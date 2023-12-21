Return-Path: <linux-kernel+bounces-8714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6056881BB5F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CB2E28919F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A1E55E73;
	Thu, 21 Dec 2023 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a2s7i/u3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AB055E63;
	Thu, 21 Dec 2023 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703174033; x=1734710033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PeNU72hqlu6zAC317VRcxYcqe9McR8dNZc6cmXs8KCo=;
  b=a2s7i/u3yJNoujlbx53NoURb+hfKJAzTnyUvzaDx8S6g4/907tHiHgKB
   UixNKiSFLrThCCEClMvhpM4RnN/4VaMT0I0gOLx9eHwKHvOcE2pW3996U
   hly++sQlsirk3tqjqkYn8XVqLI5jUTn1bF994Pd24jhl/Z9HRl/k80i0I
   jdRDSQr7YeGH1eaRxBI9xfi1d22U6w6awOOthkRz8agljH/kLWkWIV4sW
   cuOFZRqAkCOQtYD4XMM6ng4FDvjN4d4DR+6qW6UrbnmuZmMhl83Wdwq97
   jYHKQTfWOleiWrMTjbI2eh8KmgdhEkDIic/EkSVlvtQ7EHqPR3W7F+kkN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="393157642"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="393157642"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 07:53:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="949960694"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="949960694"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 07:53:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rGLLD-00000007t42-3a0L;
	Thu, 21 Dec 2023 17:52:07 +0200
Date: Thu, 21 Dec 2023 17:52:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: broonie@kernel.org, conor+dt@kernel.org, krzysztof.kozlowski@linaro.org,
	robh+dt@kernel.org, kevin-lu@ti.com, baojun.xu@ti.com,
	devicetree@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, soyer@irl.hu, tiwai@suse.de,
	peeyush@ti.com, navada@ti.com
Subject: Re: [PATCH v2 2/5] ASoC: tas2562: remove tas2563 into driver
Message-ID: <ZYRfJ54E8ws0B1FD@smile.fi.intel.com>
References: <20231221101346.429-1-shenghao-ding@ti.com>
 <20231221101346.429-2-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221101346.429-2-shenghao-ding@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 21, 2023 at 06:13:42PM +0800, Shenghao Ding wrote:
> Remove tas2563 from tas2562, it will be supported in tas2781 to better
> support dsp mode.

DSP

...

After this patch the support gone --> regression for the current users.
The commit message does not explain why it's not a problem.

-- 
With Best Regards,
Andy Shevchenko



