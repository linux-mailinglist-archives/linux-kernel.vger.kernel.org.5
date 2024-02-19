Return-Path: <linux-kernel+bounces-71928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7378185ACA5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66971C20856
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F387653E03;
	Mon, 19 Feb 2024 19:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSxgunJz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3537251C58;
	Mon, 19 Feb 2024 19:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372657; cv=none; b=JCRcDVkoijOgMcyBrtlDa1k/mbcyUEWNTItvRL/5hMAWmgYu9VdsDeGGRlJtg/3VrFKCg63SQUVTUZgFl0kM5qkFiaKo2wqdkLgTh8so7Tg5g+TJD105dgYaa8lM5rRtaVUrmI8AKheT8zSUEigbb1tRT1iLdJhOwkLz6aRImTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372657; c=relaxed/simple;
	bh=NKxyV19gwbx9qhToYre9J+jdVoGdX5i6pOifxN9cB7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s+2keNflEmeRutnQFd0UEmLhrJEEjltowej7Iy09noRtOC1NDVmhyAox0+AYzRyw6mNjlb7zMr9W3rVYl5H+WyByuS6xV3a/vQlS+URa/F08YVGwDU3OYCZT5jiU7Vwao4iNPZRZqLc1ZggPOxdfHGR2ZqO7FPY9GTByhVmSaS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSxgunJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC4B2C43601;
	Mon, 19 Feb 2024 19:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708372656;
	bh=NKxyV19gwbx9qhToYre9J+jdVoGdX5i6pOifxN9cB7I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nSxgunJzHkGo+TJhaIF8YAM5rBRJgxSVX39h9kh7X+nX5kB3QvmLIfOhiP6vOO5Gi
	 hYFK9oL/52gPXdeQtrG2giHqXZBDsi7NPQMLrgBAva+cuCtYpuwF6dzQKdvOzGoIYF
	 hqwcIwAQdWlXoFGrNuSORRpEHSXkIbj+jPOxsXr40G8MjxDMIkSY5p3e2vM8wyKWb8
	 RNAi9bP0JhFQFg8Mncaf3uDtVQuqwAdUDfpqta4qbt2uM+8MyWXbfAXcxcAsheLCb0
	 jCXiEkeeZiZSWuM4SoGR519yuDo1pmngGxvKswXafhmkoBTn1GqXG2i/APFWFlAmuR
	 FnuYsFnCI0RGQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7ECC5478A;
	Mon, 19 Feb 2024 19:57:36 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 20 Feb 2024 03:57:39 +0800
Subject: [PATCH net-next v3 4/6] net: hisi_femac: remove unused compatible
 strings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-net-v3-4-b68e5b75e765@outlook.com>
References: <20240220-net-v3-0-b68e5b75e765@outlook.com>
In-Reply-To: <20240220-net-v3-0-b68e5b75e765@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708372656; l=1155;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=RJSzDAXs9gtmFQJrfvTCrO3aV7+qGbUSblDkcyuUubM=;
 b=m1oOPiZMcNEKky8GmEBCPkQ9kS3ZNzv7XNMAW87uVjK/yXDfvEUVVLlm4TUqyAvaZePjNQ4Z+
 akmdulXx66dCMC7KDjgzC7ZHSnQO//XrrX4kRI1XzHpM03pi5GQbZi5
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
index fedfc7219fad..a5a7e0f5eb59 100644
--- a/drivers/net/ethernet/hisilicon/hisi_femac.c
+++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
@@ -989,9 +989,7 @@ static int hisi_femac_drv_resume(struct platform_device *pdev)
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


