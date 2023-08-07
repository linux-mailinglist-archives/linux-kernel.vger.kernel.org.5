Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5B7772C43
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjHGRML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjHGRL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:11:59 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3A11A4;
        Mon,  7 Aug 2023 10:11:58 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52327d63d7cso3274786a12.1;
        Mon, 07 Aug 2023 10:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691428317; x=1692033117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEh6ez/EHFv9/uxbCXXQ+0s/+H6opkFl4Y60bZY4pQI=;
        b=VnS1UOb164DqqY8Roc/WSMtNox1KjuOb8AsnLUhljSu+PJrvCrwJmPc2tc6grHHlDg
         fna0dP0hgbPSNvnY6937kZNpuwcBqwCQs7ApjtbLXs09eQRxDtLszsIFP5/X3Q3qldU8
         f4VfDvfU2B0SEkhvYv1ZkWq3n71aIg6O2f12MtcOyQmdqLVmb1gVsIbt5MHsxe0kTFCT
         8fV3xxjqeOas3L7U3r6wUBV5hKuEKUyVpSvTzWCFlK0wqCzMX/JTiVo8zjEIuJ5hZuyM
         1s/1A5s+mfl8qo/d2abrrVwaxyC7S0hBXhw6jk6Ju3EwK5G50WouE6GLwbYJnqpo6Gqn
         5c1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428317; x=1692033117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dEh6ez/EHFv9/uxbCXXQ+0s/+H6opkFl4Y60bZY4pQI=;
        b=WvfdtZ1joUaZ8m+8imjNH3mCihUf0QlWWn57dNRhS67D3wxZ6ysvSGYRNRYDX/Hnmp
         Q58CfPOLb2lA/XYrwefeULrEg/2tOnyu4qRVEIeHIAb9BGSeGqh3LGzLzjBnBIeqf47P
         4aSEB77bIvvMwiok8QNSicjbwX5h4/51mibEMyBNzCmPKstclo9j7U0jaFSwRN+Regc3
         gDpd8ak6c18R0pNQIEho8fnnofSIbrNJ4Kq09au01DJiiYcr6PypiqvkPNQBLdEr4LBU
         UTbjYijrRnkgKailNgjFqahKt+71JZh8fKHNUUtBLQxN5Le+RVgAM3ogJv8V9gipkSnz
         hDrg==
X-Gm-Message-State: AOJu0YzgKTMBqseB60zsxRGk8MjhuZfeHXNX3RVu6Jq8TSPa3HRYhTUT
        28pWr7jNhTGO+/VrhSTCqJm/xahG9eTNJg==
X-Google-Smtp-Source: AGHT+IEP+jlf4muv2Ip+VsZW1QbTmjJnbsNZIhycDl3L/uuP1V090ZVg1KI84EdqyjSLaGkJWLFGDw==
X-Received: by 2002:aa7:c490:0:b0:522:cb97:f196 with SMTP id m16-20020aa7c490000000b00522cb97f196mr8575705edq.36.1691428316637;
        Mon, 07 Aug 2023 10:11:56 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-033-028.95.112.pool.telefonica.de. [95.112.33.28])
        by smtp.gmail.com with ESMTPSA id e10-20020a056402148a00b005224d960e66sm5420814edv.96.2023.08.07.10.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 10:11:56 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/7] selinux: avoid implicit conversions in policydb code
Date:   Mon,  7 Aug 2023 19:11:40 +0200
Message-Id: <20230807171143.208481-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807171143.208481-1-cgzones@googlemail.com>
References: <20230807171143.208481-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the identical type for local variables, e.g. loop counters.

Declare members of struct policydb_compat_info unsigned to consistently
use unsigned iterators.  They hold read-only non-negative numbers in the
global variable policydb_compat.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3:
  - use unsigned int instead of u32 for iterators where the loop bound
    is known at compile time and small (<100)
    /@Paul: keep u32 iterator in policydb_destroy() due to
    /  for (i = 0; i < p->p_types.nprim; i++)
    /
  - drop not mentioned protocol and port checks regarding out of range
    values; there are a couple more of them and those changes are
    suitable for a different patchset
