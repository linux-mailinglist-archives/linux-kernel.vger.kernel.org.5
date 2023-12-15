Return-Path: <linux-kernel+bounces-811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3852F814691
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C5DFB2375F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD98D250EF;
	Fri, 15 Dec 2023 11:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="daznrApv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A7224A08
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-336420a244dso384273f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702638948; x=1703243748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3wqcftJe3oQSGEVWIPzNX4f98nIVyBhsOjYp0bmWsA=;
        b=daznrApvU/99RFpf2BiLBAbAY+AREMvYVXsktTBaO84wEaOK42OiLb/2lyHVwDrwNE
         H16KXtMhZqf7didgKUSiZJIXREeFgZU1Wd20czDA1I9vf0zHXC+Ais+2zs+W5DPksvAm
         eVMRPyJMin8fNPyaAGJE8mwPQ92gkEewyjl3he4BKjrBixVCiS2PSH6dsQv7+DTnUWgP
         tnpDvrp6WODP7mU7SlvIuEr5FD2HY2+gz8j6J/Er4Kd+d2PQgtM9y2qOAt5knHEuKBiF
         HmT8LPJPJfkMxmx2wn5Oydx1oi3e3ngMYompm1F54uCoCSkm4OEo71g02Q0D0nnrW69N
         1fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702638948; x=1703243748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3wqcftJe3oQSGEVWIPzNX4f98nIVyBhsOjYp0bmWsA=;
        b=lv5j1ahWdIbWJ8y9xJcNr2ehLqfORU2rnrzJ6BG2s/fX8zSzPGZ0/7KGGDWTFR16Nv
         wUgEHsO+z7lvl7JCWyNhELuuWXRT2bovpGeyTA0Ce+AlTy/AQ05YvbwJ4FMKd0dVnNf7
         ma0XOFun3QGIslfjG/eMJRTN+1FL9myQ2+QGq9uqtrddfi2de9C5Im0uRKrdTS2l9J8K
         tyDfPwGMgR9EUH/JNeRJD1VIu+YAN7vg31FHMMA4xYFTlFKV1udmwHAGwDKNs2cUQRpt
         m/mgSkwGZzWAF/6YR0s3pkhxq24qiSYEIjHL49oq6fJFukcJjVwp1IFLhM3MF2xgCFfW
         A3jw==
X-Gm-Message-State: AOJu0YzXdYGHE6W3D7L4xAnwZOCNlDAdPEiOgyEYvsRgMz6EmmVSmaoY
	Tj2t7h7WnciKGg7/mpE7dLaH/Q==
X-Google-Smtp-Source: AGHT+IGO+5ZWVSXtpxtnkDfhkW8kSqeviOSB4kYHDAVdjTUAkU4tSDDj5CrrkiNq2+026yJf9XVyIw==
X-Received: by 2002:adf:fc46:0:b0:336:4c4b:d702 with SMTP id e6-20020adffc46000000b003364c4bd702mr1000761wrs.117.1702638947761;
        Fri, 15 Dec 2023 03:15:47 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g13-20020a056000118d00b003333d46a9e8sm18511497wrx.56.2023.12.15.03.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 03:15:47 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 02/10] nvmem: Move of_nvmem_layout_get_container() in another header
