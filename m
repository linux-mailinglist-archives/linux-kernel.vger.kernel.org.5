Return-Path: <linux-kernel+bounces-126909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDA4894446
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F42D1C21B34
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D793D4F602;
	Mon,  1 Apr 2024 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="ePLJZ08v"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423194C60C;
	Mon,  1 Apr 2024 17:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711992170; cv=none; b=b01QH7F9vrCgOf4vmBEj7qmvE0mjiXubcD25m3cSo/33ymPaWVRi19/SBw/ZAM6K6iiwDTlGFu4faBdAxuwuxaiOcC3g2FIwiYePXmcfnGU6C0qEUWb+NLxVQBmGx7slc5r3gRXHs79WOfwUcGSJ5CxK//9u0tBQHyHsA6BP7cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711992170; c=relaxed/simple;
	bh=zHbbCSOPyTCqPdUXRwDlup/1JNlur6S+ULZXs+kmzok=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dssyXM82KR3LS1wTE2MEwDFOzWLW+fQ682CwkgxXJwdkzKjO5qimzGiZka1YS5N1qlRa7KNlpETNtrYoHrkc0PcvuRQY7SPQPH5n0fSqU9EdlIkMU2npZOTp7JTcMwTE1VxZP+KJ3TDmahReLP+RTglxegMoQeHc5Cmk3okhKWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=ePLJZ08v; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 4EBEC120003;
	Mon,  1 Apr 2024 20:22:44 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4EBEC120003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711992164;
	bh=tl1k+GzwBoZHvPC5wGd0gk/FR6ibdQtoq6i6yG3MDtE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=ePLJZ08v9l/Hp7+tshkLyConpJh3/E7UlPychQ8v4envB4os0v896owqaCmUZBjPw
	 CASP3Kvn8yjDiOVNug2zR0XVFAP5hfsR2f70JK4yUprzcIq+X0EfxdpSH+mXgwuB5P
	 9//DgLEl4FR7a0j5vgchoors49NzStQuA6+XtIawT/vGj/MGbgaQehjcYjwt2LM20g
	 rtq+7EgaEMsCG/LVOtZKVkUAMpAFl8cIcHkxzsdjEWYVb3CApexAknmGL033IXoPJZ
	 oX41ydw3Fjehxdcd681iiS8shzVEnB4Du+a1Y2CiY1y11Ylv1lpuvDO32cgmzFb4JG
	 psrARtLC41j3w==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon,  1 Apr 2024 20:22:44 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 1 Apr
 2024 20:22:43 +0300
Date: Mon, 1 Apr 2024 20:22:43 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Rob Herring <robh@kernel.org>
CC: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <kernel@salutedevices.com>,
	<rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 1/6] dt-bindings: clock: meson: a1: pll: introduce new
 syspll bindings
Message-ID: <20240401172243.zuvj6d6ptkrt6p33@CAB-WSD-L081021>
References: <20240329205904.25002-1-ddrokosov@salutedevices.com>
 <20240329205904.25002-2-ddrokosov@salutedevices.com>
 <20240401142011.GA537763-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240401142011.GA537763-robh@kernel.org>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184515 [Apr 01 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;lore.kernel.org:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/01 16:37:00
X-KSMG-LinksScanning: Clean, bases: 2024/04/01 16:36:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/01 15:13:00 #24563578
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Rob,

On Mon, Apr 01, 2024 at 09:20:11AM -0500, Rob Herring wrote:
> On Fri, Mar 29, 2024 at 11:58:41PM +0300, Dmitry Rokosov wrote:
> > The 'syspll' PLL is a general-purpose PLL designed specifically for the
> > CPU clock. It is capable of producing output frequencies within the
> > range of 768MHz to 1536MHz.
> > 
> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > ---
> >  .../devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml     | 7 +++++--
> >  include/dt-bindings/clock/amlogic,a1-pll-clkc.h            | 2 ++
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> > index a59b188a8bf5..fbba57031278 100644
> > --- a/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> > +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> > @@ -26,11 +26,13 @@ properties:
> >      items:
> >        - description: input fixpll_in
> >        - description: input hifipll_in
> > +      - description: input syspll_in
> >  
> >    clock-names:
> >      items:
> >        - const: fixpll_in
> >        - const: hifipll_in
> > +      - const: syspll_in
> 
> A new required entry is an ABI break. Please state why that's ok or make 
> it optional (minItems: 2).

Unfortunatelly, it cannot be optional. I've explained here why:

https://lore.kernel.org/all/20240401171933.bqmjsuanqsjvjosn@CAB-WSD-L081021/

"""
The clock source sys_pll_div16, being one of the GEN clock parents,
plays a crucial role and cannot be tagged as "optional". Unfortunately,
it was not implemented earlier due to the cpu clock ctrl driver's
pending status on the TODO list.
"""

Could you please provide guidance on whether there is any alternative
approach that could potentially make it possible?

-- 
Thank you,
Dmitry

