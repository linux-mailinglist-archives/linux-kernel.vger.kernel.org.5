Return-Path: <linux-kernel+bounces-68397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15308579AC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42530B26597
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4DB2D638;
	Fri, 16 Feb 2024 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="iz7Ye9Sp"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26429286AD;
	Fri, 16 Feb 2024 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077384; cv=none; b=l4mcqAfyIaeOgBeYvvaecSEmwfrk/MrwOBw14IjFetPpYpwvPv+7aUlaO8khPp2/NKV1fElmTaG9dUXKYd/OLqJur8f38ZGiJ3Jxq/I9+RMN7mcg8ohIVYNSDXk1BA16CocJF+dHU4FyQHeCMycPGD7lMaSlbo3lau/rjcKyySY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077384; c=relaxed/simple;
	bh=j4WYdlH2C0SjARdDRBqYCOTeUj3v1ffV3fGDsF0zbRM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=XNapF43S3x151vAJrJFk25i8YCAhPgE8kMVTLICXWdE3oQCFh8aza4kf+byPhbtO0lxUbKsZmKHRDZcOVqEQNSD5qRlQBML1OstcAguoaBSoaz3mhbJaKnBbqjoGYFNC82cQ06wXOwH5IqnVQD1hPfKltm4eMataWxcAIVPcjX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=iz7Ye9Sp; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708077374; x=1708682174; i=markus.elfring@web.de;
	bh=j4WYdlH2C0SjARdDRBqYCOTeUj3v1ffV3fGDsF0zbRM=;
	h=X-UI-Sender-Class:Date:From:Subject:To:Cc;
	b=iz7Ye9SpWpUmC8Hr0DfRZV7pfVRPEplG1eviG2cAguU9yzhnKMfeMJqYas+fgrJc
	 YIwxsqmLKUnyLLJWLKTroau9eidgH2X53s593F1Uu8Yzp9W9jY6dqCiAuap33WCCl
	 hCIRHZIbJY+mOf+n1ZRbYRGMCLp5+gfDO8cmN7rdWknneqmjQxxowx2WU6U4eby6K
	 conea6e0xQRH7mI2wfx2q0lc8atcryD1tIbRprmqcKdnM0aae4BtK6L3Z1MXI7UXF
	 YV/BHu3pC2xu2PS8pTYjNuhi5MbcEkv3DbIqNr5EzAJUcpNQbK+eku2EV5BjUDZ0c
	 jcj1HklLGP1lWe9h8A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MeDMR-1qzvHw2FUN-00bHl6; Fri, 16
 Feb 2024 10:50:43 +0100
