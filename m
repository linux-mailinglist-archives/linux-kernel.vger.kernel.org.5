Return-Path: <linux-kernel+bounces-166213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 330298B979D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E017F28936A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E4654FAD;
	Thu,  2 May 2024 09:24:06 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B2D53816;
	Thu,  2 May 2024 09:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641846; cv=none; b=kdM+nIIt4Np/TnLhXd0HL7jPGeOf8c/bLuazqWyP0ZGtCFtw7xJkaj/Ijn8OSp1JW3USt66scvMb9ONTuJdJFMhkC7ccufslMdgYmFfakjaJYFxA6GsaO51Ev9nMrrO4H1SIp1yfU+TZJT3bCDTvxUhzlucSV1j9sug1J42/OQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641846; c=relaxed/simple;
	bh=gtlNGUFPlNzReMYLfiDLwgTRqYFon/MhNZwo8//HJgk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHZPuJI6SHSxzGQB43D2Q1YWr2FAySKMx0mNaYni3sz66idCJDLOlt+OTbXtkJeIleLiNNATiZj1ad3+1tFQbV819oz4DQGhL48t4fnr3dZMZgXaHxXzL1ESHbwrr7EoFpdOeMsNPQJQol3o7yT0lH18E1UnNz0fVL80YshgkHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4429NlmxE2333685, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4429NlmxE2333685
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 May 2024 17:23:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 17:23:48 +0800
Received: from RTDOMAIN (172.21.210.160) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 2 May
 2024 17:23:47 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v17 12/13] realtek: Update the Makefile and Kconfig in the realtek folder
Date: Thu, 2 May 2024 17:18:46 +0800
Message-ID: <20240502091847.65181-13-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502091847.65181-1-justinlai0215@realtek.com>
References: <20240502091847.65181-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

1. Add the RTASE entry in the Kconfig.
2. Add the CONFIG_RTASE entry in the Makefile.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/Kconfig  | 17 +++++++++++++++++
 drivers/net/ethernet/realtek/Makefile |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/realtek/Kconfig b/drivers/net/ethernet/realtek/Kconfig
index 93d9df55b361..57ef924deebd 100644
--- a/drivers/net/ethernet/realtek/Kconfig
+++ b/drivers/net/ethernet/realtek/Kconfig
@@ -113,4 +113,21 @@ config R8169
 	  To compile this driver as a module, choose M here: the module
 	  will be called r8169.  This is recommended.
 
+config RTASE
+	tristate "Realtek Automotive Switch 9054/9068/9072/9075/9068/9071 PCIe Interface support"
+	depends on PCI
+	select CRC32
+	help
+	  Say Y here if you have a Realtek Ethernet adapter belonging to
+	  the following families:
+	  RTL9054 5GBit Ethernet
+	  RTL9068 5GBit Ethernet
+	  RTL9072 5GBit Ethernet
+	  RTL9075 5GBit Ethernet
+	  RTL9068 5GBit Ethernet
+	  RTL9071 5GBit Ethernet
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called rtase. This is recommended.
+
 endif # NET_VENDOR_REALTEK
diff --git a/drivers/net/ethernet/realtek/Makefile b/drivers/net/ethernet/realtek/Makefile
index 2e1d78b106b0..0c1c16f63e9a 100644
--- a/drivers/net/ethernet/realtek/Makefile
+++ b/drivers/net/ethernet/realtek/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_8139TOO) += 8139too.o
 obj-$(CONFIG_ATP) += atp.o
 r8169-objs += r8169_main.o r8169_firmware.o r8169_phy_config.o
 obj-$(CONFIG_R8169) += r8169.o
+obj-$(CONFIG_RTASE) += rtase/
-- 
2.34.1


