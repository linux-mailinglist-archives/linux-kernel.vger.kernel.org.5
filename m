Return-Path: <linux-kernel+bounces-166650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9AF8B9D93
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19DAA1C2099B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282ED15B54A;
	Thu,  2 May 2024 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VBVRUb4L"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71F7159583;
	Thu,  2 May 2024 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714664054; cv=none; b=QMKgOpkz2DFozqxCdBj11cd9inMpHBV84jq+eG3fPLsJh2o3fzXYNlktNDhMLFoQ+hwWyX7Nhrm1jgzGi45jzXW2Vc9y3osCllm321/bkaGHKVCWXGifwui76c/+xYcUyHpWi1+Jdxf+w6OitCfV1rGj6hunxo86NV2LQuIpXXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714664054; c=relaxed/simple;
	bh=i+b3Gt10kxEMdODqZYe9qCRHgRMb4d1gFMn0AhNw93o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KB8EFaTwKwb7hzSPzeR6bOgRG0qNdJKJupeR96hbXbqTY6r1v6FJxMwgohbYsbflyjyu0gfezsvzAtNmEDXHk7dAa6Xp6Y513msyi0RwY4yAa+UHTEQTZfIfhKXWf5zY7N1weTpRma15LuPUjdoMXuDFK/tarPsbH/8N11UxT+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VBVRUb4L; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714664053; x=1746200053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i+b3Gt10kxEMdODqZYe9qCRHgRMb4d1gFMn0AhNw93o=;
  b=VBVRUb4LNZ9vLvGlnAfx6ymRrCqoQcI8vl0oYqUoVwZxJhfmjzhQNeq6
   JXVgODZdGe1tTyinC6vxKj2FMpg6sRcNGZ3/z+qYLsg7yd5dS7RHUKmwa
   IqkVX2sS1UpoTyAemAkS2BHIEsfBD6CXxWnID+roW7GanyLXYS7LpQ8p6
   uRhxN6DSHLXEOIvrf31FvvAnd+iEsinxNLFuG+jWUocel9NBHMWKELnAU
   VCQZr9XbkVO3DPD3KDC1jQ2nOziXB0GxatBi29AjFR5GHnAhljMIbbeLA
   JYnDDEtMC00JL8e5XeKo0kEznx/vaAgh7XWvFUe/S/716/2iL252gRerb
   w==;
X-CSE-ConnectionGUID: nqJ+E6gCRPCvGoOsKpm9kg==
X-CSE-MsgGUID: nmM3j2wuQh6HOUUdsbO6aA==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="35824304"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="35824304"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 08:34:12 -0700
X-CSE-ConnectionGUID: 3ZasYOLJSyyn9x6P5Gn+JA==
X-CSE-MsgGUID: GCMedEbbTBey4+Yd55h0eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27556591"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 08:34:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2YRi-00000003McI-3T96;
	Thu, 02 May 2024 18:34:06 +0300
Date: Thu, 2 May 2024 18:34:06 +0300
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
Message-ID: <ZjOybob3wJjisuBL@smile.fi.intel.com>
References: <20240502-fwnode_for_each_child_node_scoped-v1-1-868a2b168fa8@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502-fwnode_for_each_child_node_scoped-v1-1-868a2b168fa8@wolfvision.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 02, 2024 at 12:55:40PM +0200, Javier Carrasco wrote:
> Add a scoped version of fwnode_for_each_child_node() following
> the approach recently taken for other loops that handle child nodes like
> for_each_child_of_node_scoped() or device_for_each_child_node_scoped(),
> which are based on the __free() auto cleanup handler to remove the need
> for fwnode_handle_put() on early loop exits.

Why not _available variant? I believe most of the code should use that.

> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
> This macro has been tested with a patch series that has not been
> applied yet and is under discussion in input [1], which makes use of the
> non-scoped version of the loop.

So, why should we apply a dead code?

> Based on linux-next (next-20240502).

Use --base instead of this. Ah, and you do, so no need to have this comment.

> Link: https://lore.kernel.org/linux-input/20240422-feature-ts_virtobj_patch-v9-0-acf118d12a8a@wolfvision.net/ [1]

-- 
With Best Regards,
Andy Shevchenko



