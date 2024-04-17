Return-Path: <linux-kernel+bounces-148864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A5E8A884B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F87FB263C4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7403D14882C;
	Wed, 17 Apr 2024 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JT93LwK4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B77147C9F;
	Wed, 17 Apr 2024 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369397; cv=none; b=KKufrYpXLLftDAX17oKVV/ks7Wd4vRq1CpxwCUyiqP1AnCSadN2esb68+cx2eotMsz7R/kiLeuDiABOj8PbOmWJge9KjbuxWwrEQo6IsCdQdOjKY+NbiVYr3re06uE4CwQ1MNyroFXd0AwdVMttyGig9LfU4ourvMIBpm4TJlpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369397; c=relaxed/simple;
	bh=vNcaPBrZO+ppAKRbORNz0nJqGNldg2Yat0x53LVhO6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TwZ0+ssa+9i90FFiblevi9ggtbkfdu31btjHmoZV+y9ZzG7z5n2itE7CLO0pApnMHLTL+ZWzSpVXrFpuE9FTm6fs5h+yb/SmUBCRwS5eWRjsc/qgB8pYRPDnk6EcLREYs1w35HLIew1/AxR2lo+DWcfPh4lV5tEaubTvzx92yz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JT93LwK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D84C072AA;
	Wed, 17 Apr 2024 15:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713369397;
	bh=vNcaPBrZO+ppAKRbORNz0nJqGNldg2Yat0x53LVhO6c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JT93LwK4URemeDxxnQXFbKdAsHWRH02//UQVW/OGjosw4wKpyBgS/LjOHHSLucPFY
	 GBHaU0xEeyVT2snGjrD4cvhebAJDa9enBKIHESiZjxPBsUOV8upfoivHaUTZWqNQHU
	 Gk1M7HBdVMAL/wft4y0SUCDnIs1rhBhzJlHIbwJgZT9OO2TyoRhCJQRUcO2hQmpTpB
	 O5rN0KrwWQtfEUCBv8Pnh4I8Ag5fmNbjfn8+6bXddvEDRoexOWyPpN/i0Y0iz3P1qf
	 oBDkfLBEB3KQXf13+v23+P3GdKgQJAsKsqAYFbaMzL7CNSf18IKxfXqC++Yz+s8ldp
	 WtZPCihqNS56A==
Message-ID: <20acec19-0dc9-4926-aac5-f24fcc09cba3@kernel.org>
Date: Wed, 17 Apr 2024 17:56:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] ASoC: dt-bindings: wcd937x-sdw: add bindings for
 wcd937x-sdw
To: Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
 quic_pkumpatl@quicinc.com
References: <20240416063600.309747-1-quic_mohs@quicinc.com>
 <20240416063600.309747-4-quic_mohs@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240416063600.309747-4-quic_mohs@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/04/2024 08:35, Mohammad Rafi Shaik wrote:
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
> diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml
> new file mode 100644
> index 000000000000..2b7358e266ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/qcom,wcd937x-sdw.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SoundWire Slave devices on WCD9370
> +
> +maintainers:
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  Qualcomm WCD9370 Codec is a standalone Hi-Fi audio codec IC.
> +  It has RX and TX Soundwire slave devices. This bindings is for the
> +  slave devices.
> +
> +properties:
> +  compatible:
> +    const: sdw20217010a00
> +
> +  reg:
> +    maxItems: 1
> +
> +  qcom,tx-port-mapping:
> +    description: |
> +      Specifies static port mapping between slave and master tx ports.
> +      In the order of slave port index.

Use inclusive terminology. Describe what is here - what is the index?
What is the value?

> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 4
> +    maxItems: 4

Add constraints on values. You have maximum 15 TX ports, don't you?

> +
> +  qcom,rx-port-mapping:
> +    description: |
> +      Specifies static port mapping between slave and master rx ports.
> +      In the order of slave port index.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 5
> +    maxItems: 5
> +
> +required:
> +  - compatible
> +  - reg
> +  - qcom,port-mapping

Test your binding. There is no need to engage reviewers for reviewing
simple mistakes which *tools* can point. Respect reviewers time and use
the tools first.

You need oneOf: with required for TX and RX... or just unify the
properties. Why do you need two?


> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soundwire@3210000 {
Drop unit address.

> +        #address-cells = <2>;
> +        #size-cells = <0>;
> +        reg = <0x03210000 0x2000>;

Drop, not relevant and not placed correctly (see DTS coding style).

> +        wcd937x_rx: codec@0,4 {

Drop label, not used.

> +            compatible = "sdw20217010a00";
> +            reg  = <0 4>;
> +            qcom,rx-port-mapping = <1 2 3 4 5>;
> +        };
> +    };
> +
> +    soundwire@3230000 {

Drop this example, it's almost identical.

Best regards,
Krzysztof


