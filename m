Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E2B7D5A36
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbjJXSLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjJXSLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:11:47 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035FC111
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 11:11:46 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6bd0e1b1890so3765943b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 11:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698171105; x=1698775905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tzIVqFd7BYIfD+/BtUvd6UdU+bq+nB9/4vc6HwyRwDA=;
        b=PJOilm4j0Tor2JNsBFG2JxKEmhssPhdUJmTOT3UXKdc7n8H8ZXswZPWFYZ4EDwyzCP
         wMUpYl3HK+YxP183yI1zvIB6qoF6rJyyXTP7FL14nB1V+V8M3qjZmBiE437NSGTlwR4A
         7Wsw6V4Hk7M1khVJz9IU8CCVgg23tbqRwBQ3bPu7dbi71FebNvh4BTXij1cpHKKI4A8O
         MtYLTppmoLTe5KpomhM2SglKGGUQtQ8WHkYNAWZWNYxYN4zo48G9/Dvy1qjM1LFIUAk4
         eLcCsX/QjRfuuWrjtYYFkiWrFmgz7VGoBnd01XmvAsy5gJBzgnKn2+bT9UeQw49T+3dY
         sY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698171105; x=1698775905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzIVqFd7BYIfD+/BtUvd6UdU+bq+nB9/4vc6HwyRwDA=;
        b=OtOsGAz1Weoh2Qcmllm7ykDlJXk1Tqn6G+Z+VXMW6KP3GhUBIrnzfHmilwcK0Vyedf
         kG0btNYS/+zWspFr3PZWdcj65uenzRq7wAOT0CPGQ+LIjnqJwTRq1jb+7TdO+elW2Ug9
         IULJNNOUucFqebq2A0RXz9VBYin07KL807XXKUdeLgopNmqQzb1H3c8SaS6iT+J9z9nV
         s2uaUXr10gj4ugRKpRim/qlNSClBqNj5aPXJY6YkM5r6Gg6pdaSdGdzQFZ+ZBbq5VKVs
         TYXBlqviYD83Ya9L+pi7OV3e6TFw+1963ykXaxhbdtEq1kKPJVQYJN78wvaUvFWZ44YN
         YmaA==
X-Gm-Message-State: AOJu0YxASjYiCAMwho+QAhm6QTeoat4ZhGK7HSz42PIiazW6utp6keAf
        eYkVyyfqe2zWQYWzmoNQ5YA=
X-Google-Smtp-Source: AGHT+IG5DZEa19Ut0ZSvrY2ONpv/RDUeT44JgOW71UKte+JD4T2cdfJWV5R/00U1mA6OiWjjJuWe+g==
X-Received: by 2002:a05:6a00:1915:b0:68e:3eb6:d45 with SMTP id y21-20020a056a00191500b0068e3eb60d45mr10917135pfi.30.1698171105386;
        Tue, 24 Oct 2023 11:11:45 -0700 (PDT)
Received: from brag-vm.. ([117.243.121.127])
        by smtp.gmail.com with ESMTPSA id z64-20020a633343000000b005898a3619c7sm7335210pgz.48.2023.10.24.11.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 11:11:45 -0700 (PDT)
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, daniel@ffwll.ch,
        airlied@gmail.com, Qingqing.Zhuo@amd.com, alvin.lee2@amd.com,
        wenjing.liu@amd.com, jun.lei@amd.com, Samson.Tam@amd.com
Cc:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: avoid variable reinitialization
Date:   Tue, 24 Oct 2023 23:41:34 +0530
Message-Id: <20231024181134.48066-1-bragathemanick0908@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The member variable enable_hpo_pg_support is already initialized 
and hence the reinitialization instruction can be removed. Issue 
identified using the doubleinit.cocci Coccinelle semantic patch script.

Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index 99d55b958977..1fd9df8da09c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -739,7 +739,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_boot_optimizations = false,
 	.disable_unbounded_requesting = false,
 	.disable_mem_low_power = false,
-	.enable_hpo_pg_support = false,
 	//must match enable_single_display_2to1_odm_policy to support dynamic ODM transitions
 	.enable_double_buffered_dsc_pg_support = true,
 	.enable_dp_dig_pixel_rate_div_policy = 1,
-- 
2.34.1

