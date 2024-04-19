Return-Path: <linux-kernel+bounces-151679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3487F8AB1F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89E31F23FCE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC7112FB3C;
	Fri, 19 Apr 2024 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oie4/xg4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uMfNdSWL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D659312F383;
	Fri, 19 Apr 2024 15:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540889; cv=none; b=jZgK1/dztnISph3zhGjtsSFmyin6bcjxHFEWr3taKCIjGF3tcDltIyvxxfdb/9eWfWYxzDnwQbQfMRwLxkkavet42iEceii7PbRnMsxF4P/R8UlBCD0DoGMZ6z3+KWjorXEGLb4dmNKsl3mzYTpcoVLRQqqP6yT0lcEqYRxaDao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540889; c=relaxed/simple;
	bh=xk5RxQLjpLMTXtkOveIqefrfeV0w3inQhOLjLQcNQ+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fysrO3FPQEdkfiq0lNg15lyCwyLHMLVcsB32/JAgkKetXwyktjEs3BUkTclN644XhMTsN9NCZfRYAO+JVfwNbutihykLYXmeuVSCvhRHlNmcj7HsR5PMMGeeza+t2FFIDn0BAx4MMs1m26TssrZf7wYWxkDTBUd2VSc25U5LGPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Oie4/xg4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uMfNdSWL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 19 Apr 2024 17:34:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713540885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9LjR+hMgOOIviyFlXVxnmansGbWA8tKdpCQ1OTyis+o=;
	b=Oie4/xg4HuGv2p1jKYMGBlvAjOUtDmS6cZohLywg7zad9+ccXByGV/dkkHVRyvlZW/6pPm
	U6Lqq9ZgpmmJWUV8KhXVuXX+2XvErS5cdMGlnQwadvDav3SCt7nnBtAFC1xbNeKMv4yuQq
	t3NGAKZioxyqtwJF/1y26QEpdbs762HJIeVTuJkSM5ZMlHOoBK8WrDy6hTLrZSwdIp/F/s
	gGtuGTJLlsdSlW6xbssdRclfI1tcLeYjRn+a5p7doXraiP3vpEr/nbaR7eNDYUSlarwr8E
	/tbQ5lfN4vlGcHKNVsmpN9X8y7qWeHd1RXhoy90rK3LCkn0TGuKCrQGciYa9Cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713540885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9LjR+hMgOOIviyFlXVxnmansGbWA8tKdpCQ1OTyis+o=;
	b=uMfNdSWLan27BfBWRRXv+xSmDwICEfuBA3xX+rten5acv3HYwS3l2yJsq8RwiBlqhXCV6y
	FQoFWnfSfNsByYAA==
From: Nam Cao <namcao@linutronix.de>
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Harshit Mogalapalli
 <harshit.m.mogalapalli@oracle.com>, Helge Deller <deller@gmx.de>, Thomas
 Zimmermann <tzimmermann@suse.de>, Daniel Vetter <daniel@ffwll.ch>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 bigeasy@linutronix.de, LKML <linux-kernel@vger.kernel.org>, Vegard Nossum
 <vegard.nossum@oracle.com>, George Kennedy <george.kennedy@oracle.com>,
 Darren Kenny <darren.kenny@oracle.com>, chuansheng.liu@intel.com
Subject: Re: [bug-report] task info hung problem in fb_deferred_io_work()
Message-ID: <20240419173443.6c49706e@namcao>
In-Reply-To: <CAMeQTsbEjUyOYDAF-kFwTcovLr+8gHQGa27jPkeeJqmLhwbTag@mail.gmail.com>
References: <271372d6-e665-4e7f-b088-dee5f4ab341a@oracle.com>
	<20240418160652.68df1a86@namcao>
	<87ttjywxv5.wl-tiwai@suse.de>
	<a7843657-c3f6-4d2e-8c36-5541d4c52956@gmx.de>
	<878r19voks.wl-tiwai@suse.de>
	<5febb249-1d4d-4ea7-b031-1df4d14620d2@oracle.com>
	<8734rhvlr2.wl-tiwai@suse.de>
	<CAMeQTsbEjUyOYDAF-kFwTcovLr+8gHQGa27jPkeeJqmLhwbTag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2024-04-19 Patrik Jakobsson wrote:
> Neither cancel_delayed_work_sync() or flush_delayed_work() prevent new
> work from being scheduled after they return.

flush_delayed_work() is called during device closing. And because no
writes are performed after the device has been closed, no new work
should be queued after flush_delayed_work().

> But
> cancel_delayed_work_sync() at least makes sure the queue is empty so
> the problem becomes less apparent.
> 
> Could this explain what we're seeing?

I suspect that cancel_delayed_work_sync() is only treating the symptoms
by preventing the deferred work from running. The real bug is "someone"
giving fb_deferred_io_work() invalid pages to work with. But that's
just a blind guess.

Best regards,
Nam

