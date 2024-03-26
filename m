Return-Path: <linux-kernel+bounces-118665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FE888BDDF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C4D1F60D3F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6891B12C54A;
	Tue, 26 Mar 2024 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXK5Gjy9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC6071B24;
	Tue, 26 Mar 2024 09:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444843; cv=none; b=mHEcMWiVLVP+bhh6707XRqAkZdqegn6TR5fRI8qXrLkAk5wVWwk7H9DRy/RlVeYgV60y0acDk54hNfGjSiYfXzlB/ZkNJQn7YUxpIyw7UKmiMopGYrm2fu9O/86mp6AybW8slx1uG/hXjQyB4+vrRAH5tWjLa1But/5nAoax9A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444843; c=relaxed/simple;
	bh=54Nt44uzjzCFnj+OxusuOrTsRFxaxwM69uLh7J3UaoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EAovzHknu2kmJHCQ8bpJOA9oYTtguuxb9MbPnSF+PBtUFIKp3penTIwTuw5/XAC00cseKfTQzrpbccQM6LNk8FfWlxqIhCi/7VPunLXyvGmHMBuPydKkLjlSkOVo1MdmbN0bHYnV30iPskeS66lUk5O1xZXwRh2aZi10tzSH5Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXK5Gjy9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 749F0C4AF7F;
	Tue, 26 Mar 2024 09:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711444842;
	bh=54Nt44uzjzCFnj+OxusuOrTsRFxaxwM69uLh7J3UaoM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lXK5Gjy95XX6ZB/lfQdjdI3AYDYSMaVBH/xLHe9RF3jhwvkGGisvUYR4r3MzUGYMx
	 VC87hL7TUSJ9MmYl91qNndlQUnNpAjogDTjqMjWvJR9tL6MKsedYCZBOs9t7KxRDbm
	 g1jgQLxWJlEhlDL+o2ab7xkezS2brpUcg9XftIqixCCKYVio7PBHSBLJDbmyk3eDaR
	 5uEbrRot0AaG1S6wEdii0iChfYBWuML+CqmDxCJ3Wfh/X0WEFbA2UIXP8zB/+e0S44
	 fA4Z7jQYfbnvPVxjOJddqHnE2la/ggauyoUzAtd5wGUDhVTYJnNc3CWYzVDgcmWa8J
	 G6LGKefQ1fZgA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619F5CD11DF;
	Tue, 26 Mar 2024 09:20:42 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Tue, 26 Mar 2024 12:18:54 +0300
Subject: [PATCH v9 27/38] ASoC: dt-bindings: ep93xx: Document Audio Port
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-ep93xx-v9-27-156e2ae5dfc8@maquefel.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711444837; l=848;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=0LgX6xJfVzU1kIBxobRUjsHWxEbHLzVzD6pHlBy8Ioo=;
 b=5ztgZZ2oUwJ/hKQO7ZhZXKm61ndvsJiqGmWxqsoL+hJL7tAnhkO4iXwPXs7iJIii9fzX8fTzC/7o
 LAxe4JCQCiVEjB2UxnPUNpruQGl4JBL6kTchDOPfDR7uYnnwieSb
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

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



