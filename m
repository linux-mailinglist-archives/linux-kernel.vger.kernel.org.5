Return-Path: <linux-kernel+bounces-51823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3325E848FB7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EE1BB215E2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8302225624;
	Sun,  4 Feb 2024 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="gEt+CYFa"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B574F249ED;
	Sun,  4 Feb 2024 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707067629; cv=none; b=dHH63r4aIK3w7nNfv8aty8iAdAjPaFLFBkh20/TRfn8BFHG9QFp4Hqznez4ugsItgGgJdv0TaHlEq+QEXWq9p2DbymZgdERne6OoyC9fDrtoqsgWJ0fxfWNObStAcrekhqCN+CtGB12GwNSe4m/rWSFjYyCyhenw0dXDKbmsNoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707067629; c=relaxed/simple;
	bh=IxAmxaUd639konem1J0CwPySbGfu/rKfRx4PF1P1Nfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=prDWyAgKBHPm+bEi/8724guZTUeGfeD5aJnYz3zLikrCigHTb60u8f4UXjPuMuaeqwsvotLaKLlzbn/oldfFqBg6tnpr/uDBvAeISHP1nt2ynyzz2f0S/S2rMxBxs8LgbJw1ugVv/ZZ6Wt6HrBD6w6WUufvSwNrDQVooZ24usmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=gEt+CYFa; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1707067616;
	bh=IxAmxaUd639konem1J0CwPySbGfu/rKfRx4PF1P1Nfs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gEt+CYFah1lDU279fX90PzcJZtwNiZTHhOkKgmMS+iwsL9kJdmFX+fW8UbUqEfDww
	 +ba8M3dextPoKKVkjZUiqNRrNFwYpBX/mMD69h2h1o9klPpnZ2oN4A2P/tWg85vFGl
	 3/xvPDcLYmGSOGIgPLw2vMyuwhH16YNcOG9p+JMw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 04 Feb 2024 18:26:50 +0100
Subject: [PATCH 4/4] power: supply: core: drop workaround for missing
 POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240204-power_supply-charge_behaviour_prop-v1-4-06a20c958f96@weissschuh.net>
References: <20240204-power_supply-charge_behaviour_prop-v1-0-06a20c958f96@weissschuh.net>
In-Reply-To: <20240204-power_supply-charge_behaviour_prop-v1-0-06a20c958f96@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707067615; l=1735;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=IxAmxaUd639konem1J0CwPySbGfu/rKfRx4PF1P1Nfs=;
 b=nN0rW/JGrCJIb+/x9MMDNSXtBsocp2ba6MNqVU656ezGH4x7jbknMB4pZdT5XLMbyMKZpfAv/
 xTfUVOKIqxuBsXEyAmgaOaqbxZu9C4OO3LwGLhgoc6rpM2OGRubm+X9
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

As the mm8013 driver was extended to also report that property the
workaround is not needed anymore.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply_sysfs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 3680cfc2e908..3804a3bbed24 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -273,7 +273,6 @@ static ssize_t power_supply_show_usb_type(struct device *dev,
 
 static ssize_t power_supply_show_charge_behaviour(struct device *dev,
 						  struct power_supply *psy,
-						  struct power_supply_attr *ps_attr,
 						  union power_supply_propval *value,
 						  char *buf)
 {
@@ -289,9 +288,7 @@ static ssize_t power_supply_show_charge_behaviour(struct device *dev,
 	ret = power_supply_get_property(psy,
 					POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE,
 					&available);
-	if (ret == -EINVAL)
-		return sysfs_emit(buf, "%s\n", ps_attr->text_values[value->intval]);
-	else if (ret < 0)
+	if (ret < 0)
 		return ret;
 
 	return power_supply_charge_behaviour_show(dev, available.intval, value->intval, buf);
@@ -337,8 +334,7 @@ static ssize_t power_supply_show_property(struct device *dev,
 						&value, buf);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
-		ret = power_supply_show_charge_behaviour(dev, psy, ps_attr,
-							 &value, buf);
+		ret = power_supply_show_charge_behaviour(dev, psy, &value, buf);
 		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
 		ret = sysfs_emit(buf, "%s\n", value.strval);

-- 
2.43.0


