Return-Path: <linux-kernel+bounces-74574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E87885D629
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165CC1F23BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B98C3F8ED;
	Wed, 21 Feb 2024 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="RXDUnqSJ"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093B83EA93;
	Wed, 21 Feb 2024 10:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513094; cv=pass; b=Pn2CZBoSW23MYJ3KfDH3NsPDX1QuabSfMrQcWfRgGy4J/dyi4I9yH/Xb/GJsN7NWDm42nPjHVTYvsUnn9bLWXZ5nqkxj2uXDfdpAfl1x9Xh2nlyUrJEE1BXOIO4F7Epc18WwaqAJjwxvJ4mW2C39WzdT84CrVGZ5hACkBka/IkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513094; c=relaxed/simple;
	bh=o8sYnoTQvODKPsJ5eLmeJIo3Vkg1AHBr3FnhQry1IJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNDI0YQo7E5n86kOS2jzxipXxhC5uKWWHxLQqnInB1goH8cIDWqJWWjXLy3bj2KB3DHt37kdvbSq3hWHdI8TSW9/nOvJetK6qKSl4Mo2BLlnp9AWykZZwNdn8VR6yOn5Dez6ra8Jv2ll4EuvQg3OeZowlvmoU7uH3M6QBDSIDv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=RXDUnqSJ; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from hillosipuli.retiisi.eu (2a00-1190-d1dd-0-c641-1eff-feae-163c.v6.cust.suomicom.net [IPv6:2a00:1190:d1dd:0:c641:1eff:feae:163c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4TftXm5q20zyRj;
	Wed, 21 Feb 2024 12:58:00 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1708513083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VflWzHR2epedex4fdVA6CCyN8VAZ75HPYtEERrituog=;
	b=RXDUnqSJFv3hpYNEpxvGSu7gqWhh0ujUdsdT4YCJ4dDWESvOzAM5eqvZPrjcRCCcjsE8ra
	SThL5MHDt7PIeiVjLDSqKME8DxlHb74mG0tgBLnF4L+EJhS0lwWZh+KrcRhM45xaVKTo9J
	ZvSeLATKC5eCBBgoF8H0dRMfGBpXgUY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1708513083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VflWzHR2epedex4fdVA6CCyN8VAZ75HPYtEERrituog=;
	b=o1wxzSlssOm48b1EhrHj0rsBX7CX/GSH7Or4RkiN6FPA5wFLiLFP0mcG1NkxT0K25z7V+7
	8wgpV4nuhyCd35ikGsp3CRc3QKgBdm6HoSin4dZwEal6VS2jLWqfpD7L2bljcN0WBlJ926
	uM0zgj1+8m7C5a33uoX19/3aAo0M9Hg=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1708513083; a=rsa-sha256; cv=none;
	b=uE2cKX6w2Endr4JLi6v7mx6NOaOpXQ0ZzEzFrb42PbN54KgbvPwp/RWwdaSowkQXTVcGrx
	ojmewYuUzp/WY6qeSfZYgVe7Ki/20jJogiMEIxrTGpryQVz9XEfeZ8RLro5RzDqn79EWZH
	AfR3TyKMOtGuDl0MSBAzDuMkOmaYbSU=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 36092634C93;
	Wed, 21 Feb 2024 12:57:59 +0200 (EET)
Date: Wed, 21 Feb 2024 10:57:58 +0000
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Mehdi Djait <mehdi.djait.k@gmail.com>
Cc: mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
	conor+dt@kernel.org, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
	maxime.chevallier@bootlin.com, paul.kocialkowski@bootlin.com,
	michael.riesch@wolfvision.net, laurent.pinchart@ideasonboard.com,
	Mehdi Djait <mehdi.djait@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [RESEND Patch v13 1/3] media: dt-bindings: media: add bindings
 for Rockchip CIF
Message-ID: <ZdXXNvGl-2CZdnhk@valkosipuli.retiisi.eu>
References: <cover.1707677804.git.mehdi.djait.k@gmail.com>
 <13deb8c5cb58e08c1b47decd112b51e8e0b6c4dc.1707677804.git.mehdi.djait.k@gmail.com>
 <Zcta6hhSio67ahKs@valkosipuli.retiisi.eu>
 <ZdTbilKCsMFcjz64@mehdi-archlinux>
 <ZdT97Szv3yYG9Xbb@valkosipuli.retiisi.eu>
 <ZdUQBl5pkFg2i1iu@mehdi-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdUQBl5pkFg2i1iu@mehdi-archlinux>

Hi Mehdi,

On Tue, Feb 20, 2024 at 09:48:06PM +0100, Mehdi Djait wrote:
> Hi Sakari,
> 
> On Tue, Feb 20, 2024 at 07:30:53PM +0000, Sakari Ailus wrote:
> > Hi Mehdi,
> > 
> > On Tue, Feb 20, 2024 at 06:04:10PM +0100, Mehdi Djait wrote:
> > > Hi Sakari,
> > > 
> > > Thank you for the review.
> > 
> > You're welcome!
> > 
> > > 
> > > On Tue, Feb 13, 2024 at 12:04:58PM +0000, Sakari Ailus wrote:
> > > > Hi Mehdi,
> > > > 
> > > > Thanks for the patchset.
> > > > 
> > > > On Sun, Feb 11, 2024 at 08:03:30PM +0100, Mehdi Djait wrote:
> > > > > From: Mehdi Djait <mehdi.djait@bootlin.com>
> > > > > 
> > > > > Add a documentation for the Rockchip Camera Interface binding.
> > > > > 
> > > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > > Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
> > > > > Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> > > > > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> > > > > ---
> > > > >  .../bindings/media/rockchip,px30-vip.yaml     | 123 ++++++++++++++++++
> > > > >  1 file changed, 123 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..6af4a9b6774a
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> > > > > @@ -0,0 +1,123 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/media/rockchip,px30-vip.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Rockchip Camera Interface (CIF)
> > > > > +
> > > > > +maintainers:
> > > > > +  - Mehdi Djait <mehdi.djait@bootlin.com>
> > > > > +
> > > > > +description:
> > > > > +  CIF is a camera interface present on some Rockchip SoCs. It receives the data
> > > > > +  from Camera sensor or CCIR656 encoder and transfers it into system main memory
> > > > > +  by AXI bus.
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    const: rockchip,px30-vip
> > > > > +
> > > > > +  reg:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  interrupts:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  clocks:
> > > > > +    items:
> > > > > +      - description: ACLK
> > > > > +      - description: HCLK
> > > > > +      - description: PCLK
> > > > > +
> > > > > +  clock-names:
> > > > > +    items:
> > > > > +      - const: aclk
> > > > > +      - const: hclk
> > > > > +      - const: pclk
> > > > > +
> > > > > +  resets:
> > > > > +    items:
> > > > > +      - description: AXI
> > > > > +      - description: AHB
> > > > > +      - description: PCLK IN
> > > > > +
> > > > > +  reset-names:
> > > > > +    items:
> > > > > +      - const: axi
> > > > > +      - const: ahb
> > > > > +      - const: pclkin
> > > > > +
> > > > > +  power-domains:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  ports:
> > > > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > > > +
> > > > > +    properties:
> > > > > +      port@0:
> > > > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > > > +        unevaluatedProperties: false
> > > > > +        description: input port on the parallel interface
> > > > > +
> > > > > +        properties:
> > > > > +          endpoint:
> > > > > +            $ref: video-interfaces.yaml#
> > > > > +            unevaluatedProperties: false
> > > > > +
> > > > > +            properties:
> > > > > +              bus-type:
> > > > > +                enum: [5, 6]
> > > > > +
> > > > > +            required:
> > > > > +              - bus-type
> > > > 
> > > > What about the vsync-active, hsync-active and data-active properties?
> > > > Aren't they relevant for this device? Are there default values? This should
> > > > be part of the bindings for the device, shouldn't it?
> > > > 
> > > 
> > > From what I gathered from the Rockchip PX30 TRM and the other
> > > available documents from Rockchip, I will add the following:
> > > 
> > > diff --git a/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> > > index 6af4a9b6774a..6920b0cb0507 100644
> > > --- a/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> > > +++ b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> > > @@ -69,6 +69,14 @@ properties:
> > >                bus-type:
> > >                  enum: [5, 6]
> > >  
> > > +              hsync-active:
> > > +                enum: [0, 1]
> > > +                default: 1
> > > +
> > > +              vsync-active:
> > > +                enum: [0, 1]
> > > +                default: 0
> > 
> > I'd use the same default for both, whether it's 0 or 1.
> > 
> 
> Is this supposed to be the default value HIGH or LOW if it is not
> configured by the driver ? because the manual states the following:
> 
> HREF_POL
> Href input polarity:
> 1'b0 : high active
> 1'b1 : low active
> RESET VALUE: 0x0
> 
> VSYNC_POL
> Vsync input polarity:
> 1'b0 : low active
> 1'b1 : high active
> RESET VALUE: 0x0
> 
> And that's why I chose 1 for hsync and 0 for vsync

The hardware reset values do not have to reflect defaults in DT bindings.

-- 
Kind regards,

Sakari Ailus

