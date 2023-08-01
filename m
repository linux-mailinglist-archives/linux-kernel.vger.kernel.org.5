Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBB176B326
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbjHALYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbjHALXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:23:38 -0400
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C170EB2;
        Tue,  1 Aug 2023 04:23:05 -0700 (PDT)
Date:   Tue, 01 Aug 2023 11:22:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1690888983; x=1691148183;
        bh=/GbdM8wTz38mFTXJXJcRCr+lPwpUtRE7lW/yp7qtVLY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Qa9Xr1mcVm25LuHUedB9uIoa86cCeHZ7ol8EWuvfnw91sipA+vvchEBCfwzINcPgw
         TQD3G0x2HHXL41CMUWyvM70KpLCEoelsC+tsncsPs+E4lpqQKn6LHSahRGzYBRvUuH
         S3KXaQeSBXLgyUC2z4BFV5tFa+EY8Fck+8jFrd0n+C3g5yejqTCXflpdphRa5x5sIf
         nErACxz9T8gmk+RcYKfPrsWUfVAYfVd3hSVu8NNL4x/4Tk+VRyuSaPxkkfer6p5Wi7
         aOjz5YYwPcRJNSu66nnt7As0A2xnHHbMdrV8KUr7c+ixUjHoRsEqy1lvIt4JR5TgcH
         kS0mPalOoAAXQ==
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
        Gareth Peoples <mail@gpeopl.es>
Subject: [PATCH v2 3/3] ARM: dts: qcom-msm8916-samsung-fortuna: Include dts from arm64
Message-ID: <20230801112134.4689-1-linmengbo0689@protonmail.com>
In-Reply-To: <20230801111745.4629-1-linmengbo0689@protonmail.com>
References: <20230801111745.4629-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After adding all necessary support for MSM8916 SMP/cpuidle without PSCI
on ARM32, build fortunaltezt and heatqlte device trees from the arm64
tree together with the ARM32 include to allow booting this device on ARM32.

The approach to include device tree files from other architectures is
inspired from e.g. the Raspberry Pi (bcm2711-rpi-4-b.dts) where this is
used to build the device tree for both ARM32 and ARM64.

[Add workaround to TSENS problem]
Co-developed-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
[Add heatqlte]
Co-developed-by: Gareth Peoples <mail@gpeopl.es>
Signed-off-by: Gareth Peoples <mail@gpeopl.es>
Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 arch/arm/boot/dts/qcom-msm8916-samsung-fortunaltezt.dts | 8 ++++++++
 arch/arm/boot/dts/qcom-msm8916-samsung-heatqlte.dts     | 8 ++++++++
 arch/arm/boot/dts/qcom/Makefile                         | 2 ++
 3 files changed, 18 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-msm8916-samsung-fortunaltezt.dts
 create mode 100644 arch/arm/boot/dts/qcom-msm8916-samsung-heatqlte.dts

diff --git a/arch/arm/boot/dts/qcom-msm8916-samsung-fortunaltezt.dts b/arch=
/arm/boot/dts/qcom-msm8916-samsung-fortunaltezt.dts
new file mode 100644
index 000000000000..b9704fea7029
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-msm8916-samsung-fortunaltezt.dts
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "arm64/qcom/msm8916-samsung-fortunaltezt.dts"
+#include "qcom-msm8916-smp.dtsi"
+
+&tsens {
+=09/* FIXME: The device crashes when accessing the SROT region for some re=
ason */
+=09status =3D "disabled";
+};
diff --git a/arch/arm/boot/dts/qcom-msm8916-samsung-heatqlte.dts b/arch/arm=
/boot/dts/qcom-msm8916-samsung-heatqlte.dts
new file mode 100644
index 000000000000..ec3edd4f31c3
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-msm8916-samsung-heatqlte.dts
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "arm64/qcom/msm8916-samsung-heatqlte.dts"
+#include "qcom-msm8916-smp.dtsi"
+
+&tsens {
+=09/* FIXME: The device crashes when accessing the SROT region for some re=
ason */
+=09status =3D "disabled";
+};
diff --git a/arch/arm/boot/dts/qcom/Makefile b/arch/arm/boot/dts/qcom/Makef=
ile
index 3dfb1c8cefb8..746d7aa940d9 100644
--- a/arch/arm/boot/dts/qcom/Makefile
+++ b/arch/arm/boot/dts/qcom/Makefile
@@ -27,7 +27,9 @@ dtb-$(CONFIG_ARCH_QCOM) +=3D \
 =09qcom-msm8660-surf.dtb \
 =09qcom-msm8916-samsung-e5.dtb \
 =09qcom-msm8916-samsung-e7.dtb \
+=09qcom-msm8916-samsung-fortunaltezt.dtb \
 =09qcom-msm8916-samsung-grandmax.dtb \
+=09qcom-msm8916-samsung-heatqlte.dtb \
 =09qcom-msm8916-samsung-serranove.dtb \
 =09qcom-msm8960-cdp.dtb \
 =09qcom-msm8960-samsung-expressatt.dtb \
--=20
2.39.2


