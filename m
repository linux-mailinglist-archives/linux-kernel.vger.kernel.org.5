Return-Path: <linux-kernel+bounces-152002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C9D8AB739
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0A81B21B63
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C30413D50D;
	Fri, 19 Apr 2024 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVbR/ZxK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A5813D2B0;
	Fri, 19 Apr 2024 22:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713565466; cv=none; b=luR+1L+3nw1AMDYdZuA7vhPxeUDvInK0HftTykZ6yHWmV03yeTxsJFxrfsX7pQ0oILpvGxDEAIkFcuPhWB3NgcyNFWt+lmZOPFjEmKGnQL3RqzV2bsCaORck5wsA8xMRMgAWg5hjfrCK8UUxlHFSmuzAdX8Q8u0MBu+/QiDZtIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713565466; c=relaxed/simple;
	bh=VaJdRqcxHgwSd0Cp+G2uht+Ei0eXCKV3+ePnom4c36o=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=lTPiDpXnWL3/lDva7rO+0vV+EJlHUXS4SguI6jJ5rdvYEDNLXJXp7xAaM6bcUsuvS7/kE7ULuWik3dcuTAPWF48fFjswjF94t3o+nVxZxYETLm3xYTys75c22OTNzO5KvaGa3kCh67i4vvYl9HZzWFYmuwStlyK2mrO+avphbZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVbR/ZxK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47763C2BD11;
	Fri, 19 Apr 2024 22:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713565466;
	bh=VaJdRqcxHgwSd0Cp+G2uht+Ei0eXCKV3+ePnom4c36o=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=WVbR/ZxKFjNNEa9TrhNj+ctecP8ggsoeUvVU6NJM4/JbTXpc330jZQfdEje3DnhIw
	 yZ+6uL0uztBkYt4otMjxcBSUVDMz9LDgjFvjrbfa/AUh/FUgTtdK/7umBjYFL9+Lid
	 siR1YebjnFUiABmjgjT4nZoBLMG/be/4JBgDsAmXTolBBqL3LSmd58JXja+Ta/50Bv
	 X99jAGiT8svCTmyu1e9PNs6UHPVFpT6cfJGK+Ja+F+s14GJzbU5ALdM0deHmEn3Edw
	 t5eDDJzQNi33Bww3yAxSmjSmxFyUXlkkfucPou7HXUZjAxHh3bAEtvc8pr5DH0As9G
	 3ioqn9I5jJv3A==
Date: Fri, 19 Apr 2024 17:24:25 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Rafal Milecki <zajec5@gmail.com>, Tom Brautaset <tbrautaset@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, Hauke Mehrtens <hauke@hauke-m.de>
In-Reply-To: <20240419-for-soc-asus-rt-ac3200-ac5300-v2-0-f95ff50c2a4d@arinc9.com>
References: <20240419-for-soc-asus-rt-ac3200-ac5300-v2-0-f95ff50c2a4d@arinc9.com>
Message-Id: <171356537257.48077.3476336621088836792.robh@kernel.org>
Subject: Re: [PATCH v2 0/4] Document ASUS RT-AC3200 and ASUS RT-AC5300 and
 add device trees


