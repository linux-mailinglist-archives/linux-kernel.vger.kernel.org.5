Return-Path: <linux-kernel+bounces-7299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796F481A526
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB17F1C223AC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9534644D;
	Wed, 20 Dec 2023 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="fticxRyy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FC037869;
	Wed, 20 Dec 2023 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=bzJ4EnCvZqQsZfO+pv4OGbyLedjWTc2W50qS42BS5Jc=; b=fticxRyyvM1O3XKb+WoaOoifSw
	Yc8URZL5JoiYFQjffx0UV+1hC0eQU3rwpqDZkwJV3wB/qSRslrhu91JHRrWM57DNdga4E0y/1W2y5
	yIgNddsTQqlKgkaCGHiNCU/6btpYjVomn/vFAo5peGNCMIUWJjS/qyXjh5xi2kk7LCXs=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:41850 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rFzSS-00077N-8c; Wed, 20 Dec 2023 11:30:08 -0500
Date: Wed, 20 Dec 2023 11:30:07 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
 kubakici@wp.pl, phil@raspberrypi.org, bo.svangard@embeddedart.se,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Message-Id: <20231220113007.c52b01fb215e38f5d2e75086@hugovil.com>
In-Reply-To: <ZYMPMK2NqGByJnRa@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
	<20231219171903.3530985-17-hugo@hugovil.com>
	<ZYMPMK2NqGByJnRa@smile.fi.intel.com>
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
Subject: Re: [PATCH 16/18] serial: sc16is7xx: reorder code to remove
 prototype declarations
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Wed, 20 Dec 2023 17:58:40 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Dec 19, 2023 at 12:19:00PM -0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Move/reorder some functions to remove sc16is7xx_ier_set() and
> > sc16is7xx_stop_tx() prototypes declarations.
> > 
> > No functional change.
> > 
> > sc16is7xx_ier_set() was introduced in
> > commit cc4c1d05eb10 ("sc16is7xx: Properly resume TX after stop")
> 
> Missing period after ). Otherwise LGTM.

Will add it for V2.

By the way, when you say LGTM, would you suggest that I add your
"Acked-by" or "Reviewed-by" tag, after having fixed what you mentioned?

Hugo Villeneuve

