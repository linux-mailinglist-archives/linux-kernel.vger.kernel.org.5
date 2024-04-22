Return-Path: <linux-kernel+bounces-152780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBB38AC422
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC80D281E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4817A433D2;
	Mon, 22 Apr 2024 06:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="mZzzk5R+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="iqFMA+Aw"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C473FBA0;
	Mon, 22 Apr 2024 06:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713767065; cv=none; b=n4nQg62HDgczViR6GeLlrSa1I/OQfL6/0jWwZNL+21F05+pKS2aQRW3j+Yt/+ozCrRo8xJbK+wiLXVzCN3loAQ3VsbtnhjIRRhB5oksg1zBRYbedFv59FSceKfoXxuHzh8r/AWHXRMUR36nCLNPSZqUMAFdg6yHDzwlv9dGC4Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713767065; c=relaxed/simple;
	bh=rrOViBBJsojVDyanVvalso2iEQYg5szP2F0RIMK8g64=;
	h=Subject:Date:From:To:Cc:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+bATITUai9cYHquyzjzXFlJZXExHLBlc3bzROexZGEWNuOpp9dXvzHsMz1dFsPE9j5EMfLLu3FQXbAcQkJdDgdNS9SHDCz/mPzrDn3JVfL5bPOnpMBvwCOTeMCEq7uz+nt2KY9jCqpeD7OWCRWUxxL2tVscOHmi5X12a/W64xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=mZzzk5R+; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=iqFMA+Aw reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713767062; x=1745303062;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=r+XvQYzy6Ph8/Uv8nnwgb09heFwJUgvhjSISPDnv/24=;
  b=mZzzk5R+T+UbaTYYgGAWY7A8QQEqBxAW8RDH1Nin5rGndHTg1bHcZu67
   BmiHVbehyww7Sy5480Q3HNiUvm/AEggkvcdMqJHyqdBfzEx8DU6FQTqJk
   cfnjCXMz34dvFDVBIen8fXe/wKra1ERPS+ZMG9JZ1GDgiZjdfVbKTslTM
   NBDKTKIVIN2oeGX4262VmVCNapWF0zZsFjChESyIKcFSW/IBBGCD3wGnE
   gnCh7snRmo2S0ddAyUjltxWthvLrrq+uk/uzHX/11kBr3v3+p9U5/CE3f
   bA4hBLACVZx2x8r21+arxspl0ru+RmZ46GiT9vuhPupS0UTzytN9q9qsv
   A==;
X-IronPort-AV: E=Sophos;i="6.07,220,1708383600"; 
   d="scan'208";a="36531127"
Subject: Re: Re: [PATCH v2] net: phy: marvell-88q2xxx: add support for Rev B1 and B2
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 22 Apr 2024 08:24:19 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0F62160A90;
	Mon, 22 Apr 2024 08:24:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713767055;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=r+XvQYzy6Ph8/Uv8nnwgb09heFwJUgvhjSISPDnv/24=;
	b=iqFMA+AwRSrbb9lzGdRFygud48xPGcj+st02VmodWAKPX5ipz/4IPly6RraG3G70COcyNx
	GY+tSPx4BCQLxKaMKcEepWzIsKJq+jRC9z0OkfpnvYOkNKDdpen9uiYrn9hVdlj5r9Foou
	RqVjyeXhCLY5KoxvgD8bDsmvavka9sr5k2Z8dOaqvXFJLI3fxApH1QiyVT3EgJIv35Tryb
	dHJBDQibamNwSm2WYR4sAhcr97cmXhux0J2Hzm0Po9OdjiHtJewz/Oew50JErj7U4AMmub
	QtP1b3AEoHcWvc6Y7GOM9NFnvmv/OZmRSruDxByr8IWzhAHBM00077eBv36Z2A==
Date: Mon, 22 Apr 2024 08:24:07 +0200
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
	alexander.stein@ew.tq-group.com
Message-ID: <ZiYCh4MbI9kly1mh@herburgerg-w2>
References: <20240417-mv88q222x-revb1-b2-init-v2-1-7ef41f87722a@ew.tq-group.com>
 <20240418123155.GA248236@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418123155.GA248236@debian>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, Apr 18, 2024 at 02:31:55PM +0200, Dimitri Fedrau wrote:
> > +static const struct mmd_val mv88q222x_revb1_revb2_init_seq1[] = {
> > +	{ MDIO_MMD_PCS, 0xFE07, 0x125A },
> > +	{ MDIO_MMD_PCS, 0xFE09, 0x1288 },
> > +	{ MDIO_MMD_PCS, 0xFE08, 0x2588 },
> > +	{ MDIO_MMD_PCS, 0xFE72, 0x042C },
> > +	{ MDIO_MMD_PCS, 0xFFE4, 0x0071 },
> > +	{ MDIO_MMD_PCS, 0xFFE4, 0x0001 },
> > +	{ MDIO_MMD_PCS, 0xFE1B, 0x0048 },
> > +	{ MDIO_MMD_PMAPMD, 0x0000, 0x0000 },
> > +	{ MDIO_MMD_PCS, 0x0000, 0x0000 },
> > +	{ MDIO_MMD_PCS, 0xFFDB, 0xFC10 },
> > +	{ MDIO_MMD_PCS, 0xFE1B, 0x58 },
> > +	{ MDIO_MMD_PCS, 0xFCAD, 0x030C },
> > +	{ MDIO_MMD_PCS, 0x8032, 0x6001 },
> > +	{ MDIO_MMD_PCS, 0xFDFF, 0x05A5 },
> > +	{ MDIO_MMD_PCS, 0xFDEC, 0xDBAF },
> > +	{ MDIO_MMD_PCS, 0xFCAB, 0x1054 },
> > +	{ MDIO_MMD_PCS, 0xFCAC, 0x1483 },
> > +	{ MDIO_MMD_PCS, 0x8033, 0xC801 },
> > +	{ MDIO_MMD_AN, 0x8032, 0x2020 },
> > +	{ MDIO_MMD_AN, 0x8031, 0xA28 },
> > +	{ MDIO_MMD_AN, 0x8031, 0xC28 },
> > +	{ MDIO_MMD_PCS, 0xFBBA, 0x0CB2 },
> > +	{ MDIO_MMD_PCS, 0xFBBB, 0x0C4A },
> > +	{ MDIO_MMD_PCS, 0xFE5F, 0xE8 },
> > +	{ MDIO_MMD_PCS, 0xFE05, 0x755C },
> > +	{ MDIO_MMD_PCS, 0xFA20, 0x002A },
> > +	{ MDIO_MMD_PCS, 0xFE11, 0x1105 },
> > +};
> > +
> nit: use small letters for hex values.
> 

Ok, will update in next version.

> Hi Gregor,
> 
> tested it for rev. B0 and it works as expected.
> 
> Tested-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> 
> Best regards,
> Dimitri Fedrau

Hi Dimitri,

thanks for testing!

