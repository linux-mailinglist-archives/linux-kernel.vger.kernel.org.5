Return-Path: <linux-kernel+bounces-72379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B74385B2A4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FFAE1C21FE9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B132859162;
	Tue, 20 Feb 2024 06:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="oKLClY50"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3531E5914E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708409292; cv=none; b=th1/Dtgngr/gepUjBOOAlfTFJVTw3DHNtbu/YRYb3llgUsSuj2PyTSQawO8s4zSrlbQl/WSqW1977ZE7VaHK4wXQfLD38c536EkfOYTZ70n+a9wLdRyC/7qR8TG2Xn8c/pcqWCaeMjdGEpwIaSSU8gNHoSz1eMo28IVnzogFwwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708409292; c=relaxed/simple;
	bh=Yv2jjkLSXu/2PGL/WRtssyxVBdk37r5e6qrU4c22G1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YIwCMJAh+Z3/1M6FZhWmUF3KDiJg/9kXTc43QqR9Esoiy2aYAybLjYLnoLPGGT1WnqNpFd1EEt/4zzAw1xEeVqA5aFikfsNhui3tzoaFbNF0CMddU9hUSVznw7lz2/yP8LFlCowAYJB1eUzbl+Oc9bK/y5LZFPjMfj7FTuTIdbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=oKLClY50; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5dca1efad59so4695813a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 22:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708409290; x=1709014090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOjDepVi55uZJQ1rIBBnqb1diEnF/zfemFV4q9wl2F4=;
        b=oKLClY50+O4God9PMIgqDkfuS0Jm4jaVXynsCvDkQdE6VTFbX7XA6xxsKYC/iu5bMv
         ih2fIqwUheSvR47gR6Ba2fyUlhFLWEQ4JRYGSqKB8Q5fyS4p8UOxAzQUXBpIQ9DHBFdS
         V+ep6ORsvX/s8dSPkagS8+kCITtvO7wxJL3hQLIs6XS0jtsbpbWPSOs0BQtvSCHrXIyZ
         mPzjJaEQc9JRlqMvDjBxKTr6ENilVsaQK5M6+EW+n3CvhGy/0Z1onQa3F8oQmp/oEGuh
         Mabxig5H/5yqPZ1Yd1Hvbb1r2DosodN5mKNKr3+2yiJdvwy7ELm9KHbzW3HdUJ+nFeHr
         o/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708409290; x=1709014090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOjDepVi55uZJQ1rIBBnqb1diEnF/zfemFV4q9wl2F4=;
        b=AtkB4tNoWmHngT4eh3CWEk4RYS+kOQcbWEVmqNi5mFSRBRa2cx5APm8EFuY/X6Y4YR
         V93yF94GE2LQDv5DSEt92wCZEKUht81ln+1T7TaGbvr98J3DWUXaZn2BeWmrW59MNhvT
         WxXCgXXccaNOG4ouq/m+YFmvbSCfJAMl/ea/rw8csz0x3Kw/6gHAST5MoWcplNpmwkB1
         bYDmtt28AqgB9yLQhp6lzfBqsb2HKz2n8kjqQP3kSDfy2UOlOUy+kQ+LpGv9uc/P6KcG
         I2TtlI7VHknutTUUN1H1ay/pqk2+/GW06/VPGruLq3KBlWtgofr9ryeA8Q+Aoz7HqbwF
         OzZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL+xkV4xKxa2RgKEZV6EqWJr+x/QYSmSF4juDEc40pqrFYqVsQUg3njXyDNlHvo8LYFgAmiQ7XvoYJqB25NbAY8RHmturJvX3gdxVx
X-Gm-Message-State: AOJu0Yz5iiWp903tQUtmlVTMzOgKl/xFm22qqGYHlyjHBBlFvjBCJXo6
	V2i8pIPAeMb/34rcBLEwsIejci9W+oTGKEfp5pg59kAReX1OjNffeTdjGAu5fys=
X-Google-Smtp-Source: AGHT+IG27Zq8HysffKss0oGfN4A8cT1P0xweWvoiHsnQ0734eUhNegFU5FnWWIYe/SmCJYR7O2d5qQ==
X-Received: by 2002:a05:6a21:8cc6:b0:19c:a7e5:37cc with SMTP id ta6-20020a056a218cc600b0019ca7e537ccmr13231784pzb.41.1708409290374;
        Mon, 19 Feb 2024 22:08:10 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.80.86])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090276c600b001db4c89aea5sm5368114plt.158.2024.02.19.22.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 22:08:09 -0800 (PST)
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
Subject: [PATCH v13 04/13] dt-bindings: interrupt-controller: Add RISC-V incoming MSI controller
Date: Tue, 20 Feb 2024 11:37:09 +0530
Message-Id: <20240220060718.823229-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220060718.823229-1-apatel@ventanamicro.com>
References: <20240220060718.823229-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We add DT bindings document for the RISC-V incoming MSI controller
(IMSIC) defined by the RISC-V advanced interrupt architecture (AIA)
specification.

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


