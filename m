Return-Path: <linux-kernel+bounces-126853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D828940F7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C88283468
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D72481D1;
	Mon,  1 Apr 2024 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPKIna4O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9300238DD8;
	Mon,  1 Apr 2024 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989375; cv=none; b=selG8RkBbesRdaSeTmGQ62nHOQtYgKth6rih5K7nqHj1O132KkgdLMDZRmf8hLk7C7NCYiwuRudjFMDA78xype5OLmEuODDnZeyGsjhQWja951FYWfRwyUj2/eThy1wSFzwZ5Hz4exRcZGyFr+mqFkGdiCHx0JM2/FKEhu3o3B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989375; c=relaxed/simple;
	bh=HXLVHGH/TOLiue7tP0Zr/Bd2VZAc8udCE64cFWNoa9c=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ndowx6DHDd1iSJqEATh9YB2c1ersxkNFdboN7po+VuR4Db7vMe0aM0aME4ztqcy5VqvvAySE8kfdhD9HkoTBcbLKB/lo6cT1z321TCah6PcqC7pQnC9aawJKs+nZ4exMXAe/vIh244V1alFbz/keik2dXdhcDH9cScSWHubt7Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPKIna4O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7B9C43390;
	Mon,  1 Apr 2024 16:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711989374;
	bh=HXLVHGH/TOLiue7tP0Zr/Bd2VZAc8udCE64cFWNoa9c=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=YPKIna4OjgnRmmdfg4JufsVx4aK8UZ0/BIBbImkXrFC6YZd3TWk3qDb9aMmuSN7UH
	 GgZgLYaNXuWZgckJ5SV1EOpxdNpiJ3XdXjVOJt6E72j42G+bm3m5sePybgN9z2yGou
	 oFEw3TKex1CjphyOs+gYPWcFs6m+WxoUcXehgiZi5W2JyfBTQra3qgFdSiw3RlsIqC
	 +z0liGXrS8IsPgLXgLjo/9rcSXXj0jdZawdfOwCwK5sw+TT4VLDDrGW/Yihn5/fzgr
	 jKmNplbECvHAz4jOkanHGTVaBjNV5L0fKQlz6XwzISkwEOsyLNvt/KVcPrxdSR6zPB
	 03DoYmNb2JcMQ==
Date: Mon, 01 Apr 2024 11:36:13 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, Conor Dooley <conor+dt@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240331-typec-fix-sm8250-v2-0-857acb6bd88e@linaro.org>
References: <20240331-typec-fix-sm8250-v2-0-857acb6bd88e@linaro.org>
Message-Id: <171198916314.1093638.15006189720750656914.robh@kernel.org>
Subject: Re: [PATCH v2 0/7] arm64: dts: qcom: fix description of the Type-C
 signals


On Sun, 31 Mar 2024 06:48:50 +0300, Dmitry Baryshkov wrote:
> Rename the HS link between usb-c-connector and the DWC3 USB controller.
> Add missing graph connection between the QMP PHY and DWC3 USB
> controller.
> 
> Reported-by: Luca Weiss <luca.weiss@fairphone.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Changes in v2:
> - Fixed other platforms in addition to sm8250 (Bryan)
> - Link to v1: https://lore.kernel.org/r/20240322-typec-fix-sm8250-v1-0-1ac22b333ea9@linaro.org
> 
> ---
> Dmitry Baryshkov (7):
>       arm64: dts: qcom: sm8250: describe HS signals properly
>       arm64: dts: qcom: sm8250: add a link between DWC3 and QMP PHY
>       arm64: dts: qcom: sc8180x: switch USB+DP QMP PHYs to new bindings
>       arm64: dts: qcom: sc8180x: describe USB signals properly
>       arm64: dts: qcom: sc8280xp: describe USB signals properly
>       arm64: dts: qcom: x1e80100: describe USB signals properly
>       arm64: dts: qcom: sm8150-hdk: rename Type-C HS endpoints
> 
>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts           |   8 +-
>  .../arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts |  16 +-
>  arch/arm64/boot/dts/qcom/sc8180x-primus.dts        |  20 +--
>  arch/arm64/boot/dts/qcom/sc8180x.dtsi              | 164 ++++++++++-----------
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts          |  20 +--
>  .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     |  20 +--
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi             |  54 ++++++-
>  arch/arm64/boot/dts/qcom/sm8150-hdk.dts            |   4 +-
>  .../boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi  |   8 +-
>  arch/arm64/boot/dts/qcom/sm8250.dtsi               |  24 ++-
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 149 ++++++++++++++++++-
>  11 files changed, 340 insertions(+), 147 deletions(-)
> ---
> base-commit: 13ee4a7161b6fd938aef6688ff43b163f6d83e37
> change-id: 20240322-typec-fix-sm8250-33c47a03a056
> 
> Best regards,
> --
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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


New warnings running 'make CHECK_DTBS=y qcom/qrb5165-rb5.dtb qcom/sc8180x-lenovo-flex-5g.dtb qcom/sc8180x-primus.dtb qcom/sc8280xp-crd.dtb qcom/sc8280xp-lenovo-thinkpad-x13s.dtb qcom/sm8150-hdk.dtb' for 20240331-typec-fix-sm8250-v2-0-857acb6bd88e@linaro.org:

arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dtb: clock-controller@af00000: clocks: [[41, 0], [42], [95, 1], [95, 2], [99, 1], [99, 2], [125, 0], [125, 1]] is too long
	from schema $id: http://devicetree.org/schemas/clock/qcom,dispcc-sm8x50.yaml#
arch/arm64/boot/dts/qcom/sc8180x-primus.dtb: clock-controller@af00000: clocks: [[41, 0], [42], [97, 1], [97, 2], [101, 1], [101, 2], [127, 0], [127, 1]] is too long
	from schema $id: http://devicetree.org/schemas/clock/qcom,dispcc-sm8x50.yaml#






