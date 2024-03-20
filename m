Return-Path: <linux-kernel+bounces-109154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5D188156F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3362C1F21160
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E55254FA9;
	Wed, 20 Mar 2024 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nx02CsiX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490C91A291;
	Wed, 20 Mar 2024 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710951657; cv=none; b=gSH2JmX16W7+PQ4m7OO6vI0bqWKO0uyr9xaSW6O/Yuv0oGA763H+5c08iC8sDUaV2gp4HvkwBN6WT4lKifJ/AWBANe4yMcmO8b10jtEubpqhM6eHQZUtxhzAh46iDxU9KhgptbDCDYDVcIeBsPyJKbx0TEoO5oEsYYPdXTU55xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710951657; c=relaxed/simple;
	bh=z3FvKvwYws62zU5YpFKEphxiNYUrulGGQ60bCVxWjQY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Ra6V4q1upZtSpHCz6aZnE+P8t3WHrBzRBrmBJOmmyU/G5sWpERlUBrzTMxvIyodj+5qyFDs3bN2XSeX6FPjsuC6Po59S74akR2J+a1ch9dDS3ZDuDrJtCoK0dJjjDYkyjv8AvNZ9ado6AgQDaWRsS1lz7z/Wwg2854MxKAjF0Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nx02CsiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0F5C433F1;
	Wed, 20 Mar 2024 16:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710951656;
	bh=z3FvKvwYws62zU5YpFKEphxiNYUrulGGQ60bCVxWjQY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Nx02CsiXwVEYOyUBA4DS/d5BGB1Djh+gF8drspEXVId+yIsnkbelmAlDNOzSFhfr9
	 ozUPOsIjtsutc1jxzgLxMZA/NIaQmXp4T1PDkMmg5Cn3wPYU172gm6bGt8UnZFTJZQ
	 Tk6gcYfrwqn0O7IDUso2VwOzqzz1QHCRHWe048sUYqGQMwsbG95Kdhzu/mAYr6l4OD
	 n76Q83o70zGwJTHlMdY887t3mNOn0fk8e4i1x7GIcwGiOzyqTen2z8jwwE6HthEauQ
	 Zd1ARj2TrPRZaIriHLZpI4XPZrRiA7ZAaboqNqnHV/RimiFUNvA16Pp1kz9Pwb0c7A
	 /X8DK2kQIpQ5A==
Date: Wed, 20 Mar 2024 11:20:55 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Komal Bajaj <quic_kbajaj@quicinc.com>
Cc: Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-arm-msm@vger.kernel.org
In-Reply-To: <20240319091020.15137-1-quic_kbajaj@quicinc.com>
References: <20240319091020.15137-1-quic_kbajaj@quicinc.com>
Message-Id: <171095148554.1943200.12080115651498296993.robh@kernel.org>
Subject: Re: [PATCH 0/3] Add devicetree support of USB for QDU/QRU1000


On Tue, 19 Mar 2024 14:40:17 +0530, Komal Bajaj wrote:
> This series adds devicetree nodes to support interconnects and usb for qdu/qru1000.
> This is based on previously sent driver series[1].
> [1]
> https://lore.kernel.org/linux-arm-msm/20240319090729.14674-1-quic_kbajaj@quicinc.com/
> 
> ------
> Changes in v2:
> * Changes qmpphy node name
> * Changes dr_mode to otg and added USB-B port USB role switch
> * Dropped maximum-speed property from usb dwc3 node
> * Link to v1: https://lore.kernel.org/linux-arm-msm/20240311120859.18489-1-quic_kbajaj@quicinc.com/
> 
> Komal Bajaj (3):
>   arm64: dts: qcom: qdu1000: Add USB3 and PHY support
>   arm64: dts: qcom: qdu1000-idp: enable USB nodes
>   arm64: dts: qcom: qru1000-idp: enable USB nodes
> 
>  arch/arm64/boot/dts/qcom/qdu1000-idp.dts |  65 +++++++++++
>  arch/arm64/boot/dts/qcom/qdu1000.dtsi    | 133 +++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/qru1000-idp.dts |  65 +++++++++++
>  3 files changed, 263 insertions(+)
> 
> --
> 2.42.0
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


