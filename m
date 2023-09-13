Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D44879F182
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjIMS56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjIMS55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:57:57 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592D71986;
        Wed, 13 Sep 2023 11:57:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694631464; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DPHtpY+9yaNaBjXM0S7iQ3FTvq/e7xWJ/umX9xMrsV9pskG7u/BESc5iv8ZXk1QAl/
    vfspTV5ZDEpzfLxaKVN4iaehMPfhpG4SJlBFlI4VJKHFkLJbeH+j6/WXWzzJwRKCl9bX
    ai4/UzNB3nQ+ySe4N7RJT7H3V7I70tOa6DYajye38v5vcp7/qhI6OlWOeF2OWbXw36my
    XP1JDG20FnqrvWfpB6FyKyGAn4y7xySWkeZnHDm2uYRCjhEEMylCdxaS7uoat71a1DHL
    QGY+2lFem6DxXhgbKBCp+ETBz1C+zGtR/LPusfPTnptbyTqaU/GIdSvEazot1gzjjkIU
    1C9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694631464;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=TSzuxS/aN3Nbyo4GrV9fy/VyKaTZefIltuvGTj3jiIM=;
    b=WlXZtHrPCSmeY6uHyQIdm/GIKqRcGtf9eE4l2J3Vhsdy67kui0vf5K+s3YQpc1mTza
    yzyPD5iS3Fk3LdzCVA9CwgW1uCDg5OMMAEMajHnV806tMjNAkR5UQ9RkaWhcPhdD2v8j
    YbHta/nkRyHpSx1HwIo9u5NjiKJheNA569UyivA31Hauncj65dcqplvMJfRwtEFyjjeZ
    d1wWxz6NW64dlkmuZgHEgt2Bf1sllAweoHC2s6Lk7ZdhPaijs1ttZbOJ02DHOp5FbVNe
    JlVWs+KkAfcA+pZ5wsuRgdIGYurdJ6sqNWn6cXQQoESOtpgpi+KsfgHgdppKuoMW0IU+
    BTKQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694631464;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=TSzuxS/aN3Nbyo4GrV9fy/VyKaTZefIltuvGTj3jiIM=;
    b=Qb7QotStzGmc+mw/bCLwojLewjyAVhNYPUg5kBLUNIn+HeFKvk/J0iJhTV9efWgK49
    EFQCoRXT56KB5hH8/OFrbaDxYkf+G+eyQWjIVF/0GCaQiLzO38AEq6UP8E8REcDC4I64
    /kw2ZBklqe4yluP3/f6S3aT55NFH2QSx8ZsiHMIGY+YgvCza3NdX7cv6X9ArQyR1Xn6z
    7DoWygS9/ABQLO+XHJmt9fD0fw9YHCCAwMCgzaZbYe/bSCtD94A8MtUKieyvuclvxLdQ
    ecjm4KAVo2BlGHU7xLK/p9RGgJk6ql30rAxB9cQg7vbclhxnO4/CbCxJf2L6MCCmf2oh
    1njA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694631464;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=TSzuxS/aN3Nbyo4GrV9fy/VyKaTZefIltuvGTj3jiIM=;
    b=jCzO1nbUmP7jGMNmoUu8ye9hz50Zb8hYkocZy3Xcu12N0X2p5xWdqGdQ8BafQy1R9g
    xgnGj+mAmh/+qIvO/sAg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1BzWso7brrTiwuvWuOfNWM/Vrq6e2vj3HGht"
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 49.8.2 AUTH)
    with ESMTPSA id V04024z8DIviA2Z
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 13 Sep 2023 20:57:44 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        beanhuo@micron.com, jakub.kwapisz@toradex.com,
        rafael.beims@toradex.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v1] mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for Micron eMMC Q2J54A
Date:   Wed, 13 Sep 2023 20:57:35 +0200
Message-Id: <20230913185735.459661-1-beanhuo@iokpp.de>
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
Cc: stable@vger.kernel.org
---
 drivers/mmc/core/core.c   | 6 ++++++
 drivers/mmc/core/mmc.c    | 5 +++++
 drivers/mmc/core/quirks.h | 7 ++++---
 include/linux/mmc/card.h  | 2 ++
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 3d3e0ca52614..5f858eb5f62c 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -259,6 +259,12 @@ static void __mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 		host->cqe_ops->cqe_off(host);
 
 	host->ops->request(host, mrq);
+
+	if (host->card->quirks & MMC_QUIRK_BROKEN_CACHE_FLUSH && !host->card->written_flag) {
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

