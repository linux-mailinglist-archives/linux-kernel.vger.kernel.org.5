Return-Path: <linux-kernel+bounces-7267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8853B81A423
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D564B279C9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2F0495E6;
	Wed, 20 Dec 2023 16:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="D0QMdRem"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F7A495EC;
	Wed, 20 Dec 2023 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=h3wCD3ROBeekL2LK2cv12WSp+pxJN7ZdSftlsllgyzY=; b=D0QMdRemHB0wsSBXdXjXzIm8i3
	aKAf+aFX5FnlC6JikhEJrV2K/0SbFN/HcdrKf6SQ9LQSpmF/yvFv3QQNPJLIRXd59idGPjf8VKbR1
	V49dJh+QY4msOQOXHBhXmSCEvSjMt0GfDRCaYMW3cB69nJ/0pnWwTXnVc0/NkGVd+suw=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:39702 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rFzAY-0006uu-5a; Wed, 20 Dec 2023 11:11:38 -0500
Date: Wed, 20 Dec 2023 11:11:36 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
 kubakici@wp.pl, phil@raspberrypi.org, bo.svangard@embeddedart.se,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Message-Id: <20231220111136.99315587e832190a528f7630@hugovil.com>
In-Reply-To: <ZYMMs5A758h12AEM@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
	<20231219171903.3530985-9-hugo@hugovil.com>
	<ZYMMs5A758h12AEM@smile.fi.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	* -1.4 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH 08/18] serial: sc16is7xx: add driver name to struct
 uart_driver
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Wed, 20 Dec 2023 17:48:03 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Dec 19, 2023 at 12:18:52PM -0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Make sure that the driver name is displayed instead of "unknown" when
> > displaying the driver infos:
> > 
> > Before:
> >     cat /proc/tty/drivers | grep ttySC
> >     unknown              /dev/ttySC    243 0-7 serial
> > 
> > After:
> >     cat /proc/tty/drivers | grep ttySC
> >     sc16is7xx            /dev/ttySC    243 0-7 serial
> 
> "Useless use of cat" (you can google for this phrase, it's famous).
> 
> 	grep ... /proc/...
> 
> will work :-)
> 
> Otherwise LGTM!

Old habits die hard :)

Interesting read!

Will modify commit message in V2.

Thank you.

Hugo Villeneuve

