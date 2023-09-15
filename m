Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96977A2351
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbjIOQKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236444AbjIOQKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:10:19 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6645B10FA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:09:53 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31ff6420f73so90051f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694794192; x=1695398992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ruUqNqg+klzqg8DIZkV1fJ8TK4DrEnEOQmLelzItfAk=;
        b=KW5hnRuacPrq6/XnKXlUMjVhjE1P43aDF9JEnYVuHmkbhT5AtQily4pJjHLBq4esbn
         QGCHITyof1fIzpqUWN5xGxSvquRTezvZR5orNpWf3D8GaZbV6XKlFdc1MqiP+82GSpM8
         h0LRH0XArJ30hYbI+mVB3tvEDA6Z92wUaFtl+r1mtW8NnUg7alnI2dBuMiTTjULHfgR2
         uPsm5no3t8DO6Wcvh7iY7weH3dTIU7EBDhrCiY1S/WwTetmtQmRNpk9KZL31wSUfy2iG
         vG0eDba8Xb9kS0J48emWzT5ly718PtL8VOEqDFXgbZcLjQIrLbxsKyLQlZHSqeooh2aq
         V0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694794192; x=1695398992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruUqNqg+klzqg8DIZkV1fJ8TK4DrEnEOQmLelzItfAk=;
        b=X34CBO69dHijdqoXuufYphPIdPDq2M3IdHwOqeDuxic60ydaaQ/Pq5QohwkrkQ2lNs
         Q/FH+JwPKh4bpd4BFTs7vH99MtSXGy6aTJuAGlEpRJSxuR5IUFQJPYmlRdaQ/NB6aWmB
         yz2I4JPKoNafwGpJTvXx1Fr+m/G8k1bgDm76MvvVyIyMkiZ9JWg49ecLTdE7IS596jL/
         cq9s7/gJYJklmP618rUP+95Jn5T0vUcnsumdDg40GfIIErntx4eVQLC9URURWTDJuVsa
         pxQ6j3C2qJ+CmzzR1YmxsSqEuJFitcS2nH2591+wy4nV6y9KEfBgyjLBtQ14id55kqOy
         7GqA==
X-Gm-Message-State: AOJu0Yzp7JQ9Og/8wYVVfX7eX3I2liYu4rLBIf33cdT93X5U0YIUfhXH
        ToxAQdnyrzuS4j64K901MCc=
X-Google-Smtp-Source: AGHT+IHLFCFEhdew0V6dS/n9rKcDRpe1AoatqJjezrn3Dd+4f1btZ1AZCX6b0W0XIWWgWujXhx8iog==
X-Received: by 2002:a05:6000:110b:b0:31f:af30:1bd4 with SMTP id z11-20020a056000110b00b0031faf301bd4mr1814580wrw.1.1694794191738;
        Fri, 15 Sep 2023 09:09:51 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id s10-20020a5d510a000000b0031971ab70c9sm4811105wrt.73.2023.09.15.09.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 09:09:51 -0700 (PDT)
Date:   Fri, 15 Sep 2023 18:09:50 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 15/16] staging: rtl8192e: Replace usage of RTLLIB_FCTL_DSTODS
 with function
