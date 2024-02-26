Return-Path: <linux-kernel+bounces-80660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B84D866AFD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06BD1F21F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C330D51C40;
	Mon, 26 Feb 2024 07:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuPVvjMD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F411CD35;
	Mon, 26 Feb 2024 07:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708932683; cv=none; b=BmlW/aQYmYnWMYUovlYoj3EekOVDxgPvxRfxxboZzraMhPE++zJuPPDvhLKLvNbQ/soQCyBAL2ZIk1qzgV4alIvcZG4fe+DcHyOUKS5t8IZMcsObnJ8U5tRSpRX09WPG5PsPr9Ldl4frAmFrcjMv8KIZB1bgdUBtmvxXMdfsAMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708932683; c=relaxed/simple;
	bh=XRF+V2sXxESLFZ4PXmdnkTRjQnltJI55wSg9W1jq2SY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=beUa8HYN/S23y1UJe/lZIuvcRziEXjRPm5MAPOJGrJ9P5GYO/UpzCv3lyCUsJI/BBnp1MZlu97kRPUy4gssM2iZrYV26q//ncmsKJPoyXqPfE1FMfCBiPBMH7bhAzSD0Ddst31EpNOyn3r5t8AokFe6V04hWyJVRSJgVVNGpDO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuPVvjMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6247BC41606;
	Mon, 26 Feb 2024 07:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708932683;
	bh=XRF+V2sXxESLFZ4PXmdnkTRjQnltJI55wSg9W1jq2SY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FuPVvjMDohTB50avbyfqdJ5oKEpHT43BZFBdaUcQzTLEtO4p3xGhmwMW+fMnkQwMr
	 xvQnI/BQ41vllikKttDwiRL2VlJVqrWwsn5Xp0FBMPBrPosSdHo3rO39DWtW5lXPma
	 36XgEYzQdSc+e9VwScak/TVPs3UJbA8ESCpvvDYrCP8nPH72JdetOkdrJo+++QEPrB
	 n9tc6gvDTejUMBqaQvaGNtG2IhpWvN9A+2hwW3zO90qiVSv0pxLf9A839YsIui3Xd1
	 OJnccouK3rsHlAQ0WXW0Y+BhxwczzIPDGuqSzBCq8CFDzPdUdjBWU+I192lvMHp5EH
	 J9bKnj+bEo5xA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBA4C54E52;
	Mon, 26 Feb 2024 07:31:23 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 26 Feb 2024 10:30:22 +0300
Subject: [PATCH v8 26/38] ASoC: dt-bindings: ep93xx: Document DMA support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-ep93xx-v8-26-3136dca7238f@maquefel.me>
References: <20240226-ep93xx-v8-0-3136dca7238f@maquefel.me>
In-Reply-To: <20240226-ep93xx-v8-0-3136dca7238f@maquefel.me>
To: Hartley Sweeten <hsweeten@visionengravers.com>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708932678; l=1224;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=wr/vd6cvCnFly70ysS4iWWMOpIK2XGwrRTm9djXX73Y=; =?utf-8?q?b=3DQ5glPHoBBy//?=
 =?utf-8?q?ZwGJrHweue3vaqootESNOHE6NDfA1BjcfAdOJmJugL3+MPrMFKDx8L42dZe61Zaf?=
 gh9r8LbWDNNTpSGo+y2SDnXX419cm058Am3/dZvjZ/EEwCZd6tE3
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

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


