Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC29E7CB144
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjJPRW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPRW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:22:28 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6AF83
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:22:26 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d9443c01a7336-1ca052ec63bso26879385ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697476946; x=1698081746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fzazQLMiElf0E2rTzrIHqd72McOV2ajmxD+aMmf7vqY=;
        b=CAgtLmkjiuoqkGRgCTLpRenMfACIUPcqXrX8nGL+mFdXKqYOoiBywqmDJt3ZGhUOxq
         DMNoLuEvacjgOjF3cKnSIWzdBSL0Zs4x9Rvzyt4D5Xx84lBMP0KbkDCcOL71OtYXwwr6
         BI7t6J0eH1xmIe6DDymvq82D6mEsiwA9AFBWi4+MdMww8eWYUhnXcTT4k2Kr53jJcniZ
         62NkJ2SzfwEmEKyryxTBbiAyWxuX5UIPe5TPuiG1516A8lEgt7cmoUwfcSD8/Vm/mAJH
         BzWEMRyJAWY5aNxiQQHnPzK+OKCmxYCSOqXkZM22I154T2Xcqwq5+EhPZGXJ6FzS3j/l
         jluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697476946; x=1698081746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzazQLMiElf0E2rTzrIHqd72McOV2ajmxD+aMmf7vqY=;
        b=cRmFRRcRN5Nglq4N52X3YftNsCHbL07rzSmA9nugcglwTs05YueU/odWa+g41xgjQ6
         v7aw4KNecCOz2LI9I9u3Y/sLcjLEOKFHGCZZgSveKOCx5DShNzOmawLE8aVq4vuYCFh7
         ysBzMeiRsaNxndmbAP2FffgNVGw2oMJ7/gs/8mU18pH9LCNODMM0Ki8nne4RJW2gYGB3
         Z8SFJV8Ys7h3LiMRLQGxbo90RWhZ7dzVFFmZaMPgP0WC+jExBombOZdFAxtcSv/jpQvs
         6kMsr9ljLzvJl+kS22bNlQEmxFCVaLHfZpYO0lsTf/RYdfRKuOWGTZvlqi4ZM7BdSUgg
         YIuQ==
X-Gm-Message-State: AOJu0YwY0xIi0CXZbgUkBrzRk1N1Sz20CKBt6wRSQVg3bVamnUOoxGnY
        45uY5Pg+zQwp9SC+iFlevsk=
X-Google-Smtp-Source: AGHT+IFu32FXclE93vnrfHvsUnNd7aLyilrnezvtfZPodtmCbOs68G8/SX15ddka7PWiK1VxXkXDQA==
X-Received: by 2002:a17:903:2445:b0:1ca:2497:554 with SMTP id l5-20020a170903244500b001ca24970554mr9560472pls.8.1697476945945;
        Mon, 16 Oct 2023 10:22:25 -0700 (PDT)
Received: from manas-VirtualBox.iitr.ac.in ([103.37.201.178])
        by smtp.gmail.com with ESMTPSA id ik5-20020a170902ab0500b001b8622c1ad2sm8926936plb.130.2023.10.16.10.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 10:22:25 -0700 (PDT)
From:   Manas Ghandat <ghandatmanas@gmail.com>
To:     dave.kleikamp@oracle.com, shaggy@kernel.org
Cc:     Manas Ghandat <ghandatmanas@gmail.com>,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+9924e2a08d9ba0fd4ce2@syzkaller.appspotmail.com
Subject: [PATCH] jfs: fix slab-out-of-bounds Read in dtSearch
Date:   Mon, 16 Oct 2023 22:41:30 +0530
Message-Id: <20231016171130.15952-1-ghandatmanas@gmail.com>
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

Currently while searching for current page in the sorted entry table
of the page there is a out of bound access. Added a bound check to fix
the error.

Reported-by: syzbot+9924e2a08d9ba0fd4ce2@syzkaller.appspotmail.com
Fixes: https://syzkaller.appspot.com/bug?extid=9924e2a08d9ba0fd4ce2
Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
---
 fs/jfs/jfs_dtree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 92b7c533407c..cf67d32d5b7f 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -633,6 +633,9 @@ int dtSearch(struct inode *ip, struct component_name * key, ino_t * data,
 		for (base = 0, lim = p->header.nextindex; lim; lim >>= 1) {
 			index = base + (lim >> 1);
 
+			if (stbl[index] > 128 || stbl[index] < 0)
+				goto out;
+
 			if (p->header.flag & BT_LEAF) {
 				/* uppercase leaf name to compare */
 				cmp =
-- 
2.37.2

