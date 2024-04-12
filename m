Return-Path: <linux-kernel+bounces-142672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3520C8A2EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A521F21DF5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E715A4D5;
	Fri, 12 Apr 2024 12:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="CIS2PZan"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D48050275;
	Fri, 12 Apr 2024 12:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712926559; cv=none; b=p5VJlSynv6lPktwdG3xWrDkn58s9gXum2F+szldmQvrvRmC3UnFREi3cZxU4EY4OzZDtpn3W8cABXw7ZeRJbyIDQUHPgbw47lKUihQplEKyu+gAgwXByOd+gt1Hjs/RWf4V3z9m3xSmUplD969dx7+BhK9LXxFaS0g+eWCTMu/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712926559; c=relaxed/simple;
	bh=mc7CoYcC1llDbti4IfCNB6jg8OGLeCYoYebr8O2poQE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lmw2wzgqEj9KrvcLn9V07x4UwtCwuDs/zlUx7U3iAHdgEMt6Ixc3fobqRteIOeSBp12mGHy1y3pHRckImF0r/iSLgVbs1ovA4/UxBKtYtRaPlKNy1PYaHR1GmGf9dtGJRFLOzwfTiBZZclW2jpAuZYCmbKoWMSED++FFulKGoM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=CIS2PZan; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43CC06gB016590;
	Fri, 12 Apr 2024 14:55:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=selector1; bh=ImEAKOL+u2wUqsXeJmbU
	lbzaMkx4kY1fkNPpK5Jr5CA=; b=CIS2PZanF/LtMN0z8UJSZP1msQbUyffh8/pa
	QR/3qgS7UkftrkSZpzCD5YefR004+8eOaRU6D/HFTm+cFOUmP2cgFO5oCrRNi1sW
	rzQuuGrw7iRqs1Gz9ipZ9YKt1uNoRe6hi3BFzNxHvPuiCTmRnp5rrK4FhV6rTHZv
	RX2M4/1wxOWtUWam8mGePSK79w7mTK+g2lbnrfpjcul/Iou13Hroef9v8sbh5cZ6
	OQZSQ7/IT5V+ck5bAHHRDxzH+z3enaE1JEA+fkq2R9Q4qmLb3kTC8ASfH3iVy9nc
	W3nmqzNcoCsdEbPOY6cSJoW8+DZGgxcYLvV9qmy1EkMWh2fHtg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xautga20n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 14:55:29 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0162740045;
	Fri, 12 Apr 2024 14:55:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A382D215BE3;
	Fri, 12 Apr 2024 14:54:42 +0200 (CEST)
Received: from localhost (10.48.86.103) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 12 Apr
 2024 14:54:42 +0200
From: Maxime MERE <maxime.mere@foss.st.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller"
	<davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>
CC: Thomas Bourgoin <thomas.bourgoin@foss.st.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Eric
 Biggers <ebiggers@google.com>, Rob Herring <robh@kernel.org>,
        <linux-crypto@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Maxime=20M=C3=A9r=C3=A9?= <maxime.mere@foss.st.com>
Subject: [PATCH] crypto: stm32/hash - add full DMA support for stm32mpx
Date: Fri, 12 Apr 2024 14:45:45 +0200
Message-ID: <20240412124545.2704487-1-maxime.mere@foss.st.com>
X-Mailer: git-send-email 2.25.1
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
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_09,2024-04-09_01,2023-05-22_02

From: Maxime Méré <maxime.mere@foss.st.com>

Due to a lack of alignment in the data sent by requests, the actual DMA
support of the STM32 hash driver is only working with digest calls.
This patch, based on the algorithm used in the driver omap-sham.c,
allows for the usage of DMA in any situation.

It has been functionally tested on STM32MP15, STM32MP13 and STM32MP25.

By checking the performance of this new driver with OpenSSL, the
following results were found:

Performance:

(datasize: 4096, number of hashes performed in 10s)

|type   |no DMA    |DMA support|software  |
|-------|----------|-----------|----------|
|md5    |13873.56k |10958.03k  |71163.08k |
|sha1   |13796.15k |10729.47k  |39670.58k |
|sha224 |13737.98k |10775.76k  |22094.64k |
|sha256 |13655.65k |10872.01k  |22075.39k |

CPU Usage:

(algorithm used: sha256, computation time: 20s, measurement taken at
~10s)

|datasize  |no DMA |DMA  | software |
|----------|-------|-----|----------|
|  2048    | 56%   | 49% | 50%      |
|  4096    | 54%   | 46% | 50%      |
|  8192    | 53%   | 40% | 50%      |
| 16384    | 53%   | 33% | 50%      |

Note: this update doesn't change the driver performance without DMA.

As shown, performance with DMA is slightly lower than without, but in
most cases, it will save CPU time.

