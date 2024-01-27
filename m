Return-Path: <linux-kernel+bounces-41168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B2883ECD2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 12:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28DE51C21B77
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 11:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FBD200C7;
	Sat, 27 Jan 2024 11:12:13 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6551C06
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 11:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706353933; cv=none; b=OnF2Fn6eaOV7ZX8fl27kt8FRj4utfS5EDSBvsVGx4+8JP0iRAMMCvfDIaQog/Dj/JR6JgCsCva6PPnyg5mArDeo+WV9GWdqE/OTdXU5Z4VwdOeKo/M/nTwWNxI8XSj4+eW5u2HP/xFybT3mRdcvmd99F2zJ7nsHtzPZPu3KQb70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706353933; c=relaxed/simple;
	bh=r5L+xEQtvw+LbjI8a9LxiOT0O+IQw17tywkL/CqVnmk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=phDpoaoefYL2GeYZcLkJmMRDM6BVxcpVkY9OaxRAzBvo5wONPUzK/dYbrTDAadKWxaFvaKbfUJOs4JktD38y6Th0f4hFwM7k/DrxAoAazQgvOOjZXjLxami60/aUNQrw1hkS0bP3jC1RBnK4EkgPR3YR62yxb9VD/nruyP/YrUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-191-7pZDE7mmPS-KyVpCHTBaCQ-1; Sat, 27 Jan 2024 11:12:00 +0000
X-MC-Unique: 7pZDE7mmPS-KyVpCHTBaCQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 27 Jan
 2024 11:11:41 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 27 Jan 2024 11:11:41 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Matthew Wilcox' <willy@infradead.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>
CC: Randy Dunlap <rdunlap@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC] Printing numbers in SI units
Thread-Topic: [RFC] Printing numbers in SI units
Thread-Index: AQHaTvdkiC6TfXh+sUqwH5KrUG2jq7DthQeA
Date: Sat, 27 Jan 2024 11:11:41 +0000
Message-ID: <fec03708abc044de8291cdcb8279fb3f@AcuMS.aculab.com>
References: <ZbFd5TZ_pi7q3hso@casper.infradead.org>
In-Reply-To: <ZbFd5TZ_pi7q3hso@casper.infradead.org>
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

...
> +=09 * C23 does not define the effect of "alternative form".  Indeed
> +=09 * I think it actually defines it to be Undefined Behaviour which
> +=09 * apparently lets the compiler delete your entire source code.

Isn't there a large laser in orbit that fires down and
completely destroys your computer?

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


