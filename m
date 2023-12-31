Return-Path: <linux-kernel+bounces-13760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E05820C2F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 18:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7DF1C20C43
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 17:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08677A957;
	Sun, 31 Dec 2023 17:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EZJCzGpq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F498F52
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e7be1c65dso4941074e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 09:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704043859; x=1704648659; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KpTNKk8wKE3bGmO15Z42fFt5aqX74H0FvDnsTf/kF6g=;
        b=EZJCzGpqQ1p8WedLDNoJEPxlq25P7e48YW8LxNKPtK9VAXMOTo0FCEGwDNAmNDI+k2
         YOosY2z8Sbgz8CPioqkPI23zYJvOy7X+RQGMIUX4iFkdzLze+OjlQrLVm0Sx2esSHL9g
         LRy2QE40CFGLTrq+U2nuDHEqXRBPuEQpjQPW9blCRv5OkCkVm6pwU1OYMRDJ5CLuWua2
         gL94joj4w2kMddSsV6IEph9KTqxQBBn9jOfWfZfkIoRvi2wirG5X22H0wssTQbMzjYeS
         C0i/7PGO9GRj+ROpwbLrDgFuW/KPgA/RPhUWmiJ1hYb1C5jieiLqVmhhh4oRwVI3LWcA
         xA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704043859; x=1704648659;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KpTNKk8wKE3bGmO15Z42fFt5aqX74H0FvDnsTf/kF6g=;
        b=f/QdElIuJ43D+05S6rVYUlQ512FCtSPx8Ln7PfueNpWsIGr522cLbR0VEocIB4Ls29
         tgrdOKf0ZK9BEkA8NC/QoFxtXez3QOaH3dCqH0//s3J9DrEqbDXpreRxHUscS4lB8q8s
         PLBwRGPMm0UWyxvrrmSWJU2gzWuMNYgFFU+gYN2m3F+AJwmpeQeqaKuLbLFX6nnkfTfn
         wXWRxdFgatXiRPa25rEPFh2h9Exmp0iknpf/UFL6gGUnXysGqFWRmEbyLrY9nRJh9sA2
         HjkoqLpC5VAH8Ik7FQlXoWjWipnkK/3SyDFpxWDQNN90ddiaQS8P/N2U2Rl8NUaRdqBt
         5MQQ==
X-Gm-Message-State: AOJu0YxHA+8ygJolC+3gn7WL15wFfUNSwg2EkJZcrr9SjVFlRpjAfrkR
	1EOcV94NJra0LRi99nqNlB3mWpMIvhR2Dw==
X-Google-Smtp-Source: AGHT+IENoo22xZd0OQJGp2+i4gXTX40/3BcU1jdwTsSIBXQX4/aJ+f8F1UkMoJhVSv8Gv6Gp1OQcPw==
X-Received: by 2002:a05:6512:108d:b0:50e:86af:97e3 with SMTP id j13-20020a056512108d00b0050e86af97e3mr3424089lfg.76.1704043858623;
        Sun, 31 Dec 2023 09:30:58 -0800 (PST)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id k1-20020ac257c1000000b0050e6b5228d3sm2754645lfo.304.2023.12.31.09.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 09:30:57 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 31 Dec 2023 19:30:56 +0200
Subject: [PATCH 1/2] cpu: allow matching cpu_subsys devices against OF
 nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231231-cpu-cacheinfo-of-v1-1-cd3584d2c7b4@linaro.org>
References: <20231231-cpu-cacheinfo-of-v1-0-cd3584d2c7b4@linaro.org>
In-Reply-To: <20231231-cpu-cacheinfo-of-v1-0-cd3584d2c7b4@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
 Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4075;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Ehv6GDEdCHawMog1wnKBhOB1sHxHki22fxkxD9ai0tc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBlkaVQazLVjIx8wxs0/MWfqPVsLl+jgCPjd8r1A
 diEZ0OZSc+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZZGlUAAKCRCLPIo+Aiko
 1SgzB/4scjIO/y2psHuNY5d/EHQIZnXizgNLH1YUBDwLJsUZqNP09yiAe6nfWqnkxLO066rEiLP
 WOYHikm5RqbTuJxSUFJBMojUt1JJ/1dnDyD96ukr2Si8KVY4qtcIRgi9whCuZ48Rx5ismof/MyS
 BmzzSyn6Xr6PJLzIvlACfswp9kuCW+m0PaHNxUk3eFrEK2TeIkw2IJ0kZ++mKS9uBIdLCIT5QmX
 XvwHwgeAEuOSOBbpWV2+zzitwPAa3Ymy98XT97KiC8mHxwynwemjQr+1urNC8XwUIJCVCZuUN5Q
 fdKktIyhdU40Fjo709jORg8B4frgnabVD76QjVdfq4W2cvJD
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Currently cpu_sybsys devices support only ACPI style matching.
Pass DT node pointer to cpu_device_create to support OF style matching
for cpu_subsys devices.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/base/cacheinfo.c |  6 ++++--
 drivers/base/cpu.c       | 15 ++++++++++++---
 include/linux/cpu.h      |  3 ++-
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index f1e79263fe61..a72c69e70fa3 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -845,7 +845,7 @@ static int cpu_cache_sysfs_init(unsigned int cpu)
 	if (per_cpu_cacheinfo(cpu) == NULL)
 		return -ENOENT;
 
