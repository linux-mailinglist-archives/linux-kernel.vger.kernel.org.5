Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE86D79173D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 14:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241268AbjIDMfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 08:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjIDMfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:35:32 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5D6EC;
        Mon,  4 Sep 2023 05:35:29 -0700 (PDT)
Date:   Mon, 04 Sep 2023 12:35:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1693830923; x=1694090123;
        bh=at8BjoFpddRw4d0u09ct+6YIxedFb1vgOg5Bk99QBFA=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=KaiugxjdVi2200gYrnmj2bVQJrdiArkOcEyPW21B82Y9TrR8aeUnbUteeHTzHpdF0
         z1GksSHP2z6D44HVmZpnUj7L3Fxju6y+P+n2K5fhN0tnxRg/XHUJhCCK6yKiF2QagI
         1Dmyp80rrygdKB8Jq5CHkW9+2lPzRKC5VCTv/qU4WquINryvn3Fk1CGFb6hcNI9SHT
         53Wj+ysqy1y+JYLlkeTEmcJ5WprMf9taeL7SV9CB9x786DTpkgsM2a2K6pxQ6kCzJl
         MjFQL7vLcu6TXlpANqF0TIgFKEY11+XyoiGYPs3nrlmPGEJRG+4L4lpbp092q3K8f3
         Ffrtno2HR8OMw==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>
Subject: [PATCH] arm64: dts: qcom: msm8916-samsung-j5-common: Add accelerometer
Message-ID: <20230904123123.2593-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markuss Broks <markuss.broks@gmail.com>

J5 and J5X have ST LIS2HH12 accelerometer.
Add support for it.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
Co-developed-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Co-developed-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 .../dts/qcom/msm8916-samsung-j5-common.dtsi   | 39 +++++++++++++++++++
 .../boot/dts/qcom/msm8916-samsung-j5.dts      |  5 +++
 .../boot/dts/qcom/msm8916-samsung-j5x.dts     | 15 +++++++
 3 files changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi b/arch=
/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
index cb0e4a7faf91..68e22873647f 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
@@ -84,6 +84,31 @@ muic: extcon@25 {
 =09=09=09pinctrl-0 =3D <&muic_int_default>;
 =09=09};
 =09};
+
+=09i2c_sensors: i2c-sensors {
+=09=09compatible =3D "i2c-gpio";
+
+=09=09sda-gpios =3D <&tlmm 31 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+=09=09scl-gpios =3D <&tlmm 32 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+
+=09=09pinctrl-0 =3D <&sensors_i2c_default>;
+=09=09pinctrl-names =3D "default";
+
+=09=09#address-cells =3D <1>;
+=09=09#size-cells =3D <0>;
+
+=09=09accelerometer: accelerometer@1d {
+=09=09=09compatible =3D "st,lis2hh12";
+=09=09=09reg =3D <0x1d>;
+
+=09=09=09interrupts-extended =3D <&tlmm 115 IRQ_TYPE_LEVEL_HIGH>;
+
+=09=09=09pinctrl-0 =3D <&accel_int_default>;
+=09=09=09pinctrl-names =3D "default";
+
+=09=09=09st,drdy-int-pin =3D <1>;
+=09=09};
+=09};
 };
=20
 &blsp_i2c5 {
@@ -147,6 +172,13 @@ &wcnss_iris {
 };
=20
 &tlmm {
+=09accel_int_default: accel-int-default-state {
+=09=09pins =3D "gpio115";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
 =09gpio_hall_sensor_default: gpio-hall-sensor-default-state {
 =09=09pins =3D "gpio52";
 =09=09function =3D "gpio";
@@ -187,6 +219,13 @@ sdc2_cd_default: sdc2-cd-default-state {
 =09=09bias-disable;
 =09};
=20
+=09sensors_i2c_default: sensors-i2c-default-state {
+=09=09pins =3D "gpio31", "gpio32";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
 =09tsp_int_default: tsp-int-default-state {
 =09=09pins =3D "gpio13";
 =09=09function =3D "gpio";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts b/arch/arm64/b=
oot/dts/qcom/msm8916-samsung-j5.dts
index 3e1ff5b4d2d7..58c2f5a70e78 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
@@ -10,6 +10,11 @@ / {
 =09chassis-type =3D "handset";
 };
=20
+&accelerometer {
+=09vdd-supply =3D <&pm8916_l5>;
+=09vddio-supply =3D <&pm8916_l5>;
+};
+
 &blsp_i2c5 {
 =09status =3D "disabled";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5x.dts b/arch/arm64/=
boot/dts/qcom/msm8916-samsung-j5x.dts
index b2fe109723d8..8b404a9cd62d 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5x.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5x.dts
@@ -23,6 +23,17 @@ reg_vdd_tsp_a: regulator-vdd-tsp-a {
 =09};
 };
=20
+&accelerometer {
+=09interrupts-extended =3D <&tlmm 49 IRQ_TYPE_LEVEL_HIGH>;
+
+=09vdd-supply =3D <&pm8916_l6>;
+=09vddio-supply =3D <&pm8916_l6>;
+
+=09mount-matrix =3D "0", "-1", "0",
+=09=09       "1", "0", "0",
+=09=09       "0", "0", "-1";
+};
+
 &muic {
 =09interrupts =3D <121 IRQ_TYPE_EDGE_FALLING>;
 };
@@ -40,6 +51,10 @@ tsp_ldo_en_default: tsp-ldo-en-default-state {
 =09};
 };
=20
+&accel_int_default {
+=09pins =3D "gpio49";
+};
+
 &muic_int_default {
 =09pins =3D "gpio121";
 };
--=20
2.39.2


