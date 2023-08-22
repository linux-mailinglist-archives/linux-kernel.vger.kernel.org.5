Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9116C7844A0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbjHVOo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjHVOoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:44:55 -0400
X-Greylist: delayed 1201 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Aug 2023 07:44:54 PDT
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2ED124
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:44:54 -0700 (PDT)
Date:   Tue, 22 Aug 2023 14:07:12 +0000
Authentication-Results: mail-4321.protonmail.ch;
        dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="NkKE019C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1692713242; x=1692972442;
        bh=JEDTfL56eXEIhpOtCWICTMLAmzOWWYiVCdprm1DzGsU=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=NkKE019CJSwybWgcTWCsiIbtG2U/0fsiND61i/rYNC7EUAJ2morhKQYvqKwrAUaOX
         QVIA/i+ghWY1oUR3E+DjN+Uz0qFvQRdU6PclG4ubNmnmJUaHUQgVv694jJvZRp+UjT
         js2QvYNXCxfH8ug4DfnRBWYI2MUJm430RugCWWTBmN8rSLYge+yHK/J9Bl6sQYHS3O
         YOtfheNzXox7Ttzp5dXE7//W1xEGV3w8+GNHT9HyOo0z8vE1EcRVMv7HqDsK+zoIzM
         t/g+Vd3SiUfY/B50KH0UhFSljNNiO+IQpg4TRM5EucNiex18kSSQqXmUhk5CXb30HV
         38x83dOfurWEA==
To:     linux-kernel@vger.kernel.org
From:   Raymond Hackley <raymondhackley@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH] arm64: dts: qcom: msm8916/39-samsung-a2015: Add flash LED
Message-ID: <20230822140407.3316-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The phones listed below have Richteck RT5033 LED, which has GPIO pin
configurations similar to SGM3140 Flash LED driver.
Add it to the device trees.

- Samsung Galaxy A3/A5/A7 2015
- Samsung Galaxy E5/E7
- Samsung Galaxy Grand Max

Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
---
 .../qcom/msm8916-samsung-a2015-common.dtsi    | 23 +++++++++++++++++++
 .../boot/dts/qcom/msm8939-samsung-a7.dts      | 23 +++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/a=
rch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
index 019bf73178fa..48990716cafd 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
=20
 / {
@@ -36,6 +37,21 @@ clk_pwm: pwm {
 =09=09status =3D "disabled";
 =09};
=20
+=09flash-led-controller {
+=09=09compatible =3D "richtek,rt5033-led";
+=09=09enable-gpios =3D <&tlmm 34 GPIO_ACTIVE_HIGH>;
+=09=09flash-gpios =3D <&tlmm 36 GPIO_ACTIVE_HIGH>;
+
+=09=09pinctrl-0 =3D <&camera_flash_default>;
+=09=09pinctrl-names =3D "default";
+
+=09=09flash_led: led {
+=09=09=09function =3D LED_FUNCTION_FLASH;
+=09=09=09color =3D <LED_COLOR_ID_WHITE>;
+=09=09=09flash-max-timeout-us =3D <544000>;
+=09=09};
+=09};
+
 =09gpio-keys {
 =09=09compatible =3D "gpio-keys";
=20
@@ -293,6 +309,13 @@ accel_int_default: accel-int-default-state {
 =09=09bias-disable;
 =09};
=20
+=09camera_flash_default: camera-flash-default-state {
+=09=09pins =3D "gpio34", "gpio36";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
 =09fg_alert_default: fg-alert-default-state {
 =09=09pins =3D "gpio121";
 =09=09function =3D "gpio";
diff --git a/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts b/arch/arm64/b=
oot/dts/qcom/msm8939-samsung-a7.dts
index ba652909d162..8d00a2328ca8 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
@@ -7,6 +7,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/leds/common.h>
=20
 / {
 =09model =3D "Samsung Galaxy A7 (2015)";
@@ -31,6 +32,21 @@ tz-apps@85500000 {
 =09=09};
 =09};
=20
+=09flash-led-controller {
+=09=09compatible =3D "richtek,rt5033-led";
+=09=09enable-gpios =3D <&tlmm 34 GPIO_ACTIVE_HIGH>;
+=09=09flash-gpios =3D <&tlmm 36 GPIO_ACTIVE_HIGH>;
+
+=09=09pinctrl-0 =3D <&camera_flash_default>;
+=09=09pinctrl-names =3D "default";
+
+=09=09flash_led: led {
+=09=09=09function =3D LED_FUNCTION_FLASH;
+=09=09=09color =3D <LED_COLOR_ID_WHITE>;
+=09=09=09flash-max-timeout-us =3D <544000>;
+=09=09};
+=09};
+
 =09gpio-hall-sensor {
 =09=09compatible =3D "gpio-keys";
=20
@@ -360,6 +376,13 @@ accel_int_default: accel-int-default-state {
 =09=09bias-disable;
 =09};
=20
+=09camera_flash_default: camera-flash-default-state {
+=09=09pins =3D "gpio34", "gpio36";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
 =09fg_alert_default: fg-alert-default-state {
 =09=09pins =3D "gpio121";
 =09=09function =3D "gpio";
--=20
2.39.2


