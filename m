Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAB87868BD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240519AbjHXHip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240420AbjHXHiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:38:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E7810F7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:38:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82A1465936
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFE5C433C8;
        Thu, 24 Aug 2023 07:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692862691;
        bh=yLSSSBHYD8WZeL0Wfaq/t90nMXiRlFnq7zlyLNlax8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LMwWtL3rVjYSTgwJ1CI0v1o/Q48mMwbRMOlcDYwq+A+OS+R5v+eaFm+4HqPX1uOJC
         gEas7dKEasmD1CfTvMY/YVSpCQK2Hq+jpszRL2zJ/84p8ikOahpk0/oRlilDY59sIt
         TVBE1sKHZF+r5UGdG4k3EUgcqNYn2/K4DiXZfRWDNT0CkF/2wxgfvOlJvlbklxoC0G
         as99N1n4vmCf5pPfskYATjzCpN1aHB30TkDase584bKcopT2ziVrT9AxueUBAhpUzi
         0ERnmGyM2YL0mMown++64XtrIKXoW2Gv8o6Z0j+wifwPuX1yA7raQd8FFsaCU10uqy
         8Y2pcg+zymOfg==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 16/20] drm/drm_connector: Provide short description of param 'supported_colorspaces'
Date:   Thu, 24 Aug 2023 08:37:01 +0100
Message-ID: <20230824073710.2677348-17-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824073710.2677348-1-lee@kernel.org>
References: <20230824073710.2677348-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/drm_connector.c:2215: warning: Function parameter or member 'supported_colorspaces' not described in 'drm_mode_create_hdmi_colorspace_property'
 drivers/gpu/drm/drm_connector.c:2239: warning: Function parameter or member 'supported_colorspaces' not described in 'drm_mode_create_dp_colorspace_property'

Signed-off-by: Lee Jones <lee@kernel.org>
---
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/drm_connector.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index bf8371dc2a612..c44d5bcf12847 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2203,6 +2203,7 @@ static int drm_mode_create_colorspace_property(struct drm_connector *connector,
 /**
  * drm_mode_create_hdmi_colorspace_property - create hdmi colorspace property
  * @connector: connector to create the Colorspace property on.
+ * @supported_colorspaces: bitmap of supported color spaces
  *
  * Called by a driver the first time it's needed, must be attached to desired
  * HDMI connectors.
@@ -2227,6 +2228,7 @@ EXPORT_SYMBOL(drm_mode_create_hdmi_colorspace_property);
 /**
  * drm_mode_create_dp_colorspace_property - create dp colorspace property
  * @connector: connector to create the Colorspace property on.
+ * @supported_colorspaces: bitmap of supported color spaces
  *
  * Called by a driver the first time it's needed, must be attached to desired
  * DP connectors.
-- 
2.42.0.rc1.204.g551eb34607-goog

