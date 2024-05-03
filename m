Return-Path: <linux-kernel+bounces-168137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EB38BB41D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD161C23A40
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01413158A11;
	Fri,  3 May 2024 19:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrAs+DQF"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995BE134B1;
	Fri,  3 May 2024 19:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764822; cv=none; b=YqGqAwdRhWh85IUegXlPrJaf//LAGlWDPGMASyU9e2Kbomy19vXvClDBWGxrM07BLdA85sJf688VpJ1LfFMSCnW6wZLVs1Ndr1ArHpaU+j2gYtsuTMsna2tcnLShS9699fdSz/+dsMsH9pop4sagiZXSvh2nXSasgv00E96v5lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764822; c=relaxed/simple;
	bh=WnxtnG5F2ZSL/UrBBiWEVqdNo/iZ7mg4Zelf0DhwJxQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRgRpZKBCrYZEl/Wz4RMfkjfHBUFFjmrY4aI2k5N9auzZ/mbU2/H5Xt2NgLHrcHEqVfTP/8KuAGljNBWBTxtckF4ndlENJ5NHFMGmDa6JOfJkTyRp70Z6jpAqTJ+ozAZcNFYSgvAiZNbTPo8GWUPgnj/MEXDkQvwbcckgATRYek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrAs+DQF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-34db9a38755so17805f8f.1;
        Fri, 03 May 2024 12:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714764819; x=1715369619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UbjwZx8MEe2bGhAnyoiiAxBTi8jV9NStJqBk4W+NrSE=;
        b=DrAs+DQFQxof1k8TdfrTPbD4Bm6gOTB85mevASfsK1riDv6PsDCc4G5Xiq0kF14YE5
         ZFdMilYrN+fPf00pxM80PDKXuAW/5Viv2Uc3CMGhuLW1L7w1mKRqzxb7pauSJsE7kHQR
         PYQWIUuVVo7GGn0g6SZi1QnSi9EuNfyWwELgTasbp6rdyMf7T2eb1wMWIeOcoWgzoSde
         wSpWtWJThYcFTcTOrxNXeH0O0/u8CS8WofOa72BXdz9D/V4Exwe/07QsvQZElVHrOJ6r
         GLkG9nSfS3h+VnarFnSg9i408poc+3QnMxJKhhT6iiyhFUelUp/R013D4YJW27smhyAx
         TF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714764819; x=1715369619;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbjwZx8MEe2bGhAnyoiiAxBTi8jV9NStJqBk4W+NrSE=;
        b=FvYqXD3s90lfB9JG9ggrwi1FcnnAy6vULij0WqjJDrhseKOCvqwN2HC221IVPGGEA9
         UGR+uCpR8EvtitJ+LKLKeNy+KxOGo2ROUOOT7hAL8qXP7dKEh0Bg6w2xg0XfFkBMYgYD
         72U/7H1Jg1qVvejuc5jT0Yx4R1hdDfwn4X9KBBOs5c6JshaugKoYqkdyy2uNWorSO+u3
         5ZWjvdUWWY3mF7RTIfFy4wjUFZfmGrezOXpeVHrGai/Zn9jXRqplT1rag0a0owzzarPG
         RfBwZXofHvFHFDoD4GWARtTZqD07FklcwRowE81mXl1IQ1lEUeLXo6uYG1hQfqaDoqj5
         4IOw==
X-Forwarded-Encrypted: i=1; AJvYcCUTOMPjClPu3qKieCsq58I/KGeuZMRh7iF2QpCOVciS4qUlSIF05R28ifYWj3rTPOgHelq+uLvac7K8QEGbGm+cX9Kkjb6jT02NAOJFikD7FwDj7LfxRP+/ZgmI3sGpw9iPJjpU/g2oBQH9KEepKpCidG3mjz5DrvGShYHdpIzOQXrcQb0=
X-Gm-Message-State: AOJu0YymOq5wPThFWuC1JNSiM9zSIyuVG8FGAgDNKJJQBgBgfHNpcOUS
	384B2eXsBUddqPUw9YI16lhoQ3ddot0goIUYihhSLEZEveoDyQhs
