Return-Path: <linux-kernel+bounces-45380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4A9842F7D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529EE1C21D8E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBF414AAA;
	Tue, 30 Jan 2024 22:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubGcfklL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7131778668;
	Tue, 30 Jan 2024 22:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706653078; cv=none; b=s9IOA2LFlvm58H/6j/Dt5iWWP9ZRMfnqduqwgTGmKDw6QKuszMXxpU2fNp1/LMFJS1lAnXwj4hgNI6zY8CNj8pORui2pr/lO5vImsPQxkzcfiwROFQLhykQYXVM2ls0qC9uxwbZCDe0zwcKgCtPzRMhTIYMR3JJYGIyv7CldA+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706653078; c=relaxed/simple;
	bh=rrbS86yWKtKwf2JST8tAiq0hVinxLgByUQZBaLuxEjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9bLkRUuguV5ZC4Tr+NxxNogK1QrOy58dVMiGUTSy6VhaV56qd+LakmkuP6xywRwxR4b9MSUuRAWUYM8JasWXtAI/Ax5V2XzD2JLj8R4j1AEL1aAWc7Dw9ihXtJ0fU1d6+ekeRfjAmgWHjKcUVWt6M/+3catQcaOIociP4PCFsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubGcfklL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77C0C433C7;
	Tue, 30 Jan 2024 22:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706653077;
	bh=rrbS86yWKtKwf2JST8tAiq0hVinxLgByUQZBaLuxEjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ubGcfklLpeat/MNboEac2hVYLFpSz/WC9Lkb3LLWvH639W4w7Jbn/ST7UpL3KqhpK
	 1SoNM3AKt+QXvf9LIPTH7c3MzgeMBDEzVKIjliaeslzAPNo2cef0qLaKcePn+N/R8h
	 +2qDHFlx/xsEliwbEkQWx8/1wc9+uv3ORTMz85FCXaMHctMEz/y2eBijwCAy8OYRrw
	 +rfUlsimlRf/RFha1qTupiwHIsudKBNgqkr7i4krtYjfakb2M3si8KdBhTq0UalmSU
	 sOlfLVfAqKHVe5cmjFShMVc/Tyw/OLzkqzdhKA0xEw98io8G1VQFhy0MdqWYzVoSC8
	 iRgrmUO2QI6UA==
Date: Tue, 30 Jan 2024 16:17:55 -0600
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Wenhua Lin <Wenhua.Lin@unisoc.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	wenhua lin <wenhua.lin1994@gmail.com>,
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>,
	zhaochen su <zhaochen.su29@gmail.com>,
	Zhaochen Su <Zhaochen.Su@unisoc.com>,
	Xiaolong Wang <Xiaolong.Wang@unisoc.com>
Subject: Re: [PATCH V2 4/6] dt-bindings: pwm: sprd: Convert to YAML
Message-ID: <20240130221755.GA2514791-robh@kernel.org>
References: <20240125025533.10315-1-Wenhua.Lin@unisoc.com>
 <20240125025533.10315-5-Wenhua.Lin@unisoc.com>
 <20240125-sleeve-defeat-61f74942e2d9@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125-sleeve-defeat-61f74942e2d9@spud>

