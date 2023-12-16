Return-Path: <linux-kernel+bounces-2239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DFA815A12
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998251C21705
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6613035A;
	Sat, 16 Dec 2023 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJrjGe2k"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD0418E0F;
	Sat, 16 Dec 2023 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d13e4f7abso586675e9.2;
        Sat, 16 Dec 2023 08:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702742486; x=1703347286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rPPChdRLnAk4gYqif9RBtjKJ77L8HfV9AvVUL8H5eqU=;
        b=NJrjGe2k+P6XktY3IkLY8131hUqnEIIABsxjPsG9uf4F90F6VkGv8ST0E5c1/YGvHL
         8523nxeN2Po4sWLCto4AIc0tCmZ4mzFniw3+3noWkJ7K8be2de+AhxvkRjd6StWH6fIC
         sGW+GbEoC2rieS1lAEGshqfLH95eBl4+7W2tBv33HufcHqNWKWSFGIr8Otn+FDNXywD7
         IydIXnAB1RUNXTZL0N3qw6/VCQCS+NEgXxT7iU4guizpOObUIThUBR+VWpFX4Jako54K
         mzaQpAfBxu/HKPCCZ87ZuA1LlIFG2oQ6LrqlvGgAxqj+tw5tgJoS8u0W9JI26w9nrF69
         9PTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702742486; x=1703347286;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPPChdRLnAk4gYqif9RBtjKJ77L8HfV9AvVUL8H5eqU=;
        b=sv70QFu2Cd+lo3E+nOyoHOnCN6OIlYAbe3nLJM8I8S7Rrxbc9gLM7lik7mk/m4dfcc
         e9oOHhNlZqRHUhUuNbxGlhMYfy/3b2yTgrLgns/S0ADZrWCPUrXviS8jFkTRZ7jJy6cG
         LppbVbB2tHc4HLzu9mxQLLDI9F2s5OOsdsKOy0rxKCWzc+DaHTCnoJREb21vtKEPUj/m
         nwzAFmSrD5u8xqBLwj4KkHSVdpzehy6E0wcxKmMxRi9qf/IUxCVWrR2P1PvcPuzgbrHN
         ENCgVb4J+vjcIrPpQ3YRp1cwFcVNifOTCozq5paAoP+IkLggOD84bdW4jBqd1iEmNvqO
         yjDw==
X-Gm-Message-State: AOJu0YzYYAHW0XQFYaw+wurPm68SqUNRmv3188W07/MwqoKQ6vB1OR5G
	Q0iq0wF+t5vvoZfUcY6tr+4=
X-Google-Smtp-Source: AGHT+IHuUzERz4MDl25m8vZZr5qHvuCPfRh3Oi/rYMhDAFXOiHO+B93YGNhQJ1ivZNoJOjPEfWs9zg==
X-Received: by 2002:a05:600c:2259:b0:40c:78c:f2b0 with SMTP id a25-20020a05600c225900b0040c078cf2b0mr8045696wmm.2.1702742485693;
        Sat, 16 Dec 2023 08:01:25 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c1d0f00b003feae747ff2sm36668732wms.35.2023.12.16.08.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:01:24 -0800 (PST)
Message-ID: <657dc9d4.050a0220.e1913.c983@mx.google.com>
X-Google-Original-Message-ID: <ZX3J0a83LQEMIl80@Ansuel-xps.>
Date: Sat, 16 Dec 2023 17:01:21 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, hkallweit1@gmail.com, corbet@lwn.net,
	p.zabel@pengutronix.de, f.fainelli@gmail.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 14/14] dt-bindings: net: ar803x: add qca8084 PHY
 properties
References: <20231215074005.26976-1-quic_luoj@quicinc.com>
 <20231215074005.26976-15-quic_luoj@quicinc.com>
 <60b9081c-76fa-4122-b7ae-5c3dcf7229f9@lunn.ch>
 <a65ad12d-b990-4439-b196-903f4a5f096a@quicinc.com>
 <f5c5cbce-c36e-498a-97e2-35f06d927d74@lunn.ch>
 <a9798333-3105-422f-8033-76c0b1d4f439@quicinc.com>
 <7c05b08a-bb6d-4fa1-8cee-c1051badc9d9@lunn.ch>
 <ZX2rU5OFcZFyBmGl@shell.armlinux.org.uk>
 <6abe5d6f-9d00-445f-8c81-9c89b9da3e0a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6abe5d6f-9d00-445f-8c81-9c89b9da3e0a@quicinc.com>

