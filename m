Return-Path: <linux-kernel+bounces-96677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6A0875FD9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC250284005
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3335645C;
	Fri,  8 Mar 2024 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwRUUWVz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5A452F89;
	Fri,  8 Mar 2024 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887186; cv=none; b=JmFparhP5JjXRboTE4Xut5RohPmkG67igTQaWudolM+C6+581gYsDyypF1wqrPa/alsVW0Q9yudoOwtDB6Fuzolxpw8rYIc9+bcrxYAqpKeoKJ75wmgY+FFZUex+iTmWO55If8tPuZtPS3Qig0zKSGJZANALJO28nueJGcZRsvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887186; c=relaxed/simple;
	bh=3ndi5x+AOKkkuN1jZhXL9mLzFshzVm6V3WcOvBa7RW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RPfS2cZLAmF/3IStYZYOLlHgejZEl04tRIJ9fBfOzP9pRYcWDf40JTwcntmWJ2eVL/GJHYcz1emCJK90VD3A6T5XcApCKhJpZcpAVym1ORwmPxxGmQdOlk9G+wgOT7DCmVj+UpIMARdZE33J87J0PCl9+4DR3m/BEes9p76cAvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwRUUWVz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87CD0C32789;
	Fri,  8 Mar 2024 08:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709887185;
	bh=3ndi5x+AOKkkuN1jZhXL9mLzFshzVm6V3WcOvBa7RW0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kwRUUWVzYymLEuO8uLmfNdyXkwFRMiXhuj0/YD+i0XPCxo0TEbnMMffxSEHPgM9oU
	 BFja64vjbvBmWU3Xs97s52CyGqo7G9A8l/QR6tYDnWTs5snWYLCZ+b3TIPYsWoAJU4
	 w/eKcJsHgvTms3DP7K4OXqzLm0nm0I5n1Y1SXT1MBqyVmilI3iJu1kp8vqyTNg1OX3
	 zLjhtNcSQkjKnrA4NQhgEeJD/Ljm+ESBXN6AX17iagAhB7jyVXXZoXXle9dfPcOkUP
	 t9rrZ/YGKq7e3OZQnyQgleR03/uvZuQO7+A3FgB0FmFIqL50Ys/AT9N/9I3LdFd1Y5
	 gFt29lVAFZryg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1FFC54E5C;
	Fri,  8 Mar 2024 08:39:45 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 08 Mar 2024 16:39:50 +0800
Subject: [PATCH net-next v10 8/8] net: hisi_femac: remove unneeded
 MODULE_ALIAS()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-net-v10-8-3684df40897e@outlook.com>
References: <20240308-net-v10-0-3684df40897e@outlook.com>
In-Reply-To: <20240308-net-v10-0-3684df40897e@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709887184; l=759;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=uL7LyY/J5pSqlD2z/1TEbFEFBkXEinuPTyuh1Re7jzE=;
 b=UsaE+jHuRZvUIbRpHxIgOLRJQR07lC6/TlyHzgQ8F/LfgY0Z6IZAc7htq8eSvgpbBS1NNAthj
 id3ugYnbDvCD6U2Q8FeGN4bBdiE7TQLcatKlfcIXH7XUc0XuLFkhhX2
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
index 9bf4beba7987..f0f2a3cd8d1d 100644
--- a/drivers/net/ethernet/hisilicon/hisi_femac.c
+++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
@@ -969,4 +969,3 @@ module_platform_driver(hisi_femac_driver);
 MODULE_DESCRIPTION("Hisilicon Fast Ethernet MAC driver");
 MODULE_AUTHOR("Dongpo Li <lidongpo@hisilicon.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:hisi-femac");

-- 
2.43.0


