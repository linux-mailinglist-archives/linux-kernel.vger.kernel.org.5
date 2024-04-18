Return-Path: <linux-kernel+bounces-150071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4558A99FC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9175B211DC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AC738382;
	Thu, 18 Apr 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="MKOAhc4D"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B0D1DA26;
	Thu, 18 Apr 2024 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444028; cv=none; b=nGLKRbx+orPlq1p1uU8wQ62X/oewxYD+v5ZI6SPbP0NhvGQkZfnJ6VNPxDWGbjFhnKSNMpRauoUnCX5+t7sCRVrpQdtGFoeVgk6Q3QhXdwvZq54PkA00htNB1f6ZJUgk31Eup5qNvwamBVU+kYJpYTvNOHMzHnoLXlfdVqCl7cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444028; c=relaxed/simple;
	bh=lAs6euoKWtTMsCQ2XVPCwEyYSxj5FVyRMEjNavkpJY8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Va7Q4ga1mYTD9/Lb2CGepaR63bsuNh7R0NloDa8beP1rx0hICDZyD56cXF/b8b4JDzoaw1OYuwD29zRkoWq6HAe8268ZrF8qk6BcKnudD0NQIaoF5ZfVMzY2bP6FNrXvw58z1T8g/JI06nWEFVc+XAcGSArxZMvpa8V6PwTpEUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=MKOAhc4D; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713444017; x=1714048817; i=parker@finest.io;
	bh=6LjRACjR9FTwEG+uc0H81JIH5+SabjHLe3fRRoHPfAo=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MKOAhc4DBX59T2rCSGMNrL9S/0UXgNEduAPBQ5HtfN7gZvD/RNyWYuBzNUHXoNcT
	 P4j6YC6/cT+Twt1xAABgZ/Khne1L6q/Lav3mKvW+Qnu+k+rq7gnegrkQMWNlu/KOx
	 l9k/1SToTTtLhFi5VuM26UZUGLGm0Rym/UkU9ePGofEUMkpF1x7Zou5NxMJ+AL0HM
	 mR4Ri28QHmWmPWHNNIzxA/Bg7Gi/BzM2jAoeIq7TRWmlv/z4nU9nxfLJFlT5OJQ2/
	 GETDmPCcIveFCzNDBe+42yBRl0lcTpfMkrtWA5QsSLYPEaSItRO/ga8rnjE4hXlEC
	 5SCgmzTzfu/Cnp7MbA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1MpE2t-1sVyBj3Od5-00qmtY; Thu, 18 Apr 2024 14:40:16 +0200
Date: Thu, 18 Apr 2024 08:40:15 -0400
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v4 0/7] serial: exar: add Connect Tech serial cards to
 Exar driver
