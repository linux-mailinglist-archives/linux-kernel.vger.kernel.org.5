Return-Path: <linux-kernel+bounces-111509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A490E886D25
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67711C23BD8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BDF612C8;
	Fri, 22 Mar 2024 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="diFskzFT"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A66E604AF
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114025; cv=none; b=oYdF9AjsdK7BfWi10zR2y1ccLgCJdGMI+GbF+Oad34Bq9TSbULC/TpuNw5TKdUIroxBLAp0ywHcWQja9nb+Gvb58trQ6pAczBiDKK2wUk5oEvQhzYCAswlAk98r+P1HMHWhyUOjLe6TbrbNczxgCVHor4mutBeCnBWZV7XNhrUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114025; c=relaxed/simple;
	bh=5o/b35YNWQ+wW36J+YG/JPEDdnYdO9wYpwztsTCGkIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zjj5613gTP4wv/yiyfULBseRkLjOU5zRQmjyjIooQHCod6sjOuH/2VzHsR2SAsEB+PrtOylSIsqZ0CB8ryyok5xzYetn6JlaTHLrYdfis0GMHTR2+35MiqkQj+mbrzx7DsWEW/mo+ehBkgYAuISThBFjkzMWPPm5VvrvFEvpBig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=diFskzFT; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=ZPs4SN1QjrsLyzCteCcuLANMhkdslo1oiN7EMNDt0Gs=; b=diFskz
	FTvbsjRXw5JFZ/q64n52ZW8erhRKO3tmycaKhSLyw3592Ztl4vtnbUO+1OikjsTJ
	Bp66MBdJgfkpjPT5H+fZApgoPEaffvFKWe0WstgrfuLCqFVLEl7cjQNCbkVjHb8o
	zVL4vLWhszWp+o2OumbsXVod/rT94ym5S4z8/Ln3Pr43bsBbaJgEwB3rDE7oDgJH
	2YoK38bqHxS5qL9cG8yTbd6uE/st2Sn6SsvKMFkPR7C13RMZzMKIn5ramtC0smps
	vxC6+vcrGkiVJC1/jFDZD9yyB8W9seO+oNFDGpUBlmRU2IABTG4gky2tBxu3UzXp
	6HiqDWy+sBHI2R1g==
Received: (qmail 3870956 invoked from network); 22 Mar 2024 14:26:46 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Mar 2024 14:26:46 +0100
X-UD-Smtp-Session: l3s3148p1@NSN7xj8U3JRehhtF
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 30/64] i2c: ljca: reword according to newest specification
Date: Fri, 22 Mar 2024 14:25:23 +0100
Message-ID: <20240322132619.6389-31-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322132619.6389-1-wsa+renesas@sang-engineering.com>
References: <20240322132619.6389-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Match the wording of this driver wrt. the newest I2C v7, SMBus 3.2, I3C
specifications and replace "master/slave" with more appropriate terms.
They are also more specific because we distinguish now between a remote
entity ("client") and a local one ("target").

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-ljca.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ljca.c b/drivers/i2c/busses/i2c-ljca.c
index b4927622177c..68aae0632f26 100644
--- a/drivers/i2c/busses/i2c-ljca.c
+++ b/drivers/i2c/busses/i2c-ljca.c
@@ -76,7 +76,7 @@ static int ljca_i2c_init(struct ljca_i2c_dev *ljca_i2c, u8 id)
 	return ret < 0 ? ret : 0;
 }
 
-static int ljca_i2c_start(struct ljca_i2c_dev *ljca_i2c, u8 slave_addr,
+static int ljca_i2c_start(struct ljca_i2c_dev *ljca_i2c, u8 client_addr,
 			  enum ljca_xfer_type type)
 {
 	struct ljca_i2c_rw_packet *w_packet =
@@ -88,7 +88,7 @@ static int ljca_i2c_start(struct ljca_i2c_dev *ljca_i2c, u8 slave_addr,
 
 	w_packet->id = ljca_i2c->i2c_info->id;
 	w_packet->len = cpu_to_le16(sizeof(*w_packet->data));
-	w_packet->data[0] = (slave_addr << 1) | type;
+	w_packet->data[0] = (client_addr << 1) | type;
 
 	ret = ljca_transfer(ljca_i2c->ljca, LJCA_I2C_START, (u8 *)w_packet,
 			    struct_size(w_packet, data, 1), (u8 *)r_packet,
@@ -107,7 +107,7 @@ static int ljca_i2c_start(struct ljca_i2c_dev *ljca_i2c, u8 slave_addr,
 	return 0;
 }
 
-static void ljca_i2c_stop(struct ljca_i2c_dev *ljca_i2c, u8 slave_addr)
+static void ljca_i2c_stop(struct ljca_i2c_dev *ljca_i2c, u8 client_addr)
 {
 	struct ljca_i2c_rw_packet *w_packet =
 			(struct ljca_i2c_rw_packet *)ljca_i2c->obuf;
@@ -169,16 +169,16 @@ static int ljca_i2c_pure_read(struct ljca_i2c_dev *ljca_i2c, u8 *data, u8 len)
 	return 0;
 }
 
-static int ljca_i2c_read(struct ljca_i2c_dev *ljca_i2c, u8 slave_addr, u8 *data,
+static int ljca_i2c_read(struct ljca_i2c_dev *ljca_i2c, u8 client_addr, u8 *data,
 			 u8 len)
 {
 	int ret;
 
-	ret = ljca_i2c_start(ljca_i2c, slave_addr, LJCA_I2C_READ_XFER_TYPE);
+	ret = ljca_i2c_start(ljca_i2c, client_addr, LJCA_I2C_READ_XFER_TYPE);
 	if (!ret)
 		ret = ljca_i2c_pure_read(ljca_i2c, data, len);
 
-	ljca_i2c_stop(ljca_i2c, slave_addr);
+	ljca_i2c_stop(ljca_i2c, client_addr);
 
 	return ret;
 }
@@ -213,16 +213,16 @@ static int ljca_i2c_pure_write(struct ljca_i2c_dev *ljca_i2c, u8 *data, u8 len)
 	return 0;
 }
 
-static int ljca_i2c_write(struct ljca_i2c_dev *ljca_i2c, u8 slave_addr,
+static int ljca_i2c_write(struct ljca_i2c_dev *ljca_i2c, u8 client_addr,
 			  u8 *data, u8 len)
 {
 	int ret;
 
-	ret = ljca_i2c_start(ljca_i2c, slave_addr, LJCA_I2C_WRITE_XFER_TYPE);
+	ret = ljca_i2c_start(ljca_i2c, client_addr, LJCA_I2C_WRITE_XFER_TYPE);
 	if (!ret)
 		ret = ljca_i2c_pure_write(ljca_i2c, data, len);
 
-	ljca_i2c_stop(ljca_i2c, slave_addr);
+	ljca_i2c_stop(ljca_i2c, client_addr);
 
 	return ret;
 }
@@ -266,7 +266,7 @@ static const struct i2c_adapter_quirks ljca_i2c_quirks = {
 };
 
 static const struct i2c_algorithm ljca_i2c_algo = {
-	.master_xfer = ljca_i2c_xfer,
+	.xfer = ljca_i2c_xfer,
 	.functionality = ljca_i2c_func,
 };
 
-- 
2.43.0


