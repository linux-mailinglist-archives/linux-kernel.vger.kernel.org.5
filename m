Return-Path: <linux-kernel+bounces-88010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2754B86DC12
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9749A1F24219
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76CE69958;
	Fri,  1 Mar 2024 07:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="btE9baPG"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094BA69943;
	Fri,  1 Mar 2024 07:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709278116; cv=none; b=csHF9tv9by9/h9HnMzw0a/HeL7zhWls8M1AtlCU1lOoXvxbF5w6mG/siFR/XCQIwIzZmzZbWGV13OEFMWm+f1+TZwYCa1CazCBXI3nRPAlKYjpQlXurElBiR5O6A5IJV6LCoPfg7BM0f6I5w1YVlL/eDVWQt7mHTRzyqWL4S11g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709278116; c=relaxed/simple;
	bh=5Wo4A9EYlwGdKNreUXFNN5bH68g9TKK3N9CXPyoeV/c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EucSLHF9xmJzGsdyELhtZEgYtVJTN1Catoq/A9A1DCPEloZLPVnZ1Wy2XkFczlBNHEqKpGNBq+LAZPjQgeB1CwY4OazE+IKBnUMpePHYqaehslnmcW8ZRJ6KBx24cRn2z3hvoRm2hwFjzl9JQb8+pOppBvXOeqJmHRP9N4G7xk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=btE9baPG; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709278113; x=1740814113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5Wo4A9EYlwGdKNreUXFNN5bH68g9TKK3N9CXPyoeV/c=;
  b=btE9baPGL4YmNkGcItvkIXK6BebgHSbYgH9SfhLlCa7iKt6gCyzn0+s2
   8hQglb3VXRKmljC2lVJRTHCWsZgNZC7cVrgJpCm6IcSlDU7N9oDNsbkBl
   HG/foOe6vUwc2xpCwHo8Ozl1E1p842wUwq5wzYdXmXdWY7ikOf0bvRUpH
   vJEF+3aK7QBGSIXKgcNyzYst11LF5qbflcQ9X9frhiKKNiRJgHNTcbs2x
   BSikmaRxiqo6I0arXkckTonyBVyv0yZpg1rgcqkOcYF6gIZv1L6XFc5AZ
   PUgZwO8mr8rlzZpgOBMf7NJqDxDRnCBNStudE2bQs2jwglRy99bEObbz5
   A==;
X-CSE-ConnectionGUID: QIh6ZxERSHmcNpB1+yhVqw==
X-CSE-MsgGUID: OdpqcaD5QC+dTdXc8FBstA==
X-IronPort-AV: E=Sophos;i="6.06,195,1705388400"; 
   d="scan'208";a="184328210"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Mar 2024 00:28:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 00:27:59 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 1 Mar 2024 00:27:59 -0700
Date: Fri, 1 Mar 2024 08:27:57 +0100
From: Horatiu Vultur - M31836 <Horatiu.Vultur@microchip.com>
To: Arun Ramadoss - I17769 <Arun.Ramadoss@microchip.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"wojciech.drewek@intel.com" <wojciech.drewek@intel.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, UNGLinuxDriver <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v2 2/2] net: phy: micrel: lan8814 cable
 improvement errata
Message-ID: <20240301072757.t36qqf47erk4jygr@DEN-DL-M31836.microchip.com>
References: <20240229195220.2673049-1-horatiu.vultur@microchip.com>
 <20240229195220.2673049-3-horatiu.vultur@microchip.com>
 <80bea3ec2ec86d2e75002f849da174f50e0b846b.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <80bea3ec2ec86d2e75002f849da174f50e0b846b.camel@microchip.com>

The 03/01/2024 03:27, Arun Ramadoss - I17769 wrote:
> Hi Horatiu,

Hi Arun,

> 
> On Thu, 2024-02-29 at 20:52 +0100, Horatiu Vultur wrote:
> > When the length of the cable is more than 100m and the lan8814 is
> > configured to run in 1000Base-T Slave then the register of the device
> > needs to be optimized.
> > 
> > Workaround this by setting the measure time to a value of 0xb. This
> > value can be set regardless of the configuration.
> > 
> > This issue is described in 'LAN8814 Silicon Errata and Data Sheet
> > Clarification' and according to that, this will not be corrected in a
> > future silicon revision.
> > 
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  drivers/net/phy/micrel.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> > index 88cc03982bb78..788fdd54fd22d 100644
> > --- a/drivers/net/phy/micrel.c
> > +++ b/drivers/net/phy/micrel.c
> > @@ -117,6 +117,10 @@
> >  #define LAN8814_EEE_STATE			0x38
> >  #define LAN8814_EEE_STATE_MASK2P5P		BIT(10)
> >  
> > +#define LAN8814_PD_CONTROLS			0x9d
> > +#define LAN8814_PD_CONTROLS_PD_MEAS_TIME_MASK_	GENMASK(3, 0)
> > +#define LAN8814_PD_CONTROLS_PD_MEAS_TIME_VAL_	0xb
> 
> nitpick: TIME_VAL macro is very generic if it can end with specific
> like TIME_VAL_100M or something similar will gives more readability.

Actually I prefer to keep it like this the name if it is possible..
Because the VAL_ represents the value and MASK_ represents the mask
value. Therefore the actual bits name of the register is
LAN8814_PD_CONTROLS_PD_MEAS_TIME.

I am trying to have a naming convetion about how to define names in this
file:
<TARGET>_<REG_NAME>_<REG_BITS_NAME>

In this way it way it is easier to find in the datasheet to what it
refers to.

> 
> > +
> > 

-- 
/Horatiu

