Return-Path: <linux-kernel+bounces-29563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E720831043
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16521C219B8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BEF29A2;
	Thu, 18 Jan 2024 00:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="xX3Ez3sn"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F706658;
	Thu, 18 Jan 2024 00:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705536064; cv=none; b=ki6wX9o+MysuPbCSPl72aZtMGlcPQVXEAe6grXcq0QTrUXJ4olMpCytjmSM/0NGRlCCuek1c76dsq0/zYTEDfBs71AnQNtU0s23lH0ejCXr9Ev3pxmCEC4tI/j51T1Q/v+O7znYigeL07rnYhGA4Fhe0F7Gsbzx6BLki8ZCJIlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705536064; c=relaxed/simple;
	bh=tndJafYULO15WVylyBbhF32eQv4wU0wthZrfJDnC8Qo=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:
	 X-Spam-Checker-Version:X-Spam-Level:X-Spam-Report:X-Spam-Status:
	 Subject:X-SA-Exim-Version:X-SA-Exim-Scanned; b=pm9zMtEKk6P5JmDnZ1W8s/SFHu40MowcEl+F4w/vPKERLZlIRLUIMTg5X5fBFTMCTe4G/Z3/BmLDNalIl3w9691SVgFXeNiEq8Mrjdl0HZNMBymb/LOXyMLeFvKyH4MaRFjgawbSJ3ormV04lnIf1HtbzCL5MPBTGvwF6mWboXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=xX3Ez3sn; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=vTG+SZV7VHmwDGhcCZdpEQ2H4RtxkfxH361qRtliDTI=; b=xX3Ez3sndcUmbasNUjPDQ4O3oq
	vS2G7rEd98SaJPwiFWzXUsBz8IJW0T/LOIkYmIaQ+lgpU1usMJdkbpKrBtQFIpeTWb00j/CmaximW
	UKDgZidaV9oCFhS6v1T4Ej8NNUfP5qRqjMDCCMgUfPWTaSJKpcwbkC52jN+J882om+fk=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:35334 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQFq3-0001yz-8w; Wed, 17 Jan 2024 19:00:55 -0500
Date: Wed, 17 Jan 2024 19:00:54 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 cosmin.tanislav@analog.com, shc_work@mail.ru, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20240117190054.b6d24d64abefc1dc7147edda@hugovil.com>
In-Reply-To: <CAHp75VdxP4pZGEP0drhXvpgATH8q96OEWieBuMb2+-aGKprUzQ@mail.gmail.com>
References: <20240117223856.2303475-1-hugo@hugovil.com>
	<CAHp75VdxP4pZGEP0drhXvpgATH8q96OEWieBuMb2+-aGKprUzQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	* -1.7 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH 00/18] serial: max310x: cleanups and improvements
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

Hi,

On Thu, 18 Jan 2024 01:26:59 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Jan 18, 2024 at 12:39 AM Hugo Villeneuve <hugo@hugovil.com> wrote:
> >
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >
> > Hello,
> > this patch series brings a few clean-ups and improvements to the max310x
> > driver.
> >
> > Some of these changes are based on suggestions for the sc16is7xx driver by
> > Andy Shevchenko following this dicussion:
> 
> discussion

Will fix in V2.

> 
> > Link: https://lore.kernel.org/all/CAHp75VebCZckUrNraYQj9k=Mrn2kbYs1Lx26f5-8rKJ3RXeh-w@mail.gmail.com/
> 
> Perhaps you may add Suggested-by to the related changes.

Ok, will do for some of the patches in V2.


> > The changes have been tested on a custom board using a max14830 in SPI
> > mode, with an external oscillator (not crystal). Tests included a simple
> > communication test with a GPS connected to UART0.
> >
> > They also have been tested by using i2c-stub to simulate the four ports on a
> > virtual I2C max14830 device, but with obvious limitations as this cannot
> > simulate all the hardware functions.
> 
> ...
> 
> LGTM, except this one (I have commented individually)
> >   serial: max310x: replace ENOTSUPP with preferred EOPNOTSUPP
> >     (checkpatch)
> 
> So, for the rest
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thank you for the review,
Hugo Villeneuve

