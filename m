Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88C67F98C6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 06:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjK0Fg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 00:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjK0Fg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 00:36:26 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511DDD64
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:30 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cfc35090b0so6057385ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1701063389; x=1701668189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2j4VzOuBt+uyczV2meq0MpY0uQbt9u8nczliuiE+crw=;
        b=J70kFCAkkhHHYw1T+CrXre7DazsSgDjM0roo3txJb+XKywphSFkGsU4LODKV44sbyt
         o6CmphSCD5HZC+IEb5WhbhNkOWqFHSEWI9gLLl2Lfefy8sZW9P5FU5Tefvgg74X1lRvR
         vXgPtgZws/4v9C4vCcjXz4bgCxHkRHaQWVN3iMCRjY2z17fnkp1WLaolHAy+Nj9KgxSe
         /WjFA/PDE0PQ77LV2isqm3oEwgtQMpsV/TS2TE3aYV3dZWaoZx7iOGeCzXBUmoIsGqU7
         dcp9+hjHX2tXtNathmxUhfuBUtlaPtA0AvOyO8573+sfBw5uJBV+CHgD4iN94by8sv1/
         DvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701063389; x=1701668189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2j4VzOuBt+uyczV2meq0MpY0uQbt9u8nczliuiE+crw=;
        b=egtlxw+q80S1MmqRdrogZbNSGhRAby3e+wvHL+JZ7iFlCUnLYI4t2v+3+s8myR9b7c
         C3lAjjebxVnCm5VrOHELgCAMgVKwO3ctm1jmo4F72rHQBna9yzeLHX7rZwLOCTdyvSLp
         gFYR4EJk0ZrdGUAYtcNAEOTLBPyxRlb3ZraMQe+PI2lFOJrbWmsjAnKu1DynHKV2AG+P
         268xph+LdhbWa+Ci4j4Qq1J/7yzjSiE+W5RIxS2xhFIBXQ81HIXKA27q8Ld2XfkHC7IZ
         fl3cUFv7gDBmUJIudbEIlr2MP4+ZgSWAszNjxjsjbMWEyvjlCJoP0CGlNsl/zAqk8Tcj
         KOVA==
X-Gm-Message-State: AOJu0YwhiESWvZql2Oze1BESg+V7efwZzaCH+6pPgKNnALWzfWOAWB7G
        B5bt1T91pycyp7Hf+IgdMJXxvQ==
X-Google-Smtp-Source: AGHT+IEYUvkttzAlThLW0Vcf5ln7MhtBjPrK2U2R9yrbD0YOHyjjEnCg0+nKVMALiObt7GRANPPgOg==
X-Received: by 2002:a17:902:ab1d:b0:1cf:50a0:566d with SMTP id ik29-20020a170902ab1d00b001cf50a0566dmr8890369plb.7.1701063389492;
        Sun, 26 Nov 2023 21:36:29 -0800 (PST)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902ed0600b001cc3875e658sm7300465pld.303.2023.11.26.21.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 21:36:29 -0800 (PST)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 11/15] Staging: rtl8192e: Rename variable DelbaParamSet
Date:   Sun, 26 Nov 2023 21:43:01 -0800
Message-ID: <20231127054305.148276-12-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231127054305.148276-1-tdavies@darkphysics.net>
References: <20231127054305.148276-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable DelbaParamSet to del_ba_param_set to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 2053feb51f61..bd037069d4f3 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -127,7 +127,7 @@ static struct sk_buff *rtllib_DELBA(struct rtllib_device *ieee, u8 *dst,
 				    struct ba_record *ba,
 				    enum tr_select TxRxSelect, u16 reason_code)
 {
-	union delba_param_set DelbaParamSet;
+	union delba_param_set del_ba_param_set;
 	struct sk_buff *skb = NULL;
 	struct ieee80211_hdr_3addr *del_ba = NULL;
 	u8 *tag = NULL;
@@ -137,10 +137,10 @@ static struct sk_buff *rtllib_DELBA(struct rtllib_device *ieee, u8 *dst,
 		netdev_dbg(ieee->dev, "%s(): reason_code(%d) sentd to: %pM\n",
 			   __func__, reason_code, dst);
 
-	memset(&DelbaParamSet, 0, 2);
+	memset(&del_ba_param_set, 0, 2);
 
-	DelbaParamSet.field.initiator = (TxRxSelect == TX_DIR) ? 1 : 0;
-	DelbaParamSet.field.tid	= ba->ba_param_set.field.tid;
+	del_ba_param_set.field.initiator = (TxRxSelect == TX_DIR) ? 1 : 0;
+	del_ba_param_set.field.tid	= ba->ba_param_set.field.tid;
 
 	skb = dev_alloc_skb(len + sizeof(struct ieee80211_hdr_3addr));
 	if (!skb)
@@ -160,7 +160,7 @@ static struct sk_buff *rtllib_DELBA(struct rtllib_device *ieee, u8 *dst,
 	*tag++ = ACT_CAT_BA;
 	*tag++ = ACT_DELBA;
 
-	put_unaligned_le16(DelbaParamSet.short_data, tag);
+	put_unaligned_le16(del_ba_param_set.short_data, tag);
 	tag += 2;
 
 	put_unaligned_le16(reason_code, tag);
-- 
2.39.2

