Return-Path: <linux-kernel+bounces-9005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BB181BF2D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0631F240EA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0C3651BD;
	Thu, 21 Dec 2023 19:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="pXihLVnJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A1A33988;
	Thu, 21 Dec 2023 19:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=vPc8thH3C7HWk4KTsdpmJPeYei58JpYABE0eXOWLITk=; b=pXihLVnJV0TtPIGJgQBjxclwAX
	5Bb/jRQwN2oSZS2a+1T9sC0aWOcHeWzpzTn46B4/Kek2A5ADwbNIvEUY9wwI1Jwd2jacpt2mULHsw
	jC89PIRAnPmOulL4ayxTfNxdNdJWMPMn5kW3HXc1hGpfA2iDzZZmzv5Euyp/b5oMpgdk=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:51258 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rGOpl-0000GN-VW; Thu, 21 Dec 2023 14:35:54 -0500
Date: Thu, 21 Dec 2023 14:35:53 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
 kubakici@wp.pl, phil@raspberrypi.org, bo.svangard@embeddedart.se,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, stable@vger.kernel.org
Message-Id: <20231221143553.57a180880d30b86257ee9b7c@hugovil.com>
In-Reply-To: <ZYMPBz3BbOzSCEog@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
	<20231219171903.3530985-16-hugo@hugovil.com>
	<ZYMPBz3BbOzSCEog@smile.fi.intel.com>
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
	* -3.8 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH 15/18] serial: sc16is7xx: pass R/W buffer in FIFO
 functions
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Wed, 20 Dec 2023 17:57:59 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Dec 19, 2023 at 12:18:59PM -0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > To simplify function by avoiding cast.
> > 
> > This is similar to what is done in max310x driver.
> 
> ...
> 
> > ---
> > If deemed appropriate for stable kernel backporting:
> 
> I don't think it's eligible.

No problem.


> > ---
> 
> I don't see the necessity of the change, OTOH it's harmless.
> The problem is that commit message is basically "Yeah, we
> do cargo cult." Because I haven't seen what casting you are
> talking about.

I'll try to reword the commit message.

And replace cast with something like "... to remove additional struct
sc16is7xx_port variable..."

Hugo Villeneuve

