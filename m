Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30497EFC04
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 00:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346313AbjKQXHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 18:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346265AbjKQXHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 18:07:21 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B937C10C6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 15:07:16 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 51352240101
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 00:07:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1700262434; bh=BV0wZGlyYWUcCw3RZEWG83/1pFewbeEJJEKOy7x8BtU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=i4mbIK4aN5HiQTBpQfmA1vZxv7du+pXLfrUCbifc15v0uGfIewrm8ZqzyCFg6v/WU
         dA49nB2P7jK0sJJiL8Fc3a57kh/j7S7E3lW5Cj7yyn6IOrQtcjjhANFU4/vFGzf5dI
         fj/fJ5bz81GzMo+OuVoTmGIF3L02ETMxznqN8N/mJm47zMAhOXe7avQ+LlfvFeZTaS
         K7ptCcAENQIfUmjnvg5gO2isoEPtjS5xC0XCYbmBzhCWeB+b9VbdYw5s6HRIWaIdx9
         WclOMfcOV6xPmed6OGP4XQ0bdnZmW6iNW5UkxAy8VWEsPE8guGgRswfb0hE1e9Yi7B
         AJPHWADhl+n+Q==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4SXCGT2QVcz6tsf;
        Sat, 18 Nov 2023 00:07:13 +0100 (CET)
From:   Charalampos Mitrodimas <charmitro@posteo.net>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Charalampos Mitrodimas <charmitro@posteo.net>
Subject: [PATCH] power: supply: Fix indentation and some other warnings
Date:   Fri, 17 Nov 2023 23:06:58 +0000
Message-Id: <20231117230658.65809-1-charmitro@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These were mentioned by checkpatch:
	Errors:
		(1) code indent should use tabs where possible
		(2) switch and case should be at the same indent
	Warnings:
		(1) quoted string split across lines
		(2) Missing a blank line after declarations

Based on this comment from "include/linux/module.h", modules with
multiple authors should use multiple MODULE_AUTHOR() statements.
	/*
	 * Author(s), use "Name <email>" or just "Name", for multiple
	 * authors use multiple MODULE_AUTHOR() statements/lines.
	 */
	#define MODULE_AUTHOR(_author) MODULE_INFO(author, _author)

Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
---
 drivers/power/supply/power_supply_core.c | 167 ++++++++++++-----------
 1 file changed, 84 insertions(+), 83 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 73265001dd4b..ecef35ac3b7e 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -861,44 +861,44 @@ const size_t power_supply_battery_info_properties_size = ARRAY_SIZE(power_supply
 EXPORT_SYMBOL_GPL(power_supply_battery_info_properties_size);
 
 bool power_supply_battery_info_has_prop(struct power_supply_battery_info *info,
-				        enum power_supply_property psp)
+					enum power_supply_property psp)
 {
 	if (!info)
 		return false;
 
 	switch (psp) {
-		case POWER_SUPPLY_PROP_TECHNOLOGY:
-			return info->technology != POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
-		case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
-			return info->energy_full_design_uwh >= 0;
-		case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
-			return info->charge_full_design_uah >= 0;
-		case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
-			return info->voltage_min_design_uv >= 0;
-		case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
-			return info->voltage_max_design_uv >= 0;
-		case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
-			return info->precharge_current_ua >= 0;
-		case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
-			return info->charge_term_current_ua >= 0;
-		case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
-			return info->constant_charge_current_max_ua >= 0;
-		case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
-			return info->constant_charge_voltage_max_uv >= 0;
-		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN:
-			return info->temp_ambient_alert_min > INT_MIN;
-		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX:
-			return info->temp_ambient_alert_max < INT_MAX;
-		case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
-			return info->temp_alert_min > INT_MIN;
-		case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
-			return info->temp_alert_max < INT_MAX;
-		case POWER_SUPPLY_PROP_TEMP_MIN:
-			return info->temp_min > INT_MIN;
-		case POWER_SUPPLY_PROP_TEMP_MAX:
-			return info->temp_max < INT_MAX;
-		default:
-			return false;
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		return info->technology != POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
+	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
+		return info->energy_full_design_uwh >= 0;
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+		return info->charge_full_design_uah >= 0;
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+		return info->voltage_min_design_uv >= 0;
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+		return info->voltage_max_design_uv >= 0;
+	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
+		return info->precharge_current_ua >= 0;
+	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+		return info->charge_term_current_ua >= 0;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		return info->constant_charge_current_max_ua >= 0;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+		return info->constant_charge_voltage_max_uv >= 0;
+	case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN:
+		return info->temp_ambient_alert_min > INT_MIN;
+	case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX:
+		return info->temp_ambient_alert_max < INT_MAX;
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
+		return info->temp_alert_min > INT_MIN;
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
+		return info->temp_alert_max < INT_MAX;
+	case POWER_SUPPLY_PROP_TEMP_MIN:
+		return info->temp_min > INT_MIN;
+	case POWER_SUPPLY_PROP_TEMP_MAX:
+		return info->temp_max < INT_MAX;
+	default:
+		return false;
 	}
 }
 EXPORT_SYMBOL_GPL(power_supply_battery_info_has_prop);
