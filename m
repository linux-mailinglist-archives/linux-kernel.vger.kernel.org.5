Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1B879D98A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbjILT2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbjILT2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:28:20 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE42810D0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 12:28:14 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-402ba03c754so17013495e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 12:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694546893; x=1695151693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QexNkjG2mXAQpwTtJAKwU4X2ozG1nmIWtcTUMqxmunQ=;
        b=bql/TAt9pS+hQvTz9NMbz8jFK4Syr4n0GBcSMGxrn5R3ba/SIhpklS3snCpyaTggn2
         jp1erRtGEtVkh7rmKA4lGG1Fh7J5Un46rCU9pygcXRyZBAQlLdlr763gv9J0JkKMcrbh
         +g7bta1yzB/NohT4H+fCYV4orbuWBOrO49/W0jLlhQbIfDI7rTU2hcYhbdiLsJAg565Q
         Dt40+PqpR8a0NXWrnqY0O19U6gV/0aqg+87ofxnkm2Nu3Fzpm1+lubWd52DZvrERUVQQ
         TBSRFEu2qHnMzvWtmUCw3HpLGMusgGeJnyYFM8TN/FtQIqPjI91LuVm5QamDiXR3tFvE
         5OOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694546893; x=1695151693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QexNkjG2mXAQpwTtJAKwU4X2ozG1nmIWtcTUMqxmunQ=;
        b=IUL/sBFfk0m5q5xVh6zundVA1V/p1gfFpk/y5MIsnjp7P69Y1f12sQEiTcnTRx0BL6
         FKBQ8mjUqVZqk/Ma9b3Pgr7pQOM5uKubqBoWKH2N9AeKfz6gqtLOy6fiHl0rbhTYIkBP
         KHEE4r6+abLW8Y7uuEVu0WV+L8Sam7gWJ34I+mEZ7L/OY0vplfjjbKuy07DBk5OuWpAc
         3KAlu3cpV3hyFb5noNJKojqNXYa65igShVpg77wylV2VQ5JOD8wiXSrJLg3/FiS9u2ZO
         115K5GZH6GtAe0NSl0Y/aP/XL7upXlq2VJn50XtYn/sxs9GomiaAnQ380B+PuRBjr7zz
         zf2g==
X-Gm-Message-State: AOJu0YwpWtjLOv5pKhLaa7lnyXLSfxH7KozHcYpiEAnb+dzn354n7770
        DKjzEowyXwrvW+WgyngSjn4=
X-Google-Smtp-Source: AGHT+IH68pBqYN80DtFu8zyIcWe17Nc6RH+PYlPdLDPrbaEQOisy1yO0gD54tU+ecnJ1j9qp+WCo1w==
X-Received: by 2002:a05:600c:3b9b:b0:3fe:dd78:8fbc with SMTP id n27-20020a05600c3b9b00b003fedd788fbcmr298664wms.3.1694546893101;
        Tue, 12 Sep 2023 12:28:13 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c028c00b003fee6e170f9sm13702848wmk.45.2023.09.12.12.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 12:28:12 -0700 (PDT)
Date:   Tue, 12 Sep 2023 21:28:11 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] staging: rtl8192e: Use standard ieee80211 function in
 rtllib_rx_mgt()
Message-ID: <26cb0a7758186090a618a134c21e237594bbc525.1694546300.git.philipp.g.hortmann@gmail.com>
References: <cover.1694546300.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694546300.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace WLAN_FC_GET_STYPE(le16_to_cpu(header->frame_ctl)) and comparison
with standard function to avoid proprietary code and to increase
readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
v1->v2: Unchanged
---
 drivers/staging/rtl8192e/rtllib_rx.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 9f944eefa41e..108238aa61d9 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -2644,14 +2644,11 @@ static void rtllib_rx_mgt(struct rtllib_device *ieee,
 {
 	struct rtllib_hdr_4addr *header = (struct rtllib_hdr_4addr *)skb->data;
 
-	if ((WLAN_FC_GET_STYPE(le16_to_cpu(header->frame_ctl)) !=
-	    RTLLIB_STYPE_PROBE_RESP) &&
-	    (WLAN_FC_GET_STYPE(le16_to_cpu(header->frame_ctl)) !=
-	    RTLLIB_STYPE_BEACON))
+	if (!ieee80211_is_probe_resp(header->frame_ctl) &&
+	    (!ieee80211_is_beacon(header->frame_ctl)))
 		ieee->last_rx_ps_time = jiffies;
 
-	switch (WLAN_FC_GET_STYPE(le16_to_cpu(header->frame_ctl))) {
-	case RTLLIB_STYPE_BEACON:
+	if (ieee80211_is_beacon(header->frame_ctl)) {
 		netdev_dbg(ieee->dev, "received BEACON\n");
 		rtllib_process_probe_response(
 				ieee, (struct rtllib_probe_response *)header,
@@ -2661,20 +2658,15 @@ static void rtllib_rx_mgt(struct rtllib_device *ieee,
 		    ieee->iw_mode == IW_MODE_INFRA &&
 		    ieee->link_state == MAC80211_LINKED))
 			schedule_work(&ieee->ps_task);
-
-		break;
-
-	case RTLLIB_STYPE_PROBE_RESP:
+	} else if (ieee80211_is_probe_resp(header->frame_ctl)) {
 		netdev_dbg(ieee->dev, "received PROBE RESPONSE\n");
 		rtllib_process_probe_response(ieee,
 			      (struct rtllib_probe_response *)header, stats);
-		break;
-	case RTLLIB_STYPE_PROBE_REQ:
+	} else if (ieee80211_is_probe_req(header->frame_ctl)) {
 		netdev_dbg(ieee->dev, "received PROBE REQUEST\n");
 		if ((ieee->softmac_features & IEEE_SOFTMAC_PROBERS) &&
 		    (ieee->iw_mode == IW_MODE_ADHOC &&
 		    ieee->link_state == MAC80211_LINKED))
 			rtllib_rx_probe_rq(ieee, skb);
-		break;
 	}
 }
-- 
2.42.0

