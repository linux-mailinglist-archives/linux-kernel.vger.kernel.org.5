Return-Path: <linux-kernel+bounces-67851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 033858571DD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98E921F23DFC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D43D1468F6;
	Thu, 15 Feb 2024 23:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ldt4ZEkx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3603A145346;
	Thu, 15 Feb 2024 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040933; cv=none; b=t/O4sOoyeRwtKSKNdgRWiIRLF1rnSftMm20dwyi8K+3a4bm6BJToz8cZPqOJLG4siMSOhUL5Lxf5+V6SIy2gy5D8JtfAqF4xuL1jF0cnuu1dGe8Uxdn/4yuwrngJSNSxp0bhccx51Jc/ZSLlq64YeftJfKM/VrY2xprQ5TEweho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040933; c=relaxed/simple;
	bh=kHlJYXFc2o2nqfCsYXCiE5nblag+GF9yfKhjdNiYNhk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hJSUopXQd7JAdpD+BrTcVx8j00NFhmYdD+S+5isoDXPffB7odOjG0+obU0FPPryjnK9DAOZpro/JswmRlI7NQTwgt3cblySUtIE0neF1af8sYM0pyjSIdmc1ptWFG6dgcly9wFiMZG2o1/pIbAW7vjvHnNUwXCBUYsrSQ3X18Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ldt4ZEkx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBF4FC43399;
	Thu, 15 Feb 2024 23:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708040932;
	bh=kHlJYXFc2o2nqfCsYXCiE5nblag+GF9yfKhjdNiYNhk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ldt4ZEkxxdQARf4z7y9yg1o5ZZ4/aP82xEHLJH5KmamlzWCW4jhjbWAX1i587Ebzg
	 GwMkGWZEV+zCulEthzeHhvnVpQOdP0r8LMZPoTx9O9fu171cuwnVdg9HRHsrLXvUGq
	 9jNqpii8HD9S+Gy8JuNPBrMM+bYkophvfHyj3qWOvMAZWzVGqAq3ftQsZvSxrGQoC6
	 ek49UUc6FTgR8wj9gaYLWuTpvaEtwRmg4tfpbPb2t929SFZJZxtNGL0rBr5RHHiV37
	 Mgkxxd3V4waxfmHOo/QdwMHBoRtnaAQw1QmqUDabBqCz9rB5r8NIw67hvUUeKkwV92
	 Nqfnpdp0ojPEw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54B9C4829E;
	Thu, 15 Feb 2024 23:48:52 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 16 Feb 2024 07:48:54 +0800
Subject: [PATCH 2/6] net: hisi_femac: remove unused compatible strings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-net-v1-2-e0ad972cda99@outlook.com>
References: <20240216-net-v1-0-e0ad972cda99@outlook.com>
In-Reply-To: <20240216-net-v1-0-e0ad972cda99@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708040932; l=848;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=Q6RobEliCYMOixlSWarXH2F6cDTqzSpO8SvRil35ZCg=;
 b=ic/0aLLq/JZF1P0XEK/8iZ7k8+22sry3xHwtc9XbBn5LCQaRENK+l+qF4NuHlLn3JUOfAjl80
 hhleIxNJVIkCJWBxDEHq/spq3dyp/PNQ7jhZX4WliE331rdd0VTU2CA
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

These compatible strings are not found in any mainline dts, remove them.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/net/ethernet/hisilicon/hisi_femac.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
index d72160efff9a..6dabc62a00b7 100644
--- a/drivers/net/ethernet/hisilicon/hisi_femac.c
+++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
@@ -990,9 +990,6 @@ static int hisi_femac_drv_resume(struct platform_device *pdev)
 #endif
 
 static const struct of_device_id hisi_femac_match[] = {
-	{.compatible = "hisilicon,hisi-femac-v1",},
-	{.compatible = "hisilicon,hisi-femac-v2",},
-	{.compatible = "hisilicon,hi3516cv300-femac",},
 	{.compatible = "hisilicon,hi3798mv200-femac",},
 	{},
 };

-- 
2.43.0


