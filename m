Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A003D7ACB95
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 21:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjIXT0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 15:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXT0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 15:26:20 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7935CF1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:26:14 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c136ee106so620059666b.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695583573; x=1696188373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mum4j91XFiU8Xtc7TFcTf1fNSOJNvZg3YC6vHA1cwnU=;
        b=LY3+1dk8HrHF4rSpTubxtCSPDupXd7gXn1n9NhqAa6q5/SMgfpFZOOxXs3M7PpetUz
         1ysiPHW8behtpiK6yX7GxV5mMyM0uQ9KksNBZZl9B6OzZAtkQqAsoSgBs9WjJSxb8PR6
         i2Vop0i/Fg43YxrFHCL1UjAHxur9dIlhumsHvRXLDeMS7JJ+xBEitScWoNdSTZRtqi/9
         mG0XyKVae11yrY5BLxqL+AuvL6yIM4UhkbpnFIIbP06aFIIqi+fIBV6dJRSlZ95jMWK6
         SwMlbZeUmjGnxKzXX+aXiQjNpRuizpTTA4hCmNjq5kHgwd7e+hP2aRnUkRvsXELJV0MU
         HPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695583573; x=1696188373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mum4j91XFiU8Xtc7TFcTf1fNSOJNvZg3YC6vHA1cwnU=;
        b=bCgdiJmz3X57jihoxPfqP67m87dz71qVwsmDv6QV7j/RVi5uCPO+LdeTkktwarUNQK
         aKWvOj9W/4n+p4vr7I42tIL3TbNGxwIc68VkokR7zftUqMbmD4dOGmQiQbqZvCEP+yxO
         MwQJ0cXdz6Q3koXX5oPb7QT4ARJ/cxt8VDDfitbzvjR2hEdYQBwSCa4fqhGyaXX5pIaB
         4ax4yytJIO7mpFKYfJ/VdU2K9VKGYa0a5phvohVcuaAfqeXmKnVbzZZu2YcdsAy2dI4r
         Xot3OpQlreglk7RHC5+wlMZQfj7WVYxMdLv1O9hYJM1YQgzpGods7UeFN57MV0EBKhnb
         JUrA==
X-Gm-Message-State: AOJu0YzuZFmuacOn+iHlWt+s6THcZQEsPugrMV98v0wkqeTlqzjN1auq
        X26uNYRsucal/ZBExkOVFSDaQ/b0omedgA==
X-Google-Smtp-Source: AGHT+IHXITx2ykaLrpQKUUcUVgZplQwvgEedTJsw9ydWxvo2fANUWEHTFIz/szbg85S67tayV/onBg==
X-Received: by 2002:a17:906:31ce:b0:9ae:6ffd:be12 with SMTP id f14-20020a17090631ce00b009ae6ffdbe12mr4738928ejf.76.1695583572612;
        Sun, 24 Sep 2023 12:26:12 -0700 (PDT)
Received: from localhost.localdomain (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id z21-20020a1709063a1500b0099d0c0bb92bsm5317632eje.80.2023.09.24.12.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 12:26:12 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     airlied@gmail.com, daniel@ffwll.ch, samuel@sholland.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 0/7] drm/sun4i: dw-hdmi: Fix initialization & refactor
Date:   Sun, 24 Sep 2023 21:25:57 +0200
Message-ID: <20230924192604.3262187-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.42.0
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

Main goal of this series is to fix race condition between probing display
connector driver and sun8i dw-hdmi platform driver. Sometimes, boards have
ddc-en gpio specified in DT file. This is handled by display connector
driver since commit 920169041baa ("drm/sun4i: dw-hdmi: Fix ddc-en GPIO
consumer conflict"). However, because there is no link between it and
sun8i dw-hdmi driver, probe order isn't determined. If display connector
driver if probed afterwards, then sun8i dw-hdmi driver won't be able to
read EDID and thus fall back to 1024x768. This can be easily solved by
using bridges and linking them together. Coincidentally, switching to
bridge model is also long term goal.

I found out some other issues when working on them (missing phy deinit and
memory corruption during executing fail path). Since there is now a bigger
chance of deferring probe, it's also good to skip reporting deferred probe
as error. This often confuses users when examining dmesg output, especially
if there is no error code reported.

I also throw 2 refactoring patches for a good measure.

Please take a look.

Best regards,
Jernej

Jernej Skrabec (7):
  drm/sun4i: dw-hdmi: Deinit PHY in fail path
  drm/sun4i: dw-hdmi: Remove double encoder cleanup
  drm/sun4i: dw-hdmi: Switch to bridge functions
  drm/sun4i: Don't show error for deferred probes.
  drm/sun4i: dw-hdmi: Split driver registration
  drm/sun4i: dw-hdmi: Make sun8i_hdmi_phy_get() more intuitive
  drm/sun4i: dw-hdmi: check for phy device first

 drivers/gpu/drm/sun4i/sun4i_drv.c      |   3 +-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c  | 191 ++++++++++++++++++-------
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h  |   9 +-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c |  13 +-
 4 files changed, 151 insertions(+), 65 deletions(-)

-- 
2.42.0

