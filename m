Return-Path: <linux-kernel+bounces-30007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F088316A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1649A1C21C0C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D92C208C6;
	Thu, 18 Jan 2024 10:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bzFYaVjO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fQO6k3sw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99377200BC;
	Thu, 18 Jan 2024 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705573628; cv=none; b=GrPZbJShtLm+FRdNa7dPUTNFb2fcgQRc9uYJ5rCr6J2f3bnD/ymP1awTVqM3ilFRVJCAWsCOrFXzhuvtGCns8kYPs2iKCe9CLOWKFLrm8sRzvTcoMKLTRnDbxxDSB1Rc4wUno1xbBc4+GVPnKTxAyPC+ouYSK5CdcKvJJSjatXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705573628; c=relaxed/simple;
	bh=ZfiZ3D6uM6pYqjO9Hou/j//5k9Vequ4W5/JIyapwCko=;
	h=From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type; b=KKrPPn3F8aRB83U8ycGbpAdmDflV0XBGdFPj5ZdyRLO6GvNF/ukjDLkRceuo11zGxhNM+66COE06Qqql0Tdp9qKqPMq3TVKpha6MXgy5/MI4tj1pcjaQgUtx3yBYofA3DX1ARO0zVWKNzwY3xYY443yfIMuC7u6t5F7emmJg9SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bzFYaVjO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fQO6k3sw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705573625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZfiZ3D6uM6pYqjO9Hou/j//5k9Vequ4W5/JIyapwCko=;
	b=bzFYaVjO6ZHxcU0X83ygYTG14gWBhniFT3uZ50HRGomn+sbWJoQqZpaUaRr9ED4aglNr1P
	H4WuMJwTf8gWkfMl7YBZJfcVWifmiclrVEYXmDvBU+ZnrYCvGvZrl/06bEqcIKvE2G2Ae0
	SXMJHD8U60SY+7Ih0qe9HKZ0jzVVSHiYWP8f4qMSwM+2U2sShsCXgaX2TI01u3M+UhOldP
	5AOMSP30/EyemMAcsQlETGigBvt0YIjnyIAnrsNVY0vcj7z2i/ZHYbhUV4koiEfQFvJjhb
	KAD8wUrx+znlznkVPRJ7nNK+huBIJewlfs07XN78O31zEGRKHn3uu2u7sNJDqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705573625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZfiZ3D6uM6pYqjO9Hou/j//5k9Vequ4W5/JIyapwCko=;
	b=fQO6k3swqYnnliYfKPSp3OJaeDmdJiGI7w8qA5cYM5kOfrT1fQkWA+P7Ca/Z4p5ecedvGf
	X0R2vBXIBX9EnVDg==
To: Leonardo Bras <leobras@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Tony Lindgren <tony@atomide.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-serial
 <linux-serial@vger.kernel.org>
Subject: Re: [RESEND RFC PATCH v1 2/2] serial/8250: Avoid getting lock in RT
 atomic context
In-Reply-To: <ZajxMc05uVmK7e60@LeoBras>
References: <20240116073701.2356171-1-leobras@redhat.com>
 <20240116073701.2356171-3-leobras@redhat.com>
 <75a39f0a-8f79-eacf-4a35-5de512a3cbed@linux.intel.com>
 <ZabJGefGkrs0SNzW@LeoBras> <87o7djaubq.fsf@jogness.linutronix.de>
 <ZajxMc05uVmK7e60@LeoBras>
Date: Thu, 18 Jan 2024 11:33:04 +0106
Message-ID: <87cytzaqdj.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-01-18, Leonardo Bras <leobras@redhat.com> wrote:
> Sure, please let me know of where can I find the latest PREEMPT_RT
> patch series so I can re-test my bug. By what you comment, it's higly
> probable that patch 2/2 will not be necessary.

Some links for you:


The Real-Time Wiki at the Linux Foundation:

https://wiki.linuxfoundation.org/realtime/


The latest development RT patch series for 6.7:

https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.7/patches-6.7-rt6.tar.xz


RT git (branch linux-6.7.y-rt-rebase is probably what you want):

https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git


> On the other hand, unless some extra work was done in preventing the
> scenario in patch 1/2, I think that can still be discussed.

I agree. Thanks for looking into this.

John

