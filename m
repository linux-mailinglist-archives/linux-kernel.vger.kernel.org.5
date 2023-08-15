Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95A577D48F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239416AbjHOUrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238939AbjHOUqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:46:34 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0AAB9;
        Tue, 15 Aug 2023 13:46:10 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6887b3613e4so153926b3a.3;
        Tue, 15 Aug 2023 13:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692132369; x=1692737169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LxLHV47VvqCGBoKoIzEd5FgBxCmSRjG8BjFVFcTiA5w=;
        b=rZIUgBUmKyzqTvYiev+8cucfssCRe4CGlnzZRmk6C3HQMV2fW5+sQslk64u36XmlbZ
         xHm7RdzB0ZpVf6az2Vn4QX11JnlsPbWFs+xvAQEu1ltUVz6iFn9Zf4icVtrPEJGm43ya
         a3LhXjrDQ6CYh697GumSWCqSN9nB/bWZFsGoXbjTfWHKiqzh7zpFiJIDSDv+AbBpMHHc
         Jwq1SUZDpZsgBHgIzR+y5fmA4hAzTI1yZCMfdzvO+P+6TPDZ5+tEkq8hIEJgQ9lXCWhc
         j/PMHAAcXd13IXaAsrua6632in+D5u4scwDUU0q1zaEinnJCArXnXR6Zs/2+X5zgtf0x
         7Uog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692132369; x=1692737169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LxLHV47VvqCGBoKoIzEd5FgBxCmSRjG8BjFVFcTiA5w=;
        b=ENFG1Dn3LAEXtPUSlNfGAdu42NUmmBDiTt1zQTPIBE5R7CVckHVsjCq6Ho5eDHiOrF
         HM8KdkwyO0CnQzRJd8vKMLJoKQ1bqU1WcNpcD2ZvAsBdU6kgg0vKK0Ttn5h53h6h2m+0
         iQsX5WwzkN+ejlMzPX3ffhgn3OOSCYCo2yD+cDV3krMRNq6iTXirZPNd0FoEbeA4R3/L
         PLo7Yg+TG7itKIRPUY6LY5kkyWjA615vn7FR/L8vPY+tgei+sh3V79L7aXHeTaavAAaH
         yAdC4RJcu7vscTFZ5dknA6GDkeuXPXLxXqFzTJE5YuaTmHyrvhCyOSwNQSqJkoARBByJ
         iRZw==
X-Gm-Message-State: AOJu0Yz88wtbH0wOB2GEGFAnGCfio99c2YM6uin1XBgeNnCOJtpNN5FX
        Zw8ffQ1mbz29F1TI/aSA/0c=
X-Google-Smtp-Source: AGHT+IHq8FlpZroFN1PJvuW3FT13d2oC2QW/nPn+ODt4JGcPy6hwmaw0n6VbNJ7xmvtUbAI+bIiIMA==
X-Received: by 2002:a05:6a20:431a:b0:13f:9232:fd39 with SMTP id h26-20020a056a20431a00b0013f9232fd39mr19242521pzk.53.1692132369058;
        Tue, 15 Aug 2023 13:46:09 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c009:58e9:db85:3caf:1429:e455])
        by smtp.gmail.com with ESMTPSA id fk22-20020a056a003a9600b006887c920637sm13579pfb.159.2023.08.15.13.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 13:46:08 -0700 (PDT)
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     paul@paul-moore.com, eparis@redhat.com
Cc:     Atul Kumar Pant <atulpant.linux@gmail.com>, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: [PATCH v1] kernel: Add space before parenthesis and around '=', "==" and '<'
Date:   Wed, 16 Aug 2023 02:15:53 +0530
Message-Id: <20230815204553.52261-1-atulpant.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes following checkpatch.pl issue:
ERROR: space required before the open parenthesis '('
ERROR: spaces required around that '='
ERROR: spaces required around that '<'
ERROR: spaces required around that '=='

Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
---
 kernel/acct.c        |  2 +-
 kernel/auditfilter.c | 16 ++++++++--------
 kernel/auditsc.c     |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index 010667ce6080..c95a9359f209 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -470,7 +470,7 @@ static void fill_ac(acct_t *ac)
 	do_div(elapsed, AHZ);
 	btime = ktime_get_real_seconds() - elapsed;
 	ac->ac_btime = clamp_t(time64_t, btime, 0, U32_MAX);
