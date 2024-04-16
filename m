Return-Path: <linux-kernel+bounces-146449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DBF8A6571
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C1D1F22E1B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D591184FD4;
	Tue, 16 Apr 2024 07:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pa53K9ZC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7B47FBC4;
	Tue, 16 Apr 2024 07:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713253906; cv=none; b=qvl4POpwyINDQJjum4qrnUQ0IwUvFdHl1atCTjsrpJrZEVhoBStHZGcQKM2kbyDHtloQghmeQ8WpNxh0WgyuDVoRTfquvIZiNNiH9Njf/uWfqZyX4Bnf6oG4RhvBMRzmFxWeB0FpIph/Os3KVrGGc0B5tFS76V54TsI/IbaMync=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713253906; c=relaxed/simple;
	bh=a19vA6wI20HdT0Dr8/OmeBGoDRFOQGDMAe/IdzCQ1Wc=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=KZYialFxQmYAh6tvaydX1bRgZdHe4ckHTZpyjS8BY+6B6OiDm88dee+E5PTuGZdnZa6iMRYWWwOSSHT4Xztra92JzAle3BxeL1yaxKmsQLmcOI2EhuIyDd/h+bcuYpNI49DiEf7p17YrOUZ1O7qrUKDeL9S4qseIRc8cejnUjpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pa53K9ZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4C2C113CE;
	Tue, 16 Apr 2024 07:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713253905;
	bh=a19vA6wI20HdT0Dr8/OmeBGoDRFOQGDMAe/IdzCQ1Wc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=pa53K9ZChmBVU8nR3+qp6d91nC5m2nR2Wl5sSGi2QJSsJEbusQo7tijjpUG3wJgaS
	 WKM2nloIaEmglewwgemiEGrjgtolzRKdyM40iGqJU4yE/cm+Ojm3wH6dbzNNM8/7kf
	 HYQwdmV10GXXuOFOdF7ioPoCHVo30ecS4OJml2NAti5DmPcIX3t7JD6GK56nYvHEWh
	 WN5xb2om9+P8wewmRP4xLuQgr4gFAU5tHqVuBy08NWf+ma9Qo4sDLds8KjAFpIeNhx
	 i7XUyD6aKilDLyUAxjJC+vNPbjrDHU1xYLiADrwzfAZk7eBf9G8L0mGVuN6JPRoUcS
	 qWqDj6DLvyEIA==
Date: Tue, 16 Apr 2024 02:51:44 -0500
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
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org, 
 Jaroslav Kysela <perex@perex.cz>, quic_pkumpatl@quicinc.com, 
 Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org, 
 Banajit Goswami <bgoswami@quicinc.com>, devicetree@vger.kernel.org, 
 quic_rohkumar@quicinc.com, Mark Brown <broonie@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, alsa-devel@alsa-project.org
In-Reply-To: <20240416063600.309747-4-quic_mohs@quicinc.com>
References: <20240416063600.309747-1-quic_mohs@quicinc.com>
 <20240416063600.309747-4-quic_mohs@quicinc.com>
Message-Id: <171325390367.1353462.6738496215058640142.robh@kernel.org>
Subject: Re: [PATCH v2 3/8] ASoC: dt-bindings: wcd937x-sdw: add bindings
 for wcd937x-sdw


On Tue, 16 Apr 2024 12:05:55 +0530, Mohammad Rafi Shaik wrote:
> From: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
> 
> Qualcomm WCD9370/WCD9375 Codec is a standalone Hi-Fi audio codec IC
> connected over SoundWire. This device has two SoundWire devices RX and
> TX respectively.
> This binding is for those slave devices on WCD9370/WCD9375.
> 
> Co-developed-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
> ---
>  .../bindings/sound/qcom,wcd937x-sdw.yaml      | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/qcom,wcd937x.example.dtb: codec@0,4: 'qcom,port-mapping' is a required property
	from schema $id: http://devicetree.org/schemas/sound/qcom,wcd937x-sdw.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/qcom,wcd937x.example.dtb: codec@0,3: 'qcom,port-mapping' is a required property
	from schema $id: http://devicetree.org/schemas/sound/qcom,wcd937x-sdw.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.example.dtb: codec@0,4: 'qcom,port-mapping' is a required property
	from schema $id: http://devicetree.org/schemas/sound/qcom,wcd937x-sdw.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.example.dtb: codec@0,3: 'qcom,port-mapping' is a required property
	from schema $id: http://devicetree.org/schemas/sound/qcom,wcd937x-sdw.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240416063600.309747-4-quic_mohs@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


