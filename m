Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE695766DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbjG1M65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbjG1M6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:58:55 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFBB35BF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:58:54 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52256241c66so4357219a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1690549132; x=1691153932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FqTFgoGmST1AJKGLh5DBCmCaz66xwOB/BVZ5Tjzguj0=;
        b=H36iKz861flkEQ1P3kKezzIhgeKJ6aRNgNSEl8u2pDIxhM/FCMYwHU3Ln2TPUPV5EF
         USA6zCNSP0NpFFrx72jAWekAJCBl+k5NbfqI0PCEkSbyhZPmYEnMdwAJezdwBXZ/Fh2c
         VCnGnaBEsTUJN0DzPnm3xkGLxyOB+xnhXtq1834PEFUjuyHOv+d5GZSqXL36LmW/dmbI
         eo+ZXlAcgH1wF4r2AQciR8UicKkt4AO0UgPZjIgbrJbN1GsQzaQiKF5Fbnbhxa4xOi+R
         KBIR64gcHRkLwwqryb8ITtXS/nT7/lNCQDlYf+8y5qJt0UbR/ImCByerB5vdbNjHw+ft
         4qCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690549132; x=1691153932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqTFgoGmST1AJKGLh5DBCmCaz66xwOB/BVZ5Tjzguj0=;
        b=L2IrNypalwZnbZFSupwFGRi1L0O3YhkjfHjWE/C0t4CnlOQTo2woj+bx5CQ92YpQ1Z
         K92IOcagZo/FuRgGyNgg/dg6iAKfoM1D/61KliUFnNmcETZIS2sLMEvDztUM4jgMdWex
         DpZoAW0F90ypOYwMKn8tz++haJe/LWRLdekcKuUkb4O055xOMGzm9Deg/G323QbNn4hh
         rDyL/98ra8c7t0W38NwNWmY0hEg0QrjNGLSyIgCndwgktpQM4w8X2hjzEPwRjIQc0vLc
         hNaiQnx0FmYi8IAwVB98S8li/osJcVtYPfM+ai7bJocHcBD7XkgMYB9rB9XLzEgS1LZ5
         oG+w==
X-Gm-Message-State: ABy/qLYVKmCTtawHZTcy2HBE6vcOvgNCJfZAaNN+d/Rj8SBZNB9lannW
        5AV4NGZJS4cK998FJQZOy4vNGQ==
X-Google-Smtp-Source: APBJJlHsWxL7O1ZC2Lv9RpUJNZzL98uTHxGO8G2yqeXTiimbQT4LHF6Rwp7C+oPZ8pTLJkOe6Fci6w==
X-Received: by 2002:a05:6402:5188:b0:522:28b9:e84c with SMTP id q8-20020a056402518800b0052228b9e84cmr5038088edd.21.1690549132533;
        Fri, 28 Jul 2023 05:58:52 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id y19-20020aa7ccd3000000b0051d9ee1c9d3sm1787535edt.84.2023.07.28.05.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 05:58:52 -0700 (PDT)
Date:   Fri, 28 Jul 2023 14:58:51 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] riscv: vdso.lds.S: remove hardcoded 0x800 .text
 start addr
Message-ID: <20230728-628baf3727ffccddae0b0663@orel>
References: <20230726173024.3684-1-jszhang@kernel.org>
 <20230726173024.3684-4-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726173024.3684-4-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 01:30:24AM +0800, Jisheng Zhang wrote:
> I believe the hardcoded 0x800 and related comments come from the long
> history VDSO_TEXT_OFFSET in x86 vdso code, but commit 5b9304933730
> ("x86 vDSO: generate vdso-syms.lds") and commit f6b46ebf904f ("x86
> vDSO: new layout") removes the comment and hard coding for x86.
> 
> Similar as x86 and other arch, riscv doesn't need the rigid layout
> using VDSO_TEXT_OFFSET since it "no longer matters to the kernel".
> so we could remove the hard coding now, and removing it brings a
> small vdso.so and aligns with other architectures.
> 
> Also, having enough separation between data and text is important for
> I-cache, so similar as x86, move .note, .eh_frame_hdr, and .eh_frame
> between .rodata and .text.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/kernel/vdso/vdso.lds.S | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.lds.S
> index 671aa21769bc..cbe2a179331d 100644
> --- a/arch/riscv/kernel/vdso/vdso.lds.S
> +++ b/arch/riscv/kernel/vdso/vdso.lds.S
> @@ -23,12 +23,8 @@ SECTIONS
>  	.gnu.version_d	: { *(.gnu.version_d) }
>  	.gnu.version_r	: { *(.gnu.version_r) }
>  
> -	.note		: { *(.note.*) }		:text	:note
>  	.dynamic	: { *(.dynamic) }		:text	:dynamic
>  
> -	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
> -	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
> -
>  	.rodata		: {
>  		*(.rodata .rodata.* .gnu.linkonce.r.*)
>  		*(.got.plt) *(.got)
> @@ -37,13 +33,16 @@ SECTIONS
>  		*(.bss .bss.* .gnu.linkonce.b.*)
>  	}
>  
> +	.note		: { *(.note.*) }		:text	:note
> +
> +	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
> +	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
> +
>  	/*
> -	 * This linker script is used both with -r and with -shared.
> -	 * For the layouts to match, we need to skip more than enough
> -	 * space for the dynamic symbol table, etc. If this amount is
> -	 * insufficient, ld -shared will error; simply increase it here.
> +	 * Text is well-separated from actual data: there's plenty of
> +	 * stuff that isn't used at runtime in between.
>  	 */
> -	. = 0x800;
> +	. = ALIGN(16);
>  	.text		: { *(.text .text.*) }		:text
>  
>  	. = ALIGN(4);
> -- 
> 2.40.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
