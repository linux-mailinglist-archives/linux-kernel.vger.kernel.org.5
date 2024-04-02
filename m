Return-Path: <linux-kernel+bounces-127963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7A28953B9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6721C23682
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C80181721;
	Tue,  2 Apr 2024 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MrD2bfzu"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A90F79DD4;
	Tue,  2 Apr 2024 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061805; cv=none; b=FCu7p44i1Fq5fUcUE8IGzEZyrE0dD5uHs9sHC5huhWuarMR1SeV9JG7W+mjUpecbBXmQ7kBWW7c7Z+mOCenva74LXaqszdpxrIhEGFFuM0Pn3dGnMRufMxGDZWqFRKYgxtN9H0UIDo/kBCTj9dm2V2pDO01DmgOTx3HTM67GBRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061805; c=relaxed/simple;
	bh=epw34yIKKlGPEjdHE3kEF72x1A6DYUMIDQaYTGHFrvU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SoMsQQ6Mja/eDLEKPzggFBXyJrEP1jB/M+5QZ7z09F9RBdlcJtO3jArYow+F8XY9Tgo/6l64mqUFYMv8OXxqoK5Kyb+/4Ulk3Dkb+d7UWtqKK4GB0HmxGk2JXxD15KFK1tcFId6C3C36+RtwuVGQ3p/d4UIj/nbSX5WcqloZqGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MrD2bfzu; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7DF16240009;
	Tue,  2 Apr 2024 12:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712061795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8b+3ZbVcaXEu4A//GjptOVHRGcD/DD5eaO2T4sWcQ9M=;
	b=MrD2bfzu4yuFaHCtAwvbZ09KPVtZtGAu/x1YbR9qgsx7MJZgCNxe1F8YdsJGuvwl5Rm5nu
	6rQhOTz/zbh3fX98bMEbvQbACB3hrg+346apChWhWNpay0A53+upmPm//TWSy4Tx7944UD
	kurhvuPQYY5B/EgiGHH+0ttSy7UHS0ZDck58bti307IcgjQ63tpXWkUu8PJd6/+b26e9Jo
	MSjEV/NM7271K3DQZrGJmwuKDOU/rEcBeTas5mApqpIzI6qkTKTVIBemTGn+8wMcT8PZoS
	GLAMTGLiivlhJQOxDCNBPfCVnLdlpHCsL2X05CE/vd2AT7YQI3Y1d5bfmCduhQ==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/6] arm64: dts: marvell: ap80x: fix IOMMU unit address
In-Reply-To: <20240401141051.98233-1-krzk@kernel.org>
References: <20240401141051.98233-1-krzk@kernel.org>
Date: Tue, 02 Apr 2024 14:43:15 +0200
Message-ID: <87il107x5o.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com

Krzysztof Kozlowski <krzk@kernel.org> writes:

> Correct the IOMMU device node unit address to match "reg" and fix dtc
> W=1 warnings:
>
>   armada-ap80x.dtsi:64.24-80.6: Warning (simple_bus_reg): /ap807/config-space@f0000000/iommu@5000000: simple-bus unit address format error, expected "100000"
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>


Applied on mvebu/dt64 as well as the 5 other patches from this series.

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-ap80x.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> index 7ec7c789d87e..fdf88cd0eb02 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> @@ -61,7 +61,7 @@ config-space@f0000000 {
>  			compatible = "simple-bus";
>  			ranges = <0x0 0x0 0xf0000000 0x1000000>;
>  
> -			smmu: iommu@5000000 {
> +			smmu: iommu@100000 {
>  				compatible = "marvell,ap806-smmu-500", "arm,mmu-500";
>  				reg = <0x100000 0x100000>;
>  				dma-coherent;
> -- 
> 2.34.1

