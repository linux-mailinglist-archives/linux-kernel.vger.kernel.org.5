Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FA0785D0D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 18:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbjHWQNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 12:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjHWQNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:13:54 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA919E74
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 09:13:52 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-48f8890c18eso706752e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 09:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692807232; x=1693412032;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qYDRjZGGnr/gd/Y4NfdXBAYEsXLOeNO0yDjSsAIxxnQ=;
        b=QXVB0hx7nZbR9a/xJxl3SPteIS/xfEPueK2yGQazaEiqkdeUlNElcO6ihxLJx7jCft
         rbnSRC5o7Q9mG1W88nBYn/SMMhxKoN9ADjOKyhLrmA2KvkFACJlpNeJQ/lZyD3d9Pk5R
         CyOEpCVtt+J68VRQ1Rv2Egohr4T9ofueOyvTCO0gzh48C2ji+7gF4ak1j9TdXIPY4j8R
         N9Y51nBsTcr8GlkawNoMz6kMu2sdRo0szqBcFA0hxR1U4SMVM5OuNqeIv9TF3l9tPYfA
         /xpqywWAR9FJKxxGe2jY0o0y+dBLKhE6uMc3XdTnqlTcn9W0z/ki1oT1CjnyUUhLXE1C
         nnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692807232; x=1693412032;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qYDRjZGGnr/gd/Y4NfdXBAYEsXLOeNO0yDjSsAIxxnQ=;
        b=Na73Ns9JN+DbZblX4tynly+/wvnEXX5Ls0QPnpWXxrBsR9wIByi4aaJARPci7iqD/L
         y70K0Wilo2hAIVqZR1jFnlh8G5HkI2B8Qd8VMFW5ftfB4yPuTelIBslAao0AmWJY18an
         bqS8t3ldKqCt6m/QK+T3kiGMn60oY4etg2LCX0qZJoGvLFgpo3zevzZrQgfCZ29ju6Wy
         hE2A+sSUyBfcDR5NYGYEJFyLyTwnMGbXY3MD3VNgJKEPghL+Ydcw/j/Yq+uhDZf6sjEx
         /Y+HiwM1UzFG2CB+8xSTwfU5A4hrih7o4qBGZzOxsBa9IknXyVT7Y2NBwrOuNXy+JiwA
         jCFw==
X-Gm-Message-State: AOJu0YyikJPjvNadbA+WsQ7vwaPS+HQnC+g3lCQZtj395Aff+Ah1TEMb
        jEKOooeZj3oZfsg0dvBL/pRudq8e2Gk=
X-Google-Smtp-Source: AGHT+IHxaYIwgFIbiRSAvQlMoHt8IPyb70oVumD80k6VwpFWQHz9Xk+5kWOSX5un9zocVRmc49k6GQ==
X-Received: by 2002:a1f:e643:0:b0:48d:1cf0:f3c3 with SMTP id d64-20020a1fe643000000b0048d1cf0f3c3mr7131329vkh.14.1692807231772;
        Wed, 23 Aug 2023 09:13:51 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:82ea:8c7c:b784:3f92:988a])
        by smtp.gmail.com with ESMTPSA id u18-20020a0cdd12000000b0061a68b5a8c4sm2255840qvk.134.2023.08.23.09.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 09:13:51 -0700 (PDT)
Date:   Wed, 23 Aug 2023 13:13:47 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH] staging: vme_user: fix check unbalaced braces
Message-ID: <ZOYwO2UivRSo4F4P@alolivei-thinkpadt480s.gru.csb>
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

Fixed all CHECK: Unbalanced braces around else statement
and CHECK: braces {} should be used on all arms of this statement,
because both are related, as reported by checkpatch to adhere
to the Linux kernel coding-style guidelines.

Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
---
 drivers/staging/vme_user/vme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index d0366dd3f2b1..ac98b3da6bed 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
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

