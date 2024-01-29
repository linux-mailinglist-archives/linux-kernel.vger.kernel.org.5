Return-Path: <linux-kernel+bounces-43042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A193C840AAC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51AB1C22E31
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CB615530A;
	Mon, 29 Jan 2024 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="XzfQz4iq"
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C52154BF1;
	Mon, 29 Jan 2024 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706543920; cv=none; b=ErHYl8P8DGzXkZQLiCML/yRmDyx90owQPZ11pF7LyMAMrNU/v335uFfTK9H0r5eVY/21ig4wxCsTYkMlnTGhsCIjUB/iwVlflI/VKzOqpZU2faM/8tYMbVt/SpteCzjdsQIAFBmlMRdg6TchUnaAvzd4JQLUES48ZShY3hqYdcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706543920; c=relaxed/simple;
	bh=4PClhCK4gD/HIW8kuwqqrqaOpA7DCCJC/PVBgoJeB5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ddcKQXo02QbaBxYVuiG81D1oohj4e65LHDVbFLk8SiLMeX1WAd1+Gr52mCkNk278CyvZhaWiuFD9K2my+ATHlvF5hN2Kg5HI5ld+LAVyeeVtbBDFsN5FhPhYQj5IwzaKaGmei/WF41pMYvDLqQhY+myLqnB75lNgoTVrz3JTq10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=XzfQz4iq; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 626A46356CC0;
	Mon, 29 Jan 2024 16:58:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1706543907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4PClhCK4gD/HIW8kuwqqrqaOpA7DCCJC/PVBgoJeB5g=;
	b=XzfQz4iqgs8PEb3R1KXO0wbZwETm/gD243U09oWn/4/o9Vxc8H9SP5UIW+rXNZd91Nlira
	1eM9Ahho6PBBLgNhKHfHuvQcZBJVorLreFYhOm5LOfP9UV+GxwztZGJ1fEOzOMlNzvuQEO
	Npm2COz6EzrS1Z7RedzNJJayHtT+YY0=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org,
 Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
 Bastien Nocera <hadess@hadess.net>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: Flood of logitech-hidpp-device messages in v6.7
Date: Mon, 29 Jan 2024 16:58:12 +0100
Message-ID: <12371430.O9o76ZdvQC@natalenko.name>
In-Reply-To: <824573bb-ae01-41b9-8f97-a760ae8f3f18@redhat.com>
References:
 <3277085.44csPzL39Z@natalenko.name>
 <824573bb-ae01-41b9-8f97-a760ae8f3f18@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5751109.DvuYhMxLoT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart5751109.DvuYhMxLoT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: Re: Flood of logitech-hidpp-device messages in v6.7
Date: Mon, 29 Jan 2024 16:58:12 +0100
Message-ID: <12371430.O9o76ZdvQC@natalenko.name>
In-Reply-To: <824573bb-ae01-41b9-8f97-a760ae8f3f18@redhat.com>
MIME-Version: 1.0

Hello.

