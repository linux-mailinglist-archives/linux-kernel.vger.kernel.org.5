Return-Path: <linux-kernel+bounces-99484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 998BA878915
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112451F21BDD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7322455E56;
	Mon, 11 Mar 2024 19:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QwMZ30Gy"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C963F5467F;
	Mon, 11 Mar 2024 19:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710186376; cv=none; b=UNWXzPfC1IjwSy0WGBCikXhpwEVN4j+aAuxluXwhdGgulbIKvyweVjGrucVdbK9OMSC8ahoSGidI7pIWEUckfbiqtNIfa75VyTAhciNh/m9dJJ3DSKbBhMOExjXN0pVzVyBEleG8OrxgwwAN6iSvhqis6pJr2o2FRwZRZ2M4uAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710186376; c=relaxed/simple;
	bh=JdAlN8/F5cO+9DSOL89V3beQqcre9Jj7LvAx+EXcf1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gszc6M/I5Sfmxic9cHmKZBXXYrDnsfPRuW3fcZzyyuR45SjHn7BPoOGU+SI2kij8OHBbAPFxYkZfjNZ+E5BNQ6wOOVkLcNY/LCLcK7EtATvdFt+aDwyeGslgY6DTmVH7y+lM1OWxYyXUf66t9nHc+r6z/hpdhyxLZ9tQgJnT3FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QwMZ30Gy; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F23081C0004;
	Mon, 11 Mar 2024 19:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710186372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z85/zZtdbtecxKvezdDv4FpOtTpCdc6XaLa6aorMusQ=;
	b=QwMZ30GyWi56M9sNK5qjCtKCCoOyoavsbzOtEAjOZjDeDUmjB4+l+f8pHHCg1tfNNwjhrK
	xvsIIRgKerv49Zv/m4iPheV8irISjoCyJjHPXAD9w5aJAtO9Kw4ng/qkEMCcSTTUjlj8rx
	91AzycNE/Fxx1TdfoXOwWPG/RcjFAReZPPExrjTWBZv5FE8dtNUcS1va1EvVcuWHkt5EaB
	x6IjaJ7uThk3KOHUg/f8nu4c/Pn2jxdq+RrlZHo3rXhNWIjO1Q29cVGMtQhClSX2XwBbJI
	LW6Ieu9uvRSSnVMhtb9VRxp43CS33OYFb4cgxRpznXj98WM3VdwwG9IFiaQYxg==
Date: Mon, 11 Mar 2024 20:46:10 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Peter Hilber <peter.hilber@opensynergy.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	virtio-dev@lists.oasis-open.org, linux-rtc@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [RFC PATCH v3 7/7] virtio_rtc: Add RTC class driver
Message-ID: <202403111946106887ed4c@mail.local>
References: <20231218073849.35294-1-peter.hilber@opensynergy.com>
 <20231218073849.35294-8-peter.hilber@opensynergy.com>
 <2024030817030063a909f0@mail.local>
 <a4babfc9-f4da-4dfe-8431-eb819f5801eb@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4babfc9-f4da-4dfe-8431-eb819f5801eb@opensynergy.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 11/03/2024 19:28:50+0100, Peter Hilber wrote:
> >> Perhaps this might be handled by the driver also setting a virtio-rtc
> >> monotonic alarm (which uses a clock similar to CLOCK_BOOTTIME_ALARM).
> >> The
> >> virtio-rtc monotonic alarm would just be used to wake up in case it was
> >> a
> >> CLOCK_BOOTTIME_ALARM alarm.
> >> 
> >> Otherwise, the behavior should not differ from other RTC class drivers.
> >> 
> > 
> > What I don't quite get is how this is actually related to RTCs. This
> > would be a super imprecise mechanism to get the current time and date
> > from the host to the guest which is what I think your are trying to do,
> > especially since this is not supporting UIE.
> > The host system clock may come from reading the RTC at some point in
> > time but more likely from another source so is it really the best
> > synchronization mechanism?
> 
> Hello,
> 
> thank you for your comments.
> 
> The main motivation to have the RTC class driver is the RTC alarm
> (discussed below).
> 
> As for synchronization, virtio_rtc also offers a PTP clock [1] which will
> be more precise, but which needs a user space daemon. As for RTC-based
> initial synchronization, my idea was to propose, in a second step, an
> optional op for rtc_class_ops, which would read the clock with nanosecond
> precision. This optional op could then be used in rtc_hctosys(), so there
> would be no need for UIE waiting.

