Return-Path: <linux-kernel+bounces-51822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C18848FB6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4468B20C19
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0FB2555B;
	Sun,  4 Feb 2024 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="lo+YLcnf"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08719249E4;
	Sun,  4 Feb 2024 17:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707067629; cv=none; b=VgVUt5w4qbKnUdIv8QKaKqqORfwuh1JJoRKLPS3m2LaHKNhoLxGO7GtGnFRaRqmEiLppF6ybifHQGVHh1ShNcdffMpAi1Rx5SOiW0PB9hEU68NcRSKE2dNLkBQhH3b51Khv+Ik8iitEWxFZ2m0dniBG6L8em4JRCz1cAbC0iEww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707067629; c=relaxed/simple;
	bh=83yBY9rck6+K+bEFFiUYGjSaD/z/BJ7WS//fZZE59+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DddXjRpyKDICl6DYxW0bnU/zlXj7GZn6SSnXyZ87ZDiWe3VUOmZIE9qmWdZelFc+oKkgB5GpvpnlkbrC9BFrLDCdaKQ3nl1i7M2vKL7438LZOOErbYI+OiWwtHEgA9J/9WiJbLLTVn+ViNyCG7Ap1a68hiDr87AIGE2AV4F3lqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=lo+YLcnf; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1707067616;
	bh=83yBY9rck6+K+bEFFiUYGjSaD/z/BJ7WS//fZZE59+k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lo+YLcnfHwvLzQS0lWRbt0O8A/HkKVTTx9cjxoxp4BnCaF+tDTHNjnQb4+mmWaWwP
	 LG55jcYg6vZ3bgOXcq1rJDHllkQdqXLaw5pWCWoB0Dq/qbYCpxtnxpCSMcR8eZaIEc
	 JPUhv86cCi1HOOsxbq5id5x1MoqGcWCfCitXfT/E=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 04 Feb 2024 18:26:47 +0100
Subject: [PATCH 1/4] power: supply: core: fix charge_behaviour formatting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240204-power_supply-charge_behaviour_prop-v1-1-06a20c958f96@weissschuh.net>
References: <20240204-power_supply-charge_behaviour_prop-v1-0-06a20c958f96@weissschuh.net>
In-Reply-To: <20240204-power_supply-charge_behaviour_prop-v1-0-06a20c958f96@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707067615; l=3685;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=83yBY9rck6+K+bEFFiUYGjSaD/z/BJ7WS//fZZE59+k=;
 b=//GN4ufpRA6QtLBhWpmTQ7vbg0vlaq/ZYuBZfls9xZQQXdtbiWc7f8DcS++H1Yr9WG3b+Mx/l
 vmnDc4L7qgtA0kgkj/5VjWwEW/+zw0lHH5e2mrO/xHXK7d/n+ae3dv+
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

As mm8013 does not implement POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE
the new logic will preserve the simple output format in this case.

Fixes: 1b0b6cc8030d ("power: supply: add charge_behaviour attributes")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply_sysfs.c | 32 +++++++++++++++++++++++++++++++
 include/linux/power_supply.h              |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 977611e16373..3680cfc2e908 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -271,6 +271,32 @@ static ssize_t power_supply_show_usb_type(struct device *dev,
 	return count;
 }
 
+static ssize_t power_supply_show_charge_behaviour(struct device *dev,
+						  struct power_supply *psy,
+						  struct power_supply_attr *ps_attr,
+						  union power_supply_propval *value,
+						  char *buf)
+{
+	union power_supply_propval available;
+	int ret;
+
+	ret = power_supply_get_property(psy,
+					POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
+					value);
+	if (ret < 0)
+		return ret;
+
+	ret = power_supply_get_property(psy,
+					POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE,
+					&available);
+	if (ret == -EINVAL)
+		return sysfs_emit(buf, "%s\n", ps_attr->text_values[value->intval]);
+	else if (ret < 0)
+		return ret;
+
+	return power_supply_charge_behaviour_show(dev, available.intval, value->intval, buf);
+}
+
 static ssize_t power_supply_show_property(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf) {
@@ -282,6 +308,8 @@ static ssize_t power_supply_show_property(struct device *dev,
 
 	if (psp == POWER_SUPPLY_PROP_TYPE) {
 		value.intval = psy->desc->type;
+	} else if (psp == POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR) {
+		value.intval = -1;
 	} else {
 		ret = power_supply_get_property(psy, psp, &value);
 
@@ -308,6 +336,10 @@ static ssize_t power_supply_show_property(struct device *dev,
 		ret = power_supply_show_usb_type(dev, psy->desc,
 						&value, buf);
 		break;
+	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
+		ret = power_supply_show_charge_behaviour(dev, psy, ps_attr,
+							 &value, buf);
+		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
 		ret = sysfs_emit(buf, "%s\n", value.strval);
 		break;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index c0992a77feea..9a6e6b488164 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -135,6 +135,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD, /* in percents! */
 	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD, /* in percents! */
 	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
+	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE,
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 	POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
 	POWER_SUPPLY_PROP_INPUT_POWER_LIMIT,

-- 
2.43.0


