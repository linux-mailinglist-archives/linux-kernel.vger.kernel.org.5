Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2315B7A0EF0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 22:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjINU2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 16:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjINU2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 16:28:05 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CDA26B2;
        Thu, 14 Sep 2023 13:28:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694723278; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Dfz75ui+4qYiWbAdx/b2gB508EnOEzfr+hACrmm+M9VREKMQfUoFcN7wfp5Az8YHIJ
    tCeiWoMi7PIwX7hR119PfMA5wRhom5Y45tgljKqjH/D528+k0oabjSReo3BDewTikRY9
    QLHZgR5x1GLOQWGukO0kYoLDkW2wYZyGNadE6BJw+re99dX6CkaJvrD5TtsscDx8mcz4
    pDgqkcoR1vO/V/0faCaxWsKS8pyaiq/tgqrpL1BMO4fKySqE+dBH9jRVY+CdWWTe4m19
    qOMZ+4B4BQDsB7ezy5UHwgdy+f2QfaDLcXgayDvcYM/rLohL0DxRUmtO35PTbEX+CPVr
    J3rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694723278;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=m4iE6KJnkzc7DxuNvxScdnjLzszoDLro5lcUVYr2ojc=;
    b=L6EnQonLTsNEcoS7C3U6vLTuSefAyMMZXATv4Y/OtQjmZYbHE1cMyhT6xCrLuIv0Ta
    5rNHfjg8uvyigkqytwuCW70hApNFo8tkASAKq3eolZNtCCO+M0AClZ10IxuqH8UblXwS
    I6Y9jlVycITAIPOccruW6iy/h7uBvTCMXvjhljQF+2Lrbfv13+ukBRUly7AgqL06rfwV
    5iCDbhgZpiiroQLoqK9lcW6ZQ14Z8sMe9CTzUFQz8sAi3q8jtFVkNNK4m31iv/BMwvbC
    WuzU6mIEwayZCF0G6SiV7QdtwbmGHplephZE4dZucxHyfRGGR8wCeVBvUsp5Ft+EZXc5
    vAxQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694723278;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=m4iE6KJnkzc7DxuNvxScdnjLzszoDLro5lcUVYr2ojc=;
    b=m9+VWFRUhpH3FY8mIhtKKeqhRdMkMbh8U2d2Nq2oUSjQf7FS1E+ud+BejLtLOKIhdI
    yhIdkfHkdWtIL86S/arUdx7v6K73aiy/dRcdJWC+F1LO6/j6dc9Ph19rI/E4E9jWSINW
    mwasWOr1vC+v3ZtS688VGfS3XBX2oliZl+gKJVOPj4PkloCEq7G42KCrchPbkNV4U4UP
    34pNaJ1ewKWiPlXZc0O6DmYhr6RbRECWixT5Z4Asa2qbwpf2lK8xsUSUFezged9bCJZ9
    pAZvb0DbSRV/8LJBnCVGL+smT9g++lWD0K+bgpdJ75xEDSW2cYjYe5wvlq+ln0jgJjpC
    Ptgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694723278;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=m4iE6KJnkzc7DxuNvxScdnjLzszoDLro5lcUVYr2ojc=;
    b=WE4KU2/QrraNeA4qJwf4tPUppronPwuw3wYGF/ORaShLsr+bC9w9DC0D8AUVHbuQTf
    AT6r6gVb7Y4gtSwp2MCg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1BzWso7brrTnk+qJtuXDXLVLiZPxnvk6DWJlKA=="
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 49.8.2 AUTH)
    with ESMTPSA id V04024z8EKRvDZR
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 14 Sep 2023 22:27:57 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        beanhuo@micron.com, jakub.kwapisz@toradex.com,
        rafael.beims@toradex.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v2] mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for Micron eMMC Q2J54A
Date:   Thu, 14 Sep 2023 22:27:49 +0200
Message-Id: <20230914202749.470100-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Micron MTFC4GACAJCN eMMC supports cache but requires that flush cache
operation be allowed only after a write has occurred. Otherwise, the
cache flush command or subsequent commands will time out.

Signed-off-by: Bean Huo <beanhuo@micron.com>
Co-developed-by: Rafael Beims <rafael.beims@toradex.com>
Tested-by: Rafael Beims <rafael.beims@toradex.com>
Cc: stable@vger.kernel.org
---
Changelog:

v1--v2:
    1. Add Rafael's test-tag, and Co-developed-by.
    2. Check host->card whether NULL or not in __mmc_start_request() before asserting host->card->->quirks

---
 drivers/mmc/core/core.c   | 7 +++++++
 drivers/mmc/core/mmc.c    | 5 +++++
 drivers/mmc/core/quirks.h | 7 ++++---
 include/linux/mmc/card.h  | 2 ++
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 3d3e0ca52614..86a669b35b91 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -259,6 +259,13 @@ static void __mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 		host->cqe_ops->cqe_off(host);
 
 	host->ops->request(host, mrq);
+
+	if (host->card && host->card->quirks & MMC_QUIRK_BROKEN_CACHE_FLUSH &&
+	    !host->card->written_flag) {
+		if (mrq->cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK ||
+		    mrq->cmd->opcode == MMC_WRITE_BLOCK)
+			host->card->written_flag = true;
+	}
 }
 
 static void mmc_mrq_pr_debug(struct mmc_host *host, struct mmc_request *mrq,
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

