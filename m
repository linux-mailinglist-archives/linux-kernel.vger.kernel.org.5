Return-Path: <linux-kernel+bounces-50553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3AB847AB0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB6128969F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288CF7C096;
	Fri,  2 Feb 2024 20:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmnExZ6s"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAE215E5DE;
	Fri,  2 Feb 2024 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706906865; cv=none; b=oVFqmcl6RyyegnRjPi0P70mbQFsIH4je3ZxM5ML6iBeiR488CRrexwT2CKEEF1Iu+bA5YAtB8jTVHjX06LKbv7WvUewjdMcFIixwdfqQWh9BD8rK+4WZY+yuUhI1WvnCHnOErMuhhbpWZ1DoqKLRtrRCmAjUOOCmxZgcjbrHfr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706906865; c=relaxed/simple;
	bh=bPUm4KkQeJeGtmyhW+KgtpEzD3kiXXwTCq3KNoloiuU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9N11/C6zoeh72UraanRhTaEKFIvhuGVWM/FgMl9aLWHY6C4X2kKC2u6n1gw0H+R1IIsKeGjOEX/hM6IIpxs8imUywR5s2nD1diqL+MZJcIf1tEW4YroznVpE7mKDe+1L+Y2/4331a2FzonX+tq8anzJYFtLl1v68/JrPbF5Zy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmnExZ6s; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fccd09082so2410315e9.2;
        Fri, 02 Feb 2024 12:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706906861; x=1707511661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4EoiGjmq+s73vrhMXdcv2bqEbqZEZKuUJt5n77/LCWc=;
        b=EmnExZ6sgrSEZcDpcjzg2o4eecaTzZ9GY7qQNb8UPKYNFTm1Jfm/YsyuvXRE4zlMdo
         Xi2tXxXfTdyUbLc51ql0aQpWKjQLH7IbdNCcySj+DMvdwW/lSvTGJpI2xkKgxiTFJRbo
         efEWHx8SooqJDSPA32FG7yDpDMs6+PaZUlzE3UuscI51/XsAQr7nzvnWnoRit6+GLdef
         HTHlcW3ltCpAjrMjOLmRODkY0qvwxsd+r19IkvcIRh6oVqRQ3fxbGrlnAZAVNi4BFwm9
         MEQrJBxGko6NVcS4wQOoltXlmmCXl5t603ebpAr1iQu+VuzgHAchaQd5NId/j+u6OI2z
         ktOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706906861; x=1707511661;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EoiGjmq+s73vrhMXdcv2bqEbqZEZKuUJt5n77/LCWc=;
        b=bg40hrBF5dFzjt6jq4XfUawkiekeYcdEMcikAhlSmkiVp9JLSQ/I4ZjcFexfqA2Pw2
         yQO9u0vpO9LvPTqDeEbkiWxNhWZ5MXwA8c86SCuc2iyWsxY127hPk30M0sQdyUgMLW/n
         rEniCMDPGPfJRPMgO2emv1UXi33QjLSJoLmndYScatMEXCiipjxJLeLBmhllkWMunvvO
         BjQx/JMrXtJ5KiyMgrQ8xojUkRO44hBWp41mVYW2Qws4M2rLqTzlYXjpJ1ffPUYOP7QI
         aKsP6He06mnsxq/0RnIgNmDU0RqLkXFhyVmEImfro6S6VhDh+Wp2OqsAaD1NilT+/Uxn
         Wlwg==
X-Gm-Message-State: AOJu0Yz+4SEv3BLOBOwiTjh7NT7jCJ4Sq4rFUKRWqDUCitr4x8jGS+/J
	RtbQaoO/oq0eeH1SlTqZ77sOUJM5Nr/157Gmd/uzaaxHcsYYJ0ql
