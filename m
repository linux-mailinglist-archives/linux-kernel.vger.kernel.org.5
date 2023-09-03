Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80753790C82
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 16:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240272AbjICOjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 10:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239862AbjICOjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 10:39:03 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9B6F5
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 07:38:59 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 383EcN98003267;
        Sun, 3 Sep 2023 09:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1693751903;
        bh=v6pe/Dt8AerprFgjS5Gcdn7rSGlsyB+4xsmT0PdVs2A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WIb4ofuCndyGlZVpvm3YB2Gvnl2n3dUBMiN0aIEEcz4ZyjY7HehtxwUHRSJnm8rR+
         FAP9GM/D3DL/ZV+mXIfkFD2cBr9yHvQWknORkbSBQOsQaikGLRVnbPkXGjAKV3meoU
         tz2KdjwxFMcjHlSE31sh5F5ukiPzoUnCyoVRt1lo=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 383EcNWo018035
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 3 Sep 2023 09:38:23 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 3
 Sep 2023 09:38:22 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 3 Sep 2023 09:38:22 -0500
Received: from LT5CG31242FY.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 383Ec9Ew064460;
        Sun, 3 Sep 2023 09:38:17 -0500
From:   Shenghao Ding <shenghao-ding@ti.com>
To:     <tiwai@suse.de>
CC:     <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <lgirdwood@gmail.com>, <perex@perex.cz>,
        <pierre-louis.bossart@linux.intel.com>, <kevin-lu@ti.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <mengdong.lin@intel.com>, <baojun.xu@ti.com>,
        <thomas.gfeller@q-drop.com>, <peeyush@ti.com>, <navada@ti.com>,
        <broonie@kernel.org>, <gentuser@gmail.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1 2/2] ALSA: hda/tas2781: Update tas2781 HDA driver
Date:   Sun, 3 Sep 2023 22:37:58 +0800
Message-ID: <20230903143759.92-2-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20230903143759.92-1-shenghao-ding@ti.com>
References: <20230903143759.92-1-shenghao-ding@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support ACPI_ID both TXNW2781 and TIAS2781, update dsp/bypass mode
switching in tasdevice_program_put.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
Changes in v1:
 - Add comment on dsp/bypass mode in tasdevice_program_put and
   tasdevice_info_programs
 - TIAS2781 has been used by our customers, see following dstd.dsl. We
   have discussed this with them, they requested TIAS2781 must be
   supported for the laptops already released to market, their new laptop
   can switch to TXNW2781
   Name (_HID, "TIAS2781")  // _HID: Hardware ID
   Name (_UID, Zero)  // _UID: Unique ID
   Method (_SUB, 0, NotSerialized)  // _SUB: Subsystem ID
   {
       If ((SPID == Zero))
       {
          Return ("17AA3886")
       }

       If ((SPID == One))
       {
           Return ("17AA3884")
       }
   }
---
 sound/pci/hda/tas2781_hda_i2c.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index fb80280293..5250d300a2 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -199,8 +199,11 @@ static int tasdevice_info_programs(struct snd_kcontrol *kcontrol,
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 1;
+	/* 0:			dsp mode
+	 * non-zero:	bypass mode
+	 */
 	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = tas_fw->nr_programs - 1;
+	uinfo->value.integer.max = tas_fw->nr_programs;
 
 	return 0;
 }
@@ -238,7 +241,10 @@ static int tasdevice_program_put(struct snd_kcontrol *kcontrol,
 	int max = tas_fw->nr_programs - 1;
 	int val, ret = 0;
 
-	val = clamp(nr_program, 0, max);
+	/* 0:			dsp mode
+	 * non-zero:	bypass mode
+	 */
+	val = (nr_program) ? max : 0;
 
 	if (tas_priv->cur_prog != val) {
 		tas_priv->cur_prog = val;
@@ -647,7 +653,9 @@ static int tas2781_hda_i2c_probe(struct i2c_client *clt)
 	const char *device_name;
 	int ret;
 
-	if (strstr(dev_name(&clt->dev), "TIAS2781"))
+	if (strstr(dev_name(&clt->dev), "TXNW2781"))
+		device_name = "TXNW2781";
+	else if (strstr(dev_name(&clt->dev), "TIAS2781"))
 		device_name = "TIAS2781";
 	else
 		return -ENODEV;
@@ -824,6 +832,7 @@ static const struct i2c_device_id tas2781_hda_i2c_id[] = {
 
 static const struct acpi_device_id tas2781_acpi_hda_match[] = {
 	{"TIAS2781", 0 },
+	{"TXNW2781", 1 },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, tas2781_acpi_hda_match);
-- 
2.34.1

