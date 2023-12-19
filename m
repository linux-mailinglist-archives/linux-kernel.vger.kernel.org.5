Return-Path: <linux-kernel+bounces-5134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 755B68186DF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3CAA1F214C8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2911B27A;
	Tue, 19 Dec 2023 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPucfGVz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188991A72B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40c60dfa5bfso53215015e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702987283; x=1703592083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7yEMgXZhKtlt+r30N1IJsOJuMAaTYKKq9iU4tTYh4A=;
        b=VPucfGVzYJDft5Ds3mcmWqUZ4/9Hq5QAnzWFf9EhLHe9qdIZOQ9E9mQpQwrLBQMOS8
         gQuCy2W1Xylhp/4uLmsK4Ear7uaIuoO/xQuO1RswWTtRZnNS/T6vr1sBoOzGQjA86o6v
         bidbS5AiIHeqh2UDpQZ+w6ocC93tn+K6LkUzrZE6IxQmaH2Up7WcPRYCsJlGMAODPi6p
         UtMzML9kbPe/QYZc46HqtfkxGq86fdZjPfHm6H7/D8/Qiw7nPGv+61/9Tk9FyBEZG5Oj
         piqB5ScaPI8CHZcQczLmD+6HKB2ZATRfAbgLoWhx9GAQkrCNPu05i43rq/289xzvxE7n
         VgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702987283; x=1703592083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7yEMgXZhKtlt+r30N1IJsOJuMAaTYKKq9iU4tTYh4A=;
        b=LoNRsMAt4eCxpq4lOcRwg/4hyNBj0Rgbddj5uw54KcQ8jI80kBKpAkECYR0utS9J/l
         AqZls0+esjxlD89N8FbL7HZvE1tK+tuXLDVywFFGgYFOxmJAh3W1fGvnpuU85NMHmygr
         h19KoONlfWYocOzGmhJT4Ath2mWxSvXw0TGw1Z02cU0WXFRDvq059OhljfmPXITXepUZ
         Km0zhBsVkkCtg8XcHwO/ecZM2LO7owkuAi8MUyTpUKxbJ494p7NNYEP/pzPE7GhAAFd/
         msPvfVuxg5aAcNwyEQ12t7SKxnyHbVqy0eF8WWCH6LMJznEL2t8F/Q7qgF4vWv9eMl6E
         PFHA==
X-Gm-Message-State: AOJu0YxzXAh2zzk8TyqPTlzg8bvHTxoxRwtsDIuRCI/02sP81mbPcP2G
	3dPLAElY5TWJqH5IUxvuFSo=
X-Google-Smtp-Source: AGHT+IFacrsz/WxyyAmEwuqg1BB6bNHm96HPr0zlPC74PGs1gxTM16a3p4tpZQe9CQsLj/7ekjHxXA==
X-Received: by 2002:a05:600c:d4:b0:40b:5e59:c55b with SMTP id u20-20020a05600c00d400b0040b5e59c55bmr9283867wmm.133.1702987283001;
        Tue, 19 Dec 2023 04:01:23 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id ux4-20020a170907cf8400b00a230f3799a4sm6767478ejc.225.2023.12.19.04.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 04:01:22 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Walle <michael@walle.cc>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH v6.8 2/2] nvmem: drop nvmem_layout_get_match_data()
Date: Tue, 19 Dec 2023 13:01:04 +0100
Message-Id: <20231219120104.3422-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231219120104.3422-1-zajec5@gmail.com>
References: <20231219120104.3422-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Thanks for layouts refactoring we now have "struct device" associated
with layout. Also its OF pointer points directly to the "nvmem-layout"
DT node.

All it takes to get match data is a generic of_device_get_match_data().

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/nvmem/core.c           | 13 -------------
 include/linux/nvmem-provider.h | 10 ----------
 2 files changed, 23 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 441d132ebb61..4ed54076346d 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -876,19 +876,6 @@ void nvmem_layout_unregister(struct nvmem_layout *layout)
 }
 EXPORT_SYMBOL_GPL(nvmem_layout_unregister);
 
-const void *nvmem_layout_get_match_data(struct nvmem_device *nvmem,
-					struct nvmem_layout *layout)
-{
-	struct device_node __maybe_unused *layout_np;
-	const struct of_device_id *match;
-
-	layout_np = of_nvmem_layout_get_container(nvmem);
-	match = of_match_node(layout->dev.driver->of_match_table, layout_np);
-
-	return match ? match->data : NULL;
-}
-EXPORT_SYMBOL_GPL(nvmem_layout_get_match_data);
-
 /**
  * nvmem_register() - Register a nvmem device for given nvmem_config.
  * Also creates a binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 81a67642ac55..f0ba0e03218f 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -205,9 +205,6 @@ void nvmem_layout_driver_unregister(struct nvmem_layout_driver *drv);
 	module_driver(__nvmem_layout_driver, nvmem_layout_driver_register, \
 		      nvmem_layout_driver_unregister)
 
-const void *nvmem_layout_get_match_data(struct nvmem_device *nvmem,
-					struct nvmem_layout *layout);
-
 #else
 
 static inline struct nvmem_device *nvmem_register(const struct nvmem_config *c)
@@ -238,13 +235,6 @@ static inline int nvmem_layout_register(struct nvmem_layout *layout)
 
 static inline void nvmem_layout_unregister(struct nvmem_layout *layout) {}
 
-static inline const void *
-nvmem_layout_get_match_data(struct nvmem_device *nvmem,
-			    struct nvmem_layout *layout)
-{
-	return NULL;
-}
-
 #endif /* CONFIG_NVMEM */
 
 #if IS_ENABLED(CONFIG_NVMEM) && IS_ENABLED(CONFIG_OF)
-- 
2.35.3


