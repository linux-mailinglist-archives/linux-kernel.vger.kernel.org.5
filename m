Return-Path: <linux-kernel+bounces-98950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0FC878185
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221182841AF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BAE3FE3F;
	Mon, 11 Mar 2024 14:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCPrDa1X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A952208B;
	Mon, 11 Mar 2024 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167012; cv=none; b=NRiaX7YQnuNh4/HeP9DB2Y6mD1NiRBDzOmMJKC+YuEl0GTbXH+5KVazQLCFBqqkR+9W6X/o2SDrOzoJgMVnYh8oLnJQdTeYgs/xk6D6BYsIC1Hm5ALDEOegXvfpCtDyrCCh1R+HQcD2oHHGNQ9nPbHKT4NKe+Yh9i7+Wj47YjHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167012; c=relaxed/simple;
	bh=xUQa2duh6dBoxq9pcAdeK/i5MkMLxHJ3k/BzRbYSM7s=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=kE4DIwzW2BD4Nwg8a6nVyhIokUYhHhscqT4iDZ9QyklnfbqfbQ1UpVP1lqqBU6WQqiu1PDcfDeE6zLc7yfvl6l/IKM7mhrdmk++/mG/cCzipglDRA+Z0K9zO/BG5wP6kb3DBtVaKBe3L8JKSJ0UWaQq58K2KqDQGRDZNpFL3Ws4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCPrDa1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59F8C433C7;
	Mon, 11 Mar 2024 14:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710167011;
	bh=xUQa2duh6dBoxq9pcAdeK/i5MkMLxHJ3k/BzRbYSM7s=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=QCPrDa1XY5vvlnXrPmOE7s/c+PBNmGA0e8BeVdhp29u0wlFq289Gvo6E1T6GwIN9j
	 bKlDgyiezbA6BBLatZ9Igo8IK4bCprIGJJJ5cs8Zg4frRbvF0tqkIPmhaJTHHBzTx1
	 Ahx+CUrKY1pZoO039RMSCwOAOED11pjWkthHAfjl1kD+6PY8bgx18A7Sv36GbwuJ2X
	 9jfRBCF21w99RWVvJ53KocALHZf/LrMZHmeHqZcYiYrAGDpWFulBAVct2CZHsuc+6h
	 61ulHWjyHcoSP15V7Vqnr5nyFIPbejwGnF0rxGNQF2SWwiVUQDerpgI3HGH+Tk4l1h
	 xfXu1rFtE5jUw==
Date: Mon, 11 Mar 2024 08:23:30 -0600
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
Cc: linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 phone-devel@vger.kernel.org, Adam Honse <calcprogrammer1@gmail.com>
In-Reply-To: <20240310-samsung-hlte-v1-0-e9b55bf98a48@z3ntu.xyz>
References: <20240310-samsung-hlte-v1-0-e9b55bf98a48@z3ntu.xyz>
Message-Id: <171016679093.1126634.17115825771533066372.robh@kernel.org>
Subject: Re: [PATCH 0/2] Add Samsung Galaxy Note 3 support


On Sun, 10 Mar 2024 15:13:35 +0100, Luca Weiss wrote:
> Add the dts for "hlte" which is a phablet from 2013.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Adam Honse (1):
>       ARM: dts: qcom: msm8974: Add Samsung Galaxy Note 3
> 
> Luca Weiss (1):
>       dt-bindings: arm: qcom: Add Samsung Galaxy Note 3
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml    |   1 +
>  arch/arm/boot/dts/qcom/Makefile                    |   1 +
>  .../boot/dts/qcom/qcom-msm8974-samsung-hlte.dts    | 403 +++++++++++++++++++++
>  3 files changed, 405 insertions(+)
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


New warnings running 'make CHECK_DTBS=y qcom/qcom-msm8974-samsung-hlte.dtb' for 20240310-samsung-hlte-v1-0-e9b55bf98a48@z3ntu.xyz:

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






