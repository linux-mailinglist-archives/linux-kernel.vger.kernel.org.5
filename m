Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495C77C9918
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 15:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjJONMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 09:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjJONMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 09:12:51 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0973BC1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 06:12:49 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-406609df1a6so35472215e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 06:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697375567; x=1697980367; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2tW4gpmmxh+63YJI903yg6bkjFjycGTO0DBlFHUGBTM=;
        b=etTqXfHZjB31k8DGeeebCIE2Ls1iMxOX6IrDDEJ1byEkFJFcHwLF6sZt0moOYTTzVE
         Ul6kItwkhtYOmRhQ7Apsnnm45EJdHfCv8xNNzjXlbL8T4gjaGx3VdYGC2nR/VqjM5gv+
         e9KGMalBt0ms8m/HxUDGiXEKpBPuJGCkIaFX1Nkj1SzlnuxlNS3+qmbIT25SXDMZcdLE
         RBbfxRI39XtWJjBC24R+ptu5k+5/Gnwrv9FfKfQY9OBP3/GADkeLj5p663jDdTGnL/Hd
         j61GFzokIGcyrYSau/5IeyLbVkyK7MLykQ2DQxqltEViaiwtJNaQ+wkv32EPGPMZga9Y
         cU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697375567; x=1697980367;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2tW4gpmmxh+63YJI903yg6bkjFjycGTO0DBlFHUGBTM=;
        b=YehpU7mZfPcG01yBg3GijVYg5MhLc4CJYnDMSDYAL9zW3VTmdLuXh9uuDc4XK6Edqe
         L4CkoLhXae17CdrtmIwj50IM3pD78i+NpJerxDJ4oXvyb2rl4F+Bwqs4Glgjn8AVFBju
         Nu9FPcI2gQzPuX1eSYXfOjeKCMfFB91K5oq4wRfmhLz1K8MTtsuzWkl84uIbNMCayS2P
         iQwyei6aOVtg/DKmn2eU9XUte0yxTDTyWedIM181fK9tUVkGPRYctWtiCl8CUJAQSlkp
         sCqOE7vY43S1hd/9Mf0s2CcSDqWUjFHl844kXR9gpiklTKnYzGphsfgAT6euqD4oKZg/
         5g2A==
X-Gm-Message-State: AOJu0Yz0vXzXA4Je6JNrCjcVrQxZPPddmW3ndBHLeWEldfIO+r6+2vlX
        r2f/hd4SUv6ETS8vWDW+/8Plz7q5eo5+bQ==
X-Google-Smtp-Source: AGHT+IHUXQ+o0u2TfCTD4y/bZVfWK0YTlVpXcTYyc02g4p2BYq725O2qRPTAP+aK3//eRfhD407BiQ==
X-Received: by 2002:a7b:ce89:0:b0:404:f9c1:d5d7 with SMTP id q9-20020a7bce89000000b00404f9c1d5d7mr27585153wmj.25.1697375566890;
        Sun, 15 Oct 2023 06:12:46 -0700 (PDT)
Received: from lab-ubuntu ([41.90.64.203])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b00405bbfd5d16sm4463112wms.7.2023.10.15.06.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 06:12:46 -0700 (PDT)
Date:   Sun, 15 Oct 2023 16:12:43 +0300
From:   Calvince Otieno <calvncce@gmail.com>
To:     gustavo@embeddedor.com, outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Calvince Otieno <calvncce@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wlan-ng: remove unnecessary helper function
Message-ID: <ZSvlS18qI7G7Dvpi@lab-ubuntu>
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

The function prism2sta_inf_handover() is called by the parent
function prism2sta_ev_info() to print a literal debug information
string using pr_debug(). The debugging utility function can be called
directly within prism2sta_ev_info().

Furthermore, to make the debugging more module-specific, the netdev_dbg()
function is preferred over the generic pr_debug() utility function.

Signed-off-by: Calvince Otieno <calvncce@gmail.com>
---
 drivers/staging/wlan-ng/prism2sta.c | 30 ++---------------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/wlan-ng/prism2sta.c b/drivers/staging/wlan-ng/prism2sta.c
index 57180bb71699..b5e95a3207fe 100644
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
@@ -1724,7 +1697,8 @@ void prism2sta_ev_info(struct wlandevice *wlandev,
 	/* Dispatch */
 	switch (inf->infotype) {
 	case HFA384x_IT_HANDOVERADDR:
-		prism2sta_inf_handover(wlandev, inf);
+		netdev_dbg(wlandev->netdev,
+			   "received infoframe:HANDOVER (unhandled)\n");
 		break;
 	case HFA384x_IT_COMMTALLIES:
 		prism2sta_inf_tallies(wlandev, inf);
-- 
2.34.1

