Return-Path: <linux-kernel+bounces-150329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B2B8A9D6F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADBA11F2195A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D8D16D31F;
	Thu, 18 Apr 2024 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="1nzocMbI"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44A06FB0;
	Thu, 18 Apr 2024 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451479; cv=none; b=qn3CgkmUfsQoKR2fgcm1Vf4wqGMDk72c3txWWZG+PN/Di2ulrjX1uprj4mjZHiHZiLdoPgEU4JY3PDwzOOh7s8ORtWC0TqBeeYalj6QkrXgeE0E5HLYPVCOm6xBWCMSNWvBQV+mL2lj0bhVD4NNuRHV6MHcWNzWvUJEAVM/VYak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451479; c=relaxed/simple;
	bh=2GS8yFC9cydIAJBVFBAT2fzV5NYDh3bXZCuJ8kcgtq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGLYSqR/vPKIncYhwyPbnnoCF/EzYovf99gDmgCxUuXnARQa4qiLlw5YaEj8pkrVs6GGvwMS2PrATB46oKM3pOsuVK9cColhvlSXjYhNkDIQ2vpFo5yNGUE9PXuE5MesR0cv/Aom1omC6vgwRzOCMlGm6k2J8JNWG2c2L/uDAsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=1nzocMbI; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43ICkpAi024390;
	Thu, 18 Apr 2024 16:44:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=
	selector1; bh=kCEdnMcJCFwIkVj1mDIJIZ2ZcGqG9mLc4VGAUReqE6w=; b=1n
	zocMbIY5rPBCoAHCDuTY+l+2nDgO3VDRUDhk0mu7mMZuepaaGIBSbxwBPhJeyd8A
	b3HuCyg+jOV3LnonerOIAvf3flfgmURZ5k28rBnlKzEcc/nXfYtsTWVtAZjfdc8o
	hurUBmZGDs4iCRpALxdgKTkaic9QrIAQSnz5NpH3qnVXdJ9zh/YNFolh+9AjQL+k
	UxB6Sz5/LRq/Cs8IxspkPUq4H7PzMWFxbIBCrOeQYQrgx51BLodVZ5fqIdJuH8Kn
	Q7b7F8+DSy8yojRjjuFMei//dcimA7M1jvf/kE9rkhuiedWQE99Sdnvqtdign+K6
	bBS4rXyyG5Isd7jyXPGQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xfhcwyugm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 16:44:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 240934002D;
	Thu, 18 Apr 2024 16:43:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1C74621ED3D;
	Thu, 18 Apr 2024 16:43:02 +0200 (CEST)
Received: from localhost (10.48.86.103) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 16:43:01 +0200
From: Maxime MERE <maxime.mere@foss.st.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller"
	<davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>
CC: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob
 Herring <robh@kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] crypto: stm32/cryp - use dma when possible.
Date: Thu, 18 Apr 2024 16:42:54 +0200
Message-ID: <20240418144256.3736800-2-maxime.mere@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240418144256.3736800-1-maxime.mere@foss.st.com>
References: <20240418144256.3736800-1-maxime.mere@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_12,2024-04-17_01,2023-05-22_02

From: Maxime Méré <maxime.mere@foss.st.com>

Use DMA when buffer are aligned and with expected size.

If buffer are correctly aligned and bigger than 1KB we have some
performance gain:

With DMA enable:
$ openssl speed -evp aes-256-cbc -engine afalg -elapsed
The 'numbers' are in 1000s of bytes per second processed.
type          16 bytes     64 bytes    256 bytes   1024 bytes   8192 bytes  16384 bytes
aes-256-cbc   120.02k      406.78k     1588.82k     5873.32k    26020.52k    34258.94k

Without DMA:
$ openssl speed -evp aes-256-cbc -engine afalg -elapsed
The 'numbers' are in 1000s of bytes per second processed.
type          16 bytes     64 bytes    256 bytes   1024 bytes   8192 bytes  16384 bytes
aes-256-cbc   121.06k      419.95k     1112.23k     1897.47k     2362.03k     2386.60k

With DMA:
extract of
$ modprobe tcrypt mode=500
testing speed of async cbc(aes) (stm32-cbc-aes) encryption
tcrypt: test 14 (256 bit key,   16 byte blocks): 1 operation in  1679 cycles (16 bytes)
tcrypt: test 15 (256 bit key,   64 byte blocks): 1 operation in  1893 cycles (64 bytes)
tcrypt: test 16 (256 bit key,  128 byte blocks): 1 operation in  1760 cycles (128 bytes)
tcrypt: test 17 (256 bit key,  256 byte blocks): 1 operation in  2154 cycles (256 bytes)
tcrypt: test 18 (256 bit key, 1024 byte blocks): 1 operation in  2132 cycles (1024 bytes)
tcrypt: test 19 (256 bit key, 1424 byte blocks): 1 operation in  2466 cycles (1424 bytes)
tcrypt: test 20 (256 bit key, 4096 byte blocks): 1 operation in  4040 cycles (4096 bytes)

