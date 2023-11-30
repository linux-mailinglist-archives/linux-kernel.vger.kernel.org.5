Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2562F7FFD3F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376814AbjK3VHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376386AbjK3VHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:07:09 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCCC10F0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:07:14 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-285d1101868so1277536a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701378434; x=1701983234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TbIZvkmLDHjuqC1Cwkdf1lYVKO4lsiVt6+GTqmsC6fc=;
        b=kQ/Te5zAg9tH0VOfkVIPix7dtbWBpPaJb4OxFopu3MfRwYpikD3CxatKPPlkODP5k6
         /dBER9ypWI8ZhurDdtAci2UxsOHz0WADU2f+0XEwy8647nqnzn44V+2hWz0PyXb4HQd9
         rLrBK7QFYISCEkO04a7DIR+E1QOmA2nTTWtPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701378434; x=1701983234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbIZvkmLDHjuqC1Cwkdf1lYVKO4lsiVt6+GTqmsC6fc=;
        b=GJTGF6ZewQ0X14ZvXeZEwEQXDCH4CdoV6F2+rmYoReeIoq5b98XoTa4gvdj7LkhsSK
         3FsvDCqMFhxDCBTKFGih6OdPyxPK5PT6DxBk4+Qc5j9/h2ehHaU7OvrMgcTOUwLhDmMg
         1X/rxYoAJiVaLvht2IQvHok8Y8g2m0GCPH5KF1NX6jjanU+SJ92sg0afW4qFEuEc8r3O
         BJOFEZaiSQlE98li5uYLNf+MQB46PKIT2xpOk/JJ3oPmmPVrlEhQ1q7+4BnDOznw7MtX
         ZYpNdiONesyifapIrBgfC6pZ4mfrdb6RcjDnFE1GkjcyX4/irI46yOwTisOxAAD6Cq1I
         F9Bg==
X-Gm-Message-State: AOJu0YxoykScHvdBi7IqTZneE07TCLG/a8TY4F0UTQhranoNVp4eNbhK
        4szILiOHp3qIEdMyMaFdB747SemGzWJrMI9m/Hw=
X-Google-Smtp-Source: AGHT+IEJgJAEtudsVkOaUX/5ItBV95aXss2DqhWCaxPJGVs0Ullk1uwZ0w8Y4goJlNpEFPj2g4aaIw==
X-Received: by 2002:a17:90b:1e02:b0:285:b08a:780d with SMTP id pg2-20020a17090b1e0200b00285b08a780dmr16762443pjb.23.1701378434172;
        Thu, 30 Nov 2023 13:07:14 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bk8-20020a17090b080800b00285a17f9da1sm3705287pjb.43.2023.11.30.13.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:07:13 -0800 (PST)
Date:   Thu, 30 Nov 2023 13:07:13 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] init: Kconfig: Disable -Wstringop-overflow for
 GCC-11
Message-ID: <202311301304.28F0C52BA@keescook>
References: <ZWj1+jkweEDWbmAR@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWj1+jkweEDWbmAR@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 02:52:10PM -0600, Gustavo A. R. Silva wrote:
> -Wstringop-overflow is buggy in GCC-11. Therefore, we should disable

Can you add some links for this? For example, maybe this?
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97490

Or discussions from -next builds?

> this option specifically for that compiler version. To achieve this,
> we introduce a new configuration option: GCC11_NO_STRINGOP_OVERFLOW.
> 
> The compiler option related to string operation overflow is now managed
> under configuration CC_STRINGOP_OVERFLOW. This option is enabled by
> default for all other versions of GCC that support it.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

But yeah, let's get this landed to keep new warnings from appearing...

Reviewed-by: Kees Cook <keescook@chromium.org>


> ---
>  Makefile     |  4 +++-
>  init/Kconfig | 12 ++++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 2cfd71ae3a86..8adc611fb611 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -982,7 +982,9 @@ NOSTDINC_FLAGS += -nostdinc
>  # perform bounds checking.
>  KBUILD_CFLAGS += $(call cc-option, -fstrict-flex-arrays=3)
>  
> -KBUILD_CFLAGS += $(call cc-option, -Wstringop-overflow)
> +#Currently, disable -Wstringop-overflow for GCC 11, globally.
> +KBUILD_CFLAGS-$(CONFIG_CC_NO_STRINGOP_OVERFLOW) += $(call cc-option, -Wno-stringop-overflow)
> +KBUILD_CFLAGS-$(CONFIG_CC_STRINGOP_OVERFLOW) += $(call cc-option, -Wstringop-overflow)
>  
>  # disable invalid "can't wrap" optimizations for signed / pointers
>  KBUILD_CFLAGS	+= -fno-strict-overflow
> diff --git a/init/Kconfig b/init/Kconfig
> index 9ffb103fc927..aaaa99a5d2a9 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -876,6 +876,18 @@ config CC_NO_ARRAY_BOUNDS
>  	bool
>  	default y if CC_IS_GCC && GCC_VERSION >= 110000 && GCC11_NO_ARRAY_BOUNDS
>  
> +# Currently, disable -Wstringop-overflow for GCC 11, globally.
> +config GCC11_NO_STRINGOP_OVERFLOW
> +	def_bool y
> +
> +config CC_NO_STRINGOP_OVERFLOW
> +	bool
> +	default y if CC_IS_GCC && GCC_VERSION >= 110000 && GCC_VERSION < 120000 && GCC11_NO_STRINGOP_OVERFLOW
> +
> +config CC_STRINGOP_OVERFLOW
> +	bool
> +	default y if CC_IS_GCC && !CC_NO_STRINGOP_OVERFLOW
> +
>  #
>  # For architectures that know their GCC __int128 support is sound
>  #
> -- 
> 2.34.1
> 

-- 
Kees Cook