v2:
  - avoid declarations in init-clauses of for loops
  - declare members of struct policydb_compat_info unsigned
---
 security/selinux/ss/policydb.c | 69 ++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 32 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index a424997c79eb..c3ffe78ef144 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -55,9 +55,9 @@ static const char *const symtab_name[SYM_NUM] = {
 #endif
 
 struct policydb_compat_info {
-	int version;
-	int sym_num;
-	int ocon_num;
+	unsigned int version;
+	unsigned int sym_num;
+	unsigned int ocon_num;
 };
 
 /* These need to be updated if SYM_NUM or OCON_NUM changes */
@@ -159,9 +159,9 @@ static const struct policydb_compat_info policydb_compat[] = {
 	},
 };
 
-static const struct policydb_compat_info *policydb_lookup_compat(int version)
+static const struct policydb_compat_info *policydb_lookup_compat(unsigned int version)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(policydb_compat); i++) {
 		if (policydb_compat[i].version == version)
@@ -359,7 +359,7 @@ static int role_tr_destroy(void *key, void *datum, void *p)
 	return 0;
 }
 
-static void ocontext_destroy(struct ocontext *c, int i)
+static void ocontext_destroy(struct ocontext *c, unsigned int i)
 {
 	if (!c)
 		return;
@@ -782,7 +782,7 @@ void policydb_destroy(struct policydb *p)
 {
 	struct ocontext *c, *ctmp;
 	struct genfs *g, *gtmp;
-	int i;
+	u32 i;
 	struct role_allow *ra, *lra = NULL;
 
 	for (i = 0; i < SYM_NUM; i++) {
@@ -1155,8 +1155,8 @@ static int common_read(struct policydb *p, struct symtab *s, void *fp)
 	char *key = NULL;
 	struct common_datum *comdatum;
 	__le32 buf[4];
-	u32 len, nel;
-	int i, rc;
+	u32 i, len, nel;
+	int rc;
 
 	comdatum = kzalloc(sizeof(*comdatum), GFP_KERNEL);
 	if (!comdatum)
@@ -1221,13 +1221,13 @@ static int type_set_read(struct type_set *t, void *fp)
 
 static int read_cons_helper(struct policydb *p,
 				struct constraint_node **nodep,
-				int ncons, int allowxtarget, void *fp)
+				u32 ncons, int allowxtarget, void *fp)
 {
 	struct constraint_node *c, *lc;
 	struct constraint_expr *e, *le;
 	__le32 buf[3];
-	u32 nexpr;
-	int rc, i, j, depth;
+	u32 i, j, nexpr;
+	int rc, depth;
 
 	lc = NULL;
 	for (i = 0; i < ncons; i++) {
@@ -1319,8 +1319,8 @@ static int class_read(struct policydb *p, struct symtab *s, void *fp)
 	char *key = NULL;
 	struct class_datum *cladatum;
 	__le32 buf[6];
-	u32 len, len2, ncons, nel;
-	int i, rc;
+	u32 i, len, len2, ncons, nel;
+	int rc;
 
 	cladatum = kzalloc(sizeof(*cladatum), GFP_KERNEL);
 	if (!cladatum)
@@ -1413,7 +1413,8 @@ static int role_read(struct policydb *p, struct symtab *s, void *fp)
 {
 	char *key = NULL;
 	struct role_datum *role;
-	int rc, to_read = 2;
+	int rc;
+	unsigned int to_read = 2;
 	__le32 buf[3];
 	u32 len;
 
@@ -1469,7 +1470,8 @@ static int type_read(struct policydb *p, struct symtab *s, void *fp)
 {
 	char *key = NULL;
 	struct type_datum *typdatum;
-	int rc, to_read = 3;
+	int rc;
+	unsigned int to_read = 3;
 	__le32 buf[4];
 	u32 len;
 
@@ -1543,7 +1545,8 @@ static int user_read(struct policydb *p, struct symtab *s, void *fp)
 {
 	char *key = NULL;
 	struct user_datum *usrdatum;
-	int rc, to_read = 2;
+	int rc;
+	unsigned int to_read = 2;
 	__le32 buf[3];
 	u32 len;
 
@@ -1684,7 +1687,7 @@ static int user_bounds_sanity_check(void *key, void *datum, void *datap)
 	upper = user = datum;
 	while (upper->bounds) {
 		struct ebitmap_node *node;
-		unsigned long bit;
+		u32 bit;
 
 		if (++depth == POLICYDB_BOUNDS_MAXDEPTH) {
 			pr_err("SELinux: user %s: "
@@ -1720,7 +1723,7 @@ static int role_bounds_sanity_check(void *key, void *datum, void *datap)
 	upper = role = datum;
 	while (upper->bounds) {
 		struct ebitmap_node *node;
-		unsigned long bit;
+		u32 bit;
 
 		if (++depth == POLICYDB_BOUNDS_MAXDEPTH) {
 			pr_err("SELinux: role %s: "
@@ -1835,9 +1838,9 @@ static int range_read(struct policydb *p, void *fp)
 {
 	struct range_trans *rt = NULL;
 	struct mls_range *r = NULL;
-	int i, rc;
+	int rc;
 	__le32 buf[2];
-	u32 nel;
+	u32 i, nel;
 
 	if (p->policyvers < POLICYDB_VERSION_MLS)
 		return 0;
@@ -2083,9 +2086,9 @@ static int filename_trans_read_helper(struct policydb *p, void *fp)
 
 static int filename_trans_read(struct policydb *p, void *fp)
 {
-	u32 nel;
+	u32 nel, i;
 	__le32 buf[1];
-	int rc, i;
+	int rc;
 
 	if (p->policyvers < POLICYDB_VERSION_FILENAME_TRANS)
 		return 0;
@@ -2124,8 +2127,8 @@ static int filename_trans_read(struct policydb *p, void *fp)
 
 static int genfs_read(struct policydb *p, void *fp)
 {
-	int i, j, rc;
-	u32 nel, nel2, len, len2;
+	int rc;
+	u32 i, j, nel, nel2, len, len2;
 	__le32 buf[1];
 	struct ocontext *l, *c;
 	struct ocontext *newc = NULL;
@@ -2238,8 +2241,9 @@ static int genfs_read(struct policydb *p, void *fp)
 static int ocontext_read(struct policydb *p, const struct policydb_compat_info *info,
 			 void *fp)
 {
-	int i, j, rc;
-	u32 nel, len;
+	int rc;
+	unsigned int i;
+	u32 j, nel, len;
 	__be64 prefixbuf[1];
 	__le32 buf[3];
 	struct ocontext *l, *c;
@@ -2430,9 +2434,9 @@ int policydb_read(struct policydb *p, void *fp)
 	struct role_allow *ra, *lra;
 	struct role_trans_key *rtk = NULL;
 	struct role_trans_datum *rtd = NULL;
-	int i, j, rc;
+	int rc;
 	__le32 buf[4];
-	u32 len, nprim, nel, perm;
+	u32 i, j, len, nprim, nel, perm;
 
 	char *policydb_str;
 	const struct policydb_compat_info *info;
@@ -3283,7 +3287,8 @@ static int (*const write_f[SYM_NUM]) (void *key, void *datum, void *datap) = {
 static int ocontext_write(struct policydb *p, const struct policydb_compat_info *info,
 			  void *fp)
 {
-	unsigned int i, j, rc;
+	unsigned int i, j;
+	int rc;
 	size_t nel, len;
 	__be64 prefixbuf[1];
 	__le32 buf[3];
@@ -3632,10 +3637,10 @@ static int filename_trans_write(struct policydb *p, void *fp)
  */
 int policydb_write(struct policydb *p, void *fp)
 {
-	unsigned int i, num_syms;
+	unsigned int num_syms;
 	int rc;
 	__le32 buf[4];
-	u32 config;
+	u32 config, i;
 	size_t len;
 	const struct policydb_compat_info *info;
 
-- 
2.40.1

