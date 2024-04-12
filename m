Return-Path: <linux-kernel+bounces-143255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920C78A365A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F0DDB214F8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3762A1509B2;
	Fri, 12 Apr 2024 19:28:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4229148313;
	Fri, 12 Apr 2024 19:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712950134; cv=none; b=YTiqgP+q+LQ8Ofo2KcfDK+o+8rXxZLDidWdUwgwz5Pdc+b4U0sHZi4i0zcoYw85R7Om9QpwRe/h0t+c+4Qo7YdrUeiy4IwadtuzM07MnOtLLTXhiGNutQxu7Uct455slvHuk4913dKpICh2mikMJD5ImcZwa4eY2gcpCgPR24Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712950134; c=relaxed/simple;
	bh=403uZ4UXj9ZEsY+K1SWJzCbispWncvlQzEVj0McozQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HAfcmZXAORyH2x2t3JW8LRaSeoBg+BWF5wjDvczwLKs0v1xSG98DeOaqYysWaHO6mFzOwuPu4nrTRsoKyniw4+sHXH07zt1y489+gp9LQ4ICGy1xOCi93jtA2Ag1+uGJyvPEbuHL3ylsZhAaCuLpRVTwjdJkHCQD/idXr2TX2YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 025E8113E;
	Fri, 12 Apr 2024 12:29:20 -0700 (PDT)
