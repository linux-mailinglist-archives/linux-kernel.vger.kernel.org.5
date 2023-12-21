Return-Path: <linux-kernel+bounces-8924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7EE81BE37
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9951D28A698
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76CD64A8F;
	Thu, 21 Dec 2023 18:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mjyyaceR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BED634EC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703183329; x=1734719329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JXfuWw8u7Vb8J6bNcnxfoxxroq6hb1JBBvfO4u3HF7s=;
  b=mjyyaceRUBFHEnfryzntyMNtLnLLlfNaqadh/yH7h7WWuh8Wqm/BEQKh
   xDG0EW1eFzqRMl/S4cHBoKZkkbCDKimweN/EGN2GKkb18T7C9vy6WDAS3
   syyKTSazl082k2pkSBnzw5yzkmOqeb0b8QbGiY1r00cxU14gr+wwkodf6
   zaQhWAeLe4+sOokZOhvwfYyfrK3tBcLtJ1pVXeoFspBNtucqnoPxWFoOq
   9058NxV44rM4ZOC1UZtKJ2EwesE7U9FxsBMUsND+K2iJSJ5t2fj1ZlO/m
   JkEVsiSte8FAMQX4tXFwwfB7ivSI1GfzFGP1oivxBPa0OrjJVcuT+4Lw1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="462460118"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="462460118"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 10:28:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="920405366"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="920405366"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 10:28:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rGNmm-00000007vLk-1znV;
	Thu, 21 Dec 2023 20:28:44 +0200
Date: Thu, 21 Dec 2023 20:28:44 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] pvpanic: Don't use "proxy" headers
Message-ID: <ZYSD3C6fKvWUulXC@smile.fi.intel.com>
References: <20231221144447.2762077-1-andriy.shevchenko@linux.intel.com>
 <c37fecee-f5b2-497f-a48d-2a2faf6697d9@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c37fecee-f5b2-497f-a48d-2a2faf6697d9@t-8ch.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 21, 2023 at 06:48:49PM +0100, Thomas Weiﬂschuh  wrote:
> Dec 21, 2023 15:44:55 Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> 
> > Update header inclusions to follow IWYU (Include What You Use)
> > principle.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Thank you!

> Note:
> This also drops the unused include of the UAPI header
> which could be mentioned in the changelog.

Isn't it implied?

-- 
With Best Regards,
Andy Shevchenko



