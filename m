Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA899789B6E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 07:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjH0FFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 01:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjH0FFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 01:05:34 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B301B3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 22:05:32 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1c504386374so1618725fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 22:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693112731; x=1693717531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w0rHx36EtjFL/T0ZOtQOOpsSvLpc8KOUwP8osiOZIL0=;
        b=i+eBNMdM4lSTpRFP24YehF6M912k+AQEeLx/6M+9vqHdKwP6B9zqoZpsmlTA6ulZgt
         ZxlgfxV7NTGJDSQ8HfDdT8yU6mVYv5uze24oHmDmTNbyJI+KocZt4rdslWqJojrZFWc/
         fA+K4zN2Wb3cr0fBvInfYDO8BwDizMl10AlFDmKIbg7wol02gH5mKC83CwpX7PHJz14o
         jCqiUeVSBOgzEwJKqYDml9pIBczMUjn03ovr1s98tqPoAePz1UnVzFjvWAUIjtyxnadr
         7mItSjjXIXhf/MBnYTP2zJkaZzWK8IVr52E3oAKGsATe65bLS4K0VI0SwTK+YBdJPI38
         LPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693112731; x=1693717531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w0rHx36EtjFL/T0ZOtQOOpsSvLpc8KOUwP8osiOZIL0=;
        b=Kxr1RGmIQC9PuIforr/vBT9BM7hiMMk6AK4IbGqOhFWnrMaZ98CgdglEmY50/FQIso
         qeBNu5Q4dgfLvtMPxXe4mIZzKr/mO9CrBgYmLTTXpr/puyi1rCPOtq92p2X5uZ+xad9o
         9aH8NWoFDIpP0gXGjDIDTKaMR6SPMBSpzk+5iOA3kg0gp0OCpkMddAcs3Q+CKjl3GskF
         VrFPtAikpJowgEEtfrmENDhQFm6pEept2rX95NjBrV1SRTj/HXp1BRAqGzZFZ7D2BuAT
         f9t1WOBH+yYmPmdXUXfWTOaOAlDOqcEqNN4eqgLyeqaH7Y8ji2bovcsuvoOgmtLHAD2/
         ANuQ==
X-Gm-Message-State: AOJu0Yy/o5XuXta4hzPq3LUGj3FI3G6pYdKU7phgfIlrHBz5cUisznHa
        fjZ2tiHwUPFgee+HH3726dw=
X-Google-Smtp-Source: AGHT+IFV5CXGL6h7bvJSFe8twRRVDGSZWHsP7/eN8yNry07I+d213Z5bPkoQHWC2NlucLAqNjQ3NUg==
X-Received: by 2002:a05:6870:610b:b0:1bb:9846:94ed with SMTP id s11-20020a056870610b00b001bb984694edmr8627537oae.3.1693112730149;
        Sat, 26 Aug 2023 22:05:30 -0700 (PDT)
Received: from manas-VirtualBox.iitr.ac.in ([103.37.201.178])
        by smtp.gmail.com with ESMTPSA id ci24-20020a17090afc9800b00265a7145fe5sm6169383pjb.41.2023.08.26.22.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 22:05:29 -0700 (PDT)
From:   Manas Ghandat <ghandatmanas@gmail.com>
To:     shaggy@kernel.org, liushixin2@huawei.com
Cc:     Manas Ghandat <ghandatmanas@gmail.com>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+91ad2b52815a08caf4ea@syzkaller.appspotmail.com
Subject: [PATCH] jfs : fix shift-out-of-bounds in dbUpdatePMap
Date:   Sun, 27 Aug 2023 10:35:13 +0530
Message-Id: <20230827050513.364567-1-ghandatmanas@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is no bound check for number of logical blocks per
page (bmp->db_l2nbperpage). Added the required bound check for the
calculation of dmap.

Reported-by: syzbot+91ad2b52815a08caf4ea@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=91ad2b52815a08caf4ea
Fixes: 4d81715fc5df ("[PATCH] fs/jfs: Conversion to generic boolean")
Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
---
 fs/jfs/jfs_dmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index a3eb1e826947..6a5df296fdc8 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -467,6 +467,10 @@ dbUpdatePMap(struct inode *ipbmap,
 	lastlblkno = 0;
 	for (rem = nblocks; rem > 0; rem -= nblks, blkno += nblks) {
 		/* get the buffer for the current dmap. */
+
+		if (bmp->db_l2nbperpage > L2BPERDMAP)
+			return -EIO;
+
 		lblkno = BLKTODMAP(blkno, bmp->db_l2nbperpage);
 		if (lblkno != lastlblkno) {
 			if (mp) {
-- 
2.37.2

