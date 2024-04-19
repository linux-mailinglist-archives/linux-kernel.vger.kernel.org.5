Return-Path: <linux-kernel+bounces-151891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 552C38AB55A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45BC1F21425
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D6413C3FF;
	Fri, 19 Apr 2024 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vhf1rzDV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PplcsBRD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4A8C8DE;
	Fri, 19 Apr 2024 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713553264; cv=none; b=ZgnyGpG0Pgfs1qvvWi8Qy59YQnYvLBohIbmd8ffM3vuElDr1M9QpnE4fDD4yO66dwkIMCMgJ929EhRXyftZjyrRsXbY+HKjxW7az6+g3gk6i3tr+P8o1xuy4ZIRtd6I5SfI9Sv4XGvFsFVT8MBDec8rzYjYMnafFoMesBOrGcwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713553264; c=relaxed/simple;
	bh=ugcejKN/8bnvBn8l5R62QNpOVWEX5fo+kneA8+gug5o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MGxY+ox7O7yTIQ9rP2Wu0ZZcObT/Rhw/cAQnrWu9pkFOMrDr3omYXZ3Pec2l4DDNbXgTJM/QK/kwuRD5liaZ6fNHesUwrvWofY+K3xc4e5zdgDH/bcBEpwAn4IZRuRR9749AOFkR/iw8vIVFZqpnpc7V89x8Km3lF75WZj602k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vhf1rzDV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PplcsBRD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713553241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y/Mk5BsbEdPJv8VhsnLb8RYA6psPnj/he2tHNKR8Z40=;
	b=vhf1rzDVQfE+/pOsWmkzBlegxqrjQuuESIAJdtotPXce6QuVJ6YaC6HifvsNYVnDhQgJa0
	Lfr3oFEIan0WVRvty2I1nNaQXfnTx0Wmfp0aum6T8h4LMCeO/lYjQHhrn6aKCOP50LcI+u
	YBprsuhsoxofF7tTDEWdgxI8RLR40An9nvdMPLEb1H/mgLt8KXvCj+Jx9ZWzhsRybm+UAA
	EXwHepNbnvBxF3I0u2ryueoFrfLDW2cluNB8c0cdNntvY3qWhItvwxmvqohbBHFMU4+Y7z
	53x9kfZQMMjT5VQq2/UKdPofyY5PT2gj8eWbMCBPyK2BLuDvbTVrR6Qwi8gqSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713553241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y/Mk5BsbEdPJv8VhsnLb8RYA6psPnj/he2tHNKR8Z40=;
	b=PplcsBRDDf6zq+QhZEMuFbhwBir7skqDABVWyD78qtxe3KSN0aak49/olGdQdBYu1n8YLM
	te0wsKuJFRXt63BQ==
To: Jaya Kumar <jayalk@intworks.biz>,
	Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: tiwai@suse.de,
	namcao@linutronix.de,
	bigeasy@linutronix.de,
	patrik.r.jakobsson@gmail.com,
	Vegard Nossum <vegard.nossum@oracle.com>,
	George Kennedy <george.kennedy@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>,
	chuansheng.liu@intel.com,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	stable@vger.kernel.org
Subject: [PATCH] fbdev: fix incorrect address computation in deferred IO
Date: Fri, 19 Apr 2024 21:00:32 +0200
Message-Id: <20240419190032.40490-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With deferred IO enabled, a page fault happens when data is written to the
framebuffer device. Then driver determines which page is being updated by
calculating the offset of the written virtual address within the virtual
memory area, and uses this offset to get the updated page within the
internal buffer. This page is later copied to hardware (thus the name
"deferred IO").

This calculation is only correct if the virtual memory area is mapped to
the beginning of the internal buffer. Otherwise this is wrong. For example,
if users do:
    mmap(ptr, 4096, PROT_WRITE, MAP_FIXED | MAP_SHARED, fd, 0xff000);

Then the virtual memory area will mapped at offset 0xff000 within the
internal buffer. This offset 0xff000 is not accounted for, and wrong page
is updated. This will lead to wrong pixels being updated on the device.

However, it gets worse: if users do 2 mmap to the same virtual address, for
example:

    int fd =3D open("/dev/fb0", O_RDWR, 0);
    char *ptr =3D (char *) 0x20000000ul;
    mmap(ptr, 4096, PROT_WRITE, MAP_FIXED | MAP_SHARED, fd, 0xff000);
    *ptr =3D 0; // write #1
    mmap(ptr, 4096, PROT_WRITE, MAP_FIXED | MAP_SHARED, fd, 0);
    *ptr =3D 0; // write #2

In this case, both write #1 and write #2 apply to the same virtual address
(0x20000000ul), and the driver mistakenly thinks the same page is being
written to. When the second write happens, the driver thinks this is the
same page as the last time, and reuse the page from write #1. The driver
then lock_page() an incorrect page, and returns VM_FAULT_LOCKED with the
correct page unlocked. It is unclear what will happen with memory
management subsystem after that, but likely something terrible.

Fix this by taking the mapping offset into account.

Reported-and-tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.c=
om>
Closes: https://lore.kernel.org/linux-fbdev/271372d6-e665-4e7f-b088-dee5f4a=
b341a@oracle.com
Fixes: 56c134f7f1b5 ("fbdev: Track deferred-I/O pages in pageref struct")
Cc: stable@vger.kernel.org
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 drivers/video/fbdev/core/fb_defio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core=
/fb_defio.c
index dae96c9f61cf..d5d6cd9e8b29 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -196,7 +196,8 @@ static vm_fault_t fb_deferred_io_track_page(struct fb_i=
nfo *info, unsigned long
  */
 static vm_fault_t fb_deferred_io_page_mkwrite(struct fb_info *info, struct=
 vm_fault *vmf)
 {
-	unsigned long offset =3D vmf->address - vmf->vma->vm_start;
+	unsigned long offset =3D vmf->address - vmf->vma->vm_start
+			+ (vmf->vma->vm_pgoff << PAGE_SHIFT);
 	struct page *page =3D vmf->page;
=20
 	file_update_time(vmf->vma->vm_file);
--=20
2.39.2


