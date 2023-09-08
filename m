Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E472798E9B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbjIHTDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbjIHTDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:03:48 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9773F1704
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 12:03:12 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf1876ef69so5366825ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 12:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694199792; x=1694804592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4/yo3aB7Sh1/iOU0noEs9ePeDaWuoFmLCAFBSuNDiRk=;
        b=JsrBEhPT9CxzW7LnrF63i4HStFXNfmDvLEE+m/NZUwU5uDQ13wkShnu5dqX7PgTwUj
         gzHJKuqUuI3KC4zAggSm4nZhg1VlQJzecGhlkVkrtKQB9T+5KF17NxGt2laVU0OjbUVF
         4aYp6yewS1/nfr1wTO85mHNP4zqrVB0BpzVEBQPmtJPkP5YCToi1ff7Zu2StTibUrHVk
         s3+IAWhClsS9wPj9zR7sKs44+qSh1mLdgqkjJ5ZqxHUJfHQgiAznE4WogOSn20SK9P7S
         nE4k+/DmElh7ej7ZvrN8OwP/naEfG1YvXHosg3kMtPWcxGPbME+6eqsFU+xTIX84/+D9
         YtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694199792; x=1694804592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4/yo3aB7Sh1/iOU0noEs9ePeDaWuoFmLCAFBSuNDiRk=;
        b=pZlXyCc9SNEKkOY6loO185dJ6TZgnJ46a62ixtHuCjdK1fv2V7E+gDz3xJe2vQSnQg
         Obj04LdHHSHEybaDG56ozSnsDiyrxMEUAAhWhUBlXUCmCSvrbpqixhWgsNbhFG7XJjXQ
         maIaWdcUHfHV7fU2BfEE+f8+dIonvdC9drgI6sSc4NKnny6Ydr0ktvIIzyQwlLy06ssd
         xhgeIkQJVEqSBQUIJeKOhsnhaKRBaR2EMg+169QqGvxfITpmr2U3cvpG+V1+TZqzCgm3
         vjdImrzPR56NYUiatHJNHrSmMCRs8kjaOMG1qgO7B1weMN3E7MfQMYfpOLg5as+cLG9B
         RxgQ==
X-Gm-Message-State: AOJu0YyyDbU/Lt3/xMw2YgVoiDpS+FHKcfq1EsWB/5WHmIjk435ErM8V
        EeBd8d/jbaruZ4qjC9GPdT4=
X-Google-Smtp-Source: AGHT+IGD/4z18TXWfJfMfvMNlXKVPmz+kVRN55ZCM5I9cYEkycW7uy+EL7t1pkht4k7chCGIjjLhYQ==
X-Received: by 2002:a17:902:d508:b0:1c1:fbec:bc32 with SMTP id b8-20020a170902d50800b001c1fbecbc32mr3552081plg.6.1694199791858;
        Fri, 08 Sep 2023 12:03:11 -0700 (PDT)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902654200b001aaf2e8b1eesm1934091pln.248.2023.09.08.12.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 12:03:11 -0700 (PDT)
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     haren@us.ibm.com
Cc:     linux-kernel@vger.kernel.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] lib/842: Simplify sw842_hlist_node declarations
Date:   Sat,  9 Sep 2023 03:03:04 +0800
Message-Id: <20230908190304.98789-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

This patch simplifies the struct declarations for sw842_hlist_node. It
introduces a macro-based approach to declare these structs, reducing
code redundancy and enhancing code maintainability. Additionally, I
utilize clang-format to ensure coding style consistency.

The changes can be summarized as follows:

- Introduce a macro, DECLARE_SW842_HLIST_NODE, that generates struct
declarations for sw842_hlist_node with varying data and index types.

- Use the DECLARE_SW842_HLIST_NODE macro to declare sw842_hlist_node8,
sw842_hlist_node4, and sw842_hlist_node2.

- The entire codebase has been auto-formatted using clang-format to
ensure consistent coding style.

This refactoring maintains the original structure and semantics of
sw842_hlist_node while making the code more concise and easier to read.
It ensures consistency across the declarations and simplifies future
updates to these structs.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 lib/842/842_compress.c | 129 ++++++++++++++++++++---------------------
 1 file changed, 63 insertions(+), 66 deletions(-)

