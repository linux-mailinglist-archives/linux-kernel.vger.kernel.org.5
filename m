Return-Path: <linux-kernel+bounces-81325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 401D386743F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70F451C27D62
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237F55B66D;
	Mon, 26 Feb 2024 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IojTQrZd"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24775B663;
	Mon, 26 Feb 2024 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949043; cv=none; b=P5i7Q2Ag95nsyEGx/3NJTfKzL2RCuaaG7nCmIgFCpbv71NahFpVwn5ZdJYHNXBN5uWPM5VZD+hUWpXoo6laS4BbpUbsB73hE7EDt3g8SVsHwKizem9kP3QzPMv+cUXLdUczYeMMVE1Brx74xhswuG7C9McK/uIMJjMvN7nuyit8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949043; c=relaxed/simple;
	bh=bSIYi307UAifxZYKBFL5Z4FCz6CO5J9gTDCXhlKnU+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osguSYYaaQXDiYYuMoeqArE3LOmHG1347rAiblypQV2IT08pEMXhGJZ+oh7CD3bsm+fIaxlB7RiPsLFUBZLPRaFsDuRP5mPbIJTseNAWp5+hlmtDKdUnVWDlv9YRDUxqhCv0SAA4Dk86tQJwYKchrrDaxjUZW1x7FGAQab2B5hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IojTQrZd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=O7pmyULB7JZRz8A9oI6WLG3NRUVeGhF0b+0ptpd76Fs=; b=IojTQrZdEhZrWdsSrZKnx/vZRV
	VlpJkkFC9Dhu94mGJ6dM2h3W1X6jS012IEPNx0ZyOUN+WmivBv9se9HQqxdhcmaupG+rnB0k1KUDX
	axg2z/ZFFtH5G9HSBtQ46pW3QWVLTeFMeCph0AiGiCkuzm5QNCgcJBTLu2jXDuEUkwAfwT3pjiHPn
	+qVDZND4xtlwfUMnhIO4vKERiyhloEAQPm9kC0o029/AP0rZMjqs3/dJV+IBDw6i9rRjSWv9WkCAe
	ixyTdJAjXWfUPqkU5Gfu88cc0o96Lri3cC5oRu7yF2rpaZI3koypVqmS8CyMdwERP/DfOhCCk5419
	JuUGoIRQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39758)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1reZi1-0003F6-0X;
	Mon, 26 Feb 2024 12:03:49 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1reZhz-0006PU-MT; Mon, 26 Feb 2024 12:03:47 +0000
Date: Mon, 26 Feb 2024 12:03:47 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Charlie Jenkins <charlie@rivosinc.com>,
	Guenter Roeck <linux@roeck-us.net>,
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
Message-ID: <Zdx+I3V9ka3EbaHq@shell.armlinux.org.uk>
References: <20240223-fix_sparse_errors_checksum_tests-v10-1-b6a45914b7d8@rivosinc.com>
 <7ae930a7-3b10-4470-94ee-89cb650b3349@csgroup.eu>
 <Zdx6YMRdPmb595M2@shell.armlinux.org.uk>
 <96b3fcfd-6932-4987-9831-5abdad8d445c@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96b3fcfd-6932-4987-9831-5abdad8d445c@csgroup.eu>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 26, 2024 at 11:57:24AM +0000, Christophe Leroy wrote:
> 
> 
> Le 26/02/2024 à 12:47, Russell King (Oracle) a écrit :
> > On Mon, Feb 26, 2024 at 11:34:51AM +0000, Christophe Leroy wrote:
> >> Le 23/02/2024 à 23:11, Charlie Jenkins a écrit :
> >>> The test cases for ip_fast_csum and csum_ipv6_magic were not properly
> >>> aligning the IP header, which were causing failures on architectures
> >>> that do not support misaligned accesses like some ARM platforms. To
> >>> solve this, align the data along (14 + NET_IP_ALIGN) bytes which is the
> >>> standard alignment of an IP header and must be supported by the
> >>> architecture.
> >>
> >> I'm still wondering what we are really trying to fix here.
> >>
> >> All other tests are explicitely testing that it works with any alignment.
> >>
> >> Shouldn't ip_fast_csum() and csum_ipv6_magic() work for any alignment as
> >> well ? I would expect it, I see no comment in arm code which explicits
> >> that assumption around those functions.
> > 
> > No, these functions are explicitly *not* designed to be used with any
> > alignment. They are for 16-bit alignment only.
> > 
> > I'm not sure where the idea that "any alignment" has come from, but it's
> > never been the case AFAIK that we've supported that - or if we do now,
> > that's something which has crept in under the radar.
> > 
> 
> Ok, 16-bit is fine for me, then there is no need to require a (14 + 
> NET_IP_ALIGN) ie a 16-bytes (128-bit) alignment as this patch is doing.

Looking again at these two functions, I'm mistaken - this was written for
optimal use with 32-bit alignment, not 16-bit. However, the entire IP
layer is written with the assumption that for maximum performance, the IP
header will be 32-bit aligned.

However, that may not always be the case for incoming packets, and what
saves 32-bit Arm is the ability to do unaligned loads in later revisions
of the architecture, or the alignment fault handler (slow) on older
revisions.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

