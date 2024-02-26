Return-Path: <linux-kernel+bounces-81221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D83867231
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71241F2CCD1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A466D52F9F;
	Mon, 26 Feb 2024 10:50:12 +0000 (UTC)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B4C52F92
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944612; cv=none; b=FMsFJnRMcgHkCp9jyizimUc2h7pz2m58ExS5F4V/vs3L2vF66zZKWu3hHt7rg5mjCXMt2N3dz5dRUkhzKO9+I3PBbr+yf5kVcUjiM3oRcyJgh2YiqSNRtikVcXNQxNXuM/loYxjp+dPaSP4xpbjjjDuMHJ2CTnjhjIkcR44KFMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944612; c=relaxed/simple;
	bh=w0lev0IdkK1jVnrZx1US92KahJ3Kf93B4idY6xvnCd4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JsFGtKL80Cg1ZVDhUK070UrrcZjhvXg5YN1naBtWVG1cFv0BFVQb6/Fi5AmrGgxxrN3K9XVWAvZmH2eJfaOQziy1uqbnceHyU6aAw5ctS8DUc8rM4D9zFv9/0LitvDAYosgTYdQvNFg1pwSfM94LGzUYabBI29qo+gdBwfUTuJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:7662:e968:947d:f3d0])
	by baptiste.telenet-ops.be with bizsmtp
	id rmq42B0085Kh3Z501mq4Kk; Mon, 26 Feb 2024 11:50:04 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1reYYU-001lUO-MP;
	Mon, 26 Feb 2024 11:50:04 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1reYYe-003pvR-61;
	Mon, 26 Feb 2024 11:50:04 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Support Opensource <support.opensource@diasemi.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Steve Twiss <stwiss.opensource@diasemi.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2] dt-bindings: mfd: dlg,da9063: Make #interrupt-cells required
Date: Mon, 26 Feb 2024 11:50:02 +0100
Message-Id: <f512045738d2102c771a171a514ed7cf612c6d6f.1708944455.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'#interrupt-cells' is a required provided for interrupt providers,
hence make it required.

While at it, move '#interrupt-cells' in the example to match common sort
order.

Fixes: 361104b05684 ("dt-bindings: mfd: Convert da9063 to yaml")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
v2:
  - Add Fixes, Reviewed-by,
  - Rebase on top of commit f1eb64bf6d4bef52 ("dt-bindings: mfd:
    dlg,da9063: Convert da9062 to json-schema") in mfd/for-mfd-next.
---
 Documentation/devicetree/bindings/mfd/dlg,da9063.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml b/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
index da741c9994456ad9..51612dc22748fcbf 100644
--- a/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
+++ b/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
@@ -112,6 +112,7 @@ allOf:
       required:
         - interrupts
         - interrupt-controller
+        - '#interrupt-cells'
 
   - if:
       properties:
@@ -162,10 +163,10 @@ examples:
       pmic@58 {
         compatible = "dlg,da9063";
         reg = <0x58>;
-        #interrupt-cells = <2>;
         interrupt-parent = <&gpio6>;
         interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
         interrupt-controller;
+        #interrupt-cells = <2>;
 
         rtc {
           compatible = "dlg,da9063-rtc";
-- 
2.34.1


