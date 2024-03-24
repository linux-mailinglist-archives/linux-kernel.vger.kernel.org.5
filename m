Return-Path: <linux-kernel+bounces-117369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D4E88AA82
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 573471F62193
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977A913CC70;
	Mon, 25 Mar 2024 15:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="gqLR18gn"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D4A131185;
	Mon, 25 Mar 2024 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380512; cv=none; b=akJ5fUatIxTwM/f0NM3YErd9fYWHJ6JbmGKXXon1AhgLo276BmW2AtW3SkyJYLlhnELM6kAPprlUW8fcgt2GQD1ENp+C2v+kaNyp2/eLGQGwl/jIChVU/EtIOh7mOa4rswuC01WffMFyQIqAEW9m8RXkmHOZWidGOzUGmn3NMSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380512; c=relaxed/simple;
	bh=yuwjtveKEbaL2UN5MUISEfFsSHypms+Pae4GIvHAq7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I18g15LN1p2PbLHbK4JBSyxaJ6Kub7kbJwuMnnKrx+whGosrO6sWYe6nVu/rRejN6FFi7HeyWoUgPg/0G0Seo5vAK8MCmrthV2vt+4r5Cjn16JbiP/QEwaRcQ5IV3KB35DDoKztY8Hs2Hqp6KB4QT+bmkj7udw38QRtcfJS1p9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=gqLR18gn; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1roltB-003KDv-0p;
	Mon, 25 Mar 2024 16:05:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NfgmcINbKPDsoie0JtH7mN1+qoCT0MNsvrJB7mPvdII=; b=gqLR18gnnboPMYwN2nCyKZCucU
	BjKN5z2jbUjHe/IpT79E1Tn8JdVrsBXlg0duVIrIGIukJjYwdDhhm3BdI5KQSFKs/RK1J308eY3O1
	BQzCDSZOTZJccfdnPEHgtNkYv/Ek5/WM+CYPzW+TAYrRfoAGZproLSjGmsdJioq5Zn60nMZRJwILx
	Eklssc9RsdeuSzSg/nW8GECrqZvvHsNXrsUmucqj7htOTvsj+Kqq2KgPPYQf8Mcg98CN9X81eihug
	BwKULqBCYLP8m/z6LqFCeTuTzpFQdTDkLBj+ABUnKh8IWZA886vmDgHK9fK0diBa6UrOACXitLWWd
	mmd5xhqg==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1roUCV-000Y9r-Fy; Sun, 24 Mar 2024 21:12:14 +0100
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1roUCU-000yRE-1A;
	Sun, 24 Mar 2024 21:12:14 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: lee@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	mazziesaccount@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [RFC PATCH 2/2] mfd: rohm-bd71828: Add power off functionality
Date: Sun, 24 Mar 2024 21:12:10 +0100
Message-Id: <20240324201210.232301-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240324201210.232301-1-andreas@kemnade.info>
References: <20240324201210.232301-1-andreas@kemnade.info>
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
 drivers/mfd/rohm-bd71828.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
index 594718f7e8e1..5a55aa3620d0 100644
--- a/drivers/mfd/rohm-bd71828.c
+++ b/drivers/mfd/rohm-bd71828.c
@@ -464,6 +464,24 @@ static int set_clk_mode(struct device *dev, struct regmap *regmap,
 				  OUT32K_MODE_CMOS);
 }
 
+static struct i2c_client *bd71828_dev;
+static void bd71828_power_off(void)
+{
+	i2c_smbus_write_byte_data(bd71828_dev, 0x03, 0xff);
+	mdelay(500);
+	i2c_smbus_write_byte_data(bd71828_dev, BD71828_REG_INT_DCIN2, 0x02);
+	mdelay(500);
+	while (true) {
+		i2c_smbus_write_byte_data(bd71828_dev, BD71828_REG_PS_CTRL_1, 0x02);
+		mdelay(500);
+	}
+}
+
+static void bd71828_remove_poweroff(void *data)
+{
+	bd71828_dev = NULL;
+}
+
 static int bd71828_i2c_probe(struct i2c_client *i2c)
 {
 	struct regmap_irq_chip_data *irq_data;
@@ -542,7 +560,18 @@ static int bd71828_i2c_probe(struct i2c_client *i2c)
 	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO, mfd, cells,
 				   NULL, 0, regmap_irq_get_domain(irq_data));
 	if (ret)
-		dev_err_probe(&i2c->dev, ret, "Failed to create subdevices\n");
+		return	dev_err_probe(&i2c->dev, ret, "Failed to create subdevices\n");
+
+	if (of_device_is_system_power_controller(i2c->dev.of_node)) {
+		if (!pm_power_off) {
+			bd71828_dev = i2c;
+			pm_power_off = bd71828_power_off;
+			ret = devm_add_action_or_reset(&i2c->dev,
+						       bd71828_remove_poweroff,
+						       NULL);
+		} else
+			dev_warn(&i2c->dev, "Poweroff callback already assigned\n");
+	}
 
 	return ret;
 }
-- 
2.39.2


