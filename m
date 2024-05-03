Return-Path: <linux-kernel+bounces-167772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CCF8BAEF9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32461C216FB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF25154BF3;
	Fri,  3 May 2024 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="CEICGNm3"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E1618C3D;
	Fri,  3 May 2024 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714746405; cv=none; b=l2ug0QkFqBUUgdsKpPBehs4+0fCDO5op58fEoLishst8KLTuyBjK+25RfsSqJrvzbMCb21F+WmmprHCwdOVg0aJkIP+sdMXqqQ2BtYybjnP+QJHYFXIuL6p7RtKpN1LcLNpdsIwLlXLNx6IKomr+UgeJYS1Jcu+PaLxogqDNIgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714746405; c=relaxed/simple;
	bh=VRjQzG8TQv5gV0C3Rxv5HRYKNeCIuch5dLMNR1+wUgY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSPDj15hRSyhL5WczCh3jbhj+kK5u149yGH2Rep9VirxG0GvE/D9Cn4LpcDZsyFMarzUUeaQeVSX+D+Qwwa9PBhGZeIgO9Peaq9ihbp+jG2HbmrWhcgrC2jD4xVjYcmKNXD6xJepIQEq+PXbOvCBkwCKUKI+fMWzIFOOzMF2dHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=CEICGNm3; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1714746395; x=1715351195; i=parker@finest.io;
	bh=qUfNnCg79Uktap5ZMBiA0j0ZtbeQ48ApVbCwVGMRNWU=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CEICGNm3L6S7psFtqiPdUDY0X5qoDjmKTqFlHUrakkKb196KClhQKiUwxM3nJPnO
	 tNcGMxp8zqscuhnhF5KpDA5Qv+SS+IRwPXuFqTQ7vBNY6wJ0YBzZS0qCr8uJ/iE8k
	 WMkbbf3wXCxTtnOZhW4nbndg4DF80ShJY4GVmhAAUH664zdFZQcnqpVZqSnGGiY57
	 sQ+dhRH3eexL9XnMaIFdbWCPLYAlbV37b4pesX3FE7YE/oniFp5zF+pUJjd5cCEFI
	 kmObEeepqhiFiEioMtM82dD+ZxGmFvwytBOH0IL/RXoeIGDhf6cJ875DiTZG0hKDs
	 5Fpu6nkPi8fCnh3MLg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MCKl5-1ruLIR3F45-0097wH; Fri, 03 May 2024 16:26:34 +0200
Date: Fri, 3 May 2024 10:26:32 -0400
From: Parker Newman <parker@finest.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Parker
 Newman <pnewman@connecttech.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-serial <linux-serial@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 11/13] serial: 8250_exar: Use BIT() in exar_ee_read()
