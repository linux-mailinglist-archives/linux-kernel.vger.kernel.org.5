Return-Path: <linux-kernel+bounces-136895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D39289D979
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCFE728903E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995EF12DDAB;
	Tue,  9 Apr 2024 12:54:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD540384
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 12:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667287; cv=none; b=P0eRQuPRTRui3i4Nopf1T7U4LaZab1fq8GxbHXpaqpqDdJoNffsSLOP0iJ89nwfifw74h+rOfa5X47ehkZ2JKSp5O2Yzsq+TCri9/nMHAKoCWfn5W8xKuLjGqHjWELdmYNAqCwRZ/QuRBi/puz4/m2jijr16OxU+ubvrF0rJkAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667287; c=relaxed/simple;
	bh=K2X/fdC9FmUWPg8OZyLIDugRhEiOa+pUKoUIsMvmlSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8ewrLKaUiQ0XNeYaZnVBwtcpd65A4AOiEKEsdSfMysydSb/tSUaVNAQo2plzQRvlZw89C077B9sQWIhanpDGSlaYR+Cuayscj5ry7TLL8yvktRr1j3L1ks0YmxlPs7n6qpT33gwfMUa3U6PLfoI2ji6CZcxfj1TVaaFf1l1vng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: BwSXjRIcTlGgsKogAbD81g==
X-CSE-MsgGUID: 1j21BcDOQjKywTl7+1c/bA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8081107"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="8081107"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 05:54:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="915399138"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="915399138"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 05:54:43 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1ruAzp-00000002o9t-1dxg;
	Tue, 09 Apr 2024 15:54:41 +0300
Date: Tue, 9 Apr 2024 15:54:41 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] auxdisplay: seg-led-gpio: Convert to platform remove
 callback returning void
Message-ID: <ZhU6kUZsL9EhSilC@smile.fi.intel.com>
References: <20240409090306.29284-2-u.kleine-koenig@pengutronix.de>
 <CAMuHMdX9VxNsedQUfeYs3hgpVN=dt=z_VX34pZEzN82fcErp2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdX9VxNsedQUfeYs3hgpVN=dt=z_VX34pZEzN82fcErp2w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 09, 2024 at 11:29:06AM +0200, Geert Uytterhoeven wrote:
> On Tue, Apr 9, 2024 at 11:03 AM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > The .remove() callback for a platform driver returns an int which makes
> > many driver authors wrongly assume it's possible to do error handling by
> > returning an error code. However the value returned is ignored (apart
> > from emitting a warning) and this typically results in resource leaks.
> >
> > To improve here there is a quest to make the remove callback return
> > void. In the first step of this quest all drivers are converted to
> > .remove_new(), which already returns void. Eventually after all drivers
> > are converted, .remove_new() will be renamed to .remove().
> >
> > Trivially convert this driver from always returning zero in the remove
> > callback to the void returning variant.
> >
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



