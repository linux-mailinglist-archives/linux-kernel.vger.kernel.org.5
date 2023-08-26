Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D997892BA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 02:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjHZAbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 20:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjHZAae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 20:30:34 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4452118
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 17:30:32 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-76d7224c5bcso86568685a.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 17:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693009832; x=1693614632;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ZyTeNGFnmQqE613GDKmKhvLAFe/AnQBwlsX/erp5GQ=;
        b=lBAbfPJmyYr7D+xhXIJ4YlXKgiw1v/rQRbN7gs6i9aXXb+yHcLxmQO6diIOdHwDr8H
         3JEvbxn/uYkWU88LxZDBF0jDV6Ry3jfFkUSV1i9Z38wNXI0Sr5+bzF0aq2CM0d7qOUy0
         Na/Pcc51GOHtZNfYuhxMdkUR2iI1GHSJPRnhAwcBLzDkuSv5w8yWCiGPhza5v3RRxCei
         xw+sqsZmRAeLqfWQ5jPEyDKTuQRzhmWfzTstc6f70MP/0JCfHfNEr+yvIx2i6y7/InLQ
         TsNObOQVDPmY7eeKrRd4Lk+/zyrwm9ZduKtsBC0tD9SiouW5gdv9niBdgZUEATAaY6tM
         fLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693009832; x=1693614632;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZyTeNGFnmQqE613GDKmKhvLAFe/AnQBwlsX/erp5GQ=;
        b=IXuATpyhecLD0Zas3ihc83CXrbxQK/kZOezanAuQS/nE46pNWgXNbVevWRFQYd59Fy
         zUYt4we9EoQCJOGg2sEDuI7y9hR5XKuy2IxpUv2zPZV6V3Fqf+JYwEk1RY7h9ADmScYB
         o+04pNYnn+NQQ+KKnDLrImh6a8/onvjEs/SGp1654DRFMLslTPIvOSx5/G8X4U7kOwv5
         fXU4PpI3oOshIAI/JENQr7d4N4yT1UYS5DGDmmpy0QB8qRNvzKwqO1igFKgvQyA/dDdD
         s8IkEG7s6KWoWc57cpUkxTiuqrY01q9TIByKd/Nyz57BCkmwNkCxtLxlnGjcKjPhZYRz
         BkkA==
X-Gm-Message-State: AOJu0YwY4IJ2nwsP+F9s4FEwMn7X9OqwGXnWHariA5W3QkXY4rvV1Xmd
        UGpYhqpAiT8zQvNf1UVwd9MQieBmzto=
X-Google-Smtp-Source: AGHT+IHdQMAbKiU8+7Ds3mrCtSx4VtAtS4KB91c27s3l8W/W893AhW7DAtd/kGWb6/gzHLi2XTIGRA==
X-Received: by 2002:a0c:c502:0:b0:64f:69a3:af37 with SMTP id x2-20020a0cc502000000b0064f69a3af37mr7616094qvi.13.1693009831703;
        Fri, 25 Aug 2023 17:30:31 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:82ea:8c7c:b784:3f92:988a])
        by smtp.gmail.com with ESMTPSA id x4-20020a0cda04000000b0063d162a8b8bsm903510qvj.19.2023.08.25.17.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 17:30:31 -0700 (PDT)
Date:   Fri, 25 Aug 2023 21:30:26 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH] staging: vme_user: fix check unnecessary space after a cast
 in vme_fake.c
Message-ID: <ZOlHos18LFnsKg0i@alolivei-thinkpadt480s.gru.csb>
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

Fixed all CHECK: No space is necessary after a cast
as reported by checkpatch to adhere to the Linux kernel
coding-style guidelines.

Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
---
 drivers/staging/vme_user/vme_fake.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index 4258ed6033e7..4ccb16dd0d0b 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -95,7 +95,7 @@ static void fake_VIRQ_tasklet(unsigned long data)
 	struct vme_bridge *fake_bridge;
 	struct fake_driver *bridge;
 
-	fake_bridge = (struct vme_bridge *) data;
+	fake_bridge = (struct vme_bridge *)data;
 	bridge = fake_bridge->driver_priv;
 
 	vme_irq_handler(fake_bridge, bridge->int_level, bridge->int_statid);
@@ -1092,7 +1092,7 @@ static int __init fake_init(void)
 	mutex_init(&fake_device->vme_int);
 	mutex_init(&fake_bridge->irq_mtx);
 	tasklet_init(&fake_device->int_tasklet, fake_VIRQ_tasklet,
-		     (unsigned long) fake_bridge);
+		     (unsigned long)fake_bridge);
 
 	strcpy(fake_bridge->name, driver_name);
 
-- 
2.41.0

