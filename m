Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174927F55A2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 01:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjKWAur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 19:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbjKWAul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 19:50:41 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708D5D62;
        Wed, 22 Nov 2023 16:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1700700533; x=1701305333; i=w_armin@gmx.de;
        bh=ypxTcPx1uFZuzoDozqG8XblCqXTwvGo3YUZs6ZriyhU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=HIRSV8ns1pcWBTpk79jNCgDdoTU6FFtGYC8VEZ9Syuy5hYUU9um0+vuxA4pAMmMR
         X48rt2sJcxFYv7OkeYkRAOX9O8l13qbp75qLA/2eFTSS+4NhyajgFjMyp5pI//Kcv
         IogKOOW/C1ld+HM5ETcZQEW+ghhSG0pYycgTJxebf/8Iu5/UpSRg92TTS2zuUjIzQ
         Q8XWJ2pW03ae2helpFqMtiiDDBCbTbgjbFGoankWYa4JVR0G/FRFyz2nrjEfTwFVv
         jwNiDNhnEiieHqKh+KTv72Supl8JjAe9SSgBRdcmFq8FJANkcqw3SxnVLamAKWd+m
         D3u37O0pEiL2soJjEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N79yQ-1rOahV1XhM-017UfY; Thu, 23 Nov 2023 01:48:53 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, hdegoede@redhat.com,
        markgross@kernel.org, ilpo.jarvinen@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 9/9] hwmon: (dell-smm) Add Optiplex 7000 to fan control whitelist
Date:   Thu, 23 Nov 2023 01:48:20 +0100
Message-Id: <20231123004820.50635-10-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123004820.50635-1-W_Armin@gmx.de>
References: <20231123004820.50635-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:saQt7LnBHg+zazPp71lwq3Y/01+bH/pKBS1QRBLb40dcuAdL6rX
 xbhK//9EdZh4bruweWCJOh+Gtr2rcR0BgBKMqQgW6U6JrAx/5qIIGV3eQAbTqtyLXJLuu4m
 ng4l/aZZQLXRDlF31NZ35j9kNIwHer9F6IheGsLxBLXzAbV8u/qZBonQhGPsiMwRC4OfIP8
 9aW4EARyP8lOJaOaCefjA==
UI-OutboundReport: notjunk:1;M01:P0:rLRRwAELCHI=;60/pT1Y9jRB92mICzgfNwvj51f1
 pRm37LbxCBMLmz6ajOeous9n2PMeYA6e3etfddNe96UM60sVoKwUnIAgJ7MetNr56XX8+S7Oc
 aVXoELiE3tN92KtqMN7xGhNLx+vr7OikPars4F2nGl2WyqDfXwA2DpGdcHUp+Z6vmIy2m0MjL
 5rbZqy1iiS6vOg0x1MNS8gxQOn22ASV4zEvQWjCdr31EoGx/yYd6/nYr62D0lbY9VaAEdm5h1
 yMs+ZL8UfJWvMCMotkZXTogXuap1K21NU3qBF2LNvQfPiKUItrJRX7cSrLyLYBfcacZKzjWne
 OehIHt3K9pXcQw41TDQmTQzwHtTaZ8mKETOgXfptMTmUMn3zb4hBIwa/qRl/610TTHTm7qNrY
 EvVEyfhxexVhmkbEOgK7E7dIUqR32ewEAaG4VJUkWIXOrAoX24pfqKvSJsQmIU7Swp4c+jaHt
 T5ocl7U+R8/a8ABLoYDaT0jNhb5/2zt1yQLa1zo6JGZ2oPtJ5CUfQkVoglzrO3nqnHLBSK5mQ
 pJFb+tJ5vw1eFE6qUDBdVQf+V4BcVGpeF7m0LJIT1sT2TBA6JralQZXsK8P1VDO69kwDhbHvB
 /N8DERoDa6OHEWIZGte6dMWXIRI6cxKTeWJcj32ZcN/xJtcRILetP1Sp1432tJHs89qrBhTp5
 yfHYsH+YyBurpJNtJ9cbvszd1OWzKaByI5nUFGjooJg5KfeNFakD5hA82TDw83Adf9RpinmHE
 PdfNsUTp4mXABxTMLa/aJWS7wTVxKnEyGJCEG1IliqVsJKg6Ujujq4DYAlwVa4S5ZwvnKL6lb
 w745ZLHhXsQrL/ZgQ5/NSb/Fk4Iuldctt2rVjhUBzJAFVnALjqrgp37O1jNo2SlG/jmqG1mtl
 ZEwQemBCosyqt0/qbGEUq5G/33RBnbzlbUsLm0rVbXRh9xiB+qVwv6scXMg6BVm3grnkYsrN8
 LDWcUFBSQXDosvo3f+xWuD7YxL8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A user reported that on this machine, disabling BIOS fan control
is necessary in order to change the fan speed.

Tested-by: <serverror@serverror.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 95330437c5af..6d8c0f328b7b 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1509,6 +1509,14 @@ static const struct dmi_system_id i8k_whitelist_fan=
_control[] __initconst =3D {
 		},
 		.driver_data =3D (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
 	},
+	{
+		.ident =3D "Dell Optiplex 7000",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7000"),
+		},
+		.driver_data =3D (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
+	},
 	{ }
 };

=2D-
2.39.2

