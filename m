Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D098D7DC778
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343670AbjJaHj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343654AbjJaHjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:39:51 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC89DE;
        Tue, 31 Oct 2023 00:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=De/PIfkZVAOyTSP91PR0+gMsXQuIhR9hutDnDNGhWn0=; b=G9hUHRdT++O/1+D/N4JHwi3uc2
        Xjhi2sFxsq8Q8KQ3DVXLthnFFMWoMivphquUM3Ny0736uudakbPTHSVpmylOwfZoZNKxyqTTnNezl
        TRdyr+5W8kyeqhAZf/RFmXeA7eQCoO9Gbdg3w1Ko783OZlmu/R0WZ1BZVdgKvWk7ATraiK5dQ/DWU
        f66SFF8UzOBkjwM1PPBurTRg4Q/9dXaWPwv5SpoWEKV0Wyy8do3NnMzvrUPWQXJoDqFjlHGhpVc2P
        tbzFNs/tClt37KVqN8RGScscZ/4QNDFHlXTraL/vOV7jjsZHGRhMuw6GOKD2DzXmsiDJM2jQDdEOZ
        rHW10Djw==;
Received: from 251.48.60.213.dynamic.reverse-mundo-r.com ([213.60.48.251] helo=vega.mundo-R.com)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qxjLW-00FHU5-Fz; Tue, 31 Oct 2023 08:39:30 +0100
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
Subject: [PATCH v3 4/4] drm/v3d: add brcm,2712-v3d as a compatible V3D device
Date:   Tue, 31 Oct 2023 08:38:59 +0100
Message-Id: <20231031073859.25298-5-itoral@igalia.com>
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

This is required to get the V3D module to load with Raspberry Pi 5.

Signed-off-by: Iago Toral Quiroga <itoral@igalia.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index ffbbe9d527d3..1ab46bdf8ad7 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -187,6 +187,7 @@ static const struct drm_driver v3d_drm_driver = {
 
 static const struct of_device_id v3d_of_match[] = {
 	{ .compatible = "brcm,2711-v3d" },
+	{ .compatible = "brcm,2712-v3d" },
 	{ .compatible = "brcm,7268-v3d" },
 	{ .compatible = "brcm,7278-v3d" },
 	{},
-- 
2.39.2

