Return-Path: <linux-kernel+bounces-95430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDB2874D95
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2127C1F26782
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0758C12C81C;
	Thu,  7 Mar 2024 11:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfIP2RGU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE9F1292F1;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811290; cv=none; b=KIvF0Vv2L5ol5UOqodbkaxEmSoZONySMRTGJJEi+QS5kHiseMeOwKMfGBPS878wxTD+QsaqOXxCRQeUBQGzpbxOe8TceLKVho8/lKE06XNx+pIAEdtkiET2nhuXAhjx35QH0vuzQNB3ZssWYXBYI5oZDVgpRkVrkxHoCZBeR1/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811290; c=relaxed/simple;
	bh=9Khh/08IFLqiyY4llHeSF9dpSr+y2mbDaYQQexylJdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XG6Opi3sfhRSDjUt8zu0ArwZn5PHTqpFIfnkflJWwO/1n7RN/UR0w5hw1Kl9kr7gXlVcluHBeNEt4tkFHNGqIKXW3Q14LdxiUE2h5uOU6hghqpMoP3Njdo7KUyO2s06Zlbu3ZyAhotpPEft1umwuP7qMjXq08lT0CSdV6/hV9gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfIP2RGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DABEC4167E;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709811289;
	bh=9Khh/08IFLqiyY4llHeSF9dpSr+y2mbDaYQQexylJdQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OfIP2RGURGBqMKfNyEQqerIF9YXDzY6rtjIx765NrpVxV4hIlhnCxJcUWFGgQdaoo
	 RikmYjWD7QslVvKebvkkjj3ujJ8DzR2AKDWyCODPNzSDmTGMOAjGRXovHTaeLu+/Ou
	 XAsCk5NsmBPZd9i61iQuDNTczoFzjUAeJdRXeuXbfxn3KU1RlAyUEYvJxYruzQ2lxl
	 UOwVVIxLISyxBcSmIxkTvqrhFBlpWXNoiMlpOoHnb5fW+NK6EfGmgrWqBRV0gbHnHE
	 0jdbJruDKzoNrtC2MFl7S/2D1NzPu1VE6y0wCWTzFEXIprGe1kZq+jRklIUj0UIc9E
	 MdySVIU3aGCHA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79534C54E58;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 07 Mar 2024 19:34:53 +0800
Subject: [PATCH net-next v9 7/9] net: hisi_femac: remove unused compatible
 strings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-net-v9-7-6e0cf3e6584d@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709811287; l=937;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=aaQRrOl6ezTfgk2jYZxmgPEEzwU/YKquwXnutXaPBpI=;
 b=9FmgJapGP/SG0VJpetSvFJunm3iKivW4ooCiGKaNyiSaMV0kNsulIlll/qR3Wo4DsR8YaMdHe
 7U+G0o6jo5BAbyGMdUnJi7WHhyLRztA+jgo/S2rZyGcN/Lhq/YDVZa+
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


