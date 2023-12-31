Return-Path: <linux-kernel+bounces-13716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39636820B8F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 15:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C40281CE1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 14:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E13F5665;
	Sun, 31 Dec 2023 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdkIfiNz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03606111;
	Sun, 31 Dec 2023 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50e80d40a41so5547216e87.1;
        Sun, 31 Dec 2023 06:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704033981; x=1704638781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6xXtdhzR13AqgwzRTbRH3ECBNsx9B40/m1NY2XuLVU=;
        b=JdkIfiNzmKtWMSV4QJhmvskZs6xHlR12gBwvBHjH1VYZe39OqCWKLDr+RFoTTYsrzC
         Q8/WSaRTnnauBDCrx8+FrmzuOPbbo+YIQe8KfAGmM/Bvn4byfo5E4zzMKtAkgF9LjivV
         2J/DYqSwKfW8FSmfy0fZ5tpfFrnV/g0Z5noz8m8AlOd/Us3KndXj5S4QVRyBYDD/h8Ug
         wh9vnMTZoHpZtrvpJ3fi7PgdPkdqV+pzB6Y1vijjXK30saOJ8SiTK3DDSYeXheeGgyIi
         2B7u45BQ4OtkDYe3R2esbQD4NgveAfWEd9ENo3sV8nHSnuWPFLX5IcHEALhKvyT6IN/Q
         D/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704033981; x=1704638781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6xXtdhzR13AqgwzRTbRH3ECBNsx9B40/m1NY2XuLVU=;
        b=PbqKpQVHxBJPVlxVSfvbAGChkUvDGzin8kr+F4Ualyab8YXcnExdDVqkkAnDzxUiNR
         PBueJSpfkDDyS+Og6ccHi2xhBSFeFgaCY36gAZscK3XYXfjIrYQBKPURqzjipEUKbUQc
         0uh/Hc3SzjygF95e4LRWvPIkosFDMrhOHz8E8ZaQrq+PRzhE+rjeiewsJEmcHEopswcW
         tOgUyWg7XQYnACJaeCOR+rSAE0mRyiPTYzMrXpJCgYtOs3RelNwz/fYI3rcbgsM5U2zt
         4G8hd2iLizK5wZvspuRlaspdQqwxmqbgRLKH6/DvMTS3tYUFvR3rBAu7+mj8PRBKRAwY
         jVoQ==
X-Gm-Message-State: AOJu0YxgEsrv5kamSyzYWMNwCgB7Wr0cx49fuTkck8VYJ3Dtr4I0qnjB
	xFteSlLsRqxz++e76PHL1umZxfZiZohwig==
X-Google-Smtp-Source: AGHT+IGctHziCTghFxKTI0rdDq3db3QfHNVX8TyjMrYD+wsWHfist1zmdgPIRppsXU+ggFK3FN2uFQ==
X-Received: by 2002:ac2:5fe8:0:b0:50e:2551:c8ce with SMTP id s8-20020ac25fe8000000b0050e2551c8cemr6164790lfg.119.1704033981392;
        Sun, 31 Dec 2023 06:46:21 -0800 (PST)
Received: from skhimich.dev.yadro.com ([185.15.172.210])
        by smtp.gmail.com with ESMTPSA id l9-20020ac24a89000000b0050e7ec49881sm1854423lfp.21.2023.12.31.06.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 06:46:21 -0800 (PST)
From: Sergey Khimich <serghox@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Jyan Chou <jyanchou@realtek.com>
Subject: [PATCH v5 1/2] mmc: cqhci: Add cqhci set_tran_desc() callback
Date: Sun, 31 Dec 2023 17:46:18 +0300
Message-Id: <20231231144619.758290-2-serghox@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231231144619.758290-1-serghox@gmail.com>
References: <20231231144619.758290-1-serghox@gmail.com>
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


