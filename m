Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7705774F44
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 01:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjHHX0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 19:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHHX0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 19:26:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDBC19BF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 16:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=NsaIqfpGRHhuu1KEMbWRWbIrElmncZ2eWcE/szEec0U=; b=lRAlkGHwHqRqhYDz5CZ6wQhW1H
        IcmI41Bxr7NnXFiRhoKeqFA8t692165C+ej5ZKP0u3OfaLp5LY5bJiMLZGisVNf1IBP0cFgTBQASI
        kPidY1gp0VUmAibD2pa7QSVzyCZ1kvNKbo+Kq9m9/SmReKR1Tv5HC74QhsGv1VpN7A4HjrlECX7WI
        zTccirgNLlkJhEeX6x3+QiiVQV26hVVIpbH/AjjA+LUNRylTtSqnGbfRg21IXEDOthv1Lb6E4WZMZ
        sIGP2ykAktnq2/yUbhINhqWsz+OCugd519yqsh//OO3phvFUVHUpi5swgNeBpAIihP6NHNfZaWn1o
        EYPeKDGQ==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTW5s-003fom-2j;
        Tue, 08 Aug 2023 23:26:29 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        amd-gfx@lists.freedesktop.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: dmub_replay: don't use kernel-doc markers
Date:   Tue,  8 Aug 2023 16:26:26 -0700
Message-ID: <20230808232627.21168-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions don't use kernel-doc notation for comments so
don't begin each comment block with the "/**" kernel-doc marker.

This prevents a bunch of kernel-doc warnings:

dmub_replay.c:37: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
dmub_replay.c:37: warning: missing initial short description on line:
 * Get Replay state from firmware.
dmub_replay.c:66: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
dmub_replay.c:66: warning: missing initial short description on line:
 * Enable/Disable Replay.
dmub_replay.c:116: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
dmub_replay.c:116: warning: missing initial short description on line:
 * Set REPLAY power optimization flags.
dmub_replay.c:134: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
dmub_replay.c:134: warning: missing initial short description on line:
 * Setup Replay by programming phy registers and sending replay hw context values to firmware.
and 10 more similar warnings.

Fixes: c7ddc0a800bc ("drm/amd/display: Add Functions to enable Freesync Panel Replay")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: lore.kernel.org/r/202308081459.US5rLYAY-lkp@intel.com
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: Christian König <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c |   18 ++++++-------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff -- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -33,7 +33,7 @@
 
 #define MAX_PIPES 6
 
-/**
+/*
  * Get Replay state from firmware.
  */
 static void dmub_replay_get_state(struct dmub_replay *dmub, enum replay_state *state, uint8_t panel_inst)
@@ -62,7 +62,7 @@ static void dmub_replay_get_state(struct
 	}
 }
 
-/**
+/*
  * Enable/Disable Replay.
  */
 static void dmub_replay_enable(struct dmub_replay *dmub, bool enable, bool wait, uint8_t panel_inst)
@@ -112,7 +112,7 @@ static void dmub_replay_enable(struct dm
 
 }
 
-/**
+/*
  * Set REPLAY power optimization flags.
  */
 static void dmub_replay_set_power_opt(struct dmub_replay *dmub, unsigned int power_opt, uint8_t panel_inst)
@@ -130,7 +130,7 @@ static void dmub_replay_set_power_opt(st
 	dm_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 }
 
-/**
+/*
  * Setup Replay by programming phy registers and sending replay hw context values to firmware.
  */
 static bool dmub_replay_copy_settings(struct dmub_replay *dmub,
@@ -215,7 +215,7 @@ static bool dmub_replay_copy_settings(st
 	return true;
 }
 
-/**
+/*
  * Set coasting vtotal.
  */
 static void dmub_replay_set_coasting_vtotal(struct dmub_replay *dmub,
@@ -234,7 +234,7 @@ static void dmub_replay_set_coasting_vto
 	dm_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 }
 
-/**
+/*
  * Get Replay residency from firmware.
  */
 static void dmub_replay_residency(struct dmub_replay *dmub, uint8_t panel_inst,
@@ -267,7 +267,7 @@ static const struct dmub_replay_funcs re
 	.replay_residency		= dmub_replay_residency,
 };
 
-/**
+/*
  * Construct Replay object.
  */
 static void dmub_replay_construct(struct dmub_replay *replay, struct dc_context *ctx)
@@ -276,7 +276,7 @@ static void dmub_replay_construct(struct
 	replay->funcs = &replay_funcs;
 }
 
-/**
+/*
  * Allocate and initialize Replay object.
  */
 struct dmub_replay *dmub_replay_create(struct dc_context *ctx)
@@ -293,7 +293,7 @@ struct dmub_replay *dmub_replay_create(s
 	return replay;
 }
 
-/**
+/*
  * Deallocate Replay object.
  */
 void dmub_replay_destroy(struct dmub_replay **dmub)
