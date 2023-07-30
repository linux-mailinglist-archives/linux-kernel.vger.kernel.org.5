Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89F776838B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 04:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjG3Czx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 22:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjG3Czv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 22:55:51 -0400
Received: from mail-40140.protonmail.ch (mail-40140.protonmail.ch [185.70.40.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D391998;
        Sat, 29 Jul 2023 19:55:50 -0700 (PDT)
Date:   Sun, 30 Jul 2023 02:55:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1690685748; x=1690944948;
        bh=V2KlmQUPdy0YQ4/qYeuVWWIA8jEfrAlasmUuWtmoJc4=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=jyiVzp8YOLQzPvjRttIH8odmFTdcihBSPRE+M6HxmdgIjA73qGCEGNnsGdCE/yBt7
         aAeGiqMMZOl6YI/CG31cyW0a1Hiw1/1CetCh1SdW61XNFkRm3eJygTPVDIXOsYT65L
         F6jfni4JnUXcMeyV0oAuRrCYoQC0XB6IME8z+JG99FfAW6YCxj8lB7WzXZyOViI1tJ
         QmX5V5M8zV9IApItXH+FRsiDkhAtLw4voei/PyxwhPYxqZRmhOGHbLg6cTJf47uqjk
         v7Rti7gq4Dl4Rs2r+QzOS7EVNJFTsXEo/sJW8+a6zymqweNJvaMDSB2NydpuJIGePf
         KeAOEz03MeLsw==
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
Subject: [PATCH] arm64: dts: qcom: msm8916-samsung-e5: Add touchscreen
Message-ID: <20230730025315.8579-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to A5, E5 uses a Melfas MMS345L touchscreen that is connected to
blsp_i2c5. Add it to the device tree.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 .../boot/dts/qcom/msm8916-samsung-e5.dts      | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-e5.dts b/arch/arm64/b=
oot/dts/qcom/msm8916-samsung-e5.dts
index 777eb934eb4b..bf0d128666d0 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-e5.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-e5.dts
@@ -22,3 +22,24 @@ / {
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
+=09=09interrupt-parent =3D <&tlmm>;
+=09=09interrupts =3D <13 IRQ_TYPE_EDGE_FALLING>;
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


