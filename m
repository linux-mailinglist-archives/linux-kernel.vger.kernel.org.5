Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DFB7F0957
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 23:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjKSWPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 17:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjKSWPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 17:15:00 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CF3D60
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:14:54 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32fa4183535so894381f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700432093; x=1701036893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tcbMTqe05WtWxbhxBRfvWmeiRKiUlkBvAQPvN/yNOsg=;
        b=gujV+DOgojiE1/VS7cejPKatKohqbmmUP+ByLLSl17MYKooOoJTxC8khvku5AWKsMB
         JseWdyGKSFCCSWm2msmBcWUiwTkuwPYgYCROHtv++XMutk7dLZWSyOgdi58+2LU2s03w
         t4Eh8frAxpzEaYGblwgsb0eqKOScpV38SBbFFkTrAZSWzGMJ5adO+ZHMQJI3Srm9AN2I
         /ZjdKldo1IdWBeLX6WPv/3BAc5ntbNT4tJTWJYyf1P7vR9imYvxxLL/oxkkIX2rcIxIA
         fq905xAvb9lWOp7B6B27J4sQhM0UlVdu/0CbNXFKOvNzWA1kd42KfeMJ9QVIRkQpNOKE
         hKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700432093; x=1701036893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcbMTqe05WtWxbhxBRfvWmeiRKiUlkBvAQPvN/yNOsg=;
        b=SolDWA2G8+nTtEhpS9ZKWmjdCA93sUdL4tY+2ul01ykXs1ZHBX/GDHES0meBNbUo3E
         /dkfB1Y+iR565o3X63Yx9i8K6vxfItwzfxmu+RIfKwboN1mia4xUy77dRJEmTQbwpTT9
         kblmRUmmXaN1prcwbq2YB9rxmLmCsSQFM0j5BjChjQGBLE8iWqNFSaJcfK10+FFMt/0L
         XNtx2yedIMXRYK3qC8lFw2imaweRdvPmsf3U8X++i/NPCTqPyK/gGkhCj54/cYXKwZNV
         zGXtpW+lZkNtMmTkSDvnpik8JgXQ/mzgGQq0ve+Vx27n3BOybo1fMNLDFHKQNpBiaslw
         Eihg==
X-Gm-Message-State: AOJu0YzTJl6WfmReBif1W1GN+mE+1DfD4dv9rqQ/fn+mEMjyO0bAs8ul
        gi+eDtY3tc6ar0Pwmvro1GyXuTycMoo=
X-Google-Smtp-Source: AGHT+IGfza6p7Pnh9cSwStD+N245SCSMtFoAi9AJqCFVDmZoRPMVv4H/ERezwk8Ny9XkWUl2SoM/AA==
X-Received: by 2002:adf:f942:0:b0:32f:51c6:cd6c with SMTP id q2-20020adff942000000b0032f51c6cd6cmr3528950wrr.2.1700432093050;
        Sun, 19 Nov 2023 14:14:53 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d45c8000000b003142e438e8csm9120626wrs.26.2023.11.19.14.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 14:14:52 -0800 (PST)
Date:   Sun, 19 Nov 2023 23:14:51 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/14] staging: rtl8192e: Remove IS_DOT11D_ENABLE(ieee)
Message-ID: <9e737b2246e0b73c3ad84a4ee09f5e94bf778b3c.1700431464.git.philipp.g.hortmann@gmail.com>
References: <cover.1700431464.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700431464.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable "enabled" is initialized to false and never changed. Therefore
IS_DOT11D_ENABLE(ieee) returns always false. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/dot11d.c         |  2 --
 drivers/staging/rtl8192e/dot11d.h         |  4 ----
 drivers/staging/rtl8192e/rtllib_softmac.c | 20 --------------------
 3 files changed, 26 deletions(-)

