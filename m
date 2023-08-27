Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7629789EBE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 15:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjH0N1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 09:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjH0N1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 09:27:18 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6D71AD
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 06:27:08 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-400e8ab9325so7679655e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 06:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693142827; x=1693747627;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q6sLDsBM3SAzSIk/9s8j5DkZWsAjuzBKZnQbC8hmoRw=;
        b=OBtIR8Ou680PclG8/4zyKtzBbSO0Trn3da/2JCkmSCR6vBcku2OsxRKPMhXNDNbFhk
         r6PuCRs1ACRngsRrF8NUBaqw+bneZrKyotc8fShw8EyYMmkVXft6QkTZ3v/1eVEFycSb
         hls+n5tAufuwckFDpwrU3POCh4kzvNiWtzZ8iabIharEmAMZHIDQRc9NxUZgmHrlBfZ/
         URdwhJqyRM+lWIP2cssszhBVMdZKMhC404rS0XQC0Ayi2VAYOWRgA5AhmMzX9mO4cUMC
         b/eJPqtFpJqjaUap1PjMnmvfSfqJCG5QwecZMU4We44JsOOmvUHwHL4GfHrouLZ82bhI
         oFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693142827; x=1693747627;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q6sLDsBM3SAzSIk/9s8j5DkZWsAjuzBKZnQbC8hmoRw=;
        b=aojt9YwsF+q/v1Z5TPgc2GZsLmyQiuStnFcX0Ippz752Hvz8HnOz6HOtZeps3T+1yT
         MwYXKQG19VRTI2kttHZ0WCuqSkRbcC6lnTQymE4Dh5dG46EdHe9eOilwa2BGBy3ccSTh
         pIlN5LldEAE9eDVeVaspYmXsL3aGlFSbqJ8ub23fByjTpXT/PkFZnWe/n7y/cFAPs/JH
         qPnJYhzTxrQ+sTMilAm2iNVcCc2sxOUyv8XtOYlq67xJqZMQ6KzpAhU7D+zzEszuc5rw
         d6uFXIf2M7lSIXnQFGKBxImFcY4Fd2zfU4C3+HgIiYcVSJGSaJ3yMYEP2wlK1iJIkto6
         IpZQ==
X-Gm-Message-State: AOJu0YzfsQDzjWoCSkFQ3AYzB+FTUB4r7d/Z9rMvmNsndX6rLjONwQKX
        m+2r0GdUz0BE0iRaBYLph5fIvpycov7cQQ==
X-Google-Smtp-Source: AGHT+IGTGqLCV/QwDDyrKOss383GlZ0N8H5bi13noXwZAEByQAc/inqAd/FeA2tqryFPCpu0gaKcCA==
X-Received: by 2002:a5d:65c5:0:b0:319:8dcf:5c10 with SMTP id e5-20020a5d65c5000000b003198dcf5c10mr16624350wrw.6.1693142826571;
        Sun, 27 Aug 2023 06:27:06 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id j11-20020adfe50b000000b003143867d2ebsm7642369wrm.63.2023.08.27.06.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 06:27:06 -0700 (PDT)
Date:   Sun, 27 Aug 2023 15:27:04 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Remove unsupported mode IW_MODE_ADHOC
Message-ID: <20230827132704.GA12506@matrix-ESPRIMO-P710>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unsupported mode IW_MODE_ADHOC because this mode is only partially
coded in the driver.

rtllib_rx_mgt() can only handle probe requests in IW_MODE_ADHOC and no
authentication or association frames.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
The only feature that is partially working in IW_MODE_ADHOC mode are
beacons. Older Android Smartphones can see the beacons but Ubuntu 22.04
and Windows 11 not. No Device is able to connect.

Debug code shows that only frames with ff:ff:ff:ff:ff:ff in addr1 field
reach rtllib_rx_InfraAdhoc() when in IW_MODE_ADHOC mode.

Using wireshark to monitor packets shows beacons and probe requests and
probe responses but no further traffic.

When this patch is accepted approximately 600 lines of code can be
removed from the driver.

Tested with rtl8192e (WLL6130-D99) in Mode n (12.5 MB/s)
Transferred this patch over wlan connection of rtl8192e.
---
 drivers/staging/rtl8192e/rtllib_softmac_wx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 0b690f0ffeef..48703d93df30 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -258,7 +258,6 @@ int rtllib_wx_set_mode(struct rtllib_device *ieee, struct iw_request_info *a,
 	mutex_lock(&ieee->wx_mutex);
 	switch (wrqu->mode) {
 	case IW_MODE_MONITOR:
-	case IW_MODE_ADHOC:
 	case IW_MODE_INFRA:
 		break;
 	case IW_MODE_AUTO:
-- 
2.41.0

