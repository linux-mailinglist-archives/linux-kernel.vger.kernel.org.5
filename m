Return-Path: <linux-kernel+bounces-149105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3958A8BE0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB8A1C21450
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2FB24B2F;
	Wed, 17 Apr 2024 19:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IywYCUI1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913EE11712;
	Wed, 17 Apr 2024 19:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713381170; cv=none; b=fjGDEjjErGNUNadBmwS0Zs8nlqAWNeSEkag+SmfnJp2GnqKk3cBmUy19IbolFVhhj7eoNlGnGg+RYOHrYPDjwE9Tz/0XXz9EEQbw2CBJNz0fLh1akyAh4kl99nJzNeg4igHwopPnVI+bKRLSeGxDbPUpGRHbsdkBkG90oMtnTNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713381170; c=relaxed/simple;
	bh=ffcHkuWgg56i0N4KooPmFmdGhTww4OCdeWXSj8ezWUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiRG49nxltdfUS1/eMdYqmA2X5ey6Rd1wwzA8L21NgdTZ/zMTsiCOBh+fahtEMRWxBEUmOO1ETpZSaWF/MomTC2VPSfe8i9FHcWBJP9ZuHM1RQr14+DDk0fIxuDq2+wQ9QIyiYeJNgGPvobEww9PeS+CJF0qezFls1ncpYsLlDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IywYCUI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD3FC072AA;
	Wed, 17 Apr 2024 19:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713381170;
	bh=ffcHkuWgg56i0N4KooPmFmdGhTww4OCdeWXSj8ezWUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IywYCUI1xUqyVE5uPR2b2fC2zXBM4wVg5VQdWrQekJatVr1MLULvXT20s2FF9kW3m
	 c/IyJ6XpnhG/iA0ouqp11xtBYv0NvhqfmXk1EyUMBhLhEqhc0T2mrI3H5m+mJFRLqm
	 N84p+oC5j0wqx5Ng8Tc0el+2W+VSXwwcT8LdE9CZut3YDUQQQxUAij7v6vh92jVfWH
	 U/m84Loaj3bYNPpLteHud9XgExrMaEEBMI8TZth7GEBS69WubmG1FfnCH77hI5nfap
	 lwy70ENbZS82aMQIF+/Cp7UibrtG/ety53QP2loJtpkF3d1fZgET6rM41lR2ObK7I5
	 9shL3VomQL96w==
Date: Wed, 17 Apr 2024 14:12:47 -0500
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
Subject: Re: [PATCH v2 1/7] dt-bindings: regulator: Add bindings for MediaTek
 DVFSRC Regulators
Message-ID: <20240417191247.GA3101736-robh@kernel.org>
References: <20240417091442.170505-1-angelogioacchino.delregno@collabora.com>
 <20240417091442.170505-2-angelogioacchino.delregno@collabora.com>
 <20240417145238.GA2348962-robh@kernel.org>
 <b728478d-d9c9-4256-aeab-a234316d81cc@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b728478d-d9c9-4256-aeab-a234316d81cc@collabora.com>

On Wed, Apr 17, 2024 at 05:39:12PM +0200, AngeloGioacchino Del Regno wrote:
> Il 17/04/24 16:52, Rob Herring ha scritto:
> > On Wed, Apr 17, 2024 at 11:14:36AM +0200, AngeloGioacchino Del Regno wrote:
> > > The Dynamic Voltage and Frequency Scaling Resource Collector Regulators
> > > are controlled with votes to the DVFSRC hardware.
> > > 
> > > This adds support for the regulators found in MT6873, MT8183, MT8192
> > > and MT8195 SoCs.
> > > 
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > ---
> > >   .../mediatek,mt6873-dvfsrc-regulator.yaml     | 71 +++++++++++++++++++
> > >   1 file changed, 71 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml
> > > new file mode 100644
> > > index 000000000000..446f1dab4d2e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml
> > > @@ -0,0 +1,71 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/regulator/mediatek,mt6873-dvfsrc-regulator.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: MediaTek DVFSRC-controlled Regulators
> > > +
> > > +description:
> > > +  The Dynamic Voltage and Frequency Scaling Resource Collector Regulators
> > > +  are controlled with votes to the DVFSRC hardware.
> > > +
> > > +maintainers:
> > > +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - mediatek,mt6873-dvfsrc-regulator
> > > +      - mediatek,mt8183-dvfsrc-regulator
> > > +      - mediatek,mt8192-dvfsrc-regulator
> > > +      - mediatek,mt8195-dvfsrc-regulator
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  dvfsrc-vcore:
> > > +    description: DVFSRC-controlled SoC Vcore regulator
> > > +    $ref: regulator.yaml#
> > 
> >         unevaluatedProperties: false
> > 
> 
> Will do!
> 
> > > +
> > > +  dvfsrc-vscp:
> > > +    description: DVFSRC-controlled System Control Processor regulator
> > > +    $ref: regulator.yaml#
> > 
> > ditto
> > 
> > > +
> > > +required:
> > > +  - compatible
> > 
> > 'reg' is never optional. And how is no regulators at all valid?
> > 
> 
> The two nodes that I'm adding with this series don't need reg, but others
> that are not present in this do... but anyway, let's postpone that problem
> for the future me, or the future-anyone-else implementing the rest, I will
> remove the 'reg' property as it is indeed not needed for this node.

That might have been fine, but now that I know you *will* need it, it 
isn't fine. You could wait 1 week to 6 months to repost and hope I 
forget...

The ideal for these cases is you put the actual sub-range of 
MMIO registers in the child nodes. But sometimes it is just bit soup in 
the register layout and that doesn't work.

> 
> And yeah it's invalid to add that node without any regulator. Will check the
> other regulator bindings on how they're doing it.

'required' or anyOf with a list of required entries.

Rob

