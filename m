Return-Path: <linux-kernel+bounces-55343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF80684BB7A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7E471C251E4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAAB6FB1;
	Tue,  6 Feb 2024 16:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQGbIz22"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0C44A3C;
	Tue,  6 Feb 2024 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707238560; cv=none; b=SHlHuexPUsLPO2hcn8eVTU1/3qnP7HM4uiTU/Nu6bTMWXkdGDWO2TRBSPja7SU8gd0GynQ6GXUSWpe4o1P6yFjhUTpvAmtaQVZVJBN78+wsfKPG8UQ3di55TBZHrAgLHANpt1ZmO7EyDRYn5yypsR6crTjVHc8uzsAGTgZ/N1xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707238560; c=relaxed/simple;
	bh=0DzQTz3e7duXjAdDGG2HxGhv1OSVoCiUZ8ZzzpuxZLY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVvWXghvFYDJZgl9wfYqDo4lUMb4KFEf5uR0iRTzl3O+LT6JYdbE1kXNKbOX8wc13N9w4fVId5pBkNtI5HA8CDoZueJSc10opeJeWPvCpeC/yTe3R5qYxNAZW/FNQYe8ba63iJ1Umavhr23n3y0g44N88EQMgff9BQlY5XczOuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQGbIz22; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40fe03cd1caso11653275e9.0;
        Tue, 06 Feb 2024 08:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707238556; x=1707843356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DQYvS2Nd94lvkvJ5h7uQC8LM8aPq2LsaJJg/9Gdvc2I=;
        b=BQGbIz22UGh572OC2HLAsucmz77YDcpwdfMcN7UR8a1L5dFHVF8vxBlduHyNnCUlUu
         6+GQGHeaAYrg1oIzMlDI8GpBNEGPCwbgbtrRE+CKdp+mrSUyibcdf/vbMOoCPVQs2wPy
         SAKJ87l1cT98d9gDwKu31cKPcfTCV9RR1B/DlcNRjjs1WJ9wpwC0ecA0yqg4Fv3rV8WY
         Hi84IBHugrPNmIOdhZkIMxQiIuL7sFz+ygNes6e2CwJ32WQB2Bko/mIQP6HbXhvcnzIh
         QEmoVyL/epMllOljK6nUDyIn2r0W2EXx7qwqR/u8xHs/qsk8SfhvRbKnqRzVwVVYFOKq
         pP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707238556; x=1707843356;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQYvS2Nd94lvkvJ5h7uQC8LM8aPq2LsaJJg/9Gdvc2I=;
        b=ejNPXSghEHJ8SojJ0cQCE7pTfmXm3tFh9fBq4+Cdn02OEauKe/hx/yqyD4v9KU2i3a
         e/N2ELausuSXDZa1xQZDRz5FlP9T7j4/ca6dfrcogG8GqIIppj/2omI+q0a9ZmqCjjZW
         39V5VAWyRc6Xq86pGraYDlC9xwygt2lWe3LrgnxtJKPjAM4j+bfu2Ic/z/gzPyGQTm8b
         KBviT9X1SZFtrpGhiLz0OmxugaRKh/HVuNuhMqYUgHf4mBuHmNG0yPluJg8JQgcZmYZ3
         DlL6c3roGznMOTxajnW+q9RYktUOaWi2mpQERXR0ebijc+7zTweHOBr9uMy2i2JRB57q
         0Asw==
X-Gm-Message-State: AOJu0Yw7pHst92ymvshOot+ulL1S6fQjvQw4+AVPCjD4l6uE145rSUpW
	SsTf9zIA+ORKNl2z06iu8t82YY1xLaYxhd3M9W4XIBUQoPVXmOwP
