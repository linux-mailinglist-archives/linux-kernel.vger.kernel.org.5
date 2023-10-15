Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3465D7C9998
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 16:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjJOOZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 10:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJOOZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 10:25:05 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FF9AD
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 07:25:02 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4066692ad35so37589545e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 07:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697379901; x=1697984701; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uFgPztQppmCCCzmM2GEubbYdc8VreQZXvcgDjFAmCwY=;
        b=FwX0Pmk2Ab+qB/yHAzdzzOg/E+8KwWx2gJRzMSGBzdKqqs+FXBgoe0E1D9kI6yRPr3
         EFkIlLTUjJYNegPAkYbxqX5aBoxX690I6tRYYQt/Sca+Xl/1YoX7ABI2ZmnN4THa3PVJ
         JhEqPLiEcraLvWmQYCeh7a+HMb7a8g6IAVaB9jtK61q4/EGkhYVvdna+JAeBokgppdEf
         Q0/b77BOfWj570JMIVSHgrpq7pux9oZjAjGDusOxz7DY6Z8dj4bdDyxqEQ/GZZs9V1+f
         xFk7TsE3XwOLQsAU0ugHOgRapKzOfb/WLpijgfI6pS8VnFEFuqil3Qj1gyfFnCn2Rmz3
         r4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697379901; x=1697984701;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uFgPztQppmCCCzmM2GEubbYdc8VreQZXvcgDjFAmCwY=;
        b=gLArDORZqq/WYRc01l9pyVY1jpQ5N3l5m9LergyryRnm2mcGFbF9M3B6cqrFBqpHNM
         W7WrJn9wuBG2pdF63FaZBsFP5UeVEtUpeYZKU/zYiP8euT9Mm6IpTh6Oj9B4JuJeIQj3
         8PZF1eCg4wogljSYNBOmID4n61BrFKxjRMWAlwW40P94iOsNK8TBwgifIVn+lHMROJ4o
         piOeIaLDrPejCOf3vixbj66mjfEvdveomvr+bizlkRcsjabQwBXizGiKeQ1unBbSH/XR
         nnRyIyFr8+OaP2UHZyI7P5rbyEX6zJ0Ptz04QGvT2W9S6oWVzeVzUW6jMIHAlvcALKAA
         D+Zw==
X-Gm-Message-State: AOJu0Yxm3f3sq/B8AAEdrc//jtNNivCPdPuUzxT4otHmVqcGHhyEEJoW
        e66++vVUmPIiH2e/NhCEYbJJEs+vZ14mnw==
X-Google-Smtp-Source: AGHT+IG8pluCHBLBeAuWJR3Muz1UtlfXuciY2kmnoEUaLPJIdbX0bCo3ucqK6FD4nZKTCgya+om38Q==
X-Received: by 2002:a05:600c:2a4e:b0:406:3f62:e591 with SMTP id x14-20020a05600c2a4e00b004063f62e591mr28059955wme.41.1697379900390;
        Sun, 15 Oct 2023 07:25:00 -0700 (PDT)
Received: from lab-ubuntu ([41.90.64.203])
        by smtp.gmail.com with ESMTPSA id p10-20020a05600c1d8a00b003fe23b10fdfsm4624604wms.36.2023.10.15.07.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 07:24:59 -0700 (PDT)
Date:   Sun, 15 Oct 2023 17:24:57 +0300
From:   Calvince Otieno <calvncce@gmail.com>
To:     gustavo@embeddedor.com, outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Calvince Otieno <calvncce@gmail.com>
Subject: [PATCH] staging: wlan-ng: remove unused function prototypes
Message-ID: <ZSv2ObWLvlbM2hXn@lab-ubuntu>
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

These functions are declared but not defined or used anywhere.
Their definitions were removed 15 years ago in the
commit cbec30c4c00c ("Staging: wlan-ng: Delete a large pile of
now-unused code.")

Signed-off-by: Calvince Otieno <calvncce@gmail.com>
---
 drivers/staging/wlan-ng/prism2mgmt.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/wlan-ng/prism2mgmt.h b/drivers/staging/wlan-ng/prism2mgmt.h
index 083a055ee986..8c3f1ac35913 100644
--- a/drivers/staging/wlan-ng/prism2mgmt.h
+++ b/drivers/staging/wlan-ng/prism2mgmt.h
@@ -78,14 +78,6 @@ void prism2mgmt_pstr2bytestr(struct hfa384x_bytestr *bytestr,
 void prism2mgmt_bytestr2pstr(struct hfa384x_bytestr *bytestr,
 			     struct p80211pstrd *pstr);
 
-/* functions to convert Group Addresses */
-void prism2mgmt_get_grpaddr(u32 did, struct p80211pstrd *pstr,
-			    struct hfa384x *priv);
-int prism2mgmt_set_grpaddr(u32 did,
-			   u8 *prism2buf, struct p80211pstrd *pstr,
-			   struct hfa384x *priv);
-int prism2mgmt_get_grpaddr_index(u32 did);
-
 void prism2sta_processing_defer(struct work_struct *data);
 
 void prism2sta_commsqual_defer(struct work_struct *data);
-- 
2.34.1

