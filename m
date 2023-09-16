Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD0B7A31B1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 19:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbjIPRlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 13:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbjIPRkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 13:40:37 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE615C6;
        Sat, 16 Sep 2023 10:40:31 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c3d6d88231so26728885ad.0;
        Sat, 16 Sep 2023 10:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694886031; x=1695490831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vi+mGijyjbgpVHMNYDnt4aB3+x2apvr+TvA/PakrFOg=;
        b=esSQ/R/UXRrISTnfHGNO5eJpgO8SKyN4lgfZxax+3X90Zm5CQDwaEQxXEQDpc130WD
         z3BmzJ6hSicQ8Ni2xUuroWsSkbqEnFvxgXVOCsFTKqeEGfMIz3ri0DF8kYhmFYtn5bXf
         ouIr57nna95ws/SfzC9aNDBIXyhMq4b7aTCREXbucz4T6Hojqs8XxyN1pKeu/d6+3XQg
         6OdGlhyma0r7EsOzjuTtxozhIInUe7xtqfcLLJ6rf+y4gLG0AukOfjSgabhKyPSWzKqY
         ig1Kw8MxYQNoG9rRKGS0aSA0U6qpKUaWmKIYealR0LarW5tGdYb66t25p/7d+uOnebFb
         XfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694886031; x=1695490831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vi+mGijyjbgpVHMNYDnt4aB3+x2apvr+TvA/PakrFOg=;
        b=RYnuFpemVeI+CDa0MUTr5lPRmmB2+2KDHy0Q/51Bao9e4Y6Q8DZhv0xy1g+5aMOQnF
         d7wbwf//WmS+QcQmgRSUUQqdkJoe9/xj5ueoGh9Tfqf0itXNSs8n5U2s9jzt03+Hfu/O
         hwqWqWiRD6EXivbBhWMgAs6Wv7vDqhj4gGwSmu05L4cnBwv7RMkx1Pf/sJ6eVDtYL9v9
         YigxzQY+9I8or1avBncfoZB8mrfW3ANnwh0PF8Eie9PzfWIrpX3+NpU5jQTBFPjww8Qt
         QNSDicWdiianQxJrEl+1I4ASka10psdeDgY7ymCf+lPCRt7q6DXYsVDWbw0vP9QL6OuU
         bzRg==
X-Gm-Message-State: AOJu0YywiqklHAincxbFCai4UR5eqcpKduJTXcOYvxMdsrfVjylFWEFM
        BHQkM93wk3sOTGh6sbCInGQX7U2mpsc=
X-Google-Smtp-Source: AGHT+IH8exMXQrNZfWnlkftpFAfxhGSTSHdEi/imho30/d9fwW+/BkfTFfS1clrxsaEX1x3M+qucTg==
X-Received: by 2002:a17:903:182:b0:1bc:6861:d746 with SMTP id z2-20020a170903018200b001bc6861d746mr5288831plg.58.1694886031248;
        Sat, 16 Sep 2023 10:40:31 -0700 (PDT)
Received: from brag-vm.localdomain ([117.243.88.184])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090332c900b001bb9bc8d232sm5481513plr.61.2023.09.16.10.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 10:40:30 -0700 (PDT)
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
To:     valentina.manea.m@gmail.com, shuah@kernel.org, i@zenithal.me,
        gregkh@linuxfoundation.org
Cc:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb/usbip : fixing warnings in stub_dev.c
Date:   Sat, 16 Sep 2023 23:10:20 +0530
Message-Id: <20230916174020.3218-1-bragathemanick0908@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some checkpatch complaints in usb/usbip/stub_dev.c

Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
---
 drivers/usb/usbip/stub_dev.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
index 9c6954aad6c8..3a5771f74a3f 100644
--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -495,24 +495,25 @@ static void stub_disconnect(struct usb_device *udev)
 		busid_priv->status = STUB_BUSID_ADDED;
 	/* release busid_lock */
 	spin_unlock(&busid_priv->busid_lock);
-	return;
 }
 
 #ifdef CONFIG_PM
 
-/* These functions need usb_port_suspend and usb_port_resume,
- * which reside in drivers/usb/core/usb.h. Skip for now. */
+/*
+ * These functions need usb_port_suspend and usb_port_resume,
+ * which reside in drivers/usb/core/usb.h. Skip for now.
+ */
 
 static int stub_suspend(struct usb_device *udev, pm_message_t message)
 {
-	dev_dbg(&udev->dev, "stub_suspend\n");
+	dev_dbg(&udev->dev, "stub suspend\n");
 
 	return 0;
 }
 
 static int stub_resume(struct usb_device *udev, pm_message_t message)
 {
-	dev_dbg(&udev->dev, "stub_resume\n");
+	dev_dbg(&udev->dev, "stub resume\n");
 
 	return 0;
 }
-- 
2.34.1

