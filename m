Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37467B4978
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 21:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbjJATuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 15:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbjJATuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 15:50:00 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB3CC4;
        Sun,  1 Oct 2023 12:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696189791; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZrWkQLoc1wy90SLi9DHxeq2l++ZaAgh3FFRuBJG9TFw2xZUuD6G6O/h4fW4hR6nC7H
    qY1cvHjj8df3xnnMdaC9lfH4thqye/d6yoc9Vb1uzc5C1HgecOHAe5k2oDsK1OCP6hHK
    N9I+w/HBpGB3Nvo1H7Bz3SyLWovxujolGIX69yXIi2LzfSw8UkWK0gUCzizyDIotysV5
    l5cI+btxouv6EX+wYk7AQaSnuSQWWQ5WeMcXhtrSNC2ihQxuxOnz34nwrDtfUzYriJ/n
    UIo94J3lC1BJX+5pBpVgqDajgDU5csqgvfDdk++waVlNVNf/jeVuHcpnQmVNqCE0sBBr
    sxeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696189791;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=QLHEjSqRnmsPYmLACZfYaE2h/KV+lL95YcLFNCIfGt0=;
    b=E3/IaUB0raN8HV8z1eWZReDcjC2qrLinGsIy8nes4teTtJn2LKRytC/y5Mzv0br42T
    URiJqnSG/AvUWIgNlOI3z7PHJWO0CJnb95VG++t4Nkika76VfDKewYmcZbUcWChRjv9d
    N+jfFHuekFoF/tlEmWaFgiKrqnU/ukbK2gjbmbN85WuAXKszW/0gRe7lurem/2jOes5G
    1x0Vej+0P+dWMuXtpbgH8vGngpWRO5xBRo+Ng9gsTAxyMTvyvokgqEz95a3aCHZCiNcS
    qWWwWIL2vXIygQ6Xo8oKOzMfT2iyFX4gFS3qDWDKO6OfPG3NOJCnhwT4uUxbMtonnAzX
    11UQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696189791;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=QLHEjSqRnmsPYmLACZfYaE2h/KV+lL95YcLFNCIfGt0=;
    b=AP95hDXhdsYYBiFXhvJ+LU75UoJNjxqBQ+2FL9D4HpWqHuDHr0Ifn2dMAybwhhPD1l
    VbC7mU3fwaRB+BWO6OT1HqJ7xJWzlrneh9rDObF04HxO34KM8REGMj69/i4kD5NMDqv4
    XYt2km1FKS+EpUObSdgb95xF6bvb9pPEie/DyN42p+k1J0qqcN06qd37IaxiKisVCCx/
    YGnbPfohIdTP/9smTNflzWHmUXSNbSu2hZ9KbYynQoPnR+j+JoAFdFyLHSDb1CyNb3/P
    SokJF4oSrW+K+p4fZLCHSKS4ggNSSWx+ShhX69k5V7HsFb9HhjzxkcMe0SF+H30+8iFl
    O7PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696189791;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=QLHEjSqRnmsPYmLACZfYaE2h/KV+lL95YcLFNCIfGt0=;
    b=soeK+dKj1zCcGUwSZZ1IXnDc28H415rQPlW9etBhMxAPjhULenTtiQqc/AxPaSHOpO
    uZCWrIuXcg+HDfBPYJCA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1BzWso7brrTglLCNtuGSDRUWFfel8K81hDt+rA=="
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 49.8.2 AUTH)
    with ESMTPSA id V04024z91Jnox5D
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 1 Oct 2023 21:49:50 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        beanhuo@micron.com, jakub.kwapisz@toradex.com,
        rafael.beims@toradex.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v4] mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for Micron eMMC Q2J54A
Date:   Sun,  1 Oct 2023 21:49:43 +0200
Message-Id: <20231001194943.658299-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

v3--v4:
    1. Add helper function for this quirk in drivers/mmc/core/card.h.
    2. Set card->written_flag only for REQ_OP_WRITE.
v2--v3:
    1. Set card->written_flag in mmc_blk_mq_issue_rq().
v1--v2:
    1. Add Rafael's test-tag, and Co-developed-by.
    2. Check host->card whether NULL or not in __mmc_start_request() before asserting host->card->->quirks
---
 drivers/mmc/core/block.c  | 5 ++++-
 drivers/mmc/core/card.h   | 4 ++++
 drivers/mmc/core/mmc.c    | 5 +++++
 drivers/mmc/core/quirks.h | 7 ++++---
 include/linux/mmc/card.h  | 2 ++
 5 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 3a8f27c3e310..dfa67d9c80bb 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2381,8 +2381,11 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
 			}
 			ret = mmc_blk_cqe_issue_flush(mq, req);
 			break;
-		case REQ_OP_READ:
 		case REQ_OP_WRITE:
+			if (mmc_card_broken_cache_flush(card) && !card->written_flag)
+				card->written_flag = true;
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
index 89cd48fcec79..47896c32086e 100644
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
 
+	if (mmc_card_broken_cache_flush(host->card) && !host->card->written_flag)
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

