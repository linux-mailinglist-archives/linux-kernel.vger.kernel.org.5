Return-Path: <linux-kernel+bounces-73596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D62085C4D5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809251C2114F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA2714A0BF;
	Tue, 20 Feb 2024 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="KNjFKIBi"
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35D176C89;
	Tue, 20 Feb 2024 19:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708457466; cv=pass; b=D/B8bCd7W3mXuxGGTVBfLDexc2amfjamFpNXMf8gil7lFzbYXSiBkx18j/s3baF1quQ4OKJIrTRchtZwo6+u+L/UGIYdXDjNyS3rupeaKmoWlMPZbfbwKUx7HVd90BmPnoaVJXWk6OGZRecOxyTJgz4QuEc5svOGACDhg1Zqxs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708457466; c=relaxed/simple;
	bh=9gTTjqDg18ZUiHwCjaFkNhYzwUuJi+Ezvidoxxkkl2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8z8uOZLiYouypnmCnv9r+Vu0ASiI6UCWnqYP/hH+12P5keu2+jbCCg0XvEFhBAPPlHabniIp4YmO+/pCDpmWMPZt3+NMX3+8Ftvr71JJXDjtnr9LEpXzhUQEWmpolo4E/u26q/7Cdrbx38fVd8M2voCdaFwy0j96rRWv2a1pQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=KNjFKIBi; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from hillosipuli.retiisi.eu (80-248-247-191.cust.suomicom.net [80.248.247.191])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TfTz24Tssz49PxK;
	Tue, 20 Feb 2024 21:30:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1708457455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6WODeMuYaOON1SJQVtQ5IEATkKOVm+utZXtQv9Iw1EA=;
	b=KNjFKIBiJJgUe4Do+ZujeyokXjlbxMHjT7N3GhuDL/KaEwhf1L7KfqHXnZ9OSuqPeV8ha6
	6KbxNaOCR4OdtxVxyo+S6dc3JGFZxpyZcZrEyT7xBZzj3U62pcJ8Fi1YIjhT40JZJNEM6n
	1r9kKvjW68vxnn9+Bfx+7xRSWHRFVBFlG1SpXfz8VlVvS1mR+po54g81EgLIae2qtQlq5K
	G3i0jePGDk1IcUPw64W0G5aRNbI5yyJuzXe1+FI5pXzorcLofAA4yuKw397V4AcP+hGLwY
	K1TrBTx6fGqu5ofGW0DUPIFDS/GNljWmqz7rwHnNTreSFG63ql6DOsaBLliR+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1708457455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6WODeMuYaOON1SJQVtQ5IEATkKOVm+utZXtQv9Iw1EA=;
	b=U1YCeSP7W4LM1J6E/Zu9UZ/tDVqp2liNJxvdG3Z6YVmpNXWQnN8wPWThgdzBSPLzR52ZTj
	pUwA5sMkVvlHpONd4/8U2WMR86qkkVu8dTpe+wxydZtNiI75cayhl0HwzCCVfj1ZNB5dRZ
	FdAE/Jtmz582eIj+y0Xtb53BHIjMSVeTqcZ2X45ryMugHUzxPCaT7vsyrTFLtXJix9s/Cb
	UTeYZ+Ol37juM2cYiPH5fgJ0Z6HCDBIvD3upoEvu4vlPKgRjfFw4VpYZuKJ3yfDN8xiTLl
	ZRxpf5oniCf4MwQKhZweVTL/NVtJ3wLvXUp/bzomsZklbpE0zsOVAHRcFRvvgQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1708457455; a=rsa-sha256;
	cv=none;
	b=XyJhVY18mh4COcbe10bCzqqUomBCAwlYqQMPLLJg6n9GNj+3sZIudna2ZTxzsweY8i0qEP
	7Psm/C2yc/cgL0xXGh0y0y8awyJi1dCIoXHfcIZ76yCvsws6i0SCa/ph9dzK6GE+ofgA6o
	EuwX9Im0Lohe0ak/khwf1JJR+epxXdFnWd9r9RIdM4CNz583GGfhtyp3HcEgZH2aMdA17T
	4zuMrbePx22g4nps7d11oKvaqtPIxlCy21AJJju6FyiPxDgdfnS76+8oywgldaygMoVkMd
	k9xc51eJxFCWGsIxc96IFP+T7mMonhu+MEL2RexOtlxXOdIyelqAn80tmbL4Ww==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 1FB1D634C93;
	Tue, 20 Feb 2024 21:30:54 +0200 (EET)
