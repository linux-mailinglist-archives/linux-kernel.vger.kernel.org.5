Return-Path: <linux-kernel+bounces-47882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7341B84541B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295F02856D6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F73715CD6A;
	Thu,  1 Feb 2024 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kBuCE4Uf"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E537B4DA17;
	Thu,  1 Feb 2024 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779971; cv=none; b=LZfmaT1g5dA4uMnwO7uN87QL9i+WXhhcU2oEhSHEw81h46OdxnR6FRHtXBkxSWE1zU0r/PL8GTzpp7XjwNdRXq32VQ7FdfF2KE5hiaEJ5I9PALDjhEudXTErreIAw43x3FeNGTz47+4JrAVMJFEDQxozex5JogMsQ2VYpLDsusI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779971; c=relaxed/simple;
	bh=thTHMvayYaLq2yO8XMZ4jUxByNXI43HWzHIRtPqbbUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WV7K/4EO/hnFS3eU4S+6uZrn/H+iZZHG5Zoz9WTONvWvu1XjelXESJLjOReHo9q18EovSTOACNzsliPaO8/H0NfCJTtOLlY6vML9rzAFsQFKk0yrV9Lf9Phocd7D1Vo/aWfxUq4f4sm/SV+5RbuYTmbbI/teMIowYKivFSnt5qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=kBuCE4Uf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GuAZN/0TLHop95zPSJq/liRwkKba22ntuB+Io7930rw=; b=kBuCE4Ufm6S/ImUw17iI8hZnXf
	rlJF+fpgS8tAJjS3LRyQrB5Z5OwAa96l6uI7CNX2Ha2Xzs9m4CQazj4EgVAbQy453207RB53/oSnC
	heyPck68MKup3/8FJ41Po0+9xp10A/CYe4eu5wYhQpkjM62gNkPHQzNDjKYXvWA5exhxqrAVee+27
	R7KKhsFMf/PYjBo+IhLHRYPnSUBX2xRK2Dn67rTirGUOlLF73FN2mVa06lL6MbJYtcClayhPWusnb
	h72jJC4ftuqQAoBdde0ucPjri7kYbrpukKBV7nd19Isn83Lt2rFLPph31x8HXoOuHZ+YeVPYc35Aj
	cogDNiOQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47286)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rVTR6-0004Lm-2o;
	Thu, 01 Feb 2024 09:32:44 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rVTR3-0007HN-QF; Thu, 01 Feb 2024 09:32:41 +0000
Date: Thu, 1 Feb 2024 09:32:41 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	patches@armlinux.org.uk, Paul Walmsley <paul@pwsan.com>,
	=?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
	Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 00/13] ARM: OMAP2+: fix a bunch of kernel-doc warnings
Message-ID: <ZbtlOWcGglCeYj6X@shell.armlinux.org.uk>
References: <20240117011004.22669-1-rdunlap@infradead.org>
 <20240117131305.GP5185@atomide.com>
 <e6692a04-142c-4df4-83dc-534ab27a55f6@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6692a04-142c-4df4-83dc-534ab27a55f6@infradead.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 17, 2024 at 08:52:16AM -0800, Randy Dunlap wrote:
> 
> 
> On 1/17/24 05:13, Tony Lindgren wrote:
> > * Randy Dunlap <rdunlap@infradead.org> [240117 01:10]:
> >> Fix many kernel-doc warnings in arch/arm/mach-omap2/:
> > 
> > Thanks for fixing these. These are unlikely to conflict with anything so
> > please queue them along with other clean-up:
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> > 
> > Or alternatively let me know if you want me to apply them.
> 
> Yes, please go ahead and apply them.

If you intend people other than me to apply patches, then please do not
copy the patches to the patch system. I now have to go through all 16
patches and search the mailing list to find out what happened... and so
far for the few I've checked, other people have applied them. So I'm
coming to the conclusion I should just discard the entire lot.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

