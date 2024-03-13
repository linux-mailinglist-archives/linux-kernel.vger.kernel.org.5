Return-Path: <linux-kernel+bounces-101500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7466187A7EE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2835E2839BC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5303FB1D;
	Wed, 13 Mar 2024 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WAQ7ECWm"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B032EAF7;
	Wed, 13 Mar 2024 12:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710334707; cv=none; b=S+zZDWNBjqP1tpaEB6EfRkgJbK3/MTdu5y/e0pn5wLNjpBHVtppAv3PRalWrXFeHsyg+ALnI7hEi2Ij7EeXmhqeHF184h0R3fK84Vp2O2ifqusuPtt2CpQcM8SwAtpCGF+J6WxVoJ15SJQS71MW7xjWyYuAtQVdHTTcMDnAzhK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710334707; c=relaxed/simple;
	bh=hJh1+o838mN+1uSio3mU/BWWt88jK+qtP+0D/946Y+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2yteSmzCO+IndBv/5IGM8124tJDGCGRU8PkMff3zvMIscHfuO5+K+3DRhiz/2r2B3ap9+Vl3T/QL/vG99YT5U/+iq4+/B0OIisaAjUtu4mEMWtwxncrgmWsWVIk29JfI/san7GfPpQGxWfPOpkbCvXtB1emtcWa/0jWE/w0bAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WAQ7ECWm; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BAF4DFF809;
	Wed, 13 Mar 2024 12:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710334696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mx4SaTEHX/lA0NAN8GNivatQCJaMOF+1Nu2r2G9g3oU=;
	b=WAQ7ECWm751CFpR96kCQu3giLkwLk0GYMCLmislJIKbyIqI8bfLeEvJguzH332kax/e3nY
	2RoEUHM5effPwWHiYcXsaVFN2vDKRQZu29R5B/8FFbRKNqYppToE+d2TEEeYAO/eIabFaO
	OV6f36jqLK+aF8vcBFNWODk0lplVIk67vwdNN6Q1E4QTNBZNsPQZLvyvVDi7Xz4Qd3Jiy4
	My0mYc0b856O2d5xSX6oLJh1VMGuI8JjMWQmzrXN7TMzLremSfRiHEzitTB2eV8nCXAbpK
	PfcMA3L5SWlhB6i8/qHDamPjZHAQWpdrTy7kTmU4G1eh6sy0SCo1SOT44q46sw==
Date: Wed, 13 Mar 2024 13:58:13 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	virtio-dev@lists.oasis-open.org,
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
Message-ID: <20240313125813ec78d5a9@mail.local>
References: <20231218073849.35294-1-peter.hilber@opensynergy.com>
 <0e21e3e2be26acd70b5575b9932b3a911c9fe721.camel@infradead.org>
 <204c6339-e80d-4a98-8d07-a11eeb729497@opensynergy.com>
 <667c8d944ce9ea5c570b82b1858a70cc67b2f3e4.camel@infradead.org>
 <f6940954-334a-458b-af32-f03d8efbe607@opensynergy.com>
 <57704b2658e643fce30468dffd8c1477607f59fb.camel@infradead.org>
 <d796d9a5-8eda-4528-a6d8-1c4eba24aa1e@opensynergy.com>
 <202403131118010e7ed5bf@mail.local>
 <dcd07f0b733a90ac3f3c43a4614967bbb3ef14ad.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcd07f0b733a90ac3f3c43a4614967bbb3ef14ad.camel@infradead.org>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 13/03/2024 12:29:38+0000, David Woodhouse wrote:
> On Wed, 2024-03-13 at 12:18 +0100, Alexandre Belloni wrote:
> > 
> > I still don't know anything about virtio but under Linux, an RTC is
> > always UTC (or localtime when dual booting but let's not care) and never
> > accounts for leap seconds. Having an RTC and RTC driver behaving
> > differently would be super inconvenient. Why don't you leave this to
> > userspace?
> 
> Well yes, we don't need to expose *anything* from the hypervisor and we
> can leave it all to guest userspace. We can run NTP on every single one
> of *hundreds* of guests, leaving them all to duplicate the work of
> calibrating the *same* underlying oscillator.
> 

Really, I see the point of sharing the time accurately between the host
and the guest and not duplicating the effort. This is not what I am
objecting to.

> I thought we were trying to avoid that, by having the hypervisor tell
> them what the time was. If we're going to do that, we need it to be
> sufficiently precise (and some clients want to *know* the precision),
> and above all we need it to be *unambiguous*.
> 
> If the hypervisor says that the time is 3692217600.001, then the guest
> doesn't actually know *which* 3692217600.001 it is, and thus it still
> doesn't know the time to an accuracy better than 1 second.
> 

The RTC subsystem has a 1 second resolution and this is not going to
change because there is no point doing so for the hardware, to get the
time precisely, UIE MUST be used there is no vendor that will just
support reading the time/date or timestamp as this is way too imprecise.

> And if we start allowing the hypervisor to smear clocks in some other
> underspecified ways, then we end up with errors of up to 1 second in
> the clock for long periods of time *around* the leap second.
> 
> We need to avoid that ambiguity.

Exactly my point and I said, reading an RTC is always UTC and never
handles leap seconds so if userspace doesn't handle the leap second and
updates the RTC, too bad. There are obviously no RTC that will smear
clock unless instructed to, so the hypervisor must not smear the clock.

Note that this is not an issue for the subsystem because if you are not
capable to track an accurate clock, the RTC itself will have drifted by
much more than a second in between leap second inclusions.

> 
> > I guess I'm still questioning whether this is the correct interface to
> > expose the host system time instead of an actual RTC.
> 
> If an RTC device is able to report '23:59:60' as the time of day, I
> suppose that *could* resolve the ambiguity. But talking to a device is
> slow; we want guests to be able to know the time — accurately — with a
> simple counter/tsc read and some arithmetic. Which means *paired* reads
> of 'RTC' and the counter, and a precise indication of the counter
> frequency.

23:59:60 is not and will never be allowed in the RTC subsystem as this
is an invalid value for the hardware.

The TSC or whatever CPU counter/clock that is used to keep the system
time is not an RTC, I don't get why it has to be exposed as such to the
guests. PTP is fine and precise, RTC is not.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

