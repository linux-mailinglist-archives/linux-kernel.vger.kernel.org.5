Return-Path: <linux-kernel+bounces-109080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4064E88146A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2A5283E95
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781EF42044;
	Wed, 20 Mar 2024 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9BD006I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9646050A7C;
	Wed, 20 Mar 2024 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948057; cv=none; b=N7RabjJKrMmABhUWLI8+QN+yxixF6cxVly3McaFipfKcsBx03OJ0WVeHhOOaTKR4pH8vvPJpHAsmHqXTRczQBE9uvDOREvOVJYZTfjBU65Mraur/H5q9o1OcZjHMt8g1QM08o1R7x1xV+/zA8pXXsj6dRQn2XGdZbGLUywqmLDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948057; c=relaxed/simple;
	bh=fv+3A41O9ch1OK7JdlitS1XL1KqojW9QBzFKwa+VV84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alM+w6+y4zzYvgefy0sc9HRJcwPUiRnVsTLPOk/mNYrz5aaNsfJPNrs/B9cEL7ghHWDTKpEY2kG4lgq9/VWatIh6+Cyz9RClrJ4D7vROPmdCjUL6im/2DO/g00Z9gBvGCxsuqDlZor4JvixQrY0iDP2Y489XdiGRUpB/CrxWLMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9BD006I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0727C433C7;
	Wed, 20 Mar 2024 15:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710948057;
	bh=fv+3A41O9ch1OK7JdlitS1XL1KqojW9QBzFKwa+VV84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d9BD006IJGpTepDWLabTqcTw6QqFiz0qcnfeeCcJpGNdk2H9R7WS2InLXWlieU7ZQ
	 DevWDbFa80XlPqbC+XL15mjSDuMiViIU8aX6oMI1tr3kk3xITPSwMGERv7Jn3tDkuQ
	 pRiMKon6XaGgRgKJUEvd3ZsL3M4boYQSVtepLMYkzUL8yiVRyNCDLcGqW2zZyK5yZU
	 o49EB41A6z9PSFuCnLVQpNFOfisIVveyAbE2depcsWf9L7PFtaQ/PdSEXi41TcNxGX
	 r1cKrrCfguT/VpGOoPOybU97FnJ5wk4z1jIrsNcOW8giwqX+NXwbh5HwPsfMrI1Z9H
	 u7rVBVd5nb2/Q==
Date: Wed, 20 Mar 2024 10:20:54 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] ASoC: dt-bindings: fsl-audmix: Convert
 fsl,audmix.txt to yaml
Message-ID: <20240320152054.GA1737736-robh@kernel.org>
References: <20240318191822.2271229-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318191822.2271229-1-Frank.Li@nxp.com>

