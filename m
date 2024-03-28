Return-Path: <linux-kernel+bounces-122403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4EE88F677
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 336C61C25E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 04:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF0328E6;
	Thu, 28 Mar 2024 04:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s/6yM3A3"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412CE22094;
	Thu, 28 Mar 2024 04:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711600736; cv=none; b=mSOYYngQ2Ahs7SCahRdSgHE/O2oF9f2r0XUcf91OgQAUcTHdaM3TZlDbbjSP2nMFfcuSNoTDLpZVGeSc6ZTuWhKrI49N4tsG1i94dTVcqvLFuWJfMXI3PcrBzdss1cxrmQNr9tYVB+9OjeMkv+OvCFWjDE+PM+WdpSvTd6My8qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711600736; c=relaxed/simple;
	bh=xJUJBVcTrcoVWKWI3noVCP/ZJuIJJ8OvP66ZFl3lGwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EKydnLtR9l61d/HSgn0fB2lAPMN0l+SHUPTiESm5VdfxherjIkrdUgnqHJOt4BKVpkQKZFQaeXlCBErrPB+L7sMma2VOElCo480FIIlhoAl2Hed4yVAhO+CrM8BAU6FmM41nsMRRezfcJDPm8FdybpxG/9NL3x1QSxEe2iZ2XMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s/6yM3A3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=L2eLyY9/pC8EXuZ02In+NSGjvj0LLz9UHxJBhvFZYGA=; b=s/6yM3A3kOt+PKN3V+URRlK5AK
	akTx62Bf7DEH6+1H7Kug56ZKJ3IbLEALZPDV3SAXP2dqEP++iSGUbDevhEXuVMA3nUfNebJ3+/adW
	GvGTVU1e93CTO9HlhW2z1CcRTmlGlAh4ZG/ROB/dkWrc0mocKhGxiHsoO1Oy5r8Mg7LFuguapgTWu
	i8ZhHJpIJW7uqR/sABrluz/c8Vw4OPv3h1Svh8+rFNPOFkcqhlbsRfzpdSNFTA7NcZrVQrwZZqYWu
	AvRFdCqYbL042qgh+SZZUbEAt5VCVwTcipyBjUmdrKN/HwN6jck8E6EJBL8AapMAaERw9MlkWct0n
	1RFLBWcQ==;
Received: from [50.53.2.121] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rphXS-0000000CPWL-3DPM;
	Thu, 28 Mar 2024 04:38:54 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: spi.h: fix punctuation & grammar typos
Date: Wed, 27 Mar 2024 21:38:54 -0700
Message-ID: <20240328043854.18249-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix various punctuation and grammar typos in <linux/spi/spi.h>.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org

 include/linux/spi/spi.h |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff -- a/include/linux/spi/spi.h b/include/linux/spi/spi.h
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -227,9 +227,9 @@ struct spi_device {
 	struct spi_statistics __percpu	*pcpu_statistics;
 
 	/* Bit mask of the chipselect(s) that the driver need to use from
-	 * the chipselect array.When the controller is capable to handle
+	 * the chipselect array. When the controller is capable of handling
 	 * multiple chip selects & memories are connected in parallel
-	 * then more than one bit need to be set in cs_index_mask.
+	 * then more than one bit needs to be set in cs_index_mask.
 	 */
 	u32			cs_index_mask : SPI_CS_CNT_MAX;
 
@@ -611,8 +611,8 @@ struct spi_controller {
 	};
 
 	/*
-	 * On some hardware transfer / message size may be constrained
-	 * the limit may depend on device transfer settings.
+	 * On some hardware, transfer / message size may be constrained.
+	 * The limit may depend on device transfer settings.
 	 */
 	size_t (*max_transfer_size)(struct spi_device *spi);
 	size_t (*max_message_size)(struct spi_device *spi);
@@ -676,7 +676,7 @@ struct spi_controller {
 	void			(*cleanup)(struct spi_device *spi);
 
 	/*
-	 * Used to enable core support for DMA handling, if can_dma()
+	 * Used to enable core support for DMA handling; if can_dma()
 	 * exists and returns true then the transfer will be mapped
 	 * prior to transfer_one() being called.  The driver should
 	 * not modify or store xfer and dma_tx and dma_rx must be set
@@ -1052,10 +1052,10 @@ struct spi_res {
  * by the results of previous messages and where the whole transaction
  * ends when the chipselect goes inactive.
  *
- * When SPI can transfer in 1x,2x or 4x. It can get this transfer information
+ * When SPI can transfer in 1x, 2x or 4x, it can get this transfer information
  * from device through @tx_nbits and @rx_nbits. In Bi-direction, these
- * two should both be set. User can set transfer mode with SPI_NBITS_SINGLE(1x)
- * SPI_NBITS_DUAL(2x) and SPI_NBITS_QUAD(4x) to support these three transfer.
+ * two should both be set. User can set transfer mode with SPI_NBITS_SINGLE(1x),
+ * SPI_NBITS_DUAL(2x) and SPI_NBITS_QUAD(4x) to support these three transfers.
  *
  * The code that submits an spi_message (and its spi_transfers)
  * to the lower layers is responsible for managing its memory.

