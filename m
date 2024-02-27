Return-Path: <linux-kernel+bounces-83035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4227868D95
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61BEF287449
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDB21384BA;
	Tue, 27 Feb 2024 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nJOIxtZ5"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9837E1386C7;
	Tue, 27 Feb 2024 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709029743; cv=none; b=hFjLIb00hpu/FR5eVPCvhMSqSjmBALpArWttLPVhI/cosj3VpODeoBswQ5rgeo6gbP8xGcCzJIu45WTHCLwL+u/9QPTXBP295Kp9hAU6iuA/qFKcywbza030tPzmBhsTNZ86fkI+fFgpDumCd2AQm9352Wk0IMagyLe6XPHxF6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709029743; c=relaxed/simple;
	bh=2nSH7ifbYm3tqDkxI8g0ViATvBk6HRIg3r24rsscvwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLHJjBiIYM5JCY0QxQpOhTz3dSUm30/rhSSuz0G2lizuM8sw31beIq6WCX0a4e46KSCe0uo2ZrUdUVdy1qgGSidXePOEEK/qQ5RX+MdhEP6UGdn4UCC6HqWIp1yGkcxLJWQtftc7dsmIoulY8NqfWZTEGoCca1c663pDUP9Q00k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nJOIxtZ5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AaMsMZWiwvSaJp1atd6FKd0pROFWF3fPGtmIY0iqYYs=; b=nJOIxtZ52FqIAVUFl2d7cP0vTC
	F1ANU0h5omGFVqaHz+i1HZQ/9eCovQVlWBEKYvHWcTgj/WlJK5s9ngZ2ESModv77AqFeEFgfOYNhM
	WuunX11xsvZ1EFu00Byzj9MB2hE2+TuhPu6d9p6pJcC4XIZ7tcmnEOZdLNgYiubkOCbQxMEt1a2wR
	l5lRgW/fVcaLTA6xaKpEElQO/kDQrISXdGzbUm3M4GGs3itlVmricP/bMq29RcArGak8WDOnK3xyi
	7KK4fDE0xQatqYO1vGATvNtgxUAr8Wj3DEWWPkYSbrodbniRmVPfY0Kap03XGhONynL7yldslsE1S
	lXYyXE9w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55912)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1reuhc-0007lc-2j;
	Tue, 27 Feb 2024 10:28:48 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1reuhZ-0007JB-VJ; Tue, 27 Feb 2024 10:28:46 +0000
Date: Tue, 27 Feb 2024 10:28:45 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Guenter Roeck <linux@roeck-us.net>,
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
Message-ID: <Zd25XWTkDPuIjpF8@shell.armlinux.org.uk>
References: <20240223-fix_sparse_errors_checksum_tests-v10-1-b6a45914b7d8@rivosinc.com>
 <7ae930a7-3b10-4470-94ee-89cb650b3349@csgroup.eu>
 <e11fea7a-e99e-4539-a489-0aa145ee65f0@roeck-us.net>
 <ZdzPgSCTntY7JD5i@shell.armlinux.org.uk>
 <ZdzZ5tk459bgUrgz@ghost>
 <ZdzhRntTHApp0doV@shell.armlinux.org.uk>
 <b13b8847977d4cfa99b6a0c9a0fcbbcf@AcuMS.aculab.com>
 <Zd0b8SDT8hrG/0yW@ghost>
 <cdd09f7a-83b2-41ba-a32c-9886dd79c43e@roeck-us.net>
 <9b4ce664-3ddb-4789-9d5d-8824f9089c48@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b4ce664-3ddb-4789-9d5d-8824f9089c48@csgroup.eu>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 27, 2024 at 06:47:38AM +0000, Christophe Leroy wrote:
> 
> 
> Le 27/02/2024 à 00:48, Guenter Roeck a écrit :
> > On 2/26/24 15:17, Charlie Jenkins wrote:
> >> On Mon, Feb 26, 2024 at 10:33:56PM +0000, David Laight wrote:
> >>> ...
> >>>> I think you misunderstand. "NET_IP_ALIGN offset is what the kernel
> >>>> defines to be supported" is a gross misinterpretation. It is not
> >>>> "defined to be supported" at all. It is the _preferred_ alignment
> >>>> nothing more, nothing less.
> >>
> >> This distinction is arbitrary in practice, but I am open to being proven
> >> wrong if you have data to back up this statement. If the driver chooses
> >> to not follow this, then the driver might not work. ARM defines the
> >> NET_IP_ALIGN to be 2 to pad out the header to be on the supported
> >> alignment. If the driver chooses to pad with one byte instead of 2
> >> bytes, the driver may fail to work as the CPU may stall after the
> >> misaligned access.
> >>
> >>>
> >>> I'm sure I've seen code that would realign IP headers to a 4 byte
> >>> boundary before processing them - but that might not have been in
> >>> Linux.
> >>>
> >>> I'm also sure there are cpu which will fault double length misaligned
> >>> memory transfers - which might be used to marginally speed up code.
> >>> Assuming more than 4 byte alignment for the IP header is likely
> >>> 'wishful thinking'.
> >>>
> >>> There is plenty of ethernet hardware that can only write frames
> >>> to even boundaries and plenty of cpu that fault misaligned accesses.
> >>> There are even cases of both on the same silicon die.
> >>>
> >>> You also pretty much never want a fault handler to fixup misaligned
> >>> ethernet frames (or really anything else for that matter).
> >>> It is always going to be better to check in the code itself.
> >>>
> >>> x86 has just made people 'sloppy' :-)
> >>>
> >>>     David
> >>>
> >>> -
> >>> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, 
> >>> MK1 1PT, UK
> >>> Registration No: 1397386 (Wales)
> >>>
> >>
> >> If somebody has a solution they deem to be better, I am happy to change
> >> this test case. Otherwise, I would appreciate a maintainer resolving
> >> this discussion and apply this fix.
> >>
> > Agreed.
> > 
> > I do have a couple of patches which add explicit unaligned tests as well as
> > corner case tests (which are intended to trigger as many carry overflows
> > as possible). Once I get those working reliably, I'll be happy to submit
> > them as additional tests.
> > 
> 
> The functions definitely have to work at least with and without VLAN, 
> which means the alignment cannot be greater than 4 bytes. That's also 
> the outcome of the discussion.

Thanks for completely ignoring what I've said. No. The alignment ends up
being commonly 2 bytes.

As I've said several times, network drivers do _not_ have to respect
NET_IP_ALIGN. There are 32-bit ARM drivers which have a DMA engine in
them which can only DMA to a 32-bit aligned address. This means that
the start of the ethernet header is placed at a 32-bit aligned address
making the IP header misaligned to 32-bit.

I don't see what is so difficult to understand about this... but it
seems that my comments on this are being ignored time and time again,
and I can only think that those who are ignoring my comments have
some alterior motive here.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

