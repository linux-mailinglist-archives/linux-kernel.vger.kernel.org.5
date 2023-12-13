Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF93811A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379098AbjLMQwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378146AbjLMQw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:52:26 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B51F4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:52:32 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5491de618b2so1627638a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702486351; x=1703091151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2IeMdk9LkSGFLAKjbTSIgJ9FLE3muXvM3bh5IcmmJy8=;
        b=hTo1HhDsotyiKIvlriNQYAd2mSHToBHan+Oox+MucmmLRvHdtFpEiXjDvdg3XFo6Cb
         8d8QFS+mbWESZESgh7BovEzQf6qzL8l5VV4knlEF+924xxNh6IUfkRIBR/0ffhIZIP0k
         MdQhdd7g+tgrDwbWvJiOm2XvmMoncolETLvW9OC/29SqFi58PN9DB3jFd7eX/VuqeoZi
         CWiefqzcKt9WpJYGUbGCGsp1vI+ZXVimZKTyXyiXZo+xjOZNDEf7El7KnxQw7XPnfKph
         8aWLfFSaVKwjV0CszzZVCXdi/GvQHT/gMjakvXyPlXX4ftG2OyoAdUx9arTmSZGCdnkr
         9TJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702486351; x=1703091151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IeMdk9LkSGFLAKjbTSIgJ9FLE3muXvM3bh5IcmmJy8=;
        b=S3VsVqHcruYTsAzErVoGbxj53CV26wubOFXXMq9iMaoAckI1hkBrBtHnQGYS8h1MFG
         KtP5ksEfOU3TIdSrB2kaNUT4qeKPwKZ0AO1ld0rVsBzpShiiIGwTVzCGI/hOX0DqPI00
         YBA52SXcDSYSmyIgidoSP+iYO5/HGeWNzo0IeW0w5yBdwu87wpJ0Lc3aiN8xeA25UhBs
         hA1IRp6FRlmv7t4F2Z7miKMTVgNVncPbtlCOqfNUCGPlUoTIkEXFOxe0K7MLyKjxtrYQ
         A1hxHyQPTOa/Zbb73/gldmExfm3D7KqI7Cr199/CxO8dnF7W7H71iSAOhm7VU5pkbgFG
         HX2g==
X-Gm-Message-State: AOJu0Yx8E/UD1VIsW5et8rjd6iULFZgct9ZNVUvkrt4upFOSjJxcIihP
        Eduda9rrNnnwt6CjhpLHhH0=
X-Google-Smtp-Source: AGHT+IGPNcU/50+hpUoQHnLv+AQkC9dE9Per50QuyKsJ715hk2aPjYYa8YscJtrZq1mrdXJf93xumw==
X-Received: by 2002:a17:907:c003:b0:a1d:6d:1392 with SMTP id ss3-20020a170907c00300b00a1d006d1392mr9509922ejc.1.1702486350900;
        Wed, 13 Dec 2023 08:52:30 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id ul5-20020a170907ca8500b00a1fa7e39957sm4417134ejc.136.2023.12.13.08.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:52:30 -0800 (PST)
Date:   Wed, 13 Dec 2023 17:52:29 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] staging: rtl8192e: Remove variable
 ht_info->mpdu_density
Message-ID: <ef90d31e0e8281235ae4d138ce2de26e35c1bbd1.1702406712.git.philipp.g.hortmann@gmail.com>
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

ht_info->mpdu_density is set to 0 and unchanged. Therefore all equations
result accordingly and ht_info->forced_short_gi can be removed.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 1 -
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 6 ++----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index c4af9968cd67..1da56f1c04eb 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -105,7 +105,6 @@ struct rt_hi_throughput {
 	u8 current_ampdu_enable;
 	u8 ampdu_factor;
 	u8 CurrentAMPDUFactor;
-	u8 mpdu_density;
 	u8 current_mpdu_density;
 	u8 forced_ampdu_factor;
 	u8 forced_mpdu_density;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 044bfe44d213..14e6f46a65ed 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -73,7 +73,6 @@ void ht_update_default_setting(struct rtllib_device *ieee)
 
 	ht_info->ampdu_enable = 1;
 	ht_info->ampdu_factor = 2;
-	ht_info->mpdu_density = 0;
 
 	ieee->tx_dis_rate_fallback = 0;
 	ieee->tx_use_drv_assinged_rate = 0;
@@ -491,8 +490,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 							    HT_AGG_SIZE_32K);
 		}
 	}
-	ht_info->current_mpdu_density = max_t(u8, ht_info->mpdu_density,
-					      pPeerHTCap->MPDUDensity);
+	ht_info->current_mpdu_density = pPeerHTCap->MPDUDensity;
 	if (ht_info->iot_action & HT_IOT_ACT_TX_USE_AMSDU_8K) {
 		ht_info->current_ampdu_enable = false;
 	}
@@ -526,7 +524,7 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 	ht_info->cur_short_gi_20mhz = false;
 	ht_info->cur_short_gi_40mhz = false;
 
-	ht_info->current_mpdu_density = ht_info->mpdu_density;
+	ht_info->current_mpdu_density = 0;
 	ht_info->CurrentAMPDUFactor = ht_info->ampdu_factor;
 
 	memset((void *)(&ht_info->SelfHTCap), 0,
-- 
2.43.0

