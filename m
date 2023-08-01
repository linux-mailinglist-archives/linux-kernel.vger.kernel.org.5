Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17D076BA3F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbjHARDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbjHARDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:03:09 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9EB2103
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 10:03:08 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-790cadee81bso16451539f.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 10:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690909388; x=1691514188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EpDVIlDX2H9hcBKUU2bnV2uAgz8tLVHVeXAEtG+jYc=;
        b=EBuJ9EqPoVpoheDdtsOWVahtooQlAWC/0GmlNOPjHSXcBXs3RtWyz0MGpOl0DZe4zh
         4HV0hnWXIIrJsYmaKz8XvDUNzTMyQDhfGG5TEfjT+tpsf6nzPj3P2LuzafdI3kyqroGU
         wEnif67Dn2TzPnBx88OVBRRCZPO4KnV2hL5L312AUzusWTZ8zUjTU2Xk/cEnkdOb9LML
         Ti2qV3ZYguUtIDNp/SmpEEAkjfOEOmvadmdFvWn8h18aVVvochY6bOEJJlyjiJY8aYg3
         QqofLxeXoMuz7w+CVrNw954tOHnNugudCFfnXd6NXxexYYA6PLh9J3TVsxL+ccGHlnzb
         6mgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690909388; x=1691514188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EpDVIlDX2H9hcBKUU2bnV2uAgz8tLVHVeXAEtG+jYc=;
        b=TQUmEB26YJTh89CXGcFjKj2TVg6tpzZwkT8vWKjQmG1VeJr8D0r0TzgDuPMZd7ra41
         eaVYlF2EpeoYZUtu1JeweAZDjDHNxOicTxWULSlQK0JGMo2vS2z0nbHWCQ/1+QycBs8h
         Q+4ByEa2VPf2LfZ+0smvrtXoIrguhSv5za6oXxbd+pRaYudSsJBZ46ElOb10dJ78gX8i
         bao4Tg9DXKLzddH5RmKZLy91Pmfqc6zZ8jeHpxvpsDyMQSJf3elkbY9p4gpXej8kjvr/
         DQRClgcl4uZmcROUcZzUxynPGuJIj/7RV7es7mphKIJCjWDg4UItfDJETGydTZ4YC9Ga
         FTpg==
X-Gm-Message-State: ABy/qLaTCYNvvO136pr+TXPdExmtvZUZe/g0n4tVYrbNGCKyRLBikVtB
        CYBthM/Y0Rou6dhycK3choo=
X-Google-Smtp-Source: APBJJlHD22NIyad1rUCJiM9vnDDanZtWLqeBb86Y7gK7+SSGru+LJO/PR8MDfI6ZS36Oc1EVndTaoA==
X-Received: by 2002:a05:6e02:1c26:b0:348:b910:313d with SMTP id m6-20020a056e021c2600b00348b910313dmr13137612ilh.14.1690909388176;
        Tue, 01 Aug 2023 10:03:08 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id o20-20020a02c6b4000000b0042b144abf71sm3768577jan.179.2023.08.01.10.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 10:03:07 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     daniel.vetter@ffwll.ch, daniel@ffwll.ch, jbaron@akamai.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     linux@rasmusvillemoes.dk, joe@perches.com, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 01/22] drm: use correct ccflags-y syntax
Date:   Tue,  1 Aug 2023 11:02:33 -0600
Message-ID: <20230801170255.163237-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801170255.163237-1-jim.cromie@gmail.com>
References: <20230801170255.163237-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Incorrect CFLAGS- usage failed to add -DDYNAMIC_DEBUG_MODULE,
which broke builds with:

CONFIG_DRM_USE_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
but without DYNAMIC_DEBUG

Nobody noticed because a larger regression emerged.

Also add subdir-ccflags so that all drivers pick up the addition.

Fixes: 84ec67288c10 ("drm_print: wrap drm_*_dbg in dyndbg descriptor factory macro")
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index a33257d2bc7f..670bf046019e 100644
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

