Return-Path: <linux-kernel+bounces-138423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAEC89F107
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99C34B22551
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9465515AACF;
	Wed, 10 Apr 2024 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gwV8VI9P"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA05159571;
	Wed, 10 Apr 2024 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712749320; cv=none; b=XvSwARhR0U/wCT4qxTcmlmPD98qlSEfqPUzYmWrjt6N7oSAeL+93ra7XmVqLo1TRPMBjpkAZ7gyuEN7mE5HKsevUcSi/zjX4Bu1vtPEZlgSHGRJll7VM+SwRTEhCrF2xEwbUKP6Wu5amtD+NWvagZyF+GzHQACUJ+aaAYUe24Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712749320; c=relaxed/simple;
	bh=yG0zg+oeG65EEgQu+xIv2yDk0f6ytD4/gZuu43Ic4NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4pMlFHhzUkeZPQnYI3QM9xbao2WcEyNuOVXRVs43JW07+Y5T1/w3/QTe5Xidyj+t8t1Z8I1UOZ73EabLnIaWvfEf8QJNLJGIUzNxqb5rlhATMc4AhLdX0UuVPydyZHHuZrdew1w2b5LEL/9fA5jOdXNLeH/VeLd8iJolWfXF7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gwV8VI9P; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712749319; x=1744285319;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yG0zg+oeG65EEgQu+xIv2yDk0f6ytD4/gZuu43Ic4NM=;
  b=gwV8VI9PnVRpSydYKE0oX/eIE+Sl9/Qw3OBhX1iHQm54BU2STpf+Ogl5
   FQuIVe12Yr28IWlWNdx171xq0vxbZsv3cV3kjBh9eZ5yGtnum8o/au6O7
   TwyDQ53LexCQ9j+cyNkyy5HnhASD7R413uBAYlHAj4ad+QScFYdLFYXrY
   6J1gtKeEXCtrQB7Ds4cqGIT/97d5DwnpyHoVA26xalrgxEfNmDwLFTUBG
   qxZVj91bsQT1lDk5kJCyHyeZV5/dDfQyeLYX3jH/bn+cpv2qUyUq73pn2
   zHgdEDiqJwUkbY4BZkKmAQP6QumZimyrabILL2NxmVwkySfJvzWyuOgdN
   g==;
X-CSE-ConnectionGUID: 8NC5PeXxQJGULsCwIm1Aww==
X-CSE-MsgGUID: AzMUE8oARhOXVfAxW/EJ4w==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11896320"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11896320"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 04:41:59 -0700
X-CSE-ConnectionGUID: ttzm7WJaR6W2mHtBRovH1Q==
X-CSE-MsgGUID: qfAhKikZTKGbSVdCdieoTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20417691"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 04:41:52 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 93BBD1203E6;
	Wed, 10 Apr 2024 14:41:49 +0300 (EEST)
Date: Wed, 10 Apr 2024 11:41:49 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Conor Dooley <conor@kernel.org>
Cc: Zhi Mao <zhi.mao@mediatek.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Hans de Goede <hdegoede@redhat.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Mehdi Djait <mehdi.djait@bootlin.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, shengnan.wang@mediatek.com,
	yaya.chang@mediatek.com, yunkec@chromium.org, 10572168@qq.com
Subject: Re: [PATCH 1/2] media: dt-bindings: i2c: add Giantec GT97xx VCM
 driver
Message-ID: <ZhZ6_WXfCdwGBdC-@kekkonen.localdomain>
References: <20240410104002.1197-1-zhi.mao@mediatek.com>
 <20240410104002.1197-2-zhi.mao@mediatek.com>
 <20240410-rice-fringe-4ae992217a2f@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410-rice-fringe-4ae992217a2f@spud>

Hi Conor, Zhi,

