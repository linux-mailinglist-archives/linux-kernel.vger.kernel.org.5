Return-Path: <linux-kernel+bounces-118662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F7E88BDD8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45E9B1C39C62
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC7B12BEAF;
	Tue, 26 Mar 2024 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DI6x/8Ku"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242A270CCC;
	Tue, 26 Mar 2024 09:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444843; cv=none; b=kNHhigJEpmF9YDfnpapcPyr5TAC3i6Px2Wn/81p3sQK0P9LzJaD9r7Is3XJuEwlDSXMLAxYQSosURyqGt/CwR24hkpeIiRDjIvjxxlL8Jrf7JSktTlvmF2rkWhraANs7gollJrJgRxBKafxu5ZZdVH57avsMpMtiqNnDFy9zSuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444843; c=relaxed/simple;
	bh=XRF+V2sXxESLFZ4PXmdnkTRjQnltJI55wSg9W1jq2SY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a24mydCttkCtlEIFaTwI1xjKLrlrHtZwcp3TUCJTXTYK13u0aup+ZBpQGIM2soCLNJMcQnxblK7tabwAlYa7d6GvQ2/AHHrkKRy5nSst1hDGgPRICJFI87SMZXobWd6rrwilJ6N/RZBvP4qpI0gph5kMvtxtqfTwA1gcDT8/nQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DI6x/8Ku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5513EC3279C;
	Tue, 26 Mar 2024 09:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711444842;
	bh=XRF+V2sXxESLFZ4PXmdnkTRjQnltJI55wSg9W1jq2SY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DI6x/8KuH/X2+TIrnXO8Vaa6RIJg51ALvSLAGrmy4JopdfrgLRgmRQHFokiVslbot
	 Ttqyadzl3FZRl4AhxCuuGzSeE8pixAA5km9xVFIcMQXUMNLlxjcVp8HLhCz4tIY7r/
	 +/QrTbGfKtlvsN5fRruntj2MfpY2m2AIz8TAQZsSA+lQDXtOs9lEnl6Vhy2gwj95Pv
	 /SRwz99/pfD7YcxcI1cxsqXbCQMe7QTFNBwctAhT4HkyRo3UsqnEHG+9zVcIkHA22z
	 IPv6raariZgp8gxEhsZTBnH5L4RM3p+X/A5DH1k4bzw6Fh5oaI5L1kRCECdEeU/3z3
	 N1Uwkz8K2GiYw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF2EC6FD1F;
	Tue, 26 Mar 2024 09:20:42 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Tue, 26 Mar 2024 12:18:53 +0300
Subject: [PATCH v9 26/38] ASoC: dt-bindings: ep93xx: Document DMA support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-ep93xx-v9-26-156e2ae5dfc8@maquefel.me>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
In-Reply-To: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
To: Hartley Sweeten <hsweeten@visionengravers.com>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711444837; l=1224;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=wr/vd6cvCnFly70ysS4iWWMOpIK2XGwrRTm9djXX73Y=;
 b=35nAtHKSIyXhAjZHJ1AXo0ZYorIyX5+nybIko4GMPqAAd3tJK6LRd1+lt9FlFASfZeMqvTXJtS3D
 u0zStc85D+yOnh6aSPA07+71utTpXSQXa2LJInfftO6QfzmFUItP
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

Document DMA support in binding document.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 .../devicetree/bindings/sound/cirrus,ep9301-i2s.yaml         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml b/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml
index 453d493c941f..36a320ddf534 100644
--- a/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml
@@ -40,6 +40,16 @@ properties:
       - const: sclk
       - const: lrclk
 
+  dmas:
+    items:
+      - description: out DMA channel
+      - description: in DMA channel
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
 required:
   - compatible
   - '#sound-dai-cells'
@@ -61,6 +71,8 @@ examples:
                  <&syscon 30>,
                  <&syscon 31>;
         clock-names = "mclk", "sclk", "lrclk";
+        dmas = <&dma0 0 1>, <&dma0 0 2>;
+        dma-names = "tx", "rx";
     };
 
 ...

-- 
2.41.0



