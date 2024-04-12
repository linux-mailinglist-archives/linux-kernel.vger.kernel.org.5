Return-Path: <linux-kernel+bounces-143026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EA88A335F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC14D1F22206
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC67148FFC;
	Fri, 12 Apr 2024 16:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pq4LaE6/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E85149013;
	Fri, 12 Apr 2024 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938388; cv=none; b=qqCS/d3ZlQTyNBNC12n/gwUm3fmzBGHQ8vlPl7s9Cw3DG4o7AJNg6jyFkV4cVyRczho2hSN7wyjC1ANZeFL89VPoMgIjRVhmSZYQ54BHXLKTfg0YeojjSowpcxQgqRwMzjUCQ6ENeuY5+fimyrfaOOk0FXL7i4OgpggvQFly8js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938388; c=relaxed/simple;
	bh=r9WaCo8AsteMJKMuCry4QLLOt5QJS8GtJCslkwm4RRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQt6qBkE3tYhFHpI1IJJ5FE9xtsOMHyqtTjfcqL0UoeCc931yCfkAX0SWw5XldL3SeV6A7jqhFRb6lLax+LTC/qLogiU9Nq3hblCkVM1KwAKc3B8I0YQ3IhogCVwfBQSQc+l4pVEieI3Folv9r9X/JlSQHP9baGCv7YiuSMfZTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pq4LaE6/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712938387; x=1744474387;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=r9WaCo8AsteMJKMuCry4QLLOt5QJS8GtJCslkwm4RRg=;
  b=Pq4LaE6/F3x8DNJRlqP2EtkETduvAbpIktYXzR2VGTbMCL1bVvUnWgl5
   GVa/OYMWpov9M8S09zRWFsf7d9wLJKbiLOhOq5Qn9FO2bM2/Z7+SwJNxW
   b/7SObTfGSbzCGb/UPdig+nSz6m5Rk/kIP2QaDEbBRCzBqyfHEvP9En/x
   hTftdSduofXve9u1xjkMH7iPnCFc6qofUssKBMG/uKnen0a8ipUfY4Dnm
   jSnTIzuXgTckr8QdtpdmWP1QC2E7cTEE9R0O0MmDCzjGGg18q4jkXu70G
   mDLAAN+tFLPhA5wz8HgcLU2APAtNAShGhZQeHh3JHDjKc35qsyi+aqrbH
   Q==;
X-CSE-ConnectionGUID: vVAMHv+xQg+untUz1c2mTA==
X-CSE-MsgGUID: vXZ09wXyQN6EvhquuLccyg==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19004074"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="19004074"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 09:12:45 -0700
X-CSE-ConnectionGUID: KzmtAe7WRUi18L9Yy/ABFg==
X-CSE-MsgGUID: FD2R05LQTP+6SOIcx/DkCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="58696027"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 09:12:42 -0700
Date: Fri, 12 Apr 2024 19:12:39 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pwm: dwc: allow suspend/resume for 16 channels
Message-ID: <Zhldd6D7ts_QJ7rt@black.fi.intel.com>
References: <20240412060812.20412-1-raag.jadav@intel.com>
 <zf74jdjza2kfgmiecmlwlws46fmy3rtxvcocmkwewgx64oewpm@xfyq2zt6ts5u>
 <Zhk-7Tp4HzF41Is5@black.fi.intel.com>
 <ZhlXLNlsHEWrxEjF@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhlXLNlsHEWrxEjF@smile.fi.intel.com>

On Fri, Apr 12, 2024 at 06:45:48PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 12, 2024 at 06:38:24PM +0300, Raag Jadav wrote:
> > On Fri, Apr 12, 2024 at 01:12:48PM +0200, Uwe Kleine-König wrote:
> > > On Fri, Apr 12, 2024 at 11:38:12AM +0530, Raag Jadav wrote:
> 
> ...
> 
> > > Otherwise I (only slightly) dislike
> > > > +	struct dwc_pwm_drvdata *data;
> > > because "data" is very generic. I'd call it ddata. But I don't feel
> > > strong here. I'm happy if you change to "ddata" in v2, I will silently
> > > apply anyhow if you prefer "data".
> > 
> > I think "data" is more readable, something like "ddata" would make me
> > re-adjust my glasses ;)
> 
> ddata is _kinda_ idiomatic, there at least several drivers use this name
> (as of my knowledge). I am bending towards Uwe's suggestion here.

Will update in v2.

Raag
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