New warnings running 'make CHECK_DTBS=y qcom/qdu1000-idp.dtb qcom/qru1000-idp.dtb' for 20240319091020.15137-1-quic_kbajaj@quicinc.com:

arch/arm64/boot/dts/qcom/qdu1000-idp.dtb: /: usb-conn-gpio: {'compatible': ['gpio-usb-b-connector'], 'vbus-gpio': [[90, 7, 0]], 'id-gpio': [[91, 42, 0]], 'vbus-supply': [[99]], 'pinctrl-0': [[100, 101]], 'pinctrl-names': ['default'], 'port': {'endpoint': {'remote-endpoint': [[102]], 'phandle': [[88]]}}} is not of type 'array'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml#
arch/arm64/boot/dts/qcom/qru1000-idp.dtb: /: usb-conn-gpio: {'compatible': ['gpio-usb-b-connector'], 'vbus-gpio': [[86, 7, 0]], 'id-gpio': [[87, 42, 0]], 'vbus-supply': [[95]], 'pinctrl-0': [[96, 97]], 'pinctrl-names': ['default'], 'port': {'endpoint': {'remote-endpoint': [[98]], 'phandle': [[84]]}}} is not of type 'array'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml#
arch/arm64/boot/dts/qcom/qru1000-idp.dtb: phy@88e3000: compatible: 'oneOf' conditional failed, one must be fixed:
	['qcom,qdu1000-usb-hs-phy', 'qcom,usb-snps-hs-7nm-phy'] is too long
	'qcom,qdu1000-usb-hs-phy' is not one of ['qcom,sc8180x-usb-hs-phy', 'qcom,usb-snps-femto-v2-phy']
	'qcom,qdu1000-usb-hs-phy' is not one of ['qcom,sa8775p-usb-hs-phy', 'qcom,sc8280xp-usb-hs-phy']
	'qcom,qdu1000-usb-hs-phy' is not one of ['qcom,sc7280-usb-hs-phy', 'qcom,sdx55-usb-hs-phy', 'qcom,sdx65-usb-hs-phy', 'qcom,sm6375-usb-hs-phy', 'qcom,sm8150-usb-hs-phy', 'qcom,sm8250-usb-hs-phy', 'qcom,sm8350-usb-hs-phy', 'qcom,sm8450-usb-hs-phy']
	'qcom,usb-snps-hs-5nm-phy' was expected
	from schema $id: http://devicetree.org/schemas/phy/qcom,usb-snps-femto-v2.yaml#
arch/arm64/boot/dts/qcom/qru1000-idp.dtb: /soc@0/phy@88e3000: failed to match any schema with compatible: ['qcom,qdu1000-usb-hs-phy', 'qcom,usb-snps-hs-7nm-phy']
arch/arm64/boot/dts/qcom/qdu1000-idp.dtb: phy@88e3000: compatible: 'oneOf' conditional failed, one must be fixed:
	['qcom,qdu1000-usb-hs-phy', 'qcom,usb-snps-hs-7nm-phy'] is too long
	'qcom,qdu1000-usb-hs-phy' is not one of ['qcom,sc8180x-usb-hs-phy', 'qcom,usb-snps-femto-v2-phy']
	'qcom,qdu1000-usb-hs-phy' is not one of ['qcom,sa8775p-usb-hs-phy', 'qcom,sc8280xp-usb-hs-phy']
	'qcom,qdu1000-usb-hs-phy' is not one of ['qcom,sc7280-usb-hs-phy', 'qcom,sdx55-usb-hs-phy', 'qcom,sdx65-usb-hs-phy', 'qcom,sm6375-usb-hs-phy', 'qcom,sm8150-usb-hs-phy', 'qcom,sm8250-usb-hs-phy', 'qcom,sm8350-usb-hs-phy', 'qcom,sm8450-usb-hs-phy']
	'qcom,usb-snps-hs-5nm-phy' was expected
	from schema $id: http://devicetree.org/schemas/phy/qcom,usb-snps-femto-v2.yaml#
