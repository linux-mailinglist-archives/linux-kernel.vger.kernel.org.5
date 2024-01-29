Return-Path: <linux-kernel+bounces-43594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC56F841610
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786FF2869C5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9A75103C;
	Mon, 29 Jan 2024 22:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="Ug86lLel"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EF423741;
	Mon, 29 Jan 2024 22:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706568989; cv=none; b=VMxhY7VcWRGIc2t2DG2OjFqYbYcN1UpfiARyoLJigwyfqizFiTdlE2ihXTLonnfuDQdc/OmLEXNXUL8NPJKQmcmbEZVRxVi5wLzaBHKLTEW8cLglXxbC8Pf2f5ygapguzxUhyJHkAhl7rxLDsZUy29N4NxfG6iKhau5jnYGpeRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706568989; c=relaxed/simple;
	bh=fJ6PjO/0FcZMze5mUXPpKJExQw6zsz0lRHzIhYnacJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sa1oKiCE4ZLiXxnULaRYi6QGEGHo4pir0sMmSRe1t2W9okzxDVn7OI71987MJBj+zGC3+SIAQijoKEQOAxaefl7kMyGIYuQXZGqBPv1/XBvdY9EbTNKc9bP7Ipgj+5hYvk9LExvQuLTkCVsfemaX76rHZHfgr/n9n30YrcJ+Mf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=Ug86lLel; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0B8929C471E;
	Mon, 29 Jan 2024 17:56:20 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id sfVhYJe3m3jd; Mon, 29 Jan 2024 17:56:19 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 76BAB9C4650;
	Mon, 29 Jan 2024 17:56:19 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 76BAB9C4650
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1706568979; bh=KDGtC4FzTZzlXlycbP8AfeeUcJA8DdDr21H9KBNnofE=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=Ug86lLelzLWUoIl9K7HPpxaT4VCML4FzCkxfd3IeI++z7rkPgvhlcfMr8aM7OPnlJ
	 esGRPSAYtZJrosl9+mNPPw82+pRKPe/5DML95Hz8B0NZAHA0RPktdfjrD98Wut0Grl
	 5cZiWn4ehCos5YLnWg04Z9RIxpoWFWco6NiEtUFwF3F2+nXzFJ9/WtrDESZ5QOpHYs
	 ke1+C0I42q0FpfDmvIWHOVT1J1eM02kS/x1mOSCFsTuonlJP/bPb24gxzChtbiHs4x
	 1kyvsjzzLgq204jlM+unSCVoOreoO7MZ36koyrhJrMGsbAyId3mMePF5Q5ZwrMKSEX
	 GNSM92ZQrCeLA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 44GFnZux4IGD; Mon, 29 Jan 2024 17:56:19 -0500 (EST)
Received: from pcperry.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 5BA2B9C45C6;
	Mon, 29 Jan 2024 17:56:19 -0500 (EST)
From: Charles Perry <charles.perry@savoirfairelinux.com>
To: mdf@kernel.org
Cc: hao.wu@intel.com,
	yilun.xu@intel.com,
	trix@redhat.com,
	krzysztof.kozlowski+dt@linaro.org,
	bcody@markem-imaje.com,
	avandiver@markem-imaje.com,
	linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Charles Perry <charles.perry@savoirfairelinux.com>
Subject: [PATCH 2/3] dt-bindings: fpga: xlnx,fpga-slave-selectmap: add DT schema
Date: Mon, 29 Jan 2024 17:56:01 -0500
Message-ID: <20240129225602.3832449-2-charles.perry@savoirfairelinux.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129225602.3832449-1-charles.perry@savoirfairelinux.com>
References: <20240129225602.3832449-1-charles.perry@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Document the slave SelectMAP interface of Xilinx 7 series FPGA.

Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
---
 .../fpga/xlnx,fpga-slave-selectmap.yaml       | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,fpga-slav=
e-selectmap.yaml

diff --git a/Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-selec=
tmap.yaml b/Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-select=
map.yaml
new file mode 100644
index 0000000000000..20cea24e3e39a
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-selectmap.ya=
ml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/xlnx,fpga-slave-selectmap.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Slave SelectMAP FPGA
+
+description: |
+  Xilinx 7 Series FPGAs support a method of loading the bitstream over a
+  parallel port named the slave SelectMAP interface in the documentation=
 Only
+  the x8 mode is supported where data is loaded at one byte per rising e=
dge of
+  the clock, with the MSB of each byte presented to the D0 pin.
+
+  Datasheets:
+    https://www.xilinx.com/support/documentation/user_guides/ug470_7Seri=
es_Config.pdf
+
+properties:
+  compatible:
+    enum:
+      - xlnx,fpga-slave-selectmap
+
+  reg:
+    description:
+      At least 1 byte of memory mapped IO
+    maxItems: 1
+
+  prog_b-gpios:
+    description:
+      config pin (referred to as PROGRAM_B in the manual)
+    maxItems: 1
+
+  done-gpios:
+    description:
+      config status pin (referred to as DONE in the manual)
+    maxItems: 1
+
+  init-b-gpios:
+    description:
+      initialization status and configuration error pin
+      (referred to as INIT_B in the manual)
+    maxItems: 1
+
+  csi-b-gpios:
+    description:
+      chip select pin (referred to as CSI_B in the manual)
+      Optional gpio for if the bus controller does not provide a chip se=
lect.
+    maxItems: 1
+
+  rdwr-b-gpios:
+    description:
+      read/write select pin (referred to as RDWR_B in the manual)
+      Optional gpio for if the bus controller does not provide this pin.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - prog_b-gpios
+  - done-gpios
+  - init-b-gpios
+
+additionalProperties: true
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    &weim {
+      status =3D "okay";
+      ranges =3D <0 0 0x08000000 0x04000000>;
+
+      fpga_mgr: fpga_programmer@0,0 {
+        compatible =3D "xlnx,fpga-slave-selectmap";
+        reg =3D <0 0 0x4000000>;
+        fsl,weim-cs-timing =3D <0x00070031 0x00000142
+              0x00020000 0x00000000
+              0x0c000645 0x00000000>;
+        prog_b-gpios =3D <&gpio5 5 GPIO_ACTIVE_LOW>;
+        init-b-gpios =3D <&gpio5 8 GPIO_ACTIVE_LOW>;
+        done-gpios =3D <&gpio2 30 GPIO_ACTIVE_HIGH>;
+        csi-b-gpios =3D <&gpio3 19 GPIO_ACTIVE_LOW>;
+        rdwr-b-gpios =3D <&gpio3 10 GPIO_ACTIVE_LOW>;
+      };
+    };
+...
--=20
2.43.0


