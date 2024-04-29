Return-Path: <linux-kernel+bounces-162247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D798B5879
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82447B29091
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54749548E8;
	Mon, 29 Apr 2024 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CQVCmsUw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85091B94D;
	Mon, 29 Apr 2024 12:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714393517; cv=none; b=U9sGcVtCOODGbRFlGVzpUWcVNM4/hgr4g9RPFiaUXXG2Fe1GldGhp8a/33vQAkiiOuG6AUt/3OApg50Nx4pn/cMt842zr216nv3pkQAJ5E9r0xIMIxlVftfsReR2H9C4HZLcPBXLcBO5uvPZmvr4SqDH87T3F7ZGkaItLOQzKMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714393517; c=relaxed/simple;
	bh=2KKpQkmBtz6WeGAWOGzuNPA8A8CtQmGLvcqNuiNUu2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6gFiUkKjnIVEqo8Eb0gnQFZc32ZmJdGJX0OEKWU1lQJL1hUgzF0UVAS3cJVgRoa4o9PYkRfu91SZ4AVG8T1s0mwPNmrDoBNXdOouty4KcGKQSCX0VnTl4pyvZE/b5SClOx+80dk4yvA/y76M+BsurlwG9bwAzESKxVQf+GdM8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CQVCmsUw; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714393517; x=1745929517;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2KKpQkmBtz6WeGAWOGzuNPA8A8CtQmGLvcqNuiNUu2A=;
  b=CQVCmsUw80PWM5lJ3I8x4t4IVOX8d2TYUs80jMckHMcRYIAv+Q6FEUEv
   XaTbLe9j3RkRgtEq5G99YWFmAXLRKGDt3SJrSDirFu8s+qRKkybLL+VBP
   2O1XOwmEAgdhGnYkyR7GOVEceYI1D/pj9pX8iCZVI3ByJiTyv8+hlb3pY
   YdVstSZhK63tEFJTgi6tAcQMTJStN43ae/tO+9iHhHgGC/5dHdCc990Lk
   O3TB14eR23yILER8omvgyAYX+wY5/Wms+33rKmylSjcZcKRImFcvzHVVK
   lYEKOk2SNNLcDH+Sm9cBe0zfBO5U6d8DkNFyKMv7lE0wFc969GxPAMv51
   g==;
X-CSE-ConnectionGUID: hQfOznpmThKJWbv6RuwkGA==
X-CSE-MsgGUID: VkF8WFlfT56EevpHyHuW8w==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="9924734"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="9924734"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 05:25:16 -0700
X-CSE-ConnectionGUID: kqBz/Or/SXicsbEVSMXAuA==
X-CSE-MsgGUID: FloMAkS1ROatcSp6lpwR6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26087793"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 05:25:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s1Q4D-00000002KZm-1ixb;
	Mon, 29 Apr 2024 15:25:09 +0300
Date: Mon, 29 Apr 2024 15:25:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org,
	Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Brady Norander <bradynorander@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>,
	Mark Hasemeyer <markhas@chromium.org>,
	Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: intel-dsp-config: Fix Huawei Matebook D14
 NBLB-WAX9N quirk detection
Message-ID: <Zi-RpauZjcWg0t_q@smile.fi.intel.com>
References: <5e6ba980c0738199589749b68b83f2d730512107.1713430105.git.mchehab@kernel.org>
 <20240418110453.10efcb60@sal.lan>
 <848bcc94-3a31-4fb4-81bc-bd3f138e12f6@linux.intel.com>
 <87edaopdlt.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edaopdlt.wl-tiwai@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 29, 2024 at 02:17:34PM +0200, Takashi Iwai wrote:
> On Thu, 18 Apr 2024 15:24:10 +0200,
> Pierre-Louis Bossart wrote:
> > On 4/18/24 05:04, Mauro Carvalho Chehab wrote:

..

> > Andy, what do you think and what would be your recommendation?
> 
> This one is still pending, and I'd like to hear the decision from
> Intel people.  Let me know if this hack is acceptable.

IIRC it was resolved on GitHub by Pierre, anything else I need to contribute?

-- 
With Best Regards,
Andy Shevchenko



