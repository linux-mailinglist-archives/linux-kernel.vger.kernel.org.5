Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB6E79C266
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbjILCJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244006AbjILCGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:06:38 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 687C134A5C;
        Mon, 11 Sep 2023 18:38:13 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 149016059CE35;
        Tue, 12 Sep 2023 09:37:50 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li kunyu <kunyu@nfschina.com>
To:     john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] apparmor/file: Removing unnecessary initial values for variable pointers
Date:   Thu, 14 Sep 2023 02:09:03 +0800
Message-Id: <20230913180903.3776-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These variable pointers are assigned during use and do not need to be
initialized for assignment.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
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

