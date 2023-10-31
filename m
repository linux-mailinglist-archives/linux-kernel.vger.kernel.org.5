Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9F27DD11E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344824AbjJaQBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344856AbjJaQBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:01:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4322FE;
        Tue, 31 Oct 2023 09:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1698768068; x=1699372868; i=rwahl@gmx.de;
        bh=2amWrJACc8qSaje+/sHjHwmHFxanJF0oJSla/8F+B1M=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=DUqP149HKohHM7cHCNOUi+71yGEXRQPdBKoVlf235wbz5DgvgMZyK0OICLCghWQR
         O6MfvxPtr4wSbk+Eh/FUgVjk0bcjyxkSkPps+imDn9kLuxtcaprNUjPhk14s2RMhf
         C8D27rqnSvA+E6YhGcHKN1SyuR/IryJZIYevKmLSMS+StfG0+XNL5aUQNEWo3uabP
         7X8iLKLPbUt9/fgATiE0bcR+IDRp8YE7FcXHGJMVIX2im7IS9Jywu4UMR0Vq8ojgt
         2g/XZNSVwrqyC9TFeb3XRm+wotIE5rb9fqX/IAb6CMASZNfXfzgUxw3AjI63kjBV5
         pU8QG+4sjHzBeZmrDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rohan.localdomain ([84.156.147.134]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCbIn-1r6trr2AKp-009iOf; Tue, 31
 Oct 2023 17:01:08 +0100
From:   Ronald Wahl <rwahl@gmx.de>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan Brattlof <bb@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Ronald Wahl <ronald.wahl@raritan.com>
Subject: [PATCH] arm64: dts: ti: k3-am62-main: Add gpio-ranges properties
Date:   Tue, 31 Oct 2023 17:00:55 +0100
Message-ID: <20231031160055.20200-1-rwahl@gmx.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SA12WqvB6o/Fsv0cLnUtbNF6+IIdHKGf22JYioQk2aaowzU5kDS
 nwoa6Ap7fCJdCuyr/SLvVnEhhkfrccXlrfHGcT+HvR7Orc0YHqSMzBAg8l6eRbhY34o3GrA
 Q+wILIy25L1SYk6P07j4GRGGFsJ3qwkQlfyhrCNhxsHN/yMSCBzmOCQ/Eh4IWn/Mkmx28CJ
 1TEXJVX8732ZBNtkXV8cg==
UI-OutboundReport: notjunk:1;M01:P0:6of6ICLBKso=;oW6aELO6oIwT8vt6wQMuot4NQXD
 BWrnR1uSQ3jDuB4v/R+9dln3OK7PTtRH+bxLClwqr02hjkVnj3YppupTXKCp8SZd9KoaMjVtQ
 iruqBLYW9ccdOCK+CIBRbxXSMZPb2Gf8tO7gxEgIX4lejV7yiJK8iyoklB0tKJZw0A8gPdDTp
 RUL1jz9ux4ecbg8wTtecQA/kBolkgYkFDEgzE9S3l6eh8c4lNqsIcoaHaSNfMwHe6Tjyk1mbs
 1MfKooVc0K0jr4TBfVVjJqWoMu2kz+AtqKnPoiovZNgAYDbRhX/FHBeQRZ6fbXngZ9B3pMg21
 VeEfX0LtIgIytDU5s4Ry5i2AWTNmyvr9b7XOGj1HcPpuYlsyRl3X1QhMg1dH91NYvgy5JoR1O
 JdSDbBgSB978z4fcQY2pJZWl5C6yGxMGSkmoxuwBqw69e7NPpQ1hBEmPLjTkzE3PBk0nQVaBz
 peTI3SF24LnaSSVn3uOh6snOSA0GuLdj14mrq9vaU7kZ4Yb34kJ7iACZjau/9BC6I9dx8k08E
 6sgVvD7jr7nSTj5jAubpSdhqsNCcAUA61T2gC6kgQqlQh8+IS1m/pPGoIkeSSaOJzynrVYFDA
 vsxHDI6VYPfi2g1JbJBMXYnSxgB6AfqIabXEb+57mZk2U9GkDrr/bNDBj9hw1EFQSiLAioAYA
 oIdjLu508pLPTskYI+H6uLwOEZLENDgi3FEBA2bT4WHyZcJKwXKKIFGPQ0WKzFz/Hy4Mx9VTg
 NfuKOnK9DPExlytj6zCzlxAUZbHoxEIUxXvuceitPxWLHh9drSzO9K7MyI+rYirizixD5/gt/
 OX
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

