Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EE57BA324
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbjJEPwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbjJEPu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:50:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590973251;
        Thu,  5 Oct 2023 07:12:48 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a02:8010:65b5:0:1ac0:4dff:feee:236a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: alarumbe)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 99D026607328;
        Thu,  5 Oct 2023 15:12:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696515166;
        bh=hYTUtJ91m8XhfmVfROlVN0LtUovJ3Zomdz4P3xGJLPc=;
        h=From:To:Cc:Subject:Date:From;
        b=J5csQFjxk3PaPfrvQOK42s8QmYosEYOhd8kF4OjtfhkbVydWs58zUSl3q+/6QJNoX
         X5thRMsEI0apbSNtVEZuqNhTpmI5ZM2fnFwbXazz/oNasA6YNaXoBA4lk9Vs4NNQvg
         PrOi/vdd+u7GNpThXDqXUMXBCpuFVpaBNDXQnPurSR0qfkdonXeIsoBXAFx3hUutnf
         rQ1eYpyG0qlqIw/ok6Aa2zEYkYoN+CXcOfNndaYIPmD8K0vTynct1wwJ81cRVwW6mP
         PrMnZ6xDIgh1bkkLLuTTHMXulzTv7Z+m5FDdsTisoe3Tzc41w0BH08nElwelKke90L
         Nze9RiUARq0iw==
From:   =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Steven Price <steven.price@arm.com>,
        =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     kernel test robot <lkp@intel.com>, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/gpu: fix Panfrost documentation build warnings
Date:   Thu,  5 Oct 2023 15:12:35 +0100
Message-ID: <20231005141239.132783-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix issues revealed by `make htmldocs` after adding Panfrost DRM
documentation file.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Fixes: d124dac2089c ("drm/panfrost: Add fdinfo support GPU load metrics")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310030917.Txzlpoeq-lkp@intel.com
---
 Documentation/gpu/drivers.rst  | 1 +
 Documentation/gpu/panfrost.rst | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/drivers.rst b/Documentation/gpu/drivers.rst
index 3a52f48215a3..45a12e552091 100644
--- a/Documentation/gpu/drivers.rst
+++ b/Documentation/gpu/drivers.rst
@@ -18,6 +18,7 @@ GPU Driver Documentation
    xen-front
    afbc
    komeda-kms
+   panfrost
 
 .. only::  subproject and html
 
diff --git a/Documentation/gpu/panfrost.rst b/Documentation/gpu/panfrost.rst
index ecc48ba5ac11..a07f6821e994 100644
--- a/Documentation/gpu/panfrost.rst
+++ b/Documentation/gpu/panfrost.rst
@@ -5,7 +5,7 @@
 .. _panfrost-usage-stats:
 
 Panfrost DRM client usage stats implementation
-==========================================
+==============================================
 
 The drm/Panfrost driver implements the DRM client usage stats specification as
 documented in :ref:`drm-client-usage-stats`.
-- 
2.42.0