Message-ID: <4b50017b-d3f6-45c8-b4a0-6943c7a7e54e@web.de>
Date: Fri, 16 Feb 2024 10:50:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] iwlwifi: Use common error handling code in five functions
To: linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Alon Giladi <alon.giladi@intel.com>,
 Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Gregory Greenman <gregory.greenman@intel.com>,
 Johannes Berg <johannes.berg@intel.com>, Kalle Valo <kvalo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zvhrmtS8gAA7vSSneY/0kkuoyoordAd2oZO5xDRTNtWRPJ9Bgst
 FP6XSfiSD2jPijpx55JA1LIGpzQQCW9InIoK3jmo5+L/RQAofH2z06KGdfmKNFJBHJhd05t
 JdWVS8xWuTTl3wRD39QSO3P5Bag2bSdTCceMFdey7On9C6aqNFeEj+Aw7DtjwiObXmmhE0i
 4Z0AaWv0J/X2b5KDFU//A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bd9dY07eXD4=;f8/5w3QpeIlF3MwRUI2u101cWY0
 a9wLnhH7YB9ZRp7KQmHdTvH/hmiURFLnaJkPBUfjBm/qF/00JMBSCeaYJAzw8nANyt0P0g4ZI
 bkp4pGY/RjwjH+TI3jZROIr9cIX4xyRdW/3cOukpjHtAJ+mO5XjzJAkOU+sgV8DCiIzhdvJH7
 IDMMQBrQVHqHbI6GOA8FeykFnB/5OJE9VhpQ+DGMv+W/j7mDYWQcdzCRHhTXNP5r3lg5P7zF1
 /Qp0V6Aiz5TukKV/NW1EryQ0hEB82RB5/cL1VANVhIARmyHMrski5HvFr8V+McKO0xTcJOGkI
 uyw2BvRA0aoCi2psITq06gqTyPR+kuXNI5Q2QkcgNaLmYYZSu/5qdDqDj3ICEqtL1rCXJlSFH
 SuRy9rlwO44MmRTYlK9ZxNWLZGHON4GAeUvhOgp0/+gbGVPpCy4As9B+pvaC3Gaoy+WDIy03+
 2yFlFVjLBGFQbaAF8gxV/d7CIFxA5MbXch1gEnX5OGTdt29RB3CW93nEE2wdWw2NEQj00B5pl
 CwtqUraLsYctWOA6Hy7ikHNREqIuMsaCi7hnIrpV94asTO9owmAmHqSTE/vD7Ljn+cxOGTSWg
 JELXdclpDOTz6rxHCuDOoeVSTDGCLGDRYHeuk9la347hSQAsQN3uwjIQfFhiT4cm9FwjKVG/y
 nsVP1F2yLgBuWSY7vXB1G8E1r5Z6GXiQ1HlhI+jOB365GPRpdaI1l3XQdWufNZU4rS6JPP/pm
 EdkYPRkC1XhzuEGtctlLSr7GlCdl40iGif3g8QtJkQcW8iFYjn5UgxeOnDj2VkKIEX6Wa02Ba
 AyZJGJRmVswx434xE8toyJyzvNm/f40SP1B2wsvsLFIsA=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 16 Feb 2024 10:22:20 +0100

The error code =E2=80=9C-EINVAL=E2=80=9D was set before the statement =E2=
=80=9Cgoto out_free=E2=80=9D
multiple times in some function implementations.
Add jump targets so that a bit of exception handling can be better reused
at the end of these functions.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 130 +++++++++----------
 1 file changed, 58 insertions(+), 72 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wi=
