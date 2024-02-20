Return-Path: <linux-kernel+bounces-73693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCD285C60D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713F7283913
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286BF14F9E7;
	Tue, 20 Feb 2024 20:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQeWLIMO"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA3B1FDB;
	Tue, 20 Feb 2024 20:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708462094; cv=none; b=D6G4WriPWCU2g6BT7wQ/y2rJQ6xbhdlLxIHQyNCRl/aYsj8uiwDysHSEYthNWMGcnH99KhiZTabpwEuNk+FTPHvI/OV/Q7nsf7goHh/FYLfn2jcU9xxgqioXo7dFs9615EUm6r3TVqRd6RJE+knqmZGjGIS8eC9XEhfnQLmrSWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708462094; c=relaxed/simple;
	bh=j0ysc+Du9hkfIMh8HUnhXGfu34k2JquJQ3Y/AbVNJPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KF5pJBHs0uskZRVsYqUpeltyAyhVnKSiK8BlcKnP+Hg7GcspbtH2FB4qL+cvaGuBDX0ulrTwwus7XUc6+JUf/73jedbJtOCl1mWLMrAOyhEBegIxF3LNxe3f8ZltvTOioy4uLVIHGXuvqNry5FNsmXPDauSXwpX0+500OyuWpg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQeWLIMO; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-511976c126dso7260989e87.1;
        Tue, 20 Feb 2024 12:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708462089; x=1709066889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=exlHopiBCxUlDxBa3rdzATJoG3CThCTdOcxqsDekfXg=;
        b=AQeWLIMO4LTWpoUlNgc/j+uWHu2u+qqK7LPMJLOKG2zSpI2xydQ+Oa1gF74feO8ueb
         C32N/MBYdMxoA6SJ/33HGbbJuJxJMB0FhipLzaGntHujqj3ebMVsQRlhtIOzjezrDqPL
         5EBODQuLOVJQK6B0yTQ7vUa77tLAybD5gWnKbuN9PyFkc5E29M/CA62fo2srzHE+Rht3
         okBocDMg+PRy4FOcC/fEbj9Y/GVsL0do7SuQGEBTwWWg6XIC/FA3sNIPtW99HmKQQ+2O
         mw1ze3syiD3ZkTxpvDyHS/P5qZUxzjIQmqgzo39y9ZqffxU+uua0ael0lww4w9IG1VtV
         KKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708462089; x=1709066889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exlHopiBCxUlDxBa3rdzATJoG3CThCTdOcxqsDekfXg=;
        b=b0yUPcXVPOWVMMpePGkOUmRiiB1HmHOyUGKnSdLPRGSgEm5nRlEFfSbw2FTNR9LjrP
         Wx+3DQ1Pfv+Qa/necNeuaAE5SGNxju57ozGcGBeR3PHWwzAiSZSUDZMyRVAuw2ZVgAvt
         mFPFJ8MaFbh/AUQDwOR5ERF+IXINWkxP4xW+EOgEqEqItLjVnIxdVn0sPkRFOYjj9XH4
         vNLOwiM5qnrd4xgeJcyn2SZh2Cp9oNssgzyfkUpslve9u89ZnujG3F0aD10nA2iAWEDJ
         GeYVszeO/U8nLFkjZestyuJ8JTZbqfN6uq2N1I5kg7l0sCm75UjfbeAVMkFFPOhfxccy
         tIGg==
X-Forwarded-Encrypted: i=1; AJvYcCUI/DNo9r1yyfet4YP9K71ExiaGqIWnPcQEBvqYQYHPBTl2nodn5scRWw+lCQfAgB+EYzki02ndltTr2dNd7RFeCkjLXtoDGIBNzpZjC169i2uUgPuGmfgRVF8D4tSO/yEQUouumUrAqxT6szX2nEF29iK31UkWO88Ct+XtwKX/FTeb9ocN
X-Gm-Message-State: AOJu0Yxgfsfdp1nGJ84FVGg9wBI4/le75WB9hDE0z/LenL8Z/WX6TI3w
	upqOTB4rP4FCkvX3OvOAD4qezZpYLzH2kulVv1ZpEnOqISgCwHkZ
X-Google-Smtp-Source: AGHT+IE73qiEzH0d1j0hNf9G9egIYVPu4qy5uKnmXliXp4xtPPtk7+MSFbxE1v7/YuaZgPUsxO/vNg==
X-Received: by 2002:a05:6512:3e05:b0:512:8811:5d8f with SMTP id i5-20020a0565123e0500b0051288115d8fmr12474041lfv.65.1708462089249;
        Tue, 20 Feb 2024 12:48:09 -0800 (PST)
Received: from mehdi-archlinux ([2a02:8109:aa27:2d00::d069])
        by smtp.gmail.com with ESMTPSA id r21-20020a50d695000000b00563f3ee5003sm4180759edi.91.2024.02.20.12.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 12:48:08 -0800 (PST)
