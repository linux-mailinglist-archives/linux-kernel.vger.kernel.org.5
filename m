Return-Path: <linux-kernel+bounces-13043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAFB81FED8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 11:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151611C217B0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE3B11193;
	Fri, 29 Dec 2023 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nmogl9W+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5193110A18;
	Fri, 29 Dec 2023 10:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e7b9cca2fso3840226e87.3;
        Fri, 29 Dec 2023 02:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703844696; x=1704449496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6xXtdhzR13AqgwzRTbRH3ECBNsx9B40/m1NY2XuLVU=;
        b=Nmogl9W+EP1p+Su6iUd44yD7ORfc6V2TijOImpDx2nk1WkdeNfvVVqFny3Qn0avyxX
         FmG+BSOPT0FzJ4Qrw9asm7s9IhwW6DyihSsEL0YXEUng3O6W8nvTnN8URHpwO3yKJbCZ
         aqtj85f58xvESnTu6wPLYAB3N1lT9KvC289WNGjxg6/ivPNj9y8W7Va2n/gxJqq9At9P
         vRLB6EP1zTI9HwPV23Yz7DtzighAqWJ8FMwHpo1LQG9MFktIvKIVeLm2vKcZamMBp9el
         YFXm8kHgYp6WzgYIPMgjDPciRZIa7kYM4XgcQNo0ASeuqfScI/Y8KRLmFBUz384+jMB+
         20sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703844696; x=1704449496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6xXtdhzR13AqgwzRTbRH3ECBNsx9B40/m1NY2XuLVU=;
        b=a4a2UMVHaQcqCV0ZKiPwcbaluve0c7zg8mvYFH6uETY3C+PuCjbKTKfqkDPn5aPFml
         HeDZ2pY/0aKIFnw82qUUcBboMMLPDDSecPC841OD0xUpx6dygeMyzPk154Bq7lqwSddx
         OWwPahriSM5cnBrNMBioI6mVj6g9AGSsLavDtVgR/H49rAIFSOBU02PqsdsPQHz0n6y/
         FVXiFfTdJsP3ZRzi3uIfqDef3w5AeVu1Qvq+YsLE8WNKd6s3fJu/RGRLT3VpbYvU3C9e
         alLQcDqZLrKKmWFgJzvQmU/oWBivV9fRVQm6Mb8F8uWvJA9bsPsQv5+i0eEh7Brot6gA
         hR2w==
X-Gm-Message-State: AOJu0YzD1RxdpkALEEk3iLd/xBeAFqz4efdso13lk7tqZdcFNcvipyOM
	BvVfhOA0Jhra87cEivL29XmaDr/CCAZSJw==
X-Google-Smtp-Source: AGHT+IFyZ2Lh6ELBoANsxkkddDMv6QH/uFEKhBX3kEt6diWTqHVniQXKifJ6dM3b031co4ZmjYfh4g==
X-Received: by 2002:ac2:4ac3:0:b0:50e:3fbc:7c12 with SMTP id m3-20020ac24ac3000000b0050e3fbc7c12mr4606838lfp.126.1703844695873;
        Fri, 29 Dec 2023 02:11:35 -0800 (PST)
Received: from skhimich.dev.yadro.com ([185.15.172.210])
        by smtp.gmail.com with ESMTPSA id a2-20020a19ca02000000b0050e6bf2b452sm2181734lfg.105.2023.12.29.02.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 02:11:35 -0800 (PST)
From: Sergey Khimich <serghox@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Jyan Chou <jyanchou@realtek.com>
Subject: [PATCH v4 1/2] mmc: cqhci: Add cqhci set_tran_desc() callback
Date: Fri, 29 Dec 2023 13:11:27 +0300
Message-Id: <20231229101128.392089-2-serghox@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231229101128.392089-1-serghox@gmail.com>
References: <20231229101128.392089-1-serghox@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Khimich <serghox@gmail.com>

There are could be specific limitations for some mmc
controllers for setting cqhci transfer descriptors.
So add callback to allow implement driver specific function.

Signed-off-by: Sergey Khimich <serghox@gmail.com>
---
 drivers/mmc/host/cqhci-core.c | 10 +++++++---
 drivers/mmc/host/cqhci.h      |  5 +++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index 41e94cd14109..d12870b124cc 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -474,8 +474,8 @@ static int cqhci_dma_map(struct mmc_host *host, struct mmc_request *mrq)
 	return sg_count;
 }
 
-static void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end,
-				bool dma64)
+void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end,
+			 bool dma64)
 {
 	__le32 *attr = (__le32 __force *)desc;
 
@@ -522,7 +522,11 @@ static int cqhci_prep_tran_desc(struct mmc_request *mrq,
 
 		if ((i+1) == sg_count)
 			end = true;
-		cqhci_set_tran_desc(desc, addr, len, end, dma64);
+		if (cq_host->ops->set_tran_desc)
+			cq_host->ops->set_tran_desc(cq_host, &desc, addr, len, end, dma64);
+		else
+			cqhci_set_tran_desc(desc, addr, len, end, dma64);
+
 		desc += cq_host->trans_desc_len;
 	}
 
diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
index 1a12e40a02e6..703d5af6c49e 100644
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -217,6 +217,7 @@ struct cqhci_host_ops;
 struct mmc_host;
 struct mmc_request;
 struct cqhci_slot;
+struct mmc_data;
 
 struct cqhci_host {
 	const struct cqhci_host_ops *ops;
@@ -293,6 +294,9 @@ struct cqhci_host_ops {
 	int (*program_key)(struct cqhci_host *cq_host,
 			   const union cqhci_crypto_cfg_entry *cfg, int slot);
 #endif
+	void (*set_tran_desc)(struct cqhci_host *cq_host, u8 **desc,
+			      dma_addr_t addr, int len, bool end, bool dma64);
+
 };
 
 static inline void cqhci_writel(struct cqhci_host *host, u32 val, int reg)
@@ -318,6 +322,7 @@ irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error,
 int cqhci_init(struct cqhci_host *cq_host, struct mmc_host *mmc, bool dma64);
 struct cqhci_host *cqhci_pltfm_init(struct platform_device *pdev);
 int cqhci_deactivate(struct mmc_host *mmc);
+void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end, bool dma64);
 static inline int cqhci_suspend(struct mmc_host *mmc)
 {
 	return cqhci_deactivate(mmc);
-- 
2.30.2