This would be a clear NAK, rtc_hctosys should use UIE to have proper
synchronisation. It currently does a very bad job reading the RTC and it
is a pity it has been mandated by systemd as useerspace is definitively
better placed to set the system time. I'm still very tempted delaying
everyone's boot by one second and make rtc_hctosys precise for all the
supported HW and not just a single driver.

> [1] https://lore.kernel.org/all/20231218073849.35294-6-peter.hilber@opensynergy.com/
> 
> > 
> > The other thing is that I don't quite get the point of the RTC alarm
> > versus a regular timer in this context.
> 
> RTC alarms allow to resume from suspend and poweroff (esp. also through
> alarmtimers), which is of interest in embedded virtualization. In my
> understanding RTC is ATM the only way to do this.
> 
> (I was indeed thinking about adding an alternate alarmtimer backend for
> CLOCK_BOOTTIME_ALARM, which should deal with the CLOCK_REALTIME_ALARM vs
> CLOCK_BOOTTIME_ALARM issue which is described in the commit message.)
> 

Right but this seems like a super convoluted way of getting the host to
wakeup the guest...

> > 
> > 
> > [...]
> > 
> >> +static const struct rtc_class_ops viortc_class_with_alarm_ops = {
> >> +	.read_time = viortc_class_read_time,
> >> +	.read_alarm = viortc_class_read_alarm,
> >> +	.set_alarm = viortc_class_set_alarm,
> >> +	.alarm_irq_enable = viortc_class_alarm_irq_enable,
> >> +};
> >> +
> >> +static const struct rtc_class_ops viortc_class_no_alarm_ops = {
> >> +	.read_time = viortc_class_read_time,
> >> +};
> >> +
> > 
> > [...]
> > 
> >> +/**
> >> +/**
> >> + * viortc_class_init() - init RTC class wrapper and device
> >> + * @viortc: device data
> >> + * @vio_clk_id: virtio_rtc clock id
> >> + * @have_alarm: expose alarm ops
> >> + * @parent_dev: virtio device
> >> + *
> >> + * Context: Process context.
> >> + * Return: RTC class wrapper on success, ERR_PTR otherwise.
> >> + */
> >> +struct viortc_class *viortc_class_init(struct viortc_dev *viortc,
> >> +				       u16 vio_clk_id, bool have_alarm,
> >> +				       struct device *parent_dev)
> >> +{
> >> +	struct viortc_class *viortc_class;
> >> +	struct rtc_device *rtc;
> >> +
> >> +	viortc_class =
> >> +		devm_kzalloc(parent_dev, sizeof(*viortc_class),
> >> GFP_KERNEL);
> >> +	if (!viortc_class)
> >> +		return ERR_PTR(-ENOMEM);
> >> +
> >> +	viortc_class->viortc = viortc;
> >> +
> >> +	rtc = devm_rtc_allocate_device(parent_dev);
> >> +	if (IS_ERR(rtc))
> >> +		return ERR_PTR(PTR_ERR(rtc));
> >> +
> >> +	viortc_class->rtc = rtc;
> >> +
> >> +	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
> >> +
> >> +	rtc->ops = have_alarm ? &viortc_class_with_alarm_ops :
> >> +				&viortc_class_no_alarm_ops;
> > 
> > Don't do this, simply clear the alarm feature.
> > 
> 
> OK (sorry, was obviously very inelegant).
> 
> Best regards,
> 
> Peter

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

