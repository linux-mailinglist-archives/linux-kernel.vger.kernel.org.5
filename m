Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC33B7DA143
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 21:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjJ0TZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 15:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjJ0TZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 15:25:05 -0400
X-Greylist: delayed 526 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Oct 2023 12:25:03 PDT
Received: from mx2-at.ubimet.com (mx2-at.ubimet.com [141.98.226.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8D41AC;
        Fri, 27 Oct 2023 12:25:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mx2-at.ubimet.com (Postfix) with ESMTP id C2E5180F51;
        Fri, 27 Oct 2023 19:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ubimet.com;
        s=20200131mdel; t=1698434174;
        bh=Fyd8ZQEuYM+Iy6ZXTdK/66gxo3xx3cuUN3PUInF/vBA=;
        h=Date:From:Cc:Subject:From;
        b=YzitxHafFVgV5w+r+XJVUkMklCrnaaICDuD2NYmaXo46HaZNj2VXj0vircbips2Dt
         mSsxxfnC/SPP/AuWr9xNtydQ0LFa7QVctGSGu9FLI+uNH6oIlMCh2CzWPSPAT5W7GT
         G8BczT1qHU0ExZdFagY4S7TA3pLKhXcMAUAvAVegUbWZNpmmdcx5J6saLfXjlIUKbU
         /EzvE5gFPu6mq8bmhKilzeMZfO9NJQx3s/ujF9CIG76i4mh3b2OBo6D/+Sc65MzuAi
         zum3VVqlRpAa48eDfeIAb96LeuHNSl7ludYiqIiZaivxB2uzUbX5kqZ7nBsW8UK12h
         kzcBCnGHd7IdQ==
Received: from mx2-at.ubimet.com ([127.0.0.1])
        by localhost (mx02.dmz.dc.at.ubimet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zZxDbivKcnPI; Fri, 27 Oct 2023 19:16:14 +0000 (UTC)
Received: from zimbra-mta01.ext.dc.at.ubimet.com (webmail-dc.at.ubimet.com [10.1.18.22])
        by mx2-at.ubimet.com (Postfix) with ESMTPS id B055C80F32;
        Fri, 27 Oct 2023 19:16:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra-mta01.ext.dc.at.ubimet.com (Postfix) with ESMTP id A62CE8074F;
        Fri, 27 Oct 2023 19:16:14 +0000 (UTC)
Received: from zimbra-mta01.ext.dc.at.ubimet.com ([127.0.0.1])
 by localhost (zimbra-mta01.ext.dc.at.ubimet.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id RmSCG380Fm8h; Fri, 27 Oct 2023 19:16:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra-mta01.ext.dc.at.ubimet.com (Postfix) with ESMTP id 753BE807D5;
        Fri, 27 Oct 2023 19:16:13 +0000 (UTC)
X-Virus-Scanned: amavis at zimbra-mta01.ext.dc.at.ubimet.com
Received: from zimbra-mta01.ext.dc.at.ubimet.com ([127.0.0.1])
 by localhost (zimbra-mta01.ext.dc.at.ubimet.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id r9ywy6JXBxb5; Fri, 27 Oct 2023 19:16:13 +0000 (UTC)
Received: from pcn112 (unknown [10.15.100.32])
        by zimbra-mta01.ext.dc.at.ubimet.com (Postfix) with ESMTPSA id 120F88074F;
        Fri, 27 Oct 2023 19:16:12 +0000 (UTC)
Date:   Fri, 27 Oct 2023 21:15:48 +0200
From:   jrodrigues <jrodrigues@ubimet.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, jrodrigues@ubimet.com
Subject: [PATCH] ARM: dts: imx: tqma7: add lm75a sensor (rev. 01xxx)
Message-ID: <20231027211548.21a6cee7@pcn112>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


TQMa7x (revision 01xxx) uses a different (LM75A) temperature sensor.
The two sensors use different I2C address, so we can set both sensors
simultaneously.

Signed-off-by: Jo=C3=A3o Rodrigues <jrodrigues@ubimet.com>
---
 arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi b/arch/arm/boot/dts/=
nxp/imx/imx7-tqma7.dtsi
index fe42b0a468..b87560d037 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
@@ -128,7 +128,14 @@ vgen6_reg: vldo4 {
 		};
 	};
=20
-	/* NXP SE97BTP with temperature sensor + eeprom */
+	/* LM75A - temperature sensor, TQMa7x 01xx */
+	lm75a: temperature-sensor@48 {
+		compatible =3D "national,lm75a";
+		reg =3D <0x48>;
+		status =3D "okay";
+	};
+
+	/* NXP SE97BTP with temperature sensor + eeprom, TQMa7x 02xx */
 	se97b: temperature-sensor-eeprom@1e {
 		compatible =3D "nxp,se97b", "jedec,jc-42.4-temp";
 		reg =3D <0x1e>;
--

The differences in the ICs are shown here:
The TQMa7 manual only references the latest version
https://www.tq-group.com/filedownloads/files/products/embedded/manuals/arm/=
embedded-modul/TQ-Socket/TQMa7x/TQMa7x.UM.0203.pdf
in section 3.2.4, while the board manual
https://www.tq-group.com/filedownloads/files/products/embedded/manuals/arm/=
carrierboard/MBa7x/MBa7x.UM.0101.pdf
in section 4.1.2 references the old version, introduced by this patch.

I have tested this change in a board which uses the TQMa7x
module, and with this patch we always a temperature sensors available.


Best regards,

--
Jo=C3=A3o Rodrigues <jrodrigues@ubimet.com>