Without DMA:
$ modprobe tcrypt mode=500
tcrypt: test 14 (256 bit key,   16 byte blocks): 1 operation in  1671 cycles (16 bytes)
tcrypt: test 15 (256 bit key,   64 byte blocks): 1 operation in  2263 cycles (64 bytes)
tcrypt: test 16 (256 bit key,  128 byte blocks): 1 operation in  2881 cycles (128 bytes)
tcrypt: test 17 (256 bit key,  256 byte blocks): 1 operation in  4270 cycles (256 bytes)
tcrypt: test 18 (256 bit key, 1024 byte blocks): 1 operation in 11537 cycles (1024 bytes)
tcrypt: test 19 (256 bit key, 1424 byte blocks): 1 operation in 15025 cycles (1424 bytes)
tcrypt: test 20 (256 bit key, 4096 byte blocks): 1 operation in 40747 cycles (4096 bytes)

Co-developed-by: Nicolas Toromanoff <nicolas.toromanoff@foss.st.com>
Signed-off-by: Nicolas Toromanoff <nicolas.toromanoff@foss.st.com>
Co-developed-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Maxime Méré <maxime.mere@foss.st.com>

---
 drivers/crypto/stm32/stm32-cryp.c | 686 ++++++++++++++++++++++++++++--
 1 file changed, 660 insertions(+), 26 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-cryp.c b/drivers/crypto/stm32/stm32-cryp.c
index f095f0065428..c6d76c81d60f 100644
--- a/drivers/crypto/stm32/stm32-cryp.c
+++ b/drivers/crypto/stm32/stm32-cryp.c
@@ -13,6 +13,8 @@
 #include <crypto/scatterwalk.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/iopoll.h>
 #include <linux/interrupt.h>
@@ -40,6 +42,8 @@
 /* Mode mask = bits [15..0] */
 #define FLG_MODE_MASK           GENMASK(15, 0)
 /* Bit [31..16] status  */
+#define FLG_IN_OUT_DMA          BIT(16)
+#define FLG_HEADER_DMA          BIT(17)
 
 /* Registers */
 #define CRYP_CR                 0x00000000
@@ -121,8 +125,12 @@
 #define CR_PH_MASK              0x00030000
 #define CR_NBPBL_SHIFT          20
 
-#define SR_BUSY                 0x00000010
-#define SR_OFNE                 0x00000004
+#define SR_IFNF                 BIT(1)
+#define SR_OFNE                 BIT(2)
+#define SR_BUSY                 BIT(8)
+
+#define DMACR_DIEN              BIT(0)
+#define DMACR_DOEN              BIT(1)
 
 #define IMSCR_IN                BIT(0)
 #define IMSCR_OUT               BIT(1)
@@ -133,7 +141,15 @@
 /* Misc */
 #define AES_BLOCK_32            (AES_BLOCK_SIZE / sizeof(u32))
 #define GCM_CTR_INIT            2
-#define CRYP_AUTOSUSPEND_DELAY	50
+#define CRYP_AUTOSUSPEND_DELAY  50
+
+#define CRYP_DMA_BURST_REG      4
+
+enum stm32_dma_mode {
+	NO_DMA,
+	DMA_PLAIN_SG,
+	DMA_NEED_SG_TRUNC
+};
 
 struct stm32_cryp_caps {
 	bool			aeads_support;
@@ -146,6 +162,7 @@ struct stm32_cryp_caps {
 	u32			sr;
 	u32			din;
 	u32			dout;
+	u32			dmacr;
 	u32			imsc;
 	u32			mis;
 	u32			k1l;
@@ -172,6 +189,7 @@ struct stm32_cryp {
 	struct list_head        list;
 	struct device           *dev;
 	void __iomem            *regs;
+	phys_addr_t             phys_base;
 	struct clk              *clk;
 	unsigned long           flags;
 	u32                     irq_status;
@@ -190,8 +208,20 @@ struct stm32_cryp {
 	size_t                  header_in;
 	size_t                  payload_out;
 
+	/* DMA process fields */
+	struct scatterlist      *in_sg;
+	struct scatterlist      *header_sg;
 	struct scatterlist      *out_sg;
+	size_t                  in_sg_len;
+	size_t                  header_sg_len;
+	size_t                  out_sg_len;
+	struct completion	dma_completion;
+
+	struct dma_chan         *dma_lch_in;
+	struct dma_chan         *dma_lch_out;
+	enum stm32_dma_mode     dma_mode;
 
+	/* IT process fields */
 	struct scatter_walk     in_walk;
 	struct scatter_walk     out_walk;
 
@@ -291,12 +321,20 @@ static inline int stm32_cryp_wait_enable(struct stm32_cryp *cryp)
 			!(status & CR_CRYPEN), 10, 100000);
 }
 
+static inline int stm32_cryp_wait_input(struct stm32_cryp *cryp)
+{
+	u32 status;
+
+	return readl_relaxed_poll_timeout_atomic(cryp->regs + cryp->caps->sr, status,
+			status & SR_IFNF, 1, 10);
+}
+
 static inline int stm32_cryp_wait_output(struct stm32_cryp *cryp)
 {
 	u32 status;
 
-	return readl_relaxed_poll_timeout(cryp->regs + cryp->caps->sr, status,
-			status & SR_OFNE, 10, 100000);
+	return readl_relaxed_poll_timeout_atomic(cryp->regs + cryp->caps->sr, status,
+			status & SR_OFNE, 1, 10);
 }
 
 static inline void stm32_cryp_key_read_enable(struct stm32_cryp *cryp)
@@ -311,8 +349,13 @@ static inline void stm32_cryp_key_read_disable(struct stm32_cryp *cryp)
 		       cryp->regs + cryp->caps->cr);
 }
 