X-Google-Smtp-Source: AGHT+IF4iJJCpDkH02ochsAoODLguy8pwV8GfJmo2pzc4HBPpQziLtpi//y3jOEeiukd7IYaA9hhSw==
X-Received: by 2002:a05:600c:a384:b0:40e:d176:1c98 with SMTP id hn4-20020a05600ca38400b0040ed1761c98mr2424500wmb.18.1706906861178;
        Fri, 02 Feb 2024 12:47:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUV/aOCGT9iGBtP6QmPpT7PVum52bOjUAAdDhaMbrBtbXB0aLR5Kp4P3w8Za1iuEGtuQ1Pv5eC/siQBM0Xw4V/S8AvSQAbU/kmeBIZPfJNe74wVCeR7rxMWmqQb8Cy2AWxPVAAZkQf6wslT3CkApGPz8orGxYIffxDiyO/iaoMFnRP8YD0uc179DoX58tYAxt3k7N+mY7+Rs05j+XCyZbkfWnsRtZZ/e+1D+rk+DD3zU/RvtBnCnXELIKUXFslDzKzySXSCwSnyb7ZHzZwtjY82UatmmTO5l8O5RJKV2AAt9kAR9/7WvEiuLBrTjFOCsEC44GNWAv8QZouvo20PjU+ysW2ZLRtk0E4krJtcbDuBAqLDsRHlK4OvWZLa6yr2fuaJBOsgLncl+lx8w/tRjnxLoUzKjyUtxgZVGNhT0pLHp5TjUdCYY7bMRJFKSZNBtjAbBS9q8zh8q19NSr8CGyBbKJW0rlPeSZzFiXb/g0O/KB7+w1hzB2K0Ll3hEVsU0+TBoLOJ7rdhkbfbRjzO7arHL/fqk1LQYh+D8BjaeFKcEQ==
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id r2-20020a05600c35c200b0040efbdd2376sm887626wmq.41.2024.02.02.12.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 12:47:40 -0800 (PST)
Message-ID: <65bd54ec.050a0220.39d07.545c@mx.google.com>
X-Google-Original-Message-ID: <Zb1U6WUYgaNpt9Bs@Ansuel-xps.>
Date: Fri, 2 Feb 2024 21:47:37 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
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
Subject: Re: [net-next PATCH v5 6/9] dt-bindings: net: Document Qcom QCA807x
 PHY package
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
 <20240201151747.7524-7-ansuelsmth@gmail.com>
 <94dfc4c4-5fe6-438d-bcda-4f818eafd2f0@linaro.org>
 <65bd0678.050a0220.bf9e4.9bd2@mx.google.com>
 <20240202203915.GA1075521-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202203915.GA1075521-robh@kernel.org>

