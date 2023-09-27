Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5984F7B0D5C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 22:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjI0U0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 16:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjI0U0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 16:26:25 -0400
Received: from sonic309-25.consmr.mail.ir2.yahoo.com (sonic309-25.consmr.mail.ir2.yahoo.com [77.238.179.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD97F193
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 13:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1695846381; bh=9liyMz7dI1f+ZL0FPhVqZI8KcCxBwUJ44/9Y4J+NCAs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=WVg6RslXc2qnSULPWmT+6JOcThZxRvZ+t+4j5fOS0/zIh/TBtadYWynO59F4H2pRewwFkidgl90TNnFNzV3gcB4P25Ltl4f7Qq8fqBjsEjfuh/27HWxXKYm69mOVs/fP6+GkGnK4MfF/eq+z7weCPaf4c/0bKsoMOR/XyL28uS95mpeTyeKtAKU5+OI6QxP/sMOrHFAR98MoBP22wrwEYI3hdNyDsuxXgxSYfEINn/GRAimYKJj4118kNpZ7g/D/7tWpYLjCnxvOPuqEwu8caChvi9UJ6QPR8FD5M1YbnsFKtmDtwijqZb6gv18MxbzUf6JGll0X/TgYWL24gEKIzw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1695846381; bh=fg7zFwGRmLa8czAJVDF4rudTssn6wSYGSaIg21XlQKK=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=kBAdqHBu0RNE4YupUErDaFB2UFI5sO8GNH63iDJMvMMXqZbGK95qiwLYDZ5/Mni4dJMorhfP3wyAy1t4Lku5QH6HEYwnwal44jAdMK2TomsT0cdg7e++vD5QINpYeBOKUDHQzIJZ7LA3ZR2IPYNZpNACrz7CL+jwchamrKPGDKQRKIt1LLCzltMfD+d/5DQvuey+wliL8tkDuwVp2kVDiDDPTj0rw58rw6KPkUPRAaOn5YAPbJ+NRYBw4dRXza/rgJQmmnMJaye1fkk/rEbRmBO+NXEbEgDhRfHFCR/AkQuGiaV/Rv/+JgVyQftk2eqm6znS0IcIbqb0CxHQNm3NMA==
X-YMail-OSG: UnrsOS0VM1nFQQ5w7LbiOI5L1tY0WRw.YpLT5lkYdAMjFpyUCy_wp9QwmHncOND
 _PrTfHq94_RkB0SHB7oCUFJhiZ6jCK2aXdc7gfwByVsXSvUBGXUUs.63pqkTs9R2jSTfh5HMvL3H
 4Jqi0VJbY2Mfn2eOh5cuWSz0JUFOu3kl1M9NHpMDk76_SZeJuuVZucFUZPhd3cjtG01WWRHJ7AEJ
 Tlmgsr0Z7oXor881B.ZNq5mFw5jEXstIdtVFmu7rKhlgB9zbcs7oKUkeGR.wZrMmbRMIsdfsfKhg
 TREJ9huCgm56cUe2YG_EMqcr7KrGXdS1YN_AQVIoGGlrza9VWthGxEL55_4r7N.ZN8jG0KFmP1Bn
 AllKB5IIUYqjvKK_5VnREWv3fWdMbUtAQudoXH6Em5cAHGTKZsEe4RLfOZyc9eY3oHdmUYsT8BkZ
 6Nm_Bo6DhlDflWRLcW_041ytizWwLrfBKeiHnLsf5Txn4g_pILZi8zNdyTXOQFvdcnNu7IyRnsDR
 C75KJ6KFFIfIenzArGFqpWUbT82tAPO.6O18PbL4Adh1BvmjfJefjR0CsmU1XQNsRCjZRYJg8pQq
 G_4bDPSRUKM5.urI13wNU7iCmpgGuynmKliNAnvoCwQDO1vXaPpMGOpYVA0byML6IApsf45b7ofk
 .qA1QGygSs8QJ_ZejtgFkKxWAzDeb5BjQ0VXuli9ER_baR0GznJ1dtg7zgxmk2ZCUkaPacMccK5Z
 w2Y3qUcN7mSVpqecW0h7GBhXu3UIm..PXslN4KD3YBj_1jkDaeQpwph6DikdXQSgQ3.dI7DPTihf
 OjIlHK6PCCUyNqpxoc_qXzMsjD8YYF1BMWcv5axn81LFMRoUoHhrohFGWLhZc5BI_45MPaQ5gptn
 3xpAV88CinYLDP2GXi6zFyPzEP8Gr90kbq11aGiqgH3h7x2F0UZZiDclzzgLM4b24Icf7zQucjTw
 8RdArWVxVZzvYlhaiEKY_V3YvWN.0BDI5nG8LWu6jhP8H16.HJiuqt2KK362OpFH54xv70B8Iv2j
 xCXmP3mPNYDjqAGbGplHzPEGqccAAnEyl8D.nyjGGTl3usT.Ze5JeO_4VVs4KHpKtDyeMkNeTfg.
 MZg_OK0_4CDppnWHEgnGgWqeu7U9YrDkOLctDiqlTCRQeyzdJ18LTzjCSwgtVx70HHtyKxPBH49_
 9o6DgzN_XrsyALsyzHN.PeCSV_adsevnbyIL7rmFFRdvZO0wffJHEbordIhd3vTUbYlWvFY62R8c
 gQl7kE2kQT22jSPAHanNY0ViyHCQkOdT3UfQP3DIEH5Br9j.DJdnmwIvi5C1V5wOCmRPRVhpyxqP
 s1tPBHuu5GaqChNhw2bAkd3d1YoEwjO0YR_szBtER8aP_0Twymy5Bf4c5Rs6ahR0QSRYYOp.1tOZ
 Jjuq5VNfhbAUBuhNFIxQQcvgCKIn1ggbdwTU1B9I_eK_9_B9XlRdrz787JnJlqt6GeE_7PmOaXpY
 keNyXxJe4f7At6Q16YvvkhG.nhFH7ZFkur8.KbsGJCsn1YeBdwiKcq5RwWGIjScQ8HVLsfi5MhfF
 5Dic2ali.3A2sft3Hp2zIhtYB.0QZRR.fuWe1B2DQM9z130i0VULAJYasoOcTTQcTByHRUTGSsMz
 WcRouMHb_rc9.r4ex_Jm9a1OZNAo1pq0dmk1c6dLMbaaVKN5eiicj1_obnuP5rBKX.daT_lfA_nM
 T5CBCBDVJKOINeu1MaaXgp9nPTXnZw4I2EapJ5b7H7cnhsc9wPfxfOq5PXpOUVLqMg0ptDUav9ak
 pcYhIF_wn9bjqljp6x8ZqePe4GjYsXuQLucUoCUYlY4NX6UiJXFyFTiMdn3lDjQtd4X6abfz0gCV
 2aq0GFRYy637AzglLOCAYVPKQ5ZJTwlGPneQFVzoiG2KeBbuvPptIyV.TE3aKoDGpOaKymQV2rBr
 AJ01fkele2rFYt3Rz3Odtw_G3d2UmvghCdJxyzlIF.fmLCLL0sWKEJ.NEFvG0SV6ZEyHufXP4Lgg
 gBAm6OGGClmzzUugy9LXNRPqZlDqCOIiUQxgWEc4jqfMe4JrkmQM4bB_4qEVWxXkOYD8pGLe6.ZH
 WALE9uMIcwe2kUOD_g4A8_cmg0Dinxgcw1_NfF0yTZxVZaxlQzRyf2BEMPmD813lVnG5kS5.7WLc
 7DFxqEdAF5Uymts6qn6DbccsAuQoPLBV52YnpoDTrPIrET3nA62i2Y1MUD2Zihprs11YQZt4ElgB
 _xvCarOIYq1AMY9Lfdg3.XuP0rB1cpzh2m7am1V17nxemnPdRPhWttsqSVRLccuYiwXl_445rX56
 2YPsd44KwP6RRK2wMtkfK6LA1SNLdiSOq
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 29f307a1-56a3-490b-baca-1e117cd0e593
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ir2.yahoo.com with HTTP; Wed, 27 Sep 2023 20:26:21 +0000
Received: by hermes--production-ir2-55db9d9d5-5hvhf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1d998f486e26fd309cd8d11c694d3a2b;
          Wed, 27 Sep 2023 20:26:16 +0000 (UTC)
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
        Jakob Hauser <jahau@rocketmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 2/5] power: supply: rt5033_charger: Add cable detection and USB OTG supply
Date:   Wed, 27 Sep 2023 22:25:59 +0200
Message-Id: <efe3e6132216ff87a1643c0fdbf471a672a3f4f3.1695844349.git.jahau@rocketmail.com>
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

Implement cable detection by extcon and handle the driver according to the
connector type.

There are basically three types of action: "set_charging", "set_otg" and
"set_disconnect".

A forth helper function to "unset_otg" was added because this is used in both
"set_charging" and "set_disconnect". In the first case it covers the rather
rare event that someone changes from OTG to charging without disconnect. In
the second case, when disconnecting, the values are set back to the ones from
initialization to return into a defined state.

Additionally, there is "set_mivr". When connecting to e.g. a laptop/PC, the
minimum input voltage regulation (MIVR) shall prevent a voltage drop if the
cable or the supply is weak. The MIVR value is set to 4600MV, same as in the
Android driver [1]. When disconnecting, MIVR is set back to DISABLED.

In the function rt5033_get_charger_state(): When in OTG mode, the chip
reports status "charging". Change this to "discharging" because there is
no charging going on in OTG mode [2].

[1] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/battery/rt5033_charger.c#L499
[2] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/battery/rt5033_charger.c#L686-L687

Tested-by: Raymond Hackley <raymondhackley@protonmail.com>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/rt5033_charger.c | 276 +++++++++++++++++++++++++-
 1 file changed, 274 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/rt5033_charger.c b/drivers/power/supply/rt5033_charger.c
index 57a0dc631e85..2c2073b8979d 100644
--- a/drivers/power/supply/rt5033_charger.c
+++ b/drivers/power/supply/rt5033_charger.c
@@ -6,8 +6,11 @@
  * Author: Beomho Seo <beomho.seo@samsung.com>
  */
 
+#include <linux/devm-helpers.h>
+#include <linux/extcon.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
@@ -27,6 +30,14 @@ struct rt5033_charger {
 	struct regmap			*regmap;
 	struct power_supply		*psy;
 	struct rt5033_charger_data	*chg;
+	struct extcon_dev		*edev;
+	struct notifier_block		extcon_nb;
+	struct work_struct		extcon_work;
+	struct mutex			lock;
+	bool online;
+	bool otg;
+	bool mivr_enabled;
+	u8 cv_regval;
 };
 
 static int rt5033_get_charger_state(struct rt5033_charger *charger)
@@ -57,6 +68,10 @@ static int rt5033_get_charger_state(struct rt5033_charger *charger)
 		state = POWER_SUPPLY_STATUS_UNKNOWN;
 	}
 
