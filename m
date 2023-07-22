Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D601B75DF6F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 01:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjGVXyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 19:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjGVXxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 19:53:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B9830C4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 16:53:20 -0700 (PDT)
Received: from workpc.. (109-252-150-127.dynamic.spd-mgts.ru [109.252.150.127])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CA3C666070F8;
        Sun, 23 Jul 2023 00:53:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690069999;
        bh=Oubjr62/5xZD6SNVKnPrUnEgQKeBKYFs3MwTqlwxAzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Giut13T2M38GoEvGph1zFA7Zv8w2Tht5Z7zP5mtGrCXt36/NC41R+Qinn8gtQA8nL
         Y8TvdlPOtvodnXRYkluM8uZEx6AKOkYvuI7FUodu0/Q4Pgsn5C3Bn1gtzn8uSfRnZQ
         VVzH/OUp+cyAxHUjqh15h5gCHOzPSOUU8MqMX89qPT/7Z0mQcfQy8Lgh1Yvm2aVHZg
         nX78F1q4NmbgPwglPNyBWJg1+EMjD+hixxvC51m+eTSrPVzQbFAEbGqiFsjocaQ6EN
         YtHD/aiH9hC85cWUggbv8NJmU7sWzQn7X0bNACWt6JG8fp12y6FFL69VGLZ85T7yTO
         7m+6K5lRYf5hA==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v14 11/12] drm/shmem-helper: Make drm_gem_shmem_print_info() symbol GPL
Date:   Sun, 23 Jul 2023 02:47:45 +0300
Message-ID: <20230722234746.205949-12-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230722234746.205949-1-dmitry.osipenko@collabora.com>
References: <20230722234746.205949-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make drm_gem_shmem_print_info() exported symbol GPL to make it consistent
with the rest of drm-shmem exports. It's the only remaining drm-shmem
symbol that isn't GPL.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 3dd4da18eedf..46190e70c3df 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -782,7 +782,7 @@ void drm_gem_shmem_print_info(const struct drm_gem_shmem_object *shmem,
 	drm_printf_indent(p, indent, "vaddr=%p\n", shmem->vaddr);
 	drm_printf_indent(p, indent, "madv=%d\n", shmem->madv);
 }
-EXPORT_SYMBOL(drm_gem_shmem_print_info);
+EXPORT_SYMBOL_GPL(drm_gem_shmem_print_info);
 
 /**
  * drm_gem_shmem_get_sg_table - Provide a scatter/gather table of pinned
-- 
2.41.0

