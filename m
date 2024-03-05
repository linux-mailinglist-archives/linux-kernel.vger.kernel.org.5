Return-Path: <linux-kernel+bounces-91837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE64871755
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C151F213CC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6657FBA2;
	Tue,  5 Mar 2024 07:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGFLxhcc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE647E79F;
	Tue,  5 Mar 2024 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709625072; cv=none; b=JrxUxLzguCXJKp3CFIuwcFnDhW6EAa+0WVAt3wO8SbqFZtqqyPRkzPvADB0Pjm3C6+pmYBiVqj6Uwfk//rtxWRb+y5WbhOBCayCmrD7N6nrKgA+cjehMRnU59X77hUkUkQpapFNmSBcs+UfDsR1CIMWLXVeWmM6Lg/upB1CkjKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709625072; c=relaxed/simple;
	bh=vu47BKfN+xFcRDfbkn3C1v8zrm2ugq1RBZELrpt63GU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R4x594pb9lTc4XFWKhh/mqfH2maU7pdedoecq0WYnb+erpgK+N5pdmOd4E1QzVib6f+mbIncMI7mpnGzQQ6dX0ZqMKE3ndWi3JeIBo19k6/SYeyd8hVWWaDoj2FqD7Ee1M4j37Smgdgb1LR3Iz+ivIzY1TTEJNcbdya3fxDXNpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGFLxhcc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F213C43394;
	Tue,  5 Mar 2024 07:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709625072;
	bh=vu47BKfN+xFcRDfbkn3C1v8zrm2ugq1RBZELrpt63GU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gGFLxhcc+1VBu2Ct0DwKdbPy5M+XwFG/851rEpLneaqneDzYqj5m5cFb2ohL65CC9
	 K2zJj2fcNiRliyVKvd0pMP9cX6sUHr6Hoo9HdQVF1QbwyLPvzZ6gyH5E4a2nlDGYJj
	 GJmOmKNKTjzaT+Ck4ldwqNU/IDmaoegDCDCKmBWR6WSbN78pItBVRU8SYKll1XwWF7
	 8+4DMPmeibcpF/BnPGlUPlTzx0H0JWM/aOpnVtSjE+N+xK5MXfntaBA4DksczRKNzo
	 P8zJc4wYMJsAnT7QL9TAWieKxLAfGPLuCbIpi46Q9N/NZ21O0exmO7Xu/i9iVvlpFy
	 LNZ5dCVAyKZuA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414B9C54E41;
	Tue,  5 Mar 2024 07:51:12 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 05 Mar 2024 15:51:12 +0800
Subject: [PATCH net-next v8 3/9] net: mdio: hisi-femac: remove clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-net-v8-3-166aaeea2107@outlook.com>
References: <20240305-net-v8-0-166aaeea2107@outlook.com>
In-Reply-To: <20240305-net-v8-0-166aaeea2107@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709625070; l=1802;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=kdWAr70dNlF5sryokQxZlrJGOk8Z9nw7ekwi0I/9miA=;
 b=/mqF9KbWpKm3quAcbIMJUnUN/Of/eercZbXE8jFyAKYih7pgUNSV2jfukyep/5tDJ+hxqNU1w
 jXQGTX6sDGrB8JpL6HlpMt2ku7FC5WG/CsjssjREG7OkhLtctYIbEQU
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
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


