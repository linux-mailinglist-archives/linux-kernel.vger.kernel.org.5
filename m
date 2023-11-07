Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4007E4AAC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344013AbjKGV2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbjKGV2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:28:43 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1807FD7A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:28:41 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d9abc069c8bso5568556276.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 13:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncf.edu; s=google; t=1699392520; x=1699997320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5GrfKC2IvsZBEgQFQYe2RhJApLNUugeSPWTjf04uUac=;
        b=SZ75Mow2RJnjfqUkUo9Ts/5nTwSU6WLwQRugmCLkr2Dik0rDWkSLg+zY627HR/FGwb
         JolNPghyYsQsAI8uVDP+ygzbZI9x3wP+M9hEQvwXg6kef/SSNP7sHBV0ZJ+znZ/Mlda8
         j2YAc9Sk6VHWOUGvs+UrVrWg3L/VGyFQFST0s4OA5UMoAWzBQDT4735cLlr14mlM45xH
         ISE3qBrFDADzc8G3fui9Z5lR1FTUsaYGLtlJNNXXUrgwIxBvIOqTUYvUf02lBOP/Z0IT
         t5lkx9zVe+dYweRbN6YaDZMaN7AdyOlVUeRHucnWtX8eBiw00lZFIktcwh/Yzm2sOI6Y
         hEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699392520; x=1699997320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5GrfKC2IvsZBEgQFQYe2RhJApLNUugeSPWTjf04uUac=;
        b=u2ezOEOmUs3JEv8nfWTAuWXXgml6EXkTyl3vMCHzJGCjNn3ciXieQsT9CubecAgvxZ
         OAMu8lK2Weru/JergTx//AvGKDkvV3wunu0I+srPumfV/75FLvPPlgz0Foz8/BAgGuaz
         tt2q5l1+0h37ocA3xS2Fkpm/3glOsi/0HvNDa33UaK1WxbLQ6NA2wOiWYVRSiba85lPn
         bW6taUBh2rSNO5vOBcjdEbZP3BK8z7HAN3tzmIFyza7s03iTYTEOIPFE0sjLXXpcg0OW
         94c2zsE3YV+UW4HPTn9HFrplG39BuaJbTU3u3GofAmzI6Krz+ma1UJzTxFLtPr1nMi81
         7i+g==
X-Gm-Message-State: AOJu0YxvU0Sd7h4oQeMQHuC6b4jzsvA/Q9YluwivDV5kN27PR+DyyDS/
        Jyb65qAID5/+n8HahFdAgy0kj/O+WvUwfRFcljguni/zTlop4D7dPQflrIQ3S5axjFHBKuayseg
        qpMsf0hSxsBmKEvtFt5IPXji/C67xVuOTAUuf4UfhopjpHgfxmeu0jg7xaZrRLG5aqFbzJNlxi0
        b7De6TLcxjjUHvleM=
X-Google-Smtp-Source: AGHT+IEVGxWjSPfH29B0f+BhNDDfe9GVs/2MnfzycBPjOvD0xg9LpfAOaj+zUSsjtvyDbSoQfjhDcg==
X-Received: by 2002:a25:97c8:0:b0:d9a:6b46:f49d with SMTP id j8-20020a2597c8000000b00d9a6b46f49dmr9749055ybo.59.1699392519826;
        Tue, 07 Nov 2023 13:28:39 -0800 (PST)
Received: from Lux.hsd1.fl.comcast.net ([2601:580:8201:d0::4174])
        by smtp.gmail.com with ESMTPSA id j186-20020a25d2c3000000b00da06575fbc8sm5657649ybg.2.2023.11.07.13.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 13:28:39 -0800 (PST)
From:   Hunter Chasens <hunter.chasens18@ncf.edu>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, daniel@ffwll.ch, airlied@gmail.com,
        Xinhui.Pan@amd.com, christian.koenig@amd.com,
        alexander.deucher@amd.com,
        Hunter Chasens <hunter.chasens18@ncf.edu>
Subject: [PATCH v3] drm: amd: Resolve Sphinx unexpected indentation warning
Date:   Tue,  7 Nov 2023 11:28:30 -0500
Message-ID: <20231107162830.36856-1-hunter.chasens18@ncf.edu>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolves Sphinx unexpected indentation warning when compiling
documentation (e.g. `make htmldocs`). Replaces tabs with spaces and adds
a literal block to keep vertical formatting of the
example power state list.

Signed-off-by: Hunter Chasens <hunter.chasens18@ncf.edu>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 517b9fb4624c..576202bf64f3 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -989,12 +989,13 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
  * Reading back the files will show you the available power levels within
  * the power state and the clock information for those levels. If deep sleep is
  * applied to a clock, the level will be denoted by a special level 'S:'
- * E.g.,
- *	S: 19Mhz *
- *	0: 615Mhz
- *	1: 800Mhz
- *	2: 888Mhz
- *	3: 1000Mhz
+ * E.g., ::
+ *
+ *  S: 19Mhz *
+ *  0: 615Mhz
+ *  1: 800Mhz
+ *  2: 888Mhz
+ *  3: 1000Mhz
  *
  *
  * To manually adjust these states, first select manual using
-- 
2.42.0