Message-ID: <20240503102632.112a34bd@SWDEV2.connecttech.local>
In-Reply-To: <ZjPLQeTEKvt7B3mj@smile.fi.intel.com>
References: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
	<20240502144626.2716994-12-andriy.shevchenko@linux.intel.com>
	<702a9145-5bc1-c765-a1fa-278702741637@linux.intel.com>
	<ZjPLQeTEKvt7B3mj@smile.fi.intel.com>
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
X-Provags-ID: V03:K1:BZqodeJrrjLNWsR+BGJEWQCKDTJkZYkEqljtAekrB2HHvKhc3Lj
 +l4I2D+Sc/oPvLN7mD9XzJFLY4c3hYClJLkvhRakkg9WfD+LtMomRsFfUvbYyZBAlxIfE0b
 Prxx0Kgr8nigkDqIvhFsVI4iGRBxquobU5LleKgFQBdgdBbud9qDv2tCIfpYfr3VIrjWpxl
 luj7x67xNlbzGAvbkRgtA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hw/IaLlh8sI=;BvyzJB1ag/J7juyaFuRSiqM2srX
 1Fvy9ykiwlh0bHBqoxdRlkaVJsuVVBI2VIcZ+ist/JeCBXH2YkmAC2pM/5x12HGboxi5r46dp
 XZcSexsbCbY+5TPmE5UPzJSn41DEOYddYwm9UPNK9OWg2Dprpd0GGCjjJAg/wE7RsR16WKWt8
 NkhhDvHz8GYgn5RqBpSHiQ0b9zwRSt1RA3oiDvBEWmIKXbrszKddaGY1kHoFCWpFOK/Rzmjak
 dMGzEjbC7LISFY/xTyC5m+zIxrwp6NYMe0fzw/Y6Or4aceVndQZo1h2MOKhvy+Je+IF/wvfd4
 eCQIEeBBaU4rJCOPGW9cislu9syUDeEDzATxnoiNarqGoY6YiLcRtn+tD3PMy9umrhhsIdcQx
 HgC1SyZZhyK1t2xYx+bomuFSAK3q3YfeuNVwRmvYi4xvwT7bqNrgmodS8aTthKoEBSr5ucTzw
 wKV9AJOcdlV59BaSR75B85J6eePeXqrmApxDQrAJpp+FC5txB4v88NFgUomFiEGHu4RJ1rNEI
 LNG6hx4NiEi9GKbjWH9yas23UE1aDHw93wyFw/BYgQ4Rgt9oQs/uxCCuptYiH4wCh8NQ4jxC3
 2xYADNW6faz3uLZEtq3mk1knFElVd7GknnXegYmDqQMIAMEdh+JheqOUDe9jagsRhS3qTSeQR
 pEDE8hQtC/sp5rJOSgsys2l61hWtP92150EuhBRtpb1hA4V4rokOj9qOzK5xKP/mWbuEyM1Ol
 b2O1tfvhV86nZ05oq9rzmIDJ5+VN8UaeIi/sMuAD2zMqP08V2s/9do=

On Thu, 2 May 2024 20:20:01 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, May 02, 2024 at 07:08:21PM +0300, Ilpo J=C3=A4rvinen wrote:
> > On Thu, 2 May 2024, Andy Shevchenko wrote: =20
>=20
> ...
>=20
> > >  	// Send address to read from
> > > -	for (i =3D 1 << (UART_EXAR_REGB_EE_ADDR_SIZE - 1); i; i >>=3D 1)
> > > -		exar_ee_write_bit(priv, (ee_addr & i));
> > > +	for (i =3D UART_EXAR_REGB_EE_ADDR_SIZE - 1; i >=3D 0; i--)
> > > +		exar_ee_write_bit(priv, ee_addr & BIT(i));
> > > =20
> > >  	// Read data 1 bit at a time
> > >  	for (i =3D 0; i <=3D UART_EXAR_REGB_EE_DATA_SIZE; i++) {
> > > -		data <<=3D 1;
> > > -		data |=3D exar_ee_read_bit(priv);
> > > +		if (exar_ee_read_bit(priv))
> > > +			data |=3D BIT(i); =20
> >=20
> > Does this end up reversing the order of bits? In the original, data was=
 left
> > shifted which moved the existing bits and added the lsb but the replace=
ment
> > adds highest bit on each iteration? =20
>=20
> Oh, seems a good catch!
>=20
> I was also wondering, but missed this somehow. Seems the EEPROM is in BE =
mode,
> so two loops has to be aligned.
>=20

I just tested this and Ilpo is correct, the read loop portion is backwards =
as=20
expected. This is the corrected loop:

    // Read data 1 bit at a time
    for (i =3D UART_EXAR_REGB_EE_DATA_SIZE; i >=3D 0; i--) {
        if (exar_ee_read_bit(priv))
            data |=3D BIT(i);
    }

I know this looks wrong because its looping from 16->0 rather than the=20
more intuitive 15->0 for a 16bit value. This is actually correct however=20
because according to the AT93C46D datasheet there is always dummy 0 bit
before the actual 16 bits of data.

I hope that helps,
-Parker

