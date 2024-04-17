Return-Path: <linux-kernel+bounces-148663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F9B8A85BF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBDA81C2095D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D491422C1;
	Wed, 17 Apr 2024 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8LbVcby"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1011411EE;
	Wed, 17 Apr 2024 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713363361; cv=none; b=eCc2O0iRDefxSb+v4NdBd2pO6SU5/dWtj26lcDpesXdGGxRvmxzhJYWeREOhltjVTzD9A5OzL1tGGJYbIOuopofu4/Q9S/UmJb3ayOkIZSrt0Z9TwpEuRI0BoaVuseWoDtgGmwxAtfjTQmq8TCiIsc8pBYiGW7XI847/1wNNyXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713363361; c=relaxed/simple;
	bh=f39lfsHN5Os0P7FTVoBlrkp1C5yLiIyaNXce6Srsymw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LQz5XnHTUtuu9JjrIFllfVuTJ97/7dCo1ZiII0wJ46cRfnlVDVurWCkvUMGCJ/aQ2KxRSkZjJ/HBSzm+E/pXdKiCI9ScxtuFSIRW8qygOZyT8t6KM0RvgsTMlPZkoqwaUCBNWwcXcxl2e0B0+I68nbmZY8Pjpf97XmlT/DhPC68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8LbVcby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60B2C116B1;
	Wed, 17 Apr 2024 14:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713363361;
	bh=f39lfsHN5Os0P7FTVoBlrkp1C5yLiIyaNXce6Srsymw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=B8LbVcbyQmYQhv/ZuWhvwQ1lAitYwRhlKa/SmQXictKX7bC6JPUgUPOFJZmY0pwps
	 divUejga0QX9/kzk6Nkl0gJgXfEUGppzx5fArDF8vyys9iS644LxwvZyO2B2EWW+2D
	 5S0/NnVrt90WT5Sg4Slc3+S/wRLlVu1DJzjHg+1QCgjIZ5jpSZkU22pVH0qzeriEOa
	 rYkR7xujtCTLNzQEXr4wWZyx9wa8Yy9aOnHhe2LjRPG8qjRPH/Yfg/o/JEbGaIyy64
	 8xEejozNXhW/tN7z/hg7I7zylSzBfXEhjaMYM7Yk+v9nfCPgR6OrzB9DzkL8EmiKPd
	 ZrPGcBqNBzwiQ==
Message-ID: <c3bcefc9-61de-44aa-8412-17ea42e7048c@kernel.org>
Date: Wed, 17 Apr 2024 16:16:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: dt-bindings: fsl,ssi: Convert to YAML
To: Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com,
 broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, shengjiu.wang@gmail.com, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1713345932-6408-1-git-send-email-shengjiu.wang@nxp.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <1713345932-6408-1-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/04/2024 11:25, Shengjiu Wang wrote:
> Convert the fsl,ssi binding to YAML.
> 

..

> +description:
> +  Notes on fsl,playback-dma and fsl,capture-dma
> +  On SOCs that have an SSI, specific DMA channels are hard-wired for playback
> +  and capture.  On the MPC8610, for example, SSI1 must use DMA channel 0 for
> +  playback and DMA channel 1 for capture.  SSI2 must use DMA channel 2 for
> +  playback and DMA channel 3 for capture.  The developer can choose which
> +  DMA controller to use, but the channels themselves are hard-wired.  The
> +  purpose of these two properties is to represent this hardware design.
> +
> +  The device tree nodes for the DMA channels that are referenced by
> +  "fsl,playback-dma" and "fsl,capture-dma" must be marked as compatible with
> +  "fsl,ssi-dma-channel".  The SOC-specific compatible string (e.g.
> +  "fsl,mpc8610-dma-channel") can remain.  If these nodes are left as
> +  "fsl,elo-dma-channel" or "fsl,eloplus-dma-channel", then the generic Elo DMA
> +  drivers (fsldma) will attempt to use them, and it will conflict with the
> +  sound drivers.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - fsl,imx50-ssi
> +              - fsl,imx53-ssi
> +          - enum:
> +              - fsl,imx51-ssi
> +          - enum:
> +              - fsl,imx21-ssi

