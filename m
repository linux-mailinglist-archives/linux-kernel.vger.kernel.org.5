Return-Path: <linux-kernel+bounces-22302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC15829C00
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5048A1C20DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F824A99B;
	Wed, 10 Jan 2024 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LRbkosC1"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3490481A0;
	Wed, 10 Jan 2024 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wg+JdhHtLxWgbjYOBxwa3B4vfuHrxB0uyCssl4auPW4=; b=LRbkosC13u2I7bkYFIw4sqCyvh
	9HCHCRVLUn3GBBOt52/uPG37UrgeiN1JevHWLK6glkyC15bOj0tTvERkX8qBYy/r+u2zIuRLz5b8Q
	p2VvNr89OLMxlrg7bthZTogLljM2k4P1sYdRlA5Je/puq6WSYJ94gkjnvxUHPGO/hRbZ+AZi+JY0i
	alIIb03exo/yAlz485/n8ggvDbYdDFYtt2MBRwiwHFau6fahmZIAeGnewD/UO8EvwFQQZFK1xuRoy
	E9toHUJCoAM+QI4o1qIpC8uguGsnbfPBDk/GbUDFHpLfcn2/TWUh24xywA7oPSVafjAODbp57xu0b
	xlSIayUw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39980)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rNZF1-0005Um-34;
	Wed, 10 Jan 2024 14:07:35 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rNZF3-0005My-3Q; Wed, 10 Jan 2024 14:07:37 +0000
Date: Wed, 10 Jan 2024 14:07:37 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: [0/2] ARM: Adjustments for init_atags_procfs()
Message-ID: <ZZ6kqV79ckeZ7JUj@shell.armlinux.org.uk>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <562a6f99-3f8e-9a77-e519-b668e24dced2@web.de>
 <b3c42397-c879-4381-aa96-c7887e81c068@web.de>
 <7dd19987-6590-4756-a929-1ff01503ad1c@web.de>
 <ZZ6MZl14bcIaCaQn@shell.armlinux.org.uk>
 <1c38e495-5c9c-4ff8-b453-93b882dd2c4c@web.de>
 <ZZ6R6KSQo9ph3ARZ@shell.armlinux.org.uk>
 <09c4cb2e-967b-4d0e-b5c6-f959e80290d9@web.de>
 <ZZ6gq5sOFf33GhM7@shell.armlinux.org.uk>
 <89406360-b6ee-455c-a575-031b87cf41ae@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89406360-b6ee-455c-a575-031b87cf41ae@web.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 10, 2024 at 03:00:11PM +0100, Markus Elfring wrote:
> >> Are you going to pick any patches up from linked information sources?
> >
> > No. Did you read my first reply which told you how patches get applied
> > to arch/arm? If you didn't, your patch won't get applied.
> 
> Do you request a resend of affected patches here?

Welcome to my /dev/null mailbox. It has plenty of space. Feel free to
continue sending your claptrap there. Rest assured I won't read it
anymore.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

