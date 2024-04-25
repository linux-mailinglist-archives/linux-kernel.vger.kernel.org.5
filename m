Return-Path: <linux-kernel+bounces-159016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E328B282D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98787B22168
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB6F38FB6;
	Thu, 25 Apr 2024 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SqxtjWTq"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF8A1D524;
	Thu, 25 Apr 2024 18:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714069841; cv=none; b=dm+yWeSoIfjRFDNwoaLHGkEs2Woebfjoj4kls9jJDXMotNGVr3NmbigzkR4xZnmvWLXiqCZ8P+hUfDklDWKMXZAUiIKdQ0Y3rpOtUUbh10hiKUL5dQVZjKoPq1azUhLmuYX047DvreUkcVdD0EXOukHeeHUblF8Nkbfivw3WSQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714069841; c=relaxed/simple;
	bh=A+VaXuVY9UUFc5y3pH6q94H3VQ7siy/79vLNmRHP49c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQmWVWQYBaMA3D6f91GyfFvLeb1ba75Dqr3NyiX0H6nzTeF+TCvnGO/ACfEpiBL8ENjgw4zzsibDfn3amAxh4lKlQjqYdjN8EIqECvTYbUsS3+Q/Cb64gnifEMj+Lx/kybZhyJtY7xYAFz78uWthZFu3OUn9x9Eaum2Q+cpnxS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SqxtjWTq; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714069840; x=1745605840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A+VaXuVY9UUFc5y3pH6q94H3VQ7siy/79vLNmRHP49c=;
  b=SqxtjWTqBAMMY4FTNU/JvgvDJCJD6iRhafvmJZ1GaSG+zYrZKQ8/yLb4
   4bTK8NG3wEuXdbS+IzQotjBjub8+YUNe7Wh8aIEhci8XxbT+9kTLcKm1b
   33afp8aI/KJ7N4TenPCQypf4Mv2Bh/GEyLHQjp6YgAnk/9IzmwyKD9xXy
   cjIC3Ey9XSD5PVVO9twbjVk01MJWoVrVi5cDoqpjo6tAPdxCVe04qC+ek
   b2z160koZrzA7CziDh7qRhMclctdriadVaObLCFJ37t3qwZE3K3hr7Dqm
   uehfTlybd7LtoCWvmuJsAiYvhL0cJlPOWq9IrqiU7GAn5CGhJzbZ/gSbO
   g==;
X-CSE-ConnectionGUID: mys/BuUTRBKyg/+F3Sa6/Q==
X-CSE-MsgGUID: Xzvg/q5LS6yIY1QBJHRwbQ==
X-IronPort-AV: E=Sophos;i="6.07,230,1708412400"; 
   d="scan'208";a="23246399"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Apr 2024 11:30:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 11:29:52 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 25 Apr 2024 11:29:51 -0700
Date: Thu, 25 Apr 2024 20:29:51 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: micrel: Add support for PTP_PF_EXTTS
 for lan8814
Message-ID: <20240425182951.2iq2lqngkkoy2fvo@DEN-DL-M31836.microchip.com>
References: <20240423195732.3353522-1-horatiu.vultur@microchip.com>
 <adf60fa5-052f-4135-acab-91a02a9aff61@linux.dev>
 <20240424191204.h2jajp57kpgccaql@DEN-DL-M31836.microchip.com>
 <c63232b1-2ee5-487a-b987-7cc6b47d3da3@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <c63232b1-2ee5-487a-b987-7cc6b47d3da3@linux.dev>

The 04/25/2024 01:10, Vadim Fedorenko wrote:
> > > > +static int lan8814_ptp_extts(struct ptp_clock_info *ptpci,
> > > > +                          struct ptp_clock_request *rq, int on)
> > > > +{
> > > > +     struct lan8814_shared_priv *shared = container_of(ptpci, struct lan8814_shared_priv,
> > > > +                                                       ptp_clock_info);
> > > > +     struct phy_device *phydev = shared->phydev;
> > > > +     int pin;
> > > > +
> > > > +     if (rq->extts.flags & ~(PTP_ENABLE_FEATURE |
> > > > +                             PTP_EXTTS_EDGES |
> > > > +                             PTP_STRICT_FLAGS))
> > > > +             return -EOPNOTSUPP;
> > > > +
> > > > +     pin = ptp_find_pin(shared->ptp_clock, PTP_PF_EXTTS,
> > > > +                        rq->extts.index);
> > > > +     if (pin == -1 || pin != LAN8814_PTP_EXTTS_NUM)
> > > > +             return -EINVAL;
> > > 
> > > I'm not sure how will enable request pass this check?
> > > In lan8814_ptp_probe_once pins are initialized with PTP_PF_NONE,
> > > and ptp_find_pin will always return -1, which will end up with
> > > -EINVAL here and never hit lan8814_ptp_extts_on/lan8814_ptp_extts_off
> > > 
> > 
> > Why ptp_find_pin will always return -1? Because we can set the function
> > of the pin.
> 
> ah, I see, PTP_PIN_SETFUNC + PTP_EXTTS_REQUEST ioctls will do the
> configuration. Maybe make GPIO 3 as PTP_PF_EXTTS function by default?

I would like not to make GPIO 3 to have PTP_PF_EXTTS function by default
just to keep similar with the other driver in this file.

> 
> > ...
> > 
> >   >       }
> > > > @@ -3148,6 +3263,10 @@ static int lan8814_ptpci_verify(struct ptp_clock_info *ptp, unsigned int pin,
> > > >                if (pin >= LAN8814_PTP_PEROUT_NUM || pin != chan)
> > > >                        return -1;
> > > >                break;
> > > > +     case PTP_PF_EXTTS:
> > > > +             if (pin != LAN8814_PTP_EXTTS_NUM)
> > > 
> > > Here the check states that exactly GPIO 3 can have EXTTS function, but
> > > later in the config...
> > 
> > ...
> > > 
> > > > +                     return -1;
> > > > +             break;
> > > >        default:
> > > >                return -1;
> > > >        }
> > > > 
> > > > @@ -3541,7 +3721,7 @@ static int lan8814_ptp_probe_once(struct phy_device *phydev)
> > > >        snprintf(shared->ptp_clock_info.name, 30, "%s", phydev->drv->name);
> > > >        shared->ptp_clock_info.max_adj = 31249999;
> > > >        shared->ptp_clock_info.n_alarm = 0;
> > > > -     shared->ptp_clock_info.n_ext_ts = 0;
> > > > +     shared->ptp_clock_info.n_ext_ts = LAN8814_PTP_EXTTS_NUM;
> > > 
> > > Here ptp_clock is configured to have 3 pins supporting EXTTS.
> > > Looks like it should be n_ext_ts = 1;
> > 
> > Good point, let me have a look at this.
> 
> I have checked it while checking enable part. Conditions in ptp_ioctl
> give no options to limit lowest number of pin which supports EXTTS.
> 
> I think that the ptp_clock_info documentation is misleading here:
> 
> * @n_ext_ts:  The number of external time stamp channels.
> 
> should be replaced to something like "max index of external time
> stamp channel".
> 
> With all above the patch LGTM!

Thanks for looking at this.

> 
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> 
> > 
> > > 
> > > >        shared->ptp_clock_info.n_pins = LAN8814_PTP_GPIO_NUM;
> > > >        shared->ptp_clock_info.pps = 0;
> > > >        shared->ptp_clock_info.pin_config = shared->pin_config;
> > > 
> > > 
> > 
> 

-- 
/Horatiu

