Return-Path: <linux-kernel+bounces-810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF90814690
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7DCA1F240F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CF324B4A;
	Fri, 15 Dec 2023 11:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YcPhxab1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BEC249EF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3332efd75c9so380053f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702638947; x=1703243747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kRMoHIJRTtXNIICxC1qtJW1lyGXSE9y4s5yX7QFSi0=;
        b=YcPhxab1bY3rO8GOQWW52qWcvhcLimuPehgVGkYn6myjAXkHNRwhLVCMyaUfa4MMV3
         /U05CRLTQKO8TJ7ED3dKKJ5cgckzQ5CSSOZJysQhB36n4UhjoHn6Q1tzKkQ1G3MOI0ab
         +V+DLsJoaLXmumI3BYO8asM1OQTWmxbswlfRTiaXufcPEC0ZB2C3PFfx1L8/2nbhaQwg
         nayqLYXxfjcj6xXRNrNrlwraCRhlyRP9I1Gf3cVtUUFRBMvHhX3wwrwvycP8sDcnXMaj
         lj6IPtuU2ZbFyu7Q4f1uBD+gRTNthHL/wLD5Wy7XfWq1bAOk03EtS5W37HbcvayobsC8
         mCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702638947; x=1703243747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kRMoHIJRTtXNIICxC1qtJW1lyGXSE9y4s5yX7QFSi0=;
        b=AQCXiQXmkFueHIRLyWQkwtkirJo1QEDoGejhKPlRbTYsPgpU8Xq50MYVzjg/5VTvFA
         oGtsov1g6UpjNFVhNGtS2cM43fXZ9rwvOOb4EWwK0W7GAGm23+TvwAJb3/DQDgAt2SiD
         CpMUCxY4WB+t71KwBC+pLCugrqVPhE+F8hQKxwNFS1n9ETkVEbbgIVj9D6lOm7MKPb4N
         SXvhaB/qq92Jbo8NS1qaLblQF15VYK7HSd91NoXOB57pXfz4r1PXZjQEYKbu+2HTSh2p
         okQVSy0oNZ4BgSpd3DDIjpt3fMXVHdxWrDPS9Gf2alldfpMD2I7XAYIlwSNsC+wG8TzK
         uL6g==
X-Gm-Message-State: AOJu0YwzYsc1BwsRuWGdJ6KqIleJ7oFjJO7QbtvuDPi7DDDWSNvswqGw
	wQjUGbvulfz/9A+bcFTJRaq3Tw==
X-Google-Smtp-Source: AGHT+IGvp0sgifCyz+Hk70iMVxwgYchRh/UKLVec3MnA6QDQyZVlTj1XYAr/LfKEjMiD225qOJAerQ==
X-Received: by 2002:a05:6000:4c8:b0:333:3a38:d568 with SMTP id h8-20020a05600004c800b003333a38d568mr3207085wri.184.1702638946946;
        Fri, 15 Dec 2023 03:15:46 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g13-20020a056000118d00b003333d46a9e8sm18511497wrx.56.2023.12.15.03.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 03:15:46 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 01/10] of: device: Export of_device_make_bus_id()
Date: Fri, 15 Dec 2023 11:15:27 +0000
Message-Id: <20231215111536.316972-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215111536.316972-1-srinivas.kandagatla@linaro.org>
References: <20231215111536.316972-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5096; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=U8/4jDIV+uERRA2Pjp9VTOhw2zC2Bzr+MXKEeB2u73A=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBlfDVXCF2GhBRHA5Vqce6mlIYurB1cC08KtWvIy qgDLK160HSJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZXw1VwAKCRB6of1ZxzRV NwFlB/4j/xNoIXxFotBnVor1mDKYmPu9ZiJrnJ0RNKm+RBA+xURJXA9vgzS21EL1fYWuB4MzujX ibsBD2oFXTiZKymnxtat33khQAXKms86nme5vMKpFkMxpu/Yk7LUMoLa9Ax+Pf9jOsMwv0iwPfA /B99P8W4UcQ41xVO0JZSja6zbM+zc57rTMV3Pt8EXNpGo6mdugPXraHZWzOyiCD5mfDeOoUntq7 c5s6Tk4UhPD1BEno2Cbi7tfQimWvwGSdpSHkrOBt/rj1rpgwfhYNE+Y624IgKS3L+cDS8b3CCau L1Gw2JvRWm7Gdf7NxC93q04rS+Wdj73O72w7sJIIBEBmtl4R
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Miquel Raynal <miquel.raynal@bootlin.com>

