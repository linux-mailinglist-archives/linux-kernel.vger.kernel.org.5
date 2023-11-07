Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA74C7E371D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjKGJEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjKGJEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:04:07 -0500
X-Greylist: delayed 2111 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Nov 2023 01:04:03 PST
Received: from 17.mo550.mail-out.ovh.net (17.mo550.mail-out.ovh.net [87.98.179.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5CCFA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:04:03 -0800 (PST)
Received: from director11.ghost.mail-out.ovh.net (unknown [10.108.4.127])
        by mo550.mail-out.ovh.net (Postfix) with ESMTP id 0E9152BBB3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 08:28:50 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-s8vqx (unknown [10.110.208.218])
        by director11.ghost.mail-out.ovh.net (Postfix) with ESMTPS id A83E51FDFD;
        Tue,  7 Nov 2023 08:28:48 +0000 (UTC)
Received: from foxhound.fi ([37.59.142.95])
        by ghost-submission-6684bf9d7b-s8vqx with ESMTPSA
        id jQj6KkD1SWWnLwAA4IXPKg
        (envelope-from <jose.pekkarinen@foxhound.fi>); Tue, 07 Nov 2023 08:28:48 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-95G001000307f4-4e36-45cc-84f3-1e15167bd51f,
                    990ED9DB402E285008FC912DE57946D84A8BC800) smtp.auth=jose.pekkarinen@foxhound.fi
X-OVh-ClientIp: 213.216.211.70
From:   =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        skhan@linuxfoundation.org
Cc:     =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>,
        airlied@gmail.com, daniel@ffwll.ch, Bhawanpreet.Lakha@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] drm/amd/display: clean up redundant conversions to bool
Date:   Tue,  7 Nov 2023 10:28:38 +0200
Message-Id: <20231107082839.92061-1-jose.pekkarinen@foxhound.fi>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17672687891539732161
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudduhedguddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeflohhsrocurfgvkhhkrghrihhnvghnuceojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqnecuggftrfgrthhtvghrnhepfedtleeuteeitedvtedtteeuieevudejfeffvdetfeekleehhfelleefteetjeejnecukfhppeduvdejrddtrddtrddupddvudefrddvudeirddvuddurdejtddpfeejrdehledrudegvddrleehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehhedtpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will address the following couple of warnings retrieved by
using coccinelle, where there is an explicit conversion to bool that
are redundant.

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c:94:102-107: WARNING: conversion to bool not needed here
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c:102:72-77: WARNING: conversion to bool not needed here

Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
index 32d3086c4cb7..5ce542b1f860 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
@@ -91,7 +91,7 @@ bool amdgpu_dm_setup_replay(struct dc_link *link, struct amdgpu_dm_connector *ac
 	pr_config.replay_supported = true;
 	pr_config.replay_power_opt_supported = 0;
 	pr_config.replay_enable_option |= pr_enable_option_static_screen;
-	pr_config.replay_timing_sync_supported = aconnector->max_vfreq >= 2 * aconnector->min_vfreq ? true : false;
+	pr_config.replay_timing_sync_supported = aconnector->max_vfreq >= 2 * aconnector->min_vfreq;
 
 	if (!pr_config.replay_timing_sync_supported)
 		pr_config.replay_enable_option &= ~pr_enable_option_general_ui;
@@ -99,7 +99,7 @@ bool amdgpu_dm_setup_replay(struct dc_link *link, struct amdgpu_dm_connector *ac
 	debug_flags = (union replay_debug_flags *)&pr_config.debug_flags;
 	debug_flags->u32All = 0;
 	debug_flags->bitfields.visual_confirm =
-		link->ctx->dc->debug.visual_confirm == VISUAL_CONFIRM_REPLAY ? true : false;
+		link->ctx->dc->debug.visual_confirm == VISUAL_CONFIRM_REPLAY;
 
 	link->replay_settings.replay_feature_enabled = true;
 
-- 
2.39.2

