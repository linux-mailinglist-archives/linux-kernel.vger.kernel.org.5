Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD0F77671F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjHISWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjHISWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:22:05 -0400
X-Greylist: delayed 177 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Aug 2023 11:22:00 PDT
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5138FE;
        Wed,  9 Aug 2023 11:22:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1691605138; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZsvkOMXUemvihkGv/CWHLKp8RWzk4T56H3L2QQKimFhaEwJfjyzu8Q7RoFvkzncAk9
    ax3MUGylnRnRUKMZcDhpzXY63gtTcqZvbctFwZJ/X69aqlmOHPfdYTfCopMnsB6mHr2y
    +B6WwIhOhz9wyTPO/Sd0EBccmimorvxXbSngQdn/aJIycYuyCT3o+k3Qq/HJu3gatJvI
    OQCFNKl01WBqwedbZIqJsU6YAywqTteMqz3FpGQ1lpz82h/t6+IGQf4jlFahypmoMOb0
    FTb/8ohwwa+1r9JIvJgByfbvKkIl1plyuIxCaGade97riNKEvFi8BdHU8fi1r9rwxsys
    v69w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1691605138;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=2jCCQnHfAiKMeG+iy/MUWyuA6lCROg7I8IT0YSSa9Ds=;
    b=dyGLV7fD/EULnv0J0jPxiBBPzlwP6yk+G0KEH7Gg4knredvzRPxqZqCOfsZskLi7Sq
    ro42iyUCr8byjGo7EOZnDYNRWG+0lniiVXymJJaevA443PVs7KasYwrt65jdkY4iUarW
    rConJ7Hlniw6nG4xLkpeiHnf3vvQcAveBvWj2NsgihcsmizGbCcYufsbHq3xYybNTz5q
    wXZGwClrUjUC0vs18ACztNufKF9vBuvuncNM7Rl0dWU+9LUT44X8fM/xc0JSxxpscVJm
    MbzwAkmUP1bCC17toG2Vg9BragleFMKa6Bl+Xl/tFNwJZuE65YVkPcPox+sC05k11A2E
    Xoxg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1691605138;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=2jCCQnHfAiKMeG+iy/MUWyuA6lCROg7I8IT0YSSa9Ds=;
    b=JwpsNXq9wJfLwj9GBhXGITbiukRIwvFvXnsVW7p5u8qbbspHWJDcMTMOo/U+5CBpZg
    lG9NUKGsVNkk0l4u0FRtnFhYLsvOnnWmG5SfWj0oKK+FkERKx7ebxhsCy9HY04l5HtbR
    vaUars/hum6BfOAZ6mQ3XjYu7hjhsTGbA1ZrTXiTwMQBqJhMvP/iZOr6KqDVhMRjBeHd
    Behao3indx9A5K6Mwzv9S8fdmPnNqlafTm5jOp4sXkfzXdy92C7/TWw+k72a1Cx12G3L
    +iiLczyru2aiuHGBxdVJyCRNCPoStB2y5f/39ORUIWOQAIbnKno16kICcZDy11u54WWf
    Es9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1691605138;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=2jCCQnHfAiKMeG+iy/MUWyuA6lCROg7I8IT0YSSa9Ds=;
    b=2m8JnPFpftdhWKewW5st61ddCms/2ADXxU7Ml7P17G3WIsFotYeD9C+urp0cgpEKB+
    c6n5ls3UBGSu/+niruCQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1B7WtoHeqrQNqrexjtNBJQI8izfAF0DFZj1zmA=="
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 49.6.6 AUTH)
    with ESMTPSA id z12fdaz79IIwh6z
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 9 Aug 2023 20:18:58 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, jonghwi.rha@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] scsi: ufs: core: Add advanced RPMB support where UFSHCI 4.0 does not support EHS length in UTRD
Date:   Wed,  9 Aug 2023 20:18:46 +0200
Message-Id: <20230809181847.102123-2-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809181847.102123-1-beanhuo@iokpp.de>
References: <20230809181847.102123-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

According to UFSHCI 4.0 specification:

5.2 Host Controller Capabilities Registers
5.2.1 Offset 00h: CAP – Controller Capabilities:

" EHS Length in UTRD Supported (EHSLUTRDS): Indicates whether the host
controller supports EHS Length field in UTRD.
0 – Host controller takes EHS length from CMD UPIU, and SW driver use EHS Length field in CMD UPIU.
1 – HW controller takes EHS length from UTRD, and SW driver use EHS Length field in UTRD.
NOTE Recommend Host controllers move to taking EHS length from UTRD, and in UFS-5, it will be
mandatory."

So, when UFSHCI 4.0 doesn't support EHS Length field in UTRD, we could use EHS Length field in CMD
UPIU. This patch aims to remove the limitation that advanced RPMB only works when EHS length is
supported in UTRD.

Fixes: 6ff265fc5ef6 ("scsi: ufs: core: bsg: Add advanced RPMB support in ufs_bsg")
Signed-off-by: jonghwi.rha <jonghwi.rha@samsung.com>
Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/ufs/core/ufs_bsg.c |  3 +--
 drivers/ufs/core/ufshcd.c  | 10 +++++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index 34e423924e06..374e5aae4e7e 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -76,8 +76,7 @@ static int ufs_bsg_exec_advanced_rpmb_req(struct ufs_hba *hba, struct bsg_job *j
 	int ret;
 	int data_len;
 
-	if (hba->ufs_version < ufshci_version(4, 0) || !hba->dev_info.b_advanced_rpmb_en ||
-	    !(hba->capabilities & MASK_EHSLUTRD_SUPPORTED))
+	if (hba->ufs_version < ufshci_version(4, 0) || !hba->dev_info.b_advanced_rpmb_en)
 		return -EINVAL;
 
 	if (rpmb_request->ehs_req.length != 2 || rpmb_request->ehs_req.ehs_type != 1)
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 8b5ee1a7d454..7f965ac18ee8 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7240,7 +7240,15 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *r
 	/* Advanced RPMB starts from UFS 4.0, so its command type is UTP_CMD_TYPE_UFS_STORAGE */
 	lrbp->command_type = UTP_CMD_TYPE_UFS_STORAGE;
 
-	ufshcd_prepare_req_desc_hdr(lrbp, &upiu_flags, dir, 2);
+	/*
+	 * According to UFSHCI 4.0 specification page 24, if EHSLUTRDS is 0, host controller takes
+	 * EHS length from CMD UPIU, and SW driver use EHS Length field in CMD UPIU. if it is 1,
+	 * HW controller takes EHS length from UTRD.
+	 */
+	if (hba->capabilities & MASK_EHSLUTRD_SUPPORTED)
+		ufshcd_prepare_req_desc_hdr(lrbp, &upiu_flags, dir, 2);
+	else
+		ufshcd_prepare_req_desc_hdr(lrbp, &upiu_flags, dir, 0);
 
 	/* update the task tag and LUN in the request upiu */
 	req_upiu->header.flags = upiu_flags;
-- 
2.34.1

