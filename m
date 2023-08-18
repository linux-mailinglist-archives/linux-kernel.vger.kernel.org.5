Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADA9780426
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357425AbjHRDDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357420AbjHRDDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:03:41 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8571E2D56;
        Thu, 17 Aug 2023 20:03:40 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qWpls-000559-2k;
        Fri, 18 Aug 2023 03:03:33 +0000
Date:   Fri, 18 Aug 2023 04:03:26 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Sam Shih <sam.shih@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] pinctrl: mediatek: assign functions to configure pin
 bias on MT7986
Message-ID: <47f72372354312a839b9337e09476aadcc206e8b.1692327317.git.daniel@makrotopia.org>
References: <7bcc8ead25dbfabc7f5a85d066224a926fbb4941.1692327317.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bcc8ead25dbfabc7f5a85d066224a926fbb4941.1692327317.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign bias_disable_get/set and bias_get/set functions to allow
configuring pin bias on MT7986.

Fixes: 2c58d8dc9cd0 ("pinctrl: mediatek: add pull_type attribute for mediatek MT7986 SoC")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/pinctrl/mediatek/pinctrl-mt7986.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7986.c b/drivers/pinctrl/mediatek/pinctrl-mt7986.c
index aa0ccd67f4f4e..acaac9b38aa8a 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7986.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7986.c
@@ -922,6 +922,10 @@ static struct mtk_pin_soc mt7986a_data = {
 	.ies_present = false,
 	.base_names = mt7986_pinctrl_register_base_names,
 	.nbase_names = ARRAY_SIZE(mt7986_pinctrl_register_base_names),
+	.bias_disable_set = mtk_pinconf_bias_disable_set,
+	.bias_disable_get = mtk_pinconf_bias_disable_get,
+	.bias_set = mtk_pinconf_bias_set,
+	.bias_get = mtk_pinconf_bias_get,
 	.pull_type = mt7986_pull_type,
 	.bias_set_combo = mtk_pinconf_bias_set_combo,
 	.bias_get_combo = mtk_pinconf_bias_get_combo,
@@ -944,6 +948,10 @@ static struct mtk_pin_soc mt7986b_data = {
 	.ies_present = false,
 	.base_names = mt7986_pinctrl_register_base_names,
 	.nbase_names = ARRAY_SIZE(mt7986_pinctrl_register_base_names),
+	.bias_disable_set = mtk_pinconf_bias_disable_set,
+	.bias_disable_get = mtk_pinconf_bias_disable_get,
+	.bias_set = mtk_pinconf_bias_set,
+	.bias_get = mtk_pinconf_bias_get,
 	.pull_type = mt7986_pull_type,
 	.bias_set_combo = mtk_pinconf_bias_set_combo,
 	.bias_get_combo = mtk_pinconf_bias_get_combo,
-- 
2.41.0
