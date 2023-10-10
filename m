Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C094D7BFF37
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbjJJO1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjJJO1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:27:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D3E91
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696948065; x=1728484065;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5WdwfPpssWHEumsq9mc7e5KRo9vNp83NwtHC1MesJUc=;
  b=hLT4P8TzO9ZjeLCcDW4XF73d41XOUx7lcDNFsBsL0Awp8NSlwaFcPDWH
   4EtYrbOtfiJG9tdUykoM/8Fwd+c3Zu3p36oeS/jQRKFz4vsATKu1vHFz4
   I/GdPYenoQ+aAdBvNtAUgD2Drri9eFwOwje4a3EQzytqMB3xhtCFCKeN7
   B7TiUfApgmbfWZbzIehjOQXBMjvliH3HsAM2xd0LDDmF8LxER07Zr2vKZ
   A7AsPBxVpD0EqpebQN9GqGBJqiUG5fwBENB24vjHZr+Pyq8UEuD7LdNxg
   l2Da4vD6K5Z6YlkqCBHPgQrhIvjIPDpV7CSbw5ZOHGyqlq2sPk9YJYH8Q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="448598110"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="448598110"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 07:27:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="869713704"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="869713704"
Received: from agargas-mobl.ger.corp.intel.com (HELO fedora..) ([10.249.254.164])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 07:27:43 -0700
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>
To:     intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/gpuvm: Dual-licence the drm_gpuvm code GPL-2.0 OR MIT
Date:   Tue, 10 Oct 2023 16:27:24 +0200
Message-ID: <20231010142725.8920-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dual-licence in order to make it possible for other non-GPL os'es
to re-implement the code. The use of EXPORT_SYMBOL_GPL() is intentionally
left untouched to prevent use of drm_gpuvm as a proxy for non-GPL drivers
to access GPL-only kernel symbols.

Much of the ideas and algorithms used in the drm_gpuvm code is already
present in one way or another in MIT-licensed code.

Cc: Danilo Krummrich <dakr@redhat.com>
Cc: airlied@gmail.com
Cc: daniel@ffwll.ch
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/drm_gpuvm.c | 2 +-
 include/drm/drm_gpuvm.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index 02ce6baacdad..08c088319652 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-only
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
  * Copyright (c) 2022 Red Hat.
  *
diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
index 361fea5cb849..21bbf11415b3 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
 
 #ifndef __DRM_GPUVM_H__
 #define __DRM_GPUVM_H__
-- 
2.41.0

