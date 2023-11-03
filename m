Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F917E0894
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345571AbjKCS6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 14:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345859AbjKCS6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:58:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AF9D59;
        Fri,  3 Nov 2023 11:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699037854; x=1699642654; i=w_armin@gmx.de;
        bh=OhijzaFOCs/gLtWXwbD2ow5r3VEm8U+868KlplYcQ9k=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=DgdYbT4Ra7kHuz52A+z8oHHWKuIvGfu55yQkp3ft3wPp1sxNYt5ExyaTtb3YH8MJ
         26XvYJVekwrWUwbmz1VtLvlJN6nvNpUf7ZmR8i5JY4Np3xmHi1RPs0ozDniosn3Nu
         r2p26CYennpNcJ03/GV+7ECaBwQe1m4bCYV1pQIKNdDgkumSr38XHtimWgaQjiwC4
         XHLh37nize3hPWUm+xKR9ZdmqqwtRZhOL3IQsL15gl4V8iRISi7IbToyNgNnEnyyJ
         zLrEmPZXaLRCWoU50cUaKWPKsZ9boC0MDi4gGIbwBRz6L8t/EMgdeyR6nEj8omFpt
         t3gI+18lmWcv2vCayw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MgvrL-1rdZxr0I5V-00hOEG; Fri, 03 Nov 2023 19:57:34 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] hwmon: (dell-smm) Move config entries out of i8k_dmi_table
Date:   Fri,  3 Nov 2023 19:57:12 +0100
Message-Id: <20231103185716.11007-6-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231103185716.11007-1-W_Armin@gmx.de>
References: <20231103185716.11007-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+bHDlPOemJkQ3c8wajbkE1ZDf+QZWbc35o3L40DApMIPvZ3N/iV
 lrXTfBfxwgjzNilZ4BhPXtesiftSrdk7Ga5qOtiK97kEyYtkLrdF/VVeETizshW2iuNcM8N
 /bBqgBBp9/U+LO2LTZzBPFL6EBkxqBZJCKHs8E1wmVlYE1K0hPx2m1ZP3HBSdHOqXOni3aL
 PdH+6hrNOfrV5U6jseFOQ==
UI-OutboundReport: notjunk:1;M01:P0:1IdPy4aFrCQ=;w3njuxt2JVfAiEnTgHAlOkoWdhd
 sZN+jidOCfcAhg27RaoK8Tdv70Bx7KfcVsEAJt27V+tj2WyNCgV8sr0jbbdhy2qylUvUe7iuy
 vtt/HdCqX4tMgEHpJA4+YAsBJJ3eFhia2te6G/yaIrCeLVYwJGcn+QVOqg8HxYF05a9TOAuL8
 UcAAr/XetnK36c54QCiP40v1y3rlSUjSRB1GQuSGaz4Xxa1XCiOK9Qxp/0kAKtMcg47N7d7xB
 fvX7joXEZIoH619npmWO2p67wwYjqHIVxJLnogLUASmKvKm62su6S46kBouRxNsN9K0013iU+
 9P+9kOpqNIVdcgkRc93UKCQmRyeZEXWSWipRK9FfZ2+f7zEi2L7p/LwWAxXswCuXwUwZ+hMdQ
 TubnerCg4Ose1S1gNXaQGdhFjT4s7G92C2S+Nbvkkv1e318JPfXjNw2p+ZfiUmMn4ObIDvVk0
 8mCv40MdXpvsy43PI7TPG7qWn+XUALa4+BdhH9CKhM3CbB/W9anIWKbBiPRqaRYmxRPcBYHse
 Fc/QNRe/tFpmL34AKfJt7JBllvCGPTSYwLOy9ctoVIcE4ub1MoQSZtOxQPzNdy7zpDMeBNz87
 PPFJgM4281YEATle0qq07oBZbcmKnSNcd0XN6ZuChDvs11IWyMdbRPXYMlnd45VevPi8Y/fi5
 pHxB30vLjcTJ3YEW/sTtgPpfFAAc77np6dVVowBNL1ITRcR8PbMRvsKO5wsfNSCEJNF2HCEy1
 yTnQjsU24nFytpkxirsybdasb9F0vuk43wkA6C4XGDD5/4mLWIYdy3NNOjMjBI3NCSR7OOIho
 k1VI5cBuALnLOlRGhSHc3oQSHRxHZPQA6MQtWrrC8Ea2i5J2Bk/KjRZW0xEy641zO15rDfUOJ
 u1aNxrBZXK1I0Vs3aNudUQ7VtRt+RgCDpaIncj5LaeO8BGM0MsiDgzFi8e3ut1Xh3dDbSGc+k
 oFPnESytj0+/7Bsriyeo8YxUcwk=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, i8k_dmi_table contains both entries used for DMI
matching and entries used to override config options. This
does not allow for differentiating between "its safe to issue
raw SMM calls on this machine" and "its not safe to issue raw
SMM calls on this machine, but here are some config values".

Since future SMM backends will need to differentiate between
those two cases, move those config entries into a separate
table. i8k_dmi_table now serves as a general "its safe to issue
raw SMM calls" table.

Tested-by: <serverror@serverror.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 129 +++++++++++++++++++--------------
 1 file changed, 73 insertions(+), 56 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 3d14a3baf8e4..4a2c0d1ffa5b 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1078,42 +1078,6 @@ static int __init dell_smm_init_hwmon(struct device=
 *dev)
 	return PTR_ERR_OR_ZERO(dell_smm_hwmon_dev);
 }

