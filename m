Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936C2779DDA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 09:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjHLHRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 03:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjHLHRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 03:17:05 -0400
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0A630D2;
        Sat, 12 Aug 2023 00:17:05 -0700 (PDT)
Date:   Sat, 12 Aug 2023 07:16:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1691824622; x=1692083822;
        bh=wloyDf2AvvZTQdPHrX71Q0Ws9rmThiu4roUkb67nTc4=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=VIaky06o9ZRLuUwaGnEi8dJFW5k1FDUqLG5uaD2Luu+Ea6hXdL1BLD1Ido7E0ZRuJ
         7rRoBbtzB0mqm7qcCvYSm4DFiQniFGa40iyogd1HPMUx7SRL0oL0JFliNQ3gJk3VD+
         DfBqhPMSHRNqutppytprFgFtCOaQck9hSLmhXC8O+SPifMpUUcb4swWHFzNGd01g5K
         VXaGzRVLfFITTUslx4MJ9tJyjUWmvwkXlnOyYSegyHXFTmSMpIQHNUyiRagt8tytUW
         uXYFM/B0zprHztIQxYBvc0yn5fD5K2xyuVuKokTUZzdDZiGDHzwz6ickY1VJ9vOJ4X
         Z1ZKtoECsRCrA==
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
Subject: [PATCH v2] arm64: dts: qcom: msm8916-samsung-e5: Add touchscreen
Message-ID: <20230812071448.4710-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to A5, E5 uses a Melfas MMS345L touchscreen that is connected to
blsp_i2c5. Add it to the device tree.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
v2: use interrupts-extended
 .../boot/dts/qcom/msm8916-samsung-e5.dts      | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-e5.dts b/arch/arm64/b=
oot/dts/qcom/msm8916-samsung-e5.dts
index 777eb934eb4b..fad2535255f7 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-e5.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-e5.dts
@@ -22,3 +22,23 @@ / {
 =09compatible =3D "samsung,e5", "qcom,msm8916";
 =09chassis-type =3D "handset";
 };
+
+&blsp_i2c5 {
+=09status =3D "okay";
+
+=09touchscreen@48 {
+=09=09compatible =3D "melfas,mms345l";
+=09=09reg =3D <0x48>;
+
+=09=09interrupts-extended =3D <&tlmm 13 IRQ_TYPE_EDGE_FALLING>;
+
+=09=09touchscreen-size-x =3D <720>;
+=09=09touchscreen-size-y =3D <1280>;
+
+=09=09avdd-supply =3D <&reg_vdd_tsp_a>;
+=09=09vdd-supply =3D <&pm8916_l6>;
+
+=09=09pinctrl-0 =3D <&ts_int_default>;
+=09=09pinctrl-names =3D "default";
+=09};
+};
--=20
2.39.2