On Mon, Mar 18, 2024 at 03:18:21PM -0400, Frank Li wrote:
> Convert fsl,audmix.txt to yaml to let dtb check tools check audmix part.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     dt_binding_check and DTB_CHECK passed.
>     
>     make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,audmix.yaml
>       LINT    Documentation/devicetree/bindings
>       DTEX    Documentation/devicetree/bindings/sound/fsl,audmix.example.dts
>       CHKDT   Documentation/devicetree/bindings/processed-schema.json
>       SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>       DTC_CHK Documentation/devicetree/bindings/sound/fsl,audmix.example.dtb
> 
>  .../devicetree/bindings/sound/fsl,audmix.txt  | 50 ------------
>  .../devicetree/bindings/sound/fsl,audmix.yaml | 78 +++++++++++++++++++
>  2 files changed, 78 insertions(+), 50 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,audmix.txt b/Documentation/devicetree/bindings/sound/fsl,audmix.txt
> deleted file mode 100644
> index 840b7e0d6a631..0000000000000
> --- a/Documentation/devicetree/bindings/sound/fsl,audmix.txt
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -NXP Audio Mixer (AUDMIX).
> -
> -The Audio Mixer is a on-chip functional module that allows mixing of two
> -audio streams into a single audio stream. Audio Mixer has two input serial
> -audio interfaces. These are driven by two Synchronous Audio interface
> -modules (SAI). Each input serial interface carries 8 audio channels in its
> -frame in TDM manner. Mixer mixes audio samples of corresponding channels
> -from two interfaces into a single sample. Before mixing, audio samples of
> -two inputs can be attenuated based on configuration. The output of the
> -Audio Mixer is also a serial audio interface. Like input interfaces it has
> -the same TDM frame format. This output is used to drive the serial DAC TDM
> -interface of audio codec and also sent to the external pins along with the
> -receive path of normal audio SAI module for readback by the CPU.
> -
> -The output of Audio Mixer can be selected from any of the three streams
> - - serial audio input 1
> - - serial audio input 2
> - - mixed audio
> -
> -Mixing operation is independent of audio sample rate but the two audio
> -input streams must have same audio sample rate with same number of channels
> -in TDM frame to be eligible for mixing.
> -
> -Device driver required properties:
> -=================================
> -  - compatible		: Compatible list, contains "fsl,imx8qm-audmix"
> -
> -  - reg			: Offset and length of the register set for the device.
> -
> -  - clocks		: Must contain an entry for each entry in clock-names.
> -
> -  - clock-names		: Must include the "ipg" for register access.
> -
> -  - power-domains	: Must contain the phandle to AUDMIX power domain node
> -
> -  - dais		: Must contain a list of phandles to AUDMIX connected
> -			  DAIs. The current implementation requires two phandles
> -			  to SAI interfaces to be provided, the first SAI in the
> -			  list being used to route the AUDMIX output.
> -
> -Device driver configuration example:
> -======================================
> -  audmix: audmix@59840000 {
> -    compatible = "fsl,imx8qm-audmix";
> -    reg = <0x0 0x59840000 0x0 0x10000>;
> -    clocks = <&clk IMX8QXP_AUD_AUDMIX_IPG>;
> -    clock-names = "ipg";
> -    power-domains = <&pd_audmix>;
> -    dais = <&sai4>, <&sai5>;
> -  };
> diff --git a/Documentation/devicetree/bindings/sound/fsl,audmix.yaml b/Documentation/devicetree/bindings/sound/fsl,audmix.yaml
> new file mode 100644
> index 0000000000000..fc65b76ea35ce
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,audmix.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/fsl,audmix.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP Audio Mixer (AUDMIX).
> +
> +maintainers:
> +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +description:

You need '|' as you have formatting.

> +  The Audio Mixer is a on-chip functional module that allows mixing of two
> +  audio streams into a single audio stream. Audio Mixer has two input serial
> +  audio interfaces. These are driven by two Synchronous Audio interface
> +  modules (SAI). Each input serial interface carries 8 audio channels in its
> +  frame in TDM manner. Mixer mixes audio samples of corresponding channels
> +  from two interfaces into a single sample. Before mixing, audio samples of
> +  two inputs can be attenuated based on configuration. The output of the
> +  Audio Mixer is also a serial audio interface. Like input interfaces it has
> +  the same TDM frame format. This output is used to drive the serial DAC TDM
> +  interface of audio codec and also sent to the external pins along with the
> +  receive path of normal audio SAI module for readback by the CPU.
> +
> +  The output of Audio Mixer can be selected from any of the three streams
> +    - serial audio input 1
> +    - serial audio input 2
> +    - mixed audio
> +
> +  Mixing operation is independent of audio sample rate but the two audio
> +  input streams must have same audio sample rate with same number of channels
> +  in TDM frame to be eligible for mixing.
> +
> +properties:
> +  compatible:
> +    const: fsl,imx8qm-audmix
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: ipg
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  dais:
> +    description:
> +      Must contain a list of phandles to AUDMIX connected
> +      DAIs. The current implementation requires two phandles
> +      to SAI interfaces to be provided, the first SAI in the
> +      list being used to route the AUDMIX output.

Needs a type and constraints. This corresponds to the output and 2 input 
streams? Something like this then?:

$ref: /schemas/types.yaml#/definitions/phandle-array
minItems: 2
items:
  - description: the AUDMIX output
    maxItems: 1
  - description: serial audio input 1
    maxItems: 1
  - description: serial audio input 2
    maxItems: 1

Rob

