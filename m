Return-Path: <linux-kernel+bounces-160954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385B88B4508
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 09:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F2B283975
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 07:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCBF4779F;
	Sat, 27 Apr 2024 07:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCCEj2AV"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AD846424;
	Sat, 27 Apr 2024 07:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714204480; cv=none; b=Ou+wFBDrA9tme7eKQeqzCfG8khtHRsiVJZrX0ghXYjURox+SmR7JQTOLlcRra6GR/fnvwR0Mc1NK3R4GYNQCmvbOy43hOka83yDPipM/1YN98KBHwVVss0EPDb7G9+yUw5d8XXi4klQe5Y/3p9B6e3aRHYcKEHJ2hwu6WtkxHsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714204480; c=relaxed/simple;
	bh=DWo4JqQ74JC8gM+9LQvhwB8sVl40deTLm00z4zyqbwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O5VlKpWE8z6pplMkqX685yNcWwplO+cEHDvu4ehFANyE6+AjZS3fgNoME/dbKjz9V5mcJwG93FBn7/m3WvmbrGzuNmajD8iK1MzNVD40Y5JvXS5kiCx+SjBi8+MfbezfiX3jgflUEYIbU9QqNvrV6h9eTR44T33kWt8SQZSNk68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCCEj2AV; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f26588dd5eso2501615b3a.0;
        Sat, 27 Apr 2024 00:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714204478; x=1714809278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7TMXDCvu+SKHpbmKD1m7Pq7A0/TWju7J0p7ed3sm/8=;
        b=LCCEj2AVNQFpFqP/dRO8b9C5ZgiQiFn+x8llM9ySoFKXYvIwN/9Hv9T3OhVpSxFDT3
         mq2s7prSFT4V/0IhwwUAsUCskNDUt5PSwX6ZrFFuzcix2pJBxwekgQEXGjy5fpW97tpJ
         g0jC46mzl3Ys3HuDsQhNkb/zYar2l8ByZHPYOW+ICoJS+zuOumg9LXjMKq5YTMjWgRdA
         oFY/0Pt2GP7aVYHAjDoOdYzPni3GXgOte7nh0gDqYQryP+pk1OgpslbZIucWPtfvKOxF
         Oyn3DawN2e0LDzIQw0PUA6hMFWaa6s8Q8A4OrP+EeMaPcgoCOapVGIeGdlhQtUY8cuRC
         mF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714204478; x=1714809278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7TMXDCvu+SKHpbmKD1m7Pq7A0/TWju7J0p7ed3sm/8=;
        b=ZIdnzVfv41/w+/tMh5hlF62k0B7yfA4JBog09e12Zsx4m7j1slgOnqzur7XCZFQfwS
         Ai33B21UZSc/SyTqUmv9FVW2PPza5DfunpWx3t2upGj9VxC+tFi13gY7XrrtBK/nvuTz
         fgw1QzmTSrfFALek1La4GtE5wJ/Mygb39QhSyjMwReJDtd68gS3ahs36gTgSlGq4na8O
         FHqlPYEDkUterf3itcYiXfc/EziofymtWT5iLBwItes5tk7UleSac3C4KLXTelB0KqSS
         Om3ZVleATAEC85jJu/cwukWa1+S8aaKZgq+axniPgLCFr6Aq0txeMv8UhoTBGHd4j9Hg
         YYYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJQ07HfnxjaiAV9i5mblqhHTB7RBhPrxFS9lgo1nLzD6CVbuoabWz03yuApaRLKOGE6w20Hk8COVcdWHFQ/GbeXYEAumdrhMjxuT30Z2CVqpjfanGNznseUQHHJzZvsu12K3QIOLMKaXC/NvH342iYZSaiUpR9FbdZecCe06K+wAYfjQ==
X-Gm-Message-State: AOJu0YzLyVnmgduldxitVXwkdVjA6eA35cJYrcvB6unUss52WXURiaPz
	S9baieQBTrhPNsgIF880yZbLA9iBh17vaBTPcKgSx4P54+0o/LiN
