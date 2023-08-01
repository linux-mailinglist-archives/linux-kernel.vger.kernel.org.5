Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D891D76C0EF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 01:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjHAXde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 19:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHAXdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 19:33:32 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BFBCC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 16:33:31 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a751d2e6ecso783617b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 16:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690932810; x=1691537610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zCkQNzwB2gjKN8HzeKzRdzAYqUq5vKXd54Q6a0LF4go=;
        b=llYOMIymJ7D0P1UHh5d2DIeLcDZ2XjDRfXWUyJVnYwXI2RXfhXZTGXofH9u2AnfK29
         A+QSfC1D5qT9dffgoJ1lX9WVnOvS5R1He7bicE8aoEWQT4jR1wjFZCP6u+9Ff/k9NAjM
         E/tIluPe16o2sxAoUpLUSKCW6TXWlRFpIA590=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690932810; x=1691537610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCkQNzwB2gjKN8HzeKzRdzAYqUq5vKXd54Q6a0LF4go=;
        b=ObWNofZqrNSuurt1E1zwEoxNPJM0+39t9WywBdkkMzB7qhoIEL3BurFzuuerryZRVZ
         Fc0RZO7feDBLSh8961tciveNJTwPzjqUUt9xtTSXxx/rXRcV09WM/CTgXJPckk7vdj3C
         M90bB+zsnJi8pGsRrHwl4i6sF/wIck0+Lora2iY07s6p+Q8HsLdmH36Vq37NWCE6w5ga
         WKaFIGms7Hz78tlfbEsj4+CiXtMbMym0Xnm1gVIyAx8aMLkq7tq1ck2wYOnICSdyzYIi
         rtUBB5GO6dEwGBm6VoCIWh9huf/W4rXbFrS3+krZNE3sZcdrtO8LuvwzPKsQW3kDQC66
         stcg==
X-Gm-Message-State: ABy/qLbgLvnSL538hweRummoDExbXrIe8WrcDRueLcwNWAYG9HzjhIBU
        5kWoS6iGevng11OPrTCBPYM7Bw==
X-Google-Smtp-Source: APBJJlFrpp1hvJWJsN7jGZ4rNvDLwtV6UmEEp4hMcXxE7Q6csK0l002Jq1VU9vdPg4FFJxeLfaLOwQ==
X-Received: by 2002:a05:6808:138f:b0:3a7:55cb:c831 with SMTP id c15-20020a056808138f00b003a755cbc831mr946264oiw.18.1690932810710;
        Tue, 01 Aug 2023 16:33:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d5-20020a633605000000b00563da87a52dsm10579412pga.40.2023.08.01.16.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 16:33:30 -0700 (PDT)
Date:   Tue, 1 Aug 2023 16:33:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] RISC-V: cpu: refactor deprecated strncpy
Message-ID: <202308011631.BDCD5CE33A@keescook>
References: <20230801-arch-riscv-kernel-v1-1-2b3f2dc0bc61@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801-arch-riscv-kernel-v1-1-2b3f2dc0bc61@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 09:14:56PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ the case for `strncpy`!
> 
> The `sv_type` buffer is declared with a size of 16 which is then
> followed by some `strncpy` calls to populate the buffer with one of:
> "sv32", "sv57", "sv48", "sv39" or "none". Hard-coding the max length as 5 is
> error-prone and involves counting the number of characters (and
> hopefully not forgetting to count the NUL-byte) in the raw string.
> 
> Using a pre-determined max length in combination with `strscpy` provides
> a cleaner, less error-prone as well as a less ambiguous implementation.
> `strscpy` guarantees that it's destination buffer is NUL-terminated even
> if it's source argument exceeds the max length as defined by the third
> argument.
> 
> To be clear, there is no bug (i think?) in the current implementation
> but the current hard-coded values in combination with using a deprecated
> interface make this a worthwhile change, IMO.
> 
> [1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
> [2]: manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
> 
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  arch/riscv/kernel/cpu.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index a2fc952318e9..1c576e4ec171 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -17,6 +17,8 @@
>  #include <asm/smp.h>
>  #include <asm/pgtable.h>
>  
> +#define SV_TYPE_MAX_LENGTH 16
> +
>  /*
>   * Returns the hart ID of the given device tree node, or -ENODEV if the node
>   * isn't an enabled and valid RISC-V hart node.
> @@ -271,21 +273,21 @@ static void print_isa(struct seq_file *f, const char *isa)
>  
>  static void print_mmu(struct seq_file *f)
>  {
> -	char sv_type[16];
> +	char sv_type[SV_TYPE_MAX_LENGTH];
>  
>  #ifdef CONFIG_MMU
>  #if defined(CONFIG_32BIT)
> -	strncpy(sv_type, "sv32", 5);
> +	strscpy(sv_type, "sv32", SV_TYPE_MAX_LENGTH);
>  #elif defined(CONFIG_64BIT)
>  	if (pgtable_l5_enabled)
> -		strncpy(sv_type, "sv57", 5);
> +		strscpy(sv_type, "sv57", SV_TYPE_MAX_LENGTH);
>  	else if (pgtable_l4_enabled)
> -		strncpy(sv_type, "sv48", 5);
> +		strscpy(sv_type, "sv48", SV_TYPE_MAX_LENGTH);
>  	else
> -		strncpy(sv_type, "sv39", 5);
> +		strscpy(sv_type, "sv39", SV_TYPE_MAX_LENGTH);
>  #endif
>  #else
> -	strncpy(sv_type, "none", 5);
> +	strscpy(sv_type, "none", SV_TYPE_MAX_LENGTH);
>  #endif /* CONFIG_MMU */
>  	seq_printf(f, "mmu\t\t: %s\n", sv_type);
>  }

I'd say just throw the whole buffer away and just avoid copying the
.rodata strings onto the stack for no reason. They can be used directly:

static void print_mmu(struct seq_file *f)
{
        const char *sv_type;

#ifdef CONFIG_MMU
#if defined(CONFIG_32BIT)
	sv_type = "sv32";
#elif defined(CONFIG_64BIT)
	if (pgtable_l5_enabled)
		sv_type = "sv57";
	else if (pgtable_l4_enabled)
		sv_type = "sv48";
	else
		sv_type = "sv39";
#endif
#else
	sv_type = "none";
#endif /* CONFIG_MMU */
	seq_printf(f, "mmu\t\t: %s\n", sv_type);
}

-- 
Kees Cook
