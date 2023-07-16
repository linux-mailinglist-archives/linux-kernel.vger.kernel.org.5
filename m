Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB63754CEE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 02:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjGPAqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 20:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGPAqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 20:46:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0F1101
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 17:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=vCDJzaPXRVCO/UvhiEs9IHkx1kgQ8KEzMrH/C6KGEU0=; b=b7ClRTC6xGPUfPjg3DfYY1xxDk
        J3IwUzmdemoCyRwI1hiw/UFxBG9Nc9tqI1e9ahGdgGni3OdqfAzU9D4rBjo2f8a14GXaWFTL8AKC6
        g3XXKCTByv78lQYd7LRpHmjSHdcZGBGa+7YYhXofQUKQnxBjv7vhd5ruCbnV1wghR5/jU07soME/F
        bCfM2LI+RaQxuigE+wISZEqQ/cu3zBOpOexyddGJldJndOS7P27AFORezLol2tj7RFy6Fw5sOvvZz
        bUMDZLVEqz2oe0IS5BCGSt6NRku+WjGsNbyj9wWo9dMgm/hfCZBrKB93jcPgX27lj5OeMa7nEnBYe
        tWxamYXg==;
Received: from 50-198-160-193-static.hfc.comcastbusiness.net ([50.198.160.193] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qKptx-009lWB-2x;
        Sun, 16 Jul 2023 00:46:18 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/connector: mark enum counter value as private
Date:   Sat, 15 Jul 2023 17:46:16 -0700
Message-ID: <20230716004616.21838-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark the DRM_MODE_COLORIMETRY_COUNT enum value as private in
kernel-doc to prevent a build warning:

include/drm/drm_connector.h:527: warning: Enum value 'DRM_MODE_COLORIMETRY_COUNT' not described in enum 'drm_colorspace'

Fixes: c627087cb164 ("drm/connector: Use common colorspace_names array")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
---
 include/drm/drm_connector.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20230714.orig/include/drm/drm_connector.h
+++ linux-next-20230714/include/drm/drm_connector.h
@@ -522,7 +522,7 @@ enum drm_colorspace {
 	DRM_MODE_COLORIMETRY_RGB_WIDE_FIXED	= 13,
 	DRM_MODE_COLORIMETRY_RGB_WIDE_FLOAT	= 14,
 	DRM_MODE_COLORIMETRY_BT601_YCC		= 15,
-	/* not a valid value; merely used for counting */
+	/* private: not a valid value; merely used for counting */
 	DRM_MODE_COLORIMETRY_COUNT
 };
 
