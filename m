Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0BE76713B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbjG1Pzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbjG1Pza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:55:30 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E11F4483;
        Fri, 28 Jul 2023 08:55:18 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b703a0453fso35210931fa.3;
        Fri, 28 Jul 2023 08:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690559716; x=1691164516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rYsK0kNMxGjYfUlP6jXFUwqPwtrROBmYtzMufSE/LU=;
        b=cCv4j1x9LDD/oh2RJBveQ5h/SYR4mJpS7bFKmnTUDY9mMkXp8dXT5k9j6Ki9KXRv56
         poIT6CqFn47rjK1p7wb/24bE4U+3+1QqYpmK/A8Nmau3pTmoGelqJkrWp1G5Pf8cY+K7
         F++sZe8yzD25YVqz72wF0eOkCt//8o8B187z68iMovnQ/BSLtoGlvHAHXDJVNvrrrV9j
         0uTYhj8/s320Zf/xvmA4k76N9Nwdh4LLA087uf6bvYmwf+wcSWQfHr4iz5vgjrHsY3ov
         2mdlSLuVlrWMQfEwaeaGWHy7EQpz1dOFV6Fgx7kCztMUzAvvQlyAdt8SSYMAmYeOxcNJ
         vF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690559716; x=1691164516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rYsK0kNMxGjYfUlP6jXFUwqPwtrROBmYtzMufSE/LU=;
        b=IVr4dN9mBIvGoaYpwtth5Gp5Qs6pWhMx6tOlm+OAaOSqTSRUjd1q6vc4hXVtJqWu9L
         vc+gCXjRN1jku1wiXx+zn7KzUq5hwgTJ91xfzEhQ5RZfID+Kv0vlh14YhjAtHLgxRcz9
         2IWoZVatDpbv3DRRCwLqa/Zh/yQSL6z3KPezftdOex+g8JizafIPCa9OIxmnqxTtfUU9
         XFSjSUYqaFG6Klis3/vKH7vYfy0ao5IfHzy6PZnLJu9GzloieYyG88X8G0UGbO1//M9T
         lX8vkPJSgSrH1VpWems5b0ZmHtQff3JLjz7CsnwwOKQ3ckexCF6VfkcgqPmVVEI76//L
         CB1g==
X-Gm-Message-State: ABy/qLYjQ0bC3KS11g5kit1M3R9ZChW4ptD6pRgMowbooK6TBECvS+PK
        gishxWO9R/JhVanrBem+TeWABiTazgEffyIBvCY=
X-Google-Smtp-Source: APBJJlGSZLLbQo9G1/zn7+V8lJgT217NYhWT410jIWNQdqPMaRVgsqfreAm7ZaIgNKobAHKTWkTRmA==
X-Received: by 2002:a2e:8e81:0:b0:2b9:4492:1226 with SMTP id z1-20020a2e8e81000000b002b944921226mr2325461ljk.11.1690559716318;
        Fri, 28 Jul 2023 08:55:16 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-157-016.77.0.pool.telefonica.de. [77.0.157.16])
        by smtp.gmail.com with ESMTPSA id f5-20020a1709064dc500b0098669cc16b2sm2198345ejw.83.2023.07.28.08.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 08:55:15 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Xiu Jianfeng <xiujianfeng@huaweicloud.com>,
        "GONG, Ruiqi" <gongruiqi1@huawei.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/9] selinux: avoid implicit conversions in services code
Date:   Fri, 28 Jul 2023 17:54:56 +0200
Message-Id: <20230728155501.39632-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728155501.39632-1-cgzones@googlemail.com>
References: <20230728155501.39632-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use u32 as the output parameter type in security_get_classes() and
security_get_permissions(), based on the type of the symtab nprim
member.

Declare the read-only class string parameter of
security_get_permissions() const.

Avoid several implicit conversions by using the identical type for the
destination.

