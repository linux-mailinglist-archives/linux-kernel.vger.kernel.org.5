Return-Path: <linux-kernel+bounces-164290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F7E8B7BDA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F34A1C24554
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE63143759;
	Tue, 30 Apr 2024 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RfER//q/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945011527AF;
	Tue, 30 Apr 2024 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491442; cv=none; b=W04MOAsgir5ZIDR7+8OAdNJA91HO1rkpzPoqWEVxSImOrrtn30OdW8CMvhLB/F8fb2n9lpDYTAm9ozDwfNF7Wr6KyaF+9ArMJv1+iO7/EOCabGu3mhVg43DDU9KsqarQWO3geatTLqBAR0qdac8V2pPkddN/NZGai6V/mKl+XUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491442; c=relaxed/simple;
	bh=e6pUJhjQW6nIxwf6P9VZRO76v+TpkWhCfGxiUDE2B0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHDxba8cKFxrqNf1G4nk9OOT6Xm8u1L2KuXbRo6DuWeOL9IQ2BgphpHBzTNHvDnAyCDfzFOFCtA+R42K9NGwTvCXYriSYh+FS+DknIAKBnkE7BAwNVUH5uQAB/1Y6OG4Lqg/qcrxM2pwrIxh7zdyjng5tMjr+qrL+fFo/aAhbTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RfER//q/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714491441; x=1746027441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e6pUJhjQW6nIxwf6P9VZRO76v+TpkWhCfGxiUDE2B0g=;
  b=RfER//q/JVV2Br/gNtB6FfDyZbqKhzkqDy9CGsQDRsSSNbPDyIqD2s4m
   /YU84PRmXCO2aCJRdhmPCEHcWqT95KduuI7s/K5JRAboQ7+H34hU1fzxU
   TIKh5wYsA9/3JOzBXobTcmKjnPKXSbSao0yJL9LyRpe3RYOHQVK3imSFv
   Kq8zTFsw1c2h5YaWsk8ZPlxljFDdnVUHnwyCBv+od0FU7o6mo/Vv6tEZQ
   qSPD5Y5fNMF4K7K+32M/esH9J8TeWsSszXeQK6xAIfiq8dtYNrSidhU9z
   uMyPAK/n+mT18Ih8aYzlxg65Y248xxsNAPxyV65J//OsuVsvaohTVO3Wy
   Q==;
X-CSE-ConnectionGUID: VK/tX2m3ROqkKszHPlpmGw==
X-CSE-MsgGUID: fgwYYLZWSdayBjKfWt0OXA==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="35591262"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="35591262"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 08:37:20 -0700
X-CSE-ConnectionGUID: cY3uSIQgQAymBhD7ehXS2w==
X-CSE-MsgGUID: X5dBi9jNReG7s0mpWyUYWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="57678464"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 08:37:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s1pXe-00000002i84-3wjG;
	Tue, 30 Apr 2024 18:37:14 +0300
Date: Tue, 30 Apr 2024 18:37:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petar Stoykov <pd.pstoykov@gmail.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Add support for Sensirion SDP500
Message-ID: <ZjEQKqkWA66HtiD4@smile.fi.intel.com>
References: <CADFWO8EZWkXeAMcURgGGEmzVjiSxFTVAbKpsb2Qmv66EZiTc+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADFWO8EZWkXeAMcURgGGEmzVjiSxFTVAbKpsb2Qmv66EZiTc+A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 30, 2024 at 05:27:17PM +0200, Petar Stoykov wrote:
> From c4437fd0ea296c4c964b1fb924144ae24a2ce443 Mon Sep 17 00:00:00 2001
> From: Petar Stoykov <pd.pstoykov@gmail.com>
> Date: Mon, 29 Apr 2024 16:41:30 +0200
> Subject: [PATCH 0/3] Add support for Sensirion SDP500
> 
> This patch series

It's not. I mean from the email chaining perspective. Have you forgotten
to add --thread to git format-patch?

Also, what is that in above?

> introduces support for Sensirion SDP500 in the IIO
> subsystem. The series is split into three patches:
> 
> 1. The first patch adds the device tree bindings.
> 2. The second patch implements the device driver.
> 3. The third patch updates the MAINTAINERS file.
> 
> The driver is relatively simple. It provides a way to read the measured
> differential pressure directly in Pa, as the device has a fixed scale
> factor of 1/60. When an applications wants to read the pressure value,
> 3 bytes are read from the device, 2 are data and 1 is CRC8. If the crc
> check passes, the calculated pressure value is returned in Pa units.
> 
> The initialization of the device just starts the measurement process.
> 
> We have been using this device and driver in a product development for
> almost a year now. There the pressure is read every 25ms and is used in a
> control loop. We have not even seen crc errors. We are using the
> "linux-imx" repository and not the mainline one but I see no risky kernel
> functions in use so it should be fine here too.
> 
> All feedback is appreciated! Thank you for taking the time to review this.

-- 
With Best Regards,
Andy Shevchenko



