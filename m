Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EBC794383
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 21:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244101AbjIFTDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 15:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244016AbjIFTCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 15:02:40 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0545198E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 12:02:36 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-34baf19955cso600355ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 12:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694026955; x=1694631755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usLeqXzE5U9X3mWlGIhl2wkCPYgPL1jt55C0ImyryHk=;
        b=i6xDD73aweOnWOaN5tMndgFCj6NAz+oicYJ5DIF9MMMK+n2+ddEL+DnzirpCT9vk0e
         QnclEjO0AsZnbsyEtmMX8iqXJdQHL/5dc77Lp6YleG3/OnG6dvw76/TC11CqgtpTW32F
         c/gHsh/yxWDslbPecRrmW+lweZUfbWYDFxZdf3AZbFbe4FR/xpslSdWa6aiKJCwHsz05
         JgQZ9egekvJGeQnDJriOwQR2YI5gSVzbcDanxyUOUpwriutDOay4ecr6m4pJEaplJPYH
         KXMGUh7k+o/Vi3I06BBmmobSleo1mmzAKypcuMC0w5VHW308+yt7MB1eFYWV5HHFj71v
         WZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694026955; x=1694631755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usLeqXzE5U9X3mWlGIhl2wkCPYgPL1jt55C0ImyryHk=;
        b=PGS5jK6qcr5t1BysDiF6FubnTLMePK029uoU5pcH0AQZ0AQHvpBQJGbq5zWyKXZGjd
         q7LGzIHH1ww+llJQASiQHp3JUtuZZ65I6LABMjzqOUHF4L5T28oJtyFOwS07B7wzLsg4
         4H+cQruBuLZF+ouj7ym91dIzja7A83iGl9N3i0HSwHFC4cJMRhnfmustARkI/R6UGN4N
         na/5R8h3UUUteVucyyX1gkUklTjjUPxBp1W7I04N7avGUxTDi/jh+ngIWtylnxn6fr/4
         rdar9UjpoxwdzGZk6gAMdjYNQxK+WOlxq2y5b2AAfjnu2p/zeTXMENmnw6t2UDXkxRQE
         hU6w==
X-Gm-Message-State: AOJu0Yxzjol/csYhePZClnentwlIsd4/FF8hsmpHd/hS+EVKepTydQT4
        LN+O5V8JArnxII8VJO3Pzl1IepNMBsPcgA==
X-Google-Smtp-Source: AGHT+IFTPVrAnUWjjhREw0Hvr2AR0rY8UkvdcnI2CamAN17ipmhg22bz+NrpSLLjzXAWDFV8FZHQ6Q==
X-Received: by 2002:a6b:dd0b:0:b0:791:16ba:d764 with SMTP id f11-20020a6bdd0b000000b0079116bad764mr18373492ioc.16.1694026955566;
        Wed, 06 Sep 2023 12:02:35 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id w11-20020a5d844b000000b0076ffebfc9fasm5152306ior.47.2023.09.06.12.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 12:02:35 -0700 (PDT)
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
Subject: [PATCH v3 5/5] drm/Makefile: use correct ccflags-y syntax
Date:   Wed,  6 Sep 2023 13:02:23 -0600
Message-ID: <20230906190224.583577-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230906190224.583577-1-jim.cromie@gmail.com>
References: <20230906190224.583577-1-jim.cromie@gmail.com>
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

Incorrect CFLAGS- usage failed to add -DDYNAMIC_DEBUG_MODULE when needed,
which broke builds with:

CONFIG_DRM_USE_DYNAMIC_DEBUG=Y
CONFIG_DYNAMIC_DEBUG_CORE=Y
CONFIG_DYNAMIC_DEBUG=N

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

