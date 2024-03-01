Return-Path: <linux-kernel+bounces-87871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 035D686DA33
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D751C2104B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B79E56475;
	Fri,  1 Mar 2024 03:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCsNOZm2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C8E482D0;
	Fri,  1 Mar 2024 03:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709264161; cv=none; b=SjZITtmdendQ5vcA3LHvXzFMIQp51ALmRXZcG4y6k/JEevYT9/5C8Grz5YMdFkHvtUTuT+lmxMSkmTYgeou1dMjbQBhx/Z/eXQ9txlN8s0UHHIpMP+fnFpVETjWieQTgSyVAt4yFQ6G1yy7aWnm7OmsNi+ypoal67uu7O9Byjtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709264161; c=relaxed/simple;
	bh=11Z9ihFs1F9o4coCr+bkAMvEXdj6rVyn442xR9Dxq2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FaQZ07EUHGjh2zhIBIbQBbFLdFqXzOMQJdaEi0ipKqwftRa74Q+8kr6G93vD42/Nx6g6qtdkNRSekSNoNALpbvrjmWSIz3k32NhFjGF7gW06oQ5wJI2WBRy1lrjG/1M2TPjKd053rr4a2ztNOkNdwa9GZ2Br5YS/CKQPqZaV1Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCsNOZm2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6328C4167D;
	Fri,  1 Mar 2024 03:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709264160;
	bh=11Z9ihFs1F9o4coCr+bkAMvEXdj6rVyn442xR9Dxq2M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pCsNOZm2Cfl4AHFNj8aoHoxmHxhpja+H/W4s5PoxdJViH4P6sz4gP/l7bL6aDI3dc
	 zH/bPqKZvj62BI1kj+cvNZgNnRhHuR+XhYbTrbPWHaDE1k19m/PypLOrukSDTB5dHD
	 sb2B6cMNZ9w04lOB4wVXsFIsHwLgRc21OsRfH8Qz/jvqXtcXJX5WFMeZyb/ChglDy7
	 I2TPS09kkAnrNnMIRU+uV0sQJFMfY5cLlQncQd5LabFNz3SRT+6PAw1m72uhzaFa0a
	 /COuNUKquf5ZqpUG5HmYVj/RgdlB6PRuJdIrLTfiV66X23yT+HRTLe3ZmQCjEMgQWm
	 ocwd102M1F6MQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FA7C54E5A;
	Fri,  1 Mar 2024 03:36:00 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 01 Mar 2024 11:36:00 +0800
Subject: [PATCH net-next v7 7/9] net: hisi_femac: remove unused compatible
 strings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-net-v7-7-45823597d4d4@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709264157; l=1002;
 i=forbidden405@outlook.com; s=20240228; h=from:subject:message-id;
 bh=yJR/Lso4vTyxua+LycT+Z/1Tv6PHgtjLoMfikCd0gbo=;
 b=qF36YvzEkBC4gbu8ZacVt7bvEGW7u3W3l04x4zhH6UnfZ3doNYngX+A0hR/F9LC1fba2yTecP
 PK3V9yf1vAFCgcp0psus12wATixxNzaGWLD09ceH3/S/d/Z0fGPHYmH
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=KAWv6ZzFsT54MGllOczJgFiWB+DuayEmyn24iiVVThU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20240228 with auth_id=136
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

It's hard to get the version number for each FEMAC core and it's unknown
how the version can be used. Remove them until it's really needed.

While at it, remove SoC compatibles and only use fallback compatible.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/net/ethernet/hisilicon/hisi_femac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
index 2406263c9dd3..5a088cba7d4e 100644
--- a/drivers/net/ethernet/hisilicon/hisi_femac.c
+++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
@@ -945,9 +945,7 @@ static int hisi_femac_drv_resume(struct platform_device *pdev)
 #endif
 
 static const struct of_device_id hisi_femac_match[] = {
-	{.compatible = "hisilicon,hisi-femac-v1",},
-	{.compatible = "hisilicon,hisi-femac-v2",},
-	{.compatible = "hisilicon,hi3516cv300-femac",},
+	{.compatible = "hisilicon,hisi-femac",},
 	{},
 };
 

-- 
2.43.0


