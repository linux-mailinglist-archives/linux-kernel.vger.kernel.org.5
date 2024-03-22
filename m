Return-Path: <linux-kernel+bounces-110986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3338866AE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90080285201
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D11BC2FD;
	Fri, 22 Mar 2024 06:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="THDPJ8F3"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5A7C122;
	Fri, 22 Mar 2024 06:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711088621; cv=none; b=KwkI+bqI5aUm/xvWQXdjCX1VRPvoprls2ySAiaWdxqvfItoInm3VqMojkDWMnBZBW127v9TVavprkQQiJ3GFxLgfSB3h4KHwUKknxe+Ioygl9KN+Zvzs2/I8k2apEoIJ54YrMIDw6ItFzoMK949y/eHXE92tCfk4OPDq7/kvwUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711088621; c=relaxed/simple;
	bh=CIQDA4RE2QaJoOsDHdz4Ke2vPj1SmGC5YF8CnH9aZBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bpnw3fE1IQX3wCfOmssl5WPBn+1NyvUvSCecFldP4/3NLPOOmC+zRAXSk7kN9YS+LHiPjo5HWbGPR8KFpPRwuENX5NY8YVZu3jBbU3MklvTe5lS08jgUz/nA9YfLlQC5OlO/MLjkoK1h7J9EIysY7gZ5ryFjD4CzoLNK6s7tN5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=THDPJ8F3; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 7BD2560426;
	Fri, 22 Mar 2024 06:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1711088618;
	bh=CIQDA4RE2QaJoOsDHdz4Ke2vPj1SmGC5YF8CnH9aZBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=THDPJ8F3skY0xd7YIdyho9ZolbqyzwbJi+/R+zH/b6Y1WNyO9xfDC/2OGWPLxcZko
	 XLKB7qMXQk7Bky6S2o7HZu49nT9IMcAyRj9uBTgOOElwuBo/9lcxfnmHdy/cCruTRg
	 /ozBJ9tMX0FzjYtuvRrMU5A6LBxPv1DSIR8UE/PQX4w44DCh/ev5q/+1fKUeqRKLo8
	 lM3Qjs7g6NWJ3qsrxM4/kM7ZhwmHhpyIFmrSbDPXdR8MWTLs5ZJKMjeAGOczfrPqph
	 I7y/vwbzWZkz6TJ7uP4HeGB4uC6iQSlNJymBH+KMo2IyKskTTaI70HSAl2RwwT8AJ2
	 skedYhf35QtSw==
Date: Fri, 22 Mar 2024 08:23:05 +0200
From: Tony Lindgren <tony@atomide.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Justin Chen <justin.chen@broadcom.com>,
	Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
	linux-serial@vger.kernel.org, Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH printk v2 08/26] printk: nbcon: Implement processing in
 port->lock wrapper
Message-ID: <20240322062305.GB5132@atomide.com>
References: <87le6oy9vg.fsf@jogness.linutronix.de>
 <87plvy31hg.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plvy31hg.fsf@jogness.linutronix.de>

* John Ogness <john.ogness@linutronix.de> [240313 09:50]:
> One nice thing that has risen from this is we are starting to see
> exactly what the console lock is needed for. At this point I would say
> its main function is synchronizing boot consoles with real
> drivers. Which means we will not be able to remove the console lock
> until we find a real solution to match boot consoles (which circumvent
> the Linux driver model) with the real drivers.

Would it help if earlycon handles all the boot consoles?
Then just have the serial driver take over when it probes?

Regards,

Tony




