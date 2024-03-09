Return-Path: <linux-kernel+bounces-97920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F099F8771A3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 15:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 672ACB20DFA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 14:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D8D3BBC4;
	Sat,  9 Mar 2024 14:35:04 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9702F22
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709994903; cv=none; b=Ivo3o1ke8XxVxvuQ4ELdMuKgwhYn3Og4buhdNOZcY76pFBf8DldaRpUp5ifl995kD0+pqoyWtoqVRH+xaS3OlZlYlwnTKCo4T/oz/nJjcM8gkBlF7pEexq34bl5iFCXoyx8+M0G7ZIgTh6MXrD/r0jvv6tctGLDQ0JjFH7ynug0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709994903; c=relaxed/simple;
	bh=ds0BIkru2EQH9Tc9HwHJJTJfwfJeUmksK9jbB2Cr3Ac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=PTZNs3aoS14Nt1UUN4ZI6TgIzLmD6VFskZotYSE2Id+7mHyFg7BSCKxyF9z68+fGV4j5YqOBwQkaUkUdkN4Zm8TvfsE+M5ld8otWn+lVBbp/z2sdMOkEe6nw0ijDTMQa/MkDGXy6Z18qFo1pc5FkpYbW3TzkEgnJZjT/tRqGaVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-253-14N-Did4PAW8hIsoNs_d-Q-1; Sat, 09 Mar 2024 14:33:12 +0000
X-MC-Unique: 14N-Did4PAW8hIsoNs_d-Q-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 9 Mar
 2024 14:33:26 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 9 Mar 2024 14:33:26 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Maxime Ripard' <mripard@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC: Naresh Kamboju <naresh.kamboju@linaro.org>, open list
	<linux-kernel@vger.kernel.org>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>, "linux-sunxi@lists.linux.dev"
	<linux-sunxi@lists.linux.dev>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "lkft-triage@lists.linaro.org"
	<lkft-triage@lists.linaro.org>, Dave Airlie <airlied@redhat.com>, "Dan
 Carpenter" <dan.carpenter@linaro.org>, Ard Biesheuvel <ardb@kernel.org>
Subject: RE: arm: ERROR: modpost: "__aeabi_uldivmod"
 [drivers/gpu/drm/sun4i/sun4i-drm-hdmi.ko] undefined!
Thread-Topic: arm: ERROR: modpost: "__aeabi_uldivmod"
 [drivers/gpu/drm/sun4i/sun4i-drm-hdmi.ko] undefined!
Thread-Index: AQHabimenIC0ADhmjUqxSQo36gIP17EvfaYA
Date: Sat, 9 Mar 2024 14:33:26 +0000
Message-ID: <85b807289ff2400ea5887ced63655862@AcuMS.aculab.com>
References: <CA+G9fYvG9KE15PGNoLu+SBVyShe+u5HBLQ81+kK9Zop6u=ywmw@mail.gmail.com>
 <338c89bb-a70b-4f35-b71b-f974e90e3383@app.fastmail.com>
 <20240304-brawny-goshawk-of-sorcery-860cef@houat>
In-Reply-To: <20240304-brawny-goshawk-of-sorcery-860cef@houat>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Maxime Ripard
> Sent: 04 March 2024 11:46
>=20
> On Mon, Mar 04, 2024 at 12:11:36PM +0100, Arnd Bergmann wrote:
> > On Mon, Mar 4, 2024, at 09:07, Naresh Kamboju wrote:
> > > The arm defconfig builds failed on today's Linux next tag next-202403=
04.
> > >
> > > Build log:
> > > ---------
> > > ERROR: modpost: "__aeabi_uldivmod"
> > > [drivers/gpu/drm/sun4i/sun4i-drm-hdmi.ko] undefined!
> > >
> >
> > Apparently caused by the 64-bit division in 358e76fd613a
> > ("drm/sun4i: hdmi: Consolidate atomic_check and mode_valid"):
> >
> >
> > +static enum drm_mode_status
> > +sun4i_hdmi_connector_clock_valid(const struct drm_connector *connector=
,
> > +                                const struct drm_display_mode *mode,
> > +                                unsigned long long clock)
> >  {
> > -       struct sun4i_hdmi *hdmi =3D drm_encoder_to_sun4i_hdmi(encoder);
> > -       unsigned long rate =3D mode->clock * 1000;
> > -       unsigned long diff =3D rate / 200; /* +-0.5% allowed by HDMI sp=
ec */
> > +       const struct sun4i_hdmi *hdmi =3D drm_connector_to_sun4i_hdmi(c=
onnector);
> > +       unsigned long diff =3D clock / 200; /* +-0.5% allowed by HDMI s=
pec */
> >         long rounded_rate;
> >
> > This used to be a 32-bit division. If the rate is never more than
> > 4.2GHz, clock could be turned back into 'unsigned long' to avoid
> > the expensive div_u64().
>=20
> I sent a fix for it this morning:
> https://lore.kernel.org/r/20240304091225.366325-1-mripard@kernel.org
>=20
> The framework will pass an unsigned long long because HDMI character
> rates can go up to 5.9GHz.

You could do:
=09/* The max clock is 5.9GHz, split the divide */
=09u32 diff =3D (u32)(clock / 8) / (200/8);

The code should really use u32 and u64.
Otherwise the sizes are different on 32bit.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