arch/arm64/boot/dts/qcom/qdu1000-idp.dtb: /soc@0/phy@88e3000: failed to match any schema with compatible: ['qcom,qdu1000-usb-hs-phy', 'qcom,usb-snps-hs-7nm-phy']
arch/arm64/boot/dts/qcom/qru1000-idp.dtb: /soc@0/phy@88e5000: failed to match any schema with compatible: ['qcom,qdu1000-qmp-usb3-uni-phy']
arch/arm64/boot/dts/qcom/qru1000-idp.dtb: usb@a6f8800: compatible:0: 'qcom,qdu1000-dwc3' is not one of ['qcom,ipq4019-dwc3', 'qcom,ipq5018-dwc3', 'qcom,ipq5332-dwc3', 'qcom,ipq6018-dwc3', 'qcom,ipq8064-dwc3', 'qcom,ipq8074-dwc3', 'qcom,ipq9574-dwc3', 'qcom,msm8953-dwc3', 'qcom,msm8994-dwc3', 'qcom,msm8996-dwc3', 'qcom,msm8998-dwc3', 'qcom,qcm2290-dwc3', 'qcom,qcs404-dwc3', 'qcom,sa8775p-dwc3', 'qcom,sc7180-dwc3', 'qcom,sc7280-dwc3', 'qcom,sc8280xp-dwc3', 'qcom,sdm660-dwc3', 'qcom,sdm670-dwc3', 'qcom,sdm845-dwc3', 'qcom,sdx55-dwc3', 'qcom,sdx65-dwc3', 'qcom,sdx75-dwc3', 'qcom,sm4250-dwc3', 'qcom,sm6115-dwc3', 'qcom,sm6125-dwc3', 'qcom,sm6350-dwc3', 'qcom,sm6375-dwc3', 'qcom,sm8150-dwc3', 'qcom,sm8250-dwc3', 'qcom,sm8350-dwc3', 'qcom,sm8450-dwc3', 'qcom,sm8550-dwc3', 'qcom,sm8650-dwc3', 'qcom,x1e80100-dwc3']
	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
arch/arm64/boot/dts/qcom/qdu1000-idp.dtb: /soc@0/phy@88e5000: failed to match any schema with compatible: ['qcom,qdu1000-qmp-usb3-uni-phy']
arch/arm64/boot/dts/qcom/qdu1000-idp.dtb: usb@a6f8800: compatible:0: 'qcom,qdu1000-dwc3' is not one of ['qcom,ipq4019-dwc3', 'qcom,ipq5018-dwc3', 'qcom,ipq5332-dwc3', 'qcom,ipq6018-dwc3', 'qcom,ipq8064-dwc3', 'qcom,ipq8074-dwc3', 'qcom,ipq9574-dwc3', 'qcom,msm8953-dwc3', 'qcom,msm8994-dwc3', 'qcom,msm8996-dwc3', 'qcom,msm8998-dwc3', 'qcom,qcm2290-dwc3', 'qcom,qcs404-dwc3', 'qcom,sa8775p-dwc3', 'qcom,sc7180-dwc3', 'qcom,sc7280-dwc3', 'qcom,sc8280xp-dwc3', 'qcom,sdm660-dwc3', 'qcom,sdm670-dwc3', 'qcom,sdm845-dwc3', 'qcom,sdx55-dwc3', 'qcom,sdx65-dwc3', 'qcom,sdx75-dwc3', 'qcom,sm4250-dwc3', 'qcom,sm6115-dwc3', 'qcom,sm6125-dwc3', 'qcom,sm6350-dwc3', 'qcom,sm6375-dwc3', 'qcom,sm8150-dwc3', 'qcom,sm8250-dwc3', 'qcom,sm8350-dwc3', 'qcom,sm8450-dwc3', 'qcom,sm8550-dwc3', 'qcom,sm8650-dwc3', 'qcom,x1e80100-dwc3']
	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
