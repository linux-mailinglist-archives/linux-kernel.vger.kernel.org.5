Return-Path: <linux-kernel+bounces-18634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D566826047
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44CBA2834DE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C308C11;
	Sat,  6 Jan 2024 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VBeZ2aNn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8157BE6C;
	Sat,  6 Jan 2024 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704556651; x=1736092651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RYiHRSIy4ECeUqhqLoDwUgsvxBw0ZlfnTroVhUsj69c=;
  b=VBeZ2aNnUrVEpnWbXmIUb8nvf75l/hCbEIE7/a70QcY0t6MYi3cgWrbO
   BzNIpe4X5se6Umi3uJVlgY1xgK+I0JeDCQC7kY2uc8Dx2rD5VP4Kcr2sn
   fA5BpeRROCOMvNd5IbU/my/k4GHAJcArDFfB1/hVogncqRel0ZG1H+Eiy
   zYVuwyzXZFO+MdFNUoBovPGnnmEujqwR21YiamJgNpK94SUFTyUjotOw2
   W3PqBG3vy9H4af/nSqW7LaYJdsg0axC+5rruFtVTFbIjeGBNdKL4HTNJ/
   pSe3uZ0/c/LAubBkmEM7Yer/afEcKkgzDm7JQis0lsjgtxIR599kssl+b
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="401445610"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="401445610"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 07:57:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="781015441"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="781015441"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 07:57:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rM8cv-0000000BwQY-2Yxb;
	Sat, 06 Jan 2024 17:30:21 +0200
Date: Sat, 6 Jan 2024 17:30:21 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 10/10] iio: pressure: mprls0025pa add SPI driver
Message-ID: <ZZlyDT0J4n1_YXh4@smile.fi.intel.com>
References: <20231229092445.30180-1-petre.rodan@subdimension.ro>
 <20231229092445.30180-11-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229092445.30180-11-petre.rodan@subdimension.ro>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 29, 2023 at 11:24:38AM +0200, Petre Rodan wrote:
> Add SPI component of the driver.

> Tested with mprls0015pa0000sa in spi mode on BeagleBone Black on
> slightly patched 6.7.0-rc6 mainline.

> Tested with mprls0025pa in i2c mode on BeagleBone Black with togreg
> branch on
> git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
> (tag: iio-for-6.8a)

I believe these paragraphs can be moved to the patch submission comments from
the commit message...

> Tested-by: Andreas Klinger <ak@it-klinger.de>
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
> v2 -> v3 removed iio.h include line

...somewhere here.

...

> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/stddef.h>

Basically here we need additionally these ones:

device.h
errno.h
types.h

(I haven't checked i2c counterpart for the similarities).

-- 
With Best Regards,
Andy Shevchenko



