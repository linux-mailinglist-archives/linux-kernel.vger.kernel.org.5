Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE0E811A12
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379305AbjLMQvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379162AbjLMQv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:51:29 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FC4B9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:51:35 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a1c6c8d2ecdso190860466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702486294; x=1703091094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1UMQD+xxxwGpCckGrKfQ1npPt/no2ggj6N88c7tmbIE=;
        b=jPv5m1mTOdTtBwVPiqA2+ibEUT9mxhW5geCFwJH1XBxbQwQHUMtGpX42+Eu50Spn/u
         2ql751xICRL7g9F22/QAeddiRnre39Tg+0aMtAW9CxgCKMZkuMiaHHBrk+YMTyY3IsXz
         aUNG1WoHnFSPe7Kc12SVwOBcC+bvz6/il5Vku9Lq+9ArEodHFFSyQ9dgfHn8B4F+hBRm
         2b6x3ElzfcxnuvGI+1FW9RilnZSk7q3qXN+P/P8LRdF8rHBwfjjqcQVcYFxm54tOKc/l
         Eh0EzZinQaBzbAGpdSbr9o/ykeeQc/0YnCRhGLzhFmDmd7fXwpKg8ng1/Lqz1ySxmD3k
         lBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702486294; x=1703091094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UMQD+xxxwGpCckGrKfQ1npPt/no2ggj6N88c7tmbIE=;
        b=gFRw12h0jNc9SCR8mOKK2xIW7A3zulBYDsLZ6kACLQcGqDnROtzIVO0E6mffnLzBQp
         4AIYWNFp9XV9ZGCa/GMLZaUiSflEkF6/WRJcDMj1gSymNe1gtUDUkmFRWZPPjupbQ0i8
         JIoYtaXNLPtEJ9Ysjt3WylSxr4z+atDyqnROa/eesuBcTmf2xNOSZQM1Xdlcutjlvo2I
         iqrCYGmRuHZTsEI3SlJm91LoiW/5mCAerQLKctUtCNNil/aCjLGJGATYpMqeBOxw6MRz
         oODH0cwiIVRrDDImdXrNH28tM0ngJkDtZepMLCTj9evehuOhSfK+rm+WAlj+I6l7QncV
         NEdQ==
X-Gm-Message-State: AOJu0Yylf7PfZqwz3OQETvGwUVeh6ZlzRDzGHU68vpBRTterCUSpGsew
        3kRgMYsZ0vu+HqTs0dB2dWk=
X-Google-Smtp-Source: AGHT+IEFCFZ3TSUggaDoIU8TzPXxoQxJJ/nuyOO0ToCi4OsWR6nB8kAy6NYouBZiLkaM4++W/cFoGQ==
X-Received: by 2002:a17:907:d404:b0:a01:b8e5:d4b7 with SMTP id vi4-20020a170907d40400b00a01b8e5d4b7mr7922559ejc.1.1702486294303;
        Wed, 13 Dec 2023 08:51:34 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id ty6-20020a170907c70600b00a1d71c57cb1sm8116418ejc.68.2023.12.13.08.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:51:34 -0800 (PST)
Date:   Wed, 13 Dec 2023 17:51:32 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] staging: rtl8192e: Remove variable
 bCurrent_AMSDU_Support
Message-ID: <d2711450dbc62974162abd4db070e34c9828997d.1702406712.git.philipp.g.hortmann@gmail.com>
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

bCurrent_AMSDU_Support and nCurrent_AMSDU_MaxSize are set but never
evaluated.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 2 --
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 9 ---------
 2 files changed, 11 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 0f27c820ffc5..bf87106dd784 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -103,8 +103,6 @@ struct rt_hi_throughput {
 	u8 PeerHTInfoBuf[32];
 	u8 amsdu_support;
 	u16 amsdu_max_size;
-	u8 bCurrent_AMSDU_Support;
-	u16 nCurrent_AMSDU_MaxSize;
 	u8 ampdu_enable;
 	u8 current_ampdu_enable;
 	u8 ampdu_factor;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 0197782e0ab6..cb8150137858 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -471,15 +471,8 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 	ht_info->cur_short_gi_20mhz = ((pPeerHTCap->ShortGI20Mhz == 1) ? true : false);
 	ht_info->cur_short_gi_40mhz = ((pPeerHTCap->ShortGI40Mhz == 1) ? true : false);
 
-	ht_info->bCurrent_AMSDU_Support = ht_info->amsdu_support;
-
 	nMaxAMSDUSize = (pPeerHTCap->MaxAMSDUSize == 0) ? 3839 : 7935;
 
-	if (ht_info->amsdu_max_size > nMaxAMSDUSize)
-		ht_info->nCurrent_AMSDU_MaxSize = nMaxAMSDUSize;
-	else
-		ht_info->nCurrent_AMSDU_MaxSize = ht_info->amsdu_max_size;
-
 	ht_info->current_ampdu_enable = ht_info->ampdu_enable;
 	if (ieee->rtllib_ap_sec_type &&
 	    (ieee->rtllib_ap_sec_type(ieee) & (SEC_ALG_WEP | SEC_ALG_TKIP))) {
@@ -547,8 +540,6 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 	ht_info->cur_short_gi_40mhz = false;
 	ht_info->forced_short_gi = false;
 
-	ht_info->bCurrent_AMSDU_Support = false;
-	ht_info->nCurrent_AMSDU_MaxSize = ht_info->amsdu_max_size;
 	ht_info->current_mpdu_density = ht_info->mpdu_density;
 	ht_info->CurrentAMPDUFactor = ht_info->ampdu_factor;
 
-- 
2.43.0

