Return-Path: <linux-kernel+bounces-158956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E192F8B2755
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F24CCB24875
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A5214F109;
	Thu, 25 Apr 2024 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AvR5SyuC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD7714F118
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065160; cv=none; b=fYmoQswBL1N82Ffnmtzkd5a3HPUO7cqRhOtNS4uJUe5yyH6SVsHuD5vA7kMal88gOkuJ6f7NlTtNYCfsCpN6PTTEJnDP0xM/z1XOdZjctW8C7jiHZZEloRNy8aJ8SgN9hU5Ge2yVR2XUI+xcNAEWP9z11TSrM7cC7sOx/RwJnis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065160; c=relaxed/simple;
	bh=/MX7mb48Oaas11ALBDWxgSss1C+Eafy+xBsAFtLrbSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/Por7zTVEDGux4UlxDobqAFky4gaGTB8cjl0bqqws/bpctUNNoZAAurSqW3UfJ1vJsMUM/LQJoKG6M0hyrL4xb187/7Cir2cPEYT9k6GNa/S+x5NiYKZaJX+GLNgeROv8mqRwHBy4suxulmwmUCP2LSUy65dGyWas93Z/iXhi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AvR5SyuC; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714065159; x=1745601159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/MX7mb48Oaas11ALBDWxgSss1C+Eafy+xBsAFtLrbSc=;
  b=AvR5SyuC8D8fS1SM8A4aIZHLKa5JKNI8bAyjDJgQs0OhYjNdgwieb5/s
   o/HTC7JvZS1paIjvLWsmijmxTNADDTRUdxvXhiH6I3h+KT9oYIxvW19S3
   JFUQ5nqyXwr0iPlMJqZa7RUjJoNp6MB/+b0OzwZWJnxU/sA7xkT8+/0aQ
   l0YG/AzGfQBrFEt6hYPUE8WFC4zQK0w+aKwUghNTJpe27DZU9KE620cBg
   lJluXgqkpFaPJ8kaNF2MQfFFM5xyTRykc0TMwrcjd8FLveDyFdQeVZVzo
   o5W/LrsAIqIvsmWivazDj4oxEyaSAKiHBGlTH4Al+wKRDYWj1wUDdo7tX
   A==;
X-CSE-ConnectionGUID: ekHSp8IeRLuh/Hw0ukXbcQ==
X-CSE-MsgGUID: G6QHzpwaRL64kXlmfneeKw==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="9641504"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="9641504"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 10:12:38 -0700
X-CSE-ConnectionGUID: 5ntsbN1DQ2COxAcOuixMBg==
X-CSE-MsgGUID: KawXo31RSom3YxIbDfqqkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="29611907"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 10:12:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s02e9-0000000149G-3Rpi;
	Thu, 25 Apr 2024 20:12:33 +0300
Date: Thu, 25 Apr 2024 20:12:33 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Melissa Wen <mwen@igalia.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 1/1] drm: fixed: Don't use "proxy" headers
Message-ID: <ZiqPAeps9uiG63qD@smile.fi.intel.com>
References: <20240422143338.2026791-1-andriy.shevchenko@linux.intel.com>
 <87r0exs067.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0exs067.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 22, 2024 at 09:49:04PM +0300, Jani Nikula wrote:
> On Mon, 22 Apr 2024, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > Update header inclusions to follow IWYU (Include What You Use)
> > principle.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Assuming it builds, and nothing depends on other stuff from kernel.h via
> drm_fixed.h,

For the record, I have built-tested this via `make allyesconfig` on x86_64.

> Reviewed-by: Jani Nikula <jani.nikula@intel.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



