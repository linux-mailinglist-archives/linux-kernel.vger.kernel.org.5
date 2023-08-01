Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACA176B8BC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbjHAPiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbjHAPh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:37:57 -0400
Received: from frasgout13.his.huawei.com (ecs-14-137-139-46.compute.hwclouds-dns.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD9F268C;
        Tue,  1 Aug 2023 08:37:47 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4RFf8T0tnNz9yB7B;
        Tue,  1 Aug 2023 23:26:17 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.81.206.119])
        by APP1 (Coremail) with SMTP id LxC2BwA36biWJslk2IYdAA--.14146S3;
        Tue, 01 Aug 2023 16:37:22 +0100 (CET)
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Ian Lin <ian.lin@infineon.com>,
        Wright Feng <wright.feng@cypress.com>,
        Hector Martin <marcan@marcan.st>,
        Prasanna Kerekoppa <prasanna.kerekoppa@cypress.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ramesh Rangavittal <ramesh.rangavittal@infineon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ryohei Kondo <ryohei.kondo@cypress.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Brian Henriquez <brian.henriquez@cypress.com>,
        linux-wireless@vger.kernel.org (open list:BROADCOM BRCM80211
        IEEE802.11n WIRELESS DRIVER),
        brcm80211-dev-list.pdl@broadcom.com (open list:BROADCOM BRCM80211
        IEEE802.11n WIRELESS DRIVER),
        SHA-cyfmac-dev-list@infineon.com (open list:BROADCOM BRCM80211
        IEEE802.11n WIRELESS DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz
Subject: [PATCH v1 1/3] wifi: brcm80211: drop struct brcmf_p2p_scan_le
Date:   Tue,  1 Aug 2023 17:36:40 +0200
Message-Id: <b94c048c8decefeca41ceac5f826da67a8d727a8.1690904067.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690904067.git.petr.tesarik.ext@huawei.com>
References: <cover.1690904067.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwA36biWJslk2IYdAA--.14146S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCw47Kw1kAw4kGF15ZryftFb_yoW5tr15pF
        yxXa4qgwsxXw4a9w4UXa1kArW2yw42qw1ktFWYvw13Kas8Crn3JFWUKry8urW5C3yfA3yY
        vF45tF45urW2kFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
        AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2
        KfnxnUUI43ZEXa7VUjb_-PUUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

The 'S' scan method is not implemented. The type member is always written
as 'E' and never read. Consequently, struct brcmf_p2p_scan_le can be
replaced with struct brcmf_escan_params_le.

Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
---
 .../broadcom/brcm80211/brcmfmac/p2p.c         | 38 ++++---------------
 1 file changed, 8 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index d4492d02e4ea..915f95760470 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -123,23 +123,6 @@ enum brcmf_p2p_disc_state {
 	WL_P2P_DISC_ST_SEARCH
 };
 
-/**
- * struct brcmf_p2p_scan_le - P2P specific scan request.
- *
- * @type: type of scan method requested (values: 'E' or 'S').
- * @reserved: reserved (ignored).
- * @eparams: parameters used for type 'E'.
- * @sparams: parameters used for type 'S'.
- */
-struct brcmf_p2p_scan_le {
-	u8 type;
-	u8 reserved[3];
-	union {
-		struct brcmf_escan_params_le eparams;
-		struct brcmf_scan_params_le sparams;
-	};
-};
-
 /**
  * struct brcmf_p2p_pub_act_frame - WiFi P2P Public Action Frame
  *
@@ -646,14 +629,14 @@ static s32 brcmf_p2p_escan(struct brcmf_p2p_info *p2p, u32 num_chans,
 {
 	struct brcmf_pub *drvr = p2p->cfg->pub;
 	s32 ret = 0;
-	s32 memsize = offsetof(struct brcmf_p2p_scan_le,
-			       eparams.params_le.channel_list);
+	s32 memsize = offsetof(struct brcmf_escan_params_le,
+			       params_le.channel_list);
 	s32 nprobes;
 	s32 active;
 	u32 i;
 	u8 *memblk;
 	struct brcmf_cfg80211_vif *vif;
-	struct brcmf_p2p_scan_le *p2p_params;
+	struct brcmf_escan_params_le *eparams;
 	struct brcmf_scan_params_le *sparams;
 
 	memsize += num_chans * sizeof(__le16);
@@ -667,8 +650,8 @@ static s32 brcmf_p2p_escan(struct brcmf_p2p_info *p2p, u32 num_chans,
 		ret = -EINVAL;
 		goto exit;
 	}
-	p2p_params = (struct brcmf_p2p_scan_le *)memblk;
-	sparams = &p2p_params->eparams.params_le;
+	eparams = (struct brcmf_escan_params_le *)memblk;
+	sparams = &eparams->params_le;
 
 	switch (search_state) {
 	case WL_P2P_DISC_ST_SEARCH:
@@ -698,11 +681,6 @@ static s32 brcmf_p2p_escan(struct brcmf_p2p_info *p2p, u32 num_chans,
 
 	brcmf_p2p_set_discover_state(vif->ifp, search_state, 0, 0);
 
-	/*
-	 * set p2p scan parameters.
-	 */
-	p2p_params->type = 'E';
-
 	/* determine the scan engine parameters */
 	sparams->bss_type = DOT11_BSSTYPE_ANY;
 	sparams->scan_type = BRCMF_SCANTYPE_ACTIVE;
@@ -747,9 +725,9 @@ static s32 brcmf_p2p_escan(struct brcmf_p2p_info *p2p, u32 num_chans,
 		sparams->channel_list[i] = cpu_to_le16(chanspecs[i]);
 
 	/* set the escan specific parameters */
-	p2p_params->eparams.version = cpu_to_le32(BRCMF_ESCAN_REQ_VERSION);
-	p2p_params->eparams.action =  cpu_to_le16(WL_ESCAN_ACTION_START);
-	p2p_params->eparams.sync_id = cpu_to_le16(0x1234);
+	eparams->version = cpu_to_le32(BRCMF_ESCAN_REQ_VERSION);
+	eparams->action =  cpu_to_le16(WL_ESCAN_ACTION_START);
+	eparams->sync_id = cpu_to_le16(0x1234);
 	/* perform p2p scan on primary device */
 	ret = brcmf_fil_bsscfg_data_set(vif->ifp, "p2p_scan", memblk, memsize);
 	if (!ret)
-- 
2.25.1

