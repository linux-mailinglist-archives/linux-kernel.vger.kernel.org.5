Return-Path: <linux-kernel+bounces-126643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B9C893AD5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239DE281854
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F12374C1;
	Mon,  1 Apr 2024 12:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Si1v+Kuy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JMfqEmjQ"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFB236B00
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 12:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711973887; cv=none; b=dSg1ffhND9j0UERLWjnkQOF6/BFOwGq8wbJsH7gzaX1AZRgWk6VRwmO8t/yIa/ho8Nxd6/KAj385cOyucE7AnngtRKu4RhGvPB5yzQT8xCSgNjxtoXVU2NbkTmJM9uqrtItSVox98/TurI9Jq+7B6eCf5QHH9h8N/ZWzdDtWIzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711973887; c=relaxed/simple;
	bh=MRGP5l1gSutLdKAGgSndTHEiRU6q2J7pxKy0toES4KY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCeyvS+gMz+BGK6oWJo8W5Inyp9SXKbNmlpGpxzf2LT5+w9dyiIHJyQWtoMuP4aDRpN8hfPWTkG55etFUfhaNfeYfty/l69ixGMr7AWGmg7hscjP2pJ3FgiHBmcDHw2aMdgJI1pi94iXc3/Zsbij5bJkR3Fa1gWCofc9AMdmC6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Si1v+Kuy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JMfqEmjQ; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 16AF83200392;
	Mon,  1 Apr 2024 08:18:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 01 Apr 2024 08:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711973883; x=1712060283; bh=g4lS9ILyqS
	T7PkjkOHUCDq9lcMtSt7QUR+20QTUdfgA=; b=Si1v+KuyaYPkEx2Zb/r2qzwS2b
	91Y0YMIrI+bnud0PdRCUzTq4Ie22Y6lHGMxhuzvTdvva/3q7TNNewsz4+uUgUGJt
	zEYkS0gDo5i6Awx0ohrJNooIlsFSPsm1RIgWF630flBbq3onQLt0tJ2ZcgWIKTCc
	UIZyi5itwfPZjcumwI+Sfwgk0B16N7l7PfLhHVAggWePqncCbSreBIBfHeUygCwD
	Xdr3VvkFgF+9C5/Sc043n4H5ZNBsBqN+kWZhEUVb9ZSKk4VNXMfPB1JEzlkainic
	LMnlJrWBnelaWrmfobSQF5+M4NT+5QsuiB/Sl6//2bftaNlgVOV2mymDLT0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711973883; x=1712060283; bh=g4lS9ILyqST7PkjkOHUCDq9lcMtS
	t7QUR+20QTUdfgA=; b=JMfqEmjQCRWC8DtDwt1eAr15DlEY17yDdiTPDZt09DBP
	7XsxY1ukXytv9J9wkb2qcDhjrVhapSbkaGCmaiT35y/s0Zx9CYdOJ9V2y1OanuHu
	cw1+jPeNYsavLJJeNZeQBttW0dqsLrezP9u+yZL/5MU7TzbEo0/wIiYi1rF4mS8Y
	PWR8ciIyP2RzlO0sbMgqX9r1WGZa4zQ+GTJYpg6Bq1zqvj8DeUCbmfoX3wHYQj9a
	R+JzTG0v2ZX05r9GePuZDqRUiZkkNHqSC5qzXC/tHB8am2LuunmHj0FgIXUm/yBP
	4wwyAhNQVEy/Gz6NKYbl41wSsVzOAh1hLJVZYW3eKg==
X-ME-Sender: <xms:-6UKZvpM3EmjyXBi8n_PkVkRy50UzDkDo-DasCqQ3kzlaU83SJu1bQ>
    <xme:-6UKZpp-Y2pcx_yn4MOgb3NGEed5db2f9oPOc_YnqBqmKbsNofIRZOK9feT2gsQXG
    m9i-r6JDtdqfnaEXU8>
X-ME-Received: <xmr:-6UKZsObc-lsTONR1tr3Zqs3Eu_keQOU0Kxm4wLSsIDEl01HZmfRMTezuBJtimbEdIOLCeO9oyPreTgAn_eU7QCVXcjKlqc3bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeftddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeejgeeifeeuveeufeeigeegjeelvdfgjeegffejgfdv
    keelhefgtdefteejleekjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:-6UKZi7w0TqWaB758z4q_BgxAWTYbQ23MXtAqtHrnYEnP-qw28f_Fg>
    <xmx:-6UKZu5b2DMKUbEVW1S79XmPLBRiTjLl4DeeW7cofw62t4YoQvcP6w>
    <xmx:-6UKZqiUBRrx9Xx4Inu1biDgNCnLHpnnriNPyxw6U3822lZ1LUzWAg>
    <xmx:-6UKZg7NbEUIB5bOdXmy1PY-fsScKqX_F6aVkKPgyJui13EXKRHGQg>
    <xmx:-6UKZknn_IvXCJq3aKk6UFVMt5P8WV_s8Nqq4dopR4OeIQHSK2EMwQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 08:18:02 -0400 (EDT)
Date: Mon, 1 Apr 2024 21:18:00 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Adam Goldman <adamg@pobox.com>, linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: ohci: mask bus reset interrupts between ISR
 and bottom half
Message-ID: <20240401121800.GA220025@workstation.local>
Mail-Followup-To: Adam Goldman <adamg@pobox.com>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <ZfqpJ061hLtPT8XL@iguana.24-8.net>
 <20240325005828.GB21329@workstation.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325005828.GB21329@workstation.local>

