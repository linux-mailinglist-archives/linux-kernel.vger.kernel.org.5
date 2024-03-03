Return-Path: <linux-kernel+bounces-89802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB7E86F5E5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1371C217E3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B9A67E8B;
	Sun,  3 Mar 2024 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Af/JS/9K"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D7467A19;
	Sun,  3 Mar 2024 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709479893; cv=none; b=RN8HViUZkMR+iv+CLbuTR1NpeyBohM1NjEkpD8Nn4gWnNcpRfdxtA1jHALCS/yc9ULvlqbXUuqViLyE4eMt4drZHmzTFdK34t1rCEXuUI0bg8U8whSJB0Ftmr0xA6BM2Z1eZL84tHOL0rG3cYzJeLM42KtXrLtWjQY8uZKrtHUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709479893; c=relaxed/simple;
	bh=fE1ygv1xYb2HYZUOI0x3ptRJowm9HrcXCdzDrxnyxeM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IhTS+eIKAwr8F1sFPFz1WWEB5dRsY35g6hWOLB6+QZ1XSp8BOKsTy2zC5vVtRCX/mVkAMkyOIFey5gl2enJoVisOxzNHyYJyHyxpRYHUVo5EuRrpKpuijevg+HPxjCZcu7Ua6zQJWFcHufUO99HJRcdMTOh5LHSTA0F6oX34Te8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Af/JS/9K; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1709479880;
	bh=fE1ygv1xYb2HYZUOI0x3ptRJowm9HrcXCdzDrxnyxeM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Af/JS/9Kt4KdQ6bu0kzZ8NvVB/YI2b3GVeQ9EiWlSbJ4xdPKjZWi3OVYzImqhNrU4
	 atexIMqonVVXufcC+DUjT6ON0NzfZXHUNkReyHRy1zWAFBUeaiR/oNZqI5OmL3iP1Y
	 kyscKTMdSLW4TK4zjN7YUZkD4khUu4jXZUoDj75I=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 03 Mar 2024 16:31:15 +0100
Subject: [PATCH v2 3/4] power: supply: core: fix charge_behaviour
 formatting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240303-power_supply-charge_behaviour_prop-v2-3-8ebb0a7c2409@weissschuh.net>
References: <20240303-power_supply-charge_behaviour_prop-v2-0-8ebb0a7c2409@weissschuh.net>
In-Reply-To: <20240303-power_supply-charge_behaviour_prop-v2-0-8ebb0a7c2409@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709479879; l=2886;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=fE1ygv1xYb2HYZUOI0x3ptRJowm9HrcXCdzDrxnyxeM=;
 b=sfdWoZTYKANqBRjwaPPhtrEBieQe4GFAgpyFXMfHn5dcLMAEOywqcu6+l/zZo5uoqEXNF+6A7
 qaRltUz4qwWDk8YzAzd6maTHUomulkZmcj4SoPGHmJwjg5q3CAOc+9w
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This property is documented to have a special format which exposes all
available behaviours and the currently active one at the same time.
For this special format some helpers are provided.

However the default property logic in power_supply_sysfs.c is not using
the helper and the default logic only prints the currently active
behaviour.

Adjust power_supply_sysfs.c to follow the documented format.

There are currently two in-tree drivers exposing charge behaviours:
thinkpad_acpi and mm8013.
thinkpad_acpi is not affected by the change, as it directly uses the
helpers and does not use the power_supply_sysfs.c logic.

As mm8013 does not set implement desc->charge_behaviours.
the new logic will preserve the simple output format in this case.

Fixes: 1b0b6cc8030d ("power: supply: add charge_behaviour attributes")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply_sysfs.c | 20 ++++++++++++++++++++
 include/linux/power_supply.h              |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 10fec411794b..a20aa0156b0a 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -271,6 +271,23 @@ static ssize_t power_supply_show_usb_type(struct device *dev,
 	return count;
 }
 
+static ssize_t power_supply_show_charge_behaviour(struct device *dev,
+						  struct power_supply *psy,
+						  union power_supply_propval *value,
+						  char *buf)
+{
+	int ret;
+
+	ret = power_supply_get_property(psy,
+					POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
+					value);
+	if (ret < 0)
+		return ret;
+
+	return power_supply_charge_behaviour_show(dev, psy->desc->charge_behaviours,
+						  value->intval, buf);
+}
+
 static ssize_t power_supply_show_property(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf) {
@@ -303,6 +320,9 @@ static ssize_t power_supply_show_property(struct device *dev,
 		ret = power_supply_show_usb_type(dev, psy->desc,
 						&value, buf);
 		break;
+	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
+		ret = power_supply_show_charge_behaviour(dev, psy, &value, buf);
+		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
 		ret = sysfs_emit(buf, "%s\n", value.strval);
 		break;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index c0992a77feea..a50ee69503bf 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -242,6 +242,7 @@ struct power_supply_config {
 struct power_supply_desc {
 	const char *name;
 	enum power_supply_type type;
+	u8 charge_behaviours;
 	const enum power_supply_usb_type *usb_types;
 	size_t num_usb_types;
 	const enum power_supply_property *properties;

-- 
2.44.0


