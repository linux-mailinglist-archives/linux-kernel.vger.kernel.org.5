Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F4679F69A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 03:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbjINBzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 21:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbjINBzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:55:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6B51BD3;
        Wed, 13 Sep 2023 18:55:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10FCC433CA;
        Thu, 14 Sep 2023 01:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694656512;
        bh=mlGKyzEE2qx03CZ4V/fq80BFyvGbaNnoxihP+Doyi3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IRCdyEERw7xjtmKDS7YYYpJ1tOJb4osTbDQD205vWbq0xMk27UABoOUf/0OlQYjv8
         m+tc3Q1AVz2y6nb4TL21GFc4KSGbD0LV8I4BFoP5V6xq1SKEYRp3gFBNJpThl5PXfB
         v7rxsnGbL8HMc7zyvYBetC/UR/cqOkUj2JvAToIDY0FQEZHB6spHYGylU+9fDRwqOv
         v2ovb4KFdLdJ65de+uyf/4cROiE1O05GK3V3fZ67vqqz4C4HFPsUjABjKzfB/hkhIK
         pOFnYDRXerZvxZL5YTCGahBsBHirdToJB8ipGFaWh7NvQVP2KeIM7AuNJx5EjmZO/g
         qbYf+Z7Xahq4A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shubh <shubhisroking@gmail.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, mario.limonciello@amd.com,
        xazrael@hotmail.com, Syed.SabaKareem@amd.com,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.5 5/7] ASoC: amd: yc: Add DMI entries to support Victus by HP Gaming Laptop 15-fb0xxx (8A3E)
Date:   Wed, 13 Sep 2023 21:54:49 -0400
Message-Id: <20230914015459.51740-5-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914015459.51740-1-sashal@kernel.org>
References: <20230914015459.51740-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.3
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubh <shubhisroking@gmail.com>

[ Upstream commit d1cf5d30b43f1a331032ebf3e11d9e366ab0f885 ]

This model requires an additional detection quirk to
enable the internal microphone.

Signed-off-by: Shubh <shubhisroking@gmail.com>
Link: https://lore.kernel.org/r/20230902150807.133523-1-shubhisroking@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index b304b3562c82b..f7ee792bd1be9 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -325,6 +325,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8A22"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8A3E"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.40.1

