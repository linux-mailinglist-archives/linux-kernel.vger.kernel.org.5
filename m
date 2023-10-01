Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72D67B4794
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 15:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbjJANSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 09:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbjJANSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:18:04 -0400
Received: from sonic301-21.consmr.mail.ir2.yahoo.com (sonic301-21.consmr.mail.ir2.yahoo.com [77.238.176.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A91BC
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 06:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1696166280; bh=5xyF+KReJNWWxWCi7Ez3mVy/VMtqQScvdho4KTEIt0E=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=J0JYfMjyRncz4s9KNUJfV1mhF3dkeK0MlhNqvV81fixw+6OTC1G246mJ2pDtTYWAkGLDHHqwihRzKduGmePVFtgrTLT6D+wYafLqVkgKbNFONQ3yyPZJR99ankkItaFoq6NZwOxcAn1DDHuPwbnM0qrxYqIEibvKcZ8P1Je6DcPjJu70GQOmf/ulr5qNE66NCOcW6vtjH2rPrgokKs33rrP7RZTUXXh73kBejbIXebelrAYnhwP4I92GD4/H7vw/+jlcxDfmom0DITBWmT6TvcN52KxOROxXfvr8Lb21kj/u+6mqmEr/cFdlVMQQczxcU4BuW+/M7IO/Sh104des7Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1696166280; bh=qfPIYl9u1Ofy1BNQjRpSAaml4adrrYUU4HmpkXR4ONL=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Gkk7WsSmnLHjhE2+cXGH9Bkz+RtqxnpnDxdb6UrmcKRL8xFbQLkRj2/Gr9WWo3qxsRYZpGE1rRFTbxTavywc133pztW2gMsIMbjYrgJcArelf6Eg+JCWYoqgN2uPu5WGsUY4CvDkD45KAmp6KZ+QFdFTTo/BNYCae2SQk5W1+mEUswldNj6Uh3YoyMqrofYM0/yioiq8AmNOuK4BSMcSizADvm+Pfd8AhAp813uaGtaot9OHywdQctAslR2EI28MpkqTd37R6Ylp5nuz3rAIxGtmHbueaQQ1a8ZesPymMqX7ia8SBC9P41DB/Oy1d5MDpdpbW+MMX7ZkYUYQF1bW7g==
X-YMail-OSG: oJxYjd4VM1nz9t_Lu05za42En9qaDXHOZ9l6rvrIJkWscESAkp2IXSqNOGQdQrw
 bsJpmwYNi6z4JgEFYNRbLa4glcCvqS8DGhwDCsqeaCMLtpW_tQh1.Ar7ryydNwc5_GOINLx9kKGb
 vDc33pXRZ7AR5qLxrxGp4PBtkBrvnCAYpBXHrLk3ALsl6DpC4TnKT2kr6Nr2pcPghrVXX5Fv7UUR
 GpRGI5Fn968B263.Cpc6w0jf2NK51ZiE3vrXrck.m8Sq88uZs_7teKoroGZg5.UhP5IWV1mP5aSP
 2yh_DqNvX37BD.nny47PkFGI4dDrHd_6FmUazgF2urbIXpXTHyQenfXZWQVw9VojD4zmqwgLEm4N
 d1qInNBYMzXtJG38BSZnvYxk7BrtnblDoW3fVWVy5maddCfsN6sEKq5Oa1xVwfpokYHFuS_o5UuG
 _y0pagwhE0.KxuVKz2XJ_Mtab3RFOU8J_aF92QqAVG9UYw.OcitR63SwZvc5qSBEmJpmuLm84vE0
 lXTCKJXQgtc4mjYUW756dxjr.9h4U2ftL08HlFMMZ9j_9xggNZ6tMKWPvozFrj._2bl04vy53VtC
 LOlU.uRutqztK30R7VB966zwsL3Q.NmqvU0tGfe7y2ylB9gIkjXMp1SOmwCbaMVWxLk84Z9NobFW
 lYqlI_LjwPGYIn2wL5ZNNUWT935oC52WXs6MrIjMTXT4BfNqbmUmF6Ky3c5H8G6wwsF0yofrSfmv
 UacHq2gobmgqJlEbNfIUo6YGyolmM_ql9kN5RUsKLGcUIsbeoGijZQhpDs2BzECHR2Fsr7a287jS
 0B4zTqAo42QTW08nFx6X_29NYu4AhvXZVo1THux.w6WVuQnTExsi0pf77k6xWypwh6BksrAupMPd
 yOGZUeyE.EuEJ3JfhDGljinh9ZYAgIMunHGxOXdq6_oMhE8V4scaKgMyWgDkW466IqnP45gmR618
 NfEEWAtaYroep493aJQ9fVfIuTwBhs8byg4Z6qDBFOfIftuT6HHxCqAAC_FfRHxF43ndFqNA0Hhy
 CCeqdOZPp3nqliIOKtr3czyirKkpSoRgWN_ycolH49nNjyDAzs45YoOdlrBKXNISvh2.4OFojBrp
 pI8TouhI7vT9J_imluTz6t0n9pdobn5B_pFYil2TSXbPyks.KkZwxRzdAwqzhKywYFjtwZxFwGLd
 yXnNzNCpCiklCGTZsxaaMgc25yQ6wpxl2SnErlPS2vwtL8ZRoC_1ZI5gma7YAQ1fZ5fDiXv_bjqa
 bIbhWIDE94JGBth7FDiJZy9q4GQrQhIBPpt5VdZnUO1X27yt5m15AtNIUetsjY9TpPMhUeEEfKFH
 o5K88QE6ioY4oEnEXxdJJ375vnNdJZZqYUJR0nEUbV.J8lNRDbgzc.151OmO4vAwDCkHbCZgP3H3
 QY2ML8TG9hxikXppCelp4l5s56I6jwe5EIPUVY1btUvs0aDCzbUosRR.zrJstww3YyGVfdXKe6W0
 TSU2rg_MDwvH6u.lt.F_1l1.oyDOlKnL.49mN7lz92YfhUuEw611XP.egiO_2vxiFp.RGELimpsS
 vwQCYHRHHJ8alstcDj7nFryy52cyY0qbV2eWdIm44JpayWypZP6yms9EsGsFXDoU9hmqnyY3fzFR
 phlCJ_W.wtJvdwkWe4LBCtKZgQ0v5lskSJyEQ.O6jRtvOBFVgfSUobfx0MCSsnZtSGbw413bkCXz
 4g4j8H6x.BC4qMxHipUERJahD0vGraMqjqeT.gjZjafz1z4go9pnrS.M244oENJu3G80ceqiFqP9
 xLplvY1nWUqjQbpQ2G2syPYWlwEbkOgomOmMTGhPxA890RU8_cUyRGhU7ndLKbGJmH9x2HJHxbZH
 NME5uzjDdaKgdKO3ytoUr.wUi97jkyGQXOSeIYVkbfwpyOydfbIID0EIaLqnzgQ5mOr9sRpAR9lt
 E9rOVa_dd1q6Y2YXlOoZ_2eBrU09XL5JYDT0sfSbzH3YZdNczuQP_DsdJn1PGAyusO9Cm8WXV8Os
 RdIKV7h3u2PrU_bnN8Qsz2gVb2GS1rK3bxof9es5FYqt_TWGq1b05JrdQtTIyLOMzsv5bTfubTFI
 2PdS4PZP5MfHTLccioSFT6cHmT4cRqCrqJNpt80.vy6JA5XYRze_BbgLq73i35Xm3wRscci8np_V
 kMaXu7ttjz3p3IgrhzEYjUzoGLhRFkidhNcRx2VSJBkkrBMpM38GIebWSt.2lJbuMnVIFyD3IGjI
 AvnJVEgCQPm4HrcdeR..UGkgsYUsxK4pEoLtJvcTwCKjv9ocu2LQruWnYmXf2KlcGvLF46Cn65O7
 UpqrZlepnZrR31ob3SeGbBH_vnisiTA--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: af00d58e-3114-4afa-9a0e-10712531b56f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Sun, 1 Oct 2023 13:18:00 +0000
Received: by hermes--production-ir2-55db9d9d5-gk4f2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f1c2828dd5bee1de58f8566f5b57afb9;
          Sun, 01 Oct 2023 13:17:58 +0000 (UTC)
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
Subject: [PATCH v2 2/3] power: supply: rt5033_charger: Simplify initialization of rt5033_charger_data
Date:   Sun,  1 Oct 2023 15:17:43 +0200
Message-Id: <0aff8c2a18cf4b88ec3333f6679a8419dd76ca29.1696165240.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1696165240.git.jahau@rocketmail.com>
References: <cover.1696165240.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

