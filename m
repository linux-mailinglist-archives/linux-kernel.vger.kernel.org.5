Return-Path: <linux-kernel+bounces-127835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FB689518E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2D41C21D5C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B44D6E5E8;
	Tue,  2 Apr 2024 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Roym+Q8J"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCCC634EA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056471; cv=none; b=tYzmkKy//8K3Q1L2bibZG79uZq5KK5TWkofT0zW8tNOPfDtaMkX/yAomr3uEuZUyf06I3H4ITps9Lk9O0C190yEjBHG85RtwakFQRaQ1j/5yBVTsSfKG8PZYWClz6AxiYRzDvVGvkjwE45xRhmunswRvjr32qNTPa3AsSUqPGMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056471; c=relaxed/simple;
	bh=WfR3fzgOc+lYO6U7TgwGQD81mZqIEEtqO9tFKn6iuM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d1xeU6BJPmeZK3vhguoAH1o58emg37VYB9tgFtqdvMYWzjLfcsLTp0trJYDVVkTeyRZa3V1e1e6GoTeGe+/fsqH9jPBsY71qJ5rr4wQPsI3lXYM9KnN2yeRD1NpssZlU5bxvx2E4JSH66LOUa9J9dtxvb/pHrlKTRuj+D2OWC28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Roym+Q8J; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e89e48d2c0so1004532a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 04:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712056467; x=1712661267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LP7LwhNxKs9alceF3MwlRSStgVkDK9Wscv2B2RIGfw=;
        b=Roym+Q8JyX0FXVlSYO7BvqAfTTg0alATGPNK5ngqbj0DSGAgUAUd0VL3UGJAtW7J1c
         mdVfWUQVPmBzZ37lVEuAwL2FHGg57LyJZqC3r3Dt6L8wNEqZiiorP4PSwKdiObxtND2D
         Hen4M2aqjRlIc1TLYfTc0ZuuUhZJlQsskf/yGWl9P2PWgcw2qXJN025sVro4fV3vJVgE
         ADPsfSqoLm96E6EpkqUQjxdfe6xnUfjMLnVGBgcTyat/108nu7dG/7MNNSZeerxVSAyv
         UrLRYR7L6NBysz0feG84dQ+BX1Fgeoi4Ykj0AqG3o+q5TI3ibhGSUu2NcMp6defAT2mn
         0rSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712056467; x=1712661267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LP7LwhNxKs9alceF3MwlRSStgVkDK9Wscv2B2RIGfw=;
        b=bte/Fxfuh3mP29O2eXPXOE24Oxcmzk9p2HIypNeETjF4Myh9t+J76Otnd8ap8sZnAn
         8l7XGef4mLKJFK7iX8QcZAm8RbOIzdDsVs6dOFvDtaLDHAGHoThuotkfOCxz6N8G8Q+C
         qxmLfs9a+CbHELePTWhwwaBCKbAmNsGE+8wqBdZSnqqAsZCEKuMfmB+bu9MqkNCkNP19
         WKYX93GIBc8nJe7X4QSjP4YP0c1QW6dH1qBaDVh4UyBzcr1wWKTd8hQbXEQJwv7fY6Om
         ubIM5QN6vYEkrR0MrXBeGwKUTWJRCUDMGY7QAryaj+yIm1cVghVVDbHfU/eKmgNgJgSO
         tEFA==
X-Forwarded-Encrypted: i=1; AJvYcCUIQNTZ02nOj+0WrlymkKxqZlyGRRcgU4OeijGhDN2eEvYsw09TW4gv0SGVMzLVPTjlniwq/AlSVMNN7DTvimpjU6wDn65iO75K6DOe
X-Gm-Message-State: AOJu0Yy+8mJaP/FclzNWegkUz/LAAWauxThQMXcs443zQyutoqaLT+27
	oodlX/pgaSHh/KqKUp5Wk69CopeGpS6TsaFDYjLKAX53u0FMj8tj
X-Google-Smtp-Source: AGHT+IGScEmFAulgT9n2upeHCeGsLZx0mX0dn83We9EGOIfwbrJ7I54KtVqtNbtbXP4T+RlLg7jx0Q==
X-Received: by 2002:a05:6830:39ea:b0:6e7:c80a:3b2c with SMTP id bt42-20020a05683039ea00b006e7c80a3b2cmr13291056otb.18.1712056467070;
        Tue, 02 Apr 2024 04:14:27 -0700 (PDT)
Received: from YOGA.local ([2a06:c701:737b:ef00:2c6f:6cdc:f641:6ecf])
        by smtp.gmail.com with ESMTPSA id 11-20020a05621420cb00b006968a6fb010sm5428855qve.91.2024.04.02.04.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 04:14:26 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	felixkimbu1@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] staging: pi433: Rename struct pi433_device instances to pi433.
