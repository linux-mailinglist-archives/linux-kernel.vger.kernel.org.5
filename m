Return-Path: <linux-kernel+bounces-71466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B98B785A5B4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5396DB222AB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460A8374EA;
	Mon, 19 Feb 2024 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o4wiG68G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6+VI/+M0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3806136125;
	Mon, 19 Feb 2024 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708352352; cv=none; b=WJC6YBvks1A2wnVttiBO6szzhtBzhdn0dsakPDH4OcVp/CA6u+IH92Mx/L/PoLJH6BPbbbuZfMxW5yWdhbY3aol4cG3OJx4AW+Ms/5Mr5zIM+pzWtShsMw2ModlB0Xo4a4IMIXmUTEAdc6WfAtWdpAQW3aUrIXyAe6gtzH43J2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708352352; c=relaxed/simple;
	bh=UQ/xCts5Y5EfjSUtaYYjNcAkUaWSg2td0YATorNw3O4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EDi8nIKtp5971lGIO6hpa8qJ4V6uitTHoKWlvuOTxMp5AHIt2H8bc6rrFkZR1FUsnkdYzDj4057LNfbammCVBgcPcewRiSu6mH743JRxh0+KDLiHPOxohrx5Jh/qxA7UrZ5ClD1hcKuKsWVs/MRokYvckdHNMwt4M/NTcN9XqqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o4wiG68G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6+VI/+M0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708352349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tE619jYxrVp6c5yjL2tj6k7CJfD9ZPT5Mqi5c3cAKts=;
	b=o4wiG68G1+RfjcQEcbQSppRlkxePd/m3kWrBNAkq/rgLKWfSSujGjeyI79HP3Zt4EuRFlT
	q0e5hvIRjvJG5NybPuHrxOsSWjZRz7Mqtr0Vp3JeledKb9Vw+UPMAQkQjIaGYFQXYojmjQ
	vWOvMbasO1wbPo5a1gRyRkWXE/hXksBM81j1Fqpc4r2dM6c2XW0Wz/EewItOe8iHoyGrJl
	e1klsPW8Nvgl4/kkZ9ML5rwpCI6799R9NNVL8NY9VNSGBYn5Or8AY867EAaaz6hyuFXZnV
	S4vWBZJ2rRxHdJFEqZzygXQT0H1lLrDQYkKEXrD4nyfHmeUnUEHnLSrCGaDSYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708352349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tE619jYxrVp6c5yjL2tj6k7CJfD9ZPT5Mqi5c3cAKts=;
	b=6+VI/+M05xsyzqQWw+k8n8bS94a1/I202cPn8dzJahoY/xp/eS3fBMtKmL59Y8qqFUDTRO
	8L2zsrbtUhG1RoAw==
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas
 Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
 Tony Lindgren <tony@atomide.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Justin Chen <justin.chen@broadcom.com>, Jiaqing
 Zhao <jiaqing.zhao@linux.intel.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v2 08/26] printk: nbcon: Implement processing in
 port->lock wrapper
In-Reply-To: <ZdNGlzwqwdsfwwab@smile.fi.intel.com>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-9-john.ogness@linutronix.de>
 <ZdNGlzwqwdsfwwab@smile.fi.intel.com>
Date: Mon, 19 Feb 2024 15:24:47 +0106
Message-ID: <87jzn0bkqg.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-02-19, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> --- a/kernel/printk/nbcon.c
>> +++ b/kernel/printk/nbcon.c
>> @@ -6,6 +6,7 @@
>>  #include <linux/console.h>
>>  #include <linux/delay.h>
>>  #include <linux/slab.h>
>> +#include <linux/serial_core.h>
>
> The headers in this file is a mess. But here you can at least keep the
> piece ordered, can you?

Just to clarify, you would like to see this ordering and inclusion?

#include <linux/bug.h>
#include <linux/console.h>
#include <linux/delay.h>
#include <linux/export.h>
#include <linux/kernel.h>
#include <linux/serial_core.h>
#include <linux/slab.h>
#include <linux/string.h>
#include "internal.h"

>> +	ret = (console_srcu_read_flags(up->cons) & CON_NBCON);
>
> The outer parentheses are redundant.

Ack.

Thanks.

John

