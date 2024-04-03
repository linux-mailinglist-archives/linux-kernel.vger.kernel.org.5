Return-Path: <linux-kernel+bounces-129931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A2C89722B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C886628AF57
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAEE14A08F;
	Wed,  3 Apr 2024 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEcXgoo7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF2714901C;
	Wed,  3 Apr 2024 14:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153758; cv=none; b=J/0XWHiVY0IcvPi2xrThEkOG+TQkPxjnxVHTLFK9Y6Shcxrn+JYvivqKyr3NzUCRg+3I1Z77hPBILQbXCYlZrvVIiPv98258WMccg67EO3QATyn4oeKjfmvhV6nPahN2VLZJ3knTV7fqNjzxmYgIZX5ha/36I9cc5nwC5aTZmW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153758; c=relaxed/simple;
	bh=nKxO2VchqXJpILlQ48hPBrQldYLcDRBj9v63t6GaFOQ=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ra4oM+Z6xC9q5CqI/WBG9DJi3cp7iOchHGUwQQ5dW1uJlu2OMIbWVRA1nR1+qDZLy7J1r+mzUsV2KhSxYJVv6YG/7Zdf+Ko+blh1AOAfb8uGsT9T296l9TktXQSSm2sOWs68hGzvgGp+bEVCXrPD98f00c7sTy/c0ZqJV0pSNDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEcXgoo7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95758C433C7;
	Wed,  3 Apr 2024 14:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712153757;
	bh=nKxO2VchqXJpILlQ48hPBrQldYLcDRBj9v63t6GaFOQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=bEcXgoo7DUdmA5yzjaN47PmRDvj8mbevDzBz3a8UK7Eau6zpXqfsXevvpf+k0BC2A
	 FnrqhQub7/RYfiz9GJBE74ok/RnzVyQdNYIz2X4sAQZIHj7kZnp+DUDIDG7HPuif6j
	 wB8R3w9rqrMqvgnATv+JQWl259Sp5rQwwVVtUexStL8geBRq4bzZUh5BauiNNEQHTH
	 gn5D1Th+uMBnzl/cdgJ47YqWLpoVjSbX4yTt7RFPzjezjXcGi/UuTgWc92QM7h9M0V
	 0IQx/qWYNFCvbPaGNju78eA7sqENCPP2jhUoZWzKBM4NogVTw9gvCmbkZS0ETJzeYD
	 r+/4bxmHQaIXQ==
Date: Wed, 03 Apr 2024 09:15:56 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Alexander Reimelt <alexander.reimelt@posteo.de>
Cc: conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 robh+dt@kernel.org, andersson@kernel.org, pvorel@suse.cz, 
 linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org
In-Reply-To: <20240403104415.30636-1-alexander.reimelt@posteo.de>
References: <20240403104415.30636-1-alexander.reimelt@posteo.de>
Message-Id: <171215356311.3499103.14484942655821414502.robh@kernel.org>
Subject: Re: [PATCH 0/2] arm64: Add basic support for LG H815


On Wed, 03 Apr 2024 10:43:28 +0000, Alexander Reimelt wrote:
> Hello,
> 
> These patches add initial support for the LG H815.
> They are enough to boot the device on postmarketOS
> and have some basic functionality. Connecting to the
> device over USB networking via ssh, buttons, SD-Card,
> eMMC and regulators work. The dtb_checker shows some
> warnings, but they come from the msm8994.dtsi.
> 
> For CPU bring up lk2nd is required. The DMA controller
> module fails to load and from time to time the SMD clock
> driver fails.
> 
> But I hope to prevent duplicate work and make it more accessible.
> 
> Best regards
> Alex
> 
> Alexander Reimelt (2):
>   dt-bindings: arm: qcom: Add LG G4 (h815)
>   arm64: dts: qcom: Add basic support for LG G4 (H815)
> 
>  .../devicetree/bindings/arm/qcom.yaml         |   1 +
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts  | 422 ++++++++++++++++++
>  3 files changed, 424 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts
> 
> --
> 2.44.0
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


New warnings running 'make CHECK_DTBS=y qcom/msm8992-lg-h815.dtb' for 20240403104415.30636-1-alexander.reimelt@posteo.de:

arch/arm64/boot/dts/qcom/msm8992-lg-h815.dtb: usb@f92f8800: 'interrupt-names' is a required property
	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
arch/arm64/boot/dts/qcom/msm8992-lg-h815.dtb: usb@f92f8800: 'oneOf' conditional failed, one must be fixed:
	'interrupts' is a required property
	'interrupts-extended' is a required property
	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#






