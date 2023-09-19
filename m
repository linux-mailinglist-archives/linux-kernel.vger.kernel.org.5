Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2449E7A572A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 03:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjISB4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 21:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjISB4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 21:56:50 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 87AE794;
        Mon, 18 Sep 2023 18:56:44 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 76CBC60292B81;
        Tue, 19 Sep 2023 09:56:25 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li kunyu <kunyu@nfschina.com>
To:     john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li kunyu <kunyu@nfschina.com>
Subject: [PATCH v2] apparmor/file: Removing unnecessary initial values for variable pointers
Date:   Tue, 19 Sep 2023 09:56:08 +0800
Message-Id: <20230919015608.8390-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These variable pointers are assigned during use and do not need to be
initialized for assignment.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 v2: Fix timestamp issues

 security/apparmor/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/file.c b/security/apparmor/file.c
index 698b124e649f..12eafdf18fc0 100644
--- a/security/apparmor/file.c
+++ b/security/apparmor/file.c
@@ -264,7 +264,7 @@ int aa_path_perm(const char *op, struct aa_label *label,
 {
 	struct aa_perms perms = {};
 	struct aa_profile *profile;
-	char *buffer = NULL;
+	char *buffer;
 	int error;
 
 	flags |= PATH_DELEGATE_DELETED | (S_ISDIR(cond->mode) ? PATH_IS_DIR :
@@ -412,7 +412,7 @@ int aa_path_link(struct aa_label *label, struct dentry *old_dentry,
 		d_backing_inode(old_dentry)->i_uid,
 		d_backing_inode(old_dentry)->i_mode
 	};
-	char *buffer = NULL, *buffer2 = NULL;
+	char *buffer, *buffer2;
 	struct aa_profile *profile;
 	int error;
 
-- 
2.18.2

