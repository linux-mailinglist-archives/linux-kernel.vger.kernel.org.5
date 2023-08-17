Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F6377FDCF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354370AbjHQSXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354425AbjHQSXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:23:24 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD5B359F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:22:54 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58cf42a3313so1483827b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692296496; x=1692901296;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KUbNCncRdoFX1+f2g3pRLFzwoP3ZTCWn6yNRKIIgaR8=;
        b=szQhiT9g55SNiHgWkEz0kzx/pdJeQMPRZT87WkTbJfU5llAAIBmjRjgiQpTzpF5YN9
         jnHWSW4RBGrl6wHgCm0b7DGDja4uzbX3KiaPHrY+tRwAS5ROOmoBpwFcWEuGquvUQoW3
         pe7iA4pHhX5sYBiHgb5CEJaRdVTc5M7PLGuWkpCjPNbYCwOvg0u3nXy5uC5Ylbnl5joJ
         FwUTm8R7v07kv/Kwe1FErP0xhPfqlzOjNSztxiwntrbqdWE6FD0+E7joEgqK2swPc/xu
         kWoNfbm78S8JqLwataTwW78ctZTGc6ehN2UYe/Tguy+OLMeSudr8wa4I8hVdXC/5tmSE
         yZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692296496; x=1692901296;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUbNCncRdoFX1+f2g3pRLFzwoP3ZTCWn6yNRKIIgaR8=;
        b=ZdoYhupTTJGGTaQp9hRsDj3QgnUwAsSLpxDjwJpeEI4F0B30ZHHPilB4rxZr9XHtZ+
         OW7jlgTRm9DHd5Y2Z5h0tK7oncnoXpD9BHiGzcTPqSWaG567hZIF4mP3H2tmOHPVUp+k
         gk/1RSThJHOK2wj7hl0zSC0UdzWa76cw6q3wR0SxhU2IY0l864iSAHVVn6c/4ZYh7I0N
         GaBT2AqvzynT9GPOE5yzurA3sV79grHedHPc9q7KobZ8E0wGFIK1RlMoPUJ8OQqKNIWG
         wk8bTOhTXPrNni30yR10sRLeBLgi4SNnt95tg2ABaVgGFypmMC8B5XxgctfByOEyfD9h
         Rh4g==
X-Gm-Message-State: AOJu0YwmNZnWRIc+XiL0CSaQ4syuKe5RzjCbc4cAg2y+ZE40HbC3KSh1
        Hk2Q1JcjVJhWoIObU4ISl5w9KCzhIpZ3
X-Google-Smtp-Source: AGHT+IEu0J32esLhZqyNCqxShUB/3M3HqZKWXXA5yaIU1uOsU/89OPq9VhM26WkG7OBEwWdWhp4PpsKGG9U1
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:4a77:fd20:7069:bdf9])
 (user=mshavit job=sendgmr) by 2002:a81:ae53:0:b0:58c:b5a4:8e14 with SMTP id
 g19-20020a81ae53000000b0058cb5a48e14mr2800ywk.2.1692296496312; Thu, 17 Aug
 2023 11:21:36 -0700 (PDT)
Date:   Fri, 18 Aug 2023 02:16:28 +0800
In-Reply-To: <20230817182055.1770180-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230818021629.RFC.v1.6.I65dd382de382428dcb3cf61342b35405903ac768@changeid>
Subject: [RFC PATCH v1 6/8] iommu/arm-smmu-v3: Free VMID when uninstalling
 domain from SMMU
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     will@kernel.org, jgg@nvidia.com, nicolinc@nvidia.com,
        tina.zhang@intel.com, jean-philippe@linaro.org,
        robin.murphy@arm.com, Michael Shavit <mshavit@google.com>
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

This will allow installing a domain onto multiple smmu devices.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 208fec5fba462..7f88b2b19cbe5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2112,7 +2112,6 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 static void arm_smmu_domain_free(struct iommu_domain *domain)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
 	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
 
@@ -2122,10 +2121,6 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 		mutex_lock(&arm_smmu_asid_lock);
 		arm_smmu_free_asid(&smmu_domain->cd);
 		mutex_unlock(&arm_smmu_asid_lock);
-	} else {
-		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
-		if (cfg->vmid)
-			ida_free(&smmu->vmid_map, cfg->vmid);
 	}
 
 	kfree(smmu_domain);
@@ -2484,6 +2479,14 @@ static void arm_smmu_installed_smmus_remove_device(
 			continue;
 		list_del(&master->list);
 		if (list_empty(&installed_smmu->devices)) {
+			if (smmu_domain->stage == ARM_SMMU_DOMAIN_S2) {
+				struct arm_smmu_s2_cfg *cfg =
+					&smmu_domain->s2_cfg;
+
+				if (cfg->vmid)
+					ida_free(&smmu->vmid_map,
+						 cfg->vmid);
+			}
 			list_del(&installed_smmu->list);
 			kfree(installed_smmu);
 		}
-- 
2.42.0.rc1.204.g551eb34607-goog

