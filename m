Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B016786556
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239457AbjHXC3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbjHXC3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:29:03 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F2D1AD;
        Wed, 23 Aug 2023 19:29:01 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bbc87ded50so42881485ad.1;
        Wed, 23 Aug 2023 19:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692844141; x=1693448941;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XDQS30M7Y7Tyo2pe+n4jKlSGcRSVTd/gkvdTtBx9Zfw=;
        b=ksJNIsWG8fG2iyJPZzD+heSEqhlTvX3/tdktjJDPKRHgA6X9KHJQYf4OxLYEl4G/pA
         e1W3d4I9Xe9/5NWNFinyOJ/3DsLvTu9VmLY/av6JRU+T4M+Xa1epWEO8ZAWEE7jaVtba
         F3keQhBFmsLMM2HxacGLhLh8JzER2nUOhBTQxJ+UzWt0kYy/7htIgcKBAY5pce4KJGVq
         jF5oNZbHJEtVn7VGdntqa0TxroQmEdizrHoh95qRz4riaUbg9GLFKHOWlV69erWGBRyF
         XO9pjue2JTOuvWlU7RbH6mh519iqPyZbSEPSWr1vv75Lf9iEv3CwspiijEvk/ChuQFhR
         TVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692844141; x=1693448941;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XDQS30M7Y7Tyo2pe+n4jKlSGcRSVTd/gkvdTtBx9Zfw=;
        b=j7/E5OuFqHdsv91Tc1zrYwbg56zJ2vRQWlnS/FeteQQ7vdb7odwFAN/y5JlHPmvIE+
         es+C5nJV7/jb5oxgfZwNgSGzLx5b4omM/WraSEwGGJdgGyBFNw86Kg8Bq+39rW7HwOru
         M4LkluJzNy+MCYKAIUrOzzT+RfCIK69dWc45mz7930pSJ9vXn6RTWJr0mxO919SaJDdk
         YGZK9tzGPxNheCqv3saAGPHw+YPSFs/YM0JfIN5bpPMsfmjT0pepLCUt0/teUEyKKaWA
         2R6+GDp4klWwCG92GM4SPX5lsMftZPq/zgji3ZUUYZNI4cqiPqKSYX6rrbyKvlgNmDzF
         hATw==
X-Gm-Message-State: AOJu0YxMgzHHxSw51L1VKrGb72ZW5OEVEQAYRqrS3bMViHx3xjcA5FKv
        AETK5veNDXSeupKA5iYhoZk=
X-Google-Smtp-Source: AGHT+IHm9K4WZ4vReOf7jrx9CIZ06oUbkKidIOV0WoEkiSubFFAl52wPdsNYfelKatGviFZulU+UYw==
X-Received: by 2002:a17:902:ec8d:b0:1bc:69d0:a024 with SMTP id x13-20020a170902ec8d00b001bc69d0a024mr14620807plg.33.1692844141013;
        Wed, 23 Aug 2023 19:29:01 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id kx14-20020a170902f94e00b001b567bbe82dsm11568484plb.150.2023.08.23.19.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 19:29:00 -0700 (PDT)
Message-ID: <da4cb2c1-8f76-44d1-b997-7565efe57701@gmail.com>
Date:   Wed, 23 Aug 2023 23:28:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rust: arc: add explicit `drop()` around
 `Box::from_raw()`
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
References: <20230823160244.188033-1-ojeda@kernel.org>
 <20230823160244.188033-2-ojeda@kernel.org>
Content-Language: en-US
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230823160244.188033-2-ojeda@kernel.org>
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

On 8/23/23 13:02, Miguel Ojeda wrote:
> `Box::from_raw()` is `#[must_use]`, which means the result cannot
> go unused.
> 
> In Rust 1.71.0, this was not detected because the block expression
> swallows the diagnostic [1]:
> 
>      unsafe { Box::from_raw(self.ptr.as_ptr()) };
> 
> It would have been detected, however, if the line had been instead:
> 
>      unsafe { Box::from_raw(self.ptr.as_ptr()); }
> 
> i.e. the semicolon being inside the `unsafe` block, rather than
> outside.
> 
> In Rust 1.72.0, the compiler started warning about this [2], so
> without this patch we will get:
> 
>          error: unused return value of `alloc::boxed::Box::<T>::from_raw` that must be used
>          --> rust/kernel/sync/arc.rs:302:22
>          |
>      302 |             unsafe { Box::from_raw(self.ptr.as_ptr()) };
>          |                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>          |
>          = note: call `drop(Box::from_raw(ptr))` if you intend to drop the `Box`
>          = note: `-D unused-must-use` implied by `-D warnings`
>      help: use `let _ = ...` to ignore the resulting value
>          |
>      302 |             unsafe { let _ = Box::from_raw(self.ptr.as_ptr()); };
>          |                      +++++++                                 +
> 
> Thus add an add an explicit `drop()` as the `#[must_use]`'s
> annotation suggests (instead of the more general help line).
> 
> Link: https://github.com/rust-lang/rust/issues/104253 [1]
> Link: https://github.com/rust-lang/rust/pull/112529 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
