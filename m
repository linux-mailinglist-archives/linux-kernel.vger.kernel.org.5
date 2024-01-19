Return-Path: <linux-kernel+bounces-31245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD44A832B0D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E0B52889E8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AF854BD9;
	Fri, 19 Jan 2024 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W+/ioX1b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3vn4frNM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W+/ioX1b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3vn4frNM"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CE15380F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705673493; cv=none; b=sdIicBbFX3OVCBi1smPMatbd/ITv0F75KqAlSNAAm8licaFHBqhsOp2eDP/yvjUy3vLsRR8y29rWB7aOoUEVE6JGgdqVIoIpzFmVV3PPJc0YDeishaptflsNA4sORV14Jnxv0XT5iVjU+ARwlX7EtbqeZNQVEFNrMEoTdfUsfY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705673493; c=relaxed/simple;
	bh=lFZW9MCfcnWmU3wNRocY0y7spmXgH1YpoNJ0jZz+4xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/V+x6KQ8nQwpSNcsjZe2vR8/dP7bVAgppa9dq2fbow8t8jWm7aP2UW2NyMToQChUEO6VWHP1pJdV3KC87B3kypZZM7uf/ZBF32SprnXf2m2rP7DGKXHMwTTFg9pImvpgnEO82cKC0ulXFCwBo7nGQenjbptzZIEyK9TfWxXwG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W+/ioX1b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3vn4frNM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W+/ioX1b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3vn4frNM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 16B1D21F29;
	Fri, 19 Jan 2024 14:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705673490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TCROTf+McwZw1+8bGOBthfecAv+bg/amZRuGRxQT7w0=;
	b=W+/ioX1b0ugM2YwMane523xCmqOCyogvY827FJ6ZsUQnRoYM8Si3ARCVgn/gk/NnsGufy4
	b5T/zj76YjYqEvgcjG3RvR1vFxxkfmVbNFerVyQp5hZw05B1R759p66RgdJbhM6pHLkpEv
	ecJOI/llcMUBXQASFFlpHRodgi4+evY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705673490;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TCROTf+McwZw1+8bGOBthfecAv+bg/amZRuGRxQT7w0=;
	b=3vn4frNM21QjlxUPll34BWLlns1j37SJWweY+nkQFovbWcfS5JKkSXz3V170nshVU1w9ap
	uk5fTBAdJ5vOb2Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705673490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TCROTf+McwZw1+8bGOBthfecAv+bg/amZRuGRxQT7w0=;
	b=W+/ioX1b0ugM2YwMane523xCmqOCyogvY827FJ6ZsUQnRoYM8Si3ARCVgn/gk/NnsGufy4
	b5T/zj76YjYqEvgcjG3RvR1vFxxkfmVbNFerVyQp5hZw05B1R759p66RgdJbhM6pHLkpEv
	ecJOI/llcMUBXQASFFlpHRodgi4+evY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705673490;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TCROTf+McwZw1+8bGOBthfecAv+bg/amZRuGRxQT7w0=;
	b=3vn4frNM21QjlxUPll34BWLlns1j37SJWweY+nkQFovbWcfS5JKkSXz3V170nshVU1w9ap
	uk5fTBAdJ5vOb2Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07A331388C;
	Fri, 19 Jan 2024 14:11:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x4rZARKDqmVnLAAAD6G6ig
	(envelope-from <jwiesner@suse.de>); Fri, 19 Jan 2024 14:11:30 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
	id AF1F09C78B; Fri, 19 Jan 2024 15:11:29 +0100 (CET)
Date: Fri, 19 Jan 2024 15:11:29 +0100
From: Jiri Wiesner <jwiesner@suse.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH v2] clocksource: Skip watchdog check for large watchdog
 intervals
Message-ID: <20240119141129.GJ3303@incl>
References: <20240110192623.GA7158@incl>
 <875xzyijl5.ffs@tglx>
 <20240113114400.GH3303@incl>
 <87cyu4hih1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyu4hih1.ffs@tglx>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="W+/ioX1b";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3vn4frNM
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 16B1D21F29
X-Spam-Flag: NO

