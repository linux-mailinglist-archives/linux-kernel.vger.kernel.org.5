Return-Path: <linux-kernel+bounces-76248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E40585F4BD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763C21F21558
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AB538DF9;
	Thu, 22 Feb 2024 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="lGYqw3oa"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DFF3A29B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708594892; cv=none; b=dQ+eyTpqvtRTZFNMjzOIiq4X5G1KpOHFcDKzyfqZi/jrPXqUPHyQNCuhvBx8l2lStB+SAeXyhI071aRiFn5g6SIQaW5blqTYUcp0iig/pSg0v0mFIofWjlWw4myzRSsVahXo59GR/o7zf/mO99NsL586X0L9jnhZjJbTqtsFaOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708594892; c=relaxed/simple;
	bh=6ldkn/NLN5Vok7/3YlbAjD/lx6DIcA8TyTnQ2yT4OV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UEQnRRw3mhlyKFv5iBfjh0NiFRQ8Tcpo+bMHX6JURdHE+8AOrlU8URr6rbXVjBynxRRCw2LHFqXBS7DF6tis+Yod/PJP2EKG68HOfX+sjYVTT2UOBOJj8B5+Tco3s5cA/pjxna27FABNumorCjlCkV121NQK0mLtGim8X8Jde3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=lGYqw3oa; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c02b993a5aso4632496b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708594889; x=1709199689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2jsLyFwepKDrwIr/uWJV0RdUuyknGyf55lcJyFTRiQ=;
        b=lGYqw3oaJ81NTg5DVN+GTGbdcl/aNab+T5cEVfzAPjv27hPlDL2/zPGLvxs/yf4ulK
         60WVqtwLiAhIf0pbx1PwWtpDzNu8/WhPA+WM57UDdZSpuJkCKcqlmVkCw8yKKjXjs0dL
         iAGiNx5bVD4DiOxlf+CpbXAZD3mpKZu+9WfK1/s62DQaX/9hc5+Bre0d+RT9EO0X/5As
         O3BlQhX2+a0wYGvFB4NPCCbde+TpXyyW7Gg8XCtf0ZBkwsxI00jpjyCI92DliLzrPC0f
         J+KA9p+Ti6oC0cVYATEM/4zk4rryxIj1XcyT2XFcLoM0crd/gbMbuSj6+TX9S+0bz2yU
         hvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708594889; x=1709199689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2jsLyFwepKDrwIr/uWJV0RdUuyknGyf55lcJyFTRiQ=;
        b=i6QotixE7O5DdPv11htBidt4VlfilveMxw15D2VLCjkX7Y8iS8OLlVP5N1ZDXL708O
         15crS/BZVJXppwMnD6gJ4Pmstotz3Kaeu9677rTMGza9FguaA2oMKjlMDYteaDWWXfwJ
         IFnriaQ0xP6OrwSYO2CL3JA6nC/aTKs7Nwr4VLBuH80wUgWKLCkG8owNAcwrItgD2HDS
         oPIOvHRQrxHoN8k25ucKIJqZtGmW6YElUR3vop7v4m70sY47K/VYnX0XH79Z4hg/ePJi
         C49OXp/XwZoneo1IjnbNq7YwptURinU/X3u3H2AB57KKS/fK+jtuyJwpTS/SzlvqK39c
         293g==
X-Forwarded-Encrypted: i=1; AJvYcCVujeMEv0iWw+V6Z9ZIA2FvRGAOo8hQvjUix4E+9Uz/DIfyGEha51utEyjTPuaQYnL7bG/HIBearo933EsXmzOaZjy/OIS5pWA24U9w
X-Gm-Message-State: AOJu0YzobFAMWZeHx9iln2GDJ2Z+lSkAvsHblv1X4AfpcaiaTEjjklo7
	M/6gbK87gLEclEsDSk+iDKqS6fz76fxccJJjyI8iReQc2/b0JtionGDqlslh8YA7m5qQqTYU9gQ
	qZvo=
X-Google-Smtp-Source: AGHT+IFRukTMRpON+pv22bV2K5TI+M1YoKk45SQw3N4BqmJNHg6vHFJjjLROu0SEPH9tD7uP10513Q==
X-Received: by 2002:a05:6808:f8b:b0:3c1:7eac:a8a8 with SMTP id o11-20020a0568080f8b00b003c17eaca8a8mr740044oiw.26.1708594889565;
        Thu, 22 Feb 2024 01:41:29 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id n15-20020a05680803af00b003c17c2b8d09sm130699oie.31.2024.02.22.01.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 01:41:29 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Saravana Kannan <saravanak@google.com>,
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v14 09/18] dt-bindings: interrupt-controller: Add RISC-V incoming MSI controller
Date: Thu, 22 Feb 2024 15:09:57 +0530
Message-Id: <20240222094006.1030709-10-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222094006.1030709-1-apatel@ventanamicro.com>
References: <20240222094006.1030709-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DT bindings document for the RISC-V incoming MSI controller (IMSIC)
defined by the RISC-V advanced interrupt architecture (AIA) specification.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../interrupt-controller/riscv,imsics.yaml    | 172 ++++++++++++++++++
 1 file changed, 172 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
