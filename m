Return-Path: <linux-kernel+bounces-168093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3218BB393
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33EED28595A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8DB158865;
	Fri,  3 May 2024 18:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="N5W60pLl"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97F215884C;
	Fri,  3 May 2024 18:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714762616; cv=none; b=aGntvuiuU2ujiJBt+xsBhdt9qExP7lM1z8LqVxc6op+/hlAuKeUmD+L7ZXPV1jnTfa7RS64jLavtaV02n+AKYEooMETLlQo0DumnDCFeuactlolzZwDzdjxh70D5aW2BwFI9S18kocThVHEvdS0mswdL01cBH3EzjIxpk+qQlDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714762616; c=relaxed/simple;
	bh=wJ634xpkzIW5+9cg7GtEgMU2T9hlxHpUT5PrKa7/e40=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hhn2XIgiMMI7Ta+bTskhJBnSRcSHUXRFisClaFvF5TTo+/cNmZK+mtxjACgvyta0iAVQLNIihDWlv5gsPg3i6VO0hdnlviQTDDUYFnwWEcPacoKeCJRxH5Or5EILBGIYBThQkwjQz4SduJxguxVYlo5ZKaXNnkdYJdZakDOiyZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=N5W60pLl; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1714762595; x=1715367395; i=parker@finest.io;
	bh=6jD/844a5M7wlwxOsH8KRJLg5R5CU6wJg3iF2lJi4n0=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=N5W60pLlJLl/P+B7DtyS444/0ckFwnMmovbc6bmFL8ZlcTSAnQg4i1LDMVs0rRG7
	 iKYdMl+FTpXuU8KFdj5vLCUHbrSQQh1eQHxLRwBkB3gRlJiUMuUz/tsTiQH90gq1e
	 kJjBjn4Sd0HGGxSlU1J5a6bKB0IH7M9uIpsSLp7ICsgdSK2yA+HpcSXsUpScrQy1J
	 DxExWPy3Ly+j/xkjGPqh4i7FFr+Hye0gF5pRWmRdmrrZ+anWplqz1XUtFdUGo7jqB
	 z8ocuJCPcjRg6pNNiPGUr5lqH4itt7VS2AXnQAo20ZKpF1CPdj14I8aIEDfybwP4O
	 eGGm0vNKR8rxJh4W5A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0LxhYD-1sjCVE00Wx-017GzL; Fri, 03 May 2024 20:56:35 +0200
Date: Fri, 3 May 2024 14:56:33 -0400
From: Parker Newman <parker@finest.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Parker
 Newman <pnewman@connecttech.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-serial <linux-serial@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 11/13] serial: 8250_exar: Use BIT() in exar_ee_read()
Message-ID: <20240503145633.1ad55378@SWDEV2.connecttech.local>
In-Reply-To: <ZjUEURneUmZ4nmbC@smile.fi.intel.com>
References: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
	<20240502144626.2716994-12-andriy.shevchenko@linux.intel.com>
	<702a9145-5bc1-c765-a1fa-278702741637@linux.intel.com>
	<ZjPLQeTEKvt7B3mj@smile.fi.intel.com>
	<20240503102632.112a34bd@SWDEV2.connecttech.local>
	<ZjUEURneUmZ4nmbC@smile.fi.intel.com>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cLVJIpyEfukT7LHtxza3jwsgSVQAv89BtasT0nnie4B6k/uh3Wn
 MN2xos2eIgojKXgZlDmDHW3cdHH3EFB5zFJq0FGPf5yIP3iXRvLHvG5oqQaJ7IcBwGA80GF
 yRYmnPe3XBSwRspHA+0noB0Z1cb4GrW7VtD5FCZyMXqKXKNVmluJ+9RyADCHJFKhOSxRSd6
 6uf8O04as/SkHttot+zvA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zDp5WcS2eQM=;TSYrBciSm/jwQqbvmJA0qfCe+NU
 r3LkB5LaQkBs7ICgII1lBFUXPyymwsroAoPflGcIzdF2dksMjyFYjF9zVr812RRGGDBISC8Mf
 UcGlzImEEHT02Y0W72WVQixhWO3PbRGMZO8Zoz+ZP8oLzi71E9mJinbtkaAHTotzqNuQF9ZLQ
 MsMv5apOSxW2Utu9jjYW8+YEnYXEbeXf9z2Ksjv+S1+jFh7N+ftLkRWI2rknvwqiq4fwYbQOH
 YTnio80b8DL8xnmFWDULBaWc5yu1kOuq6XzPbOumTNIBVxBShzsZQPJldTFjZPogXRsNaSEXH
 I5Qd5I52psTm2jO/V+bPsBNTQv5kE4kMOQ6l1iYmFZcGmDcg+QvuSj/D6ZKBdBkJG5vsg9OYE
 2vIftqczONnZ9A3iZ4EBsDDsbF6uJjRnSU4XyOYNGPvgEXGqwn2VvqRx0u/u8R4JvvyvbCPKT
 VU9H6A7kiD1fXqAtR1nTDDHBcF+SGAF27d0+xOTtTM13hrlwkE7iM5fCNc/X/mEkjBz0ywgGj
 bEdz5FyBQXjZxDa0OhSQTTUcT7VOPhMpbQzGmcrOFsqzgHYkqZfOoxMkeUrOlPJSukmA+0Hhe
 VLattDaWR3yIvztXp9MZp1+R0Yo31GxXsEsz0yCiH6F7E16SJCnBCtxRZ44UvW7jIFEzOWSlV
 yE8zModPoVoCF43kAPBCIlz2+UtQmxZRgCb0cgQXNmprgKpCLuHAx2aV1DR/GgLMPJrjAUmoS
 PDuYkBDD6Dreh7przY0/nYvOnNxvRT/PYPCxNyhpw5us+jXmtEl7WM=