Date: Fri, 15 Dec 2023 11:15:28 +0000
Message-Id: <20231215111536.316972-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215111536.316972-1-srinivas.kandagatla@linaro.org>
References: <20231215111536.316972-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3451; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=IeHRu31C5pTVzTrxF1sImdme6q++k9V3VWhgQK6Fu00=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBlfDVX4w/9/C2iAEwJzuHX73JYOK4isekL678re sVRq8ZfhYKJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZXw1VwAKCRB6of1ZxzRV N4HNB/0Q044LJGF6ZBJnoPZ2mzx2v03HbI2RALPuBjoWSsfGXwDzBIbIiuIlp10N9HyRMM/ITEU gmSkpPXY3V9EMvPuMK2NPKv0IMU5qChaPyMAPxxTE06WjkCDvgTjPEdMSGEjz1P83pSQD1iJgh2 ybu8PaLl/XURNMiiWJMBEbyvEHxuurq7XnDQkLHHEAWR2wEVBpegAxBGboNZ+O1C8kiPbay4/ee Oz3nuteNRfRRLalE1rbQM0UqOV7psMGPb8RqdVDhPEwgJY4ukwgBXbG8yLZivdsChZ4QfMqsnxL gczRh/EfIf/w4Z2R5LOTb1FR40EI/fc1kVlnRmQlj8eiBuee
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Miquel Raynal <miquel.raynal@bootlin.com>

nvmem-consumer.h is included by consumer devices, extracting data from
NVMEM devices whereas nvmem-provider.h is included by devices providing
NVMEM content.

The only users of of_nvmem_layout_get_container() outside of the core
are layout drivers, so better move its prototype to nvmem-provider.h.

While we do so, we also move the kdoc associated with the function to
the header rather than the .c file.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           |  8 --------
 include/linux/nvmem-consumer.h |  7 -------
 include/linux/nvmem-provider.h | 21 +++++++++++++++++++++
 3 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 608b352a7d91..b5b6ec8e04bb 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -847,14 +847,6 @@ static int nvmem_add_cells_from_layout(struct nvmem_device *nvmem)
 }
 
 #if IS_ENABLED(CONFIG_OF)
-/**
- * of_nvmem_layout_get_container() - Get OF node to layout container.
- *
- * @nvmem: nvmem device.
- *
- * Return: a node pointer with refcount incremented or NULL if no
- * container exists. Use of_node_put() on it when done.
- */
 struct device_node *of_nvmem_layout_get_container(struct nvmem_device *nvmem)
 {
 	return of_get_child_by_name(nvmem->dev.of_node, "nvmem-layout");
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 6ec4b9743e25..2d306fa13b1a 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -247,7 +247,6 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 				     const char *id);
 struct nvmem_device *of_nvmem_device_get(struct device_node *np,
 					 const char *name);
-struct device_node *of_nvmem_layout_get_container(struct nvmem_device *nvmem);
 #else
 static inline struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 						   const char *id)
@@ -260,12 +259,6 @@ static inline struct nvmem_device *of_nvmem_device_get(struct device_node *np,
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
-
-static inline struct device_node *
-of_nvmem_layout_get_container(struct nvmem_device *nvmem)
-{
-	return NULL;
-}
 #endif /* CONFIG_NVMEM && CONFIG_OF */
 
 #endif  /* ifndef _LINUX_NVMEM_CONSUMER_H */
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index e3930835235b..e5de21516387 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -244,6 +244,27 @@ nvmem_layout_get_match_data(struct nvmem_device *nvmem,
 
 #endif /* CONFIG_NVMEM */
 
+#if IS_ENABLED(CONFIG_NVMEM) && IS_ENABLED(CONFIG_OF)
+
+/**
+ * of_nvmem_layout_get_container() - Get OF node of layout container
+ *
+ * @nvmem: nvmem device
+ *
+ * Return: a node pointer with refcount incremented or NULL if no
+ * container exists. Use of_node_put() on it when done.
+ */
+struct device_node *of_nvmem_layout_get_container(struct nvmem_device *nvmem);
+
+#else  /* CONFIG_NVMEM && CONFIG_OF */
+
+static inline struct device_node *of_nvmem_layout_get_container(struct nvmem_device *nvmem)
+{
+	return NULL;
+}
+
+#endif /* CONFIG_NVMEM && CONFIG_OF */
+
 #define module_nvmem_layout_driver(__layout_driver)		\
 	module_driver(__layout_driver, nvmem_layout_register,	\
 		      nvmem_layout_unregister)
-- 
2.25.1


