Return-Path: <linux-kernel+bounces-79055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 749E2861CDF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36925282A90
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8481143C77;
	Fri, 23 Feb 2024 19:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FLYJNBQz"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECA51448E5
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 19:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717797; cv=none; b=FEKs5Sq967GDsRmx7kF+Q8A3Esp/eyLpXvO+V9CCz67MomUkoB3Ov+sT3zBWUU7qNh/bNqLxEo5FQnsvPaLJUGHphQGUr02/kmFSFCGXdVrv1xCHNZdeD3bXz/qvG5J8LtRL9lHPMGI9IhBhnnmwHfTVQzN4ObJu2mQ93NfAl6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717797; c=relaxed/simple;
	bh=dWt1yNz7d25oMogRjXhB3IA425EktxqvqhOdZEAgQrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvzwHZQ9whAL66vjZd6BU+nfPnsDi4JWQ5YuEE8/toH5oBokDOGF1HOSng/DMnYGzwF7mL4TlM1tI6dgtflmox3Eu0U36tjGrcsZNIWg0UvR9Uxg/aI7/iQ/kCXgAoutxy4H+fZbFVO/4HgisR5lr6d3dPO628rDqJZB4vwGddg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FLYJNBQz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SS67iSMlDFwHXkwAP1W58NWb3inuazTy+SpPIld66KI=; b=FLYJNBQzuXsqnOasfFRprBMqBu
	RSgi5745PHkvo2D0/7waffRr3f6qGZtSzmPx611aZJbR61/6yLjGIqfpAF37hGMN9fuRya6qLdwuq
	FFqqeXFk3dT37FVw2oJhZmT5G6UYo4I77np1maaUvYcfxnZcsItM0oX7P9yqCKSujc1k2BXQ3eP42
	DpzPMjDS4IUSXtTXmdFPXx3jl7+7y5+rm9br3Y77puQRQxt+n7mc06k34hvfsaZKTOEj5TSd9Ms45
	B/cfuAbs2yvKZ5JAjOPonIsPIP5ZyOBFWK36+d3aofcHRIrYdrRoI74UEkc569oKG5J4VEcS7RnYd
	jd2v2xiQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53220)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rdbY9-0000sy-0F;
	Fri, 23 Feb 2024 19:49:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rdbY5-0003sU-LE; Fri, 23 Feb 2024 19:49:33 +0000
Date: Fri, 23 Feb 2024 19:49:33 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Ruhl, Michael J" <michael.j.ruhl@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clkdev: Update clkdev id usage to allow for longer
 names
Message-ID: <Zdj2zaicBvkTOZZe@shell.armlinux.org.uk>
References: <20240223163516.796606-1-michael.j.ruhl@intel.com>
 <ZdjZCrpP52Hfbs6L@smile.fi.intel.com>
 <DS0PR11MB64248E0C15C0B86A1CCF945BC1552@DS0PR11MB6424.namprd11.prod.outlook.com>
 <Zdjku0kxCvMl2HcU@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zdjku0kxCvMl2HcU@smile.fi.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Feb 23, 2024 at 08:32:27PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 23, 2024 at 06:22:13PM +0000, Ruhl, Michael J wrote:
> > >From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >Sent: Friday, February 23, 2024 12:43 PM
> > >On Fri, Feb 23, 2024 at 11:35:16AM -0500, Michael J. Ruhl wrote:
> 
> ...
> 
> > I will remove.
> 
> Not remove, but move to the comments/changelog (after '---' line)
> 
> > I see your script automatically does a cover page...will use that format int
> > the future.
> 
> Only if there are more than a single patch.
> 
> ...
> 
> > >[1]: https://github.com/andy-shev/home-bin-
> > >tools/blob/master/ge2maintainer.sh
> > 
> > Using your script I got:
> > 
> > To: "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
> >         linux-arm-kernel@lists.infradead.org,
> >         linux-kernel@vger.kernel.org
> > Cc: Russell King <linux@armlinux.org.uk>
> > 
> > My list (using get_maintainers.pl) is:
> > 
> > linux@armlinux.org.uk
> > linux-arm-kernel@lists.infradead.org
> > linux-kernel@vger.kernel.org
> > 
> > They appear to be the same....
> 
> Ah, the Russel's email looked like a mailing list, that what confused me.

Joe, I think you know that I'll pick up on your mis-spelling of my
name... and I take that as an implicit right to call you something
other than your proper name. :D

Secondly, because the Cc contained my name, I fail to see how you can
confuse that with a mailing list. Maybe your script that you mentioned
strips the names from the email addresses, thereby adding to your
confusion - and maybe that isn't such a good idea after all? I'm not
the only one who uses linux@... There are six people in total listed in
MAINTAINERS who have a linux@... email address there.

> > I don't have the plain text part on Russel's email (linxu@armlinux.org.uk)... Is that what is missing?
> 
> Yes :-)
> But my script also uses a heuristics (which is not visible here) to add active
> developers of the code in question based on the git history.

The developers in question for this part of the code is me and not the
CCF. Therefore, what has been done by the patch author is reasonable
and no special scripts are necessary.

While my main git server is offline, I'm happy for the CCF folk
to pick this up, so:

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Michael, please resubmit with my r-b line above, and include the CCF
folk in that posting:

Michael Turquette <mturquette@baylibre.com>
Stephen Boyd <sboyd@kernel.org>
linux-clk@vger.kernel.org

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

