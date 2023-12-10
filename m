Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28BA80BBF4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 16:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjLJP0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 10:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjLJP0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 10:26:30 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D5710D0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 07:26:33 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c362efc2dso3854425e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 07:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702221992; x=1702826792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5+7aTaTlcaG6uppnc5wOD9WJR1BJWGY5PIIBacZp7LI=;
        b=WOxgdIfGRv7Q11C6VCTzuAgfaJtWtOeRpNpmUuHrMxoxPako2hKkc0PqJa2ZSmFXmS
         10grmo42pPTQsWNtA0gh/gpg65Ve6udGBcYDft7/1vQGBmUyLv+5dWpNPUMgjALXeSsV
         Dr24Exh3zBExv3q8NINOCU+25l1xwQjYf7enDsnBJRPRMr9SpwPR8FTH/uHooaP1q3Wf
         bcnK2OKBi/MJMI2sWiSE5H8/aickmrfXK2IJu9Yh3yRZxs1o842Oz+E+5YC2BiNhWTMZ
         pawD7JuEwLAFxIcKsmCKDwSHk+AnWw1/3RbNA4kziq3dIk4e8/DNPNMzfLF7VbvN5/ge
         3nfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702221992; x=1702826792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+7aTaTlcaG6uppnc5wOD9WJR1BJWGY5PIIBacZp7LI=;
        b=fbUZvKFn2kwhldgQDMkxheaGnlYYiuZ6m6/tyDdP5PJk41KXcMAwg3Hf4u1Ithqy+E
         KfvgnPqSxz6b0K9B4MxNCBXzmelAb9QwcWOosHqkQ3caQLCKpa53RFyEifbiR6Bd3v+D
         vY7eU7o0Slo/dkrDnkN/FGCNEXF52zIvAom3YMNo7VZ0Lt7ZN8VmuNQgzQBQ5rxGfobO
         stLGtS1y6pzXewDHy680W+qvwE6yXNrGOY2Br4btHWPs67l/a+40zMV2hCsHMq2FQJ+W
         GH9bsgIdh4bNholasg5FePg1+g0sHKEho4wH8AnNKFBueSbSDOXY/dBi6skUoW/Ad/dT
         oMJw==
X-Gm-Message-State: AOJu0YyguWhUvRno2z99hScA8wxTqfJwyZS4GTghW5tZsLcgevFqz+pf
        oS6klEYS/wbBlBMLh0JwZJs=
X-Google-Smtp-Source: AGHT+IEIz5F2RMVOcsuKSimCj3U2AYWR3DKo626ZvJedo1stLVJcI1Wd5pxDlCOLi2BsG8Imgh7etw==
X-Received: by 2002:a05:600c:35d6:b0:405:358c:ba75 with SMTP id r22-20020a05600c35d600b00405358cba75mr4026078wmq.0.1702221991724;
        Sun, 10 Dec 2023 07:26:31 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id o3-20020a05600c4fc300b004042dbb8925sm12148980wmq.38.2023.12.10.07.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 07:26:31 -0800 (PST)
Date:   Sun, 10 Dec 2023 16:26:30 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] staging: rtl8192e: Remove variable
 ht_info->reg_short_gi_40mhz
Message-ID: <255039e0cb27582a98a0b86340dfe88f14c08a76.1702212003.git.philipp.g.hortmann@gmail.com>
References: <cover.1702212003.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1702212003.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ht_info->reg_short_gi_40mhz is set to 1 and unchanged. Therefore all
equations result accordingly and ht_info->reg_short_gi_40mhz can be
removed.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 1 -
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 6 +-----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 8a4bd389004a..0664eb86bada 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -95,7 +95,6 @@ struct rt_hi_throughput {
 	u8 enable_ht;
 	u8 current_ht_support;
 	u8 cur_bw_40mhz;
-	u8 reg_short_gi_40mhz;
 	u8 cur_short_gi_40mhz;
 	u8 cur_short_gi_20mhz;
 	u8 bCurSuppCCK;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index ed9b3db1a393..0a5885d6c0a0 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -71,8 +71,6 @@ void ht_update_default_setting(struct rtllib_device *ieee)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-	ht_info->reg_short_gi_40mhz = 1;
-
 	ht_info->amsdu_max_size = 7935UL;
 	ht_info->amsdu_support = 0;
 
@@ -471,9 +469,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 				 true : false);
 
 	ht_info->cur_short_gi_20mhz = ((pPeerHTCap->ShortGI20Mhz == 1) ? true : false);
-	ht_info->cur_short_gi_40mhz = ((ht_info->reg_short_gi_40mhz) ?
-				     ((pPeerHTCap->ShortGI40Mhz == 1) ?
-				     true : false) : false);
+	ht_info->cur_short_gi_40mhz = ((pPeerHTCap->ShortGI40Mhz == 1) ? true : false);
 
 	ht_info->bCurSuppCCK = ((pPeerHTCap->DssCCk == 1) ? true : false);
 
-- 
2.43.0

