Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C5E772C4C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjHGRMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjHGRMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:12:06 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD5FE70;
        Mon,  7 Aug 2023 10:12:00 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5232d593646so3000769a12.0;
        Mon, 07 Aug 2023 10:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691428318; x=1692033118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbyWp+oLNRPt/+dSAljB0eynibcwf4jEYqfOipDuK7A=;
        b=YfSDQcA35+d18QIojBvbSZe/28tkrUZwUxSp3kTApfhl9Bodd7ERM78bBxGqAl0tT1
         J3N10VQE2byn4kPo8+4/1/Fj3Z3qsSqDPhe1Vu0zpUfBI5Q8D/qRKe3FO5W4iRFUUvhL
         Aje9BrceOyFlITtcdutUrIMmByhpKhbr41McY5F+KXnEczhZ+s5JKZY595bihtKjIiHZ
         pjnryZqq1lqlnWJfH4FAkaHLMCrV6cnYQ67HyT+js5Wrd18UAqDosyyn1k9NpFQ3o9f7
         tpk3ltU3ffuwLYtX1dVj1gtlMlwaHDFE15VkI6/bzRVtiEtNfyS0Q69xIcD5eNRN3gDP
         Wccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428318; x=1692033118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbyWp+oLNRPt/+dSAljB0eynibcwf4jEYqfOipDuK7A=;
        b=UjN/JH2n+VRsi6FMQ3a3rlyoC5Ugy2ZLl1FIqlZJdMMQXgzon2GNaGYDCg4jbIk4Ow
         7hXVxA9DPPJdmEOsDk9SNrQoqPu7uIZf5xHxwPFAx9GFS9jgh2XLxhKaXNdLxaGmDBYS
         7c/7aIGE8PTv6NXXGZqAnujGHWiF0wx+EGfGYpj5tpBo3w5X2N1yxQ/80xzlcmSf9FPF
         T4H2ESlP8/soTedTnEOsw2GcZVgKuB1hDta5eNYuQ6wQDAuql4qIdRepmyQK/t6mb9iu
         PLsDL0COQ98lOXFwdkwuTZkZ2Z1/T7iP/N5BfQporKJQF2nRQ9Mugg9ztWxZg5veZhNB
         KNsw==
X-Gm-Message-State: AOJu0YwxH4CEZSrXMWIc/Ud9AcZGIk6sVZl1ScviNJQkYmekJRQ+E2EB
        dGMXOUU2VjgrJls0IEJa2eu0DXKsLHVr9Q==
X-Google-Smtp-Source: AGHT+IEQ5ssGM+/5+KIInTBSFxYjRMBknEWBpteTSyTbFXzFnYDKbDG9dxVV5wguBFuCn7/V9hf1Xg==
X-Received: by 2002:a05:6402:b11:b0:522:564d:6de with SMTP id bm17-20020a0564020b1100b00522564d06demr9760205edb.36.1691428318591;
        Mon, 07 Aug 2023 10:11:58 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-033-028.95.112.pool.telefonica.de. [95.112.33.28])
        by smtp.gmail.com with ESMTPSA id e10-20020a056402148a00b005224d960e66sm5420814edv.96.2023.08.07.10.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 10:11:58 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/7] selinux: avoid implicit conversions in avtab code
Date:   Mon,  7 Aug 2023 19:11:42 +0200
Message-Id: <20230807171143.208481-7-cgzones@googlemail.com>
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

Return u32 from avtab_hash() instead of int, since the hashing is done
on u32 and the result is used as an index on the hash array.

Use the type of the limit in for loops.

Avoid signed to unsigned conversion of multiplication result in
avtab_hash_eval() and perform multiplication in destination type.

Use unsigned loop iterator for index operations, to avoid sign
extension.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3:
  - use fixed sized counters in avtab_hash_eval()
  - perform multiplication in avtab_hash_eval() in destination type