On Wed, Apr 10, 2024 at 12:27:07PM +0100, Conor Dooley wrote:
> Hey,
> 
> On Wed, Apr 10, 2024 at 06:40:01PM +0800, Zhi Mao wrote:
> > Add YAML device tree binding for GT97xx VCM driver,
> 
> Please don't mention drivers here, bindings are for hardware.
> 
> > and the relevant MAINTAINERS entries.
> > 
> > Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
> > ---
> >  .../bindings/media/i2c/giantec,gt97xx.yaml    | 91 +++++++++++++++++++
> >  1 file changed, 91 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/i2c/giantec,gt97xx.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/media/i2c/giantec,gt97xx.yaml b/Documentation/devicetree/bindings/media/i2c/giantec,gt97xx.yaml
> > new file mode 100644
> > index 000000000000..8c9f1eb4dac8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/i2c/giantec,gt97xx.yaml
> > @@ -0,0 +1,91 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright (c) 2020 MediaTek Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/i2c/giantec,gt97xx.yaml#
> 
> Filename patching compatible please.
> 
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Giantec Semiconductor, Crop. GT97xx Voice Coil Motor (VCM)
> > +
> > +maintainers:
> > +  - Zhi Mao <zhi.mao@mediatek.com>
> > +
> > +description: |-
> > +  The Giantec GT97xx is a 10-bit DAC with current sink capability.
> > +  The DAC is controlled via I2C bus that operates at clock rates up to 1MHz.
> > +  This chip integrates Advanced Actuator Control (AAC) technology
> > +  and is intended for driving voice coil lens in camera modules.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - giantec,gt9768 # for GT9768 VCM
> > +      - giantec,gt9769 # for GT9769 VCM
> 
> I don't think these comments are needed, they should be clear from the
> compatibles, no?
> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  vin-supply: true
> > +
> > +  vdd-supply: true
> > +
> > +  giantec,aac-mode:
> > +    description:
> > +      Indication of AAC mode select.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum:
> > +      - 1    #  AAC2 mode(operation time# 0.48 x Tvib)
> > +      - 2    #  AAC3 mode(operation time# 0.70 x Tvib)
> > +      - 3    #  AAC4 mode(operation time# 0.75 x Tvib)
> > +      - 5    #  AAC8 mode(operation time# 1.13 x Tvib)
> 
> I dislike these enum based properties and I would rather this either be
> the values themselves (0.48, 0.70 etc).
> 
> > +    default: 2
> > +
> > +  giantec,aac-timing:
> > +    description:
> > +      Number of AAC Timing count that controlled by one 6-bit period of
> > +      vibration register AACT[5:0], the unit of which is 100 us.
> 
> Then the property should be in a standard unit of time, not "random" hex
> numbers that correspond to register values.
> 
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 0x20
> > +    minimum: 0x00
> > +    maximum: 0x3f
> > +
> > +  giantec,clock-presc:
> > +    description:
> > +      Indication of VCM internal clock dividing rate select, as one multiple
> > +      factor to calculate VCM ring periodic time Tvib.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum:
> > +      - 0    #  Dividing Rate -  2
> > +      - 1    #  Dividing Rate -  1
> > +      - 2    #  Dividing Rate -  1/2
> > +      - 3    #  Dividing Rate -  1/4
> > +      - 4    #  Dividing Rate -  8
> > +      - 5    #  Dividing Rate -  4
> 
> Same here, you should not need these comments explaining the values, use
> an enum with meaningful values please. 
> 
> > +    default: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vin-supply
> > +  - vdd-supply
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        vcm@c {
> 
> "vcm" is not a generic node-name, can you use one please?
> Look around similar bindings or at the dt spec for generic node-names.

"camera-lens" would seem to be widely used. I can post patches to change
some of the rest out there that aren't aligned.

> 
> Thanks,
> Conor.
> 
> > +            compatible = "giantec,gt9768";
> > +            reg = <0x0c>;
> > +
> > +            vin-supply = <&gt97xx_vin>;
> > +            vdd-supply = <&gt97xx_vdd>;
> > +            giantec,aac-timing = <0x20>;
> > +        };
> > +    };
> > +
> > +...

-- 
Kind regards,

Sakari Ailus

