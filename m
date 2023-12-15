Return-Path: <linux-kernel+bounces-1622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C6F815100
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0D3281DBB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B767C45C0E;
	Fri, 15 Dec 2023 20:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVdy6KWp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C30645974;
	Fri, 15 Dec 2023 20:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A48C433C8;
	Fri, 15 Dec 2023 20:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702671700;
	bh=rM/8QyjRP/D0wS+bczAZynutfKBikwhu7mfWM05ptaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZVdy6KWp6p13IP8+827QHC8uref9ihr+d3wS4PJWkdCNk/QwsJZm87SyeGtR0VQP4
	 j/DWSSNrVtaaOFSe1ByrKX+8s4xT9XZsvws9rNjcz/V5BeYFrgzGwqzjgZtoumm67o
	 ldMA7naStAAwkNM/gtlrCmmVv7gyHMJbuWOrpJEvukd2+voiA67u14DUHABjgDZX3D
	 Ppfd5EmULEfUrLn605qtRrTGteh0EQZ7qEvupGLL7gjkPK0UGRw8Oy46mGpu1v6TC9
	 q3234vOuU/zlsTrZxNfN0Mqvo0y9E40T9oM+T9tX5KgxCYGSuclaYhKDwlZqMBRQgE
	 29h4EkWXZ/Xgw==
Received: (nullmailer pid 328118 invoked by uid 1000);
	Fri, 15 Dec 2023 20:21:37 -0000
Date: Fri, 15 Dec 2023 14:21:37 -0600
From: Rob Herring <robh@kernel.org>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Hoan Tran <hoan@os.amperecomputing.com>, Serge Semin <fancer.lancer@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v1 1/8] dt-bindings: pinctrl: Add thead,th1520-pinctrl
 bindings
Message-ID: <20231215202137.GA317624-robh@kernel.org>
References: <20231215143906.3651122-1-emil.renner.berthing@canonical.com>
 <20231215143906.3651122-2-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215143906.3651122-2-emil.renner.berthing@canonical.com>

On Fri, Dec 15, 2023 at 03:38:59PM +0100, Emil Renner Berthing wrote:
> Add bindings for the pin controllers on the T-Head TH1520 RISC-V SoC.
> 
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> ---
>  .../pinctrl/thead,th1520-pinctrl.yaml         | 156 ++++++++++++++++++
>  1 file changed, 156 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
> new file mode 100644
> index 000000000000..1b1b446cd498
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
> @@ -0,0 +1,156 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/thead,th1520-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: T-Head TH1520 SoC pin controller
> +
> +maintainers:
> +  - Emil Renner Berthing <emil.renner.berthing@canonical.com>
> +
> +description: |
> +  Pinmux and pinconf controller in the T-Head TH1520 RISC-V SoC.
> +
> +  The TH1520 has 3 groups of pads each controlled from different memory ranges.
> +  Confusingly the memory ranges are named
> +    PADCTRL_AOSYS  -> PAD Group 1
> +    PADCTRL1_APSYS -> PAD Group 2
> +    PADCTRL0_APSYS -> PAD Group 3

Are the programming models different?

> +
> +  Each pad can be muxed individually to up to 5 different functions. For most
> +  pads only a few of those 5 configurations are valid though, and a few pads in
> +  group 1 does not support muxing at all.
> +
> +  Pinconf is fairly regular except for a few pads in group 1 that either can't
> +  be configured or has some special functions. The rest have configurable drive
> +  strength, input enable, schmitt trigger, slew rate, pull-up and pull-down in
> +  addition to a special strong pull up.
> +
> +  Certain pads in group 1 can be muxed to AUDIO_PA0 - AUDIO_PA30 functions and
> +  are then meant to be used by the audio co-processor. Each such pad can then
> +  be further muxed to either audio GPIO or one of 4 functions such as UART, I2C
> +  and I2S. If the audio pad is muxed to one of the 4 functions then pinconf is
> +  also configured in different registers. All of this is done from a different
> +  AUDIO_IOCTRL memory range and is left to the audio co-processor for now.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - thead,th1520-group1-pinctrl
> +      - thead,th1520-group2-pinctrl
> +      - thead,th1520-group3-pinctrl
> +
> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  '-[0-9]+$':

Please make this a bit more specific. "-grp-[0-9]+$"?

> +    type: object

blank line. And move additionalProperties here. Easier to read in the 
indented cases.

> +    patternProperties:
> +      '-pins$':
> +        type: object
> +        $ref: /schemas/pinctrl/pincfg-node.yaml
> +        description:
> +          A pinctrl node should contain at least one subnode describing one
> +          or more pads and their associated pinmux and pinconf settings.
> +
> +        properties:
> +          pins:
> +            $ref: /schemas/types.yaml#/definitions/string-array

Type is defined in pinmux-node.yaml. You need to reference it and drop 
this.

Normally the possible values are listed out.

> +            description: List of pads that properties in the node apply to.
> +
> +          function:
> +            $ref: /schemas/types.yaml#/definitions/string
> +            enum: [ "0", "1", "2", "3", "4", "5" ]
> +            description: The mux function to select for the given pins.
> +
> +          bias-disable: true
> +
> +          bias-pull-up:
> +            type: boolean
> +
> +          bias-pull-down:
> +            type: boolean
> +
> +          drive-strength:
> +            enum: [ 1, 2, 3, 5, 7, 8, 10, 12, 13, 15, 16, 18, 20, 21, 23, 25 ]
> +
> +          input-enable: true
> +
> +          input-disable: true
> +
> +          input-schmitt-enable: true
> +
> +          input-schmitt-disable: true
> +
> +          slew-rate:
> +            maximum: 1
> +
> +          thead,strong-pull-up:
> +            oneOf:
> +              - type: boolean
> +              - $ref: /schemas/types.yaml#/definitions/uint32
> +                enum: [ 0, 2100 ]
> +            description: Enable or disable strong 2.1kOhm pull-up.

bias-pull-up can already specify the strength in Ohms.

> +
> +        required:
> +          - pins
> +
> +        additionalProperties: false
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    padctrl0_apsys: pinctrl@ec007000 {
> +        compatible = "thead,th1520-group3-pinctrl";
> +        reg = <0xec007000 0x1000>;
> +
> +        uart0_pins: uart0-0 {
> +            tx-pins {
> +                pins = "UART0_TXD";
> +                function = "0";
> +                bias-disable;
> +                drive-strength = <3>;
> +                input-disable;
> +                input-schmitt-disable;
> +                slew-rate = <0>;
> +            };
> +
> +            rx-pins {
> +                pins = "UART0_RXD";
> +                function = "0";
> +                bias-disable;
> +                drive-strength = <1>;
> +                input-enable;
> +                input-schmitt-enable;
> +                slew-rate = <0>;
> +            };
> +        };
> +    };
> +
> +    padctrl1_apsys: pinctrl@e7f3c000 {
> +        compatible = "thead,th1520-group2-pinctrl";
> +        reg = <0xe7f3c000 0x1000>;
> +
> +        i2c5_pins: i2c5-0 {
> +            i2c-pins {
> +                pins = "QSPI1_CSN0",    /* I2C5_SCL */
> +                       "QSPI1_D0_MOSI"; /* I2C5_SDA */
> +                function = "2";
> +                bias-disable;
> +                drive-strength = <7>;
> +                input-enable;
> +                input-schmitt-enable;
> +                slew-rate = <0>;
> +                thead,strong-pull-up;
> +            };
> +        };
> +    };
> -- 
> 2.40.1
> 