Use the type identical to the source for local variables.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: avoid declarations in init-clauses of for loops
---
 security/selinux/include/security.h |  4 ++--
 security/selinux/selinuxfs.c        |  7 ++++---
 security/selinux/ss/services.c      | 23 ++++++++++++-----------
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 668e393a9709..074d439fe9ad 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -312,9 +312,9 @@ int security_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
 				 u32 *peer_sid);
 
 int security_get_classes(struct selinux_policy *policy,
-			 char ***classes, int *nclasses);
+			 char ***classes, u32 *nclasses);
 int security_get_permissions(struct selinux_policy *policy,
-			     char *class, char ***perms, int *nperms);
+			     const char *class, char ***perms, u32 *nperms);
 int security_get_reject_unknown(void);
 int security_get_allow_unknown(void);
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index f79e96f0f221..b969e87fd870 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1798,7 +1798,8 @@ static int sel_make_perm_files(struct selinux_policy *newpolicy,
 			char *objclass, int classvalue,
 			struct dentry *dir)
 {
-	int i, rc, nperms;
+	u32 i, nperms;
+	int rc;
 	char **perms;
 
 	rc = security_get_permissions(newpolicy, objclass, &perms, &nperms);
@@ -1868,8 +1869,8 @@ static int sel_make_classes(struct selinux_policy *newpolicy,
 			    struct dentry *class_dir,
 			    unsigned long *last_class_ino)
 {
-
-	int rc, nclasses, i;
+	u32 i, nclasses;
+	int rc;
 	char **classes;
 
 	rc = security_get_classes(newpolicy, &classes, &nclasses);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index cf4b87ec4a0e..3a03243f52e7 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -856,7 +856,7 @@ int security_bounded_transition(u32 old_sid, u32 new_sid)
 	struct sidtab *sidtab;
 	struct sidtab_entry *old_entry, *new_entry;
 	struct type_datum *type;
-	int index;
+	u32 index;
 	int rc;
 
 	if (!selinux_initialized())
@@ -1511,7 +1511,7 @@ static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
 		return -ENOMEM;
 
 	if (!selinux_initialized()) {
-		int i;
+		u32 i;
 
 		for (i = 1; i < SECINITSID_NUM; i++) {
 			const char *s = initial_sid_to_string[i];
@@ -2821,7 +2821,6 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
 {
 	struct policydb *policydb = &policy->policydb;
 	struct sidtab *sidtab = policy->sidtab;
-	int len;
 	u16 sclass;
 	struct genfs *genfs;
 	struct ocontext *c;
@@ -2843,7 +2842,7 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
 		return -ENOENT;
 
 	for (c = genfs->head; c; c = c->next) {
-		len = strlen(c->u.name);
+		size_t len = strlen(c->u.name);
 		if ((!c->v.sclass || sclass == c->v.sclass) &&
 		    (strncmp(c->u.name, path, len) == 0))
 			break;
@@ -3331,7 +3330,7 @@ static int get_classes_callback(void *k, void *d, void *args)
 {
 	struct class_datum *datum = d;
 	char *name = k, **classes = args;
-	int value = datum->value - 1;
+	u32 value = datum->value - 1;
 
 	classes[value] = kstrdup(name, GFP_ATOMIC);
 	if (!classes[value])
@@ -3341,7 +3340,7 @@ static int get_classes_callback(void *k, void *d, void *args)
 }
 
 int security_get_classes(struct selinux_policy *policy,
-			 char ***classes, int *nclasses)
+			 char ***classes, u32 *nclasses)
 {
 	struct policydb *policydb;
 	int rc;
@@ -3357,7 +3356,8 @@ int security_get_classes(struct selinux_policy *policy,
 	rc = hashtab_map(&policydb->p_classes.table, get_classes_callback,
 			 *classes);
 	if (rc) {
-		int i;
+		u32 i;
+
 		for (i = 0; i < *nclasses; i++)
 			kfree((*classes)[i]);
 		kfree(*classes);
@@ -3371,7 +3371,7 @@ static int get_permissions_callback(void *k, void *d, void *args)
 {
 	struct perm_datum *datum = d;
 	char *name = k, **perms = args;
-	int value = datum->value - 1;
+	u32 value = datum->value - 1;
 
 	perms[value] = kstrdup(name, GFP_ATOMIC);
 	if (!perms[value])
@@ -3381,10 +3381,11 @@ static int get_permissions_callback(void *k, void *d, void *args)
 }
 
 int security_get_permissions(struct selinux_policy *policy,
-			     char *class, char ***perms, int *nperms)
+			     const char *class, char ***perms, u32 *nperms)
 {
 	struct policydb *policydb;
-	int rc, i;
+	u32 i;
+	int rc;
 	struct class_datum *match;
 
 	policydb = &policy->policydb;
@@ -3599,7 +3600,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 /* Check to see if the rule contains any selinux fields */
 int selinux_audit_rule_known(struct audit_krule *rule)
 {
-	int i;
+	u32 i;
 
 	for (i = 0; i < rule->field_count; i++) {
 		struct audit_field *f = &rule->fields[i];
-- 
2.40.1

