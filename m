Return-Path: <linux-kernel+bounces-117499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDBB88AC02
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ADF02E5935
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB70D14A4EB;
	Mon, 25 Mar 2024 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eyLrd3vu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nVuYMe/P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D27214A086;
	Mon, 25 Mar 2024 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385213; cv=none; b=je+Y7Yhn93+8fkuWshEoOgyl3fjA7q4z41TBFmKQRPIr9ZoSQRXxYH/mvDq+kZXDLm4+T48wAIYGGdedhwruJ0mdYywIBR90IhB9SxALIVy7FdCAHVH2bFH5h3qDc9Q8UwgC4Ec11KMb7OP/LvBKg39KIuRMhftiL8o4FD3YFpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385213; c=relaxed/simple;
	bh=xhIq0W/I4V0yoexpOywu6XvIpcQXqJpxEVh0bG9b7aE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RleCj+67rZAKwoaXOjWfL1IzV+u1/CYUBqDM2iHJI63JfcxvdAGkjYv7Bt6Pg/8Cv9duaNQ8tYhHOmuIQroqlyEDhr880eb4NBP2W4YYXW0hcr0TTLc8QEX/nAbL/lcvUB/hk6r2a7eLyvD7QZoIYEY8zZSPo8o971dXxKkOg2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eyLrd3vu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nVuYMe/P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Mar 2024 16:46:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711385209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=My5M8jp2lcEnM+1qj5/Vvgxpc82/dTNqTly0JFYzrM8=;
	b=eyLrd3vut/7TxojCM5pUkE3UUAY9hinTvKxUyW11RqAjwZxxCNrBuC+5KhOTOI9FE1JuHE
	70pKdgJilofgwBC7abqwpE7+pd7JJfCCJw+4dialish5suu4Lb96tUNRll88E+SwgvsPJs
	sKRA22jOHYtzvmTOEj4lo4veLAWk5DbiYQrH6+5kBdCAHdKHrHLepaZDk0Uo20qqgOwGHu
	NFIm3vqlbpGPotZAgnd7naz0YUsEARRjzRd2y5GxeBqqyXkVwp13E6GyfiUW8TSXPvv8YC
	3aeE2pxcKZkOQAI0wMX1gqpVzCjaqi1r8SH6eR1ZltFQJOKioMgnfnWYeuqRhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711385209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=My5M8jp2lcEnM+1qj5/Vvgxpc82/dTNqTly0JFYzrM8=;
	b=nVuYMe/PKVB5xitFV1pZq0heBet43npAHMrUcKDdmomaaL/h/Bb900RW03+VubMYXL2JIu
	IN8GjSyujbqQU7CA==
From: "tip-bot2 for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] dt-bindings: interrupt-controller: Add RISC-V advanced PLIC
Cc: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>,
 bjorn@rivosinc.com, Conor Dooley <conor.dooley@microchip.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240307140307.646078-6-apatel@ventanamicro.com>
References: <20240307140307.646078-6-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171138520913.10875.12939787502719525416.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     3b806a5a1a39d593d6fe0def2ef474402f551f91
Gitweb:        https://git.kernel.org/tip/3b806a5a1a39d593d6fe0def2ef474402f5=
51f91
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Thu, 07 Mar 2024 19:33:03 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 25 Mar 2024 17:38:28 +01:00

dt-bindings: interrupt-controller: Add RISC-V advanced PLIC

Add DT bindings document for RISC-V advanced platform level interrupt
controller (APLIC) defined by the RISC-V advanced interrupt architecture
(AIA) specification.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Link: https://lore.kernel.org/r/20240307140307.646078-6-apatel@ventanamicro.c=
om

---
 Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml | 17=
