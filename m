Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE78B7543D8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 22:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbjGNUh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 16:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236307AbjGNUhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 16:37:53 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFDC35AD;
        Fri, 14 Jul 2023 13:37:45 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a43cbb432aso1046097b6e.3;
        Fri, 14 Jul 2023 13:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689367065; x=1691959065;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CBhsitCN/onNBslnPmHliBhOeMbP9ETZwhScILes7/c=;
        b=UEJWiFUENx9+IWthbK2MR3Dum7I5bsNUdoAbviRfxNPKoyZtx/CiAKNZTLgQlZAlH7
         zkLfcyDS5vB5efbFjE3GMQiy7RFvJ8Ag/r4TR7auplMMcAazICba8NnfnvZxksXSevbK
         lQuo0OtRmr6lwthdLHrddZJxRS2b/JVFvWHU/TNf7RYWtaiEjwigtv114EojL2HeIAFT
         ba492OcU4rWcK5pQgDe16AYQoHhZjzAVn4ehJQAfxblLjs0jZj3Wd0zuZ4OBiFlbrEqd
         glHTlGOTb8ER8syvWOUY13ND52F0WzgYWIz3HUgAoffkniES8u4Ttmyg+koz6c7V5r3D
         at9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689367065; x=1691959065;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBhsitCN/onNBslnPmHliBhOeMbP9ETZwhScILes7/c=;
        b=SYIGOei6zHR94ab4PByRvmbd/Cw49tT4mJCYB//E5fT0kg+mDF6u0YYduF8RoNioX9
         oCgVnYJmp03iYee+UK42Jeo58vPrZnyzG1l4kMNndN+BlNGRcbhX9JLZYQNzxV1SwxCc
         Z5SmpW5/a5P5BcHVaLr1rGrJdd7wKYCBSuocZP6OZ7GZZXeE+DU99L2B4j91c6TS0vd0
         ziCRjjWGkYGMBcS5evRZfnEpNIMJXBBtMHu0OTesDdLC88iEEr/qTyE/xceL4k6Tt5fT
         lXrAuf6WpAI0ktoK8HlkyREzPrxyfFPGEZv2aL5q0JM1YfxMV9ugCyXPa36Gbkc5KtYC
         ye1g==
X-Gm-Message-State: ABy/qLYvy90mobq4eZcIxioLiakG1pgXJ7nontb71YNUj2InxQ1WyK8k
        dDL4dCIpzgCMV5dP2/nwwqc=
X-Google-Smtp-Source: APBJJlEVOJ+/DXr8bZrvrs3Adv7LDMFMrgmR+jF30O8qsjsCFQr/Fn1n9BaZFaImkMmSFCRLfxuASQ==
X-Received: by 2002:a05:6808:118c:b0:3a3:f45b:aa5f with SMTP id j12-20020a056808118c00b003a3f45baa5fmr7902058oil.52.1689367064944;
        Fri, 14 Jul 2023 13:37:44 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id bm40-20020a0568081aa800b0039ee0778048sm4305714oib.37.2023.07.14.13.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 13:37:44 -0700 (PDT)
Message-ID: <eea05d26-653e-9cf7-57ce-c5f725e8d6d1@gmail.com>
Date:   Fri, 14 Jul 2023 11:57:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC 05/11] rust: sync: Add dummy LockClassKey
 implementation for !CONFIG_LOCKDEP
Content-Language: en-US
To:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev
References: <20230714-classless_lockdep-v1-0-229b9671ce31@asahilina.net>
 <20230714-classless_lockdep-v1-5-229b9671ce31@asahilina.net>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230714-classless_lockdep-v1-5-229b9671ce31@asahilina.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/23 06:13, Asahi Lina wrote:
> Lock classes aren't used without lockdep. The C side declares the key
> as an empty struct in that case, but let's make it an explicit ZST in
> Rust, implemented in a separate module. This allows us to more easily
> guarantee that the lockdep code will be trivially optimized out without
> CONFIG_LOCKDEP, including LockClassKey arguments that are passed around.
> 
> Depending on whether CONFIG_LOCKDEP is enabled or not, we then import
> the real lockdep implementation or the dummy one.
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>   rust/kernel/sync.rs            | 29 ++++++++---------------------
>   rust/kernel/sync/lockdep.rs    | 27 +++++++++++++++++++++++++++
>   rust/kernel/sync/no_lockdep.rs | 19 +++++++++++++++++++
>   3 files changed, 54 insertions(+), 21 deletions(-)
> 
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index d219ee518eff..352472c6b77a 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -5,37 +5,24 @@
>   //! This module contains the kernel APIs related to synchronisation that have been ported or
>   //! wrapped for usage by Rust code in the kernel.
>   
> -use crate::types::Opaque;
> -
>   mod arc;
>   mod condvar;
>   pub mod lock;
>   mod locked_by;
>   
> +#[cfg(CONFIG_LOCKDEP)]
> +mod lockdep;
> +#[cfg(not(CONFIG_LOCKDEP))]
> +mod no_lockdep;

Some care must be taken wrt how is it going to appear in the resulting
documentation, I think it can lead to missing details. `#[cfg(doc)]`
should be considered.

> +#[cfg(not(CONFIG_LOCKDEP))]
> +use no_lockdep as lockdep;
> [...]
