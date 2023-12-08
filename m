Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F27C809F6E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 10:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573435AbjLHJdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 04:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjLHJdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 04:33:09 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7521590
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 01:33:14 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54cb4fa667bso2641905a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 01:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1702027993; x=1702632793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L4rZ/GzRY7+TnTS+jdlOOGqRdC+4LjtAOi+pvi/VqV0=;
        b=JtuRaQ5/qOG7u7fsHo5vA6j7INkvoMJWlC1UGGAfMSrIB7FIC1QukHG4FajC596zsl
         E1zj8nAleHRCoRTpXiDjrILm+XBC173B2tVZ/hXyw4X0pKJaAHNOTJPaEpTy59Xy4i0B
         407bVZdzIkVKxG6nY8A/IktYMm9NrRWgwKyZpWkys9KDaJfM3ghOCgrvg+rsgp9THm2b
         BXA4lQGqmnt0CAaa063gwnxdn6t7vwb4GiASNoMfarZTk6f/hgKum1oJggoXgy5WTHtE
         wdbN0a3eyOep+cfChbuTdIhzES1l9V+AegXlBk8vKh+E8/6VkJ+bTZ0JH2BTDSxqMuW6
         /7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702027993; x=1702632793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4rZ/GzRY7+TnTS+jdlOOGqRdC+4LjtAOi+pvi/VqV0=;
        b=qB/0ojJnClwL7CUMvPDnTTL47bmek+GWwKQnBtoe/ZkmvU3XOufCaRr84NNWg5MujT
         BZ3K3Ihzx+N45HVfXi84cYajBEIdtsMmiuWRcKVxc35JWpqwvRMrE0Fsblgg/0HxVf8f
         W3BTtTq6sg7DoHZcVnuvxQ9ple6py4uWdKPpMLUaYGbQE+SkL9+w7is4I4sAuh7/dQ35
         BIVIIdpTmGDaYm7kt4MRw11ElYWyHtX+Inqh1sAaAC2quZw/n+t0LsvRrPQ3kyMRJqej
         W+ethr2r9CyDXN26sbbzYvFcyRntSDY57C+THy+K/pM4XFgYEoPKmHu+93R2NgSWEX0r
         7zkA==
X-Gm-Message-State: AOJu0YzVZB9Dx2lsMdZo0qhKI8ov/vzSvwr0S2ee7qjH+hg1DMqx19MS
        AW1DKGu2CTgXBBvpkuszpZ8yxA==
X-Google-Smtp-Source: AGHT+IEDKaDtDXTodMm2fz1ox0C+VP5DwilqtYu0RuTtufQyat/65bCaa/g2n8dCE/SBCfkr5NUY+w==
X-Received: by 2002:a17:906:10ce:b0:a1e:1da1:73c0 with SMTP id v14-20020a17090610ce00b00a1e1da173c0mr1885941ejv.10.1702027992742;
        Fri, 08 Dec 2023 01:33:12 -0800 (PST)
Received: from heron.intern.cm-ag (p200300dc6f0b6500529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f0b:6500:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id vk5-20020a170907cbc500b00a1ce56f7b16sm774812ejc.71.2023.12.08.01.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 01:33:12 -0800 (PST)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Cc:     Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 1/2] kernel/cgroup: use kernfs_create_dir_ns()
Date:   Fri,  8 Dec 2023 10:33:09 +0100
Message-Id: <20231208093310.297233-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By passing the fsugid to kernfs_create_dir_ns(), we don't need
cgroup_kn_set_ugid() any longer.  That function was added for exactly
this purpose by commit 49957f8e2a43 ("cgroup: newly created dirs and
files should be owned by the creator").

Eliminating this piece of duplicate code means we benefit from future
improvements to kernfs_create_dir_ns(); for example, both are lacking
S_ISGID support currently, which my next patch will add to
kernfs_create_dir_ns().  It cannot (easily) be added to
cgroup_kn_set_ugid() because we can't dereference struct kernfs_iattrs
from there.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Acked-by: Tejun Heo <tj@kernel.org>
--
v1 -> v2: 12-digit commit id
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

