Return-Path: <linux-kernel+bounces-117062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0363388A693
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848001F3D833
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285ED13BC16;
	Mon, 25 Mar 2024 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="Na3V/KXw"
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF51F137C3C;
	Mon, 25 Mar 2024 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371071; cv=none; b=hyIAvIf65uWm2sYkzRDzkxuuSNBby9KUkPGmAOeIgfj5+mA8lHKs1xby9+1jIlbO1gBXYnxm8GSNZEG1ouLSuGTZCLSoSl2n62FJs/Lo+BEMc5jtH28E6kl8u+AqZcNO7iplJjgR5FPYjXkF+rRMVZMbASxvNFOzUWm8z+25Jhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371071; c=relaxed/simple;
	bh=zLjxSrw+xaU9HGkumiL0UXW20073ygMMlmEelv1Gs8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZ2ZHJECnUB8DqvyscBnkAcP/pDG5oD5H4+32kHSl+nN9+i0mi74UiOiBtyjl4cpFAOj4lscBghG7xXw2C2xK053idq9inBH7qzaFYA/JrJpwQnjterTWYhKL90e4YvCZGW4okbSG62SIjSvlMaucBV8Vh4fL9q11Pqjf4qy7dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=Na3V/KXw; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id D66C56346550;
	Mon, 25 Mar 2024 13:51:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1711371065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QUyUoIBK96AYs5nkg7UXK3JancEt4PFfayXLmkO0KwM=;
	b=Na3V/KXwuJUvlWqlkbKIc1g3qzP0Gp/tFpqxU+GyNyiOQ8UDM0eq6jQAOeTvh9qVHS3pxn
	9jhm5DQ98Y1b+qmHSJQzekQ03SdrgRaqokJ2upD33eBsUoKsxAiA7UWBz0lpg15/EO9skK
	tQTmFVtESt4+y+Jtql9emy442ii341U=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>,
 Hans Verkuil <hverkuil@xs4all.nl>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Subject:
 Re: [PATCH v10 3/6] media: uvcvideo: Quirk for invalid dev_sof in Logitech
 C922
Date: Mon, 25 Mar 2024 13:50:52 +0100
Message-ID: <5764213.DvuYhMxLoT@natalenko.name>
In-Reply-To:
 <CANiDSCuma7aGxq7T2uYMgn_JEW223LdR4as83UT2Aj3QmVu4ig@mail.gmail.com>
References:
 <20240323-resend-hwtimestamp-v10-0-b08e590d97c7@chromium.org>
 <12403186.O9o76ZdvQC@natalenko.name>
 <CANiDSCuma7aGxq7T2uYMgn_JEW223LdR4as83UT2Aj3QmVu4ig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6027975.lOV4Wx5bFT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart6027975.lOV4Wx5bFT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 25 Mar 2024 13:50:52 +0100
Message-ID: <5764213.DvuYhMxLoT@natalenko.name>
MIME-Version: 1.0

On pond=C4=9Bl=C3=AD 25. b=C5=99ezna 2024 10:25:51, CET Ricardo Ribalda wro=
te:
> Hi Oleksandr
>=20
> On Mon, 25 Mar 2024 at 10:23, Oleksandr Natalenko
> <oleksandr@natalenko.name> wrote:
> >
> > Hello.
> >
> > On pond=C4=9Bl=C3=AD 25. b=C5=99ezna 2024 8:52:57, CET Ricardo Ribalda =
wrote:
> > > Hi Oleksandr
> > >
> > > On Sat, 23 Mar 2024 at 13:16, Oleksandr Natalenko
> > > <oleksandr@natalenko.name> wrote:
> > >
> > > >
> > > > How do I check whether C920 (046d:082d) is affected too? I have got=
 one, I can run tests on it as long as those will not blow the webcam up.
