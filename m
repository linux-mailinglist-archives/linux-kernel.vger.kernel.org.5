Return-Path: <linux-kernel+bounces-149108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681AD8A8BE7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B7AA1C21A0E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B433C22EEB;
	Wed, 17 Apr 2024 19:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2CJEN5G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92D122324;
	Wed, 17 Apr 2024 19:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713381288; cv=none; b=tj2glhTmyvVrbW6qcnABoT7ZXWrebhADf0SzELkEkv5DMtz2rbYBNriW4RkMGvViZGYgWFqL1p9fXTzatamj/jhJFaTVnoD4Lz1nkLermjseGnExz515oGeGXBlx6r8al0eOQl1ok7o43ntCbqTu3lEf/lHdAz3ZqKiYhWRz1Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713381288; c=relaxed/simple;
	bh=a/flBp7hYPf0Kun3Ragy74rejtcqB40x2SVCVKa4trY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyZd9kQ8oBHnx1lcIi1na2duMvcXIE3LJNbkrZc/kohnRCS7uXLeD2SorSOKgGc2ybzVkAZVD6zMryi6nOS5xKprKHSQhcyUwUc45o1k9IOXH4JtenN5moXNbUo7r4/5mpN02iQ28k6A1rxJS5Jft29RHEDHh5ELmo27/j5r3e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2CJEN5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14948C072AA;
	Wed, 17 Apr 2024 19:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713381287;
	bh=a/flBp7hYPf0Kun3Ragy74rejtcqB40x2SVCVKa4trY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N2CJEN5G5R5VAfeGdC+EDkUa4TYHpR24KnWWRGW+FFjvGYB9MU/zKdhXpQ+vbBRdl
	 nrGYFWA6qWS0wxkzGyxcLDi7BG86Qf4yhrYpVzobvGKrL6CChXUr62i+nKEZ7itVJr
	 xC3eSlZF47jp6VgvaGGpk5TIJrS5ps2M+31qb83XZmCSv+ozdUCMKAxBJJNFu+VYXU
	 Pic75JU77c/EnWnxYp246/xeWh/Heqc7dpcW+DG8pNT2bbQiifPJu1PET4Q1+FHcZi
	 yOOrKfxsINGG+tiAQ7KyJvHIHCIC3IUYobsslx1DY2WNVVILO7Sm+XF++37BWarfl4
	 sgEZilsJx+bQQ==
Date: Wed, 17 Apr 2024 14:14:45 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: djakov@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
	broonie@kernel.org, keescook@chromium.org, gustavoars@kernel.org,
	henryc.chen@mediatek.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com,
	wenst@chromium.org, amergnat@baylibre.com
Subject: Re: [PATCH v2 2/7] dt-bindings: interconnect: Add MediaTek EMI
 Interconnect bindings
Message-ID: <20240417191445.GB3101736-robh@kernel.org>
References: <20240417091442.170505-1-angelogioacchino.delregno@collabora.com>
 <20240417091442.170505-3-angelogioacchino.delregno@collabora.com>
 <20240417145402.GA2355631-robh@kernel.org>
 <207eb8d7-1a40-4114-a84b-26616dc39fcc@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <207eb8d7-1a40-4114-a84b-26616dc39fcc@collabora.com>

