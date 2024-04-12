Return-Path: <linux-kernel+bounces-142974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330FE8A32C8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 605FAB2370C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D26B1487EB;
	Fri, 12 Apr 2024 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4xYflYc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059485491F;
	Fri, 12 Apr 2024 15:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712936755; cv=none; b=qoMkEq/s4uoieG94+D5klXDLZ+iTdAe7SJKRaRfZI0qH04mOZ7liBEArMPo0ObRlcgaL/01BC2Otm0nqKQfGK++T8mE7ICFqH+C/LT8aBu0l22X5GgFHks0FiwU2J+qmfeXEyPp9nnfKwDe1mnDwv3bzbzuLz7pRWW9XxIqItO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712936755; c=relaxed/simple;
	bh=jLER1a8sj+gzyT1U/nfakJjd3baKBId3n3bpkr04GS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQCYwUxeBhxkoqZ6Ry5ln/zcrWbbA+giJSCNdifIMY0fCMmFQEQDTxzYWuwWMXLlKg1iKTfImX9UDlxlBBhTpMI+k4n9kXtVg2q2zKQNRRksQRTnIV/UQE7AHmqARtrrqUXYAS+kJNvcX24FbtyawmpLpdTwY9SkC0rXFPVXn1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z4xYflYc; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712936754; x=1744472754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jLER1a8sj+gzyT1U/nfakJjd3baKBId3n3bpkr04GS4=;
  b=Z4xYflYcqd+5ILoIxPnXlzJviQy8cg7lL+oY94O1QlZKoxF5Z2on1Giq
   DQrqf+ahXAFz4lCmrI2idDKHkq1cn0PEj5mo1IghdXfUhTGJ9CJ/eqzsE
   Cdsh74RUVta3tdkPOf5cLtmY3ycEw6DIleEwq0x9xNiubmqJf4JwGRi39
   DHFMlES8A0fOXvT9JqsaSSXPYy4An4yVJOdWl86DvcFoPsCzP0EXkvhrh
   RjQtP4fWi19I9vWfPbECKf6yPqVFxVjlyPzHfFrW+iXKoSuLK8qu3xVDD
   Rr2GiiC0eIH/dzU2Dn1j+bgRzn2E8xCp5takvSzlYKkeu8fnH2FtkmX4i
   Q==;
X-CSE-ConnectionGUID: iLZ/HxNIT3qk60rFra4EGg==
X-CSE-MsgGUID: AbPK2cjWQAyYXtRJoDm+Fg==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19791615"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="19791615"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 08:45:53 -0700
X-CSE-ConnectionGUID: /2k1D6qiTdGiUHbBwJIURQ==
X-CSE-MsgGUID: WLwpahZQT+mrV8Z4d52GkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="21252439"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 08:45:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rvJ64-00000003gzj-3we3;
	Fri, 12 Apr 2024 18:45:48 +0300
Date: Fri, 12 Apr 2024 18:45:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pwm: dwc: allow suspend/resume for 16 channels
Message-ID: <ZhlXLNlsHEWrxEjF@smile.fi.intel.com>
References: <20240412060812.20412-1-raag.jadav@intel.com>
 <zf74jdjza2kfgmiecmlwlws46fmy3rtxvcocmkwewgx64oewpm@xfyq2zt6ts5u>
 <Zhk-7Tp4HzF41Is5@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zhk-7Tp4HzF41Is5@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 12, 2024 at 06:38:24PM +0300, Raag Jadav wrote:
> On Fri, Apr 12, 2024 at 01:12:48PM +0200, Uwe Kleine-König wrote:
> > On Fri, Apr 12, 2024 at 11:38:12AM +0530, Raag Jadav wrote:

..

> > Otherwise I (only slightly) dislike
> > > +	struct dwc_pwm_drvdata *data;
> > because "data" is very generic. I'd call it ddata. But I don't feel
> > strong here. I'm happy if you change to "ddata" in v2, I will silently
> > apply anyhow if you prefer "data".
> 
> I think "data" is more readable, something like "ddata" would make me
> re-adjust my glasses ;)

ddata is _kinda_ idiomatic, there at least several drivers use this name
(as of my knowledge). I am bending towards Uwe's suggestion here.

-- 
With Best Regards,
Andy Shevchenko



