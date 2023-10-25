Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6B87D6F02
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343719AbjJYOP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbjJYOP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:15:26 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA930195
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:15:20 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99de884ad25so864270066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1698243319; x=1698848119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TMrHKgdoS2NSiiT53fI7UOW8PjpyWT9P/fMnwOt5TEs=;
        b=P8pLTOWA9LwpYNcDoYjC5UbCXf0z579RDyI30EBx84ld8JiMKWw4v0plD3XfJrzgLt
         X7fKCCrHp4jGI2deq6VEAhuavaNKi38fsKs7oJmGYFLrbTUzrBAc6vY8bhyQrr76K+1T
         51TDj4vpy7x+TZ36+juJA0VnIFyv+gYbeOYWyy7o1iPFqqBpv0xDHVryMkWYlIH1RTmW
         ip1NfVlFf41MVu/RuxZsmk0RHtQrRgq8Kt4wLe01dPpEDgA9UJvgkEL250kLkyFMYjsd
         IpwJOdtfv+wwk/XZULKxXBit0trrleS41Tjs8sWLcQvZfFGCYPeptTb3t1TiQoNZwBfr
         3bFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698243319; x=1698848119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TMrHKgdoS2NSiiT53fI7UOW8PjpyWT9P/fMnwOt5TEs=;
        b=ueJrdM8nlqgrtGFbVgo4MbR4mUNia9YqT3eBGNBZIvvGYhtWReuvZlf+BV/eY1gBV4
         f+1sVJOboU9u1cQqrEfRnGeXYKAad1NA9IW+ug5cyju/jRu5PJti+T0gEzHt1TnCC5sz
         /Wqj3NfP78fscokK4K27CvW4i/ONGshCN+S0u7Qa1gwamUR2RYZTXNuasssmyYXt58Vg
         NkuEv8h5Glgc+eKKV8nLTEImmT1KQeqydHzfCBboj5qkiqcsVJFj2qhwQuf5qJOOKoI9
         bH5jzeDhKNG0Y0xW3UQWHyx4a9svFH9LFAHgXGiM51bd0mpvAWc5y0usAhukOEH90CZx
         cJTQ==
X-Gm-Message-State: AOJu0YwIOg7Tu54gEfK/kH0ViFLo/bd4n6PJVZyXNpmmEffqdKJ+UFln
        bRT8avMUMWuie/HqL4yHPMOWa0DHWIHmkNvl14JqLQ==
X-Google-Smtp-Source: AGHT+IGQUK1phpk0aNSsV+HgwU/RjPPWJqN/gdg5zPRGrX5IaMuJzdXoimTDeIlAYb6gk2WCW1O6NQ==
X-Received: by 2002:a17:907:2d10:b0:9c7:5186:de23 with SMTP id gs16-20020a1709072d1000b009c75186de23mr12593704ejc.2.1698243319077;
        Wed, 25 Oct 2023 07:15:19 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:1a6])
        by smtp.gmail.com with ESMTPSA id m16-20020a1709066d1000b009a1a5a7ebacsm9784394ejr.201.2023.10.25.07.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 07:15:18 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH] genirq: Own affinity hint
Date:   Wed, 25 Oct 2023 16:15:17 +0200
Message-ID: <20231025141517.375378-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interfaces for setting affinity hint [1] have a rather surprising contract
with the caller [2]. The cpumask memory passed as a hint must be kept
alive, and stay unchanged, until the affinity hint gets updated again or
cleared.  Otherwise reading out /proc/irq/N/affinity_hint, which
dereferences the pointer to the cpumask holding the hint, will access
potentially invalid memory.

This forces callers to allocate the affinity hint on heap and mange its
lifetime. That is unless they fall into the category of cpumask helpers -
get_cpu_mask, cpu_mask_of[_node] - which produce a pointer to a mask
constant.

Change the affinity hint interfaces to make a copy of the affinity
hint. This way the operation from the caller point of view becomes a "set
and forget." Also there is no catch any more that the passed cpumask can't
be allocated on stack [3].

No updates are needed to the existing call sites right away. They can be
adapted to simplify resource management on their side on their own
schedule.

[1] commit 65c7cdedeb30 ("genirq: Provide new interfaces for affinity hints")
[2] commit 18a048370b06 ("net: mana: Fix accessing freed irq affinity_hint")
[3] commit 8deec94c6040 ("net: stmmac: set IRQ affinity hint for multi MSI vectors")

Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/interrupt.h |  4 ++++
 include/linux/irq.h       |  1 +
 kernel/irq/irqdesc.c      | 32 ++++++++++++++++++++------------
 kernel/irq/manage.c       | 11 ++++-------
 kernel/irq/proc.c         | 22 ++++++----------------
 5 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 4a1dc88ddbff..14ea8d2a39a5 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -320,6 +320,8 @@ extern int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m,
  * @m:		cpumask pointer (NULL to clear the hint)
  *
  * Updates the affinity hint, but does not change the affinity of the interrupt.
+ *
+ * Memory pointed by @m is not accessed after the call returns.
  */
 static inline int
 irq_update_affinity_hint(unsigned int irq, const struct cpumask *m)
@@ -335,6 +337,8 @@ irq_update_affinity_hint(unsigned int irq, const struct cpumask *m)
  *
  * Updates the affinity hint and if @m is not NULL it applies it as the
  * affinity of that interrupt.
+ *
+ * Memory pointed by @m is not accessed after the call returns.
  */
 static inline int
 irq_set_affinity_and_hint(unsigned int irq, const struct cpumask *m)
