Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33167B449C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 01:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbjI3Xj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 19:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjI3Xj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 19:39:27 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBD9BA;
        Sat, 30 Sep 2023 16:39:25 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c60f1a2652so13827815ad.0;
        Sat, 30 Sep 2023 16:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696117165; x=1696721965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=thG9kTzlWoLCWbOj4FD/b+QkNyTL0JCOxKNdFQVLd+E=;
        b=M9C6DbBwURUv4QUThViTRZXFHbfBEYYZREHgH9cyA8eow4IlgbBoLsWy3azYX9ru6H
         p+wXJhDBixBtNmfEY8G7Ktgd7vH3Srbo5+yhJh7PCP8ix93FsHWsa36rFB9eONFTSVuh
         u8cU/k5IiSzBoSz2v5rCrnM0pIhzM2IZQg/SR3PGy7jDCslrVxl99KS5QebgFPw/zeUw
         MgRI63b9qUUcOO6McVXh0H7URHrr4tN9AXq0IOok6ZdIM09Etr41XnHCx7DHFm64SkDB
         H4Hhc0zg4Htxubt4LNXetOWD2vvIJ8skMRaG8VrGkvw6J9CVyK4sPbFEADpgQk+xeW2w
         7iPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696117165; x=1696721965;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thG9kTzlWoLCWbOj4FD/b+QkNyTL0JCOxKNdFQVLd+E=;
        b=pVH5strlIYDQGrLWJGMQmbaT/2ybaS34xbavFovlQzbj7VVAc1A3oF5+1ubRck45jd
         l2HQyH2v42gt3mLLDbZh8hfvjdtnKE3CAZzXTOcpFPKtFDYGsAaKpo2PFFRZaBIClQuh
         p+xlpyTGixN9exFJPkzNUgUZ7G3bnuwexiEvJpCvuFHCCwOhUlyXEV2tkESg1vC0D3Tw
         9CeDRqu2wG0xLFlpweZYb/ayY9YUBGA/akP0apE6OttuBNCVWhq+pX6gXPnvp1jawrKm
         Yk8i/+hZU8bLbimO2G6sfBgHid8c/TJrHySzFyZU5RjCzklx4zSX7wRilmNYbSZsIX3R
         txIw==
X-Gm-Message-State: AOJu0Yx/nINixvirSZ0e+cuSRTD4OqUM7SbcRn8jZkxFwDdUlwegAhLz
        RBFil5mhSqDPiwum1cgEx9U=
X-Google-Smtp-Source: AGHT+IGCmrb99RfLyeZAAaBJCBvVX+/IW3ebjGQKt5e5zNfT7PB5PBnYSSvMdsOOh3j0YOhAW63iLg==
X-Received: by 2002:a17:902:e885:b0:1c5:59dc:6e93 with SMTP id w5-20020a170902e88500b001c559dc6e93mr13270979plg.3.1696117164689;
        Sat, 30 Sep 2023 16:39:24 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b001bb892a7a67sm19135006plx.1.2023.09.30.16.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Sep 2023 16:39:24 -0700 (PDT)
Message-ID: <9f06bba3-5f8e-45fc-b729-0492452b3393@gmail.com>
Date:   Sat, 30 Sep 2023 19:42:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: error: fix the description for `ECHILD`
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
References: <20230930144958.46051-1-wedsonaf@gmail.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230930144958.46051-1-wedsonaf@gmail.com>
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

On 9/30/23 11:49, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> A mistake was made and the description of `ECHILD` is wrong (it reuses
> the description of `ENOEXEC`). This fixes it to reflect what's in
> `errno-base.h`.
> 
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
