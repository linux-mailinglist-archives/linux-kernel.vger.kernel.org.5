Return-Path: <linux-kernel+bounces-89800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E0986F5E3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25135B225AF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4643E67C7D;
	Sun,  3 Mar 2024 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="STo5rBOq"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DED67C43;
	Sun,  3 Mar 2024 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709479892; cv=none; b=ZwbDIymB/V9P9p0EH8Y2zydrKiIVZz1ix/wCOZiicGfZSNLHr6gG6Nu260CHEeOkwo8ciEf1ky+Uut7AHKdp4CBHU6GiDhrjcVM9m615N0zPBChZixDtPO6UudN0uL7Zc2VSBJQ5e6dENgah52qJeOEuE9YGVOeRgXPwtbo22zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709479892; c=relaxed/simple;
	bh=vO0wi2by1WM0BWnFkPRqBVKMUBA1OoHp/KPmP50MDPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cDHoCX/y3a7You53ezbFYQdnH4Vz0Ay6osBKDEljqKN919zLo6uOgbMgh1wD8VRJH5yVRo+4OXtqyLf4BVr07TPQIi82nG38CmBQd/wvK5UTGSPbv3rgCWS9lm/XBJP4oAkmAH8+wPeyNOmhQEwldah/4JZ1dI0sobZ80DXk68g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=STo5rBOq; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1709479880;
	bh=vO0wi2by1WM0BWnFkPRqBVKMUBA1OoHp/KPmP50MDPk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=STo5rBOqunq7z5IG7wu5dKvIA21c5NhAPYn8+cuq24n/Jhmfbey52WnUd3saXvOib
	 lmFqOc0+d6dojbXEDmVKLFlriXFtVfStoMX7D/euAS4ubVg79IbwHhQfxNc28sfB3C
	 lKlB7Js9uLTD4BntdbzoS2fbU5Vf/V3dGNaI1avQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 03 Mar 2024 16:31:14 +0100
Subject: [PATCH v2 2/4] power: supply: core: ease special formatting
 implementations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240303-power_supply-charge_behaviour_prop-v2-2-8ebb0a7c2409@weissschuh.net>
References: <20240303-power_supply-charge_behaviour_prop-v2-0-8ebb0a7c2409@weissschuh.net>
In-Reply-To: <20240303-power_supply-charge_behaviour_prop-v2-0-8ebb0a7c2409@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709479879; l=1698;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=vO0wi2by1WM0BWnFkPRqBVKMUBA1OoHp/KPmP50MDPk=;
 b=a4Tl17+Sqj9JWs4YaN8gTyUAG/AsZ3gSSPoZt8UeygTkJQEzuF9NsdqZb1pGUJMgoyw2rQ7Tg
 Zn8LkgaBgGiBhXTaqmL8u+iil5YwHxL5grGwjfDu4HtLuCyrnXTJjEd
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

By moving the conditional into the default-branch of the switch new
additions to the switch won't have to bypass the conditional.

This makes it easier to implement those special cases like the upcoming
change to the formatting of "charge_behaviour".

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/lkml/53082075-852f-4698-b354-ed30e7fd2683@redhat.com/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply_sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 977611e16373..10fec411794b 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -298,11 +298,6 @@ static ssize_t power_supply_show_property(struct device *dev,
 		}
 	}
 
-	if (ps_attr->text_values_len > 0 &&
-	    value.intval < ps_attr->text_values_len && value.intval >= 0) {
-		return sysfs_emit(buf, "%s\n", ps_attr->text_values[value.intval]);
-	}
-
 	switch (psp) {
 	case POWER_SUPPLY_PROP_USB_TYPE:
 		ret = power_supply_show_usb_type(dev, psy->desc,
@@ -312,7 +307,12 @@ static ssize_t power_supply_show_property(struct device *dev,
 		ret = sysfs_emit(buf, "%s\n", value.strval);
 		break;
 	default:
-		ret = sysfs_emit(buf, "%d\n", value.intval);
+		if (ps_attr->text_values_len > 0 &&
+				value.intval < ps_attr->text_values_len && value.intval >= 0) {
+			ret = sysfs_emit(buf, "%s\n", ps_attr->text_values[value.intval]);
+		} else {
+			ret = sysfs_emit(buf, "%d\n", value.intval);
+		}
 	}
 
 	return ret;

-- 
2.44.0


