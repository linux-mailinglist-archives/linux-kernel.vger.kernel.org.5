Return-Path: <linux-kernel+bounces-12149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 950F681F098
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42A31C21A7B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943A345C0A;
	Wed, 27 Dec 2023 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IItrMSUU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCCB45026;
	Wed, 27 Dec 2023 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703695829; x=1735231829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ObRmrEKrCs/aQWLW4FO1dZ1wW4evOUSWu2vqRi+/2iI=;
  b=IItrMSUUIkpv+F4wGGq0vs4mWeG2SDBM9xL3tzsfAaZj2BuMyK3Gr0rE
   H0LjhBrx3LRsHOhIYCVd6U+K1u5Alkh/IQZ2rMfPorYAPYiJucM2Ox1py
   vZmLJ+YI30zVTwBIz+ldLml3fdLNtn6K5EMEAxL6aS1pPjyJUrbJlPxbS
   9bx5u2iBEvjK2TBf8GkjU7nmJvRIRXhV0uaUw9bEkfEm5RU+0zvcVEuTr
   ejhv2/27E6GyvpKnXYgz0Y+fhIkraHYoX6oCyghIp/J1OAx9+pPVW492J
   sgGN2XNrTv2luTNzuiJGl5OxgKRS8URmWv8+Em1Fi0r9XmgZFVpo/SjJv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="15131139"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="15131139"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 08:50:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="812571252"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="812571252"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 08:50:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rIX6X-00000009T1e-0jFF;
	Wed, 27 Dec 2023 18:50:01 +0200
Date: Wed, 27 Dec 2023 18:50:00 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: broonie@kernel.org, conor+dt@kernel.org, krzysztof.kozlowski@linaro.org,
	robh+dt@kernel.org, kevin-lu@ti.com, baojun.xu@ti.com,
	devicetree@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, soyer@irl.hu, tiwai@suse.de,
	peeyush@ti.com, navada@ti.com
Subject: Re: [PATCH v3 2/5] ASoC: tas2562: move tas2563 from tas2562 driver
 to tas2781 driver
Message-ID: <ZYxVuGwyw1ZA3XBv@smile.fi.intel.com>
References: <20231225053932.1138-1-shenghao-ding@ti.com>
 <20231225053932.1138-2-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231225053932.1138-2-shenghao-ding@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 25, 2023 at 01:39:28PM +0800, Shenghao Ding wrote:
> Move tas2563 from tas2562 driver to tas2781 driver, because tas2563 only
> work in bypass-DSP mode with tas2562 driver. In oder to enable DSP mode
> for tas2563, it has been moved to tas2781 driver. As to the hardware part,
> such as register setting and DSP firmware, all these are stored in the
> binary firmware. What tas2781 drivder dooes is to parse the firmware and
> download them to the tas2781 or tas2563, then power on tas2781 or tas2563.
> So, tas2781 driver can be resued as tas2563 driver。 Only attention will
> be paid to downloading corresponding firmware.

I dunno if you got my emails, but my comments were completely ignored.
You can't do this patch as after it the current users may have a regression.

-- 
With Best Regards,
Andy Shevchenko



