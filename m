Return-Path: <linux-kernel+bounces-97881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4487C877127
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 13:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1614B20F7D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 12:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D5347F72;
	Sat,  9 Mar 2024 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7EWOsf5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A40F3B1B2;
	Sat,  9 Mar 2024 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709987185; cv=none; b=hzod2C8/j94/aDWbIurruG8pEsXqrlAQ80QrlSSxC4Gydfgm/yB3EtJOEj+/4VmI8DT55c+UnTUlkrt4LtCQrKjRyAHf5NhuUcNO+a8Rehfu9MorodHeaB4EJWabAhDH5sWLmxmSOYMNk0hXF71/RgRW+mnelV1DbefOhCwoXes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709987185; c=relaxed/simple;
	bh=oBChcKDw+6U+UAr+/pADMmiV+fMrY7ICx+nCf9RkwKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LjphhoXanWhf5cNY70qHEqhsE1ak/kfzHJcrxNThYmf+AHpxPYHc9diqn8i58bEaiOd2ujsT3ooQajC3T1cNT2bFSLT3yZ8kbP1nW0ms0xEshDz84eLywnUxLCEyHdmUnEXZjCvI3Eqez8Y+Ughh5nliCR59b5gYvVk+Ukbe2HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7EWOsf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E09CC43143;
	Sat,  9 Mar 2024 12:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709987184;
	bh=oBChcKDw+6U+UAr+/pADMmiV+fMrY7ICx+nCf9RkwKs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=I7EWOsf5RGzBAEwkO9wBeBa8pJpzFvW3EXM+8AYqjCd3TzR3IhPCP01LOCM9pP78i
	 bQmRAcyV2txXqxkfm71HiRDktTXCDVYi9IR+8Vc4dwGByUodfTUZoTVvkw4QdVFh/n
	 iuUnUeSGLOepCddYePMPzZB1sKjl/Lhy4qnsv+2WYPOfzMyTdLGVLo9W3f5zsRC6Ip
	 DLAPhMgyR95pf9U/SMMjE4a9KJGMVfSVU6rFhLH8/YwwdXvwLKg1dvH83oaMzpNbHX
	 knfalzAh+QHuibtmlIwNIz8dfgqPQ+yb2zli7dkyPFgiOd0J+vvCVXo0LuiqIbabQ9
	 eoVs6+o+sp+dg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D27C54E60;
	Sat,  9 Mar 2024 12:26:24 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 09 Mar 2024 20:26:28 +0800
Subject: [PATCH net-next v11 6/9] dt-bindings: net: hisi-femac: add binding
 for Hi3798MV200 FEMAC core
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240309-net-v11-6-eb99b76e4a21@outlook.com>
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
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709987182; l=1084;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=hXp0Z2gvwz2pQUJk1rM9MLAwqqkrhWdCoaJN9CeMwpY=;
 b=cACK4WVwd77tA+6JbzmRELGdMLxFXzx69Kv8fUPuW1iOEasbq89YHN7hxCsq1yFIYWoOXnmG5
 mwBVTCLp1mADW3bfa1Pt/lokq6/OQfJEeGdiIHHsLKWEA3kWY4nKPzR
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

HiSilicon FEMAC core is also found on Hi3798MV200 SoC. Document it in
binding. While at it, make "hisilicon,hi3516cv200-femac" as the fallback
compatible.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
index 5cd2331668bc..cee10d263d0b 100644
--- a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
+++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
@@ -14,8 +14,12 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - hisilicon,hi3516cv300-femac
+    oneOf:
+      - items:
+          - enum:
+              - hisilicon,hi3798mv200-femac
+          - const: hisilicon,hi3516cv300-femac
+      - const: hisilicon,hi3516cv300-femac
 
   reg:
     items:

-- 
2.43.0


