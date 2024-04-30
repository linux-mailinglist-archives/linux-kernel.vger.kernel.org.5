Return-Path: <linux-kernel+bounces-164042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D7F8B77A0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD2F284453
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D57E172BA5;
	Tue, 30 Apr 2024 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WO6ovsvn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214A017167F;
	Tue, 30 Apr 2024 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485220; cv=none; b=fBkXrj4WTPWoVQpFWN0UAbImvJQJbNpL2zJZbVqOMBnqqdoHbHggsm/da0hoTRidbhf0b3KgG4ju6Jlftz6d3ZMqAuKV0eO+3h8pAk/HdUUn07kF4bVG3fCTYk7OATggQRpOXmW9ffiHSJhTgHAzjPg/zBL8UqpDzpIK4O0Piu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485220; c=relaxed/simple;
	bh=sqoodRfj0IATLtJDqqqpof/7WjIJbwK83pY5fT0FQTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAdnrwCrrSBxAdXNC5Xvh1ask3aJofvTyi5Rr4FCEU+MXQ3X5ymfpp93YLANVZDu45kjIy7wv6ty9jgxorYPO83Xt16fcfS1PIO2Wqe7Bohl/Z658XVwjOplGriW4QCqGkdWlnGXDMHJ3DWVvVDTLVlu36SffJAWcPjdqvViTxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WO6ovsvn; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714485209; x=1746021209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sqoodRfj0IATLtJDqqqpof/7WjIJbwK83pY5fT0FQTA=;
  b=WO6ovsvnXQQnMUi7k7ybacRzQ1SJoSamDypiZMm6Xk7nrkKTuQfcirws
   NN5Lu3wcvBeGtDYmuCwS2kLDl9TmC/pgJkNfOWmjds5T4qydWV62qAI86
   v+o7KYurfGeNLyEBkt69mYjssWo5PctUxvNCFeLnUvPCBUjd9YKW7V+VW
   LtAPl/+ym0jJLXWOq+142OSl7jaCA4XA2xL6NVWGhTlnqOulJ6FtGFx3K
   h2Bn7Zl47QRk5Ot757FQXxVGhObGMKc0CvgIWfHuZmH5mUazuqWgSaX3j
   Uz4W6MAvjhp82juiuop2QlGxweKW4FTvR4vR9wtXdwQmYAiJF4xK4ggRI
   g==;
X-CSE-ConnectionGUID: Cd2XlXhrRY62rp9njJrnYA==
X-CSE-MsgGUID: 2geQL9DoQbmcQt78lpU5PQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="27713347"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="27713347"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 06:53:28 -0700
X-CSE-ConnectionGUID: 5eOKwBEpSferwc2RTJ/a9g==
X-CSE-MsgGUID: 9kf4TRh7TgypIABzvykqNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26967408"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 06:53:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s1nv5-00000002gCo-0Ukb;
	Tue, 30 Apr 2024 16:53:19 +0300
Date: Tue, 30 Apr 2024 16:53:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: lakshmi.sowjanya.d@intel.com
Cc: tglx@linutronix.de, jstultz@google.com, giometti@enneenne.com,
	corbet@lwn.net, linux-kernel@vger.kernel.org, x86@kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, eddie.dong@intel.com,
	christopher.s.hall@intel.com, jesse.brandeburg@intel.com,
	davem@davemloft.net, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com, perex@perex.cz,
	linux-sound@vger.kernel.org, anthony.l.nguyen@intel.com,
	peter.hilber@opensynergy.com, pandith.n@intel.com,
	subramanian.mohan@intel.com, thejesh.reddy.t.r@intel.com
Subject: Re: [PATCH v7 10/12] pps: generators: Add PPS Generator TIO Driver
Message-ID: <ZjD3ztepVkb5RlVE@smile.fi.intel.com>
References: <20240430085225.18086-1-lakshmi.sowjanya.d@intel.com>
 <20240430085225.18086-11-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430085225.18086-11-lakshmi.sowjanya.d@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 30, 2024 at 02:22:23PM +0530, lakshmi.sowjanya.d@intel.com wrote:
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> 
> The Intel Timed IO PPS generator driver outputs a PPS signal using
> dedicated hardware that is more accurate than software actuated PPS.
> The Timed IO hardware generates output events using the ART timer.
> The ART timer period varies based on platform type, but is less than 100
> nanoseconds for all current platforms. Timed IO output accuracy is
> within 1 ART period.
> 
> PPS output is enabled by writing '1' the 'enable' sysfs attribute. The
> driver uses hrtimers to schedule a wake-up 10 ms before each event
> (edge) target time. At wakeup, the driver converts the target time in
> terms of CLOCK_REALTIME to ART trigger time and writes this to the Timed
> IO hardware. The Timed IO hardware generates an event precisely at the
> requested system time without software involvement.

..

> +static enum hrtimer_restart hrtimer_callback(struct hrtimer *timer)
> +{
> +	struct pps_tio *tio = container_of(timer, struct pps_tio, timer);
> +	ktime_t expires, now;
> +	u32 event_count;
> +
> +	guard(spinlock)(&tio->lock);
> +
> +	/* Check if any event is missed. If an event is missed, TIO will be disabled*/
> +	event_count = pps_tio_read(tio, TIOEC);
> +	if (tio->prev_count && tio->prev_count == event_count)
> +		goto err;
> +	tio->prev_count = event_count;
> +	expires = hrtimer_get_expires(timer);
> +	now = ktime_get_real();

> +	if (now - expires < SAFE_TIME_NS) {
> +		if (!pps_generate_next_pulse(tio, expires + SAFE_TIME_NS))
> +			return HRTIMER_NORESTART;
> +	} else {

Redundant.

> +		goto err;
> +	}

	if (now - expires >= SAFE_TIME_NS)
		goto err;

	if (!pps_generate_next_pulse(tio, expires + SAFE_TIME_NS))
		return HRTIMER_NORESTART;


> +	hrtimer_forward(timer, now, NSEC_PER_SEC / 2);
> +	return HRTIMER_RESTART;
> +err:
> +	dev_err(tio->dev, "Event missed, Disabling Timed I/O");
> +	pps_tio_disable(tio);
> +	return HRTIMER_NORESTART;
> +}

-- 
With Best Regards,
Andy Shevchenko



