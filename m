Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4487E7FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjKJR6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjKJR4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:56:20 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29553446E0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 09:28:57 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cc323b2aa3so22434245ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 09:28:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699637336; x=1700242136;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VmV6Kif29Knmt9wgqkox65kgMA6S46Dxa7pWtbIajeU=;
        b=I+vmw1m29xk5YnMdz3jXHE/u9uFG0nJiMPaZxuTGtzm9sWcoGayU5sdLT4nTPZ2Em1
         zdwvORut+FA+CzHcg4bDhANUi3BEPoiayUT7xSFH91B1F+fi7gtIMZn0LxhNi62uLvee
         rHu/Vn2oueIDxKS5VNkNssxXZP1nlX2oWv8roNJTGIi2/okZRvVx+tJDsi1jU/zq+gGk
         adTteYiXyU2FMV4GkZADy22INkU/sjzCO5sHwObadd22NZ2V2QSuRVs/6zAHYOmYLHX2
         abCEA8eAuE6EOj0r4RF72X7eZkpSOYwZtXhi7tGOamg/c4J3TqFu9BZpNH5yktbIrRJg
         Re+Q==
X-Gm-Message-State: AOJu0YwbbKuKhMct9loR9sq/UDsGTAhiRZJyLgMTImwDZXQdy9y413BJ
        1AeLwyxEFEDtEOMih/unUQ1EAGkEPTjzu/6ZYt2QpoAtRCLKWpc=
X-Google-Smtp-Source: AGHT+IFjc3aHnFZdw8p5AiZLNWzW5OAdNOe/i5nwK8y6CGof6c7hJwrfIja2r6UQPPNeVfsxkAwg1zmbR3PTOcUhEEVymllx79Qc
MIME-Version: 1.0
X-Received: by 2002:a17:902:efc1:b0:1cc:2bd6:b54a with SMTP id
 ja1-20020a170902efc100b001cc2bd6b54amr1366011plb.10.1699637336729; Fri, 10
 Nov 2023 09:28:56 -0800 (PST)
Date:   Fri, 10 Nov 2023 09:28:56 -0800
In-Reply-To: <000000000000ade4f305fc36868f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b3ef1b0609cfa7c5@google.com>
Subject: Re: [syzbot] Discardable change
From:   syzbot <syzbot+7a9bbb158a7a1071eb27@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Discardable change
Author: yuran.pereira@hotmail.com

#syz test: https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 drivers/usb/core/devio.c | 2 ++
 include/linux/page_ext.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 3beb6a862e80..22ae7babf46b 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -276,12 +276,14 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
 		if (remap_pfn_range(vma, vma->vm_start,
 				    virt_to_phys(usbm->mem) >> PAGE_SHIFT,
 				    size, vma->vm_page_prot) < 0) {
+			pr_info("==> if* vma_use_count %d\n", usbm->vma_use_count);
 			dec_usb_memory_use_count(usbm, &usbm->vma_use_count);
 			return -EAGAIN;
 		}
 	} else {
 		if (dma_mmap_coherent(hcd->self.sysdev, vma, mem, dma_handle,
 				      size)) {
+			pr_info("==> else* vma_use_count %d\n", usbm->vma_use_count);
 			dec_usb_memory_use_count(usbm, &usbm->vma_use_count);
 			return -EAGAIN;
 		}
diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index be98564191e6..fb3e7dcfbffb 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -84,6 +84,7 @@ extern void page_ext_put(struct page_ext *page_ext);
 static inline void *page_ext_data(struct page_ext *page_ext,
 				  struct page_ext_operations *ops)
 {
+	pr_info("==> offset = %ld\n", ops->offset);
 	return (void *)(page_ext) + ops->offset;
 }
 
-- 
2.25.1

