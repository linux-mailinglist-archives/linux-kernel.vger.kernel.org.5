Return-Path: <linux-kernel+bounces-158936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3A28B271D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B467282D3E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FEA14E2E8;
	Thu, 25 Apr 2024 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iaogSHYY"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7271714D712;
	Thu, 25 Apr 2024 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064679; cv=none; b=fiT7xHASpDD0bghFXtdoR8waT8pWatoVmcReg+d24C2CUey/GWp/hZHJcNGxbLWhdsL++G/+CeJ41NlUNkl0HT0APup82VULl8kYXlCkt9iqVXbfQvLEEulH8imKEOlk+CoIQ6+WOd4ZMCgRjBKPCWQx8zsElbHHk/lvQM8Q9Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064679; c=relaxed/simple;
	bh=vPXk3W1Em0sP8/1n+sKu/+dLayvvS+PDY4YXTTNNSHE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LEBJmu6LJkI8ir2C4vwxXamLZSAX4GSJ+R2T3bFgSC70s9Ka2GIGtZ/gcEHyVmpRUFkWIQ1CUEh+ea++Fya8c9bj/u1JZMXhJAInqapnufzuYxLQgfnNnZcnB92NloP6k/8aYy0eAbfrQNiY/CTDsKavf/kVvt4bvyGheR9UJOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iaogSHYY; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F150BC0005;
	Thu, 25 Apr 2024 17:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714064669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+rqqSNOdhxenQbnUnZbxFCKBwQAMB5VEN1MZNUx2MRk=;
	b=iaogSHYY8bx1pnh1lNzFru2hIG6E1IDKtRgHUbNckd5xW3VFVgKqyB0hkXU2tUKEPS4CtL
	QqGE8edFTCHaNUnM2rCx1Nit/bZY2RxXOeP9LSz7tYdYrohg6/g3SuqGn6hXfhUcsPGqp9
	clUHJiGDVTNI/TElxar1v1NhHQB8H1AmCyCIJobSVq7CXnBm5QAG83sK/9ZQfXuf9i8eCS
	7geSDrkH4tNoDqaqx86cn7rRoB9rB12nqIPZezFjaYEWI2b9cdi6ZG96YhSTi85huBWMG0
	I/L9GGcvIQHNbt8DSFToYMH8Ih0TQtdMPeQoLHBC8xt9yrFBsY0QeuwBeen1uw==
Date: Thu, 25 Apr 2024 19:04:26 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net-next v3 0/3] net: pse-pd: Fixes for few small issues
Message-ID: <20240425190426.1a1a7d00@kmaincent-XPS-13-7390>
In-Reply-To: <20240425080724.15be46e9@kernel.org>
References: <20240423-fix_poe-v3-0-e50f32f5fa59@bootlin.com>
	<ZiebQLdu9dOh1v-T@nanopsycho>
	<20240425103110.33c02857@kmaincent-XPS-13-7390>
	<20240425070619.601d5e40@kernel.org>
	<20240425163002.5894c5e5@kmaincent-XPS-13-7390>
	<20240425074205.28677540@kernel.org>
	<20240425165708.62637485@kmaincent-XPS-13-7390>
	<20240425080724.15be46e9@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 25 Apr 2024 08:07:24 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 25 Apr 2024 16:57:08 +0200 Kory Maincent wrote:
> > On Thu, 25 Apr 2024 07:42:05 -0700 =20
> > > > Do you want me to like post a v5 with the "pw-bot: cr" tag? But if I
> > > > put the tag only on the cover letter it won't work then.
> > > > Maybe on all patches?     =20
> > >=20
> > > Probably not worth posting for a test. I'll try to be more careful wh=
en
> > > applying in the future, we can experiment with real postings.
> > >    =20
> > > > Was it the same for the PoE support patch series?     =20
> > >=20
> > > Yeah, I had to apply that one manually.   =20
> >=20
> > Does this patch series is on the same state?
> > https://lore.kernel.org/netdev/20240422-feature_ptp_netnext-v11-0-f1444=
1f2a1d8@bootlin.com/
> > =20
>=20
> That one was fine:
>=20
> https://patchwork.kernel.org/project/netdevbpf/cover/20240422-feature_ptp=
_netnext-v11-0-f14441f2a1d8@bootlin.com/
>=20
> Are you thinking it's the extra From in the cover letter?

Maybe or some patches between b4 version 0.13.0 and 0.14-dev. I will try
next time without my extra From b4 patch to test 0.14-dev.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