That's a mess... you cannot have enums as fallbacks.

> +      - items:
> +          - enum:
> +              - fsl,imx25-ssi
> +              - fsl,imx27-ssi
> +              - fsl,imx35-ssi
> +              - fsl,imx51-ssi
> +              - fsl,imx6q-ssi
> +              - fsl,imx6sl-ssi
> +              - fsl,imx6sx-ssi
> +          - enum:
> +              - fsl,imx21-ssi
> +              - fsl,imx51-ssi
> +      - items:
> +          - const: fsl,mpc8610-ssi
> +
> +  cell-index:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2]
> +    description: The SSI index
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  fsl,fifo-depth:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      The number of elements in the transmit and receive FIFOs.
> +      This number is the maximum allowed value for SFCSR[TFWM0].
> +
> +  clocks:
> +    items:
> +      - description: The ipg clock for register access
> +      - description: clock for SSI master mode
> +    minItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: ipg
> +      - const: baud
> +    minItems: 1
> +
> +  dmas:
> +    oneOf:
> +      - items:
> +          - description: DMA controller phandle and request line for RX
> +          - description: DMA controller phandle and request line for TX
> +      - items:
> +          - description: DMA controller phandle and request line for RX0
> +          - description: DMA controller phandle and request line for TX0
> +          - description: DMA controller phandle and request line for RX1
> +          - description: DMA controller phandle and request line for TX1
> +
> +  dma-names:
> +    oneOf:
> +      - items:
> +          - const: rx
> +          - const: tx
> +      - items:
> +          - const: rx0
> +          - const: tx0
> +          - const: rx1
> +          - const: tx1
> +
> +  codec-handle:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to a 'codec' node that defines an audio
> +      codec connected to this SSI.  This node is typically
> +      a child of an I2C or other control node.
> +
> +  fsl,fiq-stream-filter:
> +    type: boolean
> +    description:
> +      Disabled DMA and use FIQ instead to filter the codec stream.
> +      This is necessary for some boards where an incompatible codec
> +      is connected to this SSI, e.g. on pca100 and pcm043.
> +
> +  fsl,mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ ac97-slave, ac97-master, i2s-slave, i2s-master,
> +            lj-slave, lj-master, rj-slave, rj-master ]
> +    description: |
> +      "ac97-slave" - AC97 mode, SSI is clock slave
> +      "ac97-master" - AC97 mode, SSI is clock master
> +      "i2s-slave" - I2S mode, SSI is clock slave
> +      "i2s-master" - I2S mode, SSI is clock master
> +      "lj-slave" - Left justified mode, SSI is clock slave
> +      "lj-master" - Left justified mode, SSI is clock master
> +      "rj-slave" - Right justified mode, SSI is clock slave
> +      "rj-master" - Right justified mode, SSI is clock master
> +
> +  fsl,ssi-asynchronous:
> +    type: boolean
> +    description: If specified, the SSI is to be programmed in asynchronous
> +      mode.  In this mode, pins SRCK, STCK, SRFS, and STFS must
> +      all be connected to valid signals.  In synchronous mode,
> +      SRCK and SRFS are ignored.  Asynchronous mode allows
> +      playback and capture to use different sample sizes and
> +      sample rates.  Some drivers may require that SRCK and STCK
> +      be connected together, and SRFS and STFS be connected
> +      together.  This would still allow different sample sizes,
> +      but not different sample rates.
> +
> +  fsl,playback-dma:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle to a node for the DMA channel to use for
> +      playback of audio.  This is typically dictated by SOC
> +      design. Only used on Power Architecture.
> +
> +  fsl,capture-dma:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle to a node for the DMA channel to use for
> +      capture (recording) of audio.  This is typically dictated
> +      by SOC design. Only used on Power Architecture.
> +
> +  "#sound-dai-cells":
> +    const: 0
> +    description: optional, some dts node didn't add it.

The question is: is this DAI or not?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - fsl,fifo-depth
> +
> +unevaluatedProperties: false

This must be additionalProperties:false. Use example-schema as
reference... unless you want to reference dai-common.yaml, but then that
one is missing.

Best regards,
Krzysztof


