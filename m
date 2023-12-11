Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8105280D000
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344382AbjLKPq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344112AbjLKPq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:46:57 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30522EB;
        Mon, 11 Dec 2023 07:47:03 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d076ebf79cso26347765ad.1;
        Mon, 11 Dec 2023 07:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702309622; x=1702914422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t7YSA8qppIroeXtav0r61MJOOSYSTCPfxCWfFNYG/XU=;
        b=iUAcdcXi/iYxMaq2R62WG5akTpwzVPo01anC/0NeV/zHgczwASa7+3rO8gtvKaujH4
         gxIG/ydqT34pZUT4DAVChhGQC3TDI1wR4qjKTEj4oPfZNQLRtHYa0Eq0FJGHdbHmfC6b
         NZqQ+yhhFzGGFUEpDy+/RlnEHxQGRnpSdoZ0saxQ/u7ZxnQiAhpfQfEaZ7cWi8uR6LEa
         bTSTQl/dVxUFpLVpb3XZC/fOUvyPb2xA9330qZAbJSNHirT42H7aa5BTuAWgH/3ZqLDM
         IdgJ6HPTIUCIG0sqYwZgxuYgx+YOPQye2+J4xBwZ6HZ03IsNA75ccCUakrZrlJfkJWUZ
         nkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702309622; x=1702914422;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7YSA8qppIroeXtav0r61MJOOSYSTCPfxCWfFNYG/XU=;
        b=feBNb4FiXSn8QKkYSVhM1+vd/YKY9+PQwCzoqThafs7hjNkz87FwHBCOTLHj2xn68W
         b2bytps/iGBuggdSyaZr8OoAZDV7Gy2CVIAkpwr+fgiNQhhRVBfrdT6Mw6NOCrym5bQS
         VGc5OVc6QEFWhMQdWIaM9YCkzeBt3TooinE0DN2HdMyPIiZYXgtB3kQ7h0qbQejhhnty
         Le8B5FB1SCIvOH/7PoXryNs1J7gk9kppX8n49Qp4CGOeGKms4es6jw1X/DQT1eAl/4ZZ
         tbtnf3nhRlPLhbmOuuYHylRLLOp0LDkjsNjQHulxfOyVtYKssw7XO8DRQSp909UnYgK9
         rzUg==
X-Gm-Message-State: AOJu0YxcgILcvoWYt6a1PeSIYeg0EYGhVx2bzlPSzds2C4IGAYM1axe3
        xLOiuGmjBEx+Eqa9I1xw4Nk=
X-Google-Smtp-Source: AGHT+IFX90N3nTKO+WMLosFtQXdu8ENG5fYwg/zYgVGl7odcluqtaPm5O9cUZsGewAEbEGRoyLvI5w==
X-Received: by 2002:a17:903:41ce:b0:1d0:9c03:a7dc with SMTP id u14-20020a17090341ce00b001d09c03a7dcmr2375448ple.100.1702309622493;
        Mon, 11 Dec 2023 07:47:02 -0800 (PST)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id t23-20020a1709028c9700b001cff9cd5129sm6763877plo.298.2023.12.11.07.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 07:47:02 -0800 (PST)
Message-ID: <e78a7de3-147b-4c9c-87c1-8937dcabfa5c@gmail.com>
Date:   Mon, 11 Dec 2023 12:46:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/Kconfig: rust: Patchable function Rust compat
Content-Language: en-US
To:     Matthew Maurer <mmaurer@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20231211150753.293883-1-mmaurer@google.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20231211150753.293883-1-mmaurer@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 12:07, Matthew Maurer wrote:
> Rust doesn't yet support patchable entry, but likely will soon. Disable
> function padding when Rust is used but doesn't support it, and propagate
> the flag when it does.
> 
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> ---
> [...]
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 1a068de12a56..0228af62742e 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -211,7 +211,9 @@ endif
>   
>   ifdef CONFIG_CALL_PADDING
>   PADDING_CFLAGS := -fpatchable-function-entry=$(CONFIG_FUNCTION_PADDING_BYTES),$(CONFIG_FUNCTION_PADDING_BYTES)
> +PADDING_RUSTFLAGS := -Zpatchable-function-entry=$(CONFIG_FUNCTION_PADDING_BYTES),$(CONFIG_FUNCTION_PADDING_BYTES)

It seems that at a glance there's no discussion around this, neither an
issue, branch, PR or commit. Do you happen to have a link to it?

>   KBUILD_CFLAGS += $(PADDING_CFLAGS)
> +KBUILD_RUSTFLAGS += $(PADDING_RUSTFLAGS)
>   export PADDING_CFLAGS
>   endif
>   