On Fri, Feb 02, 2024 at 02:39:15PM -0600, Rob Herring wrote:
> On Fri, Feb 02, 2024 at 04:12:53PM +0100, Christian Marangi wrote:
> > On Fri, Feb 02, 2024 at 08:45:52AM +0100, Krzysztof Kozlowski wrote:
> > > On 01/02/2024 16:17, Christian Marangi wrote:
> > > > Document Qcom QCA807x PHY package.
> > > > 
> > > > Qualcomm QCA807X Ethernet PHY is PHY package of 2 or 5
> > > > IEEE 802.3 clause 22 compliant 10BASE-Te, 100BASE-TX and
> > > > 1000BASE-T PHY-s.
> > > > 
> > > > Document the required property to make the PHY package correctly
> > > > configure and work.
> > > > 
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > ---
> > > >  .../devicetree/bindings/net/qcom,qca807x.yaml | 142 ++++++++++++++++++
> > > 
> > > Your bindings header must be squashed here. Headers are not separate
> > > thing from the bindings.
> > > 
> > > >  1 file changed, 142 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/net/qcom,qca807x.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/net/qcom,qca807x.yaml b/Documentation/devicetree/bindings/net/qcom,qca807x.yaml
> > > > new file mode 100644
> > > > index 000000000000..1c3692897b02
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/net/qcom,qca807x.yaml
> > > > @@ -0,0 +1,142 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/net/qcom,qca807x.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Qualcomm QCA807X Ethernet PHY
> > > 
> > > What is "X"? Wildcards are usually not expected.
> > >
> > 
> > It's to identify the Ethrnet PHY family. Looks wrong to declare qca8072
> > or qca8074 since they would refer to a more generic Family of devices.
> 
> Declare them all or provide some justification such as the exact model 
> is discoverable (and better be sure power on is the same in order to do 
> discovery).
> 
> > What would be the correct way? We have many other case on net with
> > schema called qca8k that refer to the family of Ethernet Switch but in
> > it refer to qca8327 qca8337 qca8334...
> > 
> > > > +
> > > > +maintainers:
> > > > +  - Christian Marangi <ansuelsmth@gmail.com>
> > > > +  - Robert Marko <robert.marko@sartura.hr>
> > > > +
> > > > +description: |
> > > > +  Qualcomm QCA807X Ethernet PHY is PHY package of 2 or 5
> > > > +  IEEE 802.3 clause 22 compliant 10BASE-Te, 100BASE-TX and
> > > > +  1000BASE-T PHY-s.
> > > > +
> > > > +  They feature 2 SerDes, one for PSGMII or QSGMII connection with
> > > > +  MAC, while second one is SGMII for connection to MAC or fiber.
> > > > +
> > > > +  Both models have a combo port that supports 1000BASE-X and
> > > > +  100BASE-FX fiber.
> > > > +
> > > > +  Each PHY inside of QCA807x series has 4 digitally controlled
> > > > +  output only pins that natively drive LED-s for up to 2 attached
> > > > +  LEDs. Some vendor also use these 4 output for GPIO usage without
> > > > +  attaching LEDs.
> > > > +
> > > > +  Note that output pins can be set to drive LEDs OR GPIO, mixed
> > > > +  definition are not accepted.
> > > > +
> > > > +  PHY package can be configured in 3 mode following this table:
> > > > +
> > > > +                First Serdes mode       Second Serdes mode
> > > > +  Option 1      PSGMII for copper       Disabled
> > > > +                ports 0-4
> > > > +  Option 2      PSGMII for copper       1000BASE-X / 100BASE-FX
> > > > +                ports 0-4
> > > > +  Option 3      QSGMII for copper       SGMII for
> > > > +                ports 0-3               copper port 4
> > > > +
> > > > +$ref: ethernet-phy-package.yaml#
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: qcom,qca807x-package
> > > > +
> > > > +  qcom,package-mode:
> > > 
> > > Where is definition of this property with type and description?
> > > 
> > > > +    enum:
> > > > +      - qsgmii
> > > > +      - psgmii
> > > > +
> > > > +  qcom,tx-driver-strength:
> > > 
> > > Use proper unit suffix.
> > > 
> > > https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml
> > > 
> > > > +    description: set the TX Amplifier value in mv.
> > > > +      If not defined, 600mw is set by default.
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    enum: [140, 160, 180, 200, 220,
> > > > +           240, 260, 280, 300, 320,
> > > > +           400, 500, 600]
> > > > +
> > > > +patternProperties:
> > > > +  ^ethernet-phy(@[a-f0-9]+)?$:
> > > > +    $ref: ethernet-phy.yaml#
> > > > +
> > > > +    properties:
> > > > +      gpio-controller:
> > > > +        description: set the output lines as GPIO instead of LEDs
> > > > +        type: boolean
> 
> You only need 'gpio-controller: true'. The core already defines the 
> type.
> 
> > > > +
> > > > +      '#gpio-cells':
> > > > +        description: number of GPIO cells for the PHY
> 
> Not a useful description. Normally, you'd describe what's in the cells, 
> but GPIO is standardized so no need (unless you are deviating from the 
> norm).
> 
> > > > +        const: 2
> > > > +
> > > > +    dependencies:
> > > > +      gpio-controller: ['#gpio-cells']
> > > 
> > > Why do you need it? None of gpio-controllers do it, I think.
> > > 
> > 
> > Well gpio-controller property is optional and having that declared and
> > #gpio-cells skipped will result in an error on probe. I think it should
> > be the opposite with other schema having to declare this.
> 
> If you think everything else is wrong, then please fix them. :)
> 
> > 
> > In usual way for gpio-controller both property are defined as required
> > but you can see some (to-be-converted) txt files whith comments where
> > they say:
> > 
> > ./mux/adi,adgs1408.txt:10:- gpio-controller : if present, #gpio-cells is required.
> > 
> > Should I instead add this condition in the if right below?
> 
> The core schema enforces this dependency, so you don't need to.
>

Oh! No idea the dependency was already enforced, guess I don't have to
fix everything ahahahha

-- 
	Ansuel

