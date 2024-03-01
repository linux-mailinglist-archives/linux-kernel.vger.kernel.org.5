Return-Path: <linux-kernel+bounces-87873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F8A86DA35
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7336B1C217A9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6216147A66;
	Fri,  1 Mar 2024 03:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayq0m4fm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5BC482D8;
	Fri,  1 Mar 2024 03:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709264161; cv=none; b=GTU45Yt1aSNSU2kr1rXry1fnXoRUF8lr6gM3NGA7jcSQTcuuXo1Pvq5Z3m/7Ut6CCUO9cd1sRwVHV+u7vU3Aoncv/Isr3ZuY1a3CE0UANR7CWRc4oHuDK2neCioBQi0rJiddXbDPsqoUZ0ybB6j7TrxUHz02PvTWfSJFOPswU44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709264161; c=relaxed/simple;
	bh=7MMrpaeosl/HNUkEmXL5fvfi4arjsMc5l6Z2bn8XT50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NQsosUpjqYUlGdt473/+Ksmwp1T72qdDANGxUss7POqYSeMZF7HUOcUAWxzHYZmCqqN3KB6R8gVnjGIzTybY4392FVg9E2T87MLOZ+FeOvnfto02PTzolkpB/I8jB/ipjqI1ScL+egIJ3yd2pI/NJfBl6F57cRFtoqHG/tgVLv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayq0m4fm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D02F9C32781;
	Fri,  1 Mar 2024 03:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709264160;
	bh=7MMrpaeosl/HNUkEmXL5fvfi4arjsMc5l6Z2bn8XT50=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ayq0m4fmc3kYLRBYiF0XcKRP60Pq/NpI3LwNabcyvSP9sxAA9SWZ9yKMSY8Y66Omy
	 IkVAxVe7I7/v5H2s+2xMSfXnHYqDSwU7QHz+BkONawbrcSiCuupV5Oc1oSuULoxxHm
	 6DwjUOewXUPs5nUI3XK50DjaXZ/qmo98QXWfHDHNV8GggYv2adZkHIZmodhjiCw/5I
	 hQRJXii3JA3B/I3GRWX30X3bJxiI3+K/912tTv+Xj7AomvG4KwqebH6tKd2k12s8bW
	 RG6JZ9qmSe4uPiSrEkqn4Agw+9MbRb2UJXCj/RV+yjg4VJYmavKDn0XAm4w2o716Uk
	 Tp0kMJwJPrw1Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B911FC54E4A;
	Fri,  1 Mar 2024 03:36:00 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 01 Mar 2024 11:36:02 +0800
Subject: [PATCH net-next v7 9/9] net: hisi_femac: remove unused
 MODULE_ALIAS()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-net-v7-9-45823597d4d4@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709264157; l=755;
 i=forbidden405@outlook.com; s=20240228; h=from:subject:message-id;
 bh=+34jZ1SKVkOv2MrXgtbQ7Xmywsr8EdEjQMnJi4ShHRs=;
 b=I7cBEABnNwTuWfyboWMHMrZ5qaVqOs8glzX8mOuOV5IRCw7VivfzHePoyU78v02FUskRZLEem
 O1rRHgJyGypDAQI1kDtYciXwYi+W6dSPdgr/KOMqPKvqNY49d25sYk8
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=KAWv6ZzFsT54MGllOczJgFiWB+DuayEmyn24iiVVThU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20240228 with auth_id=136
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

We already have MODULE_DEVICE_TABLE(), so this MODULE_ALIAS() has no use
and should be removed.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/net/ethernet/hisilicon/hisi_femac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
index 22a4697e0dde..2ecc10a9ca28 100644
--- a/drivers/net/ethernet/hisilicon/hisi_femac.c
+++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
@@ -1014,4 +1014,3 @@ module_platform_driver(hisi_femac_driver);
 MODULE_DESCRIPTION("Hisilicon Fast Ethernet MAC driver");
 MODULE_AUTHOR("Dongpo Li <lidongpo@hisilicon.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:hisi-femac");

-- 
2.43.0


