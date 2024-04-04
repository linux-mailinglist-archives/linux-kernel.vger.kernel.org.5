Return-Path: <linux-kernel+bounces-130994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53418981A9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B794B24CCF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0315C548F5;
	Thu,  4 Apr 2024 06:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="gahbLtNj"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6121853809;
	Thu,  4 Apr 2024 06:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712213678; cv=none; b=tNdu9bP9XPIQPEWSTCsUE6FCgygSiu8CnF2OX645XZEiyfW8ZsuUGrWup+GELuQ9Upvk8CyEmdwsR6tjcPxtn1aFOpllap6aWosr3UIuSwLVf+wC5Szh0Llhfgje+Y0vRwIR200HEMZcgwAMSj51W91rnKbG0gqrrl5UQJhsG7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712213678; c=relaxed/simple;
	bh=8bxPw6Yh23YjxbHld45amerCkshEE+W5J9e6zeuMJ1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuklxacComA+S1ePcSmBPiJ8d+uvtEELcuBFe7P5y/Ew04SJTmqLQirctAClTmdOvTJJgK3nPlzdgBkBrFgeGlVHGTNdc3R0bduHaEfa+d5sYce3P0DE82c6UVjBH9APNNoRl6v5sRETqDNuXqrpcvhG7gm6i9Wm+LvhezFYIL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=gahbLtNj; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id A7C036042D;
	Thu,  4 Apr 2024 06:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1712213675;
	bh=8bxPw6Yh23YjxbHld45amerCkshEE+W5J9e6zeuMJ1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gahbLtNjacj8rbrMUxLNcZuSdx7U8/mY7BQiFh1hPcPQP8Z0NgGlayNm5XhLmTW2y
	 CNgARvw49GpPn3whBcNg8BAAwamjfY33gFDmkd5I3v5D9GRR5Nxsp9l71qmCANgaKg
	 kA2iVjrAVMrNtsnh8kqB3fYb86IEJ/FsztfEGE453MPlRL26vO4y3o7uYGkAjwW0eN
	 1FHXGiqdIiHBDyqVZ6ne6pzrxOwEv3Yk6ghvwrcPHWv9mQ6glHWukI2wiqPN7WKuu3
	 89R7Jm7NdWwfVsC6RXSktVL63y2mNaC5qirMUiVB984BEJW54yhRoTnkB5arbopRVr
	 SwutnjjUql8dQ==
Date: Thu, 4 Apr 2024 09:54:15 +0300
From: Tony Lindgren <tony@atomide.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: kernel test robot <oliver.sang@intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable <stable@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [linus:master] [serial]  43066e3222:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20240404065415.GO5132@atomide.com>
References: <202404031607.2e92eebe-lkp@intel.com>
 <Zg1hBvRAxifo50sf@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg1hBvRAxifo50sf@smile.fi.intel.com>

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [240403 14:00]:
> Probably we need to check if the port is still open...
> 
> P.S. AFAIU the state / xmit is invalid pointer or so.
> 
> Culprit line:	serial_out(up, UART_TX, xmit->buf[xmit->tail]);

Maybe we can set UPF_DEAD a bit earlier as below?

Regards,

Tony

8< ---------------------------
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3442,8 +3442,6 @@ void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port
 
 	mutex_lock(&port_mutex);
 
-	port->flags |= UPF_DEAD;
-
 	serial_core_remove_one_port(drv, port);
 
 	/* Note that struct uart_port *port is no longer valid at this point */
diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
index 22b9eeb23e68a..1571ef721ef10 100644
--- a/drivers/tty/serial/serial_port.c
+++ b/drivers/tty/serial/serial_port.c
@@ -104,6 +104,7 @@ EXPORT_SYMBOL(uart_add_one_port);
 
 void uart_remove_one_port(struct uart_driver *drv, struct uart_port *port)
 {
+	port->flags |= UPF_DEAD;
 	serial_ctrl_unregister_port(drv, port);
 }
 EXPORT_SYMBOL(uart_remove_one_port);

