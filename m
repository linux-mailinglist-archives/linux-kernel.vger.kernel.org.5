Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293E27901E7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 20:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350504AbjIASGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 14:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjIASGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 14:06:14 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFB292
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 11:06:11 -0700 (PDT)
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx1.riseup.net (Postfix) with ESMTPS id 4RcmDg0F4RzDrj8;
        Fri,  1 Sep 2023 18:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1693591571; bh=DWXax1VVYxJLxtnHHUvwQtEKCPi0tNnnlOsivDnI+jw=;
        h=From:Date:Subject:To:Cc:From;
        b=jMgVAI62yyAGOyMSsAhzqyeyJU2rhJ9a/GN3BcXLjsROxSZvVCsSbcmhWlojc9Q7F
         SDJEknGIQiKnUeKmljuhpUvHBgFAymsShP2JBeWhsfYwqmv0I8XsFoH4RSPcld/72u
         K1CmuGXuL4DZ22nUi/NmWlq23PR3ApQjPvrUXvws=
X-Riseup-User-ID: 4823884539E9B3C13ADCFB1C515D7D4A3A8AA806180CE3A2D768A06060843233
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4RcmDN3TPVzFs1Q;
        Fri,  1 Sep 2023 18:05:56 +0000 (UTC)
From:   Arthur Grillo <arthurgrillo@riseup.net>
Date:   Fri, 01 Sep 2023 15:05:50 -0300
Subject: [PATCH] drm/debugfs: Add inline to drm_debugfs_dev_init() to
 suppres -Wunused-function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230901-debugfs-fix-unused-function-warning-v1-1-161dd0902975@riseup.net>
X-B4-Tracking: v=1; b=H4sIAP0n8mQC/x2NSwoCQQwFrzJkbaBnRGG8irjoz+s2mygdW4Vh7
 m5wWfDq1UaGLjC6TBt1vMXkoQ7zYaJ8j9rAUpxpCcsxrGHmgjRaNa7y5aHDULgOzS/3+BO7ijZ
 ekRJyKud4iuRPzw6f/yvX277/AEgifIh1AAAA
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     tales.aparecida@gmail.com, andrealmeid@riseup.net,
        mairacanal@riseup.net,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        kernel test robot <lkp@intel.com>,
        Arthur Grillo <arthurgrillo@riseup.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_DEBUG_FS is not set -Wunused-function warnings appear,
make the static function inline to suppress that.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309012114.T8Vlfaf8-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202309012131.FeakBzEj-lkp@intel.com/
Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
---
 include/drm/drm_drv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 9850fe73b739..e2640dc64e08 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -584,7 +584,7 @@ static inline bool drm_firmware_drivers_only(void)
 #if defined(CONFIG_DEBUG_FS)
 void drm_debugfs_dev_init(struct drm_device *dev, struct dentry *root);
 #else
-static void drm_debugfs_dev_init(struct drm_device *dev, struct dentry *root)
+static inline void drm_debugfs_dev_init(struct drm_device *dev, struct dentry *root)
 {
 }
 #endif

---
base-commit: 8e455145d8f163aefa6b9cc29478e0a9f82276e6
change-id: 20230901-debugfs-fix-unused-function-warning-9ebbecbd6a5a

Best regards,
-- 
Arthur Grillo <arthurgrillo@riseup.net>

