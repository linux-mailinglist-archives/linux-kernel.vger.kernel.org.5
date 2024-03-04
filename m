Return-Path: <linux-kernel+bounces-91121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EC18709C3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5CE828A990
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE2278B41;
	Mon,  4 Mar 2024 18:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rahm3Kp4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D3F3F9FD;
	Mon,  4 Mar 2024 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577635; cv=none; b=ggziK9t+BcNNKvZ/I/cMegw+lGhVc21IcrDPV6vVwwbgQf8XN1gukH5UYl3B/HN1zlTWbDF22B5TfivnHmn11n8XO/KUIkUd70Z2fA3/urdraHUL/4kQkYgeh+8HuxFcUqjmREgj2D1C3ZohMDpSjS3cMwU0o5xJIKmEiPbf8IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577635; c=relaxed/simple;
	bh=7vh4iyPXOaOgnr49RuHWi1jSWORQ0cB+J4ov6rz10CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYTE8JKASTqNRpTlXLSn0+lXdx+aFwoyR6nY2iWiqZ5LuOddNpKCvzHJLBMhaZch+EhXEBrKN5yV/toqTl8/ZRG9RSny8rgZey+V2O/SciLQlnqAHsr2Tnk/eYJqR0mElViIEAj8Zf1U1J7l6lUboO/hMBbOeV3WWucX7qNOWcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rahm3Kp4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE45C433C7;
	Mon,  4 Mar 2024 18:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709577635;
	bh=7vh4iyPXOaOgnr49RuHWi1jSWORQ0cB+J4ov6rz10CY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rahm3Kp4K15IbjidKWNlUNUEbKT1XAqkt9tB2YlZqVXTPrYMa7IrMt9UxN9cdRdNV
	 SN11popSbGR9Ujlg49wTuKDZt+EamtXziRhi8KU/S+hDlGQnWrqVphkVFPEHUuGZPJ
	 yPfDZ5aTeI8vOWndAXulFV010eWAwduB5upNgWONQ5GPHc4oKw0u1WAfh/2cq7pr5h
	 Sl19wQvMPbJD1dPFmX0FBDRfoZJTSErer8kIc1ZA2gENu2NxMa5z5u8NZWb0SJEcyf
	 URAMwAd5p/K/u7NZXL7FljcG9XsfE402zSdX00M4Z7mBWprpZ2NhNgtMYvqGk2Gscj
	 a+Do5D6CO5Suw==
Date: Mon, 4 Mar 2024 12:40:32 -0600
From: Rob Herring <robh@kernel.org>
To: Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Lee Jones <lee@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: convert st,stih407-thermal
 to DT schema
Message-ID: <20240304184032.GA865748-robh@kernel.org>
References: <20240301-thermal-v2-0-1b32752029ec@gmail.com>
 <20240301-thermal-v2-1-1b32752029ec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301-thermal-v2-1-1b32752029ec@gmail.com>

On Fri, Mar 01, 2024 at 06:47:28PM +0100, Raphael Gallais-Pou wrote:
> 'st,passive_colling_temp' does not appear in the device-tree, and 'reg'
> is missing in the device description.
> 
> Convert st,stih407-thermal binding to DT schema format in order to clean
> unused 'st,passive_cooling_temp' and add missing 'reg' property.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
> Changes in v2:
>   - Change commit log to use imperative
>   - Drop description
>   - Drop 'clocks' description
>   - Add 'reg' property
>   - Add '#thermal-sensor-cells'
>   - Make node name generic in example
>   - Fix YAML style
> ---
>  .../bindings/thermal/st,stih407-thermal.yaml       | 56 ++++++++++++++++++++++
>  .../devicetree/bindings/thermal/st-thermal.txt     | 32 -------------
>  2 files changed, 56 insertions(+), 32 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/st,stih407-thermal.yaml b/Documentation/devicetree/bindings/thermal/st,stih407-thermal.yaml
> new file mode 100644
> index 000000000000..68d7dd8b892f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/st,stih407-thermal.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/st,stih407-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STi digital thermal sensor (DTS)
> +
> +maintainers:
> +  - Patrice Chotard <patrice.chotard@foss.st.com>
> +  - Lee Jones <lee@kernel.org>
> +
> +allOf:
> +  - $ref: thermal-sensor.yaml
> +
> +properties:
> +  compatible:
> +    const: st,stih407-thermal
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: thermal
> +
> +  interrupts:
> +    description:
> +      For thermal sensors for which no interrupt has been defined, a polling
> +      delay of 1000ms will be used to read the temperature from device.

maxItems: 1

> +
> +  '#thermal-sensor-cells': true

const: 1

Also, not in the original binding, so please state in the commit msg 
why you are adding it.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    temperature-sensor@91a0000 {
> +        compatible = "st,stih407-thermal";
> +        reg = <0x91a0000 0x28>;
> +        clock-names = "thermal";
> +        clocks = <&CLK_SYSIN>;
> +        interrupts = <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>;
> +        #thermal-sensor-cells = <0>;
> +    };
> +...

