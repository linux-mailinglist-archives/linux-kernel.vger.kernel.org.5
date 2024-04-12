Return-Path: <linux-kernel+bounces-142981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 838D58A32E4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BABA61C22445
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEAF148FF1;
	Fri, 12 Apr 2024 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="joN38Zph"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63431487F4;
	Fri, 12 Apr 2024 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712937153; cv=none; b=ujHUciYsmzEE5/cjFhbMnruIdmMfMa0zJkWy7C6Llwi/g2qkeU/q61RG33GIFqAreOJozfQzBd/3dOEV1ZTWDiCAd872NqrWpOOLBgxK1CIgK9QeNv58CW15LQGdBPthOsTQZ3cTwMrzM935QPiL2mdTeCTVeM/0Nf+cYnQR5jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712937153; c=relaxed/simple;
	bh=+9Mw43B2dc8yqpBB0UYDtikznFH+l2Yt2aPRuDCoaxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDX6YVeuqeQLKz8DNwby9igoq0v2bHgLFBoToSK98FH8Oa6hWqePz5LOoiMi7jlcR/BKpSebr8KZZTLFsh5WhPlQnEl3hYaVZ824D2ML1DFdMGwno3i7dv+FRbOIcb69LirhTRoadYKYt1NL/bXdqJRNWkCGLUxed7egxI0S/Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=joN38Zph; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712937152; x=1744473152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+9Mw43B2dc8yqpBB0UYDtikznFH+l2Yt2aPRuDCoaxs=;
  b=joN38ZphQ1iZxf7DrEH4eS2xDKF1T8BSJ3EaI58uXienr+KJt7Mf2/SD
   y8SIQ4cClnM7Ouya7+8fT2g8xS1Dw01JI/3FwPPdwM/evJSkuCznQc9Qa
   QjknC3SDnmiAJkUPnN3bFZ/Xu7+rhCk4My2GIlzo9Igy8xaNAb0DExvKl
   vQ/XioaT0roYmmMx46d786fWSRus/2HbA/F92cl95JqOntsmuy2gI3bO/
   2/BMt/sp8PvZhUT2ZwxINHufMILzRVUkqMbsxhIhkHd0HU+W3LubnLwSs
   26xgL+NLk8fq1Vis5MH6UND3m6lLxR5NhCNDYrV8F3BYY7SVGiMdRF4Tl
   g==;
X-CSE-ConnectionGUID: icjNzD5GTImK4lcoLcTaKA==
X-CSE-MsgGUID: v5Dfz/zGRSe2jvje0nMSIw==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19109610"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="19109610"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 08:52:31 -0700
X-CSE-ConnectionGUID: fcUfTuZISBWTR9K8VRnTfw==
X-CSE-MsgGUID: G/GU/PpXRyCFNjj6D9Y8Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="21689461"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 08:52:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rvJCS-00000003h58-3XTT;
	Fri, 12 Apr 2024 18:52:24 +0300
Date: Fri, 12 Apr 2024 18:52:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guanbing Huang <albanhuang0@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
	linux-acpi@vger.kernel.org, tony@atomide.com,
	john.ogness@linutronix.de, yangyicong@hisilicon.com,
	jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, lvjianmin@loongson.cn,
	albanhuang@tencent.com, tombinfan@tencent.com
Subject: Re: [PATCH v7 1/3] PNP: Add dev_is_pnp() macro
Message-ID: <ZhlYuPZTrhwZl0HD@smile.fi.intel.com>
References: <cover.1712890897.git.albanhuang@tencent.com>
 <41d35ec4ff287ad6ab4fe7360fc80fb604a12958.1712890897.git.albanhuang@tencent.com>
 <ZhlTdPNuD_IayWlw@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhlTdPNuD_IayWlw@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 12, 2024 at 06:29:56PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 12, 2024 at 11:24:12AM +0800, Guanbing Huang wrote:

..

> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I haven't given this tag _explicitly_ as it's a new code and I answered in
> the previous email that I will give one for the new version.
> 
> ...
> 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202404100523.b06UvPSB-lkp@intel.com/
> 
> No, the new feature can't be reported.
> 
> ...
> 
> Please, try again.

To clarify, remove the above lines from your first commit.
If you want, you may leave my Rb tags in the patches 2 & 3
as code wasn't changed there.

-- 
With Best Regards,
Andy Shevchenko



