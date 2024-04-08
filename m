Return-Path: <linux-kernel+bounces-134993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B7D89B9B4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1AF28226C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F4D2C859;
	Mon,  8 Apr 2024 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cz6kskoC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E50B25777;
	Mon,  8 Apr 2024 08:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712563715; cv=none; b=YeVGxD0pOOagiu5Uj7mGYjQQLZMoPRvAgTveV/HPCE4btDj5Nb0uQnOQ6M12yPZlWV4jTVQNt60KlUDcFZXEBru/GTLRkRTxFCm2iQDdtfIDmDPbRr4vBDVDrM8/Zn9ITPislptAtUjeBvo2hRh2agmBkdaC0KHKCpXnUQRT1fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712563715; c=relaxed/simple;
	bh=Uov0ir20j4odI6p1u5vs5WTkiCa18dZ4q6slRFfyyN4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yoq3rKYMjVMtkVY6emnqF4uSHbqly9hgFTtwaWUr5V6lIKQoQR5T/Kqdf+xcpwGX0+P2xnEkxFoTs1/UCnwiiUEkt7ZWRa8DHcJmo9TZQVXnTGAKlwpbW/8o8jG9TKVypTgmb7T8k+aC7ocykZ04uyD/fIwf7fcgZmPurGQAFEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cz6kskoC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59450C433F1;
	Mon,  8 Apr 2024 08:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712563714;
	bh=Uov0ir20j4odI6p1u5vs5WTkiCa18dZ4q6slRFfyyN4=;
	h=From:To:Cc:Subject:Date:From;
	b=cz6kskoCau8Xii27F8rmNEguEqAR4XvL9X1pTR3Lhks/B8DJfWFrhL2GIAsBOu3d9
	 wOxiTxLur5Ark1m6GlHDEjdIWmITefAYaKEmYyLmJwMriqN7Y0wZ2RWMTn9q7az/VX
	 5MZhX6OiT/nXSznfvox1EnKe/hSFZo7SpNvFz3a6zI/Yj3M8xPS0mfU94+3l/yHjFH
	 7jPr8t4p4gpnSAYU5Ecce0O3rClD31iOStkZHlvdqvTFsEMngV7Qpc0KkcYu2FIhoj
	 aq/fI1hY60R9x7235AJMfM0a4RPaGzbuu3LyMi8DnL/R6pQ8sk/oYzZu97iVT3Y1ad
	 o9b8x/4SUHHkg==
From: Michael Walle <mwalle@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Sean Wang <sean.wang@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/2] dt-bindings: arm64: mediatek: add Kontron 3.5"-SBC-i1200
Date: Mon,  8 Apr 2024 10:08:15 +0200
Message-Id: <20240408080816.4134370-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the compatible string for the Kontron 3.5"-SBC-i1200 single board
computer.

Signed-off-by: Michael Walle <mwalle@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
v4:
 - rebase to latest next

v3:
 - drop description and add to mt8395 existing entry

v2:
 - convert enum to const as there is only one specific board
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index d986b160fed1..72be45853fe0 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -359,6 +359,7 @@ properties:
           - const: mediatek,mt8188
       - items:
           - enum:
+              - kontron,3-5-sbc-i1200
               - mediatek,mt8395-evk
               - radxa,nio-12l
           - const: mediatek,mt8395
-- 
2.39.2


