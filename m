Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D11784E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 03:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjHWBkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 21:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjHWBkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 21:40:20 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAC5E4A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 18:40:18 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40f0b412b78so33049481cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 18:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692754817; x=1693359617;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zraoR6noj6EHn4OxAsMlxddazRXBRd6htkpsGGslKZU=;
        b=fWg0LeIFzL2SjtZ/Zs08cqTOtvQLhPzigv0rCgI0QES9ET0nvcE3j9xRxQGjTfDjeu
         56W7LVAGAZN1MrSpR/9D9ssPgKTXKpC2dSA5RKkfBLbKbpBX+6klmsZzSiK6Oj6YyzGA
         hOqTm8Rvq52+cyZkX8cDkskknPAkVLKKt4B0rfPAGMgLzq2uDBvuvgvro9dB+TtRQDtd
         ChJRbb+uRdRjNlqVUsUn3EqLerZi+gDAU9+mzFmuZ8z6o0WrncX08N6cbqrB/E4IX5gK
         ENYmhROjLyFBFdbt83U2hMByqlFM8rh8oj3iAGWzz+bt9NNLsPNLcyqFHjfTCrwNbKIh
         dLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692754817; x=1693359617;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zraoR6noj6EHn4OxAsMlxddazRXBRd6htkpsGGslKZU=;
        b=HJsxGYB+ScTPjP05Nb16YgCkKBuV7RdlR+hbMUMqM8Tls7N2LYlVRKdtcbsP4A6XZx
         LEq8nNVujLzKvbRm7jiVVSRJjuC3zPlWk/x22eGshcJawQuQMjK3St8Oofqeo2hKkgfR
         V7ya9vJkWIhmp4HVfvSTvmVT5Cz3jgeZz3MzU3KotpChl/ARCrdtlTgSvJD9B/U4dRAF
         ouSmAMXxUmmqyaYB9b26tZntBLQTVQtgpqXUGcOt2lPdajgtOmHSVjXwBaWSARumxpw9
         ImfeiEuXipV6kGlpCxPXSQK+N5ofvK6I3tc7MJx4c8fspcGTueTX5fDnhkUUZkj1v99I
         eBWA==
X-Gm-Message-State: AOJu0YytO83+4038TUolp84OxvYNcIlIGFgNkQ1RdzjUEzEp9Qtq462q
        YnlUTqQQl2qWilB0e6CIN7s=
X-Google-Smtp-Source: AGHT+IEehiBC36QHK7hjy0nsRp/qMs3yoSpmxdLVVILKewOE5Gvwq/5sDUAMm3sNn1wuiqhAhMaSwg==
X-Received: by 2002:ac8:57d0:0:b0:403:a91f:7b79 with SMTP id w16-20020ac857d0000000b00403a91f7b79mr16650881qta.20.1692754817432;
        Tue, 22 Aug 2023 18:40:17 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:86d6:7871:f7e9:8a15:865a])
        by smtp.gmail.com with ESMTPSA id t5-20020a05622a148500b004116b082feesm40149qtx.75.2023.08.22.18.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 18:40:17 -0700 (PDT)
Date:   Tue, 22 Aug 2023 22:40:12 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH] staging: vme_user: fix check unbalaced braces and
 misspellings
Message-ID: <ZOVjfKUWsSAkbpZG@alolivei-thinkpadt480s.gru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed all CHECK: Unbalanced braces around else statement,
CHECK: braces {} should be used on all arms of this statement,
and CHECK: 'specificed' may be misspelled - perhaps 'specified'?
as reported by checkpatch to adhere to the Linux kernel
coding-style guidelines.

Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
---
 drivers/staging/vme_user/vme.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index d0366dd3f2b1..1e11047acf54 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -1620,7 +1620,7 @@ EXPORT_SYMBOL(vme_lm_get);
  * @callback: Pointer to callback function called when triggered.
  * @data: Generic pointer that will be passed to the callback function.
  *
- * Attach a callback to the specificed offset into the location monitors
+ * Attach a callback to the specified offset into the location monitors
  * monitored addresses. A generic pointer is provided to allow data to be
  * passed to the callback when called.
  *
@@ -1655,7 +1655,7 @@ EXPORT_SYMBOL(vme_lm_attach);
  * @resource: Pointer to VME location monitor resource.
  * @monitor: Offset to which callback should be removed.
  *
- * Remove the callback associated with the specificed offset into the
+ * Remove the callback associated with the specified offset into the
  * location monitors monitored addresses.
  *
  * Return: Zero on success, -EINVAL when provided with an invalid location
@@ -1866,8 +1866,9 @@ static int __vme_register_driver_bus(struct vme_driver *drv,
 		if (vdev->dev.platform_data) {
 			list_add_tail(&vdev->drv_list, &drv->devices);
 			list_add_tail(&vdev->bridge_list, &bridge->devices);
-		} else
+		} else {
 			device_unregister(&vdev->dev);
+		}
 	}
 	return 0;
 
-- 
2.41.0

