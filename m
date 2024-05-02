Return-Path: <linux-kernel+bounces-166334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7268B992B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09CC61C20C2B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCF26A8AC;
	Thu,  2 May 2024 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="QgNZ/ikm"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4F160DCF;
	Thu,  2 May 2024 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714646420; cv=none; b=EtcvTWw+eV28DS5uqtxPOpEfX3ZXF5WW35/2qY2s+7sKQxXcfPBLy2sqOiW5rcAUPL+Ir8i6b3h51YJ/u+pyMTT1Lp3Fh1pIB+63aLl7vgVu7+Sw999o68I2YyQIDvaMhlUFeOvk40SV8iaDjS6I8dpc7voAvEEsZW8MJM5x3XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714646420; c=relaxed/simple;
	bh=gMCt5Iq5T+zQRh8ES75BAko3Tzsm5Fh8qCw+HGMCgfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QrkBMhmXdr1TU/576Wio8inj01W2krCgmmV7lyBRm+NzxkPRPlYjs0XF12mbKVieJoIk6KIQ59UbdhkuSy6fNd7YHtTp2vRtyseA7Vu20a5cBrx2cxLzIqfsniCEadNXGWD0XDdMN70hc7gSP0euZAd/Jj7j3AlQIwj/T4SPbTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=QgNZ/ikm; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1714646409; x=1715251209; i=j.neuschaefer@gmx.net;
	bh=L/WjbQC0Uxb9SVhmo+C44+NRCf/fM7QYCwbjyktZyvc=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QgNZ/ikmcNhUGzkceWnmNKR1XAtmX/MqYLTS5gMGSJlziMyl6mCqekrLqU0YMoqn
	 a5APTpQ8X/Srp2rIFKGP8gOf2F/l/yZVthgkvE/YmnaEVBQx4zx1Y9UoGWCQmMzFW
	 CMOpWAMyPsGhEdVi8T9jO652dnFr4TKE2hwltpe30IjzQK01WQwjha6VWZF6GA8vP
	 pioa/EaMamj0YpPxInbPXE3kGXRpKhLFKa1gSWXy9qd/2O+xl1hvsS4DlyhlxsX/6
	 nTnBj/S4+JbyQUPZtReD0k7+xXFVa0zaQtu65HVibscPysGq+uuiKLiOm03dmQ+iB
	 RSB69sErV8Vcr1dtlw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.1.59.78]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6Ue3-1s00sy1x97-008Ty4; Thu, 02
 May 2024 12:40:09 +0200
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Date: Thu, 02 May 2024 12:40:00 +0200
Subject: [PATCH v12 1/6] dt-bindings: clock: Add Nuvoton WPCM450
 clock/reset controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20240502-wpcm-clk-v12-1-1d065d58df07@gmx.net>
References: <20240502-wpcm-clk-v12-0-1d065d58df07@gmx.net>
In-Reply-To: <20240502-wpcm-clk-v12-0-1d065d58df07@gmx.net>
To: openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714646407; l=5540;
 i=j.neuschaefer@gmx.net; s=20240329; h=from:subject:message-id;
 bh=QPzdQUVDkB9QA3Xv6+gOkAHNqMRKKV6HeNLuZ6QtTHg=;
 b=jScqKHaCCM4wpdas5Q8IEiC4+jogSt+C1vQr+GGxaIt6XfDYmvN+772+LvhvyDRnzJBRzMxHO
 zAksyNaZt2MBGDJhh+vgxSzsnl+BbabtBP/njIrJDrVRcUgpzPz/TbB
