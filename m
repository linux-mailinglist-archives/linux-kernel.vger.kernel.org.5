Return-Path: <linux-kernel+bounces-107489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D7287FD3C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0555D1C21D7D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215397F7C2;
	Tue, 19 Mar 2024 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxyahYLK"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B017F478;
	Tue, 19 Mar 2024 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710849579; cv=none; b=uy+ZUTirlkEs1NdBEjouSBDyhYCiMZ3AvgCgtfc8YG9qLaH68CObL+J4HQhqc62ftpVTYSr7u7SbX/rJLMC/6O2yTU6Hk5YtIeuaGo0aQ5GPZtr1oqr3rnZduPvW3YmxoTj8o77oaxSIaY4x55Lf4VFvkTMTzaCUKoaqwzPEEjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710849579; c=relaxed/simple;
	bh=eZ7+YWRuTJS+M+Tbb32Zj+n4QjgQnXl0BfWwdXSaSiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eNaBHxTS0KCEjjgDUj7rm4Y12cB/bjcgbl/IVTY2fhe8ltuVG4p8hDtm7cXzW8WKQsDgKLY3MeaLRbqfiaaM6YSD23o4TwMypVSPPHrSiX61RJjIvsEWWE/cakSuisiQWJ+2CFWp2ZaTOJJ4J4xUbeNVF+B0OhTMdOF2HQuVCh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxyahYLK; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-513da1c1f26so6266227e87.3;
        Tue, 19 Mar 2024 04:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710849575; x=1711454375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RI1qGz8CIIXyUXChOvLqXgzJKN1FSHM3UtHTCtJhJhY=;
        b=AxyahYLKAxzqycXoKfcdfceihyDss5thPIWavMSTsOCZSLUWgVGkAP86VP5JxZI0LB
         6FUr3SEtEYNuYwy0YHF6CJR2F8NVCqzUS+gvWWvDuAaiIQ0DkDDEMnCxCt9JeusV/DxE
         2Vdkkws/b5UqtWzm+l8Wmi8OzfSqquGaK/ej1QqsQDd3UQEKFwMG0EdWsE1ZbcNG2RUc
         hPHIfGEG5WIcu++glYGfTQZa650OZL52QUoakVb/4V20v3ZM/oO3Tm8bIeMYN5J//C97
         F+H3IhBYuLYewszKk3jVSu+AlhOKSwpEbVWPrmTPDSDlkdJMzwBe0B8e4yyZ7k056ZLS
         e+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710849575; x=1711454375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RI1qGz8CIIXyUXChOvLqXgzJKN1FSHM3UtHTCtJhJhY=;
        b=j+QGPsZo+HT8P1IiVZ3AfJQ+eSzo2lFSt+QmrHyk6F7i13wm9qGm+CXV7OAJoCeOAc
         Pvoolvr3fvM3MOKubhqRZlQH3FLrt+FxTtGM/qKLu2+GV+9aL8p74kzalkoqyJy5K0ug
         YoWy5GvBcz5X2u5RB4+l2sWJGJmN91JUc/Kd9mjYyV85gjX24a9YI1ELpam0U0/edeKo
         go1f0V/bJyVmSyg+djB5t/JgCO3EmrOh3eRz19JkJ53xiQ8Y9JebopkoXI3DGDEMxwqN
         /FqXGUmHl69jVXJ5tyZRrAgEy4dcfubtssd+uRcaS6ZMLn9fGqaqbN8/MKX3HGX1wVZv
         +Igg==
X-Gm-Message-State: AOJu0Yz9u8PHhX0HGRkshRtRlmW7fDCipl9bbevs20SGpJ0ortR6YhIg
	75q6XkEnsZQevDJh3v86uzWwaIwZQLWVZ4i7ZymdalsBLiUCCzTqgM9CYABuzu4=
X-Google-Smtp-Source: AGHT+IH3aYI5oGqyB2XgE9DydyiTRKx+Y2yKyifpbuO4wzHv4f4LQTozvG6sgUKXSbOC2pVZV8y2JA==
X-Received: by 2002:a19:8c55:0:b0:513:a1eb:c084 with SMTP id i21-20020a198c55000000b00513a1ebc084mr8865785lfj.7.1710849575314;
        Tue, 19 Mar 2024 04:59:35 -0700 (PDT)
Received: from skhimich.dev.yadro.com (avpn01.yadro.com. [89.207.88.243])
        by smtp.gmail.com with ESMTPSA id d11-20020a056512368b00b00513a53acdd4sm1915198lfs.104.2024.03.19.04.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 04:59:34 -0700 (PDT)
From: Sergey Khimich <serghox@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Jyan Chou <jyanchou@realtek.com>,
	Asutosh Das <quic_asutoshd@quicinc.com>,
	Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v7 1/2] mmc: cqhci: Add cqhci set_tran_desc() callback
Date: Tue, 19 Mar 2024 14:59:31 +0300
Message-Id: <20240319115932.4108904-2-serghox@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240319115932.4108904-1-serghox@gmail.com>
References: <20240319115932.4108904-1-serghox@gmail.com>
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
 drivers/mmc/host/cqhci-core.c | 11 ++++++++---
 drivers/mmc/host/cqhci.h      |  4 ++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index 41e94cd14109..c14d7251d0bb 100644
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
 
@@ -495,6 +495,7 @@ static void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end,
 		dataddr[0] = cpu_to_le32(addr);
 	}
 }
+EXPORT_SYMBOL(cqhci_set_tran_desc);
 
 static int cqhci_prep_tran_desc(struct mmc_request *mrq,
 			       struct cqhci_host *cq_host, int tag)
@@ -522,7 +523,11 @@ static int cqhci_prep_tran_desc(struct mmc_request *mrq,
 
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
index 1a12e40a02e6..fab9d74445ba 100644
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -293,6 +293,9 @@ struct cqhci_host_ops {
 	int (*program_key)(struct cqhci_host *cq_host,
 			   const union cqhci_crypto_cfg_entry *cfg, int slot);
 #endif
+	void (*set_tran_desc)(struct cqhci_host *cq_host, u8 **desc,
+			      dma_addr_t addr, int len, bool end, bool dma64);
+
 };
 
 static inline void cqhci_writel(struct cqhci_host *host, u32 val, int reg)
@@ -318,6 +321,7 @@ irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error,
 int cqhci_init(struct cqhci_host *cq_host, struct mmc_host *mmc, bool dma64);
 struct cqhci_host *cqhci_pltfm_init(struct platform_device *pdev);
 int cqhci_deactivate(struct mmc_host *mmc);
+void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end, bool dma64);
 static inline int cqhci_suspend(struct mmc_host *mmc)
 {
 	return cqhci_deactivate(mmc);
-- 
2.30.2


