Return-Path: <linux-kernel+bounces-61790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4555285168F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A806F1F24B21
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB993D560;
	Mon, 12 Feb 2024 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KJOCP7YT"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECA13D971
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707746634; cv=none; b=SERrdAU6KAeJJbO7cxwBrw75gRbgJeGCRWfiRSrxDzG4b9C/HcgkhZIRSZAkfCLY82A1Sy5vpRvKJ8SvezJJe3MEaFApEMdpSMFyt5u9SYmR9WAld1arlQzgtUe7pY3wCQi5SkH7+ai1LEgn0HOsWCxBvN06PRm5/xiKf9xftuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707746634; c=relaxed/simple;
	bh=wV5NZg/LKpnZaM6Kml6m0dcZlcM1lNaxnWFeDUSittQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JD9/yPJmSjAfOf44vpsydPulrq30p3RIHs7oi3gJLD19CZgKsBOA9xkFl78ItzmP+ATxaw544i56X5p9NyIhMbypTjAmB9M+wgu0lOYko1nrsvDabUSEh7lpYtpAKLnVPGOdG+C8BXehtBpHnD8CZ9Kr7q2vw1lMn+yAMYiKeN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KJOCP7YT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33b18099411so1905689f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 06:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707746631; x=1708351431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGH79biiaV6ew1Z0cXAg/aqisf4dNxuTnwEmj4C4qiQ=;
        b=KJOCP7YTHnH+7uddFFI09yVcEa/e7IKyZkbNexpawIyocLEZY+CinwxZNuihzAzLYJ
         lUVuiK9qDkUwrwVVqECkzP08kPCobHYIEpOOAaM0ibs4Q3MADAp3NZImrmrhDfYwuRaU
         rRXZtCGvWYBxhs9zwyCocytX5Ic1X44s+CSqbMh9qZNVB0b0QX6E++VOzR6KJb3O8p45
         3AQY4CrfftSgLlQ9g557IwvnVWjuW+D16MoN4S/ZkMTT4AcPPvSlgd3+UEBlGbg6pMOn
         IK+J0Xi7QvKXxHdGq7OJJiH6gPWqNljC4Kzxv9mLjDcpqz6UhaqNV8+o8GwJjMBacXQ4
         6qKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707746631; x=1708351431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGH79biiaV6ew1Z0cXAg/aqisf4dNxuTnwEmj4C4qiQ=;
        b=bW3ghiFWjxt3dAwFGaIy2PniTbwBtKOsTgoc24joFyMaOWyHDaE/uv/erZfW8yKfXt
         mNcyv2oVogVQR3G7B/zassrtZc48iKmKocKDX821Vygfh1e/kcuC4jyruLOP3FXmQHnl
         gnlFNgB41rLYFgbHrbhi3eZ5gEL7wcs/+fqP9jLr3aiFr8AK+j7awFsZDad+V1FVpV06
         raN4h9DAMyZUZKPIOZReK9HFAWMKEEI7qGTW1RChHQzrPnggAAtbOnmclL/YjlI14S/6
         KvZ7tblkNX0m1tdp++4d2xdRda/wwsIhJQ12y1oZw8bNRrOtFng+iEBu3Z2197M80gTr
         Aa3Q==
X-Gm-Message-State: AOJu0YwnuvwyP5u81JucV04cB4WfU0JR0JziCv4t8T+iPEQv+UBdB0s3
	OKi1JWu5+Vtf06GiMfucBxG27lQBqyT59Hha9d6XNg/eaLx+rvS5XPlJX6GhBHzQFJT8qpDPWaC
	DnOY=
X-Google-Smtp-Source: AGHT+IGS3x5tiHx478cOA6vfdXTCG/2IAIZ3b65y6QIldC8Q++sdM3K9tTaV3NK0VcHRSwJS0LeAfQ==
X-Received: by 2002:a5d:69ce:0:b0:33b:7134:a3b0 with SMTP id s14-20020a5d69ce000000b0033b7134a3b0mr4147636wrw.13.1707746631158;
        Mon, 12 Feb 2024 06:03:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUI6uye0RmUlRtKE0WXT1AxzVO/ZKsIQdCH3OhrvSUvnL9NTDlyOA2bFRJbVln8Wsk7RuZVKvUMHB9eohQcZOZn0Ulln+lUAMB2GykP1WI/4H3OjIpG7TR69c54P9LJz4l1LDDNw6xaQz5hLF5Jt71K2QodArP9ulEGr4tldJStGYL3OEKfSSG1ZYOsG1GZcqA6KRleB31t3V1XqEtUcZbxErI9DPWjSiTjA7Au8D6eSWQyZXw6JMcf4j60Nc+k0L6/wDHqo1IOkHWLnd6nBsgfpJibPicMJAeD/7VW6SeGJkrIdb+hFBJcHR29TBZQixp6xe8bvwzA8LghYFtGmUrUeU+xMlIHTfHBJBSHQxh7ueCVh2a3FLzscOQ23aNzAdS5Rmre/+1nstIpdLFfPa4hDq11HxEqy50qe459gmhOdOjFqk8lmbxjwE1SZ29Dut/TW4AlGyncnjsOzpWdcupVthNAzs4sQrl33tXB/FFuDfAAw4Y8SEFzlxElh+qBCKHrCsV+bFJBCRa/TY8BteGCFxF1Hv0YbEZYGnvppY3BbwnulzXeLQCN2Ri8mxRogl+fk3M3ble0oJSbmpbeUbS60o7W4qZDmMs/bKDFshGZ98Cvbjc=
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d4b09000000b0033b843786e1sm2135356wrq.51.2024.02.12.06.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 06:03:49 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	robh@kernel.org,
	andi.shyti@kernel.org,
	krzysztof.kozlowski@linaro.org,
	semen.protsenko@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	devicetree@vger.kernel.org,
	arnd@arndb.de,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 04/12] spi: s3c64xx: determine the fifo depth only once