diff --git a/include/linux/irq.h b/include/linux/irq.h
index d8a6fdce9373..329c7c7be5a1 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -153,6 +153,7 @@ struct irq_common_data {
 	struct msi_desc		*msi_desc;
 #ifdef CONFIG_SMP
 	cpumask_var_t		affinity;
+	cpumask_var_t		affinity_hint;
 #endif
 #ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
 	cpumask_var_t		effective_affinity;
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 27ca1c866f29..fb443b702f22 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -55,26 +55,33 @@ static int alloc_masks(struct irq_desc *desc, int node)
 {
 	if (!zalloc_cpumask_var_node(&desc->irq_common_data.affinity,
 				     GFP_KERNEL, node))
-		return -ENOMEM;
+		goto err_affinity;
+	if (!zalloc_cpumask_var_node(&desc->irq_common_data.affinity_hint,
+				     GFP_KERNEL, node))
+		goto err_affinity_hint;
 
 #ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
 	if (!zalloc_cpumask_var_node(&desc->irq_common_data.effective_affinity,
-				     GFP_KERNEL, node)) {
-		free_cpumask_var(desc->irq_common_data.affinity);
-		return -ENOMEM;
-	}
+				     GFP_KERNEL, node))
+		goto err_effective_affinity;
 #endif
 
 #ifdef CONFIG_GENERIC_PENDING_IRQ
-	if (!zalloc_cpumask_var_node(&desc->pending_mask, GFP_KERNEL, node)) {
-#ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
-		free_cpumask_var(desc->irq_common_data.effective_affinity);
-#endif
-		free_cpumask_var(desc->irq_common_data.affinity);
-		return -ENOMEM;
-	}
+	if (!zalloc_cpumask_var_node(&desc->pending_mask, GFP_KERNEL, node))
+		goto err_pending_mask;
 #endif
 	return 0;
+
+err_pending_mask:
+#ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	free_cpumask_var(desc->irq_common_data.effective_affinity);
+#endif
+err_effective_affinity:
+	free_cpumask_var(desc->irq_common_data.affinity_hint);
+err_affinity_hint:
+	free_cpumask_var(desc->irq_common_data.affinity);
+err_affinity:
+	return -ENOMEM;
 }
 
 static void desc_smp_init(struct irq_desc *desc, int node,
@@ -391,6 +398,7 @@ static void free_masks(struct irq_desc *desc)
 	free_cpumask_var(desc->pending_mask);
 #endif
 	free_cpumask_var(desc->irq_common_data.affinity);
+	free_cpumask_var(desc->irq_common_data.affinity_hint);
 #ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
 	free_cpumask_var(desc->irq_common_data.effective_affinity);
 #endif
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index d309ba84e08a..573560645add 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -506,7 +506,10 @@ int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m,
 
 	if (!desc)
 		return -EINVAL;
-	desc->affinity_hint = m;
+	if (m)
+		cpumask_copy(desc->irq_common_data.affinity_hint, m);
+	else
+		cpumask_clear(desc->irq_common_data.affinity_hint);
 	irq_put_desc_unlock(desc, flags);
 	if (m && setaffinity)
 		__irq_set_affinity(irq, m, false);
@@ -1916,12 +1919,6 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 		irq_shutdown(desc);
 	}
 
-#ifdef CONFIG_SMP
-	/* make sure affinity_hint is cleaned up */
-	if (WARN_ON_ONCE(desc->affinity_hint))
-		desc->affinity_hint = NULL;
-#endif
-
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 	/*
 	 * Drop bus_lock here so the changes which were done in the chip
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 623b8136e9af..733324bbfb91 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -39,6 +39,7 @@ static struct proc_dir_entry *root_irq_dir;
 enum {
 	AFFINITY,
 	AFFINITY_LIST,
+	AFFINITY_HINT,
 	EFFECTIVE,
 	EFFECTIVE_LIST,
 };
@@ -57,6 +58,9 @@ static int show_irq_affinity(int type, struct seq_file *m)
 			mask = desc->pending_mask;
 #endif
 		break;
+	case AFFINITY_HINT:
+		mask = desc->irq_common_data.affinity_hint;
+		break;
 	case EFFECTIVE:
 	case EFFECTIVE_LIST:
 #ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
@@ -73,6 +77,7 @@ static int show_irq_affinity(int type, struct seq_file *m)
 		seq_printf(m, "%*pbl\n", cpumask_pr_args(mask));
 		break;
 	case AFFINITY:
+	case AFFINITY_HINT:
 	case EFFECTIVE:
 		seq_printf(m, "%*pb\n", cpumask_pr_args(mask));
 		break;
@@ -82,22 +87,7 @@ static int show_irq_affinity(int type, struct seq_file *m)
 
 static int irq_affinity_hint_proc_show(struct seq_file *m, void *v)
 {
-	struct irq_desc *desc = irq_to_desc((long)m->private);
-	unsigned long flags;
-	cpumask_var_t mask;
-
-	if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
-		return -ENOMEM;
-
-	raw_spin_lock_irqsave(&desc->lock, flags);
-	if (desc->affinity_hint)
-		cpumask_copy(mask, desc->affinity_hint);
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
-
-	seq_printf(m, "%*pb\n", cpumask_pr_args(mask));
-	free_cpumask_var(mask);
-
-	return 0;
+	return show_irq_affinity(AFFINITY_HINT, m);
 }
 
 int no_irq_affinity;
-- 
2.41.0

