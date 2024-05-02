Return-Path: <linux-kernel+bounces-166089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CADCB8B9611
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85902281DAF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F8328DBC;
	Thu,  2 May 2024 08:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sm/T+0ui"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEFC200A0;
	Thu,  2 May 2024 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636964; cv=none; b=Gsu9eARGyzknGAvxaVvfADiNIXlTICi/2LiUNIFS/XW7oYO+xsQn23/wbDusM2HpB9a09Dqi+mhmpGbXq9Y7n84i/xVwSS817dA2PdwUbSZt2KCu+lD3JuLnSzR5QxgYl9rszZOAdZYqiivcTwt2vAvo3Lw5QktM+CBaaXCQiQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636964; c=relaxed/simple;
	bh=oPGuPkHhcwOYBGws1FaAuOhDDi3Cpr/qlxKh7ABFSA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmLfcEBo4ox8vDTga9Q/tXZiJkl8isOcKmo4lpQt34RF8jKnlZcll/ORX9mjVn+JC5idok5fQpJMVLS1CoA+wstwpWC8qsJSXPUlETPTN2JDMlUZt1Ks159EM6fqWLRlYwNLyAUuyhBHFWLo1kB9HRfjU9Bmyz85bjTAnNkJFL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sm/T+0ui; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=p9H/wqBVi9vRVe7vBxSwiksXVPFSNUIhqmT3FrZLtFE=; b=sm/T+0uijlhMJTl12wtc8GNUj6
	rvPAruOZTis2rW1LpVm4pcbvdCDk8GbfFPXh7pgP6GBYJOXPYA+PbID7eqsdjNfCbk1f69yX7bRKU
	WYyA8ohWtXF5Kyp+yyg1wrDMAyEE3GMa58en77DaSWGq2wG9/xBkqKgiHdTWmXR8f4rE+Up8a/zOL
	wKbOVpT6gUfDsN5opzV0pQMpy5uPl1LeFlRXkQvSlz3V6mwk4Z+VweqUveZ//z/Ri9ASOlGPCXn8k
	6VSjuoD3z9/1HPwxxCg1tHBJM8OcwKb+G35SbnWJlCnMIGHT1zhm3kLo2c94FtZWn9YyrOoOJPmxE
	Ob0cUsoA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46528)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s2ROW-0006zn-0n;
	Thu, 02 May 2024 09:02:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s2ROS-0003UY-MH; Thu, 02 May 2024 09:02:16 +0100
Date: Thu, 2 May 2024 09:02:16 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Duanqiang Wen <duanqiangwen@net-swift.com>, mturquette@baylibre.com,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clkdev: report over-sized strings when creating clkdev
 entries
Message-ID: <ZjNIiDeXIjXhJlT4@shell.armlinux.org.uk>
References: <E1rl62V-004UFh-Te@rmk-PC.armlinux.org.uk>
 <e15b8a1165a5437ab1fa868ccd0b629c.sboyd@kernel.org>
 <560549ed7db5da2f2727dc053a5d196d.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <560549ed7db5da2f2727dc053a5d196d.sboyd@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, May 01, 2024 at 06:02:54PM -0700, Stephen Boyd wrote:
> Quoting Stephen Boyd (2024-05-01 17:59:16)
> > Quoting Russell King (Oracle) (2024-03-15 04:47:55)
> > > Report an error when an attempt to register a clkdev entry results in a
> > > truncated string so the problem can be easily spotted.
> > > 
> > > Reported by: Duanqiang Wen <duanqiangwen@net-swift.com>
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > ---
> > 
> > Applied to clk-next
> > 
> 
> And backed out because I get a compilation failure
> 
> drivers/clk/clkdev.c: In function 'vclkdev_alloc':
> drivers/clk/clkdev.c:182:17: error: function 'vclkdev_alloc' might be a candidate for 'gnu_printf' format attribute [-Werror=suggest-attribute=format]
>   182 |                 res = vsnprintf(cla->dev_id, sizeof(cla->dev_id), dev_fmt, ap);
>       |                 ^~~
> cc1: all warnings being treated as errors
> make[5]: *** [scripts/Makefile.build:244: drivers/clk/clkdev.o] Error 1
> make[4]: *** [scripts/Makefile.build:485: drivers/clk] Error 2

It builds fine for me. I don't get this _error_, and it's really no
different from what it originally was - instead of using vcsnprintf()
we're now using vsnprintf(). That should make no difference what so
ever.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

