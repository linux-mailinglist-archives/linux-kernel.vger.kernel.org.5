Return-Path: <linux-kernel+bounces-150047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 125C78A999C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 677AFB22D3A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A883F15FCEA;
	Thu, 18 Apr 2024 12:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="A7sLAgGb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73D315F418;
	Thu, 18 Apr 2024 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713442409; cv=none; b=F2A8V/dKwGFgKoebsLkwXyEeDiMurpO7ezqBIwK2I3N2tmBjLu1W6E8whOAb/QcglKxE9iv6aFQvSclEH33ScSTMiFMp5iJvUIdab630AiDnjku/BHJ5um6YIUYObXEoIb957Cmv32iov0VNjGEHHKlocVRm2b9LeMEZRZLL5qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713442409; c=relaxed/simple;
	bh=Amq8QQQDYa44SzqqX6R4cVVx5PsYPSiIZ/0HlSgcyPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIR6vZ4YtO/WNeK9z41eYJPEeJyN8Etlnil5Dt+CEItnKbSUwZKF1ymGKkjjK5kD763KnIWnCvGj/sDuU+h49aU9X21X1AuZdAvDb8+tuZoyaanYCGFeV+/eavQeKX9g3Ig1I1oTXhd8ocgDRVi2zCzoJ+1nMykYbWTsiyCIwEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=A7sLAgGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE77C113CC;
	Thu, 18 Apr 2024 12:13:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="A7sLAgGb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1713442406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7gsorX/0HQ5s+ktgRAadAV+5SRctARQllFusL+M6cyE=;
	b=A7sLAgGbzIHH3b48pvtyBzSksVK30qrf+KChuiYNq+5V1ViTvvrRdJuw386U+quDa7RGJs
	TskpmyVFyinCJY9QkeaoHf4ioTV1yXjCpRoZPNPxlXCYJql5PMGCINloGFRd+0SHy8i16G
	sfIR0DO2dB3QdcwGU4plIdIVafbtrqo=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c261e6bf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Apr 2024 12:13:25 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: tytso@mit.edu,
	robh@kernel.org,
	krzk@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sudanl@amazon.com,
	graf@amazon.com,
	dwmw@amazon.co.uk,
	krzysztof.kozlowski@linaro.org
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v7 2/3] dt-bindings: rng: Add vmgenid support
Date: Thu, 18 Apr 2024 14:12:31 +0200
Message-ID: <20240418121249.42380-3-Jason@zx2c4.com>
In-Reply-To: <20240418121249.42380-1-Jason@zx2c4.com>
References: <20240418121249.42380-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sudan Landge <sudanl@amazon.com>

Virtual Machine Generation ID driver was introduced in commit
af6b54e2b5ba ("virt: vmgenid: notify RNG of VM fork and supply
generation ID"), as an ACPI only device.

VMGenID specification http://go.microsoft.com/fwlink/?LinkId=260709
defines a mechanism for the BIOS/hypervisors to communicate to the
virtual machine that it is executed with a different configuration (e.g.
snapshot execution or creation from a template).  The guest operating
system can use the notification for various purposes such as
re-initializing its random number generator etc.

As per the specs, hypervisor should provide a globally unique
identified, or GUID via ACPI.

This patch tries to mimic the mechanism to provide the same
functionality which is for a hypervisor/BIOS to notify the virtual
machine when it is executed with a different configuration.

As part of this support the devicetree bindings requires the hypervisors
or BIOS to provide a memory address which holds the GUID and an IRQ
which is used to notify when there is a change in the GUID.  The memory
exposed in the DT should follow the rules defined in the vmgenid spec
mentioned above.

Reason for this change: Chosing ACPI or devicetree is an intrinsic part
of an hypervisor design.  Without going into details of why a hypervisor
would chose DT over ACPI, we would like to highlight that the
hypervisors that have chose devicetree and now want to make use of the
vmgenid functionality cannot do so today because vmgenid is an ACPI only
device.  This forces these hypervisors to change their design which
could have undesirable impacts on their use-cases, test-scenarios etc.

The point of vmgenid is to provide a mechanism to discover a GUID when
the execution state of a virtual machine changes and the simplest way to
do it is pass a memory location and an interrupt via devicetree.  It
would complicate things unnecessarily if instead of using devicetree, we
try to implement a new protocol or modify other protocols to somehow
provide the same functionility.

We believe that adding a devicetree binding for vmgenid is a simpler,
better alternative to provide the same functionality and will allow such
hypervisors as mentioned above to continue using devicetree.

More references to the vmgenid specs are found below.

Signed-off-by: Sudan Landge <sudanl@amazon.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Alexander Graf <graf@amazon.com>
Link: https://www.qemu.org/docs/master/specs/vmgenid.html
Link: https://learn.microsoft.com/en-us/windows/win32/hyperv_v2/virtual-machine-generation-identifier
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 .../bindings/rng/microsoft,vmgenid.yaml       | 49 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml

diff --git a/Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml b/Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml
new file mode 100644
index 000000000000..8f20dee93e7e
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rng/microsoft,vmgenid.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Virtual Machine Generation ID
+
+maintainers:
+  - Jason A. Donenfeld <Jason@zx2c4.com>
+
+description:
+  Firmwares or hypervisors can use this devicetree to describe an
+  interrupt and a shared resource to inject a Virtual Machine Generation ID.
+  Virtual Machine Generation ID is a globally unique identifier (GUID) and
+  the devicetree binding follows VMGenID specification defined in
+  http://go.microsoft.com/fwlink/?LinkId=260709.
+
+properties:
+  compatible:
+    const: microsoft,vmgenid
+
+  reg:
+    description:
+      Specifies a 16-byte VMGenID in endianness-agnostic hexadecimal format.
+    maxItems: 1
+
+  interrupts:
+    description:
+      Interrupt used to notify that a new VMGenID is available.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    rng@80000000 {
+      compatible = "microsoft,vmgenid";
+      reg = <0x80000000 0x1000>;
+      interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index aa3b947fb080..c84ac9258a48 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18463,6 +18463,7 @@ M:	"Theodore Ts'o" <tytso@mit.edu>
 M:	Jason A. Donenfeld <Jason@zx2c4.com>
 S:	Maintained
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
+F:	Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml
 F:	drivers/char/random.c
 F:	drivers/virt/vmgenid.c
 
-- 
2.44.0