On Fri, 3 May 2024 18:35:45 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, May 03, 2024 at 10:26:32AM -0400, Parker Newman wrote:
> > On Thu, 2 May 2024 20:20:01 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote: =20
> > > On Thu, May 02, 2024 at 07:08:21PM +0300, Ilpo J=C3=A4rvinen wrote: =
=20
> > > > On Thu, 2 May 2024, Andy Shevchenko wrote:   =20
>=20
> ...
>=20
> > > > >  	// Send address to read from
> > > > > -	for (i =3D 1 << (UART_EXAR_REGB_EE_ADDR_SIZE - 1); i; i >>=3D 1)
> > > > > -		exar_ee_write_bit(priv, (ee_addr & i));
> > > > > +	for (i =3D UART_EXAR_REGB_EE_ADDR_SIZE - 1; i >=3D 0; i--)
> > > > > +		exar_ee_write_bit(priv, ee_addr & BIT(i));
> > > > > =20
> > > > >  	// Read data 1 bit at a time
> > > > >  	for (i =3D 0; i <=3D UART_EXAR_REGB_EE_DATA_SIZE; i++) {
> > > > > -		data <<=3D 1;
> > > > > -		data |=3D exar_ee_read_bit(priv);
> > > > > +		if (exar_ee_read_bit(priv))
> > > > > +			data |=3D BIT(i);   =20
> > > >=20
> > > > Does this end up reversing the order of bits? In the original, data=
 was left
> > > > shifted which moved the existing bits and added the lsb but the rep=
lacement
> > > > adds highest bit on each iteration?   =20
> > >=20
> > > Oh, seems a good catch!
> > >=20
> > > I was also wondering, but missed this somehow. Seems the EEPROM is in=
 BE mode,
> > > so two loops has to be aligned.
> > >  =20
> >=20
> > I just tested this and Ilpo is correct, the read loop portion is backwa=
rds as=20
> > expected. This is the corrected loop:
> >=20
> >     // Read data 1 bit at a time
> >     for (i =3D UART_EXAR_REGB_EE_DATA_SIZE; i >=3D 0; i--) {
> >         if (exar_ee_read_bit(priv))
> >             data |=3D BIT(i);
> >     }
> >=20
> > I know this looks wrong because its looping from 16->0 rather than the=
=20
> > more intuitive 15->0 for a 16bit value. This is actually correct howeve=
r=20
> > because according to the AT93C46D datasheet there is always dummy 0 bit
> > before the actual 16 bits of data.
> >=20
> > I hope that helps, =20
>=20
> Yes, it helps and means that we need that comment to be added to the code=
 Is
> it the same applicable to the write part above (for address)? Because AFA=
IU
> mine is one bit longer than yours. Maybe in the original code is a bug? H=
ave
> you tried to read high addresses?

The address portion is 6 bits, nothing extra, so what you have is correct.

The original code was legacy, I cleaned it up but didn't change those loops=
=20

Your method works out the the same number of bits as the legacy method
which sets bit 5 and has to shift right 6 times to get i =3D 0 which ends t=
he loop.

Parker

