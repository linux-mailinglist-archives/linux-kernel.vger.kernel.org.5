Return-Path: <linux-kernel+bounces-117182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B43788A85C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0191C610B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFA713AA45;
	Mon, 25 Mar 2024 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZ8vvA8w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401AD13A88B;
	Mon, 25 Mar 2024 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374939; cv=none; b=cIBAJqinW+jeaXyfwStePRqFVdDdpPGre+BCbJy6+fn8dOgbIRLBSHhXAtNCzlAJJesGnHHVnZ9zB3HfiGAx4/P19l1UXonfAEdgizcOA9ioV+s8cKXlfDXMU1VFR1qM+bkSTuCVWJxqW2+gx5Ps0VyZ5DalZeZVgpCSkw6rR9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374939; c=relaxed/simple;
	bh=D61EWznHl1PQPwhFhPh0ucTPJDZRKnDy5Hwth2zSCVY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=cVLR+Ypp6kgSmtSSVH3D73qK7nV/q/XNeW4bfbhCXLjOX/pIq6TZ6cJBIFv8yt3IIavPbvEQ7rQZzp7W/CvicXmuiGn6VDFA+FuSojFKcdPnQkO0zOPfMYX9CVPApxZY0D/7a9epOiF7Lwo0LWIR1uC9Ten21FT+1HqPSDUbCCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZ8vvA8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94501C433A6;
	Mon, 25 Mar 2024 13:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711374938;
	bh=D61EWznHl1PQPwhFhPh0ucTPJDZRKnDy5Hwth2zSCVY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=VZ8vvA8wSXhcmeM+jmsTEVCXzgT2/HxOjFjwK9wHTB6h/18eB1gp3WPDfshnmCa9P
	 pGERQU89hgEqh73EZYpDO7zOssf3xCCYQTevM6ZdDxYIozYt6tnTEjR9orQeyJ00m/
	 N4/d66k10ro7sXvp0qEe94wceFwKui/EaKSzD6vpghskeQznG6bk6Mix1En9sP6Ow+
	 yGywbgFdW+6wI8eV2DvAt48eXvtRhxn1g1bnv3nlUDECrn1TG9FEbij2lKHEcPLGT5
	 H0l8bog0s4BOwEb+UR3SkMCppef+Cn1eVbhvs1m+/UZFXSjlbQyzvDfdnuu30Xvac7
	 XUnra2SUZNsBA==
Date: Mon, 25 Mar 2024 08:55:37 -0500
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
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, devicetree@vger.kernel.org
In-Reply-To: <f5d4d71cd59f25b80889ef88fa044aa3a4268d46.1711288736.git.stano.jakubek@gmail.com>
References: <f5d4d71cd59f25b80889ef88fa044aa3a4268d46.1711288736.git.stano.jakubek@gmail.com>
Message-Id: <171137470670.3264858.14092936502635914730.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Add Motorola Moto G (2013)


On Sun, 24 Mar 2024 15:03:59 +0100, Stanislav Jakubek wrote:
> Document the Motorola Moto G (2013), which is a smartphone based
> on the Qualcomm MSM8226 SoC.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
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


New warnings running 'make CHECK_DTBS=y qcom/msm8226-motorola-falcon.dtb' for f5d4d71cd59f25b80889ef88fa044aa3a4268d46.1711288736.git.stano.jakubek@gmail.com:

arch/arm/boot/dts/qcom/msm8226-motorola-falcon.dtb: syscon@f9011000: compatible: 'anyOf' conditional failed, one must be fixed:
	['syscon'] is too short
	'syscon' is not one of ['allwinner,sun8i-a83t-system-controller', 'allwinner,sun8i-h3-system-controller', 'allwinner,sun8i-v3s-system-controller', 'allwinner,sun50i-a64-system-controller', 'amd,pensando-elba-syscon', 'brcm,cru-clkset', 'freecom,fsg-cs2-system-controller', 'fsl,imx93-aonmix-ns-syscfg', 'fsl,imx93-wakeupmix-syscfg', 'hisilicon,dsa-subctrl', 'hisilicon,hi6220-sramctrl', 'hisilicon,pcie-sas-subctrl', 'hisilicon,peri-subctrl', 'hpe,gxp-sysreg', 'intel,lgm-syscon', 'loongson,ls1b-syscon', 'loongson,ls1c-syscon', 'marvell,armada-3700-usb2-host-misc', 'mediatek,mt8135-pctl-a-syscfg', 'mediatek,mt8135-pctl-b-syscfg', 'mediatek,mt8365-syscfg', 'microchip,lan966x-cpu-syscon', 'microchip,sparx5-cpu-syscon', 'mstar,msc313-pmsleep', 'nuvoton,ma35d1-sys', 'nuvoton,wpcm450-shm', 'rockchip,px30-qos', 'rockchip,rk3036-qos', 'rockchip,rk3066-qos', 'rockchip,rk3128-qos', 'rockchip,rk3228-qos', 'rockchip,rk3288-qos', 'rockchip,rk3368-qos', 'rockchip,rk3399-qos', 'rockchip,rk3568-qos', '
 rockchip,rk3588-qos', 'rockchip,rv1126-qos', 'starfive,jh7100-sysmain', 'ti,am62-usb-phy-ctrl', 'ti,am654-dss-oldi-io-ctrl', 'ti,am654-serdes-ctrl', 'ti,j784s4-pcie-ctrl']
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#






