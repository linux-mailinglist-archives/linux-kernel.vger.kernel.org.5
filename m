Return-Path: <linux-kernel+bounces-22859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD9682A40F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E08B22875F3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648E24F88F;
	Wed, 10 Jan 2024 22:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Oy0kMQ1S"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5AC4F8AB;
	Wed, 10 Jan 2024 22:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=jQkbXT4Xowi1pUvDT3eJyshgYO6r+Y/l3CsarSMIz3E=; b=Oy0kMQ1SLcT7pvbxS7wqM7uk5p
	Qq7t8743wKI5BIdoPu/TLDlXenb/DniQt7AMa+5LjVUDE2XvXHgrPUx+5o/N4enh4YE8Lq9C8x0L+
	m81XcR/ifiaSAWAq1fq+QtYn7ZFbMHmnR2L54W1hfvBb5e7B1GLRLe94uW2I5sMIIk6w=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:39930 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rNhGI-0001iS-NK; Wed, 10 Jan 2024 17:41:27 -0500
Date: Wed, 10 Jan 2024 17:41:26 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Rengarajan S <rengarajan.s@microchip.com>, Kumaravel Thiagarajan
 <kumaravel.thiagarajan@microchip.com>, Tharun Kumar P
 <tharunkumar.pasumarthi@microchip.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Message-Id: <20240110174126.a8beefee0e871d61de363018@hugovil.com>
In-Reply-To: <05465217-174e-4888-a6ab-6251f4a9920b@moroto.mountain>
References: <ZZ7vIfj7Jgh-pJn8@moroto>
	<20240110144605.2a8813d4bfaff1a55edb9938@hugovil.com>
	<05465217-174e-4888-a6ab-6251f4a9920b@moroto.mountain>
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
	* -3.1 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v2] serial: 8250_pci1xxxx: fix off by one in
 pci1xxxx_process_read_data()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Wed, 10 Jan 2024 23:19:28 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> On Wed, Jan 10, 2024 at 02:46:05PM -0500, Hugo Villeneuve wrote:
> > Hi,
> > it is not simply a matter of adding "fix" to the title.
> > 
> > You must explain what and why vs. how.
> > 
> > Please see:
> >   https://cbea.ms/git-commit/#why-not-how
> > 
> > for some guidelines on writing a good commit message.
> > 
> 
> If you can't understand why a buffer overflow is bad then I honestly
> don't know what to say...

Hi Dan,
I am also an old quirky guy, and pretty much know why a buffer overflow
is bad :)

My whole point was only related to the title of the commit
message, not the body of the commit message, which explained well
enough the problem and the solution, or the code fix itself.

Regards,
Hugo Villeneuve


> When I was a newbie, I encountered a driver which was written in
> terrible style.  And I thought why do people allow it???  This is
> garbage and it's messing up the Linux kernel with its bad style.
> 
> But after I got older, I realized that he was the only person with that
> hardware and the only person who cared about it.   If I started fighting
> with him about style then he would leave.  He was a quirky guy with bad
> taste but he was still making useful contributions so it was better to
> tolerate him.
> 
> These days I'm the old quirky guy.  If you want to fight with me about
> commit messages, that's fine.  I can easily just add you to my list of
> subsystems which only receive bug reports instead of patches.  (I think
> only BPF is on the list currently because it's annoying to track the
> bpf vs bpf-next tree).
> 
> Feel free to re-write this patch however you want and give me
> Reported-by credit.
> 
> regards,
> dan carpenter

