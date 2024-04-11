Return-Path: <linux-kernel+bounces-139808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8168A07F3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063791F22FEF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECC113CA89;
	Thu, 11 Apr 2024 05:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="tRS0lQdX"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A88B13C806;
	Thu, 11 Apr 2024 05:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712815188; cv=none; b=SlM8KwVWWULp9OvlI45vE5O6Xt8hmc6AD+VsUse6b9mhpAiWQDUiq0KOaIZIOsSgiGQKNg7oBz8Bhm38XDRP0JM5q47TRCMBMkStpo6xqxNhRFTB+m0Bo8iRoSHH5v9DXDW+VS7nh0pOj9+3fJUNaHg0g5dWdNWU1eYZhriaaNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712815188; c=relaxed/simple;
	bh=swbeK4DJ7LPs/mIk5Mf0PwIYPP6cgE8DuNRWYr0mNIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XD/Brhfa5iNtoefklza5bKAbDk6EwWyOa87ji4iWgXOgOFUabgt3uQVQd6iLQy6pMF3aNBtgxIuW//p7jS2H7ytwkz9DhtUe5Q4OTRFxrp5tc7V+0IHp7XKrltXU99JlIrABlBnEY+juAVpihkVrbB4KRtJa2/fo4F0nV8ac4I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=tRS0lQdX; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 12134603E6;
	Thu, 11 Apr 2024 05:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1712815185;
	bh=swbeK4DJ7LPs/mIk5Mf0PwIYPP6cgE8DuNRWYr0mNIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tRS0lQdXk51Ymbj/ChyZPXFbjmyrzT7nS71JsdRPKSqF7w4ZR1ExXrV9DwA8e6Cck
	 g0+/AK2b6MiKztsZaD0NLKq72uNB5SJKDYlIGD5A15641XYBWQdRO30KuK6/oAPtKV
	 DGrDBziI5A/nJM0Tf6UmfeQe0uAtGFePp3/yy9mgnIpnjGmtlU2A1CWIwMC5IrPGdR
	 zxeJ3nd6D64hPJchajC/eaL/O2pfzBNf9/OXCgtqBD0tekc8TYwK1CTv5puUQox+bs
	 yquhwyQH79cbIjdFUC/cxdiNHJ4YyW/SSo1OHheK/DT1JgeV5N8xtopbllj+d7X7AS
	 5hp+T7swM1FCg==
Date: Thu, 11 Apr 2024 08:59:33 +0300
From: Tony Lindgren <tony@atomide.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Greg KH <greg@kroah.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the tty tree
Message-ID: <20240411055933.GD5156@atomide.com>
References: <20240411154844.5bbcde63@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240411154844.5bbcde63@canb.auug.org.au>

* Stephen Rothwell <sfr@canb.auug.org.au> [240411 05:48]:
> Hi all,
>=20
> After merging the tty tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
>=20
> ERROR: modpost: "serial_base_add_isa_preferred_console" [drivers/tty/seri=
al/8250/8250.ko] undefined!
>=20
> Caused by commit
>=20
>   a8b04cfe7dad ("serial: 8250: Add preferred console in serial8250_isa_in=
it_ports()")
>=20
> I have used the tty tree from next-20240410 for today.

OK thanks, I'll take a look and send a fix.

Regards,

Tony


