Return-Path: <linux-kernel+bounces-155771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DA58AF6EF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7024728E603
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15D013F441;
	Tue, 23 Apr 2024 18:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XfQ2vdH0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D5F13E8B8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 18:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713898694; cv=none; b=pIi/XVEdErvi5s31qMl88aImYYs77p6ViWn2lUIb9DoLxNrS1zqT7yLZD4f25ftaJRjr1qRk3WoDu/5EDWbBUEixVqxl/Dz0fO+W7eWSGr6YECrobqiuTToBauRaRMgYsRQZLnNfJzsXpcdMytOPoDGGgf5pZWFyX889+UXG13g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713898694; c=relaxed/simple;
	bh=8u7NxCqmrJ4dxUb/5JwH09FlXZ20WCy+pxzvSv16E30=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VnAjpYPdcpW7RhI6nuhJMTy9td94O0xeCKlNG9c67CducCIgJn20fwUhha9j/RRuNlW4iiGYgV2WtTL8j4E731UtZX+I/TlR04kz+DfnyHgsW7caxy6DL+JvLT78jhbsEstrF7eqcKBPQjC9Z/1Z4ChD3SOxfu8qFIjNvq9yiEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XfQ2vdH0; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713898692; x=1745434692;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8u7NxCqmrJ4dxUb/5JwH09FlXZ20WCy+pxzvSv16E30=;
  b=XfQ2vdH0YNnQROSX+1/miGqWGKU09Xj9bPJxkO3RwUItNdhQWPmODmTw
   cWPsDbKCmYT7WylZ11XfJi18c6+NVTcs8kf5MDPh60qaCl0FItEsmeBgu
   1Y2xCFKZLRvSYanyJGygu0Ku6iZS5Gb9kzk6MSjCGLCmgeg3qtgRjbtzz
   tLUEI2k6SqftVeBYEcnUHCbDmx1Eauho1d2UONjBgVlnU2CZ664xmBKCS
   sOL8BqH2ohbJGIbB9bS/Bn1stPGJIiqUUO2YQIlMrfa7f88XNV0pBbVMX
   Y512tj3WQTKubqjgR+kjZentcXK4nED2ajBgxfhQem2ZmYmDFpdkiXTKk
   g==;
X-CSE-ConnectionGUID: j+2czPq3RpuVmHbXrG/y7g==
X-CSE-MsgGUID: I8j4QP7yQ5i55PStvCTVWw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20652074"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20652074"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 11:58:12 -0700
X-CSE-ConnectionGUID: B56BPt9pRI20bACZQ9pBaw==
X-CSE-MsgGUID: KJZl/ZQjTp6KArJkDYLquw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="29119070"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 11:58:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rzLLD-00000000RQD-30Ph;
	Tue, 23 Apr 2024 21:58:07 +0300
Date: Tue, 23 Apr 2024 21:58:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
	Namhyung Kim <namhyung@kernel.org>
Subject: limits.h in tools/
Message-ID: <ZigEvxn0-70og0H1@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

It seems tons of the code in tools include linux/limits.h. But I haven't found
where do we copy it. Any pointers?

Based on the discussion 20220603183231.15159C385A9@smtp.kernel.org.

-- 
With Best Regards,
Andy Shevchenko



