Return-Path: <linux-kernel+bounces-78380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FBB8612BB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CDA61C21A47
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F130382D72;
	Fri, 23 Feb 2024 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nkr+jyOl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230827EF07;
	Fri, 23 Feb 2024 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694909; cv=none; b=Io/rKKX4/jAAsmD80Da9lQZO7eMavYZjQpUsicQ7VyD2t5c+MBSexoExpOjnNub1Em5ZHJE+2j7yYRt8cUh9C5ySXCw5KvwL1/+jxOXuMjO6ZHwvDBxgjduOipwvYQEt2mcjDnS9mKF7lZINS3M4AZ+sZTvufM47SeJ3PypAtmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694909; c=relaxed/simple;
	bh=q5PGMNCy5OeIZklkcuyegUf5HBFFBndhdfq9OggdzzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S67l3G1+caRbZQ8ZTqJASYggh3EwpBWRIU31CLv2ZvqtoX2oWo7N9YON3owmmxHXnS4Clr4UdX+rYKsMKQ7w1ezrxNSE4fjXxJ7avQtDR4YWJ16KZCjeVs62hu3XHggsPCWGNYQIzpPuGkDN0jOgqQ9Nt35P70O6VGiHs2tzR2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nkr+jyOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEE01C43609;
	Fri, 23 Feb 2024 13:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708694908;
	bh=q5PGMNCy5OeIZklkcuyegUf5HBFFBndhdfq9OggdzzY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Nkr+jyOlHif45JDG32fH9fMC3nka4OFJ72Tis/ZtwWnIBxUrVX6rwy2XujT/xKk9W
	 u9+SkVFucXACkCrd5Ef1PP1bbIu2djmtr/jqYDTNZp2CdEQdb6VnsW3+86Ld+NzrF0
	 PbetL3at0qWmMU1JMRKyCFWorZTHmEjK5yYm5osDJMQoR21Dnc0U9nTmt+RezwdTGJ
	 tjxE/+ZoNC20N9u4hz1mFdFw9gIngwEHqweJjCE+pfiHiALetyiifVWpqh5MKDJRos
	 ojH6vFeOFeIDCpRDSMEBxxN9QrwuxnTJBEMi8M8BJOhdkjvaEaT6TjVDSlv9h0FdwK
	 gqh+fxr9GyvcA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990C8C5478C;
	Fri, 23 Feb 2024 13:28:28 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 23 Feb 2024 21:28:19 +0800
Subject: [PATCH net-next v5 4/7] dt-bindings: net: remove outdated
 hisilicon-femac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-net-v5-4-43b22d39c013@outlook.com>
References: <20240223-net-v5-0-43b22d39c013@outlook.com>
In-Reply-To: <20240223-net-v5-0-43b22d39c013@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708694896; l=2357;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=8ICAnSLBv8dPhcTYWVHR0AJKAQbZebLk5c3PYvX8hqQ=;
 b=8Wn412/pznuc46HbMSFGNBybDfRK9u5s/eofvPrfTIzONTyFWH0HeVOlfYYCBmQbeH9Grxev9
 Kvhy4LOUkEmC1odAftzPqOCiAcyWm/i2vPJ5kvJIG1dMWh73dkWgCKC
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

The user documented(Hi3516) is not found in current kernel anymore. And
it seems this SoC has been EOL for a long time. While at it, Remove this
binding entirely due to recent driver changes.

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


