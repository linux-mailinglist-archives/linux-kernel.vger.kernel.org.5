Return-Path: <linux-kernel+bounces-50563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C359847AD9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EDF41C23814
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D878061F;
	Fri,  2 Feb 2024 20:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbHAlGJB"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F9D3A1BA;
	Fri,  2 Feb 2024 20:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907495; cv=none; b=puRWSlPSlAI3HX6IInEAkarSyBvvdmOjERnanjKqRkzwxb5uILQD/fUfmRr70lioD/x/jJPJvKReZKlmUfWKdZ/6KIVuIgOMNCvl7/kfQQMIsF4DE0tYyn8Z7mp1rTNplDoctfdRV8e+PabN69mXUTqCh+17qTtRxoG1qMCwYzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907495; c=relaxed/simple;
	bh=rDn817fjX0kSguN3sUGZwUpkXg7AbEX5VOZADlydnF0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILAsTn41mwrSQv2pcf4v8MYTqouejOJyWcQcRATTPDH8zjmRPwgBxhm8vgEVrfnLcDu0n0LKbf6DT/vC7jt6n2qVdOUe6hRUhgUksvj4y3OSI76c47/2Z60D6tJ3Ar8RUlNLb6P1M3ciynWSZMb+IbtHBziX8O4+zS5Foz3Bv1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbHAlGJB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40fafae5532so21611505e9.1;
        Fri, 02 Feb 2024 12:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706907492; x=1707512292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M7SVllEj1Aqd2yqrYowH4jwwIvg+JRBFtmbWIhxjcMM=;
        b=CbHAlGJBpyqAJAFxCUN1ycq+3TX7QQ3+DpAnkXvzpo3ShXWhTfD08/Pi9lz9FFo4/C
         0XYRHyYaSDxolhksjb5PSXO+sh5BjCoyS2zJH8/cLNSD6EJFK0+tNMv/cP1I2lQb4JbG
         QifPoi8X8WCKOi+hWanLX7Vm6KzqcxJiu4IWSJpo4CyEO/fa5AoAjgM8AeN3Uj2GjkKl
         DTuzIjrHLXP1A47FyLVgTc9M+sYHFA0nb7GydqNPUgMeSTaMoVERX4l5kmQyyVwiUxGR
         XvnqgqLTHGtAdRiB1HlCvtcs48X2PZXV5VJs+AX8yty7FZK2OfwCZZlqutniZOjWCBGu
         uyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706907492; x=1707512292;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7SVllEj1Aqd2yqrYowH4jwwIvg+JRBFtmbWIhxjcMM=;
        b=h8pjgwe1Ilh74M91tn+zP/iAq7QG9Agd4F+2tcymJgyv/vX5mC9KMGk7oopr16KFeH
         DQ/i7Xt9p6huMWNaOJjT1RZJazWysvW0F9KBK5k4oeOiDw3MvB4ZAmdEhOZTjCdAPvNa
         LBEF8sW6dloj4lkBdXPLKlkialHPL7/qnjMk0UztfvleLKPukrOovBdFoeghDgz6MAxx
         84WWs/Dun8z7Ry4X+nF58NxIi8wOJxDLJBs61dElcSsVUbqZQ0N8N7BdQsUjT61fTLrd
         XJ2JI08AmwtqYIgDqlXGrxWEwr6dBQD9dH7/00qu1BswSGTfyNomso0VaehuQINuiALy
         yGtw==
X-Gm-Message-State: AOJu0YxF1YlH+g3SlVqNpwRCeDRPna67SesW4VpcHNcjJKgWcuVxM7bO
	K5tHtv8LJ7DvaEid2AICB+cx1/+pA1cPwC4sJQNN4HQNHneUIllk
X-Google-Smtp-Source: AGHT+IFJvycPwKcT0hWNjF3IXp75jqsSxhmLdQ9FLSlztmh1hNTkrUk5Dnb77/cXgHurzH7hYBX2Qw==
X-Received: by 2002:a05:600c:46ce:b0:40f:be53:82d with SMTP id q14-20020a05600c46ce00b0040fbe53082dmr3621508wmo.40.1706907492035;
        Fri, 02 Feb 2024 12:58:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWggftKTSNSfxAUs5TBR/izyuExByciXbE9HV9ftKlkJ0VHrSCl7CSvvV5vQkCSHH4PelpRpGFyi9OyeYkkj5RZNJ4y9gh6WQXKqMNqmMsRy/KAbLvsZcoFfXyN9AXOBTGGFrErp2ZOd7ea67+PhPihf2+YBG2lAB1V2kd5auLEb3IDUbAMvTCBrODsjP/32cXgcmoOLaWs2EVYrDrZPziTfVtiMhK/TLNWZmZ2aBaolUiNwbJz4dsO2gXfAy4mJZ8rK1ukKGtAKTAjgyAlAj3EYuTp2SQLzRtDSXwfFyv49+YWAfPL86RQEieRZb7cqD+oCdwyLBJY0y39iV0VphG3IsOmP5haNMXeuTNy5lYMhCpkAoB/TP0ePZlJxS8Df9dh0NrlaRZp3A11muXygrz7BRLK3bN85++c0/FLzt0IJugBKbZ50p34JLtZXfYlVFPD+mD2BLzQII6yQZM4s52/FV4pWHVDhZb9rsilaIAzDPv+hRhZ9marRggZOkqt0ZjcmgA1idD42CZt9W7yLYbdLlqlXmzxfeeQP591O+xmprCuZK1fWVbuinXd8TU4
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id m1-20020adfe941000000b0033ae6fa7f20sm2631163wrn.65.2024.02.02.12.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 12:58:11 -0800 (PST)
Message-ID: <65bd5763.df0a0220.f783b.c20e@mx.google.com>
X-Google-Original-Message-ID: <Zb1XXyo7Zp8s8BO3@Ansuel-xps.>
Date: Fri, 2 Feb 2024 21:58:07 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Rowand <frowand.list@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v5 1/9] dt-bindings: net: document ethernet PHY
 package nodes
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
 <20240201151747.7524-2-ansuelsmth@gmail.com>
 <20240202205259.GC1075521-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202205259.GC1075521-robh@kernel.org>

