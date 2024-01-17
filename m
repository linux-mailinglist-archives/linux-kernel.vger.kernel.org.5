Return-Path: <linux-kernel+bounces-28806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61082830332
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1366B1F216B2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148491DA47;
	Wed, 17 Jan 2024 10:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZZXmJ4Ul";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0k/sjsjK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C081DA35;
	Wed, 17 Jan 2024 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485817; cv=none; b=JIsj0rL17ehzYC6tvt5m87sFanDb87elQKQ9tGncT9DmXHkHZW9DKeZ9luDvBRh6Sx9PiUq+z0DdNxYqCD8AQKlV1jIo3/XEtoM12YDOvS2a4cf57P/L0ucbZ6YEPKiMN0E9kLMQsNYKJ93DJmcVrQ2BMZcnWHKGH+OokNBQ7N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485817; c=relaxed/simple;
	bh=CUFmMxfNLORzIKiq952Jyw/HdLoR8XCLYDcnFC2DXz8=;
	h=From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type; b=gUeh5HWuuhGV7wKXp/0BvkYzrxqLB51h07QxWSThcaT1aS341w1ccgD2+s0dXycIFYT4vTi0XM+ybMP1O2TJ/jx/Tu3toEUbBhoOsMsga3v2gxr9GTrLZTAjkZFTqtrsHMhGwCSCBFalz86qxLf+ke9VlI1gJTdUpRhxoP6XEbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZZXmJ4Ul; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0k/sjsjK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705485807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HCc9tibi82Pbj/50pOz8Sj6mdn1A2UjXuVfV339QXA8=;
	b=ZZXmJ4UlQeBoTS4g16SsNQJ+AVWCmnLGY1sIC3TaHan/EhbZoed4jD4FMjI/teA0BqooZT
	/R2yJQ8qJHLj1v/CQjmLZMYU+q66J/630pLOiQVBT0LceKRi1+6iEuSDdYUIM2CO9d4NNd
	qrlOALJPdr0kfUnX3VeR7wN/I5NYaoAtfjvAghpFAFAYUaNTx+agqKQICvuAqWsIFL684q
	SoSM7T7ReJFXRHHLz3FxFet4j7UYaGg3/TPjAQim6F6sqOcrNPDkgPbhzu35KQAO7ZEHd5
	IC1yvSQj0URVDQtY6ZdboR3wWkFkiOGf4H/cGoHKDnVRXVR+NSSQat+0Sp8+gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705485807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HCc9tibi82Pbj/50pOz8Sj6mdn1A2UjXuVfV339QXA8=;
	b=0k/sjsjKP0Eln9OzFwC1CgeKauAHsB01SWuXb5eGvwSJ3g5ZBS9ssUYVBQxL1OIWaAfTmW
	PMyLyQ+xvmjbAJBg==
To: "Chang, Junxiao" <junxiao.chang@intel.com>, "bigeasy@linutronix.de"
 <bigeasy@linutronix.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Li, Hao3" <hao3.li@intel.com>, "Li, Lili" <lili.li@intel.com>, "Gao,
 Jianfeng" <jianfeng.gao@intel.com>, "linux-rt-users@vger.kernel.org"
 <linux-rt-users@vger.kernel.org>
Subject: RE: [PATCH] printk: nbcon: check uart port is nbcon or not in
 nbcon_release
In-Reply-To: <BN9PR11MB5370065F4E7443FEA156347EEC722@BN9PR11MB5370.namprd11.prod.outlook.com>
References: <20240117065226.4166127-1-junxiao.chang@intel.com>
 <871qagtlk2.fsf@jogness.linutronix.de>
 <BN9PR11MB5370065F4E7443FEA156347EEC722@BN9PR11MB5370.namprd11.prod.outlook.com>
Date: Wed, 17 Jan 2024 11:09:24 +0106
Message-ID: <87y1cos2dv.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-01-17, "Chang, Junxiao" <junxiao.chang@intel.com> wrote:
> There are several serial ports in one Intel ADL hardware, they are
> enumerated as ttyS0, ttyS1, ttyS4, and so on. Multiple console options
> might be appended to kernel command line. For example,
> "console=ttyS0,115200n8 console=ttyS4,115200n8
> console=ttyS5,115200n8".
>
> In this case, several uarts "cons" pointers are same.

Typically a UART driver will register the console structure in the
driver's initcall(), which is only called once per driver. This is why
it is usually not possible to have multiple UART consoles.

If a driver _does_ allow registering consoles for multiple devices, then
it must allocate separate console structs for each registration.

Note that register_console() will generate a warning and abort if a
driver attempts to register the same console struct twice:

    WARN(con == newcon, "console '%s%d' already registered\n",
         con->name, con->index)

So I ask again. Please explain how this is possible.

John

