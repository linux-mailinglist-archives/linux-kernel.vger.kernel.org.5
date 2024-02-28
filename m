Return-Path: <linux-kernel+bounces-84724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 598DB86AABF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE451C257BD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD4037155;
	Wed, 28 Feb 2024 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a39FbhhC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7B02DF9D;
	Wed, 28 Feb 2024 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110947; cv=none; b=nFjhR+wxdMoZhXK+CVrz0lSn1fYR9ihYF/RcDprLXcoNgfiVPdKAXh3T02SengoycLVFeBDlUbWOsQ+nvF50n93BZEBZskW4N6e6c5ySBtJjV4jfItoOnxF8GTdbyQCxdtGSybWoh+oWPYtZsLYPHkNS89U3BVOzA5V1AF+mbNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110947; c=relaxed/simple;
	bh=tOs31KYTqoxrPKz/Y05lViH2DSx10Kk1ejHawTz0Dtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kA2l+/8ICXIoKYykx1OlR1K24PKStjkh+UI34CXsCptjA8oG033Iibl5N/1sbYMPfqfdOmzYDA17EGHQhkeX74W3ViGyiVgRmfycLgi4ZpPikNspHMHe3MlyaNry+Ybyb2CbqrL4+J1nQi/hqSIK38MtXny3wWY4ZQYPEpj7Uoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a39FbhhC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E08C8C4167D;
	Wed, 28 Feb 2024 09:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709110946;
	bh=tOs31KYTqoxrPKz/Y05lViH2DSx10Kk1ejHawTz0Dtk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=a39FbhhCU3m6ABccgExQ2FPaKnG/4JoDw7vn0E6zJK85qhFTZGu8wIHiCPS4jjNhF
	 8WYVQBysghItmUtaFb2tCIVpQhCWohuweNlMt7LKqSpKE5xAvUUdAhLyFvruOvsDbE
	 D90y3rp9ZAhV4Jb8tbcpIZDGq/o5wMjZ+bNpG+R9EhUD00LG25wWGinUGoOAUr5aDf
	 oSAMAQmQao36I1N8rB44ZRkyYdvWMt3K+g/lmyNH3A+OQ8cKop4STD/P2GOONfcICp
	 s0QtTEQD2fqwABg6eTojSioeeJLpSgQaMdB2wKeiu3PcGQ8ZB0qiIA2dbxXZw38G/K
	 ZofJCT5rm0Txw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE782C54E41;
	Wed, 28 Feb 2024 09:02:26 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Wed, 28 Feb 2024 17:02:30 +0800
Subject: [PATCH net-next v6 06/11] dt-bindings: net: hisi-femac: add
 missing clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-net-v6-6-6d78d3d598c1@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709110945; l=1390;
 i=forbidden405@outlook.com; s=20240228; h=from:subject:message-id;
 bh=SAqU1dlvXmk1RmH1J0egzZj4SE6kA1y4eeXVDLyRO28=;
 b=MGeGh9vcJucfrOUy4UwkspwQpi6g+ejOsZjXYNkCGbkGxi9GrfpIG3GLwKNpiugvRIWqvDzaP
 POnOPWZIkENBl/NuvWCi2MNDZF/rqcDOSrXw5JMfyzs/kW8gyXs7teC
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=KAWv6ZzFsT54MGllOczJgFiWB+DuayEmyn24iiVVThU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20240228 with auth_id=136
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

A few clocks are missing in old binding file. Add them to match the real
hardware.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../devicetree/bindings/net/hisilicon,hisi-femac.yaml         | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
index be8e34b48243..ba207f2c9ae4 100644
--- a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
+++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
@@ -30,6 +30,14 @@ properties:
   clocks:
     items:
       - description: MAC main clock
+      - description: MAC bus interface clock
+      - description: PHY clock
+
+  clock-names:
+    items:
+      - const: mac
+      - const: macif
+      - const: phy
 
   resets:
     items:
@@ -70,7 +78,8 @@ examples:
         compatible = "hisilicon,hi3516cv300-femac", "hisilicon,hisi-femac";
         reg = <0x10090000 0x1000>, <0x10091300 0x200>;
         interrupts = <12>;
-        clocks = <&clk_femac>;
+        clocks = <&clk_femac>, <&clk_femacif>, <&clk_fephy>;
+        clock-names = "mac", "macif", "phy";
         resets = <&crg 0xec 0>, <&crg 0xec 3>;
         reset-names = "mac", "phy";
         mac-address = [00 00 00 00 00 00];

-- 
2.43.0


