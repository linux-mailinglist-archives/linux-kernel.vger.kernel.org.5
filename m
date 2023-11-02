Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3FC7DFC2F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 23:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377442AbjKBWMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 18:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKBWML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 18:12:11 -0400
Received: from mx2-at.ubimet.com (mx2-at.ubimet.com [141.98.226.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A1D191;
        Thu,  2 Nov 2023 15:12:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mx2-at.ubimet.com (Postfix) with ESMTP id 9CEC0811B6;
        Thu,  2 Nov 2023 22:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ubimet.com;
        s=20200131mdel; t=1698963123;
        bh=Ts6HnFX2DYnQcX6TpBcPSGG49aedaASoj32Lwm6JRFc=;
        h=Date:From:Cc:Subject:From;
        b=EJO0gnteUdg+rCd3pHXeI1ZYTIkkKlnBI0DP2m7zC7T612GQRuPnkyOIRSA8k2B+s
         snTppcX+bvonDA0ZD7W0poGzDZXbtFjocYibN1c933Rc1uK4A/dhf99a/V9RaQ4s0d
         UbxK4xWPVwpXN6S6np2U/h81jeGqIyZTHfAgsTj+MLcCEPVFbVe7emFAtqGSJTqhRz
         YCPigM/HRIsLswsUitbN7bKjqmGLCScBtujbHNW/5HnBHxwt0BVCrdqspNrSK3vBtm
         jxEEBOZOFsYG2mgXOAeTgWqKp0ksUTInwl7HgCJFybbk2XD84B2EghJYw2PeCvk9H3
         hW61f5fkqQWkg==
Received: from mx2-at.ubimet.com ([127.0.0.1])
        by localhost (mx02.dmz.dc.at.ubimet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OHgfwoM8Xor2; Thu,  2 Nov 2023 22:12:03 +0000 (UTC)
Received: from zimbra-mta01.ext.dc.at.ubimet.com (zimbra-mta01.ext.dc.at.ubimet.com [10.1.18.22])
        by mx2-at.ubimet.com (Postfix) with ESMTPS id 86E7380BD8;
        Thu,  2 Nov 2023 22:12:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra-mta01.ext.dc.at.ubimet.com (Postfix) with ESMTP id 6945E8089B;
        Thu,  2 Nov 2023 22:12:03 +0000 (UTC)
Received: from zimbra-mta01.ext.dc.at.ubimet.com ([127.0.0.1])
 by localhost (zimbra-mta01.ext.dc.at.ubimet.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id KtiZGBuFMCmH; Thu,  2 Nov 2023 22:12:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra-mta01.ext.dc.at.ubimet.com (Postfix) with ESMTP id 40BDC8089D;
        Thu,  2 Nov 2023 22:12:02 +0000 (UTC)
X-Virus-Scanned: amavis at zimbra-mta01.ext.dc.at.ubimet.com
Received: from zimbra-mta01.ext.dc.at.ubimet.com ([127.0.0.1])
 by localhost (zimbra-mta01.ext.dc.at.ubimet.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id ZX0k2fHRKcft; Thu,  2 Nov 2023 22:12:02 +0000 (UTC)
Received: from pcn112 (unknown [10.15.100.34])
        by zimbra-mta01.ext.dc.at.ubimet.com (Postfix) with ESMTPSA id 1A12A8089B;
        Thu,  2 Nov 2023 22:12:01 +0000 (UTC)
Date:   Thu, 2 Nov 2023 23:11:30 +0100
From:   =?UTF-8?B?Sm/Do28=?= Rodrigues <jrodrigues@ubimet.com>
Cc:     =?UTF-8?B?Sm/Do28=?= Rodrigues <jrodrigues@ubimet.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] ARM: dts: imx: tqma7: add lm75a sensor (rev. 01xxx)
Message-ID: <20231102231130.13ca0513@pcn112>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jo=C3=A3o Rodrigues <jrodrigues@ubimet.com>

TQMa7x (revision 01xxx) uses a LM75A temperature sensor.
The two sensors use different I2C addresses, so we can set both sensors
simultaneously.

Signed-off-by: Jo=C3=A3o Rodrigues <jrodrigues@ubimet.com>
---
 arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi b/arch/arm/boot/dts/=
nxp/imx/imx7-tqma7.dtsi
index fe42b0a4683..3fc3130f9de 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
@@ -128,11 +128,16 @@ vgen6_reg: vldo4 {
 		};
 	};
=20
-	/* NXP SE97BTP with temperature sensor + eeprom */
+	/* LM75A temperature sensor, TQMa7x 01xx */
+	lm75a: temperature-sensor@48 {
+		compatible =3D "national,lm75a";
+		reg =3D <0x48>;
+	};
+
+	/* NXP SE97BTP with temperature sensor + eeprom, TQMa7x 02xx */
 	se97b: temperature-sensor-eeprom@1e {
 		compatible =3D "nxp,se97b", "jedec,jc-42.4-temp";
 		reg =3D <0x1e>;
-		status =3D "okay";
 	};
=20
 	/* ST M24C64 */
--=20
2.25.1

