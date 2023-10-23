Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C757D2AA0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjJWGlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbjJWGkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:40:55 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C0710C4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:40:46 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9bf0bee9f2fso100764966b.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698043245; x=1698648045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=usb14TKnR5nGARmhYK6QjpDq5f+Ywoldfs7WPWSHtjk=;
        b=lwszKBEa+0IeJyQo8Gj+9KW1H6f+C7fsvKZWfumkKTfS68wyGvX5q/jbkCZ3pmLVAK
         aOmWidI812ozp50mwwIKACSaU6B31aOV2yDenDTSv/48Ptmo2WrORkVrmOVUOaYcnfw0
         nLAk90zBaatT7pyavdxXmYWpSX1/dHPvoZGXKO7grH40M2/A9LFSz9kZFbfWko0ou3vT
         AoM0pT0+llsvnYmcx9ws5zSN0SiKC/xWZVcZAWi3uVQIp48ea0ktWpDiaVTk81Wp4UZo
         Fdmzt+CASaaQhEBGIK2Hxbz/CzS+NZa9GU2Tf/NnGtdha+pwbw+2t6OEvI39wA/7GfsW
         LQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698043245; x=1698648045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usb14TKnR5nGARmhYK6QjpDq5f+Ywoldfs7WPWSHtjk=;
        b=lEPAPJaVq3ZmGgEQGqGyzl77HuPOYMSw51YoS5swELrJSnvfMCx2mGLVscuXtKRx+g
         Xifx6iKaQDKO7XIAxNK2WNA82TiQxONVbFApEKStVC0aZFm9rVxubNmRtDF/gs3lJw+7
         L+oIZgE+Y6/znY/V7ymE+lgaBvGtZScvFuwCyZUlLaFkKb9OfzxIFJEMCkx6SyZbCWBT
         SS7hp7tW0kM1UzEOrWZUCpUEjB3mWj0kQpF0FpOQeWnZ6hkTmwINFsA5qYBL4JMhVDbl
         05pV7o4gOXDVb0UVABR6BWrsZ747YUkW9U/bH2Os+HjkKtQl3/vAhFAZToaGgG6i60n9
         rOwg==
X-Gm-Message-State: AOJu0Ywc9TqOXUbVbYW+cQN3b5k4LzDFuI7xx9Y8bd0IW60AVKd1eZfo
        kIME4hZfikGni30bITLQG88=
X-Google-Smtp-Source: AGHT+IF6ARxAGq5faUU73LlSjuP8qajtw7vveJvgBijeRWRJh4wcE9migJuJqgAIXuIuDBYnm/cfvA==
X-Received: by 2002:a17:906:109:b0:9bf:b83c:5efd with SMTP id 9-20020a170906010900b009bfb83c5efdmr5050754eje.3.1698043244873;
        Sun, 22 Oct 2023 23:40:44 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id h13-20020a1709062dcd00b009ae54585aebsm6097878eji.89.2023.10.22.23.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 23:40:44 -0700 (PDT)
Date:   Mon, 23 Oct 2023 08:40:43 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] staging: rtl8192e: Remove unused variables TClasProc
 and TClasNum
Message-ID: <04ce3eaaaf3897a22dcb95ce2f449658199770d8.1698042685.git.philipp.g.hortmann@gmail.com>
References: <cover.1698042685.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698042685.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variables to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_TS.h     | 2 --
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TS.h b/drivers/staging/rtl8192e/rtl819x_TS.h
index 240e808fc4b2..ab737428d4a7 100644
--- a/drivers/staging/rtl8192e/rtl819x_TS.h
+++ b/drivers/staging/rtl8192e/rtl819x_TS.h
@@ -21,8 +21,6 @@ struct ts_common_info {
 	struct list_head		List;
 	u8				addr[ETH_ALEN];
 	struct qos_tsinfo TSpec;
-	u8				TClasProc;
-	u8				TClasNum;
 };
 
 struct tx_ts_record {
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 7151827408b9..3206fdb3e65a 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -95,8 +95,6 @@ static void ResetTsCommonInfo(struct ts_common_info *pTsCommonInfo)
 {
 	eth_zero_addr(pTsCommonInfo->addr);
 	memset(&pTsCommonInfo->TSpec, 0, sizeof(struct qos_tsinfo));
-	pTsCommonInfo->TClasProc = 0;
-	pTsCommonInfo->TClasNum = 0;
 }
 
 static void ResetTxTsEntry(struct tx_ts_record *ts)
-- 
2.42.0

