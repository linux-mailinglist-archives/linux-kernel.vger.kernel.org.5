Return-Path: <linux-kernel+bounces-83338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4308693FA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D67E7B2E917
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDE7145B18;
	Tue, 27 Feb 2024 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZCIrCrW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99689145B01;
	Tue, 27 Feb 2024 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041502; cv=none; b=j83Cqcdpdz2wnOxMT4VwfM5RCHexUlxKct9vMiWjhpbvSUNUxosIm+d1mMmhUjDxFV8NdFsnXRf8FnvZG8VhJCR31huVosPQ6nMybNjWFPGaddOklgkzpVxtqsU4F/xspIx4BKdt5SIZNe9z9qAw5nwfbqoNuw6QMlL05PHbk5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041502; c=relaxed/simple;
	bh=fY4V1maCK/MPIaxpzKNHKm+ZLgx9DkZoMGNHYVgy8+M=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=OXaC0xjZlVlE6Jtqu2NfKS+DDtLTUU3zUGIGo6Z8XUQLVTbZE8+pt2EnutUmB6ZGA/MILJ8tGp7F7y7eGF8HjzcSIk8bqQTSYIr+bWD8tXLPVO+PDWQD/Q1xExc3dLVxcHIhs9i11e4tD0EIXoey79gjm1tHfHGdFUfW1Ujkdvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZCIrCrW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3585CC43390;
	Tue, 27 Feb 2024 13:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709041502;
	bh=fY4V1maCK/MPIaxpzKNHKm+ZLgx9DkZoMGNHYVgy8+M=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=KZCIrCrWY1Nij+wMlSoOE5A6XFfl3k+ZHEn8r6eLag5tAGj84zSivhRCDyoFozP2R
	 d1u3nt3zSkpDFd8dr/itnT4HLa1iaoATs0sEuEV11X+kU2HrTCNuw1bPSY+qwg7UXQ
	 AL0wUfs7F+mj5mBwqjDtu6vRZvoX9cRQbbfSI8gmQlrVIaOVLJ4jEHtCNp/KKQ1sZj
	 aAto4nKUcMvb31XgxJTyOdJpxPv/UfjIHXUb+ZMqaU0DKomYxvxPf4jL7hkQRNa6Ry
	 YjdW9v9ArxbcQPLxzgZZFSV+HCJHoI1oATdhFdmzlGmmDIDFXB6ZsOQosMmPrqwB8y
	 09v9cgcizhLRw==
Date: Tue, 27 Feb 2024 07:45:01 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>
In-Reply-To: <20240226-archer-ax55-v1-v2-0-3776eb61f432@gmail.com>
References: <20240226-archer-ax55-v1-v2-0-3776eb61f432@gmail.com>
Message-Id: <170904127322.3703788.10984942827471381721.robh@kernel.org>
Subject: Re: [PATCH v2 0/2] arm64: add minimal boot support for TP-Link
 Archer AX55 v1


On Mon, 26 Feb 2024 18:12:38 +0100, Gabor Juhos wrote:
> The purpose of this series to add minimal boot support for the
> TP-Link Archer AX55 v1 dual-band wireless router.
> 
> There are two patches:
>   - the first one adds the compatible for the board into the dt-bindings
>     documentation,
>   - the second patch introduces a minimal device tree source which can be
>     used for booting initramfs images
> 
> ---
> Changes in v2:
>   - reorder pin configuration properties in patch 2/2
>   - add 'Acked-by' tag to patch 1/2
>   - Link to v1: https://lore.kernel.org/r/20240223-archer-ax55-v1-v1-0-99f8fa2c3858@gmail.com
> 
> ---
> Gabor Juhos (2):
>       dt-bindings: arm: qcom: add TP-Link Archer AX55 v1
>       arm64: dts: qcom: add TP-Link Archer AX55 v1
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml    |   1 +
>  arch/arm64/boot/dts/qcom/Makefile                  |   1 +
>  .../dts/qcom/ipq5018-tplink-archer-ax55-v1.dts     | 133 +++++++++++++++++++++
>  3 files changed, 135 insertions(+)
> ---
> base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
> change-id: 20240221-archer-ax55-v1-73ed91a97c6e
> 
> Best regards,
> --
> Gabor Juhos <j4g8y7@gmail.com>
> 
> 
> 


My bot found new DT warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y qcom/ipq5018-tplink-archer-ax55-v1.dtb' for 20240226-archer-ax55-v1-v2-0-3776eb61f432@gmail.com:

arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupts: [[0, 62, 4]] is too short
	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupt-names: ['hs_phy_irq'] is too short
	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupts: [[0, 62, 4]] is too short
	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupt-names:0: 'pwr_event' was expected
	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupt-names: ['hs_phy_irq'] is too short
	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#