reless/intel/iwlwifi/fw/acpi.c
index 4caf2e25a297..0d7a2f2eab07 100644
=2D-- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -285,8 +285,7 @@ int iwl_acpi_get_tas_table(struct iwl_fw_runtime *fwrt=
,
 		wifi_pkg->package.elements[1].type =3D=3D ACPI_TYPE_INTEGER) {
 		enabled =3D !!wifi_pkg->package.elements[1].integer.value;
 	} else {
-		ret =3D -EINVAL;
-		goto out_free;
+		goto out_e_inval;
 	}

 	if (!enabled) {
@@ -301,8 +300,7 @@ int iwl_acpi_get_tas_table(struct iwl_fw_runtime *fwrt=
,
 	    IWL_WTAS_BLACK_LIST_MAX) {
 		IWL_DEBUG_RADIO(fwrt, "TAS invalid array size %llu\n",
 				wifi_pkg->package.elements[2].integer.value);
-		ret =3D -EINVAL;
-		goto out_free;
+		goto out_e_inval;
 	}
 	block_list_size =3D wifi_pkg->package.elements[2].integer.value;
 	tas_data->block_list_size =3D cpu_to_le32(block_list_size);
@@ -316,8 +314,7 @@ int iwl_acpi_get_tas_table(struct iwl_fw_runtime *fwrt=
,
 		    ACPI_TYPE_INTEGER) {
 			IWL_DEBUG_RADIO(fwrt,
 					"TAS invalid array elem %d\n", 3 + i);
-			ret =3D -EINVAL;
-			goto out_free;
+			goto out_e_inval;
 		}

 		country =3D wifi_pkg->package.elements[3 + i].integer.value;
@@ -329,6 +326,10 @@ int iwl_acpi_get_tas_table(struct iwl_fw_runtime *fwr=
t,
 out_free:
 	kfree(data);
 	return ret;
+
+out_e_inval:
+	ret =3D -EINVAL;
+	goto out_free;
 }

 int iwl_acpi_get_mcc(struct iwl_fw_runtime *fwrt, char *mcc)
@@ -474,10 +475,8 @@ int iwl_acpi_get_wrds_table(struct iwl_fw_runtime *fw=
rt)
 					 ACPI_WRDS_WIFI_DATA_SIZE_REV2,
 					 &tbl_rev);
 	if (!IS_ERR(wifi_pkg)) {
-		if (tbl_rev !=3D 2) {
-			ret =3D -EINVAL;
-			goto out_free;
-		}
+		if (tbl_rev !=3D 2)
+			goto out_e_inval;

 		num_chains =3D ACPI_SAR_NUM_CHAINS_REV2;
 		num_sub_bands =3D ACPI_SAR_NUM_SUB_BANDS_REV2;
@@ -490,10 +489,8 @@ int iwl_acpi_get_wrds_table(struct iwl_fw_runtime *fw=
rt)
 					 ACPI_WRDS_WIFI_DATA_SIZE_REV1,
 					 &tbl_rev);
 	if (!IS_ERR(wifi_pkg)) {
-		if (tbl_rev !=3D 1) {
-			ret =3D -EINVAL;
-			goto out_free;
-		}
+		if (tbl_rev !=3D 1)
+			goto out_e_inval;

 		num_chains =3D ACPI_SAR_NUM_CHAINS_REV1;
 		num_sub_bands =3D ACPI_SAR_NUM_SUB_BANDS_REV1;
@@ -506,10 +503,8 @@ int iwl_acpi_get_wrds_table(struct iwl_fw_runtime *fw=
rt)
 					 ACPI_WRDS_WIFI_DATA_SIZE_REV0,
 					 &tbl_rev);
 	if (!IS_ERR(wifi_pkg)) {
-		if (tbl_rev !=3D 0) {
-			ret =3D -EINVAL;
-			goto out_free;
-		}
+		if (tbl_rev !=3D 0)
+			goto out_e_inval;

 		num_chains =3D ACPI_SAR_NUM_CHAINS_REV0;
 		num_sub_bands =3D ACPI_SAR_NUM_SUB_BANDS_REV0;
@@ -521,10 +516,8 @@ int iwl_acpi_get_wrds_table(struct iwl_fw_runtime *fw=
rt)
 	goto out_free;

 read_table:
-	if (wifi_pkg->package.elements[1].type !=3D ACPI_TYPE_INTEGER) {
-		ret =3D -EINVAL;
-		goto out_free;
-	}
+	if (wifi_pkg->package.elements[1].type !=3D ACPI_TYPE_INTEGER)
+		goto out_e_inval;

 	IWL_DEBUG_RADIO(fwrt, "Reading WRDS tbl_rev=3D%d\n", tbl_rev);

@@ -543,6 +536,10 @@ int iwl_acpi_get_wrds_table(struct iwl_fw_runtime *fw=
rt)
 out_free:
 	kfree(data);
 	return ret;
+
+out_e_inval:
+	ret =3D -EINVAL;
+	goto out_free;
 }

 int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fwrt)
