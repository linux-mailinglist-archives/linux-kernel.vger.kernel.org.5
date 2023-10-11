Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9467C5B20
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjJKSST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbjJKSSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:18:13 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C328E5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=protonmail3; t=1697048290; x=1697307490;
        bh=ynQ1glqOOY0YVbH7mWAv/jyhEaTBs+pK+QoCHGvfw0U=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=DkR2C1Omyrv0l6cXrVNpLQfKq6s6KpCFW1FRQpyN7/O8o9fm/bxkaVhK5b72BxQK7
         aA5OJfPskfPEJs1K3b3nWxFIi0zHM56W17OzuUm6eTofIkKkRuWiVk0Hh6g3PKfgkm
         cpFKf0M+mb3+DmT64JQY3Igzmg2snv37v6Q43/taIzxjfIYhpss0mEdlH3sXIJnnFD
         AIYfVHeCk0P4jDoi1TcfSe9Lt3K3Oc8x9v9ur6WIUvHgAs2WSh6Slf6tfYaW+K7ugk
         bQ3EdylYP00NNGblRO8Y3lejV5NC1KRGjHRkipo61qoxRv5udSfTsBzcgeHddZvJmI
         EQbD+AxmwObbA==
Date:   Wed, 11 Oct 2023 18:18:05 +0000
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        =?utf-8?Q?Tam=C3=A1s_Sz=C5=B1cs?= <tszucs@protonmail.ch>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
From:   =?utf-8?Q?Tam=C3=A1s_Sz=C5=B1cs?= <tszucs@protonmail.ch>
Subject: [PATCH] arm64: dts: rockchip: Remove duplicate regulator vcc3v3_wf from rock-5b
Message-ID: <20231011181757.58047-1-tszucs@protonmail.ch>
Feedback-ID: 53029:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regulator for VCC3V3_WF has been added as vcc3v3_pcie2x1l0 first. Clean thi=
s up.

Signed-off-by: Tam=C3=A1s Sz=C5=B1cs <tszucs@protonmail.ch>
---
 .../boot/dts/rockchip/rk3588-rock-5b.dts      | 23 +------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/b=
oot/dts/rockchip/rk3588-rock-5b.dts
index 8618887899d9..392ac783c3ad 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -114,21 +114,6 @@ vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
 =09=09regulator-max-microvolt =3D <1100000>;
 =09=09vin-supply =3D <&vcc5v0_sys>;
 =09};
-
-=09vcc3v3_wf: vcc3v3-wf-regulator {
-=09=09compatible =3D "regulator-fixed";
-=09=09regulator-name =3D "vcc3v3_wf";
-=09=09regulator-always-on;
-=09=09regulator-boot-on;
-=09=09regulator-min-microvolt =3D <3300000>;
-=09=09regulator-max-microvolt =3D <3300000>;
-=09=09enable-active-high;
-=09=09gpios =3D <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
-=09=09pinctrl-names =3D "default";
-=09=09pinctrl-0 =3D <&vcc3v3_wf_en>;
-=09=09startup-delay-us =3D <50000>;
-=09=09vin-supply =3D <&vcc5v0_sys>;
-=09};
 };
=20
 &combphy0_ps {
@@ -335,12 +320,6 @@ vcc5v0_host_en: vcc5v0-host-en {
 =09=09=09rockchip,pins =3D <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
 =09=09};
 =09};
-
-=09m2e {
-=09=09vcc3v3_wf_en: vcc3v3-wf-en {
-=09=09=09rockchip,pins =3D <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
-=09=09};
-=09};
 };
=20
 &pwm1 {
@@ -391,7 +370,7 @@ &sdio {
 =09sd-uhs-sdr25;
 =09sd-uhs-sdr50;
 =09sd-uhs-sdr104;
-=09vmmc-supply =3D <&vcc3v3_wf>;
+=09vmmc-supply =3D <&vcc3v3_pcie2x1l0>;
 =09vqmmc-supply =3D <&vcc_1v8_s3>;
 =09pinctrl-names =3D "default";
 =09pinctrl-0 =3D <&sdiom0_pins>;
--=20
2.42.0


