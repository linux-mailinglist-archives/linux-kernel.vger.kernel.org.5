Return-Path: <linux-kernel+bounces-110723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028F98862E7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A57B5286C93
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBF2136997;
	Thu, 21 Mar 2024 22:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="yIi5zWEa"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF7D13664F;
	Thu, 21 Mar 2024 22:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058775; cv=none; b=Kuyubp7hJ5uah+wQJOWSHoKXAi7TMY7j1KBoQej910vaqgD/0SOvuedjcBh/S+lGfinjb9LElQceFg+kPLczFphcy1BR2Yw/6iHn/Yn2Qf55J1NSNq/60cMlebRsJi4srqBC6qCelq7Jg/7jLetl+acj2nf0ri+6EafZEA4FFUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058775; c=relaxed/simple;
	bh=3jLKTcczzZnzhXLnlDgNt6ZDQuVI3dx0MeE/oTV0g00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvExwYthdsRJiF59st736gWqMlz/7e50b1GGKGNlNlWRay1uZ7VfK42GMR9T2A8mMZ8N4WiAtI2gDCbhAegf/63cRLUKUag0akQDLNbqkskX/eteTNwJPxjj52jHlj5OGMTSdpTQpsGPzwN/HvyGtVEq91MgiB5jMYi7aFoADjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=yIi5zWEa; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8029E9C52E9;
	Thu, 21 Mar 2024 18:06:07 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id h54AjYVSvKKB; Thu, 21 Mar 2024 18:06:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 7E15F9C544D;
	Thu, 21 Mar 2024 18:06:06 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 7E15F9C544D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1711058766; bh=MS/CSI1DQm+VcI/nbTmPkuznJvo8jK4CQm3471DDMa0=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=yIi5zWEaHjGMh04NmmTsOxht0wZxJHjdMXp3lvUhOdm449lmr5PMHX/Q3CkWi0Tju
	 ArfDJAgfcUIkS96wlEiUOj0PuOOZyGaXeeT4zSFV3e8jqJr9H5UJBB6URoru6s8O+T
	 rPDSMcuj9LHVxLheMjoHGNaye8pIehco4cJpw5oMCkzlxb/ASzM/5I94otiUcPyaH+
	 bRC1KwLUicnS99hdGKb6MdRYI4x607cM0o/tBAg1gTeK8vRfrah3XR3EucYvB2EUOk
	 6euVZJtauhtPjPxSUWCMxhtHm3KTVRqzqRzltlGAS1xd+KK81Typr2/PzvRWd4rjyW
	 FL+EhdCIpu1xg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id kqGEY5JAyOp5; Thu, 21 Mar 2024 18:06:06 -0400 (EDT)
Received: from pcperry.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 583259C52E9;
	Thu, 21 Mar 2024 18:06:06 -0400 (EDT)
From: Charles Perry <charles.perry@savoirfairelinux.com>
To: mdf@kernel.org
Cc: avandiver@markem-imaje.com,
	bcody@markem-imaje.com,
	Charles Perry <charles.perry@savoirfairelinux.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
Subject: [PATCH v6 2/4] dt-bindings: fpga: xlnx,fpga-selectmap: add DT schema
Date: Thu, 21 Mar 2024 18:04:34 -0400
Message-ID: <20240321220447.3260065-3-charles.perry@savoirfairelinux.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240321220447.3260065-1-charles.perry@savoirfairelinux.com>
References: <20240321220447.3260065-1-charles.perry@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Document the SelectMAP interface of Xilinx 7 series FPGA.

Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/fpga/xlnx,fpga-selectmap.yaml    | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,fpga-sele=
ctmap.yaml

diff --git a/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.y=
aml b/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
new file mode 100644
index 0000000000000..05775746fd706
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
@@ -0,0 +1,86 @@
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
+      - xlnx,fpga-xc7s-selectmap
+      - xlnx,fpga-xc7a-selectmap
+      - xlnx,fpga-xc7k-selectmap
+      - xlnx,fpga-xc7v-selectmap
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
+      compatible =3D "xlnx,fpga-xc7s-selectmap";
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


