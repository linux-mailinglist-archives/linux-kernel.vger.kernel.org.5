Return-Path: <linux-kernel+bounces-157136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0118B0D49
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77EF528C293
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB41515E802;
	Wed, 24 Apr 2024 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G+8Vet2i"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01F415EFA1;
	Wed, 24 Apr 2024 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970407; cv=none; b=lz+Uuqi9cWcU8UWc9ZEpso/CYmJmdj+sqOL9Wr7tX9le/j4dN2MmZaGVV9CZVA6zGNVy8KvB4jyYeNiqn3hpuoGzTFhSxmU++LCeGoay3kD2BWBdwFUdYLjo+0hxacSuHb9+9x8PDoOmImXXodIrakZZlHzkXdCMiFGNZ2jxgro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970407; c=relaxed/simple;
	bh=RqfV+hja3oQylqzeWMZG5N4j93kHJlAuYk8CLvh4giQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tszk2kG/wGbjzsguMaksGGz9Km/v/jajDe+1rpd/rjLU1xjNk8eruTGY7+8dIA1xlr9qWCdKmgQ8YsiQovKW0pjq2/1stC/NKW9Ngf/5etmfQdEkeNz5i2uq39QhOit3K/xGPkkPB9hhniz9u27/xjJoh9CW7okWFwohXD0dphg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G+8Vet2i; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713970406; x=1745506406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RqfV+hja3oQylqzeWMZG5N4j93kHJlAuYk8CLvh4giQ=;
  b=G+8Vet2ismbiLI44DRMeFLJ8jUSnUrzxvbLQXJtEiih1JT+iCupXnfJM
   61mj0dGU/uKToD2/Y0yy4GZFiU/+LNXW807/EUJCxc6WMlbm4rPIRiDgG
   GZCnNVzKaR8FkC9bQRySSbC2hVnCb8GkGXezk5ucNcvWkw2wp2VIVk0np
   BJ9t3bSuSbzJ2NcNFaDPWiNm1WZ6WnMslc0exrwJnhCyMOcu96b0QFbsW
   qWROmusPyqVz0HDd7QXTK6AE8zb0N1Na9pehVVqjIkG5R2rRtDz5Z5iL+
   RgTE7XxEQwjEwE4wOhBUSjqRKkdxD2xxdHD6QuSLajcmqpmWedF997f8C
   w==;
X-CSE-ConnectionGUID: jYbM7rmSS6yoD7WQHEOwRg==
X-CSE-MsgGUID: mvBx9tbVRfSksat+1Djc3A==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9727118"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9727118"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 07:53:26 -0700
X-CSE-ConnectionGUID: 09S+vG3jRaOAUzAmHorGng==
X-CSE-MsgGUID: VlkXdLBeS6+qX3IrssO96g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="24620041"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 07:53:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzdzt-00000000gI1-1C9q;
	Wed, 24 Apr 2024 17:53:21 +0300
Date: Wed, 24 Apr 2024 17:53:21 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v1 0/2] Documentation: process: Clarify use of Cc:
Message-ID: <Zikc4fDNDer6hSzJ@smile.fi.intel.com>
References: <20240423132024.2368662-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423132024.2368662-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

+Cc: Dmitry
(have been told by colleague of mine that you also has an opinion on this
 topic, sorry if I added you by a mistake).

On Tue, Apr 23, 2024 at 04:19:36PM +0300, Andy Shevchenko wrote:
> Add a couple of recommendations on how to utilise Cc header in
> environment friendly way.
> 
> Andy Shevchenko (2):
>   Documentation: process: Avoid unneeded Cc: tags
>   Documentation: process: Recommend to put Cc: tags after cutter '---'
>     line

-- 
With Best Regards,
Andy Shevchenko



