Return-Path: <linux-kernel+bounces-119244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C2988C614
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B04B1C66134
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D07813C680;
	Tue, 26 Mar 2024 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VrYN6L+3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476991E484
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465136; cv=none; b=b557TCNzF1LUPOEFLO/SxZkUl6QscCXMZDcgzuqIl318+htSg7SYn0BV9KdZdsL6Ce9rJnj/SdB3B76CWEeEwtO6Si5bdJvBh+mkadet3JRDFs3dErJcKHYJo+qVH3weoUO2nXGPlrOCB8gPaoeSZGQeiBY1YGevIHFFlp4UzUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465136; c=relaxed/simple;
	bh=euufMSB4SVE5RBXsdwnHwJCF8Qu8BkG8kahi1cBb2O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoElgN573M94SuU+P3/e05s326aCeBVY0Y+f15gL/3UUfZ3TZAiT8pPqv+tFHpnA7VlBvutMcZTmijjfjSETAdF5zJQTdE1Tg5lZmhbezcv0swzk9QkOZB3g8y7561701GLL9v/7fTnGS0y1OJvf+HquH4WoL5ryuyGzE4dlEZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VrYN6L+3; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711465135; x=1743001135;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=euufMSB4SVE5RBXsdwnHwJCF8Qu8BkG8kahi1cBb2O4=;
  b=VrYN6L+3saYKE51NcQ8N0E7ua0K+nP4JwYuPdwcsur1fGEXlN7Gpv7bM
   eqBnQMC1JUsioIwt8h5ZHPu2CygoeOBPeKpOPP0s7J1wrgPxf77QMxoYq
   GnaFdJ/NjLRBgF9V5dKa673CYNueGAmoDYp4HYWwbSKwlGo5McNdRwzv8
   JnKarKCGrXdi0lh4Mug2s2Dn+K/IoCwhNR7ABFaiwKJmxGIWNkJt7iYFw
   QwavTfi+RWlVyAzXkXFE9oPl/hIJFrckLJ9gbChQz+s19mH8SGkJx7jva
   Y9ZHW+Mj7tcuuHNJpVT+hCDCHMFGjRl+8LTxyWLnbLaTKDN+Ydktbjudr
   w==;
X-CSE-ConnectionGUID: uLSfJMhmQyGbLo2XMv2BSA==
X-CSE-MsgGUID: UKu+eygjQb6aXRr5EwWr2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="29000277"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="29000277"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 07:58:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914882629"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="914882629"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 07:58:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rp8GF-0000000GKhL-46Jt;
	Tue, 26 Mar 2024 16:58:47 +0200
Date: Tue, 26 Mar 2024 16:58:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, robh+dt@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, kevin-lu@ti.com,
	13916275206@139.com, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
	yung-chuan.liao@linux.intel.com, broonie@kernel.org, soyer@irl.hu
Subject: Re: [PATCH v1 1/8] ALSA: hda/tas2781: Add tas2781 SPI-based driver
Message-ID: <ZgLipy9f67JfZhx4@smile.fi.intel.com>
References: <20240326010905.2147-1-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326010905.2147-1-baojun.xu@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 26, 2024 at 09:08:58AM +0800, Baojun Xu wrote:
> Add TXNW2781 support in smi.

What is 'smi'? Can you make message less cryptic, please?
Also explain why it should be in that list in scan.c.

Code wise LGTM, so with commit message fixed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