Date: Tue, 20 Feb 2024 19:30:53 +0000
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
Message-ID: <ZdT97Szv3yYG9Xbb@valkosipuli.retiisi.eu>
References: <cover.1707677804.git.mehdi.djait.k@gmail.com>
 <13deb8c5cb58e08c1b47decd112b51e8e0b6c4dc.1707677804.git.mehdi.djait.k@gmail.com>
 <Zcta6hhSio67ahKs@valkosipuli.retiisi.eu>
 <ZdTbilKCsMFcjz64@mehdi-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdTbilKCsMFcjz64@mehdi-archlinux>

Hi Mehdi,

On Tue, Feb 20, 2024 at 06:04:10PM +0100, Mehdi Djait wrote:
> Hi Sakari,
> 
> Thank you for the review.

You're welcome!

> 
> On Tue, Feb 13, 2024 at 12:04:58PM +0000, Sakari Ailus wrote:
> > Hi Mehdi,
> > 
> > Thanks for the patchset.
> > 
> > On Sun, Feb 11, 2024 at 08:03:30PM +0100, Mehdi Djait wrote:
> > > From: Mehdi Djait <mehdi.djait@bootlin.com>
> > > 
> > > Add a documentation for the Rockchip Camera Interface binding.
> > > 
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
> > > Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> > > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> > > ---
> > >  .../bindings/media/rockchip,px30-vip.yaml     | 123 ++++++++++++++++++
> > >  1 file changed, 123 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> > > new file mode 100644
> > > index 000000000000..6af4a9b6774a
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> > > @@ -0,0 +1,123 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/media/rockchip,px30-vip.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Rockchip Camera Interface (CIF)
> > > +
> > > +maintainers:
> > > +  - Mehdi Djait <mehdi.djait@bootlin.com>
> > > +
> > > +description:
> > > +  CIF is a camera interface present on some Rockchip SoCs. It receives the data
> > > +  from Camera sensor or CCIR656 encoder and transfers it into system main memory
> > > +  by AXI bus.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: rockchip,px30-vip
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: ACLK
> > > +      - description: HCLK
> > > +      - description: PCLK
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: aclk
> > > +      - const: hclk
> > > +      - const: pclk
> > > +
> > > +  resets:
> > > +    items:
> > > +      - description: AXI
> > > +      - description: AHB
> > > +      - description: PCLK IN
> > > +
> > > +  reset-names:
> > > +    items:
> > > +      - const: axi
> > > +      - const: ahb
> > > +      - const: pclkin
> > > +
> > > +  power-domains:
> > > +    maxItems: 1
> > > +
> > > +  ports:
> > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > +
> > > +    properties:
> > > +      port@0:
> > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > +        unevaluatedProperties: false
> > > +        description: input port on the parallel interface
> > > +
> > > +        properties:
> > > +          endpoint:
> > > +            $ref: video-interfaces.yaml#
> > > +            unevaluatedProperties: false
> > > +
> > > +            properties:
> > > +              bus-type:
> > > +                enum: [5, 6]
> > > +
> > > +            required:
> > > +              - bus-type
> > 
> > What about the vsync-active, hsync-active and data-active properties?
> > Aren't they relevant for this device? Are there default values? This should
> > be part of the bindings for the device, shouldn't it?
> > 
> 
> From what I gathered from the Rockchip PX30 TRM and the other
> available documents from Rockchip, I will add the following:
> 
> diff --git a/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> index 6af4a9b6774a..6920b0cb0507 100644
> --- a/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> +++ b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> @@ -69,6 +69,14 @@ properties:
>                bus-type:
>                  enum: [5, 6]
>  
> +              hsync-active:
> +                enum: [0, 1]
> +                default: 1
> +
> +              vsync-active:
> +                enum: [0, 1]
> +                default: 0

I'd use the same default for both, whether it's 0 or 1.

> +
> 
> @dt-maintainers, @Conor does this warrant a drop of the reviewed-by tags
> in the V14 ?
> 

-- 
Regards,

Sakari Ailus

