Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E178279E6BE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbjIML3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240125AbjIML3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:29:40 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641AC173E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:29:36 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-500a8b2b73eso10818628e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694604574; x=1695209374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d+YB6ER9rLtVLBq9rEid6BXzvaD59o5es/ubi9S/WB8=;
        b=gEU14NnK4yh6K5wSQszAx49YdLDDTjEnMaWslGtu/b2sDwMIN0/AwLTBAttrwkgkHR
         oa6KZ2VGTSSlMgojPTa/E+1xmK2q2kfRWAENM9ktJKRP9iJ9CuIMpZZ2CwcP2a9dX7bU
         hkfYWhKbVVW/eWWiZqYWQTuSHrHrzKQXppEBY3aUTRZIEetMkOfxxPAukroH5al9t/aG
         hHpdaK5ajLQtXKdBH4dIRzBRfDuns+r/7JTOKjbT0wFUyIlwjF7bJOBSSPBsJ3o38GZ3
         dObbR1NEMNvyOTeVIWmTbhaCyT20HlIQbMz7Pw5PGcpogX8aojg+Xi97myGOzS7HQIdz
         IkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694604574; x=1695209374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+YB6ER9rLtVLBq9rEid6BXzvaD59o5es/ubi9S/WB8=;
        b=NuixHQqsebR1XZDc8SE+XCPG1YrNjdV7a1O2a2emXt5CkiTTOebF9BCBSChMnkfV9n
         WZpZT4ZHizNbGQnXiJ0+cWN7sVvQKK8998HsdsjWyPuRaGcfJOwB/aFjG0mtWW8Ddxn0
         VMXVzZ6YPEVpaCVdOGNcVdgMB1F4v35+f9uGvM8EutbYAApXdawCrCOnStjtZh+hNXyR
         dnlQYoa+AQ5imezCo05vE4pIqp9qB+kktawUykArrmcXkaAA5TyxcaWcVVipH2tpEzGR
         K+MYRMfFinbWL9ZxbsH7r/2KVGLiw7ZVt/Ro41JIqJJ85l0NsFgcoGgboPDaLTioHV/y
         5Q0g==
X-Gm-Message-State: AOJu0YzDW8E44X4cVUFjEojgtjA9tp+kmY2VCsiT8SdCTRJdEmYnW93S
        Rp6HCdlKqSmfHeZs0PWcsn3JqA==
X-Google-Smtp-Source: AGHT+IFb0UguTRshbuqSnEdYPChV16O1AzS6uwBm6aDwafv1McNCuDlv8il3PdJ5WRFpjywxJdoAkg==
X-Received: by 2002:a19:655d:0:b0:500:98ff:4162 with SMTP id c29-20020a19655d000000b0050098ff4162mr1821401lfj.40.1694604574576;
        Wed, 13 Sep 2023 04:29:34 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id o3-20020ac24343000000b004fdb85646f1sm2113690lfl.201.2023.09.13.04.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 04:29:33 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        Christian Loehle <christian.loehle@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mmc: core: Fix error propagation for some ioctl commands
Date:   Wed, 13 Sep 2023 13:29:21 +0200
Message-Id: <20230913112921.553019-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace has currently no way of checking the internal R1 response error
bits for some commands. This is a problem for some commands, like RPMB for
example. Typically, we may detect that the busy completion has successfully
ended, while in fact the card did not complete the requested operation.

To fix the problem, let's always poll with CMD13 for these commands and
during the polling, let's also aggregate the R1 response bits. Before
completing the ioctl request, let's propagate the R1 response bits too.

Reviewed-by: Avri Altman <avri.altman@wdc.com>
Co-developed-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Updated Christian's email.
	- Updated the commit message.
	- Initialize mmc_blk_busy_data struct directly.

---
 drivers/mmc/core/block.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index b5b414a71e0b..3a8f27c3e310 100644
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
+		struct mmc_blk_busy_data cb_data = {
+			.card = card,
+		};
+
+		err = __mmc_poll_for_busy(card->host, 0, busy_timeout_ms,
+					  &mmc_blk_busy_cb, &cb_data);
+
+		idata->ic.response[0] = cb_data.status;
+	}
 
 	return err;
 }
-- 
2.34.1

