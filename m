Return-Path: <linux-kernel+bounces-158404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE2F8B1F54
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB9B1C21B28
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23EA208A8;
	Thu, 25 Apr 2024 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2H7/B80"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3612D1CD23;
	Thu, 25 Apr 2024 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714041498; cv=none; b=uuO8m6thXNw228GO/OxiuJ5DZMl0ywLlw9A3xPWkquNrwKZUG3LWK4qvk5kmor0DoC8S4dadRh4dujRA89RVoYqidX7QlfEoykApWh1MuOOIyTtixtosP6G2znMLY9wSwLqEyYg9oCHwlA6wqigxtZ+DJ/QJs9+sbA1wC0q1oow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714041498; c=relaxed/simple;
	bh=s0flc0O0ENfWyvDrw9EUrpvhWQMG2H4AQk5/xSXi9Dw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=SDRQ0uvpBoMq+S84ETHGNz1wwmNQvaVglf+EoqB8cu1gwKbAvj8AFulIRXo0FcyxUjqt+7vc4Yytl/hIYA31HK4/M8Y8QmF6JKwNNp1nrZyj/1cTM1r5uQYFrTX9EJ8NW1pKv4gwvSMMqrf8YmI68GmwoFgAEQFA+ciVGqQaTMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2H7/B80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0076C113CE;
	Thu, 25 Apr 2024 10:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714041497;
	bh=s0flc0O0ENfWyvDrw9EUrpvhWQMG2H4AQk5/xSXi9Dw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=r2H7/B80LbmXbUwobGpFjbK/uHkJiSDy7N0XJdAWDAh4l8mZuGdqrQpJtcKT+kdQ7
	 AiE9BX2JqCRSz+9ordjnrN8awj/1lEX7HEiw+n9iCzvADATTwFzNZG8tW1+monKTlS
	 tr6fM7SSkZslpGTsr6n6EEF8FQzwqW1s2vmjwJXqgnxOUZP9zBi90O3yTEPnRvMNYu
	 Oj9Hq3kr2Rtu5gA+ldv7kBzGbzzzD8FIAYbVf+XBnALVK7MCQWAdNYraNC8NkXlcz2
	 4gKHq49/OyhhDb2vXe/4F1ZhQTIXPSvM2hQ/KigtwnxDobf0QNMWpOtsCd8WXFnKqc
	 237EvN37jx1EA==
Date: Thu, 25 Apr 2024 05:38:16 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Cc: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org, 
 Banajit Goswami <bgoswami@quicinc.com>, quic_pkumpatl@quicinc.com, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 alsa-devel@alsa-project.org, Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240425091857.2161088-2-quic_mohs@quicinc.com>
References: <20240425091857.2161088-1-quic_mohs@quicinc.com>
 <20240425091857.2161088-2-quic_mohs@quicinc.com>
Message-Id: <171404149555.2167007.16345461403970586923.robh@kernel.org>
Subject: Re: [PATCH v3 1/7] ASoC: dt-bindings: document wcd937x Audio Codec


On Thu, 25 Apr 2024 14:48:51 +0530, Mohammad Rafi Shaik wrote:
> From: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
> 
> Document the Qualcomm WCD9370/WCD9375 Audio Codec and the soundwire
> devices can be found on Qualcomm QCM6490 based platforms.
> 
> The Qualcomm WCD9370/WCD9375 Audio Codec communicates
> with the host SoC over 2 Soundwire links to provide:
> - 3 TX ADC paths with 4 differential AMIC inputs
> - 6 DMIC inputs that are shared with AMIC input
> - 4 Microphone BIAS
> - RX paths with 4 PAs – HPHL/R, EAR and AUX
> - Stereo Headphone output
> - MBHC engine for Headset Detection
> 
> Co-developed-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
> ---
>  .../bindings/sound/qcom,wcd937x-sdw.yaml      | 78 +++++++++++++++++++
>  .../bindings/sound/qcom,wcd937x.yaml          | 58 ++++++++++++++
>  2 files changed, 136 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd937x.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
/Documentation/devicetree/bindings/sound/qcom,wcd937x.yaml:30:11: [warning] wrong indentation: expected 4 but found 10 (indentation)
/Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml:34:13: [warning] wrong indentation: expected 6 but found 12 (indentation)
/Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml:34:17: [warning] too many spaces before colon (colons)
/Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml:46:13: [warning] wrong indentation: expected 6 but found 12 (indentation)
/Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml:46:17: [warning] too many spaces before colon (colons)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/qcom,wcd937x.example.dtb: codec: compatible:0: 'sdw20217010a00' was expected
	from schema $id: http://devicetree.org/schemas/sound/qcom,wcd937x.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/qcom,wcd937x.example.dtb: codec: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/sound/qcom,wcd937x.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/qcom,wcd937x.example.dtb: codec: '#sound-dai-cells', 'qcom,micbias1-microvolt', 'qcom,micbias2-microvolt', 'qcom,micbias3-microvolt', 'qcom,micbias4-microvolt', 'qcom,rx-device', 'qcom,tx-device', 'reset-gpios', 'vdd-buck-supply', 'vdd-mic-bias-supply', 'vdd-px-supply', 'vdd-rxtx-supply' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/qcom,wcd937x.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240425091857.2161088-2-quic_mohs@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