@@ -562,10 +559,8 @@ int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fw=
rt)
 					 ACPI_EWRD_WIFI_DATA_SIZE_REV2,
 					 &tbl_rev);
 	if (!IS_ERR(wifi_pkg)) {
-		if (tbl_rev !=3D 2) {
-			ret =3D -EINVAL;
-			goto out_free;
-		}
+		if (tbl_rev !=3D 2)
+			goto out_e_inval;

 		num_chains =3D ACPI_SAR_NUM_CHAINS_REV2;
 		num_sub_bands =3D ACPI_SAR_NUM_SUB_BANDS_REV2;
@@ -578,10 +573,8 @@ int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fw=
rt)
 					 ACPI_EWRD_WIFI_DATA_SIZE_REV1,
 					 &tbl_rev);
 	if (!IS_ERR(wifi_pkg)) {
-		if (tbl_rev !=3D 1) {
-			ret =3D -EINVAL;
-			goto out_free;
-		}
+		if (tbl_rev !=3D 1)
+			goto out_e_inval;

 		num_chains =3D ACPI_SAR_NUM_CHAINS_REV1;
 		num_sub_bands =3D ACPI_SAR_NUM_SUB_BANDS_REV1;
@@ -594,10 +587,8 @@ int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fw=
rt)
 					 ACPI_EWRD_WIFI_DATA_SIZE_REV0,
 					 &tbl_rev);
 	if (!IS_ERR(wifi_pkg)) {
-		if (tbl_rev !=3D 0) {
-			ret =3D -EINVAL;
-			goto out_free;
-		}
+		if (tbl_rev !=3D 0)
+			goto out_e_inval;

 		num_chains =3D ACPI_SAR_NUM_CHAINS_REV0;
 		num_sub_bands =3D ACPI_SAR_NUM_SUB_BANDS_REV0;
@@ -610,10 +601,8 @@ int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fw=
rt)

 read_table:
 	if (wifi_pkg->package.elements[1].type !=3D ACPI_TYPE_INTEGER ||
-	    wifi_pkg->package.elements[2].type !=3D ACPI_TYPE_INTEGER) {
-		ret =3D -EINVAL;
-		goto out_free;
-	}
+	    wifi_pkg->package.elements[2].type !=3D ACPI_TYPE_INTEGER)
+		goto out_e_inval;

 	enabled =3D !!(wifi_pkg->package.elements[1].integer.value);
 	n_profiles =3D wifi_pkg->package.elements[2].integer.value;
@@ -623,10 +612,8 @@ int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fw=
rt)
 	 * from index 1, so the maximum value allowed here is
 	 * ACPI_SAR_PROFILES_NUM - 1.
 	 */
-	if (n_profiles >=3D BIOS_SAR_MAX_PROFILE_NUM) {
-		ret =3D -EINVAL;
-		goto out_free;
-	}
+	if (n_profiles >=3D BIOS_SAR_MAX_PROFILE_NUM)
+		goto out_e_inval;

 	/* the tables start at element 3 */
 	pos =3D 3;
@@ -651,6 +638,10 @@ int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fw=
rt)
 out_free:
 	kfree(data);
 	return ret;
+
+out_e_inval:
+	ret =3D -EINVAL;
+	goto out_free;
 }

 int iwl_acpi_get_wgds_table(struct iwl_fw_runtime *fwrt)
@@ -724,10 +715,9 @@ int iwl_acpi_get_wgds_table(struct iwl_fw_runtime *fw=
rt)
 				entry =3D &wifi_pkg->package.elements[entry_idx];
 				entry_idx++;
 				if (entry->type !=3D ACPI_TYPE_INTEGER ||
-				    entry->integer.value > num_profiles) {
-					ret =3D -EINVAL;
-					goto out_free;
-				}
+				    entry->integer.value > num_profiles)
+					goto out_e_inval;
+
 				num_profiles =3D entry->integer.value;

 				/*
@@ -736,10 +726,8 @@ int iwl_acpi_get_wgds_table(struct iwl_fw_runtime *fw=
rt)
 				 * looking up in ACPI
 				 */
 				if (wifi_pkg->package.count !=3D
-				    hdr_size + profile_size * num_profiles) {
-					ret =3D -EINVAL;
-					goto out_free;
-				}
+				    hdr_size + profile_size * num_profiles)
+					goto out_e_inval;
 			}
 			goto read_table;
 		}
