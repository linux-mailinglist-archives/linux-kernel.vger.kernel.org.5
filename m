Return-Path: <linux-kernel+bounces-126588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B930893A13
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E0F1F22244
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1699C1754B;
	Mon,  1 Apr 2024 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fj0vx3l5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D3C12E6F;
	Mon,  1 Apr 2024 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711966255; cv=none; b=DjCd/XnCFNRNH7pdEXy6HoHmWJJ+A/tn5nmVNSWrE8I5m83vF/mzaRc2CZTIs7q5ubSTCX+9xt/517Uw08Hn5M9B//E9andae4+13pOP9gi0I3rCOmzmY7Jvz473TI3oLmXI8vZp5V/MCojvuWTKYtCyF/IWs+P8ujLj4Bk/+78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711966255; c=relaxed/simple;
	bh=Uf0CCksxzPh94RRVnornSAILdhxqXP3ccZAL4skjSzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pqKo3e2JgoqZSCixZPmAX29t1XSAs8H+2F4NTjcqsLAiLcDQY3RnfpEyiduR8j9xGcXzA1WMI/ZBA32prLbdEVkziKfPqfLU6Luuills7rw6XikjW6mT2UkCH81DzS5t5cYmiyooV/JFnKBi8KxWZNFQLVx0aQOEkUSGCa9bT48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fj0vx3l5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC397C43390;
	Mon,  1 Apr 2024 10:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711966254;
	bh=Uf0CCksxzPh94RRVnornSAILdhxqXP3ccZAL4skjSzw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Fj0vx3l55hEoN0L0IuLIPThi+nEdBV66UQAuhpJAyc5hitil8zfOmgiLEheoy06xD
	 /WCMi1Fz6v6DogktqAcbITcmwa0DEC+KGeiRTxgu+EDRhiH9mHGvjXY3dzGAE/+7Vk
	 D2pnq4y3fM0fmT4upKK3qqhWdT3tmgstuFHHs8K+yWnnYS9vxBuUId3M05WRP8ClaZ
	 Bx5ykOwnc6IKCAkpiIgTpV9AgUBzdZS6dHfIcafuX0tVig8E9RnRgOMjtU5Bh1BfIJ
	 PxGAs6LYBmaErjyDPS7iyj3GpoyooO3n6C3UV6+Pu4sHs2R4rPx7X7sF8X1cM5kavf
	 JWJdx+ibLUI+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5BDCD1293;
	Mon,  1 Apr 2024 10:10:54 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Mon, 01 Apr 2024 18:10:50 +0800
Subject: [PATCH v3 2/5] dt-bindings: arm: amlogic: add A5 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-basic_dt-v3-2-cb29ae1c16da@amlogic.com>
References: <20240401-basic_dt-v3-0-cb29ae1c16da@amlogic.com>
In-Reply-To: <20240401-basic_dt-v3-0-cb29ae1c16da@amlogic.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-serial@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711966253; l=1029;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=r0xuqU4Ugjg7+rGvC23MyKK1+DvdlUD+RiCVMa++e2I=;
 b=7CcfDk6SyPhN7yKoit06AClCEA1AdIZ1Mg4Dx6H2q6MBebQbh5EvLxkgyXYkY5SdZgrLnyI1N
 +DVVa8nxlFbBKbVSctEP73cwf8sHtwbsQWb4MI7juozuWOkrR+sR/gJ
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Document the new A5 SoC/board device tree bindings.

Amlogic A5 is an application processor designed for smart audio
and IoT applications.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 520975e7cac0..e64ced44ece8 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -207,6 +207,12 @@ properties:
               - amlogic,ba400
           - const: amlogic,a4
 
+      - description: Boards with the Amlogic A5 A113X2 SoC
+        items:
+          - enum:
+              - amlogic,av400
+          - const: amlogic,a5
+
       - description: Boards with the Amlogic C3 C302X/C308L SoC
         items:
           - enum:

-- 
2.37.1



