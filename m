Return-Path: <linux-kernel+bounces-103369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE2587BEA6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C184B21476
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E676FE31;
	Thu, 14 Mar 2024 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSSLw3v7"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50156FE02;
	Thu, 14 Mar 2024 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425687; cv=none; b=IniYqzwrpJLdjg1orfLd1ZPpfAy/v+BG91A4cdu0JEQFNV1Ugx9Z6MFqFqh/zHwUvIRINBv7HLiCLY7Out7P9HQd942Qevkyi8+71Vi4vW3uoMCLq/G9zmd8XUNH48I9ODPKaNSOIjmp4wM1W2MpJgoZGeMf0qLcFUgSbSLdoh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425687; c=relaxed/simple;
	bh=eZ7+YWRuTJS+M+Tbb32Zj+n4QjgQnXl0BfWwdXSaSiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qM4IaCBs+RTls8NWjl9twDa1FAQH/OYT6lkZtv26INTh+hK0f1yXYtE+lxUhOqp8hX0eflZsOhmLthDBRIde3fw+uK4xSt01lYYhT6sK+hD7Oj+gKKUJmD1mhdftiv5MtnXXD+pIQMQmvsJCzlHe7PAqbWrTIquY1+aIseHdrqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSSLw3v7; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5139d80f8b6so1286380e87.1;
        Thu, 14 Mar 2024 07:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710425683; x=1711030483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RI1qGz8CIIXyUXChOvLqXgzJKN1FSHM3UtHTCtJhJhY=;
        b=WSSLw3v7ZytmikMXUHOSK//6yico4F7EqonJwFaU57O6+O+U1d0E6e7BeECIM6vIhi
         2968QWdpT7k8wTUSBUaJrvf/0wdT5g1YDBhg293dUrcDW3RarBHQVtzIxqFZh3glYbuw
         TzJ5/CV5S6RNzn256YwMledUV4xkmBhz74U4iOR8ITqP25GMebTOnXRcEHDKMP9SizPp
         4fiAcvsOlwGAM4pdJv3WQiU5eRWwq3XSwMOeUhCcMppvMMeEWew2VskirV9rJn3qHE3L
         LioHm/ugUvBscbeXLOWecvuhkmiEMP+SzobD8XKmQ0GwJfBf14YxDzDW9mvuzLpL5jk+
         JcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710425683; x=1711030483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RI1qGz8CIIXyUXChOvLqXgzJKN1FSHM3UtHTCtJhJhY=;
        b=IrjwT1mPADQ+m2zm+uT+LJHsy+P86W+6Mhigu2vVSS6IHZKasfKvCIktMC2OOEfHX4
         ZTrX8AcB+/4pGli7o/LVw9ll/yzW6R1NhVbQjN/1tOkD1aNj70U7Szylt9tpG3fq8y6c
         lYiRcK/rRz66/DuXdS70+tWaxZ1OqbAqsmPtbqShVQDLdDP1WrmKaTwNHknTYXVUOFFR
         KJ2YXEyfPS+8lohYbzk2kKpTYkqIOQVDzK4iSNbjL1y0YBv9onkYsI54CH2eRHeLke+J
         h3tTnRgOE9nz9UNmYq6oANgn7G+s5NGt7i0aGvhs8w6YAcMjw2jqL8TblxzHiW0I3E+7
         jaqA==
X-Gm-Message-State: AOJu0YxX3zlHYbJqie+TL4sxWOqKrczG/l//3q1RBjX+EUYGiJDMl2XT
	mvGHj8ib+zYL+9tsooyH4Kiqm9olM6y5LVwXeF9jjdpafGgHWwMscb1wAe+DOog=
X-Google-Smtp-Source: AGHT+IFIob1Z7MNOWoU2QITak92Fg2FZ3n2AJ2V77murgg98b0MdD2a1Vh2SP7HNHgnn1M6WVUi3PA==
X-Received: by 2002:a19:5e59:0:b0:513:b062:98c4 with SMTP id z25-20020a195e59000000b00513b06298c4mr192188lfi.11.1710425683060;
        Thu, 14 Mar 2024 07:14:43 -0700 (PDT)
Received: from skhimich.dev.yadro.com (avpn01.yadro.com. [89.207.88.243])
        by smtp.gmail.com with ESMTPSA id a19-20020ac25e73000000b005135bd71d6fsm286538lfr.276.2024.03.14.07.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 07:14:42 -0700 (PDT)
From: Sergey Khimich <serghox@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Jyan Chou <jyanchou@realtek.com>
Subject: [PATCH v6 1/2] mmc: cqhci: Add cqhci set_tran_desc() callback
Date: Thu, 14 Mar 2024 17:14:39 +0300
Message-Id: <20240314141440.3305802-2-serghox@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240314141440.3305802-1-serghox@gmail.com>
References: <20240314141440.3305802-1-serghox@gmail.com>
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


