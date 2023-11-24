Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A380F7F8588
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 22:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjKXViG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 16:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjKXViE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 16:38:04 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377E91FD6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:30:51 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9fd893c2938so56326066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700861449; x=1701466249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xoZLCfy84gUYPbI3uqvkOab7elap9QZSeyk50KS8zLU=;
        b=RYFObA12SH+viD2hfgeT2rajpsyLoz71cSJrdfWLky9afIOEP3Cp5XJki8Aoi7fdoj
         rTk/hQqe1vi4XVAj3A80LNqrMsFj1Ud5UEESYS2kyy8hF9/X2H/gW/k6VRjK5WKlh26O
         Q7rLzXoe838JoIkNpyL0nKdwS22KBllH0uJfiit0DqFQ6RZO6Gc9/NaJ9QkaGxJz1jb+
         keeA+y08UgMMaFlpOdFsAKN7a4/B3ppEzTEjogLsnOl3P/hu4x3hlHzYKK3KfRrtAaqO
         Bflo+KbWbK96pMTGGVg2BSwXbPvfIXkaIC/iWHzIS+NLj4xuh6NZwLZ7mQ4tY6ucpLSq
         UpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700861449; x=1701466249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoZLCfy84gUYPbI3uqvkOab7elap9QZSeyk50KS8zLU=;
        b=NmMMyQBZ13pCy1xfl447K8Il+HvOyqPiaOO1cYPCWBVHPmYErdIV26dLmFunbaZw9H
         B740FnaYtU2BNjA2tRWxmCcqQf6CRLBUk7e9IlAalkPHzhRdRiIy4f/zBhWZ4lLNi7kY
         gdwTAqXu9nfzkrFlR7haUwaOQ9knEWv4Rz96QnlfbosqwscoYIqdZ3ogE4633fwRmaMi
         XBtVZPb6eON0eDq/Q4zBhFxqk5s53SqsFoWQf63DAENmkEOr2bU2+H5SVHf+oRfaadcn
         dKpIOLc23ld6TbUvmTyTF9kBEccl/w2HmoKZuKVUSH9Y5NYO0IFh8EeW7t66iI4D7HXd
         YjnA==
X-Gm-Message-State: AOJu0Yw3FbAfWFjNKSuL4nbjYLJmrRGzlJwmEIP5ZjbUz4S0WBq7LNLo
        lUZyvUxAxG0C/YhPVxz+Ngs=
X-Google-Smtp-Source: AGHT+IExYU05LokiyAqdqqUl1BXlu3JcZIXnjwyodpQNEFEEwHrckfNTeYD3GXE+m1aWcsGb3gIwHA==
X-Received: by 2002:a17:907:b00f:b0:9b2:bf2d:6b65 with SMTP id fu15-20020a170907b00f00b009b2bf2d6b65mr2305143ejc.4.1700861449489;
        Fri, 24 Nov 2023 13:30:49 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id bv8-20020a170906b1c800b009fc927023bcsm2527152ejb.34.2023.11.24.13.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 13:30:49 -0800 (PST)
Date:   Fri, 24 Nov 2023 22:30:47 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] staging: rtl8192e: Remove unused timer beacon_timer
Message-ID: <b16b6b4525ede8e2a218cb39d23f9ef2a3a745a9.1700860759.git.philipp.g.hortmann@gmail.com>
References: <cover.1700860758.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700860758.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver does not support AP Mode therefore no beacons need to be send.
Remove unused timer beacon_timer.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h         |  1 -
 drivers/staging/rtl8192e/rtllib_softmac.c | 17 -----------------
 2 files changed, 18 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 835b407ab180..b7f4d7e2ea26 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1418,7 +1418,6 @@ struct rtllib_device {
 	struct timer_list associate_timer;
 
 	/* used if IEEE_SOFTMAC_BEACONS is set */
-	struct timer_list beacon_timer;
 	u8 need_sw_enc;
 	struct work_struct associate_complete_wq;
 	struct work_struct ips_leave_wq;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 0ad08165fd85..430951c88123 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -365,21 +365,6 @@ static void rtllib_send_beacon(struct rtllib_device *ieee)
 		softmac_mgmt_xmit(skb, ieee);
 		ieee->softmac_stats.tx_beacons++;
 	}
-
-	if (ieee->beacon_txing && ieee->ieee_up)
-		mod_timer(&ieee->beacon_timer, jiffies +
-			  (msecs_to_jiffies(ieee->current_network.beacon_interval - 5)));
-}
-
-static void rtllib_send_beacon_cb(struct timer_list *t)
-{
-	struct rtllib_device *ieee =
-		from_timer(ieee, t, beacon_timer);
-	unsigned long flags;
-
-	spin_lock_irqsave(&ieee->beacon_lock, flags);
-	rtllib_send_beacon(ieee);
-	spin_unlock_irqrestore(&ieee->beacon_lock, flags);
 }
 
 /* Enables network monitor mode, all rx packets will be received. */
@@ -2328,8 +2313,6 @@ int rtllib_softmac_init(struct rtllib_device *ieee)
 
 	timer_setup(&ieee->associate_timer, rtllib_associate_abort_cb, 0);
 
-	timer_setup(&ieee->beacon_timer, rtllib_send_beacon_cb, 0);
-
 	INIT_DELAYED_WORK(&ieee->link_change_wq, (void *)rtllib_link_change_wq);
 	INIT_WORK(&ieee->associate_complete_wq, (void *)rtllib_associate_complete_wq);
 	INIT_DELAYED_WORK(&ieee->associate_procedure_wq, (void *)rtllib_associate_procedure_wq);
-- 
2.42.0

