Return-Path: <linux-kernel+bounces-43067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8D4840B2B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3DF728A28E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AB1156964;
	Mon, 29 Jan 2024 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="QWV44F2R"
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FD2156960;
	Mon, 29 Jan 2024 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545210; cv=none; b=uLP3fq1KNzhD9hYitej8lmVYN2jeziwHYRPlR4X9ktzIGl1PhKRA2uDE9dfZcDFOJfr3f6Fx4Nganh9WztJyoPGsdg+9wCpJYBqBW2+z/wbnhetm7g5mV/NI+0AY8YowMpdxMGHZdDzEcf1+vRjl7k7UEGKgLMZYPgBMCeXxYco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545210; c=relaxed/simple;
	bh=tCQNh03kPb0hVD3381TosARGcFot6I3fIlnNAcTeoT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xh9KfhLDJ3o1eVU/z0vXcXLBJPb9hTdBm2X0hAH4XazEqytrlvYI6vdZ+0i28hGUQISngzUYnamMBPzw7rzcsBO5d5nhSBfC5bLwtLP0I74bcXsuFXGXSemLl1gPtY/UBNffJxGg68ba0zn7X8ezTkafzaBb+/68YRp+cVCx14Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=QWV44F2R; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id DA1A86356CC0;
	Mon, 29 Jan 2024 17:20:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1706545205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QUPpZlS0vWCioBkwkhT2xs0rrMrqTqY1OIwQMzU+/oE=;
	b=QWV44F2RToANXCBGBM2CXBrbu7FyJB9OFuVmLg3Gm2DlhpAoHe2O1Caj+eHTs3SekPWOcs
	OSHcgU5mgDRY8KDtrrH19yXEbkXmbSwnMnqeCTgmXaD0G62o02aY4p8Td81dhQgGq5LPxh
	kcA/10dZgl3ibkYM6hPgkzhU7gkbNFI=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org,
 Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
 Bastien Nocera <hadess@hadess.net>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: Flood of logitech-hidpp-device messages in v6.7
Date: Mon, 29 Jan 2024 17:19:54 +0100
Message-ID: <4894984.31r3eYUQgx@natalenko.name>
In-Reply-To: <489d6c71-73eb-4605-8293-5cfea385cf08@redhat.com>
References:
 <3277085.44csPzL39Z@natalenko.name> <12371430.O9o76ZdvQC@natalenko.name>
 <489d6c71-73eb-4605-8293-5cfea385cf08@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4543854.LvFx2qVVIh";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart4543854.LvFx2qVVIh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: Re: Flood of logitech-hidpp-device messages in v6.7
Date: Mon, 29 Jan 2024 17:19:54 +0100
Message-ID: <4894984.31r3eYUQgx@natalenko.name>
In-Reply-To: <489d6c71-73eb-4605-8293-5cfea385cf08@redhat.com>
MIME-Version: 1.0

