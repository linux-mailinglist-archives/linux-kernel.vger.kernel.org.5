Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0084F7C74B7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441834AbjJLRYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379688AbjJLRWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:22:54 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77883D43;
        Thu, 12 Oct 2023 10:22:15 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-35164833a21so6127265ab.0;
        Thu, 12 Oct 2023 10:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697131334; x=1697736134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SAgGhvFgEq3ojom6jJPWJ2MyF/faZd9tWGs5HOFcQQ=;
        b=lh4FDLkPSbvrHNVjRmVV7pmZ9kqVhC9jy2lcFhfkeidHRf5j437mQcf63e28YkdEUM
         oxZk8v9LeMme6n9R2pomHkd/fqzwdjKB3EsCdUHRNQgQT4QQqLHVJ4uWJSBJ9AH79Uyx
         WXMHp8uVg8sqwv9cUhsj+AfDxLa/l7uipMeZU6rzoAdtx0VjMq6TmJzqbPeQSZJzmmc7
         gSnq12oOeaZYC174rUaINQgFWLwP8cY8AN8UTnBBQPU1Iz+oWTZCPyI4JOB0Zh7TnSxg
         AraNvKQ1XOYkM0tsEvZhwYYJJVoNeB2gkXzWlkcsuzHyYWDWTaaIwXkfXU5GVkz+luI0
         s5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697131334; x=1697736134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SAgGhvFgEq3ojom6jJPWJ2MyF/faZd9tWGs5HOFcQQ=;
        b=RIH7iDgFkM25iq7r3XU3GWM3z6PAEKvyKEi7/OkhlTPwIDLpGhcNvUgia0+M1ZNLg2
         waHTAU9OK2ckofbLl/zYAnk9NG6LmTpFJJSzi2kv1vAlHsK9fowDk7jilcXa5D/etJE5
         NIxGST3C0I4hZBS8ZdeWF+v1hou80sGVpMJjJoLyXSSpdyP1Mtac2faHwxB0HRq/tPWS
         9qLqmF7AP20InjdRGIhpy7SroQYm/rTK2Us4/n28o5NB6zfwJvY1Rijo4RW/F2TM5pGU
         m/wyWuV8SmOKy6yiWJgMaxIqBK1S2KwpJYLpNw1ge9UIvCvISBHg9Bt6K7hHHbflyDSb
         PgbQ==
X-Gm-Message-State: AOJu0Yyu8WeYh3Bl4ndis3Seg8ycaaEyCC/zGtfli4ZGpwVV54o499En
        bKlYxKwTzHAtdg8Ka5awcnAthyqSAB/oPQ==
X-Google-Smtp-Source: AGHT+IFPm6eWNwHlUkCkTorLX2j6xlNTrcGNhrv2lw5AFfWnMiFPK9F+JbAQzRVXyvhlKNHyrGyDRA==
X-Received: by 2002:a05:6e02:20c8:b0:351:35d9:f18f with SMTP id 8-20020a056e0220c800b0035135d9f18fmr16703410ilq.2.1697131334353;
        Thu, 12 Oct 2023 10:22:14 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id r25-20020a028819000000b0043cef0711c1sm3992211jai.158.2023.10.12.10.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:22:13 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, groeck@google.com, yanivt@google.com,
        bleung@google.com, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7 25/25] drm: restore CONFIG_DRM_USE_DYNAMIC_DEBUG un-BROKEN
Date:   Thu, 12 Oct 2023 11:21:36 -0600
Message-ID: <20231012172137.3286566-26-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012172137.3286566-1-jim.cromie@gmail.com>
References: <20231012172137.3286566-1-jim.cromie@gmail.com>
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

