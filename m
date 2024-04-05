Return-Path: <linux-kernel+bounces-132703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C1C899905
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA261B222B5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76F615FCEE;
	Fri,  5 Apr 2024 09:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="UZOrdnA+"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7958C15FA95;
	Fri,  5 Apr 2024 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308218; cv=none; b=cqJweNwxCH5IXQuJwVVOQTy4dAjcg0SZhuShK1KOuja8lePKv3liCsJhO5sdMRUjQo0LGmdGHA3EYl/VlMBOQrWmCn9YKq4tUSPyapJmDe1qnu35/1uTlZV3J6s0dJDgm+3iDFeOnXn7HFsbJBuXWroRRS/7Bjk++0yW7pS3bk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308218; c=relaxed/simple;
	bh=6zgWN/Gm2MnsvJelWP4xZxfUiEvn8aa8s91l1UYyo+k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OKHNgdR68pQMoBMRud1k7RoGuYUQ4QXlqfdMb0iWkdL7Wd9Lbns4Q/W472tWd1+CAFk2X0piECLfWUJ4ILnlmEONvCIaTPwzWrf9N+hEseteLvWrXQqI8xW7kdf/shf82ETRXAkN9Wqo98Beg6grRkpx0gz9GsYTqC9kxDp0NOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=UZOrdnA+; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 19A01100002;
	Fri,  5 Apr 2024 12:09:48 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1712308188; bh=VeRoNF/EWKHuynHlmfs5d4fsjEQAUTE/mmqlapIGuaQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=UZOrdnA+lc/svGM+U6EefY3kFyXEWa31+mAu3vpxm3h+mpw3sutFU9OF3ifrKCIlB
	 bxNNKunHV71q45tKYaL329KXMXwpLmyEGfENz5y34Gvi7KMklaDq9TX7rL8SDgpm1O
	 lF/YvNb6kQGWIMZbXyia2rEWUn6SiNhP/gQLna+gcaHsyv5ZQovIFszGRM2xbr3PnH
	 G/4H1zDv98/Hal3tgsqIrVUBoPKDGpDeGPJjAt8HMzllILIGoc8SgZfdEavqUV96FT
	 1shD1wxrc1mJ0h1o5Cv4cl2Bdm9XnHOYPP9/w8VjNZmepPCZuf9n+y4ms4N/j3iGF3
	 Qsqzq+ZrDv39A==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Fri,  5 Apr 2024 12:07:47 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 5 Apr 2024
 12:07:27 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Christian Marangi <ansuelsmth@gmail.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>, Bjorn Andersson
	<andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	<linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] drivers: thermal: tsens: Fix null pointer dereference
Date: Fri, 5 Apr 2024 12:07:20 +0300
Message-ID: <20240405090720.16419-1-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 184598 [Apr 05 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 15 0.3.15 adb41f89e2951eb37b279104a7abb8e79494a5e7, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;t-argos.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/05 06:54:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/04/05 07:02:00 #24662400
X-KSMG-AntiVirus-Status: Clean, skipped

compute_intercept_slope() is called from calibrate_8960() (in tsens-8960.c)
as compute_intercept_slope(priv, p1, NULL, ONE_PT_CALIB) which lead to null
pointer dereference (if DEBUG or DYNAMIC_DEBUG set).
Fix this bug by adding null pointer check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: dfc1193d4dbd ("thermal/drivers/tsens: Replace custom 8960 apis with generic apis")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/thermal/qcom/tsens.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 6d7c16ccb44d..f7dd70e8d158 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -262,9 +262,10 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 	int num, den;
 
 	for (i = 0; i < priv->num_sensors; i++) {
-		dev_dbg(priv->dev,
-			"%s: sensor%d - data_point1:%#x data_point2:%#x\n",
-			__func__, i, p1[i], p2[i]);
+		if (p1 && p2)
+			dev_dbg(priv->dev,
+				"%s: sensor%d - data_point1:%#x data_point2:%#x\n",
+				__func__, i, p1[i], p2[i]);
 
 		if (!priv->sensor[i].slope)
 			priv->sensor[i].slope = SLOPE_DEFAULT;
-- 
2.30.2