+static void stm32_cryp_irq_read_data(struct stm32_cryp *cryp);
+static void stm32_cryp_irq_write_data(struct stm32_cryp *cryp);
+static void stm32_cryp_irq_write_gcmccm_header(struct stm32_cryp *cryp);
 static int stm32_cryp_read_auth_tag(struct stm32_cryp *cryp);
 static void stm32_cryp_finish_req(struct stm32_cryp *cryp, int err);
+static int stm32_cryp_dma_start(struct stm32_cryp *cryp);
+static int stm32_cryp_it_start(struct stm32_cryp *cryp);
 
 static struct stm32_cryp *stm32_cryp_find_dev(struct stm32_cryp_ctx *ctx)
 {
@@ -813,11 +856,238 @@ static void stm32_cryp_finish_req(struct stm32_cryp *cryp, int err)
 	if (is_gcm(cryp) || is_ccm(cryp))
 		crypto_finalize_aead_request(cryp->engine, cryp->areq, err);
 	else
-		crypto_finalize_skcipher_request(cryp->engine, cryp->req,
-						   err);
+		crypto_finalize_skcipher_request(cryp->engine, cryp->req, err);
+}
+
+static void stm32_cryp_header_dma_callback(void *param)
+{
+	struct stm32_cryp *cryp = (struct stm32_cryp *)param;
+	int ret;
+	u32 reg;
+
+	dma_unmap_sg(cryp->dev, cryp->header_sg, cryp->header_sg_len, DMA_TO_DEVICE);
+
+	reg = stm32_cryp_read(cryp, cryp->caps->dmacr);
+	stm32_cryp_write(cryp, cryp->caps->dmacr, reg & ~(DMACR_DOEN | DMACR_DIEN));
+
+	kfree(cryp->header_sg);
+
+	reg = stm32_cryp_read(cryp, cryp->caps->cr);
+
+	if (cryp->header_in) {
+		stm32_cryp_write(cryp, cryp->caps->cr, reg | CR_CRYPEN);
+
+		ret = stm32_cryp_wait_input(cryp);
+		if (ret) {
+			dev_err(cryp->dev, "input header ready timeout after dma\n");
+			stm32_cryp_finish_req(cryp, ret);
+			return;
+		}
+		stm32_cryp_irq_write_gcmccm_header(cryp);
+		WARN_ON(cryp->header_in);
+	}
+
+	if (stm32_cryp_get_input_text_len(cryp)) {
+		/* Phase 3 : payload */
+		reg = stm32_cryp_read(cryp, cryp->caps->cr);
+		stm32_cryp_write(cryp, cryp->caps->cr, reg & ~CR_CRYPEN);
+
+		reg &= ~CR_PH_MASK;
+		reg |= CR_PH_PAYLOAD | CR_CRYPEN;
+		stm32_cryp_write(cryp, cryp->caps->cr, reg);
+
+		if (cryp->flags & FLG_IN_OUT_DMA) {
+			ret = stm32_cryp_dma_start(cryp);
+			if (ret)
+				stm32_cryp_finish_req(cryp, ret);
+		} else {
+			stm32_cryp_it_start(cryp);
+		}
+	} else {
+		/*
+		 * Phase 4 : tag.
+		 * Nothing to read, nothing to write => end request
+		 */
+		stm32_cryp_finish_req(cryp, 0);
+	}
+}
+
+static void stm32_cryp_dma_callback(void *param)
+{
+	struct stm32_cryp *cryp = (struct stm32_cryp *)param;
+	int ret;
+	u32 reg;
+
+	complete(&cryp->dma_completion); /* completion to indicate no timeout */
+
+	dma_sync_sg_for_device(cryp->dev, cryp->out_sg, cryp->out_sg_len, DMA_FROM_DEVICE);
+
+	if (cryp->in_sg != cryp->out_sg)
+		dma_unmap_sg(cryp->dev, cryp->in_sg, cryp->in_sg_len, DMA_TO_DEVICE);
+
+	dma_unmap_sg(cryp->dev, cryp->out_sg, cryp->out_sg_len, DMA_FROM_DEVICE);
+
+	reg = stm32_cryp_read(cryp, cryp->caps->dmacr);
+	stm32_cryp_write(cryp, cryp->caps->dmacr, reg & ~(DMACR_DOEN | DMACR_DIEN));
+
+	reg = stm32_cryp_read(cryp, cryp->caps->cr);
+
+	if (is_gcm(cryp) || is_ccm(cryp)) {
+		kfree(cryp->in_sg);
+		kfree(cryp->out_sg);
+	} else {
+		if (cryp->in_sg != cryp->req->src)
+			kfree(cryp->in_sg);
+		if (cryp->out_sg != cryp->req->dst)
+			kfree(cryp->out_sg);
+	}
+
+	if (cryp->payload_in) {
+		stm32_cryp_write(cryp, cryp->caps->cr, reg | CR_CRYPEN);
+
+		ret = stm32_cryp_wait_input(cryp);
+		if (ret) {
+			dev_err(cryp->dev, "input ready timeout after dma\n");
+			stm32_cryp_finish_req(cryp, ret);
+			return;
+		}
+		stm32_cryp_irq_write_data(cryp);
+
+		ret = stm32_cryp_wait_output(cryp);
+		if (ret) {
+			dev_err(cryp->dev, "output ready timeout after dma\n");
+			stm32_cryp_finish_req(cryp, ret);
+			return;
+		}
+		stm32_cryp_irq_read_data(cryp);
+	}
+
+	stm32_cryp_finish_req(cryp, 0);
+}
+
+static int stm32_cryp_header_dma_start(struct stm32_cryp *cryp)
+{
+	int ret;
+	struct dma_async_tx_descriptor *tx_in;
+	u32 reg;
+	size_t align_size;
+
+	ret = dma_map_sg(cryp->dev, cryp->header_sg, cryp->header_sg_len, DMA_TO_DEVICE);
+	if (!ret) {
+		dev_err(cryp->dev, "dma_map_sg() error\n");
+		return -ENOMEM;
+	}
+
+	dma_sync_sg_for_device(cryp->dev, cryp->header_sg, cryp->header_sg_len, DMA_TO_DEVICE);
+
+	tx_in = dmaengine_prep_slave_sg(cryp->dma_lch_in, cryp->header_sg, cryp->header_sg_len,
+					DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!tx_in) {
+		dev_err(cryp->dev, "IN prep_slave_sg() failed\n");
+		return -EINVAL;
+	}
+
+	tx_in->callback_param = cryp;
+	tx_in->callback = stm32_cryp_header_dma_callback;
+
+	/* Advance scatterwalk to not DMA'ed data */
+	align_size = ALIGN_DOWN(cryp->header_in, cryp->hw_blocksize);
+	scatterwalk_copychunks(NULL, &cryp->in_walk, align_size, 2);
+	cryp->header_in -= align_size;
+
+	ret = dma_submit_error(dmaengine_submit(tx_in));
+	if (ret < 0) {
+		dev_err(cryp->dev, "DMA in submit failed\n");
+		return ret;
+	}
+	dma_async_issue_pending(cryp->dma_lch_in);
+
+	reg = stm32_cryp_read(cryp, cryp->caps->dmacr);
+	stm32_cryp_write(cryp, cryp->caps->dmacr, reg | DMACR_DIEN);
+
+	return 0;
+}
+
+static int stm32_cryp_dma_start(struct stm32_cryp *cryp)
+{
+	int ret;
+	size_t align_size;
+	struct dma_async_tx_descriptor *tx_in, *tx_out;
+	u32 reg;
+
+	if (cryp->in_sg != cryp->out_sg) {
+		ret = dma_map_sg(cryp->dev, cryp->in_sg, cryp->in_sg_len, DMA_TO_DEVICE);
+		if (!ret) {
+			dev_err(cryp->dev, "dma_map_sg() error\n");
+			return -ENOMEM;
+		}
+	}
+
+	ret = dma_map_sg(cryp->dev, cryp->out_sg, cryp->out_sg_len, DMA_FROM_DEVICE);
+	if (!ret) {
+		dev_err(cryp->dev, "dma_map_sg() error\n");
+		return -ENOMEM;
+	}
+
+	dma_sync_sg_for_device(cryp->dev, cryp->in_sg, cryp->in_sg_len, DMA_TO_DEVICE);
+
+	tx_in = dmaengine_prep_slave_sg(cryp->dma_lch_in, cryp->in_sg, cryp->in_sg_len,
+					DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!tx_in) {
+		dev_err(cryp->dev, "IN prep_slave_sg() failed\n");
+		return -EINVAL;
+	}
+
+	/* No callback necessary */
+	tx_in->callback_param = cryp;
+	tx_in->callback = NULL;
+
+	tx_out = dmaengine_prep_slave_sg(cryp->dma_lch_out, cryp->out_sg, cryp->out_sg_len,
+					 DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!tx_out) {
+		dev_err(cryp->dev, "OUT prep_slave_sg() failed\n");
+		return -EINVAL;
+	}
+
+	reinit_completion(&cryp->dma_completion);
+	tx_out->callback = stm32_cryp_dma_callback;
+	tx_out->callback_param = cryp;
+
+	/* Advance scatterwalk to not DMA'ed data */
+	align_size = ALIGN_DOWN(cryp->payload_in, cryp->hw_blocksize);
+	scatterwalk_copychunks(NULL, &cryp->in_walk, align_size, 2);
+	cryp->payload_in -= align_size;
+
+	ret = dma_submit_error(dmaengine_submit(tx_in));
+	if (ret < 0) {
+		dev_err(cryp->dev, "DMA in submit failed\n");
+		return ret;
+	}
+	dma_async_issue_pending(cryp->dma_lch_in);
+
+	/* Advance scatterwalk to not DMA'ed data */
+	scatterwalk_copychunks(NULL, &cryp->out_walk, align_size, 2);
+	cryp->payload_out -= align_size;
+	ret = dma_submit_error(dmaengine_submit(tx_out));
+	if (ret < 0) {
+		dev_err(cryp->dev, "DMA out submit failed\n");
+		return ret;
+	}
+	dma_async_issue_pending(cryp->dma_lch_out);
+
+	reg = stm32_cryp_read(cryp, cryp->caps->dmacr);
+	stm32_cryp_write(cryp, cryp->caps->dmacr, reg | DMACR_DOEN | DMACR_DIEN);
+
+	if (!wait_for_completion_timeout(&cryp->dma_completion, msecs_to_jiffies(1000))) {
+		dev_err(cryp->dev, "DMA out timed out\n");
+		dmaengine_terminate_sync(cryp->dma_lch_out);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
 }
 
-static int stm32_cryp_cpu_start(struct stm32_cryp *cryp)
+static int stm32_cryp_it_start(struct stm32_cryp *cryp)
 {
 	/* Enable interrupt and let the IRQ handler do everything */
 	stm32_cryp_write(cryp, cryp->caps->imsc, IMSCR_IN | IMSCR_OUT);
@@ -1149,13 +1419,254 @@ static int stm32_cryp_tdes_cbc_decrypt(struct skcipher_request *req)
 	return stm32_cryp_crypt(req, FLG_TDES | FLG_CBC);
 }
 
+static enum stm32_dma_mode stm32_cryp_dma_check_sg(struct scatterlist *test_sg, size_t len,
+						   size_t block_size)
+{
+	struct scatterlist *sg;
+	int i;
+
+	if (len <= 16)
+		return NO_DMA; /* Faster */
+
+	for_each_sg(test_sg, sg, sg_nents(test_sg), i) {
+		if (!IS_ALIGNED(sg->length, block_size) && !sg_is_last(sg))
+			return NO_DMA;
+
+		if (sg->offset % sizeof(u32))
+			return NO_DMA;
+
+		if (sg_is_last(sg) && !IS_ALIGNED(sg->length, AES_BLOCK_SIZE))
+			return DMA_NEED_SG_TRUNC;
+	}
+
+	return DMA_PLAIN_SG;
+}
+
+static enum stm32_dma_mode stm32_cryp_dma_check(struct stm32_cryp *cryp, struct scatterlist *in_sg,
+						struct scatterlist *out_sg)
+{
+	enum stm32_dma_mode ret = DMA_PLAIN_SG;
+
+	if (!is_aes(cryp))
+		return NO_DMA;
+
+	if (!cryp->dma_lch_in || !cryp->dma_lch_out)
+		return NO_DMA;
+
+	ret = stm32_cryp_dma_check_sg(in_sg, cryp->payload_in, AES_BLOCK_SIZE);
+	if (ret == NO_DMA)
+		return ret;
+
+	ret = stm32_cryp_dma_check_sg(out_sg, cryp->payload_out, AES_BLOCK_SIZE);
+	if (ret == NO_DMA)
+		return ret;
+
+	/* Check CTR counter overflow */
+	if (is_aes(cryp) && is_ctr(cryp)) {
+		u32 c;
+		__be32 iv3;
+
+		memcpy(&iv3, &cryp->req->iv[3 * sizeof(u32)], sizeof(iv3));
+		c = be32_to_cpu(iv3);
+		if ((c + cryp->payload_in) < cryp->payload_in)
+			return NO_DMA;
+	}
+
+	/* Workaround */
+	if (is_aes(cryp) && is_ctr(cryp) && ret == DMA_NEED_SG_TRUNC)
+		return NO_DMA;
+
+	return ret;
+}
+
+static int stm32_cryp_truncate_sg(struct scatterlist **new_sg, size_t *new_sg_len,
+				  struct scatterlist *sg, off_t skip, size_t size)
+{
+	struct scatterlist *cur;
+	size_t alloc_sg_len;
+
+	*new_sg_len = 0;
+
+	if (!sg || !size) {
+		*new_sg = NULL;
+		return 0;
+	}
+
+	alloc_sg_len = sg_nents_for_len(sg, skip + size);
+	if (alloc_sg_len < 0)
+		return alloc_sg_len;
+
+	/* We allocate to much sg entry, but it is easier */
+	*new_sg = kmalloc_array(alloc_sg_len, sizeof(struct scatterlist), GFP_KERNEL);
+	if (!*new_sg)
+		return -ENOMEM;
+
+	sg_init_table(*new_sg, alloc_sg_len);
+
+	cur = *new_sg;
+	while (sg && size) {
+		unsigned int len = sg->length;
+		unsigned int offset = sg->offset;
+
+		if (skip > len) {
+			skip -= len;
+			sg = sg_next(sg);
+			continue;
+		}
+
+		if (skip) {
+			len -= skip;
+			offset += skip;
+			skip = 0;
+		}
+
+		if (size < len)
+			len = size;
+
+		if (len > 0) {
+			(*new_sg_len)++;
+			size -= len;
+			sg_set_page(cur, sg_page(sg), len, offset);
+			if (size == 0)
+				sg_mark_end(cur);
+			cur = sg_next(cur);
+		}
+
+		sg = sg_next(sg);
+	}
+
+	return 0;
+}
+
+static int stm32_cryp_cipher_prepare(struct stm32_cryp *cryp, struct scatterlist *in_sg,
+				     struct scatterlist *out_sg)
+{
+	size_t align_size;
+
+	cryp->dma_mode = stm32_cryp_dma_check(cryp, in_sg, out_sg);
+
+	scatterwalk_start(&cryp->in_walk, in_sg);
+	scatterwalk_start(&cryp->out_walk, out_sg);
+
+	if (cryp->dma_mode == NO_DMA) {
+		cryp->flags &= ~FLG_IN_OUT_DMA;
+
+		if (is_ctr(cryp))
+			memset(cryp->last_ctr, 0, sizeof(cryp->last_ctr));
+
+	} else if (cryp->dma_mode == DMA_NEED_SG_TRUNC) {
+		int ret;
+
+		cryp->flags |= FLG_IN_OUT_DMA;
+
+		align_size = ALIGN_DOWN(cryp->payload_in, cryp->hw_blocksize);
+		ret = stm32_cryp_truncate_sg(&cryp->in_sg, &cryp->in_sg_len, in_sg, 0, align_size);
+		if (ret)
+			return ret;
+
+		ret = stm32_cryp_truncate_sg(&cryp->out_sg, &cryp->out_sg_len, out_sg, 0,
+					     align_size);
+		if (ret) {
+			kfree(cryp->in_sg);
+			return ret;
+		}
+	} else {
+		cryp->flags |= FLG_IN_OUT_DMA;
+
+		cryp->in_sg = in_sg;
+		cryp->out_sg = out_sg;
+
+		cryp->in_sg_len = sg_nents_for_len(cryp->in_sg, cryp->payload_in);
+		if (cryp->in_sg_len < 0)
+			return cryp->in_sg_len;
+
+		cryp->out_sg_len = sg_nents_for_len(out_sg, cryp->payload_out);
+		if (cryp->out_sg_len < 0)
+			return cryp->out_sg_len;
+	}
+
+	return 0;
+}
+
+static int stm32_cryp_aead_prepare(struct stm32_cryp *cryp, struct scatterlist *in_sg,
+				   struct scatterlist *out_sg)
+{
+	size_t align_size;
+	off_t skip;
+	int ret, ret2;
+
+	cryp->header_sg = NULL;
+	cryp->in_sg = NULL;
+	cryp->out_sg = NULL;
+
+	if (!cryp->dma_lch_in || !cryp->dma_lch_out) {
+		cryp->dma_mode = NO_DMA;
+		cryp->flags &= ~(FLG_IN_OUT_DMA | FLG_HEADER_DMA);
+
+		return 0;
+	}
+
+	/* CCM hw_init may have advanced in header */
+	skip = cryp->areq->assoclen - cryp->header_in;
+
+	align_size = ALIGN_DOWN(cryp->header_in, cryp->hw_blocksize);
+	ret = stm32_cryp_truncate_sg(&cryp->header_sg, &cryp->header_sg_len, in_sg, skip,
+				     align_size);
+	if (ret)
+		return ret;
+
+	ret = stm32_cryp_dma_check_sg(cryp->header_sg, align_size, AES_BLOCK_SIZE);
+	if (ret == NO_DMA) {
+		/* We cannot DMA the header */
+		kfree(cryp->header_sg);
+		cryp->header_sg = NULL;
+
+		cryp->flags &= ~FLG_HEADER_DMA;
+	} else {
+		cryp->flags |= FLG_HEADER_DMA;
+	}
+
+	/* Now skip all header to be at payload start */
+	skip = cryp->areq->assoclen;
+	align_size = ALIGN_DOWN(cryp->payload_in, cryp->hw_blocksize);
+	ret = stm32_cryp_truncate_sg(&cryp->in_sg, &cryp->in_sg_len, in_sg, skip, align_size);
+	if (ret) {
+		kfree(cryp->header_sg);
+		return ret;
+	}
+
+	/* For out buffer align_size is same as in buffer */
+	ret = stm32_cryp_truncate_sg(&cryp->out_sg, &cryp->out_sg_len, out_sg, skip, align_size);
+	if (ret) {
+		kfree(cryp->header_sg);
+		kfree(cryp->in_sg);
+		return ret;
+	}
+
+	ret = stm32_cryp_dma_check_sg(cryp->in_sg, align_size, AES_BLOCK_SIZE);
+	ret2 = stm32_cryp_dma_check_sg(cryp->out_sg, align_size, AES_BLOCK_SIZE);
+	if (ret == NO_DMA || ret2 == NO_DMA) {
+		kfree(cryp->in_sg);
+		cryp->in_sg = NULL;
+
+		kfree(cryp->out_sg);
+		cryp->out_sg = NULL;
+
+		cryp->flags &= ~FLG_IN_OUT_DMA;
+	} else {
+		cryp->flags |= FLG_IN_OUT_DMA;
+	}
+
+	return 0;
+}
+
 static int stm32_cryp_prepare_req(struct skcipher_request *req,
 				  struct aead_request *areq)
 {
 	struct stm32_cryp_ctx *ctx;
 	struct stm32_cryp *cryp;
 	struct stm32_cryp_reqctx *rctx;
-	struct scatterlist *in_sg;
+	struct scatterlist *in_sg, *out_sg;
 	int ret;
 
 	if (!req && !areq)
@@ -1169,8 +1680,6 @@ static int stm32_cryp_prepare_req(struct skcipher_request *req,
 	rctx = req ? skcipher_request_ctx(req) : aead_request_ctx(areq);
 	rctx->mode &= FLG_MODE_MASK;
 
-	ctx->cryp = cryp;
-
 	cryp->flags = (cryp->flags & ~FLG_MODE_MASK) | rctx->mode;
 	cryp->hw_blocksize = is_aes(cryp) ? AES_BLOCK_SIZE : DES_BLOCK_SIZE;
 	cryp->ctx = ctx;
@@ -1182,6 +1691,15 @@ static int stm32_cryp_prepare_req(struct skcipher_request *req,
 		cryp->payload_in = req->cryptlen;
 		cryp->payload_out = req->cryptlen;
 		cryp->authsize = 0;
+
+		in_sg = req->src;
+		out_sg = req->dst;
+
+		ret = stm32_cryp_cipher_prepare(cryp, in_sg, out_sg);
+		if (ret)
+			return ret;
+
+		ret = stm32_cryp_hw_init(cryp);
 	} else {
 		/*
 		 * Length of input and output data:
@@ -1211,23 +1729,22 @@ static int stm32_cryp_prepare_req(struct skcipher_request *req,
 			cryp->header_in = areq->assoclen;
 			cryp->payload_out = cryp->payload_in;
 		}
-	}
-
-	in_sg = req ? req->src : areq->src;
-	scatterwalk_start(&cryp->in_walk, in_sg);
 
-	cryp->out_sg = req ? req->dst : areq->dst;
-	scatterwalk_start(&cryp->out_walk, cryp->out_sg);
+		in_sg = areq->src;
+		out_sg = areq->dst;
 
-	if (is_gcm(cryp) || is_ccm(cryp)) {
+		scatterwalk_start(&cryp->in_walk, in_sg);
+		scatterwalk_start(&cryp->out_walk, out_sg);
 		/* In output, jump after assoc data */
 		scatterwalk_copychunks(NULL, &cryp->out_walk, cryp->areq->assoclen, 2);
-	}
 
-	if (is_ctr(cryp))
-		memset(cryp->last_ctr, 0, sizeof(cryp->last_ctr));
+		ret = stm32_cryp_hw_init(cryp);
+		if (ret)
+			return ret;
+
+		ret = stm32_cryp_aead_prepare(cryp, in_sg, out_sg);
+	}
 
-	ret = stm32_cryp_hw_init(cryp);
 	return ret;
 }
 
@@ -1239,12 +1756,35 @@ static int stm32_cryp_cipher_one_req(struct crypto_engine *engine, void *areq)
 	struct stm32_cryp_ctx *ctx = crypto_skcipher_ctx(
 			crypto_skcipher_reqtfm(req));
 	struct stm32_cryp *cryp = ctx->cryp;
+	int ret;
 
 	if (!cryp)
 		return -ENODEV;
 
-	return stm32_cryp_prepare_req(req, NULL) ?:
-	       stm32_cryp_cpu_start(cryp);
+	ret = stm32_cryp_prepare_req(req, NULL);
+	if (ret)
+		return ret;
+
+	/* Avoid to use DMA if peripheral 32 bit counter is about to overflow with ctr(aes) */
+	if (is_aes(cryp) && is_ctr(cryp)) {
+		u32 iv_overflow[4];
+
+		memcpy(iv_overflow, req->iv, sizeof(__be32) * 4);
+		iv_overflow[3] = 0xffffffff - be32_to_cpu((__be32)iv_overflow[3]);
+
+		if (req->src->length > iv_overflow[3])
+			cryp->flags &= ~FLG_IN_OUT_DMA;
+	}
+
+	if (cryp->flags & FLG_IN_OUT_DMA)
+		ret = stm32_cryp_dma_start(cryp);
+	else
+		ret = stm32_cryp_it_start(cryp);
+
+	if (ret == -ETIMEDOUT)
+		stm32_cryp_finish_req(cryp, ret);
+
+	return ret;
 }
 
 static int stm32_cryp_aead_one_req(struct crypto_engine *engine, void *areq)
