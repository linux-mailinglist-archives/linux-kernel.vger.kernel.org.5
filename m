Return-Path: <linux-kernel+bounces-17821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE21825332
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92CDD1C22F62
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83E92D029;
	Fri,  5 Jan 2024 12:02:29 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17762CCC4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-164-2jbWMMW-PhWkS7KfcjAoaQ-1; Fri, 05 Jan 2024 12:02:24 +0000
X-MC-Unique: 2jbWMMW-PhWkS7KfcjAoaQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 5 Jan
 2024 12:02:08 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 5 Jan 2024 12:02:08 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: "'alexs@kernel.org'" <alexs@kernel.org>, Eric Biederman
	<ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Alex Shi <alexsshi@tencent.com>, "curlinhuang@tencent.com"
	<curlinhuang@tencent.com>
Subject: RE: [PATCH] execve: argument list space enlargement
Thread-Topic: [PATCH] execve: argument list space enlargement
Thread-Index: AQHaPkWNtOnoU7TWREOKrIllLweKE7DLHuZw
Date: Fri, 5 Jan 2024 12:02:08 +0000
Message-ID: <1834358b1a8642f9b46a209bad035474@AcuMS.aculab.com>
References: <20240103130722.1551670-1-alexs@kernel.org>
In-Reply-To: <20240103130722.1551670-1-alexs@kernel.org>
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

From: alexs@kernel.org
> Sent: 03 January 2024 13:07
>=20
> From: Alex Shi <alexsshi@tencent.com>
>=20
> Wechat using too long gcc parameters, then get a strace complain:
>   execve(...) =3D -1 E2BIG (Argument list too long)
> Have to increase the parameter space for this, stack has enough
> space for this enlargement.

They should fix their build so that it doesn't explode.
It'll probably speed up the compiles as well since the
very long argv[] almost certainly comes from a lot of -I dir
options and they slow down the compile.

if they are -Dvar[=3Dval] then '-include file' can be used instead.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


