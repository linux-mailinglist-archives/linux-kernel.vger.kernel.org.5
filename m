Return-Path: <linux-kernel+bounces-92558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE62872225
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CF7D1C20DA8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551D5126F15;
	Tue,  5 Mar 2024 14:57:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397B06127;
	Tue,  5 Mar 2024 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650654; cv=none; b=TrIFRfZmbeU42aLgGKb0g/0R21hkjLqYx4tygEHaol7TPprwXgFjzcsQ1znpiZ88G48kw090Tr4ZqrkWLlUTjGNPXBnhUorEwWlrHSC+LAzdDPnpHF9rctqjtytCjVJOngulgFY4PZL6M/ibVeveIezEHpNj7GZO76JCEWOk3qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650654; c=relaxed/simple;
	bh=TIcbgZnFoOSin4xcvPxLtTGuR+etJMTMZC+5XvU+ehA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgWm0qXFNpF+m8jelDJ27v1joqqNLOHpd3Bp6r19SFIrBupScsV9uPfnPxBckSSvgdtjVZaCzMdYG8J42KHAYaBvPmk8gNWNahQ1cUdJdUw/SHseqKArDYNStSInD7GmquS7EJJd3GvxYuOneYt1SISfGiCyjHOKGGzkNl36Ew8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="29628910"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="29628910"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 06:57:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="914142298"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="914142298"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 06:57:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rhWEQ-0000000A0ft-0JAb;
	Tue, 05 Mar 2024 16:57:26 +0200
Date: Tue, 5 Mar 2024 16:57:25 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, lee@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v4 1/3] auxdisplay: Add 7-segment LED display driver
Message-ID: <Zecy1RsSfpmH-cvG@smile.fi.intel.com>
References: <20240305035853.916430-1-chris.packham@alliedtelesis.co.nz>
 <20240305035853.916430-2-chris.packham@alliedtelesis.co.nz>
 <CAMuHMdXF+12PHa5A7WeyPMfvsGcJN13WaPuCbTmJU52Huq=osA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXF+12PHa5A7WeyPMfvsGcJN13WaPuCbTmJU52Huq=osA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 05, 2024 at 09:23:07AM +0100, Geert Uytterhoeven wrote:
> On Tue, Mar 5, 2024 at 4:59 AM Chris Packham
> <chris.packham@alliedtelesis.co.nz> wrote:

..

> > +       priv->segment_gpios = devm_gpiod_get_array(dev, "segment", GPIOD_OUT_LOW);
> > +       if (IS_ERR(priv->segment_gpios))
> > +               return PTR_ERR(priv->segment_gpios);
> 
> This needs some validation of priv->segment_gpios->ndescs, else the
> call to gpiod_set_array_value_cansleep() in seg_led_update() may
> trigger an out-of-bounds access of the values bitmap.

Alternatively we can call gpiod_count() beforehand and check its result.

-- 
With Best Regards,
Andy Shevchenko



