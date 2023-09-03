Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88EA790D88
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 20:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345896AbjICSqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 14:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345583AbjICSq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 14:46:29 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF307110
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 11:46:22 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-79536bc669dso37507939f.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 11:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693766782; x=1694371582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+vShd9z6JIlJdMcVT9ozEMb7ECMtYhQaxypaqn+ojI=;
        b=GWQmeQHcVYcD+Soy3jBcWELYofBOHj0cBarxnmjclgCsxAMjDT1wx8wyLJfze7LUp6
         hZEs+4jYNFGK8ccf1Vpt2VBntJ1cOcS7wNDLCaknHZi/5iuW+UaimRjhctxb6VDOUBhG
         tWmfkKwsTTNrntizmGSy+fWmlkKoUVhpMAvPLLUWJjeTThaoESUkErvxttchimU/tl09
         wTmy0LTCTn87F1gFcgALpGNa3alwfLsOLw/GxA3sFfVW67T9Y+QuqZefJn3mbVpzTYbZ
         BpnK779Jl2t3VavLx7okiufTmRWz4YVodQfZGKRnX8Avn7YHkeTU98NR6MDqxXjEFXxa
         sPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693766782; x=1694371582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+vShd9z6JIlJdMcVT9ozEMb7ECMtYhQaxypaqn+ojI=;
        b=K+UAyKzL3mJxfGbaPmpattH1hWjv8CzAio3RXBGk3J04j2D/ksveUoF63c7SNwN+6Y
         4w221FleWicNhxLVJ3TsTEFcYC0yXNO0rh2lbMa95qipLz0yvYpf9derTUNi3eYqfXrm
         ySPLCWmdnFbO4rGO+rbe244g/E34vGauYIc7eoL2HzTGShW100eSNLYnQm60OytS39zR
         lu8nHRIlONxomXs98AxkBEdL74w6OUx2Zp5cFTAayKoeR3xPXTvuFzRctbyg/ULGT0Vv
         Byb+Gjm3EVCX9XAtebGuhsSDEuazoHL90t6o2tGZ9t4CWBHcW2HzJl/1J3t6QjfNGOTR
         EULA==
X-Gm-Message-State: AOJu0YwexUiEES9x3+XEL3OTe8yShj4UCyIOxA3IY9EzBFNgBeINZJp0
        AXC+JRoxpfRV+Xz3J4w6ZbXLwc1nubfsTQ==
X-Google-Smtp-Source: AGHT+IGqOoyhaY6/BLxjGQwr9jgSrLCBNKR3l+qSBXjy+8E6+buexCVqqyAEqMiNiyX8+oyGCVjU2Q==
X-Received: by 2002:a05:6e02:e12:b0:349:9993:f223 with SMTP id a18-20020a056e020e1200b003499993f223mr8706895ilk.23.1693766781766;
        Sun, 03 Sep 2023 11:46:21 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id u9-20020a02cb89000000b0042b37dda71asm2519968jap.136.2023.09.03.11.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 11:46:21 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, daniel@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, Jim Cromie <jim.cromie@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 6/6] drm: use correct ccflags-y syntax
Date:   Sun,  3 Sep 2023 12:46:03 -0600
Message-ID: <20230903184607.272198-7-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230903184607.272198-1-jim.cromie@gmail.com>
References: <20230903184607.272198-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Incorrect CFLAGS- usage failed to add -DDYNAMIC_DEBUG_MODULE,
which broke builds with:

CONFIG_DRM_USE_DYNAMIC_DEBUG=Y
CONFIG_DYNAMIC_DEBUG_CORE=Y, but CONFIG_DYNAMIC_DEBUG=N

Also add subdir-ccflags so that all drivers pick up the addition.

Fixes: 84ec67288c10 ("drm_print: wrap drm_*_dbg in dyndbg descriptor factory macro")
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 7a09a89b493b..013cde886326 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -3,7 +3,8 @@
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
-CFLAGS-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
+ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)		+= -DDYNAMIC_DEBUG_MODULE
+subdir-ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
 
 drm-y := \
 	drm_aperture.o \
-- 
2.41.0