-struct i8k_config_data {
-	uint fan_mult;
-	uint fan_max;
-};
-
-enum i8k_configs {
-	DELL_LATITUDE_D520,
-	DELL_PRECISION_490,
-	DELL_STUDIO,
-	DELL_XPS,
-};
-
-/*
- * Only use for machines which need some special configuration
- * in order to work correctly (e.g. if autoconfig fails on this machines)=
.
- */
-
-static const struct i8k_config_data i8k_config_data[] __initconst =3D {
-	[DELL_LATITUDE_D520] =3D {
-		.fan_mult =3D 1,
-		.fan_max =3D I8K_FAN_TURBO,
-	},
-	[DELL_PRECISION_490] =3D {
-		.fan_mult =3D 1,
-		.fan_max =3D I8K_FAN_TURBO,
-	},
-	[DELL_STUDIO] =3D {
-		.fan_mult =3D 1,
-		.fan_max =3D I8K_FAN_HIGH,
-	},
-	[DELL_XPS] =3D {
-		.fan_mult =3D 1,
-		.fan_max =3D I8K_FAN_HIGH,
-	},
-};
-
 static const struct dmi_system_id i8k_dmi_table[] __initconst =3D {
 	{
 		.ident =3D "Dell G5 5590",
@@ -1143,14 +1107,6 @@ static const struct dmi_system_id i8k_dmi_table[] _=
_initconst =3D {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron"),
 		},
 	},
-	{
-		.ident =3D "Dell Latitude D520",
-		.matches =3D {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude D520"),
-		},
-		.driver_data =3D (void *)&i8k_config_data[DELL_LATITUDE_D520],
-	},
 	{
 		.ident =3D "Dell Latitude 2",
 		.matches =3D {
@@ -1172,15 +1128,6 @@ static const struct dmi_system_id i8k_dmi_table[] _=
_initconst =3D {
 			DMI_MATCH(DMI_PRODUCT_NAME, "MP061"),
 		},
 	},
-	{
-		.ident =3D "Dell Precision 490",
-		.matches =3D {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME,
-				  "Precision WorkStation 490"),
-		},
-		.driver_data =3D (void *)&i8k_config_data[DELL_PRECISION_490],
-	},
 	{
 		.ident =3D "Dell Precision",
 		.matches =3D {
@@ -1201,7 +1148,6 @@ static const struct dmi_system_id i8k_dmi_table[] __=
initconst =3D {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Studio"),
 		},
-		.driver_data =3D (void *)&i8k_config_data[DELL_STUDIO],
 	},
 	{
 		.ident =3D "Dell XPS M140",
@@ -1209,7 +1155,6 @@ static const struct dmi_system_id i8k_dmi_table[] __=
initconst =3D {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "MXC051"),
 		},
-		.driver_data =3D (void *)&i8k_config_data[DELL_XPS],
 	},
 	{
 		.ident =3D "Dell XPS",
@@ -1223,6 +1168,78 @@ static const struct dmi_system_id i8k_dmi_table[] _=
_initconst =3D {

 MODULE_DEVICE_TABLE(dmi, i8k_dmi_table);

+/*
+ * Only use for machines which need some special configuration
+ * in order to work correctly (e.g. if autoconfig fails on this machines)=
.
+ */
+struct i8k_config_data {
+	uint fan_mult;
+	uint fan_max;
+};
+
+enum i8k_configs {
+	DELL_LATITUDE_D520,
+	DELL_PRECISION_490,
+	DELL_STUDIO,
+	DELL_XPS,
+};
+
+static const struct i8k_config_data i8k_config_data[] __initconst =3D {
+	[DELL_LATITUDE_D520] =3D {
+		.fan_mult =3D 1,
+		.fan_max =3D I8K_FAN_TURBO,
+	},
+	[DELL_PRECISION_490] =3D {
+		.fan_mult =3D 1,
+		.fan_max =3D I8K_FAN_TURBO,
+	},
+	[DELL_STUDIO] =3D {
+		.fan_mult =3D 1,
+		.fan_max =3D I8K_FAN_HIGH,
+	},
+	[DELL_XPS] =3D {
+		.fan_mult =3D 1,
+		.fan_max =3D I8K_FAN_HIGH,
+	},
+};
+
+static const struct dmi_system_id i8k_config_dmi_table[] __initconst =3D =
{
+	{
+		.ident =3D "Dell Latitude D520",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude D520"),
+		},
+		.driver_data =3D (void *)&i8k_config_data[DELL_LATITUDE_D520],
+	},
+	{
+		.ident =3D "Dell Precision 490",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME,
+				  "Precision WorkStation 490"),
+		},
+		.driver_data =3D (void *)&i8k_config_data[DELL_PRECISION_490],
+	},
+	{
+		.ident =3D "Dell Studio",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Studio"),
+		},
+		.driver_data =3D (void *)&i8k_config_data[DELL_STUDIO],
+	},
+	{
+		.ident =3D "Dell XPS M140",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MXC051"),
+		},
+		.driver_data =3D (void *)&i8k_config_data[DELL_XPS],
+	},
+	{ }
+};
+
 /*
  * On some machines once I8K_SMM_GET_FAN_TYPE is issued then CPU fan spee=
d
  * randomly going up and down due to bug in Dell SMM or BIOS. Here is bla=
cklist
@@ -1438,7 +1455,7 @@ static void __init dell_smm_init_dmi(void)
 	 * Set fan multiplier and maximal fan speed from DMI config.
 	 * Values specified in module parameters override values from DMI.
 	 */
-	id =3D dmi_first_match(i8k_dmi_table);
+	id =3D dmi_first_match(i8k_config_dmi_table);
 	if (id && id->driver_data) {
 		config =3D id->driver_data;
 		if (!fan_mult && config->fan_mult)
=2D-
2.39.2

