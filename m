Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050737CC04B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbjJQKNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbjJQKND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:13:03 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CB1E8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 03:13:01 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-406402933edso54988435e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 03:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697537580; x=1698142380; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E8E7YoxZ2av3orSrcaFfg8f95nyYUaTpAzrG7yxUAnU=;
        b=Z407z6pWTFSh+5gF1UxgXvG1qeQN5Ls0HgEy75VsQEGd3hM0sVCE/lxg1rSZko6adi
         42Vhxko4pTMlKb2xUGeNOk2Y1z+Rdj83uv+m9538jVptuoOmSOMw/MwOZY5O09WGV7Pp
         tAKh/TSJdTI7HbfBeiG++ayGm38PUv+uvrhnugMNbi/leHyiOrFDyIsPUT/BiJiDTeg1
         RuqSEya+DH5mgG0T19/prVaHHr4GOxoFM0dNakCNxQO2O7lT6ZocEnXo85/OUKrcDSJR
         i5yadOMjjEM3Zs4ceTOp/4kunJUsmHp8HCJBpQZLlj4XX0tmq5zvewSOkgOn9+Y+MQmh
         tQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697537580; x=1698142380;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E8E7YoxZ2av3orSrcaFfg8f95nyYUaTpAzrG7yxUAnU=;
        b=oZqUcbuWN+4uRzs2zWdoSLU4WbnQ/ffeUQ1TAYvu05iU2MHmfz2DJQp6n6RCS3ZECJ
         s8RX+1Qu/dGUSMXPNo8i8UtMUXiVLWodOZP1IEpNkp8Nuv3XNCZcKPDlfKBlUbza4ZM1
         kM2gMLtgvSfNy3Pl8RCQAVizXgZYoFBC5+Gzr9cPDIrRDCNAFap0augrUP0cJeJtgdwv
         oyoCuUJp8xII5ESX19ktNEIiM+FvI8920pN4HFcoWFu5LxtBEuSHf87gN1Y2N+mjk0IX
         eei7DzsWqbiS1mDtPqN8Pif3LFvY28UlzudwmJNeluJ7vtsDv2ZEIkTI3n7I1qjH+gFL
         c3Wg==
X-Gm-Message-State: AOJu0Yyae6/6zwgR53F2VEVS1Ka92RuQDebfmFfOHTDTM4/p+8CMt4QU
        /KNPpkXUsAGeimHlffUncEIqqEGMd5l5VQ==
X-Google-Smtp-Source: AGHT+IGC29aSwArOWKsG/fAbXePFt9Io7X0exKliBc79JW4dCiH8sjHjUReO3UOWvvCrFfLau9VPWw==
X-Received: by 2002:adf:e504:0:b0:32d:b7d4:b90 with SMTP id j4-20020adfe504000000b0032db7d40b90mr1560360wrm.39.1697537579751;
        Tue, 17 Oct 2023 03:12:59 -0700 (PDT)
Received: from lab-ubuntu ([41.90.67.11])
        by smtp.gmail.com with ESMTPSA id y7-20020adffa47000000b0031aef72a021sm1323918wrr.86.2023.10.17.03.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 03:12:59 -0700 (PDT)
Date:   Tue, 17 Oct 2023 13:12:56 +0300
From:   Calvince Otieno <calvncce@gmail.com>
To:     gustavo@embeddedor.com, outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Calvince Otieno <calvncce@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Deepak R Varma <drv@mailo.com>,
        Simon Horman <horms@kernel.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wlan-ng: remove function prism2sta_ev_txexc
Message-ID: <ZS5eKFCfu7sGOCHL@lab-ubuntu>
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

The function prism2sta_ev_txexc() is called by the function
hfa384x_usbin_txcompl() to print the transmit exception event - a debug
information using netdev_dbg().

The debugging utility function can be called directly by
hfa384x_usbin_txcompl().

Signed-off-by: Calvince Otieno <calvncce@gmail.com>
---
 drivers/staging/wlan-ng/hfa384x_usb.c |  2 +-
 drivers/staging/wlan-ng/prism2mgmt.h  |  4 +---
 drivers/staging/wlan-ng/prism2sta.c   | 24 ------------------------
 3 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/wlan-ng/hfa384x_usb.c b/drivers/staging/wlan-ng/hfa384x_usb.c
index 3e8c92675c82..35650f911ebc 100644
--- a/drivers/staging/wlan-ng/hfa384x_usb.c
+++ b/drivers/staging/wlan-ng/hfa384x_usb.c
@@ -3194,7 +3194,7 @@ static void hfa384x_usbin_txcompl(struct wlandevice *wlandev,
 
 	/* Was there an error? */
 	if (HFA384x_TXSTATUS_ISERROR(status))
-		prism2sta_ev_txexc(wlandev, status);
+		netdev_dbg(wlandev->netdev, "TxExc status=0x%x.\n", status);
 	else
 		prism2sta_ev_tx(wlandev, status);
 }
diff --git a/drivers/staging/wlan-ng/prism2mgmt.h b/drivers/staging/wlan-ng/prism2mgmt.h
index 8c3f1ac35913..17222516e85e 100644
--- a/drivers/staging/wlan-ng/prism2mgmt.h
+++ b/drivers/staging/wlan-ng/prism2mgmt.h
@@ -45,9 +45,7 @@ extern int prism2_reset_settletime;
 
 u32 prism2sta_ifstate(struct wlandevice *wlandev, u32 ifstate);
 
-void prism2sta_ev_info(struct wlandevice *wlandev,
-		       struct hfa384x_inf_frame *inf);
-void prism2sta_ev_txexc(struct wlandevice *wlandev, u16 status);
+void prism2sta_ev_info(struct wlandevice *wlandev, struct hfa384x_inf_frame *inf);
 void prism2sta_ev_tx(struct wlandevice *wlandev, u16 status);
 void prism2sta_ev_alloc(struct wlandevice *wlandev);
 
diff --git a/drivers/staging/wlan-ng/prism2sta.c b/drivers/staging/wlan-ng/prism2sta.c
index 964164bb4165..cb6c7a9fb8f3 100644
--- a/drivers/staging/wlan-ng/prism2sta.c
+++ b/drivers/staging/wlan-ng/prism2sta.c
@@ -1748,30 +1748,6 @@ void prism2sta_ev_info(struct wlandevice *wlandev,
 	}
 }
 
-/*
- * prism2sta_ev_txexc
- *
- * Handles the TxExc event.  A Transmit Exception event indicates
- * that the MAC's TX process was unsuccessful - so the packet did
- * not get transmitted.
- *
- * Arguments:
- *	wlandev		wlan device structure
- *	status		tx frame status word
- *
- * Returns:
- *	nothing
- *
- * Side effects:
- *
- * Call context:
- *	interrupt
- */
-void prism2sta_ev_txexc(struct wlandevice *wlandev, u16 status)
-{
-	netdev_dbg(wlandev->netdev, "TxExc status=0x%x.\n", status);
-}
-
 /*
  * prism2sta_ev_tx
  *
-- 
2.34.1

