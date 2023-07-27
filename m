Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E607D764E30
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbjG0Ixv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbjG0IxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:53:22 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C2642F4B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:34:43 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3175f17a7baso751321f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=devtank-co-uk.20221208.gappssmtp.com; s=20221208; t=1690446872; x=1691051672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T+RffnyX1C3jwfJk0PWLmvia5S+Nu7M5/ptHa76gYBw=;
        b=FeXoWvmilpW1hdXzL3FNF8UmBleGyuvtnBmWlMSGvCfmSQyoKL2aTr0nXU1WNBbq3U
         o4mHBaStsMb/aS8Osw9yf5pBA10qmjWbFvlxZr58zyG+vx2zz4ieK7+FD19cbHtCtj6g
         9I9CrXC6YMrnO6/7p97IYUAzIRVv7tJHCBWrSC9tOkX3Vm9nVA94sY003Q+UnQKlemgx
         9fVkLgnEpsMmaw/hfMYe0yAmqhdaYfSm0cWVDagn1mqjA630hpwRTzb7/rPjr/1HyTj0
         XPDr2xlvbijolhVXSV6s+ezhmHEA9bMqO9UdJSB0LxeW4/huleZr9kq8ExozgbYWebcC
         Jy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690446872; x=1691051672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+RffnyX1C3jwfJk0PWLmvia5S+Nu7M5/ptHa76gYBw=;
        b=PVJKmsxzUzMro1+azoxJMxtgxWVk7QfRPQCQSWBjUMX94yL1PGKKjSyurLTnlNL25d
         KCMWgwUdCEW1lvO/WwxJYporfiAsMqAdyXoNXuY89c3sGI0GpQ7FQyweL8DzTQGQRLy6
         GZ3Mco2dvAJuogjqUCvqO0CO6VUTb3qdQHlwe3LRFclVzRaQmy8Kl40w8mkhbmgl+CzV
         BdOXJu4edhmJ3cUZSDSyenbJXSLzUKDoLljrhtQci6kzIcXOPasv8g+K+yd3XgHa0+Ba
         Wp87Qp6Lb8ihsz92Er/WvzcVkZtKbqDhTIjX/N1nXtJa/0sS1AZmJEufH8ngo3+Nyw7O
         8vBg==
X-Gm-Message-State: ABy/qLYIyOY9BDthijOo1FVBlr+ybXdzP2wUzscz7rvlrT7L3wRdr6/P
        D0xU1PNO93dU7BCZMmLFHmCqfg==
X-Google-Smtp-Source: APBJJlEHOF6Ha/hI8jPTkvlVhz5xgjSnWuYcuXmwjzcHWfoWdbiiFTlziaUnxvQuqw4WK5cG59wsFg==
X-Received: by 2002:adf:edca:0:b0:313:e8bf:a77 with SMTP id v10-20020adfedca000000b00313e8bf0a77mr1129028wro.5.1690446872019;
        Thu, 27 Jul 2023 01:34:32 -0700 (PDT)
Received: from DevTop.lan ([212.82.82.3])
        by smtp.gmail.com with ESMTPSA id e5-20020a5d5005000000b00311d8c2561bsm1330079wrt.60.2023.07.27.01.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:34:31 -0700 (PDT)
From:   Harry Geyer <harry.geyer@devtank.co.uk>
To:     Till Harbaum <till@harbaum.org>,
        Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     harry.geyer@devtank.co.uk
Subject: [PATCH] i2c: tiny-usb: check usb base class before assuming the interface on device is for this driver
Date:   Thu, 27 Jul 2023 09:33:54 +0100
Message-Id: <20230727083354.4903-1-harry.geyer@devtank.co.uk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch allows usb devices with multiple interfaces to use this driver without
this driver assuming all interfaces are i2c-tiny-usb.

Signed-off-by: Harry Geyer <harry.geyer@devtank.co.uk>
---
 drivers/i2c/busses/i2c-tiny-usb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-tiny-usb.c
index d1fa9ff5aeab..d6578e8908ac 100644
--- a/drivers/i2c/busses/i2c-tiny-usb.c
+++ b/drivers/i2c/busses/i2c-tiny-usb.c
@@ -222,6 +222,9 @@ static int i2c_tiny_usb_probe(struct usb_interface *interface,
 	int retval = -ENOMEM;
 	u16 version;
 
+	if (interface->intf_assoc && interface->intf_assoc->bFunctionClass != USB_CLASS_VENDOR_SPEC)
+		return -ENODEV;
+
 	dev_dbg(&interface->dev, "probing usb device\n");
 
 	/* allocate memory for our device state and initialize it */
-- 
2.34.1

