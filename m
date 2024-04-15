Return-Path: <linux-kernel+bounces-145733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F37D28A5A26
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A3461F216C3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50019155A47;
	Mon, 15 Apr 2024 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtQusi48"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6660615573A;
	Mon, 15 Apr 2024 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206851; cv=none; b=nyR7cBVjW3d/d1kCWhba+hzwhmeV0W1mm4fMjdhJD3JcqZHzZXG314EFyi74jRnr2tahsueb99p1UzDp9ZEHMfXGRniqggpLGYd5JfgLpbqjcsWVzYspxOK32UlYcqoqiGzJjSyKEhQd0VjIq3OH/zQM/oiysP2SO9GQMHge43c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206851; c=relaxed/simple;
	bh=CmCRntxAOyJpEjWjmS3uvE0pVpaC6G3JeaC/Yurx21c=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=R1DAm/ACz5uCbMc6JoltocNSdpaaLSx4xGDJpHm/9+ARaZnzGD4AtplTeB7gQjuP8aADRdrhFQEb971UKyVt6gWQMOPweOABAlPd9FQ0oy3kjsN4XBT8F5ELA78VCHqFjAXhKB9zV2fVStt+omnBAogV0++7pnUVmmik7RnDVI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtQusi48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E782C113CC;
	Mon, 15 Apr 2024 18:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713206850;
	bh=CmCRntxAOyJpEjWjmS3uvE0pVpaC6G3JeaC/Yurx21c=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=EtQusi48nLmMhw2XbEmprdgTdKph9VD4wnAV7GHMIfzg/wH0ymzDIJaUrLKK0v+lI
	 jhw/0XDCtG5Dnf7GnD4QMLOQ9hvcs+e1bnAEk/mzJkKHKyGcEU4hPy+yAorP7WgtFh
	 KXR3Xhf27v+dtQVNLfnB5dx1hIgQBJZB5AnvfjZjaoVcKajvk4eOecJHg/DxMO73Zt
	 cfxF6ucYn5S+Bm3gkA37vSF+YgEILlK6e72ZDjY6wzroe2rnyNDDiRN5kmWrr7f51w
	 nXrjgUefws5ve61WI8SsiapXLSvjzLfJ7QFFQi/4TWjG8lC3wIo4yfRZjyeqhRDZeP
	 fdqQugObSwnaA==
Date: Mon, 15 Apr 2024 13:47:27 -0500
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
Cc: Tom Brautaset <tbrautaset@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, 
 Rafal Milecki <zajec5@gmail.com>, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 linux-arm-kernel@lists.infradead.org, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <20240414-for-soc-asus-rt-ac3200-ac5300-v1-0-118c90bae6e5@arinc9.com>
References: <20240414-for-soc-asus-rt-ac3200-ac5300-v1-0-118c90bae6e5@arinc9.com>
Message-Id: <171320635265.5077.18171651110950488504.robh@kernel.org>
Subject: Re: [PATCH 0/4] Document ASUS RT-AC3200 and ASUS RT-AC5300 and add
 device trees


On Sun, 14 Apr 2024 14:45:59 +0300, Arınç ÜNAL wrote:
> Hello.
> 
> This patch series documents the compatible strings for ASUS RT-AC3200 and
> ASUS RT-AC5300, and adds the device trees for them.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
> Arınç ÜNAL (4):
>       dt-bindings: arm: bcm: add bindings for ASUS RT-AC3200
>       dt-bindings: arm: bcm: add bindings for ASUS RT-AC5300
>       ARM: dts: BCM5301X: Add DT for ASUS RT-AC3200
>       ARM: dts: BCM5301X: Add DT for ASUS RT-AC5300
> 
>  .../devicetree/bindings/arm/bcm/brcm,bcm4708.yaml  |   2 +
>  arch/arm/boot/dts/broadcom/Makefile                |   2 +
>  .../boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts   | 164 ++++++++++++++++++++
>  .../boot/dts/broadcom/bcm47094-asus-rt-ac5300.dts  | 170 +++++++++++++++++++++
>  4 files changed, 338 insertions(+)
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


New warnings running 'make CHECK_DTBS=y broadcom/bcm4709-asus-rt-ac3200.dtb broadcom/bcm47094-asus-rt-ac5300.dtb' for 20240414-for-soc-asus-rt-ac3200-ac5300-v1-0-118c90bae6e5@arinc9.com:

arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb: pcie@12000: 'device_type' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb: pcie@12000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb: pcie@13000: 'device_type' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb: pcie@13000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dtb: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb: pcie@14000: 'device_type' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dtb: pcie@14000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
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






