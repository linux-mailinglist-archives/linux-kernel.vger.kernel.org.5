Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E987C5D7C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 21:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345948AbjJKTPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 15:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjJKTPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 15:15:18 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290C28F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=protonmail3; t=1697051713; x=1697310913;
        bh=EBTFFd6IGBPeF9S/93E4EoonIWn2TeNSGVG4hjiL2XI=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=TaUooCrLMZjJ5emzXcPY2dspBqoyKGE0bp3KQHTFObjQeEE6MgTt0ypDzZLjcpvon
         KKugtgLjchsQE/B7Pi4ZUDAQ4TRz9ippAIqqKglzgVuGngs1xWN/OZbKF1xKLp7LfZ
         DK9Gn9eBsi5n4MHOEES7zdX7nxcDL2Ecl9bn7RisDoOkPcz11zIKe8a5D6ZQy93jOK
         r3J0zfi5qJWrYJs/W4j5OSDCuVemPulClxNhVMZZd19AGpI0+OISzCOBObICf2Mnq/
         pXK68/GjQVkN3w6oyXyJuf6g935Yzq+Sbeh0/BalAuJMgea/kXx2bxiBuEPJZiCVw0
         6bULNdJPDy1ug==
Date:   Wed, 11 Oct 2023 19:14:56 +0000
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Chukun Pan <amadeus@jmu.edu.cn>,
        Anand Moon <linux.amoon@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Shengyu Qu <wiagn233@outlook.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
From:   =?utf-8?Q?Tam=C3=A1s_Sz=C5=B1cs?= <tszucs@protonmail.ch>
Cc:     =?utf-8?Q?Tam=C3=A1s_Sz=C5=B1cs?= <tszucs@protonmail.ch>
Subject: [PATCH] arm64: dts: rockchip: Add missing sdmmc2 SDR rates to rock-3a
Message-ID: <20231011191448.58936-1-tszucs@protonmail.ch>
Feedback-ID: 53029:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing UHS-I SDR rates to sdmmc2. Add explicit alias as mmc2 while at =
it.
It would be good to have matching timings enabled in case slower SDIO devic=
es
are encountered.

Signed-off-by: Tam=C3=A1s Sz=C5=B1cs <tszucs@protonmail.ch>
---
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/b=
oot/dts/rockchip/rk3568-rock-3a.dts
index e05ab11981f5..a5e974ea659e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -15,6 +15,7 @@ aliases {
 =09=09ethernet0 =3D &gmac1;
 =09=09mmc0 =3D &sdhci;
 =09=09mmc1 =3D &sdmmc0;
+=09=09mmc2 =3D &sdmmc2;
 =09};
=20
 =09chosen: chosen {
@@ -747,6 +748,9 @@ &sdmmc2 {
 =09non-removable;
 =09pinctrl-names =3D "default";
 =09pinctrl-0 =3D <&sdmmc2m0_bus4 &sdmmc2m0_cmd &sdmmc2m0_clk>;
+=09sd-uhs-sdr12;
+=09sd-uhs-sdr25;
+=09sd-uhs-sdr50;
 =09sd-uhs-sdr104;
 =09vmmc-supply =3D <&vcc3v3_sys>;
 =09vqmmc-supply =3D <&vcc_1v8>;
--=20
2.42.0


