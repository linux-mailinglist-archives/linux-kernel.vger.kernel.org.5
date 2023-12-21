Return-Path: <linux-kernel+bounces-8220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D53681B3F0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B4D128111C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D586A00A;
	Thu, 21 Dec 2023 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJGWpB4f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543B76978E;
	Thu, 21 Dec 2023 10:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d04c097e34so4676665ad.0;
        Thu, 21 Dec 2023 02:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703155247; x=1703760047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=764vQaFmy7dOHEXW+A4EOmJdBTDoOKn++aJan9T3nsw=;
        b=RJGWpB4f5AOMI1nuG/jFT0BXmZKNm5yiuII6S+C8WSyLOcO5XtxRxK0PA912a29W3B
         Dtq2Frkqdeg8CtApmqmTo758/tFj5CwJAiKrc6X/WvyhcN0T/fmION/aXjKP4PNLf3yZ
         SXOv7p6V1CLnDapCNxq6uWYly0EK1zUECwipmpZ6CCn9a/OVEWXSOVbLo/AvxOmD75IE
         b5pceCMi3UHOCOuGJ3H1ajl6ZETMzxnohVXA4bvHuNciHhZ0cAXbQQ5rVywVAJGLUGBl
         SUDOhk4rVGQoUwvnrdOzRgSIKNs0+CGovH5QBuouC91YoAoMacV4ha2k76wKV34PoQ/k
         DSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703155247; x=1703760047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=764vQaFmy7dOHEXW+A4EOmJdBTDoOKn++aJan9T3nsw=;
        b=QQDCuNKxMTpLM8Gf1NxLNIBtWYcKr+Dt6LF+Cqow/8L7bfp4IO9/sdZryYWMRsyqVi
         fh7dRQwtNJpOtVJAbLZDwjxlxq+FS5FAsOsC6SJqovajm0LdaFBwCyllSDR6hcvRCHOn
         /Q8XEj7w7GphXg9MrxWs6irDL4RM+CEG7LvwTX1ceIpn+d4gTDsWKUjfQjnG8wi7lOId
         ZC8SjyrUvJU2EtPlcPm9kLZV+6xEXGKNWAg/dvGaWBn7Rb2dLbKaKv2Eg6TrV0VWXVd1
         OM+1Hfe92zDwmik5dB//HCgdoVZXiXKHPWqewz2SfQflLQT6o+1+CZovxBxp+2Fn1Xm2
         oPhg==
X-Gm-Message-State: AOJu0YyKeaY3p0jBvMgcz7a/0gSSs2iqDop/owIGBd8I1eIwqXGNXqTe
	sOV0YIq6ea1HCiu6T3wuANrj7i78ZIxtwCEM1HjMOw==
X-Google-Smtp-Source: AGHT+IETJ5enjJloFRZrnVwDcZ6bS+QXn8cAnAjlsuxA8uaHbdUSPhZK5cl+0+9HelbhterwR0dAxw==
X-Received: by 2002:a17:903:228b:b0:1d4:45b:8770 with SMTP id b11-20020a170903228b00b001d4045b8770mr598389plh.29.1703155247588;
        Thu, 21 Dec 2023 02:40:47 -0800 (PST)
Received: from g2039B650.. ([2001:da8:203:a502:3f:1d17:2d9c:d20])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902f69100b001d3dff2575fsm1320565plg.52.2023.12.21.02.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 02:40:47 -0800 (PST)
From: Gui-Dong Han <2045gemini@gmail.com>
To: gregkh@linuxfoundation.org,
	ivan.orlov0322@gmail.com,
	surenb@google.com,
	42.hyeyoo@gmail.com,
	Liam.Howlett@Oracle.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com,
	Gui-Dong Han <2045gemini@gmail.com>,
	BassCheck <bass@buaa.edu.cn>
Subject: [PATCH] usb: mon: Fix atomicity violation in mon_bin_vma_fault
Date: Thu, 21 Dec 2023 18:40:34 +0800
Message-Id: <20231221104034.4851-1-2045gemini@gmail.com>
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
developed by our team. This tool analyzes the locking APIs to extract
function pairs that can be concurrently executed, and then analyzes the
instructions in the paired functions to identify possible concurrency
bugs including data races and atomicity violations. The above possible
bug is reported, when our tool analyzes the source code of Linux 6.2.

To address this issue, it is proposed to add a spin lock pair in
mon_bin_vma_fault() to ensure atomicity. With this patch applied, our tool
never reports the possible bug, with the kernel configuration allyesconfig
for x86_64. Due to the lack of associated hardware, we cannot test the
patch in runtime testing, and just verify it according to the code logic.

Fixes: 6f23ee1fefdc1 ("USB: add binary API to usbmon")
Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
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


