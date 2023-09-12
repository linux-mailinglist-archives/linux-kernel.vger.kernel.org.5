Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3E079D989
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbjILT2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbjILT2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:28:13 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C8BE4B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 12:28:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31c49de7a41so898051f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 12:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694546888; x=1695151688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hAqNl41hKkSBMm9EVB1yezgOtRcp8ANCKow1rmKoN+M=;
        b=K1qKbX3whTuI+m2Ch4HVSfWwzCZCbx50QsxocsLC+wbmxLPUSepEQNIsYQgC0Rwmjc
         u8kM3zDfv30XZTq9OdXCEaD6ZZaOrO5LzeC47qaLHIV5GUtvdFdKjZocGiRZiBVx/mlI
         bFRlr20m2+7n/thJROjZKluaOXoalREQTgcDFNG520PANzDkkOqNyY1ANFVDlyneQewE
         zNoYPVwd0cq/bCZAUw4uy6vVJpzD8yQ5kjNRsKLdEHBGaAqxK+uU4IODCrth5P74I9AV
         vNUI8Eu/mbuW8VYki5sLszB7X11WJD+iFB32/+TbWy5AgypSVeL+MMJ49nK5mrUXQh4s
         5Y4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694546888; x=1695151688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAqNl41hKkSBMm9EVB1yezgOtRcp8ANCKow1rmKoN+M=;
        b=usdfiIc/be6Mq9nawFG8qZh9CUKd8xtkWgM3Frt8KR0SvScap+Bnjl0TWqdWslP9C5
         xDzLdOjaIFXVhUVjNQZ1BNFX8VKcpNcz2XR8egk6Cb3cZf3zYxCrU3yQm8Ke3iq6UJzH
         8MASd7g6FYuXhHxaef3YIyEuEHqebWwTKtGgFIQ9zpcUKBzUQ65LRdJiq43gyeWk626Q
         Xz7VaCz0fN+VibFHDf3l24ObdQWhsyL4hfQuYaMesXrdbUSn9cSjdNtb1fiyMkcAJIU7
         XzjWWYvBsLKEXVJDUYA+LFaCdkjrc9QWqKhtRom8P2j2cDWdmTXMcf3RtB5ENwpuMqww
         1tqg==
X-Gm-Message-State: AOJu0YwIZO1ZBCqhpDOFwkJEHUxnoRxd6ElW2C5YYHfvWlB8+RX4WMxk
        A+SEBZK+PkfVL+JuQgiSo+/foVSl8W/RCw==
X-Google-Smtp-Source: AGHT+IE6aWFay8iwoc5rAmKKGWqsGBuYZKDYNFrhiEZwq8A9yc4cn2BiUDQDvirb6qWqzD25kSC7AA==
X-Received: by 2002:a5d:4001:0:b0:31a:e772:ddf9 with SMTP id n1-20020a5d4001000000b0031ae772ddf9mr301620wrp.4.1694546887726;
        Tue, 12 Sep 2023 12:28:07 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id o14-20020adfeace000000b003197869bcd7sm13517861wrn.13.2023.09.12.12.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 12:28:07 -0700 (PDT)
Date:   Tue, 12 Sep 2023 21:28:05 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] staging: rtl8192e: Remove useless equation in debug
 output
Message-ID: <f3c8deddac66d11c41ba720e4048aba37e41e885.1694546300.git.philipp.g.hortmann@gmail.com>
References: <cover.1694546300.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694546300.git.philipp.g.hortmann@gmail.com>
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
v1->v2: Unchanged
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
2.42.0

