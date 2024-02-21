Return-Path: <linux-kernel+bounces-75433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C76885E89D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80FFE1C22D84
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EED134CC0;
	Wed, 21 Feb 2024 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="v/ihWQHy"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE108134723;
	Wed, 21 Feb 2024 19:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708545138; cv=none; b=XA28kC/44cuTzNHYnM9oNeEJU18rZR7ejPiBXgRdMLruULvyXtdRloDzGWnzuPsZ8aBYxetwTF2XjXPrLqBCiCZXpoRnKeIh8KwfnCQsbS6ZeBiCvOUqk7zczRR1TMzqHgSbPmvSapbyERKglj0O5o9dYaGN1s+rlQPiSYZevTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708545138; c=relaxed/simple;
	bh=LlqHcE0YwJZlGexpmnxq7XZsurHwrFWJoYOL08Ka9UE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3aaZMzf50nQtHvuyQjZGYFlY2q85tM+S5CTLaDM2BLV3eTpRRlDhEbftn3E/bF+3sGsGO6WkODqeD5StMJFRh5HRXPVFgWqHOC/sva2x/SOBrllSYYvi5bKSu+FWG7zAuiHSHdikKUBm2OliIYY0HzZoTaqU6jITMxTS1NvZ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=v/ihWQHy; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5CF1D9C4B59;
	Wed, 21 Feb 2024 14:52:10 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 1HRkwdxDnQeV; Wed, 21 Feb 2024 14:52:09 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 74C559C4BEA;
	Wed, 21 Feb 2024 14:52:09 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 74C559C4BEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1708545129; bh=V0AloincpFNxqN8jxOVAcKyVY2ydGA1teB3GeWFAsDs=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=v/ihWQHyJwFqRDMtxygel1LYabD9lGZMscCI8GwNTwWtL5RAixkb9KbDSUombzccV
	 y299zfvVl9+wzPZJqYT3UUQdSKyz/Zdb6zm0S7xpb3DcTwW/3nYfCrrQ7eKMITj1wc
	 DkA1seyufzumAlMEsh/A4X3DLUulQcxKMnyRueri/CB4vh2ohgtmk15gK217pz5UoW
	 oIEDjjSN1YWqS90abXGCeksd7HWxTlJfE2k8C6JG4kTXLVCYB5FAz/bKg5Dtui1fGX
	 Hut0BZ26g4q7NrXBEW2OV9C+2fHYqIIzafcayiw6umLcLBqHdHmXkyB/bEeB4lunNd
	 l7+8fHW18nCMg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id inHxOnZgcdKg; Wed, 21 Feb 2024 14:52:09 -0500 (EST)
Received: from pcperry.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 503609C4B59;
	Wed, 21 Feb 2024 14:52:09 -0500 (EST)
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
Subject: [PATCH v4 2/3] dt-bindings: fpga: xlnx,fpga-selectmap: add DT schema
Date: Wed, 21 Feb 2024 14:50:48 -0500
Message-ID: <20240221195058.1281973-3-charles.perry@savoirfairelinux.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221195058.1281973-1-charles.perry@savoirfairelinux.com>
References: <20240221195058.1281973-1-charles.perry@savoirfairelinux.com>
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
 .../bindings/fpga/xlnx,fpga-selectmap.yaml    | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,fpga-sele=
ctmap.yaml

diff --git a/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.y=
aml b/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
new file mode 100644
index 0000000000000..08a5e92781657
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
+  - prog_b-gpios
+  - done-gpios
+  - init-b-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    fpga-mgr@8000000 {
+      compatible =3D "xlnx,fpga-xc7s-selectmap";
+      reg =3D <0x8000000 0x4>;
+      prog_b-gpios =3D <&gpio5 5 GPIO_ACTIVE_LOW>;
+      init-b-gpios =3D <&gpio5 8 GPIO_ACTIVE_LOW>;
+      done-gpios =3D <&gpio2 30 GPIO_ACTIVE_HIGH>;
+      csi-gpios =3D <&gpio3 19 GPIO_ACTIVE_LOW>;
+      rdwr-gpios =3D <&gpio3 10 GPIO_ACTIVE_LOW>;
+    };
+...
--=20
2.43.0


