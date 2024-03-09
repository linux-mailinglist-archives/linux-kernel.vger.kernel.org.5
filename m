Return-Path: <linux-kernel+bounces-97885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 691EB877126
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 13:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93F221C20B6A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 12:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FEC47F7E;
	Sat,  9 Mar 2024 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tG6Yu/Fp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3513C6BA;
	Sat,  9 Mar 2024 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709987185; cv=none; b=S/yZ+Cs4tB41vU7G5Gx0Hm/ghGAOeOfHf/1Y3utD0qAlEb3eEwWhEMVkx5xvLqUDEI4UEk/zbiMLVB2NSuXDXlweu+acK3X21NL5Cdi4u4gekg80LHYrQ5PoeWwBiQekM4Iiie/J/a/03gLsoSz3eJfn95qndemflA4F/8cmG9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709987185; c=relaxed/simple;
	bh=lSKWeMSp6hiaBqDIHd2zETyiJuHGSONXfIQS0i6E3Cw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=llHmoPg+r6VNsIJgv56Ad+h63IUPwMTBk4rzevymv9WNTD3HvO6DrjVg5AmQ6te6buGML1+qjp9/2x43236Nv9lSRq2WvUG5ZPDRF6nU18Ww2ty631xFUqoFMHddStlU8V4IlCz+DFtrLLTY8OHC1b6rmJ+uhyYsaHaeSluKiDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tG6Yu/Fp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8EEAC32786;
	Sat,  9 Mar 2024 12:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709987184;
	bh=lSKWeMSp6hiaBqDIHd2zETyiJuHGSONXfIQS0i6E3Cw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tG6Yu/Fp1cau7HoYkFQrIpJgUoMW5Sk9IqwQYnl6XYYMj+vFak63YeCTS9v6qR1W4
	 GKMAmFzuK1dxdZiD8u7mSSAH9WMSYG2J2HGzLotUnR9KCgWFXa04ExRH9m/1g+Mbvb
	 kQnjjUyZtcqI6oeMaBF418s7zMHN//amODoH4PX/pI8Bcnt2r5kXUE87Ksz/20vDPD
	 uS3i6XDictmsSBYrA3l56eqUeNqXR4D9KdaUd7LNgsrT4kBQlMz1IzaTVLsR6ozYdq
	 WGaa5ZkO0ZN/KjB1Wwt1fej0jJUUP7qrzMp2XnHtJugf4aoj2ps91LT3gZtHlbS8di
	 NB8l/f4ri6Wyw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3CCC54E5D;
	Sat,  9 Mar 2024 12:26:24 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 09 Mar 2024 20:26:31 +0800
Subject: [PATCH net-next v11 9/9] net: hisi_femac: remove unneeded
 MODULE_ALIAS()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240309-net-v11-9-eb99b76e4a21@outlook.com>
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
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709987182; l=761;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=5asUwtns0o/WnZUMxP/lMUTHZU/9R+BsisaTEtLgTiE=;
 b=a4D3ssZqzk2x3t1Nh/7G1qhSCn7dESniI29GS3APQfCyQ1jVI6fYO/IoAq/ILo/DGERlDdF20
 6JdNhtQtlK3AFDkf2iUq+GdFR9tcfe1QTkZxgTa5fa1c9XqNIhd2Hss
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

We already have MODULE_DEVICE_TABLE() that creates the correct alias.
Remove unneeded MODULE_ALIAS().

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/net/ethernet/hisilicon/hisi_femac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
index e873a4140a62..f434a3beaae7 100644
--- a/drivers/net/ethernet/hisilicon/hisi_femac.c
+++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
@@ -1014,4 +1014,3 @@ module_platform_driver(hisi_femac_driver);
 MODULE_DESCRIPTION("Hisilicon Fast Ethernet MAC driver");
 MODULE_AUTHOR("Dongpo Li <lidongpo@hisilicon.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:hisi-femac");

-- 
2.43.0


