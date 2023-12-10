Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D83A80BBF3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 16:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjLJP0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 10:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbjLJP0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 10:26:23 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A9B11C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 07:26:27 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c192f488cso5990765e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 07:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702221986; x=1702826786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jSfz65UDs/wKcMDkHDq6mjAfRk0t651ez9MkrfvQFp0=;
        b=MpBypr/M6t0DNCT6qCQAVhY7e1Iulb1ONTNxr1oj19zUhXUxksz0Q/4Qggdpgk+RXH
         CMW4Fx2J8JCCjQEGnnojfsG8FXWHbp4dqJxTRDcDuJA+fQbRH1U7yoSahF1MPlD9GJNA
         PuzatxznlF7md/anbyyannA0DKlBqlxU0TV48sQU5KuBUCykaPVqiHTzPQDVZlYr9dPB
         1zq/w3sRK4w03+Bhp5STeyzyA5K5gWyyoc2ukOpq/5v5ljMFfgZ0P9sgleZLuppT+JpY
         409VauBrtq9+XcYMe5Z6olpqkbuukJiyKDdinkxpCVUXwimMFlTBzwX+BIGswk2SmX1n
         37Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702221986; x=1702826786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSfz65UDs/wKcMDkHDq6mjAfRk0t651ez9MkrfvQFp0=;
        b=Gfw3PsYV5sDLMBAh/AlHzYTzEk9G1+ggvbcV61auo5Bw4PGK/0r5N5+usiYc0WS6p7
         m76LQ4aX0+MIGNTcN5rzLMZbbszL/vwZhlMYIBtAUQjt0bQjdykB0A5TUXDm6nCrXPq1
         c1WkOdzZ/Z5hcYXQ7d/QALSyG3WhiRG65uHW3LlTOJMotZ45jU9gKV0GtxXumFQ/o02s
         NLUyJoiU/owY0nm3PnKiUkLRdREvBaVJWk9zdEl6vfqV0glyeBhPy98NK202zGmR1nYl
         ILKN+teep/JChM5oKLIyCMfbESzDsN+BVodM8wfC3DNKOhgaUiO8gA8vRa3ba1W0r67d
         4Alg==
X-Gm-Message-State: AOJu0Yys3ZOHZDNR8siNlN3DAu4YuurdtasGhByvHY7ZSIznrv0oIdHF
        P3krPCLZSBws45N0IFazolua8Di5wqA=
X-Google-Smtp-Source: AGHT+IELaS9Zr+mPun+iaRw9flRNeqOTMP1mF8lUdD7/PdMBwDlmQtXTrSt7KifuKZ2C8wH7VD5i1g==
X-Received: by 2002:a05:6000:154f:b0:333:5330:2934 with SMTP id 15-20020a056000154f00b0033353302934mr4979541wry.1.1702221985654;
        Sun, 10 Dec 2023 07:26:25 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id g3-20020adff403000000b003335ddce799sm6529063wro.103.2023.12.10.07.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 07:26:25 -0800 (PST)
Date:   Sun, 10 Dec 2023 16:26:24 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] staging: rtl8192e: Remove variable
 ht_info->reg_short_gi_20mhz
Message-ID: <a2778d12a2bb104a980a69f8eb05ba1cabf7b545.1702212003.git.philipp.g.hortmann@gmail.com>
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

ht_info->reg_short_gi_20mhz is set to 1 and unchanged. Therefore all
equations result accordingly and ht_info->reg_short_gi_20mhz can be
removed.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 1 -
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 5 +----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 6556c5df958d..8a4bd389004a 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -97,7 +97,6 @@ struct rt_hi_throughput {
 	u8 cur_bw_40mhz;
 	u8 reg_short_gi_40mhz;
 	u8 cur_short_gi_40mhz;
-	u8 reg_short_gi_20mhz;
 	u8 cur_short_gi_20mhz;
 	u8 bCurSuppCCK;
 	enum ht_spec_ver ePeerHTSpecVer;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 7acc8b4c11c4..ed9b3db1a393 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -71,7 +71,6 @@ void ht_update_default_setting(struct rtllib_device *ieee)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-	ht_info->reg_short_gi_20mhz = 1;
 	ht_info->reg_short_gi_40mhz = 1;
 
 	ht_info->amsdu_max_size = 7935UL;
@@ -471,9 +470,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 	ht_info->cur_tx_bw40mhz = ((pPeerHTInfo->RecommemdedTxWidth == 1) ?
 				 true : false);
 
-	ht_info->cur_short_gi_20mhz = ((ht_info->reg_short_gi_20mhz) ?
-				    ((pPeerHTCap->ShortGI20Mhz == 1) ?
-				    true : false) : false);
+	ht_info->cur_short_gi_20mhz = ((pPeerHTCap->ShortGI20Mhz == 1) ? true : false);
 	ht_info->cur_short_gi_40mhz = ((ht_info->reg_short_gi_40mhz) ?
 				     ((pPeerHTCap->ShortGI40Mhz == 1) ?
 				     true : false) : false);
-- 
2.43.0

