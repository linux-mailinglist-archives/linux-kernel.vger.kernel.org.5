Return-Path: <linux-kernel+bounces-85205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0E086B23E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2BE7B28B54
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97B1151CDB;
	Wed, 28 Feb 2024 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="cSzlfyPx"
Received: from refb02.tmes.trendmicro.eu (refb02.tmes.trendmicro.eu [18.185.115.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E55D2D022
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131546; cv=fail; b=UAvKFNfmuDqaEm/wTrb6xxnlUPZGDJYoI/D6LobhhMg2/MzbGp1qzfIwH5wYpWlFE+7OgHfuy6rf/mT0wXFf42kMDz4Qor/El/DiZTjPsrOn+QE3rUC2C2aCp8rt2ZZgiAvo1PhIKeZ7NVyTW+/jkfhdI1ZztCrNnurGQ5NgNJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131546; c=relaxed/simple;
	bh=wccHaYRRmdaQrFNTjtIYVVqOXBpIk0wQINyYR90rUZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GC6ip1Cl3h04XPz4I63Wsm4bA6nn2qEfVei9pLiWkCdeDQg0DA+2UuIutSEGMdTmp3aZpoLqB4DYmhqU4yNBlF+NB5Uppmqq23mGi8sK86yC7j+N8khD6mi6P5wL4YnMWPCbIjdA4gK781DfFb4PE4PcqMe0OkecgEiuDCXQfJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=cSzlfyPx; arc=fail smtp.client-ip=18.185.115.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.169_.trendmicro.com (unknown [172.21.19.113])
	by refb02.tmes.trendmicro.eu (Postfix) with ESMTPS id 4F0E110170AC0
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:28:11 +0000 (UTC)
Received: from 104.47.11.169_.trendmicro.com (unknown [172.21.162.72])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id F2710100017C2;
	Wed, 28 Feb 2024 14:28:03 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1709130483.586000
X-TM-MAIL-UUID: d98f862d-1a46-4034-8414-4368629b174b
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 8F4ED1000030B;
	Wed, 28 Feb 2024 14:28:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxVlkl4OwPT0L0Y5GVBXYj5+X+AdyjFllF6uLdTHL9tuCqH1CzaDxqxZl8YdnMQOuT2CxOL+N8KNVGPH29fwqhHh97oPTeV/YLc3A2OYlJn6//Kseay6mMK2sc8nDcnNWoJxy6/+HQ5s5i6hz9aOYJ9whErJNkH4IqkVrbNePViUg72E/YIeZHhup+lTl2Zx7MtdZBVJujDPYTTaOtNfPacTd2byeH5b51QlGlPgF+uaClfFlr270+q6v4+2Zt1aIzTOG8rBiGBzL18WckJO+PKqFE2aIdkro6+bMRMWmlzWqWnsFknMYRZyTnRwM4YI1wxvwVsjZqcDF2Mo+IvpgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCmlABCO8fDFjHyDcjgORV1Mb1fcDEegzdNLOOic0D0=;
 b=A1PY4U/itGyNoAscqWWyPr+oJVd9hyeFs4SJPrvRbXdKW/m0tfMiNqcyXGWcG8N/9yCJL9CMbZorKiW4ttlDD3C2jf19pGYZvk50HYH/Gsai3gW7glVoGThFeETwS5r/IGk3HD0KAuhAcdqR66V/8myVhosGBgryUBJXrjwc3i6mJzeMzkgrhV9Z/k1o0+XDDn2oEVaqe/WXZPv8RrwsKvYxJAe0tdPipcPxyEXPNcAIlYB8FefN0EveatbO2OhunwFMup53xNsGiKfRrJ7h5MEwG9bbjZMdP96/+idFz5BWNYeu5HyjUvexzTaY3PZEfxE8pHpE5wOB3XkVJaSiCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=kernel.org smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=opensynergy.com; dkim=none (message not signed); arc=none (0)
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From: Harald Mommer <Harald.Mommer@opensynergy.com>
To: virtio-dev@lists.oasis-open.org,
	Haixu Cui <quic_haixcui@quicinc.com>,
	Mark Brown <broonie@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: quic_ztu@quicinc.com,
	Matti Moell <Matti.Moell@opensynergy.com>,
	Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
	Harald Mommer <harald.mommer@opensynergy.com>,
	Harald Mommer <Harald.Mommer@opensynergy.com>
Subject: [PATCH v1 3/3] virtio-spi: Add virtio SPI driver.
Date: Wed, 28 Feb 2024 15:27:55 +0100
Message-Id: <20240228142755.4061-4-Harald.Mommer@opensynergy.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240228142755.4061-1-Harald.Mommer@opensynergy.com>
References: <20240228142755.4061-1-Harald.Mommer@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A8:EE_|BEZP281MB3062:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 51dc0404-23d9-491f-33dc-08dc386977ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1oORbvyab65slbSic3WNN40562uZKH8g44Qbu3Kg5IElBvgXviXuwErDNPCzcnhEoLBmTRooFedXcQ+7Tc3X9OyHk6WRkUuA7zevjTlqJRoApxyJ5qEHyzRppKqZmbiKyIiCelHob9YFg6OYaixJoS+P1W7PNwZhjd1rslc0fr6JCj9X1DbMEmGr9zjhRp2vBJ6+tjv1zNWDm+Btk1+W81imOuBPHT8JPELj5i5lFW+TKWPaxlAdxxy/zZ7XZKhL4HIqB2b31IHAfOfEUHho631yrlleFJDoZh9uMWiTor5+7i9pymj+IYiVjOWDOOwJNLdeQ4dKiJVPac4BvCbXOApd2dC9N6fRXedZ2ds7ulZjeIiEZvRCjQWJWmMiol7GdnhWQL9T7YTxLs1GkXrKunwWjN/er8grErfsCHMAQmiS6++avUOv/HMUri9ZiGb8AnrIMSGMeG5Ly6gs2KygusiK+AlIkMNrQ1o438xy6erJNhNWoOEl0Th8swhq+D+U4A5xs/iBRxX+1GHuivoq0UJ1aW8XCQuU0/PhD3l8UjInt2/4vryb+DpdhRxKNQ/GZopFu307IYlDgi4fc5f2sPhUAcPHTPSNd2OsjingPfUYMCbE/kPqXCn2xXVqMr5Jw0EdHdXhtRXcQ3xrukvSN/snuFqQ+LbzyW/ytU4PxIIhClotK/wBUwsKP3szpK/LM5QDs+Btt198NMeR5SCDu70b/hWCGm9K+cuBwB06rqKEjrJDRsqVaafdXzN3hgBI
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 14:28:01.1448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51dc0404-23d9-491f-33dc-08dc386977ca
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A8.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB3062
X-TM-AS-ERS: 104.47.11.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28218.007
X-TMASE-Result: 10--13.787800-4.000000
X-TMASE-MatchedRID: HE8hON2ynzcAsgl6PZgqJOkI20Cl55uDgz5VmKZ8x87hCm8am+SP54vP
	iBq/iW91MpPx8OFzfY0zJJn1odE+3zVxLV/TD3CFsX4aFYAMIYPIQQwRv8gPjskXIF34mJLKOnp
	NWpJkOQuTIJr1EFP8Nn7U1eUtsS59MsZYFnBjXTWF3V/JMHm7u781t3rGD+B++wWpop+OSdw4As
	RtUisW+DmvcaGRO/Oh31jKtZ+jlPPy8yPa5oCwl4WEan0Y08OtfJ3eYkN7pTES6lv5p9KHVZtjb
	vEw2yYya+t98YxCbwSI47i1GQb7nS1CuW+6P3e+BA/ZR5qnp8O4UL3v//+17eY6m/6o4hAKqFty
	1HMHrV6ZNA2b+iaOd6EA84aOEbsGODSqp4i2jlcKonRFsndtvYo3KQs0iA9hiGVApiRLArkow1L
	HBmlcNps6E2fc3GjdUTh5CoFhalLaej9gO1Z/MOBHyXZCGbHqfq7xWexVq1yyBw15H24MRz/m+V
	kiqierl1NYlxxvWUwtgEZJUHc75WBnDtEasdEgiL+RrlWsewrY2awIDlDmun7ZRtYqlSvxFiudH
	R1ngLGK74BU3ZTzPXKQ85FZRoOF3WI5i77IXCnFBwzJyVLv9xqklYkipn3PS3PLJOcIhnVs7ZYn
	R9ZralncYgN9Ud2Z6xA0Ava73nBcOnqpgy+bqxEuOqgkm3/1h7z+gmKKj0oDf6I8jFx+tlmLzQc
	f60Tu0K2S3XHNPUe/2tJ3foSBQiPzRlrdFGDwNEHQipqsVMg1AAEuBf5okkD+1rs1KoVDLZv5Oe
	M/dOFDtKdYRNRb+w==
X-TMASE-XGENCLOUD: 7c874ead-db80-4f39-b269-9a19b31ed382-0-0-200-0
X-TM-Deliver-Signature: 509002F337D67242CDE88B54126CCC28
X-TM-Addin-Auth: FQ6XPoiTNN9ZjxNErXwyWrGmqUi3bCzO2XF7gHNADvvmbipyPmMYZLD+/W6
	uxOdGEP2cyLdAN8ajPHw3MKoz95OwDhqs6poXMvQwc2Aa7jq8bq/Zgp9MN+CERDjSPcLbS42QHs
	Za2I4hQ9uOCA2NemL4QCFSdO3ST/qofvCv2Zepm43BRB9LdeuOKKNgXkCZrtMRa1Kgzg0lwQFJb
	BEXGihdLZIrePEW2Jklq0oMvbEt/mxyX2BOTlKkFMPTZuEh+hQb6yBJwHUNTl9qMymtqU9fSviF
	G39YY1brbS5gyn0=.mkVmxQ+K9MIIIw/41gq+3+PWCwavUg5USdqd6HSdHrFmwRvt6zOSDmvDhc
	fX9DpmJGDua1BR4ILXkcHi7H0rckw95YDS4Rdc8uGTb5dhajn9CzCKgDpDN0kRcySy0ic6PQms+
	sHM+4Wbo90YqjZgPdZafj1z3cQNncILXDUCsjF3iMKGR6zutMgDPO4obgTDKWoVuovWYi6r9v77
	jVB05kxynP9IKEhZGwiqQQUIhGYSL2S0B4JP9p8dOsBI+14FVvnF3MCiuJ8aIZUnZ/88wVnF4HM
	RMm2UdjFm1RNV5Ut5qMgfsy70dxVXoqVoAlGWQz0WhWhY9RPGtouWCD2sog==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1709130483;
	bh=wccHaYRRmdaQrFNTjtIYVVqOXBpIk0wQINyYR90rUZw=; l=16816;
	h=From:To:Date;
	b=cSzlfyPxPYllTChLg6zDrAdzo5nRMpkF7ipMfRzu1TdPby25aOhfu5OcAAeeYq7v8
	 K0fcxwGDwJbrBzIfF9TV84yxPLUSQV9YrVtR4enjwZOdbsJJLwX9aAPNLUIfXrh/7E
	 cS+VKplCYIO446W6NZWwUoOnKQHdJBtxel0dgl/PtCrttphl58Ui9o/F5aFu2rn83s
	 ngQH4bj6CGDR2U3n/MaRnmHkm32P7Xq0skHxwnrraxRG18wP1TLeab38a1KeWyKIV9
	 T7NIuGewdS/xMXikuQqOwwb90e6S4RgSzIeSNZdV9TBHoq1TPrkfAdgo+on5X2kH/u
	 clUKj3dbCm7kA==

From: Harald Mommer <harald.mommer@opensynergy.com>

This is the virtio SPI Linux kernel driver.

Signed-off-by: Harald Mommer <Harald.Mommer@opensynergy.com>
---
 MAINTAINERS              |   6 +
 drivers/spi/Kconfig      |  11 +
 drivers/spi/Makefile     |   1 +
 drivers/spi/spi-virtio.c | 480 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 498 insertions(+)
 create mode 100644 drivers/spi/spi-virtio.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ecaaec6a6bf..536fad147724 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23391,6 +23391,12 @@ S:	Maintained
 F:	include/uapi/linux/virtio_snd.h
 F:	sound/virtio/*
 
+VIRTIO SPI DRIVER
+M:	Harald Mommer <harald.mommer@opensynergy.com>
+S:	Maintained
+F:	include/uapi/linux/virtio_spi.h
+F:	drivers/spi/spi-virtio.c
+
 VIRTUAL BOX GUEST DEVICE DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 M:	Arnd Bergmann <arnd@arndb.de>
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ddae0fde798e..ff06e595679a 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1125,6 +1125,17 @@ config SPI_UNIPHIER
 
 	  If your SoC supports SCSSI, say Y here.
 
+config SPI_VIRTIO
+	tristate "Virtio SPI Controller"
+	depends on SPI_MASTER && VIRTIO
+	help
+	  This enables the Virtio SPI driver.
+
+	  Virtio SPI is an SPI driver for virtual machines using Virtio.
+
+	  If your Linux is a virtual machine using Virtio, say Y here.
+	  If unsure, say N.
+
 config SPI_XCOMM
 	tristate "Analog Devices AD-FMCOMMS1-EBZ SPI-I2C-bridge driver"
 	depends on I2C
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 4ff8d725ba5e..ff2243e44e00 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -146,6 +146,7 @@ spi-thunderx-objs			:= spi-cavium.o spi-cavium-thunderx.o
 obj-$(CONFIG_SPI_THUNDERX)		+= spi-thunderx.o
 obj-$(CONFIG_SPI_TOPCLIFF_PCH)		+= spi-topcliff-pch.o
 obj-$(CONFIG_SPI_UNIPHIER)		+= spi-uniphier.o
+obj-$(CONFIG_SPI_VIRTIO)		+= spi-virtio.o
 obj-$(CONFIG_SPI_XCOMM)		+= spi-xcomm.o
 obj-$(CONFIG_SPI_XILINX)		+= spi-xilinx.o
 obj-$(CONFIG_SPI_XLP)			+= spi-xlp.o
diff --git a/drivers/spi/spi-virtio.c b/drivers/spi/spi-virtio.c
new file mode 100644
index 000000000000..7e1a75f1b45a
--- /dev/null
+++ b/drivers/spi/spi-virtio.c
@@ -0,0 +1,480 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SPI bus driver for the Virtio SPI controller
+ * Copyright (C) 2023 OpenSynergy GmbH
+ */
+
+#include <linux/completion.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/spi/spi.h>
+#include <linux/stddef.h>
+#include <linux/virtio.h>
+#include <linux/virtio_ring.h>
+#include <linux/virtio_spi.h>
+
+struct virtio_spi_req {
+	struct completion completion;
+	struct spi_transfer_head transfer_head	____cacheline_aligned;
+	const uint8_t *tx_buf			____cacheline_aligned;
+	uint8_t *rx_buf				____cacheline_aligned;
+	struct spi_transfer_result result	____cacheline_aligned;
+};
+
+/* virtio_spi private data structure */
+struct virtio_spi_priv {
+	/* Virtio SPI message */
+	struct virtio_spi_req spi_req;
+	/* The virtio device we're associated with */
+	struct virtio_device *vdev;
+	/* Pointer to the virtqueue */
+	struct virtqueue *vq;
+	/* Copy of config space mode_func_supported */
+	u32 mode_func_supported;
+	/* Copy of config space max_freq_hz */
+	u32 max_freq_hz;
+};
+
+static struct spi_board_info board_info = {
+	.modalias = "spi-virtio",
+};
+
+static void virtio_spi_msg_done(struct virtqueue *vq)
+{
+	struct virtio_spi_req *req;
+	unsigned int len;
+
+	while ((req = virtqueue_get_buf(vq, &len)))
+		complete(&req->completion);
+}
+
+/*
+ *       .   .      .    .    .   .   .   .   .   .
+ * Delay + A +      + B  +    + C + D + E + F + A +
+ *       .   .      .    .    .   .   .   .   .   .
+ *    ___.   .      .    .    .   .   .___.___.   .
+ * CS#   |___.______.____.____.___.___|   .   |___._____________
+ *       .   .      .    .    .   .   .   .   .   .
+ *       .   .      .    .    .   .   .   .   .   .
+ * SCLK__.___.___NNN_____NNN__.___.___.___.___.___.___NNN_______
+ *
+ * NOTE: 1st transfer has two words, the delay between these two words are
+ * 'B' in the diagram.
+ *
+ * A => struct spi_device -> cs_setup
+ * B => max{struct spi_transfer -> word_delay, struct spi_device -> word_delay}
+ *   Note: spi_device and spi_transfer both have word_delay, Linux
+ *         choose the bigger one, refer to _spi_xfer_word_delay_update function
+ * C => struct spi_transfer -> delay
+ * D => struct spi_device -> cs_hold
+ * E => struct spi_device -> cs_inactive
+ * F => struct spi_transfer -> cs_change_delay
+ *
+ * So the corresponding relationship:
+ * A <===> cs_setup_ns (after CS asserted)
+ * B <===> word_delay_ns (no matter with CS)
+ * C+D <===> cs_delay_hold_ns (before CS deasserted)
+ * E+F <===> cs_change_delay_inactive_ns (after CS deasserted, these two
+ * values are also recommended in the Linux driver to be added up)
+ */
+static int virtio_spi_set_delays(struct spi_transfer_head *th,
+				 struct spi_device *spi,
+				 struct spi_transfer *xfer)
+{
+	int cs_setup;
+	int cs_word_delay_xfer;
+	int cs_word_delay_spi;
+	int delay;
+	int cs_hold;
+	int cs_inactive;
+	int cs_change_delay;
+
+	cs_setup = spi_delay_to_ns(&spi->cs_setup, xfer);
+	if (cs_setup < 0) {
+		dev_warn(&spi->dev, "Cannot convert cs_setup\n");
+		return cs_setup;
+	}
+	th->cs_setup_ns = cpu_to_le32((u32)cs_setup);
+
+	cs_word_delay_xfer = spi_delay_to_ns(&xfer->word_delay, xfer);
+	if (cs_word_delay_xfer < 0) {
+		dev_warn(&spi->dev, "Cannot convert cs_word_delay_xfer\n");
+		return cs_word_delay_xfer;
+	}
+	cs_word_delay_spi = spi_delay_to_ns(&spi->word_delay, xfer);
+	if (cs_word_delay_spi < 0) {
+		dev_warn(&spi->dev, "Cannot convert cs_word_delay_spi\n");
+		return cs_word_delay_spi;
+	}
+	if (cs_word_delay_spi > cs_word_delay_xfer)
+		th->word_delay_ns = cpu_to_le32((u32)cs_word_delay_spi);
+	else
+		th->word_delay_ns = cpu_to_le32((u32)cs_word_delay_xfer);
+
+	delay = spi_delay_to_ns(&xfer->delay, xfer);
+	if (delay < 0) {
+		dev_warn(&spi->dev, "Cannot convert delay\n");
+		return delay;
+	}
+	cs_hold = spi_delay_to_ns(&spi->cs_hold, xfer);
+	if (cs_hold < 0) {
+		dev_warn(&spi->dev, "Cannot convert cs_hold\n");
+		return cs_hold;
+	}
+	th->cs_delay_hold_ns = cpu_to_le32((u32)delay + (u32)cs_hold);
+
+	cs_inactive = spi_delay_to_ns(&spi->cs_inactive, xfer);
+	if (cs_inactive < 0) {
+		dev_warn(&spi->dev, "Cannot convert cs_inactive\n");
+		return cs_inactive;
+	}
+	cs_change_delay = spi_delay_to_ns(&xfer->cs_change_delay, xfer);
+	if (cs_change_delay < 0) {
+		dev_warn(&spi->dev, "Cannot convert cs_change_delay\n");
+		return cs_change_delay;
+	}
+	th->cs_change_delay_inactive_ns =
+		cpu_to_le32((u32)cs_inactive + (u32)cs_change_delay);
+
+	return 0;
+}
+
+static int virtio_spi_transfer_one(struct spi_controller *ctrl,
+				   struct spi_device *spi,
+				   struct spi_transfer *xfer)
+{
+	struct virtio_spi_priv *priv = spi_controller_get_devdata(ctrl);
+	struct virtio_spi_req *spi_req = &priv->spi_req;
+	struct spi_transfer_head *th;
+	struct scatterlist sg_out_head, sg_out_payload;
+	struct scatterlist sg_in_result, sg_in_payload;
+	struct scatterlist *sgs[4];
+	unsigned int outcnt = 0u;
+	unsigned int incnt = 0u;
+	int ret;
+
+	th = &spi_req->transfer_head;
+
+	/* Fill struct spi_transfer_head */
+	th->chip_select_id = spi_get_chipselect(spi, 0);
+	th->bits_per_word = spi->bits_per_word;
+	th->cs_change = xfer->cs_change;
+	th->tx_nbits = xfer->tx_nbits;
+	th->rx_nbits = xfer->rx_nbits;
+	th->reserved[0] = 0;
+	th->reserved[1] = 0;
+	th->reserved[2] = 0;
+
+	BUILD_BUG_ON(VIRTIO_SPI_CPHA != SPI_CPHA);
+	BUILD_BUG_ON(VIRTIO_SPI_CPOL != SPI_CPOL);
+	BUILD_BUG_ON(VIRTIO_SPI_CS_HIGH != SPI_CS_HIGH);
+	BUILD_BUG_ON(VIRTIO_SPI_MODE_LSB_FIRST != SPI_LSB_FIRST);
+
+	th->mode = cpu_to_le32(spi->mode & (SPI_LSB_FIRST | SPI_CS_HIGH |
+					    SPI_CPOL | SPI_CPHA));
+	if ((spi->mode & SPI_LOOP) != 0)
+		th->mode |= cpu_to_le32(VIRTIO_SPI_MODE_LOOP);
+
+	th->freq = cpu_to_le32(xfer->speed_hz);
+
+	ret = virtio_spi_set_delays(th, spi, xfer);
+	if (ret)
+		goto msg_done;
+
+	/* Set buffers */
+	spi_req->tx_buf = xfer->tx_buf;
+	spi_req->rx_buf = xfer->rx_buf;
+
+	/* Prepare sending of virtio message */
+	reinit_completion(&spi_req->completion);
+
+	sg_init_one(&sg_out_head, th, sizeof(*th));
+	sgs[outcnt] = &sg_out_head;
+	outcnt++;
+
+	if (spi_req->tx_buf) {
+		sg_init_one(&sg_out_payload, spi_req->tx_buf, xfer->len);
+		sgs[outcnt] = &sg_out_payload;
+		outcnt++;
+	}
+
+	if (spi_req->rx_buf) {
+		sg_init_one(&sg_in_payload, spi_req->rx_buf, xfer->len);
+		sgs[outcnt] = &sg_in_payload;
+		incnt++;
+	}
+
+	sg_init_one(&sg_in_result, &spi_req->result,
+		    sizeof(struct spi_transfer_result));
+	sgs[outcnt + incnt] = &sg_in_result;
+	incnt++;
+
+	ret = virtqueue_add_sgs(priv->vq, sgs, outcnt, incnt, spi_req,
+				GFP_KERNEL);
+	if (ret)
+		goto msg_done;
+
+	/* Simple implementation: There can be only one transfer in flight */
+	virtqueue_kick(priv->vq);
+
+	wait_for_completion(&priv->spi_req.completion);
+
+	/* Read result from message and translate return code */
+	switch (priv->spi_req.result.result) {
+	case VIRTIO_SPI_TRANS_OK:
+		/* ret is 0 */
+		break;
+	case VIRTIO_SPI_PARAM_ERR:
+		ret = -EINVAL;
+		break;
+	case VIRTIO_SPI_TRANS_ERR:
+		ret = -EIO;
+		break;
+	default: /* Protocol violation */
+		ret = -EIO;
+		break;
+	}
+
+msg_done:
+	if (ret)
+		ctrl->cur_msg->status = ret;
+
+	return ret;
+}
+
+static void virtio_spi_read_config(struct virtio_device *vdev)
+{
+	struct spi_controller *ctrl = dev_get_drvdata(&vdev->dev);
+	struct virtio_spi_priv *priv = vdev->priv;
+	u8 cs_max_number;
+	u8 tx_nbits_supported;
+	u8 rx_nbits_supported;
+
+	cs_max_number = virtio_cread8(vdev, offsetof(struct virtio_spi_config,
+						     cs_max_number));
+	ctrl->num_chipselect = cs_max_number;
+
+	/* Set the mode bits which are understood by this driver */
+	priv->mode_func_supported =
+		virtio_cread32(vdev, offsetof(struct virtio_spi_config,
+					      mode_func_supported));
+	ctrl->mode_bits = priv->mode_func_supported &
+			  (VIRTIO_SPI_CS_HIGH | VIRTIO_SPI_MODE_LSB_FIRST);
+	if ((priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_CPHA_1) != 0)
+		ctrl->mode_bits |= VIRTIO_SPI_CPHA;
+	if ((priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_CPOL_1) != 0)
+		ctrl->mode_bits |= VIRTIO_SPI_CPOL;
+	if ((priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_LSB_FIRST) != 0)
+		ctrl->mode_bits |= SPI_LSB_FIRST;
+	if ((priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_LOOPBACK) != 0)
+		ctrl->mode_bits |= SPI_LOOP;
+	tx_nbits_supported =
+		virtio_cread8(vdev, offsetof(struct virtio_spi_config,
+					     tx_nbits_supported));
+	if ((tx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_DUAL) != 0)
+		ctrl->mode_bits |= SPI_TX_DUAL;
+	if ((tx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_QUAD) != 0)
+		ctrl->mode_bits |= SPI_TX_QUAD;
+	if ((tx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_OCTAL) != 0)
+		ctrl->mode_bits |= SPI_TX_OCTAL;
+	rx_nbits_supported =
+		virtio_cread8(vdev, offsetof(struct virtio_spi_config,
+					     rx_nbits_supported));
+	if ((rx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_DUAL) != 0)
+		ctrl->mode_bits |= SPI_RX_DUAL;
+	if ((rx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_QUAD) != 0)
+		ctrl->mode_bits |= SPI_RX_QUAD;
+	if ((rx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_OCTAL) != 0)
+		ctrl->mode_bits |= SPI_RX_OCTAL;
+
+	ctrl->bits_per_word_mask =
+		virtio_cread32(vdev, offsetof(struct virtio_spi_config,
+					      bits_per_word_mask));
+
+	priv->max_freq_hz =
+		virtio_cread32(vdev, offsetof(struct virtio_spi_config,
+					      max_freq_hz));
+}
+
+static int virtio_spi_find_vqs(struct virtio_spi_priv *priv)
+{
+	struct virtqueue *vq;
+
+	vq = virtio_find_single_vq(priv->vdev, virtio_spi_msg_done, "spi-rq");
+	if (IS_ERR(vq))
+		return (int)PTR_ERR(vq);
+	priv->vq = vq;
+	return 0;
+}
+
+/* Function must not be called before virtio_spi_find_vqs() has been run */
+static void virtio_spi_del_vq(struct virtio_device *vdev)
+{
+	virtio_reset_device(vdev);
+	vdev->config->del_vqs(vdev);
+}
+
+static int virtio_spi_validate(struct virtio_device *vdev)
+{
+	/*
+	 * SPI needs always access to the config space.
+	 * Check that the driver can access the config space
+	 */
+	if (!vdev->config->get) {
+		dev_err(&vdev->dev, "%s failure: config access disabled\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+		dev_err(&vdev->dev,
+			"device does not comply with spec version 1.x\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int virtio_spi_probe(struct virtio_device *vdev)
+{
+	struct device_node *np = vdev->dev.parent->of_node;
+	struct virtio_spi_priv *priv;
+	struct spi_controller *ctrl;
+	int err;
+	u32 bus_num;
+	u16 csi;
+
+	ctrl = devm_spi_alloc_host(&vdev->dev, sizeof(*priv));
+	if (!ctrl) {
+		dev_err(&vdev->dev, "Kernel memory exhausted in %s()\n",
+			__func__);
+		return -ENOMEM;
+	}
+
+	priv = spi_controller_get_devdata(ctrl);
+	priv->vdev = vdev;
+	vdev->priv = priv;
+	dev_set_drvdata(&vdev->dev, ctrl);
+
+	init_completion(&priv->spi_req.completion);
+
+	err = of_property_read_u32(np, "spi,bus-num", &bus_num);
+	if (!err && bus_num <= S16_MAX)
+		ctrl->bus_num = (s16)bus_num;
+
+	virtio_spi_read_config(vdev);
+
+	/* Method to do a single SPI transfer */
+	ctrl->transfer_one = virtio_spi_transfer_one;
+
+	/* Initialize virtqueues */
+	err = virtio_spi_find_vqs(priv);
+	if (err) {
+		dev_err(&vdev->dev, "Cannot setup virtqueues\n");
+		return err;
+	}
+
+	err = spi_register_controller(ctrl);
+	if (err) {
+		dev_err(&vdev->dev, "Cannot register controller\n");
+		goto err_return;
+	}
+
+	board_info.max_speed_hz = priv->max_freq_hz;
+	/* spi_new_device() currently does not use bus_num but better set it */
+	board_info.bus_num = (u16)ctrl->bus_num;
+
+	/* Add chip selects to controller */
+	for (csi = 0; csi < ctrl->num_chipselect; csi++) {
+		dev_dbg(&vdev->dev, "Setting up CS=%u\n", csi);
+		board_info.chip_select = csi;
+		/* TODO: Discuss setting of board_info.mode */
+		if (!(priv->mode_func_supported & VIRTIO_SPI_CS_HIGH))
+			board_info.mode = SPI_MODE_0;
+		else
+			board_info.mode = SPI_MODE_0 | SPI_CS_HIGH;
+		if (!spi_new_device(ctrl, &board_info)) {
+			dev_err(&vdev->dev, "Cannot setup device %u\n", csi);
+			spi_unregister_controller(ctrl);
+			err = -ENODEV;
+			goto err_return;
+		}
+	}
+
+	return 0;
+
+err_return:
+	vdev->config->del_vqs(vdev);
+	return err;
+}
+
+static void virtio_spi_remove(struct virtio_device *vdev)
+{
+	struct spi_controller *ctrl = dev_get_drvdata(&vdev->dev);
+
+	/* Order: 1.) unregister controller, 2.) remove virtqueue */
+	spi_unregister_controller(ctrl);
+	virtio_spi_del_vq(vdev);
+}
+
+static int virtio_spi_freeze(struct virtio_device *vdev)
+{
+	struct device *dev = &vdev->dev;
+	struct spi_controller *ctrl = dev_get_drvdata(dev);
+	int ret;
+
+	/* Stop the queue running */
+	ret = spi_controller_suspend(ctrl);
+	if (ret) {
+		dev_warn(dev, "cannot suspend controller (%d)\n", ret);
+		return ret;
+	}
+
+	virtio_spi_del_vq(vdev);
+	return 0;
+}
+
+static int virtio_spi_restore(struct virtio_device *vdev)
+{
+	struct device *dev = &vdev->dev;
+	struct spi_controller *ctrl = dev_get_drvdata(dev);
+	int ret;
+
+	ret = virtio_spi_find_vqs(vdev->priv);
+	if (ret) {
+		dev_err(dev, "problem starting vqueue (%d)\n", ret);
+		return ret;
+	}
+
+	ret = spi_controller_resume(ctrl);
+	if (ret)
+		dev_err(dev, "problem resuming controller (%d)\n", ret);
+
+	return ret;
+}
+
+static struct virtio_device_id virtio_spi_id_table[] = {
+	{ VIRTIO_ID_SPI, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+
+static struct virtio_driver virtio_spi_driver = {
+	.driver.name = KBUILD_MODNAME,
+	.driver.owner = THIS_MODULE,
+	.id_table = virtio_spi_id_table,
+	.validate = virtio_spi_validate,
+	.probe = virtio_spi_probe,
+	.remove = virtio_spi_remove,
+	.freeze = pm_sleep_ptr(virtio_spi_freeze),
+	.restore = pm_sleep_ptr(virtio_spi_restore),
+};
+
+module_virtio_driver(virtio_spi_driver);
+MODULE_DEVICE_TABLE(virtio, virtio_spi_id_table);
+
+MODULE_AUTHOR("OpenSynergy GmbH");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Virtio SPI bus driver");
-- 
2.25.1


