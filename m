Return-Path: <linux-kernel+bounces-98951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCA9878188
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7CDF2856A8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B789C4087A;
	Mon, 11 Mar 2024 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDjt/wS2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3ED405FC;
	Mon, 11 Mar 2024 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167015; cv=none; b=UZxmS6eH5sRPpByORz/LF8+rtTuhQcmUful/EGPuNLn+3Ht34QVSBcI99QGLhpfcutZnoKmVhNjHnOux5L0TkFNS/l2071EV7VcMvthnF7ZElL3tvB4EAFrmIftzEm47c5P0vsgBYgtG1gnLW0SRWEHbev903BEnbdok2XYuekM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167015; c=relaxed/simple;
	bh=zZBpdnMwKO+ducjzdb8dSYuF7wHQwCMGtg62sh1n6Fs=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=qlqbsIeSQ38cI8sQjlWeGbsQmPsK9I1abOZHyulCWZ1fG3hIbeAcgeOKGU915IeghIlY85R4KIhn1NrTjgsKpAUok2p+wmNgH5ay7jammcnRkNsG+GmExYk0BOfu+Zi/p30i/vr8pSoo+Tq3ttz+IP+HQi5eJzNG6uUVXkVi3e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDjt/wS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A48FC433C7;
	Mon, 11 Mar 2024 14:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710167014;
	bh=zZBpdnMwKO+ducjzdb8dSYuF7wHQwCMGtg62sh1n6Fs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=MDjt/wS2VLgkLpybu49B4ZLz6HTBlKbEZzneDE/qq66JAYnJ4jJlOc4BS4NA1ASYS
	 tvzNwUquYsUd5SKSzCHI5+hV4m3OILYTQTs7o0sE73VSIuZP3ZrFYwUx8xkm5XSQBo
	 5fddKwsVxIrEoVZ8dTKpihGy/elfXb6RJVw3QpMGkJ8oAjY7XCBNlGpJ4UlPtHXP5j
	 nRPDf58ZIy2pU2eYW7Yb8msn5/80tDj1MaP1aeXT2ROVtgKWx25Y0VXFzEBmTRowbX
	 +R0ByacXJiI8fPdzQKHR6VT1THU/UMuKwm7p7E9/9h2TvB6Etgtwr3W9AQb0oaSKm8
	 tPy5Pm6sVCy2A==
Date: Mon, 11 Mar 2024 08:23:33 -0600
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
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
 linux-arm-msm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240311120859.18489-1-quic_kbajaj@quicinc.com>
References: <20240311120859.18489-1-quic_kbajaj@quicinc.com>
Message-Id: <171016679140.1126674.15590921794307431381.robh@kernel.org>
Subject: Re: [PATCH 0/3] Add devicetree support of USB for QDU/QRU1000


On Mon, 11 Mar 2024 17:38:56 +0530, Komal Bajaj wrote:
> This series adds devicetree nodes to support interconnects and usb for qdu/qru1000.
> This is based on previously sent driver series[1].
> [1]
> https://lore.kernel.org/linux-arm-msm/20240311120215.16845-1-quic_kbajaj@quicinc.com/
> 
> Komal Bajaj (3):
>   arm64: dts: qcom: qdu1000: Add USB3 and PHY support
>   arm64: dts: qcom: qdu1000-idp: enable USB nodes
>   arm64: dts: qcom: qru1000-idp: enable USB nodes
> 
>  arch/arm64/boot/dts/qcom/qdu1000-idp.dts |  24 +++++
>  arch/arm64/boot/dts/qcom/qdu1000.dtsi    | 119 +++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/qru1000-idp.dts |  24 +++++
>  3 files changed, 167 insertions(+)
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


New warnings running 'make CHECK_DTBS=y qcom/qdu1000-idp.dtb qcom/qru1000-idp.dtb' for 20240311120859.18489-1-quic_kbajaj@quicinc.com:

arch/arm64/boot/dts/qcom/qru1000-idp.dtb: phy@88e3000: compatible: 'oneOf' conditional failed, one must be fixed:
	['qcom,qdu1000-usb-hs-phy', 'qcom,usb-snps-hs-7nm-phy'] is too long
	'qcom,qdu1000-usb-hs-phy' is not one of ['qcom,sc8180x-usb-hs-phy', 'qcom,usb-snps-femto-v2-phy']
	'qcom,qdu1000-usb-hs-phy' is not one of ['qcom,sa8775p-usb-hs-phy', 'qcom,sc8280xp-usb-hs-phy']
	'qcom,qdu1000-usb-hs-phy' is not one of ['qcom,sc7280-usb-hs-phy', 'qcom,sdx55-usb-hs-phy', 'qcom,sdx65-usb-hs-phy', 'qcom,sm6375-usb-hs-phy', 'qcom,sm8150-usb-hs-phy', 'qcom,sm8250-usb-hs-phy', 'qcom,sm8350-usb-hs-phy', 'qcom,sm8450-usb-hs-phy']
	'qcom,usb-snps-hs-5nm-phy' was expected
	from schema $id: http://devicetree.org/schemas/phy/qcom,usb-snps-femto-v2.yaml#