On Thu, Jan 25, 2024 at 05:31:48PM +0000, Conor Dooley wrote:
> Hey,
> 
> On Thu, Jan 25, 2024 at 10:55:31AM +0800, Wenhua Lin wrote:
> > Convert Spreadtrum PWM controller bindings to DT schema.
> > 
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> > ---
> >  .../devicetree/bindings/pwm/pwm-sprd.txt      | 40 --------
> >  .../devicetree/bindings/pwm/pwm-sprd.yaml     | 93 +++++++++++++++++++
> >  2 files changed, 93 insertions(+), 40 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-sprd.txt
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sprd.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sprd.txt b/Documentation/devicetree/bindings/pwm/pwm-sprd.txt
> > deleted file mode 100644
> > index 87b206fd0618..000000000000
> > --- a/Documentation/devicetree/bindings/pwm/pwm-sprd.txt
> > +++ /dev/null
> > @@ -1,40 +0,0 @@
> > -Spreadtrum PWM controller
> > -
> > -Spreadtrum SoCs PWM controller provides 4 PWM channels.
> > -
> > -Required properties:
> > -- compatible : Should be "sprd,ums512-pwm".
> > -- reg: Physical base address and length of the controller's registers.
> > -- clocks: The phandle and specifier referencing the controller's clocks.
> > -- clock-names: Should contain following entries:
> > -  "pwmn": used to derive the functional clock for PWM channel n (n range: 0 ~ 3).
> > -  "enablen": for PWM channel n enable clock (n range: 0 ~ 3).
> > -- #pwm-cells: Should be 2. See pwm.yaml in this directory for a description of
> > -  the cells format.
> > -
> > -Optional properties:
> > -- assigned-clocks: Reference to the PWM clock entries.
> > -- assigned-clock-parents: The phandle of the parent clock of PWM clock.
> > -
> > -Example:
> > -	pwms: pwm@32260000 {
> > -		compatible = "sprd,ums512-pwm";
> > -		reg = <0 0x32260000 0 0x10000>;
> > -		clock-names = "pwm0", "enable0",
> > -			"pwm1", "enable1",
> > -			"pwm2", "enable2",
> > -			"pwm3", "enable3";
> > -		clocks = <&aon_clk CLK_PWM0>, <&aonapb_gate CLK_PWM0_EB>,
> > -		       <&aon_clk CLK_PWM1>, <&aonapb_gate CLK_PWM1_EB>,
> > -		       <&aon_clk CLK_PWM2>, <&aonapb_gate CLK_PWM2_EB>,
> > -		       <&aon_clk CLK_PWM3>, <&aonapb_gate CLK_PWM3_EB>;
> > -		assigned-clocks = <&aon_clk CLK_PWM0>,
> > -			<&aon_clk CLK_PWM1>,
> > -			<&aon_clk CLK_PWM2>,
> > -			<&aon_clk CLK_PWM3>;
> > -		assigned-clock-parents = <&ext_26m>,
> > -			<&ext_26m>,
> > -			<&ext_26m>,
> > -			<&ext_26m>;
> > -		#pwm-cells = <2>;
> > -	};
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sprd.yaml b/Documentation/devicetree/bindings/pwm/pwm-sprd.yaml
> > new file mode 100644
> > index 000000000000..81c5fd688c3c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-sprd.yaml
> > @@ -0,0 +1,93 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright 2023 Unisoc Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/pwm-sprd.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Spreadtrum PWM controller
> > +
> > +maintainers:
> > +  - Orson Zhai <orsonzhai@gmail.com>
> > +  - Baolin Wang <baolin.wang7@gmail.com>
> > +  - Chunyan Zhang <zhang.lyra@gmail.com>
> > +
> > +description: |
> 
> The | here is not need, you have no formatting to preserve.
> 
> > +  Spreadtrum SoCs PWM controller provides 4 PWM channels.
> > +
> > +allOf:
> > +  - $ref: pwm.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - sprd,ums512-pwm
> 
> this is just
> 
> compatible:
>   const: sprd,ums512-pwm
> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 8
> > +    maxItems: 8
> > +
> > +  clock-names:
> > +    items:
> > +      - const: pwm0
> > +      - const: enable0
> > +      - const: pwm1
> > +      - const: enable1
> > +      - const: pwm2
> > +      - const: enable2
> > +      - const: pwm3
> > +      - const: enable3
> 
> > +    description: |
> > +      Should contain following entries:
> > +      "pwmn": used to derive the functional clock for PWM channel n (n range: 0 ~ 3).
> > +      "enablen": for PWM channel n enable clock (n range: 0 ~ 3).
> 
> I would drop this description from here, and create an items list under
> clocks, describing each clock. You can then drop the "minItems: 8" &
> "maxItems: 8" from there.
> 
> > +
> > +  assigned-clocks:
> > +    minItems: 4
> > +    maxItems: 4
> > +
> > +  assigned-clock-parents:
> > +    minItems: 4
> > +    maxItems: 4

Also, drop assigned-clock* here and from the example. It's outside the 
scope of bindings.

Rob

