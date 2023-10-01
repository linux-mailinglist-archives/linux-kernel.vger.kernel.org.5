Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D7A7B4791
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 15:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbjJANSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 09:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbjJANSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:18:04 -0400
Received: from sonic309-24.consmr.mail.ir2.yahoo.com (sonic309-24.consmr.mail.ir2.yahoo.com [77.238.179.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBF6BA
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 06:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1696166278; bh=hXqZ/BJqAdqfWupb9eY6ATDe04QF4KS61GYr5ErKHuA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=gVYl8sIGWg29EQd6N9ChVBNgVe9Hv9OQFajYbZW3vPKAFfFO/GwLxwIP1a8RGEx59hw5X9/NvPXqPV90la7sokZywMCAQrRYZs+moO1k53en8njPBzMy/DQdVOPeXdyxQWM1xtLzn7bpfWyTyYpQRYcUsRfhlDvAP+VRoMxAyB7VuKywT2W11KkbsbGFBsRBTouhaUdA/x3eFq/DY77tUkT8JDzdWkeDieGcQXI4Nc40I5lkc/EwQP7jjKLrs68fDWWjNJUy/M+GEmApsMc3g9hKzyOPDR7iy8JkpQdAFktwUbV8VRyD0WSERb9M2iCB81QKAswnWYtRWDNZ7vo1dQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1696166278; bh=Gr0OSsZYAqeAsb7I6Npw6eYkTMvr9nJtPD8hJMkSL7D=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Ebkd1Ch5FMSjc0Ka2Pl04/o+XW4v13V9IMxVcWs7jE98pPa/HCPXST3/hKhNtcguzdl158IybRoHSMh4Ere0lnSoCSQme5rTUoN8hEQ1kmLJnnyOSCZzuAz12iWn0tsdObiIW5vzEVgmSFfDON9smDHkfESs71NzMuBvjt34YU8GUKQPtVnYBWq4j21lO31rawL5FMCrqN6ZEMc8VqIzX2TNubmhJOVCa+FUZTOoHGktlYtAi79jX1CYsvUvVD1exJjS3k3fRHJJF/hSM5Q90vxaONUhmQTCEuBUMt1tKqG6n3k8QRIA+N/W1WIaBFtVmoM2yxChgvNAxEM0U8sGRQ==
X-YMail-OSG: r.w_7WEVM1ltXMe915MzJ6cXfoz_a33fzUSyGP.pE8M8UbJJG_306Gu8s7ZkmFR
 lt8_HT6VUlXaromHhqw5o1XCSxDOYa89.d1C6EeczPD.A2ZthsPvGqLZf2nV_BtZ9mCw.MAMUSWz
 GoKkqRcdnTx63CMKguMfdUBFcul4KkNFwEjyWNbr._TP_Ezyc_6Ho0QZiunZWphkYYydY_vEUqSF
 EO40zKnJu2UmxkR.92EmVDVejLZVItKYg10fiH_8noPuuD06TA2dOFqoltOaspQAIKWbzzFGLi_Y
 bXw4Gdz_4aWRzaP5IIGKegn_yPpWDAwiLliI1FJb012vMBFJEVviDuNKKuvhn.q0EUA.aaPQ9ka1
 Azf_VSjpBQZOYrI2pLGjJWu2QfIX0d6BsN4hV2CBkXZwkXKIn4C3IvU9gaOy6BFo1BzKBUbtWj_8
 NdBdPoj7I_FT1NNEmXFzXAQO.Y32buAxPu51KA5iIq0UKpzDybfA1lJHj55_ibJUIcXQ.SkVPITP
 Tfc6cDq.iQaeEMjsZZ7BKTUqL8EmtPWI_ZbSSvLKiQlGNE56uaJSjiEHW2mUOiipqrLduxAH9WDY
 3v6SxPBImOCmV5aqVtqN9w3wDqLw.xpI45lMV5ErbyD2I.lxgZhHGI6lRLTPpw_x1m.gSwz_t.tG
 p0VSstF4Y2Xo4Qom6tm7KCs0FBgcLf_E4B28vfXOLqlOIkqSg81Xr0IBcunnHkQSETXrkQ5dKuBw
 UpMPCrnVwziEUZl82S0_U3wJcAQ49_LKE88XqrikCm9Tp0KssFmVBOc9Srf6SjZ.E0B0F7I6073q
 kRQ9FvHe_scYl9xA81NVjQHXGFzcV7.rfD__raAeKAymbS3bNrLKFGw.BuuTcUAqMvI1keHqPgNL
 2SQatJrCco389ZuGYKQD4Kr2JCafLSIAjsXWwl94H9vGlfUA6MqhRFHe8VUXt_HfAm_y.pe6e2Yo
 fFbdHk1Pu4zaNNNpQf38HTR84UmSTJmDTn.sZMjfyN03Q5Mta0AqjW5H5WChqqJLaQDs9.KvCW3A
 QtWIJMtL1crO_lJxnW4WJtXlJJ36kHIzEIK1fPrneK.B3UQFMmecs_0ARMzxzMX9.Fngw998fqr5
 t6S49wAxt0R9EKummPlKIRz5JJKNmra7Xm1VFB9RJPco5O.2nK.R53aZ4okbcD3lD1rxf7bDWtBi
 Unx_2wdD9I7Mp5.9_nCKUwuHXEbi9rddf1HsSavmhO5A6WWWnkSOsfIi.WeE9Rr3Rvpcmiibf5VD
 9MtkB_6s8PPD0yMaV0UWZkUa69Ya0o22Ozdu2HqbKEgibXcrw4uCMl7d2et9DcMkom8nM1dVof0V
 iAP8xlnM4.t1Fom1W6LvKW_LcY88Tnnw9.cfiBxtaLxGlweC4cS935yn9_gxdLSyA2bzu5d4DjMW
 s1lltgS7BUXrwXVMpB4yPLZjYyEQQFplr5EsDMdoHORxFcb1ydGWcN1mIMxQToOIQ8FlBbqWU_cg
 WDTqiDZrNCzqbtVytdDuL08NDy0mml2_eyl_qzigtGpSELW.b4YisTMKjDuXPF7byKny4eFr2iRs
 jY_BceSypK.PnG4TTST_7187q6l_omQBaYJ3M69J.qvBhmggAYChVX8lG5SFyiEO_fB5GFT8K2wU
 FFqzSghRh81kU7SGcmC.uYR8CDRFMVv7IRzxpl8rQ.0NQtYrRjIW8OTILmMIt590IKigduNBZTrQ
 XhuAe3KmcGZTVb3GhpjIiZ7YlV2Rei2FYRiezFi7V.4oyJkpW0j8WPKcAmJPcPwravKzbxytoei0
 OUBLphKKirpEBIO0OEISt4fEfLuT3kb2yxdkG1nJ19wte5_mFq6nIPK8JGpgBZOOQ4AMpeJmhji5
 JOHfm1_RdnqiDx0wiOvF69fTE0SDJWzVh5izU4WI1EzNza3mCoxasQb8b1AcHBcHljrASFi.Vcf2
 Nmm16oOryzMZVz45CsR27wNxdla1DWEPInk8nxy3gRQ2YbsDcSDPz7xQQf97YB0YdIvHE3CG30uD
 JCh3Im9Itg8xIN2IZ31M7P7xsrg3HziLVjpyvVU.l4G_G2yb.DSddH6Le1v0_WmYFwgKmZIoDokp
 PqprLGfcjSVijmkPQLryNrwZywtqccXQopIQGsAVJgKmsyxqCuw97Zkw21RIfcHFtowubbcS0OZe
 Nl5q59qVpd5ZW6OwsSJGo0QiKrjpnlt36neDqlLIjOzQCBB8.nwd4CiVCVdqNevEk4iQqbon.Fmk
 6C.60K_rxLMfbFOChXp9bSDPM.fvc_4rrudTS10oaSxt3ZlwOMtFBmUqsJpPoLsrSfrr3PhXSiW0
 hqMyNGOTbinujqvL.AE8.jfxBO.J4LV0-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 44667c56-2af3-4666-9e9b-ed3bfc1b95ed
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ir2.yahoo.com with HTTP; Sun, 1 Oct 2023 13:17:58 +0000
Received: by hermes--production-ir2-55db9d9d5-gk4f2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f1c2828dd5bee1de58f8566f5b57afb9;
          Sun, 01 Oct 2023 13:17:57 +0000 (UTC)
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
Subject: [PATCH v2 1/3] power: supply: rt5033_charger: Add cable detection and USB OTG supply
Date:   Sun,  1 Oct 2023 15:17:42 +0200
Message-Id: <cc4e37e510abbb0cdfa7faa8408da48c2cb448a4.1696165240.git.jahau@rocketmail.com>
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

Yang Yingliang detected missing mutex_unlock() in some error path and
suggested a fix [3]. The suggestion was squashed into this patch.

[1] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/battery/rt5033_charger.c#L499
[2] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/battery/rt5033_charger.c#L686-L687
[3] https://lore.kernel.org/linux-pm/20230822030207.644738-1-yangyingliang@huawei.com

Tested-by: Raymond Hackley <raymondhackley@protonmail.com>
Co-developed-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 drivers/power/supply/rt5033_charger.c | 287 +++++++++++++++++++++++++-
 1 file changed, 285 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/rt5033_charger.c b/drivers/power/supply/rt5033_charger.c
index c0c516f22c66..091ca4a21f29 100644
--- a/drivers/power/supply/rt5033_charger.c
+++ b/drivers/power/supply/rt5033_charger.c
@@ -6,8 +6,12 @@
  * Author: Beomho Seo <beomho.seo@samsung.com>
  */
 
+#include <linux/devm-helpers.h>
+#include <linux/extcon.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/regmap.h>
@@ -26,6 +30,14 @@ struct rt5033_charger {
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
@@ -56,6 +68,10 @@ static int rt5033_get_charger_state(struct rt5033_charger *charger)
 		state = POWER_SUPPLY_STATUS_UNKNOWN;
 	}
 
+	/* For OTG mode, RT5033 would still report "charging" */
+	if (charger->otg)
+		state = POWER_SUPPLY_STATUS_DISCHARGING;
+
 	return state;
 }
 
@@ -147,6 +163,9 @@ static inline int rt5033_init_const_charge(struct rt5033_charger *charger)
 		return -EINVAL;
 	}
 
