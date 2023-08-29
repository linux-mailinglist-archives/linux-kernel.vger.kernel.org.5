Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDC678C9F5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 18:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbjH2QxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 12:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237589AbjH2Qwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:52:55 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589131B7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:52:53 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c1f7f7151fso11543765ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693327973; x=1693932773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1qQzy70Oe0bgxhcuXv4Qw9ZpdVk+SYDfFf1MSTVPxDk=;
        b=oB4niErMzCvAp+298iHDJV0d4kklPtej65wWAtbzel45dp7FsV5ZCBPQ53aCmcviR6
         blHZo9UdOMdrtc/EOfqqxV0DRBDrFwSyHYd23sKXvDdsQbcXLvYlfIzOIucpJSfiu8eM
         3/HOcDubqKZM/o4oaG4KFWX9p1ahqHrmWRXnVM6QYOZYMPWiKrtW7cQwU4xa2dkKjxA4
         m5+chF2a4q1m2/l7lbCzMSh4yMuLxSs/4YaO1rXUkbzlV1qUTZCWbOZQ9eCi3Jc+tCfn
         QerAivKLgs2C2oanuBV//E1VX36W+RB/ojn+QJn9D5Ego7bVj5vNQ1WHh4j5FPS57/5Q
         0rqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693327973; x=1693932773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1qQzy70Oe0bgxhcuXv4Qw9ZpdVk+SYDfFf1MSTVPxDk=;
        b=VR1lIv1wbpVdby/TCTo5/HBVbl1pPnmSohDt3mVRISA6+cf8eaTGMzqRNZnVgVzMNK
         5pHWLYrhty2Wn/djcGR1Go499fbCI5ZFhUkNltUx4uEvgu23zLWclZ/CMZ4akHXHKJ4z
         PTG+n553qB6anSveJvJhozubamX53Yo+2FJhMtBUbhV+cFHxW4LvUZWK6mqoJFkJrWaG
         CV4Jjsl/N4Q0eDFGy05l4/zHWMYlvtLaYUYFDyAZkJlspPLeVox54nCFeKWUhyylxjiY
         +HNYavvOKFmnGxUopr/5OO6hlBC1iGaAbNrsYk3As4U/ABXE2OqTW24VnUsaxc93E6ro
         66Ug==
X-Gm-Message-State: AOJu0Yx6w7y02LgHJRZbeuKOVYG/2pkJWRWb5xKukJI0PArvTJ8fP9y4
        slWs14xDPxsCv2LNpQjzi73fe+X3+w3hwn8L
X-Google-Smtp-Source: AGHT+IEpvMY/b0UIWmQtleMKRid8O5Pm9nwIOdAZ0pHOdoWFJLs2P7BGHY1pmCRM6vcRxWCW3jhj0g==
X-Received: by 2002:a17:902:7408:b0:1bf:73ec:b980 with SMTP id g8-20020a170902740800b001bf73ecb980mr19713324pll.66.1693327972489;
        Tue, 29 Aug 2023 09:52:52 -0700 (PDT)
Received: from manas-VirtualBox.iitr.ac.in ([103.37.201.179])
        by smtp.gmail.com with ESMTPSA id ji18-20020a170903325200b001b9da8b4eb7sm9582735plb.35.2023.08.29.09.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 09:52:51 -0700 (PDT)
From:   Manas Ghandat <ghandatmanas@gmail.com>
To:     shaggy@kernel.org, liushixin2@huawei.com
Cc:     Manas Ghandat <ghandatmanas@gmail.com>,
        linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+aea1ad91e854d0a83e04@syzkaller.appspotmail.com
Subject: [PATCH] jfs: fix array-index-out-of-bounds in dbFindLeaf
Date:   Tue, 29 Aug 2023 22:22:44 +0530
Message-Id: <20230829165244.460154-1-ghandatmanas@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently while searching for dmtree_t for sufficient free blocks there
is an array out of bounds while getting element in tp->dm_stree. Added
the required bound check.

Ps: After I added the check I am getting the following log

[   22.661748][ T4425] ERROR: (device loop0): dbAllocAny: unable to allocate blocks
[   22.661748][ T4425]
[   22.665536][ T4425] ERROR: (device loop0): remounting filesystem as read-only
[   22.667856][ T4425] jfs_mkdir: dtInsert returned -EIO
[   22.669750][ T4425] ERROR: (device loop0): txAbort:

I was wondering if these checks are significant of not?

Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
Reported-by: syzbot+aea1ad91e854d0a83e04@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=aea1ad91e854d0a83e04
---
 fs/jfs/jfs_dmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index a14a0f18a4c4..5af17b2287be 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -2948,6 +2948,10 @@ static int dbFindLeaf(dmtree_t * tp, int l2nb, int *leafidx)
 			/* sufficient free space found.  move to the next
 			 * level (or quit if this is the last level).
 			 */
+
+			if (x + n > TREESIZE)
+				return -ENOSPC;
+
 			if (l2nb <= tp->dmt_stree[x + n])
 				break;
 		}
-- 
2.37.2