X-Google-Smtp-Source: AGHT+IGJoLKFGAWGFD04zm9WgUj9sVAHiRRlSUoM+RS/MeaUrE1ztcbqtoT/S/bWD93YNQW1zePuOw==
X-Received: by 2002:a5d:5483:0:b0:34a:35c7:22a3 with SMTP id h3-20020a5d5483000000b0034a35c722a3mr3218989wrv.20.1714764818605;
        Fri, 03 May 2024 12:33:38 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id g4-20020a5d5404000000b0034ca136f0e9sm4457292wrv.88.2024.05.03.12.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 12:33:37 -0700 (PDT)
Message-ID: <66353c11.5d0a0220.bb93c.fb57@mx.google.com>
X-Google-Original-Message-ID: <ZjU8Dw8rxwlS8vJV@Ansuel-XPS.>
Date: Fri, 3 May 2024 21:33:35 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>,
	linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel =?iso-8859-1?Q?Gonz=E1lez?= Cabanelas <dgcbueu@gmail.com>
Subject: Re: [PATCH 3/6] dt-bindings: mips: brcm: Document mips-cbr-reg
 property
References: <20240503135455.966-1-ansuelsmth@gmail.com>
 <20240503135455.966-4-ansuelsmth@gmail.com>
 <20240503-oncoming-taste-bab71375b67c@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503-oncoming-taste-bab71375b67c@spud>

On Fri, May 03, 2024 at 05:21:41PM +0100, Conor Dooley wrote:
> On Fri, May 03, 2024 at 03:54:03PM +0200, Christian Marangi wrote:
> > Document mips-cbr-reg and mips-broken-cbr-reg property.
> > 
> > Some SoC suffer from a BUG where read_c0_brcm_cbr() might return 0
> > if called from TP1. The CBR address is always the same on the SoC
> > hence it can be provided in DT to handle broken case where bootloader
> > doesn't init it or SMP where read_c0_brcm_cbr() returns 0 from TP1.
> > 
> > Usage of this property is to give an address also in these broken
> > configuration/bootloader.
> > 
> > If the SoC/Bootloader ALWAYS provide a broken CBR address the property
> > "mips-broken-cbr-reg" can be used to ignore any value already set in the
> > registers for CBR address.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  .../devicetree/bindings/mips/brcm/soc.yaml    | 32 +++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mips/brcm/soc.yaml b/Documentation/devicetree/bindings/mips/brcm/soc.yaml
> > index 975945ca2888..12d394b7e011 100644
> > --- a/Documentation/devicetree/bindings/mips/brcm/soc.yaml
> > +++ b/Documentation/devicetree/bindings/mips/brcm/soc.yaml
> > @@ -55,6 +55,21 @@ properties:
> >           under the "cpus" node.
> >          $ref: /schemas/types.yaml#/definitions/uint32
> >  
> > +      mips-broken-cbr-reg:
> > +        description: Declare that the Bootloader init a broken
> > +          CBR address in the registers and the one provided from
> > +          DT should always be used.
> 
> Why is this property even needed, is it not sufficient to just add the
> mips-cbr-reg property to the DT for SoCs that need it and use the
> property when present?
>

I described this in the cover letter. CBR might be set by the Bootloader
and might be not 0. In that case the value is ignored as an extra
precaution and the broken propetry is needed.

> > +        type: boolean
> > +
> > +      mips-cbr-reg:
> 
> Missing a vendor prefix.
> 

I will change this to bmips,cbr-reg hope it's O.K.

> > +        description: Reference address of the CBR.
> > +          Some SoC suffer from a BUG where read_c0_brcm_cbr() might
> > +          return 0 if called from TP1. The CBR address is always the
> > +          same on the SoC hence it can be provided in DT to handle
> > +          broken case where bootloader doesn't init it or SMP where
> 
> s/init/initialise/ please :)
> 

Sure!

> Thanks,
> Conor.
> 
> > +          read_c0_brcm_cbr() returns 0 from TP1.
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +
> >      patternProperties:
> >        "^cpu@[0-9]$":
> >          type: object
> > @@ -64,6 +79,23 @@ properties:
> >      required:
> >        - mips-hpt-frequency
> >  
> > +dependencies:
> > +  mips-broken-cbr-reg: [ mips-cbr-reg ]
> > +
> > +if:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        anyOf:
> > +          - const: brcm,bcm6358
> > +          - const: brcm,bcm6368
> > +
> > +then:
> > +  properties:
> > +    cpus:
> > +      required:
> > +        - mips-cbr-reg
> > +
> >  additionalProperties: true
> >  
> >  examples:
> > -- 
> > 2.43.0
> > 



-- 
	Ansuel

