Return-Path: <linux-kernel+bounces-73397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB93685C1F7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4011C23D68
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C4876917;
	Tue, 20 Feb 2024 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJu6mrz2"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D463376419;
	Tue, 20 Feb 2024 17:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708448656; cv=none; b=b96SmtMUfEoA070lvJhjnEMJ+1rte8TMQsKSiokIdlZ2Ckwvp8RqxgmyE2fa33M8tnp7fxERwHkUBaxnkpFI+fTRpRhs95rO/e9sb4/CzEDggJwuDUbGepDSJp7bac4YK7cc0ZrxhAF1CrCXOptzZr0PIJx9IDk7rVrxWvPTQZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708448656; c=relaxed/simple;
	bh=1xXeVOnEigRxXwlKRHHOvhTGMTf9ZV/KdmBvlcHlt9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S57csKNBodHQeyLGphCmMYsQ+gnEnpUWT94t67S9qLUM4ilLSbgYvzJOhQAzXzaiFVrS2Onjlv0n1OcKnMCfc/S46dfFBgPlsy4ueb6XE6VhuOddgWCCN6DSKzE/gtvFhMyNj5Ct9Rp0JUa04anQG+syO02s2vPMQLum8k0Fu1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJu6mrz2; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a30f7c9574eso723139066b.0;
        Tue, 20 Feb 2024 09:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708448653; x=1709053453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jgEbMYOXofhTA51XQqDP7Wvc9fJvE8QuPxj1fgWRYb8=;
        b=TJu6mrz2uDdwNVD6mR3vBUfnpVlVLuLnZMBty2gMDKGezcRDh952W2AHz93eJRoS3x
         j29cPej77X9CLQcOiYgEiTi8ziPGIALM2eCrdGrvGuFap4U614C4V0NCaS7w2OtkLcZP
         D3Ihf1oKRlxliIEyZ1nnp6dTX/jW/VMJ2PD/RXUQ/W02LMBRcO/pMigYG+WEsPrv8oQq
         b2B4WLIApZ+qwYvTvzvC1/4kpgGlcJyN1mTDMtXUe7d3ANRF0j6Ivf2vBl/vueVhmyDd
         4wTF3n9qH/HvGZs6XtSpi5qm4q65/5Uv+v/MLzDTseO4plofdi1J9G6+Tpxuoz2U/pVN
         4ilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708448653; x=1709053453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgEbMYOXofhTA51XQqDP7Wvc9fJvE8QuPxj1fgWRYb8=;
        b=ptbKKUaVYpKko0ZbaVLw+wQBqZCVTVfsm8rlURctEKwvqPPh5CDMEDq26ktMnyb5g/
         Qdyt3hI5QXhA93uPuYjbBDUFB30grUuMKupO2qDgBwro9KNEmCR996wuz+ljcFsfxgqr
         n1x9qfxQHxzaM2GE4AdI0kntXLwrCJyKAbgafcc62m/7ZKLzUp1awhVSm2mBdYdKeqUx
         jYOehBGFVjG7qAEJyB3/d39ZBfX97ycfBvWqvNzthi1f+0K257FaiazkMjFgrK0vdHt5
         XzJPsJjsHrJTvkGQcA7KTZVoO2n91xq7L/nIiNQiNw6oBY7fiAoxhgYAlRV5EG3UtPPr
         H1UQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvPj7b1GEC2EH/AX0Lo/+UFeOkXiCqk3Y1OdOyubVBoYmFV/7cO5hl7wEBxfpRO3/ofhTbsH1MaHCTe+rUnIsnHTAOAvFruJFwX8cfnyUgfVKwS/SXq1SOKtAbYiN+NE+u8cB0VOd3mm8vNlsV7lD3w+3IbX9W3OsR1d9SxkVttO8WM+S7
X-Gm-Message-State: AOJu0YxWXBhemWZHYgVLTPaW68efWYfsRyQos42wYmnzibvYPJkI6WEe
	GYCKL4cUhrOE27G6l5dXbg/FAgY2h3qSzab0aZaT1U/Vcfl0ZwsD
