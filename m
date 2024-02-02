Return-Path: <linux-kernel+bounces-50622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801D1847BC9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5ADE1C23433
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E4483A03;
	Fri,  2 Feb 2024 21:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+sbDsAY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED12D8175F;
	Fri,  2 Feb 2024 21:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706910632; cv=none; b=bCkmCx9X9SWOE6vXEKoapXPQUkIsVWd9PQiQneqtu66GmF5Vtwd7V9qDj4fCOmtCiPUP1ifc/fsqwiQ8mGVKqZwmxiSumJ1ZQFLCLKWVSB56fy3ToP95sabD/pjfDmn703Ddyo8J+8gxBQSud3JRk0Ympot+q5PEMtV3xtdx5Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706910632; c=relaxed/simple;
	bh=hHxaw+nn+YcEJGGK4DNyV7fvRw6Yx8yXT/whi8BAW/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbjJ6YUu+c61xzz7SR1Vbl5MaBZEHjTnYXj5JdV2bil0shqcf8CeZrdjevdnQpo8d15pfZV7EiWTWV8RfoKSOhnRe5l/esTpK90K44NxGbQ11VPCxfeOPuRl6q2tgiraOsSuGj4Ad0ElKeiIC5ej+Ez+AdVCNGGNLNBvVw1Fv1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+sbDsAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490D7C433C7;
	Fri,  2 Feb 2024 21:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706910631;
	bh=hHxaw+nn+YcEJGGK4DNyV7fvRw6Yx8yXT/whi8BAW/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u+sbDsAYLj91MJYJb1fQsbtsO4gd29RCXVuvQUoxe7YVHfcK9q8TubRVA0iuzOYr3
	 QqDrAD7+rYQpfrRtIMFqh3g354/1lWHKYzPFYHb0v5NnyuMz4xWBx3OLJHqpxBUmgl
	 1Fx3FXyi6KKXdN0xkDcgmrvlsN2Ao9dBAlg0YrzyWdAvIRL8NVK8k8gNGPhgiM4/sK
	 Pu7uJFdJwxGs0YXF1H0H5jQq6bPxqi0KTfUGT7a0fjI/R/e2Z/UGrSgfNAyMyXGXOn
	 CFLG9Y+G5xzJuaoe0/zL5vDWNTZT2kWRmqjzVabX6RlFm/GIOOdNzIsEgNfVQ83o6M
	 Q5p2UL+OJd/3w==
Date: Fri, 2 Feb 2024 15:50:29 -0600
From: Rob Herring <robh@kernel.org>
To: Hari Nagalla <hnagalla@ti.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org,
	p.zabel@pengutronix.de, martyn.welch@collabora.com, nm@ti.com,
	vigneshr@ti.com, kristo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/5] dt-bindings: remoteproc: k3-m4f: Add K3 AM64x SoCs
Message-ID: <20240202215029.GA1597859-robh@kernel.org>
References: <20240202175538.1705-1-hnagalla@ti.com>
 <20240202175538.1705-2-hnagalla@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202175538.1705-2-hnagalla@ti.com>

