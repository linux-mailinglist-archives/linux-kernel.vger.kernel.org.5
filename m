Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CDB75EBEC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjGXGsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjGXGr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:47:57 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA496FD
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:47:53 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R8W1x2VxdzBRx4W
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:47:49 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1690181269; x=1692773270; bh=V/9DmpLtmUUaiETTyRFvOPxW8qA
        GVoJSukp/k1cY2Hw=; b=voVzjYGH3O90bDaWFPswYf28H7S3AWGgPlsNzANk1RS
        NRw3g5C9wayCnAycqK0iswBzwGc8wtsMbZ1ZyYzWs7qGjjZDPE3t2I3+XLzvwrTn
        uF33LYzJh4sV/keqRK/BFqabrxIxYlfxBdEeWsDqrL12ki6iFoUAJnTjrON6RUjU
        O2mwK6vqbPUEKm4JiUJdeC5Tvwxk+1qf4G6sneNw95G7zHCwEvLWnjUShZwOPhg4
        Ve6qrNjb5zOjSd2NJwYfKtOjiDfOEIbf9Yhc0ABESkw7Kb3pPOxk97TTCc6V9vwT
        lQhzCmvgP/P2WD1bEitybexmt7AJusnV0yjaluS8geA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wf6ao3HUy_Lz for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jul 2023 14:47:49 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R8W1w6X6ZzBRx4V;
        Mon, 24 Jul 2023 14:47:48 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 24 Jul 2023 14:47:48 +0800
From:   sunran001@208suo.com
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: "foo * bar" should be "foo *bar"
In-Reply-To: <20230724064641.8418-1-xujianghui@cdjrlc.com>
References: <20230724064641.8418-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <bbd3901a77d4f32040673a94a42626ef@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: Ran Sun <sunran001@208suo.com>
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