diff --git a/lib/842/842_compress.c b/lib/842/842_compress.c
index c02baa4168e1..15dd6f836795 100644
--- a/lib/842/842_compress.c
+++ b/lib/842/842_compress.c
@@ -15,9 +15,9 @@
 #include "842.h"
 #include "842_debugfs.h"
 
-#define SW842_HASHTABLE8_BITS	(10)
-#define SW842_HASHTABLE4_BITS	(11)
-#define SW842_HASHTABLE2_BITS	(10)
+#define SW842_HASHTABLE8_BITS (10)
+#define SW842_HASHTABLE4_BITS (11)
+#define SW842_HASHTABLE2_BITS (10)
 
 /* By default, we allow compressing input buffers of any length, but we must
  * use the non-standard "short data" template so the decompressor can correctly
@@ -35,7 +35,8 @@
 static bool sw842_strict;
 module_param_named(strict, sw842_strict, bool, 0644);
 
-static u8 comp_ops[OPS_MAX][5] = { /* params size in bits */
+static u8 comp_ops[OPS_MAX][5] = {
+	/* params size in bits */
 	{ I8, N0, N0, N0, 0x19 }, /* 8 */
 	{ I4, I4, N0, N0, 0x18 }, /* 18 */
 	{ I4, I2, I2, N0, 0x17 }, /* 25 */
@@ -64,26 +65,19 @@ static u8 comp_ops[OPS_MAX][5] = { /* params size in bits */
 	{ D8, N0, N0, N0, 0x00 }, /* 64 */
 };
 
-struct sw842_hlist_node8 {
-	struct hlist_node node;
-	u64 data;
-	u8 index;
-};
-
-struct sw842_hlist_node4 {
-	struct hlist_node node;
-	u32 data;
-	u16 index;
-};
+#define DECLARE_SW842_HLIST_NODE(type, data_type, index_type) \
+	struct sw842_hlist_node##type {                       \
+		struct hlist_node node;                       \
+		data_type data;                               \
+		index_type index;                             \
+	}
 
-struct sw842_hlist_node2 {
-	struct hlist_node node;
-	u16 data;
-	u8 index;
-};
+DECLARE_SW842_HLIST_NODE(8, u64, u8);
+DECLARE_SW842_HLIST_NODE(4, u32, u16);
+DECLARE_SW842_HLIST_NODE(2, u16, u8);
 
