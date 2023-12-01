Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1BD800B4F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378911AbjLAM4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378839AbjLAM4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:56:38 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2FD10F3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 04:56:42 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54c6896a689so359444a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 04:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1701435401; x=1702040201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m/7cKv0n7i+Sfh7Y0nPTpy9YYoZvft9zpO431GTslYc=;
        b=Sqp22FzJfmhNI6Q2Zfl0v1ry9N0axJeymXMA3hPbkA5vzLnZjTsLu0F7yCVplD78Q7
         4iv9Hfj4J9lkSDLAr8NMRDsautipaBxQVGe+OQ/twCxKFXwrOMNOEXHDWeBxjEYlMoRH
         99sdHSHC2lf2qY11J+ilWpIc4lokjq6IKaNRxqFcoj7hdsHZaflY+Zd6rJCiUzvojzLH
         Os2R55bG0/Y14M3lblcGohQ9ggSjoD70D9V2AkvZl/66jt/94lH+LlgF1U8+CfsxIzYQ
         ju5CSG9g7y3IuOln85EGl+L2fzCBQ/rPzFRN3o4+PduRo3NBf0Ky2CRRPCObLa+DGmUN
         PPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701435401; x=1702040201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/7cKv0n7i+Sfh7Y0nPTpy9YYoZvft9zpO431GTslYc=;
        b=GOrxDHkMmZAt5t/dKcx0FVqOaZIsCEI1RXpvlz5lsI9+RrjS6Vg/WWINxMKd+OUSvR
         vdVBVaQvlyDZSLvfBUlpm14M9ARjON5qQPhRTG5wvvdCi96mSPyQVvMtyToCwd/bRVL1
         AXx0Q0JgWT/waqzgh7pnrZCojJBdiR0dlEZzyqvzvl37cCig+OyMxpdy/JXlqBA534/J
         1zThFT4amA3tTgjWR2wZGBDDGAKyrAFIYR5ATTDxVxg2PG9bd8HgXP+49Tt9Hg4t4P4x
         HM8grfaJim1210sCyjBkf1SCiy5+UMqxCeQF0uRaMwPvW82vuoGQEjhiak3POgwrcBEu
         4K2g==
X-Gm-Message-State: AOJu0Yx84BGKRQRR4B33MWL41WnkrAEnTl1Kxda/5KXyEbrtNPdAqwAL
        QNne9jKtng4UzOdjdbjW7qqbgA==
X-Google-Smtp-Source: AGHT+IGgOZj2vsG0FvospNFbNTiB5LEdWj+C+Mi7rKGrBqM61c5npMqSzZynFXX3C26pm5L2fBYQ4g==
X-Received: by 2002:a17:906:6955:b0:a00:893f:58cf with SMTP id c21-20020a170906695500b00a00893f58cfmr798081ejs.54.1701435401138;
        Fri, 01 Dec 2023 04:56:41 -0800 (PST)
Received: from heron.intern.cm-ag (p200300dc6f0b6500529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f0b:6500:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id p10-20020a170906a00a00b00a0be4fec1b4sm1870231ejy.138.2023.12.01.04.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 04:56:40 -0800 (PST)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Max Kellermann <max.kellermann@ionos.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kernel/cgroup: use kernfs_create_dir_ns()
Date:   Fri,  1 Dec 2023 13:56:37 +0100
Message-Id: <20231201125638.1699026-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By passing the fsugid to kernfs_create_dir_ns(), we don't need
cgroup_kn_set_ugid() any longer.  That function was added for exactly
this purpose by commit 49957f8e2a ("cgroup: newly created dirs and
files should be owned by the creator").

Eliminating this piece of duplicate code means we benefit from future
improvements to kernfs_create_dir_ns(); for example, both are lacking
S_ISGID support currently, which my next patch will add to
kernfs_create_dir_ns().  It cannot (easily) be added to
cgroup_kn_set_ugid() because we can't dereference struct kernfs_iattrs
from there.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 kernel/cgroup/cgroup.c | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 4b9ff41ca603..a844b421fd83 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4169,20 +4169,6 @@ static struct kernfs_ops cgroup_kf_ops = {
 	.seq_show		= cgroup_seqfile_show,
 };
 
-/* set uid and gid of cgroup dirs and files to that of the creator */
-static int cgroup_kn_set_ugid(struct kernfs_node *kn)
-{
-	struct iattr iattr = { .ia_valid = ATTR_UID | ATTR_GID,
-			       .ia_uid = current_fsuid(),
-			       .ia_gid = current_fsgid(), };
-
-	if (uid_eq(iattr.ia_uid, GLOBAL_ROOT_UID) &&
-	    gid_eq(iattr.ia_gid, GLOBAL_ROOT_GID))
-		return 0;
-
-	return kernfs_setattr(kn, &iattr);
-}
-
 static void cgroup_file_notify_timer(struct timer_list *timer)
 {
 	cgroup_file_notify(container_of(timer, struct cgroup_file,
@@ -4195,25 +4181,18 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
 	char name[CGROUP_FILE_NAME_MAX];
 	struct kernfs_node *kn;
 	struct lock_class_key *key = NULL;
-	int ret;
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	key = &cft->lockdep_key;
 #endif
 	kn = __kernfs_create_file(cgrp->kn, cgroup_file_name(cgrp, cft, name),
 				  cgroup_file_mode(cft),
-				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
+				  current_fsuid(), current_fsgid(),
 				  0, cft->kf_ops, cft,
 				  NULL, key);
 	if (IS_ERR(kn))
 		return PTR_ERR(kn);
 
-	ret = cgroup_kn_set_ugid(kn);
-	if (ret) {
-		kernfs_remove(kn);
-		return ret;
-	}
-
 	if (cft->file_offset) {
 		struct cgroup_file *cfile = (void *)css + cft->file_offset;
 
@@ -5616,7 +5595,9 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 		goto out_cancel_ref;
 
 	/* create the directory */
-	kn = kernfs_create_dir(parent->kn, name, mode, cgrp);
+	kn = kernfs_create_dir_ns(parent->kn, name, mode,
+				  current_fsuid(), current_fsgid(),
+				  cgrp, NULL);
 	if (IS_ERR(kn)) {
 		ret = PTR_ERR(kn);
 		goto out_stat_exit;
@@ -5761,10 +5742,6 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
 	 */
 	kernfs_get(cgrp->kn);
 
-	ret = cgroup_kn_set_ugid(cgrp->kn);
-	if (ret)
-		goto out_destroy;
-
 	ret = css_populate_dir(&cgrp->self);
 	if (ret)
 		goto out_destroy;
-- 
2.39.2

