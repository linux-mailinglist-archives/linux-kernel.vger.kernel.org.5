Return-Path: <linux-kernel+bounces-124288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1841489151A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4F5F287FA0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BA748CCD;
	Fri, 29 Mar 2024 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="IsYIrUMT"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C5339AF2;
	Fri, 29 Mar 2024 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711700327; cv=none; b=hLtzqdFZAYXEsL17BGolQGx/M6ZZPJX2z3EqBxQEwWXCmARXSiaPbbe/XMqgGb8BQ22VJIctTXS/UsKs1tcU5Jdiyy3gGlcXuDjBiA4NtdS6pMQO6aC8hDSB/OcJWocEO2k/Y+UYwx4UfeSHh2WRv0pGDn+nGJJ2UWKaSkNa4TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711700327; c=relaxed/simple;
	bh=ZfQyfX5CleZ4VR7K3+4MxiIAG8HW4iNUDvajqU/luM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dp/OR88Xqi4ocVy9ZpQUGns2Bc/OONrZ2oBg+e15b5iw2VbqeybFBuyCum7XtEbYNzD94PHGssuHjrPSPQbhugAbx/UFAodGzD7TVaI6VZ5Umvje1VO4ecauQAmVDUf0PCsWbfGwrSdAla7Djjn4rpjJXLaPmTCl2em45A5Dhlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=IsYIrUMT; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1711700312;
	bh=ZfQyfX5CleZ4VR7K3+4MxiIAG8HW4iNUDvajqU/luM4=;
	h=From:Date:Subject:To:Cc:From;
	b=IsYIrUMT6qvhdJP3Nqpx2Y1RQLmgsXvM5aDNvMplmnwg1Z+EN+Ee9OUMl9VdxkGCj
	 EEI6+RpTvXqng1MU6tqHidAzFgi2dToJtmvKm2Pt+UIvd1iTAJrCw0pERRlYq6xrlB
	 +9IHQ5yb2Mipza7zufX6g1/2JQI0LJBJUHbiQ1Kg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 29 Mar 2024 09:18:29 +0100
Subject: [PATCH] power: supply: core: simplify charge_behaviour formatting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240329-power-supply-simplify-v1-1-416f1002739f@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAFR5BmYC/x3MSQqEQAxA0atI1gbK2IN6FXEhVqo74BAqOCHev
 YtevsX/FxhHYYMmuyDyJibLnFDkGQzffv4wik8GcvRwJdWoy84RbVUdTzSZdJRw4vNNVLkXc/A
 eUquRgxz/b9vd9w+m194eZwAAAA==
To: Sebastian Reichel <sre@kernel.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711700312; l=2284;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ZfQyfX5CleZ4VR7K3+4MxiIAG8HW4iNUDvajqU/luM4=;
 b=b0srRQ1bNaeTiPSKG7E15ppmTB1Ze+XWTTodFvwIzEbVkGs4E7euS+hhWsnqYJiBwBTXQVMu6
 j6JJDJ4nQOWCUkxpx5GRc9d3c/B0zFXQVTD4YFl3ENB8KoABGcD1sxg
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The function power_supply_show_charge_behaviour() is not needed and can
be removed completely.
Removing the function also saves a spurious read of the property from
the driver on each call.

The convulted logic was a leftover from an earlier patch revision.
Some restructuring made this cleanup possible.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/all/9e035ae4-cb07-4f84-8336-1a0050855bea@redhat.com/
Fixes: 4e61f1e9d58f ("power: supply: core: fix charge_behaviour formatting")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply_sysfs.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 0d2c3724d0bc..b86e11bdc07e 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -271,23 +271,6 @@ static ssize_t power_supply_show_usb_type(struct device *dev,
 	return count;
 }
 
-static ssize_t power_supply_show_charge_behaviour(struct device *dev,
-						  struct power_supply *psy,
-						  union power_supply_propval *value,
-						  char *buf)
-{
-	int ret;
-
-	ret = power_supply_get_property(psy,
-					POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
-					value);
-	if (ret < 0)
-		return ret;
-
-	return power_supply_charge_behaviour_show(dev, psy->desc->charge_behaviours,
-						  value->intval, buf);
-}
-
 static ssize_t power_supply_show_property(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf) {
@@ -321,7 +304,8 @@ static ssize_t power_supply_show_property(struct device *dev,
 						&value, buf);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
-		ret = power_supply_show_charge_behaviour(dev, psy, &value, buf);
+		ret = power_supply_charge_behaviour_show(dev, psy->desc->charge_behaviours,
+							 value.intval, buf);
 		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
 		ret = sysfs_emit(buf, "%s\n", value.strval);

---
base-commit: 070c1470ae24317e7b19bd3882b300b6d69922a4
change-id: 20240329-power-supply-simplify-5722806eefdd

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


