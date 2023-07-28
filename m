Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5CF76705B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbjG1PTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbjG1PTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:19:42 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B6E30FC;
        Fri, 28 Jul 2023 08:19:41 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-522382c4840so2988761a12.2;
        Fri, 28 Jul 2023 08:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690557579; x=1691162379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUMA9vPryqhAo0Bpi93ruUgRTi0RXDy6bqReSvggb7Y=;
        b=is7AQpu2eHBVvVuJqWlQnE+R4PD9yNV1vJW9sL8Wpa4JI3i+m6ZoYP9o/XUqYtPF8N
         KLbsaHLR+DOhqhtbmtjapuogT0OS7N274YsZyMYKaw9A747IvL7UpNG/Vtrzm6F9SmKZ
         u5s54PAb8BtuvcKBPDlepepOWO9cUPGZK8k2vGjkG8kt/PgDElza0oysdCsOPu/DJaZw
         jyDt7nav2GtQ/NscyVvtTaGTDGfb5UYGaTWNyDpTC/2bPlShVFTJsVCt9USaJMGQYTcr
         7f0HwEoytpR0zHgw8L+CygnTB10VJ0mYmKC1xLJ/hMeNHHaDdwMeaOW/cu2dkdKYiuFy
         qSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690557579; x=1691162379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUMA9vPryqhAo0Bpi93ruUgRTi0RXDy6bqReSvggb7Y=;
        b=jBYFjEi98g88X0gcL4zDBmawcwmVbmSRdaG6MEWLnzYjSW7i0aw8pk2LhWrDiAhpD6
         iwEu+/WMmXAxNZUibwv779pLAVk10mu3qkjMrRWjEDxWOw+pJLHVyxFc0SACtL8S3vKc
         Lioe4wJhdBSKYUxuAeqRaBzQi2xyV7LKzjXQKVafN5ELcFmPk1pWzzt9iPqDXRiiVHIU
         TzNd30savubcwdy9m5ZPTjK43qJFXyaFwMyOMOVrilLNvtdC317bl2Oy8PjUdf8M1xoR
         RW1gcHQD3z4XNM7DvrBQZMXgGpQuzNphZeo7LjHpRlrZeKbXjOamPsB4sK0393Sjbt47
         A7Gg==
X-Gm-Message-State: ABy/qLZUMDu/pRqLsSmVFCawfO4+iR7kfS1mKIo+ox/JnS7sP3l81iOG
        nXhbVqW+gFeAq/BJuDeLDL7Jx7FzPoRXPPA/
X-Google-Smtp-Source: APBJJlFaeLK3anYMlbBjJPOYtf9gmBPNyt6hRDXt8ya8D9F4vePbpDn+7MZ2Av+MZSG3ZD1M6tyvwA==
X-Received: by 2002:aa7:ca4b:0:b0:522:39b7:da3a with SMTP id j11-20020aa7ca4b000000b0052239b7da3amr2341009edt.31.1690557579346;
        Fri, 28 Jul 2023 08:19:39 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-157-016.77.0.pool.telefonica.de. [77.0.157.16])
        by smtp.gmail.com with ESMTPSA id u19-20020aa7db93000000b0051e1660a34esm1897829edt.51.2023.07.28.08.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 08:19:38 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] selinux: move debug functions into debug configuration
Date:   Fri, 28 Jul 2023 17:19:31 +0200
Message-Id: <20230728151932.30160-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230718184921.112786-2-cgzones@googlemail.com>
References: <20230718184921.112786-2-cgzones@googlemail.com>
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

avtab_hash_eval() and hashtab_stat() are only used in policydb.c when
the configuration SECURITY_SELINUX_DEBUG is enabled.

Move the function definitions under that configuration as well and
provide empty definitions in case SECURITY_SELINUX_DEBUG is disabled, to
avoid using #ifdef in the callers.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  - provide empty definitions for !SECURITY_SELINUX_DEBUG
  - drop #ifdef in caller
