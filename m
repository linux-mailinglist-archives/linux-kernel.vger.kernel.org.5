Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4217D2D7A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjJWI7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJWI7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:59:40 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7593CA9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:59:38 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9ba081173a3so480097266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1698051577; x=1698656377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VbdXqKvA2Y0zCIBWONAIVfrMXAjxSoe95dhuJargRKw=;
        b=Yzvzgawl/phAxNeXKOn8Hz0lMRvZwt49CH9cGiTJm8a9g8tOZGRypvfmA8o1OPCX9C
         0Cml0Cgkn4VExUHc+F8YHQcByNtTJDUBCMFkUDTL8s6rthbfDrObaQVM9yMY9zykFZNE
         Ik1bu6aFjTOqHIZTs26ZHhmTATOsvCu/U3QsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698051577; x=1698656377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VbdXqKvA2Y0zCIBWONAIVfrMXAjxSoe95dhuJargRKw=;
        b=H5ZXfDXL9L1EE9i+fmGOiucS/4roo99058y+4HVQ0i/VKdzGAo6JEQG/2SpI1z+M0G
         u22t+pN+qqjCz5UDoPHbpDdOaE54d4ugMrhPCdDacGSqoljPg/aNZO4SK3J3DiUJMT39
         uHpjj7I66RShlbzd8ET+fyWfwh1+JnbiXq4AkhcdeI0iAXC43U12J0bj2678l0oRMOrd
         tsjXYvkWIrSsfSpJSUrnICLXk+U/oo4kCNLBhkJpFLVowxGUaSqsqpseLUZH8ua1t4Nd
         K3+A3JQMnWmpdg30qm+DL3rUa1sj1VyGtEFACDc3fgWduaLR3cXLLdTnsKHKURNLbQDx
         kNxQ==
X-Gm-Message-State: AOJu0Yy0hF3pvcoZ0knqNDjiQzfdgGfZQeZIuFkgLAxBdoSh+s9F3Hdp
        t2Tgl7wRwjDl81ZOJ6nJyo2vzu6+B0bga6eGhy6n3Q==
X-Google-Smtp-Source: AGHT+IGbg5QcU0DjrvPCObdFUlShdpICf56Kh9iholS/vlhdNv1ZfG7Ejps4qYeKELnBRssKzwAjVw==
X-Received: by 2002:a17:907:1b0a:b0:9a6:1446:852c with SMTP id mp10-20020a1709071b0a00b009a61446852cmr8053693ejc.27.1698051576727;
        Mon, 23 Oct 2023 01:59:36 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (host-79-45-223-184.retail.telecomitalia.it. [79.45.223.184])
        by smtp.gmail.com with ESMTPSA id t11-20020a1709066bcb00b009be14e5cd54sm6268332ejs.57.2023.10.23.01.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 01:59:36 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Emma Anholt <emma@anholt.net>, Eric Anholt <eric@anholt.net>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/vc4: fix typo
Date:   Mon, 23 Oct 2023 10:59:20 +0200
Message-ID: <20231023085929.1445594-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'pack' with 'back'.

Fixes: c8b75bca92cb ("drm/vc4: Add KMS support for Raspberry Pi.")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/gpu/drm/vc4/vc4_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_regs.h b/drivers/gpu/drm/vc4/vc4_regs.h
index f3763bd600f6..8ac9515554f8 100644
--- a/drivers/gpu/drm/vc4/vc4_regs.h
+++ b/drivers/gpu/drm/vc4/vc4_regs.h
@@ -588,7 +588,7 @@ enum {
 # define VC4_HDMI_HORZA_HAP_MASK		VC4_MASK(12, 0)
 # define VC4_HDMI_HORZA_HAP_SHIFT		0
 
-/* Horizontal pack porch (htotal - hsync_end). */
+/* Horizontal back porch (htotal - hsync_end). */
 # define VC4_HDMI_HORZB_HBP_MASK		VC4_MASK(29, 20)
 # define VC4_HDMI_HORZB_HBP_SHIFT		20
 /* Horizontal sync pulse (hsync_end - hsync_start). */
-- 
2.42.0