Date: Mon, 12 Feb 2024 14:03:23 +0000
Message-ID: <20240212140331.915498-5-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240212140331.915498-1-tudor.ambarus@linaro.org>
References: <20240212140331.915498-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Determine the FIFO depth only once, at probe time.
``sdd->fifo_depth`` can be set later on with the FIFO depth
specified in the device tree.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 338ca3f03ea5..72572e23cde5 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -191,6 +191,7 @@ struct s3c64xx_spi_port_config {
  * @tx_dma: Local transmit DMA data (e.g. chan and direction)
  * @port_conf: Local SPI port configuration data
  * @port_id: Port identification number
+ * @fifo_depth: depth of the FIFO.
  * @rx_fifomask: SPI_STATUS.RX_FIFO_LVL mask. Shifted mask defining the field's
  *               length and position.
  * @tx_fifomask: SPI_STATUS.TX_FIFO_LVL mask. Shifted mask defining the field's
@@ -214,6 +215,7 @@ struct s3c64xx_spi_driver_data {
 	struct s3c64xx_spi_dma_data	tx_dma;
 	const struct s3c64xx_spi_port_config	*port_conf;
 	unsigned int			port_id;
+	unsigned int			fifo_depth;
 	u32				rx_fifomask;
 	u32				tx_fifomask;
 };
@@ -424,7 +426,7 @@ static bool s3c64xx_spi_can_dma(struct spi_controller *host,
 	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
 
 	if (sdd->rx_dma.ch && sdd->tx_dma.ch)
-		return xfer->len > FIFO_DEPTH(sdd);
+		return xfer->len > sdd->fifo_depth;
 
 	return false;
 }
@@ -548,7 +550,7 @@ static u32 s3c64xx_spi_wait_for_timeout(struct s3c64xx_spi_driver_data *sdd,
 	void __iomem *regs = sdd->regs;
 	unsigned long val = 1;
 	u32 status;
-	u32 max_fifo = FIFO_DEPTH(sdd);
+	u32 max_fifo = sdd->fifo_depth;
 
 	if (timeout_ms)
 		val = msecs_to_loops(timeout_ms);
@@ -655,7 +657,7 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
 	 * For any size less than the fifo size the below code is
 	 * executed atleast once.
 	 */
-	loops = xfer->len / FIFO_DEPTH(sdd);
+	loops = xfer->len / sdd->fifo_depth;
 	buf = xfer->rx_buf;
 	do {
 		/* wait for data to be received in the fifo */
@@ -792,7 +794,7 @@ static int s3c64xx_spi_transfer_one(struct spi_controller *host,
 				    struct spi_transfer *xfer)
 {
 	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
-	const unsigned int fifo_len = FIFO_DEPTH(sdd);
+	const unsigned int fifo_len = sdd->fifo_depth;
 	const void *tx_buf = NULL;
 	void *rx_buf = NULL;
 	int target_len = 0, origin_len = 0;
@@ -1261,6 +1263,8 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 		sdd->port_id = pdev->id;
 	}
 
+	sdd->fifo_depth = FIFO_DEPTH(sdd);
+
 	s3c64xx_spi_set_fifomask(sdd);
 
 	sdd->cur_bpw = 8;
@@ -1352,7 +1356,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d with %d Targets attached\n",
 					sdd->port_id, host->num_chipselect);
 	dev_dbg(&pdev->dev, "\tIOmem=[%pR]\tFIFO %dbytes\n",
-					mem_res, FIFO_DEPTH(sdd));
+		mem_res, sdd->fifo_depth);
 
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
-- 
2.43.0.687.g38aa6559b0-goog


