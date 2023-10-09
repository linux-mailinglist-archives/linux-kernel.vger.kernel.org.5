Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B373E7BE885
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377491AbjJIRnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbjJIRnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:43:17 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA5894
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 10:43:15 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b0dcbf3672so140098b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 10:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696873394; x=1697478194; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NnMTttrcelYaYIrt+NLGLTTRb9JsbmWtmliQHucd1xA=;
        b=Bq8dgu/mRQQpF90U9EabozVQXjuova8Ay+TB+m/wvtWjiT7lbLcNYJ5Vu918t2KgNx
         YZJXOA52Bj+9BsZXQRnUmzzgp78GefIrbJ6PTAaIHvLuWuhYmHfcmjcTNQFRILVr54yN
         ZrKpq1ETKKuMEnFggOk+TiXeWoRNXgH3cM0DFAndshpbo+ZpJtOlsZjlkevkQh5j8rDH
         Edkr6Deh0jA3lsONDFwmGROgKW7XX8+kYfFQaAjWpC6nJD351VGhJgPf+8UcO5FBemaj
         eiFtHsZEI0iD/eKs8ZpSDW0ANVePxpsrtsF2gAOV2c2R9DexBcW1gkYPhrw/+0t87s5a
         ibaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696873394; x=1697478194;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NnMTttrcelYaYIrt+NLGLTTRb9JsbmWtmliQHucd1xA=;
        b=a+/+q9ROwulbAsXUarPRws/DoPWS9pFkbb5ZeU5C7bdsjRyyEQWpMcdHQi4MoI5jKA
         QOr8LKFWlH5lRCfKFNARJ9RQhrKo6iHzwmm1YBMBnOivmWH54073Zd7CcIQVYcbrYnxu
         SOAvuIJY4IZoJRVK577E3EzG/1IqPA78V5IkNJwFDITr1CJ5pkguJFb5aa7qZ8FNtayw
         23CqTNN5Vaq+wIlcQgDQ/V5h1JLeiO7AUkIEYQCYBsoYkENJDN+WKiAC/+yioAyw1WHP
         z4Cc7Vy6Ge5wqlcDiui4q1+vPxcRgcwcVFTBW2LrJNeq8cK4ZxS8jvXJWF00eomvY5oJ
         WYYQ==
X-Gm-Message-State: AOJu0YyszYDTfI01xGCUp1J5ZtaVkiTv507K0ciVTlFVuUqpvhGeh76T
        iUNVgoJ4crCT2oA3uPVrso9W0g==
X-Google-Smtp-Source: AGHT+IHZOPERIxv0UhvXDWOFJscOkAdsaQuB2oqGGE5poJEQl40iPqlD+Ja7r74zSfxA4QhVkNZiEA==
X-Received: by 2002:a05:6808:18a1:b0:3ae:156f:d325 with SMTP id bi33-20020a05680818a100b003ae156fd325mr19459911oib.58.1696873394538;
        Mon, 09 Oct 2023 10:43:14 -0700 (PDT)
Received: from ghost (cpe-70-95-50-247.san.res.rr.com. [70.95.50.247])
        by smtp.gmail.com with ESMTPSA id c20-20020a056808105400b003a40b3fce01sm1676687oih.10.2023.10.09.10.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 10:43:14 -0700 (PDT)
Date:   Mon, 9 Oct 2023 10:43:10 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: blacklist assembly symbols for kprobe
Message-ID: <ZSQ7rp98jX4KiZCJ@ghost>
References: <20231004131009.409193-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231004131009.409193-1-cleger@rivosinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 03:10:09PM +0200, Clément Léger wrote:
> Adding kprobes on some assembly functions (mainly exception handling)
> will result in crashes (either recursive trap or panic). To avoid such
> errors, add ASM_NOKPROBE() macro which allow adding specific symbols
> into the __kprobe_blacklist section and use to blacklist the following
> symbols that showed to be problematic:
> - handle_exception()
> - ret_from_exception()
> - handle_kernel_stack_overflow()
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>  arch/riscv/include/asm/asm.h | 10 ++++++++++
>  arch/riscv/kernel/entry.S    |  3 +++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
> index 114bbadaef41..9194e334de15 100644
> --- a/arch/riscv/include/asm/asm.h
> +++ b/arch/riscv/include/asm/asm.h
> @@ -142,6 +142,16 @@
>  	REG_L x31, PT_T6(sp)
>  	.endm
>  
> +/* Annotate a function as being unsuitable for kprobes. */
> +#ifdef CONFIG_KPROBES
> +#define ASM_NOKPROBE(name)				\
> +	.pushsection "_kprobe_blacklist", "aw";		\
> +	RISCV_PTR name;					\
> +	.popsection
> +#else
> +#define ASM_NOKPROBE(name)
> +#endif
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* _ASM_RISCV_ASM_H */
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 143a2bb3e697..f24bc4eeedde 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -101,6 +101,7 @@ _save_context:
>  1:
>  	tail do_trap_unknown
>  SYM_CODE_END(handle_exception)
> +ASM_NOKPROBE(handle_exception)
>  
>  /*
>   * The ret_from_exception must be called with interrupt disabled. Here is the
> @@ -167,6 +168,7 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
>  	sret
>  #endif
>  SYM_CODE_END(ret_from_exception)
> +ASM_NOKPROBE(ret_from_exception)
>  
>  #ifdef CONFIG_VMAP_STACK
>  SYM_CODE_START_LOCAL(handle_kernel_stack_overflow)
> @@ -254,6 +256,7 @@ restore_caller_reg:
>  	move a0, sp
>  	tail handle_bad_stack
>  SYM_CODE_END(handle_kernel_stack_overflow)
> +ASM_NOKPROBE(handle_kernel_stack_overflow)
>  #endif
>  
>  SYM_CODE_START(ret_from_fork)
> -- 
> 2.42.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
