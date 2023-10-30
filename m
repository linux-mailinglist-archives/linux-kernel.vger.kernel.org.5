Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFA97DC29C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 23:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjJ3Wsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 18:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjJ3Wsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 18:48:37 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12271E1;
        Mon, 30 Oct 2023 15:48:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698706105; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kZBYoZChuCK8CR9lbKS4snbL9NzakTXIPj9YUQNH5yaZITrymmug6QfsUSZEBMYIj0
    5cPfquV2vr1r5tEHqvu3tkrnG8gy8FGtGr/pGbI9Xg5X9WMA8zWm+veVtsh56bR4DjSb
    gWAvU5lXiVSCD2XU+wAXf2jNXSYDTH5hV7N0I20As4C0ws2mFxDvE29LY4wrvUjGvmx1
    4CcXew4tvZFfZ2asuYIgGBewAeSVaHs96BsIFWcdrY3PezLV2OELQhv/gtB1Iq04sxRq
    y4SppF1j2gj4winiYsyIf5VkzeQqa5KRluwAwhsjOxjw/0Y/CHgdtGFEakQjfHKuJOFo
    E6Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698706105;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=NLfEces4BfsEWbaKYovgafBvpx5rnI42aFAQwYNElhE=;
    b=eGG1Q0AfdtJq3wIxT4BXFgMRZNkWZUlRAXjLAVOxE/wrdXs1NwwJqK0ooqCqMemwey
    IormpZ+FDUa3rzacchSp9cNgcX2U4sDRkagHueDcIRcy205m2sVShQXm1sCd1GyTHmBV
    q+gEqzzUFMl5KV9sp/0vDeoc+we9qdcFyLtkjWe8RhBRDHf8LVhgnPyAYUsLy8vGO5iY
    3+wB9M7RhZ/zXwHNNUpKnpA6Xw7ysmTZMZvJu2L907b1F7LAK4/MFMRHhWSDp+IW+Yeg
    xwnnRufhnkLb6ktJi1sI245sD9ATy9egz1xXg8Xna5GqX/j3MWEmq9siTtidgkQwiKSC
    RMCw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698706105;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=NLfEces4BfsEWbaKYovgafBvpx5rnI42aFAQwYNElhE=;
    b=kjrTCfJhmXXKVLSuHyRGqUXmqb+5pAnicDdC/pstc5pb4i2Gvp71/4ZShKlOxy+Uh4
    PMaaQ9dyWRhR6jOlYHT0vm+QxKi2CQntks/42rvxpGDEpf+IgxT/Xe18BMBEqs4XuuI9
    fn4tJ6YfK7jWHo8BLOAMQDCoklMZ7fHSQoXYz4LyXvF2tI3JfSKZlXaAoSFN4P1EfuoC
    K6YQMJuzilIes51z/CcTDfbjIjbv6uHxGyf9oYsfekHMEo1KlEJJih5BYTkIUhvvPaRE
    IdoIFgoNXJTo1gKoNCBOQQBBFg58JX9lbzcTiaqmEbMctPt8MSkUVJUEukQV4OAOOoFl
    OjGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698706105;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=NLfEces4BfsEWbaKYovgafBvpx5rnI42aFAQwYNElhE=;
    b=yR5hIyiBI8Y+O0JuNH52hbVnEBESOimD9DeB/evAmclgtkqE8jeQQFjN4/HLa6S3KM
    l0N1h9AoVpZt5gOU4sAw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1XjJKt+IXM0qv4S/D"
Received: from Munilab01-lab..
    by smtp.strato.de (RZmta 49.9.1 AUTH)
    with ESMTPSA id zd0181z9UMmPGWd
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 30 Oct 2023 23:48:25 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     ulf.hansson@linaro.org, cLoehle@hyperstone.com,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>,
        Rafael Beims <rafael.beims@toradex.com>, stable@vger.kernel.org
Subject: [v5] mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for Micron eMMC Q2J54A
Date:   Mon, 30 Oct 2023 23:48:09 +0100
Message-Id: <20231030224809.59245-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Rafael Beims <rafael.beims@toradex.com>
Cc: stable@vger.kernel.org
---

Changelog:
v4--v5:
    1. In the case of a successful flush, set writing_flag in _mmc_flush_cache()
v3--v4:
    1. Add helper function for this quirk in drivers/mmc/core/card.h.
    2. Set card->written_flag only for REQ_OP_WRITE.
v2--v3:
    1. Set card->written_flag in mmc_blk_mq_issue_rq().
v1--v2:
    1. Add Rafael's test-tag, and Co-developed-by.
    2. Check host->card whether NULL or not in __mmc_start_request() before asserting host->card->->quirks
---
 drivers/mmc/core/block.c  | 4 +++-
 drivers/mmc/core/card.h   | 4 ++++
 drivers/mmc/core/mmc.c    | 8 ++++++--
 drivers/mmc/core/quirks.h | 7 ++++---
 include/linux/mmc/card.h  | 2 ++
 5 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 3a8f27c3e310..152dfe593c43 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2381,8 +2381,10 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
 			}
 			ret = mmc_blk_cqe_issue_flush(mq, req);
 			break;
-		case REQ_OP_READ:
 		case REQ_OP_WRITE:
+			card->written_flag = true;
+			fallthrough;
+		case REQ_OP_READ:
 			if (host->cqe_enabled)
 				ret = mmc_blk_cqe_issue_rw_rq(mq, req);
 			else
diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index 4edf9057fa79..b7754a1b8d97 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -280,4 +280,8 @@ static inline int mmc_card_broken_sd_cache(const struct mmc_card *c)
 	return c->quirks & MMC_QUIRK_BROKEN_SD_CACHE;
 }
 
+static inline int mmc_card_broken_cache_flush(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_BROKEN_CACHE_FLUSH;
+}
 #endif
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 8180983bd402..11053f920ac4 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2086,13 +2086,17 @@ static int _mmc_flush_cache(struct mmc_host *host)
 {
 	int err = 0;
 
+	if (mmc_card_broken_cache_flush(host->card) && !host->card->written_flag)
+		return err;
+
 	if (_mmc_cache_enabled(host)) {
 		err = mmc_switch(host->card, EXT_CSD_CMD_SET_NORMAL,
 				 EXT_CSD_FLUSH_CACHE, 1,
 				 CACHE_FLUSH_TIMEOUT_MS);
 		if (err)
-			pr_err("%s: cache flush error %d\n",
-			       mmc_hostname(host), err);
+			pr_err("%s: cache flush error %d\n", mmc_hostname(host), err);
+		else
+			host->card->written_flag = false;
 	}
 
 	return err;
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