v2: avoid declarations in init-clauses of for loops
---
 security/selinux/ss/avtab.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 243e5dabfa86..86d98a8e291b 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -29,7 +29,7 @@ static struct kmem_cache *avtab_xperms_cachep __ro_after_init;
 /* Based on MurmurHash3, written by Austin Appleby and placed in the
  * public domain.
  */
-static inline int avtab_hash(const struct avtab_key *keyp, u32 mask)
+static inline u32 avtab_hash(const struct avtab_key *keyp, u32 mask)
 {
 	static const u32 c1 = 0xcc9e2d51;
 	static const u32 c2 = 0x1b873593;
@@ -66,7 +66,7 @@ static inline int avtab_hash(const struct avtab_key *keyp, u32 mask)
 }
 
 static struct avtab_node*
-avtab_insert_node(struct avtab *h, int hvalue,
+avtab_insert_node(struct avtab *h, u32 hvalue,
 		  struct avtab_node *prev,
 		  const struct avtab_key *key, const struct avtab_datum *datum)
 {
@@ -106,7 +106,7 @@ avtab_insert_node(struct avtab *h, int hvalue,
 static int avtab_insert(struct avtab *h, const struct avtab_key *key,
 			const struct avtab_datum *datum)
 {
-	int hvalue;
+	u32 hvalue;
 	struct avtab_node *prev, *cur, *newnode;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
@@ -152,7 +152,7 @@ struct avtab_node *avtab_insert_nonunique(struct avtab *h,
 					  const struct avtab_key *key,
 					  const struct avtab_datum *datum)
 {
-	int hvalue;
+	u32 hvalue;
 	struct avtab_node *prev, *cur;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
@@ -186,7 +186,7 @@ struct avtab_node *avtab_insert_nonunique(struct avtab *h,
 struct avtab_node *avtab_search_node(struct avtab *h,
 				     const struct avtab_key *key)
 {
-	int hvalue;
+	u32 hvalue;
 	struct avtab_node *cur;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
@@ -246,7 +246,7 @@ avtab_search_node_next(struct avtab_node *node, u16 specified)
 
 void avtab_destroy(struct avtab *h)
 {
-	int i;
+	u32 i;
 	struct avtab_node *cur, *temp;
 
 	if (!h)
@@ -325,7 +325,7 @@ int avtab_alloc_dup(struct avtab *new, const struct avtab *orig)
 #ifdef CONFIG_SECURITY_SELINUX_DEBUG
 void avtab_hash_eval(struct avtab *h, const char *tag)
 {
-	int i, chain_len, slots_used, max_chain_len;
+	u32 i, chain_len, slots_used, max_chain_len;
 	unsigned long long chain2_len_sum;
 	struct avtab_node *cur;
 
@@ -344,7 +344,7 @@ void avtab_hash_eval(struct avtab *h, const char *tag)
 
 			if (chain_len > max_chain_len)
 				max_chain_len = chain_len;
-			chain2_len_sum += chain_len * chain_len;
+			chain2_len_sum += (unsigned long long)chain_len * chain_len;
 		}
 	}
 
@@ -374,13 +374,13 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 {
 	__le16 buf16[4];
 	u16 enabled;
-	u32 items, items2, val, vers = pol->policyvers;
+	u32 items, items2, val, i;
 	struct avtab_key key;
 	struct avtab_datum datum;
 	struct avtab_extended_perms xperms;
 	__le32 buf32[ARRAY_SIZE(xperms.perms.p)];
-	int i, rc;
-	unsigned set;
+	int rc;
+	unsigned int set, vers = pol->policyvers;
 
 	memset(&key, 0, sizeof(struct avtab_key));
 	memset(&datum, 0, sizeof(struct avtab_datum));
@@ -616,7 +616,7 @@ int avtab_write_item(struct policydb *p, const struct avtab_node *cur, void *fp)
 
 int avtab_write(struct policydb *p, struct avtab *a, void *fp)
 {
-	unsigned int i;
+	u32 i;
 	int rc = 0;
 	struct avtab_node *cur;
 	__le32 buf[1];
-- 
2.40.1

