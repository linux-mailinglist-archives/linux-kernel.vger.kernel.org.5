Return-Path: <linux-kernel+bounces-167350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DF58BA857
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23060282DE4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939A7147C8A;
	Fri,  3 May 2024 08:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Blluietw"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CFA2B2DA;
	Fri,  3 May 2024 08:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723757; cv=none; b=W2mrbYcRamEA1pCI37aSLBV1MVB7cbcuXlXILTOfucRLaPJRmIkAELSL+nay6c1EKfGwpFiuR37SizE2NOvciEqPTzdMx22XS/29TKJW9M7IIYLBJsIbR6ren6Cr6tMrkQx8mHGxVmOeYua+IaViygO1Jvr67MMCItOGkuE3W8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723757; c=relaxed/simple;
	bh=ENBYZblky69TdSDJSNn9y3+7hJ7kpBrY9SAKhxMcPLk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=C0kVzNkdPNDivaXy0inSW7Zc2G08k62aeFUlx99RBiCcwra/sfLlLBPBUtPtZBhoT1PglSLikZfkkvRtxrfGQt/L1RJzLsX+/JYytDlDPdVoBpLTCXh1N8iGLZQI5ODnDBXfphwyb8FnOhrxlMqm0RnR/CQ95p294yvDqbRqMIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Blluietw; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D375D60002;
	Fri,  3 May 2024 08:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714723753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ENBYZblky69TdSDJSNn9y3+7hJ7kpBrY9SAKhxMcPLk=;
	b=Blluietw4pdtohmjHd2RzatVreMetUg/mhou3P2N6SwAWZIfAublpJzB8x4GBuP641Dhle
	mp3mE/SWphoWWrNIsdu1xOqu8wSkQifXZUwY0WRDtluUVSLtPcEIBuoPS69rNpHXKIZtF6
	DW2KDGrnCMpfTEZRNBz32RuZ/11EpUS/AZYm1A2dYLjkQi5uMsF45CCo80rAsoXbM5NddF
	ksfXnxsKBZnK7343Hx5sa5ji/suafrAsmgIV8HVttMDGk609QKi2S2mxqSvPBDywCDQzUH
	YAddw6CACoSTKIIxjzuUeWxY+ieHwjyJYbUcofDi0pQ/KRQa5Ri3XD8urKrjyw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 May 2024 10:09:08 +0200
Message-Id: <D0ZUU7BGDGRN.1NJ3GVVIBL3P1@bootlin.com>
Cc: "Sergey Senozhatsky" <senozhatsky@chromium.org>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 <linux-kernel@vger.kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Jiri Slaby" <jirislaby@kernel.org>, "Russell
 King" <linux@armlinux.org.uk>, "Tony Lindgren" <tony@atomide.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "Linus
 Walleij" <linus.walleij@linaro.org>, "Hongyu Xie" <xiehongyu1@kylinos.cn>,
 "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>, "Arnd Bergmann"
 <arnd@arndb.de>, "Lino Sanfilippo" <l.sanfilippo@kunbus.com>,
 <linux-serial@vger.kernel.org>
To: "John Ogness" <john.ogness@linutronix.de>, "Petr Mladek"
 <pmladek@suse.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH printk v5 09/30] serial: core: Introduce wrapper to set
 @uart_port->cons
X-Mailer: aerc 0.17.0
References: <20240502213839.376636-1-john.ogness@linutronix.de>
 <20240502213839.376636-10-john.ogness@linutronix.de>
In-Reply-To: <20240502213839.376636-10-john.ogness@linutronix.de>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Thu May 2, 2024 at 11:38 PM CEST, John Ogness wrote:
> Introduce uart_port_set_cons() as a wrapper to set @cons of a
> uart_port. The wrapper sets @cons under the port lock in order
> to prevent @cons from disappearing while another context is
> holding the port lock. This is necessary for a follow-up
> commit relating to the port lock wrappers, which rely on @cons
> not changing between lock and unlock.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Tested series on Mobileye EyeQ5, a MIPS64 platform that uses PL011.

Tested-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> # EyeQ5, AMBA-PL011

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


