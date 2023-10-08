Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F607BCF6E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 19:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344371AbjJHRsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 13:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjJHRr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 13:47:59 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B997A3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 10:47:58 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c5ff5f858dso25426385ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 10:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696787277; x=1697392077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QJoz8SDUov6EH8w2r891PJdscTvuwkuTW6wM+WMDtO8=;
        b=gBMH4Wema6+fO1Ql3z0kv5RR+wOeVYeDVieDNL04tv5gYlwtjXEG0jw3yl3P5wPyP2
         +iPmi/ln14auMZCjRGlOio/KlDgod8Ne/0Fh04+PJJkt3EtHj9csmdImF58eZ5b4Ouv3
         dxbFN7COMxyCsJshxeR5vlMSSRWOvtVupl8x8gHrb+e2KpjIU70JvRpO7WvzTko7eiMS
         /568Lma6VA1ThHtd5XZtq/ddARIiE2MQnC+D+R4kDgBKMfgMDudkMtLcZLfeTu5BSQP5
         Ji5w9fOaOyDrOsOE9Kxp8vSxGQaIlZAsvcR0IPnjgFKYM+wp/mh57b+HtMgtjnQwOUaG
         r6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696787277; x=1697392077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJoz8SDUov6EH8w2r891PJdscTvuwkuTW6wM+WMDtO8=;
        b=nuimGuum2uUr2MvbQ5iapg+KJjQhwtdItECPUKd7Z1SL1T+YM7/OjWUqfpOUEGxn0n
         17i3QEjrBMAXPknKVbPopjVd9/T2P/q+ybPmSnQfSTZ8SoFwD6JnQEJz/LUIj5mEBT8r
         Ha2yLTCXEtHLdhnjuW2iMIzu/njTbKMAEToRmHN3jsm5gL8I3ZZNrL/aqdl7KLXhi1BT
         iXg/7z/sgcrM+34dGZNAebKCQReRamq0DuQeDRnXI4cwkFaU7AX0VHl0+zg2epy//1cY
         P6KJ13je9tm9X3gQlWHRgXDkL92Qj1KZcMAVPZXM3hmTsF63i3aP8XifJS0yW/+D+A8v
         Euiw==
X-Gm-Message-State: AOJu0YywGKM4dTcl2twsJRlt2mbjP87D5OADLM40e2BhEGxAw/2anx9y
        o9f1jHeo8IlvcGf83Lc+tQsrS9Al/wYyooLSQHI=
X-Google-Smtp-Source: AGHT+IE5/VaCHBxl0zQmbH6k5aueCLYd63UoBV/FHcEYzYhDOT8Gh5hnx8Yu2Vjd6+SWWeOZAHn77Q==
X-Received: by 2002:a17:903:48f:b0:1c7:2c07:ca00 with SMTP id jj15-20020a170903048f00b001c72c07ca00mr10512562plb.36.1696787277368;
        Sun, 08 Oct 2023 10:47:57 -0700 (PDT)
Received: from manas-VirtualBox.iitr.ac.in ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f54900b001c47541ecd7sm7757861plf.250.2023.10.08.10.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 10:47:56 -0700 (PDT)
From:   Manas Ghandat <ghandatmanas@gmail.com>
To:     dave.kleikamp@oracle.com, shaggy@kernel.org
Cc:     Manas Ghandat <ghandatmanas@gmail.com>,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+c1056fdfe414463fdb33@syzkaller.appspotmail.com
Subject: [PATCH] jfs : fix array-index-out-of-bounds in diWrite
Date:   Sun,  8 Oct 2023 23:17:45 +0530
Message-Id: <20231008174745.27342-1-ghandatmanas@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently while copying dtree root from inode to dnode in the xp slot
there is a out of bound memcpy. Added a bound check to the memcpy.

Reported-by: syzbot+c1056fdfe414463fdb33@syzkaller.appspotmail.com
Fixes: https://syzkaller.appspot.com/bug?extid=c1056fdfe414463fdb33
Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
---
 fs/jfs/jfs_imap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 799d3837e7c2..d1f897848be0 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -746,7 +746,8 @@ int diWrite(tid_t tid, struct inode *ip)
 		xp = (dtpage_t *) & dp->di_dtroot;
 		lv = ilinelock->lv;
 		for (n = 0; n < ilinelock->index; n++, lv++) {
-			memcpy(&xp->slot[lv->offset], &p->slot[lv->offset],
+			if (lv->offset < 128)
+				memcpy(&xp->slot[lv->offset], &p->slot[lv->offset],
 			       lv->length << L2DTSLOTSIZE);
 		}
 	} else {
-- 
2.37.2