On Sun, Jan 14, 2024 at 01:22:18AM +0100, Thomas Gleixner wrote:
> On Sat, Jan 13 2024 at 12:44, Jiri Wiesner wrote:
> > On Fri, Jan 12, 2024 at 05:48:22PM +0100, Thomas Gleixner wrote:
> >> On Wed, Jan 10 2024 at 20:26, Jiri Wiesner wrote:
> >> > The measured clocksource skew - the absolute difference between cs_nsec
> >> > and wd_nsec - was 668 microseconds:
> >> >> cs_nsec - wd_nsec = 14524115132 - 14523447520 = 667612
> >> >
> >> > The kernel (based on 5.14.21) used 200 microseconds for the
> >> > uncertainty_margin of both the clocksource and watchdog, resulting in a
> >> > threshold of 400 microseconds.  The discrepancy is that the measured
> >> > clocksource skew was evaluated against a threshold suited for watchdog
> >> > intervals of roughly WATCHDOG_INTERVAL, i.e. HZ >> 1, which is 0.5
> >> > second.
> >> 
> >> This really took some time to decode. What you are trying to explain is:
> >> 
> >>    The comparison between the clocksource and the watchdog is not
> >>    working for large readout intervals because the conversion to
> >>    nanoseconds is imprecise. The reason is that the initialization
> >>    values of the shift/mult pairs which are used for conversion are not
> >>    sufficiently accurate and the accumulated inaccuracy causes the
> >>    comparison to exceed the threshold.
> >
> > The root cause of the bug does not concern the precision of the conversion 
> > to nanoseconds. The shift/mult pair of the TSC can convert diffs as large 
> > as 600 seconds. The HPET is limited to 179.0 seconds on account of being a 
> > 32-bit counter. The acpi_pm can convert only 4.7 seconds. With the 
> > CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE option enabled, the ranges are 
> > reduced to a half. The example above showed the TSC as the clocksource and 
> > the HPET as a watchdog both of which should be able to convert a diff of 
> > 14.5 seconds to nanoseconds with sufficient precision.
> 
> No. It _is_ an initialization and conversion precision problem, nothing
> else.
> 
> Assume a perfect world where the frequency of the TSC and the frequency
> of the HPET are precisely known at initialization time and the
> conversion factors to nanoseconds are precise as well. Assume further
> that the clock frequencies wont drift over time differently.
> 
> Then the relationship between the nanosecond converted readouts of TSC
> and HPET (or any other watchdog clocksource) would be constant
> independent of the readout interval with the following prerequisites:
> 
>   1) freq(TSC) / freq(HPET) == constant
> 
>   2) Conversion from TSC to nanoseconds is correct independent of the
>      interval
> 
>   3) Conversion from HPET to nanoseconds is correct independent of the
>      interval
> 
> So if all apply the uncertainty margin would be correct for any
> valid non wrapped around readout interval

Agreed.

> valid non wrapped around readout interval, which is a completely
> different issue to take care of.

It is. I did not mean to address that with the patch but did only 
coincidentally.

> Though because neither the frequency values are precise nor the
> conversion factors to nanoseconds are precise for a larger interval nor
> there is a guarantee that the clock frequencies of both clocks can't
> drift differently all prerequisites #1 - #3 above are not there.
> 
> As a consequence there _is_ a limitation to the readout interval where
> the comparison is valid.

I must admit the root cause of both inaccuracy of the shift/mult pairs and 
conversion precision fits the observed behaviour. The observed behaviour 
is that watchdog checks may fail for large readout intervals on 8 NUMA node 
machines. So, my hypothesis was that the size of the skew is directly 
proportinal to the length of the readout interval. This is what the patch 
means to address.
-- 
Jiri Wiesner
SUSE Labs