On pond=C4=9Bl=C3=AD 29. ledna 2024 17:08:56 CET Hans de Goede wrote:
> Hi,
>=20
> On 1/29/24 16:58, Oleksandr Natalenko wrote:
> > Hello.
> >=20
> > On =C3=BAter=C3=BD 9. ledna 2024 12:58:10 CET Hans de Goede wrote:
> >> Hi Oleksandr,
> >>
> >> On 1/9/24 12:45, Oleksandr Natalenko wrote:
> >>> Hello Hans et al.
> >>>
> >>> Starting from v6.7 release I get the following messages repeating in =
`dmesg` regularly:
> >>>
> >>> ```
> >>> Jan 09 10:05:06 spock kernel: logitech-hidpp-device 0003:046D:4051.00=
06: Disconnected
> >>> Jan 09 10:07:15 spock kernel: logitech-hidpp-device 0003:046D:408A.00=
05: Disconnected
> >>> Jan 09 10:16:51 spock kernel: logitech-hidpp-device 0003:046D:4051.00=
06: HID++ 4.5 device connected.
> >>> Jan 09 10:16:55 spock kernel: logitech-hidpp-device 0003:046D:408A.00=
05: HID++ 4.5 device connected.
> >>> Jan 09 10:16:55 spock kernel: logitech-hidpp-device 0003:046D:408A.00=
05: HID++ 4.5 device connected.
> >>> Jan 09 10:36:31 spock kernel: logitech-hidpp-device 0003:046D:4051.00=
06: Disconnected
> >>> Jan 09 10:37:07 spock kernel: logitech-hidpp-device 0003:046D:4051.00=
06: HID++ 4.5 device connected.
> >>> Jan 09 10:46:21 spock kernel: logitech-hidpp-device 0003:046D:4051.00=
06: Disconnected
> >>> Jan 09 10:48:23 spock kernel: logitech-hidpp-device 0003:046D:408A.00=
05: Disconnected
> >>> Jan 09 11:12:27 spock kernel: logitech-hidpp-device 0003:046D:4051.00=
06: HID++ 4.5 device connected.
> >>> Jan 09 11:12:47 spock kernel: logitech-hidpp-device 0003:046D:408A.00=
05: HID++ 4.5 device connected.
> >>> Jan 09 11:12:47 spock kernel: logitech-hidpp-device 0003:046D:408A.00=
05: HID++ 4.5 device connected.
> >>> Jan 09 11:38:32 spock kernel: logitech-hidpp-device 0003:046D:4051.00=
06: Disconnected
> >>> Jan 09 11:43:32 spock kernel: logitech-hidpp-device 0003:046D:408A.00=
05: Disconnected
> >>> Jan 09 11:45:10 spock kernel: logitech-hidpp-device 0003:046D:4051.00=
06: HID++ 4.5 device connected.
> >>> Jan 09 11:45:11 spock kernel: logitech-hidpp-device 0003:046D:408A.00=
05: HID++ 4.5 device connected.
> >>> Jan 09 11:45:11 spock kernel: logitech-hidpp-device 0003:046D:408A.00=
05: HID++ 4.5 device connected.
> >>> Jan 09 12:31:48 spock kernel: logitech-hidpp-device 0003:046D:4051.00=
06: Disconnected
> >>> Jan 09 12:33:21 spock kernel: logitech-hidpp-device 0003:046D:4051.00=
06: HID++ 4.5 device connected.
> >>> ```
> >>>
> >>> I've got the following hardware:
> >>>
> >>> * Bus 006 Device 004: ID 046d:c52b Logitech, Inc. Unifying Receiver
> >>> * Logitech MX Keys
> >>> * Logitech M510v2
> >>>
> >>> With v6.6 I do not get those messages.
> >>>
> >>> I think this is related to 680ee411a98e ("HID: logitech-hidpp: Fix co=
nnect event race").
> >>>
> >>> My speculation is that some of the devices enter powersaving state af=
ter being idle for some time (5 mins?), and then wake up and reconnect once=
 I touch either keyboard or mouse. I should highlight that everything works=
 just fine, it is the flood of messages that worries me.
> >>>
> >>> Is it expected?
> >>
> >> Yes this is expected, looking at your logs I see about 10 messages per
> >> hour which IMHO is not that bad.
> >>
> >> I guess we could change things to track we have logged the connect
> >> message once and if yes then log future connect messages (and all
> >> disconnect messages) at debug level.
> >=20
> > How granular such a tracking should be? Per-`struct hidpp_device`?
>=20
> Yes per struct hidpp_device we want to log the connect message once
> per device since it gives info which might be useful for troubleshooting.
>=20
> > Should there be something like `hid_info_once_then_dbg()` macro, or ope=
n-code it in each place instead?
>=20
> Since we want something like e.g. a "first_connect" (initialized
> to true if you use that name) flag per struct hidpp_device this needs
> to be open coded.

OK, would something like this make sense (not tested)?

```
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hi=
dpp.c
index 6ef0c88e3e60a..a9899709d6b74 100644
=2D-- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -203,6 +203,9 @@ struct hidpp_device {
 	struct hidpp_scroll_counter vertical_wheel_counter;
=20
 	u8 wireless_feature_index;
+
+	bool once_connected;
+	bool once_disconnected;
 };
=20
 /* HID++ 1.0 error codes */
@@ -988,8 +991,13 @@ static int hidpp_root_get_protocol_version(struct hidp=
p_device *hidpp)
 	hidpp->protocol_minor =3D response.rap.params[1];
=20
 print_version:
=2D	hid_info(hidpp->hid_dev, "HID++ %u.%u device connected.\n",
=2D		 hidpp->protocol_major, hidpp->protocol_minor);
+	if (!hidpp->once_connected) {
+		hid_info(hidpp->hid_dev, "HID++ %u.%u device connected.\n",
+			 hidpp->protocol_major, hidpp->protocol_minor);
+		hidpp->once_connected =3D true;
+	} else
+		hid_dbg(hidpp->hid_dev, "HID++ %u.%u device connected.\n",
+			 hidpp->protocol_major, hidpp->protocol_minor);
 	return 0;
 }
=20
@@ -4184,7 +4192,11 @@ static void hidpp_connect_event(struct work_struct *=
work)
 	/* Get device version to check if it is connected */
 	ret =3D hidpp_root_get_protocol_version(hidpp);
 	if (ret) {
=2D		hid_info(hidpp->hid_dev, "Disconnected\n");
+		if (!hidpp->once_disconnected) {
+			hid_info(hidpp->hid_dev, "Disconnected\n");
+			hidpp->once_disconnected =3D true;
+		} else
+			hid_dbg(hidpp->hid_dev, "Disconnected\n");
 		if (hidpp->battery.ps) {
 			hidpp->battery.online =3D false;
 			hidpp->battery.status =3D POWER_SUPPLY_STATUS_UNKNOWN;
```

>=20
> Regards,
>=20
> Hans
>=20
>=20
>=20
>=20
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart4543854.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmW30CoACgkQil/iNcg8
M0tMbhAAxwXz2G2znb7/e96UUURxP3n8XsQ3XQs47HR/7EqE2FXDzZhdpkK/fD02
Jhwo6dLdQ6M0nnIeGYePWzbf91iQkbzN027LY5TDQjGYLF2ckikhEOyS9/HK7+fh
2SA2p2cLbMQkPmdm1PsLKC7g/4zT0H3UU91b+pR6PfUDeTtOipQndkyhw1wHEb9X
8fyj0fyI7WbeAJ16VpXBjxAKZ0Wu1LV+lbxbNFzbAi243J6IlmdK+0O518cfqRvt
T8UB2ndH9nHiz0jamgU7ouZNAw84HYeydDV4U85R1/6Jfi3Co26YIIb0Mxl0GOjl
J940E2d+EPD0FmdGBU9dFYOaKzdmJilS3rkSVnT4CVVRygrQAeEGytlLHsPR6d8r
qaXy4f71HoEp9wcpl74E2Hf5AxCKoAkwqUrry08L+MGullPedHYkN/VdD72AtroE
UU63HApzt8giBpikRBhkmZ1l6xVHuxGvpE9ZBL1Sa5+sYpVt+dAozopCbvgj8jtU
nnsVcnjzAWwPIvRWMkYbO+CPtqBfQQ6CzST/cXDxUQK1S5jKxSVkvtf80daJg+8W
YF1WNXY9idIUwB6K1D5hge+63n+IMmgstqA6ndtC3RlKCEGybf6Y6sak3s1f6e1b
GqCcHoYIn/z3XQRnLeAr8gIszOdOMouRJKTe0KJ/X/L2NT7dm+s=
=3fAU
-----END PGP SIGNATURE-----

--nextPart4543854.LvFx2qVVIh--




