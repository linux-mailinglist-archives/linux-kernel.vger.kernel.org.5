Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996D17B46BD
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbjJAKYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbjJAKY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:24:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0631FC2
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 03:24:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552FEC433C8;
        Sun,  1 Oct 2023 10:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696155866;
        bh=HXGeAMZr4b28kGCpvXR8zaxGeeL/xNxHkFhtrUEbvvA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=hZKEMFg9c8PCe2pzd9h4YdUxbxfFn4eKADK0KsByzGHRZFKsKTUBqbPSHkLBLn+Gh
         75b4m5daka8Vfpvt7ghlVqHOGLASK+aPF2gJqYsbYnTsll3GdcuE6CKKn7/vTlXsKM
         eJcnYW+1cdTAXkTNWIZaLdqM9KrPpCmdKk7mDQ5DPwzp+62M+0JnBjOT5+g2Ndorg4
         Su78W53ZZikL0IV1Xk0ri7GRNtM3OH4vTZMRf3gJdrnsN7GRVX41KCQ12JXhzbzpL8
         w9xyLc1GT6xzst2mO8zPLA31zbjoh4d1sOOuudnCTZoOgxWs769P3liu7VXLXHcdFy
         02H+PS4LBL9iA==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 01 Oct 2023 11:24:13 +0100
Subject: [PATCH 1/2] drm/panel: ili9322: Remove redundant volatle_reg()
 operation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-drm-sn65dsi83-maple-v1-1-5519799a55e5@kernel.org>
References: <20231001-drm-sn65dsi83-maple-v1-0-5519799a55e5@kernel.org>
In-Reply-To: <20231001-drm-sn65dsi83-maple-v1-0-5519799a55e5@kernel.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1243; i=broonie@kernel.org;
 h=from:subject:message-id; bh=HXGeAMZr4b28kGCpvXR8zaxGeeL/xNxHkFhtrUEbvvA=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhlRJj8sv7G4HuGfPT89eULPD9bKlwxLbM/cNucMSV/ata
 ElInfSrk9GYhYGRi0FWTJFl7bOMVenhElvnP5r/CmYQKxPIFAYuTgGYiK8Y+/9SHoN/QZUZ6Z7G
 Dyq/li3kX71YlXHHYi9Hz8p7HwW+nbwYt2m5N3vbm/fRXNcXJN/2MFZoPv5et35T54nWpIxF8r2
 7V9fP3xMd8/dOox5re9QLs3xNpgQ906bfx65PkU40PdeTn2EuuetBtP6RRVc733RFrdI4OsvBeU
 12FnMEX3uuh32b3cq6K36KL6e4fyo+FmhidORB29GkyNfJ67+G7Tm9etk33jOyFeUxfn2W76PEI
 7bxGMYcuX6loUlc2d9uBa9hYbBNwFLOoFd1HeeTpzbez3rC4elQ+Lfp/a7ay6FPNzi8rmOMvVE0
 /1Vn5MHcCVGGLLdcPgcvEpyT+NW2eQqLA9vsNJs9lovDAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ili9322 driver has a volatile_reg() operation in it's regmap which
always returns false. This is redundant since it is the default in the
regmap core, remove the operation for a trivial code size and performance
improvement.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9322.c b/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
index 61c872f0f7ca..15b81e5228b5 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
@@ -325,11 +325,6 @@ static struct regmap_bus ili9322_regmap_bus = {
 	.val_format_endian_default = REGMAP_ENDIAN_BIG,
 };
 
-static bool ili9322_volatile_reg(struct device *dev, unsigned int reg)
-{
-	return false;
-}
-
 static bool ili9322_writeable_reg(struct device *dev, unsigned int reg)
 {
 	/* Just register 0 is read-only */
@@ -343,7 +338,6 @@ static const struct regmap_config ili9322_regmap_config = {
 	.val_bits = 8,
 	.max_register = 0x44,
 	.cache_type = REGCACHE_RBTREE,
-	.volatile_reg = ili9322_volatile_reg,
 	.writeable_reg = ili9322_writeable_reg,
 };
 

-- 
2.39.2

