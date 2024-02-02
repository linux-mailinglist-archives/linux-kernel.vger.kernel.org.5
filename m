Return-Path: <linux-kernel+bounces-49999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4DE8472D2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F23B91C2132E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AED01468EA;
	Fri,  2 Feb 2024 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0gAWcCd"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB44145B0A;
	Fri,  2 Feb 2024 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886780; cv=none; b=BgKNxP4zdW/wQy4SI4FYBY83ilkmyOwPBB0bJREO3qtFdpngpFKh/9yNiuothkg99ZXVCGYJtOEsokRApPhzDGhi7q2N786lxdVWjGt49vxwVUtP4H5X9KqDN2g5lLW4VUeSCxC/vgPSuiz5adys/mlFsak7U0vGo2I3AWY/m5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886780; c=relaxed/simple;
	bh=cH0Ez1q7AVKCSTqPdliYY761CkqYcyBDhX+VZTweTtI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHmPjvXk4eBGvrHW/t3z4ggic+Y+RqJ/WN5g2/oR4h4WKfG/7kGRuo8PUFRGe3hilLBkBACHsPPySkZJGk1eBCjYxncACGjF3rjnhYb+M/Mq/tvL7GGs+WReb2x+bDeSLY4QonxCWUgPbzcX7KSyb31t2XiqvjebLwHVR1XByiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0gAWcCd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40fb020de65so19013355e9.2;
        Fri, 02 Feb 2024 07:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706886777; x=1707491577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jOteb0PsF2BLCLyGWmKmTB+lIdwM+/E/rRbvA0hnOtw=;
        b=f0gAWcCdUcJKL+0cyr4O7l9Z2O6r9mFlwduLdEp63YiXR+zwZd/5oHdLURvfUwOAGL
         zIV8GSsjhhoGE6T0LttMhUmovjUaPJD8CNjKIDrsnr8fgqfBsuEuKDfndcO/muIur0+M
         21npdD7EmBBepHANZSIB7Lvoj0UBKsUS9yAMDAqnDoT1CC7lsEMQaKCpYMPJLV9/HRLl
         qxKg1xe7Ccj5qLtqmP8BlbPRGwKRf1vkZA1Tq/UYda8nKEvA320UrTU9KqwHVr6HqmVM
         hn4Xxf70/phPuwB7H5VtDY+6xRCmjoIzwfK+ugE9Fv0DBhyXOUgS5DEO1N67CPVgLoFB
         TG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706886777; x=1707491577;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOteb0PsF2BLCLyGWmKmTB+lIdwM+/E/rRbvA0hnOtw=;
        b=cajnWpjBiuldKH5deVmm1Fij/Kmaf9bINzHrDghndFs8fQYA0h9janN4VOtcNOcWWA
         AjIP8Dj3lbYmu6MWQ58+qFtBZTPvkIgy33QMNyM4hQX88D4j7dXBfF3QpqfH7ULuHV2I
         VwldLDDjA74o3yAxuGEHPM2x0svwoLIzFeQ0s56WuOEh7VbWLUzEdqwmJzO/BoOfqdOL
         bwfCOI0K7nj50XZPiY3bRMnLIbwXNxFINw707LgBr9aO+OYwuRqTVTKkpsClK/YBd3q3
         9AiUGGBf+nRpKBMBm5QaItTNhopgQ+Bfn4AbbBcy2c4RDL1c/JhJz3veWY+NnIiqFo63
         lFDQ==
X-Gm-Message-State: AOJu0YyGMdxfKp1kGkBg1n6wCMoIhMouGlH65nhBWI7kmU760I/P9Z85
	NnCL+kmZcbyMJttfXWuEC+AZXu57tisNQnctuzUC88EB/9XjmUO0rZsGTYU3
X-Google-Smtp-Source: AGHT+IGJ99yIvov94x22G73qH8iC/E2gQ7452meoV4GOLxI4nPTml85UYZHs+hRDhZ0GgPSwQWILNw==
X-Received: by 2002:a5d:4c50:0:b0:33b:1545:fe6b with SMTP id n16-20020a5d4c50000000b0033b1545fe6bmr3460138wrt.32.1706886776746;
        Fri, 02 Feb 2024 07:12:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVUcQCi7/os4KFKOqyKW7jLa7hByjvvekf7LRA7z5lSZB82v943d1Qn5xZyNj1My1tDJm34HzkIotGQmNv3uDcbczGqgwJ8646ISgj4XU27LdLGvNYsWVleBhUCR8/qUY90B5DjcTPFL7rT7jA/xbFD8r8JA63qRPNpEKcx/oOwPKsDAJVxNDWdAWUHHBFV3y2I6G/a+6YjgxyOS25sP/plov2AEJtI5N7lLvxbRVBM2SGr+IjxhZl92U2LQGJRaaGmNTUOlZDITNmX2SkeAIdefgXa9XuEfZ5jceRGxa4U4UCqpPvRT8K6T1UhIq/Yw/WgjFFliFDVQbnY+6m6fyZaZWaZNd+gygpez5CJiS+tcgF9IIOBk0ynTmw7N031hNlFoa8VVCPiUlDK6cvMxtCJW5orQzWsD/+xtsWDbMsV834x272Y8mwunURFUyZU743SZ0dKDXztZtqajoTiAbRoCFgwlaIlz38X/XqOC5wbsXbSq00MGQkryrmevZXdGv5NdONTrnm1JI/1su3SUXVlSxpp3Q5xCTgiwqxn7T8+
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id cp33-20020a056000402100b0033b03d77c66sm2167930wrb.78.2024.02.02.07.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 07:12:56 -0800 (PST)
Message-ID: <65bd0678.050a0220.bf9e4.9bd2@mx.google.com>
X-Google-Original-Message-ID: <Zb0GdYD0dt7l1E0U@Ansuel-xps.>
Date: Fri, 2 Feb 2024 16:12:53 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
	Frank Rowand <frowand.list@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v5 6/9] dt-bindings: net: Document Qcom QCA807x
 PHY package
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
 <20240201151747.7524-7-ansuelsmth@gmail.com>
 <94dfc4c4-5fe6-438d-bcda-4f818eafd2f0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94dfc4c4-5fe6-438d-bcda-4f818eafd2f0@linaro.org>