@@ -914,53 +914,53 @@ int power_supply_battery_info_get_prop(struct power_supply_battery_info *info,
 		return -EINVAL;
 
 	switch (psp) {
-		case POWER_SUPPLY_PROP_TECHNOLOGY:
-			val->intval = info->technology;
-			return 0;
-		case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
-			val->intval = info->energy_full_design_uwh;
-			return 0;
-		case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
-			val->intval = info->charge_full_design_uah;
-			return 0;
-		case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
-			val->intval = info->voltage_min_design_uv;
-			return 0;
-		case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
-			val->intval = info->voltage_max_design_uv;
-			return 0;
-		case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
-			val->intval = info->precharge_current_ua;
-			return 0;
-		case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
-			val->intval = info->charge_term_current_ua;
-			return 0;
-		case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
-			val->intval = info->constant_charge_current_max_ua;
-			return 0;
-		case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
-			val->intval = info->constant_charge_voltage_max_uv;
-			return 0;
-		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN:
-			val->intval = info->temp_ambient_alert_min;
-			return 0;
-		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX:
-			val->intval = info->temp_ambient_alert_max;
-			return 0;
-		case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
-			val->intval = info->temp_alert_min;
-			return 0;
-		case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
-			val->intval = info->temp_alert_max;
-			return 0;
-		case POWER_SUPPLY_PROP_TEMP_MIN:
-			val->intval = info->temp_min;
-			return 0;
-		case POWER_SUPPLY_PROP_TEMP_MAX:
-			val->intval = info->temp_max;
-			return 0;
-		default:
-			return -EINVAL;
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		val->intval = info->technology;
+		return 0;
+	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
+		val->intval = info->energy_full_design_uwh;
+		return 0;
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+		val->intval = info->charge_full_design_uah;
+		return 0;
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+		val->intval = info->voltage_min_design_uv;
+		return 0;
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+		val->intval = info->voltage_max_design_uv;
+		return 0;
+	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
+		val->intval = info->precharge_current_ua;
+		return 0;
+	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+		val->intval = info->charge_term_current_ua;
+		return 0;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		val->intval = info->constant_charge_current_max_ua;
+		return 0;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+		val->intval = info->constant_charge_voltage_max_uv;
+		return 0;
+	case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN:
+		val->intval = info->temp_ambient_alert_min;
+		return 0;
+	case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX:
+		val->intval = info->temp_ambient_alert_max;
+		return 0;
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
+		val->intval = info->temp_alert_min;
+		return 0;
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
+		val->intval = info->temp_alert_max;
+		return 0;
+	case POWER_SUPPLY_PROP_TEMP_MIN:
+		val->intval = info->temp_min;
+		return 0;
+	case POWER_SUPPLY_PROP_TEMP_MAX:
+		val->intval = info->temp_max;
+		return 0;
+	default:
+		return -EINVAL;
 	}
 }
 EXPORT_SYMBOL_GPL(power_supply_battery_info_get_prop);
@@ -1255,6 +1255,7 @@ EXPORT_SYMBOL_GPL(power_supply_powers);
 static void power_supply_dev_release(struct device *dev)
 {
 	struct power_supply *psy = to_power_supply(dev);
+
 	dev_dbg(dev, "%s\n", __func__);
 	kfree(psy);
 }
@@ -1636,6 +1637,6 @@ subsys_initcall(power_supply_class_init);
 module_exit(power_supply_class_exit);
 
 MODULE_DESCRIPTION("Universal power supply monitor class");
-MODULE_AUTHOR("Ian Molton <spyro@f2s.com>, "
-	      "Szabolcs Gyurko, "
-	      "Anton Vorontsov <cbou@mail.ru>");
+MODULE_AUTHOR("Ian Molton <spyro@f2s.com>");
+MODULE_AUTHOR("Szabolcs Gyurko");
+MODULE_AUTHOR("Anton Vorontsov <cbou@mail.ru>");
-- 
2.39.2