X-Google-Smtp-Source: AGHT+IF8DYSmDz6wkfBNyy7jXfOiVoA7MbvQll+TklEGm6Becoie6BmxW1l8aUQ2ufFEPIzNPdk0QQ==
X-Received: by 2002:a17:906:fcc6:b0:a3e:36a9:f70d with SMTP id qx6-20020a170906fcc600b00a3e36a9f70dmr5810454ejb.38.1708448652882;
        Tue, 20 Feb 2024 09:04:12 -0800 (PST)
Received: from mehdi-archlinux ([2a02:8109:aa27:2d00::d069])
        by smtp.gmail.com with ESMTPSA id fj21-20020a1709069c9500b00a3e5adf11c7sm3019450ejc.157.2024.02.20.09.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 09:04:12 -0800 (PST)
Date: Tue, 20 Feb 2024 18:04:10 +0100
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
Message-ID: <ZdTbilKCsMFcjz64@mehdi-archlinux>
References: <cover.1707677804.git.mehdi.djait.k@gmail.com>
 <13deb8c5cb58e08c1b47decd112b51e8e0b6c4dc.1707677804.git.mehdi.djait.k@gmail.com>
 <Zcta6hhSio67ahKs@valkosipuli.retiisi.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zcta6hhSio67ahKs@valkosipuli.retiisi.eu>

Hi Sakari,

Thank you for the review.

On Tue, Feb 13, 2024 at 12:04:58PM +0000, Sakari Ailus wrote:
> Hi Mehdi,
> 
> Thanks for the patchset.
> 
> On Sun, Feb 11, 2024 at 08:03:30PM +0100, Mehdi Djait wrote:
> > From: Mehdi Djait <mehdi.djait@bootlin.com>
> > 
> > Add a documentation for the Rockchip Camera Interface binding.
> > 
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
> > Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> > ---
> >  .../bindings/media/rockchip,px30-vip.yaml     | 123 ++++++++++++++++++
> >  1 file changed, 123 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> > new file mode 100644
> > index 000000000000..6af4a9b6774a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> > @@ -0,0 +1,123 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/rockchip,px30-vip.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Rockchip Camera Interface (CIF)
> > +
> > +maintainers:
> > +  - Mehdi Djait <mehdi.djait@bootlin.com>
> > +
> > +description:
> > +  CIF is a camera interface present on some Rockchip SoCs. It receives the data
> > +  from Camera sensor or CCIR656 encoder and transfers it into system main memory
> > +  by AXI bus.
> > +
> > +properties:
> > +  compatible:
> > +    const: rockchip,px30-vip
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: ACLK
> > +      - description: HCLK
> > +      - description: PCLK
> > +
> > +  clock-names:
> > +    items:
> > +      - const: aclk
> > +      - const: hclk
> > +      - const: pclk
> > +
> > +  resets:
> > +    items:
> > +      - description: AXI
> > +      - description: AHB
> > +      - description: PCLK IN
> > +
> > +  reset-names:
> > +    items:
> > +      - const: axi
> > +      - const: ahb
> > +      - const: pclkin
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > +        unevaluatedProperties: false
> > +        description: input port on the parallel interface
> > +
> > +        properties:
> > +          endpoint:
> > +            $ref: video-interfaces.yaml#
> > +            unevaluatedProperties: false
> > +
> > +            properties:
> > +              bus-type:
> > +                enum: [5, 6]
> > +
> > +            required:
> > +              - bus-type
> 
> What about the vsync-active, hsync-active and data-active properties?
> Aren't they relevant for this device? Are there default values? This should
> be part of the bindings for the device, shouldn't it?
> 

From what I gathered from the Rockchip PX30 TRM and the other
available documents from Rockchip, I will add the following:

diff --git a/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
index 6af4a9b6774a..6920b0cb0507 100644
--- a/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
+++ b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
@@ -69,6 +69,14 @@ properties:
               bus-type:
                 enum: [5, 6]
 
+              hsync-active:
+                enum: [0, 1]
+                default: 1
+
+              vsync-active:
+                enum: [0, 1]
+                default: 0
+

@dt-maintainers, @Conor does this warrant a drop of the reviewed-by tags
in the V14 ?

--
Kind Regards
Mehdi Djait

