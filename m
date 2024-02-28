Return-Path: <linux-kernel+bounces-84723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51BC86AAC1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F161C2628E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3446E37165;
	Wed, 28 Feb 2024 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kedKpLZz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B76815C8;
	Wed, 28 Feb 2024 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110947; cv=none; b=JXM8pQtj4oYVCHdmuy16p+X9zTOGegyHp0SKJ7aui6GqsQ1itsdcdestWEf1xYv2cTMbDAaf/EbCvoPMsjd8KJ3WUIArnqH1gnGUiXa1+j5IIz+ZXvrrN2RsLuPeTcRBSk4ZoK2vyF2QA8Z5DI/98Igi6zY0Nyop385pAN0KsRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110947; c=relaxed/simple;
	bh=PVTUps5QghY5pZZb1/WBlgZZuf3lpAztu7mSutrIHP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fedd/eWUPNr0u7aX1yTK4E0rSOdfigvIBzDJRJWFT3MayMvfNNCifQ8oUrPO5d9wQ1o+Q2ASaD2jLkLqelRXr4eQp8JsdLjWZX+8pzgOXj4bkKt18oqStYrLPTWO4vOR7CETchdkjhnUaIYaDY/EHPckeAUIslqQNfZWSBa96AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kedKpLZz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8A62C41674;
	Wed, 28 Feb 2024 09:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709110946;
	bh=PVTUps5QghY5pZZb1/WBlgZZuf3lpAztu7mSutrIHP8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kedKpLZzMGAWyL25bEKf22W5entPmsZl1g+ESOpLK7woVk1o9m/5vTZjP+Rac6pg8
	 46yy4HqGJdkiTmwy5HOUqu9NYm+Grmyq0uS/gRpV/x6gFc2qSp1VWub5suLroxPmkL
	 yURMwwlvdbY/Q8Hv+smFF7s5D/8loH0pfRwKaBg618xZYdf5DeMGQr2PGrd8bus3wP
	 nxVbcdKm+Sa9KVMq+x9AuzSaGFtN297ZaJnXhbT7w/SYODnGEZJNZ5+eu+xWOSUnpN
	 G2Gl/5F6ngnzw8qU42MmAbU2i7g9F2FdV3w+HtBgDYVx/mSJrC4Kc6NG+WWu7w6QAF
	 k5+UU8r2zSlqw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F20C54E56;
	Wed, 28 Feb 2024 09:02:26 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Wed, 28 Feb 2024 17:02:29 +0800
Subject: [PATCH net-next v6 05/11] dt-bindings: net: hisi-femac: remove
 core specific versioning
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-net-v6-5-6d78d3d598c1@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709110945; l=1304;
 i=forbidden405@outlook.com; s=20240228; h=from:subject:message-id;
 bh=QaLk+lI8wjJQd0lZBh2cmavdezy+qKZvyIpwbApopOY=;
 b=l5U1wW1kB4lGB6SEiVqjtKkYCq6xwMOu/+uEl3FnZaD8SWhssPq8y+GR5HJB9WRVS9mUOBF3S
 hSoU8mLvtiMDm+eSIIVtjBnCUvFQjIfZ2P5Rd0igQM/4494n5xVi07M
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=KAWv6ZzFsT54MGllOczJgFiWB+DuayEmyn24iiVVThU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20240228 with auth_id=136
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

The version numbers are not documented publicly. The version also does
not change programming interface. Remove it until it's really needed.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
index 016e9e409a30..be8e34b48243 100644
--- a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
+++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
@@ -17,9 +17,7 @@ properties:
     items:
       - enum:
           - hisilicon,hi3516cv300-femac
-      - enum:
-          - hisilicon,hisi-femac-v1
-          - hisilicon,hisi-femac-v2
+      - const: hisilicon,hisi-femac
 
   reg:
     items:
@@ -69,7 +67,7 @@ unevaluatedProperties: false
 examples:
   - |
     ethernet@10090000 {
-        compatible = "hisilicon,hi3516cv300-femac", "hisilicon,hisi-femac-v2";
+        compatible = "hisilicon,hi3516cv300-femac", "hisilicon,hisi-femac";
         reg = <0x10090000 0x1000>, <0x10091300 0x200>;
         interrupts = <12>;
         clocks = <&clk_femac>;

-- 
2.43.0


