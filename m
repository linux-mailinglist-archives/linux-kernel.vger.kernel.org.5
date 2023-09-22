Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8401D7ABC04
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 00:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjIVWxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 18:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjIVWxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 18:53:35 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F695E8;
        Fri, 22 Sep 2023 15:53:29 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68fdd6011f2so2426728b3a.3;
        Fri, 22 Sep 2023 15:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695423209; x=1696028009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9kqxgzJgXPyy+SI1U1LrSdsOznmatrZh3nVqMYZ69Ms=;
        b=fHK34zRd93z+6E1XGCfjQ0NMko9y7gB8qEnc7Zpx/YZ2Q/msQzom0a6gb0zu2/m7ZC
         aT2b4lQyPHhN4ibVM8XJAP4UyRkXpWWbsgD6qjh947w/mWA4q4dP4jqLSzK5eAMQPBCV
         y4trP6FCqGoZj+3rGV6A7gvNaENnzYlWs7R4WBgaxu+8QAoMMntucZ6b8KJdo9i7yHDH
         uqKpKw/UiMJlNK8TV0QdKu/s2xddSbilqt+SY1ag1Aycp34XJ3I6UvN0xBJpQWwTovQl
         p9ExlTFGy4xL29sKdaaMiJNHz+bPw9q6mp/rYjHKyhrst0A5lWyxCKxtIbtBWHbpQyJ7
         QCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695423209; x=1696028009;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9kqxgzJgXPyy+SI1U1LrSdsOznmatrZh3nVqMYZ69Ms=;
        b=wVdQ4n8KxxZeF6G9eWgkWCfIKrJv0a1yC75gx4Ou7+9gN4LiBPeSlRXgOXbDEaS3xv
         bfSvdNXe9f1WiIeUX9PAHgUG9mMpII0/HFsn68K7ZuqjXvi27o6wRsnuTROLCa97URhU
         04/2red14Rgox3h8OMI4P07/eUJkOazEuH1Tj19d4KA3Z308QTfdPkM660VVmTIBHEwM
         hir15YWPiABG9jfHAfVK6x7VGRX9J/VpPIqfq3nGWymRhr/9UNb/O4aPtKX218fdEwN9
         FpkOcP1JcMpvRlOjPEmK3bEjm4YfUwYHk8uQFtMhFsultQ0/uo5Mro4FKhgPDlYJ3JWt
         Ot6A==
X-Gm-Message-State: AOJu0Yw3NemnvJY7UZizjaetS9iE6SQeMmN45+5rULgnMKf5XEjumEXt
        5Y7CVP7+1F2bFUS0a+P8g8s=
X-Google-Smtp-Source: AGHT+IEdhSN5VgGrt4uKNDipxYZlx9F6Hg5pTQceSMECmTTffA4lDsvgZeO4SYQUSBLlIjhD0BDUsg==
X-Received: by 2002:a05:6a00:189e:b0:68e:496a:7854 with SMTP id x30-20020a056a00189e00b0068e496a7854mr758159pfh.18.1695423208773;
        Fri, 22 Sep 2023 15:53:28 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id v11-20020aa7808b000000b0068a54866ca8sm3684191pff.134.2023.09.22.15.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 15:53:28 -0700 (PDT)
Message-ID: <6ac73178-374d-4a4d-95b7-3b87bcafff4e@gmail.com>
Date:   Fri, 22 Sep 2023 19:52:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rust: arc: rename `ArcInner` to `WithRef`
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
References: <20230921213440.202017-1-wedsonaf@gmail.com>
 <20230921213440.202017-2-wedsonaf@gmail.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230921213440.202017-2-wedsonaf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/23 18:34, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> This is in preparation for removing `ArcBorrow` and making `WithRef`
> public.
> 
> This is a pure name change with no functional changes intended.
> 
> Suggested-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
