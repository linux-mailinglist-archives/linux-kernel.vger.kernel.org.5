Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858437B0E17
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 23:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjI0Vbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 17:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjI0Vbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 17:31:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5857F122;
        Wed, 27 Sep 2023 14:31:44 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a02:8010:65b5:0:1ac0:4dff:feee:236a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: alarumbe)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7612766072F7;
        Wed, 27 Sep 2023 22:31:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695850302;
        bh=40cxse3JQ9cf/lsBsQtEwOdtU5azU2vw7zoB5H2GdF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N1PBsBXgvf2oawydfDpOUxP22AEgIgCk/by7ssBrKPSj6sCLYzzxsEvLm+2vFwt4j
         VI7E8+8Dgi/apIDJ+7wsKIs08BlwzhZwMhF3qi63ggSSsa0DSp9wgC5n27mQmhqTbp
         l2vytuCIe6arwnAHQCUW01bhY6j65rE0qMyFoVE+/FgLlEbcY4Dvy+Eayxex8E7GaM
         U5T/WCYgFPofC3ZTNfaqurBjkrNtsJVuBacvoT+FW0vQNWRLpIE9EehaXshZfGwral
         Pt0yEltwb2xcCvoOvCC9VvQJlsxBprKi2BO0uC4VRw/yaFB7Qo2SB3lZojVOpyq8nR
         jZq8SUf3Fawng==
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
        kernel@collabora.com, tvrtko.ursulin@linux.intel.com,
        boris.brezillon@collabora.com
Subject: [PATCH v7 1/5] drm/panfrost: Add cycle count GPU register definitions
Date:   Wed, 27 Sep 2023 22:29:55 +0100
Message-ID: <20230927213133.1651169-2-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230927213133.1651169-1-adrian.larumbe@collabora.com>
References: <20230927213133.1651169-1-adrian.larumbe@collabora.com>
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
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
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

