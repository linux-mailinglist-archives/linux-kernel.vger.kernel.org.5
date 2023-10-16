Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319097C9EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjJPF1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJPF1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:27:30 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C17DDC
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 22:27:28 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-405524e6769so24734115e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 22:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697434047; x=1698038847; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DdZ+m+g68ipyNyjyLKt02+pfvg0U+piWymGF1uR9+lc=;
        b=iL5W6qoxv9fupMOiN7S7usFYo2vX2yiVF33K6vueCqFRkb11yd5QQio9brPwMMCBfU
         27Gt5R7bGy3WkyvY9tjbJlbBfRzHB6MgUTKfkjC7pDrSwBbNkDIBn0DLMbajg0mXsAAp
         ge+LBDA585CKogpHmvLmOxitgjyxPZUK682k05XSvTQdvuDaAFs5Gfb0bSSHIJHNdkH0
         qRDpXkRuP8RdPY7s4auV6CtDXyTEeoECpz2x4zuUDsr3/kI1m7bJEttbIk2enwYCHn3m
         Y+tbjRuIgcwgDDx/aoWvSEsVsSDORz4kTgbgrfSFIYC+Uk+pbhrcfNGuWy49j+5Sy0b8
         x/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697434047; x=1698038847;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DdZ+m+g68ipyNyjyLKt02+pfvg0U+piWymGF1uR9+lc=;
        b=QdLITg9ol2pOYnNX0BRZtFfnQFQsP5wz+1RaRoUF1qMinfHu0MS3gNzPZ4l79DIrZd
         RVofrawk7DKJ7NEh0A6vqgVst9RToiHZ3y9OcuTLcLBiZMRG+LEnISFuOk3ytLdfIrSn
         GMA9r0EvkTTVp95mZ9J6L2P3xPoIZoYOQop1/KRJuu2VKwmIINLqIn22LIe+j75l4akk
         sH3i/cNcIVoOhb0UP1Klyvm/Ch6LXymJql7G6F8OZKURQkazskw2aDq28iVA2pHU1bmt
         CHc5M/g7Wye5YTG4k3PO0h43qemm/bBCSK/gwZLl9K3tnGgm0aYj79dhG1PmufmrJ6zC
         Jf+A==
X-Gm-Message-State: AOJu0YxEESEGR7EJyoz9/SQp4E9JwCYuzcHAMpZW7U8oJWYLvkmtFWiS
        oFBxo1OL8W0NH4BTM4O9SxmmMM5zDb4pIA==
X-Google-Smtp-Source: AGHT+IHDufePDYgd7tgKPVnuknM7a0SfeuT6CjHzJNcLHbxk5TipFuuxkgIKUdn82Jf0yMBr3No0ww==
X-Received: by 2002:a05:600c:1d1a:b0:405:358c:ba74 with SMTP id l26-20020a05600c1d1a00b00405358cba74mr4723146wms.0.1697434046440;
        Sun, 15 Oct 2023 22:27:26 -0700 (PDT)
Received: from lab-ubuntu ([41.90.67.11])
        by smtp.gmail.com with ESMTPSA id p9-20020a5d4e09000000b0032196c508e3sm5550508wrt.53.2023.10.15.22.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 22:27:25 -0700 (PDT)
Date:   Mon, 16 Oct 2023 08:27:23 +0300
From:   Calvince Otieno <calvncce@gmail.com>
To:     gustavo@embeddedor.com, outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Calvince Otieno <calvncce@gmail.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: wlan-ng: remove unnecessary helper function
Message-ID: <ZSzJuwlEKPBj9kLN@lab-ubuntu>
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
Changes since v2:
 - Added the patch change log

Changes since v1:
 - Remove the unnecessary helper function prism2sta_inf_handover()
 - Replace pr_debug() with netdev_dbg()
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