@@ -1262,13 +1802,20 @@ static int stm32_cryp_aead_one_req(struct crypto_engine *engine, void *areq)
 	if (err)
 		return err;
 
-	if (unlikely(!cryp->payload_in && !cryp->header_in)) {
+	if (!stm32_cryp_get_input_text_len(cryp) && !cryp->header_in &&
+	    !(cryp->flags & FLG_HEADER_DMA)) {
 		/* No input data to process: get tag and finish */
 		stm32_cryp_finish_req(cryp, 0);
 		return 0;
 	}
 
-	return stm32_cryp_cpu_start(cryp);
+	if (cryp->flags & FLG_HEADER_DMA)
+		return stm32_cryp_header_dma_start(cryp);
+
+	if (!cryp->header_in && cryp->flags & FLG_IN_OUT_DMA)
+		return stm32_cryp_dma_start(cryp);
+
+	return stm32_cryp_it_start(cryp);
 }
 
 static int stm32_cryp_read_auth_tag(struct stm32_cryp *cryp)
@@ -1680,6 +2227,65 @@ static irqreturn_t stm32_cryp_irq(int irq, void *arg)
 	return IRQ_WAKE_THREAD;
 }
 
+static int stm32_cryp_dma_init(struct stm32_cryp *cryp)
+{
+	struct dma_slave_config dma_conf;
+	struct dma_chan *chan;
+	int ret;
+
+	memset(&dma_conf, 0, sizeof(dma_conf));
+
+	dma_conf.direction = DMA_MEM_TO_DEV;
+	dma_conf.dst_addr = cryp->phys_base + cryp->caps->din;
+	dma_conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	dma_conf.dst_maxburst = CRYP_DMA_BURST_REG;
+	dma_conf.device_fc = false;
+
+	chan = dma_request_chan(cryp->dev, "in");
+	if (IS_ERR(chan))
+		return PTR_ERR(chan);
+
+	cryp->dma_lch_in = chan;
+	ret = dmaengine_slave_config(cryp->dma_lch_in, &dma_conf);
+	if (ret) {
+		dma_release_channel(cryp->dma_lch_in);
+		cryp->dma_lch_in = NULL;
+		dev_err(cryp->dev, "Couldn't configure DMA in slave.\n");
+		return ret;
+	}
+
+	memset(&dma_conf, 0, sizeof(dma_conf));
+
+	dma_conf.direction = DMA_DEV_TO_MEM;
+	dma_conf.src_addr = cryp->phys_base + cryp->caps->dout;
+	dma_conf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	dma_conf.src_maxburst = CRYP_DMA_BURST_REG;
+	dma_conf.device_fc = false;
+
+	chan = dma_request_chan(cryp->dev, "out");
+	if (IS_ERR(chan)) {
+		dma_release_channel(cryp->dma_lch_in);
+		cryp->dma_lch_in = NULL;
+		return PTR_ERR(chan);
+	}
+
+	cryp->dma_lch_out = chan;
+
+	ret = dmaengine_slave_config(cryp->dma_lch_out, &dma_conf);
+	if (ret) {
+		dma_release_channel(cryp->dma_lch_out);
+		cryp->dma_lch_out = NULL;
+		dev_err(cryp->dev, "Couldn't configure DMA out slave.\n");
+		dma_release_channel(cryp->dma_lch_in);
+		cryp->dma_lch_in = NULL;
+		return ret;
+	}
+
+	init_completion(&cryp->dma_completion);
+
+	return 0;
+}
+
 static struct skcipher_engine_alg crypto_algs[] = {
 {
 	.base = {
@@ -1901,6 +2507,7 @@ static const struct stm32_cryp_caps ux500_data = {
 	.sr = UX500_CRYP_SR,
 	.din = UX500_CRYP_DIN,
 	.dout = UX500_CRYP_DOUT,
+	.dmacr = UX500_CRYP_DMACR,
 	.imsc = UX500_CRYP_IMSC,
 	.mis = UX500_CRYP_MIS,
 	.k1l = UX500_CRYP_K1L,
@@ -1923,6 +2530,7 @@ static const struct stm32_cryp_caps f7_data = {
 	.sr = CRYP_SR,
 	.din = CRYP_DIN,
 	.dout = CRYP_DOUT,
+	.dmacr = CRYP_DMACR,
 	.imsc = CRYP_IMSCR,
 	.mis = CRYP_MISR,
 	.k1l = CRYP_K1LR,
@@ -1945,6 +2553,7 @@ static const struct stm32_cryp_caps mp1_data = {
 	.sr = CRYP_SR,
 	.din = CRYP_DIN,
 	.dout = CRYP_DOUT,
+	.dmacr = CRYP_DMACR,
 	.imsc = CRYP_IMSCR,
 	.mis = CRYP_MISR,
 	.k1l = CRYP_K1LR,
@@ -1985,6 +2594,8 @@ static int stm32_cryp_probe(struct platform_device *pdev)
 	if (IS_ERR(cryp->regs))
 		return PTR_ERR(cryp->regs);
 
+	cryp->phys_base = platform_get_resource(pdev, IORESOURCE_MEM, 0)->start;
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
@@ -2030,6 +2641,17 @@ static int stm32_cryp_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, cryp);
 
+	ret = stm32_cryp_dma_init(cryp);
+	switch (ret) {
+	case 0:
+		break;
+	case -ENODEV:
+		dev_dbg(dev, "DMA mode not available\n");
+		break;
+	default:
+		goto err_dma;
+	}
+
 	spin_lock(&cryp_list.lock);
 	list_add(&cryp->list, &cryp_list.dev_list);
 	spin_unlock(&cryp_list.lock);
@@ -2075,6 +2697,12 @@ static int stm32_cryp_probe(struct platform_device *pdev)
 	spin_lock(&cryp_list.lock);
 	list_del(&cryp->list);
 	spin_unlock(&cryp_list.lock);
+
+	if (cryp->dma_lch_in)
+		dma_release_channel(cryp->dma_lch_in);
+	if (cryp->dma_lch_out)
+		dma_release_channel(cryp->dma_lch_out);
+err_dma:
 err_rst:
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
@@ -2106,6 +2734,12 @@ static int stm32_cryp_remove(struct platform_device *pdev)
 	list_del(&cryp->list);
 	spin_unlock(&cryp_list.lock);
 
+	if (cryp->dma_lch_in)
+		dma_release_channel(cryp->dma_lch_in);
+
+	if (cryp->dma_lch_out)
+		dma_release_channel(cryp->dma_lch_out);
+
 	pm_runtime_disable(cryp->dev);
 	pm_runtime_put_noidle(cryp->dev);
 
-- 
2.25.1


