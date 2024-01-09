Return-Path: <linux-kernel+bounces-20335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F546827D73
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2455EB22774
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F4C5390;
	Tue,  9 Jan 2024 03:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8X/WAVE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714954418;
	Tue,  9 Jan 2024 03:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FEEC433C7;
	Tue,  9 Jan 2024 03:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704771852;
	bh=7dVhBfoj72xsHQ2yfVCr8QOzBAyZHEiGfUpeWkbrrjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o8X/WAVERCS50ITivwMC8tmQjNyQizua4YXT04dohjGZCuDqmMMIGo3ST5mH0n4nS
	 wdtI4SaJaNfKJYTTydj5JW0Te1ZJTebnIxr0aQfJVQ19RYdYZh6cmwGA48GGJ5GBU0
	 sgb/Ap/hwIs6NClER3bjPiL/JdNifxgvZmigjq4Ez3S2HaBjmFb4f2w5/gOag2/CpZ
	 Ud72sum5Ms+QT9NJtUX073pp7nWFVzVw8UYQX5X4HDy0c/YlQS0N4okMftf3tjuomX
	 N/n2ohUyG86mH2p/sZeT0bQy4VHGZAydhDVodzUt/TNlApBg8329KKF+G476+7R72G
	 LsipTg1Y8nEHw==
Received: (nullmailer pid 2601202 invoked by uid 1000);
	Tue, 09 Jan 2024 03:44:10 -0000
Date: Mon, 8 Jan 2024 20:44:10 -0700
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH v2 3/6] dt-bindings: soc: mobileye: add EyeQ5 OLB system
 controller
Message-ID: <20240109034410.GA2585123-robh@kernel.org>
References: <20231227-mbly-clk-v2-0-a05db63c380f@bootlin.com>
 <20231227-mbly-clk-v2-3-a05db63c380f@bootlin.com>
 <CAL_JsqJD4ZeR+n09gC2fXnk1MFuqO0c0zADSg_-MiY65pck1Yw@mail.gmail.com>
 <CY02002PZ08V.368NYASI51S@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY02002PZ08V.368NYASI51S@bootlin.com>

On Thu, Dec 28, 2023 at 03:57:55PM +0100, Théo Lebrun wrote:
> Hello,
> 
> On Wed Dec 27, 2023 at 7:27 PM CET, Rob Herring wrote:
> > On Wed, Dec 27, 2023 at 10:24 AM Théo Lebrun <theo.lebrun@bootlin.com> wrote:
> > >
> > > Add documentation to describe the "Other Logic Block" syscon.
> > >
> > > Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> > > ---
> > >  .../bindings/soc/mobileye/mobileye,eyeq5-olb.yaml  | 44 ++++++++++++++++++++++
> > >  MAINTAINERS                                        |  1 +
> > >  2 files changed, 45 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.yaml b/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.yaml
> > > new file mode 100644
> > > index 000000000000..b148a49b08f1
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.yaml
> > > @@ -0,0 +1,44 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/soc/mobileye/mobileye,eyeq5-olb.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Mobileye EyeQ5 SoC system controller
> > > +
> > > +maintainers:
> > > +  - Grégory Clement <gregory.clement@bootlin.com>
> > > +  - Théo Lebrun <theo.lebrun@bootlin.com>
> > > +  - Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
> > > +
> > > +description:
> > > +  OLB ("Other Logic Block") is a hardware block grouping smaller blocks. Clocks,
> > > +  resets, pinctrl are being handled from here.
> >
> > I don't see resets or pinctrl in the binding. Please make it complete
> > whether you have the driver or not.
> >
> > As-is, you don't need clocks to be a child node.
> 
> Will do. Would it make sense to have the three drivers be a single
> series? 

You could, but doesn't have to be. Just make the binding complete. 
Whether you have the drivers done is up to you.

> Else we could have the dt-bindings be part of the base platform
> support series[1].
> 
> [1]: https://lore.kernel.org/lkml/20231212163459.1923041-1-gregory.clement@bootlin.com/
> 
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - const: mobileye,eyeq5-olb
> > > +      - const: syscon
> > > +      - const: simple-mfd
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  reg-io-width:
> > > +    const: 4
> >
> > Why do you need this? It is not a generic block and can only ever be 1
> > value.
> 
> This block is still a syscon in the end. I wanted to explicit that
> access width must be 4 bytes and nothing else.
> 
> Does you question mean you think I should be removing it?

Yes. It can be implied by compatible.

Rob

