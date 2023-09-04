Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5B0791457
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 11:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbjIDJIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 05:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjIDJIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 05:08:11 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118AE184
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 02:08:08 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38497aPW081031;
        Mon, 4 Sep 2023 04:07:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1693818456;
        bh=9gx+aJFgLOE/Uv47M7kjrLmMOCgce/x7+xPWpwyQB/4=;
        h=From:To:CC:Subject:Date;
        b=Q9O9aRy56K8yQDjYDSvsUEn+2/1vzrdiFncWXR2YkbdhSJUQDQlb1tXg5ZEx+Dvu9
         NN91YeaK53pXphhaom1xdanB1WtmCc6Aza4BrQDRAIFr62qxVmg/8aGojcV/Oy8Jji
         hScoIWZWPnLZQmDQeJLNKWQLLl9rvZPyEFSMaFgo=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38497apN025364
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Sep 2023 04:07:36 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Sep 2023 04:07:35 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Sep 2023 04:07:35 -0500
Received: from LT5CG31242FY.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38497TNO115432;
        Mon, 4 Sep 2023 04:07:30 -0500
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
Subject: [PATCH v1] ALSA: hda/tas2781: Update tas2781 HDA driver
Date:   Mon, 4 Sep 2023 17:07:24 +0800
Message-ID: <20230904090725.1388-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revert structure cs35l41_dev_name and redefine tas2781_generic_fixup.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
Changes in v1:
 - Redefine tas2781_generic_fixup, remove hid param
 - revert from scodec_dev_name back to cs35l41_dev_name, it is unnecessary
   for tas2781
---
 sound/pci/hda/patch_realtek.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a07df6f929..c3e410152b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6745,7 +6745,7 @@ static void comp_generic_playback_hook(struct hda_pcm_stream *hinfo, struct hda_
 	}
 }
 
-struct scodec_dev_name {
+struct cs35l41_dev_name {
 	const char *bus;
 	const char *hid;
 	int index;
@@ -6754,7 +6754,7 @@ struct scodec_dev_name {
 /* match the device name in a slightly relaxed manner */
 static int comp_match_cs35l41_dev_name(struct device *dev, void *data)
 {
-	struct scodec_dev_name *p = data;
+	struct cs35l41_dev_name *p = data;
 	const char *d = dev_name(dev);
 	int n = strlen(p->bus);
 	char tmp[32];
@@ -6773,19 +6773,19 @@ static int comp_match_cs35l41_dev_name(struct device *dev, void *data)
 static int comp_match_tas2781_dev_name(struct device *dev,
 	void *data)
 {
-	struct scodec_dev_name *p = data;
+	const char *bus = data;
 	const char *d = dev_name(dev);
-	int n = strlen(p->bus);
+	int n = strlen(bus);
 	char tmp[32];
 
 	/* check the bus name */
-	if (strncmp(d, p->bus, n))
+	if (strncmp(d, bus, n))
 		return 0;
 	/* skip the bus number */
 	if (isdigit(d[n]))
 		n++;
 	/* the rest must be exact matching */
-	snprintf(tmp, sizeof(tmp), "-%s:00", p->hid);
+	snprintf(tmp, sizeof(tmp), "-%s:00", "TIAS2781");
 
 	return !strcmp(d + n, tmp);
 }
@@ -6795,7 +6795,7 @@ static void cs35l41_generic_fixup(struct hda_codec *cdc, int action, const char
 {
 	struct device *dev = hda_codec_dev(cdc);
 	struct alc_spec *spec = cdc->spec;
-	struct scodec_dev_name *rec;
+	struct cs35l41_dev_name *rec;
 	int ret, i;
 
 	switch (action) {
@@ -6824,24 +6824,17 @@ static void cs35l41_generic_fixup(struct hda_codec *cdc, int action, const char
 }
 
 static void tas2781_generic_fixup(struct hda_codec *cdc, int action,
-	const char *bus, const char *hid)
+	const char *bus)
 {
 	struct device *dev = hda_codec_dev(cdc);
 	struct alc_spec *spec = cdc->spec;
-	struct scodec_dev_name *rec;
 	int ret;
 
 	switch (action) {
 	case HDA_FIXUP_ACT_PRE_PROBE:
-		rec = devm_kmalloc(dev, sizeof(*rec), GFP_KERNEL);
-		if (!rec)
-			return;
-		rec->bus = bus;
-		rec->hid = hid;
-		rec->index = 0;
 		spec->comps[0].codec = cdc;
 		component_match_add(dev, &spec->match,
-			comp_match_tas2781_dev_name, rec);
+			comp_match_tas2781_dev_name, (void *)bus);
 		ret = component_master_add_with_match(dev, &comp_master_ops,
 			spec->match);
 		if (ret)
@@ -6888,7 +6881,7 @@ static void alc287_fixup_legion_16ithg6_speakers(struct hda_codec *cdc, const st
 static void tas2781_fixup_i2c(struct hda_codec *cdc,
 	const struct hda_fixup *fix, int action)
 {
-	 tas2781_generic_fixup(cdc, action, "i2c", "TIAS2781");
+	 tas2781_generic_fixup(cdc, action, "i2c");
 }
 
 /* for alc295_fixup_hp_top_speakers */
-- 
2.34.1

