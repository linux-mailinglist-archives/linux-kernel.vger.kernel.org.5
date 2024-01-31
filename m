Return-Path: <linux-kernel+bounces-47337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CA1844CA5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C358A1F22DFC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7F84174F;
	Wed, 31 Jan 2024 23:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="u3GWrzQD"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AAF3AC01;
	Wed, 31 Jan 2024 23:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742382; cv=none; b=pg8gfKauiuu88QbSVZMkOhDfoVlWZPoxj1JWaF4sL6PBJK1AkCYo49+ZwWTqB+4sESmABJS0L95XXVSqvcbcnSkd7I61QFQiSzD1REDfULphdvRGxYi/3iR/fST4VUV1MsGYnOimNg4y6uv8yGiRGKgz0krnBq6CGjA/P75rwT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742382; c=relaxed/simple;
	bh=4wZ7PI2bLEkF9E1BRl0PwdJvRJTX1sJZchySflNwG0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shEcJnemNQ36YdbPw0p2HBfyHWq+nrS0rK78apN1uvGhLjsoIB0v6x7H3r+a9pf0zQOz3ox+A1hwds0Zml85BS+2EA9FCMtQJ2v3bSmkIyf2Kyuw90AH5kFOTpGAtAgVaBKqZuNO4DEQLqUZlXopEtuAyX81KXYlliC6TvddGJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=u3GWrzQD; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D2E169C2C74;
	Wed, 31 Jan 2024 18:06:18 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id HiUU4rlm9KN4; Wed, 31 Jan 2024 18:06:18 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 4B0889C3278;
	Wed, 31 Jan 2024 18:06:18 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 4B0889C3278
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1706742378; bh=dgN2vn3/cP5r2aYUFdkQveLiQbFbD9JN5zRJxM00TKs=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=u3GWrzQDnmdT2KV6rUqiFsaPX66hcejajkBF6HDigl6ZnSAVtsP4dXsEJ7kxNETmU
	 y9UhogRLqDqhVEjpOI/CSRY2lupmDI0RpKSIpxN+FGUKRn6dWD6p8FtAlMerzKSa46
	 +HvFAX+g6cmzlWkJTVfIUIXUUFSyJFQr8rd1NM0MGlwoEQZq5YQW2ECCtA2cz11FHk
	 hvaUZxteTNlk4OrFF+OaNFb0krb1DekUcQc6JRer7Db6DmSL+GRxwNmgYD7kgCyNxm
	 1G1mad5PA2Z+blM9r67av0KMy4cQLulfk4f+GV0Dq1mFXWpEshIkJPopDZs1oFcMyp
	 /nHguV2eMiZ6A==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id XLiIouecNLN8; Wed, 31 Jan 2024 18:06:18 -0500 (EST)
Received: from pcperry.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 29ED79C2C74;
	Wed, 31 Jan 2024 18:06:18 -0500 (EST)
From: Charles Perry <charles.perry@savoirfairelinux.com>
To: mdf@kernel.org
Cc: avandiver@markem-imaje.com,
	bcody@markem-imaje.com,
	Charles Perry <charles.perry@savoirfairelinux.com>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] dt-bindings: fpga: xlnx,fpga-slave-selectmap: add DT schema
Date: Wed, 31 Jan 2024 18:05:32 -0500
Message-ID: <20240131230542.3993409-3-charles.perry@savoirfairelinux.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131230542.3993409-1-charles.perry@savoirfairelinux.com>
References: <20240129225602.3832449-1-charles.perry@savoirfairelinux.com>
 <20240131230542.3993409-1-charles.perry@savoirfairelinux.com>
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
 .../bindings/fpga/xlnx,fpga-selectmap.yaml    | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,fpga-sele=
ctmap.yaml

diff --git a/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.y=
aml b/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
new file mode 100644
index 0000000000000..c9a446b43cdd9
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/xlnx,fpga-selectmap.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx SelectMAP FPGA interface
+
+maintainers:
+  - Charles Perry <charles.perry@savoirfairelinux.com>
+
+description: |
+  Xilinx 7 Series FPGAs support a method of loading the bitstream over a
+  parallel port named the SelectMAP interface in the documentation. Only
+  the x8 mode is supported where data is loaded at one byte per rising e=
dge of
+  the clock, with the MSB of each byte presented to the D0 pin.
+
+  Datasheets:
+    https://www.xilinx.com/support/documentation/user_guides/ug470_7Seri=
es_Config.pdf
+
+allOf:
+  - $ref: /schemas/memory-controllers/mc-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - xlnx,fpga-selectmap
+
+  reg:
+    description:
+      At least 1 byte of memory mapped IO
+    maxItems: 1
+
+  prog-gpios:
+    description:
+      config pin (referred to as PROGRAM_B in the manual)
+    maxItems: 1
+
+  done-gpios:
+    description:
+      config status pin (referred to as DONE in the manual)
+    maxItems: 1
+
+  init-gpios:
+    description:
+      initialization status and configuration error pin
+      (referred to as INIT_B in the manual)
+    maxItems: 1
+
+  csi-gpios:
+    description:
+      chip select pin (referred to as CSI_B in the manual)
+      Optional gpio for if the bus controller does not provide a chip se=
lect.
+    maxItems: 1
+
+  rdwr-gpios:
+    description:
+      read/write select pin (referred to as RDWR_B in the manual)
+      Optional gpio for if the bus controller does not provide this pin.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - prog-gpios
+  - done-gpios
+  - init-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    fpga-mgr@8000000 {
+      compatible =3D "xlnx,fpga-selectmap";
+      reg =3D <0x8000000 0x4>;
+      prog-gpios =3D <&gpio5 5 GPIO_ACTIVE_LOW>;
+      init-gpios =3D <&gpio5 8 GPIO_ACTIVE_LOW>;
+      done-gpios =3D <&gpio2 30 GPIO_ACTIVE_HIGH>;
+      csi-gpios =3D <&gpio3 19 GPIO_ACTIVE_LOW>;
+      rdwr-gpios =3D <&gpio3 10 GPIO_ACTIVE_LOW>;
+    };
+...
--=20
2.43.0


