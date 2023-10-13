Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904A17C81BB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjJMJPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjJMJPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:15:48 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A165B7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 02:15:43 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bdcade7fbso284885766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 02:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697188541; x=1697793341; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jeq0ADBKASlsQywUrFjTJUUlHr48GRLZ05MNLo+BnWA=;
        b=lzuLdSpmj5OncOb8fmN1vQw1mEJRRCg/QTOtglNYQKQaH151i71hSyeAyajbPFf2+n
         /7hCTKjBLja/ViX263H5C3EF2z0xnWvxu121v8wjo1UUOh69Iu0CWbKOF8pDOiBOa2Ik
         TZ6ulgiLONMs3MH/j4l8UwaVZDRHNIkrcJ0mq7DbQo1qgcE2ibwp4gy84U4rdSb8PkOZ
         olL/fikhbhtiVOkink8ZwtPD6pLjUvELLXV7akcYut0uYBi4XFSP/oE6N/bMfVoLQsV0
         cTp6zp5/Ril7d9qu4An3VHBtRrwITqGoI4YCZeSl6NIhDwiWI6cDwjUup25L/+e7r0BO
         4GZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697188541; x=1697793341;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jeq0ADBKASlsQywUrFjTJUUlHr48GRLZ05MNLo+BnWA=;
        b=dnRWFLcjJ4UaUULLHmGCdZNZ9jKJe6CwUrkj0GC9iWaP4sz353Vwvzu288/Ifepf0Z
         YHCYQzsvQM6AiGo2aWm+DVowCc7BetsM9ZzMWXFTrGkgB3BkSze8cvc3ks6REWb+45gj
         f8uAsxHAI60wg/uLXHD6kSm4bMkQNaVfs62ceU47krR4ygQiOxemhvCzO1VHzaOVesJI
         jUCYSiGsBM4dbtdN+kkrSWpqOU76eO1ttcO3DuDDXZIQRY1sOk5FR+cIsIqJPq27bME9
         jNKxpDJsj5feIQ1Nb61R3rhd92PGhR1l1HumkH0ml2SUqJJvF3BqOE6YzDcfbsGJSHcp
         8rRA==
X-Gm-Message-State: AOJu0YwIdvpihvrcAH3wqMLf95dGaZz3QYisUM8V+eNL5OCd6KCAWLAM
        iNi8MSnuwd1y673wPr5bKdE8+7haR5dtp11+
X-Google-Smtp-Source: AGHT+IE42F9R/8o1jQEEVanxvfrLDLYyZjYzoidBWJx4edPLLO039ItXve0O7tJPYGu+/RFAueuYkA==
X-Received: by 2002:a17:906:73d1:b0:9b6:4b5d:7758 with SMTP id n17-20020a17090673d100b009b64b5d7758mr24708273ejl.68.1697188541444;
        Fri, 13 Oct 2023 02:15:41 -0700 (PDT)
Received: from lab-ubuntu ([41.90.69.21])
        by smtp.gmail.com with ESMTPSA id u16-20020a1709064ad000b009ae54585aebsm11945500ejt.89.2023.10.13.02.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 02:15:41 -0700 (PDT)
Date:   Fri, 13 Oct 2023 12:15:39 +0300
From:   Calvince Otieno <calvncce@gmail.com>
To:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luke Koch <lu.ale.koch@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Calvince Otieno <calvncce@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wlan-ng: remove helper function
 prism2sta_inf_handover()
Message-ID: <ZSkKux4LMgYiaNMx@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prism2sta_inf_handover() function basically calls pr_debug() to print
a literal string. This can be done by the parent function directly.

Signed-off-by: Calvince Otieno <calvncce@gmail.com>
---
 drivers/staging/wlan-ng/prism2sta.c | 29 +----------------------------
 1 file changed, 1 insertion(+), 28 deletions(-)

diff --git a/drivers/staging/wlan-ng/prism2sta.c b/drivers/staging/wlan-ng/prism2sta.c
index 57180bb71699..caeceb89c9fa 100644
--- a/drivers/staging/wlan-ng/prism2sta.c
+++ b/drivers/staging/wlan-ng/prism2sta.c
@@ -90,9 +90,6 @@ static int prism2sta_getcardinfo(struct wlandevice *wlandev);
 static int prism2sta_globalsetup(struct wlandevice *wlandev);
 static int prism2sta_setmulticast(struct wlandevice *wlandev,
 				  struct net_device *dev);
-
-static void prism2sta_inf_handover(struct wlandevice *wlandev,
-				   struct hfa384x_inf_frame *inf);
 static void prism2sta_inf_tallies(struct wlandevice *wlandev,
 				  struct hfa384x_inf_frame *inf);
 static void prism2sta_inf_hostscanresults(struct wlandevice *wlandev,
@@ -922,30 +919,6 @@ static int prism2sta_setmulticast(struct wlandevice *wlandev,
 	return result;
 }
 
-/*
- * prism2sta_inf_handover
- *
- * Handles the receipt of a Handover info frame. Should only be present
- * in APs only.
- *
- * Arguments:
- *	wlandev		wlan device structure
- *	inf		ptr to info frame (contents in hfa384x order)
- *
- * Returns:
- *	nothing
- *
- * Side effects:
- *
- * Call context:
- *	interrupt
- */
-static void prism2sta_inf_handover(struct wlandevice *wlandev,
-				   struct hfa384x_inf_frame *inf)
-{
-	pr_debug("received infoframe:HANDOVER (unhandled)\n");
-}
-
 /*
  * prism2sta_inf_tallies
  *
@@ -1724,7 +1697,7 @@ void prism2sta_ev_info(struct wlandevice *wlandev,
 	/* Dispatch */
 	switch (inf->infotype) {
 	case HFA384x_IT_HANDOVERADDR:
-		prism2sta_inf_handover(wlandev, inf);
+		pr_debug("received infoframe:HANDOVER (unhandled)\n");
 		break;
 	case HFA384x_IT_COMMTALLIES:
 		prism2sta_inf_tallies(wlandev, inf);
-- 
Calvince Otieno