arch/arm64/boot/dts/qcom/qdu1000-idp.dtb: phy@88e3000: compatible: 'oneOf' conditional failed, one must be fixed:
	['qcom,qdu1000-usb-hs-phy', 'qcom,usb-snps-hs-7nm-phy'] is too long
	'qcom,qdu1000-usb-hs-phy' is not one of ['qcom,sc8180x-usb-hs-phy', 'qcom,usb-snps-femto-v2-phy']
	'qcom,qdu1000-usb-hs-phy' is not one of ['qcom,sa8775p-usb-hs-phy', 'qcom,sc8280xp-usb-hs-phy']
	'qcom,qdu1000-usb-hs-phy' is not one of ['qcom,sc7280-usb-hs-phy', 'qcom,sdx55-usb-hs-phy', 'qcom,sdx65-usb-hs-phy', 'qcom,sm6375-usb-hs-phy', 'qcom,sm8150-usb-hs-phy', 'qcom,sm8250-usb-hs-phy', 'qcom,sm8350-usb-hs-phy', 'qcom,sm8450-usb-hs-phy']
	'qcom,usb-snps-hs-5nm-phy' was expected
	from schema $id: http://devicetree.org/schemas/phy/qcom,usb-snps-femto-v2.yaml#
arch/arm64/boot/dts/qcom/qru1000-idp.dtb: /soc@0/phy@88e3000: failed to match any schema with compatible: ['qcom,qdu1000-usb-hs-phy', 'qcom,usb-snps-hs-7nm-phy']
arch/arm64/boot/dts/qcom/qdu1000-idp.dtb: /soc@0/phy@88e3000: failed to match any schema with compatible: ['qcom,qdu1000-usb-hs-phy', 'qcom,usb-snps-hs-7nm-phy']
arch/arm64/boot/dts/qcom/qru1000-idp.dtb: /soc@0/phy-wrapper@88e5000: failed to match any schema with compatible: ['qcom,qdu1000-qmp-usb3-uni-phy']
arch/arm64/boot/dts/qcom/qdu1000-idp.dtb: /soc@0/phy-wrapper@88e5000: failed to match any schema with compatible: ['qcom,qdu1000-qmp-usb3-uni-phy']
arch/arm64/boot/dts/qcom/qru1000-idp.dtb: usb@a6f8800: compatible:0: 'qcom,qdu1000-dwc3' is not one of ['qcom,ipq4019-dwc3', 'qcom,ipq5018-dwc3', 'qcom,ipq5332-dwc3', 'qcom,ipq6018-dwc3', 'qcom,ipq8064-dwc3', 'qcom,ipq8074-dwc3', 'qcom,ipq9574-dwc3', 'qcom,msm8953-dwc3', 'qcom,msm8994-dwc3', 'qcom,msm8996-dwc3', 'qcom,msm8998-dwc3', 'qcom,qcm2290-dwc3', 'qcom,qcs404-dwc3', 'qcom,sa8775p-dwc3', 'qcom,sc7180-dwc3', 'qcom,sc7280-dwc3', 'qcom,sc8280xp-dwc3', 'qcom,sdm660-dwc3', 'qcom,sdm670-dwc3', 'qcom,sdm845-dwc3', 'qcom,sdx55-dwc3', 'qcom,sdx65-dwc3', 'qcom,sdx75-dwc3', 'qcom,sm4250-dwc3', 'qcom,sm6115-dwc3', 'qcom,sm6125-dwc3', 'qcom,sm6350-dwc3', 'qcom,sm6375-dwc3', 'qcom,sm8150-dwc3', 'qcom,sm8250-dwc3', 'qcom,sm8350-dwc3', 'qcom,sm8450-dwc3', 'qcom,sm8550-dwc3', 'qcom,sm8650-dwc3', 'qcom,x1e80100-dwc3']
	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
arch/arm64/boot/dts/qcom/qru1000-idp.dtb: /soc@0/usb@a6f8800: failed to match any schema with compatible: ['qcom,qdu1000-dwc3', 'qcom,dwc3']
arch/arm64/boot/dts/qcom/qdu1000-idp.dtb: usb@a6f8800: compatible:0: 'qcom,qdu1000-dwc3' is not one of ['qcom,ipq4019-dwc3', 'qcom,ipq5018-dwc3', 'qcom,ipq5332-dwc3', 'qcom,ipq6018-dwc3', 'qcom,ipq8064-dwc3', 'qcom,ipq8074-dwc3', 'qcom,ipq9574-dwc3', 'qcom,msm8953-dwc3', 'qcom,msm8994-dwc3', 'qcom,msm8996-dwc3', 'qcom,msm8998-dwc3', 'qcom,qcm2290-dwc3', 'qcom,qcs404-dwc3', 'qcom,sa8775p-dwc3', 'qcom,sc7180-dwc3', 'qcom,sc7280-dwc3', 'qcom,sc8280xp-dwc3', 'qcom,sdm660-dwc3', 'qcom,sdm670-dwc3', 'qcom,sdm845-dwc3', 'qcom,sdx55-dwc3', 'qcom,sdx65-dwc3', 'qcom,sdx75-dwc3', 'qcom,sm4250-dwc3', 'qcom,sm6115-dwc3', 'qcom,sm6125-dwc3', 'qcom,sm6350-dwc3', 'qcom,sm6375-dwc3', 'qcom,sm8150-dwc3', 'qcom,sm8250-dwc3', 'qcom,sm8350-dwc3', 'qcom,sm8450-dwc3', 'qcom,sm8550-dwc3', 'qcom,sm8650-dwc3', 'qcom,x1e80100-dwc3']
	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
arch/arm64/boot/dts/qcom/qdu1000-idp.dtb: /soc@0/usb@a6f8800: failed to match any schema with compatible: ['qcom,qdu1000-dwc3', 'qcom,dwc3']






