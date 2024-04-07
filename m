Return-Path: <linux-kernel+bounces-134316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E67C89B040
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB2A0B214D1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86E9208B4;
	Sun,  7 Apr 2024 09:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="KQEUpfgY"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A4B182AF;
	Sun,  7 Apr 2024 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712483946; cv=none; b=PW5v0xWXR90mCFG82h7QTk1wflTK4DYY2FpuU4upq/vA6AP4GM6vWUDKzsOMQDsawTPjQ+EtOoQSrmPa8aKWtMHb3fzH1hz0Kjw45+XRTcdcQvWo+49eBYGTjQ6IfMKI5mpLooiih0u20zDj+pAn96+0GlmT1Wo67Ai9sgntE94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712483946; c=relaxed/simple;
	bh=kKqPHH9CWdZ0KGxL/eeHb0Oz8IalYGRD0PEPJpqHGV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kn9IjP2yRhMPeTCaqSfot1kZHJ3FfB93u50TJPNlTMZCG+23PChXWNRWEsW7LsJ+Wg+WVVcfjlAEmAbqi78cdhClD3aq/f4N32Zx230EQrViiW5G3zSdIUFfFoV1wV1r/0clkwJUv1faMtcxVabgk5CeHL0J3S3EgK/RDzsAWfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=KQEUpfgY; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1712483942; bh=kKqPHH9CWdZ0KGxL/eeHb0Oz8IalYGRD0PEPJpqHGV4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KQEUpfgYEHpEGN0LGUM5EW8or0q5XuDSuADxY577n5JZhkB42xXg97y/CVtDUAg3L
	 1iEj1+4jSGl897B9FGdpiJPnRWnzSe3o68Sy9HgE4hkn5dtmol0zXqk6DkdB8cDa5F
	 XqPlxIYMnjgT9ukdkWeOUuBTtneJB/dr/G3XbM0A=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sun, 07 Apr 2024 11:58:31 +0200
Subject: [PATCH 2/3] dt-bindings: remoteproc: qcom,sc7280-wpss-pil: Fix
 qcom,halt-regs definition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240407-qcom-halt-regs-fixup-v1-2-a0ea4e2c178e@z3ntu.xyz>
References: <20240407-qcom-halt-regs-fixup-v1-0-a0ea4e2c178e@z3ntu.xyz>
In-Reply-To: <20240407-qcom-halt-regs-fixup-v1-0-a0ea4e2c178e@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1189; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=kKqPHH9CWdZ0KGxL/eeHb0Oz8IalYGRD0PEPJpqHGV4=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBmEm5ji367zgZDB+N3cLeiBCtY97y7im0VY2te5
 aHOGBer/FqJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZhJuYwAKCRBy2EO4nU3X
 VqsoEACHyfcoiNajah3ZTwZ6X8X7uTXWjOYRH3QdGfZhtDfJIciqd3MTtMcDgu07UHcUzt4O/93
 ZmULqUgceEC/kDRch6sgUUTWupPSiuGSXsx4IfopObLj1xF2jyI0RE9qpRbReyN2gm/fNCnkMDa
 gdNByLCS6VS2QiDDp1W4bClU+03aj0UNvN2yK8PFJXY/nqFlFKURN7Ux78JSqwb+TVu4bl3ei3J
 EfAmX2T0iAL12VlkH8e+K8a62ZhMNKkOUIreMAwzMXh9RVDpzV+QqtRuBUFIkP6fV1NxL6mh8Ng
 QSZfujq88fiLomeh6oiciedJrPRDZ/dRN/YP/QxKMKFkuex79U0diM3xUvi+0AqBa1GoZd8wmEG
 W7hj5AdDH270TJ9KDsWnT+C4gM6xEr0MxOFpvWXoUfHW97gDuK5Fy9cyKdC6a3/fsnBbxo0nZGA
 /538J/iO1r6glGqse3q7cen9Kkbgl9M4CQEu+HZaAUz4/Mcc19o2wxs4DAdXCO2kPUjIPDxYd5W
 CYBozPjGQhpAIJWaYS5vo2uczhwsT35B3DFTefM9pSt9ju1AQKUgDa2y4EJjRNyg7dXQU7RkhuP
 ijwNbpyM9f1FIVa9DXSmFsQQlfhrfpkiovUqAROppP1kbknmwcdmR0ljsG5IIOB8Kx4Bq4j3Z8G
 n+iDnRYl0DuXhlw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Set the 'items' correctly for the qcom,halt-regs property and update the
description to match what it should be.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml        | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
index 9381c7022ff4..f4118b2da5f6 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
@@ -89,7 +89,11 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     description:
       Phandle reference to a syscon representing TCSR followed by the
-      three offsets within syscon for q6, modem and nc halt registers.
+      offset within syscon for q6 halt register.
+    items:
+      - items:
+          - description: phandle to TCSR syscon region
+          - description: offset to the Q6 halt register
 
   qcom,qmp:
     $ref: /schemas/types.yaml#/definitions/phandle

-- 
2.44.0


