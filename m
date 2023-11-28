Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9175B7FC5B4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346136AbjK1Un2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjK1UnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:43:25 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB751707
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:43:31 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32f8246103cso1553140f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701204210; x=1701809010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q4jh3kAmz3NLMMvf/uU8x0FwkaNbHPqHSzrIk9a+VQ0=;
        b=A/AIw8CDPELYNUeNNKE/A8r9dWCEmp+s0ImWveJqBr2xu/1cBCWjk6Sny4wLmz79qx
         P0mDbsYQFwDgYNnGaCE4irG9847ERrdLTGyPPAK+T+lgSNhWzUHpnaO2ihFiXesu6QVV
         1yeMvJzRfiq+xeGSlWPGgSOeF0OnKSgrQ3TT+sBs2tkrfJUZnmOH4eDdN9iEZYN9wWSb
         2n8AUksjcGOAtOL1HpjCGFn2TsH3l9DDxKUq1+78qrpdERCnU38kw2ygTH8yL8C0LAJG
         AgiRz8lbRbBHJIDeztAIL5IL3P0QH0RcZKJ1SgAChDfVC2aD1zPwwebZetIfgEOMQj1j
         c0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701204210; x=1701809010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4jh3kAmz3NLMMvf/uU8x0FwkaNbHPqHSzrIk9a+VQ0=;
        b=sbWvzn6PddA5SZ8tniOSzdr1qzYX2mBzKydd7DA7uxuuGJl4zKq6PMoqAbdXg17trr
         yrfTjku91PiYFXHwTbMf5EgjKaH4xRtXpHbtrFKF9v0RdrvYoMtoQK4JMuLiksBuhJ0F
         tYMgftcYyyA/ls+vLgxkNzGe+Hvg1ZbBkTRW2pX917f1q+WHRqGBxjlL7Ml+GktQiVSC
         FGFjycshtYWVZ7LPs/OnCLMfgBmQ/qWhhKVOHk4NPT237a3hfNZDLizdeGB5iSJMaeg2
         8Z7AYfYDW92cUTT3YL8pP+lyFAif0CCg9dmcbbMpUg2taEsVf8M3wkqGsF6xu0pNEsDI
         QrTg==
X-Gm-Message-State: AOJu0YzwjIpEGR6ds5y0QYJaeO1qez7/hxX4KsoSuRnuvhY8z28LO2pJ
        OgngpY39Q+ZZAu4jbzCAxx4=
X-Google-Smtp-Source: AGHT+IGlSPwq0XYOKQo2Gcbn4coEuBaz6tt2245HjfIV9x9M6ftvcJ75ndEXflqL8/VwW1akk2Xp/g==
X-Received: by 2002:a5d:6c6b:0:b0:32d:e435:92c4 with SMTP id r11-20020a5d6c6b000000b0032de43592c4mr14272134wrz.0.1701204209925;
        Tue, 28 Nov 2023 12:43:29 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id s11-20020adfeccb000000b003316b38c625sm15994336wro.99.2023.11.28.12.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:43:29 -0800 (PST)
Date:   Tue, 28 Nov 2023 21:43:28 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] staging: rtl8192e: Remove unused function
 rtllib_send_ADDBARsp()
Message-ID: <3d0b46b4cd2538a797743978c4c2daeec32f1f09.1701202700.git.philipp.g.hortmann@gmail.com>
References: <cover.1701202700.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701202700.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused function rtllib_send_ADDBARsp().

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 7e4aeb10a2db..fab7ced1b8c3 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -186,18 +186,6 @@ static void rtllib_send_ADDBAReq(struct rtllib_device *ieee, u8 *dst,
 		netdev_dbg(ieee->dev, "Failed to generate ADDBAReq packet.\n");
 }
 
-static void rtllib_send_ADDBARsp(struct rtllib_device *ieee, u8 *dst,
-				 struct ba_record *ba, u16 status_code)
-{
-	struct sk_buff *skb;
-
-	skb = rtllib_ADDBA(ieee, dst, ba, status_code, ACT_ADDBARSP);
-	if (skb)
-		softmac_mgmt_xmit(skb, ieee);
-	else
-		netdev_dbg(ieee->dev, "Failed to generate ADDBARsp packet.\n");
-}
-
 static void rtllib_send_DELBA(struct rtllib_device *ieee, u8 *dst,
 			      struct ba_record *ba, enum tr_select TxRxSelect,
 			      u16 reason_code)
-- 
2.42.0

