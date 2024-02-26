Return-Path: <linux-kernel+bounces-81354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9905086749D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7D51C24AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598D7604C0;
	Mon, 26 Feb 2024 12:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="O6F0P5vL"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE8E604A5;
	Mon, 26 Feb 2024 12:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949985; cv=none; b=jDBpcdEdRCmFtq4yg+IbWHC14B2k2JPY+TpLcEz3lH+A1PXvpOqMJN1UB1vM7f2vrfxBJDloFeALIWPDCoLCH2nSbl3k0LTLbGijk+4C0Ubxeuu1VvDywQP+0WjcWbbNqI/ptJJ+8M2CRnWjmvw63rH73qwTIVYJo2SDSAX235Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949985; c=relaxed/simple;
	bh=S8qmz8mEsCC2aVp3rHsO/dP5uHUmHA33spU6e8whFWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lpq97MebkVVtCN2hxSl/e4edsAWv4FZ/d/hY3hJJE9490BGMzv8d/ZG1R1DfeacZifoK0B+5nKEwcHkQ3o4xEZFt6fPX0E1+grZiw9gs9PzmMuPMhTiNIMJRIMxVuW1SoVFDRjZVWFd93IGl/NIVOGM2EDY45Ek2BDAL0XM6NH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=O6F0P5vL; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F019E40E0192;
	Mon, 26 Feb 2024 12:19:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SYe9xRSlCndm; Mon, 26 Feb 2024 12:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708949972; bh=aowlc4g9p201VE/ouP+cqCteydTDAa5Ymyxa0wtZGh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O6F0P5vLl9DOOGKeY4yfOxipgnBAV0gmmXxFvCJmKvAA6tQoKAcFfkHWSRECiYjYQ
	 4yhpkt6Rwpq2p8++S2UUABKzBJUvnY18xiwJ8Z9XLVU7cjMEwfgoJtvLZnSGWGxXUy
	 E1MrQo6/5a7Tt99DO364o8ILN82NjpyOatVr0OaQ48u12jmwIEFblUy8Y8QRFYB/bK
	 QxPADBg4LQ70gTP4My4sMQxcG/F1ahMQXvGQNmv8eF2TdnzoH8TF4ngD0s/3bVcxPd
	 hUTklgOaJq2DrappMYDj36S/YkqQ3wEKznBn6ub0lGlamqtRlujW3zj+tg8C++XEwL
	 IoSwSn1emgQB56TClbNj4ayCglNMbLUE9f/sYAWlK0/WmEor+WmHw1QZoFjg5E61Yo
	 9UFCuZNzd6AW5fjN/x/M7TPWjsj8ABBLD7lRW8gfosUH52L/khj12wKxQIO46bMx0R
	 Jnmp//zQ18amjTSEsLtJBXTe8LiixPh6mj2XiERHLF3W+s0q4/NL1TATczKQs7+ya+
	 dYRIGMkjM/L+DRyYZ4hGGu4J8QnyvU6bQAQyzuOKLT+ED5ppC5pg7m6GxHlgtBXtAx
	 hcl5ReOGpGXTNL4WonzfLWbGnOjfgTuHloFcn5gALAlVX0wtxBzcxedOg9eJE6q+6d
	 aWJlKJkdoG3YaG8u/VB2SjYk=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 05B1A40E016C;
	Mon, 26 Feb 2024 12:19:25 +0000 (UTC)
Date: Mon, 26 Feb 2024 13:19:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com
Subject: Re: [PATCH] RAS/AMD/ATL: Fix bit overflow in denorm_addr_df4_np2()
Message-ID: <20240226121919.GBZdyBx_jqFsHCWZP7@fat_crate.local>
References: <20240222165449.23582-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240222165449.23582-1-yazen.ghannam@amd.com>

On Thu, Feb 22, 2024 at 10:54:49AM -0600, Yazen Ghannam wrote:
> The hash_pa8 and hashed_bit values in denorm_addr_df4_np2() are
> currently defined as u8 types. These variables represent single bits.
> 
> 'hash_pa8' is set based on logical AND operations using masks with more
> than 8 bits. So the calculated value will not fit in this variable. It
> will always be '0'. The 'hash_pa8' check later in the function will fail
> which produces incorrect results for some cases.
> 
> Change these variables to bool type. This clarifies that they are
> single bit values. Also, this allows the compiler to ensure they hold
> the proper results. Remove an unnecessary shift operation.
> 
> Fixes: 3f3174996be6 ("RAS: Introduce AMD Address Translation Library")
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/ras/amd/atl/denormalize.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/ras/amd/atl/denormalize.c b/drivers/ras/amd/atl/denormalize.c
> index 49a900e066f1..f46bce119255 100644
> --- a/drivers/ras/amd/atl/denormalize.c
> +++ b/drivers/ras/amd/atl/denormalize.c
> @@ -545,7 +545,7 @@ static int denorm_addr_df4_np2(struct addr_ctx *ctx)
>  	unsigned int mod_value, shift_value;
>  	u16 mask = df_cfg.component_id_mask;
>  	u64 temp_addr_a, temp_addr_b;
> -	u8 hash_pa8, hashed_bit;
> +	bool hash_pa8, hashed_bit;
>  
>  	switch (ctx->map.intlv_mode) {
>  	case DF4_NPS4_3CHAN_HASH:
> @@ -578,7 +578,6 @@ static int denorm_addr_df4_np2(struct addr_ctx *ctx)
>  		temp_addr_a	= remove_bits(shift_value, shift_value, ctx->ret_addr);
>  	} else {
>  		hash_pa8	= (ctx->coh_st_fabric_id & df_cfg.socket_id_mask);
> -		hash_pa8	>>= df_cfg.socket_id_shift;
>  		temp_addr_a	= ctx->ret_addr;
>  	}
>  
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

