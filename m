Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A9A7B0D5E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 22:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjI0U0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 16:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjI0U00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 16:26:26 -0400
Received: from sonic307-54.consmr.mail.ir2.yahoo.com (sonic307-54.consmr.mail.ir2.yahoo.com [87.248.110.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6911121
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 13:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1695846381; bh=5xyF+KReJNWWxWCi7Ez3mVy/VMtqQScvdho4KTEIt0E=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=A1ki3GZ2UgkUpg4cmRNHiLh8DOeQPyz4SQiEWjFd42AzVz7UGlWLG/yIncW8Ml/7TeSKl/o/SrqQam9a6gWkt0rdtP1dfbZUJ+etWzfHxmiu8PfAVrrzK0QXwEqqbeUBb0qUP7q23Y1p2RXyNBS8ANnloAjN0zKcr5GYGqpOjf+TnhYv7uULaibD+hHqdfCr5Ad1ZJ5K9E3FPvXOBf7PlSfaW4OGU1STkte+i8afkVvy5zU4IC59ObIo8JcRbf4PGevDIKR7/Ot8WOBOUWF1kxQ4qcFmEjAi1zqmUmtccptG2wGJCzD6xNzM66y9/ftW/y4s65h91WGsbGESy/gt3g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1695846381; bh=Wb28mO+t+8IOr2hAdJHoSdh7nqXlI4Bo3bWZKM9csLN=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=CNDM5w0hsc/zHlvtktGuWlk1R60RfOnMaDJE7aSLes9xYLHH1jGhPcNN0eA4Oisyhr43jyIeljg1+Nd2lWBQOUZeKeyl0ldktUvPDFIi4p6cHhfqImRh9Mwsi9ZAX2t1U8ZCsi4y1EIhkHb+RyOo2DNk6LkjgfbByPLZX12kOWQISe6GPIuep928A1QoCBhqTS4Ae9+MjwbMgBbYDN7iu4S7PZrK/kSo0LTZl03pT+qWLyaTab+Uh6hgSjsPX4TB5jDp4lvgLZ4u+1EM4sbNeZ/oHrEXAzDJyWGmR0NHQLnO7pbxW6EGowULbOAl5RKXzgvVE4FwP/giVManZacRVw==
X-YMail-OSG: AjIJuBAVM1kZPklCHWy5Oyjwcn2GSbjO9mG2xFZmrET9esIggxY4Z3CjGKtY5Ux
 JdmRPG0Aa7sdD90NOIrZjYK2PdMbsPCgmkycv4wwNqa6f6xDvXKZ7h6GUI_K1nbj5zuTMmed3dpx
 JxyTxW_8ffG92oQCWnrgD9oVbmGhJgCMasBsP6zmIwN4lvUBeWy187hBxuy07DSS.b8KBBELlC55
 K4zdvIna4H_Lf8rPlcZDuDnB5hOmpCCQLN5nyjd1OTSlx_kko27N3eVmvnwsr2jrY5tEFvJR4k.N
 70zvcPraWieuzp20gymXeLbDWcy_zQEZjzWFx30Otx5hV6zWttccnQbX37IXtM1Nr3IK6qCowESk
 09EbFXQgiTtD0cV0E6ej8C58qX8KyuYTpwXYTnx_WsBqQ7qUFGdi6LEdbdq91sJJrZRQBOHzGAcI
 Qz4KgBjkB8YaChz_juDTGy6C5UcMTccvnAV4Ao7vZDWLI5dcIbibl0SorteqxyHkjRWHminVanw_
 2dSlUNs93IQYaC3zAjT6s3PVFOYjMgHaAmRKyz8Yc32_bse4ALdTgStLqXcG5z1_oLrCiZXhdKxB
 hedju1c16rQK6L6xAV8Lx9kHv7wZmb.kyh4c_kFlm2i6dHdS_yM8U37EOru4gFzgbTy5poJwRxu0
 11Dc2iAEy3wGAxm0cOCpv9tbpfVvvzMVer_ATff5x8a95.i55vHuAEWRr0qGrHlpsrwC2uA176wU
 Q007zV1wD8wzkSuiClVFrvgV85GzZi4yGONnv1sTf2i9iuryvMSxPn2qZNK3XkCxzjC2W6BHESDR
 _SnUxR8TUDBOtLfnACEYjiboCBJoMktBlu.b8WBSCO_6yhRCgAOCHRDAw3ci3MfGcmNKzscPPzAJ
 nGn1bEQ1V8J6caQHAGXVLNxYYMj5cshK2pO0gKgLld_bUK9v0Uu8k2ReYbVA7Xhvf10vDy3hPQWH
 kb4CIED6TOlLRo8jy3MtxHZ4FPmO98mu0SpnEfXk3o7cQJDE0v9jaTMqq2SYwdgRx1POUG9q.A.7
 y9lh6obMCXJzm9yfgLBalQcrta.uHtgtezvCTzDkXpPTDRS6opkAAizRHgdWQJuIkVqZd5W1W8X3
 HWj_DEP4fyxtmbv78WXuM5KTohRI90_bp58snAP3uacjBGeSVg8WpEnQmOfcez3dRrm7tRATtSXR
 iwJ_1iUHVXFk6czieak0j_rmp4O17dUq2k9aumgYQjN8NP54bmqN24nZJhKv3D4zPFLWv2QoovAo
 nqRTfB.F47XNO.nQqwOypfQsPxzLh6oKDS.rgj0UIZesIKlaWwDSFlwIPTV69fyaDwM75RqOIcKa
 UJQiH0OV7CqBJzN56SAVBEAdmGaCXW0QyLv3vUguMAKUN3Eceixp2pIN1tVCjztjdJfZStjCifSq
 sc1b_yf_sFHZNo9n7EqJAHrgmxj2V8JeVuW7lV.RVjVpxPP3NqO7BvXtl00e76t.EVA6kOYJ0deX
 3IquNVQmX01oo4JvP1DNioDBBHFm65ko3dG7iX54QDlggXPTTEwKnD0pZGnG_h4M7VDAHBVesOPY
 7Qxcb1ktLvJmvdfxKo6pqHiQWEGRLJyxvTQK9Atng__uDCd0BwNAfQwswCQCpgexeV4u7QEYPFgR
 _EfOfrQf8xMoqTOvxFnwoBEckAWdbAwbCyNNAH5B_kAFbcJ5LqzFYQ4zzithr_dzmytSn6ptnB2y
 k59.AdWW.CD6wiUggybt7fJbxPrjPwSfZCZIeWTvRbqMsLiVQ3tuFU4a08XQyyDeqytQSHzzsIPu
 CxFjWBON7tL_cVGGKmcbz3CpaYBMBSnu9vJpZ7uNkgrH5F1GLyp.Rdmt.uaO5FRX94YKWYvL9ERa
 uO6Boa1Xfa.J2bvkhKq1BXxDx0DKSugWakEt424Xw.oGUDPNEV1h19THCdtSTG7s_xYdyW6LlnG0
 2ib6.HRbTyo4ZiPUCGBhcBfOt9S3CpuoSkDR_xiCkVKJWGizvu9TxZYbdDqDzTQvTLSVL5e.FcO4
 cyhVFndB4NcLCURsN_y_izOUOx8jwgOdS7qCnQ9foteqWBgrzLI6funIdTYVeaIJ1bGyTJDyWe4o
 BMzbid7h.vZHPJTndQ9WTXKaHpdedi_ScAJ_i5rOGel62gjWjRGm.yO4fcYOL9HJ9lOyljFNDdUe
 SNeC1TxBEU8fUTpjX5PiM4Ugd.qgV08wIwRnuV9PeWqXSD5b_UGF7__GnJn7aWllLmHa5BJlwy87
 JpFx6UOb.WoNskA.OomzjKd6m3L.80aiggwzXmH5ehQl4N2mnbjL3mXpM1tKBEF6jk4UaCbq_XSM
 EjmfYn9JDKIg8g18flKokyHXMmJ2Lbnns.OiT
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: dc664729-052d-4421-9fec-a3471547cf86
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Wed, 27 Sep 2023 20:26:21 +0000
Received: by hermes--production-ir2-55db9d9d5-5hvhf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1d998f486e26fd309cd8d11c694d3a2b;
          Wed, 27 Sep 2023 20:26:18 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Lee Jones <lee@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH 4/5] power: supply: rt5033_charger: Simplify initialization of rt5033_charger_data
Date:   Wed, 27 Sep 2023 22:26:01 +0200
Message-Id: <95e236e16e25978d1a0280302cecd3bf59687e98.1695844349.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1695844349.git.jahau@rocketmail.com>
References: <cover.1695844349.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the struct "rt5033_charger_data" is initialized rather complicated.
The cause lies inside of the struct "rt5033_charger", where struct
"rt5033_charger_data" is implemented as a pointer *chg.

Therefore, inside of struct "rt5033_charger" change the struct
"rt5033_charger_data" to non-pointer "chg". It is then initialized right
away and can be accessed more easily.

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 drivers/power/supply/rt5033_charger.c | 29 +++++++++++----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/power/supply/rt5033_charger.c b/drivers/power/supply/rt5033_charger.c
index 091ca4a21f29..b34ef0ea6f8a 100644
--- a/drivers/power/supply/rt5033_charger.c
+++ b/drivers/power/supply/rt5033_charger.c
@@ -29,7 +29,7 @@ struct rt5033_charger {
 	struct device			*dev;
 	struct regmap			*regmap;
 	struct power_supply		*psy;
-	struct rt5033_charger_data	*chg;
+	struct rt5033_charger_data	chg;
 	struct extcon_dev		*edev;
 	struct notifier_block		extcon_nb;
 	struct work_struct		extcon_work;
@@ -131,7 +131,7 @@ static int rt5033_get_charger_const_voltage(struct rt5033_charger *charger)
 
 static inline int rt5033_init_const_charge(struct rt5033_charger *charger)
 {
-	struct rt5033_charger_data *chg = charger->chg;
+	struct rt5033_charger_data *chg = &charger->chg;
 	int ret;
 	unsigned int val;
 	u8 reg_data;
@@ -205,7 +205,7 @@ static inline int rt5033_init_const_charge(struct rt5033_charger *charger)
 
 static inline int rt5033_init_fast_charge(struct rt5033_charger *charger)
 {
-	struct rt5033_charger_data *chg = charger->chg;
+	struct rt5033_charger_data *chg = &charger->chg;
 	int ret;
 	unsigned int val;
 	u8 reg_data;
@@ -250,7 +250,7 @@ static inline int rt5033_init_fast_charge(struct rt5033_charger *charger)
 
 static inline int rt5033_init_pre_charge(struct rt5033_charger *charger)
 {
-	struct rt5033_charger_data *chg = charger->chg;
+	struct rt5033_charger_data *chg = &charger->chg;
 	int ret;
 	unsigned int val;
 	u8 reg_data;
@@ -550,21 +550,16 @@ static int rt5033_charger_get_property(struct power_supply *psy,
 	return 0;
 }
 
-static struct rt5033_charger_data *rt5033_charger_dt_init(
-						struct rt5033_charger *charger)
+static int rt5033_charger_dt_init(struct rt5033_charger *charger)
 {
-	struct rt5033_charger_data *chg;
+	struct rt5033_charger_data *chg = &charger->chg;
 	struct power_supply_battery_info *info;
 	int ret;
 
-	chg = devm_kzalloc(charger->dev, sizeof(*chg), GFP_KERNEL);
-	if (!chg)
-		return ERR_PTR(-ENOMEM);
-
 	ret = power_supply_get_battery_info(charger->psy, &info);
 	if (ret)
-		return ERR_PTR(dev_err_probe(charger->dev, -EINVAL,
-			       "missing battery info\n"));
+		return dev_err_probe(charger->dev, -EINVAL,
+				     "missing battery info\n");
 
 	/* Assign data. Validity will be checked in the init functions. */
 	chg->pre_uamp = info->precharge_current_ua;
@@ -573,7 +568,7 @@ static struct rt5033_charger_data *rt5033_charger_dt_init(
 	chg->pre_uvolt = info->precharge_voltage_max_uv;
 	chg->const_uvolt = info->constant_charge_voltage_max_uv;
 
-	return chg;
+	return 0;
 }
 
 static void rt5033_charger_extcon_work(struct work_struct *work)
@@ -690,9 +685,9 @@ static int rt5033_charger_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(charger->psy),
 				     "Failed to register power supply\n");
 
-	charger->chg = rt5033_charger_dt_init(charger);
-	if (IS_ERR_OR_NULL(charger->chg))
-		return PTR_ERR(charger->chg);
+	ret = rt5033_charger_dt_init(charger);
+	if (ret)
+		return ret;
 
 	ret = rt5033_charger_reg_init(charger);
 	if (ret)
-- 
2.39.2