On Wed, Apr 17, 2024 at 05:32:54PM +0200, AngeloGioacchino Del Regno wrote:
> Il 17/04/24 16:54, Rob Herring ha scritto:
> > On Wed, Apr 17, 2024 at 11:14:37AM +0200, AngeloGioacchino Del Regno wrote:
> > > Add bindings for the MediaTek External Memory Interface Interconnect,
> > > which providers support system bandwidth requirements through Dynamic
> > > Voltage Frequency Scaling Resource Collector (DVFSRC) hardware.
> > > 
> > > This adds bindings for MediaTek MT8183 and MT8195 SoCs.
> > > 
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > ---
> > >   .../interconnect/mediatek,mt8183-emi.yaml     | 76 +++++++++++++++++++
> > >   .../interconnect/mediatek,mt8183.h            | 23 ++++++
> > >   .../interconnect/mediatek,mt8195.h            | 44 +++++++++++
> > >   3 files changed, 143 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/interconnect/mediatek,mt8183-emi.yaml
> > >   create mode 100644 include/dt-bindings/interconnect/mediatek,mt8183.h
> > >   create mode 100644 include/dt-bindings/interconnect/mediatek,mt8195.h
> > > 
> > > diff --git a/Documentation/devicetree/bindings/interconnect/mediatek,mt8183-emi.yaml b/Documentation/devicetree/bindings/interconnect/mediatek,mt8183-emi.yaml
> > > new file mode 100644
> > > index 000000000000..3ad60fd21f83
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/interconnect/mediatek,mt8183-emi.yaml
> > > @@ -0,0 +1,76 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/interconnect/mediatek,mt8183-emi.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: MediaTek External Memory Interface (EMI) Interconnect
> > > +
> > > +maintainers:
> > > +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > +
> > > +description: |
> > > +  EMI interconnect providers support system bandwidth requirements through
> > > +  Dynamic Voltage Frequency Scaling Resource Collector (DVFSRC) hardware.
> > > +  The provider is able to communicate with the DVFSRC through Secure Monitor
> > > +  Call (SMC).
> > > +
> > > +             ICC provider         ICC Nodes
> > > +                              ----          ----
> > > +             _________       |CPU |   |--- |VPU |
> > > +    _____   |         |-----  ----    |     ----
> > > +   |     |->|  DRAM   |       ----    |     ----
> > > +   |DRAM |->|scheduler|----- |GPU |   |--- |DISP|
> > > +   |     |->|  (EMI)  |       ----    |     ----
> > > +   |_____|->|_________|---.   -----   |     ----
> > > +               /|\         `-|MMSYS|--|--- |VDEC|
> > > +                |             -----   |     ----
> > > +                |                     |     ----
> > > +                | change DRAM freq    |--- |VENC|
> > > +             --------                 |     ----
> > > +    SMC --> | DVFSRC |                |     ----
> > > +             --------                 |--- |IMG |
> > > +                                      |     ----
> > > +                                      |     ----
> > > +                                      |--- |CAM |
> > > +                                            ----
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - mediatek,mt8183-emi
> > > +      - mediatek,mt8195-emi
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  '#interconnect-cells':
> > > +    const: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - '#interconnect-cells'
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interconnect/mediatek,mt8195.h>
> > > +
> > > +    soc {
> > > +        #address-cells = <2>;
> > > +        #size-cells = <2>;
> > > +
> > > +        system-controller@10012000 {
> > > +            compatible = "mediatek,mt8195-dvfsrc";
> > > +            reg = <0 0x10012000 0 0x1000>;
> > > +            #address-cells = <1>;
> > > +            #size-cells = <0>;
> > > +
> > > +            emi_icc: interconnect@1 {
> > > +                compatible = "mediatek,mt8195-emi";
> > > +                reg = <1>;
> > > +                #interconnect-cells = <1>;
> > 
> > 
> > There's not really any need for this node. Just put #interconnect-cells
> > in the parent.
> > 
> 
> Actually, I modeled it to be a subnode of the DVFSRC for multiple reasons:
> 
> 1. Some SoCs have more than one interconnect on the DVFSRC (two different kinds
>    of EMI interconnect, and then also a SMI interconnect); and
> 
> 2. Some boards will want to not enable the interconnect driver because some of
>    those are not battery powered (so they just keep the knobs at full thrust
>    from the bootloader and never care scaling busses); and
> 
> 3. Some DVFSRC interconnect features may depend on firmware (but I'm not
>    sure which ones and which SoCs, as there are lots of SMI/EMI ICC things that
>    are not implemented yet with this series).
> 
> The alternative would've been to add a property to enable, or disable, the SMI ICC
> (not present in this series), and/or one, or the other kind of EMI ICC (this series
> implements only the simpler EMI ICC, and I keep saying "the other" because I
> currently don't remember the name).... which is really ugly.
> 
> Ideas? :-)

Just provide that reasoning in the commit msg.

Rob

