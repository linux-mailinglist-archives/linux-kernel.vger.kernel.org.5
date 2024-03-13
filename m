Return-Path: <linux-kernel+bounces-102623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5751487B4B8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6BFA1F2323A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F825D757;
	Wed, 13 Mar 2024 22:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="fCtBC6oJ"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BC320DDB;
	Wed, 13 Mar 2024 22:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710370693; cv=none; b=cO8dTGWXdcA3QLcd5LeKdKJ1cWxgdIxdl1+Gmhsb0B8Ecn4/mSwppsmtXe2mccR9KI8LnpgKuELUcv2lBH6MborYcYPNkmWX5Pf7opzimuzZjxxzGOOLs1tvIgJYD5O+Q4QtfRcSPbadd/gQYVnEipMly+s/uS/A0O2YeEyqn/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710370693; c=relaxed/simple;
	bh=mzeoWHmyDyEnfTFSLdQXvu023GNfuwJIAWkkP7EQrpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5jIpZN3RQbLrc8cUfFXpvi8ENudxetuMPvP/a4ZXETQXowaJ0McJ5OvWt77QZbdwMEH1fFDudhza551d8enrAbrc/KS/254XReEhxxDG2gH4qabQlrzNSwP6f+8jD0cRpaA61GFJr09b5supRKyYiYwDWTMoVxOpHwIgtPAyL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=fCtBC6oJ; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id DBBD79C5408;
	Wed, 13 Mar 2024 18:58:09 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id g7mtoDYOvCaV; Wed, 13 Mar 2024 18:58:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id CF7329C540C;
	Wed, 13 Mar 2024 18:58:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com CF7329C540C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1710370688; bh=/d1V79tcWO+y/0jgC7bixjyzj2GUzbqP7zTFzH0NAFw=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=fCtBC6oJOflpdyYf24NGICNN9zX2J6YMID1EpdGzItdoHl88CGt4JT4unVcfaCsC4
	 JWmRdYZMtEVXPewbWjOgegCzxIpeoSOwnob+PSBKcUO5ZsQj5GAYjEsKmV9Uy+K/H8
	 I5a48jJNp05VzifGpr4HUCY1Q4kOJbMvgcv875hoHObsPjxwRkVQ0G7UFqZON+WIgm
	 rNzijHZ5RFbVe1pywzuUltTG40znHbO33t4pJJpuLWyjcVAvOouueQKUrbGJeiB+Jn
	 icseluYLLfdk+c8i4PnE+6Y2mZpxOptE/YCAiqm/03E1BtnmQ5khqSRspSB9EUi3ff
	 tL0yD22nS7lTA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id EqkfmRMFk0ap; Wed, 13 Mar 2024 18:58:08 -0400 (EDT)
Received: from pcperry.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id AEA149C5408;
	Wed, 13 Mar 2024 18:58:08 -0400 (EDT)
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
Subject: [PATCH v5 2/3] dt-bindings: fpga: xlnx,fpga-selectmap: add DT schema
Date: Wed, 13 Mar 2024 18:57:36 -0400
Message-ID: <20240313225746.489253-3-charles.perry@savoirfairelinux.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313225746.489253-1-charles.perry@savoirfairelinux.com>
References: <20240313225746.489253-1-charles.perry@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Document the SelectMAP interface of Xilinx 7 series FPGA.

Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
---
Changes since v4: (from Yilun and Krzysztof review)
 * dt-bindings: remove usage of "_b" and "-b" for the new driver. We
   agreed that the spi and selectmap driver will use different bindings
   which will be handled by the driver core and that the legacy names wil=
l
   be used only for the spi compatible.

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
--
2.43.0