On Fri, Feb 02, 2024 at 11:55:34AM -0600, Hari Nagalla wrote:
> K3 AM64x SoC has a Cortex M4F subsystem in the MCU voltage domain.
> The remote processor's life cycle management and IPC mechanisms are
> similar across the R5F and M4F cores from remote processor driver
> point of view. However, there are subtle differences in image loading
> and starting the M4F subsystems.
> 
> The YAML binding document provides the various node properties to be
> configured by the consumers of the M4F subsystem.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> ---
> Changes since v1:
>  - Spelling corrections
>  - Corrected to pass DT checks
> 
> Changes since v2:
>  - Missed spelling correction to commit message
> 
> Changes since v3:
>  - Removed unnecessary descriptions and used generic memory region names
>  - Made mboxes and memory-region optional
>  - Removed unrelated items from examples
> 
> Changes since v4:
>  - Rebased to the latest kernel-next tree
>  - Added optional sram memory region for m4f device node
> 
> Changes since v5:
>  - None
> 
> Changes since v6:
>  - Removed blank line, fixed type for firm-ware property and binding check
>    errors.
> 
> link to v6:
>   https://lore.kernel.org/all/20230913111644.29889-2-hnagalla@ti.com/
> 
>  .../bindings/remoteproc/ti,k3-m4f-rproc.yaml  | 138 ++++++++++++++++++
>  1 file changed, 138 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
> new file mode 100644
> index 000000000000..645dbce3773b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
> @@ -0,0 +1,138 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/ti,k3-m4f-rproc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI K3 M4F processor subsystems
> +
> +maintainers:
> +  - Hari Nagalla <hnagalla@ti.com>
> +  - Mathieu Poirier <mathieu.poirier@linaro.org>
> +
> +description: |
> +  Some K3 family SoCs have Arm Cortex M4F cores. AM64x is a SoC in K3
> +  family with a M4F core. Typically safety oriented applications may use
> +  the M4F core in isolation without an IPC. Where as some industrial and
> +  home automation applications, may use the M4F core as a remote processor
> +  with IPC communications.
> +
> +$ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,am64-m4fss
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 2
> +
> +  reg:
> +    items:
> +      - description: IRAM internal memory region
> +      - description: DRAM internal memory region
> +
> +  reg-names:
> +    items:
> +      - const: iram
> +      - const: dram
> +
> +  resets:
> +    maxItems: 1
> +
> +  firmware-name:
> +    maxItems: 1
> +    description: Name of firmware to load for the M4F core
> +
> +  mboxes:
> +    description: |

Don't need '|' if no formatting.

> +      OMAP Mailbox specifier denoting the sub-mailbox, to be used for
> +      communication with the remote processor. This property should match
> +      with the sub-mailbox node used in the firmware image.
> +    maxItems: 1
> +
> +  memory-region:
> +    description: |
> +      phandle to the reserved memory nodes to be associated with the
> +      remoteproc device. The reserved memory nodes should be carveout nodes,
> +      and should be defined with a "no-map" property as per the bindings in
> +      Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml

This has moved to dtschema. I'd just drop the file name.

> +      Optional memory regions available for firmware specific purposes.
> +    maxItems: 8
> +    items:
> +      - description: regions used for DMA allocations like vrings, vring buffers
> +                     and memory dedicated to firmware's specific purposes.
> +    additionalItems: true

I think you want just:

minItems: 1
maxItems: 8

> +
> +  sram:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    maxItems: 4
> +    items:
> +      maxItems: 1
> +    description: |
> +      phandles to reserved on-chip SRAM regions. The regions should be
> +      defined as child nodes of the respective SRAM node, and
> +      should be defined as per the generic bindings in,
> +      Documentation/devicetree/bindings/sram/sram.yaml
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - ti,sci
> +  - ti,sci-dev-id
> +  - ti,sci-proc-ids
> +  - resets
> +  - firmware-name
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    reserved-memory {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        mcu_m4fss_dma_memory_region: m4f-dma-memory@9cb00000 {
> +            compatible = "shared-dma-pool";
> +            reg = <0x00 0x9cb00000 0x00 0x100000>;
> +            no-map;
> +        };
> +
> +        mcu_m4fss_memory_region: m4f-memory@9cc00000 {
> +            compatible = "shared-dma-pool";
> +            reg = <0x00 0x9cc00000 0x00 0xe00000>;
> +            no-map;
> +        };
> +    };
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        mailbox0_cluster0: mailbox-0 {
> +            #mbox-cells = <1>;
> +        };
> +
> +        remoteproc@5000000 {
> +            compatible = "ti,am64-m4fss";
> +            reg = <0x00 0x5000000 0x00 0x30000>,
> +                  <0x00 0x5040000 0x00 0x10000>;
> +            reg-names = "iram", "dram";
> +            ti,sci = <&dmsc>;
> +            ti,sci-dev-id = <9>;
> +            ti,sci-proc-ids = <0x18 0xff>;
> +            resets = <&k3_reset 9 1>;
> +            firmware-name = "am62-mcu-m4f0_0-fw";
> +            mboxes = <&mailbox0_cluster0>, <&mbox_m4_0>;
> +            memory-region = <&mcu_m4fss_dma_memory_region>,
> +                            <&mcu_m4fss_memory_region>;
> +            sram = <&oc_sram>;
> +         };
> +    };
> -- 
> 2.34.1
> 

