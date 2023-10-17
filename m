Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171FE7CC095
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343684AbjJQKUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbjJQKU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:20:28 -0400
X-Greylist: delayed 3437 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Oct 2023 03:18:57 PDT
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A776E113;
        Tue, 17 Oct 2023 03:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1697537934; x=1697797134;
        bh=tUB6w0Ph20drmiGZYYSJujiE+ggt/zuWi7AKR0FbM+A=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=V6Gjnz01qj1zOsx8nMnmQ/Lv3GWM6nWGfm7XYVW+6btRn5s2Bo5PZ5kEDmb1As0S0
         Jdmk0vlWoPgXaecCPSnPb377l0AAe9UEWbvKK3/b+SraHsqe19SyJ0vRVd1EO99xzM
         oXzdYulZ+FtDY1Z+djG/zy9rDQv7oCFs6KimbdDyUlK+Bk8SxTiMWGQ0MlkcvSNFgw
         5ilsEZypHC/wYfWMdkBj/zxLCXeId1TQ3HoSHWkDtmFUegFpHqZntlLgnT1cgVBfAV
         wYNyywMEZ1sYmp7nhquxwT/AmIFEa/9Ha64ruvNfHig21KGIhkZWd9ekK0r6uGpvZC
         F/QSmuCfaxijA==
Date:   Tue, 17 Oct 2023 10:18:14 +0000
To:     linux-kernel@vger.kernel.org
From:   Raymond Hackley <raymondhackley@protonmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Raymond Hackley <raymondhackley@protonmail.com>
Subject: [PATCH v2 2/2] ARM: dts: samsung: exynos4412-midas: use Linux event codes for input keys
Message-ID: <20231017101647.62770-1-raymondhackley@protonmail.com>
In-Reply-To: <20231017101402.62740-1-raymondhackley@protonmail.com>
References: <20231017101402.62740-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use event codes with linux-event-codes.h included for input keys on midas.

Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
---
 arch/arm/boot/dts/samsung/exynos4412-midas.dtsi | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/samsung/exynos4412-midas.dtsi b/arch/arm/boo=
t/dts/samsung/exynos4412-midas.dtsi
index 3c1ae3c19828..d00b500254ab 100644
--- a/arch/arm/boot/dts/samsung/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4412-midas.dtsi
@@ -15,6 +15,7 @@
=20
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/clock/maxim,max77686.h>
 #include "exynos-pinctrl.h"
@@ -137,21 +138,21 @@ gpio-keys {
=20
 =09=09key-down {
 =09=09=09gpios =3D <&gpx3 3 GPIO_ACTIVE_LOW>;
-=09=09=09linux,code =3D <114>;
+=09=09=09linux,code =3D <KEY_VOLUMEDOWN>;
 =09=09=09label =3D "volume down";
 =09=09=09debounce-interval =3D <10>;
 =09=09};
=20
 =09=09key-up {
 =09=09=09gpios =3D <&gpx2 2 GPIO_ACTIVE_LOW>;
-=09=09=09linux,code =3D <115>;
+=09=09=09linux,code =3D <KEY_VOLUMEUP>;
 =09=09=09label =3D "volume up";
 =09=09=09debounce-interval =3D <10>;
 =09=09};
=20
 =09=09key-power {
 =09=09=09gpios =3D <&gpx2 7 GPIO_ACTIVE_LOW>;
-=09=09=09linux,code =3D <116>;
+=09=09=09linux,code =3D <KEY_POWER>;
 =09=09=09label =3D "power";
 =09=09=09debounce-interval =3D <10>;
 =09=09=09wakeup-source;
@@ -159,7 +160,7 @@ key-power {
=20
 =09=09key-ok {
 =09=09=09gpios =3D <&gpx0 1 GPIO_ACTIVE_LOW>;
-=09=09=09linux,code =3D <0x160>;
+=09=09=09linux,code =3D <KEY_OK>;
 =09=09=09label =3D "ok";
 =09=09=09debounce-interval =3D <10>;
 =09=09=09wakeup-source;
--=20
2.39.2


