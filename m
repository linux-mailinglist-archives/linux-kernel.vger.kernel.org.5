Return-Path: <linux-kernel+bounces-140503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B87B78A1583
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41150B24BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7340C14D432;
	Thu, 11 Apr 2024 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S9Q6Z+W7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A651C14AD22;
	Thu, 11 Apr 2024 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842093; cv=none; b=fcbyTLkzoOx/islzs/rjdnu7iycY3RuXom1rrt9zKB06JOROXbfaSsgLhWdps9nw1W+GOQQz2/fQHurV/sWpxIPKZQkg5YnMKNKiflOoRr9pKvs24M2huQ7mDyMP+FFik7n5RMxs2mwDLEw9rVjTFnZ1nMYJACsULVey6Kgfxdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842093; c=relaxed/simple;
	bh=rN3vnamxh1y4e19vWKAPhoeeESNA3w+VvGOlWEyFGns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNQHsr0QVob70HnY5cNwuMe/4+sw4VqBQcWVXkU0AsfbGBwjLljx6FdUUY3JtRWHqLzw0wGr8k0qJZ0aO78jh0sowe1ZAOouyFMSfZei6jSsVjWCClSHFLervuZlMzBEok1qlwe/oe8/cqg6stlNeVy9nI35/cxyteFvz2zKPSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S9Q6Z+W7; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712842091; x=1744378091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rN3vnamxh1y4e19vWKAPhoeeESNA3w+VvGOlWEyFGns=;
  b=S9Q6Z+W7o1vnYlqo9nMo3eIuBz0Z7vrbM63vn+qexxoeGePkjGXCq5GX
   UOM3dXq+SsyyhByR5FsVQwOZyyv8MDrfdvM5rRw5io+SVn9sMpjIs2I8N
   /hsOwMykQ2O5awLRk7NgjXhxg+6koue/ISevnOgryvT8mxq8au0XiLkUJ
   FqdWpXjZcEOkvZaDxVO5Pstg1z1PHiBg2CYFO+dW0k+QjN34Nv8ZDsDxQ
   Rku3hXL9rdKFf3IBKyfVfvLlC50K8FPhlw+3Zta1PUuPr6ySuGVrYZAYK
   6qcm7WZ6c4EcOG6oPOLkIpBjr+obmojlq4wdeikFsgTWWDrVeolDMGtmE
   g==;
X-CSE-ConnectionGUID: W3wfzMj5SPOnTsD0KihHqg==
X-CSE-MsgGUID: bcY6aqeDTJaRmcCl1vat/w==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8102458"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8102458"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 06:28:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="937096973"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="937096973"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 11 Apr 2024 06:28:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id EB28532A; Thu, 11 Apr 2024 16:28:06 +0300 (EEST)
Date: Thu, 11 Apr 2024 16:28:06 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 0/2] gpiolib: acpi: A couple of error checks amendmends
Message-ID: <20240411132806.GB112498@black.fi.intel.com>
References: <20240410202243.1658129-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240410202243.1658129-1-andriy.shevchenko@linux.intel.com>

On Wed, Apr 10, 2024 at 11:21:45PM +0300, Andy Shevchenko wrote:
> One error check is moved and one is dropped.
> No functional changes intended.
> 
> Andy Shevchenko (2):
>   gpiolib: acpi: Remove never true check in acpi_get_gpiod_by_index()
>   gpiolib: acpi: Check for errors first in acpi_find_gpio()

Both,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

