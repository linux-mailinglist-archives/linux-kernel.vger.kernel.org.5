Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EF57CBEF8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343580AbjJQJWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbjJQJVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:21:46 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94E7106;
        Tue, 17 Oct 2023 02:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1697534496; x=1697793696;
        bh=OFdosyKcp6PhUrJ2tCBNQ9++8yaOxAtxpU+EBRrduxk=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=Y6ECVSLSwxbsC9spu35iGCIkBYplhs2ocrxGwobTOp1IeQHiBxrTITqbIBSmN350E
         UPAkm/sKtClLj4PWv/GgztKzCB/jhS94h27uWIovdrWaK/uK8o5QV9RZHDGQGbXo8n
         Xxs2WrGkhMAw6FkqR7UBz7CuhK/RBozUru/6ASbf8IRRRQmHK8HACsyUUBa9eoTpkw
         ZL9R2Gg8FDBVAFR/uYC6aJVIpMqA9MoQujeMoWBGL3yYoe1VKrbvx/TmP5ahRDkQaE
         Q4EA1bZ0bxVQP0z6Ptqd2++GrLdE7vBzUI4r67pQTJ4DxREFbEbYJnFZGyOrP4Tlxw
         ekPJbMgRZjVrQ==
Date:   Tue, 17 Oct 2023 09:21:30 +0000
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
Subject: [PATCH] ARM: dts: exynos: fix input keys with Linux event codes for midas
Message-ID: <20231017091953.43478-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Input event code 139 stands for KEY_MENU, instead of KEY_OK as key-ok
inplies. Fix all event codes with linux-event-codes.h included for midas.

Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
---
 arch/arm/boot/dts/samsung/exynos4412-midas.dtsi | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/samsung/exynos4412-midas.dtsi b/arch/arm/boo=
t/dts/samsung/exynos4412-midas.dtsi
index 7daf25865551..d00b500254ab 100644
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
-=09=09=09linux,code =3D <139>;
+=09=09=09linux,code =3D <KEY_OK>;
 =09=09=09label =3D "ok";
 =09=09=09debounce-interval =3D <10>;
 =09=09=09wakeup-source;
--=20
2.39.2


