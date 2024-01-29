Return-Path: <linux-kernel+bounces-42974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA362840980
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 470B0B26BC7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831B1153BD4;
	Mon, 29 Jan 2024 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mvq9mydU"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CBF651B1;
	Mon, 29 Jan 2024 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541391; cv=none; b=puw7Sxqsel6HkK0U2jZ4W7wZS32evDwBlbwzbFKRBIWcBmrgyRqaNp2a8MLvG+c2uAD2DGej41h6atyktEGUx7oJ2d+C9205dafTmVsqwQ+B3VN0Ja+TYu18s5xn6MT8uwMIZ1xGFdRGLY3N/4i30M6vM4dCfD0aPNQCKusjYkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541391; c=relaxed/simple;
	bh=0jM5ujZYP8nmek8AaX67k0KsUzxSJfaOyNJpRc3Bbrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p05yvMSK52pVxXvQNRErb6ZDG3UzRO4ZQlF1LBRn9R+EfBaTEdH/YIOVuqJqJ5k4hD/quS16k3uTChGkC0SV2k8JqMbkQk5AGkPOxjvGr83r1g5C0sJx8fd6z7U/lUSHS0aPrMlFFRWWfRAAtGU/ztfwB+L68jgLO0caqrWPFz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mvq9mydU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40eacb6067dso43789215e9.1;
        Mon, 29 Jan 2024 07:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706541388; x=1707146188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGa8xFRwP8zLCWj6u5lZzVVx+K8OLPxZ4f43XzHIoys=;
        b=Mvq9mydUuvnCqMK4O2Qhow19SZyyh8v2svPOxtOWYGwu/e7ib77NuRYhZ7C9cSCFL4
         whVqNxUvI852wj+WoRmOthWDl9Hbty/wXmMXs64zR9itLSZS9y79GQZ6CPlhY3fmfwHp
         CE85fSUQXk6JkTE2ow3QWmRkiK6UkGER4/NioO8gxE3BXuLqlqHrFrc33z/ZZJesxDi+
         PiUnWhk88o+yBe7Dz4LSQP4YMCWxhsRAl8bvVqKit/Wx+VG1nM9YBH4IeAuMzzMqsRqH
         gDFt0vOsi1G1u43hDljeznd0LpXr7aAE+ru1yrt0xomT89ck9koyMe0/mka/gdpsf/kn
         lOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706541388; x=1707146188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGa8xFRwP8zLCWj6u5lZzVVx+K8OLPxZ4f43XzHIoys=;
        b=qNNGEoCZPxJOM/LtVcNf4L6pbjHtR5Eh0Fm0XhcE8zEMiGa8Za79j1YLFWDMl643pg
         /S6WEKHAoDUlEl5Gy7o1XQz2HFyNa520s0fw3O4tuqRsjDlzQTRDQS6llV7l++JSaLJl
         Pj0q3za/hEmQkFBDxqu+ECNrBPHK0LvDL70jyerhlsGHaYb3mrH4GtD3OY1k0qCDaxq8
         tYAqhY03LSudFVzoYN7X4xlDSzaIaL0omVV6AqctoRHLmjbo2enF1Ak4PMSlKWn+iRGh
         8u6BAH05FpexjIbsPxTjr/WkP0400Q+vDshqgKVHnf9f+ICW8A+4cEUb+hFOs6No09H3
         x5Bw==
X-Gm-Message-State: AOJu0YypVr73HoVxVaFbsKisFVUC3s9J/c7RD2Z9Tllkr08/U0tLcUvF
	Q6/Y7ZhBHJvmMOAtIEX8yG2nD8IkZ2WJi4WacwpVAhOAOwFRrywF
X-Google-Smtp-Source: AGHT+IG3HsuD9SaUwYrvX4rmWSShZVOxOyMaqp6KeQVa+qLdgqFTIv45DCNzraZDMw6ntN1GjVYCWg==
X-Received: by 2002:adf:e105:0:b0:337:c176:6549 with SMTP id t5-20020adfe105000000b00337c1766549mr4168842wrz.65.1706541388215;
        Mon, 29 Jan 2024 07:16:28 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:5616:a18c:ea50:2995])
        by smtp.gmail.com with ESMTPSA id h4-20020adfa4c4000000b00337d4eed87asm8397774wrb.115.2024.01.29.07.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 07:16:27 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/5] dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/Five SoC
Date: Mon, 29 Jan 2024 15:16:14 +0000
Message-Id: <20240129151618.90922-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129151618.90922-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240129151618.90922-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Document RZ/Five (R9A07G043F) IRQC bindings. The IRQC block on RZ/Five SoC
is almost identical to one found on the RZ/G2L SoC with below differences,
* Additional BUS error interrupt
* Additional ECCRAM error interrupt
* Has additional mask control registers for NMI/IRQ/TINT

Hence new compatible string "renesas,r9a07g043f-irqc" is added for RZ/Five
SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../renesas,rzg2l-irqc.yaml                   | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
index d3b5aec0a3f7..3abc01e48934 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
@@ -23,6 +23,7 @@ properties:
   compatible:
     items:
       - enum:
+          - renesas,r9a07g043f-irqc   # RZ/Five
           - renesas,r9a07g043u-irqc   # RZ/G2UL
           - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
           - renesas,r9a07g054-irqc    # RZ/V2L
@@ -88,6 +89,12 @@ properties:
       - description: GPIO interrupt, TINT30
       - description: GPIO interrupt, TINT31
       - description: Bus error interrupt
+      - description: ECCRAM0 TIE1 interrupt
+      - description: ECCRAM0 TIE2 interrupt
+      - description: ECCRAM0 overflow interrupt
+      - description: ECCRAM1 TIE1 interrupt
+      - description: ECCRAM1 TIE2 interrupt
+      - description: ECCRAM1 overflow interrupt
 
   interrupt-names:
     minItems: 41
@@ -134,6 +141,12 @@ properties:
       - const: tint30
       - const: tint31
       - const: bus-err
+      - const: eccram0-tie1
+      - const: eccram0-tie2
+      - const: eccram0-ovf
+      - const: eccram1-tie1
+      - const: eccram1-tie2
+      - const: eccram1-ovf
 
   clocks:
     maxItems: 2
@@ -180,6 +193,20 @@ allOf:
       required:
         - interrupt-names
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a07g043f-irqc
+    then:
+      properties:
+        interrupts:
+          minItems: 48
+        interrupt-names:
+          minItems: 48
+      required:
+        - interrupt-names
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1


