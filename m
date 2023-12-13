Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68188811A1E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379165AbjLMQwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378146AbjLMQwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:52:37 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20367112
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:52:42 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-551e19beb35so309869a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702486360; x=1703091160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QpGgf4XklN8es0KYbSGNNm5QQAnGIuhX/jA7OD+Idx8=;
        b=JyTER3Xcx09Fxzd3f3IDJYzmcmB+LSCPFuBDGR018QLniZuoIGbOPl9sG72gABeMXy
         WkN/RG628x3hTo9bS6e7TCNaSRWZ7F5YzEIWnBtOgbybnyzJSmBYCTPLECIljycIIqdu
         lyPUKnmX22JUEPLDVBMvNvfFLrTWn+pWezJe3rZP5odI9aHFMNPVUzvL8LvdZKMfD+1n
         gOqZFTPQ8drYEfwaotRkP1Hin7MgYHoz+tgqmi96Bmb0eKUVgOZ9D+IjauKjOhwucT17
         /omU/uQV/oy9RqMzyK1mT1ksgHvZN0m0VVxLkKbC4AeK10M0QwcM6j8G5dX5YPgT9we1
         fQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702486360; x=1703091160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpGgf4XklN8es0KYbSGNNm5QQAnGIuhX/jA7OD+Idx8=;
        b=jHvlJyHnjh35wM6ymoLKA/gXrBpB4HJm95qxurrZxi/jYFxC0isusI8gS727/cwbau
         B0p1ReWGMbnN3U6d7HtkCNkSbyQfbWiUJojg3FCo92m2kxDYZQ44CrdpTP1sMH3LvCiu
         lzJe4lqfBMnahcEfvkcZCePp6ARiwSeawpeyofL6fzAuCmzvUjsxL2YEMlJ2s5Fme3tj
         upe+nGoySU+XoEtOb5ptjfTiPpj2dTj66NE2vOEKjoYie7gUEAH5bOBPZVFu5H7vkE62
         4DKF4nqZcY+3GzeQIfR6ofnpcYc4d6+OvY9i/PYNw345ap8J348n4lN0mXXHiyxjetEG
         RbAw==
X-Gm-Message-State: AOJu0Yyu+4dDW1aqd/Xtj7T5CmSlHLRzwVCnFZpy3QvhItW14EloZBPk
        Qff+wbvrmaQwotKqxFcTxneQb1gp0p8=
X-Google-Smtp-Source: AGHT+IEPaoMNNeCr5kGtxS+NwpcCbGmmQ8u4TTb5xnRZH/gXRuLX9rjNxxBjeloggYEEAJl4I944OQ==
X-Received: by 2002:a50:bae9:0:b0:552:6202:41e1 with SMTP id x96-20020a50bae9000000b00552620241e1mr31473ede.1.1702486360316;
        Wed, 13 Dec 2023 08:52:40 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id l12-20020a50cbcc000000b0054b53aacd86sm5771950edi.65.2023.12.13.08.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:52:40 -0800 (PST)
Date:   Wed, 13 Dec 2023 17:52:38 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] staging: rtl8192e: Remove variable
 ht_info->RT2RT_HT_Mode
Message-ID: <b6253e56cdb346045a234d1f545d7ef92cdd220d.1702406712.git.philipp.g.hortmann@gmail.com>
References: <cover.1702406712.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1702406712.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove variable ht_info->RT2RT_HT_Mode as it is always set but never
evaluated.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 1 -
 drivers/staging/rtl8192e/rtl819x_HT.h        | 1 -
 drivers/staging/rtl8192e/rtl819x_HTProc.c    | 4 ----
 3 files changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 72e89ccfb184..bef042233117 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -287,7 +287,6 @@ static void _rtl92e_update_beacon(void *data)
 	if (ieee->ht_info->current_ht_support)
 		HT_update_self_and_peer_setting(ieee, net);
 	ieee->ht_info->current_rt2rt_long_slot_time = net->bssht.bd_rt2rt_long_slot_time;
-	ieee->ht_info->RT2RT_HT_Mode = net->bssht.rt2rt_ht_mode;
 	_rtl92e_update_cap(dev, net->capability);
 }
 
diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 1da56f1c04eb..315905fa4b2c 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -113,7 +113,6 @@ struct rt_hi_throughput {
 	u8 cur_tx_bw40mhz;
 	u8 sw_bw_in_progress;
 	u8 reg_rt2rt_aggregation;
-	u8 RT2RT_HT_Mode;
 	u8 current_rt2rt_aggregation;
 	u8 current_rt2rt_long_slot_time;
 	u8 sz_rt2rt_agg_buf[10];
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 14e6f46a65ed..6bd4afe32f61 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -540,7 +540,6 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 
 	ht_info->current_rt2rt_aggregation = false;
 	ht_info->current_rt2rt_long_slot_time = false;
-	ht_info->RT2RT_HT_Mode = (enum rt_ht_capability)0;
 
 	ht_info->iot_peer = 0;
 	ht_info->iot_action = 0;
@@ -601,11 +600,9 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
 				 pNetwork->bssht.bd_rt2rt_aggregation;
 			ht_info->current_rt2rt_long_slot_time =
 				 pNetwork->bssht.bd_rt2rt_long_slot_time;
-			ht_info->RT2RT_HT_Mode = pNetwork->bssht.rt2rt_ht_mode;
 		} else {
 			ht_info->current_rt2rt_aggregation = false;
 			ht_info->current_rt2rt_long_slot_time = false;
-			ht_info->RT2RT_HT_Mode = (enum rt_ht_capability)0;
 		}
 
 		ht_iot_peer_determine(ieee);
@@ -621,7 +618,6 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
 		ht_info->current_ht_support = false;
 		ht_info->current_rt2rt_aggregation = false;
 		ht_info->current_rt2rt_long_slot_time = false;
-		ht_info->RT2RT_HT_Mode = (enum rt_ht_capability)0;
 
 		ht_info->iot_action = 0;
 		ht_info->iot_ra_func = 0;
-- 
2.43.0

