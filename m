Return-Path: <linux-kernel+bounces-148612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7A58A8516
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68898B25043
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9811411C4;
	Wed, 17 Apr 2024 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="LCHFR0oO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="qrgC8E3C"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44D113F42D;
	Wed, 17 Apr 2024 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361459; cv=none; b=K2ZHLpFjkbRJGRW/ind1fe99SOkom/b5Bgdrdf6Lgu9nBRtGT1GjgSZhvBha668DCUvLGHtlSehH7rq9jgwRjgzqzsi18ofBFcamKekTlMzOWPRG+HuUXYsbaLboJxx9A+XANeO+SsIsf7u1NGvq+918i0viylW0jrkL2fHPMyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361459; c=relaxed/simple;
	bh=G9CV2IDmvN9SvoNGxvVTVF4YluRtXT0j7nf86rqgr0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IYlPGe/WUKd74mS6vhc3PliBKOcMvjIi4gDcsoPvlsYw3s5E2g75mTFBn0D5sNOaXM1PNRj7aROIOGzdx38ujWDJ5KgjyjqhgU8SR74InX4O1+0vWYyQFo2PDXbB4CIaVt88231df15FMw3iLKPGpsuxwt+aT8wM3mdbKIa+PWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=LCHFR0oO; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=qrgC8E3C reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713361456; x=1744897456;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=9ecwfr2jTX8nUYKdYFcFhX7DqDXFj9IkXl4aWoV6EaQ=;
  b=LCHFR0oOXkfXjvyIgRYA3IC0hKFCXVeEpBdZ0BqZfOIoQI6M5bErpw3i
   0TqVlPWC+H/urXObLj3sej3OPIzEQSVznEc6ARyam4xnUn+XYyxNoL+90
   nAB/F0GdTih49xeISMTDn+SXpnG3tJWJ27JVHFXY60sxgE/rN5T3NTdoN
   RZqxlDs58BDEQXAUK0SalcHgWw8SL/adfhlRTMG5n3ClG8dgxBQq1oBOe
   qzzyFvwvwp27TUsumZDl9vMulqU+PmSUucamD1ni8VZ5aXaUmAIaEgj4d
   qGOnUWMpN6+yBqGRz/mmcnEIKysxh6skN0ik/GnSLGoKTBQ3FCWjNBj1k
   w==;
X-IronPort-AV: E=Sophos;i="6.07,209,1708383600"; 
   d="scan'208";a="36469973"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 17 Apr 2024 15:44:13 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 12DD5173228;
	Wed, 17 Apr 2024 15:44:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713361449;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9ecwfr2jTX8nUYKdYFcFhX7DqDXFj9IkXl4aWoV6EaQ=;
	b=qrgC8E3C3KTBohezvOoHHqT3Qt1x6ui2tv4Jk14J71cmnAJtGbN+sDcpt8s8T6nMNdbcBb
	/+eLef+Z/awypojM8WI0BjG0/06/n++CpFw7B5tJcNBTR3hxGOjP4ccbbWtKoj/rTaUlbw
	hCp/hW6yA6LwVe5rO0mwd0gynwF+BVsaCJrpKF+GgZpLC5k75xOI44AJA54yIvGHQZFK+R
	9zMvY8MZPGnuiWUDStl0QFvxbl7PSZcBt7gSW7c0tJnoM3SodZ9DuamJeeH/7LhmjU5OvL
	IJR2q9XhUlLSkwzAqzoaWiRG0cIA7N2V167mYsxpiPEEfSzrXpf2ZGWaUQqRvw==
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Date: Wed, 17 Apr 2024 15:43:54 +0200
Subject: [PATCH 1/4] can: mcp251xfd: stop timestamp before sending chip to
 sleep
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240417-mcp251xfd-gpio-feature-v1-1-bc0c61fd0c80@ew.tq-group.com>
References: <20240417-mcp251xfd-gpio-feature-v1-0-bc0c61fd0c80@ew.tq-group.com>
In-Reply-To: <20240417-mcp251xfd-gpio-feature-v1-0-bc0c61fd0c80@ew.tq-group.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux@ew.tq-group.com, gregor.herburger@ew.tq-group.com, 
 alexander.stein@ew.tq-group.com
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713361443; l=1952;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=G9CV2IDmvN9SvoNGxvVTVF4YluRtXT0j7nf86rqgr0k=;
 b=znK0b9++zpEp5xhl44Em7LfvHSw+afplN48+9nNL/VFdVwLVRLhruHxP2dOV4GUowFkbZoSFI
 yN9mbrW9/AeBpNkjDBXmbsP+9EMZWSgD/0ehRiCiGT8gWF0pkHGATBa
X-Developer-Key: i=gregor.herburger@ew.tq-group.com; a=ed25519;
 pk=+eRxwX7ikXwazcRjlOjj2/tbDmfVZdDLoW+xLZbQ4h4=
X-Last-TLS-Session-Version: TLSv1.3

MCP2518FD exits Low-Power Mode (LPM) when CS is asserted. When chip
is send to sleep and the timestamp workqueue is not stopped chip is
waked by SPI transfer of mcp251xfd_timestamp_read.

So before sending chip to sleep stop timestamp otherwise the
mcp251xfd_timestamp_read callback would wake chip up.

Also there are error paths in mcp251xfd_chip_start where workqueue has
not been initialized but mcp251xfd_chip_stop is called. So check for
initialized func before canceling delayed_work.

Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c      | 1 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 1d9057dc44f2..eb699288c076 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -744,6 +744,7 @@ static void mcp251xfd_chip_stop(struct mcp251xfd_priv *priv,
 
 	mcp251xfd_chip_interrupts_disable(priv);
 	mcp251xfd_chip_rx_int_disable(priv);
+	mcp251xfd_timestamp_stop(priv);
 	mcp251xfd_chip_sleep(priv);
 }
 
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
index 712e09186987..537c31890838 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
@@ -67,5 +67,8 @@ void mcp251xfd_timestamp_init(struct mcp251xfd_priv *priv)
 
 void mcp251xfd_timestamp_stop(struct mcp251xfd_priv *priv)
 {
-	cancel_delayed_work_sync(&priv->timestamp);
+	struct work_struct *work = &priv->timestamp.work;
+
+	if (work->func)
+		cancel_delayed_work_sync(&priv->timestamp);
 }

-- 
2.34.1