new file mode 100644
index 000000000000..84976f17a4a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
@@ -0,0 +1,172 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/riscv,imsics.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V Incoming MSI Controller (IMSIC)
+
+maintainers:
+  - Anup Patel <anup@brainfault.org>
+
+description: |
+  The RISC-V advanced interrupt architecture (AIA) defines a per-CPU incoming
+  MSI controller (IMSIC) for handling MSIs in a RISC-V platform. The RISC-V
+  AIA specification can be found at https://github.com/riscv/riscv-aia.
+
+  The IMSIC is a per-CPU (or per-HART) device with separate interrupt file
+  for each privilege level (machine or supervisor). The configuration of
+  a IMSIC interrupt file is done using AIA CSRs and it also has a 4KB MMIO
+  space to receive MSIs from devices. Each IMSIC interrupt file supports a
+  fixed number of interrupt identities (to distinguish MSIs from devices)
+  which is same for given privilege level across CPUs (or HARTs).
+
+  The device tree of a RISC-V platform will have one IMSIC device tree node
+  for each privilege level (machine or supervisor) which collectively describe
+  IMSIC interrupt files at that privilege level across CPUs (or HARTs).
+
+  The arrangement of IMSIC interrupt files in MMIO space of a RISC-V platform
+  follows a particular scheme defined by the RISC-V AIA specification. A IMSIC
+  group is a set of IMSIC interrupt files co-located in MMIO space and we can
+  have multiple IMSIC groups (i.e. clusters, sockets, chiplets, etc) in a
+  RISC-V platform. The MSI target address of a IMSIC interrupt file at given
+  privilege level (machine or supervisor) encodes group index, HART index,
+  and guest index (shown below).
+
+  XLEN-1            > (HART Index MSB)                  12    0
+  |                  |                                  |     |
+  -------------------------------------------------------------
+  |xxxxxx|Group Index|xxxxxxxxxxx|HART Index|Guest Index|  0  |
+  -------------------------------------------------------------
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qemu,imsics
+      - const: riscv,imsics
+
+  reg:
+    minItems: 1
+    maxItems: 16384
+    description:
+      Base address of each IMSIC group.
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 0
+
+  msi-controller: true
+
+  "#msi-cells":
+    const: 0
+
+  interrupts-extended:
+    minItems: 1
+    maxItems: 16384
+    description:
+      This property represents the set of CPUs (or HARTs) for which given
+      device tree node describes the IMSIC interrupt files. Each node pointed
+      to should be a riscv,cpu-intc node, which has a CPU node (i.e. RISC-V
+      HART) as parent.
+
+  riscv,num-ids:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 63
+    maximum: 2047
+    description:
+      Number of interrupt identities supported by IMSIC interrupt file.
+
+  riscv,num-guest-ids:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 63
+    maximum: 2047
+    description:
+      Number of interrupt identities are supported by IMSIC guest interrupt
+      file. When not specified it is assumed to be same as specified by the
+      riscv,num-ids property.
+
+  riscv,guest-index-bits:
+    minimum: 0
+    maximum: 7
+    default: 0
+    description:
+      Number of guest index bits in the MSI target address.
+
+  riscv,hart-index-bits:
+    minimum: 0
+    maximum: 15
+    description:
+      Number of HART index bits in the MSI target address. When not
+      specified it is calculated based on the interrupts-extended property.
+
+  riscv,group-index-bits:
+    minimum: 0
+    maximum: 7
+    default: 0
+    description:
+      Number of group index bits in the MSI target address.
+
+  riscv,group-index-shift:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 55
+    default: 24
+    description:
+      The least significant bit position of the group index bits in the
+      MSI target address.
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - msi-controller
+  - "#msi-cells"
+  - interrupts-extended
+  - riscv,num-ids
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    // Example 1 (Machine-level IMSIC files with just one group):
+
+    interrupt-controller@24000000 {
+      compatible = "qemu,imsics", "riscv,imsics";
+      interrupts-extended = <&cpu1_intc 11>,
+                            <&cpu2_intc 11>,
+                            <&cpu3_intc 11>,
+                            <&cpu4_intc 11>;
+      reg = <0x28000000 0x4000>;
+      interrupt-controller;
+      #interrupt-cells = <0>;
+      msi-controller;
+      #msi-cells = <0>;
+      riscv,num-ids = <127>;
+    };
+
+  - |
+    // Example 2 (Supervisor-level IMSIC files with two groups):
+
+    interrupt-controller@28000000 {
+      compatible = "qemu,imsics", "riscv,imsics";
+      interrupts-extended = <&cpu1_intc 9>,
+                            <&cpu2_intc 9>,
+                            <&cpu3_intc 9>,
+                            <&cpu4_intc 9>;
+      reg = <0x28000000 0x2000>, /* Group0 IMSICs */
+            <0x29000000 0x2000>; /* Group1 IMSICs */
+      interrupt-controller;
+      #interrupt-cells = <0>;
+      msi-controller;
+      #msi-cells = <0>;
+      riscv,num-ids = <127>;
+      riscv,group-index-bits = <1>;
+      riscv,group-index-shift = <24>;
+    };
+...
-- 
2.34.1