-#if ACCT_VERSION==2
+#if ACCT_VERSION == 2
 	ac->ac_ahz = AHZ;
 #endif
 
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index a25757f09255..8317a37dea0b 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -221,7 +221,7 @@ static int audit_match_signal(struct audit_entry *entry)
 					       entry->rule.mask));
 	}
 
-	switch(audit_classify_arch(arch->val)) {
+	switch (audit_classify_arch(arch->val)) {
 	case 0: /* native */
 		return (audit_match_class_bits(AUDIT_CLASS_SIGNAL,
 					       entry->rule.mask));
@@ -243,7 +243,7 @@ static inline struct audit_entry *audit_to_entry_common(struct audit_rule_data *
 
 	err = -EINVAL;
 	listnr = rule->flags & ~AUDIT_FILTER_PREPEND;
-	switch(listnr) {
+	switch (listnr) {
 	default:
 		goto exit_err;
 #ifdef CONFIG_AUDITSYSCALL
@@ -344,7 +344,7 @@ static int audit_field_valid(struct audit_entry *entry, struct audit_field *f)
 
 	switch (entry->rule.listnr) {
 	case AUDIT_FILTER_FS:
-		switch(f->type) {
+		switch (f->type) {
 		case AUDIT_FSTYPE:
 		case AUDIT_FILTERKEY:
 			break;
@@ -651,7 +651,7 @@ static struct audit_rule_data *audit_krule_to_data(struct audit_krule *krule)
 
 		data->fields[i] = f->type;
 		data->fieldflags[i] = audit_ops[f->op];
-		switch(f->type) {
+		switch (f->type) {
 		case AUDIT_SUBJ_USER:
 		case AUDIT_SUBJ_ROLE:
 		case AUDIT_SUBJ_TYPE:
@@ -718,7 +718,7 @@ static int audit_compare_rule(struct audit_krule *a, struct audit_krule *b)
 		    a->fields[i].op != b->fields[i].op)
 			return 1;
 
-		switch(a->fields[i].type) {
+		switch (a->fields[i].type) {
 		case AUDIT_SUBJ_USER:
 		case AUDIT_SUBJ_ROLE:
 		case AUDIT_SUBJ_TYPE:
@@ -947,7 +947,7 @@ static inline int audit_add_rule(struct audit_entry *entry)
 	int dont_count = 0;
 
 	/* If any of these, don't count towards total */
-	switch(entry->rule.listnr) {
+	switch (entry->rule.listnr) {
 	case AUDIT_FILTER_USER:
 	case AUDIT_FILTER_EXCLUDE:
 	case AUDIT_FILTER_FS:
@@ -1030,7 +1030,7 @@ int audit_del_rule(struct audit_entry *entry)
 	int dont_count = 0;
 
 	/* If any of these, don't count towards total */
-	switch(entry->rule.listnr) {
+	switch (entry->rule.listnr) {
 	case AUDIT_FILTER_USER:
 	case AUDIT_FILTER_EXCLUDE:
 	case AUDIT_FILTER_FS:
@@ -1084,7 +1084,7 @@ static void audit_list_rules(int seq, struct sk_buff_head *q)
 
 	/* This is a blocking read, so use audit_filter_mutex instead of rcu
 	 * iterator to sync with list writers. */
-	for (i=0; i<AUDIT_NR_FILTERS; i++) {
+	for (i = 0; i < AUDIT_NR_FILTERS; i++) {
 		list_for_each_entry(r, &audit_rules_list[i], list) {
 			struct audit_rule_data *data;
 
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index addeed3df15d..a674039ea9ef 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2124,7 +2124,7 @@ static void handle_path(const struct dentry *dentry)
 	d = dentry;
 	rcu_read_lock();
 	seq = read_seqbegin(&rename_lock);
-	for(;;) {
+	for (;;) {
 		struct inode *inode = d_backing_inode(d);
 
 		if (inode && unlikely(inode->i_fsnotify_marks)) {
-- 
2.25.1

