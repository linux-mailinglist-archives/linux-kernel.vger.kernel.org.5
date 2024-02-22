Return-Path: <linux-kernel+bounces-77077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CBC8600EE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D00D6B254F9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC57160865;
	Thu, 22 Feb 2024 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lf9/mlYY"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1CE15E5C3;
	Thu, 22 Feb 2024 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625689; cv=none; b=f5hXKUCDMKG5BU4kpXiU1XfTyy5lGONblYsi3NK+b9JiaUg4mvGu8xSKNfl1Z1QpiNBPNf5/DyNY3QBO+/pBifjtiZ8oYIDFwHIzzxbTG+3m0jR8hqvvwWhskoggLnpnL/fgS51UYZNEWWRfT1IvlbizOh1SufeiABRdemhFBDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625689; c=relaxed/simple;
	bh=ePu72+GcKnqKnFgiENA7NMWun17fWyqJBf3/+y7h41I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omd4iqUAIapSISVGQIUNKhEeU5sbAX5f67hjmLxiPbNKl6symJJ8UQB/FoPMzbc5YbCAgBqMc8S6qE1vx2wjHLatVjcSFgiXCsf/hWAtXgjkO6ASQvPS9IOKcTqxktXmS9msG/OoGmsh9Krwqy61Fx8TESJ5SjwBptYU2eWUq7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lf9/mlYY; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5112bd13a4fso1330213e87.0;
        Thu, 22 Feb 2024 10:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708625686; x=1709230486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLzBjMC1HQrpBSrNG7IsBicFltQpQsnlTrfLyFywK/U=;
        b=Lf9/mlYYFVgJGg9lbRpBBXsnCXzVk36DEQwG8Co0hvadLFiaqu4cwL+Xz5MJljkYKy
         9yKqcAn0njBIvltUbxTrBtJ8BVL8fuhriSl4S3qOe9Hu7OsFaNIitTdrpdImYlXJX8Oc
         XuWi1sT6LywoT4dh1YUgbSw8EgODax0zmf2bAQmrdSfxsQbud0NmRrjVXLJ5AgEXCNsM
         /Jv7A4dW0jov36d93Nfipni6yiPexEGdHzhYGJRj1pZdJuQh/fpUaXZ43/pG8nz/QGDc
         kHRMgChpqnrOdP0joBmxfPykSg81lAN/juNTnk+YoYBTU1vSAA+E11nQpO/D9ZypVUSx
         ikfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708625686; x=1709230486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLzBjMC1HQrpBSrNG7IsBicFltQpQsnlTrfLyFywK/U=;
        b=j6u6Kc7G7YfqsdOcuPg59DkWDsmkXIVoXJhbfYlhx+36S76VMELA9NmsmWmxgtOuiY
         uBPiCM02HFPpjFGt/gXtkCxRNfMBjG6GQ25kW05xXsmqGvcTvXjpdmxtwE503QGM0aEa
         jVreTYTuM/kbnUWdwYVfl2QpphSL+iDTe7Pe0i4QGC6anMxoF8tzcL1CZyumDH5CK8GS
         g6U9F3HKAfYPYk8om1bRIcn9/hZlj5VZoYYmx4tvwMNTntsm/4TO3NwTnCt41PRpmWiU
         Ro/BnHC8fS39ohDfTXTUmUEiwbS7aKygreYf8IoNpxKMDtT3QEAnRyv0GdV5BUbl+sJy
         8Kxg==
X-Forwarded-Encrypted: i=1; AJvYcCWl2McqfJKzy2lFiFLVEoWlqhBBhw9TPB+nsDBnIw1J5JpyZNmijzdjIMjiH5178jXBVJ+dl/ynostxsJ9xD+50Fae/HQRhKq6hVuR4xMTRSA1zutvR6/KrhPYWT0LPPD8AuPFABdYIMw==
X-Gm-Message-State: AOJu0Ywoz1q45GTZKahJRPHt8xXW0Huu9bA6n6WEglPsqvppveb9tjK8
	3nT3L+uX7lXbuM5Lp9+dpmO45YAYQCmWjsTMuMFyarhZiCOomOYy