-	per_cpu_cache_dev(cpu) = cpu_device_create(dev, NULL, NULL, "cache");
+	per_cpu_cache_dev(cpu) = cpu_device_create(dev, NULL, NULL, NULL, "cache");
 	if (IS_ERR(per_cpu_cache_dev(cpu)))
 		return PTR_ERR(per_cpu_cache_dev(cpu));
 
@@ -882,7 +882,9 @@ static int cache_add_dev(unsigned int cpu)
 		if (this_leaf->type == CACHE_TYPE_NOCACHE)
 			break;
 		cache_groups = cache_get_attribute_groups(this_leaf);
-		ci_dev = cpu_device_create(parent, this_leaf, cache_groups,
+		ci_dev = cpu_device_create(parent, this_leaf,
+					   NULL,
+					   cache_groups,
 					   "index%1u", i);
 		if (IS_ERR(ci_dev)) {
 			rc = PTR_ERR(ci_dev);
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 47de0f140ba6..d7db38fbfc17 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -16,6 +16,7 @@
 #include <linux/percpu.h>
 #include <linux/acpi.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/cpufeature.h>
 #include <linux/tick.h>
 #include <linux/pm_qos.h>
@@ -28,7 +29,11 @@ static DEFINE_PER_CPU(struct device *, cpu_sys_devices);
 
 static int cpu_subsys_match(struct device *dev, struct device_driver *drv)
 {
-	/* ACPI style match is the only one that may succeed. */
+	/* Attempt an OF style match first */
+	if (of_driver_match_device(dev, drv))
+		return 1;
+
+	/* Then try ACPI style match */
 	if (acpi_driver_match_device(dev, drv))
 		return 1;
 
@@ -428,12 +433,14 @@ EXPORT_SYMBOL_GPL(get_cpu_device);
 
 static void device_create_release(struct device *dev)
 {
+	of_node_put(dev->of_node);
 	kfree(dev);
 }
 
-__printf(4, 0)
+__printf(5, 0)
 static struct device *
 __cpu_device_create(struct device *parent, void *drvdata,
+		    struct device_node *np,
 		    const struct attribute_group **groups,
 		    const char *fmt, va_list args)
 {
@@ -447,6 +454,7 @@ __cpu_device_create(struct device *parent, void *drvdata,
 	device_initialize(dev);
 	dev->parent = parent;
 	dev->groups = groups;
+	dev->of_node = of_node_get(np);
 	dev->release = device_create_release;
 	device_set_pm_not_required(dev);
 	dev_set_drvdata(dev, drvdata);
@@ -467,6 +475,7 @@ __cpu_device_create(struct device *parent, void *drvdata,
 }
 
 struct device *cpu_device_create(struct device *parent, void *drvdata,
+				 struct device_node *np,
 				 const struct attribute_group **groups,
 				 const char *fmt, ...)
 {
@@ -474,7 +483,7 @@ struct device *cpu_device_create(struct device *parent, void *drvdata,
 	struct device *dev;
 
 	va_start(vargs, fmt);
-	dev = __cpu_device_create(parent, drvdata, groups, fmt, vargs);
+	dev = __cpu_device_create(parent, drvdata, np, groups, fmt, vargs);
 	va_end(vargs);
 	return dev;
 }
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index dcb89c987164..6ae291080e4a 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -76,8 +76,9 @@ extern ssize_t cpu_show_spec_rstack_overflow(struct device *dev,
 extern ssize_t cpu_show_gds(struct device *dev,
 			    struct device_attribute *attr, char *buf);
 
-extern __printf(4, 5)
+extern __printf(5, 6)
 struct device *cpu_device_create(struct device *parent, void *drvdata,
+				 struct device_node *np,
 				 const struct attribute_group **groups,
 				 const char *fmt, ...);
 extern bool arch_cpu_is_hotpluggable(int cpu);

-- 
2.39.2