On Sat, Dec 16, 2023 at 10:41:28PM +0800, Jie Luo wrote:
> 
> 
> On 12/16/2023 9:51 PM, Russell King (Oracle) wrote:
> > On Sat, Dec 16, 2023 at 11:21:53AM +0100, Andrew Lunn wrote:
> > > > The following is the chip package, the chip can work on the switch mode
> > > > like the existed upstream code qca8k, where PHY1-PHY4 is connected with
> > > > MAC1-MAC4 directly;
> > > 
> > > Ah, that is new information, and has a big effect on the design.
> > 
> > This QCA8084 that's being proposed in these patches is not a PHY in
> > itself, but is a SoC. I came across this:
> > 
> >   https://www.rt-rk.com/android-tv-solution-tv-in-smartphone-pantsstb-based-on-qualcomm-soc-design/
> 
> The chip mentioned in the link you mentioned is SoC, which is not the
> chip that the qca8084 driver work for.
> 
> qca8084/qca8386 is just the Ethernet CHIP, not SoC, for the switch mode
> qca8386, which is most like qca8337 the dsa drive qca8k.c is already in
> upstream.

Hi,
sorry for stepping in. I guess here there is a massive confusion with
naming and using qca8k.

Since it seems the same name is used for PHY and for Switch stuff, I
would add PHY and MAC prefix when referring to qca8064.

With the previous message I was a bit confused by the use of qca8k and
didn't know you were actually referring to the DSA driver.
Interesting... this is for the upcoming WiFi 7 platoform right? (ipq9574)

All these discussion comes for the problem of using this PHY as an
integrated PHY in the qca8386 switch and trying to select the mode in
the PHY driver.

Considering you would use the same logic of the current DSA qca8k driver
with the integrated PHY, the problem doesn't apply or a different
implementation should be used (and actually handled later when the
actual DSA code will come)

I would expect in the integrated mode, the switch to handle the PHY (as
it's done by qca8337) with the PHY defined in the switch node and qca8k
handling the PHY registration. With the following implementation flags
can be passed and PHY can be configured to integrated mode. (or virtual
PHY ID can be used for such scope with dedicated functions in the PHY
driver)

With this in mind the entire integrated problem can put on hold and
dropped to be later reimplemented when it's time. (assuming that all the
prereq are already here and the very same implementation of qca8k will
be used)

Anyway, I'm more or less the maintainer of the qca8k.c DSA driver and I
would be more than happy to help you guys internally or externally on
pushing and make this proceed further. (again assuming this is ipq9574
stuff, it would be good to finally have proper DSA driver instead of
leaving the thing unusable as it's the current situation with ipq8074)

> 
> i qca8084 chip package includes 4 PHYs, 2 PCSs and the common chip level
> modules such as GCC and security control modules, all these modules are
> located in the qca8084 chip package, since qca8084 works on PHY mode, so
> the MACs are not used.
> 
> qca8084 is connected with the SoC CHIP such as IPQ platform by PCS1
> working on 10g-qxgmii mode and the fourth PHY can also optionally
> be connected with the IPQ SoC PCS by sgmii mode, there is no more
> interface on qca8084 to connect the external chips.
> 
> > It's sounding like what we have here is some PHY IP that is integrated
> > into a larger SoC, and the larger SoC needs to be configured so the
> > PHY IP can work correctly.
> 
> qca8084 is not a SoC, it is the Ethernet chip, in this qca8084 package,
> there are GCC that is driving the PHY working on the various link speed.
> that is the reason we need to do these package level common clocks and
> resets initialization before probing PHY correctly.
> 
> > 
> > Given that this package of four PHYs seems to be rather unique, I think
> > we need Jie Luo to provide sufficient information so we can understand:
> > 
> > 1) this package of four PHYs itself
> 
> Yes, this chip package for all 4 PHYs itself, also including the PCSes
> and common package level modules such as GCC.
> 
> > 2) how this package is integrated into the SoC
> 
> the qca8084 is connected with SoC by PCSes.
> 
> > 
> > Specifically, what resets and clocks are controlled from within the
> > package's register space, which are external to the package
> > register space (and thus are provided by other IPs in the SoC).
> 
> All clocks and resets mentioned for qca8084 drive including package
> level and PCS & PHY clocks and resets from the qca8084 internal GCC
> modules register space,
> 
> > 
> > As I've said previously, the lack of DT example doesn't help to further
> > our understanding. The lack of details of what the package encompases
> > also doesn't help us understand the hardware.
> 
> Indeed, i will add the qca8084 DT example in the next patch set.
> BTW, i also replied your earlier comments by providing the DTS defined
> for the current qca8084 drive code.
> 
> hope you can have a better understanding with the provided DTS code in
> earlier reply of this email thread.
> > 
> > Unless we can gain that understanding, I feel that Jie Luo's patches
> > are effectively unreviewable and can't be accepted into mainline.
> > 

-- 
	Ansuel