> > > >
> > > > Thanks.
> > > >
> > >
> > > First of all you need to enable the hwtimestamps in the driver. You
> > > could do that with
> > >
> > > ```
> > > rmmod uvcvideo; modprobe uvcvideo hwtimestamps=3D1
> > > ```
> >
> > ```
> > $ cat /sys/module/uvcvideo/parameters/hwtimestamps
> > 1
> > ```
> >
> > > Then capture some frames with yavta
> > > ```
> > > yavta -c /dev/video0
> > > ```
> > >
> > > After around 5 seconds all the frames should have a stable fps, the
> > > fps is not stable then your camera is affected with this bug.
> >
> > ```
> > $ ./yavta -c /dev/video1
> > Device /dev/video1 opened.
> > Device `HD Pro Webcam C920' on `usb-0000:0f:00.3-3.4' (driver 'uvcvideo=
') supports video, capture, without mplanes.
> > Video format: MJPEG (47504a4d) 1920x1080 (stride 0) field none buffer s=
ize 4147200
> > =E2=80=A6
> > 100 (4) [-] none 100 200717 B 212.919114 213.079004 33.727 fps ts mono/=
SoE
> > 101 (5) [-] none 101 200889 B 213.003703 213.114996 11.822 fps ts mono/=
SoE
> > 102 (6) [-] none 102 200926 B 213.035571 213.146999 31.379 fps ts mono/=
SoE
> > 103 (7) [-] none 103 200839 B 213.067424 213.179003 31.394 fps ts mono/=
SoE
> > 104 (0) [-] none 104 200692 B 213.293180 213.214991 4.430 fps ts mono/S=
oE
> > 105 (1) [-] none 105 200937 B 213.322374 213.247001 34.254 fps ts mono/=
SoE
> > 106 (2) [-] none 106 201013 B 213.352228 213.279005 33.496 fps ts mono/=
SoE
> > =E2=80=A6
> > 168 (0) [-] none 168 200914 B 215.183707 215.347066 33.676 fps ts mono/=
SoE
> > 169 (1) [-] none 169 201141 B 215.271693 215.379066 11.365 fps ts mono/=
SoE
> > 170 (2) [-] none 170 201005 B 215.303449 215.415057 31.490 fps ts mono/=
SoE
> > 171 (3) [-] none 171 201195 B 215.335295 215.447062 31.401 fps ts mono/=
SoE
> > 172 (4) [-] none 172 200933 B 215.557731 215.479072 4.496 fps ts mono/S=
oE
> > 173 (5) [-] none 173 200973 B 215.587033 215.515063 34.127 fps ts mono/=
SoE
> > 174 (6) [-] none 174 200698 B 215.616811 215.547063 33.582 fps ts mono/=
SoE
> > 175 (7) [-] none 175 201290 B 215.646196 215.579075 34.031 fps ts mono/=
SoE
> > 176 (0) [-] none 176 200807 B 215.675857 215.615073 33.714 fps ts mono/=
SoE
> > =E2=80=A6
> > ```
> >
> > Does the above mean the webcam is affected?
>=20
> Looks like it.... could you try applying this patch and run with
>=20
> rmmod uvcvideo; modprobe uvcvideo hwtimestamps=3D1 quirks=3D0x4000
>=20
> to see if that fixes it for you?

On top of v6.8, I've applied the whole v10, and also applied the following =
change instead of providing `quirks=3D`:

```
commit 884a61751d979ee9974c08a71c72e88e73bdd87e
Author: Oleksandr Natalenko <oleksandr@natalenko.name>
Date:   Mon Mar 25 10:28:00 2024 +0100

    media: uvcvideo: Quirk for invalid dev_sof in Logitech C920
   =20
    Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc=
_driver.c
index 723e6d5680c2e..444d7089885ea 100644
=2D-- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2573,7 +2573,8 @@ static const struct usb_device_id uvc_ids[] =3D {
 	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
 	  .bInterfaceSubClass	=3D 1,
 	  .bInterfaceProtocol	=3D 0,
=2D	  .driver_info		=3D UVC_INFO_QUIRK(UVC_QUIRK_RESTORE_CTRLS_ON_INIT) },
+	  .driver_info		=3D UVC_INFO_QUIRK(UVC_QUIRK_RESTORE_CTRLS_ON_INIT
+					       | UVC_QUIRK_INVALID_DEVICE_SOF) },
 	/* Logitech HD Pro Webcam C922 */
 	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,

```

Now I see this:

```
154 (2) [-] none 154 192417 B 42.199823 42.207788 27.779 fps ts mono/SoE
155 (3) [-] none 155 192040 B 42.231834 42.239791 31.239 fps ts mono/SoE
156 (4) [-] none 156 192213 B 42.263823 42.271822 31.261 fps ts mono/SoE
157 (5) [-] none 157 191981 B 42.299824 42.303827 27.777 fps ts mono/SoE
158 (6) [-] none 158 191953 B 42.331835 42.339811 31.239 fps ts mono/SoE
159 (7) [-] none 159 191904 B 42.363824 42.371813 31.261 fps ts mono/SoE
160 (0) [-] none 160 192210 B 42.399834 42.407801 27.770 fps ts mono/SoE
161 (1) [-] none 161 192235 B 42.431824 42.439806 31.260 fps ts mono/SoE
```

without dips in FPS.

What do you think?

>=20
> Thanks!
>=20
> >
> > Thank you.
> >
> > >
> > >
> > > Thanks!
> > >
> >
> >
> > --
> > Oleksandr Natalenko (post-factum)
>=20
>=20
>=20
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart6027975.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmYBcywACgkQil/iNcg8
M0tp3g//bg8SISk8dmh0xS2tALwwiznraDeWRzECmn7OhqFwgEpFnswDRHkH+jVx
Pc0WD3W1kPpoY+jyhiI3hqD4O44ozOVdDQakt4v37wDWig+a4cNFgamIVpUphw0+
XNxCAlM7FvVDC6K3eU5JcazjVzPFVL/mYJ46uc3j9CU2qo1szr0w5rnAca+8J2vs
/i6K/DKyG70M4i6S6XBZzDr/8pALMo17f0/chC4penOHiK5+GTgeypVUYb1KjgW2
HF2USU+6Be1atSq3FXwCtDC2PevrJVurKgWI31Njul6xsvrvxGysSlPPKgMPN3o6
ciaIhnTPF+nZXqABRn/EQ98Cg5SNfbk+VQfMV6cOmQj9x6/HVoNCgECKHTtTJJ+6
wwbJh2/bpWoXxgA4u/R7BAo9lWTuRW+yEdV2sXLSwycdXO1XqrNxwGuoFEya1kQO
kOM2X15oj4I1DVOdwvCaaxq0r534GXIyrqHaBtnhBTFDTgdrHdQYLWaq1SXkqp2s
yRW4UDKSbXdHa5/qo31+79Qi+RALKLcb1x3jZXHs0b33RLjN0whZVvJh77KQUjtQ
ORRxwPlN6sGfvuE478+j9R786sShvKIMdvY8J+x3i+i9E4H9oxh0cGEfYcooXl1x
x+/+MewbJ+6sF2ks9trKPQeoYTbZKqE1ddpOuymjPGH3paB87Xo=
=0T8G
-----END PGP SIGNATURE-----

--nextPart6027975.lOV4Wx5bFT--




