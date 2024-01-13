Return-Path: <linux-kernel+bounces-25276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4973182CC8B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 12:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32431F22DDF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 11:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF45210E8;
	Sat, 13 Jan 2024 11:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QBqRwCjY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cxTlClfH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QBqRwCjY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cxTlClfH"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C608210E1
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 11:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C08B22494;
	Sat, 13 Jan 2024 11:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705146245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=beRgYZefzbmH7GpUrflrikEV7hbo1wnhlCtbtjwBvw0=;
	b=QBqRwCjY5AbbkY84o8xdiQJtaNihGh5swn6KogKa/MudIBthDR5W1kNlbWu+FAgieJ5V1y
	7QhjKp3afN93LuvaObOXboy6rUzd12xxYKKGksahRWe7fFYt+OmS7e9vpx3LXTfW8Ihh6z
	MAVexs1E/OgpGmV9Uimi+PVRnSkkMoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705146245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=beRgYZefzbmH7GpUrflrikEV7hbo1wnhlCtbtjwBvw0=;
	b=cxTlClfH3JLnH0I37jVw1ZRQj8ePbl4aumwXqGnCfvyhCs52ftdXQrymC12JBCpWrMF1UE
	70wzexzl05tZOPDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705146245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=beRgYZefzbmH7GpUrflrikEV7hbo1wnhlCtbtjwBvw0=;
	b=QBqRwCjY5AbbkY84o8xdiQJtaNihGh5swn6KogKa/MudIBthDR5W1kNlbWu+FAgieJ5V1y
	7QhjKp3afN93LuvaObOXboy6rUzd12xxYKKGksahRWe7fFYt+OmS7e9vpx3LXTfW8Ihh6z
	MAVexs1E/OgpGmV9Uimi+PVRnSkkMoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705146245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=beRgYZefzbmH7GpUrflrikEV7hbo1wnhlCtbtjwBvw0=;
	b=cxTlClfH3JLnH0I37jVw1ZRQj8ePbl4aumwXqGnCfvyhCs52ftdXQrymC12JBCpWrMF1UE
	70wzexzl05tZOPDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20C3C13508;
	Sat, 13 Jan 2024 11:44:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7rP5B4V3omUXHQAAD6G6ig
	(envelope-from <jwiesner@suse.de>); Sat, 13 Jan 2024 11:44:05 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
	id C05299C60A; Sat, 13 Jan 2024 12:44:00 +0100 (CET)
Date: Sat, 13 Jan 2024 12:44:00 +0100
From: Jiri Wiesner <jwiesner@suse.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH v2] clocksource: Skip watchdog check for large watchdog
 intervals
Message-ID: <20240113114400.GH3303@incl>
References: <20240110192623.GA7158@incl>
 <875xzyijl5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xzyijl5.ffs@tglx>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

On Fri, Jan 12, 2024 at 05:48:22PM +0100, Thomas Gleixner wrote:
> On Wed, Jan 10 2024 at 20:26, Jiri Wiesner wrote:
> > The measured clocksource skew - the absolute difference between cs_nsec
> > and wd_nsec - was 668 microseconds:
> >> cs_nsec - wd_nsec = 14524115132 - 14523447520 = 667612
> >
> > The kernel (based on 5.14.21) used 200 microseconds for the
> > uncertainty_margin of both the clocksource and watchdog, resulting in a
> > threshold of 400 microseconds.  The discrepancy is that the measured
> > clocksource skew was evaluated against a threshold suited for watchdog
> > intervals of roughly WATCHDOG_INTERVAL, i.e. HZ >> 1, which is 0.5
> > second.
> 
> This really took some time to decode. What you are trying to explain is:
> 
>    The comparison between the clocksource and the watchdog is not
>    working for large readout intervals because the conversion to
>    nanoseconds is imprecise. The reason is that the initialization
>    values of the shift/mult pairs which are used for conversion are not
>    sufficiently accurate and the accumulated inaccuracy causes the
>    comparison to exceed the threshold.

The root cause of the bug does not concern the precision of the conversion 
to nanoseconds. The shift/mult pair of the TSC can convert diffs as large 
as 600 seconds. The HPET is limited to 179.0 seconds on account of being a 
32-bit counter. The acpi_pm can convert only 4.7 seconds. With the 
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE option enabled, the ranges are 
reduced to a half. The example above showed the TSC as the clocksource and 
the HPET as a watchdog both of which should be able to convert a diff of 
14.5 seconds to nanoseconds with sufficient precision.

