Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B726A7DDA26
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 01:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376954AbjKAA2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 20:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376967AbjKAA1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 20:27:15 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB37194;
        Tue, 31 Oct 2023 17:26:50 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-357ccaf982eso23042035ab.0;
        Tue, 31 Oct 2023 17:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698798410; x=1699403210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SAgGhvFgEq3ojom6jJPWJ2MyF/faZd9tWGs5HOFcQQ=;
        b=TTnzm5oGw4rcEXJlvZS/FiwonKEtI7xm5JGFHxRP2hCnZ/CEZkuVj9tMaOlOOUoAud
         cQtB87zhV5jUkvUdMfIPSgHdUN0FRAOLw1e/ZEq9Upe8gs5zz1lduoSPrFS7havR/Sd9
         TWKGqWGNEh683ScmLKkKCaIlqGak/TDvp2DvRGAN1Urx6AXlzeGu+ALYkhm5rY4K/Sv5
         WBZjt5ox4ZfWfznDCGsEWQG3bozcnpUrBqPSG8QAYpuObyTOv3SWdu5+Pk4VICaruf1A
         O9wejjD5nSwkkEAiDM+n0snY8Q5k+chdlldgX9m4Nl8bHB07praMNnlhXDeuEIj9Cf3G
         6XfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698798410; x=1699403210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SAgGhvFgEq3ojom6jJPWJ2MyF/faZd9tWGs5HOFcQQ=;
        b=VHunYjUw7YTP9G85bIgAl/+jjkgbnij33EhBDm7xj4sN/jt4KUPHvONs+yNZub+z9z
         Kt3GOT6DrqgaD2cux/ASY1Vi3Qvfj6LeXgI6DYDmrdQH9s/yRVtLYltUgngApAxL7H8T
         Mb7xT+EANYavUZEOCDkx87sL5Yt3hl2PDbSi9abUT1xc5P/l0u61YcXL2qfqFg+Glvpz
         PCMS9RKDBJ0Ot6iJqmdxGq1waPfuTwFQJtH6Ak2JzyzWkdBaZhCtJtbuZMOWH5nPChQH
         nVIhvpi4X5HU+Fz4iO3lh2gXZbOEMS+w7V89wdgy+RBBFr2j0gm3l/dfiiRcpO2s2Z9X
         NhjQ==
X-Gm-Message-State: AOJu0YwXOFP3Io1cDQkybRrhW2oD2Qwp3fDyYwghytDH5+eM+YC3wBy1
        wcIN3iMxpDyzsTkFM3PPOwxgntDpuYODHA==
X-Google-Smtp-Source: AGHT+IFaLMPhKAQDiXwdcpHNHlQB0x4IFVrH9A1QbFz7CNOFwFce//LXq9uQbZHYcyJx7HoGA67UZQ==
X-Received: by 2002:a05:6e02:1522:b0:357:a180:6b74 with SMTP id i2-20020a056e02152200b00357a1806b74mr19332114ilu.27.1698798409806;
        Tue, 31 Oct 2023 17:26:49 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id t1-20020a92c901000000b00357cc8df1d5sm141701ilp.68.2023.10.31.17.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 17:26:49 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     lb@semihalf.com, linux@rasmusvillemoes.dk, joe@perches.com,
        mcgrof@kernel.org, daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, groeck@google.com, yanivt@google.com,
        bleung@google.com, linux-doc@vger.kernel.org,
        quic_saipraka@quicinc.com, will@kernel.org,
        catalin.marinas@arm.com, quic_psodagud@quicinc.com, maz@kernel.org,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, mingo@redhat.com,
        jim.cromie@gmail.com
Subject: [PATCH v7d 23/23] drm: restore CONFIG_DRM_USE_DYNAMIC_DEBUG un-BROKEN
Date:   Tue, 31 Oct 2023 18:26:09 -0600
Message-ID: <20231101002609.3533731-24-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231101002609.3533731-1-jim.cromie@gmail.com>
References: <20231101002609.3533731-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lots of burn-in testing needed before signing, upstreaming.

NOTE: I set default Y to maximize testing by default.
Is there a better way to do this ?

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 3caa020391c7..708f5e8cb205 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -55,8 +55,7 @@ config DRM_DEBUG_MM
 
 config DRM_USE_DYNAMIC_DEBUG
 	bool "use dynamic debug to implement drm.debug"
-	default n
-	depends on BROKEN
+	default y
 	depends on DRM
 	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
 	depends on JUMP_LABEL
-- 
2.41.0