Signed-off-by: Maxime Méré <maxime.mere@foss.st.com>
---
 drivers/crypto/stm32/stm32-hash.c | 570 +++++++++++++++++++++++-------
 1 file changed, 448 insertions(+), 122 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index 2b2382d4332c..bace2baefaf3 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -94,6 +94,7 @@
 #define HASH_FLAGS_ERRORS		BIT(21)
 #define HASH_FLAGS_EMPTY		BIT(22)
 #define HASH_FLAGS_HMAC			BIT(23)
+#define HASH_FLAGS_SGS_COPIED		BIT(24)
 
 #define HASH_OP_UPDATE			1
 #define HASH_OP_FINAL			2
@@ -145,7 +146,7 @@ struct stm32_hash_state {
 	u16			bufcnt;
 	u16			blocklen;
 
-	u8 buffer[HASH_BUFLEN] __aligned(4);
+	u8 buffer[HASH_BUFLEN] __aligned(sizeof(u32));
 
 	/* hash state */
 	u32			hw_context[3 + HASH_CSR_NB_MAX];
@@ -158,8 +159,8 @@ struct stm32_hash_request_ctx {
 	u8 digest[SHA512_DIGEST_SIZE] __aligned(sizeof(u32));
 	size_t			digcnt;
 
-	/* DMA */
 	struct scatterlist	*sg;
+	struct scatterlist	sgl[2]; /* scatterlist used to realize alignment */
 	unsigned int		offset;
 	unsigned int		total;
 	struct scatterlist	sg_key;
@@ -184,6 +185,7 @@ struct stm32_hash_pdata {
 	size_t					algs_info_size;
 	bool					has_sr;
 	bool					has_mdmat;
+	bool					context_secured;
 	bool					broken_emptymsg;
 	bool					ux500;
 };
@@ -195,6 +197,7 @@ struct stm32_hash_dev {
 	struct reset_control	*rst;
 	void __iomem		*io_base;
 	phys_addr_t		phys_base;
+	u8			xmit_buf[HASH_BUFLEN] __aligned(sizeof(u32));
 	u32			dma_mode;
 	bool			polled;
 
@@ -220,6 +223,8 @@ static struct stm32_hash_drv stm32_hash = {
 };
 
 static void stm32_hash_dma_callback(void *param);
+static int stm32_hash_prepare_request(struct ahash_request *req);
+static void stm32_hash_unprepare_request(struct ahash_request *req);
 
 static inline u32 stm32_hash_read(struct stm32_hash_dev *hdev, u32 offset)
 {
@@ -232,6 +237,11 @@ static inline void stm32_hash_write(struct stm32_hash_dev *hdev,
 	writel_relaxed(value, hdev->io_base + offset);
 }
 
+/**
+ * stm32_hash_wait_busy - wait until hash processor is available. It return an
+ * error if the hash core is processing a block of data for more than 10 ms.
+ * @hdev: the stm32_hash_dev device.
+ */
 static inline int stm32_hash_wait_busy(struct stm32_hash_dev *hdev)
 {
 	u32 status;
@@ -245,6 +255,11 @@ static inline int stm32_hash_wait_busy(struct stm32_hash_dev *hdev)
 				   !(status & HASH_SR_BUSY), 10, 10000);
 }
 
+/**
+ * stm32_hash_set_nblw - set the number of valid bytes in the last word.
+ * @hdev: the stm32_hash_dev device.
+ * @length: the length of the final word.
+ */
 static void stm32_hash_set_nblw(struct stm32_hash_dev *hdev, int length)
 {
 	u32 reg;
@@ -282,6 +297,11 @@ static int stm32_hash_write_key(struct stm32_hash_dev *hdev)
 	return 0;
 }
 
+/**
+ * stm32_hash_write_ctrl - Initialize the hash processor, only if
+ * HASH_FLAGS_INIT is set.
+ * @hdev: the stm32_hash_dev device
+ */
 static void stm32_hash_write_ctrl(struct stm32_hash_dev *hdev)
 {
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(hdev->req);
@@ -469,9 +489,7 @@ static int stm32_hash_update_cpu(struct stm32_hash_dev *hdev)
 {
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(hdev->req);
 	struct stm32_hash_state *state = &rctx->state;
-	u32 *preg = state->hw_context;
 	int bufcnt, err = 0, final;
-	int i, swap_reg;
 
 	dev_dbg(hdev->dev, "%s flags %x\n", __func__, state->flags);
 
@@ -495,34 +513,23 @@ static int stm32_hash_update_cpu(struct stm32_hash_dev *hdev)
 		return stm32_hash_xmit_cpu(hdev, state->buffer, bufcnt, 1);
 	}
 
-	if (!(hdev->flags & HASH_FLAGS_INIT))
-		return 0;
-
-	if (stm32_hash_wait_busy(hdev))
-		return -ETIMEDOUT;
-
-	swap_reg = hash_swap_reg(rctx);
-
-	if (!hdev->pdata->ux500)
-		*preg++ = stm32_hash_read(hdev, HASH_IMR);
-	*preg++ = stm32_hash_read(hdev, HASH_STR);
-	*preg++ = stm32_hash_read(hdev, HASH_CR);
-	for (i = 0; i < swap_reg; i++)
-		*preg++ = stm32_hash_read(hdev, HASH_CSR(i));
-
-	state->flags |= HASH_FLAGS_INIT;
-
 	return err;
 }
 
 static int stm32_hash_xmit_dma(struct stm32_hash_dev *hdev,
-			       struct scatterlist *sg, int length, int mdma)
+			       struct scatterlist *sg, int length, int mdmat)
 {
 	struct dma_async_tx_descriptor *in_desc;
 	dma_cookie_t cookie;
 	u32 reg;
 	int err;
 
+	dev_dbg(hdev->dev, "%s mdmat: %x length: %d\n", __func__, mdmat, length);
+
+	/* do not use dma if there is no data to send */
+	if (length <= 0)
+		return 0;
+
 	in_desc = dmaengine_prep_slave_sg(hdev->dma_lch, sg, 1,
 					  DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT |
 					  DMA_CTRL_ACK);
@@ -535,13 +542,12 @@ static int stm32_hash_xmit_dma(struct stm32_hash_dev *hdev,
 	in_desc->callback = stm32_hash_dma_callback;
 	in_desc->callback_param = hdev;
 
-	hdev->flags |= HASH_FLAGS_FINAL;
 	hdev->flags |= HASH_FLAGS_DMA_ACTIVE;
 
 	reg = stm32_hash_read(hdev, HASH_CR);
 
 	if (hdev->pdata->has_mdmat) {
-		if (mdma)
+		if (mdmat)
 			reg |= HASH_CR_MDMAT;
 		else
 			reg &= ~HASH_CR_MDMAT;
@@ -550,7 +556,6 @@ static int stm32_hash_xmit_dma(struct stm32_hash_dev *hdev,
 
 	stm32_hash_write(hdev, HASH_CR, reg);
 
-	stm32_hash_set_nblw(hdev, length);
 
 	cookie = dmaengine_submit(in_desc);
 	err = dma_submit_error(cookie);
@@ -590,7 +595,7 @@ static int stm32_hash_hmac_dma_send(struct stm32_hash_dev *hdev)
 	struct stm32_hash_ctx *ctx = crypto_ahash_ctx(tfm);
 	int err;
 
-	if (ctx->keylen < rctx->state.blocklen || hdev->dma_mode == 1) {
+	if (ctx->keylen < rctx->state.blocklen || hdev->dma_mode > 0) {
 		err = stm32_hash_write_key(hdev);
 		if (stm32_hash_wait_busy(hdev))
 			return -ETIMEDOUT;
@@ -655,18 +660,20 @@ static int stm32_hash_dma_send(struct stm32_hash_dev *hdev)
 	struct scatterlist sg[1], *tsg;
 	int err = 0, reg, ncp = 0;
 	unsigned int i, len = 0, bufcnt = 0;
+	bool final = hdev->flags & HASH_FLAGS_FINAL;
 	bool is_last = false;
+	u32 last_word;
 
-	rctx->sg = hdev->req->src;
-	rctx->total = hdev->req->nbytes;
+	dev_dbg(hdev->dev, "%s total: %d bufcnt: %d final: %d\n",
+		__func__, rctx->total, rctx->state.bufcnt, final);
 
-	rctx->nents = sg_nents(rctx->sg);
 	if (rctx->nents < 0)
 		return -EINVAL;
 
 	stm32_hash_write_ctrl(hdev);
 
-	if (hdev->flags & HASH_FLAGS_HMAC) {
+	if (hdev->flags & HASH_FLAGS_HMAC && (!(hdev->flags & HASH_FLAGS_HMAC_KEY))) {
+		hdev->flags |= HASH_FLAGS_HMAC_KEY;
 		err = stm32_hash_hmac_dma_send(hdev);
 		if (err != -EINPROGRESS)
 			return err;
@@ -677,22 +684,36 @@ static int stm32_hash_dma_send(struct stm32_hash_dev *hdev)
 		len = sg->length;
 
 		if (sg_is_last(sg) || (bufcnt + sg[0].length) >= rctx->total) {
-			sg->length = rctx->total - bufcnt;
-			is_last = true;
-			if (hdev->dma_mode == 1) {
-				len = (ALIGN(sg->length, 16) - 16);
-
-				ncp = sg_pcopy_to_buffer(
-					rctx->sg, rctx->nents,
-					rctx->state.buffer, sg->length - len,
-					rctx->total - sg->length + len);
-
-				sg->length = len;
+			if (!final) {
+				/* Always manually put the last word of a non-final transfer. */
+				len -= sizeof(u32);
+				sg_pcopy_to_buffer(rctx->sg, rctx->nents, &last_word, 4, len);
+				sg->length -= sizeof(u32);
 			} else {
-				if (!(IS_ALIGNED(sg->length, sizeof(u32)))) {
-					len = sg->length;
-					sg->length = ALIGN(sg->length,
-							   sizeof(u32));
+				/*
+				 * In Multiple DMA mode, DMA must be aborted before the final
+				 * transfer.
+				 */
+				sg->length = rctx->total - bufcnt;
+				if (hdev->dma_mode > 0) {
+					len = (ALIGN(sg->length, 16) - 16);
+
+					ncp = sg_pcopy_to_buffer(rctx->sg, rctx->nents,
+								 rctx->state.buffer,
+								 sg->length - len,
+								 rctx->total - sg->length + len);
+
+					if (!len)
+						break;
+
+					sg->length = len;
+				} else {
+					is_last = true;
+					if (!(IS_ALIGNED(sg->length, sizeof(u32)))) {
+						len = sg->length;
+						sg->length = ALIGN(sg->length,
+								   sizeof(u32));
+					}
 				}
 			}
 		}
@@ -706,43 +727,67 @@ static int stm32_hash_dma_send(struct stm32_hash_dev *hdev)
 
 		err = stm32_hash_xmit_dma(hdev, sg, len, !is_last);
 
+		/* The last word of a non final transfer is sent manually. */
+		if (!final) {
+			stm32_hash_write(hdev, HASH_DIN, last_word);
+			len += sizeof(u32);
+		}
+
+		rctx->total -= len;
+
 		bufcnt += sg[0].length;
 		dma_unmap_sg(hdev->dev, sg, 1, DMA_TO_DEVICE);
 
-		if (err == -ENOMEM)
+		if (err == -ENOMEM || err == -ETIMEDOUT)
 			return err;
 		if (is_last)
 			break;
 	}
 
-	if (hdev->dma_mode == 1) {
-		if (stm32_hash_wait_busy(hdev))
-			return -ETIMEDOUT;
-		reg = stm32_hash_read(hdev, HASH_CR);
-		reg &= ~HASH_CR_DMAE;
-		reg |= HASH_CR_DMAA;
-		stm32_hash_write(hdev, HASH_CR, reg);
+	/*
+	 * When the second last block transfer of 4 words is performed by the DMA,
+	 * the software must set the DMA Abort bit (DMAA) to 1 before completing the
+	 * last transfer of 4 words or less.
+	 */
+	if (final) {
+		if (hdev->dma_mode > 0) {
+			if (stm32_hash_wait_busy(hdev))
+				return -ETIMEDOUT;
+			reg = stm32_hash_read(hdev, HASH_CR);
+			reg &= ~HASH_CR_DMAE;
+			reg |= HASH_CR_DMAA;
+			stm32_hash_write(hdev, HASH_CR, reg);
+
+			if (ncp) {
+				memset(buffer + ncp, 0, 4 - DIV_ROUND_UP(ncp, sizeof(u32)));
+				writesl(hdev->io_base + HASH_DIN, buffer,
+					DIV_ROUND_UP(ncp, sizeof(u32)));
+			}
 
-		if (ncp) {
-			memset(buffer + ncp, 0,
-			       DIV_ROUND_UP(ncp, sizeof(u32)) - ncp);
-			writesl(hdev->io_base + HASH_DIN, buffer,
-				DIV_ROUND_UP(ncp, sizeof(u32)));
+			stm32_hash_set_nblw(hdev, ncp);
+			reg = stm32_hash_read(hdev, HASH_STR);
+			reg |= HASH_STR_DCAL;
+			stm32_hash_write(hdev, HASH_STR, reg);
+			err = -EINPROGRESS;
 		}
-		stm32_hash_set_nblw(hdev, ncp);
-		reg = stm32_hash_read(hdev, HASH_STR);
-		reg |= HASH_STR_DCAL;
-		stm32_hash_write(hdev, HASH_STR, reg);
-		err = -EINPROGRESS;
-	}
 
-	if (hdev->flags & HASH_FLAGS_HMAC) {
-		if (stm32_hash_wait_busy(hdev))
-			return -ETIMEDOUT;
-		err = stm32_hash_hmac_dma_send(hdev);
+		/*
+		 * The hash processor needs the key to be loaded a second time in order
+		 * to process the HMAC.
+		 */
+		if (hdev->flags & HASH_FLAGS_HMAC) {
+			if (stm32_hash_wait_busy(hdev))
+				return -ETIMEDOUT;
+			err = stm32_hash_hmac_dma_send(hdev);
+		}
+
+		return err;
 	}
 
-	return err;
+	if (err != -EINPROGRESS)
+		return err;
+
+	return 0;
 }
 
 static struct stm32_hash_dev *stm32_hash_find_dev(struct stm32_hash_ctx *ctx)
@@ -765,33 +810,6 @@ static struct stm32_hash_dev *stm32_hash_find_dev(struct stm32_hash_ctx *ctx)
 	return hdev;
 }
 
-static bool stm32_hash_dma_aligned_data(struct ahash_request *req)
-{
-	struct scatterlist *sg;
-	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
-	struct stm32_hash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
-	struct stm32_hash_dev *hdev = stm32_hash_find_dev(ctx);
-	int i;
-
-	if (!hdev->dma_lch || req->nbytes <= rctx->state.blocklen)
-		return false;
-
-	if (sg_nents(req->src) > 1) {
-		if (hdev->dma_mode == 1)
-			return false;
-		for_each_sg(req->src, sg, sg_nents(req->src), i) {
-			if ((!IS_ALIGNED(sg->length, sizeof(u32))) &&
-			    (!sg_is_last(sg)))
-				return false;
-		}
-	}
-
-	if (req->src->offset % 4)
-		return false;
-
-	return true;
-}
-
 static int stm32_hash_init(struct ahash_request *req)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
@@ -802,8 +820,10 @@ static int stm32_hash_init(struct ahash_request *req)
 	bool sha3_mode = ctx->flags & HASH_FLAGS_SHA3_MODE;
 
 	rctx->hdev = hdev;
+	state->flags = 0;
 
-	state->flags = HASH_FLAGS_CPU;
+	if (!(hdev->dma_lch &&  hdev->pdata->has_mdmat))
+		state->flags |= HASH_FLAGS_CPU;
 
 	if (sha3_mode)
 		state->flags |= HASH_FLAGS_SHA3_MODE;
@@ -857,6 +877,7 @@ static int stm32_hash_init(struct ahash_request *req)
 		dev_err(hdev->dev, "Error, block too large");
 		return -EINVAL;
 	}
+	rctx->nents = 0;
 	rctx->total = 0;
 	rctx->offset = 0;
 	rctx->data_type = HASH_DATA_8_BITS;
@@ -874,6 +895,9 @@ static int stm32_hash_update_req(struct stm32_hash_dev *hdev)
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(hdev->req);
 	struct stm32_hash_state *state = &rctx->state;
 
+	dev_dbg(hdev->dev, "update_req: total: %u, digcnt: %zd, final: 0",
+		rctx->total, rctx->digcnt);
+
 	if (!(state->flags & HASH_FLAGS_CPU))
 		return stm32_hash_dma_send(hdev);
 
@@ -887,6 +911,11 @@ static int stm32_hash_final_req(struct stm32_hash_dev *hdev)
 	struct stm32_hash_state *state = &rctx->state;
 	int buflen = state->bufcnt;
 
+	if (!(state->flags & HASH_FLAGS_CPU)) {
+		hdev->flags |= HASH_FLAGS_FINAL;
+		return stm32_hash_dma_send(hdev);
+	}
+
 	if (state->flags & HASH_FLAGS_FINUP)
 		return stm32_hash_update_req(hdev);
 
@@ -968,15 +997,21 @@ static int stm32_hash_finish(struct ahash_request *req)
 static void stm32_hash_finish_req(struct ahash_request *req, int err)
 {
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
+	struct stm32_hash_state *state = &rctx->state;
 	struct stm32_hash_dev *hdev = rctx->hdev;
 
+	if (hdev->flags & HASH_FLAGS_DMA_ACTIVE)
+		state->flags |= HASH_FLAGS_DMA_ACTIVE;
+	else
+		state->flags &= ~HASH_FLAGS_DMA_ACTIVE;
+
 	if (!err && (HASH_FLAGS_FINAL & hdev->flags)) {
 		stm32_hash_copy_hash(req);
 		err = stm32_hash_finish(req);
 	}
 
-	pm_runtime_mark_last_busy(hdev->dev);
-	pm_runtime_put_autosuspend(hdev->dev);
+	/* Finalized request mist be unprepared here */
+	stm32_hash_unprepare_request(req);
 
 	crypto_finalize_hash_request(hdev->engine, req, err);
 }
@@ -1006,6 +1041,10 @@ static int stm32_hash_one_request(struct crypto_engine *engine, void *areq)
 
 	pm_runtime_get_sync(hdev->dev);
 
+	err = stm32_hash_prepare_request(req);
+	if (err)
+		return err;
+
 	hdev->req = req;
 	hdev->flags = 0;
 	swap_reg = hash_swap_reg(rctx);
@@ -1030,6 +1069,12 @@ static int stm32_hash_one_request(struct crypto_engine *engine, void *areq)
 		if (state->flags & HASH_FLAGS_HMAC)
 			hdev->flags |= HASH_FLAGS_HMAC |
 				       HASH_FLAGS_HMAC_KEY;
+
+		if (state->flags & HASH_FLAGS_CPU)
+			hdev->flags |= HASH_FLAGS_CPU;
+
+		if (state->flags & HASH_FLAGS_DMA_ACTIVE)
+			hdev->flags |= HASH_FLAGS_DMA_ACTIVE;
 	}
 
 	if (rctx->op == HASH_OP_UPDATE)
@@ -1054,6 +1099,284 @@ static int stm32_hash_one_request(struct crypto_engine *engine, void *areq)
 	return 0;
 }
 
+static int stm32_hash_copy_sgs(struct stm32_hash_request_ctx *rctx,
+			       struct scatterlist *sg, int bs,
+			       unsigned int new_len)
+{
+	struct stm32_hash_state *state = &rctx->state;
+	int pages;
+	void *buf;
+
+	pages = get_order(new_len);
+
+	buf = (void *)__get_free_pages(GFP_ATOMIC, pages);
+	if (!buf) {
+		pr_err("Couldn't allocate pages for unaligned cases.\n");
+		return -ENOMEM;
+	}
+
+	if (state->bufcnt)
+		memcpy(buf, rctx->hdev->xmit_buf, state->bufcnt);
+
+	scatterwalk_map_and_copy(buf + state->bufcnt, sg, rctx->offset,
+				 min(new_len, rctx->total) - state->bufcnt, 0);
+	sg_init_table(rctx->sgl, 1);
+	sg_set_buf(rctx->sgl, buf, new_len);
+	rctx->sg = rctx->sgl;
+	state->flags |= HASH_FLAGS_SGS_COPIED;
+	rctx->nents = 1;
+	rctx->offset += new_len - state->bufcnt;
+	state->bufcnt = 0;
+	rctx->total = new_len;
+
+	return 0;
+}
+
+static int stm32_hash_align_sgs(struct scatterlist *sg,
+				int nbytes, int bs, bool init, bool final,
+				struct stm32_hash_request_ctx *rctx)
+{
+	struct stm32_hash_state *state = &rctx->state;
+	struct stm32_hash_dev *hdev = rctx->hdev;
+	struct scatterlist *sg_tmp = sg;
+	int offset = rctx->offset;
+	int new_len;
+	int n = 0;
+	int bufcnt = state->bufcnt;
+	bool secure_ctx = hdev->pdata->context_secured;
+	bool aligned = true;
+
+	if (!sg || !sg->length || !nbytes) {
+		if (bufcnt) {
+			bufcnt = DIV_ROUND_UP(bufcnt, bs) * bs;
+			sg_init_table(rctx->sgl, 1);
+			sg_set_buf(rctx->sgl, rctx->hdev->xmit_buf, bufcnt);
+			rctx->sg = rctx->sgl;
+			rctx->nents = 1;
+		}
+
+		return 0;
+	}
+
+	new_len = nbytes;
+
+	if (offset)
+		aligned = false;
+
+	if (final) {
+		new_len = DIV_ROUND_UP(new_len, bs) * bs;
+	} else {
+		new_len = (new_len - 1) / bs * bs; // return n block - 1 block
+
+		/*
+		 * Context save in some version of HASH IP can only be done when the
+		 * FIFO is ready to get a new block. This implies to send n block plus a
+		 * 32 bit word in the first DMA send.
+		 */
+		if (init && secure_ctx) {
+			new_len += sizeof(u32);
+			if (unlikely(new_len > nbytes))
+				new_len -= bs;
+		}
+	}
+
+	if (!new_len)
+		return 0;
+
+	if (nbytes != new_len)
+		aligned = false;
+
+	while (nbytes > 0 && sg_tmp) {
+		n++;
+
+		if (bufcnt) {
+			if (!IS_ALIGNED(bufcnt, bs)) {
+				aligned = false;
+				break;
+			}
+			nbytes -= bufcnt;
+			bufcnt = 0;
+			if (!nbytes)
+				aligned = false;
+
+			continue;
+		}
+
+		if (offset < sg_tmp->length) {
+			if (!IS_ALIGNED(offset + sg_tmp->offset, 4)) {
+				aligned = false;
+				break;
+			}
+
+			if (!IS_ALIGNED(sg_tmp->length - offset, bs)) {
+				aligned = false;
+				break;
+			}
+		}
+
+		if (offset) {
+			offset -= sg_tmp->length;
+			if (offset < 0) {
+				nbytes += offset;
+				offset = 0;
+			}
+		} else {
+			nbytes -= sg_tmp->length;
+		}
+
+		sg_tmp = sg_next(sg_tmp);
+
+		if (nbytes < 0) {
+			aligned = false;
+			break;
+		}
+	}
+
+	if (!aligned)
+		return stm32_hash_copy_sgs(rctx, sg, bs, new_len);
+
+	rctx->total = new_len;
+	rctx->offset += new_len;
+	rctx->nents = n;
+	if (state->bufcnt) {
+		sg_init_table(rctx->sgl, 2);
+		sg_set_buf(rctx->sgl, rctx->hdev->xmit_buf, state->bufcnt);
+		sg_chain(rctx->sgl, 2, sg);
+		rctx->sg = rctx->sgl;
+	} else {
+		rctx->sg = sg;
+	}
+
+	return 0;
+}
+
+static int stm32_hash_prepare_request(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct stm32_hash_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
+	struct stm32_hash_dev *hdev = stm32_hash_find_dev(ctx);
+	struct stm32_hash_state *state = &rctx->state;
+	unsigned int nbytes;
+	int ret, hash_later, bs;
+	bool update = rctx->op & HASH_OP_UPDATE;
+	bool init = !(state->flags & HASH_FLAGS_INIT);
+	bool finup = state->flags & HASH_FLAGS_FINUP;
+	bool final = state->flags & HASH_FLAGS_FINAL;
+
+	if (!hdev->dma_lch || state->flags & HASH_FLAGS_CPU)
+		return 0;
+
+	bs = crypto_ahash_blocksize(tfm);
+
+	nbytes = state->bufcnt;
+
+	/*
+	 * In case of update request nbytes must correspond to the content of the
+	 * buffer + the offset minus the content of the request already in the
+	 * buffer.
+	 */
+	if (update || finup)
+		nbytes += req->nbytes - rctx->offset;
+
+	dev_dbg(hdev->dev,
+		"%s: nbytes=%d, bs=%d, total=%d, offset=%d, bufcnt=%d\n",
+		__func__, nbytes, bs, rctx->total, rctx->offset, state->bufcnt);
+
+	if (!nbytes)
+		return 0;
+
+	rctx->total = nbytes;
+
+	if (update && req->nbytes && (!IS_ALIGNED(state->bufcnt, bs))) {
+		int len = bs - state->bufcnt % bs;
+
+		if (len > req->nbytes)
+			len = req->nbytes;
+		scatterwalk_map_and_copy(state->buffer + state->bufcnt, req->src,
+					 0, len, 0);
+		state->bufcnt += len;
+		rctx->offset = len;
+	}
+
+	/* copy buffer in a temporary one that is used for sg alignment */
+	if (state->bufcnt)
+		memcpy(hdev->xmit_buf, state->buffer, state->bufcnt);
+
+	ret = stm32_hash_align_sgs(req->src, nbytes, bs, init, final, rctx);
+	if (ret)
+		return ret;
+
+	hash_later = nbytes - rctx->total;
+	if (hash_later < 0)
+		hash_later = 0;
+
+	if (hash_later && hash_later <= state->blocklen) {
+		scatterwalk_map_and_copy(state->buffer,
+					 req->src,
+					 req->nbytes - hash_later,
+					 hash_later, 0);
+
+		state->bufcnt = hash_later;
+	} else {
+		state->bufcnt = 0;
+	}
+
+	if (hash_later > state->blocklen) {
+		/* FIXME: add support of this case */
+		pr_err("Buffer contains more than one block.\n");
+		return -ENOMEM;
+	}
+
+	rctx->total = min(nbytes, rctx->total);
+
+	return 0;
+}
+
+static void stm32_hash_unprepare_request(struct ahash_request *req)
+{
+	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
+	struct stm32_hash_state *state = &rctx->state;
+	struct stm32_hash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
+	struct stm32_hash_dev *hdev = stm32_hash_find_dev(ctx);
+	u32 *preg = state->hw_context;
+	int swap_reg, i;
+
+	if (hdev->dma_lch)
+		dmaengine_terminate_sync(hdev->dma_lch);
+
+	if (state->flags & HASH_FLAGS_SGS_COPIED)
+		free_pages((unsigned long)sg_virt(rctx->sg), get_order(rctx->sg->length));
+
+	rctx->sg = NULL;
+	rctx->offset = 0;
+
+	state->flags &= ~(HASH_FLAGS_SGS_COPIED);
+
+	if (!(hdev->flags & HASH_FLAGS_INIT))
+		goto pm_runtime;
+
+	state->flags |= HASH_FLAGS_INIT;
+
+	if (stm32_hash_wait_busy(hdev)) {
+		dev_warn(hdev->dev, "Wait busy failed.");
+		return;
+	}
+
+	swap_reg = hash_swap_reg(rctx);
+
+	if (!hdev->pdata->ux500)
+		*preg++ = stm32_hash_read(hdev, HASH_IMR);
+	*preg++ = stm32_hash_read(hdev, HASH_STR);
+	*preg++ = stm32_hash_read(hdev, HASH_CR);
+	for (i = 0; i < swap_reg; i++)
+		*preg++ = stm32_hash_read(hdev, HASH_CSR(i));
+
+pm_runtime:
+	pm_runtime_mark_last_busy(hdev->dev);
+	pm_runtime_put_autosuspend(hdev->dev);
+}
+
 static int stm32_hash_enqueue(struct ahash_request *req, unsigned int op)
 {
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
@@ -1070,16 +1393,26 @@ static int stm32_hash_update(struct ahash_request *req)
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
 	struct stm32_hash_state *state = &rctx->state;
 
-	if (!req->nbytes || !(state->flags & HASH_FLAGS_CPU))
+	if (!req->nbytes)
 		return 0;
 
-	rctx->total = req->nbytes;
-	rctx->sg = req->src;
-	rctx->offset = 0;
 
-	if ((state->bufcnt + rctx->total < state->blocklen)) {
-		stm32_hash_append_sg(rctx);
-		return 0;
+	if (state->flags & HASH_FLAGS_CPU) {
+		rctx->total = req->nbytes;
+		rctx->sg = req->src;
+		rctx->offset = 0;
+
+		if ((state->bufcnt + rctx->total < state->blocklen)) {
+			stm32_hash_append_sg(rctx);
+			return 0;
+		}
+	} else { /* DMA mode */
+		if (state->bufcnt + req->nbytes <= state->blocklen) {
+			scatterwalk_map_and_copy(state->buffer + state->bufcnt, req->src,
+						 0, req->nbytes, 0);
+			state->bufcnt += req->nbytes;
+			return 0;
+		}
 	}
 
 	return stm32_hash_enqueue(req, HASH_OP_UPDATE);
@@ -1098,20 +1431,18 @@ static int stm32_hash_final(struct ahash_request *req)
 static int stm32_hash_finup(struct ahash_request *req)
 {
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
-	struct stm32_hash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
-	struct stm32_hash_dev *hdev = stm32_hash_find_dev(ctx);
 	struct stm32_hash_state *state = &rctx->state;
 
 	if (!req->nbytes)
 		goto out;
 
 	state->flags |= HASH_FLAGS_FINUP;
-	rctx->total = req->nbytes;
-	rctx->sg = req->src;
-	rctx->offset = 0;
 
-	if (hdev->dma_lch && stm32_hash_dma_aligned_data(req))
-		state->flags &= ~HASH_FLAGS_CPU;
+	if ((state->flags & HASH_FLAGS_CPU)) {
+		rctx->total = req->nbytes;
+		rctx->sg = req->src;
+		rctx->offset = 0;
+	}
 
 out:
 	return stm32_hash_final(req);
@@ -1215,7 +1546,6 @@ static int stm32_hash_cra_sha3_hmac_init(struct crypto_tfm *tfm)
 					HASH_FLAGS_HMAC);
 }
 
-
 static void stm32_hash_cra_exit(struct crypto_tfm *tfm)
 {
 	struct stm32_hash_ctx *ctx = crypto_tfm_ctx(tfm);
@@ -1228,14 +1558,9 @@ static irqreturn_t stm32_hash_irq_thread(int irq, void *dev_id)
 {
 	struct stm32_hash_dev *hdev = dev_id;
 
-	if (HASH_FLAGS_CPU & hdev->flags) {
-		if (HASH_FLAGS_OUTPUT_READY & hdev->flags) {
-			hdev->flags &= ~HASH_FLAGS_OUTPUT_READY;
-			goto finish;
-		}
-	} else if (HASH_FLAGS_DMA_ACTIVE & hdev->flags) {
-		hdev->flags &= ~HASH_FLAGS_DMA_ACTIVE;
-			goto finish;
+	if (HASH_FLAGS_OUTPUT_READY & hdev->flags) {
+		hdev->flags &= ~HASH_FLAGS_OUTPUT_READY;
+		goto finish;
 	}
 
 	return IRQ_HANDLED;
@@ -2004,6 +2329,7 @@ static const struct stm32_hash_pdata stm32_hash_pdata_stm32mp13 = {
 	.algs_info_size	= ARRAY_SIZE(stm32_hash_algs_info_stm32mp13),
 	.has_sr		= true,
 	.has_mdmat	= true,
+	.context_secured = true,
 };
 
 static const struct of_device_id stm32_hash_of_match[] = {
-- 
2.25.1


