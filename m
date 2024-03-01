Return-Path: <linux-kernel+bounces-87870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678E586DA2C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77E431C20D68
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A1850A7E;
	Fri,  1 Mar 2024 03:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V77qGRZk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E6D47F6A;
	Fri,  1 Mar 2024 03:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709264161; cv=none; b=VYX1bqkGVzpATnoE4ybUkEPd50j1Op6Y7EhssS2/llGZBrbdoFcs1TdZpGPDZfw8Xaiv1MM4HCkVsisz/a3Kl2y1YNKs4DKnJ36aqqCxgJgl4ZnCaMuOY82y5h7ygRUDlF9XEbUxUnrnvRvL0Q48VvyO0Y1Q4PcpdZfkOusP2S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709264161; c=relaxed/simple;
	bh=vu47BKfN+xFcRDfbkn3C1v8zrm2ugq1RBZELrpt63GU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aCfiKPDD26FWBOLBRksuNDGnn6o+sCFkF3IQmnMOlBRDPQZtfINVavzkMNzhX+05rMcgPAxnbzerxmzUKBZoChY0ZO8i6sYgQVlXNIy4ZymH2uV3D5Y7OXW+6X8mHgcw/qJeEWnz5mkDyLJglgN/J2+q3qdNuEIRI9CKSwQ1ICk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V77qGRZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 940DFC43394;
	Fri,  1 Mar 2024 03:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709264160;
	bh=vu47BKfN+xFcRDfbkn3C1v8zrm2ugq1RBZELrpt63GU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=V77qGRZkUCAYZ57ZfUfHvfxdL042Ik+bNjoDDxWIjAoBI6/ury/mSSMEiQ5rcS9BL
	 Y1JuBPd5MJzAbGVMWk5i7rdOlTARpsMz30VakD9Uzj7V2r8vD3Mm+qYcYIAzSwzjUu
	 soPEP27qqJ7mj7alle/EKP1f3vBwUG+jr+HGjjP7uMUfGxQ3Q+PUvuXllgd3aeCBV2
	 Li15Ikb4SXC96WQrkPrZJEQ+umWuQqJqs1/1xwBy+7yuQXMGjDwCHHneh0zMdRFV2Z
	 KfWf0K2u7Nuyul+BkZtBPr0aTJyjUd8NWuZ2tn26gG9FuOirsEcD/10jARY3urOpX3
	 SUdsKqsIP8KGg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7521DC54E4A;
	Fri,  1 Mar 2024 03:36:00 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 01 Mar 2024 11:35:56 +0800
Subject: [PATCH net-next v7 3/9] net: mdio: hisi-femac: remove clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-net-v7-3-45823597d4d4@outlook.com>
References: <20240301-net-v7-0-45823597d4d4@outlook.com>
In-Reply-To: <20240301-net-v7-0-45823597d4d4@outlook.com>
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
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709264157; l=1802;
 i=forbidden405@outlook.com; s=20240228; h=from:subject:message-id;
 bh=kdWAr70dNlF5sryokQxZlrJGOk8Z9nw7ekwi0I/9miA=;
 b=vMZl7y/xYRIMdfj+JX/WeX49XurYKNszz1Pyqh4ASk24iWH5NK2Ndl/uItW2Iniw7llrySsEG
 eQjQviplIwyCDNIq3FPHa+IiETizuyC2dJr2y4RDRppcW7/FKQC7pda
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=KAWv6ZzFsT54MGllOczJgFiWB+DuayEmyn24iiVVThU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20240228 with auth_id=136
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

This integrated MDIO bus does not have a dedicated clock, remove it.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/net/mdio/mdio-hisi-femac.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/net/mdio/mdio-hisi-femac.c b/drivers/net/mdio/mdio-hisi-femac.c
index 6703f626ee83..faf4688eb1ab 100644
--- a/drivers/net/mdio/mdio-hisi-femac.c
+++ b/drivers/net/mdio/mdio-hisi-femac.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2016 HiSilicon Technologies Co., Ltd.
  */
 
-#include <linux/clk.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -21,7 +20,6 @@
 #define BIT_WR_DATA_OFFSET	16
 
 struct hisi_femac_mdio_data {
-	struct clk *clk;
 	void __iomem *membase;
 };
 
@@ -93,26 +91,14 @@ static int hisi_femac_mdio_probe(struct platform_device *pdev)
 		goto err_out_free_mdiobus;
 	}
 
-	data->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(data->clk)) {
-		ret = PTR_ERR(data->clk);
-		goto err_out_free_mdiobus;
-	}
-
-	ret = clk_prepare_enable(data->clk);
-	if (ret)
-		goto err_out_free_mdiobus;
-
 	ret = of_mdiobus_register(bus, np);
 	if (ret)
-		goto err_out_disable_clk;
+		goto err_out_free_mdiobus;
 
 	platform_set_drvdata(pdev, bus);
 
 	return 0;
 
-err_out_disable_clk:
-	clk_disable_unprepare(data->clk);
 err_out_free_mdiobus:
 	mdiobus_free(bus);
 	return ret;
@@ -121,10 +107,8 @@ static int hisi_femac_mdio_probe(struct platform_device *pdev)
 static void hisi_femac_mdio_remove(struct platform_device *pdev)
 {
 	struct mii_bus *bus = platform_get_drvdata(pdev);
-	struct hisi_femac_mdio_data *data = bus->priv;
 
 	mdiobus_unregister(bus);
-	clk_disable_unprepare(data->clk);
 	mdiobus_free(bus);
 }
 

-- 
2.43.0