On =FAter=FD 9. ledna 2024 12:58:10 CET Hans de Goede wrote:
> Hi Oleksandr,
>=20
> On 1/9/24 12:45, Oleksandr Natalenko wrote:
> > Hello Hans et al.
> >=20
> > Starting from v6.7 release I get the following messages repeating in `d=
mesg` regularly:
> >=20
> > ```
> > Jan 09 10:05:06 spock kernel: logitech-hidpp-device 0003:046D:4051.0006=
: Disconnected
> > Jan 09 10:07:15 spock kernel: logitech-hidpp-device 0003:046D:408A.0005=
: Disconnected
> > Jan 09 10:16:51 spock kernel: logitech-hidpp-device 0003:046D:4051.0006=
: HID++ 4.5 device connected.
> > Jan 09 10:16:55 spock kernel: logitech-hidpp-device 0003:046D:408A.0005=
: HID++ 4.5 device connected.
> > Jan 09 10:16:55 spock kernel: logitech-hidpp-device 0003:046D:408A.0005=
: HID++ 4.5 device connected.
> > Jan 09 10:36:31 spock kernel: logitech-hidpp-device 0003:046D:4051.0006=
: Disconnected
> > Jan 09 10:37:07 spock kernel: logitech-hidpp-device 0003:046D:4051.0006=
: HID++ 4.5 device connected.
> > Jan 09 10:46:21 spock kernel: logitech-hidpp-device 0003:046D:4051.0006=
: Disconnected
> > Jan 09 10:48:23 spock kernel: logitech-hidpp-device 0003:046D:408A.0005=
: Disconnected
> > Jan 09 11:12:27 spock kernel: logitech-hidpp-device 0003:046D:4051.0006=
: HID++ 4.5 device connected.
> > Jan 09 11:12:47 spock kernel: logitech-hidpp-device 0003:046D:408A.0005=
: HID++ 4.5 device connected.
> > Jan 09 11:12:47 spock kernel: logitech-hidpp-device 0003:046D:408A.0005=
: HID++ 4.5 device connected.
> > Jan 09 11:38:32 spock kernel: logitech-hidpp-device 0003:046D:4051.0006=
: Disconnected
> > Jan 09 11:43:32 spock kernel: logitech-hidpp-device 0003:046D:408A.0005=
: Disconnected
> > Jan 09 11:45:10 spock kernel: logitech-hidpp-device 0003:046D:4051.0006=
: HID++ 4.5 device connected.
> > Jan 09 11:45:11 spock kernel: logitech-hidpp-device 0003:046D:408A.0005=
: HID++ 4.5 device connected.
> > Jan 09 11:45:11 spock kernel: logitech-hidpp-device 0003:046D:408A.0005=
: HID++ 4.5 device connected.
> > Jan 09 12:31:48 spock kernel: logitech-hidpp-device 0003:046D:4051.0006=
: Disconnected
> > Jan 09 12:33:21 spock kernel: logitech-hidpp-device 0003:046D:4051.0006=
: HID++ 4.5 device connected.
> > ```
> >=20
> > I've got the following hardware:
> >=20
> > * Bus 006 Device 004: ID 046d:c52b Logitech, Inc. Unifying Receiver
> > * Logitech MX Keys
> > * Logitech M510v2
> >=20
> > With v6.6 I do not get those messages.
> >=20
> > I think this is related to 680ee411a98e ("HID: logitech-hidpp: Fix conn=
ect event race").
> >=20
> > My speculation is that some of the devices enter powersaving state afte=
r being idle for some time (5 mins?), and then wake up and reconnect once I=
 touch either keyboard or mouse. I should highlight that everything works j=
ust fine, it is the flood of messages that worries me.
> >=20
> > Is it expected?
>=20
> Yes this is expected, looking at your logs I see about 10 messages per
> hour which IMHO is not that bad.
>=20
> I guess we could change things to track we have logged the connect
> message once and if yes then log future connect messages (and all
> disconnect messages) at debug level.

How granular such a tracking should be? Per-`struct hidpp_device`?

Should there be something like `hid_info_once_then_dbg()` macro, or open-co=
de it in each place instead?

Thanks.

> Jiri, Benjamin, do you have any opinion on this ?
>=20
> Regards,
>=20
> Hans
>=20
>=20
>=20
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart5751109.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmW3yxQACgkQil/iNcg8
M0t1SRAAgt55kvScXbRofCukdWh8aHqoe1t2F9BSC35Eqrp9h30h9Z25VDvrSWpC
KkYn1UOwSMxwVpigahOJ3DKfE1DK4RuWAeu8oeUrG4ixdbXsWJ0/YxGoJQojgMcv
JMmcE0rNooEGgCfdDYXJsEJk0Nu9icHlpzUDuKYH3kJt8Z7uJPkULKw1ywYFiE9l
ySny5dR41hN6owfVSJr9wdcJoVGOS0PbLDH1IhNAftonCi9tbcTvxZVjiu8OyH4a
2xsgGoqoYh+RS9X8leXatO4NVXeWpW78lqKYveFLAMLpF0J6Uajj9jIourFk0kuy
PtL1AGuwep8cYkjED5bvUlKJztdd2w7itEcSPDRFRnKux/SJJyPcrGhVWxu9fhd8
qWOYvFl7vbb/nFWp5Xbyirso38eGerev+S3jrZGMaMNEK6Kn7uo3PUTew0atoXbv
1oX4B2vkzV4qONnZ5ROLvFxEA5WrWstbSlWX4etvQL0w+JkByW4QGHziUYGI4TRF
mElZqRiUxx0TLPr8gAOFTf8KDgqrDM3IUbEqBc7gaKpXtN2Gt8eqN53lxSnz7812
7Wq3FgP9Mz0E+N00GpRHXygwcmmJsDEmWRpkDxSlA322cUCeMTCyXtxz8FtYyWlp
qSj0tS1YxuKQll/vmkmMEDSJ+C0JBgVWcKkLEjsaflgzhhH3loo=
=mgIn
-----END PGP SIGNATURE-----

--nextPart5751109.DvuYhMxLoT--




