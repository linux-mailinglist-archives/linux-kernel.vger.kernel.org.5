Return-Path: <linux-kernel+bounces-82104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7DA867F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2191C2B501
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A98412E1CB;
	Mon, 26 Feb 2024 17:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uZZb1kEo"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8053812F378;
	Mon, 26 Feb 2024 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708969877; cv=none; b=CHSGPIWa63nqMzxjvboor3tD9Q9CBU6f51Pz78jB1Gt+LeStsYaHyttX6DFH1v34kxyWfY2Exeu7nKpBjaP50ZsAeWGvfCxBExzRgsqTBJF/GBAw2kRyzCFz/CBv8NCXzkXhEC9s9EmvYFEDm495ilS8NRwpQgO2buxxN1/xGh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708969877; c=relaxed/simple;
	bh=qS8OT9weX4S2COy6j3APFrkuDaTbvAGT/4iWvd39c/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oqdhuj01A25H+7OVo8wlJ51JyXXeggCnvSgwGbemfc83XUHYjZC31xIy8i6owv7jQtPtgy9GJPUBjfuSUv/qqxuejLEQ3cRbWn/J9KEmbvEPWb17lpUopcIrALHjE0Ic7YVthnTSJTP9QJFJI1n6MBYs5qffmWQjC5YQlU8ZBA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=uZZb1kEo; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DS/FPTlhqUV1Rbg7GjDt8wu7AR4Zgooi3ewXLgKys4c=; b=uZZb1kEoLX0PAJhCzRKUy1g8Uv
	SM+ZTC9ce6iXI97yEZwMtIvw5Lg3sO+8TwU/Yu8qkCLF1A+/VH/fSTtULAWPKnSCb+daQeBXzIyG6
	8W1NEzzdisP4BLY3je4cSsZZO2YCORB9qBwKvUj8nIA60Y097T6ZwzAwoAfM89DWyDCCQ7jeO4gqh
	IXG/VZsGfdMjIN8I+ZpoYWgafqV2v0ukZQoO9cK1EOYfs4TBJDe29tRKB72oqoQIkZB+3dbtTFD8k
	SsPnkVQtYn4MFi5EgMUUpYmochutSB8T+EjoktzLSPzeHxbhESm3tNJU6WJ1FLIv2GybwO7+aRwFa
	2lSAHhiQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35226)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ref81-0004XQ-0c;
	Mon, 26 Feb 2024 17:51:01 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ref7x-0006ci-SJ; Mon, 26 Feb 2024 17:50:57 +0000
Date: Mon, 26 Feb 2024 17:50:57 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Charlie Jenkins <charlie@rivosinc.com>,
	David Laight <David.Laight@aculab.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Helge Deller <deller@gmx.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Parisc List <linux-parisc@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Message-ID: <ZdzPgSCTntY7JD5i@shell.armlinux.org.uk>
References: <20240223-fix_sparse_errors_checksum_tests-v10-1-b6a45914b7d8@rivosinc.com>
 <7ae930a7-3b10-4470-94ee-89cb650b3349@csgroup.eu>
 <e11fea7a-e99e-4539-a489-0aa145ee65f0@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e11fea7a-e99e-4539-a489-0aa145ee65f0@roeck-us.net>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 26, 2024 at 08:44:29AM -0800, Guenter Roeck wrote:
> On 2/26/24 03:34, Christophe Leroy wrote:
> > 
> > 
> > Le 23/02/2024 à 23:11, Charlie Jenkins a écrit :
> > > The test cases for ip_fast_csum and csum_ipv6_magic were not properly
> > > aligning the IP header, which were causing failures on architectures
> > > that do not support misaligned accesses like some ARM platforms. To
> > > solve this, align the data along (14 + NET_IP_ALIGN) bytes which is the
> > > standard alignment of an IP header and must be supported by the
> > > architecture.
> > 
> > I'm still wondering what we are really trying to fix here.
> > 
> > All other tests are explicitely testing that it works with any alignment.
> > 
> > Shouldn't ip_fast_csum() and csum_ipv6_magic() work for any alignment as
> > well ? I would expect it, I see no comment in arm code which explicits
> > that assumption around those functions.
> > 
> > Isn't the problem only the following line, because csum_offset is
> > unaligned ?
> > 
> > csum = *(__wsum *)(random_buf + i + csum_offset);
> > 
> > Otherwise, if there really is an alignment issue for the IPv6 source or
> > destination address, isn't it enough to perform a 32 bits alignment ?
> > 
> 
> It isn't just arm.
> 
> Question should be what alignments the functions are supposed to be able
> to handle, not what they are optimized for. If byte and/or half word alignments
> are expected to be supported, there is still architecture code which would
> have to be fixed. Unaligned accesses are known to fail on hppa64/parisc64
> and on sh4, for example. If unaligned accesses are expected to be handled,
> it would probably make sense to add a separate test case, though, to clarify
> that the test fails due to alignment issues, not due to input parameters.

It's network driver dependent. Most network drivers receive packets
to the offset defined by NET_IP_ALIGN (which is normally 2) which
has the effect of "mis-aligning" the ethernet header, but aligning
the IP header.

Whether drivers do that is up to drivers (and their capabilities).
Some network drivers can not do this kind of alignment, so there are
cases where the received packets aren't offset by two bytes, leading
to the IP header being aligned to an odd 16-bit word rather than an
even 16-bit word (and thus 32-bit aligned.)

Then you have the possibility of other headers between the ethernet
and IP header - not only things like VLANs, but also possibly DSA
headers (for switches) and how big those are.

There's a lot to be researched here!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

