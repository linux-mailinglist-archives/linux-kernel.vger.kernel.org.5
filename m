Return-Path: <linux-kernel+bounces-164838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 440F08B83D1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 02:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C271C223C7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F5146BA;
	Wed,  1 May 2024 00:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YpO/8Zr0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000DA646;
	Wed,  1 May 2024 00:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714524779; cv=none; b=U4dzwiG7m/ROcZpKlVf35poKcRQuTe5J9OfpUhoD/H1brrsmBwYHdwB/QoiXho1upAMgTqJBML04RYm4VeEcgtHuRJUrCqkxZdq7CbCELjY984bcSMmBzcPNGMgv9EDhSaiNL6142U6ENeKxtnQMRHS/pjf1U1hqTAxRWHiR/NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714524779; c=relaxed/simple;
	bh=/TN7SiCublb2q/4ojZFR4/POqT5ttG+SWtdRCGOgxd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aufgg1ySVFOrorNlG9TMnxvmfxUeZ+JBxeEFbNQOi/pMbde0Zi8pd/gyIjjCE3qkUZBDXFf+xVRiuXE9LvrDJd88S9QvNYzDHZQYMo2qago81eTqIxLeWK2wTjFwBeZz345+s++axFygkOhURIsTYxqmEB/s+NH5fZbnkfGzG/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YpO/8Zr0; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714524777; x=1746060777;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/TN7SiCublb2q/4ojZFR4/POqT5ttG+SWtdRCGOgxd8=;
  b=YpO/8Zr0/4apu/vf2VqnTrB+aMK7+xyN1+70/LG0SpIxiS/d9pZKTL0q
   b2/vwZXC4hidF8mjEl3tlKMwSb5ozzAbGw5n8YwGofo1JF2ARPGgyB16p
   vSr5VKMIPuFfsnokFEFH+YzcOGRcyINp3E8PrFHCr2FWv8GcZlrkqI7Pu
   Xwnf/S63fTi+Lz+tyN8bxo8eO75uyvkqiThZeI1g4MyxMZVGe6wj8czSF
   GrhFRkyaiWaf6LYD0j7KZsiCyr06gOLNEpdiaqSnDuwZ5bpfNaNsoYsTk
   pByzBGPGhgC2DLKGPfYl4ilgo/COgY52z9KxcFo3c08sBT3fgOBsFUP8W
   A==;
X-CSE-ConnectionGUID: AUbc9CL7RfCHHW98SCzUhg==
X-CSE-MsgGUID: 9tIuphHFQ3uhlLrhLTt3kQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10427247"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="10427247"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 17:52:57 -0700
X-CSE-ConnectionGUID: IKMrh20OTIOli/AiCOwNWg==
X-CSE-MsgGUID: wuwKJK23QO++FFMVLKNXFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="27057176"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 17:52:56 -0700
Date: Tue, 30 Apr 2024 17:59:40 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
	"Brown, Len" <len.brown@intel.com>,
	"stanislaw.gruszka@linux.intel.com" <stanislaw.gruszka@linux.intel.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Neri, Ricardo" <ricardo.neri@intel.com>
Subject: Re: [PATCH 2/4] thermal: intel: hfi: Tune the HFI thermal netlink
 event delay via debugfs
Message-ID: <20240501005940.GA29652@ranerica-svr.sc.intel.com>
References: <20240429234152.16230-1-ricardo.neri-calderon@linux.intel.com>
 <20240429234152.16230-3-ricardo.neri-calderon@linux.intel.com>
 <e7fa25681ed057988c5ed14ebddad72e09b20703.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7fa25681ed057988c5ed14ebddad72e09b20703.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, Apr 30, 2024 at 04:52:52AM +0000, Zhang, Rui wrote:
> On Mon, 2024-04-29 at 16:41 -0700, Ricardo Neri wrote:
> > THe delay between an HFI interrupt and its corresponding thermal
> 
> s/THe/The

Ah, I read the changelog 1000 times and still I misse this. Thanks!

> 
> > netlink
> > event has so far been hard-coded to CONFIG_HZ jiffies. This may not
> > suit
> > the needs of all hardware configurations or listeners of events.
> > 
> > If the update delay is too long, much of the information of
> > consecutive
> > hardware updates will be lost as the HFI delayed workqueue posts a
> > new
> > thermal netlink event only when there are no previous pending events.
> > If
> > the delay is too short, multiple, events may overwhelm listeners.
> > 
> > Listeners are better placed to determine the delay of events. They
> > know how
> > quickly they can act on them effectively. They may also want to
> > experiment
> > with different values.
> > 
> > Start a debugfs interface to tune the notification delay.
> 
> Why this is implemented as debugfs rather than a module param?

Implementing as module param would require more work. In its current form,
intel_hfi is not a module. Its entry points are device_initcall()
(via therm_throt.c) and CPU hotplug.

I can look into implementing as a module param if folks think its a
better solution.

