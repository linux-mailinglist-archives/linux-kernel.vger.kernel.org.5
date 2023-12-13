Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD929811A20
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjLMQw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235424AbjLMQww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:52:52 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D63B9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:52:58 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54ce02c1ba2so1600332a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702486377; x=1703091177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FS9s22OYVyAuBMFkyAlKFllCNEacvvjLW0t9zMiOW0M=;
        b=fw3kWsCypVk/cIonioXU38WAc6Hyng7TE4DZs2KXNyNIb9NxGe/Jhsq0hiSkoSvU+C
         AcxddEGYWj9tl1CCetylXwjnLDigE3Rp98g7EZ7GrKGrEVtnEu8khFKcwxeV+CBl/3Xq
         1eiszfl8qptEgrLKP2Ql5FQ9DXvf3sWLUOmIj8HH6KFxh27lBb2VIUrwSzFSfdfjkGrd
         GVnaJrGPCLThDtwN5WZTgfEX7uRfKwaVKBWaBglDvsp7UImue+mwCkWWVTDG4dGeJ+ET
         j00oYpYfB14VC1f7qljKXBr0EWlaAOptyFVeVkbyj9e4zX/u+XZh+CBLp+094gvZ4/p2
         iPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702486377; x=1703091177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FS9s22OYVyAuBMFkyAlKFllCNEacvvjLW0t9zMiOW0M=;
        b=qIDnURJ87UYKpwlXPY32ST6eR2CkRqDot/9ndysN/TEymGxOGAk42QQesNRmxlxSBQ
         lDzyd6Kq/yBj45Ueta0rSCSAdUAvUZkvUqbRLslBLcSyIqnSKoZVVckBK68r7EbMd26/
         Qj4zTd7fM0ap+w7Jh+p/tb7RhJF1Letssqyr+1pxTI/YpNwBQ2GCtUIXoCTtQBAj1KZk
         1gdYXiHLkdBMLF5eQWBuO0bmNoFX1rljCOZ4i8y2wmPjSmYiztzsdjYMOl4SolXUdbQI
         518FN/lP48pp3ZqXVY0hA0dCoahZpiZQOEZy3KIcy4fDZfY5Rzc1N3q/R/wi7zTt3jGG
         fRdQ==
X-Gm-Message-State: AOJu0YzpOD4nU7yS2v9QmoV7K9MAOX0XBKHquD6xyO6Dnct2KJrwcLyV
        g87pqJitlS7n6NEu5Tkyr4Y=
X-Google-Smtp-Source: AGHT+IFIApYKM+gx1pkJmp4hu81yddktS+De8kLLlF1vuNbUK4n3HX+NC4tp8rIIgO/t5SqJueGYeQ==
X-Received: by 2002:a17:906:99cf:b0:a1c:5944:29bb with SMTP id s15-20020a17090699cf00b00a1c594429bbmr9082964ejn.7.1702486376863;
        Wed, 13 Dec 2023 08:52:56 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id sa16-20020a1709076d1000b00a1da72b8752sm8047775ejc.212.2023.12.13.08.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:52:56 -0800 (PST)
Date:   Wed, 13 Dec 2023 17:52:55 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] staging: rtl8192e: Remove constant variable
 reg_rx_reorder_enable
Message-ID: <c9bf183b78bfe1fc242dc496786cd0c9f20262a4.1702406712.git.philipp.g.hortmann@gmail.com>
References: <cover.1702406712.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1702406712.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove constant variable reg_rx_reorder_enable and replace it at the place
of usage with the value.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 1 -
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 514ac9e1f3f8..2911ea82dd17 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -115,7 +115,6 @@ struct rt_hi_throughput {
 	u8 current_rt2rt_aggregation;
 	u8 current_rt2rt_long_slot_time;
 	u8 sz_rt2rt_agg_buf[10];
-	u8 reg_rx_reorder_enable;
 	u8 cur_rx_reorder_enable;
 	u8 rx_reorder_win_size;
 	u8 rx_reorder_pending_time;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index d9561e3a76d6..00bf5c706157 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -79,7 +79,6 @@ void ht_update_default_setting(struct rtllib_device *ieee)
 
 	ieee->tx_enable_fw_calc_dur = 1;
 
-	ht_info->reg_rx_reorder_enable = 1;
 	ht_info->rx_reorder_win_size = 64;
 	ht_info->rx_reorder_pending_time = 30;
 }
@@ -484,7 +483,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 	if (ht_info->iot_action & HT_IOT_ACT_TX_USE_AMSDU_8K) {
 		ht_info->current_ampdu_enable = false;
 	}
-	ht_info->cur_rx_reorder_enable = ht_info->reg_rx_reorder_enable;
+	ht_info->cur_rx_reorder_enable = 1;
 
 	if (pPeerHTCap->MCS[0] == 0)
 		pPeerHTCap->MCS[0] = 0xff;
-- 
2.43.0

