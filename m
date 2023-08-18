Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13ECA780423
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357418AbjHRDDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357384AbjHRDC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:02:59 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857C41BB;
        Thu, 17 Aug 2023 20:02:58 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qWpl3-00054P-1n;
        Fri, 18 Aug 2023 03:02:41 +0000
Date:   Fri, 18 Aug 2023 04:02:35 +0100
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
Subject: [PATCH 1/2] pinctrl: mediatek: fix pull_type data for MT7981
Message-ID: <7bcc8ead25dbfabc7f5a85d066224a926fbb4941.1692327317.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MediaTek has released pull_type data for MT7981 in their SDK.
Use it and set functions to configure pin bias.

Fixes: 6c83b2d94fcc ("pinctrl: add mt7981 pinctrl driver")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/pinctrl/mediatek/pinctrl-mt7981.c | 44 +++++++----------------
 1 file changed, 13 insertions(+), 31 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7981.c b/drivers/pinctrl/mediatek/pinctrl-mt7981.c
index 18abc57800111..0fd2c0c451f95 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7981.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7981.c
@@ -457,37 +457,15 @@ static const unsigned int mt7981_pull_type[] = {
 	MTK_PULL_PUPD_R1R0_TYPE,/*34*/ MTK_PULL_PUPD_R1R0_TYPE,/*35*/
 	MTK_PULL_PUPD_R1R0_TYPE,/*36*/ MTK_PULL_PUPD_R1R0_TYPE,/*37*/
 	MTK_PULL_PUPD_R1R0_TYPE,/*38*/ MTK_PULL_PUPD_R1R0_TYPE,/*39*/
-	MTK_PULL_PUPD_R1R0_TYPE,/*40*/ MTK_PULL_PUPD_R1R0_TYPE,/*41*/
-	MTK_PULL_PUPD_R1R0_TYPE,/*42*/ MTK_PULL_PUPD_R1R0_TYPE,/*43*/
-	MTK_PULL_PUPD_R1R0_TYPE,/*44*/ MTK_PULL_PUPD_R1R0_TYPE,/*45*/
-	MTK_PULL_PUPD_R1R0_TYPE,/*46*/ MTK_PULL_PUPD_R1R0_TYPE,/*47*/
-	MTK_PULL_PUPD_R1R0_TYPE,/*48*/ MTK_PULL_PUPD_R1R0_TYPE,/*49*/
-	MTK_PULL_PUPD_R1R0_TYPE,/*50*/ MTK_PULL_PUPD_R1R0_TYPE,/*51*/
-	MTK_PULL_PUPD_R1R0_TYPE,/*52*/ MTK_PULL_PUPD_R1R0_TYPE,/*53*/
-	MTK_PULL_PUPD_R1R0_TYPE,/*54*/ MTK_PULL_PUPD_R1R0_TYPE,/*55*/
-	MTK_PULL_PUPD_R1R0_TYPE,/*56*/ MTK_PULL_PUPD_R1R0_TYPE,/*57*/
-	MTK_PULL_PUPD_R1R0_TYPE,/*58*/ MTK_PULL_PUPD_R1R0_TYPE,/*59*/
-	MTK_PULL_PUPD_R1R0_TYPE,/*60*/ MTK_PULL_PUPD_R1R0_TYPE,/*61*/
-	MTK_PULL_PUPD_R1R0_TYPE,/*62*/ MTK_PULL_PUPD_R1R0_TYPE,/*63*/
-	MTK_PULL_PUPD_R1R0_TYPE,/*64*/ MTK_PULL_PUPD_R1R0_TYPE,/*65*/
-	MTK_PULL_PUPD_R1R0_TYPE,/*66*/ MTK_PULL_PUPD_R1R0_TYPE,/*67*/
-	MTK_PULL_PUPD_R1R0_TYPE,/*68*/ MTK_PULL_PU_PD_TYPE,/*69*/
-	MTK_PULL_PU_PD_TYPE,/*70*/ MTK_PULL_PU_PD_TYPE,/*71*/
-	MTK_PULL_PU_PD_TYPE,/*72*/ MTK_PULL_PU_PD_TYPE,/*73*/
-	MTK_PULL_PU_PD_TYPE,/*74*/ MTK_PULL_PU_PD_TYPE,/*75*/
-	MTK_PULL_PU_PD_TYPE,/*76*/ MTK_PULL_PU_PD_TYPE,/*77*/
-	MTK_PULL_PU_PD_TYPE,/*78*/ MTK_PULL_PU_PD_TYPE,/*79*/
-	MTK_PULL_PU_PD_TYPE,/*80*/ MTK_PULL_PU_PD_TYPE,/*81*/
-	MTK_PULL_PU_PD_TYPE,/*82*/ MTK_PULL_PU_PD_TYPE,/*83*/
-	MTK_PULL_PU_PD_TYPE,/*84*/ MTK_PULL_PU_PD_TYPE,/*85*/
-	MTK_PULL_PU_PD_TYPE,/*86*/ MTK_PULL_PU_PD_TYPE,/*87*/
-	MTK_PULL_PU_PD_TYPE,/*88*/ MTK_PULL_PU_PD_TYPE,/*89*/
-	MTK_PULL_PU_PD_TYPE,/*90*/ MTK_PULL_PU_PD_TYPE,/*91*/
-	MTK_PULL_PU_PD_TYPE,/*92*/ MTK_PULL_PU_PD_TYPE,/*93*/
-	MTK_PULL_PU_PD_TYPE,/*94*/ MTK_PULL_PU_PD_TYPE,/*95*/
-	MTK_PULL_PU_PD_TYPE,/*96*/ MTK_PULL_PU_PD_TYPE,/*97*/
-	MTK_PULL_PU_PD_TYPE,/*98*/ MTK_PULL_PU_PD_TYPE,/*99*/
-	MTK_PULL_PU_PD_TYPE,/*100*/
+	MTK_PULL_PU_PD_TYPE,/*40*/ MTK_PULL_PU_PD_TYPE,/*41*/
+	MTK_PULL_PU_PD_TYPE,/*42*/ MTK_PULL_PU_PD_TYPE,/*43*/
+	MTK_PULL_PU_PD_TYPE,/*44*/ MTK_PULL_PU_PD_TYPE,/*45*/
+	MTK_PULL_PU_PD_TYPE,/*46*/ MTK_PULL_PU_PD_TYPE,/*47*/
+	MTK_PULL_PU_PD_TYPE,/*48*/ MTK_PULL_PU_PD_TYPE,/*49*/
+	MTK_PULL_PU_PD_TYPE,/*50*/ MTK_PULL_PU_PD_TYPE,/*51*/
+	MTK_PULL_PU_PD_TYPE,/*52*/ MTK_PULL_PU_PD_TYPE,/*53*/
+	MTK_PULL_PU_PD_TYPE,/*54*/ MTK_PULL_PU_PD_TYPE,/*55*/
+	MTK_PULL_PU_PD_TYPE,/*56*/
 };
 
 static const struct mtk_pin_reg_calc mt7981_reg_cals[] = {
@@ -1014,6 +992,10 @@ static struct mtk_pin_soc mt7981_data = {
 	.ies_present = false,
 	.base_names = mt7981_pinctrl_register_base_names,
 	.nbase_names = ARRAY_SIZE(mt7981_pinctrl_register_base_names),
+	.bias_disable_set = mtk_pinconf_bias_disable_set,
+	.bias_disable_get = mtk_pinconf_bias_disable_get,
+	.bias_set = mtk_pinconf_bias_set,
+	.bias_get = mtk_pinconf_bias_get,
 	.pull_type = mt7981_pull_type,
 	.bias_set_combo = mtk_pinconf_bias_set_combo,
 	.bias_get_combo = mtk_pinconf_bias_get_combo,
-- 
2.41.0
