Return-Path: <linux-kernel+bounces-155127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BE48AE59B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2654A1F2291E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2888684FCB;
	Tue, 23 Apr 2024 12:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="W7gPOmEF"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE5F21A19
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713874111; cv=none; b=kxkqQzLOuhY326sreOxf0M/3KcKH6W2jJ0QpWySRi3fk3h5t574W9/Nhq/gOtPyaHpPciiXLPuUWZ2PnejACc5ncYbd8WvnAzkKocKtUVZNEiywxbPifxTE5Fu6N2O/m1+198EvC3qMLRdx3Rf5CWVOhkwDkSUTTiXm3X5tgGVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713874111; c=relaxed/simple;
	bh=vj4jIeVW+7PoiExoJwbgChfdoJtJx7c2amXeCx4ELO4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=moge43qsXYjmL0gF+/bngNv2NVKsx2oILaYN3aHBB4DZt9H0rC6XwlFC0zsJHHVQZYOYNsdik3FeQMmGx9cIt/02ImDKd4gZpQwcIbXSWo7wTnLf2htnwwNcI5zSkjZxTp1YfjgzqQSXOiamaQBdhwDzqX4Hm7vlXy5IgyvaZfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=W7gPOmEF; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240423120821euoutp020fc311d5b42cd0083450adbd68be835d~I52o5jpCO2522625226euoutp028
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:08:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240423120821euoutp020fc311d5b42cd0083450adbd68be835d~I52o5jpCO2522625226euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713874101;
	bh=KaZelo7BQ9JGVPOzVxxV1W4fwjbZsq3J/OFVmVnpm9k=;
	h=From:To:Cc:Subject:Date:References:From;
	b=W7gPOmEF2kK/qHHg9TIXeVed0D9Hro82YaULrfQAW1stQiAgSR+PJyPPhfE5iFObJ
	 xT5H3AUGhJmAJBxBte3MNjzUSlXUg5wD22PlaVpqlK4XXLPb8p2sKY6OMtDnOsb5t5
	 1sNTPIo6SjFH46IAPwHdz3NPZzn4aKYRx0yoZtp4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240423120821eucas1p1410aa3756655cdcced13f4c8659c1176~I52om1mvW0783007830eucas1p1H;
	Tue, 23 Apr 2024 12:08:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 2F.55.09875.5B4A7266; Tue, 23
	Apr 2024 13:08:21 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240423120821eucas1p2e8eb7aa059e00ee2bc6272cda24d1457~I52oW-4Ld2518225182eucas1p2j;
	Tue, 23 Apr 2024 12:08:21 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240423120821eusmtrp2850376a33c96a629508291b343b75ea9~I52oWhC1b2998329983eusmtrp2C;
	Tue, 23 Apr 2024 12:08:21 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-ee-6627a4b55f32
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 50.48.08810.4B4A7266; Tue, 23
	Apr 2024 13:08:20 +0100 (BST)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240423120820eusmtip1af1830231cd9012b1b728fa02817a4a7~I52n8ANzn0744407444eusmtip1a;
	Tue, 23 Apr 2024 12:08:20 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH] serial: msm: Unify TX and RX DMA paths
