Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACE77E2E09
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjKFUSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjKFUSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:18:04 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3185D77
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:18:01 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a822f96aedso59072077b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 12:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncf.edu; s=google; t=1699301880; x=1699906680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U8ZaLnkOmfn6VUj4P2bkyzAv0ojbKADStfSaOPEyh7k=;
        b=YuXeChXaR12GuDusRAHx2xim51OmR8OslhG4H51IsNrwFr96NYyLiZLQIiB2c5pRdL
         +RdFx2pn6MsDs6QCwMFR7CoEQJ/hUu882EHtEiFnMutv/7yXJC4xYmehOFosr07YD9V2
         dssjr1XwMrB6BF24UNePkNYe9G7j8OXKWmQ8xjxa1Dfb/PxZ48cqI/e8Y6/ZPk9tk4tG
         YVWpllurG5nlnHVFjeL0nuDkrQLCNOMc8v7peKVoqwKEm4smeTWga3QqoNyhu7V8//qj
         nILxKyKaK/BlFDMECvkIn3sOxwwThPqLxVlAxWWvA4p+kR/1SHuzGme02Q/99NZtVgqj
         enXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699301880; x=1699906680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8ZaLnkOmfn6VUj4P2bkyzAv0ojbKADStfSaOPEyh7k=;
        b=wrWQalWsinRVcyj4QQER9LUSJgQBk+begEVdDRgxxvMj61/thCM+HnCaPGa+uSVhTv
         2mQKnTIAfJ4O3OZxFHVMUiFGa2qyJCFH7WcLsxOtz4ugf/qx229+vx0CyUskJlsfZphs
         pgDFE6ezyzjMQvQay3Vw+Kp1FybvgDw4KwT89tYKMilmaC/qekVuINWoTg6uXytZq3JF
         QRj0ckUKAYFaGc9oA6sX94+YBPk/ZnJs/uI90QuwVquH8NNlWqrkrwaMO8k8vJLc7ywd
         n1nlUHIM1rDVkDeGXfesP30WkTr7S4YKXaZaeifAiu81iG0ai3q5wch9x8Es6E+l6OAJ
         jIQA==
X-Gm-Message-State: AOJu0YzOL25HUpirihix/XJW4jvlRnej8cO5IadbNg/YJQX906i8MDSB
        fGRh9Dt5XvcrGsdTj73FGBc7GaWZcbfDl7AiZezADzY05cIfaK1fGIw811IVBTgCIQ2x9akV2nY
        mGyyVaU+7MX6Ta3E4QntDKzXAUiKqH7mvgayvMTfhAkX94EDrAje1DV2ixKLYst9z8X25B9/Nc5
        5ZMDf3ncf7vGNVwuM=
X-Google-Smtp-Source: AGHT+IEQcelb7+yRoiYucbFC0plzPHM97ye3oRTkSaTHrhyd7sCMz0sZn3o3ovon0cvSA7iGE8n/Yw==
X-Received: by 2002:a81:658b:0:b0:583:a3ab:b950 with SMTP id z133-20020a81658b000000b00583a3abb950mr10575615ywb.50.1699301880325;
        Mon, 06 Nov 2023 12:18:00 -0800 (PST)
Received: from localhost.localdomain ([2601:580:8201:d0::d089])
        by smtp.gmail.com with ESMTPSA id q203-20020a815cd4000000b005a4da74b869sm4782343ywb.139.2023.11.06.12.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 12:18:00 -0800 (PST)
From:   Hunter Chasens <hunter.chasens18@ncf.edu>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Hunter Chasens <hunter.chasens18@ncf.edu>
Subject: [PATCH v2] drm: amd: Resolve Sphinx unexpected indentation warning
Date:   Mon,  6 Nov 2023 15:17:39 -0500
Message-Id: <20231106201739.29507-1-hunter.chasens18@ncf.edu>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 517b9fb4624c..81b8ceb26890 100644
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
+ * E.g.::
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
2.39.3

