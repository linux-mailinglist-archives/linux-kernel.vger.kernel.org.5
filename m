Return-Path: <linux-kernel+bounces-151433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 375208AAECD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF187B21E8C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887658565D;
	Fri, 19 Apr 2024 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="d4uqJJ/0"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FA51E878;
	Fri, 19 Apr 2024 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713531026; cv=none; b=a4cy9cS35HwG9sggT/NukiHR5UlSD1GSJVoxHM6aJJ4FLLQTA87DKr3H/p0BAhjy7WwluORDHEei3zs7aDYsGyaedSU1JSWOC6C2ufqgSwGxA0slmdDUgnVJtUjsrOqOHBykVlqdwGoXhE0F+aHbvvkSRXfLcrFg0F+51yOFfTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713531026; c=relaxed/simple;
	bh=yFjYjqQyBQU76LrN+gDKRvv2an/8O8EpQH79UXcUorg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxFgfCK52EruFC3wVpqlF3zfroZarB2+rKeViEsI82zLQOkSMEg52OSeP549yK105pPAv/fRc1Xmm/hVnlUQuuibJ9FOVPWyJc5UcvCYbkAfyCuFh8lVdjS6YdiOSILJu1p3oKG97x69ILFl9Ja9j26DGQuYPOH02xxQ6hHGTZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=d4uqJJ/0; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713531019; x=1714135819; i=parker@finest.io;
	bh=bNY/7hj6dR8JMaNQap3x7uELT9glIvJBuZmmXt2CWDE=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=d4uqJJ/0Z5QyN8tUSgju/HIKzVFj0MpmDHwqkdTMdPcB23Oxm54EQOdMWlj+GkSL
	 zfWohrgpt3Q2Y8N7WqqjND1Iog/gr+edzh8EaZeb129ofA8WIko/HH/QbSlq5cZJy
	 pRXeRgnN3Rx1hZjceh5beBPoZ3ghpaOAysyDvepH9FIKVs2sen2se/O+8Dp/egZCp
	 qnIgUjP6i/EEXz/O635Mq0rp8r8tn4+LEfC3oiRkgKk73EhHnu7d4wlL7TAT3MbEr
	 EZ0B2+inavB4iAGNVnX+pB6ceZV+1jlQH+AyiIuY7s+ieQg7dr8sxguOJiPaO32fC
	 iHQ6nfOo9rPV3iC0mw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1N33hJ-1sjP4o1R2D-013MEI; Fri, 19 Apr 2024 14:50:19 +0200
Date: Fri, 19 Apr 2024 08:50:18 -0400
From: Parker Newman <parker@finest.io>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Parker Newman
 <pnewman@connecttech.com>