Date: Tue,  2 Apr 2024 14:14:10 +0300
Message-Id: <20240402111414.871089-3-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402111414.871089-1-ikobh7@gmail.com>
References: <20240402111414.871089-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just as other devices use specific names for instantiation,
struct_pi433 should also have a distinct name.
Moreover, some other structs use the "dev" or "device" in their naming
conventions for members, which can be confusing.

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 654 +++++++++++++++----------------
 1 file changed, 327 insertions(+), 327 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 13b464ab7db8..7efe6b8501e3 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -113,7 +113,7 @@ struct pi433_device {
 };
 
 struct pi433_instance {
-	struct pi433_device	*device;
+	struct pi433_device	*pi433;
 	struct pi433_tx_cfg	tx_cfg;
 
 	/* control flags */
@@ -125,19 +125,19 @@ struct pi433_instance {
 /* GPIO interrupt handlers */
 static irqreturn_t DIO0_irq_handler(int irq, void *dev_id)
 {
-	struct pi433_device *device = dev_id;
-
-	if (device->irq_state[DIO0] == DIO_PACKET_SENT) {
-		device->free_in_fifo = FIFO_SIZE;
-		dev_dbg(device->dev, "DIO0 irq: Packet sent\n");
-		wake_up_interruptible(&device->fifo_wait_queue);
-	} else if (device->irq_state[DIO0] == DIO_RSSI_DIO0) {
-		dev_dbg(device->dev, "DIO0 irq: RSSI level over threshold\n");
-		wake_up_interruptible(&device->rx_wait_queue);
-	} else if (device->irq_state[DIO0] == DIO_PAYLOAD_READY) {
-		dev_dbg(device->dev, "DIO0 irq: Payload ready\n");
-		device->free_in_fifo = 0;
-		wake_up_interruptible(&device->fifo_wait_queue);
+	struct pi433_device *pi433 = dev_id;
+
+	if (pi433->irq_state[DIO0] == DIO_PACKET_SENT) {
+		pi433->free_in_fifo = FIFO_SIZE;
+		dev_dbg(pi433->dev, "DIO0 irq: Packet sent\n");
+		wake_up_interruptible(&pi433->fifo_wait_queue);
+	} else if (pi433->irq_state[DIO0] == DIO_RSSI_DIO0) {
+		dev_dbg(pi433->dev, "DIO0 irq: RSSI level over threshold\n");
+		wake_up_interruptible(&pi433->rx_wait_queue);
+	} else if (pi433->irq_state[DIO0] == DIO_PAYLOAD_READY) {
+		dev_dbg(pi433->dev, "DIO0 irq: Payload ready\n");
+		pi433->free_in_fifo = 0;
+		wake_up_interruptible(&pi433->fifo_wait_queue);
 	}
 
 	return IRQ_HANDLED;
@@ -145,19 +145,19 @@ static irqreturn_t DIO0_irq_handler(int irq, void *dev_id)
 
 static irqreturn_t DIO1_irq_handler(int irq, void *dev_id)
 {
-	struct pi433_device *device = dev_id;
+	struct pi433_device *pi433 = dev_id;
 
-	if (device->irq_state[DIO1] == DIO_FIFO_NOT_EMPTY_DIO1) {
-		device->free_in_fifo = FIFO_SIZE;
-	} else if (device->irq_state[DIO1] == DIO_FIFO_LEVEL) {
-		if (device->rx_active)
-			device->free_in_fifo = FIFO_THRESHOLD - 1;
+	if (pi433->irq_state[DIO1] == DIO_FIFO_NOT_EMPTY_DIO1) {
+		pi433->free_in_fifo = FIFO_SIZE;
+	} else if (pi433->irq_state[DIO1] == DIO_FIFO_LEVEL) {
+		if (pi433->rx_active)
+			pi433->free_in_fifo = FIFO_THRESHOLD - 1;
 		else
-			device->free_in_fifo = FIFO_SIZE - FIFO_THRESHOLD - 1;
+			pi433->free_in_fifo = FIFO_SIZE - FIFO_THRESHOLD - 1;
 	}
-	dev_dbg(device->dev,
-		"DIO1 irq: %d bytes free in fifo\n", device->free_in_fifo);
-	wake_up_interruptible(&device->fifo_wait_queue);
+	dev_dbg(pi433->dev,
+		"DIO1 irq: %d bytes free in fifo\n", pi433->free_in_fifo);
+	wake_up_interruptible(&pi433->fifo_wait_queue);
 
 	return IRQ_HANDLED;
 }
@@ -165,94 +165,94 @@ static irqreturn_t DIO1_irq_handler(int irq, void *dev_id)
 /*-------------------------------------------------------------------------*/
 
 static int
-rf69_set_rx_cfg(struct pi433_device *dev, struct pi433_rx_cfg *rx_cfg)
+rf69_set_rx_cfg(struct pi433_device *pi433, struct pi433_rx_cfg *rx_cfg)
 {
 	int ret;
 	int payload_length;
 
 	/* receiver config */
-	ret = rf69_set_frequency(dev->spi, rx_cfg->frequency);
+	ret = rf69_set_frequency(pi433->spi, rx_cfg->frequency);
 	if (ret < 0)
 		return ret;
-	ret = rf69_set_modulation(dev->spi, rx_cfg->modulation);
+	ret = rf69_set_modulation(pi433->spi, rx_cfg->modulation);
 	if (ret < 0)
 		return ret;
-	ret = rf69_set_bit_rate(dev->spi, rx_cfg->bit_rate);
+	ret = rf69_set_bit_rate(pi433->spi, rx_cfg->bit_rate);
 	if (ret < 0)
 		return ret;
-	ret = rf69_set_antenna_impedance(dev->spi, rx_cfg->antenna_impedance);
+	ret = rf69_set_antenna_impedance(pi433->spi, rx_cfg->antenna_impedance);
 	if (ret < 0)
 		return ret;
-	ret = rf69_set_rssi_threshold(dev->spi, rx_cfg->rssi_threshold);
+	ret = rf69_set_rssi_threshold(pi433->spi, rx_cfg->rssi_threshold);
 	if (ret < 0)
 		return ret;
-	ret = rf69_set_ook_threshold_dec(dev->spi, rx_cfg->threshold_decrement);
+	ret = rf69_set_ook_threshold_dec(pi433->spi, rx_cfg->threshold_decrement);
 	if (ret < 0)
 		return ret;
-	ret = rf69_set_bandwidth(dev->spi, rx_cfg->bw_mantisse,
+	ret = rf69_set_bandwidth(pi433->spi, rx_cfg->bw_mantisse,
 				 rx_cfg->bw_exponent);
 	if (ret < 0)
 		return ret;
-	ret = rf69_set_bandwidth_during_afc(dev->spi, rx_cfg->bw_mantisse,
+	ret = rf69_set_bandwidth_during_afc(pi433->spi, rx_cfg->bw_mantisse,
 					    rx_cfg->bw_exponent);
 	if (ret < 0)
 		return ret;
-	ret = rf69_set_dagc(dev->spi, rx_cfg->dagc);
+	ret = rf69_set_dagc(pi433->spi, rx_cfg->dagc);
 	if (ret < 0)
 		return ret;
 
-	dev->rx_bytes_to_drop = rx_cfg->bytes_to_drop;
+	pi433->rx_bytes_to_drop = rx_cfg->bytes_to_drop;
 
 	/* packet config */
 	/* enable */
 	if (rx_cfg->enable_sync == OPTION_ON) {
-		ret = rf69_enable_sync(dev->spi);
+		ret = rf69_enable_sync(pi433->spi);
 		if (ret < 0)
 			return ret;
 
-		ret = rf69_set_fifo_fill_condition(dev->spi,
+		ret = rf69_set_fifo_fill_condition(pi433->spi,
 						   after_sync_interrupt);
 		if (ret < 0)
 			return ret;
 	} else {
-		ret = rf69_disable_sync(dev->spi);
+		ret = rf69_disable_sync(pi433->spi);
 		if (ret < 0)
 			return ret;
 
-		ret = rf69_set_fifo_fill_condition(dev->spi, always);
+		ret = rf69_set_fifo_fill_condition(pi433->spi, always);
 		if (ret < 0)
 			return ret;
 	}
 	if (rx_cfg->enable_length_byte == OPTION_ON) {
-		ret = rf69_set_packet_format(dev->spi, packet_length_var);
+		ret = rf69_set_packet_format(pi433->spi, packet_length_var);
 		if (ret < 0)
 			return ret;
 	} else {
-		ret = rf69_set_packet_format(dev->spi, packet_length_fix);
+		ret = rf69_set_packet_format(pi433->spi, packet_length_fix);
 		if (ret < 0)
 			return ret;
 	}
-	ret = rf69_set_address_filtering(dev->spi,
+	ret = rf69_set_address_filtering(pi433->spi,
 					 rx_cfg->enable_address_filtering);
 	if (ret < 0)
 		return ret;
 
 	if (rx_cfg->enable_crc == OPTION_ON) {
-		ret = rf69_enable_crc(dev->spi);
+		ret = rf69_enable_crc(pi433->spi);
 		if (ret < 0)
 			return ret;
 	} else {
-		ret = rf69_disable_crc(dev->spi);
+		ret = rf69_disable_crc(pi433->spi);
 		if (ret < 0)
 			return ret;
 	}
 
 	/* lengths */
-	ret = rf69_set_sync_size(dev->spi, rx_cfg->sync_length);
+	ret = rf69_set_sync_size(pi433->spi, rx_cfg->sync_length);
 	if (ret < 0)
 		return ret;
 	if (rx_cfg->enable_length_byte == OPTION_ON) {
-		ret = rf69_set_payload_length(dev->spi, 0xff);
+		ret = rf69_set_payload_length(pi433->spi, 0xff);
 		if (ret < 0)
 			return ret;
 	} else if (rx_cfg->fixed_message_length != 0) {
@@ -261,26 +261,26 @@ rf69_set_rx_cfg(struct pi433_device *dev, struct pi433_rx_cfg *rx_cfg)
 			payload_length++;
 		if (rx_cfg->enable_address_filtering != filtering_off)
 			payload_length++;
-		ret = rf69_set_payload_length(dev->spi, payload_length);
+		ret = rf69_set_payload_length(pi433->spi, payload_length);
 		if (ret < 0)
 			return ret;
 	} else {
-		ret = rf69_set_payload_length(dev->spi, 0);
+		ret = rf69_set_payload_length(pi433->spi, 0);
 		if (ret < 0)
 			return ret;
 	}
 
 	/* values */
 	if (rx_cfg->enable_sync == OPTION_ON) {
-		ret = rf69_set_sync_values(dev->spi, rx_cfg->sync_pattern);
+		ret = rf69_set_sync_values(pi433->spi, rx_cfg->sync_pattern);
 		if (ret < 0)
 			return ret;
 	}
 	if (rx_cfg->enable_address_filtering != filtering_off) {
-		ret = rf69_set_node_address(dev->spi, rx_cfg->node_address);
+		ret = rf69_set_node_address(pi433->spi, rx_cfg->node_address);
 		if (ret < 0)
 			return ret;
-		ret = rf69_set_broadcast_address(dev->spi,
+		ret = rf69_set_broadcast_address(pi433->spi,
 						 rx_cfg->broadcast_address);
 		if (ret < 0)
 			return ret;
@@ -290,76 +290,76 @@ rf69_set_rx_cfg(struct pi433_device *dev, struct pi433_rx_cfg *rx_cfg)
 }
 
 static int
-rf69_set_tx_cfg(struct pi433_device *dev, struct pi433_tx_cfg *tx_cfg)
+rf69_set_tx_cfg(struct pi433_device *pi433, struct pi433_tx_cfg *tx_cfg)
 {
 	int ret;
 
-	ret = rf69_set_frequency(dev->spi, tx_cfg->frequency);
+	ret = rf69_set_frequency(pi433->spi, tx_cfg->frequency);
 	if (ret < 0)
 		return ret;
-	ret = rf69_set_modulation(dev->spi, tx_cfg->modulation);
+	ret = rf69_set_modulation(pi433->spi, tx_cfg->modulation);
 	if (ret < 0)
 		return ret;
-	ret = rf69_set_bit_rate(dev->spi, tx_cfg->bit_rate);
+	ret = rf69_set_bit_rate(pi433->spi, tx_cfg->bit_rate);
 	if (ret < 0)
 		return ret;
-	ret = rf69_set_deviation(dev->spi, tx_cfg->dev_frequency);
+	ret = rf69_set_deviation(pi433->spi, tx_cfg->dev_frequency);
 	if (ret < 0)
 		return ret;
-	ret = rf69_set_pa_ramp(dev->spi, tx_cfg->pa_ramp);
+	ret = rf69_set_pa_ramp(pi433->spi, tx_cfg->pa_ramp);
 	if (ret < 0)
 		return ret;
-	ret = rf69_set_modulation_shaping(dev->spi, tx_cfg->mod_shaping);
+	ret = rf69_set_modulation_shaping(pi433->spi, tx_cfg->mod_shaping);
 	if (ret < 0)
 		return ret;
-	ret = rf69_set_tx_start_condition(dev->spi, tx_cfg->tx_start_condition);
+	ret = rf69_set_tx_start_condition(pi433->spi, tx_cfg->tx_start_condition);
 	if (ret < 0)
 		return ret;
 
 	/* packet format enable */
 	if (tx_cfg->enable_preamble == OPTION_ON) {
-		ret = rf69_set_preamble_length(dev->spi,
+		ret = rf69_set_preamble_length(pi433->spi,
 					       tx_cfg->preamble_length);
 		if (ret < 0)
 			return ret;
 	} else {
-		ret = rf69_set_preamble_length(dev->spi, 0);
+		ret = rf69_set_preamble_length(pi433->spi, 0);
 		if (ret < 0)
 			return ret;
 	}
 
 	if (tx_cfg->enable_sync == OPTION_ON) {
-		ret = rf69_set_sync_size(dev->spi, tx_cfg->sync_length);
+		ret = rf69_set_sync_size(pi433->spi, tx_cfg->sync_length);
 		if (ret < 0)
 			return ret;
-		ret = rf69_set_sync_values(dev->spi, tx_cfg->sync_pattern);
+		ret = rf69_set_sync_values(pi433->spi, tx_cfg->sync_pattern);
 		if (ret < 0)
 			return ret;
-		ret = rf69_enable_sync(dev->spi);
+		ret = rf69_enable_sync(pi433->spi);
 		if (ret < 0)
 			return ret;
 	} else {
-		ret = rf69_disable_sync(dev->spi);
+		ret = rf69_disable_sync(pi433->spi);
 		if (ret < 0)
 			return ret;
 	}
 
 	if (tx_cfg->enable_length_byte == OPTION_ON) {
-		ret = rf69_set_packet_format(dev->spi, packet_length_var);
+		ret = rf69_set_packet_format(pi433->spi, packet_length_var);
 		if (ret < 0)
 			return ret;
 	} else {
-		ret = rf69_set_packet_format(dev->spi, packet_length_fix);
+		ret = rf69_set_packet_format(pi433->spi, packet_length_fix);
 		if (ret < 0)
 			return ret;
 	}
 
 	if (tx_cfg->enable_crc == OPTION_ON) {
-		ret = rf69_enable_crc(dev->spi);
+		ret = rf69_enable_crc(pi433->spi);
 		if (ret < 0)
 			return ret;
 	} else {
-		ret = rf69_disable_crc(dev->spi);
+		ret = rf69_disable_crc(pi433->spi);
 		if (ret < 0)
 			return ret;
 	}
@@ -369,38 +369,38 @@ rf69_set_tx_cfg(struct pi433_device *dev, struct pi433_tx_cfg *tx_cfg)
 
 /*-------------------------------------------------------------------------*/
 
-static int pi433_start_rx(struct pi433_device *dev)
+static int pi433_start_rx(struct pi433_device *pi433)
 {
 	int retval;
 
 	/* return without action, if no pending read request */
-	if (!dev->rx_active)
+	if (!pi433->rx_active)
 		return 0;
 
 	/* setup for receiving */
-	retval = rf69_set_rx_cfg(dev, &dev->rx_cfg);
+	retval = rf69_set_rx_cfg(pi433, &pi433->rx_cfg);
 	if (retval)
 		return retval;
 
 	/* setup rssi irq */
-	retval = rf69_set_dio_mapping(dev->spi, DIO0, DIO_RSSI_DIO0);
+	retval = rf69_set_dio_mapping(pi433->spi, DIO0, DIO_RSSI_DIO0);
 	if (retval < 0)
 		return retval;
-	dev->irq_state[DIO0] = DIO_RSSI_DIO0;
-	irq_set_irq_type(dev->irq_num[DIO0], IRQ_TYPE_EDGE_RISING);
+	pi433->irq_state[DIO0] = DIO_RSSI_DIO0;
+	irq_set_irq_type(pi433->irq_num[DIO0], IRQ_TYPE_EDGE_RISING);
 
 	/* setup fifo level interrupt */
-	retval = rf69_set_fifo_threshold(dev->spi, FIFO_SIZE - FIFO_THRESHOLD);
+	retval = rf69_set_fifo_threshold(pi433->spi, FIFO_SIZE - FIFO_THRESHOLD);
 	if (retval < 0)
 		return retval;
-	retval = rf69_set_dio_mapping(dev->spi, DIO1, DIO_FIFO_LEVEL);
+	retval = rf69_set_dio_mapping(pi433->spi, DIO1, DIO_FIFO_LEVEL);
 	if (retval < 0)
 		return retval;
-	dev->irq_state[DIO1] = DIO_FIFO_LEVEL;
-	irq_set_irq_type(dev->irq_num[DIO1], IRQ_TYPE_EDGE_RISING);
+	pi433->irq_state[DIO1] = DIO_FIFO_LEVEL;
+	irq_set_irq_type(pi433->irq_num[DIO1], IRQ_TYPE_EDGE_RISING);
 
 	/* set module to receiving mode */
-	retval = rf69_set_mode(dev->spi, receive);
+	retval = rf69_set_mode(pi433->spi, receive);
 	if (retval < 0)
 		return retval;
 
@@ -411,50 +411,50 @@ static int pi433_start_rx(struct pi433_device *dev)
 
 static int pi433_receive(void *data)
 {
-	struct pi433_device *dev = data;
-	struct spi_device *spi = dev->spi;
+	struct pi433_device *pi433 = data;
+	struct spi_device *spi = pi433->spi;
 	int bytes_to_read, bytes_total;
 	int retval;
 
-	dev->interrupt_rx_allowed = false;
+	pi433->interrupt_rx_allowed = false;
 
 	/* wait for any tx to finish */
-	dev_dbg(dev->dev, "rx: going to wait for any tx to finish\n");
-	retval = wait_event_interruptible(dev->rx_wait_queue, !dev->tx_active);
+	dev_dbg(pi433->dev, "rx: going to wait for any tx to finish\n");
+	retval = wait_event_interruptible(pi433->rx_wait_queue, !pi433->tx_active);
 	if (retval) {
 		/* wait was interrupted */
-		dev->interrupt_rx_allowed = true;
-		wake_up_interruptible(&dev->tx_wait_queue);
+		pi433->interrupt_rx_allowed = true;
+		wake_up_interruptible(&pi433->tx_wait_queue);
 		return retval;
 	}
 
 	/* prepare status vars */
-	dev->free_in_fifo = FIFO_SIZE;
-	dev->rx_position = 0;
-	dev->rx_bytes_dropped = 0;
+	pi433->free_in_fifo = FIFO_SIZE;
+	pi433->rx_position = 0;
+	pi433->rx_bytes_dropped = 0;
 
 	/* setup radio module to listen for something "in the air" */
-	retval = pi433_start_rx(dev);
+	retval = pi433_start_rx(pi433);
 	if (retval)
 		return retval;
 
 	/* now check RSSI, if low wait for getting high (RSSI interrupt) */
 	while (!(rf69_read_reg(spi, REG_IRQFLAGS1) & MASK_IRQFLAGS1_RSSI)) {
 		/* allow tx to interrupt us while waiting for high RSSI */
-		dev->interrupt_rx_allowed = true;
-		wake_up_interruptible(&dev->tx_wait_queue);
+		pi433->interrupt_rx_allowed = true;
+		wake_up_interruptible(&pi433->tx_wait_queue);
 
 		/* wait for RSSI level to become high */
-		dev_dbg(dev->dev, "rx: going to wait for high RSSI level\n");
-		retval = wait_event_interruptible(dev->rx_wait_queue,
+		dev_dbg(pi433->dev, "rx: going to wait for high RSSI level\n");
+		retval = wait_event_interruptible(pi433->rx_wait_queue,
 						  rf69_read_reg(spi, REG_IRQFLAGS1) &
 						  MASK_IRQFLAGS1_RSSI);
 		if (retval) /* wait was interrupted */
 			goto abort;
-		dev->interrupt_rx_allowed = false;
+		pi433->interrupt_rx_allowed = false;
 
 		/* cross check for ongoing tx */
-		if (!dev->tx_active)
+		if (!pi433->tx_active)
 			break;
 	}
 
@@ -462,97 +462,97 @@ static int pi433_receive(void *data)
 	retval = rf69_set_dio_mapping(spi, DIO0, DIO_PAYLOAD_READY);
 	if (retval < 0)
 		goto abort;
-	dev->irq_state[DIO0] = DIO_PAYLOAD_READY;
-	irq_set_irq_type(dev->irq_num[DIO0], IRQ_TYPE_EDGE_RISING);
+	pi433->irq_state[DIO0] = DIO_PAYLOAD_READY;
+	irq_set_irq_type(pi433->irq_num[DIO0], IRQ_TYPE_EDGE_RISING);
 
 	/* fixed or unlimited length? */
-	if (dev->rx_cfg.fixed_message_length != 0) {
-		if (dev->rx_cfg.fixed_message_length > dev->rx_buffer_size) {
+	if (pi433->rx_cfg.fixed_message_length != 0) {
+		if (pi433->rx_cfg.fixed_message_length > pi433->rx_buffer_size) {
 			retval = -1;
 			goto abort;
 		}
-		bytes_total = dev->rx_cfg.fixed_message_length;
-		dev_dbg(dev->dev, "rx: msg len set to %d by fixed length\n",
+		bytes_total = pi433->rx_cfg.fixed_message_length;
+		dev_dbg(pi433->dev, "rx: msg len set to %d by fixed length\n",
 			bytes_total);
 	} else {
-		bytes_total = dev->rx_buffer_size;
-		dev_dbg(dev->dev, "rx: msg len set to %d as requested by read\n",
+		bytes_total = pi433->rx_buffer_size;
+		dev_dbg(pi433->dev, "rx: msg len set to %d as requested by read\n",
 			bytes_total);
 	}
 
 	/* length byte enabled? */
-	if (dev->rx_cfg.enable_length_byte == OPTION_ON) {
-		retval = wait_event_interruptible(dev->fifo_wait_queue,
-						  dev->free_in_fifo < FIFO_SIZE);
+	if (pi433->rx_cfg.enable_length_byte == OPTION_ON) {
+		retval = wait_event_interruptible(pi433->fifo_wait_queue,
+						  pi433->free_in_fifo < FIFO_SIZE);
 		if (retval) /* wait was interrupted */
 			goto abort;
 
 		rf69_read_fifo(spi, (u8 *)&bytes_total, 1);
-		if (bytes_total > dev->rx_buffer_size) {
+		if (bytes_total > pi433->rx_buffer_size) {
 			retval = -1;
 			goto abort;
 		}
-		dev->free_in_fifo++;
-		dev_dbg(dev->dev, "rx: msg len reset to %d due to length byte\n",
+		pi433->free_in_fifo++;
+		dev_dbg(pi433->dev, "rx: msg len reset to %d due to length byte\n",
 			bytes_total);
 	}
 
 	/* address byte enabled? */
-	if (dev->rx_cfg.enable_address_filtering != filtering_off) {
+	if (pi433->rx_cfg.enable_address_filtering != filtering_off) {
 		u8 dummy;
 
 		bytes_total--;
 
-		retval = wait_event_interruptible(dev->fifo_wait_queue,
-						  dev->free_in_fifo < FIFO_SIZE);
+		retval = wait_event_interruptible(pi433->fifo_wait_queue,
+						  pi433->free_in_fifo < FIFO_SIZE);
 		if (retval) /* wait was interrupted */
 			goto abort;
 
 		rf69_read_fifo(spi, &dummy, 1);
-		dev->free_in_fifo++;
-		dev_dbg(dev->dev, "rx: address byte stripped off\n");
+		pi433->free_in_fifo++;
+		dev_dbg(pi433->dev, "rx: address byte stripped off\n");
 	}
 
 	/* get payload */
-	while (dev->rx_position < bytes_total) {
+	while (pi433->rx_position < bytes_total) {
 		if (!(rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_PAYLOAD_READY)) {
-			retval = wait_event_interruptible(dev->fifo_wait_queue,
-							  dev->free_in_fifo < FIFO_SIZE);
+			retval = wait_event_interruptible(pi433->fifo_wait_queue,
+							  pi433->free_in_fifo < FIFO_SIZE);
 			if (retval) /* wait was interrupted */
 				goto abort;
 		}
 
 		/* need to drop bytes or acquire? */
-		if (dev->rx_bytes_to_drop > dev->rx_bytes_dropped)
-			bytes_to_read = dev->rx_bytes_to_drop -
-					dev->rx_bytes_dropped;
+		if (pi433->rx_bytes_to_drop > pi433->rx_bytes_dropped)
+			bytes_to_read = pi433->rx_bytes_to_drop -
+					pi433->rx_bytes_dropped;
 		else
-			bytes_to_read = bytes_total - dev->rx_position;
+			bytes_to_read = bytes_total - pi433->rx_position;
 
 		/* access the fifo */
-		if (bytes_to_read > FIFO_SIZE - dev->free_in_fifo)
-			bytes_to_read = FIFO_SIZE - dev->free_in_fifo;
+		if (bytes_to_read > FIFO_SIZE - pi433->free_in_fifo)
+			bytes_to_read = FIFO_SIZE - pi433->free_in_fifo;
 		retval = rf69_read_fifo(spi,
-					&dev->rx_buffer[dev->rx_position],
+					&pi433->rx_buffer[pi433->rx_position],
 					bytes_to_read);
 		if (retval) /* read failed */
 			goto abort;
 
-		dev->free_in_fifo += bytes_to_read;
+		pi433->free_in_fifo += bytes_to_read;
 
 		/* adjust status vars */
-		if (dev->rx_bytes_to_drop > dev->rx_bytes_dropped)
-			dev->rx_bytes_dropped += bytes_to_read;
+		if (pi433->rx_bytes_to_drop > pi433->rx_bytes_dropped)
+			pi433->rx_bytes_dropped += bytes_to_read;
 		else
-			dev->rx_position += bytes_to_read;
+			pi433->rx_position += bytes_to_read;
 	}
 
 	/* rx done, wait was interrupted or error occurred */
 abort:
-	dev->interrupt_rx_allowed = true;
-	if (rf69_set_mode(dev->spi, standby))
+	pi433->interrupt_rx_allowed = true;
+	if (rf69_set_mode(pi433->spi, standby))
 		pr_err("rf69_set_mode(): radio module failed to go standby\n");
-	wake_up_interruptible(&dev->tx_wait_queue);
+	wake_up_interruptible(&pi433->tx_wait_queue);
 
 	if (retval)
 		return retval;
@@ -562,8 +562,8 @@ static int pi433_receive(void *data)
 
 static int pi433_tx_thread(void *data)
 {
-	struct pi433_device *device = data;
-	struct spi_device *spi = device->spi;
+	struct pi433_device *pi433 = data;
+	struct spi_device *spi = pi433->spi;
 	struct pi433_tx_cfg tx_cfg;
 	size_t size;
 	bool   rx_interrupted = false;
@@ -572,9 +572,9 @@ static int pi433_tx_thread(void *data)
 
 	while (1) {
 		/* wait for fifo to be populated or for request to terminate*/
-		dev_dbg(device->dev, "thread: going to wait for new messages\n");
-		wait_event_interruptible(device->tx_wait_queue,
-					 (!kfifo_is_empty(&device->tx_fifo) ||
+		dev_dbg(pi433->dev, "thread: going to wait for new messages\n");
+		wait_event_interruptible(pi433->tx_wait_queue,
+					 (!kfifo_is_empty(&pi433->tx_fifo) ||
 					  kthread_should_stop()));
 		if (kthread_should_stop())
 			return 0;
@@ -585,17 +585,17 @@ static int pi433_tx_thread(void *data)
 		 * - size of message
 		 * - message
 		 */
-		retval = kfifo_out(&device->tx_fifo, &tx_cfg, sizeof(tx_cfg));
+		retval = kfifo_out(&pi433->tx_fifo, &tx_cfg, sizeof(tx_cfg));
 		if (retval != sizeof(tx_cfg)) {
-			dev_dbg(device->dev,
+			dev_dbg(pi433->dev,
 				"reading tx_cfg from fifo failed: got %d byte(s), expected %d\n",
 				retval, (unsigned int)sizeof(tx_cfg));
 			continue;
 		}
 
-		retval = kfifo_out(&device->tx_fifo, &size, sizeof(size_t));
+		retval = kfifo_out(&pi433->tx_fifo, &size, sizeof(size_t));
 		if (retval != sizeof(size_t)) {
-			dev_dbg(device->dev,
+			dev_dbg(pi433->dev,
 				"reading msg size from fifo failed: got %d, expected %d\n",
 				retval, (unsigned int)sizeof(size_t));
 			continue;
@@ -614,7 +614,7 @@ static int pi433_tx_thread(void *data)
 			size++;
 
 		/* prime tx_buffer */
-		memset(device->tx_buffer, 0, size);
+		memset(pi433->tx_buffer, 0, size);
 		position = 0;
 
 		/* add length byte, if requested */
@@ -623,16 +623,16 @@ static int pi433_tx_thread(void *data)
 			 * according to spec, length byte itself must be
 			 * excluded from the length calculation
 			 */
-			device->tx_buffer[position++] = size - 1;
+			pi433->tx_buffer[position++] = size - 1;
 
 		/* add adr byte, if requested */
 		if (tx_cfg.enable_address_byte == OPTION_ON)
-			device->tx_buffer[position++] = tx_cfg.address_byte;
+			pi433->tx_buffer[position++] = tx_cfg.address_byte;
 
 		/* finally get message data from fifo */
-		retval = kfifo_out(&device->tx_fifo, &device->tx_buffer[position],
-				   sizeof(device->tx_buffer) - position);
-		dev_dbg(device->dev,
+		retval = kfifo_out(&pi433->tx_fifo, &pi433->tx_buffer[position],
+				   sizeof(pi433->tx_buffer) - position);
+		dev_dbg(pi433->dev,
 			"read %d message byte(s) from fifo queue.\n", retval);
 
 		/*
@@ -642,23 +642,23 @@ static int pi433_tx_thread(void *data)
 		 * place otherwise we need to  wait for the incoming telegram
 		 * to finish
 		 */
-		wait_event_interruptible(device->tx_wait_queue,
-					 !device->rx_active ||
-					  device->interrupt_rx_allowed);
+		wait_event_interruptible(pi433->tx_wait_queue,
+					 !pi433->rx_active ||
+					  pi433->interrupt_rx_allowed);
 
 		/*
 		 * prevent race conditions
 		 * irq will be re-enabled after tx config is set
 		 */
-		disable_irq(device->irq_num[DIO0]);
-		device->tx_active = true;
+		disable_irq(pi433->irq_num[DIO0]);
+		pi433->tx_active = true;
 
 		/* clear fifo, set fifo threshold, set payload length */
 		retval = rf69_set_mode(spi, standby); /* this clears the fifo */
 		if (retval < 0)
 			goto abort;
 
-		if (device->rx_active && !rx_interrupted) {
+		if (pi433->rx_active && !rx_interrupted) {
 			/*
 			 * rx is currently waiting for a telegram;
 			 * we need to set the radio module to standby
@@ -680,7 +680,7 @@ static int pi433_tx_thread(void *data)
 		}
 
 		/* configure the rf chip */
-		retval = rf69_set_tx_cfg(device, &tx_cfg);
+		retval = rf69_set_tx_cfg(pi433, &tx_cfg);
 		if (retval < 0)
 			goto abort;
 
@@ -688,16 +688,16 @@ static int pi433_tx_thread(void *data)
 		retval = rf69_set_dio_mapping(spi, DIO1, DIO_FIFO_LEVEL);
 		if (retval < 0)
 			goto abort;
-		device->irq_state[DIO1] = DIO_FIFO_LEVEL;
-		irq_set_irq_type(device->irq_num[DIO1], IRQ_TYPE_EDGE_FALLING);
+		pi433->irq_state[DIO1] = DIO_FIFO_LEVEL;
+		irq_set_irq_type(pi433->irq_num[DIO1], IRQ_TYPE_EDGE_FALLING);
 
 		/* enable packet sent interrupt */
 		retval = rf69_set_dio_mapping(spi, DIO0, DIO_PACKET_SENT);
 		if (retval < 0)
 			goto abort;
-		device->irq_state[DIO0] = DIO_PACKET_SENT;
-		irq_set_irq_type(device->irq_num[DIO0], IRQ_TYPE_EDGE_RISING);
-		enable_irq(device->irq_num[DIO0]); /* was disabled by rx active check */
+		pi433->irq_state[DIO0] = DIO_PACKET_SENT;
+		irq_set_irq_type(pi433->irq_num[DIO0], IRQ_TYPE_EDGE_RISING);
+		enable_irq(pi433->irq_num[DIO0]); /* was disabled by rx active check */
 
 		/* enable transmission */
 		retval = rf69_set_mode(spi, transmit);
@@ -705,61 +705,61 @@ static int pi433_tx_thread(void *data)
 			goto abort;
 
 		/* transfer this msg (and repetitions) to chip fifo */
-		device->free_in_fifo = FIFO_SIZE;
+		pi433->free_in_fifo = FIFO_SIZE;
 		position = 0;
 		repetitions = tx_cfg.repetitions;
 		while ((repetitions > 0) && (size > position)) {
-			if ((size - position) > device->free_in_fifo) {
+			if ((size - position) > pi433->free_in_fifo) {
 				/* msg to big for fifo - take a part */
-				int write_size = device->free_in_fifo;
+				int write_size = pi433->free_in_fifo;
 
-				device->free_in_fifo = 0;
+				pi433->free_in_fifo = 0;
 				rf69_write_fifo(spi,
-						&device->tx_buffer[position],
+						&pi433->tx_buffer[position],
 						write_size);
 				position += write_size;
 			} else {
 				/* msg fits into fifo - take all */
-				device->free_in_fifo -= size;
+				pi433->free_in_fifo -= size;
 				repetitions--;
 				rf69_write_fifo(spi,
-						&device->tx_buffer[position],
+						&pi433->tx_buffer[position],
 						(size - position));
 				position = 0; /* reset for next repetition */
 			}
 
-			retval = wait_event_interruptible(device->fifo_wait_queue,
-							  device->free_in_fifo > 0);
+			retval = wait_event_interruptible(pi433->fifo_wait_queue,
+							  pi433->free_in_fifo > 0);
 			if (retval) {
-				dev_dbg(device->dev, "ABORT\n");
+				dev_dbg(pi433->dev, "ABORT\n");
 				goto abort;
 			}
 		}
 
 		/* we are done. Wait for packet to get sent */
-		dev_dbg(device->dev,
+		dev_dbg(pi433->dev,
 			"thread: wait for packet to get sent/fifo to be empty\n");
-		wait_event_interruptible(device->fifo_wait_queue,
-					 device->free_in_fifo == FIFO_SIZE ||
+		wait_event_interruptible(pi433->fifo_wait_queue,
+					 pi433->free_in_fifo == FIFO_SIZE ||
 					 kthread_should_stop());
 		if (kthread_should_stop())
 			return 0;
 
 		/* STOP_TRANSMISSION */
-		dev_dbg(device->dev, "thread: Packet sent. Set mode to stby.\n");
+		dev_dbg(pi433->dev, "thread: Packet sent. Set mode to stby.\n");
 		retval = rf69_set_mode(spi, standby);
 		if (retval < 0)
 			goto abort;
 
 		/* everything sent? */
-		if (kfifo_is_empty(&device->tx_fifo)) {
+		if (kfifo_is_empty(&pi433->tx_fifo)) {
 abort:
 			if (rx_interrupted) {
 				rx_interrupted = false;
-				pi433_start_rx(device);
+				pi433_start_rx(pi433);
 			}
-			device->tx_active = false;
-			wake_up_interruptible(&device->rx_wait_queue);
+			pi433->tx_active = false;
+			wake_up_interruptible(&pi433->rx_wait_queue);
 		}
 	}
 }
@@ -770,7 +770,7 @@ static ssize_t
 pi433_read(struct file *filp, char __user *buf, size_t size, loff_t *f_pos)
 {
 	struct pi433_instance	*instance;
-	struct pi433_device	*device;
+	struct pi433_device	*pi433;
 	int			bytes_received;
 	ssize_t			retval;
 
@@ -779,31 +779,31 @@ pi433_read(struct file *filp, char __user *buf, size_t size, loff_t *f_pos)
 		return -EMSGSIZE;
 
 	instance = filp->private_data;
-	device = instance->device;
+	pi433 = instance->pi433;
 
 	/* just one read request at a time */
-	mutex_lock(&device->rx_lock);
-	if (device->rx_active) {
-		mutex_unlock(&device->rx_lock);
+	mutex_lock(&pi433->rx_lock);
+	if (pi433->rx_active) {
+		mutex_unlock(&pi433->rx_lock);
 		return -EAGAIN;
 	}
 
-	device->rx_active = true;
-	mutex_unlock(&device->rx_lock);
+	pi433->rx_active = true;
+	mutex_unlock(&pi433->rx_lock);
 
 	/* start receiving */
 	/* will block until something was received*/
-	device->rx_buffer_size = size;
-	bytes_received = pi433_receive(device);
+	pi433->rx_buffer_size = size;
+	bytes_received = pi433_receive(pi433);
 
 	/* release rx */
-	mutex_lock(&device->rx_lock);
-	device->rx_active = false;
-	mutex_unlock(&device->rx_lock);
+	mutex_lock(&pi433->rx_lock);
+	pi433->rx_active = false;
+	mutex_unlock(&pi433->rx_lock);
 
 	/* if read was successful copy to user space*/
 	if (bytes_received > 0) {
-		retval = copy_to_user(buf, device->rx_buffer, bytes_received);
+		retval = copy_to_user(buf, pi433->rx_buffer, bytes_received);
 		if (retval)
 			return -EFAULT;
 	}
@@ -816,12 +816,12 @@ pi433_write(struct file *filp, const char __user *buf,
 	    size_t count, loff_t *f_pos)
 {
 	struct pi433_instance	*instance;
-	struct pi433_device	*device;
+	struct pi433_device	*pi433;
 	int                     retval;
 	unsigned int		required, available, copied;
 
 	instance = filp->private_data;
-	device = instance->device;
+	pi433 = instance->pi433;
 
 	/*
 	 * check, whether internal buffer (tx thread) is big enough
@@ -835,7 +835,7 @@ pi433_write(struct file *filp, const char __user *buf,
 	 * config the RF trasmitter correctly due to invalid settings
 	 */
 	if (!instance->tx_cfg_initialized) {
-		dev_notice_once(device->dev,
+		dev_notice_once(pi433->dev,
 				"write: failed due to unconfigured tx_cfg (see PI433_IOC_WR_TX_CFG)\n");
 		return -EINVAL;
 	}
@@ -846,49 +846,49 @@ pi433_write(struct file *filp, const char __user *buf,
 	 * - size of message
 	 * - message
 	 */
-	mutex_lock(&device->tx_fifo_lock);
+	mutex_lock(&pi433->tx_fifo_lock);
 
 	required = sizeof(instance->tx_cfg) + sizeof(size_t) + count;
-	available = kfifo_avail(&device->tx_fifo);
+	available = kfifo_avail(&pi433->tx_fifo);
 	if (required > available) {
-		dev_dbg(device->dev, "write to fifo failed: %d bytes required but %d available\n",
+		dev_dbg(pi433->dev, "write to fifo failed: %d bytes required but %d available\n",
 			required, available);
-		mutex_unlock(&device->tx_fifo_lock);
+		mutex_unlock(&pi433->tx_fifo_lock);
 		return -EAGAIN;
 	}
 
-	retval = kfifo_in(&device->tx_fifo, &instance->tx_cfg,
+	retval = kfifo_in(&pi433->tx_fifo, &instance->tx_cfg,
 			  sizeof(instance->tx_cfg));
 	if (retval != sizeof(instance->tx_cfg))
 		goto abort;
 
-	retval = kfifo_in(&device->tx_fifo, &count, sizeof(size_t));
+	retval = kfifo_in(&pi433->tx_fifo, &count, sizeof(size_t));
 	if (retval != sizeof(size_t))
 		goto abort;
 
-	retval = kfifo_from_user(&device->tx_fifo, buf, count, &copied);
+	retval = kfifo_from_user(&pi433->tx_fifo, buf, count, &copied);
 	if (retval || copied != count)
 		goto abort;
 
-	mutex_unlock(&device->tx_fifo_lock);
+	mutex_unlock(&pi433->tx_fifo_lock);
 
 	/* start transfer */
-	wake_up_interruptible(&device->tx_wait_queue);
-	dev_dbg(device->dev, "write: generated new msg with %d bytes.\n", copied);
+	wake_up_interruptible(&pi433->tx_wait_queue);
+	dev_dbg(pi433->dev, "write: generated new msg with %d bytes.\n", copied);
 
 	return copied;
 
 abort:
-	dev_warn(device->dev,
+	dev_warn(pi433->dev,
 		 "write to fifo failed, non recoverable: 0x%x\n", retval);
-	mutex_unlock(&device->tx_fifo_lock);
+	mutex_unlock(&pi433->tx_fifo_lock);
 	return -EAGAIN;
 }
 
 static long pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct pi433_instance	*instance;
-	struct pi433_device	*device;
+	struct pi433_device	*pi433;
 	struct pi433_tx_cfg	tx_cfg;
 	void __user *argp = (void __user *)arg;
 
@@ -897,9 +897,9 @@ static long pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return -ENOTTY;
 
 	instance = filp->private_data;
-	device = instance->device;
+	pi433 = instance->pi433;
 
-	if (!device)
+	if (!pi433)
 		return -ESHUTDOWN;
 
 	switch (cmd) {
@@ -911,32 +911,32 @@ static long pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case PI433_IOC_WR_TX_CFG:
 		if (copy_from_user(&tx_cfg, argp, sizeof(struct pi433_tx_cfg)))
 			return -EFAULT;
-		mutex_lock(&device->tx_fifo_lock);
+		mutex_lock(&pi433->tx_fifo_lock);
 		memcpy(&instance->tx_cfg, &tx_cfg, sizeof(struct pi433_tx_cfg));
 		instance->tx_cfg_initialized = true;
-		mutex_unlock(&device->tx_fifo_lock);
+		mutex_unlock(&pi433->tx_fifo_lock);
 		break;
 	case PI433_IOC_RD_RX_CFG:
-		if (copy_to_user(argp, &device->rx_cfg,
+		if (copy_to_user(argp, &pi433->rx_cfg,
 				 sizeof(struct pi433_rx_cfg)))
 			return -EFAULT;
 		break;
 	case PI433_IOC_WR_RX_CFG:
-		mutex_lock(&device->rx_lock);
+		mutex_lock(&pi433->rx_lock);
 
 		/* during pending read request, change of config not allowed */
-		if (device->rx_active) {
-			mutex_unlock(&device->rx_lock);
+		if (pi433->rx_active) {
+			mutex_unlock(&pi433->rx_lock);
 			return -EAGAIN;
 		}
 
-		if (copy_from_user(&device->rx_cfg, argp,
+		if (copy_from_user(&pi433->rx_cfg, argp,
 				   sizeof(struct pi433_rx_cfg))) {
-			mutex_unlock(&device->rx_lock);
+			mutex_unlock(&pi433->rx_lock);
 			return -EFAULT;
 		}
 
-		mutex_unlock(&device->rx_lock);
+		mutex_unlock(&pi433->rx_lock);
 		break;
 	default:
 		return -EINVAL;
@@ -949,13 +949,13 @@ static long pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 static int pi433_open(struct inode *inode, struct file *filp)
 {
-	struct pi433_device	*device;
+	struct pi433_device	*pi433;
 	struct pi433_instance	*instance;
 
 	mutex_lock(&minor_lock);
-	device = idr_find(&pi433_idr, iminor(inode));
+	pi433 = idr_find(&pi433_idr, iminor(inode));
 	mutex_unlock(&minor_lock);
-	if (!device) {
+	if (!pi433) {
 		pr_debug("device: minor %d unknown.\n", iminor(inode));
 		return -ENODEV;
 	}
@@ -965,7 +965,7 @@ static int pi433_open(struct inode *inode, struct file *filp)
 		return -ENOMEM;
 
 	/* setup instance data*/
-	instance->device = device;
+	instance->pi433 = pi433;
 
 	/* instance data as context */
 	filp->private_data = instance;
@@ -987,7 +987,7 @@ static int pi433_release(struct inode *inode, struct file *filp)
 
 /*-------------------------------------------------------------------------*/
 
-static int setup_gpio(struct pi433_device *device)
+static int setup_gpio(struct pi433_device *pi433)
 {
 	char	name[5];
 	int	retval;
@@ -1000,89 +1000,89 @@ static int setup_gpio(struct pi433_device *device)
 	for (i = 0; i < NUM_DIO; i++) {
 		/* "construct" name and get the gpio descriptor */
 		snprintf(name, sizeof(name), "DIO%d", i);
-		device->gpiod[i] = gpiod_get(&device->spi->dev, name,
-					     0 /*GPIOD_IN*/);
+		pi433->gpiod[i] = gpiod_get(&pi433->spi->dev, name,
+					    0 /*GPIOD_IN*/);
 
-		if (device->gpiod[i] == ERR_PTR(-ENOENT)) {
-			dev_dbg(&device->spi->dev,
+		if (pi433->gpiod[i] == ERR_PTR(-ENOENT)) {
+			dev_dbg(&pi433->spi->dev,
 				"Could not find entry for %s. Ignoring.\n", name);
 			continue;
 		}
 
-		if (device->gpiod[i] == ERR_PTR(-EBUSY))
-			dev_dbg(&device->spi->dev, "%s is busy.\n", name);
+		if (pi433->gpiod[i] == ERR_PTR(-EBUSY))
+			dev_dbg(&pi433->spi->dev, "%s is busy.\n", name);
 
-		if (IS_ERR(device->gpiod[i])) {
-			retval = PTR_ERR(device->gpiod[i]);
+		if (IS_ERR(pi433->gpiod[i])) {
+			retval = PTR_ERR(pi433->gpiod[i]);
 			/* release already allocated gpios */
 			for (i--; i >= 0; i--) {
-				free_irq(device->irq_num[i], device);
-				gpiod_put(device->gpiod[i]);
+				free_irq(pi433->irq_num[i], pi433);
+				gpiod_put(pi433->gpiod[i]);
 			}
 			return retval;
 		}
 
 		/* configure the pin */
-		retval = gpiod_direction_input(device->gpiod[i]);
+		retval = gpiod_direction_input(pi433->gpiod[i]);
 		if (retval)
 			return retval;
 
 		/* configure irq */
-		device->irq_num[i] = gpiod_to_irq(device->gpiod[i]);
-		if (device->irq_num[i] < 0) {
-			device->gpiod[i] = ERR_PTR(-EINVAL);
-			return device->irq_num[i];
+		pi433->irq_num[i] = gpiod_to_irq(pi433->gpiod[i]);
+		if (pi433->irq_num[i] < 0) {
+			pi433->gpiod[i] = ERR_PTR(-EINVAL);
+			return pi433->irq_num[i];
 		}
-		retval = request_irq(device->irq_num[i],
+		retval = request_irq(pi433->irq_num[i],
 				     DIO_irq_handler[i],
 				     0, /* flags */
 				     name,
-				     device);
+				     pi433);
 
 		if (retval)
 			return retval;
 
-		dev_dbg(&device->spi->dev, "%s successfully configured\n", name);
+		dev_dbg(&pi433->spi->dev, "%s successfully configured\n", name);
 	}
 
 	return 0;
 }
 
-static void free_gpio(struct pi433_device *device)
+static void free_gpio(struct pi433_device *pi433)
 {
 	int i;
 
 	for (i = 0; i < NUM_DIO; i++) {
 		/* check if gpiod is valid */
-		if (IS_ERR(device->gpiod[i]))
+		if (IS_ERR(pi433->gpiod[i]))
 			continue;
 
-		free_irq(device->irq_num[i], device);
-		gpiod_put(device->gpiod[i]);
+		free_irq(pi433->irq_num[i], pi433);
+		gpiod_put(pi433->gpiod[i]);
 	}
 }
 
-static int pi433_get_minor(struct pi433_device *device)
+static int pi433_get_minor(struct pi433_device *pi433)
 {
 	int retval = -ENOMEM;
 
 	mutex_lock(&minor_lock);
-	retval = idr_alloc(&pi433_idr, device, 0, N_PI433_MINORS, GFP_KERNEL);
+	retval = idr_alloc(&pi433_idr, pi433, 0, N_PI433_MINORS, GFP_KERNEL);
 	if (retval >= 0) {
-		device->minor = retval;
+		pi433->minor = retval;
 		retval = 0;
 	} else if (retval == -ENOSPC) {
-		dev_err(&device->spi->dev, "too many pi433 devices\n");
+		dev_err(&pi433->spi->dev, "too many pi433 devices\n");
 		retval = -EINVAL;
 	}
 	mutex_unlock(&minor_lock);
 	return retval;
 }
 
-static void pi433_free_minor(struct pi433_device *dev)
+static void pi433_free_minor(struct pi433_device *pi433)
 {
 	mutex_lock(&minor_lock);
-	idr_remove(&pi433_idr, dev->minor);
+	idr_remove(&pi433_idr, pi433->minor);
 	mutex_unlock(&minor_lock);
 }
 
@@ -1106,35 +1106,35 @@ static const struct file_operations pi433_fops = {
 
 static int pi433_debugfs_regs_show(struct seq_file *m, void *p)
 {
-	struct pi433_device *dev;
+	struct pi433_device *pi433;
 	u8 reg_data[114];
 	int i;
 	char *fmt = "0x%02x, 0x%02x\n";
 	int ret;
 
-	dev = m->private;
+	pi433 = m->private;
 
-	mutex_lock(&dev->tx_fifo_lock);
-	mutex_lock(&dev->rx_lock);
+	mutex_lock(&pi433->tx_fifo_lock);
+	mutex_lock(&pi433->rx_lock);
 
 	// wait for on-going operations to finish
-	ret = wait_event_interruptible(dev->rx_wait_queue, !dev->tx_active);
+	ret = wait_event_interruptible(pi433->rx_wait_queue, !pi433->tx_active);
 	if (ret)
 		goto out_unlock;
 
-	ret = wait_event_interruptible(dev->tx_wait_queue, !dev->rx_active);
+	ret = wait_event_interruptible(pi433->tx_wait_queue, !pi433->rx_active);
 	if (ret)
 		goto out_unlock;
 
 	// skip FIFO register (0x0) otherwise this can affect some of uC ops
 	for (i = 1; i < 0x50; i++)
-		reg_data[i] = rf69_read_reg(dev->spi, i);
+		reg_data[i] = rf69_read_reg(pi433->spi, i);
 
-	reg_data[REG_TESTLNA] = rf69_read_reg(dev->spi, REG_TESTLNA);
-	reg_data[REG_TESTPA1] = rf69_read_reg(dev->spi, REG_TESTPA1);
-	reg_data[REG_TESTPA2] = rf69_read_reg(dev->spi, REG_TESTPA2);
-	reg_data[REG_TESTDAGC] = rf69_read_reg(dev->spi, REG_TESTDAGC);
-	reg_data[REG_TESTAFC] = rf69_read_reg(dev->spi, REG_TESTAFC);
+	reg_data[REG_TESTLNA] = rf69_read_reg(pi433->spi, REG_TESTLNA);
+	reg_data[REG_TESTPA1] = rf69_read_reg(pi433->spi, REG_TESTPA1);
+	reg_data[REG_TESTPA2] = rf69_read_reg(pi433->spi, REG_TESTPA2);
+	reg_data[REG_TESTDAGC] = rf69_read_reg(pi433->spi, REG_TESTDAGC);
+	reg_data[REG_TESTAFC] = rf69_read_reg(pi433->spi, REG_TESTAFC);
 
 	seq_puts(m, "# reg, val\n");
 
@@ -1148,8 +1148,8 @@ static int pi433_debugfs_regs_show(struct seq_file *m, void *p)
 	seq_printf(m, fmt, REG_TESTAFC, reg_data[REG_TESTAFC]);
 
 out_unlock:
-	mutex_unlock(&dev->rx_lock);
-	mutex_unlock(&dev->tx_fifo_lock);
+	mutex_unlock(&pi433->rx_lock);
+	mutex_unlock(&pi433->tx_fifo_lock);
 
 	return ret;
 }
@@ -1159,7 +1159,7 @@ DEFINE_SHOW_ATTRIBUTE(pi433_debugfs_regs);
 
 static int pi433_probe(struct spi_device *spi)
 {
-	struct pi433_device	*device;
+	struct pi433_device	*pi433;
 	int			retval;
 	struct dentry		*entry;
 
@@ -1196,37 +1196,37 @@ static int pi433_probe(struct spi_device *spi)
 	}
 
 	/* Allocate driver data */
-	device = kzalloc(sizeof(*device), GFP_KERNEL);
-	if (!device)
+	pi433 = kzalloc(sizeof(*pi433), GFP_KERNEL);
+	if (!pi433)
 		return -ENOMEM;
 
 	/* Initialize the driver data */
-	device->spi = spi;
-	device->rx_active = false;
-	device->tx_active = false;
-	device->interrupt_rx_allowed = false;
+	pi433->spi = spi;
+	pi433->rx_active = false;
+	pi433->tx_active = false;
+	pi433->interrupt_rx_allowed = false;
 
 	/* init rx buffer */
-	device->rx_buffer = kmalloc(MAX_MSG_SIZE, GFP_KERNEL);
-	if (!device->rx_buffer) {
+	pi433->rx_buffer = kmalloc(MAX_MSG_SIZE, GFP_KERNEL);
+	if (!pi433->rx_buffer) {
 		retval = -ENOMEM;
 		goto RX_failed;
 	}
 
 	/* init wait queues */
-	init_waitqueue_head(&device->tx_wait_queue);
-	init_waitqueue_head(&device->rx_wait_queue);
-	init_waitqueue_head(&device->fifo_wait_queue);
+	init_waitqueue_head(&pi433->tx_wait_queue);
+	init_waitqueue_head(&pi433->rx_wait_queue);
+	init_waitqueue_head(&pi433->fifo_wait_queue);
 
 	/* init fifo */
-	INIT_KFIFO(device->tx_fifo);
+	INIT_KFIFO(pi433->tx_fifo);
 
 	/* init mutexes and locks */
-	mutex_init(&device->tx_fifo_lock);
-	mutex_init(&device->rx_lock);
+	mutex_init(&pi433->tx_fifo_lock);
+	mutex_init(&pi433->rx_lock);
 
 	/* setup GPIO (including irq_handler) for the different DIOs */
-	retval = setup_gpio(device);
+	retval = setup_gpio(pi433);
 	if (retval) {
 		dev_dbg(&spi->dev, "setup of GPIOs failed\n");
 		goto GPIO_failed;
@@ -1256,105 +1256,105 @@ static int pi433_probe(struct spi_device *spi)
 		goto minor_failed;
 
 	/* determ minor number */
-	retval = pi433_get_minor(device);
+	retval = pi433_get_minor(pi433);
 	if (retval) {
 		dev_dbg(&spi->dev, "get of minor number failed\n");
 		goto minor_failed;
 	}
 
 	/* create device */
-	device->devt = MKDEV(MAJOR(pi433_dev), device->minor);
-	device->dev = device_create(&pi433_class,
-				    &spi->dev,
-				    device->devt,
-				    device,
-				    "pi433.%d",
-				    device->minor);
-	if (IS_ERR(device->dev)) {
+	pi433->devt = MKDEV(MAJOR(pi433_dev), pi433->minor);
+	pi433->dev = device_create(&pi433_class,
+				   &spi->dev,
+				   pi433->devt,
+				   pi433,
+				   "pi433.%d",
+				   pi433->minor);
+	if (IS_ERR(pi433->dev)) {
 		pr_err("pi433: device register failed\n");
-		retval = PTR_ERR(device->dev);
+		retval = PTR_ERR(pi433->dev);
 		goto device_create_failed;
 	} else {
-		dev_dbg(device->dev,
+		dev_dbg(pi433->dev,
 			"created device for major %d, minor %d\n",
 			MAJOR(pi433_dev),
-			device->minor);
+			pi433->minor);
 	}
 
 	/* start tx thread */
-	device->tx_task_struct = kthread_run(pi433_tx_thread,
-					     device,
-					     "pi433.%d_tx_task",
-					     device->minor);
-	if (IS_ERR(device->tx_task_struct)) {
-		dev_dbg(device->dev, "start of send thread failed\n");
-		retval = PTR_ERR(device->tx_task_struct);
+	pi433->tx_task_struct = kthread_run(pi433_tx_thread,
+					    pi433,
+					    "pi433.%d_tx_task",
+					    pi433->minor);
+	if (IS_ERR(pi433->tx_task_struct)) {
+		dev_dbg(pi433->dev, "start of send thread failed\n");
+		retval = PTR_ERR(pi433->tx_task_struct);
 		goto send_thread_failed;
 	}
 
 	/* create cdev */
-	device->cdev = cdev_alloc();
-	if (!device->cdev) {
-		dev_dbg(device->dev, "allocation of cdev failed\n");
+	pi433->cdev = cdev_alloc();
+	if (!pi433->cdev) {
+		dev_dbg(pi433->dev, "allocation of cdev failed\n");
 		retval = -ENOMEM;
 		goto cdev_failed;
 	}
-	device->cdev->owner = THIS_MODULE;
-	cdev_init(device->cdev, &pi433_fops);
-	retval = cdev_add(device->cdev, device->devt, 1);
+	pi433->cdev->owner = THIS_MODULE;
+	cdev_init(pi433->cdev, &pi433_fops);
+	retval = cdev_add(pi433->cdev, pi433->devt, 1);
 	if (retval) {
-		dev_dbg(device->dev, "register of cdev failed\n");
+		dev_dbg(pi433->dev, "register of cdev failed\n");
 		goto del_cdev;
 	}
 
 	/* spi setup */
-	spi_set_drvdata(spi, device);
+	spi_set_drvdata(spi, pi433);
 
-	entry = debugfs_create_dir(dev_name(device->dev), root_dir);
-	debugfs_create_file("regs", 0400, entry, device, &pi433_debugfs_regs_fops);
+	entry = debugfs_create_dir(dev_name(pi433->dev), root_dir);
+	debugfs_create_file("regs", 0400, entry, pi433, &pi433_debugfs_regs_fops);
 
 	return 0;
 
 del_cdev:
-	cdev_del(device->cdev);
+	cdev_del(pi433->cdev);
 cdev_failed:
-	kthread_stop(device->tx_task_struct);
+	kthread_stop(pi433->tx_task_struct);
 send_thread_failed:
-	device_destroy(&pi433_class, device->devt);
+	device_destroy(&pi433_class, pi433->devt);
 device_create_failed:
-	pi433_free_minor(device);
+	pi433_free_minor(pi433);
 minor_failed:
-	free_gpio(device);
+	free_gpio(pi433);
 GPIO_failed:
-	kfree(device->rx_buffer);
+	kfree(pi433->rx_buffer);
 RX_failed:
-	kfree(device);
+	kfree(pi433);
 
 	return retval;
 }
 
 static void pi433_remove(struct spi_device *spi)
 {
-	struct pi433_device	*device = spi_get_drvdata(spi);
+	struct pi433_device	*pi433 = spi_get_drvdata(spi);
 
-	debugfs_lookup_and_remove(dev_name(device->dev), root_dir);
+	debugfs_lookup_and_remove(dev_name(pi433->dev), root_dir);
 
 	/* free GPIOs */
-	free_gpio(device);
+	free_gpio(pi433);
 
 	/* make sure ops on existing fds can abort cleanly */
-	device->spi = NULL;
+	pi433->spi = NULL;
 
-	kthread_stop(device->tx_task_struct);
+	kthread_stop(pi433->tx_task_struct);
 
-	device_destroy(&pi433_class, device->devt);
+	device_destroy(&pi433_class, pi433->devt);
 
-	cdev_del(device->cdev);
+	cdev_del(pi433->cdev);
 
-	pi433_free_minor(device);
+	pi433_free_minor(pi433);
 
-	kfree(device->rx_buffer);
-	kfree(device);
+	kfree(pi433->rx_buffer);
+	kfree(pi433);
 }
 
 static const struct of_device_id pi433_dt_ids[] = {
-- 
2.34.1


