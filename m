Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4626A7F9E90
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjK0L1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbjK0L1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:27:36 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909AE10A;
        Mon, 27 Nov 2023 03:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1701084438; x=1701689238; i=rwahl@gmx.de;
        bh=2amWrJACc8qSaje+/sHjHwmHFxanJF0oJSla/8F+B1M=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=hK+aMpEGKtjwnuyfDAH3rXunntmy8vQ6ugU8UyEP3/xUHM273qidzh79QI4vtTBk
         zBiF/aBZwvFq9+CL/df11DeDfhyxoy4qT5wde0XU10QXanPkGgIbTQzcQzObnG2TB
         uSmKLprHI25uK4/tQwCCQuUTZiI6Xr8Jn+fIUP9qI3qCJJGuJX7iCIrHIFRNy1wfY
         uee/2ICjgRxvWhyClKtfcglUUUIkJKhi54zTqxiqbukWCiWW80nIVi3Pn/t2I3RAE
         TrrYsChzRNCt5qtX6W0k7VZxqXq+6r6JTlSW/lfUgh33szh+azzG/mR+ioIPQgq2T
         rlukpqXnbvMVrjfa5Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rohan.localdomain ([84.156.159.24]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s4r-1r7IWH1wXf-0023Db; Mon, 27
 Nov 2023 12:27:18 +0100
From:   Ronald Wahl <rwahl@gmx.de>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan Brattlof <bb@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Ronald Wahl <ronald.wahl@raritan.com>
Subject: [PATCH RESEND] arm64: dts: ti: k3-am62-main: Add gpio-ranges properties
Date:   Mon, 27 Nov 2023 12:26:57 +0100
Message-ID: <20231127112657.2692103-1-rwahl@gmx.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QinziaHniGAksgaiTDEcGuOV9M9mixaCm3bbnBulSSGtPvLFtpE
 oZF1YyX/56c1HRfGgX1/h2RbN6xQrPWcsmmliGqvbq7v/2RzC89Ihk8F7FwjoqYdERelZNW
 FIArsjAGsOGEwL1AusY8RUDe+Yb+RZWaErWK4TJlJBZHTotIl/BWzqBK5Qr74ONMhJQuQAG
 fThhNKWjanG+Ur6yLUhSw==
UI-OutboundReport: notjunk:1;M01:P0:z9rK+5kZQOo=;EUokD9aqwJPbzieYo0Kci1Dy2WQ
 3BLJJ8NSd5tVlHYQE1BFeA9jdzkStrDY0rRw4ociZ05mEEM44ULQry7Dv8CXILSzdSDVm4bYQ
 o7zEH4uVS+yAoTL4tbGGLUIpsfwZpSP3GAJN/zihKnIal2pjWE/f3I4A0qrFBmuz/g5gCJ3jz
 bYO5tu9dYQeUYucAVR8cywIGa+BQwV3kdDLTuHmaak08WDPkFWRBwJpoD4DNxXYqbxa103mED
 OqoO70jKPimKn05jFfoKneg7mjRGfsqA7IhNdGbRyQZDkAPOgtjYqPnWlGQGZ58b2N7zXdYJ5
 BDWOF4u/PKgDDxpYvlUrufvM0nn7B3d9fSwy86PjYZ6EFtQzMewplP+/9aUM7t7Fanv/TExTd
 ux5AQaKPsvHArgTdgYTXDNV8mxUsKr4sXv/XSwiytwcDS2jCbhmsM219Ftn0avME722IcIebJ
 WzzHFaKT8rXPp7jASf07FMBRs7ZBEqdc6crWXlc4xfHHl9JcfkLyBuxN7/ilDeciuVQTqUriH
 X/fOd5puv3C+ES0DgrGshwxd4/EnIVMNAt09RJeXgo11GWCx8t3E9pjlZcUJTsxq2e4Hl2HAd
 JR2xnq6m7fnSaYlJ7c9EsSyo5wajvRe0JFuPM2ANtg+0EufeCK76jA/6JWyhpKbUNffzJDUnB
 3J8YrcHIQ/1NDJMOPGHVEEby9ApqD2yxORim9daXCI0ggi/qu6MzCYoPhG4dOiBbC0p/dsCpS
 nEg5Ol25ueoiAFCeYj/+qbHEc+oOZnFC1gklOIUeCflNseO0+rWqRKMV25Sc3RXQkOTL08gxc
 efO6ZmvOWPJ8wECf1SVSQVxmS2od/9O8GcixWN7hR+RdD4MqcMJQkb08OVAG5dnjk88pPw03R
 HsTtyTy0SAsx+5QBU9dwX2hPSDV7vXSTPGJjtFody4wTaiVQf9IuFjMdi/5xXN25Q041asTCs
 VGfMMg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronald Wahl <ronald.wahl@raritan.com>

On the AM62 platform we have no single 1:1 relation regarding index of
gpio and pin controller. Actually there are some linear ranges with
small holes inbetween. These ranges can be represented with the
gpio-ranges device tree property. They have been extracted manually
from the AM62x datasheet (Table 6-1. Pin Attributes).

Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
=2D--
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dt=
s/ti/k3-am62-main.dtsi
index 284b90c94da8..587d197e82c4 100644
=2D-- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -492,6 +492,9 @@ main_gpio_intr: interrupt-controller@a00000 {
 	main_gpio0: gpio@600000 {
 		compatible =3D "ti,am64-gpio", "ti,keystone-gpio";
 		reg =3D <0x0 0x00600000 0x0 0x100>;
+		gpio-ranges =3D <&main_pmx0  0  0 32>,
+			      <&main_pmx0 32 33 38>,
+			      <&main_pmx0 70 72 22>;
 		gpio-controller;
 		#gpio-cells =3D <2>;
 		interrupt-parent =3D <&main_gpio_intr>;
@@ -510,6 +513,10 @@ main_gpio1: gpio@601000 {
 		compatible =3D "ti,am64-gpio", "ti,keystone-gpio";
 		reg =3D <0x0 0x00601000 0x0 0x100>;
 		gpio-controller;
+		gpio-ranges =3D <&main_pmx0  0  94 41>,
+			      <&main_pmx0 41 136  6>,
+			      <&main_pmx0 47 143  3>,
+			      <&main_pmx0 50 149  2>;
 		#gpio-cells =3D <2>;
 		interrupt-parent =3D <&main_gpio_intr>;
 		interrupts =3D <180>, <181>, <182>,
=2D-
2.41.0

