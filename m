Return-Path: <linux-kernel+bounces-160642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811378B4085
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E7B28A1EF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53854208D6;
	Fri, 26 Apr 2024 19:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esDMTaJX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96954D2F5;
	Fri, 26 Apr 2024 19:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161257; cv=none; b=CyXJMrPdM638OYF1lXcqrh3gnFS/cnmVjHkfMFDRlbhvFhT2Z8TGyWgblDgryaMc4ZFWC4NrQWyPruKL6AvnLWTAM+MgeihM87ZRDWlPN+HO12B8RWMzDPr5pXKHEDJQTu/YcXLNqg736xaEyNlZHkbld6F2L9F227UlkSoXDKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161257; c=relaxed/simple;
	bh=QPeeDX2DDvQRA6ERB9qQ64tdJOF8dHgBuG6mRv3ZZ6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rORcU3joCts/sv/puFRVnhWMc2jRm3cGrjE/4gSAEAbhAN7PIFl7lS5k/BvYiefmX7z+9B/WagN1Y5ieaLD75N92BkOzznhhlDH+EnAbn1rPdhcEDE+x8fGjXLvIfpkFIAjhs+YGXw0+SjygViqxm/ozsCYPVcN6Dx3AgtyL67Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esDMTaJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF4EC113CD;
	Fri, 26 Apr 2024 19:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714161257;
	bh=QPeeDX2DDvQRA6ERB9qQ64tdJOF8dHgBuG6mRv3ZZ6Y=;
	h=From:To:Cc:Subject:Date:From;
	b=esDMTaJXY14cgL7iUr+SLGpgILhoQ9+wW3SXgu8lu0DhL5iayrLPGTGsjg0SEYWMe
	 YIrkuEqen1KoD0KOXsRE4gQC9a8k1WqTzqgmmgycY2ie2N8gxvHkhP9cFgmEdn1gnW
	 1uX69RNBmVHlzctPrNTUWwO56+4iHGKwo+MoL4iNy6qcO+4GHaYTzY22qbQDr7QN7b
	 NtJ3GX9Sw5jiTZbINQBlpeEvFwzUos6LXUSu19d7LCkx2dywVBokQNq4DX1fuD8LuI
	 76JTjNXaStT+HEspUHtNuhh8feRTEKTgOpqociyFhC6afGDmKYBCK++rNLda18GM3h
	 3eCP1mJz1MSZA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] dt-bindings: interrupt-controller: mediatek,mt6577-sysirq: Drop unnecessary quotes
Date: Fri, 26 Apr 2024 14:54:04 -0500
Message-ID: <20240426195404.2771046-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop unnecessary quotes which aren't needed in yaml. This is checked by
yamllint, but this case was excluded due to the comma and yamllint's
mishandling of some cases with commas. That's now fixed in yamllint
1.34.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/interrupt-controller/mediatek,mt6577-sysirq.yaml   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,mt6577-sysirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/mediatek,mt6577-sysirq.yaml
index e1a379c052e4..123d24b05556 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,mt6577-sysirq.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,mt6577-sysirq.yaml
@@ -48,7 +48,7 @@ properties:
   interrupt-controller: true
 
   "#interrupt-cells":
-    $ref: "arm,gic.yaml#/properties/#interrupt-cells"
+    $ref: arm,gic.yaml#/properties/#interrupt-cells
 
 required:
   - reg
-- 
2.43.0


