Return-Path: <linux-kernel+bounces-95427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79061874D8B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34ABB281414
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9AD12AAD0;
	Thu,  7 Mar 2024 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5PQQ5AB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDB51292CD;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811289; cv=none; b=rcDo3Rd7R1otyLbEBI4q1fUZYOO+uoX36mAQw+Ei1tS1a9g7Ykju4SXBg632I4UzBOZoAu29G58WqNxQjNZOCJ8dPPMW1xJveq4GzEV6HhsVGhLFV4tiSPjBMsAM/Yc1v+ozg4JNh+qUItt++bhT8aRXRkZCLr6bsNzJXogjLYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811289; c=relaxed/simple;
	bh=7PtIg95ncCvxMHh4b5Xw5GAtbDAZ3d89g3e/YJ0Tj88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MHmpQs7iOVTHO5IWQcBdnaaPpNy2RtyviJwjcS5w9AWDvp11JM3DGO5kwTVUqmbrVCwthDdUIGszo66tZm2m5SQoKF9SxWcKgek08TMRQzJna+KZg7rNnozSrFclSxroh5x7gDJ+jCniaSJWaLzp0G5ckQd62fUrqNisW0iqHP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5PQQ5AB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BF1AC43394;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709811289;
	bh=7PtIg95ncCvxMHh4b5Xw5GAtbDAZ3d89g3e/YJ0Tj88=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=L5PQQ5ABa3fL4wCuqpgYkYK/MG3bteD5QslRrPuIjy008S4e8lWNdhOU16XAAvflI
	 sH5VY+52a3OmUQipp4gLnyIgWDL17/HiLzsTQ7vDp6egY+vyeyAJIkkLDUx1B4RA6D
	 90j0prculieNJNoMcHMuP1vyasYsQD/ycXxrCR+q3mPnjyxja16kJi7zxQ9LHKEuPX
	 PuHfD9z6UjczscU6HpaoJ+zoAd5DsNS5F0DPrD9u2aqb3+gMyid9ph9T8tOGOxx+n+
	 W2lUt/D1XY/Jr0CbewFlIW9ajHDUp6ff8dwg3kUF6qP53xIdURxV3VUI3aPaht/1Uz
	 sRjTGtYpmtU6Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42587C48BF6;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 07 Mar 2024 19:34:48 +0800
Subject: [PATCH net-next v9 2/9] dt-bindings: net:
 hisilicon,hisi-femac-mdio: remove clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-net-v9-2-6e0cf3e6584d@outlook.com>
References: <20240307-net-v9-0-6e0cf3e6584d@outlook.com>
In-Reply-To: <20240307-net-v9-0-6e0cf3e6584d@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709811287; l=1118;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=zFRj07D287wM/dCKue4SsEqnuuC7qPQ9ydZbNJ2lxsQ=;
 b=+iZ7saWYkk7PHCMwIj2k9K+iHDcqAgrSFLzPLIoK9KP6YQE8VRjNQxWs7huG3CKRWC1LKU24F
 8+EQScfMDYNCHlqh1adhv0N4r4dlbZsIZ6EZMMDoyeyfzbEZsXkrVnc
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

This integrated MDIO bus does not have a dedicated clock. Remove it. The
old binding is wrong.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 Documentation/devicetree/bindings/net/hisilicon,hisi-femac-mdio.yaml | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac-mdio.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac-mdio.yaml
index 36def9d5eecd..dea1bcc27381 100644
--- a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac-mdio.yaml
@@ -19,13 +19,9 @@ properties:
   reg:
     maxItems: 1
 
-  clocks:
-    maxItems: 1
-
 required:
   - compatible
   - reg
-  - clocks
 
 unevaluatedProperties: false
 
@@ -34,7 +30,6 @@ examples:
     mdio@10091100 {
         compatible = "hisilicon,hisi-femac-mdio";
         reg = <0x10091100 0x20>;
-        clocks = <&clk_mdio>;
         #address-cells = <1>;
         #size-cells = <0>;
 

-- 
2.43.0


