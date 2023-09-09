Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F239799A67
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 20:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239475AbjIISU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 14:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239802AbjIISU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 14:20:57 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D840910EB
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 11:20:26 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-401d61e9fecso9086115e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 11:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694283625; x=1694888425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jSwFvBNQ2AMCc4pS5SxTSy3TPsMqYhfRv4nOtRztjH4=;
        b=A4E3+0W5c0wJGiqtrd0SkQonhn6FTlMkEgosdJVOsmaQZxt9WrXxxgcfHEXuuv9GlS
         N2g3sHYqsSpzZv5votiwfrmq8Jc7c/Ewgxiy+kmHEGWAYOvCDxXTiMp8Yh6fmck+1lvz
         xfTcz1j5g11L1yW7IowPhglxaVnWixY9FA/jcTpLCMiLwOjexp305xNTMD0GXCaJD1i9
         MsrwuEjcvNVmyZGFvade4X6P4aOR46fCeJTPQz/TT2XfanE6WXf+tHzdC47YJMZ0BRb5
         juHXgHuhj/sQcvv1gGrnYzasG/Ak8DYHPY/JuJrJ4VyNEDZ6M/xQ/LWAez1ANyBQorQn
         Mf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694283625; x=1694888425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSwFvBNQ2AMCc4pS5SxTSy3TPsMqYhfRv4nOtRztjH4=;
        b=NMQR6UwTT7QCUVv5QJXXHz8xWlNQJ9KfEv16as9le3ARIKeTGR6HrkNiifhsAHPuEB
         2LgZvqdX8LykVLIG4QZiIwgY1mOmm3g4gShFVKP2VRtQYyF/7qSc537Q0tr2VDsHuinX
         Yfb1KSRBOL/ZYyXyBS82KxNDaMjZSqZNWF6g052MFbGzQhmEoaRrSYxCS96lnzb1ed3J
         2/bfqp6GUU5k1fy3YngZAiP4r6MC5kQrdN5nbCNgg3XLazrdTn2hWssT59C3Okj0g2NL
         lciLEYK9UqkoAZe+scodHlw1mYzNCRRaSeqAed3GFBcxPIfJj46WfxO/W9EIfSCs/rw+
         Bcig==
X-Gm-Message-State: AOJu0YxGNbEGVDU1Fj6KA5jN04/qjl9RIOUqZCG7RuERMzHiz4GesfwW
        7RlYM1yLkuw16d0kN+lLh+k=
X-Google-Smtp-Source: AGHT+IGYzLWM2bWX2MqgLDzD2AesQMqSmGp4wAHxG4NYNRnSG7mwZwWtOjrIvDOjnkEpxeFYr1ZZ5A==
X-Received: by 2002:a05:600c:3ba6:b0:3ff:8617:672b with SMTP id n38-20020a05600c3ba600b003ff8617672bmr4974721wms.2.1694283625280;
        Sat, 09 Sep 2023 11:20:25 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c4f1300b00403038d7652sm2192312wmq.39.2023.09.09.11.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 11:20:25 -0700 (PDT)
Date:   Sat, 9 Sep 2023 20:20:23 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] staging: rtl8192e: Remove rtllib_get_payload()
Message-ID: <cea7bba329e0dabdbf3d020abafd7e7c122587da.1694282907.git.philipp.g.hortmann@gmail.com>
References: <cover.1694282907.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694282907.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtllib_process_action() is only called in one place with management
frames. Frame is passed over to rtllib_get_payload() which passes it to
rtllib_get_hdrlen(). In rtllib_get_hdrlen() all management frames
return with hdrlen = RTLLIB_3ADDR_LEN. Therefore the switch in
rtllib_get_payload() is useless and dead code. The condition act == NULL
cannot occur and can also be removed. Then rtllib_hdr_2addr is not used
anymore and can be removed as well.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h         | 23 -----------------------
 drivers/staging/rtl8192e/rtllib_softmac.c |  9 +--------
 2 files changed, 1 insertion(+), 31 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 7dfb93f0590c..565a6e41b982 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -692,14 +692,6 @@ struct rtllib_hdr_1addr {
 	u8 payload[];
 } __packed;
 
-struct rtllib_hdr_2addr {
-	__le16 frame_ctl;
-	__le16 duration_id;
-	u8 addr1[ETH_ALEN];
-	u8 addr2[ETH_ALEN];
-	u8 payload[];
-} __packed;
-
 struct rtllib_hdr_3addr {
 	__le16 frame_ctl;
 	__le16 duration_id;
@@ -1781,21 +1773,6 @@ static inline int rtllib_get_hdrlen(u16 fc)
 	return hdrlen;
 }
 
-static inline u8 *rtllib_get_payload(struct rtllib_hdr *hdr)
-{
-	switch (rtllib_get_hdrlen(le16_to_cpu(hdr->frame_ctl))) {
-	case RTLLIB_1ADDR_LEN:
-		return ((struct rtllib_hdr_1addr *)hdr)->payload;
-	case RTLLIB_2ADDR_LEN:
-		return ((struct rtllib_hdr_2addr *)hdr)->payload;
-	case RTLLIB_3ADDR_LEN:
-		return ((struct rtllib_hdr_3addr *)hdr)->payload;
-	case RTLLIB_4ADDR_LEN:
-		return ((struct rtllib_hdr_4addr *)hdr)->payload;
-	}
-	return NULL;
-}
-
 static inline int rtllib_is_ofdm_rate(u8 rate)
 {
 	switch (rate & ~RTLLIB_BASIC_RATE_MASK) {
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 5de57331c1cf..904be0ef867f 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1921,16 +1921,9 @@ EXPORT_SYMBOL(rtllib_ps_tx_ack);
 static void rtllib_process_action(struct rtllib_device *ieee,
 				  struct sk_buff *skb)
 {
-	struct rtllib_hdr_3addr *header = (struct rtllib_hdr_3addr *)skb->data;
-	u8 *act = rtllib_get_payload((struct rtllib_hdr *)header);
+	u8 *act = skb->data + RTLLIB_3ADDR_LEN;
 	u8 category = 0;
 
-	if (act == NULL) {
-		netdev_warn(ieee->dev,
-			    "Error getting payload of action frame\n");
-		return;
-	}
-
 	category = *act;
 	act++;
 	switch (category) {
-- 
2.41.0

