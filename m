Return-Path: <linux-kernel+bounces-95428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D491C874D8D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBCB1C210DD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A093D12AADD;
	Thu,  7 Mar 2024 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="im485R7n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD791292CA;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811289; cv=none; b=CRWd//AE75KuL+qhzWaocRYV/49YxUrq6aByXv9iChyB2kdA3qZwciFbjIvGQzSzC7nHCmxxlnJSHQsGdfmGkwza0K+6zV/64yJ6HUT6nlVNFYP465WCsuE2uakM9qz1gi9XRlT2M/QLogkWAA7TTCYWLxPVZu2zQQFjb+hvg+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811289; c=relaxed/simple;
	bh=vu47BKfN+xFcRDfbkn3C1v8zrm2ugq1RBZELrpt63GU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O/4UQHOePHVH5b4vzBgv3bAaKsoFswbHlvfj3kPPj5ap62Nvi0/2QxW+qtp1TJ8pi5rE5hFF8HAGPL1xp14cKjLYAhuCh9T33k6IoJlmmNQMC7nf7zrmrH+qbQgNRUtVhl2m8Sq6YHNn1Bcg0QfwlNL48ixaIaKMZ97p6K6sSL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=im485R7n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 649FAC43399;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709811289;
	bh=vu47BKfN+xFcRDfbkn3C1v8zrm2ugq1RBZELrpt63GU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=im485R7nJmn8xDH8cxn81xBBQrDgIDW1mGHRDMHqIPt0mRYJ7Uk/5sM6ATCChj5ap
	 46QvL5GIz+cdN76vJ6cYbgKVhr5sxrQARq1b3jatve6uGfEbGXNS0tZCjmPzJNTD1s
	 5V9PsMWPJPx2rI/Vkj/OFKO5wIOFntLO62TtX69eRJgkB69qWRl6Rm1g/amQkNG7Rz
	 2waLDh8TBvq50BobOMmCH7C9tQdhT210K3gZ2J+ibqRroJuqapAAhETsNuST+qE9IT
	 D/DzIjE+SipAuxwxO0/3a4JKpJhCKVhc19nVGyU0np9XYUf6FLEqzq7pcrSnIgTnuG
	 V2xyULJzPCwuA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2C1C54E5D;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 07 Mar 2024 19:34:49 +0800
Subject: [PATCH net-next v9 3/9] net: mdio: hisi-femac: remove clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-net-v9-3-6e0cf3e6584d@outlook.com>
References: <20240307-net-v9-0-6e0cf3e6584d@outlook.com>
In-Reply-To: <20240307-net-v9-0-6e0cf3e6584d@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709811287; l=1802;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=kdWAr70dNlF5sryokQxZlrJGOk8Z9nw7ekwi0I/9miA=;
 b=4jG54x7jbw0SvOi73HBsijYpAPLI5aJg0+aivTN+E2BwqWAmb9+9EI/8ESyHdgvineOb53dR8
 TCTFa4NfbJZDMHqCFQMazmqRdJgxe9RmCLsMoVg7No64HCQLtKgTXU+
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


