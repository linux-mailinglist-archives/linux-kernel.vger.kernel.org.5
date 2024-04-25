Return-Path: <linux-kernel+bounces-158774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F55E8B24B5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E491C21877
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484833BBE6;
	Thu, 25 Apr 2024 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C0LqFtEI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AD741C6C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714057742; cv=none; b=Ygsk2kCkqf2hMIe6xQ4HG1ZSyYonWqYut4nfrRPtpFh+Ij86lUcE4nNm6iQj1lNdYV8+9oMfJu0rBwFvJhLGKhvDE3jllmZgP+x0Qv0gEOuwSUhZue7Yn2Oswn3WAjCWcGEKLMIozQaeuhzOhT0Jt2Btvctdyj04w1gF9lKbMII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714057742; c=relaxed/simple;
	bh=Lurgw0dvlqu/AllUXoRvG5F3HtkgrU7tdy2p3P/MLYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDWDu7lRC/G6IHFU66v0qo13gaPCxiWeyoAEITB6O5EH1lwncrnadCXyQpkltxFKb8xDrWigevdml/z7xMZ+xPdymL5Qn8zssc0U+60cVQev8t+ReoRnxpypuXCbT7fMDcJktItQV+VPNUKdqoFJZu5oVd5t6MU79tdgL8YWs4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C0LqFtEI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714057741; x=1745593741;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lurgw0dvlqu/AllUXoRvG5F3HtkgrU7tdy2p3P/MLYw=;
  b=C0LqFtEI4w9mxOiM3aPzGg3IHTYxNlhIE3z14KeAVxXoCixeQ41bJXRW
   BVlhIVEzJF7jqlP+oA+wkrLlBmnHOpfT3ksWYqmWYJEABf/NkUm6UrdIy
   GEBfQN5a+tCFQ6PJfx/7rtwG91L1arSjIkP3gvhXvs1UzRdYFWbP9Nwau
   LIcyZqMqrHKPJhX3c5/uicljYTcNEhKjIzTGBRZZCRcEjfzgH7Q032l7Q
   lTWnwtoxWawQmPg2tGmXrU6GFABBT7M2JWraHPXGDWGiuidSymSShzT7m
   xpCKrOFU9o2kXHc8m6a4IW+E5IDFFzCM0JzAvbIydKZycZe4FGOnJ8C+4
   w==;
X-CSE-ConnectionGUID: Y86ph98TT3mofpkh7lq3kg==
X-CSE-MsgGUID: TgpiU6ezR4WgqJPSnvhG0g==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="21170741"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="21170741"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 08:09:00 -0700
X-CSE-ConnectionGUID: pnD+ssClQbWbdCTbrEurqQ==
X-CSE-MsgGUID: tr4IzscMRR66iXtWy7wr4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="56041847"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 08:08:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s00iU-000000012EX-0Q6K;
	Thu, 25 Apr 2024 18:08:54 +0300
Date: Thu, 25 Apr 2024 18:08:53 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 0/3] drm/panel: ili9341: Obvious fixes
Message-ID: <ZipyBTyP6bDmu943@smile.fi.intel.com>
References: <20240425142706.2440113-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425142706.2440113-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 25, 2024 at 05:26:16PM +0300, Andy Shevchenko wrote:
> A few obvious fixes to the driver.

Note, despite the desire of removal Adafruit support from this driver,
the older (read: stable) kernels will need this.

-- 
With Best Regards,
Andy Shevchenko



