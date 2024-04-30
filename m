Return-Path: <linux-kernel+bounces-164295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 039208B7BF5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B899628541E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C716174EC7;
	Tue, 30 Apr 2024 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bO8Fv/JI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC06172BBF;
	Tue, 30 Apr 2024 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491641; cv=none; b=Y7EqC30nOE6OiACCZRAhYORX3GdJ9qalkVcJs8q5SbGg2ANHTEEAqaKrHnwIM95ETNSI4W/fmPbGuQL5NuGKWrntPnqcYkAjtibaeGlL8LfmQKcoIE6Hin3+Fh/vGEsKfcGDScufJ5u3LJ0WX+yufhm61kpZVPXtiFYi7LusGlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491641; c=relaxed/simple;
	bh=AhXim/Cc8ypQWAXX8GYwTtPeMzV9LcwnwpaCMgnFYdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhOX9wBx00BvzaQSvjqinrBUQbYAgjEuBTBqmvJcBGBTtUilEoga2x1V32lt23aDBkjaJjxz6Dba66hMaZcDm9aNqxiBeJb8FxpGK2Nbx6uTuZj2diQhQD/rRe8jrBIIPN6E6S1lnbgjpkEVL/1/0HFPwZn3T/Gn+b1R1GjEPII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bO8Fv/JI; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714491640; x=1746027640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AhXim/Cc8ypQWAXX8GYwTtPeMzV9LcwnwpaCMgnFYdE=;
  b=bO8Fv/JIFcuxv8bWze/OgdH7y7nG2i7laLu4a3xgsaGcizkmGQ08F7FN
   sXgCsKGgLGHgQsWAiLBOY6XOkVS7zux5Tcfa8LeqILYqjshtWvJa1FKRs
   jOd6Zd1bXeM19x3p6Q/GocjlAYQxTvLnrufaqBn8erm46zgJQddRaLxGS
   +J/dO8E4QHIh1Tf6g8PoVbrCVO9MGhYMOdu8Rit7AATAvYF4kTeuNzxxI
   6gv9PfwsM5PLRBhssarIDEpupUWdH2NAUZbK55InWMYV/SiZWHY6c1x4o
   Xn84GuM6IeXAcVmkPibJJswh1o9NEDLG04gpekUc5iI7CpLIirZeJSsny
   g==;
X-CSE-ConnectionGUID: 53cGs2IzSJa7biN3ITYL2w==
X-CSE-MsgGUID: w9Uqr4dsTOGKe9hFnXGabw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10066457"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10066457"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 08:40:40 -0700
X-CSE-ConnectionGUID: zUTsGXBoR22YHQ6INz1/Zw==
X-CSE-MsgGUID: f3OF7Y3dTSOPjEERKsuEtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="31297597"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 08:40:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s1par-00000002iBe-0CR9;
	Tue, 30 Apr 2024 18:40:33 +0300
Date: Tue, 30 Apr 2024 18:40:32 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petar Stoykov <pd.pstoykov@gmail.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: pressure: Add driver for Sensirion SDP500
Message-ID: <ZjEQ8LBxftcr0Z0t@smile.fi.intel.com>
References: <CADFWO8EQUkGcbE=RXjxXbub2tZge9+ss=gB-Q6wngFAvwFygRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADFWO8EQUkGcbE=RXjxXbub2tZge9+ss=gB-Q6wngFAvwFygRg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 30, 2024 at 05:27:24PM +0200, Petar Stoykov wrote:
> From 6ae7537517f551540121ca6fb3b99080b7580410 Mon Sep 17 00:00:00 2001
> From: Petar Stoykov <pd.pstoykov@gmail.com>
> Date: Mon, 15 Jan 2024 12:21:26 +0100
> Subject: [PATCH 2/3] iio: pressure: Add driver for Sensirion SDP500
> 
> Sensirion SDP500 is a digital differential pressure sensor. The sensor is
> accessed over I2C.

Any Datasheet: tag can be added?

..

> +config SDP500
> +    tristate "Sensirion SDP500 differential pressure sensor I2C driver"
> +    depends on I2C
> +    help
> +      Say Y here to build support for Sensirion SDP500 differential pressure
> +      sensor I2C driver.
> +      To compile this driver as a module, choose M here: the core module
> +      will be called sdp500.

You patch is broken. Fix the way how you send patches.

..

> +static int sdp500_start_measurement(struct sdp500_data *data, const
> struct iio_dev *indio_dev)

Here is more visible.

-- 
With Best Regards,
Andy Shevchenko



