Return-Path: <linux-kernel+bounces-104597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A12D87D0AE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2A41C22257
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEA54AED0;
	Fri, 15 Mar 2024 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGz9uQSj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B5C487A9;
	Fri, 15 Mar 2024 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710517847; cv=none; b=K2WFxrG5lHYj312ixNywaQtPESZc3IFE6Xi/6j0kNJEiVoENY2pOHBkG0ltYP2wefFlNxf6oQpC0BYobh2InUITNzd4knCCac5ZRw26IvfPrajWA7uwRNCQvxx5SYxX2Kj6EPjrwxfxn5SNX/4H1/iu1nh0ch3N0aC0nEYoUYW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710517847; c=relaxed/simple;
	bh=GNo8DvOCyNH+fBflb4vOPG62jKEW0NN1t2gGBuQJWQY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=G5G37ZdfjC0UbzvHX3SDF0+uwBlLEtJSU1PJ8oEH477ZuLWEgC+uQkusaX8BOzG9s2eFvYlbP0piaVz7QD7lTRyWcE/+6LnCcd87f990DTRugptMlQnI2lHXzyVFkEaCONQsQlJvWHe9IqSfMy+J2ciQ1qoPj/HAZ6yuvQYHlbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGz9uQSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DFBC433F1;
	Fri, 15 Mar 2024 15:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710517847;
	bh=GNo8DvOCyNH+fBflb4vOPG62jKEW0NN1t2gGBuQJWQY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=nGz9uQSjqCeI70vG3Y6NOHsrruye8xQqCKIYD8s+56YzteM1h905tBBYtEMxtrfZx
	 0vtUvfIncQzhd9bL0ZXevhROxhyzMReAfTL6I+O6UKAKsJTFbAfNYudrRWOxDHSO/q
	 paKhDUYMysjEYcXnh9E3pqSW225lReplFB9TjD8tus09j9yuvYaa1tWfc0+LuqZZRN
	 jrZZEgRjiYAxsCDNPugkBfex8Stk6m1URdxfITb4c3lzvMU9xrRzGa35Yz3wW/Vs89
	 4if6+Tz5N8z6eLXcwdXCG09183vQ7t9yDZ9f/3byR3uZ9Jh0amb2n+k+VtRJQhoDcH
	 7zXHOfsY3GIYw==
Date: Fri, 15 Mar 2024 09:50:45 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Luca Weiss <luca@z3ntu.xyz>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Adam Honse <calcprogrammer1@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org
In-Reply-To: <20240314-samsung-hlte-v2-0-84094b41c033@z3ntu.xyz>
References: <20240314-samsung-hlte-v2-0-84094b41c033@z3ntu.xyz>
Message-Id: <171051664251.1380101.17946022685245274327.robh@kernel.org>
Subject: Re: [PATCH v2 0/2] Add Samsung Galaxy Note 3 support


On Thu, 14 Mar 2024 20:00:13 +0100, Luca Weiss wrote:
> Add the dts for "hlte" which is a phablet from 2013.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes in v2:
> - Correct property order (Konrad)
> - Pick up tags
> - Link to v1: https://lore.kernel.org/r/20240310-samsung-hlte-v1-0-e9b55bf98a48@z3ntu.xyz
> 
> ---
> Adam Honse (1):
>       ARM: dts: qcom: msm8974: Add Samsung Galaxy Note 3
> 
> Luca Weiss (1):
>       dt-bindings: arm: qcom: Add Samsung Galaxy Note 3
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml    |   1 +
>  arch/arm/boot/dts/qcom/Makefile                    |   1 +
>  .../boot/dts/qcom/qcom-msm8974-samsung-hlte.dts    | 401 +++++++++++++++++++++
>  3 files changed, 403 insertions(+)
> ---
> base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
> change-id: 20240310-samsung-hlte-78d1a287b0a8
> 
> Best regards,
> --
> Luca Weiss <luca@z3ntu.xyz>
> 
> 
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


New warnings running 'make CHECK_DTBS=y qcom/qcom-msm8974-samsung-hlte.dtb' for 20240314-samsung-hlte-v2-0-84094b41c033@z3ntu.xyz:

arch/arm/boot/dts/qcom/qcom-msm8974-samsung-hlte.dtb: /: memory: False schema does not allow {'device_type': ['memory'], 'reg': [[0, 0]]}
	from schema $id: http://devicetree.org/schemas/root-node.yaml#
arch/arm/boot/dts/qcom/qcom-msm8974-samsung-hlte.dtb: l2-cache: Unevaluated properties are not allowed ('qcom,saw' was unexpected)
	from schema $id: http://devicetree.org/schemas/cache.yaml#
arch/arm/boot/dts/qcom/qcom-msm8974-samsung-hlte.dtb: idle-states: 'spc' does not match any of the regexes: '^(cpu|cluster)-', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/cpu/idle-states.yaml#
arch/arm/boot/dts/qcom/qcom-msm8974-samsung-hlte.dtb: syscon@f9011000: compatible: 'anyOf' conditional failed, one must be fixed:
	['syscon'] is too short
	'syscon' is not one of ['allwinner,sun8i-a83t-system-controller', 'allwinner,sun8i-h3-system-controller', 'allwinner,sun8i-v3s-system-controller', 'allwinner,sun50i-a64-system-controller', 'amd,pensando-elba-syscon', 'brcm,cru-clkset', 'freecom,fsg-cs2-system-controller', 'fsl,imx93-aonmix-ns-syscfg', 'fsl,imx93-wakeupmix-syscfg', 'hisilicon,dsa-subctrl', 'hisilicon,hi6220-sramctrl', 'hisilicon,pcie-sas-subctrl', 'hisilicon,peri-subctrl', 'hpe,gxp-sysreg', 'intel,lgm-syscon', 'loongson,ls1b-syscon', 'loongson,ls1c-syscon', 'marvell,armada-3700-usb2-host-misc', 'mediatek,mt8135-pctl-a-syscfg', 'mediatek,mt8135-pctl-b-syscfg', 'mediatek,mt8365-syscfg', 'microchip,lan966x-cpu-syscon', 'microchip,sparx5-cpu-syscon', 'mstar,msc313-pmsleep', 'nuvoton,ma35d1-sys', 'nuvoton,wpcm450-shm', 'rockchip,px30-qos', 'rockchip,rk3036-qos', 'rockchip,rk3066-qos', 'rockchip,rk3128-qos', 'rockchip,rk3228-qos', 'rockchip,rk3288-qos', 'rockchip,rk3368-qos', 'rockchip,rk3399-qos', 'rockchip,rk3568-qos', '
 rockchip,rk3588-qos', 'rockchip,rv1126-qos', 'starfive,jh7100-sysmain', 'ti,am62-usb-phy-ctrl', 'ti,am654-dss-oldi-io-ctrl', 'ti,am654-serdes-ctrl', 'ti,j784s4-pcie-ctrl']
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#






