Return-Path: <linux-kernel+bounces-154015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7DF8AD622
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C3F283A01
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48481CAAD;
	Mon, 22 Apr 2024 20:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTFA9wPD"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002E71BC30;
	Mon, 22 Apr 2024 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713819076; cv=none; b=X8oPPywrtmPeVP8hZWY1f4zHXBtXBB47BVG52BJzLADxIjBkAEyS5LTeloSjswzmqwb2tucUumnvbl45BdkHVZphenwSWy5lbYsQ4esNMeuxWoOneQF8DqZVrqwDms5Eg9rC/MeOEzpbn7oMXxo+gAokIJDJ+Rtt19ALjM98zNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713819076; c=relaxed/simple;
	bh=N/b+/MDTqGaOVzb9YoM/ILL55RXJnEsAaMKANhtU+nU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oGFUuJIHJuPX9bpEPV+Q3ZunG9DI2MuveC9fYP0Y4lG6dTjjyXIwsnk4nsV7GWQQfat8iphg5aJ4m6qgrh6JGjDMIiex8wHUSDkoXJ5KWOQViqaZd92L+pSg0GImHoUhpP2khqfSazdU+YeMDCuLIJ8Q3a3NN7GrMv/iRNW22cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTFA9wPD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41a5b68ed4fso11328185e9.0;
        Mon, 22 Apr 2024 13:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713819072; x=1714423872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PIQCZqh6zWI6gztJg49TwF5fLu/Zw1pV2keZztwPFc=;
        b=gTFA9wPDC6ss5gWZLU/Oas6ReTA8VPOqDGPIMjZ/pcHhelGzflhtER/t94at2leCyh
         ALXIH2fDbQPkcAyIJZabnKjZfNzYu6aTGrjltfSMJkZNfCTRGJP+4J8pJXg0fhcCQiWE
         I7PwT8ouk9u/OT0VKa8Ky3TMVpRyIx2KQfgS/ey2IJ9C1fs//Ma6M4buT/hbc9M98UFp
         VKwjfvAgcoXPnct6qFbkBuBe5i3kmfSbz+oLrVcFhnGWR/YWaZUu2QvGxOI11M9pRyoG
         dMLgl9zXsN8HQWUQBwbKm4ey4vTcQRtTFzvVzEaAJIpw4B+co7/hHU+5yCoNSj8N9o/a
         3DAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713819072; x=1714423872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PIQCZqh6zWI6gztJg49TwF5fLu/Zw1pV2keZztwPFc=;
        b=Vx1VTiNgLP6tP8nHhdVJUetU4tTeVmVJAS6V3XFfodqZvuCkHsVOU364Ag9b4Vl9sz
         2DylycRdiVsThftT1DlH2Cwl2SVt4EK1kXeLfrSkndx7tr40fMOGE+w/hEkBFDdz237G
         mjuAM6QIn3KWKG5z2rG74uSUpd2uE0RlrcfwPRz4Bg5xZGHr4/HDdw5knmVCzgUy9rO4
         uPGpEAhJm0QbCPlhJYAdEIeyrMOhpwL/Qfg8yVMtWRiXwsVMJ7po/aK4NO0tHbSIIWML
         dseGQl5nMmhqcqVKOP+4snERIH7kcOmlzm7YPyrbRzwOhgEZDD5++d5ALHsmDmYO7iua
         rvXA==
X-Forwarded-Encrypted: i=1; AJvYcCVk2OxGhkfMGFoORZu9U1zL7HqERk9St5BzSfyS9tl9bGLsuPoyufJVHrHuGJWsYywNpOV/Jb3jKhY+DdcKWe3IMH85xyMUfBUbelmXGu2js7lgrT4clvzOcGOa8qS7++89fOxrEM5acubWTjf3
X-Gm-Message-State: AOJu0YzIUa7A4/HwPiI+CAMxjE1n28hP6NMMRWTAYFZquDHyC67fUIyn
	SiVSRJcAikWg41bDlU+rxqc39W0mh7eXGTayxrYD7+cBqejwHfYJ
X-Google-Smtp-Source: AGHT+IE2lLmVkmfAJV/IjJxO6PaTSSfOhu99t2PmJHJ1PwcYyuFSAh+bnozGSQf6WJFXJWIQQL9Wwg==
X-Received: by 2002:a05:600c:1992:b0:418:8df1:ca73 with SMTP id t18-20020a05600c199200b004188df1ca73mr5902111wmq.19.1713819072062;
        Mon, 22 Apr 2024 13:51:12 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:ab0d:124:447c:bf37])
        by smtp.gmail.com with ESMTPSA id w15-20020a5d544f000000b00349c63eb484sm12861576wrv.23.2024.04.22.13.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 13:51:11 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/Five SoC
Date: Mon, 22 Apr 2024 21:50:52 +0100
Message-Id: <20240422205053.496095-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422205053.496095-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240422205053.496095-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Document RZ/Five (R9A07G043F) IRQC bindings. The IRQC block on the RZ/Five
SoC is almost identical to the one found on the RZ/G2L SoC, with the only
difference being that it has additional mask control registers for
NMI/IRQ/TINT.

Hence new compatible string "renesas,r9a07g043f-irqc" is added for RZ/Five
SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2->v3
- Dropped items for rz/five
- Collected the RB tags

v1->v2
- Dropped the checks for interrupts as its already handled
- Added SoC specific compat string
---
 .../renesas,rzg2l-irqc.yaml                     | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
index daef4ee06f4e..44b6ae5fc802 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
@@ -21,13 +21,16 @@ description: |
 
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,r9a07g043u-irqc   # RZ/G2UL
-          - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
-          - renesas,r9a07g054-irqc    # RZ/V2L
-          - renesas,r9a08g045-irqc    # RZ/G3S
-      - const: renesas,rzg2l-irqc
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a07g043u-irqc    # RZ/G2UL
+              - renesas,r9a07g044-irqc     # RZ/G2{L,LC}
+              - renesas,r9a07g054-irqc     # RZ/V2L
+              - renesas,r9a08g045-irqc     # RZ/G3S
+          - const: renesas,rzg2l-irqc
+
+      - const: renesas,r9a07g043f-irqc     # RZ/Five
 
   '#interrupt-cells':
     description: The first cell should contain a macro RZG2L_{NMI,IRQX} included in the
-- 
2.34.1


