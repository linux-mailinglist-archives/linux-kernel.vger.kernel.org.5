Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F282B7E4CD4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344422AbjKGXXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbjKGXX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:23:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E657B10C8;
        Tue,  7 Nov 2023 15:23:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE803C433CB;
        Tue,  7 Nov 2023 23:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699399380;
        bh=Gl9SuUNgp53c9A2XY9WRzZmWHWKI1qzZxd2y9nAFbXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NSUPQZv1hQOa7emqytN3yQJRWompotoSDnJtSbDddxm0KWHDGtnFwRRLbnOtWpODx
         pr6W0AGTF1dcGTMHlmR3+Tytsuw6Sycj5hm/5zuXJdBdK9vXUQlv5PFlNPQkDgEjHK
         FQt3bWtZa1nj1cBRw8QW3Q74QQ/WaiXRY0FBtk3NZ9ydSTsEYiqsG3B3oIVG2cgaUN
         6eWg5XhoVSUGzBY5V2sI3a+N0wlHHy/4OCI2/RCjigN7sW1CIIupt5k1q2/a6eXf1X
         kqzhuCH3/LsLOCcatWc+IRDi5G+w5y1dN1KJy14Mb74p9Bwy6I3x5Mj0j1dEi4gwLq
         DLC7Al1k3i9SA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.6 12/18] soundwire: dmi-quirks: update HP Omen match
Date:   Tue,  7 Nov 2023 18:22:06 -0500
Message-ID: <20231107232231.3775605-12-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107232231.3775605-1-sashal@kernel.org>
References: <20231107232231.3775605-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 4ea2b6d3128ea4d502c4015df0dc16b7d1070954 ]

New platforms have a slightly different DMI product name, remove
trailing characters/digits to handle all cases

Closes: https://github.com/thesofproject/linux/issues/4611
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20231013010833.114271-1-yung-chuan.liao@linux.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/dmi-quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/dmi-quirks.c b/drivers/soundwire/dmi-quirks.c
index 2a1096dab63d3..9ebdd0cd0b1cf 100644
--- a/drivers/soundwire/dmi-quirks.c
+++ b/drivers/soundwire/dmi-quirks.c
@@ -141,7 +141,7 @@ static const struct dmi_system_id adr_remap_quirk_table[] = {
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "OMEN by HP Gaming Laptop 16-k0xxx"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OMEN by HP Gaming Laptop 16"),
 		},
 		.driver_data = (void *)hp_omen_16,
 	},
-- 
2.42.0