@@ -769,10 +757,8 @@ int iwl_acpi_get_wgds_table(struct iwl_fw_runtime *fw=
rt)
 				entry =3D &wifi_pkg->package.elements[entry_idx];
 				entry_idx++;
 				if (entry->type !=3D ACPI_TYPE_INTEGER ||
-				    entry->integer.value > U8_MAX) {
-					ret =3D -EINVAL;
-					goto out_free;
-				}
+				    entry->integer.value > U8_MAX)
+					goto out_e_inval;

 				fwrt->geo_profiles[i].bands[j].max =3D
 					entry->integer.value;
@@ -787,10 +773,8 @@ int iwl_acpi_get_wgds_table(struct iwl_fw_runtime *fw=
rt)
 					entry =3D &wifi_pkg->package.elements[entry_idx];
 					entry_idx++;
 					if (entry->type !=3D ACPI_TYPE_INTEGER ||
-					    entry->integer.value > U8_MAX) {
-						ret =3D -EINVAL;
-						goto out_free;
-					}
+					    entry->integer.value > U8_MAX)
+						goto out_e_inval;

 					fwrt->geo_profiles[i].bands[j].chains[k] =3D
 						entry->integer.value;
@@ -805,6 +789,10 @@ int iwl_acpi_get_wgds_table(struct iwl_fw_runtime *fw=
rt)
 out_free:
 	kfree(data);
 	return ret;
+
+out_e_inval:
+	ret =3D -EINVAL;
+	goto out_free;
 }

 int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
@@ -829,8 +817,7 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwr=
t)
 					tbl_rev);
 			goto read_table;
 		} else {
-			ret =3D -EINVAL;
-			goto out_free;
+			goto out_e_inval;
 		}
 	}

@@ -839,10 +826,9 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fw=
rt)
 			ACPI_PPAG_WIFI_DATA_SIZE_V1, &tbl_rev);

 	if (!IS_ERR(wifi_pkg)) {
-		if (tbl_rev !=3D 0) {
-			ret =3D -EINVAL;
-			goto out_free;
-		}
+		if (tbl_rev !=3D 0)
+			goto out_e_inval;
+
 		num_sub_bands =3D IWL_NUM_SUB_BANDS_V1;
 		IWL_DEBUG_RADIO(fwrt, "Reading PPAG table v1 (tbl_rev=3D0)\n");
 		goto read_table;
@@ -855,10 +841,8 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fw=
rt)
 	fwrt->ppag_ver =3D tbl_rev;
 	flags =3D &wifi_pkg->package.elements[1];

-	if (flags->type !=3D ACPI_TYPE_INTEGER) {
-		ret =3D -EINVAL;
-		goto out_free;
-	}
+	if (flags->type !=3D ACPI_TYPE_INTEGER)
+		goto out_e_inval;

 	fwrt->ppag_flags =3D iwl_bios_get_ppag_flags(flags->integer.value,
 						   fwrt->ppag_ver);
@@ -873,10 +857,8 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fw=
rt)
 			union acpi_object *ent;

 			ent =3D &wifi_pkg->package.elements[idx++];
-			if (ent->type !=3D ACPI_TYPE_INTEGER) {
-				ret =3D -EINVAL;
-				goto out_free;
-			}
+			if (ent->type !=3D ACPI_TYPE_INTEGER)
+				goto out_e_inval;

 			fwrt->ppag_chains[i].subbands[j] =3D ent->integer.value;
 		}
@@ -887,6 +869,10 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fw=
rt)
 out_free:
 	kfree(data);
 	return ret;
+
+out_e_inval:
+	ret =3D -EINVAL;
+	goto out_free;
 }

 void iwl_acpi_get_phy_filters(struct iwl_fw_runtime *fwrt,
=2D-
2.43.0


