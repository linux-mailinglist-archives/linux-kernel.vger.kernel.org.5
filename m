Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471187E4D42
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344352AbjKGX07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344516AbjKGX0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:26:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134E21BDB;
        Tue,  7 Nov 2023 15:24:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A6BC433C9;
        Tue,  7 Nov 2023 23:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699399472;
        bh=Gl9SuUNgp53c9A2XY9WRzZmWHWKI1qzZxd2y9nAFbXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NaZmiYjHg0NnLZ5YWRjNSL8NoYwvdqqnXtnhl6uuv9rXZWFbP+stNrePfsEp7wo/G
         bZMVQebA4AqHVGfIFy5JqVh5s9xQEEg2Gje7ayTOZUmXAS5z45Pi1B7eEfQnXLZZmg
         DODj9pkquIC/adG8rxTEM8+wRPV2StpFjTxuhtfUt0rTahgDAu/npz/u8c2SKWgzUy
         sF2J8R6D3Ajy++9Jl68DCMkNBAFix2I5HihmNlDiVAXhf/2j1OfXw7L0AKyAjg9i1q
         DaJ4jdbcAu02XEjm/JnfzpBuuGw8GJxG7yS8vP6GnW5dv9ye/PSehj4ASukCJ6LzYb
         Gb0LIVJxOaTzw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.1 07/11] soundwire: dmi-quirks: update HP Omen match
Date:   Tue,  7 Nov 2023 18:24:08 -0500
Message-ID: <20231107232420.3776419-7-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107232420.3776419-1-sashal@kernel.org>
References: <20231107232420.3776419-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
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

