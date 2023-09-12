Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BCB79D991
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237682AbjILT3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbjILT3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:29:00 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B60170B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 12:28:56 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3175e1bb38cso972302f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 12:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694546935; x=1695151735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f9QOFf4TBJHbEExXLmv/GmW03P0dycuuh5jJHz9YFN0=;
        b=nnFJKFcJOPKI93ZMgy8MqeGx/0bDTETSX+8fSqm9Mx2oGi1WrAQdZgS9m8KDv2zy6W
         haX6Yg7HCIMPBYFoHsRifOYQ+HRhcvC7yk/3Ic2QI+LjWf1SNYM52yQN7J9qGrU7TnAp
         Pa1GzXk5nPZxQ0uj5JCl/xiFKvTzJLpQwmQF7qBD//SxlKpr9rgCf/iuT8Dw6Sb8HIue
         z6tcbo1ypolB4vclSSwxPLxFYdDN/15Dqinn94q/SI6axVs9/6RJMhDm+U/XHEvp2iUf
         CEf3yN97UuA52EtK9MhF1jTVI6jqdFOKYTiSR2w9uYCCqHmH6oyTMRkJak/MCNyGc/KV
         dxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694546935; x=1695151735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9QOFf4TBJHbEExXLmv/GmW03P0dycuuh5jJHz9YFN0=;
        b=Yh/Eqir3CeyqNyBnM5Wf1Y1Rly0ICJR6zIHqHcYyzwy1fp3eVoEa3F5rQdJH7OE8Op
         OF9NjrZTOL5TejqtYFkMY61DTRkNeH4g1by+Kdu2rnpysVDH6F/z/TmRgcPyIwtFeuZ6
         X9n/u1ED8w/IcDG7EbyGlvshEmIuspqrkX4Awm708XDK8JdulO0uX7NJX0UmdZK15i/J
         dnKTA5pvojgU3wgtCktUrzB+P8wbgx3sWS5GxHJuD69azeDoQ5bC8oVgYet+HtgOIK2l
         S8GpI9f+p53rUoXz06OwP3Xr20SIcXUjHdUx+zv3G6+S2ZPWuLIwFxx6BDSxobNkjxit
         b8DA==
X-Gm-Message-State: AOJu0Yyh98sbyIh6pNI6KhUgEJdcv+nKOJGE9FdRC8NYJxOpg1cXGHP8
        Jv//eAbtyMYJOqZMy0Tc1rY=
X-Google-Smtp-Source: AGHT+IEWSM+SW8BpvQulP8HrwUyJjbRtAlSQeT8oECnzVT6aSE1Tt/ISTlh/Mhnt2k+SMZUB6+HQww==
X-Received: by 2002:a5d:5651:0:b0:31a:e21f:37ef with SMTP id j17-20020a5d5651000000b0031ae21f37efmr392517wrw.3.1694546934906;
        Tue, 12 Sep 2023 12:28:54 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id q15-20020adfcd8f000000b0031753073abcsm13509097wrj.36.2023.09.12.12.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 12:28:54 -0700 (PDT)
Date:   Tue, 12 Sep 2023 21:28:53 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] staging: rtl8192e: Remove rtllib_get_payload()
Message-ID: <3ef288fb819f50da3eb9291522067babaa57f532.1694546301.git.philipp.g.hortmann@gmail.com>
References: <cover.1694546300.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694546300.git.philipp.g.hortmann@gmail.com>
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
v1->v2: Unchanged
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
2.42.0

