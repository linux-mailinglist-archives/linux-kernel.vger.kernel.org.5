Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC527864AF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 03:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239078AbjHXBgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 21:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239054AbjHXBgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 21:36:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2887D10F2;
        Wed, 23 Aug 2023 18:36:21 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a02:8010:65b5:0:1ac0:4dff:feee:236a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: alarumbe)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6430C6607234;
        Thu, 24 Aug 2023 02:36:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692840979;
        bh=Ofyfli6e0NuNza46GsWbQjyNGXuy8Dx7UnNH9i1R+0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IsjnyPjxpThYbHO4jJU0PF2/Si80HD1hN0r/LOsLU0PWCav57n9AMRwiCgKvxlw2P
         as1kh/y45IjLoqhQvOSExROP8mX4OLxfiQiwT9viI5BIG3p9lEKk98GscqyRJLGlU9
         Uq2i/7hgH9cLowRmIXCKdeSJs+rDr8WO4YlYqkVAbksI1dvvtg0JWQhsw9E1DNx3cs
         y9eT/BP21ABBd8Vh9pCuZcn438tc2o17y8haDEsmXkJf/GMnLeiqjAv8bYmhqmuone
         1faJmdEB4MfUSjMnal420PXcCVy7JKuNJkGBiI69c15kObb+36TjCRm/Ir8cbKHK1q
         adXeVWgRvAcNw==
From:   =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, robh@kernel.org,
        steven.price@arm.com
Cc:     adrian.larumbe@collabora.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, healych@amazon.com,
        kernel@collabora.com
Subject: [PATCH v2 1/6] drm/panfrost: Add cycle count GPU register definitions
Date:   Thu, 24 Aug 2023 02:34:44 +0100
Message-ID: <20230824013604.466224-2-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824013604.466224-1-adrian.larumbe@collabora.com>
References: <20230824013604.466224-1-adrian.larumbe@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These GPU registers will be used when programming the cycle counter, which
we need for providing accurate fdinfo drm-cycles values to user space.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_regs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_regs.h b/drivers/gpu/drm/panfrost/panfrost_regs.h
index 919f44ac853d..55ec807550b3 100644
--- a/drivers/gpu/drm/panfrost/panfrost_regs.h
+++ b/drivers/gpu/drm/panfrost/panfrost_regs.h
@@ -46,6 +46,8 @@
 #define   GPU_CMD_SOFT_RESET		0x01
 #define   GPU_CMD_PERFCNT_CLEAR		0x03
 #define   GPU_CMD_PERFCNT_SAMPLE	0x04
+#define   GPU_CMD_CYCLE_COUNT_START	0x05
+#define   GPU_CMD_CYCLE_COUNT_STOP	0x06
 #define   GPU_CMD_CLEAN_CACHES		0x07
 #define   GPU_CMD_CLEAN_INV_CACHES	0x08
 #define GPU_STATUS			0x34
@@ -73,6 +75,9 @@
 #define GPU_PRFCNT_TILER_EN		0x74
 #define GPU_PRFCNT_MMU_L2_EN		0x7c
 
+#define GPU_CYCLE_COUNT_LO		0x90
+#define GPU_CYCLE_COUNT_HI		0x94
+
 #define GPU_THREAD_MAX_THREADS		0x0A0	/* (RO) Maximum number of threads per core */
 #define GPU_THREAD_MAX_WORKGROUP_SIZE	0x0A4	/* (RO) Maximum workgroup size */
 #define GPU_THREAD_MAX_BARRIER_SIZE	0x0A8	/* (RO) Maximum threads waiting at a barrier */
-- 
2.42.0

