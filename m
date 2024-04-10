Return-Path: <linux-kernel+bounces-138611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B29089F82D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA250283D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA20015DBC4;
	Wed, 10 Apr 2024 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gYq84n8/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824FC15E5B1;
	Wed, 10 Apr 2024 13:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756133; cv=none; b=X9oRQ2R/m0Uffe4NhZxTcp0AzcdTg2bdETNmIZoKKDU9OBLT4ZLqO6iHIsN9dWmWMozcx44iZWRq4I9l2PfID9K49dJYOeWgM/GcHf5jS/LraPBKSR1mgn5j/V80dzlKwEa6NntWK0fpMFgt7YfcW0Wf6UW2Di4QE7nE4aEUjVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756133; c=relaxed/simple;
	bh=OfCHBzNqhxOboXDegyegyyxVY/r98YaMcMQUhRg/Yuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGWdWXje6TThnmG98CO3mjHpK/ysv40LlzGgsdFXjhDVTJRLR3IFowqN7ABf0MKlcS3kZPBYLTkOzVqo13Nw3LbGpk4P9NK5/uaz9kxYeme/3vnqxbPOTx/pdtKH0ygTd7EYuUBitCLPbJqR52EUV3hcMMRRUT4/Fg3oVjzMyOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gYq84n8/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712756131; x=1744292131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OfCHBzNqhxOboXDegyegyyxVY/r98YaMcMQUhRg/Yuc=;
  b=gYq84n8/cUU3oKBx/WsvsYI4gGmYBbFUpuKYLv+hKrlkDewGvuNecFZ0
   WA7yM28gAh1qqxzrEuMJfyxHyNevsuseaZ86qu0jK1yq8NB3w4wpNXF4M
   UxLSAh2FDXGieHotDWMb3gfxVCbVV8APIJuC0yoIvCzXtXQ/TBbbqh9Y1
   JdtPtj/uwvmo8GR8qupSR7Vpw10KdVuIji4qy+qL17Vuz/BXaBYanB7uV
   NzI0Yu6eKoZDbWcS8ZtbYB8mVKaKR5cc8Ug7EGueNYuLloZ86ozgO0tgl
   0/y/DVzkOoT/uNCI7pPx42oDMbAevpumkCWWIrF3pguSHU2Q7//jvg6BO
   g==;
X-CSE-ConnectionGUID: wTEJw19WRdmWg0sg4U50JA==
X-CSE-MsgGUID: G4H7rwhwS5KblTkDO+xw1A==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7990863"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7990863"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 06:35:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915433250"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="915433250"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 06:35:28 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ruY6n-000000034xQ-2BIQ;
	Wed, 10 Apr 2024 16:35:25 +0300
Date: Wed, 10 Apr 2024 16:35:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 2/2] media: atomisp: Replace open-coded
 i2c_find_device_by_fwnode()
Message-ID: <ZhaVnYtFoTaFOKD-@smile.fi.intel.com>
References: <20240326202813.1425431-1-andriy.shevchenko@linux.intel.com>
 <20240326202813.1425431-3-andriy.shevchenko@linux.intel.com>
 <c9741df0-6c12-4ff5-90b4-5a13f0bd9b51@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9741df0-6c12-4ff5-90b4-5a13f0bd9b51@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 10, 2024 at 12:35:29PM +0200, Hans de Goede wrote:
> On 3/26/24 9:27 PM, Andy Shevchenko wrote:

..

> I'm going to merge this variant into my media-atomisp branch
> instead of the orignal.

Thanks!

This explains why changelog made the commit message.
Was it done deliberately?

-- 
With Best Regards,
Andy Shevchenko