diff --git a/drivers/staging/rtl8192e/dot11d.c b/drivers/staging/rtl8192e/dot11d.c
index fc65a63a4de6..9eb941326bc8 100644
--- a/drivers/staging/rtl8192e/dot11d.c
+++ b/drivers/staging/rtl8192e/dot11d.c
@@ -18,8 +18,6 @@ void dot11d_init(struct rtllib_device *ieee)
 {
 	struct rt_dot11d_info *dot11d_info = GET_DOT11D_INFO(ieee);
 
-	dot11d_info->enabled = false;
-
 	dot11d_info->state = DOT11D_STATE_NONE;
 	dot11d_info->country_len = 0;
 	memset(dot11d_info->channel_map, 0, MAX_CHANNEL_NUMBER + 1);
diff --git a/drivers/staging/rtl8192e/dot11d.h b/drivers/staging/rtl8192e/dot11d.h
index 39bda2f94eed..c28067510653 100644
--- a/drivers/staging/rtl8192e/dot11d.h
+++ b/drivers/staging/rtl8192e/dot11d.h
@@ -33,8 +33,6 @@ enum dot11d_state {
  */
 
 struct rt_dot11d_info {
-	bool enabled;
-
 	u16 country_len;
 	u8  country_buffer[MAX_IE_LEN];
 	u8  country_src_addr[6];
@@ -54,8 +52,6 @@ static inline void copy_mac_addr(unsigned char *des, unsigned char *src)
 #define GET_DOT11D_INFO(__ieee_dev)			\
 	 ((struct rt_dot11d_info *)((__ieee_dev)->dot11d_info))
 
-#define IS_DOT11D_ENABLE(__ieee_dev)			\
-	 (GET_DOT11D_INFO(__ieee_dev)->enabled)
 #define IS_COUNTRY_IE_VALID(__ieee_dev)			\
 	(GET_DOT11D_INFO(__ieee_dev)->country_len > 0)
 
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 42d652fe8601..08349f522c83 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -492,10 +492,6 @@ static void rtllib_softmac_scan_syncro(struct rtllib_device *ieee)
 	ieee->actscanning = false;
 	ieee->sync_scan_hurryup = 0;
 
-	if (ieee->link_state >= MAC80211_LINKED) {
-		if (IS_DOT11D_ENABLE(ieee))
-			dot11d_scan_complete(ieee);
-	}
 	mutex_unlock(&ieee->scan_mutex);
 
 	ieee->be_scan_inprogress = false;
@@ -552,8 +548,6 @@ static void rtllib_softmac_scan_wq(void *data)
 	return;
 
 out:
-	if (IS_DOT11D_ENABLE(ieee))
-		dot11d_scan_complete(ieee);
 	ieee->current_network.channel = last_channel;
 
 out1:
@@ -609,10 +603,6 @@ static void rtllib_start_scan(struct rtllib_device *ieee)
 {
 	ieee->rtllib_ips_leave_wq(ieee->dev);
 
-	if (IS_DOT11D_ENABLE(ieee)) {
-		if (IS_COUNTRY_IE_VALID(ieee))
-			RESET_CIE_WATCHDOG(ieee);
-	}
 	if (ieee->softmac_features & IEEE_SOFTMAC_SCAN) {
 		if (ieee->scanning_continue == 0) {
 			ieee->actscanning = true;
@@ -625,10 +615,6 @@ static void rtllib_start_scan(struct rtllib_device *ieee)
 /* called with wx_mutex held */
 void rtllib_start_scan_syncro(struct rtllib_device *ieee)
 {
-	if (IS_DOT11D_ENABLE(ieee)) {
-		if (IS_COUNTRY_IE_VALID(ieee))
-			RESET_CIE_WATCHDOG(ieee);
-	}
 	ieee->sync_scan_hurryup = 0;
 	if (ieee->softmac_features & IEEE_SOFTMAC_SCAN)
 		rtllib_softmac_scan_syncro(ieee);
@@ -2090,10 +2076,6 @@ static void rtllib_start_bss(struct rtllib_device *ieee)
 {
 	unsigned long flags;
 
-	if (IS_DOT11D_ENABLE(ieee) && !IS_COUNTRY_IE_VALID(ieee)) {
-		if (!ieee->global_domain)
-			return;
-	}
 	/* check if we have already found the net we
 	 * are interested in (if any).
 	 * if not (we are disassociated and we are not
@@ -2128,8 +2110,6 @@ void rtllib_disassociate(struct rtllib_device *ieee)
 	if (ieee->softmac_features & IEEE_SOFTMAC_TX_QUEUE)
 		rtllib_reset_queue(ieee);
 
-	if (IS_DOT11D_ENABLE(ieee))
-		dot11d_reset(ieee);
 	ieee->link_state = MAC80211_NOLINK;
 	ieee->is_set_key = false;
 	ieee->wap_set = 0;
-- 
2.42.0