Hi Adam,

On Mon, Mar 25, 2024 at 09:58:28AM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> On Wed, Mar 20, 2024 at 02:15:19AM -0700, Adam Goldman wrote:
> > In the FireWire OHCI interrupt handler, if a bus reset interrupt has 
> > occurred, mask bus reset interrupts until bus_reset_work has serviced and 
> > cleared the interrupt.
> > 
> > Normally, we always leave bus reset interrupts masked. We infer the bus 
> > reset from the self-ID interrupt that happens shortly thereafter. A 
> > scenario where we unmask bus reset interrupts was introduced in 2008 in 
> > a007bb857e0b26f5d8b73c2ff90782d9c0972620: If 
> > OHCI_PARAM_DEBUG_BUSRESETS (8) is set in the debug parameter bitmask, we 
> > will unmask bus reset interrupts so we can log them.
> > 
> > irq_handler logs the bus reset interrupt. However, we can't clear the bus 
> > reset event flag in irq_handler, because we won't service the event until 
> > later. irq_handler exits with the event flag still set. If the 
> > corresponding interrupt is still unmasked, the first bus reset will 
> > usually freeze the system due to irq_handler being called again each 
> > time it exits. This freeze can be reproduced by loading firewire_ohci 
> > with "modprobe firewire_ohci debug=-1" (to enable all debugging output). 
> > Apparently there are also some cases where bus_reset_work will get called 
> > soon enough to clear the event, and operation will continue normally.
> > 
> > This freeze was first reported a few months after a007bb85 was committed, 
> > but until now it was never fixed. The debug level could safely be set 
> > to -1 through sysfs after the module was loaded, but this would be 
> > ineffectual in logging bus reset interrupts since they were only 
> > unmasked during initialization.
> > 
> > irq_handler will now leave the event flag set but mask bus reset 
> > interrupts, so irq_handler won't be called again and there will be no 
> > freeze. If OHCI_PARAM_DEBUG_BUSRESETS is enabled, bus_reset_work will 
> > unmask the interrupt after servicing the event, so future interrupts 
> > will be caught as desired.
> > 
> > As a side effect to this change, OHCI_PARAM_DEBUG_BUSRESETS can now be 
> > enabled through sysfs in addition to during initial module loading. 
> > However, when enabled through sysfs, logging of bus reset interrupts will 
> > be effective only starting with the second bus reset, after 
> > bus_reset_work has executed.
> > 
> > Signed-off-by: Adam Goldman <adamg@pobox.com>
> > ---
> > 
> > --- linux-6.8-rc1.orig/drivers/firewire/ohci.c	2024-01-21 14:11:32.000000000 -0800
> > +++ linux-6.8-rc1/drivers/firewire/ohci.c	2024-03-12 01:15:10.000000000 -0700
> > @@ -2060,6 +2060,8 @@ static void bus_reset_work(struct work_s
> >  
> >  	ohci->generation = generation;
> >  	reg_write(ohci, OHCI1394_IntEventClear, OHCI1394_busReset);
> > +	if (param_debug & OHCI_PARAM_DEBUG_BUSRESETS)
> > +		reg_write(ohci, OHCI1394_IntMaskSet, OHCI1394_busReset);
> >  
> >  	if (ohci->quirks & QUIRK_RESET_PACKET)
> >  		ohci->request_generation = generation;
> > @@ -2125,12 +2127,14 @@ static irqreturn_t irq_handler(int irq,
> >  		return IRQ_NONE;
> >  
> >  	/*
> > -	 * busReset and postedWriteErr must not be cleared yet
> > +	 * busReset and postedWriteErr events must not be cleared yet
> >  	 * (OHCI 1.1 clauses 7.2.3.2 and 13.2.8.1)
> >  	 */
> >  	reg_write(ohci, OHCI1394_IntEventClear,
> >  		  event & ~(OHCI1394_busReset | OHCI1394_postedWriteErr));
> >  	log_irqs(ohci, event);
> > +	if (event & OHCI1394_busReset)
> > +		reg_write(ohci, OHCI1394_IntMaskClear, OHCI1394_busReset);
> >  
> >  	if (event & OHCI1394_selfIDComplete)
> >  		queue_work(selfid_workqueue, &ohci->bus_reset_work);
> 
> Thanks for the patch. I pushed topic branch[1] for it, since I'm
> considering about whether to send it to stable and longterm releases.
> 
> I had realized that the debug=8 for firewire-ohci module provides tons
> of logs triggering by the irq handler, since the irq for bus reset is
> not unmasked, so I rely on selfID events when debugging bus-reset. I have
> few objections to the change.
> 
> My concern is how much invasive it is. The unmasking is kept until
> bus_reset_work() is executed in the workqueue. When considering about
> the delay of workqueue (since it is a kind of schedulable task), many
> irq events for bus reset is potentially skipped from the logging. Of
> course, it is the aim of change.
> 
> Let me take more time to evaluate the change, but I'm willing to send it
> to upstream until -rc3 or -rc4, at least, if receiving no objections
> from the others.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git/log/?h=v6.9-firewire-mask-bus-reset-event-during-handling

As long as I tested, the patch is enough good to suppress the spurious
IRQ event. I'll send it to mainline in this weekend.

I sent an additional patch[1] to handle the bus-reset event at the first
time. I'd like you to review and test it as well, especially under your
environment in which 1394:1995 and 1394a phys exist.

[1] https://lore.kernel.org/lkml/20240401121200.220013-1-o-takashi@sakamocchi.jp/


Thanks

Takashi Sakamoto

