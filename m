Return-Path: <linux-kernel+bounces-30962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 017B98326DB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4821F22576
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56E33CF54;
	Fri, 19 Jan 2024 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="K0gmYk7m"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707483C68A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705657279; cv=none; b=b/8Fg8IFeCD39eIrH3NZQiHfb9IfHqctrvTrSvPAOEvzWNbIfas88DeJ0QaXn+hP20e0837X055vPOa8e7Z7H1+FCVzsh13kXU8RTJcfgdUnTJ1ucjouyeLBu8/8yHCN/+AkKiZ3/FATyW66DwHieTGnpgBEtGsqncNZCLcJ/Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705657279; c=relaxed/simple;
	bh=hQO+97VKdVxewRQI5AfMSZN+wy10WX8vdUeEz8Fh5CI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hto+0bvMTsx6ETcehKS/o03gIZrdFv5owp+xBdIwYmsbpKo4wzuceufqbfQMMndkW3CNV2g4pGcA1FBgR2hmffiDbNVrthg93mdAISS03nKayK1Nzv1p6qfFCmgHbNGduAkixdch2rz8Ro9yxUXtcud7pNYF8X/PtXdZz30U2ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=K0gmYk7m; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so651350a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 01:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705657275; x=1706262075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VjY2td5hE6yXhz+Ia9iRWMUcND8jTxmyaK8S9msHCZg=;
        b=K0gmYk7m+18mg/L7IUUCNQsevoUyJ7bx7IwdbJjUAhyFU9L+Xq5A0usmAALBWs4WTp
         65uLOkk3p+QPzvm+ZxPEQisDG/N2xLPchLQtkxvYtQNHZmCGVJhr1EKPPySJHKHdT7Uv
         WSVjaK8/oxNDXDOW65JukpKT6TDrWgZl117DASBoW+WqVTqUq7tO2MzQNhbRdXLIHyve
         SDmJ9bwZbyMJmxHJIEcsHLjTEumLWymTkbjIloILE8R253NM9y+A51WCfCxKJr5WOmsa
         3h5KsmsVs8d+J30CXrR/6VdXEAMElIo2PQe7TpGf5RY2doZ/mb145e6kpUJo7QoV+U7i
         Ik/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705657275; x=1706262075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjY2td5hE6yXhz+Ia9iRWMUcND8jTxmyaK8S9msHCZg=;
        b=TifZzyFgpenVCod3Ufj9qHiKfp7GK+Bc7dSRV+wMlNxPCnLksYBWPDvODPOhAgmqyq
         g/uI0IFyjY/SxfTUJlL1/jCJzDqMuTfBObjizychWLcHlUpDCIBipQ+WAkmV7eHigYQ8
         y4ExZvSKMBcuxx5aWKOVcKMcPqUw1YCDJUmBoFKqzoDHR1VOqkdXK1wFqQ1VR3LQG7jL
         MEvj+OqMozzggfSHYRaFaojiTVWgz64A6pRKc7AUtwLwkZBeIGMvbHPOL5xitSWMRbI8
         dOHNqQOomZ55HzCPHO1/h8vkQN/RjqXvJYZWE7ZpFu2ViTsUhB1dPgTD9w6szs6d5pak
         3NjQ==
X-Gm-Message-State: AOJu0Yy7i+WnPnOMaTEjhHGjZukryrohWIGYSOu847rd+vCccO+37Ug+
	DSRoNS1gBs3fzkfY8pgAL5ITm5/YIufoJkpFACLKH2IYYS3E2XS+laG0fEVHYog=
X-Google-Smtp-Source: AGHT+IHTZetoKvZ4IVId0QiHm+6oVWhdJLXsLPNFWMrcJmVzn0CiP03i+EmBALPDmtPVDl+LJfC9Gg==
X-Received: by 2002:a17:907:318b:b0:a2c:867c:43e3 with SMTP id xe11-20020a170907318b00b00a2c867c43e3mr1292269ejb.86.1705657275448;
        Fri, 19 Jan 2024 01:41:15 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id t19-20020a1709067c1300b00a2cab4514a2sm9122593ejo.133.2024.01.19.01.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 01:41:15 -0800 (PST)
Date: Fri, 19 Jan 2024 10:41:14 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: lib: Check if output in asm goto supported
Message-ID: <20240119-1bff4a21b3d2d5c500a14fcc@orel>
References: <20240118-csum_remove_output_operands_asm_goto-v2-1-5d1b73cf93d4@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118-csum_remove_output_operands_asm_goto-v2-1-5d1b73cf93d4@rivosinc.com>

On Thu, Jan 18, 2024 at 02:36:45PM -0800, Charlie Jenkins wrote:
> The output field of an asm goto statement is not supported by all
> compilers. If it is not supported, fallback to the non-optimized code.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Fixes: a04c192eabfb ("riscv: Add checksum library")
> ---
> The OutputOperands field for asm goto statements is only supported
> starting from GCC 11. Split the asm goto to remove the use of this
> feature.
> ---
> Changes in v2:
> - Use CC_HAS_ASM_GOTO_TIED_OUTPUT
> - Link to v1: https://lore.kernel.org/r/20240118-csum_remove_output_operands_asm_goto-v1-1-47c672bb9d4b@rivosinc.com
> ---
>  arch/riscv/lib/csum.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
> index 06ce8e7250d9..af3df5274ccb 100644
> --- a/arch/riscv/lib/csum.c
> +++ b/arch/riscv/lib/csum.c
> @@ -156,6 +156,7 @@ do_csum_with_alignment(const unsigned char *buff, int len)
>  	end = (const unsigned long *)(buff + len);
>  	csum = do_csum_common(ptr, end, data);
>  
> +#ifdef CC_HAS_ASM_GOTO_TIED_OUTPUT

Can't we just add another IS_ENABLED() to the if rather than this #ifdef?

>  	/*
>  	 * Zbb support saves 6 instructions, so not worth checking without
>  	 * alternatives if supported
> @@ -214,6 +215,7 @@ do_csum_with_alignment(const unsigned char *buff, int len)
>  		return csum >> 16;
>  	}
>  no_zbb:
> +#endif /* CC_HAS_ASM_GOTO_TIED_OUTPUT */
>  #ifndef CONFIG_32BIT
>  	csum += ror64(csum, 32);
>  	csum >>= 32;

BTW, I wonder how/if the check for CC_HAS_ASM_GOTO_TIED_OUTPUT in
init/Kconfig is working as expected. I see $CC, as opposed to $(CC),
being used there. I believe $CC is just the expansion of $C with a
'C' appended.

Thanks,
drew

> 
> ---
> base-commit: 080c4324fa5e81ff3780206a138223abfb57a68e
> change-id: 20240118-csum_remove_output_operands_asm_goto-49922c141ce7
> -- 
> - Charlie
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