Date: Tue, 23 Apr 2024 14:08:08 +0200
Message-Id: <20240423120809.2678030-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42LZduznOd2tS9TTDNas4LdoXryezeLdXBmL
	ifvPsltc3jWHzWLtkbvsDqwem1Z1snnsn7uG3aNvyypGj8+b5AJYorhsUlJzMstSi/TtErgy
	Jux+x1ww3bpiR+NK9gbGtQZdjJwcEgImEpOvLmUHsYUEVjBKnN/A0sXIBWR/YZSY8PwgM4Tz
	mVFi3fMrQA4HWMeJWeEQ8eWMElfbPiB0LHz6mAVkFJuAoUTX2y42EFtEwF7izrybTCBFzAKt
	jBIvNp5gBEkIC5hLrGx7xgYylUVAVeLFyTCQMC9Qfc/0S6wQ58lL7D94lhkiLihxcuYTsPnM
	QPHmrbPBrpMQ6OWQ6GjbxATR4CKxsX8nG4QtLPHq+BZ2CFtG4v/O+UwQDe2MEgt+34dyJjBK
	NDy/xQhRZS1x59wvsIuYBTQl1u/Shwg7SjxYtYsV4n0+iRtvBSGO4JOYtG06NFR4gW4QgqhW
	k5h1fB3c2oMXLjFD2B4Sq2ddZ4EEdazEtCWbWCcwKsxC8tosJK/NQrhhASPzKkbx1NLi3PTU
	YqO81HK94sTc4tK8dL3k/NxNjMBUcvrf8S87GJe/+qh3iJGJg/EQowQHs5II768/KmlCvCmJ
	lVWpRfnxRaU5qcWHGKU5WJTEeVVT5FOFBNITS1KzU1MLUotgskwcnFINTCv/a/Jkbr9U0bfA
	8ZekxI2U63FCzjLW1nsuapzQFQ5dwv/6wOSGJ/M9da6tnmAxceWRl1/XzV39+ibHoVnNi4+6
	NP2VP651OSW0OqiC5yhXjuf8Z5MXN+0/97L9lLHGlz1LXP3jeCpz7P5zvuOrSFtvHXCQ59mm
	qO9nb/zoWbYggn9yoKy7Z+lt3Zu7Cj/bakwtktu4UTnqn+aTuR3buEReHF2c9NBLau6G0rhQ
	MecNrA/eC8vfebC7l+FT5GUL9/btNof5N97ntlq1pWLDjMd3Sj59Nlmw90jX68dV8+OWaXic
	euL967WTxwnnYy/lzPpPctfn/z6bor7vjsnOjVVu0ZccWS8zWghdY/N7X1yixFKckWioxVxU
	nAgAH+EY35QDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsVy+t/xu7pblqinGTQ9tLBoXryezeLdXBmL
	ifvPsltc3jWHzWLtkbvsDqwem1Z1snnsn7uG3aNvyypGj8+b5AJYovRsivJLS1IVMvKLS2yV
	og0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyJux+x1ww3bpiR+NK9gbGtQZd
	jBwcEgImEidmhXcxcnEICSxllOjaeY+li5ETKC4jcXJaAyuELSzx51oXG0TRJ0aJS59us4Mk
	2AQMJbregiQ4OUQEHCW2z1nIBGIzC7QzSlyY4gRiCwuYS6xse8YGsoxFQFXixckwkDCvgL1E
	z/RLUPPlJfYfPMsMEReUODnzCQvEGHmJ5q2zmScw8s1CkpqFJLWAkWkVo0hqaXFuem6xoV5x
	Ym5xaV66XnJ+7iZGYABvO/Zz8w7Gea8+6h1iZOJgPMQowcGsJML7649KmhBvSmJlVWpRfnxR
	aU5q8SFGU6DzJjJLiSbnA2MoryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQim
	j4mDU6qB6YReHLPVLvlZOYx/ThRFbODdsH9LdsluFa33xx58r2Hc+7L17Zx5G+3fifgycMY4
	sIjzPA9z3H+28qfcarUL3l7fjNca+678VTrnYOuv3BPM0nUHTt9MUtaX05qz6aLo61v64te2
	1kV3ZwiH7Ht9cVlGlknP5nltl/gCOlu/LJzJdu+U9oRKO9l3ZjMXGVlzPpdY1HD0wt77177x
	7FuUonOPldlZo/VA6ULeWy2G73YuEJi56+CxW8F6/Ncl/G/Pd/CPe214bSFjQMjL/Zl//wm9
	7P3kcKiPe/u3/i6nFYL3J8px3mI9K7HnSWvGVTnnmkPrp8/uN39b9KvaO0b3GL/bhVmq8kzX
	jATnb8v5I6PEUpyRaKjFXFScCAAtcphT6QIAAA==
X-CMS-MailID: 20240423120821eucas1p2e8eb7aa059e00ee2bc6272cda24d1457
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240423120821eucas1p2e8eb7aa059e00ee2bc6272cda24d1457
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240423120821eucas1p2e8eb7aa059e00ee2bc6272cda24d1457
References: <CGME20240423120821eucas1p2e8eb7aa059e00ee2bc6272cda24d1457@eucas1p2.samsung.com>

