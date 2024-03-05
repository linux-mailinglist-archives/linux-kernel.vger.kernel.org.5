Return-Path: <linux-kernel+bounces-91843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74413871765
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15D4BB23355
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF84781749;
	Tue,  5 Mar 2024 07:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpVVDPZN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2ED7F476;
	Tue,  5 Mar 2024 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709625073; cv=none; b=CgrV8HjoPjND+qOBfQ6GxeSfyXm/YaezOFk/dPXRxbAZS+MNjdbAzFSDboO5QXemGw8mhujol28Njtz7GsLt8C198cyYS5eO3mmtSS3vZ7bSZNxqq5AVcFZzp5Jh6IYNNVfZd2cqo6S7jOmkXE+gNv/nspLBF6od36Y+Q5l+YLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709625073; c=relaxed/simple;
	bh=QDh37/hypKzqzSrGrTAeVEghHDvc7ycpYvDwVjDq178=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lg/LyDcR0lpVMkSG5kF4nkOLjuC4QhztOBLMIruJuSa0fqPWPU1NZ4eUD09FzUdG0KeEE3yIpBPquxqGnPxjER8Bj03lZPgGa+1pWnAvcYxF+tpqhfLvjFnuw7P5t2zpS5ZhwJMW2L1UOhXaVfPLF5psb3SWDdkjeYY1o97evjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpVVDPZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A39D7C32787;
	Tue,  5 Mar 2024 07:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709625072;
	bh=QDh37/hypKzqzSrGrTAeVEghHDvc7ycpYvDwVjDq178=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TpVVDPZNLvOWwLBiGWzMobgo8QFbD2HtIFgHNJhEFy8bfZOvEj0Fd3b8/ua919/ad
	 KJI7Nos9ELYJxxVORm2DQGo8+ewpZe5aNr0rmfcDOkkQD5uOBDlKVJvH/ihDuQUdG8
	 PMP625X6YUd8jqHBF4T/LGZrmJYNiasDws21uELOQUCzRJbeD3F0U9dOC2P6ostAQ+
	 DSHWx+BgNTHTVkYE0hPsxM49Enhn55uw519hrGKLR9OEdHP0tEw2ZyS/ehBFW8jQeR
	 ZPkBhTExPxVDoV0rps1xUkinbRu+pHpkfWE0uiTxmUXugDcwqd/xNGJ1o5xmgTssaM
	 YdUFS283RbZcQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9361FC54E41;
	Tue,  5 Mar 2024 07:51:12 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 05 Mar 2024 15:51:18 +0800
Subject: [PATCH net-next v8 9/9] net: hisi_femac: remove unneeded
 MODULE_ALIAS()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-net-v8-9-166aaeea2107@outlook.com>
References: <20240305-net-v8-0-166aaeea2107@outlook.com>
In-Reply-To: <20240305-net-v8-0-166aaeea2107@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709625070; l=761;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=dDYro7mR0AilpKVwze2YXBVItXvJMbJiAARD8z9wFaE=;
 b=BeUD2kK+uMFGXzTas40KU2U+vEaLDhYUP7EOP2nwDx+5ZlWez0w7QYlXS6M4ra9Pr0NV/EIQQ
 52uVMHFo+q+BZHozbNe77BQ+Ns/oKGuptIDqIHnu+rr9Xq2eJCOG2tx
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
index a4f856710d96..ea8f60f292c1 100644
--- a/drivers/net/ethernet/hisilicon/hisi_femac.c
+++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
@@ -1015,4 +1015,3 @@ module_platform_driver(hisi_femac_driver);
 MODULE_DESCRIPTION("Hisilicon Fast Ethernet MAC driver");
 MODULE_AUTHOR("Dongpo Li <lidongpo@hisilicon.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:hisi-femac");

-- 
2.43.0


