Return-Path: <linux-kernel+bounces-48943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5800D846370
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D0028BC7B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD42E405FC;
	Thu,  1 Feb 2024 22:30:07 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9261E405F7
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 22:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706826607; cv=none; b=tFAxmvP8xFCaLqvGutV9KEBD5IGwH2+K4269A8dBpPfjBzH4OlBWA/tU53H0HbVKu6GknXOwFKKCHp2nGjNqZTdfT/54TrHq3TvvKD2/NprnjzCoCeAE9BS1CTOq586XVaFTyuLudMZOwUgr76xQQulllXOYUhU56vCMrfw2Efk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706826607; c=relaxed/simple;
	bh=+FEiqruD2PhiHiOREenoir18YObY1XMyZp7vO4EV3A4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=DQ/f5SF3cojBYHczX8sNDbffS3at6IYkNC/08bezSiG+eyMuOQePEdDJHhBPZfluZVTry4ZvZ0KYyVlnDbrgNTuydEOwiK14lMnbAcdqPKovtfqpy8+5LpvxxpehETeHAPNwZ5DXAhTO8gBkxd4lKCmdDaEzhHWFVZ0ILo1j+Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-92-6SPxv_cpN_qKS1Gtzru5yA-1; Thu, 01 Feb 2024 22:29:54 +0000
X-MC-Unique: 6SPxv_cpN_qKS1Gtzru5yA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 1 Feb
 2024 22:29:37 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 1 Feb 2024 22:29:37 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Kees Cook' <keescook@chromium.org>, Andy Shevchenko <andy@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC: "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] string: Allow 2-argument strscpy()
Thread-Topic: [RFC] string: Allow 2-argument strscpy()
Thread-Index: AQHaUvHLFgl6ZJLHe0apLw7TCgOYwbD2FRpA
Date: Thu, 1 Feb 2024 22:29:37 +0000
Message-ID: <9dae4c62fc164abeaa7915f9e53fdb28@AcuMS.aculab.com>
References: <20240129202901.work.282-kees@kernel.org>
In-Reply-To: <20240129202901.work.282-kees@kernel.org>
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

From: Kees Cook
> Sent: 29 January 2024 20:29
>=20
> Using sizeof(dst) is the overwhelmingly common case for strscpy().
> Instead of requiring this everywhere, allow a 2-argument version to be
> used that will use the sizeof() internally.

You may want to (try to) add a check that the first argument is
actually an array rather than just a pointer.

But the cpp output bloat can get silly and slow the build down.
I guess no one would do:
=09x =3D min(strscpy(a, b), strscpy(c, d));
but you can never tell :-)

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


