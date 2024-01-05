Return-Path: <linux-kernel+bounces-17485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1451824E17
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 06:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18331C218D5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 05:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2205690;
	Fri,  5 Jan 2024 05:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/WPVtQb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576191DDD9;
	Fri,  5 Jan 2024 05:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d4a2526a7eso8045185ad.3;
        Thu, 04 Jan 2024 21:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704432269; x=1705037069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUAzjzZKcTM5m6fQb9IcdJP313nlHgCPZQcP52iARe0=;
        b=g/WPVtQbRiKwhnW1WNTkFvjsQQ9h4l5+z6Fpu31oQbOj69IHR3HJStuuIJcrbR+v6y
         PF6gsZ88MHaaNBh8wcO1Bp9rpijeyTLpLFAT/muHWQSPgd4HOz1JmM8cuYLf6/H3qgNM
         nJTk6wA0kOjuTPT5jhljrt6eBORatiHd8vN9cCl/f9EE4zWWSPByT3wzy3LNhdz2wxUX
         S1XAz7H1hoZX4AmLgMYRmAHcOX0z0ikpViknfnpbGXgHDyl2ZVyj/YsVJz/gej4o6RXg
         bA1pOMHjPjhgfSpPMPh2UKFOizCmp8AqEPwv4oifRWI8IWlGXwClTXUXD8ddb+76UzAG
         ikMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704432269; x=1705037069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUAzjzZKcTM5m6fQb9IcdJP313nlHgCPZQcP52iARe0=;
        b=WPCoB+l9+2mFNi70JqZwp6X+7zSNoDsjJkSIpAx7lTo7VNQZJeSFhiId9Y6yuSNIqZ
         m/vTR+PSACOHYjKADAsmc9LqdkGGf2LjLjJVcoV6caiOZMAMKEurZK9eNyud5smboQIs
         4L01nMxYA6swCpXRTg/qPZLLQDn8WHKFE14uNUpIpzOhWLPv08DVurrn4WubtXS8wyxb
         LHOxHpcNLWsZuhCfVpSYAaQh6z707AzSmmIdzUsB7/zWuVVH91ynl52p16xxPYuBr3H8
         5X5EwfGMejF7SWr1GVu/h+sWLHVWLW+DB/0FHiIQDzQXhINdxV+5lEBlKcO+vgw4QyKu
         bJmQ==
X-Gm-Message-State: AOJu0YxFs9lUQgexjA+vvytXBoMmoPr0OevCEoz2SIMj2wpG7Cs1ijd5
	G1W+0lAaVyVVuPSDSbx9WOU=
X-Google-Smtp-Source: AGHT+IHmvtk+B8CsCaQvyw6Z57dGQSva5h0HCt97/tCawph3GRd5Pq42T2N8B+2ctTasZPPaCMpK9A==
X-Received: by 2002:a17:903:11c5:b0:1d4:3065:6647 with SMTP id q5-20020a17090311c500b001d430656647mr1692151plh.110.1704432269542;
        Thu, 04 Jan 2024 21:24:29 -0800 (PST)
Received: from g2039B650.. ([106.39.42.152])
        by smtp.gmail.com with ESMTPSA id u3-20020a170902bf4300b001d4ea483473sm327841pls.82.2024.01.04.21.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 21:24:29 -0800 (PST)
From: Gui-Dong Han <2045gemini@gmail.com>
To: gregkh@linuxfoundation.org,
	rppt@kernel.org,
	ivan.orlov0322@gmail.com,
	akpm@linux-foundation.org,
	sebastian.reichel@collabora.com,
	surenb@google.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com,
	Gui-Dong Han <2045gemini@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] usb: mon: Fix atomicity violation in mon_bin_vma_fault
Date: Fri,  5 Jan 2024 13:24:12 +0800
Message-Id: <20240105052412.9377-1-2045gemini@gmail.com>
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

Fixes: 19e6317d24c2 ("usb: mon: Fix a deadlock in usbmon between ...")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
---
v2:
* In this patch v2, we've added some information of the static analysis
tool used, as per the researcher guidelines. Also, we've added a cc in the
signed-off-by area, according to the stable-kernel-rules.
  Thank Greg KH for helpful advice.
---
v3:
* In this patch v3, we've added a necessary blank line and adjusted the
position of spin_unlock_irqrestore() following Greg KH's suggestions.
  Thank Greg KH for helpful advice.
---
 drivers/usb/mon/mon_bin.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/mon/mon_bin.c b/drivers/usb/mon/mon_bin.c
index 9ca9305243fe..fbc1a9c0b345 100644
--- a/drivers/usb/mon/mon_bin.c
+++ b/drivers/usb/mon/mon_bin.c
@@ -1250,14 +1250,19 @@ static vm_fault_t mon_bin_vma_fault(struct vm_fault *vmf)
 	struct mon_reader_bin *rp = vmf->vma->vm_private_data;
 	unsigned long offset, chunk_idx;
 	struct page *pageptr;
-
+	unsigned long flags;
+
+	spin_lock_irqsave(&rp->b_lock, flags);
 	offset = vmf->pgoff << PAGE_SHIFT;
-	if (offset >= rp->b_size)
+	if (offset >= rp->b_size) {
+		spin_unlock_irqrestore(&rp->b_lock, flags);
 		return VM_FAULT_SIGBUS;
+	}
 	chunk_idx = offset / CHUNK_SIZE;
 	pageptr = rp->b_vec[chunk_idx].pg;
 	get_page(pageptr);
 	vmf->page = pageptr;
+	spin_unlock_irqrestore(&rp->b_lock, flags);
 	return 0;
 }
 
-- 
2.34.1


