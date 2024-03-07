Return-Path: <linux-kernel+bounces-95164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04464874A21
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326311C2313C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08BB82D7A;
	Thu,  7 Mar 2024 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="rMyCNR0z"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1BB1A29A;
	Thu,  7 Mar 2024 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709801629; cv=none; b=KAfWoEzzes8lcVkhShTNGtWQZvBhyVXxB4Y4BjHYnQBSysdIv1vFjZBgg1sh/Vx3PrUamOu3yC1jk7bX6mdpIdQhqPYr98iePf2y/VP550D5qlk7xuk7oAa0gT6AhNXz3Ow0h/wKmFxEi5kz4xU1NiuwQeuRxG+ThRac2ZLuNKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709801629; c=relaxed/simple;
	bh=apfVStlB67TMYQsd9dI7ItflrhUjMPLZgwzzdIWFtL0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JeQC9y7NwTGi93dj53b00McRUMHXNAj1DMjGYNm78kv8ngDN38HnuD2GVUaM71UXm2MOEHbvsb1cjV5WdnG9JbaEWaIissl5AiRlvhaQEKtq9Z5SJGfHE8Tc3wXUJQuEJwrcgWOW0NZ+7J9qm73Kcop+S5u3JYK/mJ283rZpdfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=rMyCNR0z; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 36461100003;
	Thu,  7 Mar 2024 11:53:26 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1709801606; bh=IYuDKE6wcngSlBLZHMJobm5rVJjSjgr3vxQlOD53g1c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=rMyCNR0zFhyLlOc2MRl+YKdk76rC3tIWU7SmtOaCalG+XTYZw/8E5Y4bzYfcd8WlG
	 OUvmt2zp7eW1m7MFCjrx5F5enQo4rgjRUFmOobF+4jIiyUx9DcWDaLeJX11EFZ82rY
	 5QBR+mPzNK5EbxL4jIaAOC+Ms8dDSJzs2KFMcfYjytLm8ySjeT62Sw53ypmwQy4VsG
	 KtxFpJAFHha6QTsp7YjJb6OI7btwFvsaihxwappOwcDH0bDHgajQoRhMlXR/7SUirP
	 e8qOCOHEtPGj2eN8b27A+rVgYo6UQU2HU2LkXTer6jFOwgQEcIapgGZjWA2rSS4e/K
	 XfPUchdodPZTQ==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Thu,  7 Mar 2024 11:52:45 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Mar 2024
 11:51:53 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Ulf Hansson
	<ulf.hansson@linaro.org>, Wen Zhiwei <wenzhiwei@kylinos.cn>,
	<linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] mmc: dw_mmc: Fix potential null pointer risk
Date: Thu, 7 Mar 2024 11:51:35 +0300
Message-ID: <20240307085135.16245-1-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 184022 [Mar 07 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 9 0.3.9 e923e63e431b6489f12901471775b2d1b59df0ba, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1;t-argos.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/07 07:53:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/03/07 06:26:00 #24026065
X-KSMG-AntiVirus-Status: Clean, skipped

In dw_mci_runtime_resume() 'host->slot' could be null, but check is not cover all corresponding code.
Fix this bug by changing check place.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 4a835afd808a (mmc: dw_mmc: Fix potential null pointer risk)
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/mmc/host/dw_mmc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 829af2c98a44..a4f124452abc 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3570,8 +3570,10 @@ int dw_mci_runtime_resume(struct device *dev)
 		   DW_MCI_ERROR_FLAGS);
 	mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
 
+	if (!host->slot)
+		goto err;
 
-	if (host->slot && host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
+	if (host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
 		dw_mci_set_ios(host->slot->mmc, &host->slot->mmc->ios);
 
 	/* Force setup bus to guarantee available clock output */
-- 
2.30.2


