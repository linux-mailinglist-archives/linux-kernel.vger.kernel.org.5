Return-Path: <linux-kernel+bounces-128246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99DE895840
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F40286947
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CE8131748;
	Tue,  2 Apr 2024 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DGRbbx23"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77AA12BF3D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712071900; cv=none; b=dsC8zxMAzNB2A1KVoRMuFaTpMHipD0ipSTMKR971hw0yccNkN1RDb6ZVwc3XiaeaxbhTcY8WQ2GMlnDWHxb7W6mLXiwC3IKhOGRJcLt1qhOZWNxu+lTEvTewkb/m652VP/Mlk+l3Kmr8Zvj8HRgvu4cHGRjJBjjXdedCwQEUVmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712071900; c=relaxed/simple;
	bh=pBASrkS4prxfkCqb8ad8wDSpfxM6yP5/Zpbw0jLSIiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHMpFiBp4srA3EGxOdjIyvZNIgiYNYZkb0c2Umq2HSmbOH1pPuZ07yCjhDsJGwykjc+c6xlAzUcNfRv2G/Sa7cP78OScGyOwgk6O+tpu0n2/TDAnUXBX1Y2MyeRTH1h8tO24MymRI2ZH2lp5SePUPTKFCQfdC08O3xFTXm1IEvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DGRbbx23; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712071899; x=1743607899;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pBASrkS4prxfkCqb8ad8wDSpfxM6yP5/Zpbw0jLSIiU=;
  b=DGRbbx23ttlb8IPommJ/z2t9rEAA+iIjlXvsmkGQxFPygdvQKRg45frE
   GLwSApuUMOWRZ6RXzJrmyLjdReRDvrbycsZrZ/8H/Rw2KnYaauDyejywl
   AWjwaVibF0Smy1gQouRa/1Rpbm+6NNrJ5YHJBZlAEo4P9t6c03GVKKXJM
   +YMb2ZqZksnLqVZloyajaBmYhj2j3F6fiZMEW72/u/aCfRPHPlzqDCBOP
   eLF9M/ElFxGmcf/S5hPXQ5Mx5xyTIiJy+5BoPDOoLraUiwqhbjAHZyYMs
   0jJcOnhuYHPq4HWzCdkI4Z5l68mhxQ2mbcOhEXD8M/d/kHrUzG0ZbcVmP
   g==;
X-CSE-ConnectionGUID: vYggQ9wZTemoXAESlLetjQ==
X-CSE-MsgGUID: OADEtOH0QIuXKkDs1RonEg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7377327"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="7377327"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 08:31:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915144670"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="915144670"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 08:31:37 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rrg6p-00000000qZQ-01iL;
	Tue, 02 Apr 2024 18:31:35 +0300
Date: Tue, 2 Apr 2024 18:31:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v1 0/6] mfd: kempld: A few cleanups
Message-ID: <Zgwk1tr7x4HnnlD9@smile.fi.intel.com>
References: <20240223195113.880121-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223195113.880121-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 23, 2024 at 09:49:49PM +0200, Andy Shevchenko wrote:
> Just a set of ad-hoc cleanups. No functional change intended.

Any comments?

(I assume the 6+ weeks in the mailing list is enough for all kind of CIs
 to complain. But they hadn't AFAICS.)

-- 
With Best Regards,
Andy Shevchenko