I could change the description to:

The kernel (based on 5.14.21) used 200 microseconds for the 
uncertainty_margin of both the clocksource and watchdog, resulting in a 
threshold of 400 microseconds (the md variable). The root cause of the 
issue is that the measured clocksource skew, 668 microseconds, was 
evaluated against a threshold (the md variable) which is suited for 
watchdog intervals of roughly WATCHDOG_INTERVAL, i.e. HZ >> 1, which is 
0.5 second. Both the cs_nsec and the wd_nsec value indicate that the 
watchdog interval was circa 14.5 seconds.

The intention of 2e27e793e280 ("clocksource: Reduce clocksource-skew 
threshold") was to tighten the threshold for evaluating skew and set the 
lower bound for the uncertainty_margin of clocksources to twice 
WATCHDOG_MAX_SKEW. Later in c37e85c135ce ("clocksource: Loosen clocksource 
watchdog constraints"), the WATCHDOG_MAX_SKEW constant was increased to 
125 microseconds to fit the limit of NTP, which is able to use 
a clocksource that suffers from up to 500 microseconds of skew per second. 
Both the TSC and the HPET use default uncertainty_margin. When the 
watchdog interval gets stretched the default uncertainty_margin is no 
longer a suitable lower bound for evaluating skew - it imposes a limit 
that is stricter than the skew with which NTP can deal. The longer the 
watchdog interval is the larger the threshold should be. For evaluating 
skew in a watchdog interval of 14.5 seconds, a proportional threshold 
should be used, which should be 14500 microseconds (7250 coming from the 
TSC, 7250 coming from the HPET).

> So yes, limiting the maximum readout interval and skipping the check is
> sensible.

It is a bug to mark a clocksource unstable if the skew is 668 microseconds 
in 14.5 seconds. One possible solution is to skip the check. I originally 
posted a patch scaling the uncertainty_margin of clocksources but it got 
no support and the feedback I got was to avoid the calculation and skip 
the current check in order to keep the code simple:
https://lore.kernel.org/lkml/20231221160517.GA22919@incl/#t
Since skipping the check solves issue as well I sent a patch.

> >  /*
> >   * Interval: 0.5sec.
> >   */
> > -#define WATCHDOG_INTERVAL (HZ >> 1)
> > +#define WATCHDOG_INTERVAL	(HZ >> 1)
> > +#define WATCHDOG_INTR_MAX_NS	((WATCHDOG_INTERVAL + (WATCHDOG_INTERVAL >> 1))\
> > +				 * (NSEC_PER_SEC / HZ))
> 
> That 1.5 * WATCHDOG_INTERVAL seems to be rather arbitrary. One second
> should be safe enough, no?

Yes, it is arbitrary. The concern is how strict can we allow the skew 
check to get. 2 * WATCHDOG_INTERVAL would mean imposing a skew threshold 
of 250 microseconds per second for intervals that are close in their value 
to 2 * WATCHDOG_INTERVAL. Even using 2 * WATCHDOG_INTERVAL would still be 
many times better than using 500 microseconds to check skew in a 14.5-long 
watchdog interval.

> > +		/*
> > +		 * The processing of timer softirqs can get delayed (usually
> > +		 * on account of ksoftirqd not getting to run in a timely
> > +		 * manner), which causes the watchdog interval to stretch.
> > +		 * Some clocksources, e.g. acpi_pm, cannot tolerate
> > +		 * watchdog intervals longer than a few seconds.
> 
> What ensures that the watchdog did not wrap around then?

Nothing. It has always been this way. The check usually fails when the 
watchdog wraps around, in which case the clocksource is marked unstable 
for no fault of its own.

> > +				watchdog_max_intr = interval;
> > +				pr_warn("Skipping watchdog check: cs_nsec: %lld wd_nsec: %lld\n",
> > +					cs_nsec, wd_nsec);
> 
> This really wants to have a proper indication why the check was skipped,
> i,e. due to a long readout interval, no?

It could be changed to:
pr_warn("Large watchdog interval, skipping check: cs_nsec: %lld wd_nsec: %lld\n",

I will send a v3 incorporation all the suggestions after we have made the 
description intelligible. Thank you for the feedback.
-- 
Jiri Wiesner
SUSE Labs

