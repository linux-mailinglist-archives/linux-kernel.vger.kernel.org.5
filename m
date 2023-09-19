Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EE07A6862
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 17:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjISP4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 11:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjISP4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:56:11 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63AC93
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 08:56:05 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-690c6f4f6a5so632362b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 08:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695138965; x=1695743765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nOHqs4qAkXtTB8hx364ax6AK99btnMvdjW46PwKkTo4=;
        b=FAm6Wrd5V8M3lDqXKcVpflMeWukDHevCpLo83ExB2YMf1ibAJsKMHDOD0iwsIPOOnv
         WERFAqkcbPNM8BZ1n2LN6bRz0C/vz9VL6I/RsWCV7CHWLVS0kwJ3IloiJcZ2oihGjmrV
         tngo8l/5pZF8qxenhMSqw5UQP1+0Bt9WBjbbb21QBds7DxDI6NGIWudwbie1QZPfxJ01
         hTE58/1PyoCbPx/rW4kGMSSSTIlivZZocCSukcXvCnnItdS6+YgrAnxs/C802wNDBMOn
         /4HHWvOihPtpgX9xrieS+77h+Qnvc0ScaAnbu3m3m4Ujl5SPcUUqhWwksxMtG4MLFwF1
         bP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695138965; x=1695743765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nOHqs4qAkXtTB8hx364ax6AK99btnMvdjW46PwKkTo4=;
        b=t1z3nFiwSyDnXxvSuS4T6NGARuDvWXpgkp1jJQBMMcjWULwYwD/YBb2CcIz8vHm4DD
         /Ud9mSiKbC61JMmdHxkTDtXqzUYNawJd7G9m1xLmm3vhnWrn7+iWA8suGPaZ7t05C/V3
         keETkaxB9E84Qjnq6t/O+wRepgjxwp5iopmpv72RkSKn24Ojb69CZI2ato0FmxVHfvse
         RzlLLWrkN9urWIR6rOQ8RYI3Mbi7mXsJoxOf/RrsTLh8fX7QlFVGBPedU2hlzJnodsRb
         FFeuKuIxOZNJ31Ru7C/TKPH4FM36pc/ONL/cVQibz0BiHg8pq4/zuSZmoecLxGSZBSAB
         9Dqg==
X-Gm-Message-State: AOJu0Yw0gw4S1djbwjNjk5egB/iVGqK6FO+YzFBmXHRimJSKQjz6zron
        jMr9uZlcD45TDf6rzEbuLws=
X-Google-Smtp-Source: AGHT+IE0y3FysbDgGuSL0FvAtrT32Ve9Gq3DbLiI0l5tKFSTY2C0ADc+ebEoQua8RovmKSbfgcIckA==
X-Received: by 2002:a05:6a21:47c6:b0:140:a25:1c1d with SMTP id as6-20020a056a2147c600b001400a251c1dmr9500637pzc.51.1695138965147;
        Tue, 19 Sep 2023 08:56:05 -0700 (PDT)
Received: from manas-VirtualBox.iitr.ac.in ([103.37.201.177])
        by smtp.gmail.com with ESMTPSA id bm1-20020a056a00320100b0068fece2c190sm8739890pfb.70.2023.09.19.08.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 08:56:04 -0700 (PDT)
From:   Manas Ghandat <ghandatmanas@gmail.com>
To:     shaggy@kernel.org
Cc:     Manas Ghandat <ghandatmanas@gmail.com>,
        linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+0558d19c373e44da3c18@syzkaller.appspotmail.com
Subject: [PATCH] jfs : fs array-index-out-of-bounds in txCommit
Date:   Tue, 19 Sep 2023 21:25:42 +0530
Message-Id: <20230919155542.4354-1-ghandatmanas@gmail.com>
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

Currently there is no check for out of bound access for xad in the
struct xtpage_t. Added the required check at various places for the same

Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
Reported-by: syzbot+0558d19c373e44da3c18@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0558d19c373e44da3c18
Fixes: df0cc57e057f
---
 fs/jfs/jfs_txnmgr.c | 4 ++++
 fs/jfs/jfs_xtree.c  | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index ce4b4760fcb1..6c6640942bed 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -1722,6 +1722,10 @@ static void xtLog(struct jfs_log * log, struct tblock * tblk, struct lrd * lrd,
 			jfs_err("xtLog: lwm > next");
 			goto out;
 		}
+		if (lwm >= XTROOTMAXSLOT) {
+			jfs_err("xtLog: lwm out of range");
+			goto out;
+		}
 		tlck->flag |= tlckUPDATEMAP;
 		xadlock->flag = mlckALLOCXADLIST;
 		xadlock->count = next - lwm;
diff --git a/fs/jfs/jfs_xtree.c b/fs/jfs/jfs_xtree.c
index 2d304cee884c..57569c52663e 100644
--- a/fs/jfs/jfs_xtree.c
+++ b/fs/jfs/jfs_xtree.c
@@ -357,6 +357,9 @@ static int xtSearch(struct inode *ip, s64 xoff,	s64 *nextp,
 		for (base = XTENTRYSTART; lim; lim >>= 1) {
 			index = base + (lim >> 1);
 
+			if (index >= XTROOTMAXSLOT)
+				goto out;
+
 			XT_CMP(cmp, xoff, &p->xad[index], t64);
 			if (cmp == 0) {
 				/*
@@ -618,6 +621,9 @@ int xtInsert(tid_t tid,		/* transaction id */
 		memmove(&p->xad[index + 1], &p->xad[index],
 			(nextindex - index) * sizeof(xad_t));
 
+	if (index >= XTROOTMAXSLOT)
+		goto out;
+
 	/* insert the new entry: mark the entry NEW */
 	xad = &p->xad[index];
 	XT_PUTENTRY(xad, xflag, xoff, xlen, xaddr);
-- 
2.37.2

