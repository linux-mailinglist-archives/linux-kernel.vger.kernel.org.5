Return-Path: <linux-kernel+bounces-136986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A42489DAC0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE7B290FCB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234451369BB;
	Tue,  9 Apr 2024 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="st9BVkrg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D826136990;
	Tue,  9 Apr 2024 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669948; cv=none; b=bSFeqA8sSNU/odBO10PjsuROGA1MIbnnLCqg81rs9499umAboZerkg22XsjfWr9UhSQpUJWYz9pyXxMCths5TdzkwuAF4+JfNy3ApKujT97lIu2IVuxVPk17+I7+K6SqRg9S9SGKuEKk7ioIVKaAtDSYFDwnUA6B305o04ZdJPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669948; c=relaxed/simple;
	bh=ufZjj/dqW11/Dx5bguBYdYOpNmt61BYctGvVnxZcsHw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=MSj2Dn/bQo5NXlT0ZXDXooitcXYpj+G1ItIsgIcasJAASgC1JKIL7T+NFzro5knNV4M65OISWimAhdZpwkXvFESVKcvP4UGs4+TdP9DAKFtc+zbhH0dFJxcOIWnkusqGEPI11lnkNkKjATV9ICjCcFh4rFlPN2og5HMhHuqu7fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=st9BVkrg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A745EC43394;
	Tue,  9 Apr 2024 13:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712669947;
	bh=ufZjj/dqW11/Dx5bguBYdYOpNmt61BYctGvVnxZcsHw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=st9BVkrgDrkpcnic8fOcBW+Vg9I3hqLNdirHD9+YhwHbm0T++ftajcdwnair3fnpY
	 Upo6at1S+pU0SOIPDI/FZJZXdmr8bZSpStTpMaL955GzhdNilcKZIvH4cJO0WJDGhd
	 gNthcdjh3hq1Kk8Tmqugr/S9J2/FlbhxGKmMHJj3dgyVKV1qtl59JMByzxmWVwOdib
	 COGO7eoUJ064h843DKb22WjLmdmIBLshUXyzKccQuRXoRzaeBYSvp5fbdtDP7dPJ6d
	 SMU0oPESBVyDP0dY6OeDtzZ2L/tWqEOPNJWO7ip4o5yVLTdf2Qisc2dS9J3QHlxvCG
	 TpPIxINNTvNJQ==
Date: Tue, 09 Apr 2024 08:39:06 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, phone-devel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-arm-msm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>
In-Reply-To: <32c507337ab80c550fb1df08f7014d1e31eb4c32.1712480582.git.stano.jakubek@gmail.com>
References: <32c507337ab80c550fb1df08f7014d1e31eb4c32.1712480582.git.stano.jakubek@gmail.com>
Message-Id: <171266958581.1032688.14946054886230163874.robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: qcom: Add Motorola Moto G
 (2013)


On Sun, 07 Apr 2024 11:05:10 +0200, Stanislav Jakubek wrote:
> Document the Motorola Moto G (2013), which is a smartphone based
> on the Qualcomm MSM8226 SoC.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
> Changes in V3:
>   - no changes
> 
> Changes in V2:
>   - collect Krzysztof's A-b
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y qcom/msm8226-motorola-falcon.dtb' for 32c507337ab80c550fb1df08f7014d1e31eb4c32.1712480582.git.stano.jakubek@gmail.com:

arch/arm/boot/dts/qcom/msm8226-motorola-falcon.dtb: syscon@f9011000: compatible: 'anyOf' conditional failed, one must be fixed:
	['syscon'] is too short
	'syscon' is not one of ['allwinner,sun8i-a83t-system-controller', 'allwinner,sun8i-h3-system-controller', 'allwinner,sun8i-v3s-system-controller', 'allwinner,sun50i-a64-system-controller', 'amd,pensando-elba-syscon', 'brcm,cru-clkset', 'freecom,fsg-cs2-system-controller', 'fsl,imx93-aonmix-ns-syscfg', 'fsl,imx93-wakeupmix-syscfg', 'hisilicon,dsa-subctrl', 'hisilicon,hi6220-sramctrl', 'hisilicon,pcie-sas-subctrl', 'hisilicon,peri-subctrl', 'hpe,gxp-sysreg', 'intel,lgm-syscon', 'loongson,ls1b-syscon', 'loongson,ls1c-syscon', 'marvell,armada-3700-usb2-host-misc', 'mediatek,mt8135-pctl-a-syscfg', 'mediatek,mt8135-pctl-b-syscfg', 'mediatek,mt8365-syscfg', 'microchip,lan966x-cpu-syscon', 'microchip,sparx5-cpu-syscon', 'mstar,msc313-pmsleep', 'nuvoton,ma35d1-sys', 'nuvoton,wpcm450-shm', 'rockchip,px30-qos', 'rockchip,rk3036-qos', 'rockchip,rk3066-qos', 'rockchip,rk3128-qos', 'rockchip,rk3228-qos', 'rockchip,rk3288-qos', 'rockchip,rk3368-qos', 'rockchip,rk3399-qos', 'rockchip,rk3568-qos', '
 rockchip,rk3588-qos', 'rockchip,rv1126-qos', 'starfive,jh7100-sysmain', 'ti,am62-usb-phy-ctrl', 'ti,am654-dss-oldi-io-ctrl', 'ti,am654-serdes-ctrl', 'ti,j784s4-pcie-ctrl']
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#






