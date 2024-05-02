Return-Path: <linux-kernel+bounces-166123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B958B9688
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68BB1C215E4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AC246433;
	Thu,  2 May 2024 08:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hEZkC2rp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03218495
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714638836; cv=none; b=OzlGW1zud2AECnIK9J3yW+g0U2T6POKWJ5Po+ntWYJG7pTNG5QMqLwysOL5A40ZmwyfQaqfYXs/t0L5Mcf54CYH93o/4rvo0Sj0cRBc9mxQuQeHxemB64SEvSiafRk3C1AtIAJFx1yQn5ixgtgb04z/FzZM1oxgFYlLVwRfEE60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714638836; c=relaxed/simple;
	bh=5tAqrkXFR/y7Phpht4DK8jfnwEPW8WWwj8wA/rkJ4ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxIoT5egHyFAaG6SoJMiI4rj7LcPds/vpRVefiwJ32FSNj88D1THigVVEAHw41cOgaQJXaHTtRwNYJak/XN4bInFTPgZrrA2aR63fyEWZwCqQCSxpJjCsvQ1rBb3g6XPDjGq7kKOtavvkPuvohEeMlaHoynBxVJjwNSdQOCsqnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hEZkC2rp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714638835; x=1746174835;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5tAqrkXFR/y7Phpht4DK8jfnwEPW8WWwj8wA/rkJ4ZM=;
  b=hEZkC2rpyfRr53CXJ9v+M+MeTCdjt8/T1ZpdymGcnGMm4sKMnRVLORnn
   LLqWBDfd17r/gUOKC+a0LTnNRNTwNcBazDVT1oVwu/FwuDtZ1y9J48w9J
   Kj6m2Byf5Eklapi4tpzS0nbNd+wK2Askl/JZNqUrbv86qfTnuoHKVelYk
   rbWnpMnZKmdxp8sPJvcQCMODIzdlFZ3LR+duPLsYPLMo9gnRRp5VxQRmx
   WBa5aXBcYWpZdaUddf28RvnX2JnHgtNUsApdUv06Fn/cxtAxxHlx5vpee
   cxD+XS0+5IpXeuk1BKebJsNJFeo9lb3wR8VdqJDTY41sQXAhcN62eTy+K
   g==;
X-CSE-ConnectionGUID: hP6RXUrpQYSbwzpYQ/1Yyg==
X-CSE-MsgGUID: BBLqaOP+RjSUaumVy6epsw==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="10613757"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10613757"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 01:33:54 -0700
X-CSE-ConnectionGUID: FYJzk8iUSbma7C5vWUjPag==
X-CSE-MsgGUID: er1gI6ykQVeTDYsaZUkwzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="64491261"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 01:33:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2Rsx-00000003FHv-1uWq;
	Thu, 02 May 2024 11:33:47 +0300
Date: Thu, 2 May 2024 11:33:47 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 0/3] drm/panel: ili9341: Obvious fixes
Message-ID: <ZjNP6xESIuUUDP5d@smile.fi.intel.com>
References: <20240425142706.2440113-1-andriy.shevchenko@linux.intel.com>
 <171463582219.3069182.3806050898196009292.b4-ty@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171463582219.3069182.3806050898196009292.b4-ty@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 02, 2024 at 09:43:42AM +0200, Neil Armstrong wrote:
> Hi,
> 
> On Thu, 25 Apr 2024 17:26:16 +0300, Andy Shevchenko wrote:
> > A few obvious fixes to the driver.
> > 
> > Andy Shevchenko (3):
> >   drm/panel: ili9341: Correct use of device property APIs
> >   drm/panel: ili9341: Respect deferred probe
> >   drm/panel: ili9341: Use predefined error codes
> > 
> > [...]
> 
> Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)
> 
> [1/3] drm/panel: ili9341: Correct use of device property APIs
>       https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/d43cd48ef1791801c61a54fade4a88d294dedf77
> [2/3] drm/panel: ili9341: Respect deferred probe
>       https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/740fc1e0509be3f7e2207e89125b06119ed62943
> [3/3] drm/panel: ili9341: Use predefined error codes
>       https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/da85f0aaa9f21999753b01d45c0343f885a8f905

Thank you, Neil, appreciated!

-- 
With Best Regards,
Andy Shevchenko



