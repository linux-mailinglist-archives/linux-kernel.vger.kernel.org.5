Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FFD7819BC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 15:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjHSNd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 09:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHSNdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 09:33:55 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B980260BE;
        Sat, 19 Aug 2023 06:31:46 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf48546ccfso7660445ad.2;
        Sat, 19 Aug 2023 06:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692451905; x=1693056705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=354r1E8RomJOmLTWCsnFrWN7S2WMC4vNevjDGwZilNU=;
        b=FKItqNn7h6xWPDCRRcOmc9Ez68Wlegq31PhjXmfE4aBe1zGReLec7/vKM3nJtqV/T5
         829EDrd2xlqVK8Tw3nM20/B3p1DNQLLEbNdF91Eyz/WH1w7UEqNan0Kq8R9XQ6jNDjHh
         RnLEZz0S9PdfnsU0izgs40JpcIGM7pXpTx4/qpx7ZGxtvZ2pLUmJKfekLl6V0yP2eIvJ
         18Y+YmpU+4IzBF38SRWHzI92pOS1O4AsZVnlGVYM6pvSfBMpm1CgfcfQ6KhVFoIB3K8e
         9IU5Tbb/hqFzwnMVt2fTO6FmDEfllVLKcVVj5I0wT9n6zZs6WBZWm9uC7jFGB/UabfYG
         KVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692451905; x=1693056705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=354r1E8RomJOmLTWCsnFrWN7S2WMC4vNevjDGwZilNU=;
        b=hu+rNb+ftIkHEIKNw8drECwwleM2elv3bZjdRkl0pshNT3E9K7FpD2aXflfvMk+5ay
         wLsX3f0r0cLkiFjkRpMZAyCrP5bR22ukOCjlVr5ezf8wuuyaGcUWNTUr5pwRNQxw+wxp
         jcmPg51NniHEsDIKUS94e6rE2LE7Qf5tZDo7AdtXACmOFJUqJ8JNfpqW48BZOMl5WJnE
         bmnjggYpOhrDH7Gvm28mCyPPOrW5uthtG9Ca6wI8TtQYGcZ5o61T/H55goUk9zil1RtL
         7ieag+uCAORCCsRNpDFdYL3FIV1OhCPT59DTjBieezteWwVw/9d0XpA5XJZYZ7L5zXlZ
         b8ag==
X-Gm-Message-State: AOJu0YxfLF+ugyDK+JWh3i1zH9yVJjwP/54R+Joe2P05RZa1mfC9pNeB
        4ACg3Rzot5Q64d7oUOSdve4=
X-Google-Smtp-Source: AGHT+IEA9QHCXPRr5498UeC9TcMCKSHe0MOr/n/QkY6SbexlkQEyoRyTDDVMGC1CFHCymOKfzzgTLA==
X-Received: by 2002:a17:902:b709:b0:1bd:a0cd:1860 with SMTP id d9-20020a170902b70900b001bda0cd1860mr1207022pls.64.1692451905279;
        Sat, 19 Aug 2023 06:31:45 -0700 (PDT)
Received: from archlinux.srmu.edu.in ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b001b8b26fa6c1sm3663786plk.115.2023.08.19.06.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 06:31:44 -0700 (PDT)
From:   Anshul <anshulusr@gmail.com>
To:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org
Cc:     Anshul <anshulusr@gmail.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, anshulusr2@gmail.com
Subject: [PATCH] fixing ERROR: Macros with compex values must be enclosed within parentheses
Date:   Sat, 19 Aug 2023 19:01:13 +0530
Message-ID: <20230819133115.23048-1-anshulusr@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Anshul <anshulusr@gmail.com>
---
 drivers/media/usb/uvc/uvc_driver.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 08fcd2ffa727..8d3bcd18b652 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2417,9 +2417,8 @@ static const struct uvc_device_info uvc_quirk_force_y8 = {
 	.quirks = UVC_QUIRK_FORCE_Y8,
 };
 
-#define UVC_INFO_QUIRK(q) (kernel_ulong_t)&(struct uvc_device_info){.quirks = q}
-#define UVC_INFO_META(m) (kernel_ulong_t)&(struct uvc_device_info) \
-	{.meta_format = m}
+#define UVC_INFO_QUIRK(q) ((kernel_ulong_t)&(struct uvc_device_info){.quirks = q})
+#define UVC_INFO_META(m) ((kernel_ulong_t)&(struct uvc_device_info) {.meta_format = m})
 
 /*
  * The Logitech cameras listed below have their interface class set to
-- 
2.41.0

