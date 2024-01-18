Return-Path: <linux-kernel+bounces-30296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484BD831CBF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09FD328432C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492E625764;
	Thu, 18 Jan 2024 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Nzx0ZSJ8"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC46286B1;
	Thu, 18 Jan 2024 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705592691; cv=none; b=oNZZCnbZqiLgTN5vEWBa62YMj2WK+ZfV43Wa2Opl/nQSUY7pKRlRhKX3KQq3AFrN3GvxbzNFih4v35FTF/JGFI2v6hqWoR7VaJE0JEY+socKtiibCuYR51mHkbsCgegn7in/DkUanD1/L5sOrNaOXEhlfpZTqBTmW2CNURWJ6kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705592691; c=relaxed/simple;
	bh=CavptMrepFkGnLQxcqm3tjtRyT9DRUDkSdSAVBe57oQ=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:
	 X-Spam-Checker-Version:X-Spam-Level:X-Spam-Report:X-Spam-Status:
	 Subject:X-SA-Exim-Version:X-SA-Exim-Scanned; b=hbLH2AdugNH29MPcFQzYZlixRT+QzqxQOWMHQojyQ0qvP7EEBV1H/vM+nGOcQ3lrpPj8z05aOrwpgBngH3LfWEgk+3b6qrqXAV+H8cNPaEaVAfb0fXfcFMOaQLgceyblQLBhoRpXclTxQhhPo0n0x2eMJdfUiZa1uJFgtX8lRzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=Nzx0ZSJ8; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=3bL4e55eYzt254U4zqZJd6dYCyF0R+EU3ZczOwUxrAo=; b=Nzx0ZSJ8W3N+e4u2G/bEb3zJhD
	lBfiABFvsy2N+CxRu5NM3llNy2z+83EYjHTaOmfx5bDveR9LO4QPvZtsO6x996m41ONVYJPJb8qeb
	V5diYwz/+J5+OR7688apk8sje4nKKcKCRCmibXLvSxQTUdvMl/15/mue/jZnfXDYBHlc=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:60262 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQUZP-0003BE-Ix; Thu, 18 Jan 2024 10:44:43 -0500
Date: Thu, 18 Jan 2024 10:44:43 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 cosmin.tanislav@analog.com, shc_work@mail.ru, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Jan =?UTF-8?B?S3VuZHLDoXQ=?= <jan.kundrat@cesnet.cz>
Message-Id: <20240118104443.7678d39eafc698a4baeb2ce7@hugovil.com>
In-Reply-To: <CAHp75Vf7j6_xPceGuDWB5Mno2eJreyyD8B4i4GyyiMyKZPiwLA@mail.gmail.com>
References: <20240118152213.2644269-1-hugo@hugovil.com>
	<20240118152213.2644269-9-hugo@hugovil.com>
	<CAHp75Vf7j6_xPceGuDWB5Mno2eJreyyD8B4i4GyyiMyKZPiwLA@mail.gmail.com>
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
Subject: Re: [PATCH v2 08/17] serial: max310x: use separate regmap name for
 each port
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Thu, 18 Jan 2024 17:30:16 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Jan 18, 2024 at 5:22 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> >
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >
> > Use a separate regmap name for each port so they can each have their own
> > debugfs entry, allowing to access each port registers independently.
> >
> > For example, a four channels/ports device like the MAX14830 will have four
> > entries in its regmap debugfs:
> >
> > $ find /sys/kernel/debug/regmap -type d | grep spi0.0
> 
> Just a side note for the future. The above is an example of "Useless
> use of grep".
> `find` has a `-name` parameter for such, using `find ...-name
> 'spi0.0*'` makes the grep unnecessary.

Hi,
yes, I fixed a similar one in the sc16is7xx serie, but forgot to update
this one :)

Will fix it if sending V3.

Hugo Villeneuve


> 
> > /sys/kernel/debug/regmap/spi0.0-port0
> > /sys/kernel/debug/regmap/spi0.0-port1
> > /sys/kernel/debug/regmap/spi0.0-port2
> > /sys/kernel/debug/regmap/spi0.0-port3
> 
> -- 
> With Best Regards,
> Andy Shevchenko