On Fri, 19 Apr 2024 10:22:47 +0300, Arınç ÜNAL wrote:
> Hello.
> 
> This patch series documents the compatible strings for ASUS RT-AC3200 and
> ASUS RT-AC5300, and adds the device trees for them.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
> Changes in v2:
> - Patch 3
>   - Remove the chosen node as earlycon is not for mainline use, and the
>     stdout-path property which should be used instead of bootargs =
>     "console=" is already described in bcm4708.dtsi with the same value.
>   - Remove MAC address assignment to switch ports. To explain why shortly,
>     on the switch with CPU port architecture, the LLC Entity associated
>     with each port can be accessed without a distinct MAC address assigned
>     to each port. Therefore, it is unnecessary.
> - Patch 4
>   - Same as above.
> - Link to v1: https://lore.kernel.org/r/20240414-for-soc-asus-rt-ac3200-ac5300-v1-0-118c90bae6e5@arinc9.com
> 
> ---
> Arınç ÜNAL (4):
>       dt-bindings: arm: bcm: add bindings for ASUS RT-AC3200
>       dt-bindings: arm: bcm: add bindings for ASUS RT-AC5300
>       ARM: dts: BCM5301X: Add DT for ASUS RT-AC3200
>       ARM: dts: BCM5301X: Add DT for ASUS RT-AC5300
> 
>  .../devicetree/bindings/arm/bcm/brcm,bcm4708.yaml  |   2 +
>  arch/arm/boot/dts/broadcom/Makefile                |   2 +
>  .../boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts   | 150 ++++++++++++++++++++
>  .../boot/dts/broadcom/bcm47094-asus-rt-ac5300.dts  | 156 +++++++++++++++++++++
>  4 files changed, 310 insertions(+)
> ---
> base-commit: 011d79ef1cfad701c2d8e7e80d8c77523af9c771
> change-id: 20240408-for-soc-asus-rt-ac3200-ac5300-5d6efc2c497b
> 
> Best regards,
> --
> Arınç ÜNAL <arinc.unal@arinc9.com>
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


New warnings running 'make CHECK_DTBS=y broadcom/bcm4709-asus-rt-ac3200.dtb broadcom/bcm47094-asus-rt-ac5300.dtb' for 20240419-for-soc-asus-rt-ac3200-ac5300-v2-0-f95ff50c2a4d@arinc9.com:

arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb: pcie@12000: 'device_type' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb: pcie@12000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb: pcie@13000: 'device_type' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb: pcie@13000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb: pcie@14000: 'device_type' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb: pcie@14000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dtb: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dtb: pcie@12000: 'device_type' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dtb: pcie@12000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dtb: pcie@13000: 'device_type' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dtb: pcie@13000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dtb: pcie@14000: 'device_type' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dtb: pcie@14000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
	from schema $id: http://devicetree.org/schemas/net/dsa/brcm,b53.yaml#
arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
	'fixed-link' is a required property
	'phy-handle' is a required property
	'managed' is a required property
	from schema $id: http://devicetree.org/schemas/net/dsa/brcm,b53.yaml#
arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb: ethernet-switch@18007000: ports:port@7: 'phy-mode' is a required property
	from schema $id: http://devicetree.org/schemas/net/dsa/brcm,b53.yaml#
arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb: ethernet-switch@18007000: ports:port@7: 'oneOf' conditional failed, one must be fixed:
	'fixed-link' is a required property
	'phy-handle' is a required property
	'managed' is a required property
	from schema $id: http://devicetree.org/schemas/net/dsa/brcm,b53.yaml#
arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb: ethernet-switch@18007000: ports:port@8: 'phy-mode' is a required property
	from schema $id: http://devicetree.org/schemas/net/dsa/brcm,b53.yaml#
arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/dsa/brcm,b53.yaml#
arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
	from schema $id: http://devicetree.org/schemas/net/dsa/brcm,b53.yaml#
arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
	'fixed-link' is a required property
	'phy-handle' is a required property
	'managed' is a required property
	from schema $id: http://devicetree.org/schemas/net/dsa/brcm,b53.yaml#
arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dtb: ethernet-switch@18007000: ports:port@7: 'phy-mode' is a required property
	from schema $id: http://devicetree.org/schemas/net/dsa/brcm,b53.yaml#
arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dtb: ethernet-switch@18007000: ports:port@7: 'oneOf' conditional failed, one must be fixed:
	'fixed-link' is a required property
	'phy-handle' is a required property
	'managed' is a required property
	from schema $id: http://devicetree.org/schemas/net/dsa/brcm,b53.yaml#
arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dtb: ethernet-switch@18007000: ports:port@8: 'phy-mode' is a required property
	from schema $id: http://devicetree.org/schemas/net/dsa/brcm,b53.yaml#
arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/dsa/brcm,b53.yaml#






