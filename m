Return-Path: <linux-kernel+bounces-9568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E2681C7A8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67E6DB224EF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E82717989;
	Fri, 22 Dec 2023 09:53:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A377D17735;
	Fri, 22 Dec 2023 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 1A6627FDC;
	Fri, 22 Dec 2023 17:53:12 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 22 Dec
 2023 17:53:11 +0800
Received: from [192.168.125.131] (113.72.145.47) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 22 Dec
 2023 17:53:11 +0800
Message-ID: <ed66f0bb-69c7-4b00-9688-05a5102212e9@starfivetech.com>
Date: Fri, 22 Dec 2023 17:44:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: ASoC: Add Cadence I2S controller for
 StarFive JH8100 SoC
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Claudiu Beznea <Claudiu.Beznea@microchip.com>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor.dooley@microchip.com>, Walker Chen <walker.chen@starfivetech.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
References: <20231221033223.73201-1-xingyu.wu@starfivetech.com>
 <20231221033223.73201-2-xingyu.wu@starfivetech.com>
 <20231221-saddlebag-tricolor-d02a17d66795@spud>
From: Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <20231221-saddlebag-tricolor-d02a17d66795@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag

On 2023/12/21 21:53, Conor Dooley wrote:
> Xingyu, Mark,
> 
> On Thu, Dec 21, 2023 at 11:32:22AM +0800, Xingyu Wu wrote:
>> Add bindings for the Multi-Channel I2S controller of Cadence
>> on the StarFive JH8100 SoC.
>> 
>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>> ---
>>  .../bindings/sound/cdns,jh8100-i2s.yaml       | 100 ++++++++++++++++++
>>  1 file changed, 100 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/sound/cdns,jh8100-i2s.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/sound/cdns,jh8100-i2s.yaml b/Documentation/devicetree/bindings/sound/cdns,jh8100-i2s.yaml
>> new file mode 100644
>> index 000000000000..5d95d9ab3e45
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/cdns,jh8100-i2s.yaml
>> @@ -0,0 +1,100 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/cdns,jh8100-i2s.yaml#
> 
> Filename matching the compatible please.

Noted.

> 
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Cadence multi-channel I2S controller for StarFive JH8100 SoC
>> +
>> +description: |
> 
> You only need the | if there is formatting to preserve.

Will drop.

> 
>> +  The Cadence I2S Controller implements a function of the multi-channel
>> +  (up to 8-channel) bus. It combines functions of a transmitter and a receiver.
>> +  It is used in the StarFive JH8100 SoC.
>> +
>> +maintainers:
>> +  - Xingyu Wu <xingyu.wu@starfivetech.com>
>> +  - Walker Chen <walker.chen@starfivetech.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: starfive,jh8100-i2s
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    description: |
>> +      The interrupt line number for the I2S controller. Add this
>> +      parameter if the I2S controller that you are using does not
>> +      support DMA.
> 
> You've got one i2s controller here, you should know if it supports DMA
> or not.

The I2S already supports interrupt handler, but if the SoC supports DMA controller to be use, it can optionally use DMA.

> 
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: Bit clock
>> +      - description: Main ICG clock
>> +      - description: Inner master clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: bclk
>> +      - const: icg
>> +      - const: mclk_inner
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  dmas:
>> +    items:
>> +      - description: TX DMA Channel
>> +      - description: RX DMA Channel
>> +    minItems: 1
>> +
>> +  dma-names:
>> +    items:
>> +      - const: tx
>> +      - const: rx
>> +    minItems: 1
>> +
>> +  cdns,i2s-max-channels:
>> +    description: |
>> +      Number of I2S max stereo channels supported by the hardware.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 1
>> +    maximum: 8
> 
> Mark, is there no common property for this kind of thing? That said,
> there's one device here so the number is known at present.
> Another note, this property is not required, so it should have a
> default.
> 
> It's kinda hard to know with this binding - it is touted as being for a
> particular Cadence IP, and some aspects are pretty generic, but at the
> same time there's only one device here so it's hard to tell what is
> variable between implementations and what is not.
> Are there no other implementations of this controller? Unless it is
> brand new, I find that hard to believe.
> 
> Cheers,
> Conor.
> 
 
Sorry, It does not seem to be common property. The Cadence I2S supports 8 channels. There are four I2S controllers on the JH8100 SoC, and two of them just provide 4 channels to use, one of them just provide 2 channels.
It seems to depend on the SoC.

Thanks,
Xingyu Wu

>> +
>> +  "#sound-dai-cells":
>> +    const: 0
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +
>> +oneOf:
>> +  - required:
>> +      - dmas
>> +      - dma-names
>> +  - required:
>> +      - interrupts
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2s@122b0000 {
>> +      compatible = "starfive,jh8100-i2s";
>> +      reg = <0x122b0000 0x1000>;
>> +      clocks = <&syscrg_ne 133>,
>> +               <&syscrg_ne 170>,
>> +               <&syscrg 50>;
>> +      clock-names = "bclk", "icg",
>> +                    "mclk_inner";
>> +      resets = <&syscrg_ne 43>;
>> +      dmas = <&dma 7>, <&dma 6>;
>> +      dma-names = "tx", "rx";
>> +      cdns,i2s-max-channels = <2>;
>> +      #sound-dai-cells = <0>;
>> +    };
>> -- 
>> 2.25.1
>> 
>> 