X-Google-Smtp-Source: AGHT+IERS90AfZk97jnnoFogRTYTgoR2FBo6O/FidCfBh3vKq//6L9L+dWeGdXOLQUOfv1tejDV6og==
X-Received: by 2002:a05:600c:138c:b0:40e:e25c:41cf with SMTP id u12-20020a05600c138c00b0040ee25c41cfmr2498046wmf.12.1707238555647;
        Tue, 06 Feb 2024 08:55:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWDCewoDdshbLkNDODTr84UP83nCrRLXABxPAlbqM+t6esdx9VWGB+QzPbH8bK0l4x0Vay8RcCwsGBh/qJekO95e0iAZ8CaK1FvfP8C+tW1L/2sdafTIABL+3TtYf6tJCEDNF8BSTrCeYfFlco6Kj+RDWyVXLGEZkwd6Gt89p35AGWs3b23LUs3bW3H+DEPVHhsEalI96bbL7anvABvfgVQLCcPtq3F8/S5RKJsnm+I5EyZSfN+mN8YzDwlI4dAjIfI3ZoSOmx0/2kL/RshNCDKCG1Wkxz1aOX88fdY91SjLCtxgptHp+msRLqbwkSPX8RQQFItKLPWURWGtGl6i0vpQUiQU/JHpeagkvZvuSskVxR44vGCOHtonjVLnzaNX1ey3kTZqqdFKFt34lVmI7yx9itY36gzihAxV9S+VTURG+XXZsSydnOKqYIoYe6HrQYxG3w2hg/6l0P6ybNgy6GgPJkClUoeTGPNu9d9DjA6rDvhh3ruCsJwWGy0SemXYLaYNte/qjdyICauE+m8eo1JWQqz3SlkhuOaCTkLId4CKzoYOujTi+JCsyALaFhxh7zsGg2Fj3WeNARWhxKMcJz2IyZ7048nH5fxRu9h1Kf5QQ024MJVZD76VJyE
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id l9-20020a1c7909000000b0040fc2f07ed5sm2456846wme.27.2024.02.06.08.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 08:55:54 -0800 (PST)
Message-ID: <65c2649a.1c0a0220.ca891.c8da@mx.google.com>
X-Google-Original-Message-ID: <ZcJklT-ob7iP6ozk@Ansuel-xps.>
Date: Tue, 6 Feb 2024 17:55:49 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v6 05/10] dt-bindings: net: Document Qcom
 QCA807x PHY package
References: <20240205164851.1351-1-ansuelsmth@gmail.com>
 <20240205164851.1351-6-ansuelsmth@gmail.com>
 <20240206-correct-viscous-1f8c163f4d0c@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206-correct-viscous-1f8c163f4d0c@spud>

On Tue, Feb 06, 2024 at 04:32:29PM +0000, Conor Dooley wrote:
> Hey Christian,
> 
> On Mon, Feb 05, 2024 at 05:48:37PM +0100, Christian Marangi wrote:
> > Document Qcom QCA807x PHY package.
> > 
> > Qualcomm QCA807X Ethernet PHY is PHY package of 2 or 5
> > IEEE 802.3 clause 22 compliant 10BASE-Te, 100BASE-TX and
> > 1000BASE-T PHY-s.
> > 
> > Document the required property to make the PHY package correctly
> > configure and work.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> I think this looks pretty decent, some minor comments.
> 
> > +  qcom,package-mode:
> > +    description: |
> > +      PHY package can be configured in 3 mode following this table:
> > +
> > +                    First Serdes mode       Second Serdes mode
> > +      Option 1      PSGMII for copper       Disabled
> > +                    ports 0-4
> > +      Option 2      PSGMII for copper       1000BASE-X / 100BASE-FX
> > +                    ports 0-4
> > +      Option 3      QSGMII for copper       SGMII for
> > +                    ports 0-3               copper port 4
> > +
> > +      PSGMII mode (option 1 or 2) is configured dynamically by the driver
> 
> I'd drop mention of the driver here, with s/by the driver//.
>

Sure.

> > +      based on the presence of a connected SFP device.
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum:
> > +      - qsgmii
> > +      - psgmii
> > +    default: psgmii
> > +
> > +  qcom,tx-driver-strength-milliwatt:
> 
> Is this a typo? Should not it be "drive-strength"? There's 39 mentions
> in tree of "driver-strength" and 3500 for "drive-strength".

In the PHY datasheet the reg is called TX_DRIVER and the description say
TX driver amplitude adjustment.

But the section is PSGMII/QSGMII drive control 1 register...

Guess it's a typo in the datasheet. Will change to drive.

> 
> Otherwise I think the review comments have been resolved:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 

Thanks!

-- 
	Ansuel

