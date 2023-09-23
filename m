Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E707AC4DD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 21:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjIWTdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 15:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjIWTdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 15:33:45 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECE119A;
        Sat, 23 Sep 2023 12:33:38 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-690d2e13074so3308616b3a.1;
        Sat, 23 Sep 2023 12:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695497618; x=1696102418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LOtuPFxlpOJnlPD5je6/bnBdPybRwVi7VM0GipzcDdc=;
        b=DOQYnZ42H59KrQGYue6thfs1UTe1VuW8UeqkdqHSNrUN4MFWsGwNZKK9j38HJ/75oK
         mYTV6XaYxSiFdQRZdDmVwqJukwYRaAgqw3OhwaJgtDKJVttbCExFh5CQXSTHW04McvC7
         sFbmYoHy413fp5mH7TxwQ0MYllgSnmlNH3S6Siq/ZbtqoL6eklgNMe3GH6qs9Z0NBn+k
         d8ywd1eoou9IKbDLLH41ueTnofmoxZxD59tYiFd2O9eMGEEudDaLyJHawxWNF/eo1lCX
         GhF84tOWg8MPlDgye9FiGuZGBvyw/chwwuj7HZcITBJwrL9z5JPHRhPr40T4Fdh1sdEW
         fbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695497618; x=1696102418;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LOtuPFxlpOJnlPD5je6/bnBdPybRwVi7VM0GipzcDdc=;
        b=GCsa7YUcSP4yReugQmnzXR9GxHUCdk6V4mK9JT+ZGi4WA63c+OIx39HaIIfRYVuYxs
         9NJ4e051QaCJWxqE1FzmfW5ykSMLIqAyVQ8brwwGethmKMO9YWFmTryAwKit5w+2hWdP
         f3e8cIg0lFiVfjFZR/84k+DIodL1oQQRJF/mMAKhTRxP+UzByVHEJnBrTdEQaVDvTz6c
         MdggJdY0wvV76PD/scCdXdDs0yqeclqKZFtbw9op19K7E31VPIkbwWM4SChrRnC1MIrN
         VKowhaZHC+0eruUU+57ii4/6rwPzCNZ5XmcCnqKy78E415oTt1WWaJrNkZrPc2IWYNE0
         9EiQ==
X-Gm-Message-State: AOJu0YxEepAI2luucp0uc7QU+fRFd4b7/1kr8rzwq3+UEcVWzMc1hRDt
        bE4Y00ImxT+IOUtOSAiRBws=
X-Google-Smtp-Source: AGHT+IEfWrUgOrnrsPPCxQ5cuVt858pXyvz8DywujqeysyDyjc4YXMT9fH9xqjI3t3RUgdgy2OvKLw==
X-Received: by 2002:a05:6a21:328e:b0:12e:98a3:77b7 with SMTP id yt14-20020a056a21328e00b0012e98a377b7mr2289038pzb.59.1695497617879;
        Sat, 23 Sep 2023 12:33:37 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id n11-20020a170902d2cb00b001c06dcd453csm5685740plc.236.2023.09.23.12.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 12:33:37 -0700 (PDT)
Message-ID: <3eb24e38-710a-48cd-b9bb-3e258d914fc2@gmail.com>
Date:   Sat, 23 Sep 2023 16:32:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] rust: arc: remove `ArcBorrow` in favour of
 `WithRef`
Content-Language: en-US
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
References: <20230923144938.219517-1-wedsonaf@gmail.com>
 <20230923144938.219517-3-wedsonaf@gmail.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230923144938.219517-3-wedsonaf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/23 11:49, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> With GATs, we don't need a separate type to represent a borrowed object
> with a refcount, we can just use Rust's regular shared borrowing. In
> this case, we use `&WithRef<T>` instead of `ArcBorrow<'_, T>`.
> 
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
