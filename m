Return-Path: <linux-kernel+bounces-68322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5108578B3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A0E28242F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF4D1B968;
	Fri, 16 Feb 2024 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="e+SWQT9L";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="P6hDkCEn"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666C51B950;
	Fri, 16 Feb 2024 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708075112; cv=none; b=Xqzvq2yjIV6B6ZUIMVieMsxF0YKnnByuE74zdmKUefh6w/Y+0HL5CMhfdK67Xi1+f/ysBlZYM+gnHO+1Xk0L1Ar1n6uxTEU6aWzIYNXCSd1tr7yoUuFr9HvN1hroBc0rEmxGtNbTFBR8E5Iy3KNElN+FoNKpu/x2JF2nEcBjdE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708075112; c=relaxed/simple;
	bh=j6FweoeTcGYtk9WGMeA/+EuzmaUpi5F2wLqCAXH4r4o=;
	h=Subject:Date:From:To:Cc:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrzyMmSjOIiAnBeICY8omqe7agV8nZFP2t0V5VTqe3dJc6dJJ6uWmi/ky4I4HiTusqF+KLsncWRDb6ka699LBNSmUDjDOHjGCF/2VtWyuND9EJ6gul2JS8WceTWsweYok5TIDpkB+FCGFEmNWtovCL7OTMbXe51WlL8xVWzYD4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=e+SWQT9L; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=P6hDkCEn reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1708075108; x=1739611108;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject;
  bh=9h5wDTixacUMLfnEkk4dJ+i0Fer99CHkegjhnU+Eq9E=;
  b=e+SWQT9LDfdoUs9cg808edU4KSmp90JrKKLCPsHVlqlJTA8fc8UQAacH
   4CdiyeIgm/aVaDjamKVxJ7OzmKbdPeIfERlcKXDXGSucBPxrQCfINI+ba
   mMximuaW8mVH0AbK3NuF6padaesQ9LsNLMXkP1iKimKzYIMqyg0MqfKIy
   g2fUoxARD1RZpWlBH87wli5UDR1BOkiUahHVQZIk+vvIqCdhLcxGecySV
   NGux5EAUbvKwX0yxvUXhG2Ta0PMBmgI49jgcw9dHx6h1IzhCTzLuBKmx8
   Jdn3oGuBT+pP9RVoB1UfLYJHOtsIzIeWEuH1nl1KGyfh3udouMNlH8LcY
   A==;
X-IronPort-AV: E=Sophos;i="6.06,164,1705359600"; 
   d="scan'208";a="35440875"
Subject: Re: Re: [PATCH v6 net-next 05/14] net: phy: marvell-88q2xxx: add driver for
 the Marvell 88Q2220 PHY
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 16 Feb 2024 10:18:25 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 603FA16EFFF;
	Fri, 16 Feb 2024 10:18:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1708075105;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9h5wDTixacUMLfnEkk4dJ+i0Fer99CHkegjhnU+Eq9E=;
	b=P6hDkCEnkOhtlRBcTxw+1CpOYBfdi9rhKbZVfMoqhCpzXL/Gpu8d7SYTyqoffIPLEXWKrr
	qWSv1SFDzvr0pXcHZ04ZGLL23ek3tkgapqmbun3nuMUOxnLPT70LieSM8FCI6zh6WyQv8G
	qX4VmGEW4AnharcxXls67DMYWfg/nbOkUKxDLxnEZtyu4W7kpjsYMhVGK6RrtcxDBJvZLQ
	XJeJ8EBWSOPizyLhwMYXST9fRe17ojqtag/mOZtYA9L6lsndjfiQZCm0Izc8j/oKaTtNvX
	lj+RWe6t57VDJV3nKb84G7pE74hX1LMftV9q5KRUGQZHFmlxWy7O5uGLsmI1xw==
Date: Fri, 16 Feb 2024 10:18:10 +0100
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-ID: <Zc8oUt4fnD7ltxq4@herburgerg-w2>
References: <20240213213955.178762-1-dima.fedrau@gmail.com>
 <20240213213955.178762-6-dima.fedrau@gmail.com>
 <Zcy9E4riyFRk8B1P@herburgerg-w2>
 <20240215202403.GA3103@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240215202403.GA3103@debian>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, Feb 15, 2024 at 09:24:03PM +0100, Dimitri Fedrau wrote:
> > Hi Dimitri,
> >
> Hi Gregor,
> 
> > On Tue, Feb 13, 2024 at 10:39:44PM +0100, Dimitri Fedrau wrote:
> > >  static struct phy_driver mv88q2xxx_driver[] = {
> > >  	{
> > >  		.phy_id			= MARVELL_PHY_ID_88Q2110,
> > > @@ -255,12 +439,26 @@ static struct phy_driver mv88q2xxx_driver[] = {
> > >  		.get_sqi		= mv88q2xxx_get_sqi,
> > >  		.get_sqi_max		= mv88q2xxx_get_sqi_max,
> > >  	},
> > > +	{
> > > +		PHY_ID_MATCH_EXACT(PHY_ID_88Q2220_REVB0),
> > 
> > I tested the series on a 88Q2220 REV B1 (which is id 0x002b0b22). The
> > driver works fine on this revision.
> > 
> > I understand that in the Marvell API the initialization for Rev B0 and
> > B1 differ. For B0 some additional init sequence is executed. I did not look
> > into the details of this sequence. However this patch seems to work on
> > Rev B1.
> >
> > Would you consider adding compatibility for Rev B1 and following? I
> > tested with:
> > 		.phy_id			= MARVELL_PHY_ID_88Q2220,
> > 		.phy_id_mask		= MARVELL_PHY_ID_MASK,
> >
> 
> thanks for testing. I would stick to the exact initialization sequence
> provided by the Marvell API. Registers and bits are mostly undocumented
> and I think it is safest this way. Besides that it should be relatively
> easy to add the support for rev. B1 by just adding the init sequence for
> it.

Ok. I will have an closer look at the marvell API and eventually come up
with a patch for Rev. B1.

There is also a Rev.B2 for which I cannot find any init sequence. But
Rev. B1 will no longer be produced so I need a solution for B2
eventually.

Best regards
Gregor

-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

