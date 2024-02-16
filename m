Return-Path: <linux-kernel+bounces-68401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D43EE8579C7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB7F1F21424
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583841CF89;
	Fri, 16 Feb 2024 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/6zw0rY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3FA1C69D;
	Fri, 16 Feb 2024 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077722; cv=none; b=Xj5iBQr70OS9uo6CIpuEguwCK2ylNUcMbYOdQcYtVtrvWstX4Mj+YKf07ZGNJGaTNktwo72kr5OSw3ksshgUjVThaxtWfMhfOdBIbG653npa5iHWQEBStvFJzvYTqRAv9M+yzjKtha0bgacWMptijPIDniao013GmGfRF083Qrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077722; c=relaxed/simple;
	bh=j5nhh5B/znEmnTOlGsIqqT6pFgya37PaQz5F1VZv6Qo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dqoKLNoEQ0FUhALLFv5xvuT/U/nc5SbNXG99IPnwYuWD0fema4nY59pcSED9WFQhEh+4id7grjuOk/sphafZZb7jPqz8QN+woAP0L9eU6ybu7VZ9G0G0JXaPucDA8mGcsvyk+ixbp9krANngPdmlo68ozQDs6R+MxNIxcVQmjdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/6zw0rY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16587C433C7;
	Fri, 16 Feb 2024 10:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708077722;
	bh=j5nhh5B/znEmnTOlGsIqqT6pFgya37PaQz5F1VZv6Qo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=K/6zw0rYjz9fkQ2HYRz7y7B3U7IEw05Z99rmLztTnp/j34AJqMUpG6JnAVp/+lFwc
	 WeAMRwIP1zOX4xYIDfi4Zw2ZY2QrPLJEyyDaxd/O4IEdSDfpJ0FmODTKLqJ7Zq31y6
	 G913tYLXBkXZe2cqWS7WgDmmukVTJbR1gqzJuThtMIjYEmBId4YHz0wjsfgEPxZoUp
	 oTe9Sstr3ptYXfK7mKUUXBuTpRFeWGuKmJJJJrcHlBCuzGVaerk9bmwk6UOHT4YKjB
	 ENW19iS7rp0CJ+9SFul7xgWtgRoQoorn6QlSP882+0dNYpMT/gNex5nQqkGv0TwiH1
	 4yf3vy1oqjVCw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF524C48BEB;
	Fri, 16 Feb 2024 10:02:01 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 16 Feb 2024 18:02:01 +0800
Subject: [PATCH v2 2/6] net: hisi_femac: remove unused compatible strings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-net-v2-2-89bd4b7065c2@outlook.com>
References: <20240216-net-v2-0-89bd4b7065c2@outlook.com>
In-Reply-To: <20240216-net-v2-0-89bd4b7065c2@outlook.com>
To: Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708077720; l=1155;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=VItgdwH/S2ChRp+ovLIh4GSJZrDbNQYqIUlou/CYzgk=;
 b=iObYojUwZgCh1QaGVSGrNP8JRUwhiyKAgKlMEUVTARxkeuANaOrGu2f04uB8xcwGZxG5OoxMl
 xF1BqLxsEnuDYCpw+8JgdWPhR03wrB+obioeQVAYuclAjxo0AqqUzTA
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
index 15e90c7d6421..09a649af691f 100644
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


