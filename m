Return-Path: <linux-kernel+bounces-76532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B0B85F885
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52600B26CE5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463221353E1;
	Thu, 22 Feb 2024 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZ+tU+zw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1EE12E1D6;
	Thu, 22 Feb 2024 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708605822; cv=none; b=D4zomdrNY8cIUm3DQT8EGRpJvfpBvAicrQNqtmzkDDoqwxGIiruzKLjEFRdrUNHC3OyYLZfnXM4g7A70UJUQ0tSJEBUGYYpgV2e4jUjzdfX6/TYm+7q1c+T2hjMZqA/9NA0lrU+54qqb51YgiTxD50SWdND7iNLALaEmRy+O4t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708605822; c=relaxed/simple;
	bh=OcmgXpcRM8kSwibnYWY2jGXTBaTcyrBdkKpBfGjwCpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AEHzaogHtzwhS1xPX6veVRhD4fRDHFRAX71IoPxEdysHI275kuoaCFk7GiG2qRKbYSygZK5WGppNGpm9qB97XGT5xNsHxxFSDOf9//chZbjx4yq83d8fWsvbNOKfVEDfSo0635YWyOhXfJUtUhmd4mxu0R/r9kO4I4toI9hWFf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZ+tU+zw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12893C43142;
	Thu, 22 Feb 2024 12:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708605822;
	bh=OcmgXpcRM8kSwibnYWY2jGXTBaTcyrBdkKpBfGjwCpA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sZ+tU+zwHEuCkU2aGO+otM9xajArfGOWdB7GRU+bbhwj6mxtjcfkzS2d0LtYX2Qmk
	 8JkQTwY6CcF9KWaFR8JfLv79sxUWv0IbNmVTu+q1/bqreWVKnvtG2k/pTleAfi0vdv
	 4vjVr38sXAwanX0fYV2g1N9hCpX7UDDwo6Bo6vsqFN7tfqgk8qSEaymUa8PAFKYL+O
	 NSkHMmrKLrqIO8PxcdUCIRn0K9yCfYhKiBEQ8b7aGQXn/raxHC7hh2FTQsaxhva6rM
	 VtNmg12WFpgar1eSzvKwRv5zi0PWHVhYFRrhULK42uYSxU9gI5ZFa8Im90tt9dtVqr
	 E95+MQ7gMAjAg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CFEC5479F;
	Thu, 22 Feb 2024 12:43:41 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 22 Feb 2024 20:43:26 +0800
Subject: [PATCH net-next v4 6/6] net: hisi_femac: remove unused compatible
 strings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-net-v4-6-eea68f93f090@outlook.com>
References: <20240222-net-v4-0-eea68f93f090@outlook.com>
In-Reply-To: <20240222-net-v4-0-eea68f93f090@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708605802; l=1155;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=sYmI7rY8FFj5xi4CE0Px8R4wNFWcF8TjujWAa/SwbJA=;
 b=J+c5JmE+zwQ+47hqbBiqjZouHf4AaRNXkfmB5TRcybazVxCARxI6fNv6NiDDCsoZaW0aFzkn9
 UIGYuWnSagDB1mHQCxoRd4RDDclKQaubg2jdJa9Zdso2/OsJ7DmYJR8
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


