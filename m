Return-Path: <linux-kernel+bounces-151625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA0D8AB146
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CAD01F24198
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E9B12F586;
	Fri, 19 Apr 2024 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s3ApxoBz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qItYvkou"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E787C08E;
	Fri, 19 Apr 2024 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539073; cv=none; b=td5izG+LVAj9KZCFh8zbAcJuw18r/F5gv5GnTN9PDpopZjV+V2SWLk1BS9DsXQ8eSFpjuYk1tnNtzq8z3ee+emPKcUFcmxzquxan3VI9OsIyHfjwqRcZugi5wDGwjXwA1YSKiJk7Fb3aTQ5aJjO76FJlW93PcAq9arqxHbVnpWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539073; c=relaxed/simple;
	bh=kFKf8tNcChxx7D8qXTnVEns97I1cqu8Uv2J5Bx7MT4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HKRhf9ocffPHvaD95MkFZwuTkhSW7K5FukuY+oWA/gIWnrdWH3IHAZ4X/7vMD4CGaXmgXB5JL5GxAFa/dbIvP4Ch9RdtDLd51sd7i7fp7CdvWF4tgKtrD+0s8AnAIwXigM2oUiP3+yEGWyI/fs6r9fRYJv5knCesYOvaufKRuF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s3ApxoBz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qItYvkou; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 19 Apr 2024 16:59:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713538760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFy5tOWbJnHTTd/HH6FM6qdDQdeNlfnkJofdVo0X314=;
	b=s3ApxoBzIv0PB3/Nw0NGixvnGITT3G2fuw5pfNYi04ilb57GqyalvJGnKjwccYgI2fp1kj
	8HyiAC5Djo3/FrYcKZR4VG0g5Eba2R8RVmKmj7pRCvNpUaWnaKDmBDTMmWMljOiZ0aMmby
	+2YugeVRvKutvbuEmrIsA0lyWo/KCIPkWLcSr8KYJn+wvIjPtzHKIpeI7/TGhHwkpAlIGA
	Np6w3qaaICsQrUYFZnKzRtiG00uW26GfPXfnyrargzkMMc2hvBDSWdi6Y92mjKundFjDSc
	hcpqdjllZN8KLaTveok1mynYjsiJkGjUSVLvIy4R2Ri6fKWR60e/vmW5JBuvvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713538760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFy5tOWbJnHTTd/HH6FM6qdDQdeNlfnkJofdVo0X314=;
	b=qItYvkoudQJSixjUBY0qqqIQtxPVYizlro6RKTJGIklkRVZEzDfJBLR65hE0591zo5ajSi
	rot6xhQP1EZ/AkAg==
From: Nam Cao <namcao@linutronix.de>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: jayalk@intworks.biz, Daniel Vetter <daniel@ffwll.ch>, deller@gmx.de,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 tiwai@suse.de, bigeasy@linutronix.de, patrik.r.jakobsson@gmail.com, LKML
 <linux-kernel@vger.kernel.org>, Vegard Nossum <vegard.nossum@oracle.com>,
 George Kennedy <george.kennedy@oracle.com>, Darren Kenny
 <darren.kenny@oracle.com>, chuansheng.liu@intel.com
Subject: Re: [bug-report] task info hung problem in fb_deferred_io_work()
Message-ID: <20240419165915.228c76e9@namcao>
In-Reply-To: <271372d6-e665-4e7f-b088-dee5f4ab341a@oracle.com>
References: <271372d6-e665-4e7f-b088-dee5f4ab341a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2024-04-18 Harshit Mogalapalli wrote:
> While fuzzing 5.15.y kernel with Syzkaller, we noticed a INFO: task hung 
> bug in fb_deferred_io_work()

I think the problem is because of improper offset address calculation.
The kernel calculate address offset with:
	offset = vmf->address - vmf->vma->vm_start

Now the problem is that your C program mmap the framebuffer at 2
different offsets:
	mmap(ptr, 4096, PROT_WRITE, MAP_FIXED | MAP_SHARED, fd, 0xff000);
	mmap(ptr, 4096, PROT_WRITE, MAP_FIXED | MAP_SHARED, fd, 0);

but the kernel doesn't take these different offsets into account.
So, 2 different pages are mistakenly recognized as the same page.

Can you try the following patch?

Best regards,
Nam

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index dae96c9f61cf..d5d6cd9e8b29 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -196,7 +196,8 @@ static vm_fault_t fb_deferred_io_track_page(struct fb_info *info, unsigned long
  */
 static vm_fault_t fb_deferred_io_page_mkwrite(struct fb_info *info, struct vm_fault *vmf)
 {
-	unsigned long offset = vmf->address - vmf->vma->vm_start;
+	unsigned long offset = vmf->address - vmf->vma->vm_start
+			+ (vmf->vma->vm_pgoff << PAGE_SHIFT);
 	struct page *page = vmf->page;
 
 	file_update_time(vmf->vma->vm_file);



