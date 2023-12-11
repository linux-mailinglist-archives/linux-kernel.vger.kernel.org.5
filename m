Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB4D80CC3B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343777AbjLKN7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343820AbjLKN6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:58:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A62226AD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:56:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E470C433C8;
        Mon, 11 Dec 2023 13:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702303010;
        bh=bYKkKLzZA8jGXcnt6bR9g4qRqoJgH/dKArVF5Co8L98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LA3EcSqm3uQl/934YG3mOEgOClGDO+z1TEqfFBe8uBCSTYoRi4W9Or7oVif/hHU6/
         bDQwf54YnORtQy7nqyu15upP64xFl/eFOld1PUzgDE5lWkq6JRC72uCxvJTkSloZGw
         +046fblIrCj7ZJuYDXfpvEiTE5MLw/a+fucked6AZRnWnTzCS0YXDL91za0xO7YBWb
         8zwryIS5faNGkbpeHBbJW7VPRoLbwP84VNzU8TUt8nIH3CjlOjhP/2GUmasnuw3Wat
         vocJSUrhez3h2t4RzzKUowtKU36ljM9OfxC70tahEuzpPl4xmi5eKW5bMyNQlGmb+H
         RNK2VIS8MpaSA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alvin Lee <alvin.lee2@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Samson Tam <samson.tam@amd.com>,
        Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, felipe.clark@amd.com, tony.tascioglu@amd.com,
        ruanjinjie@huawei.com, drv@mailo.com, sunran001@208suo.com,
        mario.limonciello@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 23/29] drm/amd/display: Use channel_width = 2 for vram table 3.0
Date:   Mon, 11 Dec 2023 08:54:07 -0500
Message-ID: <20231211135457.381397-23-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135457.381397-1-sashal@kernel.org>
References: <20231211135457.381397-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.66
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Lee <alvin.lee2@amd.com>

[ Upstream commit fec05adc40c25a028c9dfa9d540f800a2d433f80 ]

VBIOS has suggested to use channel_width=2 for any ASIC that uses vram
info 3.0. This is because channel_width in the vram table no longer
represents the memory width

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index e507d2e1410b7..72891d69afb68 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2402,7 +2402,13 @@ static enum bp_result get_vram_info_v30(
 		return BP_RESULT_BADBIOSTABLE;
 
 	info->num_chans = info_v30->channel_num;
-	info->dram_channel_width_bytes = (1 << info_v30->channel_width) / 8;
+	/* As suggested by VBIOS we should always use
+	 * dram_channel_width_bytes = 2 when using VRAM
+	 * table version 3.0. This is because the channel_width
+	 * param in the VRAM info table is changed in 7000 series and
+	 * no longer represents the memory channel width.
+	 */
+	info->dram_channel_width_bytes = 2;
 
 	return result;
 }
-- 
2.42.0

