Return-Path: <linux-kernel+bounces-159739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A79088B3382
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8143B21377
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3A813D291;
	Fri, 26 Apr 2024 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="FpOERp8U"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F6225605
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 09:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122270; cv=none; b=Tzv+P6IhK86eAxWtmc4PwFfkf4CmT//wPGMyilFF8QYkorAejrkUoPTHclqLWy/Y3fpR+vF2uH+2E+JpwLvbXPQPPxDgsfaU1S9iJTJR1Uaeo7pHqVEyoy8IMGACaMLAAa8/4vcHlhq0RzBNoet2IXuwOBvckCAF70BovvAtHJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122270; c=relaxed/simple;
	bh=nW7jXvCEvQnb9l7QOm8u/1qQtJrmGBsLapHtsNxqzkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nY3iYQfj55QwuBF3agmjscaZyN4TFRVhc7WMk4DeBAYP4fCVoLiLEFMTTcvYwYFQikRB1DwlSJUX6oMLCww+MEih7em0U3Ntn+XMMaqEKU5GtIr7n+GfYWni65D2uiPO/6beZ3pyfntiwZ0IdCf4spvejWxbjjLVv4BNFCbjy/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=FpOERp8U; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a55b2f49206so518187866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 02:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714122267; x=1714727067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hzl4Ufo8fPsUKZxQXQJoooQsy8g61GqJ67h+tl5OxfU=;
        b=FpOERp8UD4XvijQD/Thldx9fZbq4orYkU3NmEDsKgY94lI2MNkyMBMB9w/VSW7WdeP
         uxjVvzoPZvETVetc4HSFwGDAPeFqzZHTIitL5rMnqP8cwOnoh8LE6cXc5cfI8Sooq5oZ
         0Ok4nVoDtanPFVchSGavhfOjAEzjXNBth/ysKKQB/dNeBkgXoM9bXFIU0RwPNNmiCDN5
         6nTC75v9SamhC+71GO1E+L1ae5EBVOvW4mBL/Csuh51A2j2svLIpIUdZNyaYE0rlYW3p
         53wcafWJUwGe58srp+czumBObuCnYEUCqVDQ6LrtkZcRYDZPxaOeRkRxBvjLmyTmolpd
         IXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714122267; x=1714727067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzl4Ufo8fPsUKZxQXQJoooQsy8g61GqJ67h+tl5OxfU=;
        b=YZmhS00kxJYrNIN1f3YYtAAMQZz86cgke/EbSsuZ9LQq/J4b5866Dp6QpLhUE0m3L3
         f20GCfZSBFaJCe2Tto1OsotjefLAgGa3AldQT+yNf6L8nNZy/PTPkDLZ0yRjV+CsbADJ
         of4WHDqKKwLDKwdLddC2Z0xrGd1PEvS6cM85suuRZ2IguE0xoEYRCfGiAytNiX4k3KUt
         PiBhWefIh6SSVNZD9GayulxNdGXh5mb35sPFVEWFycLRgR+DJTgR3QEtxBIUxUoB+J0D
         6QEzRb4dNdR0wwyug1c1VsIGLbk2ODSO7wFIMlrdQNHVGS19zaQMtc2NfM0rEhsDI9dE
         6pJA==
X-Forwarded-Encrypted: i=1; AJvYcCXFcahy1hrTueka0Ott+aH9wwhn+w3xa1lQVjsHskcAcpRKisLWhqSksbAHz38kV2mmi5k0veAkiKMb122n+bxoDe2FJXCracIsLzDh
X-Gm-Message-State: AOJu0YzutSkWbGM3/H8ACNqM1mG5DSTN43B0ecTlRX8PmNW2cADxIfXL
	P/G4hMho3M755N5eAMbb6yklAdwZ4Jw8mvNlffRRDCiIt+sN8rR8Z5laOcbpYtY=
X-Google-Smtp-Source: AGHT+IGGQjMoum6nDXLgZtliFReM/nKG5LCeh8eEH857A0KequuLtsB621jAkhX12QtK6pYL9HvzSQ==
X-Received: by 2002:a17:906:c10a:b0:a58:a0b8:2a5e with SMTP id do10-20020a170906c10a00b00a58a0b82a5emr2344119ejc.26.1714122266694;
        Fri, 26 Apr 2024 02:04:26 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id hg7-20020a170906f34700b00a4e5a6b57a2sm10343313ejb.163.2024.04.26.02.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 02:04:26 -0700 (PDT)
Date: Fri, 26 Apr 2024 11:04:25 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Conor Dooley <conor@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, Evan Green <evan@rivosinc.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH 2/2] riscv: cpufeature: Fix extension subset checking
Message-ID: <20240426-e532c061e4929c6e8babcb3b@orel>
References: <20240424-cpufeature_fixes-v1-0-585e73d2226b@rivosinc.com>
 <20240424-cpufeature_fixes-v1-2-585e73d2226b@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424-cpufeature_fixes-v1-2-585e73d2226b@rivosinc.com>

On Wed, Apr 24, 2024 at 09:19:55AM GMT, Charlie Jenkins wrote:
> This loop is supposed to check if ext->subset_ext_ids[j] is valid, rather
> than if ext->subset_ext_ids[i] is valid, before setting the extension
> id ext->subset_ext_ids[j] in isainfo->isa.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Fixes: 0d8295ed975b ("riscv: add ISA extension parsing for scalar crypto")
> ---
>  arch/riscv/kernel/cpufeature.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index c6e27b45e192..6dff7bb1db3f 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -607,7 +607,7 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
>  
>  			if (ext->subset_ext_size) {
>  				for (int j = 0; j < ext->subset_ext_size; j++) {
> -					if (riscv_isa_extension_check(ext->subset_ext_ids[i]))
> +					if (riscv_isa_extension_check(ext->subset_ext_ids[j]))
>  						set_bit(ext->subset_ext_ids[j], isainfo->isa);
>  				}
>  			}
> 
> -- 
> 2.44.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

