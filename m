Return-Path: <linux-kernel+bounces-156939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8068B0A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02C34B275EF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AF115CD66;
	Wed, 24 Apr 2024 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORTlE1Ye"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C93015B98B;
	Wed, 24 Apr 2024 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964461; cv=none; b=S5zwZLx1H0eXJgn0MYswhk3Z4r5Lq1HFvrFmaRNB3/IEW0oluAoIdJI9y88LAl7zV6Nvmj9VytjFXn9LzxH3dHcMyYC6j7ViqDpCFpyU3uQS5y0qdDrKrT+KaTUBK/Wu13pXT/yCqPy6DylWngySn2xkY8TwZFmv8vjEM/nAuTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964461; c=relaxed/simple;
	bh=nZHbG0wfUOw2pjAGM1BQC+MUTbN5dqrkOpU54Nd4FUg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ldcdWVMyo8eSEOCnjrgJd3CYVNsYVpPKuQ8kAFTTqr+IdtP5Z/vcqa9ysbmcMx/O5JQDxO6MLOt1HlqQW3u1jma93bRE1hi7MlGAUCCYdaYtFTCJhWh0iGmsuRY1sgsWTVQYhI/6VWfGNVj8TAABx2p/RY00OGgl7loa457GjdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORTlE1Ye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EA4C113CE;
	Wed, 24 Apr 2024 13:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713964461;
	bh=nZHbG0wfUOw2pjAGM1BQC+MUTbN5dqrkOpU54Nd4FUg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ORTlE1Ye5jmyLa+PRETfxpDtYkkQ7C3qX5cd2GZTBFu5JFc0hMJBdS3i+/LMVLhfS
	 Z0PEnSDaUBRqo1WR0zslDTfxi53nX6hXihrQXSx1erL1GJ57WHzziepcdO3qxYjeR2
	 igV7pOdZw2T3i2GaadMKl00ugZTYH/lA6Im2blcLoK4RcERalQYpPASfWzf9jp8EbH
	 yLxUIbeMyj0YJM+TPjzN3ABoRvh+dooF6L4NC9hSJZvfIQApm89Y4rEK3PYWU/b4/I
	 FUVTSn0+NriFLtoXs0QmQrJ1k784SYw31I8APoZ/HZxhW9VO37klGicBbW8RGMtrYX
	 lqInvfHhCuVQw==
Date: Wed, 24 Apr 2024 08:14:19 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: conor+dt@kernel.org, rajpat@codeaurora.org, luca.weiss@fairphone.com, 
 andersson@kernel.org, swboyd@chromium.org, devicetree@vger.kernel.org, 
 cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org, 
 quic_anupkulk@quicinc.com, mka@chromium.org, linux-kernel@vger.kernel.org, 
 konrad.dybcio@linaro.org, quic_msavaliy@quicinc.com, krzk+dt@kernel.org, 
 rojay@codeaurora.org
In-Reply-To: <20240424075853.11445-1-quic_vdadhani@quicinc.com>
References: <20240424075853.11445-1-quic_vdadhani@quicinc.com>
Message-Id: <171396420160.3427004.14810050432348630573.robh@kernel.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: Remove CTS/RTS
 configuration


On Wed, 24 Apr 2024 13:28:53 +0530, Viken Dadhaniya wrote:
> For IDP variant, GPIO 20/21 is used by camera use case and camera
> driver is not able acquire these GPIOs as it is acquired by UART5
> driver as RTS/CTS pin.
> 
> UART5 is designed for debug UART for all the board variants of the
> sc7280 chipset and RTS/CTS configuration is not required for debug
> uart usecase.
> 
> Remove CTS/RTS configuration for UART5 instance and change compatible
> string to debug UART.
> 
> Remove overwriting compatible property from individual target specific
> file as it is not required.
> 
> Fixes: 38cd93f413fd ("arm64: dts: qcom: sc7280: Update QUPv3 UART5 DT node")
> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> 
> ---
> v1 -> v2:
> - Remove compatible property from target specific file.
> - Update commit log.
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts |  1 -
>  arch/arm64/boot/dts/qcom/qcm6490-idp.dts           |  1 -
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       |  1 -
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           |  1 -
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi         |  1 -
>  arch/arm64/boot/dts/qcom/sc7280.dtsi               | 14 ++------------
>  6 files changed, 2 insertions(+), 17 deletions(-)
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


New warnings running 'make CHECK_DTBS=y qcom/qcm6490-fairphone-fp5.dtb qcom/qcm6490-idp.dtb qcom/qcs6490-rb3gen2.dtb' for 20240424075853.11445-1-quic_vdadhani@quicinc.com:

arch/arm64/boot/dts/qcom/qcm6490-idp.dtb: usb@8cf8800: interrupt-names: ['pwr_event', 'hs_phy_irq', 'dp_hs_phy_irq', 'dm_hs_phy_irq'] is too short
	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#






