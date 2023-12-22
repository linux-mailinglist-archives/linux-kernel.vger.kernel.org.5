Return-Path: <linux-kernel+bounces-9384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B310681C4DF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4104C1F2560B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC0979C4;
	Fri, 22 Dec 2023 06:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuaaVsE2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F929944B;
	Fri, 22 Dec 2023 06:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3b86f3cdca0so1116878b6e.3;
        Thu, 21 Dec 2023 22:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703225108; x=1703829908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HBNIDOO/kNUDBzLQkjMPteisx8AB+PzGd7AfwImLK/E=;
        b=OuaaVsE2+t52r/mIEdm8C+E7+hWJmIAYmxYxLYjy1xPBhwJDU+qXqhfZkQNwJtOmIS
         5Uu+WjaP19fVr22NxNYQGKqHKJ+SRJWf1ut+vaYo3flnvyLOjXIgWtCsbVTdcw6X5iSQ
         OZ0HoSJEY5JXiHZsykclhH1eeypJ0eSwhLE6gH8ldDtf+oH7qIDEBOjrVVOGGfQ6Dquz
         4hDSh3xqtDYykySQCx/rlJyyBd42G+oeDVuUsXHoyri8TizNH1Th2BrKviQgsQF1K9D8
         BWEPwF/sJXlYok42LvyxN4zjhYJwZNeGPoNnMoN/ttPAti8+94mnqd61W/pd7qJ9XrHf
         EyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703225108; x=1703829908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBNIDOO/kNUDBzLQkjMPteisx8AB+PzGd7AfwImLK/E=;
        b=B9nRUXOtbefliQJDoKn694RthG7bfKdzgjaeOK0TPdDggvY9cZWVb6pWadOyWVzRPr
         je7bpn31otbdmy9NYZN8XX8BAf4YFBrSp2iVS55ApiIrz1DCnfjGwolyLIQrfBtwL4/J
         xV2zDH3ATIjDkZeYhBmJR75WxC4rAsSG0QEGDcy84wtrN22f9m8gjc5+yyB1LW/8pbU2
         YCu1LykCQcZ/VXblMy2RxN6+R9EKlTa72Krb1DgFPKJ8/daDH/7iPaLjUNPIKsKP+dWe
         81qov/AvmakQ09VdmUyDThXgpvST/8PyXZZr8RW48YQ6cByinKRqOQriinWueCpF0n+S
         hmoA==
X-Gm-Message-State: AOJu0Yw5GwrfLb9a9tHkA3UCptYh4Fsfcjj9/0Zgm0nwlYY9nCIZj5kz
	+Y1YegizsiZX/CEduCX84Qg=
X-Google-Smtp-Source: AGHT+IHNRDzTGhOEYhBNduVlZ74a6Gc8Cd2eSUvK9qz8tfba0ucnJZFb39vSwN/6igSIs+djUsI/AA==
X-Received: by 2002:a05:6359:6294:b0:173:70d:7364 with SMTP id se20-20020a056359629400b00173070d7364mr645317rwb.35.1703225108178;
        Thu, 21 Dec 2023 22:05:08 -0800 (PST)
Received: from g2039B650.. ([106.39.42.144])
        by smtp.gmail.com with ESMTPSA id w22-20020aa78596000000b006d97df7d4cfsm1446995pfn.0.2023.12.21.22.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 22:05:07 -0800 (PST)
From: Gui-Dong Han <2045gemini@gmail.com>
To: gregkh@linuxfoundation.org,
	surenb@google.com,
	42.hyeyoo@gmail.com,
	benjamin.tissoires@redhat.com,
	mhocko@suse.com,
	ivan.orlov0322@gmail.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com,
	Gui-Dong Han <2045gemini@gmail.com>,
	stable@vger.kernel.org,
	BassCheck <bass@buaa.edu.cn>
Subject: [PATCH v2] usb: mon: Fix atomicity violation in mon_bin_vma_fault
Date: Fri, 22 Dec 2023 14:04:50 +0800
Message-Id: <20231222060450.5449-1-2045gemini@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mon_bin_vma_fault():
	offset = vmf->pgoff << PAGE_SHIFT;
	if (offset >= rp->b_size)
		return VM_FAULT_SIGBUS;
	chunk_idx = offset / CHUNK_SIZE;
	pageptr = rp->b_vec[chunk_idx].pg;
The code is executed without holding any lock.

In mon_bin_vma_close():
	spin_lock_irqsave(&rp->b_lock, flags);
	rp->mmap_active--;
	spin_unlock_irqrestore(&rp->b_lock, flags);

In mon_bin_ioctl():
	spin_lock_irqsave(&rp->b_lock, flags);
	if (rp->mmap_active) {
		...
	} else {
		...
		kfree(rp->b_vec);
		rp->b_vec  = vec;
		rp->b_size = size;
		...
	}
	spin_unlock_irqrestore(&rp->b_lock, flags);

Concurrent execution of mon_bin_vma_fault() with mon_bin_vma_close() and
mon_bin_ioctl() could lead to atomicity violations. mon_bin_vma_fault()
accesses rp->b_size and rp->b_vec without locking, risking array
out-of-bounds access or use-after-free bugs due to possible modifications
in mon_bin_ioctl().

This possible bug is found by an experimental static analysis tool
developed by our team, BassCheck[1]. This tool analyzes the locking APIs
to extract function pairs that can be concurrently executed, and then
analyzes the instructions in the paired functions to identify possible
concurrency bugs including data races and atomicity violations. The above
possible bug is reported when our tool analyzes the source code of
Linux 6.2.

To address this issue, it is proposed to add a spin lock pair in
mon_bin_vma_fault() to ensure atomicity. With this patch applied, our tool
never reports the possible bug, with the kernel configuration allyesconfig
for x86_64. Due to the lack of associated hardware, we cannot test the
patch in runtime testing, and just verify it according to the code logic.

[1] https://sites.google.com/view/basscheck/

Fixes: 19e6317d24c25 ("usb: mon: Fix a deadlock in usbmon between ...")
Cc: stable@vger.kernel.org
Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
---
v2:
* In this patch v2, we've added some information of the static analysis
tool used, as per the researcher guidelines. Also, we've added a cc in the
signed-off-by area, according to the stable-kernel-rules.
  Thank Greg KH for helpful advice.
---
 drivers/usb/mon/mon_bin.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/mon/mon_bin.c b/drivers/usb/mon/mon_bin.c
index 9ca9305243fe..509cd1b8ff13 100644
--- a/drivers/usb/mon/mon_bin.c
+++ b/drivers/usb/mon/mon_bin.c
@@ -1250,12 +1250,16 @@ static vm_fault_t mon_bin_vma_fault(struct vm_fault *vmf)
 	struct mon_reader_bin *rp = vmf->vma->vm_private_data;
 	unsigned long offset, chunk_idx;
 	struct page *pageptr;
-
+	unsigned long flags;
+	spin_lock_irqsave(&rp->b_lock, flags);
 	offset = vmf->pgoff << PAGE_SHIFT;
-	if (offset >= rp->b_size)
+	if (offset >= rp->b_size) {
+		spin_unlock_irqrestore(&rp->b_lock, flags);
 		return VM_FAULT_SIGBUS;
+	}
 	chunk_idx = offset / CHUNK_SIZE;
 	pageptr = rp->b_vec[chunk_idx].pg;
+	spin_unlock_irqrestore(&rp->b_lock, flags);
 	get_page(pageptr);
 	vmf->page = pageptr;
 	return 0;
-- 
2.34.1


