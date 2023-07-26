Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E41E762949
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 05:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjGZDak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 23:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjGZDac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 23:30:32 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2905E213C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 20:30:29 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R9fYD5s4RzBSXTh
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:30:24 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1690342224; x=1692934225; bh=Kaqg3kvlUcRExSgaeAEIxsFsiDi
        pcctqy+l/tstW17M=; b=m+xj9wq244OoiCIr9poc3arBk/xDhRCM+6u/2remK+o
        wn11g7BkigrYN5m4olkiy/Qf9mOiWruCq3tSG9lQTvr7VkSX5th0uGP+IIyuaBds
        XOKUYNis0pUoVHCIm5iqUHe34tJTB7OqOoVNlb1OVKN+wQhkrGQqoMwvsB/g36wJ
        m/+1vhlleHiRxTbUOLz9w9pJAH/JOKnVJ6dKCQsJNKt0vI1qWk648t0J+yUv2MnC
        oBVyPFTfzDfN5EGob1d58udJDn2fQn88M1xzg7F4Z4AEShezxw2aUx+2GaqnWe4/
        c46zr7vhyj2GaAbjzajwOiWgGz87/FX4CTbsk+F3IHQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7p6lASvzSPkd for <linux-kernel@vger.kernel.org>;
        Wed, 26 Jul 2023 11:30:24 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R9fYD3pWPzBJDhK;
        Wed, 26 Jul 2023 11:30:24 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 26 Jul 2023 11:30:24 +0800
From:   wuyonggang001@208suo.com
To:     alexander.deucher@amd.com
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm: Fix format error
In-Reply-To: <20230726032626.51101-1-zhanglibing@cdjrlc.com>
References: <20230726032626.51101-1-zhanglibing@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <f5c1bdcdb456f524f4f5a45a7434c8a4@208suo.com>
X-Sender: wuyonggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the error(s):
ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
---
  drivers/gpu/drm/drm_legacy.h | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_legacy.h b/drivers/gpu/drm/drm_legacy.h
index 70c9dba114a6..f098a48cbdf4 100644
--- a/drivers/gpu/drm/drm_legacy.h
+++ b/drivers/gpu/drm/drm_legacy.h
@@ -231,7 +231,7 @@ static inline int drm_legacy_dma_setup(struct 
drm_device *dev)
  #endif

  void drm_legacy_free_buffer(struct drm_device *dev,
-			    struct drm_buf * buf);
+			    struct drm_buf *buf);
  #if IS_ENABLED(CONFIG_DRM_LEGACY)
  void drm_legacy_reclaim_buffers(struct drm_device *dev,
  				struct drm_file *filp);
@@ -253,12 +253,12 @@ int drm_legacy_sg_free(struct drm_device *dev, 
void *data,
  void drm_legacy_init_members(struct drm_device *dev);
  void drm_legacy_destroy_members(struct drm_device *dev);
  void drm_legacy_dev_reinit(struct drm_device *dev);
-int drm_legacy_setup(struct drm_device * dev);
+int drm_legacy_setup(struct drm_device *dev);
  #else
  static inline void drm_legacy_init_members(struct drm_device *dev) {}
  static inline void drm_legacy_destroy_members(struct drm_device *dev) 
{}
  static inline void drm_legacy_dev_reinit(struct drm_device *dev) {}
-static inline int drm_legacy_setup(struct drm_device * dev) { return 0; 
}
+static inline int drm_legacy_setup(struct drm_device *dev) { return 0; 
}
  #endif

  #if IS_ENABLED(CONFIG_DRM_LEGACY)
