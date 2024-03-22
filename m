Return-Path: <linux-kernel+bounces-111184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41988868D7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A551C23F7A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159271B95F;
	Fri, 22 Mar 2024 09:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="M9YV8kKn"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8325017998;
	Fri, 22 Mar 2024 09:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711098439; cv=none; b=HmRpXJM05W55mI3K2DHVi0A/DraXsJAn8YJ1xU7J4wWanpnkC9MOLbK+7wbllBtwBQ2pTwQzbP+U0lZwXFR1znvy7MrmOQvTmti0UnerbNjfOFeF9BVK9uhmykdjCKtmbxUVfxk/8eeD97Y0fk3rlm4I8wbywC9YkrFgnbUxjjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711098439; c=relaxed/simple;
	bh=fqnq0phZd8eQ1RBeCYKOKzraow94yCRC0cLooXVkLDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbTEi6mlR+W2WC9cucA0VYQogblYgcgcmpaBFP/o3XRUNzvER8jeOt2fs99mjEnmm9nQF3/jdSi2/gb9YiZahLBe8IsCyXeu3x26nZO2YPviuy+HBJuEYFJ87J6gxPglpE5XqcuNnyX32EZXmsQrVoS9F+AMEEStVD8wxvwOkl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=M9YV8kKn; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 0040360340;
	Fri, 22 Mar 2024 09:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1711098430;
	bh=fqnq0phZd8eQ1RBeCYKOKzraow94yCRC0cLooXVkLDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M9YV8kKnPAlSqDp772EmB/bHzTaDkR+q2GDGF+ZJKdISm9Z7MMsp/ij3Z7kNDdk97
	 Y1/FDp98vv4WSDMbb1u1jk7XpUF8Kto52j04bNH8Wiw59zGrol+rEDjX0PWUf2XCSg
	 0W+bh4RLEtuztC9SwxnvNZNbqw4Bt4e83IrZNlS2WD9yGzg80XD8LecgN1ht2ncY4Z
	 sIUgOcMW3TgauctmrAvxSFEAddpztd96nqkNvjQnhj2rxYE3GFoAPOYO0zEKoT7qfJ
	 J5QzaBv6TvPU/sE/HFDT4JLac2RkQSh2s72B/FvaI9qiPtX6/wTVTnzFjI+nzYAnpk
	 8qg+hiadrnNmg==
Date: Fri, 22 Mar 2024 11:06:57 +0200
From: Tony Lindgren <tony@atomide.com>
To: Nick Bowler <nbowler@draconx.ca>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
	regressions@lists.linux.dev, linux-serial@vger.kernel.org
Subject: Re: PROBLEM: Sun Ultra 60 hangs on boot since Linux 6.8
Message-ID: <20240322090657.GD5132@atomide.com>
References: <d84baa5d-a092-3647-8062-ed7081d329d4@draconx.ca>
 <20240322051531.GA5132@atomide.com>
 <d7337014-09ac-8a35-7159-e75ecd2707b6@draconx.ca>
 <20240322064843.GC5132@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322064843.GC5132@atomide.com>

* Tony Lindgren <tony@atomide.com> [240322 08:48]:
> * Nick Bowler <nbowler@draconx.ca> [240322 06:36]:
> > On 2024-03-22 01:15, Tony Lindgren wrote:
> > > Can you please test if the following change to add back the check for
> > > !pm_runtime_active() is enough to fix the issue?
> > 
> > I applied the below patch on top of 6.8 and unfortunately it does _not_
> > fix the problem (no obvious change in behaviour).
> 
> Hmm OK thanks for testing. I'll take a look and see if I can debug this
> with qemu sparc as I no longer have any sparc boxes around.

I can't reproduce this on qemu-system-sparc64, probably as it does not use
the sunsab driver.

I noticed something though, I think we need to test for the port device
instead for being runtime PM enabled.

Can you please test if the updated patch below make things work again?

Regards,

Tony

8< -------------------
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -156,7 +156,7 @@ static void __uart_start(struct uart_state *state)
 	 * enabled, serial_port_runtime_resume() calls start_tx() again
 	 * after enabling the device.
 	 */
-	if (pm_runtime_active(&port_dev->dev))
+	if (!pm_runtime_enabled(port->dev) || pm_runtime_active(&port_dev->dev))
 		port->ops->start_tx(port);
 	pm_runtime_mark_last_busy(&port_dev->dev);
 	pm_runtime_put_autosuspend(&port_dev->dev);
-- 
2.44.0

