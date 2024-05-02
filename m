Return-Path: <linux-kernel+bounces-166374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9026C8B99BF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17BB1C229C6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B29604C8;
	Thu,  2 May 2024 11:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pguM2JIl"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EEA5C8EF;
	Thu,  2 May 2024 11:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714648138; cv=none; b=jbNO8K37ujfVNmfVN4t/1REkVUNY/CYCpkUmbsos40BpsHo/Ck6JQ/JCm9i4hj1wRchobej8iALprxUbTOPYVKYVR471x/BNmoh4OHbvcV3IOL0I38WaCdbZwHUjz4ogTo5SfGDauMTS0vPe7NFsJAIj9G0Sm+jWPKW1TidmfIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714648138; c=relaxed/simple;
	bh=yHhEEO1k8GZkLOIk0m9sDTJz8Cg1evDntc5JF3aC37g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9yc02JwI/u/TeEKN++NK2ngXp746Wwl4ZesIK1NKTMuQLl02gSBm5VEWiWP07zg9wQnCRDcvnFfRs9Xf0/2vypgEpr9K6yKnoidu2L16yZpzGmPQl4jZCfW2TnZGGLsJn256eY+pBQFRN9OgC2g+XD8O8L7Av6du6X6VaqH+WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pguM2JIl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RixZO4UNd5X+9/Eb+rJgRIgpftzrZx704xGqdwLo84c=; b=pguM2JIlPY0Lc+2Pu/lym4sSK3
	TWl5G680QXe50eULZWlN4Q1SYb/H/CHXp+OQiaYmXz66j4fyKYuc5x95eoOJvIi9BUw4R4il6T2h9
	kvb4lpNtvUX8lWYwSPjAsjk67d5ilLYgRRlsuyl0svGig0+JXblFpVkw4cjkk54FRq2VO2oWeTJmV
	b6twrDWplwXdeDBEKrp8iDtMY8QnW6Eg/7PYh8kz3V1TpEnNwupYR7vaVgt+W6MaOQcVtwk9n+DbN
	9TJJF6tp1GvFeeK98mOiUs4nUwmy6paKBOLl0o8+6khTUn4BRFuHNi4bdS9jn2E/ZCK0rRvTTvOae
	iOfH5XSw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58980)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s2UIr-0007CJ-13;
	Thu, 02 May 2024 12:08:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s2UIo-0003bE-5n; Thu, 02 May 2024 12:08:38 +0100
Date: Thu, 2 May 2024 12:08:38 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Duanqiang Wen <duanqiangwen@net-swift.com>, mturquette@baylibre.com,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clkdev: report over-sized strings when creating clkdev
 entries
Message-ID: <ZjN0NkYifXY0OsZt@shell.armlinux.org.uk>
References: <E1rl62V-004UFh-Te@rmk-PC.armlinux.org.uk>
 <e15b8a1165a5437ab1fa868ccd0b629c.sboyd@kernel.org>
 <560549ed7db5da2f2727dc053a5d196d.sboyd@kernel.org>
 <ZjNIiDeXIjXhJlT4@shell.armlinux.org.uk>
 <ZjNNT+KBNpQL+U3b@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjNNT+KBNpQL+U3b@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, May 02, 2024 at 09:22:39AM +0100, Russell King (Oracle) wrote:
> On Thu, May 02, 2024 at 09:02:16AM +0100, Russell King (Oracle) wrote:
> > On Wed, May 01, 2024 at 06:02:54PM -0700, Stephen Boyd wrote:
> > > Quoting Stephen Boyd (2024-05-01 17:59:16)
> > > > Quoting Russell King (Oracle) (2024-03-15 04:47:55)
> > > > > Report an error when an attempt to register a clkdev entry results in a
> > > > > truncated string so the problem can be easily spotted.
> > > > > 
> > > > > Reported by: Duanqiang Wen <duanqiangwen@net-swift.com>
> > > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > > > ---
> > > > 
> > > > Applied to clk-next
> > > > 
> > > 
> > > And backed out because I get a compilation failure
> > > 
> > > drivers/clk/clkdev.c: In function 'vclkdev_alloc':
> > > drivers/clk/clkdev.c:182:17: error: function 'vclkdev_alloc' might be a candidate for 'gnu_printf' format attribute [-Werror=suggest-attribute=format]
> > >   182 |                 res = vsnprintf(cla->dev_id, sizeof(cla->dev_id), dev_fmt, ap);
> > >       |                 ^~~
> > > cc1: all warnings being treated as errors
> > > make[5]: *** [scripts/Makefile.build:244: drivers/clk/clkdev.o] Error 1
> > > make[4]: *** [scripts/Makefile.build:485: drivers/clk] Error 2
> > 
> > It builds fine for me. I don't get this _error_, and it's really no
> > different from what it originally was - instead of using vcsnprintf()
> > we're now using vsnprintf(). That should make no difference what so
> > ever.
> 
> ... and I've just checked, and it builds entirely cleanly for me.
> 
> I'll merge it.

It should be in tonight's linux-next tree.

I also note... the kernel build bot never flagged the above, not even
a warning for it, and it would've built the patch as it was Cc'd to
linux-kernel. So my conclusion is the error you are seeing is somehow
specific to your environment. Maybe you're building with an additional
set of warning flags and -Werror?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

