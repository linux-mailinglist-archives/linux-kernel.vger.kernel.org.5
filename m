Return-Path: <linux-kernel+bounces-36731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DFB83A5B0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C6C293ECD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9325118029;
	Wed, 24 Jan 2024 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lki1T9jI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+JGNhcrN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75303182A0;
	Wed, 24 Jan 2024 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706089253; cv=none; b=cBlXDQRtKiSakfqEPu0oQrP2xpyMfVN+o22VNh/PvD2Z2F2HnMmYGEPW+HYR7UV1OPsZSFMgb2bgzvYzN5mFb+YEqfDR73CDGkHHixXvXhpX5uAOgwREb9YsiADK27tEoK6xZH4mFSOVEg8ppfm/5A8X8IMTDt0qcOn9Hrz+U3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706089253; c=relaxed/simple;
	bh=0nH0pQ4/QHTXj++AgwYVxeag8yUhRFREwHBgcGA8cBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZeQlJklhcnX4W3A+cU/W2YUWUDwOkcWyNtJj1WernfF0XwTYrEwc6JODZRPMJ/3LdB/BwURPiN1Tf9J4QSykboW/as6ztPsE+Czg95joC+sz6uxvTT3NpeI596D23f+V3lztYL5yUlcf6avjkVTnvl6yUlYKHdtUpsol7zhu3ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lki1T9jI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+JGNhcrN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706089250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0nH0pQ4/QHTXj++AgwYVxeag8yUhRFREwHBgcGA8cBw=;
	b=lki1T9jIapSpv1XcMoYs3pllb6OtT1rHBHnpzlIQuQ+Xa4Gemj/s2yGOF2y4WIM85Knx6P
	dkpjzMZFzfjbsd+LG6txcIUbddnV8ZWPaSDkB7j4p6RhD1yVb6rlrcblOxieTsN/h1r85R
	MbSIfTw0VsgJjAkLYOla246osciOB0rXGjskCKS+h6zo0UWHHAtiDIDvT3k9iF33xOkxc+
	HHChZ+H1STSS5SdJ+6tyuD8YReAktfq1ioH/VP7z8bex42ZNb9q/N16A8CiyO513B9Edga
	LiOmDoE8uHoJYEhSf8JBJXidMlwU7gmyF1Ifolbdmigxe51nMcumd1lah0GeoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706089250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0nH0pQ4/QHTXj++AgwYVxeag8yUhRFREwHBgcGA8cBw=;
	b=+JGNhcrNgARPXqwwMYnChO8weeZBRHkXpUbj3CwVm90koLnrqm+IiBWC/VOt1/kjtIFSHF
	3UiJXlq4wlemS9DA==
To: Junxiao Chang <junxiao.chang@intel.com>, bigeasy@linutronix.de,
 tglx@linutronix.de, rostedt@goodmis.org, linux-kernel@vger.kernel.org
Cc: hao3.li@intel.com, lili.li@intel.com, jianfeng.gao@intel.com,
 linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 0/2] nbcon locking issue with v6.6.10-rt18 kernel
In-Reply-To: <20240123054033.183114-1-junxiao.chang@intel.com>
References: <BN9PR11MB5370AED9C562F9DA75093557EC742@BN9PR11MB5370.namprd11.prod.outlook.com>
 <20240123054033.183114-1-junxiao.chang@intel.com>
Date: Wed, 24 Jan 2024 10:46:44 +0106
Message-ID: <87o7db9ihv.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-01-23, Junxiao Chang <junxiao.chang@intel.com> wrote:
> There are two serial port devices in one Intel ADL hardware, one is
> 8250 lpss, another is 8250 dw. Multiple uart devices are enumerated as
> ttyS0, ttyS4, ttyS5,... With 6.6.10 rt18 kernel, booting hangs in
> nbcon_release if console is enabled by appending
> "console=ttySx,115200n8" to kernel command line. According to nbcon
> author John's suggestion, lock flag is moved from console structure to
> uart_port. Another patch is to add uart_is_nbcon checking in
> nbcon_release.

Isn't the real issue that the console pointer is copied to device that
are not consoles? I am wondering why that is. Is it possible to
dynamically switch the console index during runtime? If not, I think a
proper fix would be to only assign @cons if it actually registered as a
console. This would also simplify the uart_console() macro.

It is critical that a struct console is not shared by multiple
devices. I do not like the idea (or see the point) of having non-console
devices store a struct console pointer that is registered with another
device.

I will take a closer look at that.

John

