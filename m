Return-Path: <linux-kernel+bounces-65109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D0D8547EA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1070AB29743
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C14E1AADC;
	Wed, 14 Feb 2024 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aRiADG+f"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3BE1AAD0;
	Wed, 14 Feb 2024 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707909323; cv=none; b=ka6goRZz+2iLGSeR9kM3NyH7KEIdkoVq1FxCHHRhKG1lm52HStX3bl5Z+Xjj/yeEh8PeBzc3tzKN1rj+DRpgk2bzpD8VoHX4iWNdj8kpNVpsRHE3Gdh7oiNtbwZXKnv0Vo3VN9RCeNOkHNlY1RZk+08lcFe4RYqpbcqnPsASclo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707909323; c=relaxed/simple;
	bh=BaeX3CxzgjGnGXG+jjOlxSe9XMor87kcACjYdz7FzjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mq8eGLvvKe4/0gFOspxTllJe8W5OegFLXvuEPXZu3z459sE/vS2ezGrywnwLkxU6/YgdXzP9hyoO+XzBkuReqntcLW4s1vp1GIYfcwBDU8kVjq7WBBfayv0kGeiK22DoKawxSOWWAhNlX/qRCO0SaBCs5DVOEIx/GWQnocauzd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aRiADG+f; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0915B1C0006;
	Wed, 14 Feb 2024 11:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707909319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QX2F+SiPt59EFUZW297RvZmqcYkhC1k7aoqJ8fw5ASg=;
	b=aRiADG+fMK9VpS0h7S5QobMVrxI+pX6H9xgvXFloawUakF0lHG7kqNq55QY7l3C5c8bFJ6
	4lWhLix/qXyz6vZ9MDOaedOTv4cZzintatO946IznWvb4UG1Uvz+8S7/3TxFsHtP/3hkg+
	6PZlewk0Rih90imVlB7TG3ZC2TgG7vQmRGp7XCVza+pIIYWAS8ZFfXe4fTSUrBH3T0z553
	t25jDwEP9lmG8VrML8/4N3BLyVlD1n70hGc1Lyo6/90oM9uN3eIQjUek8W7zUn+wEkRjUc
	Bkq5/Ypn0QEwIc7LGNCS1fDG0TO1fc3syq0sJpjT2+9yK32dP2TYdvXOm7h0Fg==
Date: Wed, 14 Feb 2024 12:15:17 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Adam Ford <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, marex@denx.de,
 aford@beaconembedded.com, Lucas Stach <l.stach@pengutronix.de>, Vinod Koul
 <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team
 <linux-imx@nxp.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 4/6] arm64: dts: imx8mp: add HDMI irqsteer
Message-ID: <20240214121517.54552a4a@booty>
In-Reply-To: <20240210204606.11944-5-aford173@gmail.com>
References: <20240210204606.11944-1-aford173@gmail.com>
	<20240210204606.11944-5-aford173@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

On Sat, 10 Feb 2024 14:46:00 -0600
Adam Ford <aford173@gmail.com> wrote:

> From: Lucas Stach <l.stach@pengutronix.de>
> 
> The HDMI irqsteer is a secondary interrupt controller within the HDMI
> subsystem that maps all HDMI peripheral IRQs into a single upstream
> IRQ line.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V2:  Add my (Adam) s-o-b and re-order position under AIPS4
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 0730d4cf9bc4..9b8ab367d774 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -1927,6 +1927,19 @@ hdmi_blk_ctrl: blk-ctrl@32fc0000 {
>  						     "hdcp", "hrv";
>  				#power-domain-cells = <1>;
>  			};
> +
> +			irqsteer_hdmi: interrupt-controller@32fc2000 {
> +				compatible = "fsl,imx-irqsteer";
> +				reg = <0x32fc2000 0x44>;

The last register being at offset 0x44, this should be <0x32fc2000
0x48> or even <... 0x1000> as the TRM mentions a 4 kB size.

[Tested using Avnet MSC SM2S-IMX8PLUS SoM on Avnet MSC SM2-MB-EP1]
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>


Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

