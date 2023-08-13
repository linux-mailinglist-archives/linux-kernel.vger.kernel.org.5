Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0188377A523
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 08:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjHMGhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 02:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHMGhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 02:37:02 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AFE19A3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 23:36:52 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3177d3bdfb3so682987f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 23:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691908611; x=1692513411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yafTvXOw9qDIGS3IGLglUTI/sT6XCgYCEECZPdC93mM=;
        b=SpndYIL5xHz95OsitFo/24m0F5jbfwCYwe5HO3nITx7B6LHHoRBmleN2Pn/ZOgt91c
         f6xm+iVH69ErRScFz0ZisVdpoavkRTpV9Cnqm0wRhIGbKEVhXtrF0BOcGEKqIGSfN6QQ
         fufTNJAdTmZbApS39fWGQEBMjcTy1aiPWByzvLd7nZFWRmZs8kVFSxbOHLfeU4RtnpxX
         k1MAKcGCFtB6iAn7F/wMOGLo9roc2UZ8l9i4KQ1Ub+N+jP7gm91zLk8pfb/shAoJppea
         dkKLYAMvB0uqjW1ADg4Dl2OqNHrCRow+/rtfpBAxGtGVq5OWM5KZlFpf5r7TW32Atwon
         zFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691908611; x=1692513411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yafTvXOw9qDIGS3IGLglUTI/sT6XCgYCEECZPdC93mM=;
        b=kwMpajRG2s1CQTl9tcVen0YC5ptrAGApZyiJzBTsLBsp2D1+w+s2RycbiGkFlB2XeO
         b1X/MfL7iibX9d8vEGF7/LspfvdXc4oehO54fNqklRmn75E16/mIKHeDIvDXGXO8Q6ee
         j/7bI19p3b+cqwKwY9KnBVx9tLK+nUdUxKYpIGF33hSI0vTtfTd/SEF6e2+RR1U3PD14
         fXEneT/ugRDHyjdlkqxtcGaubgq7hmqC0XnyCe3h3faO64DHt/D4lk6mrjr+PxWST4E1
         ZVHifRORKDMK0i2F71l+x4XpQpjymjzZuMlUvjBIONlx/+7hGWdvF9grktq2Fpr9Idtu
         NXZw==
X-Gm-Message-State: AOJu0Yxb+lQlOLs04WPI4OUaqUX7IgqTgdTg77UUpmXKfRHCF590iTq8
        qcMeFX3MOBXkPkisIPNuCYg=
X-Google-Smtp-Source: AGHT+IEqm6+RA5GwptemXwxHBIgaAKqI9h+sx0dE6FHQDA2UxR5Z78pHLD4svgwEvyUCbS0pKpmDtA==
X-Received: by 2002:a05:600c:5111:b0:3fe:5228:b78c with SMTP id o17-20020a05600c511100b003fe5228b78cmr6279334wms.1.1691908610821;
        Sat, 12 Aug 2023 23:36:50 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id z5-20020a7bc7c5000000b003fbe4cecc3bsm13152437wmk.16.2023.08.12.23.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 23:36:50 -0700 (PDT)
Date:   Sun, 13 Aug 2023 08:36:48 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] staging: rtl8192e: Remove unsupported mode IW_MODE_MESH
Message-ID: <54230361abba9f33827eac9bf5074dd9f62d787b.1691908402.git.philipp.g.hortmann@gmail.com>
References: <cover.1691908402.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691908402.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tasklet irq_rx_tasklet is scheduled when hw is receiving frames. Function
_rtl92e_irq_rx_tasklet() is then called which calls then
_rtl92e_rx_normal(). In _rtl92e_rx_normal() all frames are processed by
rtllib_rx(). When ieee->iw_mode is IW_MODE_MESH the function returns
0. The calling function then calls: dev_kfree_skb_any() which clears
the skb. So the driver clears all packets received in this mode. Remove
dead code in mode IW_MODE_MESH.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h    |  4 ----
 drivers/staging/rtl8192e/rtllib_rx.c | 20 ++++++++------------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 0c812eb02ba6..afde4812a221 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -89,10 +89,6 @@ static inline void *netdev_priv_rsl(struct net_device *dev)
 #define HIGH_QUEUE			     7
 #define BEACON_QUEUE			   8
 
-#ifndef IW_MODE_MESH
-#define IW_MODE_MESH			7
-#endif
-
 #define IE_CISCO_FLAG_POSITION		0x08
 #define SUPPORT_CKIP_MIC			0x08
 #define SUPPORT_CKIP_PK			0x10
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 322e603237d4..40e7bbb17c0d 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1013,17 +1013,15 @@ static int rtllib_rx_data_filter(struct rtllib_device *ieee, u16 fc,
 		}
 	}
 
-	if (ieee->iw_mode != IW_MODE_MESH) {
-		/* packets from our adapter are dropped (echo) */
-		if (!memcmp(src, ieee->dev->dev_addr, ETH_ALEN))
-			return -1;
+	/* packets from our adapter are dropped (echo) */
+	if (!memcmp(src, ieee->dev->dev_addr, ETH_ALEN))
+		return -1;
 
-		/* {broad,multi}cast packets to our BSS go through */
-		if (is_multicast_ether_addr(dst)) {
-			if (memcmp(bssid, ieee->current_network.bssid,
-				   ETH_ALEN))
-				return -1;
-		}
+	/* {broad,multi}cast packets to our BSS go through */
+	if (is_multicast_ether_addr(dst)) {
+		if (memcmp(bssid, ieee->current_network.bssid,
+			   ETH_ALEN))
+			return -1;
 	}
 	return 0;
 }
@@ -1499,8 +1497,6 @@ int rtllib_rx(struct rtllib_device *ieee, struct sk_buff *skb,
 	case IW_MODE_MONITOR:
 		ret = rtllib_rx_Monitor(ieee, skb, rx_stats);
 		break;
-	case IW_MODE_MESH:
-		break;
 	default:
 		netdev_info(ieee->dev, "%s: ERR iw mode!!!\n", __func__);
 		break;
-- 
2.41.0

