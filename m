Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793DD7DC777
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343661AbjJaHj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343653AbjJaHjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:39:51 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D178C1;
        Tue, 31 Oct 2023 00:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=wjkfA18vskmNpwq7uCNBs7pSL6GNgLLuP059XVeOTOI=; b=MkjxmaIfzpb2fodXDU2+I0m+bt
        tpGiekNhBPCx2qnvqa6reui58D99bNsjrtEgR7Dnz3K3ik8EomJbsDYSOOaysjMufrqLHW6N5p9Lz
        rXl52CeviBKM0YwHz34Eyoa9SX5q2pBsR5eBJ/yqj5KKoAlY6ICQGm3qBUHtKnDdnpdnmI79Nn6OG
        vIHYehHtYxNqovYMm/V5ljot8VcbUw+C613YKj7cfO2r9ktj4eXvZUVWS918k+kQmlchxDGb4ztUp
        GX/sfmj9BnPVC78th+jdXR0kbAXSDqATWbePnCs2/baYo8hhUJHdXo9dCgQ+z2D4Qd1yg2oZd9xxz
        I8dPD+jg==;
Received: from 251.48.60.213.dynamic.reverse-mundo-r.com ([213.60.48.251] helo=vega.mundo-R.com)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qxjLV-00FHU5-13; Tue, 31 Oct 2023 08:39:29 +0100
From:   Iago Toral Quiroga <itoral@igalia.com>
To:     dri-devel@lists.freedesktop.org, Maira Canal <mcanal@igalia.com>
Cc:     Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        Iago Toral Quiroga <itoral@igalia.com>
Subject: [PATCH v3 1/4] drm/v3d: update UAPI to match user-space for V3D 7.x
Date:   Tue, 31 Oct 2023 08:38:56 +0100
Message-Id: <20231031073859.25298-2-itoral@igalia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031073859.25298-1-itoral@igalia.com>
References: <20231031073859.25298-1-itoral@igalia.com>
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

V3D 7.x takes a new parameter to configure TFU jobs that needs
to be provided by user space.

Signed-off-by: Iago Toral Quiroga <itoral@igalia.com>
Reviewed-by: Maíra Canal <mcanal@igalia.com>
---
v2: added s-o-b, fixed typo in commit message (Maíra Canal)

 include/uapi/drm/v3d_drm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/drm/v3d_drm.h b/include/uapi/drm/v3d_drm.h
index 3dfc0af8756a..1a7d7a689de3 100644
--- a/include/uapi/drm/v3d_drm.h
+++ b/include/uapi/drm/v3d_drm.h
@@ -319,6 +319,11 @@ struct drm_v3d_submit_tfu {
 
 	/* Pointer to an array of ioctl extensions*/
 	__u64 extensions;
+
+	struct {
+		__u32 ioc;
+		__u32 pad;
+	} v71;
 };
 
 /* Submits a compute shader for dispatch.  This job will block on any
-- 
2.39.2

