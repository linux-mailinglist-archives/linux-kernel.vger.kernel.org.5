Return-Path: <linux-kernel+bounces-159631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD7C8B3156
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD3D1C21ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75DD13C3DB;
	Fri, 26 Apr 2024 07:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Fo7c0pvU"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F0113BC18;
	Fri, 26 Apr 2024 07:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714116586; cv=none; b=TQfTsEWqeYQACFrvhOYZfpL9GwqOJBXFZQZGgzO6RplwDwC+zg/0eKgcwaJ4vSF4kl86xxyPFeoZNdQ+SCQ3siNIYXZ86iVLaDDsHizfFg6fFECkiccW/f9hxp85vF0XCiXmj4eEl8Ow6n2nyWHDDCgrSdkC6TYZASYB8WGwcjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714116586; c=relaxed/simple;
	bh=elD+9XGLAdnCSlM802POq0qCA5eLDtUU1xAs/bhJBLY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QDm608qcf9TrNarJ8BHzZf2GndxqY/un26ko4zIvC3Rb1BioNe0iGuRy0h2KqDB/yToIXD+3wFxYbZiKgJlw+kip6eVttgCMF9/i3xrBZoYO8kY7nZCd3GeXb3id6gF0RVe61Aaz18u9ieNEVtFyGrM621wSDJ/Kn5usw2+cU9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Fo7c0pvU; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CFFBBE000A;
	Fri, 26 Apr 2024 07:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714116575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vWfgP9DpxfeThuAahkC7EFje7Rmo/njf+PU7vtdfr4I=;
	b=Fo7c0pvUK5+Z0LuTvsKNkgCQXt6pPabRdLGioc1EvGbQI0cyPTtKWJAFd7l3nD8qcUor0h
	jWs3/NiPc6PSXY+cW/xvMEOV7V6OQadj+aRdc0vv2N2d8zi4DfrAQhRozCyFn67lCjE9kS
	kdmE5tzHcW6f34J61wzJxXN1pSONGXFsT9hkTa0X3rBo061dxU2X2A1k/Xy3xh2cZfvOxz
	pdmO/tfdC03AxJX0odiklMV/goMX/F2Ld/U5jWMLi61iNY8HsYFkznL2C2VzRMGKdhJUrg
	LntZCmkpL3AvUrh/6O3Q+Zilyhw3sa9OYNLqRwAUHb5rVbl+yDigRVbkungUDw==
Date: Fri, 26 Apr 2024 09:29:32 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net-next v3 0/3] net: pse-pd: Fixes for few small issues
Message-ID: <20240426092932.0e1a5e2b@kmaincent-XPS-13-7390>
In-Reply-To: <20240425101511.6a3a517c@kernel.org>
References: <20240423-fix_poe-v3-0-e50f32f5fa59@bootlin.com>
	<ZiebQLdu9dOh1v-T@nanopsycho>
	<20240425103110.33c02857@kmaincent-XPS-13-7390>
	<20240425070619.601d5e40@kernel.org>
	<20240425163002.5894c5e5@kmaincent-XPS-13-7390>
	<20240425074205.28677540@kernel.org>
	<20240425165708.62637485@kmaincent-XPS-13-7390>
	<20240425080724.15be46e9@kernel.org>
	<20240425190426.1a1a7d00@kmaincent-XPS-13-7390>
	<20240425101511.6a3a517c@kernel.org>
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

On Thu, 25 Apr 2024 10:15:11 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 25 Apr 2024 19:04:26 +0200 Kory Maincent wrote:
> > > That one was fine:
> > >=20
> > > https://patchwork.kernel.org/project/netdevbpf/cover/20240422-feature=
_ptp_netnext-v11-0-f14441f2a1d8@bootlin.com/
> > >=20
> > > Are you thinking it's the extra From in the cover letter?   =20
> >=20
> > Maybe or some patches between b4 version 0.13.0 and 0.14-dev. I will try
> > next time without my extra From b4 patch to test 0.14-dev. =20
>=20
> Another random thought is that some people put the name in quotes if
> it contains non-trivial chars, so may be worth trying with:
>=20
> From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>

Ok, I will try also with quotes.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

