Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D686768B75
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 07:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjGaF7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 01:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGaF7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 01:59:41 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D228ABF
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 22:59:38 -0700 (PDT)
X-ASG-Debug-ID: 1690783173-086e23186c02d30001-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id eLJcoea6GwdQb7d8 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 31 Jul 2023 13:59:33 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 31 Jul
 2023 13:59:33 +0800
Received: from tony-HX002EA.zhaoxin.com (10.32.65.162) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 31 Jul
 2023 13:59:31 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
To:     <perex@perex.cz>, <tiwai@suse.com>,
        <pierre-louis.bossart@linux.intel.com>,
        <zhangyiqun@phytium.com.cn>, <peter.ujfalusi@linux.intel.com>,
        <broonie@kernel.org>, <TonyWWang-oc@zhaoxin.com>,
        <chenhuacai@kernel.org>, <cezary.rojewski@intel.com>,
        <siyanteng@loongson.cn>, <amadeuszx.slawinski@linux.intel.com>,
        <evan.quan@amd.com>, <jasontao@glenfly.com>,
        <kai.vehmanen@linux.intel.com>,
        <ranjani.sridharan@linux.intel.com>, <mkumard@nvidia.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>,
        <LeoLiu-oc@zhaoxin.com>
Subject: [PATCH] ALSA: hda: Zhaoxin: Add HDAC PCI IDs and HDMI Codec Vendor IDs
Date:   Mon, 31 Jul 2023 13:59:32 +0800
X-ASG-Orig-Subj: [PATCH] ALSA: hda: Zhaoxin: Add HDAC PCI IDs and HDMI Codec Vendor IDs
Message-ID: <20230731055932.4336-1-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.32.65.162]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1690783173
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 8603
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.112108
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add newer HD Audio PCI IDs, and HDMI codec vendor IDs for Zhaoxin.

The quirk of AZX_DCAPS_RIRB_PRE_DELAY implies that write response
from codec to memory needs delay when synchronized to memory after
interrupt happened. For KX-5000 needs raising the priority of write
cycles additionally, so add specific register setting codes for it.

Because Zhaoxin hardware limitation, set BDL position to 128 to
increase interrupt interval.

Because Zhaoxin HDMI codec need driver to do actual clean-ups for
the linked codec when switch from one codec to another, set
no_sticky_stream for Zhaoxin HDMI codec too.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 sound/pci/hda/hda_controller.c | 17 +++++++++++-
 sound/pci/hda/hda_controller.h |  2 ++
 sound/pci/hda/hda_intel.c      | 51 +++++++++++++++++++++++++++++++++-
 sound/pci/hda/patch_hdmi.c     | 13 +++++++++
 4 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 406779625fb5..7b7a7735c482 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1044,6 +1044,16 @@ void azx_stop_chip(struct azx *chip)
 }
 EXPORT_SYMBOL_GPL(azx_stop_chip);
 
+static void azx_rirb_zxdelay(struct azx *chip, int enable)
+{
+	if (chip->remap_diu_addr) {
+		if (!enable)
+			writel(0x0, (char *)chip->remap_diu_addr + 0x490a8);
+		else
+			writel(0x1000000, (char *)chip->remap_diu_addr + 0x490a8);
+	}
+}
+
 /*
  * interrupt handler
  */
@@ -1103,9 +1113,14 @@ irqreturn_t azx_interrupt(int irq, void *dev_id)
 			azx_writeb(chip, RIRBSTS, RIRB_INT_MASK);
 			active = true;
 			if (status & RIRB_INT_RESPONSE) {
-				if (chip->driver_caps & AZX_DCAPS_CTX_WORKAROUND)
+				if ((chip->driver_caps & AZX_DCAPS_CTX_WORKAROUND) ||
+					(chip->driver_caps & AZX_DCAPS_RIRB_PRE_DELAY)) {
+					azx_rirb_zxdelay(chip, 1);
 					udelay(80);
+				}
 				snd_hdac_bus_update_rirb(bus);
+				if (chip->driver_caps & AZX_DCAPS_RIRB_PRE_DELAY)
+					azx_rirb_zxdelay(chip, 0);
 			}
 		}
 	} while (active && ++repeat < 10);
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index 8556031bcd68..ba51e33329c1 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -45,6 +45,7 @@
 #define AZX_DCAPS_CORBRP_SELF_CLEAR (1 << 28)	/* CORBRP clears itself after reset */
 #define AZX_DCAPS_NO_MSI64      (1 << 29)	/* Stick to 32-bit MSIs */
 #define AZX_DCAPS_SEPARATE_STREAM_TAG	(1 << 30) /* capture and playback use separate stream tag */
