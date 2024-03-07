Return-Path: <linux-kernel+bounces-95590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA67A874FE2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A48282576
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A9612C7EC;
	Thu,  7 Mar 2024 13:23:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229713EA8A;
	Thu,  7 Mar 2024 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709817817; cv=none; b=X64wtfHaIqrI9Gh+VgQNKsrruMp+GT+7KoasPoTEhSb5P+xuYLoBc37cCZvi0QLEELT8Ph4/jKdOCBnbDrNUuaae4SnwfgV4YSd6XGjMwbzMelbRTP6fh9TkNX0KNLfEi5qNITb51T0/ievlRlowyWxxJ4CQJt4i6uBnLlssE5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709817817; c=relaxed/simple;
	bh=QDSw/onQwWE3aXFRC4Eip93K8ZRBf8/+gHveqY3AYt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxXz4TTpUoA23IUS0mW1XDSrITp0pU7wbpAcrIzKGSF4xctQ1QiJW3lZ6fkjqgzHV+2IDquEdcTlYDq6WUgKXb6sZdM87NhrdKVz5WWy37rPE9UoIdJtv3x7z64nHqkomd/BhSFy/mf6aP6odQltzlVUU9endjzZbhJsTM92VS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="8242519"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="8242519"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 05:23:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="914214115"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="914214115"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 05:23:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1riDib-0000000AZWB-1oTI;
	Thu, 07 Mar 2024 15:23:29 +0200
Date: Thu, 7 Mar 2024 15:23:29 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, lee@kernel.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/3] auxdisplay: Add 7-segment LED display driver
Message-ID: <Zem_0dph7FMwE42u@smile.fi.intel.com>
References: <20240306235021.976083-1-chris.packham@alliedtelesis.co.nz>
 <20240306235021.976083-2-chris.packham@alliedtelesis.co.nz>
 <CAMuHMdUzrkRk_07SfQoZoe8b+bxkX+fLH_f5tVqbUZu23=DN_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUzrkRk_07SfQoZoe8b+bxkX+fLH_f5tVqbUZu23=DN_Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 07, 2024 at 02:13:23PM +0100, Geert Uytterhoeven wrote:
> On Thu, Mar 7, 2024 at 12:50 AM Chris Packham
> <chris.packham@alliedtelesis.co.nz> wrote:

..

> > +       DECLARE_BITMAP(values, 8) = { 0 };

While doing next version, drop this '0', as we have in another terminator
the same approach (i.o.w. for the sake of consistency).

..

> > +       gpiod_set_array_value_cansleep(priv->segment_gpios->ndescs, priv->segment_gpios->desc,
> > +                                      priv->segment_gpios->info, values);
> 
> This may still cause an out-of-bounds access of values if ndescs > 8.

Not really. It will be only for ndescs >= 32 (on 32-bit) or 64
(on 64-bit accordingly).

But good catch, we better to narrow the range down.

-- 
With Best Regards,
Andy Shevchenko



