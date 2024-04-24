Return-Path: <linux-kernel+bounces-157125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CDB8B0D25
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89C23B26A32
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF5915EFA0;
	Wed, 24 Apr 2024 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HvnJLGXk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3784715886A;
	Wed, 24 Apr 2024 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970195; cv=none; b=DdnqlJlk/7fP7wMqBlKg0Fu2oETi4wB+C3O78aqEaDzAUakkG8Lyj2mkXgLeOhkpog4YeDtAZUdgiCcfkqn5uXfJQTyuEd7eER8rY7U+FMB/rlJP4ynSga+q2Pqm9EtkmXfpaPIlveRgFPVHgdL0aefoLT1J5DxafyCaGjPDfEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970195; c=relaxed/simple;
	bh=QfIp9Cuncd8TPCMm0EDUz7IMudkuyG5DpO4qs2ODp2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjpYdtGIKJHVCtvqhniiN/i+b/4iECqaAohb7VE7xFDrCMChfAvzKX9IxKQ+UXfJ78KRxUmVSyGGd8gct4H9Yia6CabVgVMxBnvL0SmPulRa+SfIjT/VKkHD1ZwFxhsMOJiVlne5dZxYDL1/kCB6ai2eUKZNsev3LQxNf1/fVvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HvnJLGXk; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713970194; x=1745506194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QfIp9Cuncd8TPCMm0EDUz7IMudkuyG5DpO4qs2ODp2w=;
  b=HvnJLGXkFRTpzOpAEcxe4sBc2dqGP638rNYMGriEg0FFWtnfvG7h+hns
   zH+8epM1XIPq4fX9Go4F4AcvQMsXtJbOikGLM4j9vuoDMsCiEyVMItkvf
   BiHmjdtmFAvO4ExoMnuXp0vEEDBzJyaRZ1VrrCIEZ37yk+rz86si77G6k
   BJlbjENCVpQDTJoUi6o3wJqxNTm4PGqJlz3N77BoId3PjqsbFdmGHYMTd
   xkg1y+un4GQ+Y6NEXF74I/WwmbZu53Z1QLTEp0uxKkKMuFQCKlJBryFFb
   4sc1iIuFjMJPZbU37Xp7lCzCYME9bd7o6KJSWna4T3zNqTcMqrWSN0Sd/
   A==;
X-CSE-ConnectionGUID: UivBsOr8R4mX+nmmDZJVRA==
X-CSE-MsgGUID: CIkDa5Y0SMel1pYTGqVu3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="13392135"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="13392135"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 07:49:53 -0700
X-CSE-ConnectionGUID: 4ydNRvDCQRSL0tBHTCMQCg==
X-CSE-MsgGUID: kcLpl1bGTB6gEqnyj6Opyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="24802439"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 07:49:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzdwS-00000000gDk-3NW8;
	Wed, 24 Apr 2024 17:49:48 +0300
Date: Wed, 24 Apr 2024 17:49:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v2 1/1] ALSA: control: Use list_for_each_entry_safe()
Message-ID: <ZikcDLDnv1PX17wb@smile.fi.intel.com>
References: <20240423211102.3785556-1-andriy.shevchenko@linux.intel.com>
 <87h6frdxz2.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6frdxz2.wl-tiwai@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 24, 2024 at 09:24:49AM +0200, Takashi Iwai wrote:
> On Tue, 23 Apr 2024 23:10:22 +0200,
> Andy Shevchenko wrote:
> > 
> > Instead of reiterating the list, use list_for_each_entry_safe()
> > that allows to continue without starting over.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Jaroslav Kysela <perex@perex.cz>
> > ---
> > v2: added tag (Jaroslav)
> 
> We have a similar repeat in snd_ctl_led_reset().
> Wouldn't it be better to catch both?

Sure, v3 is on its way.

-- 
With Best Regards,
Andy Shevchenko



