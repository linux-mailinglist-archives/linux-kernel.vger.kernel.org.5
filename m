Return-Path: <linux-kernel+bounces-90662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 264298702DB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5C1EB2699A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1A73E487;
	Mon,  4 Mar 2024 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6YTCCzx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066EF3DB9A;
	Mon,  4 Mar 2024 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559454; cv=none; b=qRAxaF5qzZX7dKjbmNLvmYwTvdw61ivh8XBpw1jHfExePCP4uepE5cH2Jnh8+Pb7F4peNJBBK6FZD0ktwae2P5K+zLjP5UgTVhI2BPMCFjsqPUQ3KnddKeVXYM//vKLJAxWJzAJw7rjFwIAdJzNanez44gD90ddJFUobKjw+eq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559454; c=relaxed/simple;
	bh=Ph0t88urpiIfgX3lePmkozKVSowGvKDDtWxRZ0hH0SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LM2uXiA5HaluMkyc4MUbmF3vrZnaYKTE3j0/9JXXEsP3o6OXYdfmmGOgwR2AF9+Zs8aH6YBVt3hH47CHHZ7fpjtEJB9zp4I6Lpl+UkPkkR/Ky9JxLvxpa2QS+hzJuI/uhkzsQ7yXoCRNyOIGA4BJ33TsXknHAsQ/J6tpjNmEmMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6YTCCzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87519C433C7;
	Mon,  4 Mar 2024 13:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709559453;
	bh=Ph0t88urpiIfgX3lePmkozKVSowGvKDDtWxRZ0hH0SY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W6YTCCzx3azyARlHLnJKj7DlRItWL5zU5z7c2kkrB/veS/4VLDVzLIqutidwIFPXg
	 +oD7pa46iAuCawIFdTOfPQ6mc44Z6RgVRaTAjLlVuu3xNHt4PaUoswpEmeRc0FCZB3
	 mJmG7dn8ArXlzs0hQK0ZsgqgKemoQSyigGvy3Hn/ibL04I17ATwReEFGw+n4OZ65Gq
	 hwjgWQUX6h4vcG+oJiZQy4jZgJ2VuuWXyjYsTzlRXgicBTDfFdTVZBBkzhkrZP+6fd
	 AZbPzsmiLKkxUmA/Ho1OCOaCbT12Q1EOxlJn4pWPgRB+MrK2+VBcefw3oX6AR+aM0S
	 kRH+qRae3MZbg==
Date: Mon, 4 Mar 2024 07:37:31 -0600
From: Rob Herring <robh@kernel.org>
To: Seven Lee <wtli@nuvoton.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	conor+dt@kernel.org, YHCHuang@nuvoton.com, KCHSU0@nuvoton.com,
	CTLIN0@nuvoton.com, SJLIN0@nuvoton.com, scott6986@gmail.com,
	supercraig0719@gmail.com, dardar923@gmail.com
Subject: Re: [PATCH v3 1/2] ASoC: dt-bindings: Added schema for
 "nuvoton,nau8325"
Message-ID: <20240304133731.GA105655-robh@kernel.org>
References: <20240304101523.538989-1-wtli@nuvoton.com>
 <20240304101523.538989-2-wtli@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304101523.538989-2-wtli@nuvoton.com>

On Mon, Mar 04, 2024 at 06:15:22PM +0800, Seven Lee wrote:
> Added a DT schema for describing nau8325 audio amplifiers.

Present tense: Add a ...

Please say more about this device. Features, link to datasheet, etc.

> 
> Signed-off-by: Seven Lee <wtli@nuvoton.com>
> ---
>  .../bindings/sound/nuvoton,nau8325.yaml       | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100755 Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml

Schemas aren't executable. checkpatch.pl will tell you this.

> 
> diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml
> new file mode 100755
> index 000000000000..297d29462812
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/nuvoton,nau8325.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NAU8325 audio Amplifier
> +
> +maintainers:
> +  - Seven Lee <WTLI@nuvoton.com>
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: nuvoton,nau8325
> +
> +  reg:
> +    maxItems: 1
> +
> +  nuvoton,vref-impedance:
> +    description:
> +      VREF impedance selection.
> +    enum: ["Open", "25kOhm", "125kOhm", "2.5kOhm"]

Use standard units (-ohms), not strings. For "open", just omit the 
property.

> +
> +
> +  nuvoton,dac-vref:
> +    description: DAC Reference Voltage Setting.
> +    enum: ["External VDDA", "1.5V", "1.6V", "1.7V"]

Use standard units.

> +
> +
> +  nuvoton,alc-enable:
> +    description:
> +      Enable digital automatic level control (ALC) function.
> +    type: boolean
> +
> +  nuvoton,clock-detection-disable:
> +    description:
> +      When clock detection is enabled, it will detect whether MCLK
> +      and FS are within the range. MCLK range is from 2.048MHz to 24.576MHz.
> +      FS range is from 8kHz to 96kHz. And also needs to detect the ratio
> +      MCLK_SRC/LRCK of 256, 400 or 500, and needs to detect the BCLK
> +      to make sure data is present. There needs to be at least 8 BCLK
> +      cycles per Frame Sync.
> +    type: boolean
> +
> +  nuvoton,clock-det-data:
> +    description:
> +      Request clock detection to require 2048 non-zero samples before enabling
> +      the audio paths. If set then non-zero samples is required, otherwise it
> +      doesn't matter.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        codec@21 {
> +            compatible = "nuvoton,nau8325";
> +            reg = <0x21>;
> +            nuvoton,vref-impedance = "125kOhm";
> +            nuvoton,dac-vref = "1.6V";
> +            nuvoton,alc-enable;
> +            nuvoton,clock-det-data;
> +        };
> +    };
> -- 
> 2.25.1
> 