Use scatterlist-based API also for RX mode to unify TX and RX DMA paths
as well as simplify the whole driver code a bit.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/tty/serial/msm_serial.c | 86 +++++++++++++--------------------
 1 file changed, 34 insertions(+), 52 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 0a9c5219df88..d5e00e613f73 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -161,14 +161,8 @@ enum {
 struct msm_dma {
 	struct dma_chan		*chan;
 	enum dma_data_direction dir;
-	union {
-		struct {
-			dma_addr_t		phys;
-			unsigned char		*virt;
-			unsigned int		count;
-		} rx;
-		struct scatterlist tx_sg;
-	};
+	unsigned char		*virt;
+	struct scatterlist	sg;
 	dma_cookie_t		cookie;
 	u32			enable_bit;
 	struct dma_async_tx_descriptor	*desc;
@@ -254,13 +248,7 @@ static void msm_stop_dma(struct uart_port *port, struct msm_dma *dma)
 	unsigned int mapped;
 	u32 val;
 
-	if (dma->dir == DMA_TO_DEVICE) {
-		mapped = sg_dma_len(&dma->tx_sg);
-	} else {
-		mapped = dma->rx.count;
-		dma->rx.count = 0;
-	}
-
+	mapped = sg_dma_len(&dma->sg);
 	dmaengine_terminate_all(dma->chan);
 
 	/*
@@ -275,11 +263,8 @@ static void msm_stop_dma(struct uart_port *port, struct msm_dma *dma)
 	msm_write(port, val, UARTDM_DMEN);
 
 	if (mapped) {
-		if (dma->dir == DMA_TO_DEVICE) {
-			dma_unmap_sg(dev, &dma->tx_sg, 1, dma->dir);
-			sg_init_table(&dma->tx_sg, 1);
-		} else
-			dma_unmap_single(dev, dma->rx.phys, mapped, dma->dir);
+		dma_unmap_sg(dev, &dma->sg, 1, dma->dir);
+		sg_init_table(&dma->sg, 1);
 	}
 }
 
@@ -299,7 +284,7 @@ static void msm_release_dma(struct msm_port *msm_port)
 	if (dma->chan) {
 		msm_stop_dma(&msm_port->uart, dma);
 		dma_release_channel(dma->chan);
-		kfree(dma->rx.virt);
+		kfree(dma->virt);
 	}
 
 	memset(dma, 0, sizeof(*dma));
@@ -371,8 +356,8 @@ static void msm_request_rx_dma(struct msm_port *msm_port, resource_size_t base)
 
 	of_property_read_u32(dev->of_node, "qcom,rx-crci", &crci);
 
-	dma->rx.virt = kzalloc(UARTDM_RX_SIZE, GFP_KERNEL);
-	if (!dma->rx.virt)
+	dma->virt = kzalloc(UARTDM_RX_SIZE, GFP_KERNEL);
+	if (!dma->virt)
 		goto rel_rx;
 
 	memset(&conf, 0, sizeof(conf));
@@ -399,7 +384,7 @@ static void msm_request_rx_dma(struct msm_port *msm_port, resource_size_t base)
 
 	return;
 err:
-	kfree(dma->rx.virt);
+	kfree(dma->virt);
 rel_rx:
 	dma_release_channel(dma->chan);
 no_rx:
@@ -434,7 +419,7 @@ static void msm_start_tx(struct uart_port *port)
 	struct msm_dma *dma = &msm_port->tx_dma;
 
 	/* Already started in DMA mode */
-	if (sg_dma_len(&dma->tx_sg))
+	if (sg_dma_len(&dma->sg))
 		return;
 
 	msm_port->imr |= MSM_UART_IMR_TXLEV;
@@ -462,12 +447,12 @@ static void msm_complete_tx_dma(void *args)
 	uart_port_lock_irqsave(port, &flags);
 
 	/* Already stopped */
-	if (!sg_dma_len(&dma->tx_sg))
+	if (!sg_dma_len(&dma->sg))
 		goto done;
 
 	dmaengine_tx_status(dma->chan, dma->cookie, &state);
 
-	dma_unmap_sg(port->dev, &dma->tx_sg, 1, dma->dir);
+	dma_unmap_sg(port->dev, &dma->sg, 1, dma->dir);
 
 	val = msm_read(port, UARTDM_DMEN);
 	val &= ~dma->enable_bit;
@@ -478,9 +463,9 @@ static void msm_complete_tx_dma(void *args)
 		msm_write(port, MSM_UART_CR_TX_ENABLE, MSM_UART_CR);
 	}
 
-	count = sg_dma_len(&dma->tx_sg) - state.residue;
+	count = sg_dma_len(&dma->sg) - state.residue;
 	uart_xmit_advance(port, count);
-	sg_init_table(&dma->tx_sg, 1);
+	sg_init_table(&dma->sg, 1);
 
 	/* Restore "Tx FIFO below watermark" interrupt */
 	msm_port->imr |= MSM_UART_IMR_TXLEV;
@@ -503,16 +488,16 @@ static int msm_handle_tx_dma(struct msm_port *msm_port, unsigned int count)
 	int ret;
 	u32 val;
 
-	sg_init_table(&dma->tx_sg, 1);
-	kfifo_dma_out_prepare(&tport->xmit_fifo, &dma->tx_sg, 1, count);
+	sg_init_table(&dma->sg, 1);
+	kfifo_dma_out_prepare(&tport->xmit_fifo, &dma->sg, 1, count);
 
-	mapped = dma_map_sg(port->dev, &dma->tx_sg, 1, dma->dir);
+	mapped = dma_map_sg(port->dev, &dma->sg, 1, dma->dir);
 	if (!mapped) {
 		ret = -EIO;
 		goto zero_sg;
 	}
 
-	dma->desc = dmaengine_prep_slave_sg(dma->chan, &dma->tx_sg, 1,
+	dma->desc = dmaengine_prep_slave_sg(dma->chan, &dma->sg, 1,
 						DMA_MEM_TO_DEV,
 						DMA_PREP_INTERRUPT |
 						DMA_PREP_FENCE);
@@ -550,9 +535,9 @@ static int msm_handle_tx_dma(struct msm_port *msm_port, unsigned int count)
 	dma_async_issue_pending(dma->chan);
 	return 0;
 unmap:
-	dma_unmap_sg(port->dev, &dma->tx_sg, 1, dma->dir);
+	dma_unmap_sg(port->dev, &dma->sg, 1, dma->dir);
 zero_sg:
-	sg_init_table(&dma->tx_sg, 1);
+	sg_init_table(&dma->sg, 1);
 	return ret;
 }
 
@@ -569,7 +554,7 @@ static void msm_complete_rx_dma(void *args)
 	uart_port_lock_irqsave(port, &flags);
 
 	/* Already stopped */
-	if (!dma->rx.count)
+	if (!sg_dma_len(&dma->sg))
 		goto done;
 
 	val = msm_read(port, UARTDM_DMEN);
@@ -586,14 +571,13 @@ static void msm_complete_rx_dma(void *args)
 
 	port->icount.rx += count;
 
-	dma->rx.count = 0;
-
-	dma_unmap_single(port->dev, dma->rx.phys, UARTDM_RX_SIZE, dma->dir);
+	dma_unmap_sg(port->dev, &dma->sg, 1, dma->dir);
+	sg_init_table(&dma->sg, 1);
 
 	for (i = 0; i < count; i++) {
 		char flag = TTY_NORMAL;
 
-		if (msm_port->break_detected && dma->rx.virt[i] == 0) {
+		if (msm_port->break_detected && dma->virt[i] == 0) {
 			port->icount.brk++;
 			flag = TTY_BREAK;
 			msm_port->break_detected = false;
@@ -604,9 +588,9 @@ static void msm_complete_rx_dma(void *args)
 		if (!(port->read_status_mask & MSM_UART_SR_RX_BREAK))
 			flag = TTY_NORMAL;
 
-		sysrq = uart_prepare_sysrq_char(port, dma->rx.virt[i]);
+		sysrq = uart_prepare_sysrq_char(port, dma->virt[i]);
 		if (!sysrq)
-			tty_insert_flip_char(tport, dma->rx.virt[i], flag);
+			tty_insert_flip_char(tport, dma->virt[i], flag);
 	}
 
 	msm_start_rx_dma(msm_port);
@@ -630,14 +614,13 @@ static void msm_start_rx_dma(struct msm_port *msm_port)
 	if (!dma->chan)
 		return;
 
-	dma->rx.phys = dma_map_single(uart->dev, dma->rx.virt,
-				   UARTDM_RX_SIZE, dma->dir);
-	ret = dma_mapping_error(uart->dev, dma->rx.phys);
-	if (ret)
+	sg_init_one(&dma->sg, dma->virt, UARTDM_RX_SIZE);
+	ret = dma_map_sg(uart->dev, &dma->sg, 1, dma->dir);
+	if (!ret)
 		goto sw_mode;
 
-	dma->desc = dmaengine_prep_slave_single(dma->chan, dma->rx.phys,
-						UARTDM_RX_SIZE, DMA_DEV_TO_MEM,
+	dma->desc = dmaengine_prep_slave_sg(dma->chan, &dma->sg, 1,
+						DMA_DEV_TO_MEM,
 						DMA_PREP_INTERRUPT);
 	if (!dma->desc)
 		goto unmap;
@@ -664,8 +647,6 @@ static void msm_start_rx_dma(struct msm_port *msm_port)
 
 	msm_write(uart, msm_port->imr, MSM_UART_IMR);
 
-	dma->rx.count = UARTDM_RX_SIZE;
-
 	dma_async_issue_pending(dma->chan);
 
 	msm_write(uart, MSM_UART_CR_CMD_RESET_STALE_INT, MSM_UART_CR);
@@ -684,7 +665,8 @@ static void msm_start_rx_dma(struct msm_port *msm_port)
 
 	return;
 unmap:
-	dma_unmap_single(uart->dev, dma->rx.phys, UARTDM_RX_SIZE, dma->dir);
+	dma_unmap_sg(uart->dev, &dma->sg, 1, dma->dir);
+	sg_init_table(&dma->sg, 1);
 
 sw_mode:
 	/*
@@ -967,7 +949,7 @@ static irqreturn_t msm_uart_irq(int irq, void *dev_id)
 	}
 
 	if (misr & (MSM_UART_IMR_RXLEV | MSM_UART_IMR_RXSTALE)) {
-		if (dma->rx.count) {
+		if (sg_dma_len(&dma->sg)) {
 			val = MSM_UART_CR_CMD_STALE_EVENT_DISABLE;
 			msm_write(port, val, MSM_UART_CR);
 			val = MSM_UART_CR_CMD_RESET_STALE_INT;
-- 
2.34.1


