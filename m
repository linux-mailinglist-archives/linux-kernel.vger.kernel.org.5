Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD6E792AE4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344584AbjIEQoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354463AbjIELu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:50:56 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53C41AD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 04:50:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c647150c254so3936330276.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 04:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693914652; x=1694519452; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gjCU4bk4Wl3Es5Hg0EGwSHw9ZzQ976ECMmTAxnvnHd4=;
        b=fTVK9zt5fOYBuNBs8Z3H+afiBGtpeIcUqoHf9bbVbJsnVN2/JxsxgJLlJ1j7y3WOGB
         QGqfmPgxi8qUYcRO9XBsjF7OpVgtKxJC+RF8F9i/6Z9qE2wPIrqQ6mO/2+cDn4cBzegu
         XFAiXJAfxSh8AUIHGfCswZh0oB7hfvjoehuGpzzoqX36iMHCoTd7RamBwLVIy7VIsPTH
         osH3LNytxdZ1U0Whsvf+7nPNbH3QCnfWuG3xXAgIwxzGtr6dZs+m7PiF5rYTQWwRcm1s
         L44JZk7IJFQau4jg3Ke8YW+5aOLZDgprRB6IBNPj/iJjd3eNub2dmlROn3ATS5HlEvGu
         l8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693914652; x=1694519452;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjCU4bk4Wl3Es5Hg0EGwSHw9ZzQ976ECMmTAxnvnHd4=;
        b=TYA5ozw5tmdhKmAAPTyfNjPdlMGJX/JuUSMEwQz21GB1FXjq7frYwqvNWG47FBEerD
         d9lgqDzCL180sfD1hR9ovOc0ju1QIAl4P9xv2xVkuvhKBMjz2GVYkXYT0RmO9MfCSBXv
         5GnEKBota2U9dIzNqxS0WDdELsqiow4H8+Hg8xtD0l9WokDmEfs/1BZ3kyoNmx69xJ2Z
         VMvuBs9JFEMAlFAWrWIJLx1diqwzvUUTxVT0YZdKySRRnAlwsuiJ61Pg2zFOaa8PvPub
         1pmHS27xukLegT7Rn//2b2N4Jd0LL3sKEPezryQvUd9mx11ZeklrWZjeOLvEj4ZIzybS
         w+5g==
X-Gm-Message-State: AOJu0YzzjV8vgve+JJk4dbxxgLHoUWcoDA1ztPCnhR1UeV8C4sRxPnoy
        4IuUoTKe5vR7pM1QJ2dfJ48e14r1WkDX
X-Google-Smtp-Source: AGHT+IH8Ll81TmfGbOr35Poi1a+i5Cf1F4+EZkR+p5aL39BXPjl6KqI30DbaRvJMrjW56k1ISvkx8KhqYjW3
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:c4a8:fdce:d8d3:7b02])
 (user=mshavit job=sendgmr) by 2002:a25:df49:0:b0:d77:f789:f9da with SMTP id
 w70-20020a25df49000000b00d77f789f9damr350984ybg.6.1693914652046; Tue, 05 Sep
 2023 04:50:52 -0700 (PDT)
Date:   Tue,  5 Sep 2023 19:49:14 +0800
In-Reply-To: <20230905115013.1572240-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230905115013.1572240-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230905194849.v1.3.I211f2ab0ee241f53cdfbc3a8a573f14b8a46fb26@changeid>
Subject: [PATCH v1 3/3] iommu/arm-smmu-v3-sva: Remove arm_smmu_bond
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     will@kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com,
        jean-philippe@linaro.org, jgg@nvidia.com, tina.zhang@intel.com,
        Michael Shavit <mshavit@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Tomas Krcka <krckatom@amazon.de>,
        Yicong Yang <yangyicong@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new iommu_domain subclass for SVA iommu domains to hold the
