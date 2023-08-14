Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FB677C13A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjHNUDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjHNUDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:03:33 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D666610F0;
        Mon, 14 Aug 2023 13:03:28 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31965c94001so2399984f8f.3;
        Mon, 14 Aug 2023 13:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692043407; x=1692648207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5fiXIeSxGU6C12/rcvOiLEQl7A8RO3MC5S0NrAZgA48=;
        b=R1zZbbSBgKNzu8Ux7wLr6E7apfwzcRfyA2+cBDttLJOkCC/s9/IAzJvwJ4pAMFxB4G
         8EEQo+h0B5MuO3JKzc1dj3fdx/uRf3PUFyEYOd81VTkIE2D6GK5itNQnjGzGSZUtuPwN
         UnEsi3N7H/YbxHGFm1AB+a3vpuaSFqIUpFypDDc5miqMth+ku5FdETHayi4Juz3/kj4Y
         3qx5quWLJRvMO/S50jFyMSMDOnikqA7jOCZCKb0wtS3/zSf8/D427vEQMkBKqKCkfPbz
         32yoKjo/oosQ4N1aVk7XcFdkufhJ0jYE4ZNAzZpCwkCb18Oudfgli4nE4KJCrWc+3wd7
         6h0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692043407; x=1692648207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5fiXIeSxGU6C12/rcvOiLEQl7A8RO3MC5S0NrAZgA48=;
        b=OKpFa9j/0SU10WRGriA9wzc30qLaxTg1WosThFfOo8eASIrUxis+oziFajcRcAPqHV
         YJYEc0EtJwBCX0SU5OmsvWIUJyNIifLmksxKPU5syVTuirrfgRrDKXOXVOLaT/rOsmbZ
         y9ckVM/fF7ZMNMgkzfBew/sLESIN4bFGOqB99gHpvXe8LAJ5JCDHRAd7EcSCjgvVfEJN
         tbSy97W9MRvm6J6uq59VZHGhVLMEgqdOpWfLsa7N4hT3BvvGTwwo7d/His+BP8DZR9vl
         lfPMWQtVReVA1QIkqWyQ/jm9608tYLpmOi/5ib4gOm4BXRfzomoWw/aW9LkZR0LvYsPD
         rAnw==
X-Gm-Message-State: AOJu0YynvofeRA7X7mSYaL62H4xG5441iPon5C1KtHI3xVlf5TG0DKiu
        jjfy2v+KZC2U6CSYB3cSl48=
X-Google-Smtp-Source: AGHT+IEEzqFJCrvsKy+RvX2zA7EyrgcHCWnPkZR0870P2/bZGQTchnccaPU3JR3ahoetHACFF4e1ig==
X-Received: by 2002:adf:f4c6:0:b0:317:5399:bb5b with SMTP id h6-20020adff4c6000000b003175399bb5bmr7436110wrp.25.1692043406977;
        Mon, 14 Aug 2023 13:03:26 -0700 (PDT)
Received: from mmaatuq-HP-Laptop-15-dy2xxx.. ([2001:8f8:1163:806e:5eb8:ff79:bda:b103])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c378d00b003fe2de3f94fsm15225777wmr.12.2023.08.14.13.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 13:03:26 -0700 (PDT)
From:   Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
To:     jirislaby@kernel.org, mickflemm@gmail.com, mcgrof@kernel.org,
        kvalo@kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
Subject: [PATCH v1] ath5k: fix WARNING opportunity for swap.
Date:   Tue, 15 Aug 2023 00:02:34 +0400
Message-Id: <20230814200234.637583-1-mahmoudmatook.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

coccinielle reported the following:
./drivers/net/wireless/ath/ath5k/phy.c:1573:25-26: WARNING opportunity for swap()

Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
---
changes in v1:
- replace the entire double loop with sort()
  as suggested by Jiri Slaby <jirislaby@kernel.org>
---
 drivers/net/wireless/ath/ath5k/phy.c | 29 +++++++++++++---------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath5k/phy.c b/drivers/net/wireless/ath/ath5k/phy.c
index 5797ef9c73d7..7ee4e1616f45 100644
--- a/drivers/net/wireless/ath/ath5k/phy.c
+++ b/drivers/net/wireless/ath/ath5k/phy.c
@@ -26,6 +26,7 @@
 
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/sort.h>
 #include <asm/unaligned.h>
 
 #include "ath5k.h"
@@ -1554,6 +1555,11 @@ static void ath5k_hw_update_nfcal_hist(struct ath5k_hw *ah, s16 noise_floor)
 	hist->nfval[hist->index] = noise_floor;
 }
 
+static int cmps16(const void *a, const void *b)
+{
+	return *(s16 *)a - *(s16 *)b;
+}
+
 /**
  * ath5k_hw_get_median_noise_floor() - Get median NF from history buffer
  * @ah: The &struct ath5k_hw
@@ -1561,25 +1567,16 @@ static void ath5k_hw_update_nfcal_hist(struct ath5k_hw *ah, s16 noise_floor)
 static s16
 ath5k_hw_get_median_noise_floor(struct ath5k_hw *ah)
 {
-	s16 sort[ATH5K_NF_CAL_HIST_MAX];
-	s16 tmp;
-	int i, j;
-
-	memcpy(sort, ah->ah_nfcal_hist.nfval, sizeof(sort));
-	for (i = 0; i < ATH5K_NF_CAL_HIST_MAX - 1; i++) {
-		for (j = 1; j < ATH5K_NF_CAL_HIST_MAX - i; j++) {
-			if (sort[j] > sort[j - 1]) {
-				tmp = sort[j];
-				sort[j] = sort[j - 1];
-				sort[j - 1] = tmp;
-			}
-		}
-	}
+	s16 sorted_nfval[ATH5K_NF_CAL_HIST_MAX];
+	int i;
+
+	memcpy(sorted_nfval, ah->ah_nfcal_hist.nfval, sizeof(sorted_nfval));
+	sort(sorted_nfval, ATH5K_NF_CAL_HIST_MAX, sizeof(s16), cmps16, NULL);
 	for (i = 0; i < ATH5K_NF_CAL_HIST_MAX; i++) {
 		ATH5K_DBG(ah, ATH5K_DEBUG_CALIBRATE,
-			"cal %d:%d\n", i, sort[i]);
+			"cal %d:%d\n", i, sorted_nfval[i]);
 	}
-	return sort[(ATH5K_NF_CAL_HIST_MAX - 1) / 2];
+	return sorted_nfval[(ATH5K_NF_CAL_HIST_MAX - 1) / 2];
 }
 
 /**
-- 
2.34.1

