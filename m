Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D907B599D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbjJBRyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238607AbjJBRyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:54:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E97CE4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:54:00 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3233799e7b8so14439f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 10:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696269239; x=1696874039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=76iRx49ZBjTzS3/ihrdEmUB6JBE+9sFOl4sgt+UhoLQ=;
        b=lAmREfscTE1emigtGjrRuaD8nRXe6x6R6JZEvedk7T9aFv1qZIQokQkjgD3rf2jpwE
         BdSCRN61lEusLOy1AVPGw/yUN0w/aYqZuulUcJtX8VSjdaeKs/LaDdxnCnzNHdWbt0z1
         HUpnjtE8iQoQOud11QhELFP4IiRhMhVnnzpKPpd8YtwBa4/6seSd+xCy28kF2Kf9VqNh
         OIH3/DoAiZ3Mxg+z/JZF4ojGSHSXDHnJdJewa0JTnmwObHwR7G6YDDcfDeiNAL4Qmqhv
         dUpFBhXcjIOpb9ZlFkdDrmyF3D9YYU/DFC/XNMlCKcM+ndzmFIjmIFSNa8TNK6VPQiIL
         E9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696269239; x=1696874039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76iRx49ZBjTzS3/ihrdEmUB6JBE+9sFOl4sgt+UhoLQ=;
        b=iYP6rmy525RYMPEZX75Yj/1sAy7TfA4iGMFyb3goqEOyRFgGjuilF8vHEqsOUtjQmS
         9Msmtnws132fUQEomX8Ka3aQjMXd+VA+7hIKQXPifqDiylyIyMejECfc68R55Aaoelx6
         KO86PiK5J8L8j/ZGrgI0NVyfHR5B0txac1I+IrJNEbiOj/9cxHigUjVp/qoDJECmzQ7v
         Lh/sXeCLTYzip5175OwVw6TK0SqEfwQ97CL87jfpnXi9TbCdwl2vnqq5QabnJV8cNaxT
         c8XfpH+RIqhPjqrNapzxjICSZCUZ22HB6Akda0eRXZ5eal2tTQ+pMtGr20Jv0PmvJLFB
         0OBQ==
X-Gm-Message-State: AOJu0YxEb3vDb3ZtRXSM7P9nkH30aykcnpFBmh2/TbHFE8AL6U6sKIbi
        GjvX3RGPvZzpPqS/89BdLoY=
X-Google-Smtp-Source: AGHT+IEqGg5Mv/6tMKOZxA4ggAtVSs5nKOTnduDKRqzJPyS9+sVH5HpcAbGEOT/LL84pTdI3LN+dYA==
X-Received: by 2002:adf:f04b:0:b0:317:630d:1e8e with SMTP id t11-20020adff04b000000b00317630d1e8emr10079014wro.2.1696269238704;
        Mon, 02 Oct 2023 10:53:58 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id z19-20020a1709063ad300b009a1a653770bsm17455916ejd.87.2023.10.02.10.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:53:58 -0700 (PDT)
Date:   Mon, 2 Oct 2023 19:53:56 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] staging: rtl8192e: Remove constant parameter from
 rtllib_stop_protocol()
Message-ID: <7eebcd3a8637b686331e34532136df3e7760f869.1696266965.git.philipp.g.hortmann@gmail.com>
References: <cover.1696266964.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696266964.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove constant parameter shutdown of function rtllib_stop_protocol().
shutdown is always true. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h            |  2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c    | 19 ++++++++-----------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c |  6 +++---
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 65f29afa81be..ff1728d1824d 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1698,7 +1698,7 @@ void rtllib_start_scan_syncro(struct rtllib_device *ieee);
 void rtllib_sta_ps_send_null_frame(struct rtllib_device *ieee, short pwr);
 void rtllib_sta_ps_send_pspoll_frame(struct rtllib_device *ieee);
 void rtllib_start_protocol(struct rtllib_device *ieee);
-void rtllib_stop_protocol(struct rtllib_device *ieee, u8 shutdown);
+void rtllib_stop_protocol(struct rtllib_device *ieee);
 
 void rtllib_EnableNetMonitorMode(struct net_device *dev, bool bInitState);
 void rtllib_DisableNetMonitorMode(struct net_device *dev, bool bInitState);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 1a086f0ff10d..79a62bd9a297 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2283,21 +2283,19 @@ void rtllib_softmac_stop_protocol(struct rtllib_device *ieee)
 {
 	rtllib_stop_scan_syncro(ieee);
 	mutex_lock(&ieee->wx_mutex);
-	rtllib_stop_protocol(ieee, true);
+	rtllib_stop_protocol(ieee);
 	mutex_unlock(&ieee->wx_mutex);
 }
 EXPORT_SYMBOL(rtllib_softmac_stop_protocol);
 
-void rtllib_stop_protocol(struct rtllib_device *ieee, u8 shutdown)
+void rtllib_stop_protocol(struct rtllib_device *ieee)
 {
 	if (!ieee->proto_started)
 		return;
 
-	if (shutdown) {
-		ieee->proto_started = 0;
-		ieee->proto_stoppping = 1;
-		ieee->rtllib_ips_leave(ieee->dev);
-	}
+	ieee->proto_started = 0;
+	ieee->proto_stoppping = 1;
+	ieee->rtllib_ips_leave(ieee->dev);
 
 	del_timer_sync(&ieee->associate_timer);
 	mutex_unlock(&ieee->wx_mutex);
@@ -2315,10 +2313,9 @@ void rtllib_stop_protocol(struct rtllib_device *ieee, u8 shutdown)
 		rtllib_disassociate(ieee);
 	}
 
-	if (shutdown) {
-		RemoveAllTS(ieee);
-		ieee->proto_stoppping = 0;
-	}
+	RemoveAllTS(ieee);
+	ieee->proto_stoppping = 0;
+
 	kfree(ieee->assocreq_ies);
 	ieee->assocreq_ies = NULL;
 	ieee->assocreq_ies_len = 0;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 3c7c0f07ab0b..e9da566646c5 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -134,7 +134,7 @@ int rtllib_wx_set_wap(struct rtllib_device *ieee,
 	}
 
 	if (ifup)
-		rtllib_stop_protocol(ieee, true);
+		rtllib_stop_protocol(ieee);
 
 	/* just to avoid to give inconsistent infos in the
 	 * get wx method. not really needed otherwise
@@ -277,7 +277,7 @@ int rtllib_wx_set_mode(struct rtllib_device *ieee, struct iw_request_info *a,
 	if (!ieee->proto_started) {
 		ieee->iw_mode = wrqu->mode;
 	} else {
-		rtllib_stop_protocol(ieee, true);
+		rtllib_stop_protocol(ieee);
 		ieee->iw_mode = wrqu->mode;
 		rtllib_start_protocol(ieee);
 	}
@@ -401,7 +401,7 @@ int rtllib_wx_set_essid(struct rtllib_device *ieee,
 	}
 
 	if (proto_started)
-		rtllib_stop_protocol(ieee, true);
+		rtllib_stop_protocol(ieee);
 
 	/* this is just to be sure that the GET wx callback
 	 * has consistent infos. not needed otherwise
-- 
2.42.0

