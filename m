Return-Path: <linux-kernel+bounces-155106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C688AE555
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D08283A7B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEDC13C911;
	Tue, 23 Apr 2024 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aXPsKAUY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GE4xxKg1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F93586AC8;
	Tue, 23 Apr 2024 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713873069; cv=none; b=KGD/KoueUc7JuL9Db+O5t3VM4VeAkAw/0EzZaMoQzU5rmkxN2XSAte0cSs/GeNPOdP9XlXuoQzidPB9W6ClxUStnvJOOONS51dg/yk9kQnlxphgIAKKq1RJ/IVhjSnOuSExfacW8d1oaCb3eqFHqevart0fgntkYQSpgxWATQ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713873069; c=relaxed/simple;
	bh=cQlvbfsGcivyYSvJInJbINjshicdDs+x+gygQ5JtuVw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lebVsHrNnjZfIiNV8u7XIKht5+7kR28kVnbsVfqNHgb1U64dtmi4rWstXCRl/SHiwhddVN8VZDvI6u0L6CDsLFb72oQvvhc750Xv0GDfl4hhaa/A49x8KNPv/J2JI8ZfUTB3SG/L1IIgIddkExZOtbx9sXE+8CqI4VajpLrLHAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aXPsKAUY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GE4xxKg1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713873066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nId7yfti82jidSrNPjc6pFuqg7gFIn/sC7IuAdW8lsU=;
	b=aXPsKAUYw1xfZIpf+JY5/kFVVaYhclqesT8eNqgRT8QWYp1fy4f9W5cQ96InRPMjc81Tpx
	nym17Np9zhy/o3PSY9GC/WTSdhfRe+zxZSVwmbqMXeo3yn2tqse+UJuXmeNaGfVwo/IbP9
	RR3rhvZjylHfmhNtzwK09DsCc8k/8g/0t1tjCJrhQ1J95nsyOWOMIqkiDN3E1o5jt20Hgn
	s/YPG9lovejnpZaT0rezWC1uHCgOWJuH0gnvH7cqE+4nrcpoVWHam+o4J+mUFM62wAMK2T
	OI+cmh+RvVNalgAyize0CWS0YTZ5x5QxY/pEWFLqPW+7if4zFIOUqwOqCTRuJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713873066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nId7yfti82jidSrNPjc6pFuqg7gFIn/sC7IuAdW8lsU=;
	b=GE4xxKg1OleHEYvmyB77Oha0O4topex9HjYpEQVHoc0U0xyzeSVNI6gWt2wOvfF5KCOqyl
	pYqRuHdMYzNWmjBA==
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
Subject: [PATCH v2] fbdev: fix incorrect address computation in deferred IO
Date: Tue, 23 Apr 2024 13:50:53 +0200
Message-Id: <20240423115053.4490-1-namcao@linutronix.de>
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

This offset calculation is only correct if the virtual memory area is
mapped to the beginning of the internal buffer. Otherwise this is wrong.
For example, if users do:
    mmap(ptr, 4096, PROT_WRITE, MAP_FIXED | MAP_SHARED, fd, 0xff000);

Then the virtual memory area will mapped at offset 0xff000 within the
internal buffer. This offset 0xff000 is not accounted for, and wrong page
is updated.

Correct the calculation by using vmf->pgoff instead. With this change, the
variable "offset" will no longer hold the exact offset value, but it is
rounded down to multiples of PAGE_SIZE. But this is still correct, because
this variable is only used to calculate the page offset.

Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Closes: https://lore.kernel.org/linux-fbdev/271372d6-e665-4e7f-b088-dee5f4a=
b341a@oracle.com
Fixes: 56c134f7f1b5 ("fbdev: Track deferred-I/O pages in pageref struct")
Cc: <stable@vger.kernel.org>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
v2:
  - simplify the patch by using vfg->pgoff
  - remove tested-by tag, as the patch is now different

 drivers/video/fbdev/core/fb_defio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core=
/fb_defio.c
index 1ae1d35a5942..b9607d5a370d 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -196,7 +196,7 @@ static vm_fault_t fb_deferred_io_track_page(struct fb_i=
nfo *info, unsigned long
  */
 static vm_fault_t fb_deferred_io_page_mkwrite(struct fb_info *info, struct=
 vm_fault *vmf)
 {
-	unsigned long offset =3D vmf->address - vmf->vma->vm_start;
+	unsigned long offset =3D vmf->pgoff << PAGE_SHIFT;
 	struct page *page =3D vmf->page;
=20
 	file_update_time(vmf->vma->vm_file);
--=20
2.39.2