arch/arm64/boot/dts/qcom/qru1000-idp.dtb: /soc@0/usb@a6f8800: failed to match any schema with compatible: ['qcom,qdu1000-dwc3', 'qcom,dwc3']
arch/arm64/boot/dts/qcom/qdu1000-idp.dtb: /soc@0/usb@a6f8800: failed to match any schema with compatible: ['qcom,qdu1000-dwc3', 'qcom,dwc3']
arch/arm64/boot/dts/qcom/qru1000-idp.dtb: pmic@0: gpio@c000: 'usb-vbus-det-default' does not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml#
arch/arm64/boot/dts/qcom/qdu1000-idp.dtb: pmic@0: gpio@c000: 'usb-vbus-det-default' does not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml#
arch/arm64/boot/dts/qcom/qru1000-idp.dtb: gpio@c000: 'usb-vbus-det-default' does not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pinctrl/qcom,pmic-gpio.yaml#
arch/arm64/boot/dts/qcom/qdu1000-idp.dtb: gpio@c000: 'usb-vbus-det-default' does not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pinctrl/qcom,pmic-gpio.yaml#
arch/arm64/boot/dts/qcom/qru1000-idp.dtb: pinctrl@f000000: Unevaluated properties are not allowed ('usb-id-det-default', 'usb-vbus-boost-default' were unexpected)
	from schema $id: http://devicetree.org/schemas/pinctrl/qcom,qdu1000-tlmm.yaml#
arch/arm64/boot/dts/qcom/qdu1000-idp.dtb: pinctrl@f000000: Unevaluated properties are not allowed ('usb-id-det-default', 'usb-vbus-boost-default' were unexpected)
	from schema $id: http://devicetree.org/schemas/pinctrl/qcom,qdu1000-tlmm.yaml#
arch/arm64/boot/dts/qcom/qru1000-idp.dtb: usb-conn-gpio: compatible: 'oneOf' conditional failed, one must be fixed:
	['gpio-usb-b-connector'] is too short
	'gpio-usb-b-connector' is not one of ['usb-a-connector', 'usb-b-connector', 'usb-c-connector']
	'samsung,usb-connector-11pin' was expected
	from schema $id: http://devicetree.org/schemas/connector/usb-connector.yaml#
arch/arm64/boot/dts/qcom/qru1000-idp.dtb: usb-conn-gpio: 'anyOf' conditional failed, one must be fixed:
	'vbus-gpios' is a required property
	'id-gpios' is a required property
	from schema $id: http://devicetree.org/schemas/connector/usb-connector.yaml#
arch/arm64/boot/dts/qcom/qru1000-idp.dtb: usb-conn-gpio: Unevaluated properties are not allowed ('compatible', 'id-gpio', 'vbus-gpio' were unexpected)
	from schema $id: http://devicetree.org/schemas/connector/usb-connector.yaml#
arch/arm64/boot/dts/qcom/qdu1000-idp.dtb: usb-conn-gpio: compatible: 'oneOf' conditional failed, one must be fixed:
	['gpio-usb-b-connector'] is too short
	'gpio-usb-b-connector' is not one of ['usb-a-connector', 'usb-b-connector', 'usb-c-connector']
	'samsung,usb-connector-11pin' was expected
	from schema $id: http://devicetree.org/schemas/connector/usb-connector.yaml#
arch/arm64/boot/dts/qcom/qdu1000-idp.dtb: usb-conn-gpio: 'anyOf' conditional failed, one must be fixed:
	'vbus-gpios' is a required property
	'id-gpios' is a required property
	from schema $id: http://devicetree.org/schemas/connector/usb-connector.yaml#
arch/arm64/boot/dts/qcom/qdu1000-idp.dtb: usb-conn-gpio: Unevaluated properties are not allowed ('compatible', 'id-gpio', 'vbus-gpio' were unexpected)
	from schema $id: http://devicetree.org/schemas/connector/usb-connector.yaml#






