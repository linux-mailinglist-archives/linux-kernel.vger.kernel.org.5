Return-Path: <linux-kernel+bounces-7088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 344B481A17D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5CB1F23159
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E163D96F;
	Wed, 20 Dec 2023 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fLnfpUwy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97DB3F8D0;
	Wed, 20 Dec 2023 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703083916; x=1734619916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4wHmGZHe3svEJVhmHtSCWZ7shvpHcD4OJm9FlO0yOSU=;
  b=fLnfpUwy5cSiaySQyvWr2tVQOJNqMwalghLifuCS3Iu2lHGh4kYO1Njk
   pwaj5mSmn8DNsOoV2jFZseCafQp4WkrteUc7RgiQE646BaEY+bYKIkSPN
   xI5VGR2wzAYrR+KVnm/fI4n6Ixbw4aR25/SZqSIm9guBpxk1AgnXx8QBK
   wYPmzbhO8x14mxSFbhgxm1ZD9M2do3i1qRZEZvKgmz+g4swSZv70KG1on
   nMQoolu2yd+1k8yULi0BRVkKxORgdzHpBLokVxLeJzpUXunXzkNB3npqp
   zNTco3nHdpZQ/oYD9NaZUtJPFAh7ROoAzA0ZzHmacQDRRnq9BY6mclX55
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="9204582"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="9204582"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 06:51:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="726098329"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="726098329"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 06:51:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rFxvL-00000007YwM-0MuC;
	Wed, 20 Dec 2023 16:51:51 +0200
Date: Wed, 20 Dec 2023 16:51:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2] gpio: sysfs: drop tabs from local variable
 declarations
Message-ID: <ZYL_hrjwUP-O8GTI@smile.fi.intel.com>
References: <20231220080942.8381-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220080942.8381-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 20, 2023 at 09:09:42AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Older code has an annoying habit of putting tabs between the type and the
> name of the variable. This doesn't really add to readability and newer
> code doesn't do it so make the entire file consistent.

So, I would go with reversed xmas tree ordering in the lines you changed.
It will decrease the churn for both: the future changes and backporting
efforts.

I explained that in my previous reply to v1 thread.

-- 
With Best Regards,
Andy Shevchenko