X-Google-Smtp-Source: AGHT+IGVGG7JHCiusAb9XSxJwziVVLr/Gx8dPNPsWyTUDy9bkr+juJL1rqqgPwYEfdccnfH+Cn2TRA==
X-Received: by 2002:a19:654b:0:b0:511:a0db:5062 with SMTP id c11-20020a19654b000000b00511a0db5062mr1107289lfj.17.1708625685752;
        Thu, 22 Feb 2024 10:14:45 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id z7-20020a19f707000000b00512e1f810cesm141154lfe.47.2024.02.22.10.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:14:45 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 14/20] EDAC/mc: Add generic unique MC index allocation procedure
Date: Thu, 22 Feb 2024 21:12:59 +0300
Message-ID: <20240222181324.28242-15-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222181324.28242-1-fancer.lancer@gmail.com>
References: <20240222181324.28242-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the EDAC subsystem relies on the low-level device drivers to
select an unique index for each memory controller available in the system.
Here are the already implemented approaches:
1. Fixed zero id. The vast majority of the drivers expect to have a single
memory controller in the system.
2. Calculate based on a platform-specific way (Pre-defined devices order,
PCIe-bus address, Numa node ID + PCIe-function number, etc).
3. Use platform_device->id.
4. Use custom ACPI/OF property value.
5. Use locally maintained static MC counter.

