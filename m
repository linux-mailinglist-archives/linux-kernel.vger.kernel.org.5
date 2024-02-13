Return-Path: <linux-kernel+bounces-64411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A286853E08
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673771C21FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EF262807;
	Tue, 13 Feb 2024 22:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="lYIG+yiq"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3078626DF
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861784; cv=none; b=ZUbbS8qRZAl4IL+owfUpqKHj78U7KXYKR/bJfcNmmRff8JtIjseEqKiyQOwliu4nviokdIdyYir505VzVCLZHoGeiChA2Be9YmdfhS7ZDTdI5BMt0dUfeJNuExJQr5xxkqXGSeWRYan3z6JB7rGkoI49NeykguslrxCPBsWovag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861784; c=relaxed/simple;
	bh=s46cqh5WXM0+I/dyk3J0iZj7PDngod2/SdoD02i9s4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iD2D1McpXPS4L9lesZ3buu/iJ2mvWbJgvW+VJkmVobh967XrzWUStRA5IIqG35vkBt2l3vcGZ6MlapMX9AFJBRVs/UiiYbDRN++kEgqAuFrCM9+8TxCh3oTOdpB/8PfGQRZ1bHWrKJlCmVz10H2l/IGYHAq8BDANqu63vlf1Dy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=lYIG+yiq; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=3iz4DCLUOGZx4OfgLPz/FN/m99Q5bIPUkOtswq6lKVY=; b=lYIG+y
	iqbN1lyV1utz9rereyEYAd59LbFW5OzbV3JEFK7Dd1MC72lMz3wsYntlJcX/T0J9
	/i9rvsZyitRLDq4RSqp9jOwTNmd3zdjBJpPzdd+39jK7ZYiT/B7+CH+g+KV22Dyg
	WZqZ29LPlEySsfSIe+2JhT2eWiYN2fNd5zORlNaRwU1Md1Grv6gELo6I4dH7+YSA
	HbyBK/cKZC/XHnUAcfWveZdLfDimgO2opfMlvvZcO+HFHG+wSo8H3v/2P2k3nyRx
	jlddt/Uo0xhJyIpuDJFytV+iyBCqsfrmbBC5E2/mk/ZXNMOLLrKjeM3owX59cdE2
	0gob7Hj/RPNleoqg==
Received: (qmail 1211754 invoked from network); 13 Feb 2024 23:02:51 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Feb 2024 23:02:51 +0100
X-UD-Smtp-Session: l3s3148p1@T/g0jkoRwN8ujnsZ
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] mfd: tmio: Remove obsolete platform_data
Date: Tue, 13 Feb 2024 23:02:20 +0100
Message-ID: <20240213220221.2380-9-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213220221.2380-8-wsa+renesas@sang-engineering.com>
References: <20240213220221.2380-8-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 8971bb812e3c ("mfd: remove toshiba tmio drivers"), all users
of platform data for NAND and framebuffers are gone. So, remove
definitions from the header, too.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Lee Jones <lee@kernel.org>
---
 include/linux/mfd/tmio.h | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index eace8ea6cda0..bc53323293a3 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -103,31 +103,4 @@ struct tmio_mmc_data {
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
 };
-
-/*
- * data for the NAND controller
- */
-struct tmio_nand_data {
-	struct nand_bbt_descr	*badblock_pattern;
-	struct mtd_partition	*partition;
-	unsigned int		num_partitions;
-	const char *const	*part_parsers;
-};
-
-#define FBIO_TMIO_ACC_WRITE	0x7C639300
-#define FBIO_TMIO_ACC_SYNC	0x7C639301
-
-struct tmio_fb_data {
-	int			(*lcd_set_power)(struct platform_device *fb_dev,
-						 bool on);
-	int			(*lcd_mode)(struct platform_device *fb_dev,
-					    const struct fb_videomode *mode);
-	int			num_modes;
-	struct fb_videomode	*modes;
-
-	/* in mm: size of screen */
-	int			height;
-	int			width;
-};
-
 #endif
-- 
2.43.0


