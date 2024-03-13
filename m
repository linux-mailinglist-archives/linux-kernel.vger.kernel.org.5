Return-Path: <linux-kernel+bounces-101430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB10E87A6FF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECBA51C225A5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310883F8D4;
	Wed, 13 Mar 2024 11:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HS1gvryZ"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E132F3B798;
	Wed, 13 Mar 2024 11:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328687; cv=none; b=XFpLEZXF2pMH8VPYZ7pF3i0lBCNAvs6TQmrmEprUHqoVAWu7b19WyjwFCtmYv+Tjok3mIATHlycAVHaj+jWIW1ILlwD9HzCWX/ad1a4PfIBIBLjTipyMTDIngzt+lk8/S4vrsivttGDgq9tBI2zR2fhqfxj5sicaZggo+qeghwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328687; c=relaxed/simple;
	bh=hxeHZhSBUHvsvoBf5IqvwwNsYzhlISlH5FeUuHmtrBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOSmizF2GlbuGWI2dUl4eTbn50XcGO5zCO1Q6ryeZe5aAEzTtAXDUDMVyWH3QNl4OMWtAwDSvUPW/hXc9L+5m1ffp+LIcJg/ofSE6TDsJhGShTmOOUJtgKoCvWUyj5LCdochHSIyLdsGcjFkf73V8fFNzkVmo0uShJMThzu6sEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HS1gvryZ; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7EBF9E000C;
	Wed, 13 Mar 2024 11:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710328683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bD8It+AS8zjMzshjMBk0JajORqnW1ER+tTJE8+Q3t9U=;
	b=HS1gvryZIrb7ssL2gw+ikVXAdfTur20JL1ruPdVMOjVfqSJ9kPA5e28xgOT0X8gRmfPsB8
	tLAqIXIA4Eg0fSxVywmpezEjP4iZV26JJjE3G2Qy0+yHDWoB5o2qJhNN9XepV8gEUXleF+
	D2oEz7sRijfNQ+gp0RMS9AOfv7scEREJZiYI3MLPDLsU5lEODgS7+CQBLg5o5IV1JHBDdH
	3iPTbcoZWf2Oi54w4G3CcRAdQJ3yhvyAJuSicrRHPtIJ/w1d1FVIzKm9B26L97aTblEtq8
	14m7z6wTpjV8Bgmx9x0EHT+p43ceherUyQ+Wdt5oyrVtpbdykLq9Q8WGWGMPyQ==
Date: Wed, 13 Mar 2024 12:18:01 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Peter Hilber <peter.hilber@opensynergy.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, virtio-dev@lists.oasis-open.org,
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"Christopher S. Hall" <christopher.s.hall@intel.com>,
	Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	"Ridoux, Julien" <ridouxj@amazon.com>
Subject: Re: [RFC PATCH v3 0/7] Add virtio_rtc module and related changes
Message-ID: <202403131118010e7ed5bf@mail.local>
References: <20231218073849.35294-1-peter.hilber@opensynergy.com>
 <0e21e3e2be26acd70b5575b9932b3a911c9fe721.camel@infradead.org>
 <204c6339-e80d-4a98-8d07-a11eeb729497@opensynergy.com>
 <667c8d944ce9ea5c570b82b1858a70cc67b2f3e4.camel@infradead.org>
 <f6940954-334a-458b-af32-f03d8efbe607@opensynergy.com>
 <57704b2658e643fce30468dffd8c1477607f59fb.camel@infradead.org>
 <d796d9a5-8eda-4528-a6d8-1c4eba24aa1e@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d796d9a5-8eda-4528-a6d8-1c4eba24aa1e@opensynergy.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 13/03/2024 10:45:54+0100, Peter Hilber wrote:
> > Exposing UTC as the only clock reference is bad enough; when leap
> > seconds happen there's a whole second during which you don't *know*
> > which second it is. It seems odd to me, for a precision clock to be
> > deliberately ambiguous about what the time is!
> 
> Just to be clear, the device can perfectly expose only a TAI reference
> clock (or both UTC and TAI), the spec is just completely open about this,
> as it tries to work for diverse use cases.
> 
> > 
> > But if the virtio-rtc clock is defined as UTC and then expose something
> > *different* in it, that's even worse. You potentially end up providing
> > inaccurate time for a whole *day* leading up to the leap second.
> > 
> > I think you're right that leap second smearing should be addressed. At
> > the very least, by making it clear that the virtio-rtc clock which
> > advertises UTC shall be used *only* for UTC, never UTC-SLS or any other
> > yet-to-be-defined variant.
> > 
> 
> Agreed.
> 
> > Please make it explicit that any hypervisor which wants to advertise a
> > smeared clock shall define a new type which specifies the precise
> > smearing algorithm and cannot be conflated with the one you're defining
> > here.
> > 
> 
> I will add a requirement that the UTC clock can never have smeared/smoothed
> leap seconds.
> 
> I think that not every vendor would bother to first add a definition of a
> smearing algorithm. Also, I think in some cases knowing the precise
> smearing algorithm might not be important (when having the same time as the
> hypervisor is enough and accuracy w.r.t. actual time is less important).
> 
> So maybe I should add a VIRTIO_RTC_CLOCK_UTC_SMEARED clock type, which for
> now could catch every UTC-like clock which smears/smoothes leap seconds,
> where the vendor cannot be bothered to add the smearing algorithm to spec
> and implementations.
> 

I still don't know anything about virtio but under Linux, an RTC is
always UTC (or localtime when dual booting but let's not care) and never
accounts for leap seconds. Having an RTC and RTC driver behaving
differently would be super inconvenient. Why don't you leave this to
userspace?

I guess I'm still questioning whether this is the correct interface to
expose the host system time instead of an actual RTC.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

