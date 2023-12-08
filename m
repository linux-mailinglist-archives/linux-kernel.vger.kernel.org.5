Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC47880AA1B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574414AbjLHRI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574187AbjLHRIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:08:54 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64161199B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:09:00 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c2c5a8150so18999755e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 09:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702055339; x=1702660139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XVyGqXIqWznKFmI6wLzi11NM/yRQinuNhq1yEIojuaw=;
        b=l5SC3H7M1o30t46BXAcrsD8ORY6RI/ftDbPP0otJtBVH85hIUXnmVpWtT9IXBiT3P+
         4ZXNaOlcBts5g8DYZaTF9vtPQnvYd6nUOhE+1pvOjc9+B3g5nJYoG7EFFSjkQIDiNDJl
         eKnwbGkH+gP5Qjq8dAV5zwyKbww8U5GYFjkqN51hcMfzQiIX7opc8HaBgvduObL8EvC6
         2Y/TEXizYKd1hogUhifDB42VZoQqEqzjkUJn24Xu1DnDHlZgvo+4u75X9xp4hCW0HUtQ
         h9SM81WAJIIk0u1jusrFGDY1p8a8+lfOuysPRoiUBuWMI6EAFpSFhswxsMZFNRnxMEts
         BvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702055339; x=1702660139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVyGqXIqWznKFmI6wLzi11NM/yRQinuNhq1yEIojuaw=;
        b=sAoyNLPPGRLJLJu10WDXqFLr4E6jDUvu/cIitmWJfQUeENtPeQP4Li+dTnT7mZ3NBI
         I8N3Nvf6QzkLcoPAcFSyF9U+bSuoXAzLex7WTDnbBLY8W56uFi4Fmry4TYpUQGlka0Q2
         RWRZfh9ZQHlyUEQxxrLljiwBpNtziyZ3yhDli5gCEOnjqTR1Ab0EEhDUWquxfCrHp3Yo
         2vNzR7YD0rvED2vgeLF5ltuAeOW/lQ73a03TuHSyNapeYeDyvnfEPXDkiFx8sVIYziXj
         Ek9eNh6SQIJ00vFl1zEZtSmAOO/rjpd/mc6wGW4runXra93eGiVK8f7QOXjhP3+/SU5m
         m3rA==
X-Gm-Message-State: AOJu0YyvvkugKTcdsTAGwQoWVRJkHjsVuQR7WiwSaweOrxvxiLZWB9HW
        GAgyJDKEkmmmin5Pg2W2+g==
X-Google-Smtp-Source: AGHT+IE5AVT05vxNckWOXAcQGAYW3iMc2rtK7qiOsXmsYrjU0zrcLWNRWjDXMEMGI2qhHoAf0Friiw==
X-Received: by 2002:a05:600c:1d15:b0:40b:5e21:ec49 with SMTP id l21-20020a05600c1d1500b0040b5e21ec49mr151241wms.123.1702055338662;
        Fri, 08 Dec 2023 09:08:58 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:79e9:c218:2514:2131])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d44d1000000b003334a0513dbsm2421835wrr.67.2023.12.08.09.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:08:58 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Frank Binns <frank.binns@imgtec.com>,
        Donald Robson <donald.robson@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Sarah Walker <sarah.walker@imgtec.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH] drm/imagination: vm: Fix heap lookup condition
Date:   Fri,  8 Dec 2023 18:08:56 +0100
Message-ID: <20231208170856.1748413-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
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

When conditionally checking for heap existence of a certian address in
pvr_vm_bind_op_map_init the condition whether the map request comes from a
user is incorrect: The context must not be the kernel-context to be a
user(space) context and should be looked up in pvr_heaps.

That makes addresses coming from userspace not being verfied against the
defined ranges and prevents firmware loading for meta cores.

Fixes: ff5f643de0bf ("drm/imagination: Add GEM and VM related code")
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/gpu/drm/imagination/pvr_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index f42345fbe4bf..82690cee978c 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -225,7 +225,7 @@ pvr_vm_bind_op_map_init(struct pvr_vm_bind_op *bind_op,
 			u64 device_addr, u64 size)
 {
 	struct drm_gem_object *obj = gem_from_pvr_gem(pvr_obj);
-	const bool is_user = vm_ctx == vm_ctx->pvr_dev->kernel_vm_ctx;
+	const bool is_user = vm_ctx != vm_ctx->pvr_dev->kernel_vm_ctx;
 	const u64 pvr_obj_size = pvr_gem_object_size(pvr_obj);
 	struct sg_table *sgt;
 	u64 offset_plus_size;
-- 
2.43.0

