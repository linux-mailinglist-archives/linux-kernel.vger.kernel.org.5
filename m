Return-Path: <linux-kernel+bounces-163991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BA98B76E3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7C71C21EC8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90521176FB8;
	Tue, 30 Apr 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oENGpKbS"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDA0172BD1;
	Tue, 30 Apr 2024 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483238; cv=none; b=uFRUIj/GMnniqc38kKODktYjmWlBKF/kUAt3dR56bBxHaZD4QR7KH7E1mF1z+gIKR1bY4lay8w0b5rqCq+/DU918vxcf9mBU8uQP2ECl/3nQ3XhhHvGYoRwW4e9GMiaWyeQ8Vh3GWfG2YywR8PfX7sNoL7YFFds7WcsqHk0aZtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483238; c=relaxed/simple;
	bh=QZpQRgobpHQl9Ix8vXok8CWGEIDsu/GsRRB0lJ2O/xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XeURUALkUaLN67yiaxg8ES7cnu8wfrhJ2VRva5YRPYUA2qVcsFJcXcmM14ubFXNkLTLyuPJKLbZq4xbneJbW6fXv0nxzBN3mj7koJmoYedKGAuk9cJ4Q5Kbkf2KIPiXhz7A/tk06jyHU5v1p/ZvolpDJsa+F9v2ZZo7sbTVNoSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oENGpKbS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714483235;
	bh=QZpQRgobpHQl9Ix8vXok8CWGEIDsu/GsRRB0lJ2O/xQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oENGpKbSgfqGHVSamLzVNMuPo//MNqVwwyi8QzRy0dgP45z6Wrp5FtKb3fCmQ3RPt
	 qTIdesRXp+yDVYLTQEPtRNvkoIxPDdEaJerX0y07Lhm6AvCXQFkmf3v4h1w31Ab41n
	 aYXNtOejMJHi4T4CwiuXzz0QIRN+U+EYEF3JoQy0/qT2NTRQwdcVoPBzTAgLaHOdAX
	 2p1iKy4wLFoMHzUzrlIXoDurOdwKCDIOK+6xUYsQM42YjWHLL58mqftBtXfUnQbLQx
	 Uh24JeiW2nAWvE7WukXpzT05nXHjUa1AwJCZaiZepw3c3Vz5D4IB8/lLRrRHCzZH/5
	 OKoJcCGB1ib9A==
Received: from apertis.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2A587378212B;
	Tue, 30 Apr 2024 13:20:35 +0000 (UTC)
From: Julien Massot <julien.massot@collabora.com>
To: linux-media@vger.kernel.org,
	sakari.ailus@iki.fi
Cc: devicetree@vger.kernel.org,
	kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	Julien Massot <julien.massot@collabora.com>
Subject: [PATCH v7 5/5] drivers: media: max96717: stop the csi receiver before the source
Date: Tue, 30 Apr 2024 15:19:31 +0200
Message-ID: <20240430131931.166012-6-julien.massot@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430131931.166012-1-julien.massot@collabora.com>
References: <20240430131931.166012-1-julien.massot@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stopping the CSI source before stopping the serializer
CSI port may make the serializer not respond.
Then all the next writes to the device will fail.

max96717 1-0040: Error writing reg 0x0308: -121
max96717 1-0040: Error writing reg 0x0006: -121

Fix that by stopping the CSI receiver first and then CSI source.

Seen on max96717f revision 4.

Signed-off-by: Julien Massot <julien.massot@collabora.com>
---
 drivers/media/i2c/max96717.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/media/i2c/max96717.c b/drivers/media/i2c/max96717.c
index 1ea76f922bdb..499408837aef 100644
--- a/drivers/media/i2c/max96717.c
+++ b/drivers/media/i2c/max96717.c
@@ -384,24 +384,23 @@ static int max96717_disable_streams(struct v4l2_subdev *sd,
 {
 	struct max96717_priv *priv = sd_to_max96717(sd);
 	u64 sink_streams;
-	int ret;
+
+	/*
+	 * Stop the CSI receiver first then the source,
+	 * otherwise the device may become unresponsive
+	 * while holding the I2C bus low.
+	 */
+	priv->enabled_source_streams &= ~streams_mask;
+	if (!priv->enabled_source_streams)
+		max96717_start_csi(priv, false);
 
 	sink_streams = v4l2_subdev_state_xlate_streams(state,
 						       MAX96717_PAD_SOURCE,
 						       MAX96717_PAD_SINK,
 						       &streams_mask);
 
-	ret = v4l2_subdev_disable_streams(priv->source_sd, priv->source_sd_pad,
-					  sink_streams);
-	if (ret)
-		return ret;
-
-	priv->enabled_source_streams &= ~streams_mask;
-
-	if (!priv->enabled_source_streams)
-		max96717_start_csi(priv, false);
-
-	return 0;
+	return v4l2_subdev_disable_streams(priv->source_sd, priv->source_sd_pad,
+					   sink_streams);
 }
 
 static const struct v4l2_subdev_pad_ops max96717_pad_ops = {
-- 
2.44.0