Message-ID: <20240418084015.5db5a6a1@SWDEV2.connecttech.local>
In-Reply-To: <2024041801-earthlike-drastic-076a@gregkh>
References: <cover.1713382717.git.pnewman@connecttech.com>
	<2024041801-earthlike-drastic-076a@gregkh>
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
X-Provags-ID: V03:K1:XfYM1HfcmvGAgIQ7bGoh0MQhpvPGgEvrU00lAwD1W1kO+AMTap0
 oULVIJUIC74+6Fxws1qWsS9digvMP70o4XhF/rw1cVsh/1CzB2S7327CQSKHp65TEhcWpt+
 mrJDgf8L1WE4KgGP9nw53itza/Cv3h1mZbwfCg8nvXKxSWD7GkuKnYHnWv6G/OkJ+IIkqUR
 AB3nay4KaKrJcb9vCX2JA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eKD3pRiZqFY=;h31ppLCcW88GZ3FaCMxv10M97Tl
 YWCsaMScUFeuuBQs/vCgyfdcUO93HyfLY1COogG3WuMNaGo4TqZdlpRIXae0+0H821w43/UlL
 XySY2K05NVd8eb2So1Lp+SNU2jgSxbUY60VPdOLgdXpDIINA3jtNZPhlq+ngq3CF1YhrjgaJh
 z65WBML4pf8AFbpyvxC5AXgYGYhiFvjv+oP1srqpW5X5Y/JqM3LFbjHCjcF39fcvi1cKIi1S5
 NgM3dnNQiqOAf+bswDfBBubEWRKGlkrgvGE8sNGauVXPcj5nzkiAR373/VnCvs/Jda0MgYDic
 qYUXuwcQyRXlKVEoEncf87YJ/t3VEEj4tV1mZvuYiAywh5L1EL7S6to5mPZOIem3XJ1DdlcST
 BkW5VnTgcJDVynd+0fcjRA6YoD3BlgvR3HGnGBWmc2n49ptlNCs1HmTOIItzEspoa/nzRL3vp
 QNoLxsrE2RciBCmRCy0cDew9C/vzKKZihnVS5Xu3q+Hprnd5LH2IpF3BFiEDa8tJFC/zsmLM8
 DBfvqMu36HBjcSZtgJBcvdkJ/jJEbKUTJzQBD+QIPMw9BjyW2qL60VSoairRwCyfP47sb+1iY
 wRG3ncp+eJ9RYDrieC4sPmZPMgCZDskE98XfFuk0NX5TLmF3OpLbnN6d4LafP1qg1gSpTlcjh
 U/phE9RryWxUpDpK4dqVuxez9BL5FIDypERbyhlcdTHL9SRG1xJvQPyrt5jY76U4QXFQ9gPa4
 Cr5AgU984MyEQzpQy5xzPmqdEoYnEtef3PpstRWbBxix3/QAdsq17M=

On Thu, 18 Apr 2024 08:25:10 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Wed, Apr 17, 2024 at 04:31:22PM -0400, Parker Newman wrote:
> > From: Parker Newman <pnewman@connecttech.com>
> >
> > Hello,
> > These patches add proper support for most of Connect Tech's (CTI) Exar
> > based serial cards. Previously, only a subset of CTI's cards would wor=
k
> > with the Exar driver while the rest required the CTI out-of-tree drive=
r.
> > These patches are intended to phase out the out-of-tree driver.
> >
> > I am new to the mailing lists and contributing to the kernel so please
> > let me know if I have made any mistakes or if you have any feedback.
> >
> > Changes in v2:
> > - Put missing PCI IDs in 8250_exar.c instead of pci_ids.h
> > - Split large patch into smaller ones
> >
> > Changes in v3:
> > - Refactored patches to be easier to follow (based on feedback of v2)
> > - Patch specific changes listed in corresponding patch
> >
> > Changes in v4:
> > - Rebased to tty-testing branch
> > - Removed v3 patch 8/8, "bug" didn't happen in current driver
> > - Patch specific changes listed in corresponding patch
> >
> > Thank you,
> >
> > Parker Newman (7):
> >   serial: exar: remove old Connect Tech setup
> >   serial: exar: added a exar_get_nr_ports function
> >   serial: exar: add optional board_init function
> >   serial: exar: moved generic_rs485 further up in 8250_exar.c
> >   serial: exar: add CTI cards to exar_get_nr_ports
> >   serial: exar: add CTI specific setup code
> >   serial: exar: fix checkpach warnings
> >
> >  drivers/tty/serial/8250/8250_exar.c | 981 ++++++++++++++++++++++++++-=
-
> >  1 file changed, 916 insertions(+), 65 deletions(-)
>
> Nice, compared to your first version, this is less code overall in this
> file:
>    1 file changed, 1019 insertions(+), 70 deletions(-)
>
> so the review process helped!
>

Yes thanks again for your patience. I learned a lot about the process :).

> All now applied to my tree, thanks for the revisions.  And a follow-on
> patch to fix up the kbuild warning would be appreciated.
>

I will follow up with a mini-series now to fix the kbuild warnings and a
couple minor things mentioned by Ilpo.

Thanks,
Parker

> thanks,
>
> greg k-h