+	/* For OTG mode, RT5033 would still report "charging" */
+	if (charger->otg)
+		state = POWER_SUPPLY_STATUS_DISCHARGING;
+
 	return state;
 }
 
@@ -148,6 +163,9 @@ static inline int rt5033_init_const_charge(struct rt5033_charger *charger)
 		return -EINVAL;
 	}
 
+	/* Store that value for later usage */
+	charger->cv_regval = reg_data;
+
 	/* Set end of charge current */
 	if (chg->eoc_uamp < RT5033_CHARGER_EOC_MIN ||
 	    chg->eoc_uamp > RT5033_CHARGER_EOC_MAX) {
@@ -331,6 +349,152 @@ static int rt5033_charger_reg_init(struct rt5033_charger *charger)
 	return 0;
 }
 
+static int rt5033_charger_set_otg(struct rt5033_charger *charger)
+{
+	int ret;
+
+	mutex_lock(&charger->lock);
+
+	/* Set OTG boost v_out to 5 volts */
+	ret = regmap_update_bits(charger->regmap, RT5033_REG_CHG_CTRL2,
+			RT5033_CHGCTRL2_CV_MASK,
+			0x37 << RT5033_CHGCTRL2_CV_SHIFT);
+	if (ret) {
+		dev_err(charger->dev, "Failed set OTG boost v_out\n");
+		return -EINVAL;
+	}
+
+	/* Set operation mode to OTG */
+	ret = regmap_update_bits(charger->regmap, RT5033_REG_CHG_CTRL1,
+			RT5033_CHGCTRL1_MODE_MASK, RT5033_BOOST_MODE);
+	if (ret) {
+		dev_err(charger->dev, "Failed to update OTG mode.\n");
+		return -EINVAL;
+	}
+
+	/* In case someone switched from charging to OTG directly */
+	if (charger->online)
+		charger->online = false;
+
+	charger->otg = true;
+
+	mutex_unlock(&charger->lock);
+
+	return 0;
+}
+
+static int rt5033_charger_unset_otg(struct rt5033_charger *charger)
+{
+	int ret;
+	u8 data;
+
+	/* Restore constant voltage for charging */
+	data = charger->cv_regval;
+	ret = regmap_update_bits(charger->regmap, RT5033_REG_CHG_CTRL2,
+			RT5033_CHGCTRL2_CV_MASK,
+			data << RT5033_CHGCTRL2_CV_SHIFT);
+	if (ret) {
+		dev_err(charger->dev, "Failed to restore constant voltage\n");
+		return -EINVAL;
+	}
+
+	/* Set operation mode to charging */
+	ret = regmap_update_bits(charger->regmap, RT5033_REG_CHG_CTRL1,
+			RT5033_CHGCTRL1_MODE_MASK, RT5033_CHARGER_MODE);
+	if (ret) {
+		dev_err(charger->dev, "Failed to update charger mode.\n");
+		return -EINVAL;
+	}
+
+	charger->otg = false;
+
+	return 0;
+}
+
+static int rt5033_charger_set_charging(struct rt5033_charger *charger)
+{
+	int ret;
+
+	mutex_lock(&charger->lock);
+
+	/* In case someone switched from OTG to charging directly */
+	if (charger->otg) {
+		ret = rt5033_charger_unset_otg(charger);
+		if (ret)
+			return -EINVAL;
+	}
+
+	charger->online = true;
+
+	mutex_unlock(&charger->lock);
+
+	return 0;
+}
+
+static int rt5033_charger_set_mivr(struct rt5033_charger *charger)
+{
+	int ret;
+
+	mutex_lock(&charger->lock);
+
+	/*
+	 * When connected via USB connector type SDP (Standard Downstream Port),
+	 * the minimum input voltage regulation (MIVR) should be enabled. It
+	 * prevents an input voltage drop due to insufficient current provided
+	 * by the adapter or USB input. As a downside, it may reduces the
+	 * charging current and thus slows the charging.
+	 */
+	ret = regmap_update_bits(charger->regmap, RT5033_REG_CHG_CTRL4,
+			RT5033_CHGCTRL4_MIVR_MASK, RT5033_CHARGER_MIVR_4600MV);
+	if (ret) {
+		dev_err(charger->dev, "Failed to set MIVR level.\n");
+		return -EINVAL;
+	}
+
+	charger->mivr_enabled = true;
+
+	mutex_unlock(&charger->lock);
+
+	/* Beyond this, do the same steps like setting charging */
+	rt5033_charger_set_charging(charger);
+
+	return 0;
+}
+
+static int rt5033_charger_set_disconnect(struct rt5033_charger *charger)
+{
+	int ret;
+
+	mutex_lock(&charger->lock);
+
+	/* Disable MIVR if enabled */
+	if (charger->mivr_enabled) {
+		ret = regmap_update_bits(charger->regmap,
+				RT5033_REG_CHG_CTRL4,
+				RT5033_CHGCTRL4_MIVR_MASK,
+				RT5033_CHARGER_MIVR_DISABLE);
+		if (ret) {
+			dev_err(charger->dev, "Failed to disable MIVR.\n");
+			return -EINVAL;
+		}
+
+		charger->mivr_enabled = false;
+	}
+
+	if (charger->otg) {
+		ret = rt5033_charger_unset_otg(charger);
+		if (ret)
+			return -EINVAL;
+	}
+
+	if (charger->online)
+		charger->online = false;
+
+	mutex_unlock(&charger->lock);
+
+	return 0;
+}
+
 static enum power_supply_property rt5033_charger_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_CHARGE_TYPE,
