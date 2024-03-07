Return-Path: <linux-kernel+bounces-95102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D383874939
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA67B1F2215F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9D66313B;
	Thu,  7 Mar 2024 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="EFqBmGUl"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036B563126;
	Thu,  7 Mar 2024 08:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709798816; cv=none; b=mu/E5YiRbby5lxVhNoPxFzezTlqESIBml0daQpDI70HwDZX0xM5XW5Tz1QLwmqleA/eXimQGYssckt4IW7ia24bP+ACd44i3A6DakSGGBJYsOOeIjMEY8O0xUt34U399j4KWG1IAphqS1dwWEtlXp8bRhpGPPwvpEpA+BwQc1ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709798816; c=relaxed/simple;
	bh=HmxSxu3e+YBIQn4IRhQm21ZwDOa4fcx36CXpkhLBFqU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ec1mzkNyBKJrEoKkcGPrk/45/oSBjapLDun66cSiGez2nR/ZMVyoe5t7d9OJ78n9PHw8pCqAlYum0QgPtGYjWULTvNxcyKnWMHlLn0G2W+nl7qameDMRsdOWvpWIaNUAD9CObCCEmi7WoScYOsWrDEw2SnWcXAYAQmWOinl5fw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=EFqBmGUl; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 84F44100002;
	Thu,  7 Mar 2024 11:06:30 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1709798790; bh=aUbJGmH1J/w83lr18xfMtIo/u0AqnmbG6WscZrXzHMw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=EFqBmGUlS4eWXOhHWubd6nr1fPqd6ikC43Q8PYy8w7eSFJL56CQLx7uKsphDkE4aD
	 eMmCiZyp6SGBhGJpjs6cBMf3fPcHklgjYRxC6lobxzwL1VUmmPAThzEjguQTK/Lz2V
	 u5GDFZkxfSdtbqK6sMFAzZpaOzG6t+dFHiHf9xigdt2MhooXL9wtR1CsNm446CCCnB
	 3Dre8hIEA9fgHSrBkEr+HFg0cW6YMSDKV1NP41J4J0L6XBXFeDJhSTQJKcJS1ha73k
	 GzjzkTjwagOGYaAFu2JlLlEc2OBsGS99Sc5lQ4/hDkY5ZA0zGMLq6CbQzCNFKaSNMh
	 eO8OWG9R/9x8w==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Thu,  7 Mar 2024 11:05:24 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Mar 2024
 11:05:03 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Madalin Bucur <madalin.bucur@nxp.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Sean Anderson
	<sean.anderson@seco.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Igal Liberman <igal.liberman@freescale.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] fsl/fman: Add array size check
Date: Thu, 7 Mar 2024 11:04:52 +0300
Message-ID: <20240307080452.13278-1-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 184020 [Mar 07 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 9 0.3.9 e923e63e431b6489f12901471775b2d1b59df0ba, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;t-argos.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/07 07:53:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/03/07 06:26:00 #24026065
X-KSMG-AntiVirus-Status: Clean, skipped

In fman_register_intr() and fman_unregister_intr()
get_module_event() is assigned to event which is then used
as array index without size check.
Fix this bug by adding a check of event.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 414fd46e7762 (fsl/fman: Add FMan support)
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/net/ethernet/freescale/fman/fman.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index d96028f01770..902d05ffff1b 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -2054,7 +2054,10 @@ void fman_register_intr(struct fman *fman, enum fman_event_modules module,
 	int event = 0;
 
 	event = get_module_event(module, mod_id, intr_type);
-	WARN_ON(event >= FMAN_EV_CNT);
+	if (event >= FMAN_EV_CNT) {
+		WARN_ON(event >= FMAN_EV_CNT);
+		return;
+	}
 
 	/* register in local FM structure */
 	fman->intr_mng[event].isr_cb = isr_cb;
@@ -2079,7 +2082,10 @@ void fman_unregister_intr(struct fman *fman, enum fman_event_modules module,
 	int event = 0;
 
 	event = get_module_event(module, mod_id, intr_type);
-	WARN_ON(event >= FMAN_EV_CNT);
+	if (event >= FMAN_EV_CNT) {
+		WARN_ON(event >= FMAN_EV_CNT);
+		return;
+	}
 
 	fman->intr_mng[event].isr_cb = NULL;
 	fman->intr_mng[event].src_handle = NULL;
-- 
2.30.2