Create a generic method of the MC index allocation which could be utilized
for the case 5 (it doesn't imply any strict memory controller order) and
which would prevent the new MC EDAC drivers re-implementing the approaches
3 and 4. Moreover it will be useful for the cases when a platform is
equipped with memory-controllers of different types [1] and which are
probed by different drivers [2].

[1] Link: https://lore.kernel.org/all/9dc2a947-d2ab-4f00-8ed3-d2499cb6fdfd@BN1BFFO11FD002.protection.gbl/
[2] Link: https://lore.kernel.org/linux-edac/BY5PR12MB4258CB67B70D71F107EC1E9DDB3E9@BY5PR12MB4258.namprd12.prod.outlook.com

The suggested implementation is based on the IDA kernel API and implies
the next semantics:
1. If a particular MC index is specified it will be registered in the
IDR pool unless the specified ID has already been reserved.
2. If a special MC index is specified (EDAC_AUTO_MC_NUM) the EDAC
core will check whether there is a "mcID" alias is defined in the device
tree and use the ID from there if it's found.
3. Otherwise a next free index will be allocated and assigned to the
registered memory controller.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Note the approach implemented here has been partly ported from the SPI
core driver using IDA to track/allocate SPI bus numbers.
Link: https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi.c#L2957
---
 drivers/edac/edac_mc.c | 89 +++++++++++++++++++++++++++++++++++++++---
 drivers/edac/edac_mc.h |  4 ++
 2 files changed, 87 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index c0b36349999f..2144e0615679 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -29,6 +29,9 @@
 #include <linux/edac.h>
 #include <linux/bitops.h>
 #include <linux/uaccess.h>
+#include <linux/idr.h>
+#include <linux/of.h>
+
 #include <asm/page.h>
 #include "edac_mc.h"
 #include "edac_module.h"
@@ -46,6 +49,7 @@ EXPORT_SYMBOL_GPL(edac_op_state);
 /* lock to memory controller's control array */
 static DEFINE_MUTEX(mem_ctls_mutex);
 static LIST_HEAD(mc_devices);
+static DEFINE_IDR(mc_idr);
 
 /*
  * Used to lock EDAC MC to just one module, avoiding two drivers e. g.
@@ -494,7 +498,64 @@ void edac_mc_reset_delay_period(unsigned long value)
 	mutex_unlock(&mem_ctls_mutex);
 }
 
+/**
+ * edac_mc_alloc_id() - Allocate unique Memory Controller identifier
+ *
+ * @mci: pointer to the mci structure to allocate ID for
+ *
+ * Use edac_mc_free_id() to coherently free the MC identifier.
+ *
+ * .. note::
+ *	locking model: must be called with the mem_ctls_mutex lock held
+ *
+ * Returns:
+ *	0 on Success, or an error code on failure
+ */
+static int edac_mc_alloc_id(struct mem_ctl_info *mci)
+{
+	struct device_node *np = dev_of_node(mci->pdev);
+	int ret, min, max;
+
+	if (mci->mc_idx == EDAC_AUTO_MC_NUM) {
+		ret = of_alias_get_id(np, "mc");
+		if (ret >= 0) {
+			min = ret;
+			max = ret + 1;
+		} else {
+			min = of_alias_get_highest_id("mc");
+			if (min >= 0)
+				min++;
+			else
+				min = 0;
+
+			max = 0;
+		}
+	} else {
+		min = mci->mc_idx;
+		max = mci->mc_idx + 1;
+	}
+
+	ret = idr_alloc(&mc_idr, mci, min, max, GFP_KERNEL);
+	if (ret < 0)
+		return ret == -ENOSPC ? -EBUSY : ret;
+
+	mci->mc_idx = ret;
+
+	return 0;
+}
 
+/**
+ * edac_mc_free_id() - Free Memory Controller identifier
+ *
+ * @mci: pointer to the mci structure to free ID from
+ *
+ * .. note::
+ *	locking model: must be called with the mem_ctls_mutex lock held
+ */
+static void edac_mc_free_id(struct mem_ctl_info *mci)
+{
+	idr_remove(&mc_idr, mci->mc_idx);
+}
 
 /**
  * edac_mc_init_labels() - Initialize DIMM labels
@@ -613,7 +674,8 @@ EXPORT_SYMBOL_GPL(edac_get_owner);
 int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
 			       const struct attribute_group **groups)
 {
-	int ret = -EINVAL;
+	int ret;
+
 	edac_dbg(0, "\n");
 
 #ifdef CONFIG_EDAC_DEBUG
@@ -650,20 +712,30 @@ int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
 		goto fail0;
 	}
 
+	ret = edac_mc_alloc_id(mci);
+	if (ret) {
+		edac_printk(KERN_ERR, EDAC_MC, "failed to allocate MC idx %u\n",
+			    mci->mc_idx);
+		goto fail0;
+	}
+
 	edac_mc_init_labels(mci);
 
-	if (add_mc_to_global_list(mci))
-		goto fail0;
+	if (add_mc_to_global_list(mci)) {
+		ret = -EINVAL;
+		goto fail1;
+	}
 
 	/* set load time so that error rate can be tracked */
 	mci->start_time = jiffies;
 
 	mci->bus = edac_get_sysfs_subsys();
 
-	if (edac_create_sysfs_mci_device(mci, groups)) {
+	ret = edac_create_sysfs_mci_device(mci, groups);
+	if (ret) {
 		edac_mc_printk(mci, KERN_WARNING,
 			"failed to create sysfs device\n");
-		goto fail1;
+		goto fail2;
 	}
 
 	if (mci->edac_check) {
@@ -687,9 +759,12 @@ int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
 	mutex_unlock(&mem_ctls_mutex);
 	return 0;
 
-fail1:
+fail2:
 	del_mc_from_global_list(mci);
 
+fail1:
+	edac_mc_free_id(mci);
+
 fail0:
 	mutex_unlock(&mem_ctls_mutex);
 	return ret;
@@ -717,6 +792,8 @@ struct mem_ctl_info *edac_mc_del_mc(struct device *dev)
 	if (del_mc_from_global_list(mci))
 		edac_mc_owner = NULL;
 
+	edac_mc_free_id(mci);
+
 	mutex_unlock(&mem_ctls_mutex);
 
 	if (mci->edac_check)
diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
index 881b00eadf7a..4b6676235b1b 100644
--- a/drivers/edac/edac_mc.h
+++ b/drivers/edac/edac_mc.h
@@ -23,6 +23,7 @@
 #define _EDAC_MC_H_
 
 #include <linux/kernel.h>
+#include <linux/limits.h>
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
@@ -37,6 +38,9 @@
 #include <linux/workqueue.h>
 #include <linux/edac.h>
 
+/* Generate MC identifier automatically */
+#define EDAC_AUTO_MC_NUM	UINT_MAX
+
 #if PAGE_SHIFT < 20
 #define PAGES_TO_MiB(pages)	((pages) >> (20 - PAGE_SHIFT))
 #define MiB_TO_PAGES(mb)	((mb) << (20 - PAGE_SHIFT))
-- 
2.43.0


