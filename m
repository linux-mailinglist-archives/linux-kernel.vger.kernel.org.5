Return-Path: <linux-kernel+bounces-61314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8820E8510E7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB9B1C2228D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3346210EE;
	Mon, 12 Feb 2024 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="seS7Io0n"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E69182C7;
	Mon, 12 Feb 2024 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733897; cv=none; b=FLCEkE9AGSpZ9woFK2dISdMXKdJV8FWjGdX7lNNTdLBWjzsjbCZcsvCBA9RF1eSR8ns22r2ni5V/VXoHiJ+uyFR3sB3FXrML86+0HB5urJsJjFFGVfaRtrhieige6pqXkiiQKoxMZOhexW1ke86LcfsHd/zHk0BNnW4UNc2HXkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733897; c=relaxed/simple;
	bh=ZUr3j8LXsXZQWjcUq4Q+7Cm4KOboTaTOCh0CLeRg8kQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OUH+W7ejxDAAENsTxgxRU/kJvrb7PaEf4TpIAdp7kuya9JTzFrzx8rbQH+52YB4LMfdqyXW+sJsJj9jNS5tBkleKA0Gl0OaaxuXGjfjtQCENF3J4t0TW352KJQp1gJ26V6pm0XHhay4WpmDDX0ZfrQtXaHjBJDyTlR1NfzeIzo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=seS7Io0n; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=xAXBzZTraFRQ7cvwghHUqqv7zNWQZICWaeAHfCkxYcU=;
	t=1707733895; x=1708943495; b=seS7Io0ngdaM/b9JwMVvkW3NPRw6BO2qlnm8zIHMgSsnrcr
	fTR6XggweaS0lwSLY8LPbZ/qa/dpQrvxctgGJ+6Jssv1uJY4x1knohyppPKIjlJ0G1N6uLpx7Zv1C
	Hn5g3Cy83GQ03FHhFvYgT4E833xAOKvBE8qOdt3ravkHCjYrqUt971bT2e8dK22m4TOmIE9Loz1Mk
	a/ipoChzqUTenvSZFu4lGXzZJtNbeBeTP0XD2WSMLs5B04qRTsc1XHB08cU0S2XpNcoTrAFuJ8it+
	PS5WQTRAL8KFS0oZOdl3zRzcfn740FWX+V2TWari8a8wj1KBQoSAHh4Ayx/xNs9A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rZTay-00000005yIY-3uZo;
	Mon, 12 Feb 2024 11:31:29 +0100
Message-ID: <35d4ae8f4c5157e3d0da39295a5b15eced367ab6.camel@sipsolutions.net>
Subject: Re: [PATCH v1 6/9] iwlwifi: mvm: Set THERMAL_TRIP_WRITABLE_TEMP
 directly
From: Johannes Berg <johannes@sipsolutions.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Stanislaw Gruszka
	 <stanislaw.gruszka@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
 <linux-pm@vger.kernel.org>,  Miri Korenblit
 <miriam.rachel.korenblit@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>,  Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>,
 netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Petr Machata
 <petrm@nvidia.com>, linux-wireless@vger.kernel.org,  Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Manaf Meethalavalappu Pallikunhi
 <quic_manafm@quicinc.com>
Date: Mon, 12 Feb 2024 11:31:27 +0100
In-Reply-To: <CAJZ5v0gZ1tpNmdkvRLA6-ydnhKPKgsM_FCwrW+q1=5ZiD=vbWA@mail.gmail.com>
References: <3232442.5fSG56mABF@kreacher> <3757041.MHq7AAxBmi@kreacher>
	 <ZcY7jyyFJq1yfOCj@linux.intel.com>
	 <CAJZ5v0gZ1tpNmdkvRLA6-ydnhKPKgsM_FCwrW+q1=5ZiD=vbWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-02-09 at 17:15 +0100, Rafael J. Wysocki wrote:
> > >       for (i =3D 0 ; i < IWL_MAX_DTS_TRIPS; i++) {
> > >               mvm->tz_device.trips[i].temperature =3D THERMAL_TEMP_IN=
VALID;
> > >               mvm->tz_device.trips[i].type =3D THERMAL_TRIP_PASSIVE;
> > > +             mvm->tz_device.trips[i].type =3D THERMAL_TRIP_WRITABLE_=
TEMP;
> >=20
> >                 mvm->tz_device.trips[i].flags =3D THERMAL_TRIP_WRITABLE=
_TEMP;
> >=20
> > Consider using diffrent prefix for constants to diffrenciate flags and =
types.
>=20
> Well, I can use THERMAL_TRIP_FLAG_RW_TEMP or similar, but is it really
> so confusing?
>=20
> I'm wondering what others think.
>=20

I'd tend to agree with Stanislaw. I did (eventually) notice the double
assignment to .type above, but had that not been visible in the context,
or you'd have removed the first one by accident, I'd really not have
thought about it twice.

The bug also makes it look like you even confused yourself ;-)

So having a clearer indication that it's a flag would make sense, I'd
say.

johannes

