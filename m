Return-Path: <linux-kernel+bounces-155007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 719938AE440
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279F41F21738
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A06D81722;
	Tue, 23 Apr 2024 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZMiuRte7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rOvjDt4a"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3E67D3E6;
	Tue, 23 Apr 2024 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872382; cv=none; b=V/uEyTATukCA4ktxeoEJ5iHxitoJxx5RpFxUA00qVMblIZ+14IT3pUDTiyKVF4XnkyNt/0u0HVxRO5nid3cgD781JEw1iv/5cGI2jCjxq6CoBoGSNl5546quoaoFEyLK4jBJZVjmrzMGhMp25nLqTszoDLkjHRUycWq7zKY1JT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872382; c=relaxed/simple;
	bh=kiq6atPFDm1hyItOWVUCAq5+dBPedMN0gRxrx3BomxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKPqo88MQTXOED8ggycrWT+MfKJaW2mvsnLNOjPRaF4ZlbdoCyZ9dUpZcMYmmiCd0AH1VucYX1yEk+bPeyJrULkf/DqCX5WH6Wo7alBkpnyi1AyCtfP/2uCBJnwZ9e3SPl9BJ43uj/WPtjF7R6f+0r6mqm8YZVJ2zAWX2PenJmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZMiuRte7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rOvjDt4a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 23 Apr 2024 13:39:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713872377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C0HVSv5euflJb8c+If9F5GRU+WYrGKFtrWnWjuUiGzI=;
	b=ZMiuRte76KcnQlXMkfARsv0/NVu9zZTf2RdRW62fJ1f8UkdMBDZtxd8rMIa0DKT1jip65R
	fY1CXtvwDxQDBURnwLAbSOkmad0Ccwr+Y1SwtwRmsF7DjNDCZWdrp3XxZGFa4ZJuU3IBtL
	oySHtTsXQ31/BuRd4zqmXnqvcocZp9LciGRDgR1uG2REbMWQ/g8zrtZdeSEaMs+vYu1uDq
	lQBfl01lVKtO2sA1MhjWBw+LGfDNQ11u078L1d9gXX9izl0QkatZAzLT/rqLJmawgRk7yS
	2Ct9cy4dsW+QAxxI6t/VkyuZycV2MPGtZYllVgaL39l9BtCP/GKOVP6KCwz5Vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713872377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C0HVSv5euflJb8c+If9F5GRU+WYrGKFtrWnWjuUiGzI=;
	b=rOvjDt4a/9i+oY2ZeothsvDr4PfDNwf7LljBPfGHyxVmolGoL7M4aB5i8+rAntGPMvNvDI
	PRjoFBIs7JDUlJBw==
From: Nam Cao <namcao@linutronix.de>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jaya Kumar <jayalk@intworks.biz>, Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, tiwai@suse.de, bigeasy@linutronix.de,
	patrik.r.jakobsson@gmail.com,
	Vegard Nossum <vegard.nossum@oracle.com>,
	George Kennedy <george.kennedy@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>, chuansheng.liu@intel.com,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] fbdev: fix incorrect address computation in deferred IO
Message-ID: <20240423113933.IpMjHGw7@linutronix.de>
References: <20240419190032.40490-1-namcao@linutronix.de>
 <666d986e-5227-4b6d-829c-95ff16115488@suse.de>
 <20240423095538.m79ML6a0@linutronix.de>
 <64c1585d-70e0-47d4-9d78-405b483b433c@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64c1585d-70e0-47d4-9d78-405b483b433c@suse.de>

On Tue, Apr 23, 2024 at 01:27:09PM +0200, Thomas Zimmermann wrote:
> Am 23.04.24 um 11:55 schrieb Nam Cao:
..
> > > The page-fault handler at [1] use vm_fault.pgoff to retrieve the page
> > > structure. Can we do the same here and avoid that computation?
> > Yes, thanks for the suggestion.
> > 
> > It will change things a bit: offset will not be the exact value anymore,
> > but will be rounded down to multiple of PAGE_SIZE. But that doesn't matter,
> > because it will only be used to calculate the page offset later on.
> > 
> > We can clean this up and rename this "offset" to "pg_offset". But that's
> > for another day.
> 
> But can't we use struct vm_fault.pgoff directly? The page-fault handler has
> used it since forever. The look-up code for the pageref should probably do
> the same, because there's a 1:1 connection between the page and the pageref.
> The pageref structure only exists because we cannot store its data in struct
> page directly.
> 
> AFAICT pgoff is exactly the value want to compute. See [1] and  the
> calculation at [2].

Completely agree. I just wanted to point out that the value inside the
variable "offset" won't be the same as before, but it's still correct.

I just tested the patch on real hardware, will send it shortly.

Best regards,
Nam

