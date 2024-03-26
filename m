Return-Path: <linux-kernel+bounces-119799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4266A88CD2B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51C08B21DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA88313D502;
	Tue, 26 Mar 2024 19:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="lt06R4VE"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B363513D296;
	Tue, 26 Mar 2024 19:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480993; cv=none; b=eAj+m+R4LH7xml0n4YiiBx0ofoTTDcmy4bELz35af/7XTrVJAhitqbgZx7hB8dJFhLaxYYPcHxPGQ9H9AxIjI7GEWbEX/AmrNln5fwWVVmz89c4qrGuEbw7LhYDZhOnEbhT0pDZZDpNorOxYC5E41tUPCv3E9HTVTtAAKXRR6hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480993; c=relaxed/simple;
	bh=f8HG3e1ClCrHzKAhwCDleSXnn0+ft6Urm+6xTlDP6vU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rnrNJBM7in+Uc3vz9Ba8Rlc0Fi98CJ00FLEAx3F5k296d7pwVccJqJg8NPqIBOAp4CsMPOQCZ3jEuFpAoQwb25e35KXgUy7tnxjQ+iek6xozjl5tODvxj0TiJvyBUhB/ShqHnTgxE0oFDvsYG9czn4o239OBFTJzF6yPFuk3N28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=lt06R4VE; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rpCO0-003QYQ-0p;
	Tue, 26 Mar 2024 20:23:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+jxVHRwQhG/IIQ16MId8Kg/5S9fPK/hentUCgSuXt8g=; b=lt06R4VEqQfBQAfygxBNYV8VLr
	ggG33nSffiGkDqB6l5Jg99k3Qcbyc2QQvO7+/djFnfDnGAT8ablDeWpC/2FrvMBMzPt6xdPWHaFwU
	05axalYIyDLECiiTT8pZ/6PJcfI00U39QTFo590b9QaElnEuMXubIsj7XGtTZbmtILtxKGDRmr8za
	hrJOw8IEiFw4uwN33FGXT/j1z+tbvz32LbioUWNYC0s8WTzpxwKcI5doyxDDsr/1OygYhicjJnE+z
	/15MWhCpjrgaJaHgO9zR2t4wOlkPWYvSnGRtnCUdJEwaiV+/yq+cu5Gj+FLtt6eH5Bvasy3mQ7Wez
	kcp/sGDQ==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rpCNy-0002bz-2v;
	Tue, 26 Mar 2024 20:23:03 +0100
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rpCNy-001FZB-2m;
	Tue, 26 Mar 2024 20:23:02 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: lee@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	mazziesaccount@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 2/2] mfd: rohm-bd71828: Add power off functionality
Date: Tue, 26 Mar 2024 20:22:58 +0100
Message-Id: <20240326192258.298143-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326192258.298143-1-andreas@kemnade.info>
References: <20240326192258.298143-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the chip can power off the system, add the corresponding
functionality.
Based on https://github.com/kobolabs/Kobo-Reader/raw/master/hw/imx6sll-clara2e/kernel.tar.bz2
No information source about the magic numbers found.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/mfd/rohm-bd71828.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
index 594718f7e8e1..8fd994664bbf 100644
--- a/drivers/mfd/rohm-bd71828.c
+++ b/drivers/mfd/rohm-bd71828.c
@@ -464,6 +464,21 @@ static int set_clk_mode(struct device *dev, struct regmap *regmap,
 				  OUT32K_MODE_CMOS);
 }
 
+static struct i2c_client *bd71828_dev;
+static void bd71828_power_off(void)
+{
+	while (true) {
+		/* We are not allowed to sleep, so do not use regmap involving mutexes here. */
+		i2c_smbus_write_byte_data(bd71828_dev, BD71828_REG_PS_CTRL_1, 0x02);
+		mdelay(500);
+	}
+}
+
+static void bd71828_remove_poweroff(void *data)
+{
+	pm_power_off = NULL;
+}
+
 static int bd71828_i2c_probe(struct i2c_client *i2c)
 {
 	struct regmap_irq_chip_data *irq_data;
@@ -542,7 +557,20 @@ static int bd71828_i2c_probe(struct i2c_client *i2c)
 	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO, mfd, cells,
 				   NULL, 0, regmap_irq_get_domain(irq_data));
 	if (ret)
-		dev_err_probe(&i2c->dev, ret, "Failed to create subdevices\n");
+		return	dev_err_probe(&i2c->dev, ret, "Failed to create subdevices\n");
+
+	if (of_device_is_system_power_controller(i2c->dev.of_node) &&
+	    chip_type == ROHM_CHIP_TYPE_BD71828) {
+		if (!pm_power_off) {
+			bd71828_dev = i2c;
+			pm_power_off = bd71828_power_off;
+			ret = devm_add_action_or_reset(&i2c->dev,
+						       bd71828_remove_poweroff,
+						       NULL);
+		} else {
+			dev_warn(&i2c->dev, "Poweroff callback already assigned\n");
+		}
+	}
 
 	return ret;
 }
-- 
2.39.2


