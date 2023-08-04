Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847AB770A8A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjHDVJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjHDVIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:08:52 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F4A4EEE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 14:07:35 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68336d06620so2327511b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 14:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691183254; x=1691788054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpU2xFaaF3Xyb1VXPjBfCVgipxCUGfroeAS7mPX+g1w=;
        b=cEUGE6wsJwsRZHdJ/r0L0sZaGTK5F3K/xw3fxbwU4+7awGdBhuIueX5dlIc0n8u+cg
         54pS6miJSNZg+HoThr4CiTgxUdnVx39P/JieL0ooRs8tEAK+ereTgwxpTjgeU3zSxmS+
         UIbWy6KSSV6s1jO2Sd7Ner4SJSIrVXpveIY3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691183254; x=1691788054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpU2xFaaF3Xyb1VXPjBfCVgipxCUGfroeAS7mPX+g1w=;
        b=FDYJf6r3spru6exCmWmTnUYQSb+CXFIhbdK/baQgdef+KH2hv2zPHzaGaeoSufVUqv
         zSjhyqZ+IVDggc07EHYrDsyx7UXVBl+NQN4ElXeTsrSlmo86fDag8QXHjX3vz6lAwIHs
         H1HRAWyZi94IAFCoCSOjZB8X/J0OdqxKEI/4YNAHt8y8+pgbGXhdeiK+4SaH/+X4zBAq
         qZlfCLddAyM60oU1PECWXkXKWb+t/S0DLaGLipYUt2ZjL+Nz3e+rnTO2Tk+CdqGCNfHr
         Mhto6cH2kXloRUsyO/v71VzG1EKHMVmpizpcOiZRLjhQ8ho0M1PgoosmGZQ5te8VkBzp
         puAw==
X-Gm-Message-State: AOJu0YzNSMGMJ89xtNKuH0IjjH+Xz5A1vlfCZ8cYzb+hYu6LeWjvyp4x
        GhCZQbPP3S1rIG5ufryqwq2NwA==
X-Google-Smtp-Source: AGHT+IHAa5PFI7E7ljoNguOyDV3zMc+VCG8XxoylBnS1MC5PEbgpVz5WqE7OI7hD0tr47yDAi54uWg==
X-Received: by 2002:a05:6a00:8c4:b0:687:96f2:72af with SMTP id s4-20020a056a0008c400b0068796f272afmr3777918pfu.17.1691183254593;
        Fri, 04 Aug 2023 14:07:34 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e186:e5d2:e60:bad3])
        by smtp.gmail.com with ESMTPSA id n22-20020aa78a56000000b0068664ace38asm2037584pfa.19.2023.08.04.14.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 14:07:33 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 10/10] drm/panel: Update TODO list item for cleaning up prepared/enabled tracking
Date:   Fri,  4 Aug 2023 14:06:13 -0700
Message-ID: <20230804140605.RFC.10.I104cdece7324b0c365e552a17f9883414ffaea01@changeid>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
In-Reply-To: <20230804210644.1862287-1-dianders@chromium.org>
References: <20230804210644.1862287-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that most panels have been updated not to track/double-check their
prepared/enabled state update the TODO with next steps.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 Documentation/gpu/todo.rst | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 139980487ccf..c73d9dbebbf4 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -460,26 +460,19 @@ Contact: Thomas Zimmermann <tzimmermann@suse.de>
 
 Level: Starter
 
-Clean up checks for already prepared/enabled in panels
-------------------------------------------------------
-
-In a whole pile of panel drivers, we have code to make the
-prepare/unprepare/enable/disable callbacks behave as no-ops if they've already
-been called. To get some idea of the duplicated code, try::
-
-  git grep 'if.*>prepared' -- drivers/gpu/drm/panel
-  git grep 'if.*>enabled' -- drivers/gpu/drm/panel
-
-In the patch ("drm/panel: Check for already prepared/enabled in drm_panel")
-we've moved this check to the core. Now we can most definitely remove the
-check from the individual panels and save a pile of code.
-
-In adition to removing the check from the individual panels, it is believed
-that even the core shouldn't need this check and that should be considered
-an error if other code ever relies on this check. The check in the core
-currently prints a warning whenever something is relying on this check with
-dev_warn(). After a little while, we likely want to promote this to a
-WARN(1) to help encourage folks not to rely on this behavior.
+Never double prepare/enable/disable/unprepare a panel
+-----------------------------------------------------
+
+As of commit d2aacaf07395 ("drm/panel: Check for already prepared/enabled in
+drm_panel"), we have a check in the drm_panel core to make sure nobody
+double-calls prepare/enable/disable/unprepare. However, that extra double-check
+shouldn't be necessary. The caller should always be matching up calls of
+prepare/unprepare and matching up calls of enable/disable.
+
+Hopefully the warning printed will encourage everyone to fix this. Eventually
+we'll likely want to change this to a WARN_ON and (perhaps) fully remove the
+check. NOTE: even if we remove the double-check, drm_panel core still needs
+to track the enabled/prepared state for its own purposes.
 
 Contact: Douglas Anderson <dianders@chromium.org>
 
-- 
2.41.0.585.gd2178a4bd4-goog

