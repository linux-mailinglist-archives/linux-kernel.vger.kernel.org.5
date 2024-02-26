Return-Path: <linux-kernel+bounces-82200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A178680E2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFDC4B2B219
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400EA12F365;
	Mon, 26 Feb 2024 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MOK4PN3O"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AE112F5A1;
	Mon, 26 Feb 2024 19:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974424; cv=none; b=fk3Yx+mxwmChLFVvFNrJOGzgfuQJve/jOSNU+vFTfUH8YLpFMP8EAFn429lx6pjLw326BnLGkgbiRfFHBMjjIIOAZwlP68oQ+5BhvfsVBjm9ykSBMkf8+Ksgk5M2si/ue28739QhjNcWqa3c7DOqrJoNdIJBy6UNk8fMvVNy0J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974424; c=relaxed/simple;
	bh=dME12RiHWkWvlr/Yymi7aKCtbspaBLR+cUleBOIT3Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVf/QRAE3J+BIhbUxe3HIdQ4gP+KLDWIj3ZCq0JTSNI5cvoE18duFi2BYl5SyVrlxP+WA5KgTQmXYx158GHNR+sU5An0WqP/59w3ZMCaOuUv5XP4139ZoDscFIWYGRMvku0GUIlT7v08ECuLKCOvu07GlT4eijUPXwTdgJalk0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MOK4PN3O; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=p9KjOlu0+TEJffXffYs7C37fc+zygG+gBQDwUHyWubM=; b=MOK4PN3Og8rk6JU6g/g8QfsZhX
	mALDPkPGKkCfHWrsMRhTPcRVXeI+jhwqbEbrajU8tBCo1QmNgg4/jTfWwR8wjcFvDFUNNSEIaleJt
	uLiKY21HevkbnEgWwEQ+Kb4na7jJjlsNq5lcqNguwVVSmFRf618UvykUgUcxcGOnHfmQNRomPhIjB
	BCqP6A3BQEyebPbZG/NKGATVluIzPC9px/m/Y7O1reqVIzSnP5E7WgZ1D1cg6rIJp0/MOrDevKgXv
	uDcUt/n1GpuYVldBbIbJ8juegUuJVgoqRCAGAQPQwefpH/GZvxo8sYARgf35T+dFNxlpsR9RUv8gy
	nP4T7rRQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37538)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1regJO-0004mT-08;
	Mon, 26 Feb 2024 19:06:50 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1regJK-0006fG-SC; Mon, 26 Feb 2024 19:06:46 +0000
Date: Mon, 26 Feb 2024 19:06:46 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
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
Message-ID: <ZdzhRntTHApp0doV@shell.armlinux.org.uk>
References: <20240223-fix_sparse_errors_checksum_tests-v10-1-b6a45914b7d8@rivosinc.com>
 <7ae930a7-3b10-4470-94ee-89cb650b3349@csgroup.eu>
 <e11fea7a-e99e-4539-a489-0aa145ee65f0@roeck-us.net>
 <ZdzPgSCTntY7JD5i@shell.armlinux.org.uk>
 <ZdzZ5tk459bgUrgz@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZdzZ5tk459bgUrgz@ghost>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 26, 2024 at 10:35:18AM -0800, Charlie Jenkins wrote:
> On Mon, Feb 26, 2024 at 05:50:57PM +0000, Russell King (Oracle) wrote:
> > On Mon, Feb 26, 2024 at 08:44:29AM -0800, Guenter Roeck wrote:
> > > On 2/26/24 03:34, Christophe Leroy wrote:
> > > > 
> > > > 
> > > > Le 23/02/2024 à 23:11, Charlie Jenkins a écrit :
> > > > > The test cases for ip_fast_csum and csum_ipv6_magic were not properly
> > > > > aligning the IP header, which were causing failures on architectures
> > > > > that do not support misaligned accesses like some ARM platforms. To
> > > > > solve this, align the data along (14 + NET_IP_ALIGN) bytes which is the
> > > > > standard alignment of an IP header and must be supported by the
> > > > > architecture.
> > > > 
> > > > I'm still wondering what we are really trying to fix here.
> > > > 
> > > > All other tests are explicitely testing that it works with any alignment.
> > > > 
> > > > Shouldn't ip_fast_csum() and csum_ipv6_magic() work for any alignment as
> > > > well ? I would expect it, I see no comment in arm code which explicits
> > > > that assumption around those functions.
> > > > 
> > > > Isn't the problem only the following line, because csum_offset is
> > > > unaligned ?
> > > > 
> > > > csum = *(__wsum *)(random_buf + i + csum_offset);
> > > > 
> > > > Otherwise, if there really is an alignment issue for the IPv6 source or
> > > > destination address, isn't it enough to perform a 32 bits alignment ?
> > > > 
> > > 
> > > It isn't just arm.
> > > 
> > > Question should be what alignments the functions are supposed to be able
> > > to handle, not what they are optimized for. If byte and/or half word alignments
> > > are expected to be supported, there is still architecture code which would
> > > have to be fixed. Unaligned accesses are known to fail on hppa64/parisc64
> > > and on sh4, for example. If unaligned accesses are expected to be handled,
> > > it would probably make sense to add a separate test case, though, to clarify
> > > that the test fails due to alignment issues, not due to input parameters.
> > 
> > It's network driver dependent. Most network drivers receive packets
> > to the offset defined by NET_IP_ALIGN (which is normally 2) which
> > has the effect of "mis-aligning" the ethernet header, but aligning
> > the IP header.
> > 
> > Whether drivers do that is up to drivers (and their capabilities).
> > Some network drivers can not do this kind of alignment, so there are
> > cases where the received packets aren't offset by two bytes, leading
> > to the IP header being aligned to an odd 16-bit word rather than an
> > even 16-bit word (and thus 32-bit aligned.)
> > 
> > Then you have the possibility of other headers between the ethernet
> > and IP header - not only things like VLANs, but also possibly DSA
> > headers (for switches) and how big those are.
> 
> Those additional combinations can be supported by future test cases,
> but the goal of this patch was simply to have basic testing for these
> functions. The NET_IP_ALIGN offset is what the kernel defines to be
> supported, so that is the test case I went for.

I think you misunderstand. "NET_IP_ALIGN offset is what the kernel
defines to be supported" is a gross misinterpretation. It is not
"defined to be supported" at all. It is the _preferred_ alignment
nothing more, nothing less.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

