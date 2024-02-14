Return-Path: <linux-kernel+bounces-65323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345E8854B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05385B2597F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFDE55778;
	Wed, 14 Feb 2024 14:12:43 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A2954FA4;
	Wed, 14 Feb 2024 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707919962; cv=none; b=tTtrvBELaFKcvpnZokBSRi3ogRmuZPGpkBafGtqlV4tXX8Fi/f5j0GXUixva5tLH5oKEabRuYvLJ2nlSMC67b0to/eXFW8pF01cI8zEtdQ06eAerv5/rXqcli5h8S4hXaZva7SN87tqvqCFM2HSsq4ASEwKK0uMDBnuT+rzp1nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707919962; c=relaxed/simple;
	bh=XYOhbvhPZxYmBhp1tU8taJa8/fjCiGlVZn1WC/bNMZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T160rZs4n5nBvcaLPv1nMe1zU2ir0PsJGnHu724w8NAiqTTSnCdR5hxWGTPwvrguhHIvmceiW1CRR2zTOR1kUDpt/6unwMGi72huOGaYnDKtl4GV38TWMl/oBz+WGohgZqrPxiDlD/pgVCi/Ok8TSHoLtxZ92IwQMgzu7uZcUDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1raFzr-00046P-39;
	Wed, 14 Feb 2024 14:12:24 +0000
Date: Wed, 14 Feb 2024 14:12:15 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V2 2/2] pwm: mediatek: add support for MT7988
Message-ID: <ZczKP-L7MptwnKF_@makrotopia.org>
References: <20240214140454.6438-1-zajec5@gmail.com>
 <20240214140454.6438-2-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240214140454.6438-2-zajec5@gmail.com>

On Wed, Feb 14, 2024 at 03:04:54PM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> MT7988 uses new registers layout just like MT7981 but it supports 8 PWM
> interfaces.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

> ---
> V2: New patch in the series
> 
>  drivers/pwm/pwm-mediatek.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index 562102a47ac0..292c8bd5b343 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -339,6 +339,13 @@ static const struct pwm_mediatek_of_data mt7986_pwm_data = {
>  	.reg_offset = mtk_pwm_reg_offset_v1,
>  };
>  
> +static const struct pwm_mediatek_of_data mt7988_pwm_data = {
> +	.num_pwms = 8,
> +	.pwm45_fixup = false,
> +	.has_ck_26m_sel = false,
> +	.reg_offset = mtk_pwm_reg_offset_v2,
> +};
> +
>  static const struct pwm_mediatek_of_data mt8183_pwm_data = {
>  	.num_pwms = 4,
>  	.pwm45_fixup = false,
> @@ -369,6 +376,7 @@ static const struct of_device_id pwm_mediatek_of_match[] = {
>  	{ .compatible = "mediatek,mt7629-pwm", .data = &mt7629_pwm_data },
>  	{ .compatible = "mediatek,mt7981-pwm", .data = &mt7981_pwm_data },
>  	{ .compatible = "mediatek,mt7986-pwm", .data = &mt7986_pwm_data },
> +	{ .compatible = "mediatek,mt7988-pwm", .data = &mt7988_pwm_data },
>  	{ .compatible = "mediatek,mt8183-pwm", .data = &mt8183_pwm_data },
>  	{ .compatible = "mediatek,mt8365-pwm", .data = &mt8365_pwm_data },
>  	{ .compatible = "mediatek,mt8516-pwm", .data = &mt8516_pwm_data },
> -- 
> 2.35.3
> 
> 

