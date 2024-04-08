Return-Path: <linux-kernel+bounces-135556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDCE89C784
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A852858AD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA6913F422;
	Mon,  8 Apr 2024 14:52:01 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5459313F00A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587921; cv=none; b=Qu6MvNRbEipkm7AD3BWDbO+u6lbrnHLeSLJv24kxkHcNttHSHrXehkhm5x6L/G9yTDZiE9c7QP/QbpFaSE/bWbotHO057sTDWkHXmjkzO5uYoftNKeG8qWrrimRd8ubHVm0yLk3d6u+HhSc3DBsqvB9Iak+MYhv4lRXPoKojZzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587921; c=relaxed/simple;
	bh=joBS4N+InEhxAxePrDedqkg1DBS7fYz8aPowxWmurS4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=F9Cbp7vmZbyiHCbHbdU1GYHsNE4WvkNRdP5utmZP7jF3IKLkZ2QaBbXMnGM9YWMChEQ26igt27LqzxGkls6nlg5huFVBvaLieEn6uQekjyJ2A9ofFWUj4OHS7QoiGsgCqfLe36VzDbLlVioTO4bPHpdyvdciQfuHGu2CWJ2sFsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-71-6TRe-qOWOSiRkJM3kA_YFw-1; Mon, 08 Apr 2024 15:51:48 +0100
X-MC-Unique: 6TRe-qOWOSiRkJM3kA_YFw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 8 Apr
 2024 15:51:13 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 8 Apr 2024 15:51:13 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Haris Okanovic' <harisokn@amazon.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-assembly@vger.kernel.org"
	<linux-assembly@vger.kernel.org>
CC: "peterz@infradead.org" <peterz@infradead.org>
Subject: RE: [PATCH 2/3] arm64: add __READ_ONCE_EX()
Thread-Topic: [PATCH 2/3] arm64: add __READ_ONCE_EX()
Thread-Index: AQHahJ/HcAF4vsIbZ0CGgbWFvfkyfLFefKGg
Date: Mon, 8 Apr 2024 14:51:13 +0000
Message-ID: <1b659ba3fa50482a8338b1a6942884cc@AcuMS.aculab.com>
References: <20240402014706.3969151-1-harisokn@amazon.com>
 <20240402014706.3969151-2-harisokn@amazon.com>
In-Reply-To: <20240402014706.3969151-2-harisokn@amazon.com>
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

From: Haris Okanovic
> Sent: 02 April 2024 02:47
>=20
> Perform an exclusive load, which atomically loads a word and arms the
> execusive monitor to enable wfe() polling of an address.
>=20
> Adding this macro in preparation for an arm64 cpuidle driver which
> supports a wfe() based polling state.
>=20
> https://developer.arm.com/documentation/dht0008/a/arm-synchronization-pri=
mitives/exclusive-
> accesses/exclusive-monitors
>=20
> Signed-off-by: Haris Okanovic <harisokn@amazon.com>
> ---
>  arch/arm64/include/asm/readex.h | 46 +++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 arch/arm64/include/asm/readex.h
>=20
> diff --git a/arch/arm64/include/asm/readex.h b/arch/arm64/include/asm/rea=
dex.h
> new file mode 100644
> index 000000000000..51963c3107e1
> --- /dev/null
> +++ b/arch/arm64/include/asm/readex.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Based on arch/arm64/include/asm/rwonce.h
> + *
> + * Copyright (C) 2020 Google LLC.
> + * Copyright (C) 2024 Amazon.com, Inc. or its affiliates.
> + */
> +
> +#ifndef __ASM_READEX_H
> +#define __ASM_READEX_H
> +
> +#define __LOAD_EX(sfx, regs...) "ldaxr" #sfx "\t" #regs
> +
> +#define __READ_ONCE_EX(x)=09=09=09=09=09=09\
> +({=09=09=09=09=09=09=09=09=09\
> +=09typeof(&(x)) __x =3D &(x);=09=09=09=09=09\
> +=09int atomic =3D 1;=09=09=09=09=09=09=09\
> +=09union { __unqual_scalar_typeof(*__x) __val; char __c[1]; } __u;=09\
> +=09switch (sizeof(x)) {=09=09=09=09=09=09\
> +=09case 1:=09=09=09=09=09=09=09=09\
> +=09=09asm volatile(__LOAD_EX(b, %w0, %1)=09=09=09\
> +=09=09=09: "=3Dr" (*(__u8 *)__u.__c)=09=09=09\
> +=09=09=09: "Q" (*__x) : "memory");=09=09=09\
> +=09=09break;=09=09=09=09=09=09=09\
> +=09case 2:=09=09=09=09=09=09=09=09\
> +=09=09asm volatile(__LOAD_EX(h, %w0, %1)=09=09=09\
> +=09=09=09: "=3Dr" (*(__u16 *)__u.__c)=09=09=09\
> +=09=09=09: "Q" (*__x) : "memory");=09=09=09\
> +=09=09break;=09=09=09=09=09=09=09\
> +=09case 4:=09=09=09=09=09=09=09=09\
> +=09=09asm volatile(__LOAD_EX(, %w0, %1)=09=09=09\
> +=09=09=09: "=3Dr" (*(__u32 *)__u.__c)=09=09=09\
> +=09=09=09: "Q" (*__x) : "memory");=09=09=09\
> +=09=09break;=09=09=09=09=09=09=09\
> +=09case 8:=09=09=09=09=09=09=09=09\
> +=09=09asm volatile(__LOAD_EX(, %0, %1)=09=09=09\
> +=09=09=09: "=3Dr" (*(__u64 *)__u.__c)=09=09=09\
> +=09=09=09: "Q" (*__x) : "memory");=09=09=09\
> +=09=09break;=09=09=09=09=09=09=09\
> +=09default:=09=09=09=09=09=09=09\
> +=09=09atomic =3D 0;=09=09=09=09=09=09\
> +=09}=09=09=09=09=09=09=09=09\
> +=09atomic ? (typeof(*__x))__u.__val : (*(volatile typeof(__x))__x);\

I'm pretty sure that doesn't work the way you expect.
The ?: operator promotes 'unsigned char' to  'int'.
So you can fall foul of signedness tests (eg in min()).
It also isn't going to work for non-scalers.

Replacing the ?: with __builtin_choose_expr() may help.

(This is probably a bug in the code you copied.)

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


