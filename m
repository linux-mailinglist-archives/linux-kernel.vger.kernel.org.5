Return-Path: <linux-kernel+bounces-146689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF668A6965
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01C41F21E88
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA269128807;
	Tue, 16 Apr 2024 11:10:05 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D746F128384
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713265805; cv=none; b=DxbsJm8/R5z0R7tS+c+iNfwQD8BqAysu4BD4Zn7CxB7h1GMorcpP6E4pqB7GRF0CSN2yRs/vm9B4JHfAizQPmP1ipx5n2VY/BUWQJDdpTr8CGwetx7OgdKFV3Hw2uolq6oPJF1yN8NWPNBvVT4GjmUp820Qo2JpNBI5W+xPNgNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713265805; c=relaxed/simple;
	bh=DGnXGWBZ6/NHWbsu+aI1H9Su1DSjbVK/pq0pcF7oTHQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=kL/O+iE3MelfZCUVaN9DWwgxneOSNNHRbdmokOZaefjAgIpue2c8OQQz1WFJVT5YVhSOQy1Vp1iPpXvJ7scEY4LLxJXzORjsEvCiPjTYKrtdy7ZAg6vgROifRNKVaq+elQyg+sgOY1A9ilVhooB2nHVXCYLZH7naD1OIM9Z3tEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-255-LPfE2IzbO0utuOqpskCb8A-1; Tue, 16 Apr 2024 12:09:55 +0100
X-MC-Unique: LPfE2IzbO0utuOqpskCb8A-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 16 Apr
 2024 12:09:27 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 16 Apr 2024 12:09:27 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Segher Boessenkool' <segher@kernel.crashing.org>, Naresh Kamboju
	<naresh.kamboju@linaro.org>
CC: Nathan Chancellor <nathan@kernel.org>, Anders Roxell
	<anders.roxell@linaro.org>, Linux Regressions <regressions@lists.linux.dev>,
	Arnd Bergmann <arnd@arndb.de>, clang-built-linux <llvm@lists.linux.dev>,
	"Nick Desaulniers" <ndesaulniers@google.com>, open list
	<linux-kernel@vger.kernel.org>, "lkft-triage@lists.linaro.org"
	<lkft-triage@lists.linaro.org>, Aneesh Kumar K.V <aneesh.kumar@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Dan Carpenter
	<dan.carpenter@linaro.org>, Kees Cook <keescook@chromium.org>
Subject: RE: powerpc: io-defs.h:43:1: error: performing pointer arithmetic on
 a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
Thread-Topic: powerpc: io-defs.h:43:1: error: performing pointer arithmetic on
 a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
Thread-Index: AQHaj+s965G0tAMqzUOctdh7rJqb8rFqvAFg
Date: Tue, 16 Apr 2024 11:09:26 +0000
Message-ID: <1d0de2bee67643bfa5a561e70133db75@AcuMS.aculab.com>
References: <CA+G9fYtEh8zmq8k8wE-8RZwW-Qr927RLTn+KqGnq1F=ptaaNsA@mail.gmail.com>
 <20240416103819.GQ19790@gate.crashing.org>
In-Reply-To: <20240416103819.GQ19790@gate.crashing.org>
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

From: Segher Boessenkool
> Sent: 16 April 2024 11:38
>=20
> On Tue, Apr 16, 2024 at 03:02:52PM +0530, Naresh Kamboju wrote:
> > In file included from arch/powerpc/include/asm/io.h:672:
> > arch/powerpc/include/asm/io-defs.h:43:1: error: performing pointer
> > arithmetic on a null pointer has undefined behavior
> > [-Werror,-Wnull-pointer-arithmetic]
>=20
> It is not UB, but just undefined: the program is meaningless.
>=20
> It is not a null pointer but even a null pointer constant here.  It
> matters in places, including here.
>=20
> It would help if the warnings were more correct :-(

Isn't it only a problem because the NULL pointer isn't required to
be the all-zero bit pattern?

So when do we get a warning from using memset() on a structure
that contains pointers? Since it is equally buggy.

Has anyone ever seen a system where NULL wasn't 'all zeros'?
I've used a system where the 'native' invalid pointer was 'all ones',
but even there the C code used 'all zeros'.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