---
 security/selinux/ss/avtab.c    | 2 ++
 security/selinux/ss/avtab.h    | 7 +++++++
 security/selinux/ss/hashtab.c  | 3 ++-
 security/selinux/ss/hashtab.h  | 6 ++++++
 security/selinux/ss/policydb.c | 5 +++--
 5 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 32f92da00b0e..243e5dabfa86 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -322,6 +322,7 @@ int avtab_alloc_dup(struct avtab *new, const struct avtab *orig)
 	return avtab_alloc_common(new, orig->nslot);
 }
 
+#ifdef CONFIG_SECURITY_SELINUX_DEBUG
 void avtab_hash_eval(struct avtab *h, const char *tag)
 {
 	int i, chain_len, slots_used, max_chain_len;
@@ -352,6 +353,7 @@ void avtab_hash_eval(struct avtab *h, const char *tag)
 	       tag, h->nel, slots_used, h->nslot, max_chain_len,
 	       chain2_len_sum);
 }
+#endif /* CONFIG_SECURITY_SELINUX_DEBUG */
 
 static const uint16_t spec_order[] = {
 	AVTAB_ALLOWED,
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index 2ef5d1ae2844..3c3904bf02b0 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -91,7 +91,14 @@ void avtab_init(struct avtab *h);
 int avtab_alloc(struct avtab *, u32);
 int avtab_alloc_dup(struct avtab *new, const struct avtab *orig);
 void avtab_destroy(struct avtab *h);
+
+#ifdef CONFIG_SECURITY_SELINUX_DEBUG
 void avtab_hash_eval(struct avtab *h, const char *tag);
+#else
+static inline void avtab_hash_eval(struct avtab *h, const char *tag)
+{
+}
+#endif
 
 struct policydb;
 int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index 30532ec319ce..e3747b5dd3e7 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -103,7 +103,7 @@ int hashtab_map(struct hashtab *h,
 	return 0;
 }
 
-
+#ifdef CONFIG_SECURITY_SELINUX_DEBUG
 void hashtab_stat(struct hashtab *h, struct hashtab_info *info)
 {
 	u32 i, chain_len, slots_used, max_chain_len;
@@ -129,6 +129,7 @@ void hashtab_stat(struct hashtab *h, struct hashtab_info *info)
 	info->slots_used = slots_used;
 	info->max_chain_len = max_chain_len;
 }
+#endif /* CONFIG_SECURITY_SELINUX_DEBUG */
 
 int hashtab_duplicate(struct hashtab *new, struct hashtab *orig,
 		int (*copy)(struct hashtab_node *new,
diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
index 9dac6da45b98..f9713b56d3d0 100644
--- a/security/selinux/ss/hashtab.h
+++ b/security/selinux/ss/hashtab.h
@@ -142,7 +142,13 @@ int hashtab_duplicate(struct hashtab *new, struct hashtab *orig,
 		int (*destroy)(void *k, void *d, void *args),
 		void *args);
 
+#ifdef CONFIG_SECURITY_SELINUX_DEBUG
 /* Fill info with some hash table statistics */
 void hashtab_stat(struct hashtab *h, struct hashtab_info *info);
+#else
+static inline void hashtab_stat(struct hashtab *h, struct hashtab_info *info)
+{
+}
+#endif
 
 #endif	/* _SS_HASHTAB_H */
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index dc66868ff62c..a424997c79eb 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -701,6 +701,9 @@ static void symtab_hash_eval(struct symtab *s)
 static inline void hash_eval(struct hashtab *h, const char *hash_name)
 {
 }
+static inline void symtab_hash_eval(struct symtab *s)
+{
+}
 #endif /* CONFIG_SECURITY_SELINUX_DEBUG */
 
 /*
@@ -725,10 +728,8 @@ static int policydb_index(struct policydb *p)
 	pr_debug("SELinux:  %d classes, %d rules\n",
 		 p->p_classes.nprim, p->te_avtab.nel);
 
-#ifdef CONFIG_SECURITY_SELINUX_DEBUG
 	avtab_hash_eval(&p->te_avtab, "rules");
 	symtab_hash_eval(p->symtab);
-#endif
 
 	p->class_val_to_struct = kcalloc(p->p_classes.nprim,
 					 sizeof(*p->class_val_to_struct),
-- 
2.40.1