X-Google-Smtp-Source: AGHT+IGzIDLoLkD8sTwrlpX4G39Zd3wFCBM8sBggCL0vDj3rBjh2ZHPbwk2/tTWAtQuxRqizRdbTWw==
X-Received: by 2002:a05:6a00:1788:b0:6ed:1c7:8c6b with SMTP id s8-20020a056a00178800b006ed01c78c6bmr6489072pfg.1.1714204478087;
        Sat, 27 Apr 2024 00:54:38 -0700 (PDT)
Received: from localhost ([46.3.240.103])
        by smtp.gmail.com with ESMTPSA id r16-20020a056a00217000b006ed87983f95sm15860556pff.52.2024.04.27.00.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 00:54:37 -0700 (PDT)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: dlan@gentoo.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH v1 2/2] spi: add support for sophgo spi-nor controller
Date: Sat, 27 Apr 2024 15:54:26 +0800
Message-Id: <20240427075426.662671-3-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240427075426.662671-1-qiujingbao.dlmu@gmail.com>
References: <20240427075426.662671-1-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a driver for sophgo spi-nor controller using spi-mem interface.

Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
---
 drivers/spi/Kconfig             |   9 +
 drivers/spi/Makefile            |   1 +
 drivers/spi/spi-sophgo-cv1800.c | 370 ++++++++++++++++++++++++++++++++
 3 files changed, 380 insertions(+)
 create mode 100644 drivers/spi/spi-sophgo-cv1800.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index bc7021da2fe9..41ad7c0aaab8 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -971,6 +971,15 @@ config SPI_SN_F_OSPI
 	  for connecting an SPI Flash memory over up to 8-bit wide bus.
 	  It supports indirect access mode only.
 
+config SPI_SOPHGO_CV1800
+	tristate "Sophgo SPI NOR Controller"
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	help
+	  This enables support for the Sophgo SPI NOR controller,
+	  which supports Dual/Qual read and write operations while
+	  also supporting 3Byte address devices and 4Byte address
+	  devices.
+
 config SPI_SPRD
 	tristate "Spreadtrum SPI controller"
 	depends on ARCH_SPRD || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 4ff8d725ba5e..a25549155106 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -128,6 +128,7 @@ obj-$(CONFIG_SPI_SH_SCI)		+= spi-sh-sci.o
 obj-$(CONFIG_SPI_SIFIVE)		+= spi-sifive.o
 obj-$(CONFIG_SPI_SLAVE_MT27XX)          += spi-slave-mt27xx.o
 obj-$(CONFIG_SPI_SN_F_OSPI)		+= spi-sn-f-ospi.o
+obj-$(CONFIG_SPI_SOPHGO_CV1800)		+= spi-sophgo-cv1800.o
 obj-$(CONFIG_SPI_SPRD)			+= spi-sprd.o
 obj-$(CONFIG_SPI_SPRD_ADI)		+= spi-sprd-adi.o
 obj-$(CONFIG_SPI_STM32) 		+= spi-stm32.o
