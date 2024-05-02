Return-Path: <linux-kernel+bounces-166821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E68E8B9FFC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0911F2203D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFF317167B;
	Thu,  2 May 2024 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KlslehFS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58641553BB;
	Thu,  2 May 2024 18:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714673008; cv=none; b=ubR9iZ35JWAONXngttL3s1B2DUpwLIk8/j7drIX+B1hlejCc2frkrcBXvxlLPOwLzh0H3QkA+SYQsmQhVKe8+DIjLWSje5XobW+5j5otNjcLxatN3NpdAJ/mnX/cmU77OjehpCSqoLcArALOHsaw1ilCKFyl942C41cYONAmnrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714673008; c=relaxed/simple;
	bh=rwPBD7zU8deuKFTYLY8oJFYpCoQjHFdZlDqUf8AaoQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mW8yjCyerwesb+d/tBW+579l5O1tmpQHD31deQGrehhsxIiLkujLo0x0rzMOpb4cysNeMVlbiGRAiR344tp8FdFLcO4PVViRmnprhU6SRTuXiUUtczq9E0UzVrPvdAZ55dI4v5pgfDZuYfBhJ5ebJFc16Sem7rsSnE0a7qDIuQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KlslehFS; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714673007; x=1746209007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rwPBD7zU8deuKFTYLY8oJFYpCoQjHFdZlDqUf8AaoQo=;
  b=KlslehFSCTz/4EtW9P4+QazvDlhkDUisBwyTzdu/WbJOWuKNrgV6L7g1
   yo0tth61/DAJOCgMWq80ErYsfWM4Q7xnkXj08zsAX71FtkHbZmtqKRvJe
   t7z6406Wzuvh+7nb5INWKY4ziMjfT6y+cgqSSuVdyWuk7B4fWzntnRZZH
   b/GKNwp8ZWD3k+e5IsqsbWxK2KxKEmow7JOoeDYCrKj+cIE+gLp286Kuq
   /5kODGpIf+Bn/9GvR9jldIfYco+cp9OiXICRxpT7xwmctweWFmMzuiQ4c
   JekBI/tDR32xU3SeDpsRpFoj6kC0qf07wlX7wqeKFW4Fl5lYiPD5fUcOP
   g==;
X-CSE-ConnectionGUID: IXoX1pU9RWaTsc/zgJpQZw==
X-CSE-MsgGUID: +dUIydDCTamjFrMskg5hpg==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="27989864"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27989864"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 11:03:14 -0700
X-CSE-ConnectionGUID: 2JLC8rOgQvOT5wDViZBkEA==
X-CSE-MsgGUID: qD13URDuQHuDe0bO5++Cdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31689668"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 11:03:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2alx-00000003PPW-2VPI;
	Thu, 02 May 2024 21:03:09 +0300
Date: Thu, 2 May 2024 21:03:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device property: introduce
 fwnode_for_each_child_node_scoped()
Message-ID: <ZjPVXW9tr0RLp7Jn@smile.fi.intel.com>
References: <20240502-fwnode_for_each_child_node_scoped-v1-1-868a2b168fa8@wolfvision.net>
 <ZjOybob3wJjisuBL@smile.fi.intel.com>
 <6b5571e0-1463-4dd9-9bd8-459d456a6932@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b5571e0-1463-4dd9-9bd8-459d456a6932@wolfvision.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 02, 2024 at 07:58:26PM +0200, Javier Carrasco wrote:
> On 5/2/24 17:34, Andy Shevchenko wrote:
> > On Thu, May 02, 2024 at 12:55:40PM +0200, Javier Carrasco wrote:

..

> >> This macro has been tested with a patch series that has not been
> >> applied yet and is under discussion in input [1], which makes use of the
> >> non-scoped version of the loop.
> > 
> > So, why should we apply a dead code?
> 
> I will add this patch to the series I mentioned, so there is a first use
> case.

Sounds like a good plan.

> Even if the _available variant is preferred, the other one is more
> widely used, and having a scoped version will allow for safer code.

-- 
With Best Regards,
Andy Shevchenko



