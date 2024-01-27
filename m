Return-Path: <linux-kernel+bounces-41402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E8F83F033
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FBA51C21E5B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 21:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745181B7E5;
	Sat, 27 Jan 2024 21:23:28 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB8E1B5A2
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 21:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706390608; cv=none; b=CBeDnh3Ymukfnm9oVU0gFRA2Fl/A2BlfB93GntG72ikDCd8FcEf3SRLlbJzQnXt7FwHTYsXf3Ri33ydCzFO9+XeX/TVFYYctcTIafna2slPUtFxzcHx5k2h1e/2sJZypzJFWSobeHXF8lvXD9toVsvXa54WnKLoLj4IId6FHZHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706390608; c=relaxed/simple;
	bh=YkqaicGETk+XKynlgPWOudIML4WAqhf9XLhiYoty3Yk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=KKUby8nsvjIKd7KknUxPnUQW45hqK9UrjEzau4y6Rq4RRx3ILCJY+pLOwOGBNsP/he62aD7sn265CGKeNuh0fV47cD7VbElGu94WWbRDDdDs49XfSU6qytFTrJ1p9yAQ1kCxUbclsNhI4rlXCjdQJSuDR5MUNs3mpavSsy6u834=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-81-GfvnfuAlPfiYfhrNVHlMsw-1; Sat, 27 Jan 2024 21:23:21 +0000
X-MC-Unique: GfvnfuAlPfiYfhrNVHlMsw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 27 Jan
 2024 21:23:01 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 27 Jan 2024 21:23:01 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Willy Tarreau' <w@1wt.eu>, =?iso-8859-1?Q?Thomas_Wei=DFschuh?=
	<linux@weissschuh.net>
CC: Rodrigo Campos <rodrigo@sdfg.com.ar>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/1] tools/nolibc/string: export strlen()
Thread-Topic: [PATCH 0/1] tools/nolibc/string: export strlen()
Thread-Index: AQHaUT7WVqm/RgPyLEmfaSR8/02gXLDuKmvw
Date: Sat, 27 Jan 2024 21:23:01 +0000
Message-ID: <512849f3c22e4f4688c20fabe017c903@AcuMS.aculab.com>
References: <20240126142411.22972-1-rodrigo@sdfg.com.ar>
 <9abed5e3-cd61-474e-bb16-13243709f5c5@t-8ch.de>
 <20240127162400.GA14079@1wt.eu>
In-Reply-To: <20240127162400.GA14079@1wt.eu>
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

.
> Yes, once we have the proof that the compiler may produce such a call, it
> can also happen in whatever user code so we need to export the function,
> there's no other solution.

Does that mean that it you try to implement strlen() in C
gcc will generate a recursive call?

I guess an 'asm volatile("");' in the loop fix it.
Although, IIRC, you need a comment in the asm - and there
isn't a portable comment.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