Received: from e120937-lin.. (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C49A3F766;
	Fri, 12 Apr 2024 12:28:49 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	jassisinghbrar@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jonathan.cameron@huawei.com
Subject: [PATCH v4 1/2] dt-bindings: mailbox: arm,mhuv3: Add bindings
Date: Fri, 12 Apr 2024 20:28:00 +0100
Message-Id: <20240412192801.554464-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412192801.554464-1-cristian.marussi@arm.com>
References: <20240412192801.554464-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for the ARM MHUv3 Mailbox controller.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v3 -> v4
- using ARM GIC defines in example
- defined MHUv3 Extensions types in dt-bindings/arm/mhuv3-dt.h
v2 -> v3
- fixed spurious tabs in dt_binding_check
v1 -> v2
- clarified extension descriptions around configurability and discoverability
- removed unused labels from the example
- using pattern properties to define interrupt-names
- bumped interrupt maxItems to 74 (allowing uo to 8 channels per extension)
---
 .../bindings/mailbox/arm,mhuv3.yaml           | 224 ++++++++++++++++++
 include/dt-bindings/arm/mhuv3-dt.h            |  13 +
 2 files changed, 237 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml
 create mode 100644 include/dt-bindings/arm/mhuv3-dt.h

diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml
new file mode 100644
index 000000000000..449b55afeb7d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml
@@ -0,0 +1,224 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/arm,mhuv3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM MHUv3 Mailbox Controller
+
+maintainers:
+  - Sudeep Holla <sudeep.holla@arm.com>
+  - Cristian Marussi <cristian.marussi@arm.com>
+
+description: |
+  The Arm Message Handling Unit (MHU) Version 3 is a mailbox controller that
+  enables unidirectional communications with remote processors through various
+  possible transport protocols.
+  The controller can optionally support a varying number of extensions that, in
+  turn, enable different kinds of transport to be used for communication.
+  Number, type and characteristics of each supported extension can be discovered
+  dynamically at runtime.
+
+  Given the unidirectional nature of the controller, an MHUv3 mailbox controller
+  is composed of a MHU Sender (MHUS) containing a PostBox (PBX) block and a MHU
+  Receiver (MHUR) containing a MailBox (MBX) block, where
+
+   PBX is used to
+      - Configure the MHU
+      - Send Transfers to the Receiver
+      - Optionally receive acknowledgment of a Transfer from the Receiver
+
+   MBX is used to
+      - Configure the MHU
+      - Receive Transfers from the Sender
+      - Optionally acknowledge Transfers sent by the Sender
+
+  Both PBX and MBX need to be present and defined in the DT description if you
+  need to establish a bidirectional communication, since you will have to
+  acquire two distinct unidirectional channels, one for each block.
+
+  As a consequence both blocks needs to be represented separately and specified
+  as distinct DT nodes in order to properly describe their resources.
+
+  Note that, though, thanks to the runtime discoverability, there is no need to
+  identify the type of blocks with distinct compatibles.
+
+  Following are the MHUv3 possible extensions.
+
+  - Doorbell Extension (DBE): DBE defines a type of channel called a Doorbell
+    Channel (DBCH). DBCH enables a single bit Transfer to be sent from the
+    Sender to Receiver. The Transfer indicates that an event has occurred.
+    When DBE is implemented, the number of DBCHs that an implementation of the
+    MHU can support is between 1 and 128, numbered starting from 0 in ascending
+    order and discoverable at run-time.
+    Each DBCH contains 32 individual fields, referred to as flags, each of which
+    can be used independently. It is possible for the Sender to send multiple
+    Transfers at once using a single DBCH, so long as each Transfer uses
+    a different flag in the DBCH.
+    Optionally, data may be transmitted through an out-of-band shared memory
+    region, wherein the MHU Doorbell is used strictly as an interrupt generation
+    mechanism, but this is out of the scope of these bindings.
+
+  - FastChannel Extension (FCE): FCE defines a type of channel called a Fast
+    Channel (FCH). FCH is intended for lower overhead communication between
+    Sender and Receiver at the expense of determinism. An FCH allows the Sender
+    to update the channel value at any time, regardless of whether the previous
+    value has been seen by the Receiver. When the Receiver reads the channel's
+    content it gets the last value written to the channel.
+    FCH is considered lossy in nature, and means that the Sender has no way of
+    knowing if, or when, the Receiver will act on the Transfer.
+    FCHs are expected to behave as RAM which generates interrupts when writes
+    occur to the locations within the RAM.
+    When FCE is implemented, the number of FCHs that an implementation of the
+    MHU can support is between 1-1024, if the FastChannel word-size is 32-bits,
+    or between 1-512, when the FastChannel word-size is 64-bits.
+    FCHs are numbered from 0 in ascending order.
+    Note that the number of FCHs and the word-size are implementation defined,
+    not configurable but discoverable at run-time.
+    Optionally, data may be transmitted through an out-of-band shared memory
+    region, wherein the MHU FastChannel is used as an interrupt generation
+    mechanism which carries also a pointer to such out-of-band data, but this
+    is out of the scope of these bindings.
+
+  - FIFO Extension (FE): FE defines a Channel type called a FIFO Channel (FFCH).
+    FFCH allows a Sender to send
+       - Multiple Transfers to the Receiver without having to wait for the
+         previous Transfer to be acknowledged by the Receiver, as long as the
+         FIFO has room for the Transfer.
+       - Transfers which require the Receiver to provide acknowledgment.
+       - Transfers which have in-band payload.
+    In all cases, the data is guaranteed to be observed by the Receiver in the
+    same order which the Sender sent it.
+    When FE is implemented, the number of FFCHs that an implementation of the
+    MHU can support is between 1 and 64, numbered starting from 0 in ascending
+    order. The number of FFCHs, their depth (same for all implemented FFCHs) and
+    the access-granularity are implementation defined, not configurable but
+    discoverable at run-time.
+    Optionally, additional data may be transmitted through an out-of-band shared
+    memory region, wherein the MHU FIFO is used to transmit, in order, a small
+    part of the payload (like a header) and a reference to the shared memory
+    area holding the remaining, bigger, chunk of the payload, but this is out of
+    the scope of these bindings.
+
+properties:
+  compatible:
+    const: arm,mhuv3
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 74
+
+  interrupt-names:
+    description: |
+      The MHUv3 controller generates a number of events some of which are used
+      to generate interrupts; as a consequence it can expose a varying number of
+      optional PBX/MBX interrupts, representing the events generated during the
+      operation of the various transport protocols associated with different
+      extensions. All interrupts of the MHU are level-sensitive.
+      Some of these optional interrupts are defined per-channel, where the
+      number of channels effectively available is implementation defined and
+      run-time discoverable.
+      In the following names are enumerated using patterns, with per-channel
+      interrupts implicitly capped at the maximum channels allowed by the
+      specification for each extension type.
+      For the sake of simplicity maxItems is anyway capped to a most plausible
+      number, assuming way less channels would be implemented than actually
+      possible.
+
+      The only mandatory interrupts on the MHU are:
+        - combined
+        - mbx-fch-xfer-<N> but only if mbx-fcgrp-xfer-<N> is not implemented.
+
+    minItems: 1
+    maxItems: 74
+    items:
+      oneOf:
+        - const: combined
+          description: PBX/MBX Combined interrupt
+        - const: combined-ffch
+          description: PBX/MBX FIFO Combined interrupt
+        - pattern: '^ffch-low-tide-[0-9]+$'
+          description: PBX/MBX FIFO Channel <N> Low Tide interrupt
+        - pattern: '^ffch-high-tide-[0-9]+$'
+          description: PBX/MBX FIFO Channel <N> High Tide interrupt
+        - pattern: '^ffch-flush-[0-9]+$'
+          description: PBX/MBX FIFO Channel <N> Flush interrupt
+        - pattern: '^mbx-dbch-xfer-[0-9]+$'
+          description: MBX Doorbell Channel <N> Transfer interrupt
+        - pattern: '^mbx-fch-xfer-[0-9]+$'
+          description: MBX FastChannel <N> Transfer interrupt
+        - pattern: '^mbx-fchgrp-xfer-[0-9]+$'
+          description: MBX FastChannel <N> Group Transfer interrupt
+        - pattern: '^mbx-ffch-xfer-[0-9]+$'
+          description: MBX FIFO Channel <N> Transfer interrupt
+        - pattern: '^pbx-dbch-xfer-ack-[0-9]+$'
+          description: PBX Doorbell Channel <N> Transfer Ack interrupt
+        - pattern: '^pbx-ffch-xfer-ack-[0-9]+$'
+          description: PBX FIFO Channel <N> Transfer Ack interrupt
+
+  '#mbox-cells':
+    description: |
+      The first argument in the consumers 'mboxes' property represents the
+      extension type, the second is for the channel number while the third
+      depends on extension type.
+
+      Extension types constants are defined in <dt-bindings/arm/mhuv3-dt.h>.
+
+      Extension type for DBE is DBE_EXT and the third parameter represents the
+      doorbell flag number to use.
+      Extension type for FCE is FCE_EXT, third parameter unused.
+      Extension type for FE is FE_EXT, third parameter unused.
+
+      mboxes = <&mhu DBE_EXT 0 5>; // DBE, Doorbell Channel Window 0, doorbell 5.
+      mboxes = <&mhu DBE_EXT 7>; // DBE, Doorbell Channel Window 1, doorbell 7.
+      mboxes = <&mhu FCE_EXT 0 0>; // FCE, FastChannel Window 0.
+      mboxes = <&mhu FCE_EXT 3 0>; // FCE, FastChannel Window 3.
+      mboxes = <&mhu FE_EXT 1 0>; // FE, FIFO Channel Window 1.
+      mboxes = <&mhu FE_EXT 7 0>; // FE, FIFO Channel Window 7.
+    const: 3
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - '#mbox-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        mailbox@2aaa0000 {
+            compatible = "arm,mhuv3";
+            #mbox-cells = <3>;
+            reg = <0 0x2aaa0000 0 0x10000>;
+            clocks = <&clock 0>;
+            interrupt-names = "combined", "pbx-dbch-xfer-ack-1",
+                               "ffch-high-tide-0";
+            interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+        };
+
+        mailbox@2ab00000 {
+            compatible = "arm,mhuv3";
+            #mbox-cells = <3>;
+            reg = <0 0x2aab0000 0 0x10000>;
+            clocks = <&clock 0>;
+            interrupt-names = "combined", "mbx-dbch-xfer-1", "ffch-low-tide-0";
+            interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
diff --git a/include/dt-bindings/arm/mhuv3-dt.h b/include/dt-bindings/arm/mhuv3-dt.h
new file mode 100644
index 000000000000..4575406919dd
--- /dev/null
+++ b/include/dt-bindings/arm/mhuv3-dt.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * This header provides constants for the defined MHUv3 types.
+ */
+
+#ifndef _DT_BINDINGS_ARM_MHUV3_DT_H
+#define _DT_BINDINGS_ARM_MHUV3_DT_H
+
+#define DBE_EXT		0
+#define FCE_EXT		1
+#define FE_EXT		2
+
+#endif /* _DT_BINDINGS_ARM_MHUV3_DT_H */
-- 
2.34.1


