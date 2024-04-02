Return-Path: <linux-kernel+bounces-128160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B82895712
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF111C22720
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35B612BF3A;
	Tue,  2 Apr 2024 14:37:20 +0000 (UTC)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D6912BEB8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068640; cv=none; b=P77ybPnvwqCYlePj3s+Jx+WoFKYjZAPy4KwzdaIR7sFZzP1pn7xP7lU8V1UpiYDgidIRvO6mhPqnls/QmUO/TQFoYgmeMOsmdvsdhATwXy1lDnlttXdQ71rTZxpAO3o790Gs3wx7bMGcIdphI/SS/NW1Dm/F4j2T8Jv3nLnS2QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068640; c=relaxed/simple;
	bh=ytnKWlk1S847GyZ4lTZMzBXbPey057/EwDu5KNxyeHo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SLwKuwjmNJw7qp9Q4DdO9/TTJvmxz4faCX89PQMuDutH3tFXACWAXH43v/Nx4Kp0NdB+UgMuYmjNiDF9ZkPIevUYsedlRF5B2tfpJ+jagtxz6nKPVTTgaJKshK8YY0fTtwB57SVI6+M+edcZtD2m11tF6JMD0zxtEgTVs33SEJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by xavier.telenet-ops.be with bizsmtp
	id 6Ed92C00d0SSLxL01Ed9Gw; Tue, 02 Apr 2024 16:37:10 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rrfFi-00GBbX-Au;
	Tue, 02 Apr 2024 16:37:09 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rrfG9-009rRb-Jw;
	Tue, 02 Apr 2024 16:37:09 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: timer: renesas,tmu: Add R-Car V4M support
Date: Tue,  2 Apr 2024 16:37:02 +0200
Message-Id: <8a39386b1a33db6e83e852b3b365bc1adeb25242.1712068574.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for the Timer Unit (TMU) in the Renesas R-Car V4M
(R8A779H0) SoC.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/timer/renesas,tmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
index 50b5225ceb10b64c..75b0e7c70b62c89f 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
@@ -50,6 +50,7 @@ properties:
           - renesas,tmu-r8a779a0 # R-Car V3U
           - renesas,tmu-r8a779f0 # R-Car S4-8
           - renesas,tmu-r8a779g0 # R-Car V4H
+          - renesas,tmu-r8a779h0 # R-Car V4M
       - const: renesas,tmu
 
   reg:
-- 
2.34.1


