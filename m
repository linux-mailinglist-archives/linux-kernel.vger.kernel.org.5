Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16D47C5726
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344784AbjJKOj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbjJKOjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:39:55 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC53892
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 07:39:53 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-690bc3f82a7so5364611b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 07:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697035193; x=1697639993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fQNK4cZppGs8Y8rM4h3XQeL/bSmNLB40k5aLUnjJJ7g=;
        b=BrZwl5gY3xDf4qkKwNQIeXvGGQlK9YJBFZnLKOF0ARHJkmJdEpzo5EtWwkpgyjs3nN
         79dwEkHZ9AyhtalfZvoxM/NlWVLzagoDZPPpU/YZ/IRVuE62hbSsmpqoILenYUVMIuu+
         osEYeQo+Iaxy4RNqmS1Cc3Z/PiV9s/trKzSa3RHSFEjh23eH/Jq02Qdd8N+xmvPiC5D8
         4tEHEDz1xahF+7uEesgO0te6F7aEMo1cMdW8NA89X65+7EGFz7BcFi9wFIdrsV6ns/LT
         xXRcD8JtCT79uz6c0bn2oy2/gIACMwWlPfXNRr0/+wXDMjCuBjW6egaeMDFipAFGxq4A
         jrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697035193; x=1697639993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fQNK4cZppGs8Y8rM4h3XQeL/bSmNLB40k5aLUnjJJ7g=;
        b=KSc7uh43iEpfrFIIAqv4AussIs2OqQcjptpzopO1QL61gXv6gHIQteZIHbygRg+/XT
         hq4AtTu/WZ3LeYOaMR3kDmHGC6VMf7UrcT+e6D4EUfKBI6nLI8t20uC9O4Zt0gmJwafp
         cOViYxTwrOJHu54aUakyW0Q9nv29UklxB05bwpI4ir/VnvfcKXISoI5c7pVu56uXr7wr
         aiRbliHnuhUhxye1ZPf1idNiyZxO4bx1QO9tQWl/1SqyLxAN8U+kBKgLqI1bIkKyvymg
         2p24fxgGZ+b7cjTuOYwPJ1l008zCbCSef0TjoU5qX1SoWnBxj3dQIXuAmWg+tOpvdyLg
         G+0w==
X-Gm-Message-State: AOJu0YxDP5SJiVQu9mrS0HvWcdXWp+GtaqfgK7MIBz/IkZXtZrxThaic
        WZtSAvouz7FPBXHKp6CKhq8=
X-Google-Smtp-Source: AGHT+IE6Ikt3sjADpcL2G+goBGqBF7/yE9bydDfjiJ4t5gPY9YMYFFqsRsWWbZrdhK57fjiyveTMXA==
X-Received: by 2002:a05:6a21:788a:b0:125:517c:4f18 with SMTP id bf10-20020a056a21788a00b00125517c4f18mr22055418pzc.8.1697035193173;
        Wed, 11 Oct 2023 07:39:53 -0700 (PDT)
Received: from manas-VirtualBox.iitr.ac.in ([103.37.201.179])
        by smtp.gmail.com with ESMTPSA id x16-20020a170902ec9000b001c61901ed2esm13874266plg.219.2023.10.11.07.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 07:39:52 -0700 (PDT)
From:   Manas Ghandat <ghandatmanas@gmail.com>
To:     dave.kleikamp@oracle.com, shaggy@kernel.org
Cc:     Manas Ghandat <ghandatmanas@gmail.com>,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+411debe54d318eaed386@syzkaller.appspotmail.com
Subject: [PATCH] jfs: fix shift-out-of-bounds in dbJoin
Date:   Wed, 11 Oct 2023 20:09:37 +0530
Message-Id: <20231011143937.31996-1-ghandatmanas@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently while joining the leaf in a buddy system there is shift out
of bound error in calculation of BUDSIZE. Added the required check 
to the BUDSIZE and fixed the documentation as well.

Reported-by: syzbot+411debe54d318eaed386@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=411debe54d318eaed386
Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
---
 fs/jfs/jfs_dmap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 6b838d3ae7c2..baa97bda1c7a 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -2730,7 +2730,9 @@ static int dbBackSplit(dmtree_t * tp, int leafno)
  *	leafno	- the number of the leaf to be updated.
  *	newval	- the new value for the leaf.
  *
- * RETURN VALUES: none
+ * RETURN VALUES:
+ *  0		- success
+ *	-EIO	- i/o error
  */
 static int dbJoin(dmtree_t * tp, int leafno, int newval)
 {
@@ -2757,6 +2759,10 @@ static int dbJoin(dmtree_t * tp, int leafno, int newval)
 		 * get the buddy size (number of words covered) of
 		 * the new value.
 		 */
+
+		if ((newval - tp->dmt_budmin) > BUDMIN)
+			return -EIO;
+
 		budsz = BUDSIZE(newval, tp->dmt_budmin);
 
 		/* try to join.
-- 
2.37.2

