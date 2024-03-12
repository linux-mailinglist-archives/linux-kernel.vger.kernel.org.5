Return-Path: <linux-kernel+bounces-100448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7648797B1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0BF1C21A71
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1728E7C6DE;
	Tue, 12 Mar 2024 15:36:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351A27C0B2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257769; cv=none; b=Z+a3G4af93wMh5i6me5pRT+PMFj4DNwxxYbHd9Jr2iq0lBAZlRgXpT6BRXJbXaItXfRLbusbUxcOsZZhXEzF0gh0tdxLNS8xd+8WWggdP70IQvCYshDQX7dliVIvu/70e1UfD6U4jO9qeEBF4cDLCqs3PxmSTRkgVhxPXuKQTfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257769; c=relaxed/simple;
	bh=px16BB2yL1LGNNnF1idex0fwqAdQ6VLGIXIo4UIpP4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDW6xri+16RbJFpYDf/IXoFHmepDAt1FoZFxHGJ27xblPcOytM6B2hyJq5P0ks7kdUN881GlZJmQuab3yKl1xt2HeLbOugG+qoGTvyEW7Wf2VV57iLgIoGCM4mWtBdRyLKBcVKxh2XDE9K2ayKpOyH1HFOS1NF2MCt1aYQY2wk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="4826974"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4826974"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 08:36:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="914399956"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="914399956"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 08:36:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rk4Ad-0000000Bvnx-1G7J;
	Tue, 12 Mar 2024 17:36:03 +0200
Date: Tue, 12 Mar 2024 17:36:03 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH 3/3] auxdisplay: img-ascii-lcd: Convert to platform
 remove callback returning void
Message-ID: <ZfB2Y1P5VRZWEUqu@smile.fi.intel.com>
References: <cover.1710194084.git.u.kleine-koenig@pengutronix.de>
 <44de2d4c1fed6fe96b68ba9ad768d297b8f392a5.1710194084.git.u.kleine-koenig@pengutronix.de>
 <CAMuHMdVvmN2xns_76zSDpUX-v8V16mSP12A=Y4gght9cdgNb+A@mail.gmail.com>
 <r5ydocz3u3ng6voax2iveoqvvqpuo6s3defjkpqzmuoj222clw@76ilb4kbjlrw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <r5ydocz3u3ng6voax2iveoqvvqpuo6s3defjkpqzmuoj222clw@76ilb4kbjlrw>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 12, 2024 at 11:27:37AM +0100, Uwe Kleine-König wrote:
> On Tue, Mar 12, 2024 at 09:17:54AM +0100, Geert Uytterhoeven wrote:
> > On Mon, Mar 11, 2024 at 10:59 PM Uwe Kleine-König
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > The .remove() callback for a platform driver returns an int which makes
> > > many driver authors wrongly assume it's possible to do error handling by
> > > returning an error code. However the value returned is ignored (apart
> > > from emitting a warning) and this typically results in resource leaks.
> > >
> > > To improve here there is a quest to make the remove callback return
> > > void. In the first step of this quest all drivers are converted to
> > > .remove_new(), which already returns void. Eventually after all drivers
> > > are converted, .remove_new() will be renamed to .remove().
> > >
> > > Trivially convert this driver from always returning zero in the remove
> > > callback to the void returning variant.
> > >
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > 
> > Thanks for your patch!
> > 
> > > --- a/drivers/auxdisplay/img-ascii-lcd.c
> > > +++ b/drivers/auxdisplay/img-ascii-lcd.c
> > > @@ -279,13 +279,12 @@ static int img_ascii_lcd_probe(struct platform_device *pdev)
> > >   *
> > >   * Return: 0
> > 
> > Please remove this line.
> 
> Good catch, thanks.
> 
> @Andy: Should I resend this patch? Or the whole series? Or do you want
> to fixup while applying?

Not big deal, I'll fix it whilst applying.
Thank you!

-- 
With Best Regards,
Andy Shevchenko



