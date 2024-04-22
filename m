Return-Path: <linux-kernel+bounces-153279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0F58ACBD8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381542832E4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECF81465A7;
	Mon, 22 Apr 2024 11:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TMW3g3nR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D233145FEC;
	Mon, 22 Apr 2024 11:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784578; cv=none; b=Pfw3E24zo8VADK1n8PVL15LwC1KynYnF7GGRUnM3oCeW0MoBf+2YIieOsX7l6GUE9MZY3JJmXcUAejRgLZn5hi3174bf97niBhlZUeXdkWonhVmO8LT4wHnp6F2eDxsNvWUrCqEFZ4tDHQUcSE+eIXCY2bdxOhm6ktTB3Fqi6No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784578; c=relaxed/simple;
	bh=wDbHwtY+TxaptW1s9tsA+CXbI81ldIEI6DPUe3+mBvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7yvcPPXKLiVHDfn8aLO3DH6KgcZIKJRNVJ9JKyGCys5k5ktB9+4wb3QxNW8ZgHVxFl/LNLURTiMSO6A5ceiw3rRTnfU8BepFle9slgS1u849CmHAKTFi83bs66QQNnvDIbYGZ54JAomQoxyghiCrqtCcPjXSO6FQiIc8lZa6Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TMW3g3nR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713784577; x=1745320577;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wDbHwtY+TxaptW1s9tsA+CXbI81ldIEI6DPUe3+mBvY=;
  b=TMW3g3nRdysYNgu1cdwMmTecpg3YPKA0LVq+Ka7aF+IOSS7cK22TCWtV
   D2NJpIuCoJ0PkTpMOLLVOzxs/YE1CZqk1sy3me1IO6wHC4OihLbcm/mc+
   cwMQYLpDYJeXziWDjZldcY2xISpRvNb5Hv0nQH5rXCAmZQ+EdMkCjbNZs
   y0YIWTYCNh8FlsmPET8zdHG9bpyV0NF2t+ERjd5wv4kIWlmGRx3vU5a+e
   EEiD4uqCDdBrqv2WND4HTakAiVF+aZ6nVjCkIZYObc1vlmYeJ/bimXwiW
   mV7KtUGfOectI7Okb7zWWlPutWDQHt4YQYWxdI+hb0+NttSYS1z9dLUVP
   Q==;
X-CSE-ConnectionGUID: S8FvSFW0TxaJM3qEOVZdtA==
X-CSE-MsgGUID: jyYtX122Q5ij6TJUOVfwzg==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="31807932"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="31807932"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 04:16:17 -0700
X-CSE-ConnectionGUID: QrqM3OGDRkuy6EK36oRdNA==
X-CSE-MsgGUID: ABjTpl61TnSfyt0J40sxCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="23858314"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 04:16:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ryreZ-00000001d8Q-2mcE;
	Mon, 22 Apr 2024 14:16:07 +0300
Date: Mon, 22 Apr 2024 14:16:07 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Konstantin P." <ria.freelander@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Konstantin Pugin <rilian.la.te@ya.ru>, krzk@kernel.org,
	conor@kernel.org, lkp@intel.com, vz@mleia.com, robh@kernel.org,
	jcmvbkbc@gmail.com, nicolas.ferre@microchip.com,
	manikanta.guntupalli@amd.com, corbet@lwn.net, ychuang3@nuvoton.com,
	u.kleine-koenig@pengutronix.de, Maarten.Brock@sttls.nl,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 3/3] serial: sc16is7xx: add support for EXAR XR20M1172
 UART
Message-ID: <ZiZG90gXb66jCaw_@smile.fi.intel.com>
References: <20240420182223.1153195-1-rilian.la.te@ya.ru>
 <20240420182223.1153195-4-rilian.la.te@ya.ru>
 <7cf31245-b2a1-419c-add6-a6a50a3f3cf1@kernel.org>
 <CAF1WSuw9WKCNbsnyDv6F0QNJbYT78wMn=s54n7XXfM94z51oJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF1WSuw9WKCNbsnyDv6F0QNJbYT78wMn=s54n7XXfM94z51oJg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 22, 2024 at 11:35:32AM +0300, Konstantin P. wrote:
> I do not think this is a requirement for a new version. I need to
> wait. Some folks want to test my patches with their hardware)))

You should not top-post!

..

Yes, it would be good them to provide a formal Tested-by tag, then you may send
a v6 with the tags and Jiri's comments being addressed. Btw, I prefer to have
them addressed now to eliminate unneeded churn in the future.

> On Mon, Apr 22, 2024 at 9:30 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> > On 20. 04. 24, 20:22, Konstantin Pugin wrote:

> > I am not sure the above warrants for a new version. Just in case you are
> > sending one.

-- 
With Best Regards,
Andy Shevchenko



