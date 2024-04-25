Return-Path: <linux-kernel+bounces-158253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 769C38B1D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19D321F224B2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC4183CA1;
	Thu, 25 Apr 2024 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fi7Yl2zD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260C540849
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036538; cv=none; b=pYDn/1BMMNIV1VICS8v9BGAdyKD04DH1b6Kp4y7LbFFV1brD1lQ9QvICaou2IjT/LaBga2NB9e7P+NQxI0BNJiF7cpybjShyqk/pLvH8XtT4hvdffwxpSvd30JWfYx5iurCx/7YYcOToEn1xZ5VSqYt/NmX7UuEDkgfx1RY5PIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036538; c=relaxed/simple;
	bh=7I2F8yY16MhzKfcFcggrHF6aynsqbAHUvh7eIBlE41o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQEZfB/OSPMKFhikJYxgF0Iq7nVLnuO+Jx2WWCGRo30h1xWie557OdFnc+HB4zSQOuUhD89Ek/5mPcA8xEmpfQ05FM0HjVmbQPyQbpVMP+hBcz3aAtMgA8BWmQZ4wMjvIlTQOhcZ8NFdPOXAI6PWWDE07GCJw3vxNm6kNnmaP60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fi7Yl2zD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714036537; x=1745572537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7I2F8yY16MhzKfcFcggrHF6aynsqbAHUvh7eIBlE41o=;
  b=fi7Yl2zDCErq0TV5BRev4l8D74rE69ZkUHPCs8lNOzmKHtuF38dyZoi5
   1+0dMPMZ7ZQZgj4Dir82WuO++jN90EOkMC2EAcrSach9ertPKqBt6/3hH
   iE1gWelAZjGB6HfZoQiX49gEr+db4LMTNBUAdWqmBvF+AcC2n8LfD/gQ+
   8LQ2d9Uruk2dQIb9b1Xdo/B7NPzfWVlq1jjnhFj5U4xkNJpTodcAlMj3n
   lYFoxcH0EHYvraBNj6bZe2VzaBdtWBgvf4NFuoTBCvVljdF5OZ8S3aB3N
   lBuJfbGTul85seNJuaqps0FRbnWVyri9Bbvb1FJRDLD4aA7XcrnVlxYWS
   Q==;
X-CSE-ConnectionGUID: GDluEK5CTemaYqTwc36sWQ==
X-CSE-MsgGUID: Kx+HKZHbTaGsSgsjJr/okg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9556966"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="9556966"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 02:15:36 -0700
X-CSE-ConnectionGUID: TBBtHCntTm6m8fXAxqh4aA==
X-CSE-MsgGUID: o7sJpbVgQtu/FRi/UGeqSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="24999908"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 02:15:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzvCW-00000000wJK-2Jz8;
	Thu, 25 Apr 2024 12:15:32 +0300
Date: Thu, 25 Apr 2024 12:15:32 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm: page_alloc: Avoid defining unused function
Message-ID: <ZiofNBBRAKTUsh9Q@smile.fi.intel.com>
References: <20240423161506.2637177-1-andriy.shevchenko@linux.intel.com>
 <68489f85-5579-5cff-eed1-55ae585916f3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68489f85-5579-5cff-eed1-55ae585916f3@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 25, 2024 at 02:25:24PM +0800, Miaohe Lin wrote:
> On 2024/4/24 0:14, Andy Shevchenko wrote:
> > In some configurations I got
> > mm/page_alloc.c:656:20: warning: unused function 'add_to_free_list' [-Wunused-function]
> > Becuase the only user is guarged with a certain ifdeffery,
> 
> guarged?

A typo, thanks!

> ifdeffery?

Yes, this is established term.

> > do the same for add_to_free_list().
> 
> A Fixes tag might be needed.

First of all, it's not really critical issue to fix. Also see below.

> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Anyway, this patch looks good to me. Thanks.
> 
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thank you, I believe it will be squashed to the original one as Andrew already
accepted it. But at the same time his workflow allows to update the commit
message in case it's going to be a separate change.

-- 
With Best Regards,
Andy Shevchenko