diff --git a/drivers/spi/spi-sophgo-cv1800.c b/drivers/spi/spi-sophgo-cv1800.c
new file mode 100644
index 000000000000..2e453b7d45f0
--- /dev/null
+++ b/drivers/spi/spi-sophgo-cv1800.c
@@ -0,0 +1,370 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Sophgo SPI NOR controller driver
+//
+// Copyright (C) 2020 Jingbao Qiu <qiujingbao.dlmu@gmail.com>
+
+#include <linux/bitfield.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+
+#define SOPHGO_SPI_CTRL                 0x000
+#define SOPHGO_SPI_CE_CTRL              0x004
+#define SOPHGO_SPI_DLY_CTRL             0x008
+#define SOPHGO_SPI_DMMR                 0x00C
+#define SOPHGO_SPI_TRAN_CSR             0x010
+#define SOPHGO_SPI_TRAN_NUM             0x014
+#define SOPHGO_SPI_FIFO_PORT            0x018
+#define SOPHGO_SPI_FIFO_PT              0x020
+#define SOPHGO_SPI_INT_STS              0x028
+
+#define SOPHGO_NOR_CTRL_SCK_DIV_MASK    GENMASK(10, 0)
+#define SOPHGO_NOR_CTRL_DEFAULT_DIV     4
+#define SOPHGO_NOR_DLY_CTRL_NEG_SAMPLE  BIT(14)
+
+#define SOPHGO_NOR_CE_MANUAL            BIT(0)
+#define SOPHGO_NOR_CE_MANUAL_EN         BIT(1)
+#define SOPHGO_NOR_CE_ENABLE            (SOPHGO_NOR_CE_MANUAL | SOPHGO_NOR_CE_MANUAL_EN)
+#define SOPHGO_NOR_CE_DISABLE           SOPHGO_NOR_CE_MANUAL_EN
+#define SOPHGO_NOR_CE_HARDWARE          0
+
+#define SOPHGO_NOR_TRAN_MODE_RX         BIT(0)
+#define SOPHGO_NOR_TRAN_MODE_TX         BIT(1)
+#define SOPHGO_NOR_TRAN_MODE_MASK       GENMASK(1, 0)
+#define SOPHGO_NOR_TRANS_FAST           BIT(3)
+#define SOPHGO_NOR_TRANS_BUS_WIDTH(n)   (n << 4)
+#define SOPHGO_NOR_TRANS_BUS_WIDTH_MASK GENMASK(5, 4)
+
+#define SOPHGO_NOR_TRANS_MIOS           BIT(7)
+
+#define SOPHGO_NOR_TRAN_ADDR(n)         (n << 8)
+#define SOPHGO_NOR_TRANS_ADDR_MASK      GENMASK(10, 8)
+#define SOPHGO_NOR_TRANS_CMD            BIT(11)
+#define SOPHGO_NOR_TRAN_FIFO_MASK       GENMASK(13, 12)
+#define SOPHGO_NOR_TRAN_FIFO_8_BYTE     GENMASK(13, 12)
+#define SOPHGO_NOR_TRAN_GO_BUSY         BIT(15)
+
+#define SOPHGO_NOR_TRANS_DMMR_EN        BIT(20)
+#define SOPHGO_NOR_TRANS_DMMR_CMD       BIT(21)
+
+#define SOPHGO_NOR_TRANS_MMIO									\
+	(SOPHGO_NOR_TRANS_FAST | SOPHGO_NOR_TRANS_DMMR_EN |			\
+		SOPHGO_NOR_TRANS_DMMR_CMD | SOPHGO_NOR_TRANS_MIOS |		\
+		SOPHGO_NOR_TRAN_MODE_RX | SOPHGO_NOR_TRAN_FIFO_8_BYTE)
+
+#define SOPHGO_NOR_TRANS_PORT								\
+	(SOPHGO_NOR_TRAN_MODE_MASK | SOPHGO_NOR_TRANS_ADDR_MASK |	\
+		SOPHGO_NOR_TRAN_FIFO_MASK | SOPHGO_NOR_TRANS_BUS_WIDTH_MASK |	\
+		SOPHGO_NOR_TRANS_BUS_WIDTH_MASK)
+
+#define SOPHGO_NOR_FIFO_CAPACITY  8
+#define SOPHGO_NOR_FIFO_AVAI_MASK GENMASK(3, 0)
+
+#define SOPHGO_NOR_INT_TRAN_DONE  BIT(0)
+#define SOPHGO_NOR_INT_RD_FIFO    BIT(1)
+#define SOPHGO_NOR_INT_WR_FIFO    BIT(2)
+
+struct sophgo_nor {
+	struct spi_controller *ctlr;
+	struct device *dev;
+	void __iomem *io_base;
+	uint32_t tran_csr_orig;
+	uint32_t sck_div_orig;
+	struct mutex lock;
+};
+
+static uint32_t sophgo_nor_clk_setup(struct sophgo_nor *spif, uint32_t sck_div)
+{
+	uint32_t reg;
+	uint32_t old_clk;
+
+	reg = readl(spif->io_base + SOPHGO_SPI_DLY_CTRL);
+
+	if (sck_div < SOPHGO_NOR_CTRL_DEFAULT_DIV)
+		reg |= SOPHGO_NOR_DLY_CTRL_NEG_SAMPLE;
+
+	writel(reg, spif->io_base + SOPHGO_SPI_DLY_CTRL);
+
+	reg = readl(spif->io_base + SOPHGO_SPI_CTRL);
+	old_clk = FIELD_GET(SOPHGO_NOR_CTRL_SCK_DIV_MASK, reg);
+
+	reg &= ~SOPHGO_NOR_CTRL_SCK_DIV_MASK;
+	reg |= sck_div;
+	writel(reg, spif->io_base + SOPHGO_SPI_CTRL);
+
+	return old_clk;
+}
+
+static inline uint32_t sophgo_nor_trans_csr_config(struct sophgo_nor *spif,
+					       const struct spi_mem_op *op)
+{
+	uint32_t tran_csr = 0;
+
+	if (op->dummy.nbytes)
+		tran_csr |= (op->dummy.nbytes * 8) / op->dummy.buswidth << 16;
+
+	tran_csr |= SOPHGO_NOR_TRANS_MMIO;
+	tran_csr |= SOPHGO_NOR_TRANS_BUS_WIDTH(op->data.buswidth / 2);
+	tran_csr |= SOPHGO_NOR_TRAN_ADDR(op->addr.nbytes);
+
+	return tran_csr;
+}
+
+static void sophgo_nor_config_mmio(struct sophgo_nor *spif,
+				   const struct spi_mem_op *op,
+				   uint32_t enabled)
+{
+	uint32_t ctrl, tran_csr;
+
+	if (enabled) {
+		spif->tran_csr_orig =
+			readl(spif->io_base + SOPHGO_SPI_TRAN_CSR);
+		tran_csr = sophgo_nor_trans_csr_config(spif, op);
+		ctrl = SOPHGO_NOR_CE_HARDWARE;
+	} else {
+		tran_csr = spif->tran_csr_orig;
+		ctrl = SOPHGO_NOR_CE_ENABLE;
+	}
+
+	writel(tran_csr, spif->io_base + SOPHGO_SPI_TRAN_CSR);
+	writel(ctrl, spif->io_base + SOPHGO_SPI_CE_CTRL);
+	writel(enabled, spif->io_base + SOPHGO_SPI_DMMR);
+}
+
+static void sophgo_nor_config_port(struct sophgo_nor *spif, uint32_t enabled)
+{
+	uint32_t ctrl = SOPHGO_NOR_CE_ENABLE;
+
+	if (enabled) {
+		ctrl = SOPHGO_NOR_CE_MANUAL_EN;
+		writel(!enabled, spif->io_base + SOPHGO_SPI_DMMR);
+	}
+
+	writel(ctrl, spif->io_base + SOPHGO_SPI_CE_CTRL);
+}
+
+static int sophgo_nor_xfer(struct sophgo_nor *spif, const uint8_t *dout,
+			   uint8_t *din, uint32_t data_bytes,
+			   uint32_t bus_width)
+{
+	uint32_t xfer_size, off;
+	uint32_t fifo_cnt;
+	uint32_t interrupt_mask = 0;
+	uint32_t stat, tran_csr = 0;
+	int ret = 0;
+
+	writel(0, spif->io_base + SOPHGO_SPI_INT_STS);
+	writel(0, spif->io_base + SOPHGO_SPI_FIFO_PT);
+
+	writew(data_bytes, spif->io_base + SOPHGO_SPI_TRAN_NUM);
+
+	if (din && dout)
+		return -1;
+	else if (!din && !dout)
+		return -1;
+
+	tran_csr = readw(spif->io_base + SOPHGO_SPI_TRAN_CSR);
+
+	tran_csr &= ~SOPHGO_NOR_TRANS_PORT;
+
+	tran_csr |= SOPHGO_NOR_TRAN_FIFO_8_BYTE;
+	tran_csr |= SOPHGO_NOR_TRAN_GO_BUSY;
+	tran_csr |= (bus_width / 2) << 4;
+
+	interrupt_mask |= SOPHGO_NOR_INT_TRAN_DONE;
+
+	if (din) {
+		tran_csr |= SOPHGO_NOR_TRAN_MODE_RX;
+		interrupt_mask |= SOPHGO_NOR_INT_RD_FIFO;
+		spif->sck_div_orig =
+			sophgo_nor_clk_setup(spif, SOPHGO_NOR_CTRL_DEFAULT_DIV);
+	} else if (dout) {
+		tran_csr |= SOPHGO_NOR_TRAN_MODE_TX;
+		interrupt_mask |= SOPHGO_NOR_INT_WR_FIFO;
+	}
+
+	writew(tran_csr, spif->io_base + SOPHGO_SPI_TRAN_CSR);
+
+	ret = readb_poll_timeout(spif->io_base + SOPHGO_SPI_INT_STS, stat,
+				 stat & interrupt_mask, 10, 30);
+	if (ret)
+		dev_warn(spif->dev, "%s stat timedout\n", __func__);
+
+	off = 0;
+	while (off < data_bytes) {
+		xfer_size = min_t(uint32_t, data_bytes - off,
+				  SOPHGO_NOR_FIFO_CAPACITY);
+
+		fifo_cnt = readl(spif->io_base + SOPHGO_SPI_FIFO_PT) &
+			   SOPHGO_NOR_FIFO_AVAI_MASK;
+
+		if (fifo_cnt > SOPHGO_NOR_FIFO_CAPACITY)
+			goto exit;
+
+		if (din)
+			xfer_size = min(xfer_size, fifo_cnt);
+		else
+			xfer_size = min_t(uint32_t, xfer_size,
+					  SOPHGO_NOR_FIFO_CAPACITY - fifo_cnt);
+
+		while (xfer_size--) {
+			if (din)
+				*(din + off) = readb(spif->io_base +
+						     SOPHGO_SPI_FIFO_PORT);
+			else
+				writeb(*(dout + off),
+				       spif->io_base + SOPHGO_SPI_FIFO_PORT);
+			off++;
+		}
+	}
+
+	ret = readb_poll_timeout(spif->io_base + SOPHGO_SPI_INT_STS, stat,
+				 (stat & interrupt_mask), 10, 30);
+	if (ret) {
+		dev_warn(spif->dev, " %s command timed out %x\n", __func__,
+			 stat);
+	}
+
+exit:
+	writeb(0, spif->io_base + SOPHGO_SPI_FIFO_PT);
+	stat = readb(spif->io_base + SOPHGO_SPI_INT_STS) & ~interrupt_mask;
+	writeb(stat, spif->io_base + SOPHGO_SPI_INT_STS);
+
+	if (din)
+		sophgo_nor_clk_setup(spif, spif->sck_div_orig);
+
+	return 0;
+}
+
+static int sophgo_nor_port_trans(struct sophgo_nor *spif,
+				 const struct spi_mem_op *op)
+{
+	const uint8_t *dout = NULL;
+	uint8_t *din = NULL;
+	uint32_t addr;
+
+	sophgo_nor_config_port(spif, 1);
+
+	if (op->cmd.nbytes)
+		sophgo_nor_xfer(spif, (uint8_t *)&op->cmd.opcode, NULL,
+				op->cmd.nbytes, op->cmd.buswidth);
+
+	if (op->addr.nbytes) {
+		addr = cpu_to_be32(op->addr.val);
+		sophgo_nor_xfer(spif, (uint8_t *)&addr, NULL, op->addr.nbytes,
+				op->addr.buswidth);
+	}
+
+	if (op->data.dir == SPI_MEM_DATA_IN)
+		din = op->data.buf.in;
+	else if (op->data.dir == SPI_MEM_DATA_OUT)
+		dout = op->data.buf.out;
+
+	sophgo_nor_xfer(spif, dout, din, op->data.nbytes, op->data.buswidth);
+
+	sophgo_nor_config_port(spif, 0);
+
+	return 0;
+}
+
+static void sophgo_nore_read_mmio(struct sophgo_nor *spif,
+				  const struct spi_mem_op *op)
+{
+	sophgo_nor_config_mmio(spif, op, 1);
+	memcpy_fromio(op->data.buf.in, spif->io_base + op->addr.val,
+		      op->data.nbytes);
+	sophgo_nor_config_mmio(spif, op, 0);
+}
+
+static int sophgo_nor_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct sophgo_nor *spif;
+
+	spif = spi_controller_get_devdata(mem->spi->controller);
+
+	mutex_lock(&spif->lock);
+	if (op->data.dir == SPI_MEM_DATA_IN && op->data.nbytes &&
+	    op->addr.nbytes == 4) {
+		sophgo_nore_read_mmio(spif, op);
+		goto exit;
+	}
+
+	sophgo_nor_port_trans(spif, op);
+
+exit:
+	mutex_unlock(&spif->lock);
+	return 0;
+}
+
+static const struct spi_controller_mem_ops sophgo_nor_mem_ops = {
+	.exec_op = sophgo_nor_exec_op,
+};
+
+static const struct of_device_id sophgo_nor_match[] = {
+	{ .compatible = "sophgo,cv1800b-nor" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sophgo_nor_match);
+
+static int sophgo_nor_probe(struct platform_device *pdev)
+{
+	struct spi_controller *ctlr;
+	struct sophgo_nor *sp;
+	void __iomem *base;
+
+	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*sp));
+	if (!ctlr)
+		return -ENOMEM;
+
+	sp = spi_controller_get_devdata(ctlr);
+	dev_set_drvdata(&pdev->dev, ctlr);
+
+	sp->dev = &pdev->dev;
+	sp->ctlr = ctlr;
+
+	sp->io_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	ctlr->num_chipselect = 1;
+	ctlr->dev.of_node = pdev->dev.of_node;
+	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
+	ctlr->auto_runtime_pm = false;
+	ctlr->mem_ops = &sophgo_nor_mem_ops;
+	ctlr->mode_bits = SPI_RX_DUAL | SPI_TX_DUAL | SPI_RX_QUAD | SPI_TX_QUAD;
+
+	mutex_init(&sp->lock);
+
+	sophgo_nor_config_port(sp, 1);
+
+	return devm_spi_register_controller(&pdev->dev, ctlr);
+}
+
+static int sophgo_nor_remove(struct platform_device *pdev)
+{
+	struct sophgo_nor *spif = platform_get_drvdata(pdev);
+
+	mutex_destroy(&spif->lock);
+	return 0;
+}
+
+static struct platform_driver sophgo_nor_driver = {
+	.driver = {
+		.name = "sophgo-spif",
+		.of_match_table = sophgo_nor_match,
+	},
+	.probe = sophgo_nor_probe,
+	.remove = sophgo_nor_remove,
+};
+
+module_platform_driver(sophgo_nor_driver);
+
+MODULE_DESCRIPTION("Sophgo SPI NOR controller driver");
+MODULE_AUTHOR("Jingbao Qiu <qiujingbao.dlmu@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.25.1


