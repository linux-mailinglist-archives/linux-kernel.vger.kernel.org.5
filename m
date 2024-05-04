Return-Path: <linux-kernel+bounces-168497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E05298BB944
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 04:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D69F1C22FBC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C8818046;
	Sat,  4 May 2024 02:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b="D0MX2+BA"
Received: from mail.kaechele.ca (mail.kaechele.ca [54.39.219.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D52B8F6D;
	Sat,  4 May 2024 02:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.39.219.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714788924; cv=none; b=ft9qNMbFJqh2pcODVrsH8f91gSshPsrHt2eWWi5dc64zrbq1j/e3dESqbKLQhYTLfeCrU4N/uZo/mzNREiHFhHLjxwxNHeATNZKY0vjZ+Qq7O8zxAhd4APBGjseKeL5ALF2+jkvrLgb7QDoCaV2H/6jHnCkhxnAOm6otBfmFBg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714788924; c=relaxed/simple;
	bh=ImJjYhwLeq6DoD7y9lot08dHBzE0SDmStx3VVB4Rp4Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5Bqv+ih9yZctcHLtKfTFs4a6nQRN0jYVpqDGyHV2sbFd1gQJIrH4IslGsot2RJwzixd8YRZ0t6aB4iZqbaf3+Kaqzj/s2WCtCN+8ejFRx0EfqA9cBMuq9B2OY1YP9zQZZAN9ThdaSL1Ri2ItDjceGzBg59r1GEKngf2IfCbnaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca; spf=pass smtp.mailfrom=kaechele.ca; dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b=D0MX2+BA; arc=none smtp.client-ip=54.39.219.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaechele.ca
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1C3D3C0070;
	Fri,  3 May 2024 22:08:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaechele.ca; s=201907;
	t=1714788490; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=BG74+zku+YYoWtxycM9DdqK7wU1Re6w/HHT7DHU603Q=;
	b=D0MX2+BAKHFoo0B8BrQ2GjO7p68ACYlPPe8f74HerI+O5NWglTb3plAsHV+qAah0NdKcul
	7otF5Gl/5jGlUx4kQ1NqNqoUGi0kpwUDNOAeDgHW38wcaejaq0F5L2p/TcnGWuzzrpbzxG
	F8lhv2GnkmpxhHEg2azL7xXcagW10Uw=
From: Felix Kaechele <felix@kaechele.ca>
To: Job Noorman <job@noorman.info>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] input: himax_hx83112b: use more descriptive register defines
Date: Fri,  3 May 2024 22:04:42 -0400
Message-ID: <20240504020745.68525-4-felix@kaechele.ca>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504020745.68525-1-felix@kaechele.ca>
References: <20240504020745.68525-1-felix@kaechele.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Himax uses an AHB-style bus to communicate with different parts of the
display driver and touch controller system.
Use more descriptive names for the register and address defines.
The names were taken from a driver submission for the similar HX83102J
chip.

Signed-off-by: Felix Kaechele <felix@kaechele.ca>
Link: https://lore.kernel.org/all/TY0PR06MB561105A3386E9D76F429110D9E0F2@TY0PR06MB5611.apcprd06.prod.outlook.com/
---
 drivers/input/touchscreen/himax_hx83112b.c | 23 ++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/himax_hx83112b.c b/drivers/input/touchscreen/himax_hx83112b.c
index 0a797789e548..ba5442cc0a24 100644
--- a/drivers/input/touchscreen/himax_hx83112b.c
+++ b/drivers/input/touchscreen/himax_hx83112b.c
@@ -26,12 +26,14 @@
 #define HIMAX_MAX_POINTS		10
 #define HIMAX_MAX_SUPPLIES		2
 
-#define HIMAX_REG_CFG_SET_ADDR		0x00
-#define HIMAX_REG_CFG_INIT_READ		0x0c
-#define HIMAX_REG_CFG_READ_VALUE	0x08
-#define HIMAX_REG_READ_EVENT		0x30
+#define HIMAX_AHB_ADDR_BYTE_0			0x00
+#define HIMAX_AHB_ADDR_RDATA_BYTE_0		0x08
+#define HIMAX_AHB_ADDR_ACCESS_DIRECTION		0x0c
+#define HIMAX_AHB_ADDR_EVENT_STACK		0x30
 
-#define HIMAX_CFG_PRODUCT_ID		0x900000d0
+#define HIMAX_AHB_CMD_ACCESS_DIRECTION_READ	0x00
+
+#define HIMAX_REG_ADDR_ICID			0x900000d0
 
 #define HIMAX_INVALID_COORD		0xffff
 
@@ -75,15 +77,16 @@ static int himax_read_config(struct himax_ts_data *ts, u32 address, u32 *dst)
 {
 	int error;
 
-	error = regmap_write(ts->regmap, HIMAX_REG_CFG_SET_ADDR, address);
+	error = regmap_write(ts->regmap, HIMAX_AHB_ADDR_BYTE_0, address);
 	if (error)
 		return error;
 
-	error = regmap_write(ts->regmap, HIMAX_REG_CFG_INIT_READ, 0x0);
+	error = regmap_write(ts->regmap, HIMAX_AHB_ADDR_ACCESS_DIRECTION,
+					 HIMAX_AHB_CMD_ACCESS_DIRECTION_READ);
 	if (error)
 		return error;
 
-	error = regmap_read(ts->regmap, HIMAX_REG_CFG_READ_VALUE, dst);
+	error = regmap_read(ts->regmap, HIMAX_AHB_ADDR_RDATA_BYTE_0, dst);
 	if (error)
 		return error;
 
@@ -109,7 +112,7 @@ static int himax_read_product_id(struct himax_ts_data *ts, u32 *product_id)
 {
 	int error;
 
-	error = himax_read_config(ts, HIMAX_CFG_PRODUCT_ID, product_id);
+	error = himax_read_config(ts, HIMAX_REG_ADDR_ICID, product_id);
 	if (error)
 		return error;
 
@@ -243,7 +246,7 @@ static int himax_handle_input(struct himax_ts_data *ts)
 	int error;
 	struct himax_event event;
 
-	error = regmap_raw_read(ts->regmap, HIMAX_REG_READ_EVENT, &event,
+	error = regmap_raw_read(ts->regmap, HIMAX_AHB_ADDR_EVENT_STACK, &event,
 				sizeof(event));
 	if (error) {
 		dev_err(&ts->client->dev, "Failed to read input event: %d\n",
-- 
2.44.0


