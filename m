Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B2A754C0B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 22:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjGOUmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 16:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjGOUmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 16:42:01 -0400
Received: from mail-4027.protonmail.ch (mail-4027.protonmail.ch [185.70.40.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F6BB3;
        Sat, 15 Jul 2023 13:42:00 -0700 (PDT)
Date:   Sat, 15 Jul 2023 20:41:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1689453718; x=1689712918;
        bh=nfq894edfLj7KJhL0ovu2fYW+vNvVLWaaCXHQzABep4=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=vM9WFj3pCl919CeJU2Yds05u/oO4rBXT2D4TgG9upfKRf7EmrDYVfv6K8VeTo5nOX
         pQEkqNJd5UYhGOZd+2p/t8D5ifDa2g8aGfTBLlIzdgQauGCMucsiFf8EmId0E75v/a
         N38NjQzWTkEV04a0Wb/gbzpI1Q4dhilVqTH2yPW1m7bJ0t4GtqnK5t59mghaU8xJ5X
         QIxU/1W05c2SrDLKl/IGLOqFEs+90sRsSzbqkNHMYPfHWv4qTr9MZMzqoUxZjHdeFy
         K9PAVwRr0k3dZKXHr8feRXBuMxi60dv5mmGMM10LgtiN85Wbu+yB2I2wS7k4nTVv7y
         +SOcoIVo4ngug==
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
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH] arm64: dts: qcom: msm8916-samsung-e2015: Add accelerometer
Message-ID: <20230715204128.12612-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

E5, E7 and Grand Max have ST LIS2HH12 accelerometer.
Add support for it.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 .../qcom/msm8916-samsung-e2015-common.dtsi    | 21 +++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi b/a=
rch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
index 0cdd6af7817f..ef7c7ac40e05 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
@@ -42,10 +42,27 @@ reg_touch_key: regulator-touch-key {
=20
 &blsp_i2c2 {
 =09/* lis2hh12 accelerometer instead of BMC150 */
-=09status =3D "disabled";
-
 =09/delete-node/ accelerometer@10;
 =09/delete-node/ magnetometer@12;
+
+=09accelerometer@1d {
+=09=09compatible =3D "st,lis2hh12";
+=09=09reg =3D <0x1d>;
+
+=09=09interrupt-parent =3D <&msmgpio>;
+=09=09interrupts =3D <115 IRQ_TYPE_LEVEL_HIGH>;
+
+=09=09vdd-supply =3D <&pm8916_l5>;
+=09=09vddio-supply =3D <&pm8916_l5>;
+
+=09=09st,drdy-int-pin =3D <1>;
+=09=09mount-matrix =3D "1", "0", "0",
+=09=09=09       "0", "-1", "0",
+=09=09=09       "0", "0", "1";
+
+=09=09pinctrl-0 =3D <&accel_int_default>;
+=09=09pinctrl-names =3D "default";
+=09};
 };
=20
 &reg_motor_vdd {
--=20
2.39.2


