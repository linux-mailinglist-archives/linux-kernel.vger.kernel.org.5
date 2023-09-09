Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4300799A61
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 20:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238312AbjIISTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 14:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjIISTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 14:19:38 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C54E1B1
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 11:19:33 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401ce65dfc4so9127425e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 11:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694283572; x=1694888372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ssVWE9PyVo0MJDIoiWo0h0qTjLlpWHSLjGBywkF+JnM=;
        b=lRyus6n9Kmg4hMdhYB4x9rUuwcwMXcIm4DMa/lwEr+SkR2h0s+AKd07xUB0gfEpCiG
         70KaXcL6hLAYxigy/afLfipFCp85cYFHn5Y9c93AVAsJUZHvmEfgTNLoK23+CoeBg7FM
         oegSVOceeiv5DjQd9vP36uI8M2HbRroH4NbTo8A+X8+O0ZIX3dqAgAL9rUMBYCIGC0gT
         W0eBa2yccKwtCgJMdJzHTDcuLyR++bohf8kZLuIqhqd/R3KeBZbREnwT9zweUBWYm6mR
         D6EVxn4Qrg5W5gymU1VL3XG0LoceWD2+6SdSxnSpoP4KgPLYZ0eW187JxKJvWW3gNEmV
         miKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694283572; x=1694888372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssVWE9PyVo0MJDIoiWo0h0qTjLlpWHSLjGBywkF+JnM=;
        b=WXuPfHUXLF7GpcnXFanh6+V7twSwQKTVW6dbGgKRn/AqNsUhpKCOm9KAfwENvZZfMA
         ptzJbOSm+/q6JLbojqY0k50XHFiaw1nkEkHbYuZBAo1nvvsgtlQLdPTRTrq7OhnDSdOB
         HuaFTYJPogO2uBM7A+t+OFKtrLXQIB1wQgrHHJ8tGKvE6w1+UJTnOeHCcbxJCuxQlAcx
         uVRhV/SjRo1Yd4duyPlain3AJXflAXfCxgXiuxIdWDEHGX+L4DcALOfbFRmCwPr+4wOb
         PFz3n+gW27skj11iAK3/cBtG8mWdccTsEHEiUpVi6imaBX73t9k67CpvMKijQ8y6W6/q
         NOyw==
X-Gm-Message-State: AOJu0Yws1oV9l+QeGij0/rnVLp9ZJR2nSFKXmKSS47Kn/OTReVG0ATxj
        vGpWgKMdyy/ge78RIe+d3I7F4q8+jkpchg==
X-Google-Smtp-Source: AGHT+IEhuPEY0HZVsNBEFRYiSMZ0IGtHD9bjAZpJ1rbS5hq35Mso0ccW4ZxJ0leRhLTYra4AhoiHIg==
X-Received: by 2002:a05:600c:3114:b0:3fe:d46a:ef4b with SMTP id g20-20020a05600c311400b003fed46aef4bmr5151459wmo.1.1694283571697;
        Sat, 09 Sep 2023 11:19:31 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b003fed8e12d62sm5242873wmm.27.2023.09.09.11.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 11:19:31 -0700 (PDT)
Date:   Sat, 9 Sep 2023 20:19:29 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] staging: rtl8192e: Remove useless equation in debug
 output
Message-ID: <34330df02f386b9e3b69baf582cb2933635867c4.1694282907.git.philipp.g.hortmann@gmail.com>
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

When "switch (WLAN_FC_GET_STYPE(le16_to_cpu(header->frame_ctl)))" results
in "case RTLLIB_STYPE_BEACON:" there is no need to calculate this again
inside "case" and when a frame is a beacon there is no need to print the
frame identifier again as it is explicit.
Same for PROBE RESPONSE and PROBE REQUEST. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 0e695b144b36..9f944eefa41e 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -2652,8 +2652,7 @@ static void rtllib_rx_mgt(struct rtllib_device *ieee,
 
 	switch (WLAN_FC_GET_STYPE(le16_to_cpu(header->frame_ctl))) {
 	case RTLLIB_STYPE_BEACON:
-		netdev_dbg(ieee->dev, "received BEACON (%d)\n",
-			   WLAN_FC_GET_STYPE(le16_to_cpu(header->frame_ctl)));
+		netdev_dbg(ieee->dev, "received BEACON\n");
 		rtllib_process_probe_response(
 				ieee, (struct rtllib_probe_response *)header,
 				stats);
@@ -2666,14 +2665,12 @@ static void rtllib_rx_mgt(struct rtllib_device *ieee,
 		break;
 
 	case RTLLIB_STYPE_PROBE_RESP:
-		netdev_dbg(ieee->dev, "received PROBE RESPONSE (%d)\n",
-			   WLAN_FC_GET_STYPE(le16_to_cpu(header->frame_ctl)));
+		netdev_dbg(ieee->dev, "received PROBE RESPONSE\n");
 		rtllib_process_probe_response(ieee,
 			      (struct rtllib_probe_response *)header, stats);
 		break;
 	case RTLLIB_STYPE_PROBE_REQ:
-		netdev_dbg(ieee->dev, "received PROBE REQUEST (%d)\n",
-			   WLAN_FC_GET_STYPE(le16_to_cpu(header->frame_ctl)));
+		netdev_dbg(ieee->dev, "received PROBE REQUEST\n");
 		if ((ieee->softmac_features & IEEE_SOFTMAC_PROBERS) &&
 		    (ieee->iw_mode == IW_MODE_ADHOC &&
 		    ieee->link_state == MAC80211_LINKED))
-- 
2.41.0

