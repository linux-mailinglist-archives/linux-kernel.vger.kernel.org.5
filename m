Return-Path: <linux-kernel+bounces-36773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC35A83A656
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A432B2813E7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A601862E;
	Wed, 24 Jan 2024 10:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wImRTpti";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IOK4QaPO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CBE18E00;
	Wed, 24 Jan 2024 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090729; cv=none; b=YHDG1giyTXvjUv1msRhLitCg+f0eDbde2dn8U/eVD9W5e5stOJTgHv/dczCOZsF1l+qzqRt41RYYiPzeOXh/Yzuopw2lYRPQaBEmhiRLUiAho0WF9+8jGG8RR7VTsatnFFyDXjtiC9eUtA/4exhKuIgJKe4ZNHtAPifEg++BNII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090729; c=relaxed/simple;
	bh=0KezyqRF9YchXDd4bxWas5poKmjepqlImiHTbBdZrM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2VMxnU5dZwUR+78gkikHdNQ1szSNO4VEyQ9osL9imq8O8D0yyFt54zwOyn5I1MQXmHHNmDcu5r91O0iBEVr6v2xQd6jm75lH45oScL7FrEBFM/YLLPI2iOWWIZgwTHj4ZkmVpj7y2B5uy4KSoRIGAKCqQ+AqYh/kbfxlV1eP24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wImRTpti; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IOK4QaPO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Jan 2024 11:05:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706090725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WTilLq0oXbltZtjofTkiTqw+ozvdtSJ/BvaTTO3IVgc=;
	b=wImRTptiZtvuvgCwAOgsYIqGgIgGgIj1h39yTiFvQ1u9BJIEQ9mi2kYrccIIt5KU2tdmVC
	37GOZHA5sQWl+wxHI+O3Vn/L2zPFvHvgUdvcLnnLiGf3y00rfdatmPWGixARhL0r+uh7K0
	87YYY6SmYx7p6Lz7/2QqXPrwD8nop2NxmyACQu5T94fcF2QVLQ3NcXpjazHAIKxW3uiXT9
	MQvo8PiUXIkvz/JPQcWxfgY1606Hsq0K93FzzyhfyBY+nbSfLyiIwdld9qhD8I33xalQ/u
	yPIwziWijKaSNH3Ip4f20ZSU3JMS6LgziAUf8j3iOJj+G+v0LmQrhzgVSX4INg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706090725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WTilLq0oXbltZtjofTkiTqw+ozvdtSJ/BvaTTO3IVgc=;
	b=IOK4QaPOSTWxQ4nzStRhEHT3ekqrsmzv6CPZSINo4mXJVOYxtsR/fH3IL5M6i2pHTL6yJd
	Dv909blqai0IOUCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: John Ogness <john.ogness@linutronix.de>
Cc: Junxiao Chang <junxiao.chang@intel.com>, tglx@linutronix.de,
	rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	hao3.li@intel.com, lili.li@intel.com, jianfeng.gao@intel.com,
	linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 1/2] printk: nbcon: move locked_port flag to struct
 uart_port
Message-ID: <20240124100524.ZyAPfPU5@linutronix.de>
References: <BN9PR11MB5370AED9C562F9DA75093557EC742@BN9PR11MB5370.namprd11.prod.outlook.com>
 <20240123054033.183114-1-junxiao.chang@intel.com>
 <20240123054033.183114-2-junxiao.chang@intel.com>
 <87le8f9i75.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87le8f9i75.fsf@jogness.linutronix.de>

On 2024-01-24 10:53:10 [+0106], John Ogness wrote:
> On 2024-01-23, Junxiao Chang <junxiao.chang@intel.com> wrote:
> > Console pointer in uart_port might be shared among multiple uart
> > ports.
> 
> I still want to investigate why the pointer is shared. This sounds
> sloppy or dangerous.

I have x86 a server box and PNP enumerates two UARTs (8250). Only one is
wired up but both can be specified as console=.
What do I need to do to reproduce this here? Using console= twice does
not do the trick.

Sebastian

