Return-Path: <linux-kernel+bounces-29031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F8883073F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0C21F25781
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E194200D8;
	Wed, 17 Jan 2024 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gj/UOBnl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Re46DMnb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D261EB57;
	Wed, 17 Jan 2024 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705498956; cv=none; b=GPzlaz/iYWq7Ug5BsaISMmLbxdEYnlYDVRAvpiSyWgbLux9uktN1meGgI2slgLtXfP+Izpc52AU1NzNDqS5+cDFjhnZb7qkVC61SvOrcWVaOlVFuVAXB/ORR2eEO5ZL55QWcaNXmvApQU7bPCuLfysdG+znBRELnqQY6fU+vo84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705498956; c=relaxed/simple;
	bh=dyRNCFjn8d4+GiBuo7xutiy2wG0X8ur1DJVGIRCZJ3c=;
	h=From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type; b=paSIcQI5NBi8groEzCk/hwwfIM/abyaavqQjMfmUDPRNciamPnziOk1I+X1KX6iBkt0CZ+HPixIGziaG+yEOs0pl0+4pv5KuoRa5QUOMQpUVZxDyD477pq5LdaDdSPyzHUpZ1MGKm0BJ0JyURMiGdg+S5RcgG8NItiBJQSujw+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gj/UOBnl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Re46DMnb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705498952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZC+51fURMNsrZMs60syMJyw2GHfrcZPYF5r36IEGtU=;
	b=gj/UOBnl59bxLYbK/mOcWgN3nHx2wu65J9WrhSK4j3mEz8VfdDi1sW8nt4eyYGKlLU2q1c
	iK1QXiPzdJoZp9aNAAIlR5pSymLFc9bnvEWOoeawh224ZkyO5E3m73FxVj9hmcfSy8muAE
	C5VcxRuOIFJoaY9rvwM689VwI38MZJ0pNp2dpq+VQOD39ocFITK1ncrBklkO2anS6Q1QKL
	8cCWSmMsmIYarXkWBTW3z5qAyNLh4ww5nVuNsNlCIOPccVkj+vPqYYsUziDbIPA85EdHBl
	XThd5sRsLJlSxNe5lXwNqCKwUfUBLQaBYTykE0Pw+xGq9wa/uklxkw+bkXRBOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705498952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZC+51fURMNsrZMs60syMJyw2GHfrcZPYF5r36IEGtU=;
	b=Re46DMnbHsx4PlSNwrmlTmf1m/xT045rSGqgiL1DVcJvUkT36SXyNPtAV9UWnlPwTmNFwG
	8PYUvCxtrtmD4nBA==
To: "Chang, Junxiao" <junxiao.chang@intel.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "rostedt@goodmis.org"
 <rostedt@goodmis.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Li, Hao3" <hao3.li@intel.com>, "Li, Lili"
 <lili.li@intel.com>, "Gao, Jianfeng" <jianfeng.gao@intel.com>,
 "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: RE: [PATCH] printk: nbcon: check uart port is nbcon or not in
 nbcon_release
In-Reply-To: <BN9PR11MB53709FD2BC70878B49059107EC722@BN9PR11MB5370.namprd11.prod.outlook.com>
References: <20240117065226.4166127-1-junxiao.chang@intel.com>
 <871qagtlk2.fsf@jogness.linutronix.de>
 <BN9PR11MB5370065F4E7443FEA156347EEC722@BN9PR11MB5370.namprd11.prod.outlook.com>
 <87y1cos2dv.fsf@jogness.linutronix.de>
 <20240117102446.itexUYMc@linutronix.de>
 <BN9PR11MB53709FD2BC70878B49059107EC722@BN9PR11MB5370.namprd11.prod.outlook.com>
Date: Wed, 17 Jan 2024 14:48:28 +0106
Message-ID: <87r0igrs8r.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-01-17, "Chang, Junxiao" <junxiao.chang@intel.com> wrote:
> As you mentioned, same console driver is only registered once. 8250
> console driver is registered once, its "struct console *newcon"
> parameter is address of "univ8250_console" which is defined in
> drivers\tty\serial\8250\8250_core.c.
>
> However, in each serial port device is registered, their cons pointer(
> "struct console *cons;" in "struct uart_port") will be assigned with
> same cons in API serial_core_add_one_port:
>
> 	uport->cons = drv->cons;
>
> That is, multiple similar 8250 uart_port devices have same console
> pointer which points to above univ8250_console.

Ah. This explains the "(port)->cons->index == (port)->line" check in
uart_console(). Thank you for clarifying.

> BTW, this issue couldn't be reproduced with v6.6.7-rt17 kernel.

The reason for the change is because console registration/unregistration
is not related to the port lock. There is a potential race condition if
nbcon unlocking is based on the UART port still being registered as a
console.

We could move the @locked_port flag to the struct uart_port. (Probably
renaming it to @nbcon_locked_port.) I think that would be the
appropriate fix.

John