data previously stored in the dynamically allocated arm_smmu_bond. Add a
simple count of attached SVA domains to arm_smmu_master to replace the
list of bonds.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 70 +++++++------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  1 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +-
 3 files changed, 26 insertions(+), 47 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 9fb6907c5e7d4..0342c0f35d55a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -24,14 +24,13 @@ struct arm_smmu_mmu_notifier {
 
 #define mn_to_smmu(mn) container_of(mn, struct arm_smmu_mmu_notifier, mn)
 
-struct arm_smmu_bond {
-	struct mm_struct		*mm;
+struct arm_smmu_sva_domain {
+	struct iommu_domain		iommu_domain;
 	struct arm_smmu_mmu_notifier	*smmu_mn;
-	struct list_head		list;
 };
 
-#define sva_to_bond(handle) \
-	container_of(handle, struct arm_smmu_bond, sva)
+#define to_sva_domain(domain) \
+	container_of(domain, struct arm_smmu_sva_domain, iommu_domain)
 
 static DEFINE_MUTEX(sva_lock);
 
@@ -318,10 +317,10 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 	arm_smmu_free_shared_cd(cd);
 }
 
-static int __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
+static int __arm_smmu_sva_bind(struct device *dev,
+			       struct arm_smmu_sva_domain *sva_domain,
+			       struct mm_struct *mm)
 {
-	int ret;
-	struct arm_smmu_bond *bond;
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
@@ -329,24 +328,14 @@ static int __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	if (!master || !master->sva_enabled)
 		return -ENODEV;
 
-	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
-	if (!bond)
-		return -ENOMEM;
-
-	bond->mm = mm;
-
-	bond->smmu_mn = arm_smmu_mmu_notifier_get(smmu_domain, mm);
-	if (IS_ERR(bond->smmu_mn)) {
-		ret = PTR_ERR(bond->smmu_mn);
-		goto err_free_bond;
+	sva_domain->smmu_mn = arm_smmu_mmu_notifier_get(smmu_domain,
+							mm);
+	if (IS_ERR(sva_domain->smmu_mn)) {
+		sva_domain->smmu_mn = NULL;
+		return PTR_ERR(sva_domain->smmu_mn);
 	}
-
-	list_add(&bond->list, &master->bonds);
+	master->nr_attached_sva_domains += 1;
 	return 0;
-
-err_free_bond:
-	kfree(bond);
-	return ret;
 }
 
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
@@ -476,7 +465,7 @@ int arm_smmu_master_enable_sva(struct arm_smmu_master *master)
 int arm_smmu_master_disable_sva(struct arm_smmu_master *master)
 {
 	mutex_lock(&sva_lock);
-	if (!list_empty(&master->bonds)) {
+	if (master->nr_attached_sva_domains != 0) {
 		dev_err(master->dev, "cannot disable SVA, device is bound\n");
 		mutex_unlock(&sva_lock);
 		return -EBUSY;
@@ -500,22 +489,14 @@ void arm_smmu_sva_notifier_synchronize(void)
 void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
 				   struct device *dev, ioasid_t id)
 {
-	struct mm_struct *mm = domain->mm;
-	struct arm_smmu_bond *bond = NULL, *t;
+	struct arm_smmu_sva_domain *sva_domain = to_sva_domain(domain);
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 
 	mutex_lock(&sva_lock);
-	list_for_each_entry(t, &master->bonds, list) {
-		if (t->mm == mm) {
-			bond = t;
-			break;
-		}
-	}
-
-	if (!WARN_ON(!bond)) {
-		list_del(&bond->list);
-		arm_smmu_mmu_notifier_put(bond->smmu_mn);
-		kfree(bond);
+	if (!WARN_ON(!sva_domain->smmu_mn)) {
+		master->nr_attached_sva_domains -= 1;
+		arm_smmu_mmu_notifier_put(sva_domain->smmu_mn);
+		sva_domain->smmu_mn = NULL;
 	}
 	mutex_unlock(&sva_lock);
 }
@@ -527,7 +508,7 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 	struct mm_struct *mm = domain->mm;
 
 	mutex_lock(&sva_lock);
-	ret = __arm_smmu_sva_bind(dev, mm);
+	ret = __arm_smmu_sva_bind(dev, to_sva_domain(domain), mm);
 	mutex_unlock(&sva_lock);
 
 	return ret;
@@ -545,12 +526,11 @@ static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
 
 struct iommu_domain *arm_smmu_sva_domain_alloc(void)
 {
-	struct iommu_domain *domain;
+	struct arm_smmu_sva_domain *sva_domain;
 
-	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
-	if (!domain)
+	sva_domain = kzalloc(sizeof(*sva_domain), GFP_KERNEL);
+	if (!sva_domain)
 		return NULL;
-	domain->ops = &arm_smmu_sva_domain_ops;
-
-	return domain;
+	sva_domain->iommu_domain.ops = &arm_smmu_sva_domain_ops;
+	return &sva_domain->iommu_domain;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9b0dc35056019..911bcfd90cd85 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2685,7 +2685,6 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 
 	master->dev = dev;
 	master->smmu = smmu;
-	INIT_LIST_HEAD(&master->bonds);
 	dev_iommu_priv_set(dev, master);
 
 	ret = arm_smmu_insert_master(smmu, master);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index dcab85698a4e2..3a518834429b1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -702,7 +702,7 @@ struct arm_smmu_master {
 	bool				stall_enabled;
 	bool				sva_enabled;
 	bool				iopf_enabled;
-	struct list_head		bonds;
+	unsigned int			nr_attached_sva_domains;
 	unsigned int			ssid_bits;
 };
 
-- 
2.42.0.283.g2d96d420d3-goog

