Return-Path: <linux-kernel+bounces-132720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC944899945
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2536283DD6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351AA1607A9;
	Fri,  5 Apr 2024 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JXw2oYVZ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBAF15FCEC;
	Fri,  5 Apr 2024 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308600; cv=none; b=N/W7d0cCyV0UkNK14se2B7uDZuow3WwMLdxsMbDcktpILYAIlkGwhziu8+l/hLsEcdBQRrFb7FKjfn7cyv3x9iSJs1u05KYTHv0SvBAz3YJCQIr4rOi3WF3E8xenTVOdIwnJAznkhgEWw8IA0HFlDgoSpd1VzEb7UCD6AJa8Bf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308600; c=relaxed/simple;
	bh=fdMbK7k3/PNgmO7Xgshuru0+/9501l65oDk3nuXnMCg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6YzKl7fCfVkWfBGOifCpImbC2QWz4t8FzSRjbVJqcm1HjwidIS0UhSQHHutSHnu2M0BAI3rQOI3QHMQgIoPLWbq0JLVb91LLjEAnFFPOnVlHqvwAXO/IPZuCMXCr19NR81IFV8TLUiznnZpZaMx3VrBw1/uKhOLys/hRzybElA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JXw2oYVZ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712308597; x=1743844597;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fdMbK7k3/PNgmO7Xgshuru0+/9501l65oDk3nuXnMCg=;
  b=JXw2oYVZJH49enVBJRrJWTptbkVfnwn4LpASayoC5l7wQYtvsrYvDKJG
   dCypznIVmg4DF0LLO7OvtOGXLIAy30df+JLFq4+j8vp9t+7DdcgdKpJnq
   cdJnTaeRjn75/AAFsHDIb7zVjZPsvpM/kN9kdEaLWQiMZ1USp+6BFWOqN
   iOvSe4y/a+qoFtozB+h/RfQhMY/UcL52vtoY4BVudvaDZo4voutDWKhuf
   lqkyY5HF/08Io9T/8HN9pQGIMQskEbLr4argQ8bSp1wYBVfytiYW8IrkA
   DnvkpW8Cl9mkO8YPKEwHj994l7DzwrA6MqwITIFk5An436YOY+vHgk1Gj
   w==;
X-CSE-ConnectionGUID: sMUIZTwPTmiGVQCGWDNR+g==
X-CSE-MsgGUID: 1BdMq5GhSjicJYu6ieBt5g==
X-IronPort-AV: E=Sophos;i="6.07,181,1708412400"; 
   d="scan'208";a="19574513"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2024 02:16:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 02:16:24 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 5 Apr 2024 02:16:24 -0700
Date: Fri, 5 Apr 2024 11:16:23 +0200
From: Horatiu Vultur - M31836 <Horatiu.Vultur@microchip.com>
To: Divya Koppera - I30481 <Divya.Koppera@microchip.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, UNGLinuxDriver <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next 2/2] net: phy: micrel: lan8814: Add support for
 PTP_PF_PEROUT
Message-ID: <20240405091623.yxbx5pkoxqqokyr2@DEN-DL-M31836.microchip.com>
References: <20240404080115.450929-1-horatiu.vultur@microchip.com>
 <20240404080115.450929-3-horatiu.vultur@microchip.com>
 <CO1PR11MB4771B9B8238242DA6406CBE6E2032@CO1PR11MB4771.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CO1PR11MB4771B9B8238242DA6406CBE6E2032@CO1PR11MB4771.namprd11.prod.outlook.com>

The 04/05/2024 08:35, Divya Koppera - I30481 wrote:
> Hi Horatiu,

Hi Divya,

> > +	ts_on.tv_sec = rq->perout.on.sec;
> > +	ts_on.tv_nsec = rq->perout.on.nsec;
> > +	on_nsec = timespec64_to_ns(&ts_on);
> > +
> > +	ts_period.tv_sec = rq->perout.period.sec;
> > +	ts_period.tv_nsec = rq->perout.period.nsec;
> > +	period_nsec = timespec64_to_ns(&ts_period);
> > +
> > +	if (period_nsec < 200) {
> > +		pr_warn_ratelimited("%s: perout period too small, minimum
> > is 200 nsec\n",
> > +				    phydev_name(phydev));
> > +		return -EOPNOTSUPP;
> > +	}
> 
> Unlock is Missing in above and below conditions.

Thanks for the review.

Jakob already mention this in a previous comment[1]. And I already sent a
new version where this is fixed.

[1] https://lore.kernel.org/netdev/20240404094137.51b1397e@kernel.org/T/#m3053305f9a354ebf89e4dd0e6140f6cfbd2591e6

> 
> > +
> > +	if (on_nsec >= period_nsec) {
> > +		pr_warn_ratelimited("%s: pulse width must be smaller than
> > period\n",
> > +				    phydev_name(phydev));
> > +		return -EINVAL;
> > +	}
> > +
-- 
/Horatiu

