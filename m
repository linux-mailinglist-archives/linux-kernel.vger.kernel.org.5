Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3C07543D5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 22:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbjGNUhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 16:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbjGNUhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 16:37:38 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9747035B0;
        Fri, 14 Jul 2023 13:37:37 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a36b30aa7bso1796383b6e.3;
        Fri, 14 Jul 2023 13:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689367057; x=1691959057;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mY5r74EsToyg15WyPiWjX1ZroHWYpVw9giMGrKp5JHA=;
        b=AJN5/qxg8i0gT7b4C7JV8YxHIbBH13eMOg2DhSZgcyeTwVmINt+uIR1UC7cffKvHa3
         3/bfbVb6OaoeS+/kSx4ONT1rQ/JADd8D03xutMFZu50rbkjCAOBm3ChncdDakkAjvCFR
         ZTMcUD0KglBQXRLgl0tkuw3bitTlQsJPYbqMNdxy5iNvBK2Lj1VgPfzPX4jgEu5V0fhN
         TbV2oVtYFJfwHCp9DGcH6P7H8JzVT5Q4lnmDf7b6cnveNHDh+oOz/kVQ4T61RQyMn+WY
         f7JBbUX7nXRprPIfE5Y1dCdU39NH5n5LQ18IzlSkyVG6yThBm+YX6MPtt9t+zXi3amdh
         a0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689367057; x=1691959057;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mY5r74EsToyg15WyPiWjX1ZroHWYpVw9giMGrKp5JHA=;
        b=H7x2884KuYQ1AtyKgnGxhCW7BPHq0LSSSstIq3Kp/Kyj5duI807B/RnUuHSvXswsRE
         r6Ti69Fp9EG0BeEYrVQVbbxDSCVv9R+L7E/n2dwoqnffPZbxgMLlEDv+TC1QKSCd5VIu
         kbbBzSQ9pL9rcfWre89GOHhj009iFLALvdk+Xcf6lQECASXgGjpJuem9QslaLnvu73XQ
         ZSNimcfRCgh7O3YZA1MBNoxEg+NNvSPAfywuuYiso/w0dWHtUoupOXGvj/nr2dpgQqSg
         wwXDj8psWd5OLS5ArpGwO0OhVXcVgH568S5gAU5ys6mmaVIttXXH7R6xDmKyj4yFLoIU
         ZPFQ==
X-Gm-Message-State: ABy/qLZdv69vWES69S3hknf8LK06A9FzSgLN5lyiMA6y+KxwhycXR5e5
        6rAq0/h7n4OmPjHWwBFhqtI=
X-Google-Smtp-Source: APBJJlFBrF1UdrLk9k1UzyB21a0BPI2S3IPzkt81x9e58ufSqkaA21DfyAMl9+w9uwHwKMk7wMrhDA==
X-Received: by 2002:a05:6808:d47:b0:396:e3a:9f2f with SMTP id w7-20020a0568080d4700b003960e3a9f2fmr6910430oik.5.1689367056789;
        Fri, 14 Jul 2023 13:37:36 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id bk12-20020a0568081a0c00b003a44b425c18sm293034oib.43.2023.07.14.13.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 13:37:36 -0700 (PDT)
Message-ID: <72aca706-c2ff-b363-717c-323ea24d3908@gmail.com>
Date:   Fri, 14 Jul 2023 11:28:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC 04/11] rust: siphash: Add a simple siphash abstraction
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
 <20230714-classless_lockdep-v1-4-229b9671ce31@asahilina.net>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230714-classless_lockdep-v1-4-229b9671ce31@asahilina.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/23 06:13, Asahi Lina wrote:
> This simple wrapper allows Rust code to use the Hasher interface with
> the kernel siphash implementation. No fancy features supported for now,
> just basic bag-of-bytes hashing. No guarantee that hash outputs will
> remain stable in the future either.
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
> [...]
> --- /dev/null
> +++ b/rust/kernel/siphash.rs
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! A core::hash::Hasher wrapper for the kernel siphash implementation.
> +//!
> +//! This module allows Rust code to use the kernel's siphash implementation
> +//! to hash Rust objects.
> +
> +use core::hash::Hasher;
> +
> +/// A Hasher implementation that uses the kernel siphash implementation.
> +#[derive(Default)]
> +pub struct SipHasher {
> +    // SipHash state is 4xu64, but the Linux implementation
> +    // doesn't expose incremental hashing so let's just chain
> +    // individual SipHash calls for now, which return a u64
> +    // hash.

Isn't this detail relevant to mention in the doc comment? At least to
explain the difference between them.

> +    state: u64,
> +}
> [...]