On Fri, Feb 02, 2024 at 08:45:52AM +0100, Krzysztof Kozlowski wrote:
> On 01/02/2024 16:17, Christian Marangi wrote:
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
> > ---
> >  .../devicetree/bindings/net/qcom,qca807x.yaml | 142 ++++++++++++++++++
> 
> Your bindings header must be squashed here. Headers are not separate
> thing from the bindings.
> 
> >  1 file changed, 142 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/qcom,qca807x.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/net/qcom,qca807x.yaml b/Documentation/devicetree/bindings/net/qcom,qca807x.yaml
> > new file mode 100644
> > index 000000000000..1c3692897b02
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/qcom,qca807x.yaml
> > @@ -0,0 +1,142 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/qcom,qca807x.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm QCA807X Ethernet PHY
> 
> What is "X"? Wildcards are usually not expected.
>

It's to identify the Ethrnet PHY family. Looks wrong to declare qca8072
or qca8074 since they would refer to a more generic Family of devices.

What would be the correct way? We have many other case on net with
schema called qca8k that refer to the family of Ethernet Switch but in
it refer to qca8327 qca8337 qca8334...

> > +
> > +maintainers:
> > +  - Christian Marangi <ansuelsmth@gmail.com>
> > +  - Robert Marko <robert.marko@sartura.hr>
> > +
> > +description: |
> > +  Qualcomm QCA807X Ethernet PHY is PHY package of 2 or 5
> > +  IEEE 802.3 clause 22 compliant 10BASE-Te, 100BASE-TX and
> > +  1000BASE-T PHY-s.
> > +
> > +  They feature 2 SerDes, one for PSGMII or QSGMII connection with
> > +  MAC, while second one is SGMII for connection to MAC or fiber.
> > +
> > +  Both models have a combo port that supports 1000BASE-X and
> > +  100BASE-FX fiber.
> > +
> > +  Each PHY inside of QCA807x series has 4 digitally controlled
> > +  output only pins that natively drive LED-s for up to 2 attached
> > +  LEDs. Some vendor also use these 4 output for GPIO usage without
> > +  attaching LEDs.
> > +
> > +  Note that output pins can be set to drive LEDs OR GPIO, mixed
> > +  definition are not accepted.
> > +
> > +  PHY package can be configured in 3 mode following this table:
> > +
> > +                First Serdes mode       Second Serdes mode
> > +  Option 1      PSGMII for copper       Disabled
> > +                ports 0-4
> > +  Option 2      PSGMII for copper       1000BASE-X / 100BASE-FX
> > +                ports 0-4
> > +  Option 3      QSGMII for copper       SGMII for
> > +                ports 0-3               copper port 4
> > +
> > +$ref: ethernet-phy-package.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: qcom,qca807x-package
> > +
> > +  qcom,package-mode:
> 
> Where is definition of this property with type and description?
> 
> > +    enum:
> > +      - qsgmii
> > +      - psgmii
> > +
> > +  qcom,tx-driver-strength:
> 
> Use proper unit suffix.
> 
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml
> 
> > +    description: set the TX Amplifier value in mv.
> > +      If not defined, 600mw is set by default.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [140, 160, 180, 200, 220,
> > +           240, 260, 280, 300, 320,
> > +           400, 500, 600]
> > +
> > +patternProperties:
> > +  ^ethernet-phy(@[a-f0-9]+)?$:
> > +    $ref: ethernet-phy.yaml#
> > +
> > +    properties:
> > +      gpio-controller:
> > +        description: set the output lines as GPIO instead of LEDs
> > +        type: boolean
> > +
> > +      '#gpio-cells':
> > +        description: number of GPIO cells for the PHY
> > +        const: 2
> > +
> > +    dependencies:
> > +      gpio-controller: ['#gpio-cells']
> 
> Why do you need it? None of gpio-controllers do it, I think.
> 

Well gpio-controller property is optional and having that declared and
#gpio-cells skipped will result in an error on probe. I think it should
be the opposite with other schema having to declare this.

In usual way for gpio-controller both property are defined as required
but you can see some (to-be-converted) txt files whith comments where
they say:

/mux/adi,adgs1408.txt:10:- gpio-controller : if present, #gpio-cells is required.

Should I instead add this condition in the if right below?

> > +
> > +    if:
> > +      required:
> > +        - gpio-controller
> > +    then:
> > +      properties:
> > +        leds: false
> > +
> > +    unevaluatedProperties: false
> > +
> > +required:
> > +  - compatible
> > +
> > +unevaluatedProperties: false
> 
> 
> Best regards,
> Krzysztof
> 

-- 
	Ansuel