X-Developer-Key: i=j.neuschaefer@gmx.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Provags-ID: V03:K1:5VER75uzSdDA4mmQwpBXPbQfADXqztMpC36lRk/cg57psmjNCBa
 yCGWxgpVP9EE//NF79nzToYwLyFiRyUyb3QbyNfILj+8mDSCVP6S4lX5W/wPiJUc1tjg9c1
 hR+wk99j1Z8JPY43DXXLYHVwqzPiWCt0IVdJEomraXDyJpujPi0B6RIMo7gtJt+o8oyjGCQ
 EyczDx7WrKWPKprax3RUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EtsfR5Rcu8o=;zumcOV0z+TRMIQaNPiRveTY8YfO
 e1nQ+aq3bItzoUKp+4vtKDa5GWn1C9kh4fC8hr27vtInhefUDVz3pAgnzFwEa88sYPkYbQcbs
 99Jho5WPf/rPalxfndgidW6NGYEUIMzBp06gLmKJpYaC/sir1LF+gGjoX1MwEObJk7OK9lRUa
 Zx3DtPtUnVV9mOMi9O8WLrQar483eXl9XgD/h3vPMwFFg+EpifiIEkL7cF4qSQNmx96QLD0sq
 DKeft5gMruVR7TG1TAHSnTIV42Umk/bwkJ6cr3O154vGqBwyfkgSTVGB0j+i/htD591jZ/FEh
 /UAvPFk7iByrhdsYG6+BhORRjpGuT+owOnavhVmTMMMYZYVKriOgdGeghl5oTM3MyGqL9CKg0
 KtYArW9fc42UXiy+9/fExpsbz7mTToXIW5JasI8HgDw80zBMVV6m8WSFreHgmKvsAaeoA0MkR
 fF4Nv823auZAeFSF8C4rk/6d/E7iXon9rLL6BSHoI4CAnLpAXvg6K3mh4DCbkr2k0DG7slD1Y
 eN3qDtmbl6RKVILw0oLECAhZXZSw6osdZojVTXXuOhGzBGtN5ZqIPhlVkTNKZGHuYASzzNlXr
 u3AOi/jKB3nTRqGL+2o1+whtbo9I46ESZCzinQlsSTv2W6r+LPeeKZfqy/aosUAsGlQl2uyiw
 tEgxM8B4VlBW3LJt7rjsYWE+BYWXS0JEqf1e5+zUJJ5xetyIXsmGaTh+Bn99fNs15Gl0okPGN
 v0Gv6c/USYPKPoFM0hjRM9JusV0uEmUW7ZOYh0XVXGasgWFnHEm5OdBAVnCZXO+LwGHgNauPR
 mmigDerSHeHMIBjNUrPGfyYTk7jwyRg8EhGUCtry4KpsQ=

The Nuvoton WPCM450 SoC has a combined clock and reset controller.
Add a devicetree binding for it, as well as definitions for the bit
numbers used by it.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
=2D--
v10-v11:
- no changes

v9:
- Remove clock-output-names in example, because it's now unnecessary due
  to driver improvements

v5-v8:
- no changes

v4:
- https://lore.kernel.org/lkml/20220610072141.347795-4-j.neuschaefer@gmx.n=
et/
- Add R-b tag

v3:
- Change clock-output-names and clock-names from "refclk" to "ref", sugges=
ted
  by Krzysztof Kozlowski

v2:
- https://lore.kernel.org/lkml/20220429172030.398011-5-j.neuschaefer@gmx.n=
et/
- Various improvements, suggested by Krzysztof Kozlowski

v1:
- https://lore.kernel.org/lkml/20220422183012.444674-5-j.neuschaefer@gmx.n=
et/
=2D--
 .../bindings/clock/nuvoton,wpcm450-clk.yaml        | 65 +++++++++++++++++=
++++
 include/dt-bindings/clock/nuvoton,wpcm450-clk.h    | 67 +++++++++++++++++=
+++++
 2 files changed, 132 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/nuvoton,wpcm450-clk.y=
