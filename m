Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62159768621
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 17:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjG3PFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 11:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjG3PFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 11:05:09 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D301712;
        Sun, 30 Jul 2023 08:04:59 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a5ad21a1f9so2360844b6e.2;
        Sun, 30 Jul 2023 08:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690729499; x=1691334299;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sjtmh4nNwvExMynVKxhinGFBrbzl40KOySzNLRmSZXM=;
        b=Ypafvh4XXnWnBJB9s/Y0H0I4mPNKmfOcCQJFjcnzzoXFaA8EXXp4rDydrHFcI5PheE
         W+AhkX3JIKQ7By/Iilv8gjPt1/R/r6JIszHs65liPby7ZV0/y+aMSVpkCRzc3vXSk4r2
         h5Zlh0vSQGGtGQ2puArhOvD+TBguZZ2g07sNRCHKwGevnonQzAk1ii83urr5LYBCC6PA
         MATSGNA/sM7wwPpseeVEKu70wEc/5YXh16RsjizPgqf+0AYzLGDOVaV16oiWR1vzEn8a
         s83T9K93hF5lmcsawzRKNpY6F/QtItw+OL08aavfEY6Iswp22qOpLFZiNGocdXSMduTs
         1B8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690729499; x=1691334299;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sjtmh4nNwvExMynVKxhinGFBrbzl40KOySzNLRmSZXM=;
        b=jcqkBfIj3ZusqbvGe9ZHsU/k2nJJPL7i1SuTE6LhNOUUqswgxmfhApOzM5tHK5sTbu
         FaxaWwM3O6hiGtr2ihz0YQMv3De1z+Z6tFWwdDwG9qhuQ7wlU82UNqr5cmJCz9EVSQKu
         aFlEdfbSl6IsDypEYXE6sgbyq0lek1q+sJkYy9eIRAnkT94J46OgfV8D7S7rMKa1h32D
         KuksaBZoBx0djG5odwYC9sDiPdyIFZjSvY/Sf82qCvEMc8e3PR9woW74ft+9O8KyDkS9
         6qA+zZu6NYcOkBoLh3nd9bScphAuRxDlbPVtPy0o3kyVXaqf7PGwmceG0qnEI8GU4qgp
         xJdg==
X-Gm-Message-State: ABy/qLZrjIzR2kYDH4NwTE41u6OAgxoXRTCRq5ebTUTaraGUb1mJo5CA
        T3VB6SwIfAMCShDLE7dkLKI=
X-Google-Smtp-Source: APBJJlFzfU16xWOnu1QveV7x9esXMMOKh87PthZ+O4eEVcrHiZfA92eR+7URAoU21ZlP72nX8MVmZw==
X-Received: by 2002:a05:6808:1a2a:b0:3a7:2120:8bb with SMTP id bk42-20020a0568081a2a00b003a7212008bbmr2357986oib.17.1690729498846;
        Sun, 30 Jul 2023 08:04:58 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id j19-20020aca1713000000b003a40b3fce01sm3359309oii.10.2023.07.30.08.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 08:04:58 -0700 (PDT)
Message-ID: <de0f5630-a0ad-92c4-a11c-0824b334cd84@gmail.com>
Date:   Sun, 30 Jul 2023 12:04:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rust: enable `no_mangle_with_rust_abi` Clippy lint
Content-Language: en-US
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
References: <20230729220317.416771-1-ojeda@kernel.org>
 <20230729220317.416771-2-ojeda@kernel.org>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230729220317.416771-2-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/23 19:03, Miguel Ojeda wrote:
> Introduced in Rust 1.69.0 [1], this lint prevents forgetting to set
> the C ABI when using `#[no_mangle]` (or thinking it is implied).
> 
> For instance, it would have prevented the issue [2] fixed by commit
> c682e4c37d2b ("rust: kernel: Mark rust_fmt_argument as extern "C"").
> 
>      error: `#[no_mangle]` set on a function with the default (`Rust`) ABI
>        --> rust/kernel/print.rs:21:1
>         |
>      21 | / unsafe fn rust_fmt_argument(
>      22 | |     buf: *mut c_char,
>      23 | |     end: *mut c_char,
>      24 | |     ptr: *const c_void,
>      25 | | ) -> *mut c_char {
>         | |________________^
>         |
>         = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#no_mangle_with_rust_abi
>         = note: requested on the command line with `-D clippy::no-mangle-with-rust-abi`
>      help: set an ABI
>         |
>      21 | unsafe extern "C" fn rust_fmt_argument(
>         |        ++++++++++
>      help: or explicitly set the default
>         |
>      21 | unsafe extern "Rust" fn rust_fmt_argument(
>         |        +++++++++++++
> 
> Thus enable it.
> 
> In rare cases, we may need to use the Rust ABI even with `#[no_mangle]`
> (e.g. one case, before 1.71.0, would have been the `__rust_*`
> functions). In those cases, we would need to `#[allow(...)]` the lint,
> since using `extern "Rust"` explicitly (as the compiler suggests)
> currently gets overwritten by `rustfmt` [3].
> 
> Link: https://github.com/rust-lang/rust-clippy/issues/10347 [1]
> Link: https://github.com/Rust-for-Linux/linux/pull/967 [2]
> Link: https://github.com/rust-lang/rustfmt/issues/5701 [3]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
