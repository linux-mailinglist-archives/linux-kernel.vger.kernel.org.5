Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8CC790D6F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 20:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344516AbjICSqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 14:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245584AbjICSqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 14:46:18 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0557110A
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 11:46:14 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-79564282cb1so26011239f.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 11:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693766773; x=1694371573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WS96irfNC14gdmDiFClarh9DIKJfgD77OErS65jXzQY=;
        b=Dpk+pRW1/F5QDjr/xY35K0j2nPGFeux0fNw2MUYoFWMmAKCsF1DKJDjvBc88vc50Jy
         Nd1fNeMIg7vdiH/Jka4Wg0EPArGPzHz9XSoQtRsAgF304NNjuISrms956Ivec4Ih/0nf
         iuIERRt6NmLCin82QRPIPhVYxWJayCAbAmJa+oea8xUfbmOA2k5ZHZ2KHlZ2h6bSWyjl
         qIFJ7MHKA2dMbGHxr8X0PaucRPTPZV3qFyTPwGWyaJ7SV2JFl3wQZlCMvW2T0/DQ4K6M
         qoXsiYuN8Gqq5vKKU9dAz9aCQMikogbX+vxd3vRoosvhrUWGSGirEeU06ENZCnXuPafb
         Dkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693766773; x=1694371573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WS96irfNC14gdmDiFClarh9DIKJfgD77OErS65jXzQY=;
        b=D7gQ8wjLD9UoAV3Dpmskas4w7S67GTbFpmoIE605RN/kG9jx+j8F9l3NSd6jIx9VYp
         JOrjjf6PakuDxPnarKSprNdhEqN9UZuKGx3znFR8t1s9lvYOjpT8XwpmUNAQimO6lZ5G
         n447hKA+4E7c6EvXxNcueHcEn/cP7JjySlfrPtENG+oMHsyv+AOdRjDP/dQ/0b7VDUwd
         yoLGyzJeoA3TsC6IyjquhP++92fkqRsRVI1udeA1voYn4vpTU3ZvCiV4Ro+K3nDdHqs7
         NKFH2oHISbbj64PRp4+nLVSTwraZ5khYfLd4XKmy0bYB0oyjAOicqTV5siajrpt7tKW9
         zXuw==
X-Gm-Message-State: AOJu0Yzm2k188RMQBrRvdLMwP6374ZaGOKgqA3S0r5QOVIrJ6I8ujEEm
        Ui5rvimrRZ3O+PJZPCVzefSkZer77WEhTQ==
X-Google-Smtp-Source: AGHT+IFYCmR7Iv8xnRYnf/lKtlWv1bE7hNxZ00vdtzELzd9ulSSSQd6sJ4F8ae9sGd8UtxCQOEjWOw==
X-Received: by 2002:a6b:ec16:0:b0:792:82f8:6f90 with SMTP id c22-20020a6bec16000000b0079282f86f90mr9317430ioh.16.1693766773070;
        Sun, 03 Sep 2023 11:46:13 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id u9-20020a02cb89000000b0042b37dda71asm2519968jap.136.2023.09.03.11.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 11:46:12 -0700 (PDT)
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
        David Airlie <airlied@gmail.com>
Subject: [PATCH v2 1/6] drm_dbg: add trailing newlines to msgs
Date:   Sun,  3 Sep 2023 12:45:58 -0600
Message-ID: <20230903184607.272198-2-jim.cromie@gmail.com>
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

By at least strong convention, a print-buffer's trailing newline says
"message complete, send it".  The exception (no TNL, followed by a call
to pr_cont) proves the general rule.

Most DRM.debug calls already comport with this: 207 DRM_DEV_DEBUG,
1288 drm_dbg.  Clean up the remainders, in maintainer sized chunks.

No functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_connector.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index f28725736237..14020585bdc0 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2925,7 +2925,9 @@ int drm_mode_getconnector(struct drm_device *dev, void *data,
 						     dev->mode_config.max_width,
 						     dev->mode_config.max_height);
 		else
-			drm_dbg_kms(dev, "User-space requested a forced probe on [CONNECTOR:%d:%s] but is not the DRM master, demoting to read-only probe",
+			drm_dbg_kms(dev,
+				    "User-space requested a forced probe on [CONNECTOR:%d:%s] "
+				    "but is not the DRM master, demoting to read-only probe\n",
 				    connector->base.id, connector->name);
 	}
 
-- 
2.41.0

