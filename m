Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3313480BBF8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 16:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbjLJP1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 10:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjLJP0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 10:26:55 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EE410B
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 07:27:01 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c317ba572so5642425e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 07:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702222020; x=1702826820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ghc9oNYnVV/LlJvVf4sjMAoSbSil2W5yyWhaZB5Vhg=;
        b=Q3HWLqjK4Zk/2y1bO8hbz50aiN+0fxUsz27+ktirb218eQAHiYAlel2r0Mqqm5jS1S
         GNKnN/qyeOFMdNQsNtGlvmAMM1WpcoLeTvnequAtUhImtICRiwaN9srtt9TtG9edq8Y6
         GcIX2B9FwVG93vhC/RxNUqLVhZV5biRRT5rxYgdeMQ3zg5beiCxRaqqEs2iUR3fnRY8u
         xFlfMUi4qfxbFkNPL+4dHVkwxag8uLUU9PS5WtnZnsiZsQwFYSEU5ieSvfu0xDlj4YaY
         ozbY9lZU8/VmQTJ4UH9uSRE3mz4Q9wKR1isGylysblIJGoMBEVFVp82s9YN7HGk0XoMF
         wtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702222020; x=1702826820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Ghc9oNYnVV/LlJvVf4sjMAoSbSil2W5yyWhaZB5Vhg=;
        b=v4PEl5UzxVHs8AUekThHkoXLc/87o9F1D7BbbhqgjTuurPcQHJZPLVCriI426aC12u
         S7UboRmlS3X3ewwDrJs0s1TLfkAckWYazucOhjcFSVFMGwto2USeiABQtqnfi+LeR4SY
         qvoeZF93XmFOXhPDO1EA9Ge7PPmTlE8hbyS4HRPqN9Ah4oxTBHxyETwwizW9E1ifixZQ
         sO73JYxw7F97nj0bzXp3CJAx0kWN/VSL50N3nqNASJooHCPFHkACEWM51RbNTmdXqHot
         FRFf7U51m+Apd6rc+IAoQGA8tzyRHB336Zy0280zX1FvhU1uBG/dtUNEBsB2zl7d0lN8
         cBNg==
X-Gm-Message-State: AOJu0YzxyXR3Ybjl6w/ve66KqybeRPGNMTLV+GGQudr8TAzESNFQOh5Z
        UuPLMt42m/iBiR31wP87G/E=
X-Google-Smtp-Source: AGHT+IF9JUkMMqyQF8K7oosTh16A72VikY5ePJs2iVpnR6eLhp3mf8J3VR1wwdV5HcMwFUUfMhiJ8A==
X-Received: by 2002:a05:600c:1913:b0:40c:287a:1bba with SMTP id j19-20020a05600c191300b0040c287a1bbamr4041201wmq.2.1702222019806;
        Sun, 10 Dec 2023 07:26:59 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id r20-20020a05600c459400b0040b349c91acsm12117696wmo.16.2023.12.10.07.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 07:26:59 -0800 (PST)
Date:   Sun, 10 Dec 2023 16:26:58 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] staging: rtl8192e: Remove variable ht_info->bCurSuppCCK
Message-ID: <159a1a84c7bc90042bf1618a067f02ac123dd15d.1702212003.git.philipp.g.hortmann@gmail.com>
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

ht_info->bCurSuppCCK is set to 1 and unchanged. Therefore all equations
result accordingly and ht_info->bCurSuppCCK can be removed.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 1 -
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ----
 drivers/staging/rtl8192e/rtllib_softmac.c | 5 +----
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 670affe9d57b..416633b88446 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -97,7 +97,6 @@ struct rt_hi_throughput {
 	u8 cur_bw_40mhz;
 	u8 cur_short_gi_40mhz;
 	u8 cur_short_gi_20mhz;
-	u8 bCurSuppCCK;
 	enum ht_spec_ver ePeerHTSpecVer;
 	struct ht_capab_ele SelfHTCap;
 	struct ht_info_ele SelfHTInfo;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index ca9da96b6f6c..439b43faa2bb 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -471,8 +471,6 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 	ht_info->cur_short_gi_20mhz = ((pPeerHTCap->ShortGI20Mhz == 1) ? true : false);
 	ht_info->cur_short_gi_40mhz = ((pPeerHTCap->ShortGI40Mhz == 1) ? true : false);
 
-	ht_info->bCurSuppCCK = true;
-
 	ht_info->bCurrent_AMSDU_Support = ht_info->amsdu_support;
 
 	nMaxAMSDUSize = (pPeerHTCap->MaxAMSDUSize == 0) ? 3839 : 7935;
@@ -549,8 +547,6 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 	ht_info->cur_short_gi_40mhz = false;
 	ht_info->forced_short_gi = false;
 
-	ht_info->bCurSuppCCK = true;
-
 	ht_info->bCurrent_AMSDU_Support = false;
 	ht_info->nCurrent_AMSDU_MaxSize = ht_info->amsdu_max_size;
 	ht_info->current_mpdu_density = ht_info->mpdu_density;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 5c89744b2bbe..416f89ec576c 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -173,10 +173,7 @@ static u8 MgntQuery_MgntFrameTxRate(struct rtllib_device *ieee)
 		rate = ieee->basic_rate & 0x7f;
 
 	if (rate == 0) {
-		if (ieee->mode == WIRELESS_MODE_N_24G && !ht_info->bCurSuppCCK)
-			rate = 0x0c;
-		else
-			rate = 0x02;
+		rate = 0x02;
 	}
 
 	return rate;
-- 
2.43.0