aml b/Documentation/devicetree/bindings/clock/nuvoton,wpcm450-clk.yaml
new file mode 100644
index 00000000000000..93521cf68a040f
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/clock/nuvoton,wpcm450-clk.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/nuvoton,wpcm450-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton WPCM450 clock controller
+
+maintainers:
+  - Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
+
+description:
+  The clock controller of the Nuvoton WPCM450 SoC supplies clocks and res=
ets to
+  the rest of the chip.
+
+properties:
+  compatible:
+    const: nuvoton,wpcm450-clk
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Reference clock oscillator (should be 48 MHz)
+
+  clock-names:
+    items:
+      - const: ref
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+examples:
+  - |
+    #include <dt-bindings/clock/nuvoton,wpcm450-clk.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    refclk: clock-48mhz {
+      /* 48 MHz reference oscillator */
+      compatible =3D "fixed-clock";
+      clock-frequency =3D <48000000>;
+      #clock-cells =3D <0>;
+    };
+
+    clk: clock-controller@b0000200 {
+      reg =3D <0xb0000200 0x100>;
+      compatible =3D "nuvoton,wpcm450-clk";
+      clocks =3D <&refclk>;
+      clock-names =3D "ref";
+      #clock-cells =3D <1>;
+      #reset-cells =3D <1>;
+    };
diff --git a/include/dt-bindings/clock/nuvoton,wpcm450-clk.h b/include/dt-=
bindings/clock/nuvoton,wpcm450-clk.h
new file mode 100644
index 00000000000000..86e1c895921b71
=2D-- /dev/null
+++ b/include/dt-bindings/clock/nuvoton,wpcm450-clk.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_CLOCK_NUVOTON_WPCM450_CLK_H
+#define _DT_BINDINGS_CLOCK_NUVOTON_WPCM450_CLK_H
+
+/* Clocks based on CLKEN bits */
+#define WPCM450_CLK_FIU            0
+#define WPCM450_CLK_XBUS           1
+#define WPCM450_CLK_KCS            2
+#define WPCM450_CLK_SHM            4
+#define WPCM450_CLK_USB1           5
+#define WPCM450_CLK_EMC0           6
+#define WPCM450_CLK_EMC1           7
+#define WPCM450_CLK_USB0           8
+#define WPCM450_CLK_PECI           9
+#define WPCM450_CLK_AES           10
+#define WPCM450_CLK_UART0         11
+#define WPCM450_CLK_UART1         12
+#define WPCM450_CLK_SMB2          13
+#define WPCM450_CLK_SMB3          14
+#define WPCM450_CLK_SMB4          15
+#define WPCM450_CLK_SMB5          16
+#define WPCM450_CLK_HUART         17
+#define WPCM450_CLK_PWM           18
+#define WPCM450_CLK_TIMER0        19
+#define WPCM450_CLK_TIMER1        20
+#define WPCM450_CLK_TIMER2        21
+#define WPCM450_CLK_TIMER3        22
+#define WPCM450_CLK_TIMER4        23
+#define WPCM450_CLK_MFT0          24
+#define WPCM450_CLK_MFT1          25
+#define WPCM450_CLK_WDT           26
+#define WPCM450_CLK_ADC           27
+#define WPCM450_CLK_SDIO          28
+#define WPCM450_CLK_SSPI          29
+#define WPCM450_CLK_SMB0          30
+#define WPCM450_CLK_SMB1          31
+
+/* Other clocks */
+#define WPCM450_CLK_USBPHY        32
+
+#define WPCM450_NUM_CLKS          33
+
+/* Resets based on IPSRST bits */
+#define WPCM450_RESET_FIU          0
+#define WPCM450_RESET_EMC0         6
+#define WPCM450_RESET_EMC1         7
+#define WPCM450_RESET_USB0         8
+#define WPCM450_RESET_USB1         9
+#define WPCM450_RESET_AES_PECI    10
+#define WPCM450_RESET_UART        11
+#define WPCM450_RESET_MC          12
+#define WPCM450_RESET_SMB2        13
+#define WPCM450_RESET_SMB3        14
+#define WPCM450_RESET_SMB4        15
+#define WPCM450_RESET_SMB5        16
+#define WPCM450_RESET_PWM         18
+#define WPCM450_RESET_TIMER       19
+#define WPCM450_RESET_ADC         27
+#define WPCM450_RESET_SDIO        28
+#define WPCM450_RESET_SSPI        29
+#define WPCM450_RESET_SMB0        30
+#define WPCM450_RESET_SMB1        31
+
+#define WPCM450_NUM_RESETS        32
+
+#endif /* _DT_BINDINGS_CLOCK_NUVOTON_WPCM450_CLK_H */

=2D-
2.43.0


