Return-Path: <linux-kernel+bounces-67854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0388571DE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06B31C22529
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178C8146905;
	Thu, 15 Feb 2024 23:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5W5kA6l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B17B145B07;
	Thu, 15 Feb 2024 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040933; cv=none; b=k9sNAu2vIBCl3AVMFz9iRtuLa/PM/QD3vmB95KH1P11KvnzRycZgaL0Zpe/DtTm4E19j3tenloVCBxvWiDA+bGjFKX+G+SyM280pyHteOVF3/BxAblAEbIJvu9dDKYY22331cdOnClJmOwIMc7S8xhPeMnksiXS2z0UJQz2QqSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040933; c=relaxed/simple;
	bh=zk4WR4VZ/jCY8pexd+8b92ywhJFB67TqSj5YpsTG+TQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fm35wGj9/UbtED9eolKNhk2c4GXmikmV9+Rp+hya74jcBK6ke4eUsY6YjTiC1VEQAlyEQc6gYheebfBUgJtR7f2i/WHuEEdQPF/6fhMZSrY3M+CGXKnz5POfKYB+MMZHtGnCWmmw5MWScXuqsY4mt+1r9MRH+kfwH+gg85UJZXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5W5kA6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC873C433B2;
	Thu, 15 Feb 2024 23:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708040932;
	bh=zk4WR4VZ/jCY8pexd+8b92ywhJFB67TqSj5YpsTG+TQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=h5W5kA6llfgxVAHUfzeNHCObe9n50aKNMJDNG11KqsrBK58kDilm9wT5BChQmUQTX
	 DLPKIrcYoc4HXm4y+Qd5K+LLJcyRq9DB0ZChLa27eoG/fd+D9p8tkVPtOsuvyYL+UW
	 KkWhK8h/2bMnXGZB/LkjL26Nxi4ri+D0gAEC+fXdrYRYKpTxW3cAeIC0fD59StR49R
	 gH4ukguTqPRaUCg7gqBRdIGRka+bLDJZdNJFuu/JHpy+bt6dZDCx8+Vj9k1Hi38weV
	 ihakl/d0ZXuetjBRuZUi1FZqBIyqDoHBQFzoF79xeMSmwgOh3/Yp3XLing3RgQcbbo
	 L8JK2wtu6KxBQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8297C48BF2;
	Thu, 15 Feb 2024 23:48:52 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 16 Feb 2024 07:48:55 +0800
Subject: [PATCH 3/6] dt-bindings: net: remove outdated hisilicon-femac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-net-v1-3-e0ad972cda99@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708040932; l=2291;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=/LRpcFbOMPfKKUiQJIHRI4Rc7KX5XmWz3V8ZUehXBd8=;
 b=+iIZXH+TBsZ0TpNpIKvi2QCLLprQXK65wZF6Z9kiv5kV4SKJdhRYMipMC3GxD/9L11qwrOHc8
 mja+oNKt4cRDIesBekKRdlJQS4juaDM58pPIanNHL/76wWLjEEkNg7n
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

The user documented(Hi3516) is not found in current kernel anymore.
Remove this binding entirely due to recent driver changes.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../devicetree/bindings/net/hisilicon-femac.txt    | 41 ----------------------
 1 file changed, 41 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/hisilicon-femac.txt b/Documentation/devicetree/bindings/net/hisilicon-femac.txt
deleted file mode 100644
index 5f96976f3cea..000000000000
--- a/Documentation/devicetree/bindings/net/hisilicon-femac.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-Hisilicon Fast Ethernet MAC controller
-
-Required properties:
-- compatible: should contain one of the following version strings:
-	* "hisilicon,hisi-femac-v1"
-	* "hisilicon,hisi-femac-v2"
-	and the soc string "hisilicon,hi3516cv300-femac".
-- reg: specifies base physical address(s) and size of the device registers.
-  The first region is the MAC core register base and size.
-  The second region is the global MAC control register.
-- interrupts: should contain the MAC interrupt.
-- clocks: A phandle to the MAC main clock.
-- resets: should contain the phandle to the MAC reset signal(required) and
-	the PHY reset signal(optional).
-- reset-names: should contain the reset signal name "mac"(required)
-	and "phy"(optional).
-- phy-mode: see ethernet.txt [1].
-- phy-handle: see ethernet.txt [1].
-- hisilicon,phy-reset-delays-us: triplet of delays if PHY reset signal given.
-	The 1st cell is reset pre-delay in micro seconds.
-	The 2nd cell is reset pulse in micro seconds.
-	The 3rd cell is reset post-delay in micro seconds.
-
-The MAC address will be determined using the optional properties
-defined in ethernet.txt[1].
-
-[1] Documentation/devicetree/bindings/net/ethernet.txt
-
-Example:
-	hisi_femac: ethernet@10090000 {
-		compatible = "hisilicon,hi3516cv300-femac","hisilicon,hisi-femac-v2";
-		reg = <0x10090000 0x1000>,<0x10091300 0x200>;
-		interrupts = <12>;
-		clocks = <&crg HI3518EV200_ETH_CLK>;
-		resets = <&crg 0xec 0>,<&crg 0xec 3>;
-		reset-names = "mac","phy";
-		mac-address = [00 00 00 00 00 00];
-		phy-mode = "mii";
-		phy-handle = <&phy0>;
-		hisilicon,phy-reset-delays-us = <10000 20000 20000>;
-	};

-- 
2.43.0


