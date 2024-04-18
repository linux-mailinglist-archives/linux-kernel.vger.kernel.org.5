Return-Path: <linux-kernel+bounces-149823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C008A9656
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E161C21B95
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F38115B10E;
	Thu, 18 Apr 2024 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qzhdWhRS"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0420A15ADB7;
	Thu, 18 Apr 2024 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433074; cv=none; b=OEvYlTt00ZOx7w7Rzd3iV0J/OJ46aVMg0yM6fC5D52lwT/hhKjriu+kz4GUq2OPk9YQiDWvbwGnMM9RwmEzcfPJZ+mK5A01tr66d1dEAv3ISUbcUyqsebOo1sBZP22clZDuyjQ0Vnt7VOKpy01UZquE3XUOL5K5Vn8Dh+aG4wXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433074; c=relaxed/simple;
	bh=xTTRylhxTMNxuBPyF0ZhqgtTHDOevThfPc3RUW/tG/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HSyVLGyHK6QDsjYsF9QOWHt+CfdeAb1YWq82nSdQdmISKIAQzQ9bdkvVv1I45yJK1uJumEqyQRbr15MLu99hJaeeZ+spTkWKPQ2qXpyY5VqfhQSPGdYeGN78xiosFAfte0R24OKRCMcQw9lSjzaID5cypQ/A3owmmdo7E/b4Vxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qzhdWhRS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713433071;
	bh=xTTRylhxTMNxuBPyF0ZhqgtTHDOevThfPc3RUW/tG/c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qzhdWhRSZDUQAR3tcksUDkxqnZpVvM6wSVUDbGme+YCwaZ6VCN6zVZCwj4V82tqTF
	 SGtlShSYstZUYS6Hm7D+qpZT8L0IOFgbR7EYbqi75tbyHpg/VwjmUO8LdkT5WI1lEy
	 Cguc92jAtUWBprkFt7MpVm3RLHbc5elQ3cn5TV6G9FADJw4mV/E9CeeAxuIYikY17V
	 eT7ya0NbDgfsm2JDBvqqfQbUFf/c+KnVitUuAAGJyVIohYZli06fFcALDWyT4Iv9Xd
	 7Zve4oKydMyuemER0dwuub0KPc873KsZjt+SfIh8h5kp95S2G8in9vhLbZO6cY5Pbm
	 hJN6qqUkgC5jA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8A90737813E3;
	Thu, 18 Apr 2024 09:37:49 +0000 (UTC)
Message-ID: <8e572021-f872-48c7-bebb-e33e7ed7acf1@collabora.com>
Date: Thu, 18 Apr 2024 11:37:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] dt-bindings: soc: mediatek: Add DVFSRC bindings
 for MT8183 and MT8195
To: Rob Herring <robh@kernel.org>
Cc: henryc.chen@mediatek.com, krzysztof.kozlowski+dt@linaro.org,
 wenst@chromium.org, gustavoars@kernel.org, devicetree@vger.kernel.org,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 conor+dt@kernel.org, kernel@collabora.com, amergnat@baylibre.com,
 linux-pm@vger.kernel.org, keescook@chromium.org,
 linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
 djakov@kernel.org, broonie@kernel.org, linux-kernel@vger.kernel.org
References: <20240418082812.152270-1-angelogioacchino.delregno@collabora.com>
 <20240418082812.152270-4-angelogioacchino.delregno@collabora.com>
 <171343301130.424721.10758711321868587171.robh@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <171343301130.424721.10758711321868587171.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/04/24 11:36, Rob Herring ha scritto:
> 
> On Thu, 18 Apr 2024 10:28:08 +0200, AngeloGioacchino Del Regno wrote:
>> Add bindings for the MediaTek Dynamic Voltage and Frequency Scaling
>> Resource Collector (DVFSRC), a hardware module used to collect all the
>> requests from both software and the various remote processors embedded
>> into the SoC and decide about a minimum operating voltage and a minimum
>> DRAM frequency to fulfill those requests in an effort to provide the
>> best achievable performance per watt.
>>
>> This hardware IP is capable of transparently performing direct register
>> R/W on all of the DVFSRC-controlled regulators and SoC bandwidth knobs.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../soc/mediatek/mediatek,mt8183-dvfsrc.yaml  | 94 +++++++++++++++++++
>>   1 file changed, 94 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.example.dtb: system-controller@10012000: regulators@0: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/soc/mediatek/mediatek,mt8183-dvfsrc.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.example.dtb: system-controller@10012000: interconnect@1: Unevaluated properties are not allowed ('reg' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/soc/mediatek/mediatek,mt8183-dvfsrc.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.example.dtb: regulators@0: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6873-dvfsrc-regulator.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.example.dtb: interconnect@1: Unevaluated properties are not allowed ('reg' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/interconnect/mediatek,mt8183-emi.yaml#
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240418082812.152270-4-angelogioacchino.delregno@collabora.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

Whoops. Forgot to update this one. Sending v4.


