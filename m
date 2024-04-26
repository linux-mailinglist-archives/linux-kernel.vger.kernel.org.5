Return-Path: <linux-kernel+bounces-159738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7BD8B337E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723C81C214C3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC7F13D299;
	Fri, 26 Apr 2024 09:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="EkW6CyjQ"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76EE13CF96
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122160; cv=none; b=Hw4yxpejbPYLESZwhgKMh7DkypeOWKARiyd2rsfq6vO+Ju6mvJQ7K2Dp2aoSTZmHGSO+mMeFYyOzQMzoe9opqHOmmsDrj/4G//DF90Krl6H7aDG+5p1HILEIVMJpGjonECP3KkzJSWNOHG+jAvQ90LccImmkfkH8zLEXjfUTujo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122160; c=relaxed/simple;
	bh=GCv7cleECdS9aeuqWa/FYm7mTZK68TxrmukAAfvgKyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f93cXG/p1M1IjfGQAedNlYftfBnhKGCGih6BUBQGJDskdTRHSb22ixA85o4GeQc6ZtcTiawmzSYRV/YgTE8GnxEZj0ybTdpGq8gROoHYs7vR8O9a7l5x9svpuWk4kO37QH0osM26ejtlUDlhuE8gSyy8zyO6XsTDtY5LhFRJMdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=EkW6CyjQ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a58a36008ceso241797666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 02:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714122157; x=1714726957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5cmdr7rr4QFZS2PzQg0uqFLEwvPrpxobM8THii525BU=;
        b=EkW6CyjQixi/IsDd61fFzbK4E0TdJbiE/lWOMnDKTUyItrmcX1AiVFeSSvt50reA85
         NIhqkeYsxPm3Td0Ax5GKDQl+FT8pM47vox/Kabz61U1Sz0jE1xRYFJDqgLDVZdzPJ0KH
         9c0jsDculRhYTo6/bAz+ik+WqsKQ12XGxmQv0JabC4xJsLo7RkojCDMZjvqM08pMpMrx
         PYXsSxZu3lnZ5SEpiXpZpxQmvRpBzOIkdSJsFL+q1R5/rfB92thGq7cJQZd+UZ+Z1UsA
         mXj/SZ1myTUZKtCCfK45tOesapgJhCONtfmNx5dP5P6G902f+hW+a/6Vgdut2T7/gRNA
         coSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714122157; x=1714726957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cmdr7rr4QFZS2PzQg0uqFLEwvPrpxobM8THii525BU=;
        b=H5k1zUsgeEAoHLYuG160VXO1goHqOSQ24L+JCr2TysQd8bqW97e7O9Y2v+3CBAObUj
         U4TyOMHcRmlb0e94ann+E7D++v3PNIWW+oj8ETdm1VmFT2ySTYFMgsl78ooWWB/4pvwz
         D4rXNZUdCiGpsgMkP5wanflxx83nhC85Xd47y+0/ZnHOZ8n4tOW2TIIPK1iVuLMUzJjJ
         1cnJKulgbPBif6uPpnfUImdX3kEYCxdGR3Xx730ezjsqHqDcq2kU8oAoJwzd4Z91tskF
         oU+vL8KYXt3PuFG2mK64VF4h5OYGG1wAWpNHdmlJDWE/uUW2vtpBzyDeUA75t1vOpnbl
         5yqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWR82EMXpE/KCIsd2JAHuxW0j3x5RUuwLMAIf+anxTeFkpyMOobd6SisD2+J3ZARGWI9SC7xA824oayygZtFTgNPsL4px4GYgpOimuT
X-Gm-Message-State: AOJu0YxxOhrwsvc8xkLphWOzlLSKMe7P3SB6QiMqzvhzESI9bn+Vi/DT
	YxTxEb93fFA/ix9img7ULb5aeh/1bCEJk/T4kmQ57//OV9G8frkOuABM710GaKg=
X-Google-Smtp-Source: AGHT+IG63NkJc6p1bxym4HDcpur9jISULVtE0j/y7bASzKsfhFZof8hQmBOhF4j5tAzb0EGQcmN2Zg==
X-Received: by 2002:a17:906:410a:b0:a58:aea7:df78 with SMTP id j10-20020a170906410a00b00a58aea7df78mr1541901ejk.6.1714122156900;
        Fri, 26 Apr 2024 02:02:36 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906311100b00a5599f3a057sm7714032ejx.107.2024.04.26.02.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 02:02:36 -0700 (PDT)
Date: Fri, 26 Apr 2024 11:02:30 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Conor Dooley <conor@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, Evan Green <evan@rivosinc.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: cpufeature: Fix thead vector hwcap removal
Message-ID: <20240426-d8aba0211e882568ccc761df@orel>
References: <20240424-cpufeature_fixes-v1-0-585e73d2226b@rivosinc.com>
 <20240424-cpufeature_fixes-v1-1-585e73d2226b@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424-cpufeature_fixes-v1-1-585e73d2226b@rivosinc.com>

On Wed, Apr 24, 2024 at 09:19:54AM GMT, Charlie Jenkins wrote:
..
> +	/*
> +	 * Naively assume that all harts have the same mvendorid/marchid as the
> +	 * boot hart.

This comment isn't necessary, since we don't have to assume all harts have
the same IDs. This information is currently being collected specifically
for thead. So, we can state in a comment below, where the information is
used, that we assume when the boot hart is thead, then we don't want to
enable V on any hart (whatever their IDs are).

Thanks,
drew

> +	 */
> +	boot_vendorid = riscv_get_mvendorid();
> +	boot_archid = riscv_get_marchid();
> +
>  	for_each_possible_cpu(cpu) {
>  		struct riscv_isainfo *isainfo = &hart_isa[cpu];
>  		unsigned long this_hwcap = 0;
> @@ -544,8 +553,7 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
>  		 * CPU cores with the ratified spec will contain non-zero
>  		 * marchid.
>  		 */
> -		if (acpi_disabled && riscv_cached_mvendorid(cpu) == THEAD_VENDOR_ID &&
> -		    riscv_cached_marchid(cpu) == 0x0) {
> +		if (acpi_disabled && boot_vendorid == THEAD_VENDOR_ID && boot_archid == 0x0) {
>  			this_hwcap &= ~isa2hwcap[RISCV_ISA_EXT_v];
>  			clear_bit(RISCV_ISA_EXT_v, isainfo->isa);
>  		}
> 
> -- 
> 2.44.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