-#define INDEX_NOT_FOUND		(-1)
-#define INDEX_NOT_CHECKED	(-2)
+#define INDEX_NOT_FOUND (-1)
+#define INDEX_NOT_CHECKED (-2)
 
 struct sw842_param {
 	u8 *in;
@@ -106,46 +100,49 @@ struct sw842_param {
 	struct sw842_hlist_node2 node2[1 << I2_BITS];
 };
 
-#define get_input_data(p, o, b)						\
+#define get_input_data(p, o, b) \
 	be##b##_to_cpu(get_unaligned((__be##b *)((p)->in + (o))))
 
-#define init_hashtable_nodes(p, b)	do {			\
-	int _i;							\
-	hash_init((p)->htable##b);				\
-	for (_i = 0; _i < ARRAY_SIZE((p)->node##b); _i++) {	\
-		(p)->node##b[_i].index = _i;			\
-		(p)->node##b[_i].data = 0;			\
-		INIT_HLIST_NODE(&(p)->node##b[_i].node);	\
-	}							\
-} while (0)
-
-#define find_index(p, b, n)	({					\
-	struct sw842_hlist_node##b *_n;					\
-	p->index##b[n] = INDEX_NOT_FOUND;				\
-	hash_for_each_possible(p->htable##b, _n, node, p->data##b[n]) {	\
-		if (p->data##b[n] == _n->data) {			\
-			p->index##b[n] = _n->index;			\
-			break;						\
-		}							\
-	}								\
-	p->index##b[n] >= 0;						\
-})
-
-#define check_index(p, b, n)			\
-	((p)->index##b[n] == INDEX_NOT_CHECKED	\
-	 ? find_index(p, b, n)			\
-	 : (p)->index##b[n] >= 0)
-
-#define replace_hash(p, b, i, d)	do {				\
-	struct sw842_hlist_node##b *_n = &(p)->node##b[(i)+(d)];	\
-	hash_del(&_n->node);						\
-	_n->data = (p)->data##b[d];					\
-	pr_debug("add hash index%x %x pos %x data %lx\n", b,		\
-		 (unsigned int)_n->index,				\
-		 (unsigned int)((p)->in - (p)->instart),		\
-		 (unsigned long)_n->data);				\
-	hash_add((p)->htable##b, &_n->node, _n->data);			\
-} while (0)
+#define init_hashtable_nodes(p, b)                                  \
+	do {                                                        \
+		int _i;                                             \
+		hash_init((p)->htable##b);                          \
+		for (_i = 0; _i < ARRAY_SIZE((p)->node##b); _i++) { \
+			(p)->node##b[_i].index = _i;                \
+			(p)->node##b[_i].data = 0;                  \
+			INIT_HLIST_NODE(&(p)->node##b[_i].node);    \
+		}                                                   \
+	} while (0)
+
+#define find_index(p, b, n)                                    \
+	({                                                     \
+		struct sw842_hlist_node##b *_n;                \
+		p->index##b[n] = INDEX_NOT_FOUND;              \
+		hash_for_each_possible(p->htable##b, _n, node, \
+				       p->data##b[n]) {        \
+			if (p->data##b[n] == _n->data) {       \
+				p->index##b[n] = _n->index;    \
+				break;                         \
+			}                                      \
+		}                                              \
+		p->index##b[n] >= 0;                           \
+	})
+
+#define check_index(p, b, n)                                           \
+	((p)->index##b[n] == INDEX_NOT_CHECKED ? find_index(p, b, n) : \
+						 (p)->index##b[n] >= 0)
+
+#define replace_hash(p, b, i, d)                                           \
+	do {                                                               \
+		struct sw842_hlist_node##b *_n = &(p)->node##b[(i) + (d)]; \
+		hash_del(&_n->node);                                       \
+		_n->data = (p)->data##b[d];                                \
+		pr_debug("add hash index%x %x pos %x data %lx\n", b,       \
+			 (unsigned int)_n->index,                          \
+			 (unsigned int)((p)->in - (p)->instart),           \
+			 (unsigned long)_n->data);                         \
+		hash_add((p)->htable##b, &_n->node, _n->data);             \
+	} while (0)
 
 static u8 bmask[8] = { 0x00, 0x80, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc, 0xfe };
 
@@ -282,8 +279,8 @@ static int add_template(struct sw842_param *p, u8 c)
 			return ret;
 
 		if (inv) {
-			pr_err("Invalid templ %x op %d : %x %x %x %x\n",
-			       c, i, t[0], t[1], t[2], t[3]);
+			pr_err("Invalid templ %x op %d : %x %x %x %x\n", c, i,
+			       t[0], t[1], t[2], t[3]);
 			return -EINVAL;
 		}
 
@@ -291,8 +288,8 @@ static int add_template(struct sw842_param *p, u8 c)
 	}
 
 	if (b != 8) {
-		pr_err("Invalid template %x len %x : %x %x %x %x\n",
-		       c, b, t[0], t[1], t[2], t[3]);
+		pr_err("Invalid template %x len %x : %x %x %x %x\n", c, b, t[0],
+		       t[1], t[2], t[3]);
 		return -EINVAL;
 	}
 
@@ -474,8 +471,8 @@ static int process_next(struct sw842_param *p)
  * will contain the number of output bytes written on success, or
  * 0 on error.
  */
-int sw842_compress(const u8 *in, unsigned int ilen,
-		   u8 *out, unsigned int *olen, void *wmem)
+int sw842_compress(const u8 *in, unsigned int ilen, u8 *out, unsigned int *olen,
+		   void *wmem)
 {
 	struct sw842_param *p = (struct sw842_param *)wmem;
 	int ret;
-- 
2.25.1

