Return-Path: <linux-kernel+bounces-22388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 745C4829D02
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DCE6281C71
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E754BA92;
	Wed, 10 Jan 2024 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="EvyFiqKy"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44D44D100;
	Wed, 10 Jan 2024 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=DUExN3Br1mSbT2FmUtdpMOUc0V+OeqQ1WWIPCPNAmBo=; b=EvyFiqKyAoCdBSK3kJmvtX675Q
	fba97xLWJb7F1iAZustUHKVtEEpVNj+V0W17JmW9jqN4AM/CzhQ+NlcfF2OG5RjCtVAzXMR8cfrvR
	EMaYG34y0o2K5g732aZdgJa0sBPXsmYL3So5xUGRAnzagMk+/lEjM4xhnWAk+Ds5RdEg=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:41772 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rNa1z-0006Bn-Jm; Wed, 10 Jan 2024 09:58:12 -0500
Date: Wed, 10 Jan 2024 09:58:11 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Alexander Shiyan <shc_work@mail.ru>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Message-Id: <20240110095811.ec1b29403276a43b5e063129@hugovil.com>
In-Reply-To: <2024011006-snugly-poppy-8994@gregkh>
References: <20240109201102.299302-1-hugo@hugovil.com>
	<2024011006-snugly-poppy-8994@gregkh>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	* -3.1 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH] serial: max310x: fix syntax error in IRQ error message
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Wed, 10 Jan 2024 08:59:36 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Tue, Jan 09, 2024 at 03:11:02PM -0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Replace g with q.
> > 
> > Helpfull when grepping thru source code or logs for
> > "request" keyword.
> > 
> > Fixes: f65444187a66 ("serial: New serial driver MAX310X")
> > Cc: <stable@vger.kernel.org>
> 
> I really doubt that changing a spelling issue is stable patch material,
> right? :)
> 
> I'll queue this up after 6.8-rc1 is out.

Ok, no problem.

I am about to submit a new serie of some cleanups/improvements for the
max310x, and if you want I can integrate it into this new serie.

Thank you,
Hugo Villeneuve

