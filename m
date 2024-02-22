Return-Path: <linux-kernel+bounces-77533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 609BC8606EE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C05287F05
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EE817BDC;
	Thu, 22 Feb 2024 23:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gtb9elFl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1282208F;
	Thu, 22 Feb 2024 23:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708644094; cv=none; b=dNUmuaQ+TF9k2wZCFt0Dz79yLIscOf6HlG6yy1MPV2mxWLwxsBVUm961gSq3sEflxCtj+xgudBWT2t6LDJ+xgqTQ0trjULfyaIKGREKhX9J/zDcps79zA35AIItZm5j2lGHqZmzp/M2qgsPv5En+mi2F57WzmzW0/pVx8ibu00A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708644094; c=relaxed/simple;
	bh=/7oDxzaotDMQ2PYxvxhhKnxcodeCvytyBRIpHzW+Yog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDCfqb8eOA86bj99TUIJw59yFsZEKN1dTOiiymmwxNgOvAdCldZ6KPQIyPW7/IxkBEIdxbY8JUk2x1EE2bENHN43mNkS9XN8ZyH5m2gPXcaAU8eqteqIm30sD2AG1Sw5B6uTCihnWa0XqFWvlvuq5U46/KqlhdDKWacspZUX1c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gtb9elFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF3CC433F1;
	Thu, 22 Feb 2024 23:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708644093;
	bh=/7oDxzaotDMQ2PYxvxhhKnxcodeCvytyBRIpHzW+Yog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gtb9elFlw0C4aEVU9bfKXRUwfVwgsRLl1VDgjExetw4rUsO6PHqWUITOD0C0czy/M
	 gNJ4rn6NoNwiJF5S3bnE7sXKW4vY8DkFfKWLHDJIOG+GDRTJ7vZv2hlLAodZb3O1a+
	 HJuhgzRwS2Gofu45IBFGFB9akdWh0kV0OCC+YJj87tVmmELVm/inroYIhyA5PWFC1/
	 ooYrLFpTFexkoWaAZ5Ur6dyia+okjXSViKu31n1NNtCYGK3O3xVMQChYmlt0tK46Qz
	 dCwtuMytvYnz1IzvlyBBEie3z2WQo5D1uZKMUe1IYSUWr6eWzkUazxXChyHGiPqNCH
	 LDG66X26HEVyQ==
Date: Thu, 22 Feb 2024 14:14:11 -0600
From: Rob Herring <robh@kernel.org>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, David Yang <mmyangfl@gmail.com>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/4] dt-binding: clock: merge all hisilicon clock
 bindings to hisilicon,clock-reset-generator
Message-ID: <20240222201411.GA3765548-robh@kernel.org>
References: <20240216-clk-mv200-v1-0-a29ace29e636@outlook.com>
 <20240216-clk-mv200-v1-3-a29ace29e636@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216-clk-mv200-v1-3-a29ace29e636@outlook.com>

On Fri, Feb 16, 2024 at 07:37:53PM +0800, Yang Xiwen wrote:
> We don't need so many separated and duplicated dt-binding files. Merge
> them all and convert them to YAML.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  .../devicetree/bindings/clock/hi3660-clock.txt     |  47 -------
>  .../devicetree/bindings/clock/hi3670-clock.txt     |  43 -------
>  .../devicetree/bindings/clock/hi6220-clock.txt     |  52 --------
>  .../devicetree/bindings/clock/hisi-crg.txt         |  50 --------
>  .../clock/hisilicon,clock-reset-generator.yaml     | 139 +++++++++++++++++++++
>  .../clock/hisilicon,hi3559av100-clock.yaml         |  59 ---------
>  6 files changed, 139 insertions(+), 251 deletions(-)


> diff --git a/Documentation/devicetree/bindings/clock/hisilicon,clock-reset-generator.yaml b/Documentation/devicetree/bindings/clock/hisilicon,clock-reset-generator.yaml
> new file mode 100644
> index 000000000000..d37cd892473e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/hisilicon,clock-reset-generator.yaml
> @@ -0,0 +1,139 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/hisilicon,clock-reset-generator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Hisilicon SOC Clock and Reset Generator (CRG) module
> +
> +maintainers:
> +  - Yang Xiwen <forbidden405@foxmail.com>
> +
> +description: |

Don't need '|' if no formatting. Here and elsewhere.

> +  Hisilicon SOC clock control module which supports the clocks, resets and
> +  power domains on various SoCs.
> +
> +properties:
> +  compatible:
> +    minItems: 1
> +    items:
> +      - enum:
> +          - hisilicon,hi3559av100-clock
> +          - hisilicon,hi3559av100-shub-clock
> +          - hisilicon,hi3660-crgctrl
> +          - hisilicon,hi3660-pctrl
> +          - hisilicon,hi3660-pmuctrl
> +          - hisilicon,hi3660-sctrl
> +          - hisilicon,hi3660-iomcu
> +          - hisilicon,hi3660-stub-clk
> +          - hisilicon,hi3670-crgctrl
> +          - hisilicon,hi3670-pctrl
> +          - hisilicon,hi3670-pmuctrl
> +          - hisilicon,hi3670-sctrl
> +          - hisilicon,hi3670-iomcu
> +          - hisilicon,hi3670-media1-crg
> +          - hisilicon,hi3670-media2-crg
> +          - hisilicon,hi6220-acpu-sctrl
> +          - hisilicon,hi6220-aoctrl
> +          - hisilicon,hi6220-sysctrl
> +          - hisilicon,hi6220-mediactrl
> +          - hisilicon,hi6220-pmctrl
> +          - hisilicon,hi6220-stub-clk
> +          - hisilicon,hi3516cv300-crg
> +          - hisilicon,hi3516cv300-sysctrl
> +          - hisilicon,hi3519-crg
> +          - hisilicon,hi3798cv200-crg
> +          - hisilicon,hi3798cv200-sysctrl
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    enum: [1, 2]
> +    description: |
> +      First cell is reset request register offset.
> +      Second cell is bit offset in reset request register.
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  mboxes:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

Standard property already has a type. You need to define how many 
entries and what each one is if more than 1.

> +    description: |
> +      Phandle to the mailbox for sending msg to MCU
> +      (See ../mailbox/hisilicon,hi3660-mailbox.txt for more info)

Convert or avoid adding new references to txt bindings.

> +
> +  mbox-names:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description: |
> +      Names of the mailboxes.
> +
> +  hisilicon,hi6220-clk-sram:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      Phandle to the syscon managing the SoC internal sram
> +      the driver needs using the sram to pass parameters for frequency change.
> +
> +  reset-controller:
> +    type: object
> +    description: |
> +      Reset controller for Hi3798CV200 GMAC module
> +
> +required:
> +  - compatible
> +  - '#clock-cells'
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              enum:
> +                - hisilicon,hi3798cv200-crg
> +    then:
> +      properties:
> +        reset-controller: false
> +  - oneOf:
> +      - required:
> +          - hisilicon,hi6220-clk-sram
> +      - required:
> +          - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/hi3559av100-clock.h>
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        clock-controller@12010000 {
> +            compatible = "hisilicon,hi3559av100-clock";
> +            #clock-cells = <1>;
> +            #reset-cells = <2>;
> +            reg = <0x0 0x12010000 0x0 0x10000>;
> +        };
> +    };
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/hi3660-clock.h>
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        clock-controller@fff35000 {
> +            compatible = "hisilicon,hi3660-crgctrl", "syscon";
> +            reg = <0x0 0xfff35000 0x0 0x1000>;
> +            #clock-cells = <1>;
> +        };
> +    };

