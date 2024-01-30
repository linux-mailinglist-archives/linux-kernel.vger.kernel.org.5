Return-Path: <linux-kernel+bounces-45174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78820842C74
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4F81F23BFB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E8B7AE55;
	Tue, 30 Jan 2024 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEcaIkvC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8A27AE45;
	Tue, 30 Jan 2024 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641978; cv=none; b=Lvrvl7glBGV4J0I+Joony2D2+bi+3wPE6SeajzGOZTW3X/bMZaZsf6w2Jw+8rvvlFxah4SWaconVmSDpEXo8AaRYzD53N3V72ty/AOGILhNL37HLsTdUBZ9LOw6mPfH5ZVSjQl5fryXDE9uezPm24SsFmw01m4bJpJv/R3i5PgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641978; c=relaxed/simple;
	bh=nEH6/Gsz/g0ZkEX+gtrP7lVR/DRDDEnivsf7uhE+Q3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urpFEXcIGBgvqlBME77JDwC4i+YDuu8QFcCbzllBkcf+aZ+a7A8jZMHsSVuESrLybqp0m/EnnK+RkCpDWKAd0VKKmcFBP8PP/b4duqDLlOHANSvsKhfuywBIe36mMsZ82RlzeoGgsMtnDWrQ1sQcQvlKCpn98aMOzdOSwBLrqUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEcaIkvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3008C433F1;
	Tue, 30 Jan 2024 19:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706641978;
	bh=nEH6/Gsz/g0ZkEX+gtrP7lVR/DRDDEnivsf7uhE+Q3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HEcaIkvCbfbc6JFGId2VCmGC1tw1Hh6yB4i9KzHCCy53Ki1Lg/77lQY5WqUOwCrKf
	 2Gzm+RmhcKoFO1A0uQ/mMkjhErF5N/5db2CBJptWzB2nRNMSZM6ZqKCX973Bmci/Vx
	 ijTfGoJ4HWZBwH04NR7+F8dDlKmsT47vaJjG31gl3R1VHm9AU9ANbIyHDH/I0Ehq5a
	 WFXyFHHw6yXPUrQp/O0pD/h+SbWqVmWjhREwqg7WprbvZXHV4991vODsjdjBEc5sQL
	 J6K7nzcD7/XNlQ2NZ4a9AmHrz3RvdfjmP8gkFcmuMqBh9d4k74w+FEvjAr7mNrV2gP
	 lGESch3GpRfLA==
Date: Tue, 30 Jan 2024 13:12:55 -0600
From: Rob Herring <robh@kernel.org>
To: Dharma.B@microchip.com
Cc: conor@kernel.org, krzk@kernel.org, Manikandan.M@microchip.com,
	andrzej.hajda@intel.com, neil.armstrong@linaro.org,
	rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
	daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Linux4Microchip@microchip.com
Subject: Re: [PATCH 1/3] dt-bindings: display: bridge: add sam9x7-lvds
 compatible
Message-ID: <20240130191255.GA2164257-robh@kernel.org>
References: <20240122082947.21645-1-dharma.b@microchip.com>
 <20240122082947.21645-2-dharma.b@microchip.com>
 <10a88fc6-2c4c-4f77-850f-f15b21a8ed49@kernel.org>
 <20240122-privacy-preschool-27dc7dcc5529@spud>
 <01c4fc05-9b3f-4007-9216-444a4306efd7@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01c4fc05-9b3f-4007-9216-444a4306efd7@microchip.com>

On Tue, Jan 23, 2024 at 03:39:13AM +0000, Dharma.B@microchip.com wrote:
> Hi Conor,
> 
> On 22/01/24 10:07 pm, Conor Dooley wrote:
> > On Mon, Jan 22, 2024 at 04:51:16PM +0100, Krzysztof Kozlowski wrote:
> >> On 22/01/2024 09:29, Dharma Balasubiramani wrote:
> >>> Add the 'sam9x7-lvds' compatible binding, which describes the
> >>> Low Voltage Differential Signaling (LVDS) Controller found on Microchip's
> >>> sam9x7 series System-on-Chip (SoC) devices. This binding will be used to
> >>> define the properties and configuration for the LVDS Controller in DT.
> >>>
> >>> Signed-off-by: Dharma Balasubiramani<dharma.b@microchip.com>
> >>> ---
> >>>   .../display/bridge/microchip,sam9x7-lvds.yaml | 59 +++++++++++++++++++
> >>>   1 file changed, 59 insertions(+)
> >>>   create mode 100644 Documentation/devicetree/bindings/display/bridge/microchip,sam9x7-lvds.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/display/bridge/microchip,sam9x7-lvds.yaml b/Documentation/devicetree/bindings/display/bridge/microchip,sam9x7-lvds.yaml
> >>> new file mode 100644
> >>> index 000000000000..8c2c5b858c85
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/display/bridge/microchip,sam9x7-lvds.yaml
> >>> @@ -0,0 +1,59 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id:http://devicetree.org/schemas/display/bridge/microchip,sam9x7-lvds.yaml#
> >>> +$schema:http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Microchip SAM9X7 LVDS Controller
> >> What is the "X"?
> >>
> >>> +
> >>> +maintainers:
> >>> +  - Dharma Balasubiramani<dharma.b@microchip.com>
> >>> +
> >>> +description: |
> >> Do not need '|' unless you need to preserve formatting.
> >>
> >>> +  The Low Voltage Differential Signaling Controller (LVDSC) manages data
> >>> +  format conversion from the LCD Controller internal DPI bus to OpenLDI
> >>> +  LVDS output signals. LVDSC functions include bit mapping, balanced mode
> >>> +  management, and serializer.
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    const: microchip,sam9x7-lvds
> >> What is "x"? Wildcard? Then no, don't use it and instead use proper SoC
> >> version number.
> > These SoCs actually do have an x in their name. However, and I do always
> > get confused here, the sam9x7 is a series of SoCs (the cover letter does
> > say this) rather than a specific device.
> > I think the series current consists of a sam9x70 sam9x72 and a sam9x75.
> > The devices are largely similar, but I am not sure if the sam9x70
> > supports LVDS at all. Having a compatible for the series does not seem
> > correct to me.
> Yes, you are correct. Only sam9x72 and sam9x75 have LVDS support, while 
> sam9x70 does not. I will revise the compatibility to include both 
> sam9x72 and sam9x75, as outlined below:
> 
> properties:
>    compatible:
>      enum:
>        - microchip,sam9x72-lvds
>        - microchip,sam9x75-lvds

I would presume these 2 are the same, but the above implies they 
aren't. I think what you had is fine assuming these are all 
fundamentally the same part with just packaging or fused off h/w 
differences.

Rob

