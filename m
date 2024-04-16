Return-Path: <linux-kernel+bounces-147124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6DD8A6FC0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54771F21F5E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F27130AE5;
	Tue, 16 Apr 2024 15:27:42 +0000 (UTC)
Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [195.130.132.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA15130A4B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713281262; cv=none; b=C0c+a0h1WNv68G3RFnt8Ij6pRjHK9ooK9X3cCgA6FWJAjjcKggRHEfWil9oNXxtz+ktvs6FdnezQLpDPxx0X+z+ueHgoc15UDl8W8zj6Tx6fU7/iE8ofCoxANnHHN0ZL97f95ZUItJVsL/tl0bdc/EcP1cIAY6/Y+WGGXFr5hEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713281262; c=relaxed/simple;
	bh=lN/LCVnSKylBG/BB/y6k7eL7xUWQTh3n78CmxC/DCaM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PEzNoK7Wk0PjNc9RNgRu7jaOrb9mY16F22eEvqTLl5PZcYhUFRTvseFZ1lSWyslAany8V5RtrDdKh2iv348IcMcZNAL3QD7pIDvzPaW12VzsI2XmgVLmfanc9fqzJfuw0MXg6h4al9cxZDNdP1S4Npjzz6LYNY3fLRQNXSnjS5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
	by gauss.telenet-ops.be (Postfix) with ESMTPS id 4VJnkj2nyyz4x1PN
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:19:09 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by laurent.telenet-ops.be with bizsmtp
	id BrK12C0060SSLxL01rK1SS; Tue, 16 Apr 2024 17:19:01 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rwkZl-008FRp-MW;
	Tue, 16 Apr 2024 17:19:01 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rwkaL-00EbPG-2t;
	Tue, 16 Apr 2024 17:19:01 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: interrupt-controller: renesas,irqc: Add r8a779g0 support
Date: Tue, 16 Apr 2024 17:18:59 +0200
Message-Id: <264cffccfbb1f92657420f5f869236b06a97d958.1713280616.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for the Interrupt Controller for External Devices
(INT-EX) in the Renesas R-Car V4M (R8A779H0) SoC.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../devicetree/bindings/interrupt-controller/renesas,irqc.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
index b417341fc8ae049b..fb3c29e813499e3f 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
@@ -39,6 +39,7 @@ properties:
           - renesas,intc-ex-r8a779a0    # R-Car V3U
           - renesas,intc-ex-r8a779f0    # R-Car S4-8
           - renesas,intc-ex-r8a779g0    # R-Car V4H
+          - renesas,intc-ex-r8a779h0    # R-Car V4M
       - const: renesas,irqc
 
   '#interrupt-cells':
-- 
2.34.1


