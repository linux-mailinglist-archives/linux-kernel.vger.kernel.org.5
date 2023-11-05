Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82697E16BA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 22:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjKEVBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 16:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEVBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 16:01:16 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C90E0
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 13:01:10 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5b35579f475so44147667b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 13:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncf.edu; s=google; t=1699218069; x=1699822869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IHNT0zTQnNcqPPjHsSZJukecZ6cg1UjZ8+XnwMd4fEU=;
        b=LL8+sOjSE1BRmbaCr13g/tkaW+e2gmtffWTLcjWCrFdK/lSS4Oy2IYkP3FvnrwhAmU
         I2g9FjdzEarMHHHtVVl+evs2fmEXs5GCMavbtsOX9DiH7w218IsMkeWGZ4ctAsiv1Tcc
         jam3Nc67dQhuYIOQlekY/LhQgguwSK59OvxW0fUElnCVFun6knYnF/xcr1zx0qn7ri28
         yLUW4343OXQAI+cp0rVzVKeBp1afg13+c7twMBS1KCVpE3VP38aJcN2j/2fhUEVrd+0D
         OTdXgLQluUe8vVC/tC614wD5PfW+eSKTILqs2IfMR7CUdpu3W1+VuX7Ss705bo+xS+PO
         BPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699218069; x=1699822869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IHNT0zTQnNcqPPjHsSZJukecZ6cg1UjZ8+XnwMd4fEU=;
        b=xGo9jl8t1w51Wt+ybTEy3Iy5L2bO/NaVmYGm9R2xvTQHS7sKAEYvek+L30TXVBqdUL
         1D1R4wwlSyHdA8lNhF9pSLtkyaiM7w2+GDAYwykFstUYsDfrRvEqjGHERDxaRvthZf8I
         2qmXQAqkFXH7lA2hebIZX7wkq7BQOtI1uBNEs/jqJR/lQKUj9UuXUg17gSpmnp9FV29H
         LgDqun1CYZvCcXqgprigd/GerQ/5SjAGtgwMgW3Vd3of/z9KLsr8HwuvBtCZkSifyb7F
         QPPICX7rWlNDWB8DfyIiKegACreXsBIvzlP969rHv5H2ehvwpL/DH9ogdEs7yEwSkPh7
         B/BA==
X-Gm-Message-State: AOJu0Yx+D500bff3+1IzqI0b1Vk4HiwUwY1UXxdg4FX7dl3DK2GBz1zD
        rXzHOtTIS1xuRBrrRd8/pqggDzJmDo+DlUTwCErPudlScBEOstaH/7POqDWibzqJrSLR6I9s8ur
        x4w2cRXxzeCkL51Q7hf7juS568+fE8yVjgmXsuwnIQTLLMBjiT/yfJhjt1hrfeqnWV1ldH90qYM
        5sAM0ryvRj/PIOsow=
X-Google-Smtp-Source: AGHT+IHTe+jz59X3TG5/BvLWO7twuGvFUqyXHcSTGVYZVIJwrYV1Qm7dBjwgblMISH1Ss4fexHRecQ==
X-Received: by 2002:a81:9290:0:b0:5a7:aaac:2bce with SMTP id j138-20020a819290000000b005a7aaac2bcemr9344504ywg.35.1699218068977;
        Sun, 05 Nov 2023 13:01:08 -0800 (PST)
Received: from localhost.localdomain ([2601:580:8201:d0::7d3d])
        by smtp.gmail.com with ESMTPSA id fc10-20020a05690c314a00b005afa4b9b049sm3486658ywb.42.2023.11.05.13.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 13:01:08 -0800 (PST)
From:   Hunter Chasens <hunter.chasens18@ncf.edu>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, daniel@ffwll.ch, airlied@gmail.com,
        Xinhui.Pan@amd.com, christian.koenig@amd.com,
        alexander.deucher@amd.com, evan.quan@amd.com,
        Hunter Chasens <hunter.chasens18@ncf.edu>
Subject: [PATCH v1] drm: amd: Resolve Sphinx unexpected indentation warning
Date:   Sun,  5 Nov 2023 16:00:44 -0500
Message-Id: <20231105210044.70371-1-hunter.chasens18@ncf.edu>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 517b9fb4624c..703fe2542258 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -990,11 +990,14 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
  * the power state and the clock information for those levels. If deep sleep is
  * applied to a clock, the level will be denoted by a special level 'S:'
  * E.g.,
- *	S: 19Mhz *
- *	0: 615Mhz
- *	1: 800Mhz
- *	2: 888Mhz
- *	3: 1000Mhz
+ *
+ * ::
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

