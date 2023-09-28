Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D95D7B2609
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 21:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjI1TnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 15:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI1TnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 15:43:17 -0400
X-Greylist: delayed 401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Sep 2023 12:43:14 PDT
Received: from halley.uberspace.de (halley.uberspace.de [185.26.156.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595171A1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 12:43:14 -0700 (PDT)
Received: (qmail 19271 invoked by uid 498); 28 Sep 2023 19:36:31 -0000
Authentication-Results: halley.uberspace.de;
        auth=pass (plain)
From:   Kai Uwe Broulik <foss-linux@broulik.de>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Kai Uwe Broulik <foss-linux@broulik.de>
Subject: [PATCH] drm: panel-orientation-quirks: Add quirk for One Mix 2S
Date:   Thu, 28 Sep 2023 21:35:58 +0200
Message-Id: <20230928193558.2228730-1-foss-linux@broulik.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -
X-Rspamd-Report: MID_CONTAINS_FROM(1) BAYES_HAM(-2.997336) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -1.597336
Received: from unknown (HELO unkown) (::1)
        by halley.uberspace.de (Haraka/3.0.1) with ESMTPSA; Thu, 28 Sep 2023 21:36:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=broulik.de; s=uberspace;
        h=from;
        bh=hsyA3JeFc7lPYPSEDFueqHSjDgW9MvWF8HHghEmTgwY=;
        b=YY+Atr5cQU0D0nCZy74zNiP4cY7hLbxi3znuwerob6Ilvga459CiWmI6pkwbRhxL0WHWjg3lPq
        3GMhlr+RPF/GpuOEiQqh/tWNUOe17FrS85YZm/Ql4iF9L2BRH7+7SN1cemX4P5R53N1Vl2UnUe0M
        CZyStMMAgdthR/SBkzoZJhkoIumf36xK8rM9dZRihACQZqeeGyAZQjtfirUshOH1a8J8skWQH/xF
        TLmD8GXDPGhvFjW9rU58Xpt2lvxvyzMiayqxlA76/gdQ6yk2EgFy1/xOO7lG96v/HqpCxCJWypID
        yeB6Vb71fhXAMFKfn8Z/iiyFVxfC8Jd9wpUtGzyFIBpgpFO6JUDGvRGGxZZlVB11IzI6fe/iF4pZ
        zbduXR0SoKP8N6qd6mJ9WKjfthiyjmZiuJaF8lm5adycN4YG6dZrk2DXvuGm2WwOCXnbsc2zElJB
        sN99dPkeoP9Ae4lWtlDItDO8hSxHPYycLb3hmxsZio/3zSme2bdyvTTbeZk/bd4FoCNF4s+HCttg
        5o31NyMngCpXvpyYcrE8S5FVhmjMiaBQ5565IHw8y1GfRRoB42D5Sn+WSSj9RS+N8b54NmaEcylb
        GFkFvOpqUlu5+ac3GdZhgkNprTmEWwotWQtU+NewpMvFu+nGXswSoFxVx0COvrmP1JLPayLVvVl0
        o=
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The One Mix 2S is a mini laptop with a 1200x1920 portrait screen
mounted in a landscape oriented clamshell case. Because of the too
generic DMI strings this entry is also doing bios-date matching.

Signed-off-by: Kai Uwe Broulik <foss-linux@broulik.de>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 0cb646cb04ee..cc9a9099faaf 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -38,6 +38,14 @@ static const struct drm_dmi_panel_orientation_data gpd_micropc = {
 	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
 };
 
+static const struct drm_dmi_panel_orientation_data gpd_onemix2s = {
+	.width = 1200,
+	.height = 1920,
+	.bios_dates = (const char * const []){ "03/04/2019",
+		NULL },
+	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
+};
+
 static const struct drm_dmi_panel_orientation_data gpd_pocket = {
 	.width = 1200,
 	.height = 1920,
@@ -401,6 +409,14 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "LTH17"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* One Mix 2S (generic strings, also match on bios date) */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Default string"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Default string"),
+		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Default string"),
+		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "Default string"),
+		},
+		.driver_data = (void *)&gpd_onemix2s,
 	},
 	{}
 };
-- 
2.34.1

