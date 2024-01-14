Return-Path: <linux-kernel+bounces-25516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523B982D190
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 18:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB161B21291
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 17:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A1A5392;
	Sun, 14 Jan 2024 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YEKWtib+"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE6D23A6;
	Sun, 14 Jan 2024 17:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705252100; x=1736788100;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UzgFjM2CD1QtXNQP46Z3RkFdGjU5fivGIZd8OKaOVwY=;
  b=YEKWtib+YqxYs6DzJO6TN8gzeyExwgQufbV6MRG5kGNBQQpzt2KjJuaZ
   VEw49nocHXsxESG4648px4qLFoj+G3oJOgpVaxCCaNe9JXDcROfU9nMqS
   6OrdZq97CSnLlLa7jb32Kki9CoF3Q/CZbSLM+u+YlsCWI0TmuJpeuQSqS
   C42wo33JBV4jysQZHekLCh+BFk4YYx0AOZTTDs/uZcPg5Qx04gWa5OvCG
   2nGRB49ZDszXrNvDef8QfCBGrfrIJN2ltHGIsDCpc4lW9thGGt+u0qUEC
   8l/FwVst4M7SgF0fIZL5BBNltX39Z+3rHfZru8ZOSxlzcC32bff40J8oO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="396621295"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="396621295"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 09:08:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="786869958"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="786869958"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 09:08:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rP3y1-0000000DyAP-1bfe;
	Sun, 14 Jan 2024 19:08:13 +0200
Date: Sun, 14 Jan 2024 19:08:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] firmware: coreboot: Generate aliases for coreboot
 modules
Message-ID: <ZaQU_QqGXwkSgU_Y@smile.fi.intel.com>
References: <20240111151226.842603-1-nfraprado@collabora.com>
 <20240111151226.842603-3-nfraprado@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240111151226.842603-3-nfraprado@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 11, 2024 at 12:11:47PM -0300, Nícolas F. R. A. Prado wrote:
> Generate aliases for coreboot modules to allow automatic module probing.

..

> +/**
> + * struct coreboot_device_id - Identifies a coreboot table entry
> + * @tag: tag ID
> + */
> +struct coreboot_device_id {
> +	__u32 tag;
> +};

Don't you want to have a driver data or so associated with this?

-- 
With Best Regards,
Andy Shevchenko



