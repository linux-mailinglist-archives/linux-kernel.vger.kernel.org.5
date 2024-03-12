Return-Path: <linux-kernel+bounces-100011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61068790BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66ABEB2332D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EF679B77;
	Tue, 12 Mar 2024 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zl8o0Wct"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BCA77F3C;
	Tue, 12 Mar 2024 09:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235141; cv=none; b=QfBtXPqk9ogGqtrJfcR52c+cKitlykWE5hpoyLNmSYIujllWEzxVtyCVbX8pPvM02l9m5EHAHMZKIrGlNpT6Tedtjb9IbNbg3SRX1YPbTji/4GHkYRJc9uqw9TZi6ImENVOsQQh6dv/ixE3p0KEC/8fuSuvAvI02zZOthRJSK4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235141; c=relaxed/simple;
	bh=GY1Y3YgslgI5nfRHL9M2c1UwLc2CcvyuUQy+xFniYMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L72R2dMR+OOKpfdaLll+3nGMsgV8lF4EYb7z2i6H0tHlouNkhJSeBTOym9NOKnYo0/HiMk+blJJlmMge9A7diBtZmjEeQEOI+hCn7Ui7jyAF7jDSXIjbSZfJVPihtDXQk3kPssK90qIAmGGVXKlQe1WS/GVxjd68kr15n8g91r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zl8o0Wct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2FD5C433C7;
	Tue, 12 Mar 2024 09:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710235140;
	bh=GY1Y3YgslgI5nfRHL9M2c1UwLc2CcvyuUQy+xFniYMY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Zl8o0WctTI41LRkGlWN2Yims8ZWoHOizQZIP8JQtDLArypYakxc9Ze/wE02ZIA/NA
	 H2PRsZONK6+ZCvRXy4IOHW7l/NsoPNIbTlSCp77DGnMAm7EuwgChpPQnkyTAgX/4Zl
	 9VXvCqTAdR9YCNtUZK9LHKmiEj4MIacGlUsaQXOxvny7deycNYjHnbi2tljR57fcOt
	 Ukr2g2UJ5sNOyd4xh+B51zL0WnKvd3meLpG2s/2QGlR6vBkDFwvzwgWakBrRny8auT
	 Ly5/sFaJpIKnv3TlGcd1fUprOU3U63wiEyW7SeTDhSMAKHzFwsMxPT7I2resg6ATBd
	 GZiTfSKKfnl9Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D28EC54E67;
	Tue, 12 Mar 2024 09:19:00 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Tue, 12 Mar 2024 17:18:57 +0800
Subject: [PATCH 1/4] dt-bindings: arm: amlogic: add A4 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240312-basic_dt-v1-1-7f11df3a0896@amlogic.com>
References: <20240312-basic_dt-v1-0-7f11df3a0896@amlogic.com>
In-Reply-To: <20240312-basic_dt-v1-0-7f11df3a0896@amlogic.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710235139; l=1031;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=7CB3caeULILonhq2akOBlXwuATMVWXMmUGpiqCh9RIo=;
 b=dp75MXR6HO7WQiTAAb/cIulbes0mAbyUf01Ax8fSgIxPPQeaaCRltOJb7yIkRUSzWLltdnK8W
 wvZEfuMIwJFDfCeKSjWlC5YD9dm6E1evNOW6Luv+0ymGX/47VIzEvhl
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received:
 by B4 Relay for xianwei.zhao@amlogic.com/20231208 with auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: <xianwei.zhao@amlogic.com>

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Document the new A4 SoC/board device tree bindings.

Amlogic A4 is an application processor designed for smart audio
and IoT applications.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 949537cea6be..9a135fe1c862 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -201,6 +201,14 @@ properties:
               - amlogic,ad402
           - const: amlogic,a1
 
+      - description: Boards with the Amlogic A4 A113L2 SoC
+        items:
+          - enum:
+              - amlogic,ba400
+              - amlogic,ba401
+              - amlogic,ba409
+          - const: amlogic,a4
+
       - description: Boards with the Amlogic C3 C302X/C308L SoC
         items:
           - enum:

-- 
2.37.1


