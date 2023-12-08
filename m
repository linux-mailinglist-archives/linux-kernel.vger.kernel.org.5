Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2903780ABF0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574612AbjLHSTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574560AbjLHSTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:19:48 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A499F10DF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 10:19:54 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a1d48f0223dso65253266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 10:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702059593; x=1702664393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3+GiMKSFFjg4ZMw0A4N/m/YEPbPCxTc/5rQWQIRaPIU=;
        b=aGMhPjcyOMo0IMdWGMFMCLDTB+60RmW2B8FKNhhD9z2m83nNKwTzzzLG4e1gpO8v+r
         QWD94wbylf1EnhzlikoxbpBBY8cAnw3K3SQwfMyQVdsvLQkH8XXf6CdfuErAQcDEIj2v
         A6Hubd7gC8ih3977XG+KOJEnlDbXzufV9+b3Gbwkbi30NVSW5JTu/S2xugAvqp9I7cHe
         4r4Zx06XIkU35bHfvkPvc17DXr3JYVGO4uE/DDPVzw6b4mv/+QrATvTXVnrT2KiZvMLZ
         VKhivfVTiZBQDYEw1gN1SAYU7EZeiEcMBxWuxn1r668t1srWDw+eGmkg83CqVB/mFof5
         0TUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702059593; x=1702664393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+GiMKSFFjg4ZMw0A4N/m/YEPbPCxTc/5rQWQIRaPIU=;
        b=b0NZGBYPaiul9VZSRFsKHytBAGITuQ5XYxvhVvc2tTVWl1wlQ0f+CHLcWbVdwgvya8
         wTASRxPUCrDwZl1raJe53IXchdwoxpKabwwpvH2VI2of1CbzKpS69MXipzLQPL1THTnw
         /2VcndJeEhXKlUsNpp8KXTNTdUHU3UURbbUG63A1UEPxWtULrtxBWbKNgGRbXyhXQaaD
         fL5BNbZp9Qfdd5PlDmio96rXi8S9IeywaSp+rurYNeJbDg8pO289dwRC9lsegGqWTRYp
         dDdIs9o38Z6Qup8Sb5aooduCDPGpdB85IzuZ8kJ1wt7XrFUIzJ3JCpjPgmoi5Sa8oY5D
         YO8g==
X-Gm-Message-State: AOJu0YxM45UcalBg5ONsP63LmoG1t5g24JuOmgaLEQ5b10POBbQBxNrI
        Yc/YThk14RaLLgZt3mu3nSY=
X-Google-Smtp-Source: AGHT+IFTU2n3tnX5CI1gosGvDYb9GngljuO8owN+2TVNQx5bFnanpeCoc7wlrYMkoaUv8Wy3BHYzZQ==
X-Received: by 2002:a17:907:d384:b0:a1b:1daf:8270 with SMTP id vh4-20020a170907d38400b00a1b1daf8270mr485532ejc.5.1702059593003;
        Fri, 08 Dec 2023 10:19:53 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id tf13-20020a1709078d8d00b00a1b8829597fsm1260423ejc.114.2023.12.08.10.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 10:19:52 -0800 (PST)
Date:   Fri, 8 Dec 2023 19:19:51 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] staging: rtl8192e: Remove variable dot11d_info
Message-ID: <2438971feb0c02c5c72776f57201a4011f249190.1701989555.git.philipp.g.hortmann@gmail.com>
References: <cover.1701989555.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701989555.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove variable dot11d_info as it is unused. Remove unused struct
channel_list and empty struct rt_dot11d_info.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/dot11d.c         | 5 -----
 drivers/staging/rtl8192e/dot11d.h         | 6 ------
 drivers/staging/rtl8192e/rtllib.h         | 1 -
 drivers/staging/rtl8192e/rtllib_softmac.c | 6 ------
 4 files changed, 18 deletions(-)

diff --git a/drivers/staging/rtl8192e/dot11d.c b/drivers/staging/rtl8192e/dot11d.c
index c44ff26e8d61..8d89f962b3bf 100644
--- a/drivers/staging/rtl8192e/dot11d.c
+++ b/drivers/staging/rtl8192e/dot11d.c
@@ -7,11 +7,6 @@
  ******************************************************************************/
 #include "dot11d.h"
 
-struct channel_list {
-	u8      channel[32];
-	u8      len;
-};
-
 void dot11d_channel_map(struct rtllib_device *ieee)
 {
 
diff --git a/drivers/staging/rtl8192e/dot11d.h b/drivers/staging/rtl8192e/dot11d.h
index d047283f2ceb..98aa28d0cf72 100644
--- a/drivers/staging/rtl8192e/dot11d.h
+++ b/drivers/staging/rtl8192e/dot11d.h
@@ -18,12 +18,6 @@
  *		2 - valid (passive scan)
  */
 
-struct rt_dot11d_info {
-};
-
-#define GET_DOT11D_INFO(__ieee_dev)			\
-	 ((struct rt_dot11d_info *)((__ieee_dev)->dot11d_info))
-
 void dot11d_channel_map(struct rtllib_device *ieee);
 
 #endif
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index ec720f776639..51dcea57a329 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1320,7 +1320,6 @@ struct rtllib_device {
 	u16 scan_watch_dog;
 
 	/* map of allowed channels. 0 is dummy */
-	void *dot11d_info;
 	u8 active_channel_map[MAX_CHANNEL_NUMBER+1];
 
 	int rate;       /* current rate */
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index fdb0e76d20b0..3c92eb401e8c 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2077,9 +2077,6 @@ int rtllib_softmac_init(struct rtllib_device *ieee)
 	ieee->link_state = MAC80211_NOLINK;
 	for (i = 0; i < 5; i++)
 		ieee->seq_ctrl[i] = 0;
-	ieee->dot11d_info = kzalloc(sizeof(struct rt_dot11d_info), GFP_ATOMIC);
-	if (!ieee->dot11d_info)
-		return -ENOMEM;
 
 	ieee->link_detect_info.SlotIndex = 0;
 	ieee->link_detect_info.SlotNum = 2;
@@ -2153,9 +2150,6 @@ void rtllib_softmac_free(struct rtllib_device *ieee)
 	cancel_work_sync(&ieee->ips_leave_wq);
 	cancel_work_sync(&ieee->wx_sync_scan_wq);
 	cancel_work_sync(&ieee->ps_task);
-
-	kfree(ieee->dot11d_info);
-	ieee->dot11d_info = NULL;
 }
 
 static inline struct sk_buff *
-- 
2.43.0