Date: Tue, 20 Feb 2024 21:48:06 +0100
From: Mehdi Djait <mehdi.djait.k@gmail.com>
To: Sakari Ailus <sakari.ailus@iki.fi>
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
Message-ID: <ZdUQBl5pkFg2i1iu@mehdi-archlinux>
References: <cover.1707677804.git.mehdi.djait.k@gmail.com>
 <13deb8c5cb58e08c1b47decd112b51e8e0b6c4dc.1707677804.git.mehdi.djait.k@gmail.com>
 <Zcta6hhSio67ahKs@valkosipuli.retiisi.eu>
 <ZdTbilKCsMFcjz64@mehdi-archlinux>
 <ZdT97Szv3yYG9Xbb@valkosipuli.retiisi.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdT97Szv3yYG9Xbb@valkosipuli.retiisi.eu>

Hi Sakari,

On Tue, Feb 20, 2024 at 07:30:53PM +0000, Sakari Ailus wrote:
> Hi Mehdi,
> 
> On Tue, Feb 20, 2024 at 06:04:10PM +0100, Mehdi Djait wrote:
> > Hi Sakari,
> > 
> > Thank you for the review.
> 
> You're welcome!
> 
> > 
> > On Tue, Feb 13, 2024 at 12:04:58PM +0000, Sakari Ailus wrote:
> > > Hi Mehdi,
> > > 
> > > Thanks for the patchset.
> > > 
> > > On Sun, Feb 11, 2024 at 08:03:30PM +0100, Mehdi Djait wrote:
> > > > From: Mehdi Djait <mehdi.djait@bootlin.com>
> > > > 
> > > > Add a documentation for the Rockchip Camera Interface binding.
> > > > 
> > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
> > > > Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> > > > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> > > > ---
> > > >  .../bindings/media/rockchip,px30-vip.yaml     | 123 ++++++++++++++++++
> > > >  1 file changed, 123 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> > > > new file mode 100644
> > > > index 000000000000..6af4a9b6774a
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> > > > @@ -0,0 +1,123 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/media/rockchip,px30-vip.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Rockchip Camera Interface (CIF)
> > > > +
> > > > +maintainers:
> > > > +  - Mehdi Djait <mehdi.djait@bootlin.com>
> > > > +
> > > > +description:
> > > > +  CIF is a camera interface present on some Rockchip SoCs. It receives the data
> > > > +  from Camera sensor or CCIR656 encoder and transfers it into system main memory
> > > > +  by AXI bus.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: rockchip,px30-vip
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupts:
> > > > +    maxItems: 1
> > > > +
> > > > +  clocks:
> > > > +    items:
> > > > +      - description: ACLK
> > > > +      - description: HCLK
> > > > +      - description: PCLK
> > > > +
> > > > +  clock-names:
> > > > +    items:
> > > > +      - const: aclk
> > > > +      - const: hclk
> > > > +      - const: pclk
> > > > +
> > > > +  resets:
> > > > +    items:
> > > > +      - description: AXI
> > > > +      - description: AHB
> > > > +      - description: PCLK IN
> > > > +
> > > > +  reset-names:
> > > > +    items:
> > > > +      - const: axi
> > > > +      - const: ahb
> > > > +      - const: pclkin
> > > > +
> > > > +  power-domains:
> > > > +    maxItems: 1
> > > > +
> > > > +  ports:
> > > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > > +
> > > > +    properties:
> > > > +      port@0:
> > > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > > +        unevaluatedProperties: false
> > > > +        description: input port on the parallel interface
> > > > +
> > > > +        properties:
> > > > +          endpoint:
> > > > +            $ref: video-interfaces.yaml#
> > > > +            unevaluatedProperties: false
> > > > +
> > > > +            properties:
> > > > +              bus-type:
> > > > +                enum: [5, 6]
> > > > +
> > > > +            required:
> > > > +              - bus-type
> > > 
> > > What about the vsync-active, hsync-active and data-active properties?
> > > Aren't they relevant for this device? Are there default values? This should
> > > be part of the bindings for the device, shouldn't it?
> > > 
> > 
> > From what I gathered from the Rockchip PX30 TRM and the other
> > available documents from Rockchip, I will add the following:
> > 
> > diff --git a/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> > index 6af4a9b6774a..6920b0cb0507 100644
> > --- a/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> > +++ b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> > @@ -69,6 +69,14 @@ properties:
> >                bus-type:
> >                  enum: [5, 6]
> >  
> > +              hsync-active:
> > +                enum: [0, 1]
> > +                default: 1
> > +
> > +              vsync-active:
> > +                enum: [0, 1]
> > +                default: 0
> 
> I'd use the same default for both, whether it's 0 or 1.
> 

Is this supposed to be the default value HIGH or LOW if it is not
configured by the driver ? because the manual states the following:

HREF_POL
Href input polarity:
1'b0 : high active
1'b1 : low active
RESET VALUE: 0x0

VSYNC_POL
Vsync input polarity:
1'b0 : low active
1'b1 : high active
RESET VALUE: 0x0

And that's why I chose 1 for hsync and 0 for vsync

--
Kind Regards
Mehdi Djait

