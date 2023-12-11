Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06AD80CB64
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343751AbjLKNv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343710AbjLKNvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:51:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99734E4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:51:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F17C433C8;
        Mon, 11 Dec 2023 13:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702302716;
        bh=cxnve05K/VRYJl8jpV68XU1TGjaNM2S97d2vtX+mAx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pv4QoFA4GUdNp+p0/JjgdS2cLfaj/DR+kNwA/UJUDO4HhuCS9eGZ/ZPg1TeZfnPiA
         nnHamQg5Q7gCzRGf5R4uLXzMAuBqhnL9297R03oqsdOjKCRMI6enfZpVB1l2SOCRTJ
         GyB37Va89H0KDXwrFKqVKXQyNXZIR5wt/GCvkuDubz4wK8zEYAx59ilVZvJiq5+6Ok
         SDu9ItLjWHD+c9VTOApEhGtbMWLtD2lElNC+v1gzGbfkFSEz6sOd/EOxbsiNJ9jysF
         4RrrvMrrbBbkCemKSQXuGKFISChhjL5kF+1K2ajRIPe5ZvV0fZZumqVQPXMDQModhf
         Q9lufODq8x5nw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matus Malych <matus@malych.org>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, mario.limonciello@amd.com,
        jeremy@system76.com, git@augustwikerfors.se,
        Syed.SabaKareem@amd.com, linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 03/47] ASoC: amd: yc: Add HP 255 G10 into quirk table
Date:   Mon, 11 Dec 2023 08:50:04 -0500
Message-ID: <20231211135147.380223-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matus Malych <matus@malych.org>

[ Upstream commit 0c6498a59fbbcbf3d0a58c282dd6f0bca0eed92a ]

HP 255 G10's internal microphone array can be made
to work by adding it to the quirk table.

Signed-off-by: Matus Malych <matus@malych.org>
Link: https://lore.kernel.org/r/20231112165403.3221-1-matus@malych.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 15a864dcd7bd3..e2a510443bf1c 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -367,6 +367,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8A3E"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8B2F"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.42.0

