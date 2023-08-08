Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF6277563F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjHIJUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjHIJUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:20:39 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956B01FD5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 02:20:38 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe5c0e5747so4005245e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 02:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691572837; x=1692177637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fjGqHv3jPMmZWsr3YV2CNvMjKi5/yIr3XsV/bXdCpjo=;
        b=nGfPM+uT4+rq1cirZDf2iqldyWLzu6R2ibKkwtCv5bHkF8uZi4owxiaB+YoPTFzu3T
         Z4xx9BgDsl7nQYr2hRXlkdHfCLeaAglUk9Y2PQFyXxX/nsBvFGtKs+BOsTwcZtSbBnVT
         Ej6VM5DgWwuMd0kjNTfBWVmP7jlwf1OGzumWPOn2xDePiKNfUEab79AvGOndurY5V993
         l1USvNo5ZiqDmM7bWlK8vepPqgfBTMoazApN/WEvC7MwSSKef/P6c7xhyNA7keOybupA
         g4VRcsBpp9l04/jPcKm5j6a18aQasp1TZ+ZfaryGu6dgFhVIu5NiQXR04v+gydU2ijx3
         S32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691572837; x=1692177637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fjGqHv3jPMmZWsr3YV2CNvMjKi5/yIr3XsV/bXdCpjo=;
        b=HiYnXkyvjfeHT6nA9Whn8VsikcwS7XXrmc2H03gbpvy4ajI2/a8Ed7lmb0cB37VHkV
         bkkawVLfj1MqGRKD0XAp1wAQJ6hXmPr3DJuTASb1Q+9zKMSgkwhSikXu4kAPZerqUtE4
         loNLfTqcwTs+AaYszuVHOTmOVUZIyAxS+vmWhfalPx93qSJYcsrNSPAOZQKR2jhnit8c
         jS7pMRTWFW1QdqZK6S0n5gEJA6Kslo4iJyXo5AosV1K2II9ysGRXXbl/gsOzrXtPH0Bc
         1kbreMKkuPBlg4MqsowMQM1sa5Xmohv9+WmeNUwAO/k9hX+WL9JgdhczH4uzZjKtSxjq
         lu7w==
X-Gm-Message-State: AOJu0YwcM5Qy+pXfmJoeieIBuRawi/jmIk3mIISHugh+G0aBn0ftb9Ge
        wUvftZHze3jK5DOAb3Ulnxk=
X-Google-Smtp-Source: AGHT+IH9WJcEmnbaXYTQ+Vh4luEUtFYqUswZdokF/AgUlI1zGZDW3R8XdxP78cDXg3DZKPfd9YQdiQ==
X-Received: by 2002:a05:600c:209:b0:3fe:215e:44a0 with SMTP id 9-20020a05600c020900b003fe215e44a0mr1923902wmi.18.1691572836802;
        Wed, 09 Aug 2023 02:20:36 -0700 (PDT)
Received: from archdev (pa5-84-91-151-142.netvisao.pt. [84.91.151.142])
        by smtp.gmail.com with ESMTPSA id q12-20020a7bce8c000000b003fe26244858sm1373182wmj.46.2023.08.09.02.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 02:20:36 -0700 (PDT)
Received: by archdev (Postfix, from userid 0)
        id 162541A40AE; Tue,  8 Aug 2023 23:14:24 +0100 (WEST)
From:   Diogo Silva <diogompaissilva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Diogo Silva <diogompaissilva@gmail.com>
Subject: [PATCH] staging: wlan-ng: cfg80211.c: removed unnecessary parenthesis to match coding style
Date:   Tue,  8 Aug 2023 23:12:36 +0100
Message-ID: <20230808221339.2667-1-diogompaissilva@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
 drivers/staging/wlan-ng/cfg80211.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index 471bb310176f..57c16afe8773 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -247,7 +247,7 @@ static int prism2_get_station(struct wiphy *wiphy, struct net_device *dev,
 
 	memset(sinfo, 0, sizeof(*sinfo));
 
-	if (!wlandev || (wlandev->msdstate != WLAN_MSD_RUNNING))
+	if (!wlandev || wlandev->msdstate != WLAN_MSD_RUNNING)
 		return -EOPNOTSUPP;
 
 	/* build request message */
@@ -351,8 +351,8 @@ static int prism2_scan(struct wiphy *wiphy,
 		msg2->bssindex.data = i;
 
 		result = p80211req_dorequest(wlandev, (u8 *)&msg2);
-		if ((result != 0) ||
-		    (msg2->resultcode.data != P80211ENUM_resultcode_success)) {
+		if (result != 0 ||
+		    msg2->resultcode.data != P80211ENUM_resultcode_success) {
 			break;
 		}
 
@@ -459,11 +459,11 @@ static int prism2_connect(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	/* Set the authorization */
-	if ((sme->auth_type == NL80211_AUTHTYPE_OPEN_SYSTEM) ||
-	    ((sme->auth_type == NL80211_AUTHTYPE_AUTOMATIC) && !is_wep))
+	if (sme->auth_type == NL80211_AUTHTYPE_OPEN_SYSTEM ||
+	    (sme->auth_type == NL80211_AUTHTYPE_AUTOMATIC && !is_wep))
 		msg_join.authtype.data = P80211ENUM_authalg_opensystem;
-	else if ((sme->auth_type == NL80211_AUTHTYPE_SHARED_KEY) ||
-		 ((sme->auth_type == NL80211_AUTHTYPE_AUTOMATIC) && is_wep))
+	else if (sme->auth_type == NL80211_AUTHTYPE_SHARED_KEY ||
+		 (sme->auth_type == NL80211_AUTHTYPE_AUTOMATIC && is_wep))
 		msg_join.authtype.data = P80211ENUM_authalg_sharedkey;
 	else
 		netdev_warn(dev,
-- 
2.41.0

