Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D9A77008E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjHDMxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjHDMwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:52:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C86EA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691153527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=E5xN1heImVZNR+PxjfKlixHWlk07JRG1661WVNvOkoo=;
        b=dC/C6vN3pAtzDR1YqpphPmudglUwa3b0kk2LKExylzecNesa7WXBW1cfOb9IrZGHMuZ4Y0
        z0dKPrw1JWdGH6DU7BnOSaKrJNyAiKoysNxtvw+SVvXyiPnGX6PRB5k8ZO48qFnLUR6LPb
        jNMeeEt6uNx8PfXUjAVPQQyKsEAVlkM=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-ZWXo6tyINP6KCDy65oeZJA-1; Fri, 04 Aug 2023 08:52:06 -0400
X-MC-Unique: ZWXo6tyINP6KCDy65oeZJA-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-56c8f0995faso2824183eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 05:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691153525; x=1691758325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E5xN1heImVZNR+PxjfKlixHWlk07JRG1661WVNvOkoo=;
        b=bFzkAqzrUtaMIRc6BI96zw313QWub7kFdjJLGvB5HZ0xtKgDYgvJYxCbZwieIONsAg
         eSKnIbx5V/Cjgax16oMk/TkYA2ryRuiHTXuPG7DI4HTDBEsa3Aa/UQZQsYd6shfuNLi7
         8rntXM5DDUKqxaT+ffH9bvmSoxl1S1U+JbOIJypdLJO6EcUw3igbparkPc9yoddfZwN1
         +8Nws5wHJuY2JxhRn4YM/xKzDp0s4czCp+FumfvB0/hzo1NnZPZBh+IFa4CGFJWiXdQI
         60jD2veBc10UUE1wpRKvtp1dReq7ZyNCJDSXqg3IcLIaCVy8WrgaTkyS2t0V2/doN7St
         ZyAw==
X-Gm-Message-State: AOJu0YwnDcUtye5yG2kkmZ7e+mND9/TffvdSvxINq44h7xnqJdt1vpKc
        rgVjBTce3+uByUOPfV/dY+M2VQJuuxoOR9mXJJd5lE/3+fQt9Esx5paYGjeX+k72lvs3yi/iVVn
        eLArFHUNXF2ksy6TnaFd5tPpLZM4tvi2q7kCij9y3nPYx4BGtEBsDorRipPTFwsg2OcI80VNs9B
        ahrj68IXo=
X-Received: by 2002:a4a:3018:0:b0:56c:7428:4a35 with SMTP id q24-20020a4a3018000000b0056c74284a35mr1492090oof.7.1691153525543;
        Fri, 04 Aug 2023 05:52:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOrbC6e26HbOemq9s/V8xZIA7GMJmKyBDN30iDQnRLjJ8J9R4Y4jCYk1e12SwM9ZEwgrCyCw==
X-Received: by 2002:a4a:3018:0:b0:56c:7428:4a35 with SMTP id q24-20020a4a3018000000b0056c74284a35mr1492063oof.7.1691153525185;
        Fri, 04 Aug 2023 05:52:05 -0700 (PDT)
Received: from minerva.. ([181.120.144.238])
        by smtp.gmail.com with ESMTPSA id r19-20020a4a3713000000b0056c589d98bcsm942085oor.1.2023.08.04.05.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 05:52:04 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>, Helge Deller <deller@gmx.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm: Drop select FRAMEBUFFER_CONSOLE for DRM_FBDEV_EMULATION
Date:   Fri,  4 Aug 2023 14:51:43 +0200
Message-ID: <20230804125156.1387542-1-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit c242f48433e7 ("drm: Make FB_CORE to be selected if DRM fbdev
emulation is enabled") changed DRM_FBDEV_EMULATION from 'depends on FB'
to an effective 'select FB_CORE', so any config that previously had DRM=y
and FB=n now has FB_CORE=y and FRAMEBUFFER_CONSOLE=y.

This leads to unmet direct dependencies detected for FRAMEBUFFER_CONSOLE
as reported by Arthur Grillo, e.g:

WARNING: unmet direct dependencies detected for FRAMEBUFFER_CONSOLE
  Depends on [n]: VT [=n] && FB_CORE [=y] && !UML [=y]
  Selected by [y]:
  - DRM_FBDEV_EMULATION [=y] && HAS_IOMEM [=y] && DRM [=y] && !EXPERT [=n]

Arnd Bergmann suggests to drop the select FRAMEBUFFER_CONSOLE for the
DRM_FBDEV_EMULATION Kconfig symbol, since a possible use case could
be to enable DRM fbdev emulation but without a framebuffer console.

Fixes: c242f48433e7 ("drm: Make FB_CORE to be selected if DRM fbdev emulation is enabled")
Reported-by: Arthur Grillo <arthurgrillo@riseup.net>
Closes: https://lore.kernel.org/dri-devel/20230726220325.278976-1-arthurgrillo@riseup.net
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index b51c6a141dfa..2a44b9419d4d 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -135,7 +135,6 @@ config DRM_DEBUG_MODESET_LOCK
 config DRM_FBDEV_EMULATION
 	bool "Enable legacy fbdev support for your modesetting driver"
 	depends on DRM
-	select FRAMEBUFFER_CONSOLE if !EXPERT
 	select FRAMEBUFFER_CONSOLE_DETECT_PRIMARY if FRAMEBUFFER_CONSOLE
 	default y
 	help
-- 
2.41.0

