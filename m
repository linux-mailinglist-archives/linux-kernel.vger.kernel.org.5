Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B987A8C63
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjITTM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjITTMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:12:15 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52A412E;
        Wed, 20 Sep 2023 12:11:55 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-502b1bbe5c3so344446e87.1;
        Wed, 20 Sep 2023 12:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695237113; x=1695841913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcL6jVEgRGh/qyB/fYgM+LhUsSDKaUSeMRlsor46jHo=;
        b=A0ILyv7kbWUloEEQ81tMPRc4Vs/7ANXKz5LUuHQZl5mh5RiLCRq+/kf2ihzuV0yNKW
         FyeH37C5GwWK70JRURwS4+z7XfwCpKSQazhUO7KoBqqZuqxchiw5p0u+CoQ9Qqyk6ZZ7
         mmioI7LIKooeiyq7qvZvOXZklTV6N6LYwUaYnHki8sbv+z5GbUbbBpJrAk8Dc4LSsp9w
         i535QBkveNUOEpGkJQcn5A+agGFcvYDDRYmF5N45GnbrQsMnIKd35JrLbh3Z44HJz8MZ
         VY9NYQDS5OkUeNwikxvxcpJNDcVwHXRU4864bICyrunzLaBxWboVMh/sg77FsMOYfjDU
         scnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237113; x=1695841913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcL6jVEgRGh/qyB/fYgM+LhUsSDKaUSeMRlsor46jHo=;
        b=FqHvyFJ363huPbp0szao0W4SLDOfVSMlgcNRyXnXbQYbAfW5AFzMfVSow0eHXV0EAA
         OUVo6CKEU1QCK9UUQyMYdNdoDyRCC5AQFKfhUnWPYSZeDTrmognTu39e021piOEPsnub
         sWokMbeN61ebsdAi0GKmhGHA5o4FAQRlRyWyrvkPEf7cUtOznrrHCafeNfj4n+neXVJb
         vazvMmAGgpOlyXXZxHUswMJLzznJ1M+bgKf1tcnGCPOTY5RL/kA3EpCb74edxpT8IhN0
         4LI/QQ/L2cZh5MVTme6N8BGpK7rlQhLaMJlr06fMq14EFcI7TwLf5sKlmb0d3JEJCduk
         53Lg==
X-Gm-Message-State: AOJu0YytSdv+a2WjyEg70BHDZ1tU4KbDVO8cnI14M8orEw/T0cr/o6K7
        SUIg/z3PUbvWTZIZJQ6Zr0Q=
X-Google-Smtp-Source: AGHT+IHkTSYPsgKsNJY3ThE2JEfP39gTJq7Sqe3B+h1DLraWjnV2B9+b5fyyV5SzFtu+I00UXiAL6w==
X-Received: by 2002:a05:6512:3254:b0:4fd:8976:5fc9 with SMTP id c20-20020a056512325400b004fd89765fc9mr3089136lfr.23.1695237113037;
        Wed, 20 Sep 2023 12:11:53 -0700 (PDT)
Received: from localhost ([85.26.234.178])
        by smtp.gmail.com with ESMTPSA id k8-20020ac24568000000b00502ae6b8ebcsm568414lfm.304.2023.09.20.12.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:11:52 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/20] EDAC/synopsys: Drop redundant info from the error messages
Date:   Wed, 20 Sep 2023 22:10:36 +0300
Message-ID: <20230920191059.28395-13-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920191059.28395-1-fancer.lancer@gmail.com>
References: <20230920191059.28395-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the custom error messages are needlessly long so the logged text
gets to be printed in several lines in console. There is some
duplicated/redundant information which can be freely removed from it: drop
the message prefix "DDR ECC error type:%s" since the resultant text
printed to the log by the edac_mc_printk() method will contain the error
type and the memory controller id referring to the device detected the
error anyway; with no harm to readability shorten out the phrase "Bit
Position" to being just "Bit".

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index f1ec44cdd87f..62f498b6dfed 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -479,13 +479,13 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 		pinf = &p->ceinfo;
 		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type:%s Row %d Col %d Bank %d Bank Group %d Bit Position: %d Data: 0x%08x",
-				 "CE", pinf->row, pinf->col, pinf->bank,
-				 pinf->bankgrp, pinf->bitpos, pinf->data);
+				 "Row %d Col %d Bank %d Bank Group %d Bit %d Data 0x%08x",
+				 pinf->row, pinf->col, pinf->bank, pinf->bankgrp,
+				 pinf->bitpos, pinf->data);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type:%s Row %d Bank %d Col %d Bit Position: %d Data: 0x%08x",
-				 "CE", pinf->row, pinf->bank, pinf->col,
+				 "Row %d Bank %d Col %d Bit: %d Data: 0x%08x",
+				 pinf->row, pinf->bank, pinf->col,
 				 pinf->bitpos, pinf->data);
 		}
 
@@ -498,13 +498,12 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 		pinf = &p->ueinfo;
 		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type :%s Row %d Col %d Bank %d Bank Group %d",
-				 "UE", pinf->row, pinf->col, pinf->bank,
-				 pinf->bankgrp);
+				 "Row %d Col %d Bank %d Bank Group %d",
+				 pinf->row, pinf->col, pinf->bank, pinf->bankgrp);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-				 "UE", pinf->row, pinf->bank, pinf->col);
+				 "Row %d Bank %d Col %d",
+				 pinf->row, pinf->bank, pinf->col);
 		}
 
 		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
-- 
2.41.0

