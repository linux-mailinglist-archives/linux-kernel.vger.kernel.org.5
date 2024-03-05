Return-Path: <linux-kernel+bounces-91552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FB787138A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B27F1284DC7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72CB18E29;
	Tue,  5 Mar 2024 02:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAwCX0T5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE1C1803A;
	Tue,  5 Mar 2024 02:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709605197; cv=none; b=OG29GNxxt3Kz/nB+ANxPpFmwYHEpUncG5nMykYSIB5SDrvSPFP5SV8SKsxdMvJ+YA2O0QV2vGKsP7RHdC3rtctc/3YuXBMklkQrARt28ViLojkaaKaNzJtt2ZpV9ZUE7xaWyK/J/i5Ug5tklVItlHzyM0zLMCTJnX/z9l4ulHvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709605197; c=relaxed/simple;
	bh=j2QxGDEhq99RHC8PPIr7+4POEgFQFJ0Y8qdfPyL6lA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ebOol546AWmoz7VDoJUQ3Ajv0YhnWgVCLOU1Jp8hF9PKoQbLitTXkIRqbIlG++Q4oaXmaNrOb8ifwvHxsYd2ZZ3zlf2XI1+paoEmYiulUgBAzv+Trnbe06xjIWHG6gBsd9LuEdmaPpH7UwFyM0CAXeC7Dx2Dng+aBybd0EI6+GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAwCX0T5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90637C43394;
	Tue,  5 Mar 2024 02:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709605196;
	bh=j2QxGDEhq99RHC8PPIr7+4POEgFQFJ0Y8qdfPyL6lA4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vAwCX0T5XC55C8KD+4b8Yd+cjS3vfJRmE/JSXBEK+Y579w6DsWnsEQ+SeLG7tyv0c
	 ummb7qt3utjLsbclCSpfdrK1ZMYCtxKHLH6J1W039wkMEIGkuNCbJb11tp+O6X6IEc
	 5TBmZGQadJPD7Ds1AG+dalB+FVJ+lWCeZ1uoj4S45emW9qSxpISoInobKnIXd1H9Y6
	 ySeWju+DOMvhNZ5okrxP1h1Mii2VarkHM2DSpzF3P57Om6kIJdNtLQ994RFv/osKcl
	 QfWvtxvSMeDb3ErGe1RQJrxnq6tUmNHU51YYOrkzm1suZ4lprkL4nz2ke4ZR/BClTD
	 PdakwTHcD0J2w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CDAC54E4A;
	Tue,  5 Mar 2024 02:19:56 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 05 Mar 2024 10:19:48 +0800
Subject: [PATCH v4 3/5] dt-bindings: phy: hisilicon,inno-usb2-phy: add
 support for Hi3798MV100 INNO PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-inno-phy-v4-3-a03204c9cf1c@outlook.com>
References: <20240305-inno-phy-v4-0-a03204c9cf1c@outlook.com>
In-Reply-To: <20240305-inno-phy-v4-0-a03204c9cf1c@outlook.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jiancheng Xue <xuejiancheng@hisilicon.com>, 
 Shawn Guo <shawn.guo@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, 
 David Yang <mmyangfl@gmail.com>, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709605195; l=829;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=6dFyqSF2W3Rgkd9gq9kKKbV4XaRy0uRiH6eHrHgNDio=;
 b=rkQ0Luc5fivUDIuQxsUqDT1LMOA7aZ5/z3xiXyMpkOfiv2nAPIafLjZGeKrFJSTSJv06mOnDs
 dgIdv7UUNJ8A9eG0uKnq4B1shlgOHRQLUBJsDd5hc2Dg4YKUiqjTVmB
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Hi3798MV100 also has a similar INNO USB2 PHY with slightly different
register fields offsets. Document it in the binding.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
index ba82405ddf51..7f0811a2dc2b 100644
--- a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
@@ -14,6 +14,7 @@ properties:
     items:
       - enum:
           - hisilicon,hi3798cv200-usb2-phy
+          - hisilicon,hi3798mv100-usb2-phy
 
   reg:
     maxItems: 1

-- 
2.43.0