On Fri, Feb 02, 2024 at 02:52:59PM -0600, Rob Herring wrote:
> On Thu, Feb 01, 2024 at 04:17:27PM +0100, Christian Marangi wrote:
> > Document ethernet PHY package nodes used to describe PHY shipped in
> > bundle of 2-5 PHY. The special node describe a container of PHY that
> > share common properties. This is a generic schema and PHY package
> > should create specialized version with the required additional shared
> > properties.
> > 
> > Example are PHY packages that have some regs only in one PHY of the
> > package and will affect every other PHY in the package, for example
> > related to PHY interface mode calibration or global PHY mode selection.
> > 
> > The PHY package node MUST declare the base address used by the PHY driver
> > for global configuration by calculating the offsets of the global PHY
> > based on the base address of the PHY package.
> > 
> > Each reg of the PHYs defined in the PHY Package node is an offset of the
> > PHY Package reg.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  .../bindings/net/ethernet-phy-package.yaml    | 55 +++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml b/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
> > new file mode 100644
> > index 000000000000..d7cdbb1a4b3e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
> > @@ -0,0 +1,55 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/ethernet-phy-package.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Ethernet PHY Package Common Properties
> > +
> > +maintainers:
> > +  - Christian Marangi <ansuelsmth@gmail.com>
> > +
> > +description:
> > +  PHY packages are multi-port Ethernet PHY of the same family
> > +  and each Ethernet PHY is affected by the global configuration
> > +  of the PHY package.
> > +
> > +  Each reg of the PHYs defined in the PHY Package node is
> > +  an offset of the PHY Package reg.
> > +
> > +  Each Ethernet PHYs defined in the PHY package node is
> > +  reachable in the MDIO bus at the address of the PHY
> > +  Package offset of the Ethernet PHY reg.
> 
> If the phys are addressed with an MDIO address, then just use those.
>

Thanks a lot for the review Rob.

Just to make sure I got this right!

Are you ok to have the PHYs with absolute reg? (it would make thing soo
much easy)

It would result in this node example on real world scenario.

	ethernet-phy-package@16 {
		compatible = "qcom,qca8075-package";
		#address-cells = <1>;
		#size-cells = <0>;
		reg = <16>;
		qcom,package-mode = "qsgmii";

		qca8075_16: ethernet-phy@16 {
			compatible = "ethernet-phy-ieee802.3-c22";
			reg = <16>;
		};

		qca8075_17: ethernet-phy@17 {
			compatible = "ethernet-phy-ieee802.3-c22";
			reg = <17>;
		};

		qca8075_18: ethernet-phy@18 {
			compatible = "ethernet-phy-ieee802.3-c22";
			reg = <18>;
		};

		qca8075_19: ethernet-phy@19 {
			compatible = "ethernet-phy-ieee802.3-c22";
			reg = <19>;
		};
	};

> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^ethernet-phy-package(@[a-f0-9]+)?$"
> 
> Can't be optional if 'reg' is required (which it should be).
> 
> > +
> > +  reg:
> > +    minimum: 0
> > +    maximum: 31
> > +    description:
> > +      The base ID number for the PHY package.
> > +      Commonly the ID of the first PHY in the PHY package.
> > +
> > +      Some PHY in the PHY package might be not defined but
> > +      still occupy ID on the device (just not attached to
> > +      anything) hence the PHY package reg might correspond
> > +      to a not attached PHY (offset 0).
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +patternProperties:
> > +  ^ethernet-phy(@[a-f0-9]+)?$:
> 
> Same issue here.
> 
> > +    $ref: ethernet-phy.yaml#
> > +
> > +required:
> > +  - reg
> > +  - '#address-cells'
> > +  - '#size-cells'
> > +
> > +additionalProperties: true
> > -- 
> > 2.43.0
> > 

-- 
	Ansuel