This helper is really handy to create unique device names based on their
device tree path, we may need it outside of the OF core (in the NVMEM
subsystem) so let's export it. As this helper has nothing patform
specific, let's move it to of/device.c instead of of/platform.c so we
can add its prototype to of_device.h.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/of/device.c       | 41 +++++++++++++++++++++++++++++++++++++++
 drivers/of/platform.c     | 40 --------------------------------------
 include/linux/of_device.h |  6 ++++++
 3 files changed, 47 insertions(+), 40 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 1ca42ad9dd15..6e9572c4af83 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -304,3 +304,44 @@ int of_device_uevent_modalias(const struct device *dev, struct kobj_uevent_env *
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_device_uevent_modalias);
+
+/**
+ * of_device_make_bus_id - Use the device node data to assign a unique name
+ * @dev: pointer to device structure that is linked to a device tree node
+ *
+ * This routine will first try using the translated bus address to
+ * derive a unique name. If it cannot, then it will prepend names from
+ * parent nodes until a unique name can be derived.
+ */
+void of_device_make_bus_id(struct device *dev)
+{
+	struct device_node *node = dev->of_node;
+	const __be32 *reg;
+	u64 addr;
+	u32 mask;
+
+	/* Construct the name, using parent nodes if necessary to ensure uniqueness */
+	while (node->parent) {
+		/*
+		 * If the address can be translated, then that is as much
+		 * uniqueness as we need. Make it the first component and return
+		 */
+		reg = of_get_property(node, "reg", NULL);
+		if (reg && (addr = of_translate_address(node, reg)) != OF_BAD_ADDR) {
+			if (!of_property_read_u32(node, "mask", &mask))
+				dev_set_name(dev, dev_name(dev) ? "%llx.%x.%pOFn:%s" : "%llx.%x.%pOFn",
+					     addr, ffs(mask) - 1, node, dev_name(dev));
+
+			else
+				dev_set_name(dev, dev_name(dev) ? "%llx.%pOFn:%s" : "%llx.%pOFn",
+					     addr, node, dev_name(dev));
+			return;
+		}
+
+		/* format arguments only used if dev_name() resolves to NULL */
+		dev_set_name(dev, dev_name(dev) ? "%s:%s" : "%s",
+			     kbasename(node->full_name), dev_name(dev));
+		node = node->parent;
+	}
+}
+EXPORT_SYMBOL_GPL(of_device_make_bus_id);
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 126d265aa7d8..c39e49a1eba0 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -97,46 +97,6 @@ static const struct of_device_id of_skipped_node_table[] = {
  * mechanism for creating devices from device tree nodes.
  */
 
-/**
- * of_device_make_bus_id - Use the device node data to assign a unique name
- * @dev: pointer to device structure that is linked to a device tree node
- *
- * This routine will first try using the translated bus address to
- * derive a unique name. If it cannot, then it will prepend names from
- * parent nodes until a unique name can be derived.
- */
-static void of_device_make_bus_id(struct device *dev)
-{
-	struct device_node *node = dev->of_node;
-	const __be32 *reg;
-	u64 addr;
-	u32 mask;
-
-	/* Construct the name, using parent nodes if necessary to ensure uniqueness */
-	while (node->parent) {
-		/*
-		 * If the address can be translated, then that is as much
-		 * uniqueness as we need. Make it the first component and return
-		 */
-		reg = of_get_property(node, "reg", NULL);
-		if (reg && (addr = of_translate_address(node, reg)) != OF_BAD_ADDR) {
-			if (!of_property_read_u32(node, "mask", &mask))
-				dev_set_name(dev, dev_name(dev) ? "%llx.%x.%pOFn:%s" : "%llx.%x.%pOFn",
-					     addr, ffs(mask) - 1, node, dev_name(dev));
-
-			else
-				dev_set_name(dev, dev_name(dev) ? "%llx.%pOFn:%s" : "%llx.%pOFn",
-					     addr, node, dev_name(dev));
-			return;
-		}
-
-		/* format arguments only used if dev_name() resolves to NULL */
-		dev_set_name(dev, dev_name(dev) ? "%s:%s" : "%s",
-			     kbasename(node->full_name), dev_name(dev));
-		node = node->parent;
-	}
-}
-
 /**
  * of_device_alloc - Allocate and initialize an of_device
  * @np: device node to assign to device
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 2c7a3d4bc775..a72661e47faa 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -40,6 +40,9 @@ static inline int of_dma_configure(struct device *dev,
 {
 	return of_dma_configure_id(dev, np, force_dma, NULL);
 }
+
+void of_device_make_bus_id(struct device *dev);
+
 #else /* CONFIG_OF */
 
 static inline int of_driver_match_device(struct device *dev,
@@ -82,6 +85,9 @@ static inline int of_dma_configure(struct device *dev,
 {
 	return 0;
 }
+
+static inline void of_device_make_bus_id(struct device *dev) {}
+
 #endif /* CONFIG_OF */
 
 #endif /* _LINUX_OF_DEVICE_H */
-- 
2.25.1


