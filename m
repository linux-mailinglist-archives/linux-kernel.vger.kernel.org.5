Return-Path: <linux-kernel+bounces-47856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C55C98453C2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68D00B2A1EF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB98915CD55;
	Thu,  1 Feb 2024 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NawEF8H0"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6734A15CD5C;
	Thu,  1 Feb 2024 09:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779323; cv=none; b=JY5SeGuu/iIU+yKwmqFgV7n4YLR93L4kuuZQ9Uy4CKsriIf1cAosA3Oc+A92JzA1BTtoU1bb5OIQIHm/i3/lGclB61Tipdn/+3kQQ8zcv7kW32uyUlvmwaEF4ITUCnJmZjrECQOJotqiQyoukCakMFwSvoDcal4qzy5Y1KefPb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779323; c=relaxed/simple;
	bh=c/OtwZ1IVY3svpSGJcfnXW8p+CkDVu3pn+h8kJ4hxi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzSGIJbHQV7zuVbLrgG1YHbtZ7bPyQdL8ATwnqVoKNNcMd5m35oFDfUOqNHh83iWxeQEFWWvOFyWdF9tqCUJEo0HN44i/V5YNciJ7r3LqLal65fRi+epaOC/XA/87zrAQgu2h8paQsCsqaiPJRJEqHzNYGXRmHHA74N6N7Vx0Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NawEF8H0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0E87740E01A9;
	Thu,  1 Feb 2024 09:21:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HbuLDg8jRx1L; Thu,  1 Feb 2024 09:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706779315; bh=0Q3UUFk6+/2SkhRCa05XVslnKNWRkpVQdLj6IkRIvOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NawEF8H0wvIx6pk2E2d2j8+Vq/ffdEIwfZGyFaT1EIKzr2JzAJcLgmaOCQGde6ZZS
	 qvq9VOkHmB5jctS5kfZJQAxQNhBY/e1MBPSqAlB4enAq7ndTJ+gstuziUX/yeYkIxE
	 O4Mjolx6PYROYXJeOuDGED/pbNYgpTZV5189th8bbhOwSI8beEY/FG/q5iNqIQB8sB
	 N2T6t7xWLPx3iTJykSJ0Ycn4rHUv697P8N55TCLdesJKjIGEEx12/DzoJgHEWdVb1I
	 pcBt/pcy+nzFwcxgBwM3A8x8ZeOAxIVHmHzyFEHJWDf54Js+qbeE9nXtzEWo7ma7VG
	 2hVz2iykKxEWN7ktkg+Nz4D1MDCTBzsQmAoOVJmv71LAaL9d9LJjY4CDHZd4iwpR2h
	 nNqYE1NbikhpNRi3jMTml5fRxe1hRFcnMpwM9Smv8nDbbDz8En2laWZ/662psgeJcc
	 qVTOXeXLlnSEtGmD3voHMzVCUJFRrsk3pkGAqYNwe+u3AV4LY5QU+v24Qp+bsoi4uz
	 b5zo0jEYLamJydzC8gATMlsquCP2kon6O/Mgk015d+GllRyVdCe7nwXMH/PEhr50jl
	 czo28vbdx0xnmO3Ksh2JkjEWOTFN+WNftppHa3r6kJe8oCa7il/EThzuYT1Dse+6JR
	 oZdYUe5hc/62Azy7+Ff/FpHI=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C12AC40E00C5;
	Thu,  1 Feb 2024 09:21:48 +0000 (UTC)
Date: Thu, 1 Feb 2024 10:21:48 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com
Subject: Re: [PATCH] RAS/AMD/ATL: Add MI300 DRAM to Normalized address
 translation support
Message-ID: <20240201092148.GBZbtirOfNAR3SYmht@fat_crate.local>
References: <20240131165732.88297-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240131165732.88297-1-yazen.ghannam@amd.com>

On Wed, Jan 31, 2024 at 10:57:32AM -0600, Yazen Ghannam wrote:
> diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
> index 7bfa21a582f0..816c2c5c683f 100644
> --- a/drivers/ras/amd/atl/umc.c
> +++ b/drivers/ras/amd/atl/umc.c
> @@ -49,6 +49,203 @@ static u8 get_coh_st_inst_id_mi300(struct atl_err *err)
>  	return i;
>  }
>  
> +static u16 internal_bitwise_xor(u16 val)

Why are we calling it "internal"?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

