Return-Path: <linux-kernel+bounces-128606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42901895D03
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDCFF1F22408
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5471115CD53;
	Tue,  2 Apr 2024 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="eB4ebqY7"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7079D15AAAA;
	Tue,  2 Apr 2024 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712087480; cv=none; b=ldMFyRj6ye+XR1Zs3OuTtRcIwiJOCZ72CezufrGTiGLfeWQyaVEuPqOQ4FD20tKBwOOpQfYRFMp8/Nk1E7kjG7/9yzYYGgrWBj9EnkIC28MiqW1CdptqzkeTECk3E/t/+1TkKYmVISxJuTj2pBvn7XH7LMZadhnni7qzHqb0gdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712087480; c=relaxed/simple;
	bh=bqXSoYZYpoDOlviSuyY8vu24PrI+70YMdminhVwEYNs=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=Ri9ljOsXjYHNw/E97BPVrpj3qMYwcyYCUyDIffA4byI5w+z/ECFYkyZq1bejT6ZHVy+zKOoVo81pqvfPh7jBHmwd1v5WWBLuj3f/NGCKnGYVd/fPHGn8dy7umcmfnoT9CZoO7pVtVDkClA9b4yLxFqGsdfqb0XmS4a9qrPMRXc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=eB4ebqY7; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=9DaXjULJHLZpzhqzyNkkPkEBR6YCb7iZnUxB3ewIuiM=; b=eB4ebqY77eAy5B+wYMKAXdHm8S
	/9LoTwYSrV1tP6OlfY4l436g/XkgNzCgeSFPaTfiTtIz64G5L622/trtFRHJpineY7/EDDf47ngBN
	Va2dUe8AL22iFq5gZE+umzBylvdE20S4I8Wxa9mgwQxXYPZqwupwyXed9yeX8sT8eow0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:50794 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rrkA7-0001Hn-JC; Tue, 02 Apr 2024 15:51:15 -0400
Date: Tue, 2 Apr 2024 15:51:15 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Message-Id: <20240402155115.7aa760a4b7a107003e2b411c@hugovil.com>
In-Reply-To: <CAHp75VedAiB_wSaq+oaNriC3HfLC=ft21O=ZYW_wCARPS7v3QQ@mail.gmail.com>
References: <20240402174353.256627-1-hugo@hugovil.com>
	<20240402174353.256627-5-hugo@hugovil.com>
	<CAHp75VedAiB_wSaq+oaNriC3HfLC=ft21O=ZYW_wCARPS7v3QQ@mail.gmail.com>
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
	* -0.4 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v3 4/5] serial: sc16is7xx: split into core and I2C/SPI
 parts (sc16is7xx_lines)
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Tue, 2 Apr 2024 22:28:25 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Apr 2, 2024 at 8:45 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> >
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >
> > Before, sc16is7xx_lines was checked for a free (zero) bit first, and then
> > later it was set only if UART port registration succeeded. Now that
> > sc16is7xx_lines is shared for the I2C and SPI drivers, there is a
> > possibility that the two drivers can simultaneously try to reserve the same
> > line bit at the same time.
> >
> > To prevent this, make sure line allocation is reserved atomically, and use
> > a new variable to hold the status of UART port regisration.
> 
> registration

Hi Andy,
will fix for V4.

> 
> > Now that we no longer need to search if a bit is set, it is now possible
> > to simplify sc16is7xx_lines allocation by using the IDA framework.
> 
> ...
> 
> > -static DECLARE_BITMAP(sc16is7xx_lines, SC16IS7XX_MAX_DEVS);
> > +static DEFINE_IDA(sc16is7xx_lines);
> 
> Don't we need to replace bitmap.h with idr.h with this change in place?

Yes, but I will replace bitops.h with idr.h in V4 (bitmap.h was not
included).

While at it, I will include an additional patch to replace inlude of 
<uapi/linux/sched/types.h> with <linux/sched.h>.

Thank you,
Hugo.