@@ -367,8 +531,7 @@ static int rt5033_charger_get_property(struct power_supply *psy,
 		val->strval = RT5033_MANUFACTURER;
 		break;
 	case POWER_SUPPLY_PROP_ONLINE:
-		val->intval = (rt5033_get_charger_state(charger) ==
-				POWER_SUPPLY_STATUS_CHARGING);
+		val->intval = charger->online;
 		break;
 	default:
 		return -EINVAL;
@@ -403,6 +566,86 @@ static struct rt5033_charger_data *rt5033_charger_dt_init(
 	return chg;
 }
 
+static void rt5033_charger_extcon_work(struct work_struct *work)
+{
+	struct rt5033_charger *charger =
+		container_of(work, struct rt5033_charger, extcon_work);
+	struct extcon_dev *edev = charger->edev;
+	int connector, state;
+	int ret;
+
+	for (connector = EXTCON_USB_HOST; connector <= EXTCON_CHG_USB_PD;
+	     connector++) {
+		state = extcon_get_state(edev, connector);
+		if (state == 1)
+			break;
+	}
+
+	/*
+	 * Adding a delay between extcon notification and extcon action. This
+	 * makes extcon action execution more reliable. Without the delay the
+	 * execution sometimes fails, possibly because the chip is busy or not
+	 * ready.
+	 */
+	msleep(100);
+
+	switch (connector) {
+	case EXTCON_CHG_USB_SDP:
+		ret = rt5033_charger_set_mivr(charger);
+		if (ret) {
+			dev_err(charger->dev, "failed to set USB mode\n");
+			break;
+		}
+		dev_info(charger->dev, "USB mode. connector type: %d\n",
+			 connector);
+		break;
+	case EXTCON_CHG_USB_DCP:
+	case EXTCON_CHG_USB_CDP:
+	case EXTCON_CHG_USB_ACA:
+	case EXTCON_CHG_USB_FAST:
+	case EXTCON_CHG_USB_SLOW:
+	case EXTCON_CHG_WPT:
+	case EXTCON_CHG_USB_PD:
+		ret = rt5033_charger_set_charging(charger);
+		if (ret) {
+			dev_err(charger->dev, "failed to set charging\n");
+			break;
+		}
+		dev_info(charger->dev, "charging. connector type: %d\n",
+			 connector);
+		break;
+	case EXTCON_USB_HOST:
+		ret = rt5033_charger_set_otg(charger);
+		if (ret) {
+			dev_err(charger->dev, "failed to set OTG\n");
+			break;
+		}
+		dev_info(charger->dev, "OTG enabled\n");
+		break;
+	default:
+		ret = rt5033_charger_set_disconnect(charger);
+		if (ret) {
+			dev_err(charger->dev, "failed to set disconnect\n");
+			break;
+		}
+		dev_info(charger->dev, "disconnected\n");
+		break;
+	}
+
+	power_supply_changed(charger->psy);
+}
+
+static int rt5033_charger_extcon_notifier(struct notifier_block *nb,
+					  unsigned long event, void *param)
+{
+	struct rt5033_charger *charger =
+		container_of(nb, struct rt5033_charger, extcon_nb);
+
+	schedule_work(&charger->extcon_work);
+
+	return NOTIFY_OK;
+}
+
 static const struct power_supply_desc rt5033_charger_desc = {
 	.name = "rt5033-charger",
 	.type = POWER_SUPPLY_TYPE_USB,
@@ -415,6 +658,7 @@ static int rt5033_charger_probe(struct platform_device *pdev)
 {
 	struct rt5033_charger *charger;
 	struct power_supply_config psy_cfg = {};
+	struct device_node *np_conn, *np_edev;
 	int ret;
 
 	charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
@@ -424,6 +668,7 @@ static int rt5033_charger_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, charger);
 	charger->dev = &pdev->dev;
 	charger->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	mutex_init(&charger->lock);
 
 	psy_cfg.of_node = pdev->dev.of_node;
 	psy_cfg.drv_data = charger;
@@ -443,6 +688,33 @@ static int rt5033_charger_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/*
+	 * Extcon support is not vital for the charger to work. If no extcon
+	 * is available, just emit a warning and leave the probe function.
+	 */
+	np_conn = of_parse_phandle(pdev->dev.of_node, "richtek,usb-connector", 0);
+	np_edev = of_get_parent(np_conn);
+	charger->edev = extcon_find_edev_by_node(np_edev);
+	if (IS_ERR(charger->edev)) {
+		dev_warn(&pdev->dev, "no extcon device found in device-tree\n");
+		goto out;
+	}
+
+	ret = devm_work_autocancel(&pdev->dev, &charger->extcon_work,
+				   rt5033_charger_extcon_work);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to initialize extcon work\n");
+		return ret;
+	}
+
+	charger->extcon_nb.notifier_call = rt5033_charger_extcon_notifier;
+	ret = devm_extcon_register_notifier_all(&pdev->dev, charger->edev,
+						&charger->extcon_nb);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register extcon notifier\n");
+		return ret;
+	}
+out:
 	return 0;
 }
 
-- 
2.39.2

