Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74737DE429
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjKAPtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjKAPts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:49:48 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE76510C;
        Wed,  1 Nov 2023 08:49:40 -0700 (PDT)
X-UUID: 41e5068278ce11ee8051498923ad61e6-20231101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Ov9TiPDknb6R9yF2IVYZFuRm6kOrz1Qf6/9qeS+Jpgw=;
        b=tn1FxN3s2FjIgUDdiAJzn5pnR/1n9IYeqXV652hLmM9ru50zq1/xEx+1JcA7P787YHkiA0SXF4MAgwlhwENK5MqoBb6jC3W/Bas1/cd0IjjmpVyj/0aCAlwC4ajot/X/QpbVSqV70weS6mNe6NExJtAkFkJB4q8/hFeT/Jug6hI=;
X-CID-CACHE: Type:Local,Time:202311012337+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:5f823a4a-bafd-4a1a-bd5d-938640fa097f,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:364b77b,CLOUDID:eb9c2872-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 41e5068278ce11ee8051498923ad61e6-20231101
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <bo.ye@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 554406059; Wed, 01 Nov 2023 23:49:35 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 1 Nov 2023 23:49:34 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 1 Nov 2023 23:49:33 +0800
From:   Bo Ye <bo.ye@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <yongdong.zhang@mediatek.com>, <browse.zhang@mediatek.com>,
        <lin.gui@mediatek.com>, <qilin.tan@mediatek.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] mmc: add wp_grp_size node
Date:   Wed, 1 Nov 2023 23:49:26 +0800
Message-ID: <20231101154927.119312-1-bo.ye@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.192800-8.000000
X-TMASE-MatchedRID: th1XRPLu1HNGlhjnipkGEAwfhKwa9GwD+lX/RcQoG2FX4H/AHZTAKiQH
        YX2qyjfSlB6IdnaWhV1I7JPsZpNRgcL2WgOVZLNHhDqIQb7sQecK3n1SHen81VeilmPI7oJlf8S
        IQrqULYwLYtJsevMdjZZLxtyQINIccMMjBRRYYhwflhDI6DvVlkJfxXUWJFGS31GU/N5W5BBLR6
        I6ytdxONZKQinVddBT3D2hj0hvDabf0vAzbUUm26am63kopwnT57kkHY8cvsS6Kbobcv5luFpqk
        DNHM8v+nFqPTSvsB8lzQ71/lVVm1vJMF6pylZNW1tU7lyp9XhEoPUUDFlEi1db1HR1TV5h03x8z
        1cIgGiHi8zVgXoAltsIJ+4gwXrEtIAcCikR3vq9j6bKbLCMItm8ICwgw12VPO6dim/ocNbcn4VX
        tjVje77MxnEq2nQWr
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.192800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 0F899615BDE2A6CD307BF16FE736E603887F1EBB5A91C4D58CC90BFFF96AE5642000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "lin.gui" <lin.gui@mediatek.com>

Detail:
Add node "wp_grp_size", corresponding to WP_GRP_SIZE
(write protect group size) of eMMC's CSD register.

Scenario:
The eMMC card can be set into write-protected mode to
prevent data from being accidentally modified or deleted.
Wp_grp_size (Write Protect Group Size) refers to an
attribute of the eMMC card, used to manage write protection,
and is the CSD register  [36:32] of the eMMC device.
Wp_grp_size (Write Protect Group Size) indicates how many
eMMC blocks are contained in each write protection group on the eMMC card.

Final rendered file:
"/sys/class/mmc_host/mmc0/mmc0:0001/wp_grp_size"

Signed-off-by: lin.gui <lin.gui@mediatek.com>
Change-Id: I73952dbde2db375ba918daadb3264380b7863096
---
 drivers/mmc/core/mmc.c   | 16 +++++++++++++++-
 include/linux/mmc/card.h |  2 ++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 4a4bab9aa726..9b67e49a9e63 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -136,6 +136,17 @@ static void mmc_set_erase_size(struct mmc_card *card)
 	mmc_init_erase(card);
 }
 
+
+static void mmc_set_wp_grp_size(struct mmc_card *card)
+{
+	if (card->ext_csd.erase_group_def & 1)
+		card->wp_grp_size = card->ext_csd.hc_erase_size *
+			card->ext_csd.raw_hc_erase_gap_size;
+	else
+		card->wp_grp_size = card->csd.erase_size *
+			(card->csd.wp_grp_size + 1);
+}
+
 /*
  * Given a 128-bit response, decode to our card CSD structure.
  */
@@ -186,6 +197,7 @@ static int mmc_decode_csd(struct mmc_card *card)
 		b = UNSTUFF_BITS(resp, 37, 5);
 		csd->erase_size = (a + 1) * (b + 1);
 		csd->erase_size <<= csd->write_blkbits - 9;
+		csd->wp_grp_size = UNSTUFF_BITS(resp, 32, 5);
 	}
 
 	return 0;
@@ -791,6 +803,7 @@ MMC_DEV_ATTR(csd, "%08x%08x%08x%08x\n", card->raw_csd[0], card->raw_csd[1],
 MMC_DEV_ATTR(date, "%02d/%04d\n", card->cid.month, card->cid.year);
 MMC_DEV_ATTR(erase_size, "%u\n", card->erase_size << 9);
 MMC_DEV_ATTR(preferred_erase_size, "%u\n", card->pref_erase << 9);
+MMC_DEV_ATTR(wp_grp_size, "%u\n", card->wp_grp_size << 9);
 MMC_DEV_ATTR(ffu_capable, "%d\n", card->ext_csd.ffu_capable);
 MMC_DEV_ATTR(hwrev, "0x%x\n", card->cid.hwrev);
 MMC_DEV_ATTR(manfid, "0x%06x\n", card->cid.manfid);
@@ -851,6 +864,7 @@ static struct attribute *mmc_std_attrs[] = {
 	&dev_attr_date.attr,
 	&dev_attr_erase_size.attr,
 	&dev_attr_preferred_erase_size.attr,
+	&dev_attr_wp_grp_size.attr,
 	&dev_attr_fwrev.attr,
 	&dev_attr_ffu_capable.attr,
 	&dev_attr_hwrev.attr,
@@ -1759,7 +1773,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			mmc_set_erase_size(card);
 		}
 	}
-
+	mmc_set_wp_grp_size(card);
 	/*
 	 * Ensure eMMC user default partition is enabled
 	 */
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index daa2f40d9ce6..62873ecc52f1 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -32,6 +32,7 @@ struct mmc_csd {
 	unsigned int		r2w_factor;
 	unsigned int		max_dtr;
 	unsigned int		erase_size;		/* In sectors */
+	unsigned int		wp_grp_size;
 	unsigned int		read_blkbits;
 	unsigned int		write_blkbits;
 	unsigned int		capacity;
@@ -304,6 +305,7 @@ struct mmc_card {
 	unsigned int		eg_boundary;	/* don't cross erase-group boundaries */
 	unsigned int		erase_arg;	/* erase / trim / discard */
  	u8			erased_byte;	/* value of erased bytes */
+	unsigned int		wp_grp_size; /* write group size in sectors */
 
 	u32			raw_cid[4];	/* raw card CID */
 	u32			raw_csd[4];	/* raw card CSD */
-- 
2.17.0

