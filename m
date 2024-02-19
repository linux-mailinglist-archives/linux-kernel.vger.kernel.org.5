Return-Path: <linux-kernel+bounces-71919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B2D85AC82
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0E31C23765
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7BF524BC;
	Mon, 19 Feb 2024 19:53:29 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2C851C52
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372408; cv=none; b=ASS7a+SeRt1rQr2cEYp7iIHPSDes/d2947mG95AXXu6hbb71MpYKZs8+PXxs4Pp6ydjYpw+wl5kE+pAkb8a+zzd3vKh4eHJJYHmOrpZR5HxMEi3P2eeKCRqvBlrOZfC0VMxKLhPEXKcw43SE1xATsjv3N4tigkuyaZQsDuIRewU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372408; c=relaxed/simple;
	bh=tUCR7LXsvtV62R1qRJs8R8DM/EaMa+lZAAVeZ+VQlwg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=DOwC/ZykuGlUi/vbBQiMPADdxLE1Zb7hkILJX/5tWzM+vfZHIiJzEoDquvB7RpivTO5MaUGuMnGfMZRtMXhWD5QlSoRTRV6oZ/UuoHwW3Twva46/dlrjPsjJBKJBusMu5ln/6/NNlnykBzkQvzirIxTdM6qVZKOhC5CxEOOWoqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-211-7we1XWUIMouBaxZLYQD49A-1; Mon, 19 Feb 2024 19:53:17 +0000
X-MC-Unique: 7we1XWUIMouBaxZLYQD49A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 19 Feb
 2024 19:53:16 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 19 Feb 2024 19:53:16 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Kent Overstreet' <kent.overstreet@linux.dev>, "Russell King (Oracle)"
	<linux@armlinux.org.uk>
CC: Arnd Bergmann <arnd@arndb.de>, Calvin Owens <jcalvinowens@gmail.com>,
	"Dave Martin" <Dave.Martin@arm.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-bcachefs@vger.kernel.org"
	<linux-bcachefs@vger.kernel.org>
Subject: RE: [PATCH] arm: Silence gcc warnings about arch ABI drift
Thread-Topic: [PATCH] arm: Silence gcc warnings about arch ABI drift
Thread-Index: AQHaYxoBs2nLAxuyWkKD0kyGLfcL8bESE6VA
Date: Mon, 19 Feb 2024 19:53:15 +0000
Message-ID: <ff0164553d6f486f97643eae8235cc5f@AcuMS.aculab.com>
References: <fe51512baa18e1480ce997fc535813ce6a0b0721.1708286962.git.jcalvinowens@gmail.com>
 <431dd956-ad31-4da8-ad42-34f7380824bb@app.fastmail.com>
 <ZdMe24xN1Ej4QoVU@shell.armlinux.org.uk>
 <xs2splnjhlj257uca5yae64fp4solc4ugbxrkczoyd75n42r66@42boyzdcmyj4>
 <ZdMkyPX/h9s8xht5@shell.armlinux.org.uk>
 <fharyfc7fnh45dthgd2ehwsgdqzmdfptp7jw7gi5ahb6slwgf6@nrkhlhvbbzx7>
In-Reply-To: <fharyfc7fnh45dthgd2ehwsgdqzmdfptp7jw7gi5ahb6slwgf6@nrkhlhvbbzx7>
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

..
> I'm not always trying to write code that will generate the fastest
> assembly possible; there aro other considerations. As long a the
> compiler is doing something /reasonable/, the code is fine.

Speaks the man who was writing horrid 'jit' code ...

This also begs the question of why that data is so compressed
in the first place?
It is quite likely that a few accesses generate far more code
than the data you are attempting to save.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


