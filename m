Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E417D7559D4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 05:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjGQDHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 23:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGQDHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 23:07:49 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41B310C;
        Sun, 16 Jul 2023 20:07:45 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a1c162cdfeso2827498b6e.2;
        Sun, 16 Jul 2023 20:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689563265; x=1692155265;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P1cF7aE0O334w6SieqGerie0ev5721fo103fEanx5vI=;
        b=X0QzLlcdDyPEULFRD0ZEN4qFLBoJCv2i0tWTBy3cwCJ2Oi+4p2LkJl4R/HXJ1V7akU
         2Jde6aQZAJDXf8zzPGMTxW5rIDgXvpH4xibWUqFuXPwHQa/+hsIYIkqfPFLF3hZLaP7H
         nJSJgj2OGV8bQrX7ZDrvXHVPNB+3NfJ8BJZfapSe7cXauyuEJx/erw/JGOuzaOKAFbtf
         trMenhqjpzSJ8dliWh3Nq/3FPs2Imw0CBTtge25g45lCD9DDJSLodtaaynMMptmAI8IG
         cu4tMq4kfEDmIXQS/xZkFjuGbYi4aOTvZh5+/2j4IIaWwdsWoBTLgtTNEBDSupPSFTs9
         Pftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689563265; x=1692155265;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1cF7aE0O334w6SieqGerie0ev5721fo103fEanx5vI=;
        b=N2OVbTJVQpCu4AgFUSyocjIwrtleusUM24XpS3/S3fVDCJnpl9H9mYgxWdyBIwMy6E
         1/o3pbpKLJLjG0k9CFOsgoxEIqtyf7AbpG/bEVgscOJ0vzrhRq5FVl1fkUMXozWIgnXi
         hmA9pAVwGff0CKflteCwpGxFOKtAyRQpCLKNGETtE38jrjNQVL/wndK7NxkoY94uhKlQ
         C1jWY80/XoVJzOZw2Igbh+a+r+ilUWZo3cqCJZIgqQISk3lXDfZQtnSUwg7fRitvkyRD
         QhQZsgaLdzXxUYDY0Nx7N+NsCsM0805Qyp7pRpEO5q7kQbjU+iu/70BvaW7Rydskr5dg
         mTIQ==
X-Gm-Message-State: ABy/qLbXiAjZhr/9FbLRNmEi0uLUlyspdl16Fo0lCUbrtgpB3pqT6nvC
        cphxN9jYYpTqwkLEklIhn6E=
X-Google-Smtp-Source: APBJJlGdR3SVNPCXRrFeb38Mu5xgb1z6xNlAt0dTJl7qCM6K+K1ucbpkZ56OKvVAc+H16zKKC8mu7Q==
X-Received: by 2002:aca:ded5:0:b0:39c:9173:31f1 with SMTP id v204-20020acaded5000000b0039c917331f1mr9165869oig.28.1689563264924;
        Sun, 16 Jul 2023 20:07:44 -0700 (PDT)
Received: from bud-laptop (cpe-70-122-131-40.tx.res.rr.com. [70.122.131.40])
        by smtp.gmail.com with ESMTPSA id b18-20020a056808011200b003a05afbcbf0sm6309908oie.22.2023.07.16.20.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 20:07:44 -0700 (PDT)
Date:   Sun, 16 Jul 2023 22:07:42 -0500
From:   Wes Miser <buddwm@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: Add VID/PID 0489/e102 for MediaTek MT7922
Message-ID: <ZLSwfv2pQ5uH6bja@bud-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on Acer Swift Edge 16 Notebook

Signed-off-by: Wes Miser <buddwm@gmail.com>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5ec4ad0a5c86..95f43d48f383 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -628,6 +628,9 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0489, 0xe0f2), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe102), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
-- 
2.41.0

