Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E6D77E0BF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244757AbjHPLry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244768AbjHPLr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:47:28 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F17E2121
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:47:27 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4ff8cf11b90so1784091e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692186445; x=1692791245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XdVIooP7Ho7O4vx5CwmajztmNRsl01Hr+hDUfrzHogc=;
        b=xxhn6TRzANpoGLRb2/aK/u4KUe0U1w9sDFilaQQHByky4S5QHKbsJp8JwisGl80UNi
         FcQgaKhIevk/vspB39SFEvmkcJkUvrBqeVrIFy3oovYYqgLYy7G+dhgOaRzFwFlKhkRH
         ZxDDTCO7dLbm0Ai0us0JCpFx5A3uQkWdSFL6PMsqRav2pp1jV/Id4rx/RIyN9LK9Jawb
         XRTy1n0q7JhRCZDcwyiLjIWVlbAU3lyVrBdmDWPMu6Oupfn9Up5tZxJ+D8JJy5qGMMus
         kEjaYA651WD9LhA81gCBAZzWsuDlYF4T126pvF/K1cz5EYf+Y0p+yMuri7uL3rHrFx9D
         XTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692186445; x=1692791245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XdVIooP7Ho7O4vx5CwmajztmNRsl01Hr+hDUfrzHogc=;
        b=lPUo6MFusTAFLg/GYewL5V+dSW506vjGpBHaBwCm6xxqkUqA6J4bmZUuyrLEP+dRqa
         cfCJRwolCkW568/km9b71fusSGgE66+NgRrRJQ6/dz7gbMmo4PYXPI4KWL14Z/k72mbI
         wyVmJ5Q7ga50Tk8Tprd5WVNxoy1qwrcNMdKJP7CITB9uR38XzVZh05Y0X4ykTq0cYDRc
         ebBFbk5yLGPO3n/zsdZDVr08nwpmnGsy7+tp9iZ42XO2UIeFx9FZdedLRwj4+ea2cN9N
         O7W74886MqtBKx9UG3RfGxM7XMxkDxh5apRT00DgIPB0airK38b2JgzGadcO4HShHTBR
         V+dQ==
X-Gm-Message-State: AOJu0Yx8y3OSxnyAevnXo6MYXQlJK/qNmivWsHKY2s02VxyY7Xq4xi9G
        +hWygwUjsjZTbaRBFo4I5YTnKw==
X-Google-Smtp-Source: AGHT+IHInKejBBDdX5k76fJuLZ7aKj8UaU3udDXP0w2kVMdO5TH/+uC0Y5X8xwSDsdjaT9pkk/IcoQ==
X-Received: by 2002:a05:6512:128b:b0:4f8:6625:f2ca with SMTP id u11-20020a056512128b00b004f86625f2camr1769155lfs.61.1692186445122;
        Wed, 16 Aug 2023 04:47:25 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id a15-20020a056512374f00b004fddaddeb63sm2895683lfs.137.2023.08.16.04.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 04:47:24 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        Christian Lohle <cloehle@hyperstone.com>,
        linux-kernel@vger.kernel.org,
        Christian Loehle <CLoehle@hyperstone.com>
Subject: [PATCH] mmc: core: Fix error propagation for some ioctl commands
Date:   Wed, 16 Aug 2023 13:47:12 +0200
Message-Id: <20230816114712.25093-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace has currently has no way of checking the internal R1 response
error bits for some commands. This is a problem for some commands, like
RPMB for example. Typically, we may detect that the busy completion
successfully has ended, while in fact the card did not complete the
requested operation.

To fix the problem, let's always poll with CDM13 for these commands and
during the polling aggregate the R1 response bits. Before completing the
ioctl request, let's propagate the R1 response bits too.

Cc: Avri Altman <avri.altman@wdc.com>
Co-developed-by: Christian Loehle <CLoehle@hyperstone.com>
Signed-off-by: Christian Loehle <CLoehle@hyperstone.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Christian, I took the liberty of re-working your previous patch [1]. But rather
than keeping your authorship I added you as a co-developer. Please tell me if
you prefer differently.

Kind regards
Uffe

[1]
https://lore.kernel.org/all/26d178dcfc2f4b7d9010145d0c051394@hyperstone.com/ 

---
 drivers/mmc/core/block.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index b6f4be25b31b..62a8aacc996c 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -179,6 +179,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 			       struct mmc_queue *mq);
 static void mmc_blk_hsq_req_done(struct mmc_request *mrq);
 static int mmc_spi_err_check(struct mmc_card *card);
+static int mmc_blk_busy_cb(void *cb_data, bool *busy);
 
 static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
 {
@@ -470,7 +471,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	struct mmc_data data = {};
 	struct mmc_request mrq = {};
 	struct scatterlist sg;
-	bool r1b_resp, use_r1b_resp = false;
+	bool r1b_resp;
 	unsigned int busy_timeout_ms;
 	int err;
 	unsigned int target_part;
@@ -551,8 +552,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	busy_timeout_ms = idata->ic.cmd_timeout_ms ? : MMC_BLK_TIMEOUT_MS;
 	r1b_resp = (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B;
 	if (r1b_resp)
-		use_r1b_resp = mmc_prepare_busy_cmd(card->host, &cmd,
-						    busy_timeout_ms);
+		mmc_prepare_busy_cmd(card->host, &cmd, busy_timeout_ms);
 
 	mmc_wait_for_req(card->host, &mrq);
 	memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
@@ -605,19 +605,28 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	if (idata->ic.postsleep_min_us)
 		usleep_range(idata->ic.postsleep_min_us, idata->ic.postsleep_max_us);
 
-	/* No need to poll when using HW busy detection. */
-	if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
-		return 0;
-
 	if (mmc_host_is_spi(card->host)) {
 		if (idata->ic.write_flag || r1b_resp || cmd.flags & MMC_RSP_SPI_BUSY)
 			return mmc_spi_err_check(card);
 		return err;
 	}
-	/* Ensure RPMB/R1B command has completed by polling with CMD13. */
-	if (idata->rpmb || r1b_resp)
-		err = mmc_poll_for_busy(card, busy_timeout_ms, false,
-					MMC_BUSY_IO);
+
+	/*
+	 * Ensure RPMB, writes and R1B responses are completed by polling with
+	 * CMD13. Note that, usually we don't need to poll when using HW busy
+	 * detection, but here it's needed since some commands may indicate the
+	 * error through the R1 status bits.
+	 */
+	if (idata->rpmb || idata->ic.write_flag || r1b_resp) {
+		struct mmc_blk_busy_data cb_data;
+
+		cb_data.card = card;
+		cb_data.status = 0;
+		err = __mmc_poll_for_busy(card->host, 0, busy_timeout_ms,
+					  &mmc_blk_busy_cb, &cb_data);
+
+		idata->ic.response[0] = cb_data.status;
+	}
 
 	return err;
 }
-- 
2.34.1

