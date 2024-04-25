Return-Path: <linux-kernel+bounces-159062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0B08B28C8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB59F1F21910
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E371514C9;
	Thu, 25 Apr 2024 19:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lg3JWVVJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C791939FCF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714072208; cv=none; b=lPn6MxMXCBwlrrXg8D/fk8TGmDkYbDNik4nhcbRUa+PEjlP5IGyDfOV81gZzZ5BolmUtTv+f7RFaklL3NJKRWHP315OZ/MltbWSj8ObpGagGm36K5fo64abJ0PjmzG3Q5l5NEifm6WOE6+PRh3rrrdGRpEkIPhcZRI/3OkSLCFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714072208; c=relaxed/simple;
	bh=+b3QRlo9wSt9E1+K4WqjEZx7tqujB9TDe2BuF4AqYBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zd9TqEQDIp9R5PYvktBn+28DfrwVbQOma5lWrhpQMqUOB7u82d1t1VGn++cbyCcN+yRVeKLzkzj+jKrJbv516hyR+wXGqmNnDHQMwOwUeiY/XmA3si0XX7xAzPcgDZpwepmUnWAd1QNzX85ypCrB2jlkx0AoBrSHvUWHV8VAOm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lg3JWVVJ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714072207; x=1745608207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+b3QRlo9wSt9E1+K4WqjEZx7tqujB9TDe2BuF4AqYBM=;
  b=Lg3JWVVJMz+Bec55FQ6VnBMgX2hn3VbV/eUiXZKyhpBfORKBFXJo73/7
   xKvQc6iZrPgy0k3Q+aID5emyJeVltHg95iwnPFzkIlwLe0F27KiT+wreG
   O2QegZ58QhCIinrGtcxK2YQqvAH/q254YKaft28XB4s0R5Eskl+jI4FF0
   JRNOSZa2ci+YUPlFzj3mECXjYomMoUYgf0Ig8EdDhrLUAB+hsBvf5GNj7
   MR86ymWEu/NE3ffLezF/FpEvIoyj6Nd/XNvRQIeIbRrfpaLtRcq1YGtno
   VpjlnS7kVlUSGSAsrKJ2gye43IPWjdfZp/KhKtnCsUCVzrj0yIuHLvY/y
   Q==;
X-CSE-ConnectionGUID: hKn27TJXQaWNifCAEOqptA==
X-CSE-MsgGUID: /XYNg8tYQZ6pEyudtU84hQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="27241266"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="27241266"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 12:10:06 -0700
X-CSE-ConnectionGUID: Vn+cAKfeQDypsFrPZ/MhyA==
X-CSE-MsgGUID: V68WkJXQRu6OsGCjniEUvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="25059548"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 12:10:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s04To-000000016qx-1Wa5;
	Thu, 25 Apr 2024 22:10:00 +0300
Date: Thu, 25 Apr 2024 22:10:00 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [v1,1/3] drm/panel: ili9341: Correct use of device property APIs
Message-ID: <ZiqqiAztCaiAgI8e@smile.fi.intel.com>
References: <20240425142706.2440113-2-andriy.shevchenko@linux.intel.com>
 <c2d41916-0b6c-43b5-98eb-514eb0511f84@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2d41916-0b6c-43b5-98eb-514eb0511f84@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 26, 2024 at 02:08:16AM +0800, Sui Jingfeng wrote:
> On 2024/4/25 22:26, Andy Shevchenko wrote:
> > It seems driver missed the point of proper use of device property APIs.
> > Correct this by updating headers and calls respectively.
> 
> You are using the 'seems' here exactly saying that you are not 100% sure.
> 
> Please allow me to tell you the truth: This patch again has ZERO effect.
> It fix nothing. And this patch is has the risks to be wrong.

Huh?! Really, stop commenting the stuff you do not understand.

> Simple because the "ili9341_probe() ---> ili9341_dbi_prob()" code path
> is DT dependent.
> 
> First of all, the devm_of_find_backlight() is called in ili9341_dbi_probe()
> under *non-DT* environment, devm_of_find_backlight() is just a just a
> no-op and will return NULL. NULL is not an error code, so ili9341_dbi_probe()
> won't rage quit. But the several side effect is that the backlight will
> NOT works at all.

Is it a problem?

> It is actually considered as fatal bug for *panels* if the backlight of
> it is not light up, at least the brightness of *won't* be able to adjust.
> What's worse, if there is no sane platform setup code at the firmware
> or boot loader stage to set a proper initial state. The screen is complete
> dark. Even though the itself panel is refreshing framebuffers, it can not
> be seen by human's eye. Simple because of no backlight.

Can you imagine that I may have different hardware that considered
this is non-fatal error?

> Second, the ili9341_dbi_probe() requires additional device properties to
> be able to works very well on the rotation screen case. See the calling
> of "device_property_read_u32(dev, "rotation", &rotation)" in
> ili9341_dbi_probe() function.

Yes, exactly, and how does it object the purpose of this patch?

> Combine with those two factors, it is actually can conclude that the
> panel-ilitek-ili9394 driver has the *implicit* dependency on 'OF'.
> Removing the 'OF' dependency from its Kconfig just trigger the
> leakage of such risks.

What?!

> My software node related patches can help to reduce part of the potential
> risks, but it still need some extra work. And it is not landed yet.

Your patch has nothing to do with this series.

-- 
With Best Regards,
Andy Shevchenko



