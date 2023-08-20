Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EEB7820A4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 00:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjHTWvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 18:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjHTWvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 18:51:49 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6EE9F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 15:51:45 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 759CC2C0488;
        Mon, 21 Aug 2023 10:51:31 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1692571891;
        bh=ltMKzVSGK60mq2KrfhI7SNciiBGTVyCpRjFZf8Nlzk0=;
        h=From:To:Cc:Subject:Date:From;
        b=T6EbMW1HRWwTplBjIiv+khJThYsPESosJs0U0xyr6uSd5WPtk4RZiKE4H4lVDolHi
         8vi8FlBU7LS8uhR6Wr70HXlIBW75iCXTIVu6duG/Wtuppu2UTpIhTsskhpmQGQZCSZ
         6iqjZFSRqiharOofTVpS3j6V+s0WpJ5ZQzMxvLeh0Xl6SKQuiom9r+mdum3jbfFKdF
         aNQ5CCMu+GQA6dEya2rZg5louPBYwb5Xq7HirHJztlHRPtbpT8slMQpd/vnkFvBYFq
         yPIU13ZylAFVMqMBME+34grYZ4JghyCHbF/ET8EFbAV8KahWinCg+dfjqaiuE/mFBs
         3WWsIEZYlvCpg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B64e298f30000>; Mon, 21 Aug 2023 10:51:31 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 3DDDC13EDA8;
        Mon, 21 Aug 2023 10:51:31 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 3E3D2280E13; Mon, 21 Aug 2023 10:51:31 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        kostap@marvell.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] ARM64: dts: marvell: cn9310: Use appropriate label for spi1 pins
Date:   Mon, 21 Aug 2023 10:51:25 +1200
Message-ID: <20230820225126.561304-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=fYfTNHYF c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=UttIx32zK-AA:10 a=K8jVNL0kp2MPpiqQWdsA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the CN9130-CRB and CN9130-DB use the SPI1 interface but had the
pinctrl node labelled as "cp0_spi0_pins". Use the label "cp0_spi1_pins"
and update the node name to "cp0-spi-pins-1" to avoid confusion with the
pinctrl options for SPI0.

Fixes: 4c43a41e5b8c ("arm64: dts: cn913x: add device trees for topology B=
 boards")
Fixes: 5c0ee54723f3 ("arm64: dts: add support for Marvell cn9130-crb plat=
form")
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    We noticed this while tracking down a U-Boot bug on one of our
    platforms. This mislabeling had been copied and we ended up using the
    label when configuring SPI0 which had the nasty side effect of
    reconfiguring the NAND/DEV pins into SPI1 mode when SPI0 was probed.
   =20
    It probably went unnoticed because none of the CN9130 platforms
    supported in upstream U-Boot use NAND.

 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi | 4 ++--
 arch/arm64/boot/dts/marvell/cn9130-db.dtsi  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi b/arch/arm64/boo=
t/dts/marvell/cn9130-crb.dtsi
index 32cfb3e2efc3..47d45ff3d6f5 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
@@ -120,7 +120,7 @@ cp0_sdhci_pins: cp0-sdhi-pins-0 {
 				       "mpp59", "mpp60", "mpp61";
 			marvell,function =3D "sdio";
 		};
-		cp0_spi0_pins: cp0-spi-pins-0 {
+		cp0_spi1_pins: cp0-spi-pins-1 {
 			marvell,pins =3D "mpp13", "mpp14", "mpp15", "mpp16";
 			marvell,function =3D "spi1";
 		};
@@ -170,7 +170,7 @@ &cp0_sdhci0 {
=20
 &cp0_spi1 {
 	pinctrl-names =3D "default";
-	pinctrl-0 =3D <&cp0_spi0_pins>;
+	pinctrl-0 =3D <&cp0_spi1_pins>;
 	reg =3D <0x700680 0x50>,		/* control */
 	      <0x2000000 0x1000000>;	/* CS0 */
 	status =3D "okay";
diff --git a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi b/arch/arm64/boot=
/dts/marvell/cn9130-db.dtsi
index c7de1ea0d470..6eb6a175de38 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
@@ -307,7 +307,7 @@ &cp0_sdhci0 {
 &cp0_spi1 {
 	status =3D "disabled";
 	pinctrl-names =3D "default";
-	pinctrl-0 =3D <&cp0_spi0_pins>;
+	pinctrl-0 =3D <&cp0_spi1_pins>;
 	reg =3D <0x700680 0x50>;
=20
 	flash@0 {
@@ -371,7 +371,7 @@ cp0_sdhci_pins: cp0-sdhi-pins-0 {
 				       "mpp59", "mpp60", "mpp61";
 			marvell,function =3D "sdio";
 		};
-		cp0_spi0_pins: cp0-spi-pins-0 {
+		cp0_spi1_pins: cp0-spi-pins-1 {
 			marvell,pins =3D "mpp13", "mpp14", "mpp15", "mpp16";
 			marvell,function =3D "spi1";
 		};
--=20
2.41.0

