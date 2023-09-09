Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A415799A62
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 20:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238625AbjIISTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 14:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238467AbjIISTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 14:19:43 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6DDCD3
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 11:19:39 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3175e1bb38cso523344f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 11:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694283577; x=1694888377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1aLXZJ8e8a6ZIeBJrLxOGJeFVq96U2uVqqm6oo+s6Dg=;
        b=rSvQnXf4FcWGuKNApGjI/rhgcztlhtmfvxKX2Fjj0LuhwlQJ+Kjlptw9lITOvfjjkE
         nCspQraifMwfpbmAeJ6l9Srfxyj7ns6pQd+osY/tZ4EPzEVB3CF728sRI3kgCrnGOVpx
         oFJqDrzMytdU8OJL4dg51IthIXQ3wiVsYM1LaHzMLy9Vh7U+V7yZQ8iBKI25rlq5aJCV
         hh5Ln1PJu0y/axVqOHJOoBR3T7pAPQXoFo8vCrQBjGgBJodqsS0ZS6Rq8Gw091rI0xEd
         Mjp+YtPVPJpkvC8goP1nSq2iCCg7xpCaRqIUBw4g+6FxuCLSeNHupxSBYSa2GUQBbfyO
         1odA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694283577; x=1694888377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aLXZJ8e8a6ZIeBJrLxOGJeFVq96U2uVqqm6oo+s6Dg=;
        b=OJ3e7gjmCXpOVKYkVfMMzAvhNKXbbdfuqv+bKkAJUU19ImYPIGRA0WWvVq7hzCaKbp
         BK2z6HqrfVersHjoc8Vk/9eaKOTY/v5emtDisbVu/opasIVkMkrJqOkHvXkdnd6/s6Ia
         ijFXaDEh3h3GbLcEr8KRX8LpDowKfnzi8HRuSCxlpV4v0QNOvmkefaiI2FyNqIHXDfKF
         42rx9GGQXHtE3RB7z+V0Zgkwm3xxXxqqTB/K+D/P2M3k/BVPmNQQ1wNBo4PewYE0hJNd
         AaWLscaFmzulEgx1UGdVbcRmc7CQHUySmEJRsWTynWA2N/8zCAKhBKnsPnnhVLDExTJN
         Fkhg==
X-Gm-Message-State: AOJu0Yxscpl+mP0981yn2EayWZcd1bcmWa5fxcL0cQ46KAB2G+5l+FHN
        9XzHfuZ9l7QUU1ex4GCsbCP3BMIDjozniA==
X-Google-Smtp-Source: AGHT+IE0omFKM3JitdIp9lk4WPJ3b6Oj2Sakmb1uePpPNXbtLnIIY9lH+XCZgxIetNGRtwvsuEKi0Q==
X-Received: by 2002:adf:fec2:0:b0:31a:e21f:37ef with SMTP id q2-20020adffec2000000b0031ae21f37efmr4366455wrs.3.1694283577276;
        Sat, 09 Sep 2023 11:19:37 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id g9-20020adff409000000b00315af025098sm5408533wro.46.2023.09.09.11.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 11:19:37 -0700 (PDT)
Date:   Sat, 9 Sep 2023 20:19:35 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] staging: rtl8192e: Use standard ieee80211 function in
 rtllib_rx_mgt()
Message-ID: <9cb9ffc25d558af2a0c6e1abb6ae92521ba7ab89.1694282907.git.philipp.g.hortmann@gmail.com>
References: <cover.1694282907.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694282907.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace WLAN_FC_GET_STYPE(le16_to_cpu(header->frame_ctl)) and comparison
with standard function to avoid proprietary code and to increase
readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 9f944eefa41e..108238aa61d9 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -2644,14 +2644,11 @@ static void rtllib_rx_mgt(struct rtllib_device *ieee,
 {
 	struct rtllib_hdr_4addr *header = (struct rtllib_hdr_4addr *)skb->data;
 
-	if ((WLAN_FC_GET_STYPE(le16_to_cpu(header->frame_ctl)) !=
-	    RTLLIB_STYPE_PROBE_RESP) &&
-	    (WLAN_FC_GET_STYPE(le16_to_cpu(header->frame_ctl)) !=
-	    RTLLIB_STYPE_BEACON))
+	if (!ieee80211_is_probe_resp(header->frame_ctl) &&
+	    (!ieee80211_is_beacon(header->frame_ctl)))
 		ieee->last_rx_ps_time = jiffies;
 
-	switch (WLAN_FC_GET_STYPE(le16_to_cpu(header->frame_ctl))) {
-	case RTLLIB_STYPE_BEACON:
+	if (ieee80211_is_beacon(header->frame_ctl)) {
 		netdev_dbg(ieee->dev, "received BEACON\n");
 		rtllib_process_probe_response(
 				ieee, (struct rtllib_probe_response *)header,
@@ -2661,20 +2658,15 @@ static void rtllib_rx_mgt(struct rtllib_device *ieee,
 		    ieee->iw_mode == IW_MODE_INFRA &&
 		    ieee->link_state == MAC80211_LINKED))
 			schedule_work(&ieee->ps_task);
-
-		break;
-
-	case RTLLIB_STYPE_PROBE_RESP:
+	} else if (ieee80211_is_probe_resp(header->frame_ctl)) {
 		netdev_dbg(ieee->dev, "received PROBE RESPONSE\n");
 		rtllib_process_probe_response(ieee,
 			      (struct rtllib_probe_response *)header, stats);
-		break;
-	case RTLLIB_STYPE_PROBE_REQ:
+	} else if (ieee80211_is_probe_req(header->frame_ctl)) {
 		netdev_dbg(ieee->dev, "received PROBE REQUEST\n");
 		if ((ieee->softmac_features & IEEE_SOFTMAC_PROBERS) &&
 		    (ieee->iw_mode == IW_MODE_ADHOC &&
 		    ieee->link_state == MAC80211_LINKED))
 			rtllib_rx_probe_rq(ieee, skb);
-		break;
 	}
 }
-- 
2.41.0