Subject: Re: [PATCH v1 3/4] serial: exar: remove unneeded parenthesis
Message-ID: <20240419085018.5a5c5826@SWDEV2.connecttech.local>
In-Reply-To: <4a7a1c35-f1f6-4ed3-ad57-d71891220219@kernel.org>
References: <cover.1713452766.git.pnewman@connecttech.com>
	<1dbe1847d92dd34d223c6dc6b5cd0731b78e98e5.1713452766.git.pnewman@connecttech.com>
	<2024041951-paradox-stable-320e@gregkh>
	<4a7a1c35-f1f6-4ed3-ad57-d71891220219@kernel.org>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nX6MR+9qHH2U4r/xs6zM//xIjgFCdQ8hhVeSjsjCEDKtm6xZihK
 I2+a3JYQccPIm4Cv2S5+AtZdryE/L1xyzByjyqtztFukbx0YbNdmKd0MEc5948YRiRk5BRq
 CZ9Wxhm7qMjUmAZ51+tp2VbHGD3OM+EsXuibK5oO5r4c0+blz45Wlc+8GZ9kerOspzWfNz5
 DPhp5A3Cw9g2Qosovs5Lw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hl9aSz4ph+8=;Dt2eAanbqVuhgV/69Tg9c4UYaHW
 tvKR/ltNSYLIVW+Hae3nIGPcB7M2F+46otcCUYlkbnr6eq+HNV4DN6C0Sn40I/nLhMgKMCBv8
 iCqc1m4FkgGdTdAC4ezkj+5eMYPESxrlnVB8oSaqLoQO0zP/dSY/BuHFR2VvbLlFe9mVmaF/w
 pRzT5nBhwQAn15AO4STwD6PGOQMvEVEUnaYcFADUU7UBd+B/ZGOXEeiSpirPIiKs+vDCmpUPa
 OxFz3fz1ePsfryru0D6b/x3DZRAgh4LLYPXo8YEE00YxuEsuVEF3pEOPvyGEQOl+eocpp4kCf
 b9zfOAxLO83yUWZ9qMY2s9fSZVwrQ8OC28HILfhL4Zto4xpGax4PrtrSSw8hmW8nNm4Zb/hBA
 2c9UM/6hjtylpLk1+3ZtWx7Vhb52d6AjF3V4sb6SCiDiq9I1Zd4s04FSRn+r9+OlG5uHNnI0w
 5AhfxQFY3q0inxXXxKB0SztKAzrizj5tSQIOVxWwZgbF63pVww76C3fmry/xbEOADoOpAdIZ/
 pWwCrhlnCCUnYr/U5vOO7ObfhJSpn9RoDRyURuuv2weKpASoGcNBDx1LN4Huf2ac6/FWogepv
 ucYEVfbdp9nQi8qM6fbPqRuoG2mwEXQbD6ZVkVFoVBWqkRnDjyYwVtTLjF4V65qT/9HKxVMLK
 dN7WLlu5E+WHaiVZnbzUSH6fHV9O3Ohnc4F82cDFYoNm9iib8JGwNggKJFjjtTVyIWFSTgeu4
 gS16xn096qr3TJ+hnoi9FglXhW4WUZ8NoyaPYqT4Xd3e4sCKplDXzU=

On Fri, 19 Apr 2024 09:01:22 +0200
Jiri Slaby <jirislaby@kernel.org> wrote:

> On 19. 04. 24, 8:58, Greg Kroah-Hartman wrote:
> > On Thu, Apr 18, 2024 at 11:36:30AM -0400, Parker Newman wrote:
> >> From: Parker Newman <pnewman@connecttech.com>
> >>
> >> Remove unneeded parenthesis from several locations.
> >>
> >> Based on feedback from:
> >> Link: https://lore.kernel.org/linux-serial/f2353b8c-2079-b895-2707-f6=
be83161288@linux.intel.com
> >>
> >> Signed-off-by: Parker Newman <pnewman@connecttech.com>
> >> ---
> >>   drivers/tty/serial/8250/8250_exar.c | 28 ++++++++++++++------------=
--
> >>   1 file changed, 14 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial=
/8250/8250_exar.c
> >> index 01748ddbf729..10725ad0f3ef 100644
> >> --- a/drivers/tty/serial/8250/8250_exar.c
> >> +++ b/drivers/tty/serial/8250/8250_exar.c
> >> @@ -317,7 +317,7 @@ static inline u8 exar_ee_read_bit(struct exar8250=
 *priv)
> >>
> >>   	regb =3D exar_read_reg(priv, UART_EXAR_REGB);
> >>
> >> -	return (regb & UART_EXAR_REGB_EEDO ? 1 : 0);
> >> +	return regb & UART_EXAR_REGB_EEDO ? 1 : 0;
> >
> > Again, spell out the ? : stuff here please.  Using () isn't the proble=
m :)
>
> Could this in fact be inline bool exar_is_ee_set() (or alike) and return
> that regb & UART_EXAR_REGB_EEDO directly (w/o using ternary at all)?
>
> thanks,

That would work. I will update.
Thanks,
Parker

