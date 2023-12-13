Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C84811A1B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbjLMQwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378960AbjLMQwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:52:09 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC0CB9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:52:15 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54cea1f30cbso1538180a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702486334; x=1703091134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hcU4d4c9EhwDhCpZ+xb05RdkC86nsBALUhVrkSRZ1Dw=;
        b=TI9tH/ipcl9K7i14cVskk3TqvSimXxuaFFvLRYrJur6UzVjkBXbJ/ocMHfspeLjTX6
         9Gj7GUZeU22Rr4yPGiSKGFE55rYw090pVwcqUag4202Ik+yzSXpwtgsBRhjmjkfx6sCL
         LXn4UyKGgl9H0fxvhQyJhdUikLmQ+u/s8AqDjNHx2A6qMPUzEzXi055BawstDcU3Ma6B
         +RkP0ijaCVmXbiQgqjvhtvc9hRTDUmyYEpbbdw/QnEzWUOf/KYHh3hRKDbpnNlx/HBGy
         nBojjgRg5f9HNna0GhEXYetMtp63BkTVeDr+9JruaDVn9kCK+hXnPIWxdJgUrTQ5E1lE
         YG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702486334; x=1703091134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcU4d4c9EhwDhCpZ+xb05RdkC86nsBALUhVrkSRZ1Dw=;
        b=J9GydbKMHIvve7FQWk5KbwMEQMT60mdz/lreKYkyQGaaYeloD/TNCY4+e1j1lzUjPu
         nf9bK5KHB08QxcrR2Wn8WwwC8pDy6hF3JhzBA7C8Vqil1weFrxcifYJbX+Iv9KK+yfns
         KLMRciL/hzxbIMEp5KeBak1LQ6apO5cm5lKZxYpOlkQ1Lz9d54lDudGgRGoCV02jFJcH
         +EmZxSFh+zQ3rfCypRSNo9GtxeHYF8j/RpEyB9MC4EoPZe4zpAiNeCKHumokNOd3KZ5P
         wmoo/SgaJZFZ4/tI9o7rGQDkAvOIR+s/CgNwfhs/7kit9EToxPEWbSUF4nmh27N5ST02
         Nyyw==
X-Gm-Message-State: AOJu0YxsbtNpG2MVMYlvphnExPdHQZlXloP4+eRR1M/mALvSygL55aBG
        vCyHXevkBbVT0nwHGdZoYMaDLLktAtM=
X-Google-Smtp-Source: AGHT+IGZz7paThhCvZZNDmg/Imt9mXY25GH+sKlIoSMkzIKOa6mluYu0N+JMxL26diY7xzifU3KH4g==
X-Received: by 2002:a50:c189:0:b0:54c:6fc0:483a with SMTP id m9-20020a50c189000000b0054c6fc0483amr8757847edf.2.1702486334020;
        Wed, 13 Dec 2023 08:52:14 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id v1-20020a50d581000000b00550ce74f7eesm4994896edi.67.2023.12.13.08.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:52:13 -0800 (PST)
Date:   Wed, 13 Dec 2023 17:52:12 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] staging: rtl8192e: Remove constant variable
 forced_short_gi
Message-ID: <fc5711032c658af6ae6c5a7a98c52871c29f8c33.1702406712.git.philipp.g.hortmann@gmail.com>
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

ht_info->forced_short_gi is set to 0 and unchanged. Therefore all equations
result accordingly and ht_info->forced_short_gi can be removed.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 1 -
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 1 -
 drivers/staging/rtl8192e/rtllib_tx.c      | 5 -----
 3 files changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 43472b2250c2..e6cd906dc0ac 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -110,7 +110,6 @@ struct rt_hi_throughput {
 	u8 current_mpdu_density;
 	u8 forced_ampdu_factor;
 	u8 forced_mpdu_density;
-	u8 forced_short_gi;
 	u8 current_op_mode;
 	enum ht_extchnl_offset CurSTAExtChnlOffset;
 	u8 cur_tx_bw40mhz;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index d424b7729a01..578d9276035f 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -527,7 +527,6 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 
 	ht_info->cur_short_gi_20mhz = false;
 	ht_info->cur_short_gi_40mhz = false;
-	ht_info->forced_short_gi = false;
 
 	ht_info->current_mpdu_density = ht_info->mpdu_density;
 	ht_info->CurrentAMPDUFactor = ht_info->ampdu_factor;
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 0fa6f674a844..f7098a2ba8b0 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -340,11 +340,6 @@ static void rtllib_query_HTCapShortGI(struct rtllib_device *ieee,
 	if (!ht_info->current_ht_support || !ht_info->enable_ht)
 		return;
 
-	if (ht_info->forced_short_gi) {
-		tcb_desc->bUseShortGI = true;
-		return;
-	}
-
 	if (ht_info->cur_bw_40mhz && ht_info->cur_short_gi_40mhz)
 		tcb_desc->bUseShortGI = true;
 	else if (!ht_info->cur_bw_40mhz && ht_info->cur_short_gi_20mhz)
-- 
2.43.0