Message-ID: <69f72a352b8129bcc6610c1355a41d966abf24d8.1694792595.git.philipp.g.hortmann@gmail.com>
References: <cover.1694792595.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694792595.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace usage of RTLLIB_FCTL_DSTODS with function ieee80211_has_a4() to
avoid proprietary code and to increase readability. To achieve this goal
it was required to change a parameter of function rtllib_rx_data_filter().

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h            |  1 -
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c |  3 +--
 drivers/staging/rtl8192e/rtllib_rx.c         | 14 +++++++-------
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 47156eb8f46b..9179c3c14ab3 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -338,7 +338,6 @@ enum rt_op_mode {
 #define RTLLIB_FCTL_FRAMETYPE	0x00fc
 #define RTLLIB_FCTL_TODS		0x0100
 #define RTLLIB_FCTL_FROMDS		0x0200
-#define RTLLIB_FCTL_DSTODS		0x0300
 #define RTLLIB_FCTL_MOREFRAGS	0x0400
 #define RTLLIB_FCTL_RETRY		0x0800
 #define RTLLIB_FCTL_PM		0x1000
diff --git a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
index 8e4514cc132c..5621261d66b9 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
@@ -92,8 +92,7 @@ static int ccmp_init_iv_and_aad(struct ieee80211_hdr *hdr,
 	int a4_included, qc_included;
 
 	fc = le16_to_cpu(hdr->frame_control);
-	a4_included = ((fc & (RTLLIB_FCTL_TODS | RTLLIB_FCTL_FROMDS)) ==
-		       (RTLLIB_FCTL_TODS | RTLLIB_FCTL_FROMDS));
+	a4_included = ieee80211_has_a4(hdr->frame_control);
 
 	qc_included = ((WLAN_FC_GET_TYPE(fc) == RTLLIB_FTYPE_DATA) &&
 		       (WLAN_FC_GET_STYPE(fc) & 0x80));
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 4d8c3869eb83..ef042dfd89cb 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -97,7 +97,7 @@ rtllib_frag_cache_get(struct rtllib_device *ieee,
 	struct ieee80211_qos_hdr_4addr *hdr_4addrqos;
 	u8 tid;
 
-	if (((fc & RTLLIB_FCTL_DSTODS) == RTLLIB_FCTL_DSTODS) &&
+	if (ieee80211_has_a4(hdr->frame_control) &&
 	    RTLLIB_QOS_HAS_SEQ(fc)) {
 		hdr_4addrqos = (struct ieee80211_qos_hdr_4addr *)hdr;
 		tid = le16_to_cpu(hdr_4addrqos->qos_ctrl) & RTLLIB_QCTL_TID;
@@ -166,7 +166,7 @@ static int rtllib_frag_cache_invalidate(struct rtllib_device *ieee,
 	struct ieee80211_qos_hdr_4addr *hdr_4addrqos;
 	u8 tid;
 
-	if (((fc & RTLLIB_FCTL_DSTODS) == RTLLIB_FCTL_DSTODS) &&
+	if (ieee80211_has_a4(hdr->frame_control) &&
 	    RTLLIB_QOS_HAS_SEQ(fc)) {
 		hdr_4addrqos = (struct ieee80211_qos_hdr_4addr *)hdr;
 		tid = le16_to_cpu(hdr_4addrqos->qos_ctrl) & RTLLIB_QCTL_TID;
@@ -359,7 +359,7 @@ static int is_duplicate_packet(struct rtllib_device *ieee,
 	struct ieee80211_qos_hdr_4addr *hdr_4addrqos;
 	u8 tid;
 
-	if (((fc & RTLLIB_FCTL_DSTODS) == RTLLIB_FCTL_DSTODS) &&
+	if (ieee80211_has_a4(header->frame_control) &&
 	    RTLLIB_QOS_HAS_SEQ(fc)) {
 		hdr_4addrqos = (struct ieee80211_qos_hdr_4addr *)header;
 		tid = le16_to_cpu(hdr_4addrqos->qos_ctrl) & RTLLIB_QCTL_TID;
@@ -968,16 +968,16 @@ static void rtllib_rx_extract_addr(struct rtllib_device *ieee,
 	}
 }
 
-static int rtllib_rx_data_filter(struct rtllib_device *ieee, u16 fc,
+static int rtllib_rx_data_filter(struct rtllib_device *ieee, struct ieee80211_hdr *hdr,
 				 u8 *dst, u8 *src, u8 *bssid, u8 *addr2)
 {
 	u8 type, stype;
-
+	u16 fc = le16_to_cpu(hdr->frame_control);
 	type = WLAN_FC_GET_TYPE(fc);
 	stype = WLAN_FC_GET_STYPE(fc);
 
 	/* Filter frames from different BSS */
-	if (((fc & RTLLIB_FCTL_DSTODS) != RTLLIB_FCTL_DSTODS) &&
+	if (ieee80211_has_a4(hdr->frame_control) &&
 	    !ether_addr_equal(ieee->current_network.bssid, bssid) &&
 	    !is_zero_ether_addr(ieee->current_network.bssid)) {
 		return -1;
@@ -1341,7 +1341,7 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 	rtllib_rx_extract_addr(ieee, hdr, dst, src, bssid);
 
 	/* Filter Data frames */
-	ret = rtllib_rx_data_filter(ieee, fc, dst, src, bssid, hdr->addr2);
+	ret = rtllib_rx_data_filter(ieee, hdr, dst, src, bssid, hdr->addr2);
 	if (ret < 0)
 		goto rx_dropped;
 
-- 
2.42.0

