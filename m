Return-Path: <linux-kernel+bounces-166822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 184A38B9FFF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40E08B225D6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130FF17167B;
	Thu,  2 May 2024 18:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QqYTELYs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59EA1553BB;
	Thu,  2 May 2024 18:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714673083; cv=none; b=mmk6wHtEIZ67cmTs4L8QcicmHbLYxjSWnr586eluPkiRtSWqoEgTx4ogGmmIUjSxoXHmh13s4vPu+P+GkXgaEl52cw2yuQckCaVSwyzBU66viNd7xTB6gWrhBgVmdwwDJvMooaRzZjVIm43nUJWiDxaDYcaZAwjJIGBU2QvO5vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714673083; c=relaxed/simple;
	bh=5/V5S7wrzoPy8oKMzOoDT2O7s5J/iVanuW6/BCcg29I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZGvsVxo1Y9L0vgXQLnODDVy5xHjnSYhnsNFJLegw1Gu16txCdckmVRN+axsd3tIxI6wfL/k6N4iafrdhhfiHctgSiG+TN0XShk3S5KsViqzOkNl60Q7PvynGxcd41bfhcszNlLlXFVpny3SDvuCqFTzq5xWJ4Od6DWcnrJiZzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QqYTELYs; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714673082; x=1746209082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5/V5S7wrzoPy8oKMzOoDT2O7s5J/iVanuW6/BCcg29I=;
  b=QqYTELYsoJ1SNO5HP7iKukJ9+HpQfmO3P+DT5N3ybFkLqCZd1ToHM9Zy
   vfqroK8TXGkIampZz0CEcK2dQBboBmbFhXoK9sKWWuxRcCVbphtmSiFKg
   6R/Cf4CWLWkFaYhqFdrA/IvIZoUrDYgAzQJglHBAmoL1VJx3z47kBZoMH
   B7qZaGTyiKWUFJ8Vvo3oYLylq6UN0pUkJDCBhGZsYRlYeclSdYm++NKqe
   IPTJHZHqpCpBLQZc581NIkU9wMr4rfpv759BSA2+VRDUcTqOa0Tje2pdE
   xstIbN0i3nNElJE5C2HTYh2u993bfFB6Z6qauUcU6Vck0VE+csz64tZci
   Q==;
X-CSE-ConnectionGUID: rcMnLXLATQqqpX0W3MGiaw==
X-CSE-MsgGUID: mvoHL0JlTcmJOIBgpTlntQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10392507"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10392507"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 11:04:41 -0700
X-CSE-ConnectionGUID: ZE+KgaoXRZKNW+PlDxac9w==
X-CSE-MsgGUID: f+h2FOWAShiH0+3Od4MrAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27179982"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 11:04:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2anL-00000003PQx-32bI;
	Thu, 02 May 2024 21:04:35 +0300
Date: Thu, 2 May 2024 21:04:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Javier Carrasco <javier.carrasco@wolfvision.net>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device property: introduce
 fwnode_for_each_child_node_scoped()
Message-ID: <ZjPVs5NJzlMzHYn0@smile.fi.intel.com>
References: <20240502-fwnode_for_each_child_node_scoped-v1-1-868a2b168fa8@wolfvision.net>
 <ZjOybob3wJjisuBL@smile.fi.intel.com>
 <6b5571e0-1463-4dd9-9bd8-459d456a6932@wolfvision.net>
 <ZjPVXW9tr0RLp7Jn@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjPVXW9tr0RLp7Jn@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 02, 2024 at 09:03:09PM +0300, Andy Shevchenko wrote:
> On Thu, May 02, 2024 at 07:58:26PM +0200, Javier Carrasco wrote:
> > On 5/2/24 17:34, Andy Shevchenko wrote:
> > > On Thu, May 02, 2024 at 12:55:40PM +0200, Javier Carrasco wrote:

..

> > >> This macro has been tested with a patch series that has not been
> > >> applied yet and is under discussion in input [1], which makes use of the
> > >> non-scoped version of the loop.
> > > 
> > > So, why should we apply a dead code?
> > 
> > I will add this patch to the series I mentioned, so there is a first use
> > case.
> 
> Sounds like a good plan.

Ah, note that IIO has already some patches against device property APIs. Maybe
it's already done by Jonathan.
Cc'ed to him.

> > Even if the _available variant is preferred, the other one is more
> > widely used, and having a scoped version will allow for safer code.

-- 
With Best Regards,
Andy Shevchenko



