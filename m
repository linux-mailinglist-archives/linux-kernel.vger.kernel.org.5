Return-Path: <linux-kernel+bounces-97624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA84F876CBA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8AA282E1E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987EE5FDCC;
	Fri,  8 Mar 2024 22:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="Agh3+Jvo";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="I2qD65yd"
Received: from mailrelay1-1.pub.mailoutpod2-cph3.one.com (mailrelay1-1.pub.mailoutpod2-cph3.one.com [46.30.211.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85EC5FBA3
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 22:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935768; cv=none; b=GBELePV5mkNqZZCpCbU3qsE4cZOjsXZc7FR7rcAVqDv/C70L+l+idQ72HuR/EBFm4X49Wo0ZlFQHJTU87G8b+6gFdJYa9jmZPIi6JMySFBfAAi99q50b/EztdAYd5gyjT8YSUaVkWJAs7d1GijtszHWQILE/rhj9YHHtpLi8reM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935768; c=relaxed/simple;
	bh=834qs+3joZCkbp+FMZGEpLkV7x/MjBrhqaWUUY7wOBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dt483qEw+u9PxY7sjB2mcaP4C/S/cnUjwNFqvPSOOAtujC/IGJGrKfUXa+0eC/yzBDVt/lUwrEpcROarCG3Vll1wrqVHwEsJkGsukzxHtG3CZiGBgH8PLaLPh9sP0eskRw/GnhYf7C+5zaxxSfk733Q794Ml79MSZBjtR23PIbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=Agh3+Jvo; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=I2qD65yd; arc=none smtp.client-ip=46.30.211.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=AtLoa8zacGc0oIyeREeKHPcnZjoGrtMtwWVKHTle0wI=;
	b=Agh3+Jvoz+GCNvC+CwlKqVzOUVZ1Z9OZCQraAVQjni7waNpR2PTEc2tUUIXWuIM3HZMcWyxZuF6gK
	 pSpsy6SH0oEXcZBi3VsSzW8iuuJBnHo5TlAiGhCDJlIjT06tFIhS/313awg/JDjy4feI2CZ4cmcfem
	 ds8iBFwfT92aEJGHLBe16ZqdLKKmgeWAPRdUtzHhpxvlUC8XyZRVbgoisaBOd6tMWkzNSZVBZNucJs
	 wrUKZ28IBFPtyTRWJn47jCJw3VMZJoEopRdxRDHGPWhh9D41O+ACJRqM7pbl0BrXuODjcPF+cpVicp
	 KYqMr5rJFoI5P74pSEkTqWJtLNXhINA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=AtLoa8zacGc0oIyeREeKHPcnZjoGrtMtwWVKHTle0wI=;
	b=I2qD65ydnGFNH7+ZYpW9viE8IvI+NRbisMLG42LjFddJ35JUBJgBAYWASxJzwt/4ETuUou7GLNoHR
	 xyl3y+jBg==
X-HalOne-ID: 5a44b079-dd98-11ee-83ef-516168859393
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay1.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 5a44b079-dd98-11ee-83ef-516168859393;
	Fri, 08 Mar 2024 22:08:13 +0000 (UTC)
Date: Fri, 8 Mar 2024 23:08:12 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, sparclinux@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-parport@lists.infradead.org,
	"David S. Miller" <davem@davemloft.net>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH v2 7/7] sparc32: Fix section mismatch in leon_pci_grpci
Message-ID: <20240308220812.GA4091237@ravnborg.org>
References: <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
 <20240224-sam-fix-sparc32-all-builds-v2-7-1f186603c5c4@ravnborg.org>
 <b62d0ae6-c2cb-4f2c-b792-2dba52a44e35@gaisler.com>
 <c5654b69-209e-4406-ac70-9a4547adfc36@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5654b69-209e-4406-ac70-9a4547adfc36@gaisler.com>

Hi Andreas,

On Thu, Mar 07, 2024 at 07:20:11PM +0100, Andreas Larsson wrote:
> On 2024-03-05 16:06, Andreas Larsson wrote:
> > On 2024-02-24 18:42, Sam Ravnborg via B4 Relay wrote:
> >> From: Sam Ravnborg <sam@ravnborg.org>
> >>
> >> Passing a datastructre marked _initconst to platform_driver_register()
> >> is wrong. Drop the __initconst notation.
> >>
> >> This fixes the following warnings:
> >>
> >> WARNING: modpost: vmlinux: section mismatch in reference: grpci1_of_driver+0x30 (section: .data) -> grpci1_of_match (section: .init.rodata)
> >> WARNING: modpost: vmlinux: section mismatch in reference: grpci2_of_driver+0x30 (section: .data) -> grpci2_of_match (section: .init.rodata)
> >>
> >> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> >> Cc: "David S. Miller" <davem@davemloft.net>
> >> Cc: Andreas Larsson <andreas@gaisler.com>
> > 
> > Could you also add
> > 
> > Fixes: 4154bb821f0b ("sparc: leon: grpci1: constify of_device_id")
> > Fixes: 03949b1cb9f1 ("sparc: leon: grpci2: constify of_device_id")
> > 
> > for these fixes in your v3 of the series as well as CCing stable?
> 
> I'll pick up the whole series apart for the ZONE_DMA removal, so there
> is no other need for a v3. I can add the Fixes lines to this one, if it
> is ok with you Sam, or take it as is.

I did not verify the two fixes lines - but seems legit.
So would be super if you add them before applying.

Thanks for picking up the other patches, we are now much closer to
an all{yes,mod}config that can build (but not link).

	Sam