+	/* Store that value for later usage */
+	charger->cv_regval = reg_data;
+
 	/* Set end of charge current */
 	if (chg->eoc_uamp < RT5033_CHARGER_EOC_MIN ||
 	    chg->eoc_uamp > RT5033_CHARGER_EOC_MAX) {
@@ -330,6 +349,162 @@ static int rt5033_charger_reg_init(struct rt5033_charger *charger)
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
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	/* Set operation mode to OTG */
+	ret = regmap_update_bits(charger->regmap, RT5033_REG_CHG_CTRL1,
+			RT5033_CHGCTRL1_MODE_MASK, RT5033_BOOST_MODE);
+	if (ret) {
+		dev_err(charger->dev, "Failed to update OTG mode.\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	/* In case someone switched from charging to OTG directly */
+	if (charger->online)
+		charger->online = false;
+
+	charger->otg = true;
+
+out_unlock:
+	mutex_unlock(&charger->lock);
+
+	return ret;
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
+		if (ret) {
+			mutex_unlock(&charger->lock);
+			return -EINVAL;
+		}
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
+		mutex_unlock(&charger->lock);
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
+	int ret = 0;
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
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+
+		charger->mivr_enabled = false;
+	}
+
+	if (charger->otg) {
+		ret = rt5033_charger_unset_otg(charger);
+		if (ret) {
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+	}
+
+	if (charger->online)
+		charger->online = false;
+
+out_unlock:
+	mutex_unlock(&charger->lock);
+
+	return ret;
+}
+
 static enum power_supply_property rt5033_charger_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_CHARGE_TYPE,
@@ -366,8 +541,7 @@ static int rt5033_charger_get_property(struct power_supply *psy,
 		val->strval = RT5033_MANUFACTURER;
 		break;
 	case POWER_SUPPLY_PROP_ONLINE:
-		val->intval = (rt5033_get_charger_state(charger) ==
-				POWER_SUPPLY_STATUS_CHARGING);
+		val->intval = charger->online;
 		break;
 	default:
 		return -EINVAL;
@@ -402,6 +576,86 @@ static struct rt5033_charger_data *rt5033_charger_dt_init(
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
@@ -414,6 +668,7 @@ static int rt5033_charger_probe(struct platform_device *pdev)
 {
 	struct rt5033_charger *charger;
 	struct power_supply_config psy_cfg = {};
+	struct device_node *np_conn, *np_edev;
 	int ret;
 
 	charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
@@ -423,6 +678,7 @@ static int rt5033_charger_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, charger);
 	charger->dev = &pdev->dev;
 	charger->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	mutex_init(&charger->lock);
 
 	psy_cfg.of_node = pdev->dev.of_node;
 	psy_cfg.drv_data = charger;
@@ -442,6 +698,33 @@ static int rt5033_charger_probe(struct platform_device *pdev)
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

