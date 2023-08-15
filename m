Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5747777C6A8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 06:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbjHOENs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 00:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbjHOELZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 00:11:25 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A0A2688;
        Mon, 14 Aug 2023 21:08:29 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe8242fc4dso41966035e9.1;
        Mon, 14 Aug 2023 21:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692072507; x=1692677307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=anT8jKhSoDVocUIDbiLfqy7dD2AOUweYjEowk202rTE=;
        b=pXh3wdDuavmAXAWIopZ2tsVh81/1AfndoZfZCz6/vScMlf2CL0WH/iRhg39OnJbi96
         Mi6oLJlMJ/nsCF54S1G09ZWjPd9vznFlZ3Zry6G3nn00GLfg2bHUu4RH1Ak6x3s8NDZL
         pf4GLkgmBssOJX8mm7Tlwfi8nYngQz3TT6luj14EsoxJPXmMSHTyhvcg4kzCyG1aDN31
         moOXSAe0JMwiawhxdNx3ZXSLwp2MFZ5kGCL3gFB4al8mQvJuPYMHOjWIBILFSIB+kKxr
         6xFm04W11jT9eob7hbPxd4mV+/bqzsVLXYK1JUbcUmavyOY1wvPj+fcf8D06MyLRFmtl
         YTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692072507; x=1692677307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=anT8jKhSoDVocUIDbiLfqy7dD2AOUweYjEowk202rTE=;
        b=S0kBKxA78RHSAtVQQngTxN6IQzhkSChBPlZ8TAbUNq6F9w6dDnL+bGG5jcSE0rFsvP
         M3vQ7dh8A4ETBMMlaYPhQDpUS2lXjHrsSdLTi6S5UzAB3GaU3dVaa6opLWugtAbPX7rp
         E8MHT6vO/hG1gTxc3eALgHN9AarYGpx/h5OaUPAntkUzrurIrWsPUbdsS9ssxucVy1hK
         YHbbPPSh+DfYVEh6RHh7+9t4qZcMHl6bcVZunIgf+9UDtWwFRlPBFiOotJpdiYp94AaN
         2NTG3rQRtaDk6GpK+XJjvZwwz+D10B9ynV3bYDCH20jdUpSMAlTvhlgBb+P9rM5XEx/E
         q+gw==
X-Gm-Message-State: AOJu0YwhQDrdJapOUUnMo3t3nxNAqutWbGU0wHvImd6k676vZqN50UXd
        e8T+3P61ED+JCwoq+kl+M+75xKfkHmmlpleeZugHkg==
X-Google-Smtp-Source: AGHT+IGqJCddhtqQ3on45c/KeSIusPEi1z8qJoVUzy5BtApUx75l6r8iKgX+6HNVY9FMuRS0MrcGLw==
X-Received: by 2002:a7b:cc8d:0:b0:3f4:d18f:b2fb with SMTP id p13-20020a7bcc8d000000b003f4d18fb2fbmr9080082wma.8.1692072507328;
        Mon, 14 Aug 2023 21:08:27 -0700 (PDT)
Received: from mmaatuq-HP-Laptop-15-dy2xxx.. ([2001:8f8:1163:806e:5eb8:ff79:bda:b103])
        by smtp.gmail.com with ESMTPSA id p1-20020adfcc81000000b003179b3fd837sm16375286wrj.33.2023.08.14.21.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 21:08:26 -0700 (PDT)
From:   Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
To:     jirislaby@kernel.org, mickflemm@gmail.com, mcgrof@kernel.org,
        kvalo@kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
Subject: [PATCH v2] ath5k: fix WARNING opportunity for swap.
Date:   Tue, 15 Aug 2023 08:08:19 +0400
Message-Id: <20230815040819.649455-1-mahmoudmatook.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

coccinielle reported the following:
./drivers/net/wireless/ath/ath5k/phy.c:1573:25-26: WARNING opportunity for swap()

while trying to fix the above warning, it reveals that ath5k_hw_get_median_noise_floor() 
had open-coded sort() functionality. Since ath5k_hw_get_median_noise_floor() only
executes once every 10 seconds, any extra overhead due to sort() calling
its "compare" and "swap" functions can be ignored, so replace the
existing logic with a call to sort().

Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
Suggested-by: Jiri Slaby <jirislaby@kernel.org>
---
changes in v2:
- update the commit message explaining why open-coded sort()
  functionality is replaced with a call to sort().

- this part of updating the commit message is suggested by
   Jeff Johnson <quic_jjohnson@quicinc.com>

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

