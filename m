Return-Path: <linux-kernel+bounces-94614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCD7874229
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A45D1C22438
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D6C1B80B;
	Wed,  6 Mar 2024 21:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPylgsJD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE1763C8;
	Wed,  6 Mar 2024 21:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709761576; cv=none; b=RulGdYGpv+CMOlCGF5w2Wf9ZloaMiqUnXebgReSccXWn61JGcM07TbJkfVY3mxj6SKuLEQH5JsxAO4Vm48ysUDzEuY9s6x5hScLVGq11VF+n8wnYFkfUIrFcb2Dlzrc0Vuq7LMCe0adbClKcjrupdxsI8ML9tX8CJUAteXSDh68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709761576; c=relaxed/simple;
	bh=4MyjM4R7gGubu4ceSP37ZkH/7N5C3TSIAZ8zo4h/0Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDpHfOEmZ3CAIT+1gOD3GyKliOtPjLCrxLeMLs1a0f+Z522GvTgY/Z0kzaQ7U0hRIf8b7s5mnyqH10m4d064FCuxbJCr69CnfwT9QoQP4pz60zXbqjwSH907rP7QkQKHA0iyq+BIZrxvQBA429AXYC9CiVwkmJIYmA2iSQibpQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPylgsJD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B47C433F1;
	Wed,  6 Mar 2024 21:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709761575;
	bh=4MyjM4R7gGubu4ceSP37ZkH/7N5C3TSIAZ8zo4h/0Sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IPylgsJDAzIegkEEAyd+DFggB7J4gMWakaazASs3Dz2VBnyF5rhZ9Sv52yVxGKrDO
	 URQTLq+bBIb5RijGuDnFuDLCcufQ0uYnbZrAzyj603LNsLE/07gKyW1l0xvKbO3L2x
	 AND8Uz2EwiiLB99eAf+ccDhsVHl8cObFRU1Y3T4S/n1ZEkOfBp4/d14R3XOozE0J56
	 zaGXQ32AJ6YJOT7mM9bVMuRjxRUx8YIKgxkFudZBC2Zqa6M6PcxGZGHbzbS6dcoDeM
	 9MyeWKKyaBkusY+xReT3ELXYSWjLzkOgdukKnYMxGtvJgsecLB+p1MF3KeFZFbuvK3
	 H2D5UzRqdHi9A==
Date: Wed, 6 Mar 2024 15:46:13 -0600
From: Rob Herring <robh@kernel.org>
To: "JiaLong.Yang" <jialong.yang@shingroup.cn>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, shenghui.qu@shingroup.cn,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: perf: Support uncore NI-700 PMU
Message-ID: <20240306214613.GA716904-robh@kernel.org>
References: <cover.1709694173.git.jialong.yang@shingroup.cn>
 <f674ec19ce824dfc13258396931256c3d33cd207.1709694173.git.jialong.yang@shingroup.cn>
 <7f2576291e51043b33296a2cd9e21263d16ca077.1709694173.git.jialong.yang@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f2576291e51043b33296a2cd9e21263d16ca077.1709694173.git.jialong.yang@shingroup.cn>

On Wed, Mar 06, 2024 at 02:16:02PM +0800, JiaLong.Yang wrote:
> Add file corresponding to hx_arm_ni.c introducing ARM NI-700 PMU
> driver for HX.
> 
> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
> ---
> v1 --> v2:
> 1. Submit dt-bindings file Seperately.
> 2. Do some check:
>    ~ #: make dt_binding_check DT_SCHEMA_FILES=perf
>    LINT    Documentation/devicetree/bindings
>    CHKDT   Documentation/devicetree/bindings/processed-schema.json
>    SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>    DTEX    Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.example.dts
>    DTC_CHK Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.example.dtb
> 
> v2 --> v3:
> 1. Change vendor from hx to hexin.
> 2. Submit driver and dt-bindings files together.
> 3. Delete pccs-id property. Use alias-id to do this.
> 4. There are at least one interrupt line for the hardware and driver
>    for handling counter overflow.
> 5. Use 4 spaces for example indentation in yaml file.
> 
>  .../bindings/perf/hexin,c2000-arm-ni.yaml     | 51 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/hexin,c2000-arm-ni.yaml
> 
> diff --git a/Documentation/devicetree/bindings/perf/hexin,c2000-arm-ni.yaml b/Documentation/devicetree/bindings/perf/hexin,c2000-arm-ni.yaml
> new file mode 100644
> index 000000000000..b2641ee84d60
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/hexin,c2000-arm-ni.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/perf/hexin,c2000-arm-ni.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HX-C2000 NI (Network-on-chip Interconnect) Performance Monitors
> +
> +maintainers:
> +  - Jialong Yang <jialong.yang@shingroup.cn>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - hexin,c2000-arm-ni

As this seems to be Arm IP, I'd expect arm,ni-700-pmu or something.

Are there Hexin modifications to it?

> +
> +  reg:
> +    items:
> +      - description: Physical address of the base (PERIPHBASE) and
> +          size of the whole NI configuration address space.

Just 'maxItems: 1' if there is only 1 entry.

> +
> +  interrupts:
> +    minItems: 1
> +    items:
> +      - description: Overflow interrupt for clock domain 0
> +      - description: Overflow interrupt for clock domain 1
> +      - description: Overflow interrupt for clock domain 2
> +      - description: Generally, one interrupt line for one PMU. But this also
> +          support one interrupt line for a NI if merged.

I don't understand this last entry.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    aliases {
> +        ni-pmu0 = &nipmu0;

Drop. Please don't make up your own alias names.

> +    };
> +
> +    nipmu0: pmu@23ff0000 {
> +        compatible = "hexin,c2000-arm-ni";
> +        reg = <0x2b420000 0x10000>;
> +        interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4f298c4187fb..4b664cec98a7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18890,6 +18890,12 @@ L:	linux-riscv@lists.infradead.org
>  S:	Maintained
>  F:	arch/riscv/boot/dts/thead/
>  
> +HX ARM-NI-700 PMU DRIVERS
> +M:	Jialong Yang <jialong.yang@shingroup.cn>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/perf/hexin,c2000-arm-ni.yaml
> +F:	drivers/perf/hx_arm_ni.c
> +
>  RNBD BLOCK DRIVERS
>  M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
>  M:	Jack Wang <jinpu.wang@ionos.com>
> -- 
> 2.25.1
> 

