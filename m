Return-Path: <linux-kernel+bounces-164292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 624368B7BE3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916091C2279F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD78770F5;
	Tue, 30 Apr 2024 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aL5mgz6k"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C9A143722;
	Tue, 30 Apr 2024 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491484; cv=none; b=VUZnvTgJTcR0k+TwdP9aHpyfgM9u64j7nAlMI7ehQ2Kf1142+o2sE3Gly6OlBCUc2+JblVGvwUj2m56BtjH7rGglQ+7VTyxmeQMxyhX6IyKWnebnVOyzUttHVqsF38OuKlh6heroGJFhdVlTyewCCLrjiWkjsHIQz4hqRi9UVmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491484; c=relaxed/simple;
	bh=m4xhMmy7sam+xsPd6zPA6Ji4V1IDiqCoOmIlSwQrGA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAfqBhcLKAUT0kHdi17p+pxOCVWLWavf4LoqGyXQYOGUOpVR8UBiF6COMIFtVeEGXZ+/mp7tYzA/RJvCFjYP0zPC4mTCHBZ3uvtYfjDHWA7WyOx6VrblDTV2WsR13SQYJIPGMNkQLqZKh2DCs14DMdbuKuNwHnFLGg2gOJhNE1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aL5mgz6k; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714491483; x=1746027483;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m4xhMmy7sam+xsPd6zPA6Ji4V1IDiqCoOmIlSwQrGA8=;
  b=aL5mgz6kRAHfoOhhQDOl3CAJtBRPnEQEersxIJmpWWagEe8QYEu9fllL
   CcDJ63RX7eO1mPuGRgL30HiuQAwmjTjbf5L4lyxRxSfVZ0RVSqwvbynnj
   aYa9OB/K1vpVBEk/AMnGyIDPCq6/6Re/3qZ3hPoPJG3ollB8/J1Mgzmuc
   tyElMcEWX0saiBqsugGwZq5QAKnr7XR5uE0D7uLpTf8nGX8NuPTWiQmQA
   MpvVxJhuAlHwiCju9sn8jTjFKTNggzQ45s6Wdpr4B7/iZbDhCodpUFYIH
   dCbU8vvOAYyr85iy9dL5Hc4M6fv+epZzlRc2Zx3mK6FGEwsxRNiecoLw/
   g==;
X-CSE-ConnectionGUID: UpZLh0DySKGkAfixIbKiMg==
X-CSE-MsgGUID: vY++q5t+RraXiuoYGevlVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10082440"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10082440"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 08:38:00 -0700
X-CSE-ConnectionGUID: TKfjSq4YTPaHJ+kFvT22Bg==
X-CSE-MsgGUID: HacH/Z/ATMyFIGBGcPp+1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="31308271"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 08:37:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s1pYI-00000002i8s-0ezK;
	Tue, 30 Apr 2024 18:37:54 +0300
Date: Tue, 30 Apr 2024 18:37:53 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petar Stoykov <pd.pstoykov@gmail.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: pressure: Add Sensirion SDP500
Message-ID: <ZjEQUeUmMQmMAj3W@smile.fi.intel.com>
References: <CADFWO8GC6RP6A7H-Cq5UZHfBY3VJZTCqssdZet61hH031euhwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADFWO8GC6RP6A7H-Cq5UZHfBY3VJZTCqssdZet61hH031euhwQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 30, 2024 at 05:27:20PM +0200, Petar Stoykov wrote:
> From 60f5cc7f65b07124f19428a713c3bc33b9e4a7a7 Mon Sep 17 00:00:00 2001
> From: Petar Stoykov <pd.pstoykov@gmail.com>
> Date: Mon, 15 Jan 2024 14:29:25 +0100
> Subject: [PATCH 1/3] dt-bindings: iio: pressure: Add Sensirion SDP500

You should really fix the email flow on your side.

-- 
With Best Regards,
Andy Shevchenko



