Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2E4784E49
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 03:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjHWBh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 21:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjHWBhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 21:37:55 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037BEE46
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 18:37:54 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-76d92a5e652so302134485a.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 18:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692754673; x=1693359473;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zraoR6noj6EHn4OxAsMlxddazRXBRd6htkpsGGslKZU=;
        b=K2F1f6F5NV6yWhcUB4eipqri8/M+alccOsCDQojhqAzNeJTioZeToDOplHkwDBxogM
         HOqfCXF2QiKC6Hv79y3LsFgI3IRRkWbP+lakXdpoG+wPkVHiXyrpkeAKX5FgcMw9Ez8z
         l9ETtSrsqI55m3C+VgqGAtmeuh5gAA/utlp5PFzIG4ywdZtYCXnbMw+vfxw1u71LdbrI
         QHN5eFjFW69TcN3+ORtjwsOlyEh8KlUs1cb8sUPkoYAXo4Rvdb3CKtCudksgGMJd/JYR
         vdnc+AWryCmHRqeBjhbBXWoTSpmKwSdnT0C2DXReXCO1NXziTOPmoNoEAI2yuHiVZuId
         MCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692754673; x=1693359473;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zraoR6noj6EHn4OxAsMlxddazRXBRd6htkpsGGslKZU=;
        b=c0Sf4LyCRsDHo3UHIFc4Wkiqw/5nqgJL4/OJmtcDBEHxLp7BVLWFo2E8Fz/Fbjf7h4
         sUsrffzlz9ZXreP4NiL+833hD69kqwV9qAQnfu322vILFD/GOBRshxkta+kTl384sxJd
         41rv+FZj90x9Wc/wXPu88epS0OICB3XmGvRdAVXdOcyIajTcw8jP5MdtqKuf6HPOg7in
         V0yZxoLs/uNsedqvzA4B7RpZEx3X3z99sL24+4DtIfuTgZD5W/i++falk/OoaDXrb0z6
         Dp6qsIiJ5mP7Z2rzN4QMyOPnhDg7Q9fzXUAsDPhgvZpXQvo/Dp01KQRFTKTfgsEVf1er
         74rQ==
X-Gm-Message-State: AOJu0YwZ6pDXfZZyQZuP3pX/vBCDQZHQyNZIi0x68KNLFI6T1+ZXfoHt
        EuAxC9TY0Im5Et2QwpjKyZV1LPNLfkU=
X-Google-Smtp-Source: AGHT+IEFnJmxAy1A6K2ykvxgVt1zMpjpe2n8UH/M1oai/FvYg42sxPZS3DhfOIQlGUv0K6m8eDqtdw==
X-Received: by 2002:a05:622a:1049:b0:403:b869:9d37 with SMTP id f9-20020a05622a104900b00403b8699d37mr16290637qte.0.1692754673007;
        Tue, 22 Aug 2023 18:37:53 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:86d6:7871:f7e9:8a15:865a])
        by smtp.gmail.com with ESMTPSA id oo23-20020a05620a531700b0076c98dad91dsm3609665qkn.120.2023.08.22.18.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 18:37:52 -0700 (PDT)
Date:   Tue, 22 Aug 2023 22:37:48 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     artyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH] staging: vme_user: fix check unbalaced braces and
 misspellings
Message-ID: <ZOVi7BC4J1PeIjpN@alolivei-thinkpadt480s.gru.csb>
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

