Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AF87528E6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbjGMQiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbjGMQhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:37:24 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48242719
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:37:06 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3463de183b0so3825285ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689266226; x=1691858226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tc9Brh2W3dPQvcqCOoVpte1ruNYD5JWFtpqITlawe8U=;
        b=VsfyQKiLjbzKK/SahsmLfJl8Z5jeUynfr0CGupnuqwUvhXarUNFxb4dr2w1hr+uGyT
         s7PuO6sZxBKzI85rB0M97T7GRy4O6xyqTT5e7Fw9ikPjgU4ipxt1Qz9iHBFfW/yDOTRl
         ckLv3sT5eUP2QZTIZrP9F5b6dhLZPm/ABHMG6573blneUR6G0Ye+wsj1MMCbZJxoKxC4
         LqY7RLUKs9KWXWuIay4vywY5Z8jeU42vhb1vepjVcJWtPe5cQMDZbWwAVVBQJXHQW9gv
         1RhkzAb/nIU6ZLKkOg3TePjFGtilKseYtyWY2vBL01JW7jw68B9zDC+7Ipfqxd2mYpL4
         J9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689266226; x=1691858226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tc9Brh2W3dPQvcqCOoVpte1ruNYD5JWFtpqITlawe8U=;
        b=VV1c2AkDaz4qydR6lu0MfBpkq5bYswGAOjHJY9FZKCxSiAm4J0cHJk4omzBtTghN9f
         2RyBH1OXu5/joPzfzzl2O3hj5gJzWrCiMNTOUBZCuuTG9DU8DXx8PcZoI89V5JO49Tjc
         NfkwKX7A99tlb9FendVyIx7RSiWpw4O4atGpOH5UKLgaQp7m2ERGjiUJLtCtmmqmu84w
         ChzquoNeK28qWNx5j6d9BQzq6ykKwg/F7qaMmv2FTsUsRsdVU9dPembA/Q//DpTGA4HS
         4BCNlfOzTSdpBqx5sWBAfPHBcYYZ41cajwgBmPIqSdTywChsLQwV1uC9eWc/z1HxM6qU
         Zuqg==
X-Gm-Message-State: ABy/qLY4wnl45lyRBJ6y/qBI6IS0QSRFY2Q0xQ1MTen9Os1+KKU1BJmp
        Ly/Gfgqezk9kIlH1FsE9nzA=
X-Google-Smtp-Source: APBJJlGn4S2QMrp8rhNUQHiN1GoLViDKjpqnclnnpU6cHFyPYGabENfbMJ6YJUwugrBgI/SFhRuenw==
X-Received: by 2002:a92:cd0d:0:b0:346:28e:ebf with SMTP id z13-20020a92cd0d000000b00346028e0ebfmr2059677iln.2.1689266226260;
        Thu, 13 Jul 2023 09:37:06 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id s7-20020a92d907000000b00345950d7e94sm2147571iln.20.2023.07.13.09.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 09:37:05 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        seanpaul@chromium.org, robdclark@gmail.com,
        gregkh@linuxfoundation.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 20/21] config TEST_DYNAMIC_DEBUG default m
Date:   Thu, 13 Jul 2023 10:36:25 -0600
Message-ID: <20230713163626.31338-21-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713163626.31338-1-jim.cromie@gmail.com>
References: <20230713163626.31338-1-jim.cromie@gmail.com>
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

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/Kconfig.debug | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d4fbbcc395d2..82d11ac63758 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2696,13 +2696,14 @@ config TEST_STATIC_KEYS
 
 config TEST_DYNAMIC_DEBUG
 	tristate "Build test-dynamic-debug module"
+	default m
 	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
 	help
 	  This module works/demo's the dyndbg's classmap API, by
 	  creating 2 classes: a DISJOINT classmap (like DRM.debug)
 	  and a LEVELS/VERBOSE classmap (where 2>1).
 
-	  If unsure, say N.
+	  If unsure, say N.  If bored/curious, say M
 
 config TEST_KMOD
 	tristate "kmod stress tester"
-- 
2.41.0

