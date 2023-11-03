Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C88A7E05C1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343818AbjKCPue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjKCPud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:50:33 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A420111
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 08:50:29 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2800db61af7so569616a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 08:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699026628; x=1699631428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UzPpHStW8fd1Sa/XvvRvmDs3ZUV3eU14pMhnuEaZyXo=;
        b=cREISMtWJKHXHFQztpIJTiakUSN3wCAbVIa17Q75U0wFlsvwzmR2vqY3IJ3lZZ7ruz
         Szw7J7+TH/3vcCn1wKK8f4TLBmUsqG+BB6RHSq74CTRv3yOcMRO2JH8RhH4GUxZka0WC
         hNSo1WbE7P6FyEdJtq0EYeNasSQJokcqB8c3PDZuy5R90e0bAFGqpesDb71jaDvJLrCB
         8glIzc/0yFwNF7G4+/zFAHKbAGwNNt0EEURqcrlcBrgbmnYo61JxQvykgm50mLPlnUE6
         qcJhiMk4vkp/JjC1isij5nePOwFRw64UGhcth4vAPlNQjyIimZBvIBOWAHGrNcEfBcH1
         Y86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699026628; x=1699631428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UzPpHStW8fd1Sa/XvvRvmDs3ZUV3eU14pMhnuEaZyXo=;
        b=WnYDVWIzstFIRKJAqhulhG3PvqYpk7YXqdCiNln6taFt5+dG8ahQH6LkQPVQoFYSzD
         wEEPQxrRE17a1O+Bx5K6leV9l14g4Cro42IukIuaPp8q6C8JtriDUIAkWyd/HS53Hv4F
         3viPzgyo82vqBq2DPPh7YoGTpgheTNvL4ClSt0ie+xDqbh0a2Iy1hexOI6C8m6VO7jfo
         VdmrdT8AVSzRZ1OLfX2tIn7GRQ3mgYTq7YmepXCSAPG3yjdn+gekc53sxMENlDp7YgJ+
         Rehk1RD2MIBGAhzbKWuXcm0eq6paQljEHIVhFyyIBFPKJzOFxpJ1dIFAVVcrN3FTx/hD
         72Zg==
X-Gm-Message-State: AOJu0YwhGo9dih1tAJqv29/RExXcpEur596WJ+/Ql7b4+mc65+VE9v/U
        XMSyU4QZaOJOvdwWQqfgJjzygZfC0NZ8wGli
X-Google-Smtp-Source: AGHT+IF1P3WyRtABQCc7gbOnKw/OsbBmL5Ob0nkdHmczkHloZMZMVQhl0Mb+oTGSIJdMVU+1lpfLXQ==
X-Received: by 2002:a17:90a:7064:b0:27d:32d8:5f23 with SMTP id f91-20020a17090a706400b0027d32d85f23mr21154782pjk.2.1699026628449;
        Fri, 03 Nov 2023 08:50:28 -0700 (PDT)
Received: from abhinav.. ([103.75.161.210])
        by smtp.gmail.com with ESMTPSA id v3-20020a17090ad58300b00274922d4b38sm1469858pju.27.2023.11.03.08.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 08:50:28 -0700 (PDT)
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Abhinav Singh <singhabhinav9051571833@gmail.com>
Subject: [PATCH] drivers: gpu: Fix warning using plain integer as NULL
Date:   Fri,  3 Nov 2023 21:20:13 +0530
Message-Id: <20231103155013.332367-1-singhabhinav9051571833@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse static analysis tools generate a warning with this message
"Using plain integer as NULL pointer". In this case this warning is
being shown because we are trying to intialize a pointer to NULL using
integer value 0.

Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
---
 drivers/gpu/drm/radeon/clearstate_evergreen.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/clearstate_evergreen.h b/drivers/gpu/drm/radeon/clearstate_evergreen.h
index 63a1ffbb3ced..3b645558f133 100644
--- a/drivers/gpu/drm/radeon/clearstate_evergreen.h
+++ b/drivers/gpu/drm/radeon/clearstate_evergreen.h
@@ -1049,7 +1049,7 @@ static const struct cs_extent_def SECT_CONTEXT_defs[] =
     {SECT_CONTEXT_def_5, 0x0000a29e, 5 },
     {SECT_CONTEXT_def_6, 0x0000a2a5, 56 },
     {SECT_CONTEXT_def_7, 0x0000a2de, 290 },
-    { 0, 0, 0 }
+    { NULL, 0, 0 }
 };
 static const u32 SECT_CLEAR_def_1[] =
 {
@@ -1060,7 +1060,7 @@ static const u32 SECT_CLEAR_def_1[] =
 static const struct cs_extent_def SECT_CLEAR_defs[] =
 {
     {SECT_CLEAR_def_1, 0x0000ffc0, 3 },
-    { 0, 0, 0 }
+    { NULL, 0, 0 }
 };
 static const u32 SECT_CTRLCONST_def_1[] =
 {
@@ -1070,11 +1070,11 @@ static const u32 SECT_CTRLCONST_def_1[] =
 static const struct cs_extent_def SECT_CTRLCONST_defs[] =
 {
     {SECT_CTRLCONST_def_1, 0x0000f3fc, 2 },
-    { 0, 0, 0 }
+    { NULL, 0, 0 }
 };
 static const struct cs_section_def evergreen_cs_data[] = {
     { SECT_CONTEXT_defs, SECT_CONTEXT },
     { SECT_CLEAR_defs, SECT_CLEAR },
     { SECT_CTRLCONST_defs, SECT_CTRLCONST },
-    { 0, SECT_NONE }
+    { NULL, SECT_NONE }
 };
--
2.39.2

