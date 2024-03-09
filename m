Return-Path: <linux-kernel+bounces-97882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61531877124
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 13:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170931F216E0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 12:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32B747F78;
	Sat,  9 Mar 2024 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0wwS4yk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A43C3B2A2;
	Sat,  9 Mar 2024 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709987185; cv=none; b=ezS3Cd2R40fCH6ZG5ExSE740dL8dc/GWJfuWaSEI9Mv5OFHZKfrpouyTx2/CcP0UyHoJtaKTrU9VoPPNEKyeSTUFBcBD3IMKWC/aArKTZwu12BpmVVFjQEIFZ6m6Mu61dxzoloQap4P9nQqIwjdweN0kJDh3WZj4Sqpo0eWnp2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709987185; c=relaxed/simple;
	bh=DhcpedOubnECe7b/cBTge5kBP9lF6IUP3AO1TZvZq2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SJjOqmuREG3rtCcKAZfC2JjgnfTTFkY4VXPQr6JIqnvCBdMQnrHO6B/RmSEKTDzOtdAC0BnKIkiS9p6Ml4Jk0CRhxogAaEonvIv98L2D5u9chXZu/7sbNB8wS3IXY5X+PITdqU5tiZqxTwToz+S4tRr4BDODDYlEciBowHFl8xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0wwS4yk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 889D6C4167D;
	Sat,  9 Mar 2024 12:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709987184;
	bh=DhcpedOubnECe7b/cBTge5kBP9lF6IUP3AO1TZvZq2E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=O0wwS4ykxVaHbE1lCiX1nrqZxwU4tAbPV1MqLiPm1buwBjb2POXRZvTNX9OlQdDsL
	 s4pIKlI5bvbSt/hAg6a6na15k6MCoDmDFCeJcDn7mHjmul1cnrOG+sLGfMvNY1v+gN
	 /kKySe98duOkuZNjbQ3lW1Bpychpps6OAgADOb1QxZXwcr39SY18wEbqvnLWXjSfDX
	 IPqM+A+u4ERoybh7ZCSKSdV2wynIiKuL9KpuJDTNqSXYd4DcQtvpgJj0ZbtjIazsp9
	 LN+HDF9CMvqdAuG+qGdJOZSfAfc7lXTywbbedXxW8M9YDn3PzvwOe+gXh4p0sJCxEh
	 Dbqn+RsX+fqJg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7481CC54E41;
	Sat,  9 Mar 2024 12:26:24 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 09 Mar 2024 20:26:29 +0800
Subject: [PATCH net-next v11 7/9] net: hisi_femac: remove unused compatible
 strings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240309-net-v11-7-eb99b76e4a21@outlook.com>
References: <20240309-net-v11-0-eb99b76e4a21@outlook.com>
In-Reply-To: <20240309-net-v11-0-eb99b76e4a21@outlook.com>
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
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709987182; l=1001;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=lph+izMyuosipNJp3zUzxyABy7CFBGcgm+YFHBiI/s4=;
 b=maPjusymXxjRu5XBJlLbrFweG2oWMw4bQlpoFi9RcUFR7mKmhqMnGnjM6fkdL60jThnoVX4E6
 ibtkym5ToY1Bj7Yqm43TABNEk7P5DY7dUahxBsFOSaeH0svAn/tTHWC
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

It's hard to get the version number for each FEMAC core and it's unknown
how the version can be used. Remove them until it's really needed.

While at it, remove fallback compatibles and only use SoC compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/net/ethernet/hisilicon/hisi_femac.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
index 2406263c9dd3..9bf4beba7987 100644
--- a/drivers/net/ethernet/hisilicon/hisi_femac.c
+++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
@@ -945,8 +945,6 @@ static int hisi_femac_drv_resume(struct platform_device *pdev)
 #endif
 
 static const struct of_device_id hisi_femac_match[] = {
-	{.compatible = "hisilicon,hisi-femac-v1",},
-	{.compatible = "hisilicon,hisi-femac-v2",},
 	{.compatible = "hisilicon,hi3516cv300-femac",},
 	{},
 };

-- 
2.43.0


