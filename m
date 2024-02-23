Return-Path: <linux-kernel+bounces-78381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0905F8612BC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE4F1F25093
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D06882D77;
	Fri, 23 Feb 2024 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbXiv5If"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A9A7F48D;
	Fri, 23 Feb 2024 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694909; cv=none; b=brW75pxGXDF207Q8AEPX7mi+PFbwBhXPh33XYUwDEqT8bVHjA3AZQkf+Vx/Fo+icGE8uQ2q6gpbbV2dZv/z8lfmu0iBisF2kW963GuK13f4CzviUKybRVC42wt4FTbAMZz5LIOqwtgUdZrP+uwKHEv5EopaJEQEVsFhmcJb4mbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694909; c=relaxed/simple;
	bh=OcmgXpcRM8kSwibnYWY2jGXTBaTcyrBdkKpBfGjwCpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mlEKqgti3EwQnyMXRc6OTM54JTUslQtAyoxBUEh8MqQe9kSFIz2mtuV2S6lpv1Wt4pDY/PPHdH5/vqoSP1FINKlMBe3/OzyZeMEJiwZNDkbYQ0ShhuGJXPFB6caRqikG/2hq7qssuOLbN5KR31Xo4aV+kQ2ICk/ERVxUNmWHxcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbXiv5If; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8DB3C3277A;
	Fri, 23 Feb 2024 13:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708694908;
	bh=OcmgXpcRM8kSwibnYWY2jGXTBaTcyrBdkKpBfGjwCpA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DbXiv5IflUQwSulHSPUIsrLM6b5xxJTprJWdi+BS3lCzOZZQnOkp/sG7fDeis9liv
	 HbVpVl9l6eyYuGrKkkLM5vJCz7Too9nzAiTuiyfv2KGEj6ZR0GV/Kpbdfo3aDb1wYw
	 L0WDOu7+2cpe6DAMUN9Kk0zuM0qjb64OlHf0TbTNXN3aI87/XWTQ87NuyZtpo4GBjj
	 mhf4DvcYUsqsPuYLJsSxjjS4o8u8r5mzNADE9qOkK67FwSbo90Jcfu21r6+i/45Vtc
	 KXM2Bab4tzvBL3y46Y9+Nkay91klgfeW+RlkjhJiN9KtNqeu/Hu2DRDphlCwMBD4oG
	 UxKIpkI5s7+TA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B41C54798;
	Fri, 23 Feb 2024 13:28:28 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 23 Feb 2024 21:28:22 +0800
Subject: [PATCH net-next v5 7/7] net: hisi_femac: remove unused compatible
 strings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-net-v5-7-43b22d39c013@outlook.com>
References: <20240223-net-v5-0-43b22d39c013@outlook.com>
In-Reply-To: <20240223-net-v5-0-43b22d39c013@outlook.com>
To: Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708694896; l=1155;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=sYmI7rY8FFj5xi4CE0Px8R4wNFWcF8TjujWAa/SwbJA=;
 b=y5AFthUDMAKc4WCobsL6nAa0m+n8a/ePnE5/DJblwDSUz4juexa2ujqNi+54+2fmxtaOl8KyF
 7CGgey2Rt/FDIhmZB+d//6McD0Ts6Bkjyw6lP6d5dCOBSgArlbZ58v+
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

The only documented SoC Hi3516DV300 does not receive any updates from 8
years ago. With the recent driver changes, it unlikely works for this
SoC anymore. Remove the binding for this SoC.

Also it's hard to get the version number and it's unknown how the
version can be used. Remove them until it's really needed.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/net/ethernet/hisilicon/hisi_femac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
index eab91e011d11..9466ca9da2bb 100644
--- a/drivers/net/ethernet/hisilicon/hisi_femac.c
+++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
@@ -990,9 +990,7 @@ static int hisi_femac_drv_resume(struct platform_device *pdev)
 #endif
 
 static const struct of_device_id hisi_femac_match[] = {
-	{.compatible = "hisilicon,hisi-femac-v1",},
-	{.compatible = "hisilicon,hisi-femac-v2",},
-	{.compatible = "hisilicon,hi3516cv300-femac",},
+	{.compatible = "hisilicon,hisi-femac",},
 	{.compatible = "hisilicon,hi3798mv200-femac",},
 	{},
 };

-- 
2.43.0


