Return-Path: <linux-kernel+bounces-84215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FAD86A3AA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E605E1C22598
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F87559165;
	Tue, 27 Feb 2024 23:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmJJrqjO"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E565058AA7;
	Tue, 27 Feb 2024 23:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709076365; cv=none; b=KkbQNfUAvbXpGdl6aF9kWA0JUXFpIaTnmhtXj2SYNelihi59r1T4mIYGicQal6Y18F32jv22ZJDTCGz+n0S+YoCeL3y/+/falgV/n8lkSsALr21g2MKOmxe2BryVz/HV2wlUuRp7XmJSMk0s5JAQX4eYIY0/4xNh5n2G1WZJlS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709076365; c=relaxed/simple;
	bh=2WKEIwQQNWfmg98tnsDM9WyYaj8/8R7x/wRIpkYmhlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EZ1pg9Gg71kv7ITf9Wa7LpBXrlYJF3yD14L8BmddJxpb0TXfswI4B4Kw/sF06X4UhYLEFRgN8xfjJCYZ6PRHvS7Bbw1y2Zs7GCrD2QRMrTc6yVo03LpTEKDtsFdOG+JK8Zbua7U8An/MgOI98GNd3atkOQGU4bSbAoQauSuhGfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmJJrqjO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412b34fb36bso794835e9.3;
        Tue, 27 Feb 2024 15:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709076362; x=1709681162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0ma3PIRLS2/lZAGTM7OFOKNZqV04AlFCQIzgTx9y0U=;
        b=TmJJrqjO68fcol5Iiuhj0+KIahj/RKwP83IPysDFAkx9paWLxPR5ObL1we+Fi+DDG1
         eMibwW+TKvhvf8NK5++3DutWetnsfg79ulYDE5IfshD5W2K5MyS0ysIY0V65lp3mq4cx
         HyyMRYZfoyeDc0n2lbCrCs0AZAABXyJc2wuojaisvqv8BB/E1uN0gF5iVIJZ8SN/4lap
         QBgDxGpG/I8CCXp7sGHl7Xb/ejynEniy80NPQgsxbQNBd/Qak8bnEKK+XL6eT4t/ia5X
         7unap/tkdOnocQpa1dCY7lDNo4IugmI3z/zEbuUTeylghk6h9HXGzGNhSGBNdi5RIM1H
         s4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709076362; x=1709681162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0ma3PIRLS2/lZAGTM7OFOKNZqV04AlFCQIzgTx9y0U=;
        b=BihhMAcnp+lG8WtOCxWVvEaItt9mVhQ2xl4TDsjSeBehspE6D5HOz3GxiP7QTAzmqQ
         6KsqTvLvjMXyKkk2IyRr4OV4zuIoXe8kEokG3T/jKRExWkwcrJlb/mmzMW3AuqqMBkLB
         mcvTc+ysC8c0MSKCcOr7Z+cXnvpZQTjm2XvjbzzkqWemRvX5ISIvkke/EECIeQZ74bwm
         mfYgWdLbs7XXXwR4KZMGvar2r+crIGQr1DwvCaA1spclRa8dIdu0vIh3NaKRF+Fub3FG
         O+uEJrO+vPtbMEPAv+bPTCHc1UgQFfAQMR3J1EAL3vVi7BglFoLOnBkOKJtrjThbbULQ
         ExXA==
X-Forwarded-Encrypted: i=1; AJvYcCU/BNeDOt3wMHzzxkaH8eSMPrArBCkibatowOaJcaU9NcMJOn1WqAIWFtgUvPdpCHxjKmlD2X1qP5pIYHrZLNnQS0UcUA07bNxIgE71RD59lodKiU3BrDQK735GgzQQx0reY9m/AwHPI90Blkowd8g9CzhHcRsUWKsP7wzXVDaP29IfZHYvyMoUUmQ5
X-Gm-Message-State: AOJu0YwHewNZwTB2ddGByOkUaSHgLNf5xT1efxyR9cUOZvVUev0/2UgO
	mKSB+7UyNdV3J5xDusdYZfe52xJqTJbx+CNUe+WNwK8TftiuR3BJ
X-Google-Smtp-Source: AGHT+IE3mkEwOn8Q8tjquPjbHTzBnx9Hda8D4G1DHBshf+Z6nX6aPedYQYIcBTi48yeUFLMhp2oVEg==
X-Received: by 2002:a5d:490b:0:b0:33d:5548:435e with SMTP id x11-20020a5d490b000000b0033d5548435emr6852450wrq.53.1709076362186;
        Tue, 27 Feb 2024 15:26:02 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:e6a2:98b:e06b:631a])
        by smtp.gmail.com with ESMTPSA id co22-20020a0560000a1600b0033d96b4efbasm13014444wrb.21.2024.02.27.15.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 15:26:01 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 2/4] dt-bindings: arm: renesas: Document Renesas RZ/V2H(P) System Controller
Date: Tue, 27 Feb 2024 23:25:29 +0000
Message-Id: <20240227232531.218159-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227232531.218159-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240227232531.218159-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add DT binding documentation for System Controller (SYS) found on
RZ/V2H(P) ("R9A09G057") SoC's.

SYS block contains the SYS_LSI_DEVID register which can be used to
retrieve SoC version information.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
v1 -> v2
- Dropped extal_clk node from example
- Replaced RZ/V2H{P} -> RZ/V2H(P)
- Dropped description for clocks & resets properties
- used <cpg 1> for clocks in example node
---
 .../soc/renesas/renesas,r9a09g057-sys.yaml    | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/renesas/renesas,r9a09g057-sys.yaml

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas,r9a09g057-sys.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas,r9a09g057-sys.yaml
new file mode 100644
index 000000000000..72bf8e733dcd
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas,r9a09g057-sys.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/renesas/renesas,r9a09g057-sys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/V2H(P) System Controller (SYS)
+
+maintainers:
+  - Geert Uytterhoeven <geert+renesas@glider.be>
+
+description:
+  The RZ/V2H(P) SYS (System Controller) controls the overall
+  configuration of the LSI and supports the following functions,
+  - Trust zone control
+  - Extend access by specific masters to address beyond 4GB space
+  - GBETH configuration
+  - Control of settings and states of SRAM/PCIe/CM33/CA55/CR8/xSPI/ADC/TSU
+  - LSI version
+  - WDT stop control
+  - General registers
+
+properties:
+  compatible:
+    const: renesas,r9a09g057-sys
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    sys: system-controller@10430000 {
+        compatible = "renesas,r9a09g057-sys";
+        reg = <0x10430000 0x10000>;
+        clocks = <&cpg 1>;
+        resets = <&cpg 1>;
+    };
-- 
2.34.1


