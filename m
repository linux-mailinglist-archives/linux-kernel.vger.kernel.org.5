Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5C37E8042
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344561AbjKJSI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345501AbjKJSGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:06:35 -0500
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D1A3A23B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 07:22:39 -0800 (PST)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6c337ce11ceso2238410b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 07:22:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699629759; x=1700234559;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IPzczgmFbAPnGqoNra/Exmwp4N4poyyFRIcw6m8a/SE=;
        b=kOKayaDxN+cHwYoJ1vgAyVzE8Sz6dCrDtp0a1mkUKCtK1uLY36nYfbA4S2IdlsUbe0
         G7ha+8X/kU5v/GEoyj5Vx1YLz0D5qDnFu1h6xxKu52h+8Rzu3X4oW0whMAxM5BMuhQ02
         0TNrD1iaziOiMpHMbDzrI6UrjZxiMD8xF/dMZ+YO1TLh9CG2tQyuo+EnwdUA6eqhs2L9
         AVVyRx8U32jDtlvUyo/DW9J1E+9Lglb4AN0KLrUeNiSIx75Tg4IC69jDjow/ZPbAg+I4
         eHs1oHc9BaqTySKBN+Qyz8QqGTnkfW2n22wibny7LPFZ/KawumZDXUhS9c2III19rlfR
         X27g==
X-Gm-Message-State: AOJu0YzdCOxkasZ4M0Xe8IkanZQV0XGyjQpdbeQna1pPMtjKR8pDiKDr
        zWeCgGGFm0rrqy57eorOfM0RafGpLZBUdB6bY8z72U18VDKUyDE=
X-Google-Smtp-Source: AGHT+IFYqh2CDJOTP9gjjrkWFS2OqzwrSWw++vCFmz78cuq2DouDS2F3CzL1A74OajqghpbSyU2etHMyB51WGpyzsUMsPRwSmvEn
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:bdd:b0:6c0:4f6f:ef83 with SMTP id
 x29-20020a056a000bdd00b006c04f6fef83mr1285433pfu.6.1699629758867; Fri, 10 Nov
 2023 07:22:38 -0800 (PST)
Date:   Fri, 10 Nov 2023 07:22:38 -0800
In-Reply-To: <000000000000ade4f305fc36868f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000006f2f80609cde40a@google.com>
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

#syz test:
https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 drivers/usb/core/devio.c | 2 ++
 1 file changed, 2 insertions(+)

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
-- 
2.25.1

