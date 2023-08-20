Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A4A781BE7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 03:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjHTA6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjHTA6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:58:18 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759B27C9EE
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:21 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-570c36ec14bso209433eaf.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692492321; x=1693097121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWQQsv7kFWgeQHT/Yq5qIyfESDh5t6Uw6gZfyjJY5+M=;
        b=Twsf1xAMLd/DPZOXPb+fhb4p+9b30O+TQ7fyspz5Ps1crEAl4DMTMClQNgcBSLeqOG
         nP0lfVTpJKfIzyxphhnWX1N86FVRM2ApBSt4Z/Jm2lpk7LChSBeo41hufBYBspiUkC6O
         3FqqRKMGotVAY3uWxhtqOGST5OxJBhM5AEr2Ha9VhlZD6uaHLuSZBC8Yh1ZVHGgmyaEn
         Ia74ubvd/mkW4qUc3v/MWrdqr0u8iVjRyK3YBbLMkCrOMgcwCsmjNxjrFhW7wkjD4L5H
         W13Tnq7L6v4zmDY/gvu0bTMXi+wXNsRKpzIy82JRNVA1UmZbfRHOK9eYT9Iyir4Kwqy3
         rm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692492321; x=1693097121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWQQsv7kFWgeQHT/Yq5qIyfESDh5t6Uw6gZfyjJY5+M=;
        b=Rl30GyJU25OV0WomNGcx3SQ0a1VWMNCI0yq1uHGDB1qwww8Kka1snpRFCaBxqhUrYk
         xz8XjdR4E0UvO+9Uet1+3QPRmGV4CgTzvtzVA5kwL6ALqWg57sjMFK9xbczHpaYAp7Xr
         yeckZZCf2CQeLVkkwmymUdbpBHwLQIjIAetpiqLUN9V/lUw3vfvaLAOiammcfROqsLhX
         8iW9oeV3i0RiI0fMkC9ANxAVYQtxQn+7g6X6R1ycRZSp2YOVRQDzQs4m7M400SRW1D0R
         LSMqnZU9lvQxcuA0bZmlEx2TVZtgSy2aZomNmh5j7q2RtA9iwY6142rTgOfb7Y5saNnE
         9dRQ==
X-Gm-Message-State: AOJu0YxhdW5TDqy9kOYtAD6hmL7WXTyhXx7ZH20l9YWOriIFG93QtLeS
        0B2EFXjrkzh2sTBVKJaGKPsRfw==
X-Google-Smtp-Source: AGHT+IF9UIajOIooUgvdl+U9eGGnBNrjW0vOH+LRG+GxZM32b970kY0+jvQ8KEd/v7FG5GFeME3prA==
X-Received: by 2002:a05:6870:9722:b0:1b3:715c:463e with SMTP id n34-20020a056870972200b001b3715c463emr5014038oaq.0.1692492320812;
        Sat, 19 Aug 2023 17:45:20 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a1a1900b00268b439a0cbsm4004884pjk.23.2023.08.19.17.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 17:45:20 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v3 03/16] Staging: rtl8192e: Rename variable pRxTs in function rtllib_rx_DELBA()
Date:   Sat, 19 Aug 2023 17:47:31 -0700
Message-ID: <20230820004744.278022-4-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230820004744.278022-1-tdavies@darkphysics.net>
References: <20230820004744.278022-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable pRxTs in function rtllib_rx_DELBA() to ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v3:Resend as 16 patch series - no longer throttled by email provider
v2:Resending in smaller patch series
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 03d76765e85f..c584e9ec48b6 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -430,9 +430,9 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 	pDelBaParamSet = (union delba_param_set *)&delba->payload[2];
 
 	if (pDelBaParamSet->field.initiator == 1) {
-		struct rx_ts_record *pRxTs;
+		struct rx_ts_record *ts;
 
-		if (!GetTs(ieee, (struct ts_common_info **)&pRxTs, dst,
+		if (!GetTs(ieee, (struct ts_common_info **)&ts, dst,
 			   (u8)pDelBaParamSet->field.tid, RX_DIR, false)) {
 			netdev_warn(ieee->dev,
 				    "%s(): can't get TS for RXTS. dst:%pM TID:%d\n",
@@ -441,7 +441,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 			return -1;
 		}
 
-		rx_ts_delete_ba(ieee, pRxTs);
+		rx_ts_delete_ba(ieee, ts);
 	} else {
 		struct tx_ts_record *pTxTs;
 
-- 
2.41.0

