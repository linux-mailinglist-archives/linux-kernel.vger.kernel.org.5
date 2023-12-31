Return-Path: <linux-kernel+bounces-13761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 623F4820C30
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 18:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED79E1F21640
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 17:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48070AD54;
	Sun, 31 Dec 2023 17:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GC7dD6fM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368AC8F58
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e7aed08f4so4893217e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 09:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704043859; x=1704648659; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hlBwUBagV5t7Ua0zL9AMI5lLR/VTB0BrMWRgto0wa3M=;
        b=GC7dD6fMqrznZQX2ceVrMMY9ezONho/5TOPOy0FSLZVMoieTdy1zU2YaD9LB0uQAZD
         HpGdxUFdvKwrSYhDwOUxE5X7u1XDdNMTGbukqyjb2quFpRgjN6OP5ZDzti+fO2nAptSi
         wiOCxVNOqeYpRWGU38d93udGSXHmfx3BRQ2DPS++ezTot+nVeAsTYC83GUzahGQg1p7+
         oWQkYMxnpO62MdyhM3lcJEJXeO6Rr+sEnD7RzduDcRWB/UoUuub1HJga6O56NYLqZyFC
         hiY+Jueh0WR3hS1PIHfJDnRvEqejxBRyFsGYfcrREywZaF9KG+clzX4B6yYKutiGxwPe
         AaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704043859; x=1704648659;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlBwUBagV5t7Ua0zL9AMI5lLR/VTB0BrMWRgto0wa3M=;
        b=tnlwoiZxJ3DzPz6E0qTBydL3MNUHd1bdNvOKAQL15k5sSVenAJY39XXAAK49YORUnA
         97dJtMewHgh9uU2UjYJ5G+3Ue5NlCFr7+CW6TYnCVRpLbQp/elwvQhYRFtp/lXlvPi3B
         YP+1sPghgq/qgsEKnauX2PWB+79EzS4UNjgc6658s9l4fXq/OHvT/oPBA+Go/ZBkd5rH
         BYEUntFN3eEU9Q4wuNaUXUn1lNE4Avu6bU4uMGkGFXFKKQX8F0WZkIvVtfe9Q3jVMYND
         THEhOQajPf5DDBadiCWDGEplhWZp3MnZNqt6LFp/kGzSpOfUIYoWBqC3QeXNTcDE8JYw
         9RAQ==
X-Gm-Message-State: AOJu0YyJ3ZnO9AoA9JBVpKMWOn7cOJIvNGkWqiTyY1tUXyw1n+ETrN0T
	YLqFZ5pEL4R7DOkmlTX+G5Uzlc+g0iK9xg==
X-Google-Smtp-Source: AGHT+IFoDiaFV03S7y908enJQ4ZO1/mX4GL5lE3nL/FpG6FrTCC3QLeXkVjPAYbQ/gWSjN+6Zt/7rQ==
X-Received: by 2002:ac2:593b:0:b0:50e:7c08:1ac3 with SMTP id v27-20020ac2593b000000b0050e7c081ac3mr4768303lfi.19.1704043859245;
        Sun, 31 Dec 2023 09:30:59 -0800 (PST)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id k1-20020ac257c1000000b0050e6b5228d3sm2754645lfo.304.2023.12.31.09.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 09:30:58 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 31 Dec 2023 19:30:57 +0200
Subject: [PATCH 2/2] cacheinfo: pass of_node to cpu_device_create()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231231-cpu-cacheinfo-of-v1-2-cd3584d2c7b4@linaro.org>
References: <20231231-cpu-cacheinfo-of-v1-0-cd3584d2c7b4@linaro.org>
In-Reply-To: <20231231-cpu-cacheinfo-of-v1-0-cd3584d2c7b4@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
 Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2544;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=fihis3MyTyp6l+0iQfwORdHTA5PAnKsF+hOW3xnuqjs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBlkaVQJD3G1THjeCig6ET5zZhdsHC0L/7ei8U3y
 4n0huoVld+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZZGlUAAKCRCLPIo+Aiko
 1Qf2B/0UXewDYJGJ1YjHKDD/rcJ4C/E/1rFAl7G9iqNf3CBWZd4r3jO2bpk6kHQDG4SQhIDVv22
 zS29LNYdCv9Ugr3lfE2+52kkdDxrLzLjjJMEavEw/kRU/Pd0d5FLWksQiPx/xICJIjkZVO4RvP6
 UqdLR/CLr6n1tOGciyo0Rw6e2J4DAgXVoWT7vMB3P1cMyDgjQvNTmxsuueGptDLe3mSfzrhD7j8
 fIPoDi4YOM7/qVvNLOpT4EzDAsR2R4llvRg1EekdvFYcvuX79oKFsE+xOiEQQ3VEKwzQUTXUeR6
 pmZONSYGuD+Qzjb2b4MN83lAhlaTUFSW9KmPSHSx3WlO4HSJ
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Pass the DT node correponsing to caches to the cpu_device_create() in
order to let platform-specific cache drivers to bind to the
corresponding cache devices. For example, on Qualcomm Krait platforms
the L2 cache frequency should be scaled following the CPU frequencies.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/base/cacheinfo.c  | 12 +++++++++++-
 include/linux/cacheinfo.h |  2 ++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index a72c69e70fa3..63bc94cf2c59 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -230,6 +230,7 @@ static int cache_setup_of_node(unsigned int cpu)
 		}
 		cache_of_set_props(this_leaf, np);
 		this_leaf->fw_token = np;
+		this_leaf->of_node = of_node_get(np);
 		index++;
 	}
 
@@ -457,10 +458,19 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
 
 static void free_cache_attributes(unsigned int cpu)
 {
+	struct cacheinfo *this_leaf;
+	unsigned int index;
+
 	if (!per_cpu_cacheinfo(cpu))
 		return;
 
 	cache_shared_cpu_map_remove(cpu);
+
+	for (index = 0; index < cache_leaves(cpu); index++) {
+		this_leaf = per_cpu_cacheinfo_idx(cpu, index);
+		of_node_put(this_leaf->of_node);
+		this_leaf->of_node = NULL;
+	}
 }
 
 int __weak early_cache_level(unsigned int cpu)
@@ -883,7 +893,7 @@ static int cache_add_dev(unsigned int cpu)
 			break;
 		cache_groups = cache_get_attribute_groups(this_leaf);
 		ci_dev = cpu_device_create(parent, this_leaf,
-					   NULL,
+					   this_leaf->of_node,
 					   cache_groups,
 					   "index%1u", i);
 		if (IS_ERR(ci_dev)) {
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index d504eb4b49ab..543d1410e56a 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -38,6 +38,7 @@ extern unsigned int coherency_max_size;
  * @attributes: bitfield representing various cache attributes
  * @fw_token: Unique value used to determine if different cacheinfo
  *	structures represent a single hardware cache instance.
+ * @of_node: Corresponding DT node
  * @disable_sysfs: indicates whether this node is visible to the user via
  *	sysfs or not
  * @priv: pointer to any private data structure specific to particular
@@ -67,6 +68,7 @@ struct cacheinfo {
 	(CACHE_READ_ALLOCATE | CACHE_WRITE_ALLOCATE)
 #define CACHE_ID		BIT(4)
 	void *fw_token;
+	struct device_node *of_node;
 	bool disable_sysfs;
 	void *priv;
 };

-- 
2.39.2


