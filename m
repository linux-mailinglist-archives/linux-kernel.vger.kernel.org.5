Return-Path: <linux-kernel+bounces-84727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 388EE86AACC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0FF41F22748
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F7644C69;
	Wed, 28 Feb 2024 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxXoc0Eo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D22531A83;
	Wed, 28 Feb 2024 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110947; cv=none; b=dg56972apL/Ju2Dl7501nxLLVC4iUby264Fll14zjAF1w3YOwmjh56TpcnRjCJmljah5pYZ18qHMK7PfgVKeRRijUTDmGmGrk+97vFQdIu/8PXkgB1LxGeERusGnnoxtdshWXDBo0EQS6Lr6YaufiVyCz6L0YPMDVQM1M8ur89U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110947; c=relaxed/simple;
	bh=AwiWhyYYPQ6J5Nsxc1RcXcfAeBDJwdSxCWFxnx8UpOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L0iQA0MYenj0Gbf3zVvAlU+cIRbwAODbT3FbVCA2D3mwIhh2hjIjSczcx82BmsDHwn5Ti8TWKeIBGWHKgtuycdq7BR0aqPl54lXoCk/GDTP6cv9PB3q3jMBTbQvlNJgmI0KYDtSC2EJKZF00JL3lX8vHACnM3DWgM52XE9VLtVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxXoc0Eo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB21EC4167E;
	Wed, 28 Feb 2024 09:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709110947;
	bh=AwiWhyYYPQ6J5Nsxc1RcXcfAeBDJwdSxCWFxnx8UpOE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TxXoc0EoB29C+ytOFAg+pPsjhb+xBC0jvwepynh3cX7mMnlIg5/h8qEs8K0KZkxjP
	 2oO4igRgVtceE5KwMf8iTNccByS9bufsyICws3sA4d9+amE09GLLlO5+OEoFyIB2Dy
	 +ZVG7UlY9xRxAkHfugCqz8wjENQeT8C0VUq3VBpLygLXSYU2MQR6KNi+7JK7RJtuVo
	 GEIfuP9rXJlH5lr2rUD07ZmGwyjdC+emCItOn6G2uiniqFbG77v4/o1TcRGTzKqXwt
	 4aO2y/aMM1H/bRAiArLEkyDLjY0iYxAoz2Om4zYD+ZcwTRA71XtsWHC+ThbqBRMlnY
	 xv5arJzybeZHw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB361C54E55;
	Wed, 28 Feb 2024 09:02:26 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Wed, 28 Feb 2024 17:02:31 +0800
Subject: [PATCH net-next v6 07/11] dt-bindings: net: hisi-femac: replace
 deprecated phy-mode with recommended phy-connection-type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-net-v6-7-6d78d3d598c1@outlook.com>
References: <20240228-net-v6-0-6d78d3d598c1@outlook.com>
In-Reply-To: <20240228-net-v6-0-6d78d3d598c1@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709110945; l=1121;
 i=forbidden405@outlook.com; s=20240228; h=from:subject:message-id;
 bh=UkM6cazLUUcGm7V+UelgyTmRZYNnC9CwRUbl7j+gA44=;
 b=f5Z5JfMhFzIZrioziMkhpJB/CbSksX9sZDGw/4dP0dQYJHzTEaL2jb0GFBOtYQQ1738WyKZ4X
 GWICiPgPUFOCNGnp3xFLFHiUbPWx0lzBribGIcCjE8z3ivD+rsr8FPV
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=KAWv6ZzFsT54MGllOczJgFiWB+DuayEmyn24iiVVThU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20240228 with auth_id=136
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

The old property "phy-mode" should be replaced with the latest
"phy-connection-type".

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
index ba207f2c9ae4..6c5888897876 100644
--- a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
+++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
@@ -66,7 +66,7 @@ required:
   - clocks
   - resets
   - reset-names
-  - phy-mode
+  - phy-connection-type
   - phy-handle
   - hisilicon,phy-reset-delays-us
 
@@ -83,7 +83,7 @@ examples:
         resets = <&crg 0xec 0>, <&crg 0xec 3>;
         reset-names = "mac", "phy";
         mac-address = [00 00 00 00 00 00];
-        phy-mode = "mii";
+        phy-connection-type = "mii";
         phy-handle = <&fephy>;
         hisilicon,phy-reset-delays-us = <10000 20000 20000>;
     };

-- 
2.43.0