+#define AZX_DCAPS_RIRB_PRE_DELAY (1 << 31)	/* RIRB need delay */
 
 enum {
 	AZX_SNOOP_TYPE_NONE,
@@ -145,6 +146,7 @@ struct azx {
 
 	/* GTS present */
 	unsigned int gts_present:1;
+	void __iomem *remap_diu_addr;
 
 #ifdef CONFIG_SND_HDA_DSP_LOADER
 	struct azx_dev saved_azx_dev;
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 176567f0d0e0..d5dce7e7ef4a 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -238,6 +238,7 @@ enum {
 	AZX_DRIVER_CMEDIA,
 	AZX_DRIVER_ZHAOXIN,
 	AZX_DRIVER_LOONGSON,
+	AZX_DRIVER_ZHAOXINHDMI,
 	AZX_DRIVER_GENERIC,
 	AZX_NUM_DRIVERS, /* keep this as last entry */
 };
@@ -350,6 +351,7 @@ static const char * const driver_short_names[] = {
 	[AZX_DRIVER_CMEDIA] = "HDA C-Media",
 	[AZX_DRIVER_ZHAOXIN] = "HDA Zhaoxin",
 	[AZX_DRIVER_LOONGSON] = "HDA Loongson",
+	[AZX_DRIVER_ZHAOXINHDMI] = "HDA Zhaoxin HDMI",
 	[AZX_DRIVER_GENERIC] = "HD-Audio Generic",
 };
 
@@ -371,6 +373,29 @@ static void update_pci_byte(struct pci_dev *pci, unsigned int reg,
 	pci_write_config_byte(pci, reg, data);
 }
 
+static int azx_init_pci_zx(struct azx *chip)
+{
+	struct snd_card *card = chip->card;
+	unsigned int diu_reg;
+	struct pci_dev *diu_pci = NULL;
+
+	diu_pci = pci_get_device(PCI_VENDOR_ID_ZHAOXIN, 0x3a03, NULL);
+	if (!diu_pci) {
+		dev_err(card->dev, "hda no KX-5000 device.\n");
+		return -ENXIO;
+	}
+	pci_read_config_dword(diu_pci, PCI_BASE_ADDRESS_0, &diu_reg);
+	chip->remap_diu_addr = ioremap(diu_reg, 0x50000);
+	dev_info(card->dev, "hda %x %p\n", diu_reg, chip->remap_diu_addr);
+	return 0;
+}
+
+static void azx_free_pci_zx(struct azx *chip)
+{
+	if (chip->remap_diu_addr)
+		iounmap(chip->remap_diu_addr);
+}
+
 static void azx_init_pci(struct azx *chip)
 {
 	int snoop_type = azx_get_snoop_type(chip);
@@ -1360,6 +1385,10 @@ static void azx_free(struct azx *chip)
 	hda->init_failed = 1; /* to be sure */
 	complete_all(&hda->probe_wait);
 
+	if (chip->driver_type == AZX_DRIVER_ZHAOXINHDMI) {
+		azx_free_pci_zx(chip);
+	}
+
 	if (use_vga_switcheroo(hda)) {
 		if (chip->disabled && hda->probe_continued)
 			snd_hda_unlock_devices(&chip->bus);
@@ -1743,10 +1772,11 @@ static int default_bdl_pos_adj(struct azx *chip)
 
 	switch (chip->driver_type) {
 	/*
-	 * increase the bdl size for Glenfly Gpus for hardware
+	 * increase the bdl size for Glenfly/Zhaoxin Gpus for hardware
 	 * limitation on hdac interrupt interval
 	 */
 	case AZX_DRIVER_GFHDMI:
+	case AZX_DRIVER_ZHAOXINHDMI:
 		return 128;
 	case AZX_DRIVER_ICH:
 	case AZX_DRIVER_PCH:
@@ -1876,6 +1906,10 @@ static int azx_first_init(struct azx *chip)
 		bus->access_sdnctl_in_dword = 1;
 	}
 
+	chip->remap_diu_addr = NULL;
+	if (chip->driver_type == AZX_DRIVER_ZHAOXINHDMI)
+		azx_init_pci_zx(chip);
+
 	err = pcim_iomap_regions(pci, 1 << 0, "ICH HD audio");
 	if (err < 0)
 		return err;
@@ -1977,6 +2011,7 @@ static int azx_first_init(struct azx *chip)
 			chip->capture_streams = ATIHDMI_NUM_CAPTURE;
 			break;
 		case AZX_DRIVER_GFHDMI:
+		case AZX_DRIVER_ZHAOXINHDMI:
 		case AZX_DRIVER_GENERIC:
 		default:
 			chip->playback_streams = ICH6_NUM_PLAYBACK;
@@ -2739,6 +2774,20 @@ static const struct pci_device_id azx_ids[] = {
 	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_HDMI },
 	/* Zhaoxin */
 	{ PCI_VDEVICE(ZHAOXIN, 0x3288), .driver_data = AZX_DRIVER_ZHAOXIN },
+	{ PCI_VDEVICE(ZHAOXIN, 0x9141),
+	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_NO_64BIT },
+	{ PCI_VDEVICE(ZHAOXIN, 0x9142),
+	  .driver_data = AZX_DRIVER_ZHAOXINHDMI | AZX_DCAPS_POSFIX_LPIB |
+	  AZX_DCAPS_NO_MSI | AZX_DCAPS_RIRB_PRE_DELAY | AZX_DCAPS_NO_64BIT },
+	{ PCI_VDEVICE(ZHAOXIN, 0x9144),
+	  .driver_data = AZX_DRIVER_ZHAOXINHDMI | AZX_DCAPS_POSFIX_LPIB |
+	  AZX_DCAPS_NO_MSI | AZX_DCAPS_RIRB_PRE_DELAY | AZX_DCAPS_NO_64BIT },
+	{ PCI_VDEVICE(ZHAOXIN, 0x9145),
+	  .driver_data = AZX_DRIVER_ZHAOXINHDMI | AZX_DCAPS_POSFIX_LPIB |
+	  AZX_DCAPS_NO_MSI | AZX_DCAPS_RIRB_PRE_DELAY | AZX_DCAPS_NO_64BIT },
+	{ PCI_VDEVICE(ZHAOXIN, 0x9146),
+	  .driver_data = AZX_DRIVER_ZHAOXINHDMI | AZX_DCAPS_POSFIX_LPIB |
+	  AZX_DCAPS_NO_MSI | AZX_DCAPS_RIRB_PRE_DELAY | AZX_DCAPS_NO_64BIT },
 	/* Loongson HDAudio*/
 	{ PCI_VDEVICE(LOONGSON, PCI_DEVICE_ID_LOONGSON_HDA),
 	  .driver_data = AZX_DRIVER_LOONGSON },
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 1cde2a69bdb4..58ae77aa1ad9 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -4501,6 +4501,8 @@ static int patch_gf_hdmi(struct hda_codec *codec)
 	return 0;
 }
 
+static int patch_zx_hdmi(struct hda_codec *codec) { return patch_gf_hdmi(codec); }
+
 /*
  * patch entries
  */
@@ -4607,6 +4609,17 @@ HDA_CODEC_ENTRY(0x11069f80, "VX900 HDMI/DP",	patch_via_hdmi),
 HDA_CODEC_ENTRY(0x11069f81, "VX900 HDMI/DP",	patch_via_hdmi),
 HDA_CODEC_ENTRY(0x11069f84, "VX11 HDMI/DP",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x11069f85, "VX11 HDMI/DP",	patch_generic_hdmi),
+HDA_CODEC_ENTRY(0x1d179f86, "ZX-100S HDMI/DP",	patch_generic_hdmi),
+HDA_CODEC_ENTRY(0x1d179f87, "ZX-100S HDMI/DP",	patch_generic_hdmi),
+HDA_CODEC_ENTRY(0x1d179f88, "KX-5000 HDMI/DP",	patch_zx_hdmi),
+HDA_CODEC_ENTRY(0x1d179f89, "KX-5000 HDMI/DP",	patch_zx_hdmi),
+HDA_CODEC_ENTRY(0x1d179f8a, "KX-6000 HDMI/DP",	patch_zx_hdmi),
+HDA_CODEC_ENTRY(0x1d179f8b, "KX-6000 HDMI/DP",	patch_zx_hdmi),
+HDA_CODEC_ENTRY(0x1d179f8c, "KX-6000G HDMI/DP",	patch_zx_hdmi),
+HDA_CODEC_ENTRY(0x1d179f8d, "KX-6000G HDMI/DP",	patch_zx_hdmi),
+HDA_CODEC_ENTRY(0x1d179f8e, "KX-8000 HDMI/DP", patch_zx_hdmi),
+HDA_CODEC_ENTRY(0x1d179f8f, "KX-8000 HDMI/DP", patch_zx_hdmi),
+HDA_CODEC_ENTRY(0x1d179f90, "KX-8000 HDMI/DP", patch_zx_hdmi),
 HDA_CODEC_ENTRY(0x80860054, "IbexPeak HDMI",	patch_i915_cpt_hdmi),
 HDA_CODEC_ENTRY(0x80862800, "Geminilake HDMI",	patch_i915_glk_hdmi),
 HDA_CODEC_ENTRY(0x80862801, "Bearlake HDMI",	patch_generic_hdmi),
-- 
2.17.1

