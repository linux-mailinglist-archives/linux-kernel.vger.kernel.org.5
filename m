Return-Path: <linux-kernel+bounces-140360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3C38A1356
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E54C1C216DA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D10914C594;
	Thu, 11 Apr 2024 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="gWL6scdx"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F01148855;
	Thu, 11 Apr 2024 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835792; cv=none; b=WwIXGeUFyBIp24bE0vXbguu+f3uw11NKMh6CxB/5q+4dZYyUcLK71Lz8/Yro4XyyzxUkQhTWxjXxchckdiRhsH79AHkWHoFQ8Ug6IfazTwnKBc5Ux1cmZvSwMGQX5xBSuTy2WimtwchPOtsKpVOshTRhfUc4wsYAg/wnXSAmO5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835792; c=relaxed/simple;
	bh=xKamhCIS2K0T5f1TpPU8dNW0kHtYfzXYFU/r8H0Iar0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JkrvN0fy2qCuyvo/f8C24ryE8a/Z+U/JGzwD2RI+xFH6l/127h1KDTu+/PvQEk5TQPaIwK/pY7iBWbatrmGOojrKVGXoa4yctwHUhWRzwe9UMQoiC2wm0cb6SaYtHbnXdIWA7vjxj0VbLX3Q2mWGIOmZct598Pu3SHC5fu6B4M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=gWL6scdx; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id C9553100002;
	Thu, 11 Apr 2024 14:42:49 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1712835769; bh=NSUtamrtwLzdrUGzn+cpttYD732xrJfvqCh/kdjnOlM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=gWL6scdxrVzQdFBdqKQ83v9nAsdZMpgHImivkC/tt3o3VfIOWZTgY5XUGhOsyVII9
	 T6kgfteePjnm/hsmW2prJ8gPZ05/4cRe2et+JH0J+LeooEeuwGrb9suwnm/LXvhgi7
	 WAqlviIpLrKuqX0ICDwsCSGHbjgAEWRHovCU/QMd9ulK4zRmOKbt4kDEHRwvfdwl9s
	 dig3K6A27R5jLVhwihkZl0NQbj2uv4YnILyljjM6gV0jW9iws4BQTPBbd5rQGup7qa
	 yH4mzuojSIZduFL7vwry89o9p8atViuCyHujIsP5iYTbLDdCQwkWiFMftLid0Co+gH
	 +4MBY0/5sIJ0Q==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Thu, 11 Apr 2024 14:40:49 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Apr
 2024 14:40:29 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Christian Marangi <ansuelsmth@gmail.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>, Bjorn Andersson
	<andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	<linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH v2] drivers: thermal: tsens: Fix null pointer dereference
Date: Thu, 11 Apr 2024 14:40:21 +0300
Message-ID: <20240411114021.12203-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184672 [Apr 11 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 16 0.3.16 6e64c33514fcbd07e515710c86ba61de7f56194e, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;t-argos.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/11 07:47:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/04/11 10:13:00 #24743273
X-KSMG-AntiVirus-Status: Clean, skipped

compute_intercept_slope() is called from calibrate_8960() (in tsens-8960.c)
as compute_intercept_slope(priv, p1, NULL, ONE_PT_CALIB) which lead to null
pointer dereference (if DEBUG or DYNAMIC_DEBUG set).
Fix this bug by adding null pointer check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: dfc1193d4dbd ("thermal/drivers/tsens: Replace custom 8960 apis with generic apis")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
v2: Simplified fix

 drivers/thermal/qcom/tsens.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 6d7c16ccb44d..4edee8d929a7 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -264,7 +264,7 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 	for (i = 0; i < priv->num_sensors; i++) {
 		dev_dbg(priv->dev,
 			"%s: sensor%d - data_point1:%#x data_point2:%#x\n",
-			__func__, i, p1[i], p2[i]);
+			__func__, i, p1[i], p2 ? p2[i] : 0);
 
 		if (!priv->sensor[i].slope)
 			priv->sensor[i].slope = SLOPE_DEFAULT;
-- 
2.30.2


