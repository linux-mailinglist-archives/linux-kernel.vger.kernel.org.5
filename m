Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709BB7CCCA9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343507AbjJQTxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjJQTxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:53:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93961C4;
        Tue, 17 Oct 2023 12:53:42 -0700 (PDT)
Date:   Tue, 17 Oct 2023 19:53:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697572421;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IcBt2xPQ1tUNJXBgNwttFf5lFVdSWnHxCfEhD6ZM68I=;
        b=iThQ3UrOyEEsz5vSXD5NDmPkz+NGGIilz+OLZ8LnszH0GEedadxc30TcfCYVFRVYKuIsnc
        k+ouC61PQj/qze/Sskn3sz6aqDMWbvgB2APu5JHFv0WghijqBcyHHU/EaT7VXvKEe7J9XQ
        lWEf5k/3hrTd3XnwI1Su3ZMFSC0DjBbTWkJWqdnujcZbyeDzzwuTaQw28nldJ+0vQ0Ne6X
        GcHrOd9sVMIEe0DHZv3/78gkujupu/HRZVUCPw13/LxD2o+0upizfdRH0lJMGZywgqcocA
        UqEUjpOlhlL1CQaRZZ5RpwjG8U1572USJqmC2pkZ+GHhlhOXqIdy7LIMDQLZqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697572421;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IcBt2xPQ1tUNJXBgNwttFf5lFVdSWnHxCfEhD6ZM68I=;
        b=/ez8FsxAtD6Ql9RlArNIEBmOR3FjtgvEA5zfQDh/9ukX74ZgJXypu15Uqh4fJSET4Ds3x2
        lWu7uG7zMXpi/IDQ==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Provide stubs for IMS functions
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: =?utf-8?q?=3C14ff656899a3757453f8584c1109d7a9b98fa258=2E16975?=
 =?utf-8?q?64731=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C14ff656899a3757453f8584c1109d7a9b98fa258=2E169756?=
 =?utf-8?q?4731=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <169757242009.3135.5502383859327174030.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     41efa431244f6498833ff8ee8dde28c4924c5479
Gitweb:        https://git.kernel.org/tip/41efa431244f6498833ff8ee8dde28c4924c5479
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 17 Oct 2023 10:56:38 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 17 Oct 2023 21:46:33 +02:00

PCI/MSI: Provide stubs for IMS functions

The IMS related functions (pci_create_ims_domain(), pci_ims_alloc_irq(),
and pci_ims_free_irq()) are not declared when CONFIG_PCI_MSI is disabled.

Provide definitions of these functions for use when callers are compiled
with CONFIG_PCI_MSI disabled.

Fixes: 0194425af0c8 ("PCI/MSI: Provide IMS (Interrupt Message Store) support")
Fixes: c9e5bea27383 ("PCI/MSI: Provide pci_ims_alloc/free_irq()")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/14ff656899a3757453f8584c1109d7a9b98fa258.1697564731.git.reinette.chatre@intel.com
---
 include/linux/pci.h | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8c7c2c3..b564172 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1624,6 +1624,8 @@ struct msix_entry {
 	u16	entry;	/* Driver uses to specify entry, OS writes */
 };
 
+struct msi_domain_template;
+
 #ifdef CONFIG_PCI_MSI
 int pci_msi_vec_count(struct pci_dev *dev);
 void pci_disable_msi(struct pci_dev *dev);
@@ -1656,6 +1658,11 @@ void pci_msix_free_irq(struct pci_dev *pdev, struct msi_map map);
 void pci_free_irq_vectors(struct pci_dev *dev);
 int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
 const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev, int vec);
+bool pci_create_ims_domain(struct pci_dev *pdev, const struct msi_domain_template *template,
+			   unsigned int hwsize, void *data);
+struct msi_map pci_ims_alloc_irq(struct pci_dev *pdev, union msi_instance_cookie *icookie,
+				 const struct irq_affinity_desc *affdesc);
+void pci_ims_free_irq(struct pci_dev *pdev, struct msi_map map);
 
 #else
 static inline int pci_msi_vec_count(struct pci_dev *dev) { return -ENOSYS; }
@@ -1719,6 +1726,25 @@ static inline const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev,
 {
 	return cpu_possible_mask;
 }
+
+static inline bool pci_create_ims_domain(struct pci_dev *pdev,
+					 const struct msi_domain_template *template,
+					 unsigned int hwsize, void *data)
+{ return false; }
+
+static inline struct msi_map pci_ims_alloc_irq(struct pci_dev *pdev,
+					       union msi_instance_cookie *icookie,
+					       const struct irq_affinity_desc *affdesc)
+{
+	struct msi_map map = { .index = -ENOSYS, };
+
+	return map;
+}
+
+static inline void pci_ims_free_irq(struct pci_dev *pdev, struct msi_map map)
+{
+}
+
 #endif
 
 /**
@@ -2616,14 +2642,6 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
 void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 #endif
 
-struct msi_domain_template;
-
-bool pci_create_ims_domain(struct pci_dev *pdev, const struct msi_domain_template *template,
-			   unsigned int hwsize, void *data);
-struct msi_map pci_ims_alloc_irq(struct pci_dev *pdev, union msi_instance_cookie *icookie,
-				 const struct irq_affinity_desc *affdesc);
-void pci_ims_free_irq(struct pci_dev *pdev, struct msi_map map);
-
 #include <linux/dma-mapping.h>
 
 #define pci_printk(level, pdev, fmt, arg...) \
