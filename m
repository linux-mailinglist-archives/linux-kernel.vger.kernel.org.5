Return-Path: <linux-kernel+bounces-147022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FE58A6E53
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7CC61F21F37
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2D012E1C1;
	Tue, 16 Apr 2024 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELC8O1hE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC2712BF3A;
	Tue, 16 Apr 2024 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277959; cv=none; b=JFNOnnT3oEY54OmL/VbVdVKP/fo/YqPt/pT9d9sOYxI4XTEofZ3r4pscPDfs5nivR8EgGh7HI4TomZb9dhCgdiloaC61Fi+czyKNEQK89P3UNdMHO9rI1OkL5k2wEzVH0Fskql+YCGSAltd5aAJXtz7YluZo8NiwrmXzCnc+RvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277959; c=relaxed/simple;
	bh=wjp4bLJ0fT33224ygvnRP0tblkyuZ6Q22imNSXQ8bQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BC6oUK32U0Ae3LrqjJYPgXhUxdlqWzD5xLhQ3G5fc4H13LJjZpo/+kKmZDNNz8tItH+lceSJTwGIq/64ST4vLe4VmOHrGZ/bWdxh0iiDCbmnWliH6oYge0hTYDASuCGelmKc9YBGcBqyLiLNNYEtpREvUghVOtQ0dMD/sIpjr50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELC8O1hE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D84C2BD11;
	Tue, 16 Apr 2024 14:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713277959;
	bh=wjp4bLJ0fT33224ygvnRP0tblkyuZ6Q22imNSXQ8bQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ELC8O1hEoEIPM2E6gWK8WyW2OayVVZCojXc4wIgfrTIBqIGH3wx4xw0daVirJGf5z
	 BGi8uSFtsLKQoFWxjXtsWDqAYrvVpjT8GEnrxcmMzg0Ui4tZddBCzMy8LpZQJmd77Z
	 6BVJbyLGOVbhNTJv3p5gZru86qStIGA4RPaHrLj+TT2FqCBWnNGyXpuXI+vo+OwBV1
	 GqxSL+E3iIMyQJpwLWxQ0dD8NUvxelf4+yM4O92n9JUDULl4kIrncXMJxnBzokRHF0
	 glHQcUDstoGq2M+lbLMwi5cTBRxI0AfD0R+AsSAPhrWRi+7lg9ApXRPC+oxKBp9nki
	 r7YrNWAzZ09zQ==
Date: Tue, 16 Apr 2024 09:32:37 -0500
From: Rob Herring <robh@kernel.org>
To: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
	quic_pkumpatl@quicinc.com
Subject: Re: [PATCH v2 3/8] ASoC: dt-bindings: wcd937x-sdw: add bindings for
 wcd937x-sdw
Message-ID: <20240416143237.GA2250258-robh@kernel.org>
References: <20240416063600.309747-1-quic_mohs@quicinc.com>
 <20240416063600.309747-4-quic_mohs@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416063600.309747-4-quic_mohs@quicinc.com>

On Tue, Apr 16, 2024 at 12:05:55PM +0530, Mohammad Rafi Shaik wrote:
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

Don't need '|' if no formatting.

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

Are there constraints on the values of the entries?

> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 4
> +    maxItems: 4
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
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soundwire@3210000 {
> +        #address-cells = <2>;
> +        #size-cells = <0>;
> +        reg = <0x03210000 0x2000>;
> +        wcd937x_rx: codec@0,4 {
> +            compatible = "sdw20217010a00";
> +            reg  = <0 4>;
> +            qcom,rx-port-mapping = <1 2 3 4 5>;
> +        };
> +    };
> +
> +    soundwire@3230000 {
> +        #address-cells = <2>;
> +        #size-cells = <0>;
> +        reg = <0x03230000 0x2000>;
> +        wcd937x_tx: codec@0,3 {
> +            compatible = "sdw20217010a00";
> +            reg  = <0 3>;
> +            qcom,tx-port-mapping = <2 3 4 5>;
> +        };
> +    };
> +
> +...
> -- 
> 2.25.1
> 

