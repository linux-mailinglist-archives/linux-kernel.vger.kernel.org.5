Return-Path: <linux-kernel+bounces-155354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 003F08AE943
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D168EB21D61
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DF813B5A4;
	Tue, 23 Apr 2024 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUsX2UAc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B87D13BADC;
	Tue, 23 Apr 2024 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881758; cv=none; b=CnE0NCCKLIhhGttGDvKfr4669IhD4e7pSvTurU0E4tjVTRkpCb5CQ50xCwUYnOh96K9NzqrpfqW3MxMsZ3PNtZvlXXNCnH/FGNbAwjSVxtbfHxM+QX8BSi8SZ9Tq0xJtFtKAA+VqnLoDIgR3qqdbqFXK9KImU40ollSeCeNHi9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881758; c=relaxed/simple;
	bh=4DJ/Dgkx7F+t3aXQA8U+UrYZta3W6HBJxg7ojhYewBk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=TEnyHHgRTbk8eo0QvQYltuV9FG5SNeI4+roY9l3r5kRt6ZE19Wa5naA40lki+G6nc09Nfs8HPrZcOgh5F9yeZ0PDE/zCr5gUIDo/slWcIBnXODqsOC6hJwqY8CM+h6fv5c+huxuVQ2NURmQfJMQI4eeDpnPJ9Dp/7IQZiWAol5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUsX2UAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC385C116B1;
	Tue, 23 Apr 2024 14:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713881757;
	bh=4DJ/Dgkx7F+t3aXQA8U+UrYZta3W6HBJxg7ojhYewBk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=lUsX2UActzcUmTg0uHQcCkW7Q96/e4UkSHyVdA7jXz5dfn74WnxB7CkrmrGbnovDO
	 rD7+Ssy0HyK7H15xbsLuK1Ao6pCfFk6iMUbH072mxWgt6l+p677024KgVnrtvNLRUX
	 74HoMC0uAdMZFVIPAPU5OW9YIRdhW3e6TduXx9HfciuaqOMh9OR7AeCZXwgAmJvTDC
	 aAYBMHKl9PAw/FxA1A+3Nrcl2loYmmye+skeHSvCtHqkFeEXND+wcddYDl8c4XabLx
	 ooGajCGZVYq3etBUl0sUMbP0hTIT0WaB8w0wJfY3gvDHw0nxBc6kPi+vsEtfeJkhy5
	 tSB3Y1Sokbjlw==
Date: Tue, 23 Apr 2024 09:15:56 -0500
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
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rafal Milecki <zajec5@gmail.com>, Tom Brautaset <tbrautaset@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Florian Fainelli <f.fainelli@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20240423-for-soc-asus-rt-ac3200-ac5300-v3-0-23d33cfafe7a@arinc9.com>
References: <20240423-for-soc-asus-rt-ac3200-ac5300-v3-0-23d33cfafe7a@arinc9.com>
Message-Id: <171388152821.138872.5281517425137095516.robh@kernel.org>
Subject: Re: [PATCH v3 0/5] Document ASUS RT-AC3200 and ASUS RT-AC5300 and
 add device trees


On Tue, 23 Apr 2024 12:50:44 +0300, Arınç ÜNAL wrote:
> Hello.
> 
> This patch series documents the compatible strings for ASUS RT-AC3200 and
> ASUS RT-AC5300, and adds the device trees for them. The last patch makes
> the device tree files for ASUS RT-AC3100 and ASUS RT-AC88U conform to the
> Devicetree Sources (DTS) Coding Style.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
> Changes in v3:
> - Add a new patch to the end.
> - Patch 3
>   - Reorder the nodes and properties to conform to the Devicetree Sources
>     (DTS) Coding Style.
> - Patch 4
>   - Same as above.
> - Link to v2: https://lore.kernel.org/r/20240419-for-soc-asus-rt-ac3200-ac5300-v2-0-f95ff50c2a4d@arinc9.com
> 
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
> Arınç ÜNAL (5):
>       dt-bindings: arm: bcm: add bindings for ASUS RT-AC3200
>       dt-bindings: arm: bcm: add bindings for ASUS RT-AC5300
>       ARM: dts: BCM5301X: Add DT for ASUS RT-AC3200
>       ARM: dts: BCM5301X: Add DT for ASUS RT-AC5300
>       ARM: dts: BCM5301X: Conform to DTS Coding Style on ASUS RT-AC3100 & AC88U
> 
>  .../devicetree/bindings/arm/bcm/brcm,bcm4708.yaml  |   2 +
>  arch/arm/boot/dts/broadcom/Makefile                |   2 +
>  .../boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts   | 150 ++++++++++++++++++++
>  .../boot/dts/broadcom/bcm47094-asus-rt-ac3100.dtsi |  92 ++++++------
>  .../boot/dts/broadcom/bcm47094-asus-rt-ac5300.dts  | 156 +++++++++++++++++++++
>  .../boot/dts/broadcom/bcm47094-asus-rt-ac88u.dts   |  69 +++++----
>  6 files changed, 390 insertions(+), 81 deletions(-)
> ---
> base-commit: dd5c56cd065e6f7ac5f87b939e8a3c499a62d463
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


New warnings running 'make CHECK_DTBS=y broadcom/bcm4709-asus-rt-ac3200.dtb broadcom/bcm47094-asus-rt-ac5300.dtb broadcom/bcm47094-asus-rt-ac88u.dtb' for 20240423-for-soc-asus-rt-ac3200-ac5300-v3-0-23d33cfafe7a@arinc9.com:

arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dtb: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb: pcie@12000: 'device_type' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb: pcie@12000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb: pcie@13000: 'device_type' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb: pcie@13000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dtb: pcie@12000: 'device_type' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dtb: pcie@12000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb: pcie@14000: 'device_type' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb: pcie@14000: 'ranges' is a required property
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