2 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 172 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ri=
scv,aplic.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,apl=
ic.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.=
yaml
new file mode 100644
index 0000000..190a649
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
@@ -0,0 +1,172 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/riscv,aplic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V Advanced Platform Level Interrupt Controller (APLIC)
+
+maintainers:
+  - Anup Patel <anup@brainfault.org>
+
+description:
+  The RISC-V advanced interrupt architecture (AIA) defines an advanced
+  platform level interrupt controller (APLIC) for handling wired interrupts
+  in a RISC-V platform. The RISC-V AIA specification can be found at
+  https://github.com/riscv/riscv-aia.
+
+  The RISC-V APLIC is implemented as hierarchical APLIC domains where all
+  interrupt sources connect to the root APLIC domain and a parent APLIC
+  domain can delegate interrupt sources to it's child APLIC domains. There
+  is one device tree node for each APLIC domain.
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qemu,aplic
+      - const: riscv,aplic
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  interrupts-extended:
+    minItems: 1
+    maxItems: 16384
+    description:
+      Given APLIC domain directly injects external interrupts to a set of
+      RISC-V HARTS (or CPUs). Each node pointed to should be a riscv,cpu-intc
+      node, which has a CPU node (i.e. RISC-V HART) as parent.
+
+  msi-parent:
+    description:
+      Given APLIC domain forwards wired interrupts as MSIs to a AIA incoming
+      message signaled interrupt controller (IMSIC). If both "msi-parent" and
+      "interrupts-extended" properties are present then it means the APLIC
+      domain supports both MSI mode and Direct mode in HW. In this case, the
+      APLIC driver has to choose between MSI mode or Direct mode.
+
+  riscv,num-sources:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 1023
+    description:
+      Specifies the number of wired interrupt sources supported by this
+      APLIC domain.
+
+  riscv,children:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 1
+    maxItems: 1024
+    items:
+      maxItems: 1
+    description:
+      A list of child APLIC domains for the given APLIC domain. Each child
+      APLIC domain is assigned a child index in increasing order, with the
+      first child APLIC domain assigned child index 0. The APLIC domain child
+      index is used by firmware to delegate interrupts from the given APLIC
+      domain to a particular child APLIC domain.
+
+  riscv,delegation:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 1
+    maxItems: 1024
+    items:
+      items:
+        - description: child APLIC domain phandle
+        - description: first interrupt number of the parent APLIC domain (in=
clusive)
+        - description: last interrupt number of the parent APLIC domain (inc=
lusive)
+    description:
+      A interrupt delegation list where each entry is a triple consisting
+      of child APLIC domain phandle, first interrupt number of the parent
+      APLIC domain, and last interrupt number of the parent APLIC domain.
+      Firmware must configure interrupt delegation registers based on
+      interrupt delegation list.
+
+dependencies:
+  riscv,delegation: [ "riscv,children" ]
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - "#interrupt-cells"
+  - riscv,num-sources
+
+anyOf:
+  - required:
+      - interrupts-extended
+  - required:
+      - msi-parent
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    // Example 1 (APLIC domains directly injecting interrupt to HARTs):
+
+    interrupt-controller@c000000 {
+      compatible =3D "qemu,aplic", "riscv,aplic";
+      interrupts-extended =3D <&cpu1_intc 11>,
+                            <&cpu2_intc 11>,
+                            <&cpu3_intc 11>,
+                            <&cpu4_intc 11>;
+      reg =3D <0xc000000 0x4080>;
+      interrupt-controller;
+      #interrupt-cells =3D <2>;
+      riscv,num-sources =3D <63>;
+      riscv,children =3D <&aplic1>, <&aplic2>;
+      riscv,delegation =3D <&aplic1 1 63>;
+    };
+
+    aplic1: interrupt-controller@d000000 {
+      compatible =3D "qemu,aplic", "riscv,aplic";
+      interrupts-extended =3D <&cpu1_intc 9>,
+                            <&cpu2_intc 9>;
+      reg =3D <0xd000000 0x4080>;
+      interrupt-controller;
+      #interrupt-cells =3D <2>;
+      riscv,num-sources =3D <63>;
+    };
+
+    aplic2: interrupt-controller@e000000 {
+      compatible =3D "qemu,aplic", "riscv,aplic";
+      interrupts-extended =3D <&cpu3_intc 9>,
+                            <&cpu4_intc 9>;
+      reg =3D <0xe000000 0x4080>;
+      interrupt-controller;
+      #interrupt-cells =3D <2>;
+      riscv,num-sources =3D <63>;
+    };
+
+  - |
+    // Example 2 (APLIC domains forwarding interrupts as MSIs):
+
+    interrupt-controller@c000000 {
+      compatible =3D "qemu,aplic", "riscv,aplic";
+      msi-parent =3D <&imsic_mlevel>;
+      reg =3D <0xc000000 0x4000>;
+      interrupt-controller;
+      #interrupt-cells =3D <2>;
+      riscv,num-sources =3D <63>;
+      riscv,children =3D <&aplic3>;
+      riscv,delegation =3D <&aplic3 1 63>;
+    };
+
+    aplic3: interrupt-controller@d000000 {
+      compatible =3D "qemu,aplic", "riscv,aplic";
+      msi-parent =3D <&imsic_slevel>;
+      reg =3D <0xd000000 0x4000>;
+      interrupt-controller;
+      #interrupt-cells =3D <2>;
+      riscv,num-sources =3D <63>;
+    };
+...

