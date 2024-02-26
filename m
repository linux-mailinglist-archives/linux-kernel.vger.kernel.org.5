Return-Path: <linux-kernel+bounces-81305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDAF8673D0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE6051C25F91
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908942557E;
	Mon, 26 Feb 2024 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="brVvD7gL"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF99208B8;
	Mon, 26 Feb 2024 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948093; cv=none; b=jN9L0K7q2aYnUhQzxLpizwfkCmi3uBEAJx4oEPYeJOU/Jq+Qdr26Ze9TJAI8T1UCWX59g2S4+PyS7y5RHFMLpq3rElOfkuvjvCaHvZD8gxtOXf7reMsmZXbRs7Kq+jTwai/YP3q4BVTz7qiRpBrkqYw/Z5KbRMoNqFD36CRgIU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948093; c=relaxed/simple;
	bh=kFr3B/ULY+gMSkUP5N9M2ZZcd1AQsK+54aUGpEWndtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0DF4TDdijSanv8RUV8VEmMUHP69jvxdwiANPSffQhnYPZiL7JFuoCqpxlQIOkwKvX6Eh7qt6RRFXHB2xsUsGP/I5d7moJiJGvOTat4r+nQ5+TcUfw900WXd2usuds3XRjZoSN1t9UfdK0W/VoiEVgMrlzVed2n1+dUlzQhF7pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=brVvD7gL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Gw1YcQC9qtJ4/pe66V7YRq+GAf4l9U7OKSN0ldpLYSY=; b=brVvD7gLhZJfWAo8PU5vLdHgiY
	kdXs2ki0PBjRk/pm7+3gkSDljK1QxtoBZeyd8T+RUXMw9AUUjEuYYJ+vLcSnbqtqk74jX6Xc4GE3x
	XFX1+7DuIl4b7pTlP9DUxZvqxsMdrQ6/aAo5Yt5IyYF5DP+s36IinJu0HbOsg07TqnyCxHHgwX2Ky
	HnGs5GLG8BPOhvHM94GvuLxrxxNGy3WuXv4ekVOpOZC/OrkT3kvOMssX3fh+QLX6ieE1pn1MQDhnL
	JOis2meDoCyogwRu1Se4ystHBJPtbfLHPaoNB72w9rN9zygg7PMxSGBtjvAT3xrFex7WMTbppgRgj
	yjfwBftQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56924)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1reZSY-0003A6-2J;
	Mon, 26 Feb 2024 11:47:50 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1reZSS-0006P5-Tm; Mon, 26 Feb 2024 11:47:44 +0000
Date: Mon, 26 Feb 2024 11:47:44 +0000
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
Message-ID: <Zdx6YMRdPmb595M2@shell.armlinux.org.uk>
References: <20240223-fix_sparse_errors_checksum_tests-v10-1-b6a45914b7d8@rivosinc.com>
 <7ae930a7-3b10-4470-94ee-89cb650b3349@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ae930a7-3b10-4470-94ee-89cb650b3349@csgroup.eu>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 26, 2024 at 11:34:51AM +0000, Christophe Leroy wrote:
> Le 23/02/2024 à 23:11, Charlie Jenkins a écrit :
> > The test cases for ip_fast_csum and csum_ipv6_magic were not properly
> > aligning the IP header, which were causing failures on architectures
> > that do not support misaligned accesses like some ARM platforms. To
> > solve this, align the data along (14 + NET_IP_ALIGN) bytes which is the
> > standard alignment of an IP header and must be supported by the
> > architecture.
> 
> I'm still wondering what we are really trying to fix here.
> 
> All other tests are explicitely testing that it works with any alignment.
> 
> Shouldn't ip_fast_csum() and csum_ipv6_magic() work for any alignment as 
> well ? I would expect it, I see no comment in arm code which explicits 
> that assumption around those functions.

No, these functions are explicitly *not* designed to be used with any
alignment. They are for 16-bit alignment only.

I'm not sure where the idea that "any alignment" has come from, but it's
never been the case AFAIK that we've supported that - or if we do now,
that's something which has crept in under the radar.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

