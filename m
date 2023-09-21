Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8305D7AA2EA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbjIUVmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjIUVm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:42:28 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30504914C5;
        Thu, 21 Sep 2023 13:34:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695328474; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=to4FZCbRwcRzKdeJ1mP8+pdwViPslNBh4WGE3bEoyQfGnczi5p/d4ohFefO6ZSHdg9
    2MbAatpQsd49E7SQ+nk1KOMvmzjzh08GKtIjhoIq0p+7bBeGPLl+g+XsEEEPIv0Mpmzw
    huiPcQ1VqOsa8Ajlwqp/PrqB81PRUjrPYJBGx5KBPsC4n+N5m93IL+jOWuMpSeZ7l9E2
    bw1ArQlhDo0wnUVeFO8eeNdYM5QdXP4FZS3A9kdb2nIFpS/NhkJ5+MnkFoKE1Zjwka+a
    LkEEBD7DV/zsNKBs5PwZHIedYT6kdDY5es2D6o6wJnZndPaGYTBJbyT8hqXGl2hNpB+j
    +5+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695328474;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=J0nR2muyYS1TkYpyAE/l8A0M3UYTbFjIRjyGUoG0Wew=;
    b=dOGRxkRI7cEXdJB5HtUFr+pTmpauXNueEvA8wt7yxNOIb8SpNBtrlTmPM/sMJDlIUE
    HLelAZw0GAbbSNrpYay5IOh8NphGtc9gU9GB3MKduq/H4co0A9e1hyroMHpheb2HXJON
    MBUWb9xXKRK7XVvBBw/ldmPJ+1KqI139HvTsOlUCz20vu8mApY0BMyTO3DvCgSu96iav
    ZvPftbV62FNO4KnOSRTfaDz+n5qXb2pudazJl+0nOzsempNUOeBU04mu81Pdpnzwsxpf
    biO7xvcRGAhPbrZkuDqwXZnXZKSzq3hR//IxcZ8QTKbC+jI+HvIeo5Pu3+Kfe0Q0gGtK
    3qjA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695328474;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=J0nR2muyYS1TkYpyAE/l8A0M3UYTbFjIRjyGUoG0Wew=;
    b=GQXutuR22et10f3Y0bPE1jAp4H80TyriH1z33R3Y2Yf3iaiXXXIzYb4UxsNU175sZO
    l2aauA3uPhVgACd/dnEdDqwbzE15HGJ42mvRG0TsgM3lTGo1T8Sm2Q3LIHlb8+X5cFm0
    rDB3zMlqA7cDpeZnQuuCCVggS+Axbt1wu4BsnyMcUN58c9eGM8R+GB8fVBfhzNohiMqe
    smeP23XVOtnnyyzddzEFDYvwhsAF7EM9dYIGCN7iQQykMmXdMLHHhSaJhxgcVHE6LegF
    SF8L7PJWV4a1bkr2HDPWqnnWp+tQOs0ElmVBMbIg20HJ76+BG9anwMOBhQuKh+aPIJsg
    l/QA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695328474;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=J0nR2muyYS1TkYpyAE/l8A0M3UYTbFjIRjyGUoG0Wew=;
    b=Ff1M6q5Rvjxe0XTBaoXIwqjqpuTjfhpfwXz26maVc/GiKwk8PawigSd833I2LR1aco
    sQyTSvTUR52r3+/SoiBQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1BzWso7brrTixenVtuORDAoORyBxZr4Riojd"
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 49.8.2 AUTH)
    with ESMTPSA id V04024z8LKYYYNv
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 21 Sep 2023 22:34:34 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        beanhuo@micron.com, jakub.kwapisz@toradex.com,
        rafael.beims@toradex.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v3] mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for Micron eMMC Q2J54A
Date:   Thu, 21 Sep 2023 22:34:26 +0200
Message-Id: <20230921203426.638262-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Micron MTFC4GACAJCN eMMC supports cache but requires that flush cache
operation be allowed only after a write has occurred. Otherwise, the
cache flush command or subsequent commands will time out.

Signed-off-by: Bean Huo <beanhuo@micron.com>
Co-developed-by: Rafael Beims <rafael.beims@toradex.com>
Cc: stable@vger.kernel.org
---
Changelog:

v2--v3:
    1. Set card->written_flag in mmc_blk_mq_issue_rq().
v1--v2:
    1. Add Rafael's test-tag, and Co-developed-by.
    2. Check host->card whether NULL or not in __mmc_start_request() before asserting host->card->->quirks
---
 drivers/mmc/core/block.c  | 4 ++++
 drivers/mmc/core/mmc.c    | 5 +++++
 drivers/mmc/core/quirks.h | 7 ++++---
 include/linux/mmc/card.h  | 2 ++
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 3a8f27c3e310..14d0dc7942de 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2387,6 +2387,10 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
 				ret = mmc_blk_cqe_issue_rw_rq(mq, req);
 			else
 				ret = mmc_blk_mq_issue_rw_rq(mq, req);
+
+			if (host->card->quirks & MMC_QUIRK_BROKEN_CACHE_FLUSH &&
+			    !host->card->written_flag && !ret)
+				host->card->written_flag = true;
 			break;
 		default:
 			WARN_ON_ONCE(1);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 89cd48fcec79..a2edd065fa1b 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1929,6 +1929,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	if (!oldcard)
 		host->card = card;
 
+	card->written_flag = false;
+
 	return 0;
 
 free_card:
@@ -2081,6 +2083,9 @@ static int _mmc_flush_cache(struct mmc_host *host)
 {
 	int err = 0;
 
+	if (host->card->quirks & MMC_QUIRK_BROKEN_CACHE_FLUSH && !host->card->written_flag)
+		return err;
+
 	if (_mmc_cache_enabled(host)) {
 		err = mmc_switch(host->card, EXT_CSD_CMD_SET_NORMAL,
 				 EXT_CSD_FLUSH_CACHE, 1,
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index 32b64b564fb1..5e68c8b4cdca 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -110,11 +110,12 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
 		  MMC_QUIRK_TRIM_BROKEN),
 
 	/*
-	 * Micron MTFC4GACAJCN-1M advertises TRIM but it does not seems to
-	 * support being used to offload WRITE_ZEROES.
+	 * Micron MTFC4GACAJCN-1M supports TRIM but does not appear to suppor
+	 * WRITE_ZEROES offloading. It also supports caching, but the cache can
+	 * only be flushed after a write has occurred.
 	 */
 	MMC_FIXUP("Q2J54A", CID_MANFID_MICRON, 0x014e, add_quirk_mmc,
-		  MMC_QUIRK_TRIM_BROKEN),
+		  MMC_QUIRK_TRIM_BROKEN | MMC_QUIRK_BROKEN_CACHE_FLUSH),
 
 	/*
 	 * Kingston EMMC04G-M627 advertises TRIM but it does not seems to
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index daa2f40d9ce6..7b12eebc5586 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -295,7 +295,9 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_HPI	(1<<13)		/* Disable broken HPI support */
 #define MMC_QUIRK_BROKEN_SD_DISCARD	(1<<14)	/* Disable broken SD discard support */
 #define MMC_QUIRK_BROKEN_SD_CACHE	(1<<15)	/* Disable broken SD cache support */
+#define MMC_QUIRK_BROKEN_CACHE_FLUSH	(1<<16)	/* Don't flush cache until the write has occurred */
 
+	bool			written_flag;	/* Indicates eMMC has been written since power on */
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
 
 	unsigned int		erase_size;	/* erase size in sectors */
-- 
2.34.1

