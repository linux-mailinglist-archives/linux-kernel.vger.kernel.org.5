Return-Path: <linux-kernel+bounces-80662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3762D866AFC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680D21C2150C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5D951C34;
	Mon, 26 Feb 2024 07:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnuV5s76"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6C91CD3C;
	Mon, 26 Feb 2024 07:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708932683; cv=none; b=paPciwR9uow8LkCEKCWhkG9pEjJsbz/2GDKJeS/1L2ETvepb/wfu0nP95cPf8NUAGoYGAfCCfTjJPPtTgIjYTrIDdgGUMkcxC96UmPtZCiGzn5Dko2XPKFzQdHYpmQcncREJAqX+M1N1BHWkb3j8C6JDT3imYuRzjaSM2fYTgv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708932683; c=relaxed/simple;
	bh=54Nt44uzjzCFnj+OxusuOrTsRFxaxwM69uLh7J3UaoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Klkv8qzi81hjOx0eNV2c1okpMS/vL0hi3k3NaZ2nvsWIbdB4R7aBsoQ3fkvFzPjUWVByoTz2rwN8sPJQR1TMowqvwatfYaP3w247Z3v+obSbgLfILQerldyt6t6JzT0Q7TQdbcXLOs42Khz69bUlnGHjyQ++Xvgc/nm+UeJt3Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnuV5s76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73D4EC4E68B;
	Mon, 26 Feb 2024 07:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708932683;
	bh=54Nt44uzjzCFnj+OxusuOrTsRFxaxwM69uLh7J3UaoM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dnuV5s76rYgbZin/DYKASEHrWl8gU3lOWT2bGBAUNBx8+xGqN8hktNb0wrgK36eF9
	 XpFcVe2kMfG+RrFyULSQxTgV0QOh1J5CgKwNGF8WaChXUkwv4KZBdA6IdnItitz4sA
	 mOoSvTeCm8DvCYO+Mt3UodMaBaVv0G+PluMfGSxkBYA4sOiNae/qdXhY/ONQhXsshK
	 FXJW59FrJIeax8kfoQsKZEl3KAfE3c3KlIuKXLgGXCiWQYHIAnh7H8BzqZaP+1/tRx
	 4VqtE9k1anb9BmHjMXRIjg4tKwLeOoq7Qdw8NTYxhfFaHOtptJLp2rb530Ze6LkNi/
	 7F7M4ZB14oh8Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C260C48BF6;
	Mon, 26 Feb 2024 07:31:23 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 26 Feb 2024 10:30:23 +0300
Subject: [PATCH v8 27/38] ASoC: dt-bindings: ep93xx: Document Audio Port
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-ep93xx-v8-27-3136dca7238f@maquefel.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708932678; l=848;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=0LgX6xJfVzU1kIBxobRUjsHWxEbHLzVzD6pHlBy8Ioo=; =?utf-8?q?b=3DU1lC2bs9+0/I?=
 =?utf-8?q?5vF/qIOo0do9Kh6YKmsipTUByix7465MEJvmXAMwpgEEp7WPRtu/7Ifk1cjXaENb?=
 QnzPBZurAiSmBeHyFWFzS7WvW3M5KO3JHXJKgrmfmDznCZWvDFaY
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

From: Nikita Shubin <nikita.shubin@maquefel.me>

Document Audio Graph Port support in binding document.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml b/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml
index 36a320ddf534..4693e85aed37 100644
--- a/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml
@@ -50,6 +50,10 @@ properties:
       - const: tx
       - const: rx
 
+  port:
+    $ref: audio-graph-port.yaml#
+    unevaluatedProperties: false
+
 required:
   - compatible
   - '#sound-dai-cells'

-- 
2.41.0


