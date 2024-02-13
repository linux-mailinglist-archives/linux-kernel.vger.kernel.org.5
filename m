Return-Path: <linux-kernel+bounces-63632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4582B853283
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5C91C2281A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51B95733B;
	Tue, 13 Feb 2024 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="vKS3uaI7"
Received: from refb02.tmes.trendmicro.eu (refb02.tmes.trendmicro.eu [18.185.115.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1FE56769
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832973; cv=fail; b=Agjp4F+h+NtEPRcNAZFvMMqDAMosoLBVjWSqhv/9Bp7ngBKCBoHCjuMpb+l3PhzFgsw4n9Cd2UhAjiaCN/fQ/jVKin+/Fre+fxayz9vgMD4hluFRXK+g/FIPEGYc234mB3mO8wvsRjqR8Gq9ykMy2I0zQlmTsvgcQHzRs6AMv+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832973; c=relaxed/simple;
	bh=wkyN0bavj1OWNJTpKAH4bQrs60NepAw2FdH1VpTV9pc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oBf83qhblf/lzW/58ianWbyrVoGWjZp4dUv8BDb0UPP71kZaCqC3sU7XhMN3SoLtQ5IJRiOu4NcjPJLE+udk5NQd6O+YnE4aO256tA+DIE1+g7YwiDChEclWIDxc08tnhB2KdueEbh+klc22DZPpVHUeL62d6AaU5I054Zg9o1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=vKS3uaI7; arc=fail smtp.client-ip=18.185.115.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.19.202])
	by refb02.tmes.trendmicro.eu (Postfix) with ESMTPS id 54D71100571F0
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:54:10 +0000 (UTC)
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.199.136])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id C1A9C10000B8F;
	Tue, 13 Feb 2024 13:54:02 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1707832442.138000
X-TM-MAIL-UUID: 46a31541-2a2c-47c1-9e80-027994baf0b5
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 21F0010045DED;
	Tue, 13 Feb 2024 13:54:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gne+aegbVz+cEqwcymZ7XooabqIx1x22UWiXxKHozVqeLTD4C/vZn/knF01xHRAOTb+OAXY1QpuSnf1L11TfdENuY7mieElHrybntABBBtwkB8MMHQenjOhx/bL1h/4peWXL1+eEsSnb39G0LfW6mHWw3qJlGmFVcu4QtutZLhtarjZuh6bQ4HQkknPlll8Z8uhIlw4pZSP5W5dqZte1UCIbalr+1fcf/nDQ3J0TKULBJHhewB+JlTeEkTUczN2HuoGkP4kvXo9GbXlVcEW9q1Ans1AZAnYkbOvRdzOMB89nnT1//gpvy/ZODZ/PN7Gr8o398Dn+t7BsKwHPvZgjtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRvuHXUDPg97iD1UvOLNnDEdi6Ub1+PpVJNGi5i/hl4=;
 b=Aww9uD6AyvoGUttlTfZFuxljUaSHRytyM2frDfz9xvcfFNyBrBaYEMWU7M+iOQDvxRCN/ZvWrHIk+JkoEuU5qUqxDnmSeN+EF51Y7jtBd6VQQ/NYmWULbY3OXlwwt5Pn6PONMBJ6zT3YaUtEcf0AIKkxD8Oc/maETanpnMdIm4vD7wd6tobUFeC6mKmRSTPCYrqlYWltkX5iEhhrHrop3m9nKIjmLkNxOg+kjQxnuCZ4ccLRXgycAwfX0saioAUHakgVixnbJVuKKrWoYUL7POWnObwj1zLyP551izoqVxZ2E9c2r7OokAtQxlY7MxlrNo3bHHTz3G98kh8h3WlXvw==
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
Subject: [RFC PATCH v3 3/3] SPI: Add virtio SPI driver.
Date: Tue, 13 Feb 2024 14:53:50 +0100
Message-Id: <20240213135350.5878-4-Harald.Mommer@opensynergy.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240213135350.5878-1-Harald.Mommer@opensynergy.com>
References: <20240213135350.5878-1-Harald.Mommer@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B6:EE_|BEUP281MB3619:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7d455834-1353-4715-85e6-08dc2c9b3a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TmBwGBBCzSnAOe7MaElIP8xiFvMcK4o5nqX+RdUqDwP0//bbASmTMn4EZR2ww182DQqnQBN+YRrIzpJ0V/WTmhbWhEAU6CxuqbjlGSuXbAkJMSfiv7HVPOuetptELkK6cAt7Ef4PCTl8tvi2znvweri6InvHOUzchbUJWbaLZcauVdIGiNDceh4YTDm/jys1k/HSd2PAvanjWlNPeVKXDnQVhLpfeZ2d1qk9Ve5ggWq5l/Uyw3fHX5XOQK7b7suf+msL3EgfwKfLjpsR/30Lp1eFWSfkHvR9IANsUDlu+LppBOile6RHK/7HKMPqcIysthbzU1QbZ+WU6Nanp4wd82J8yTrbY/bGj5hKlPqpyeyCemo/IcprpjHoOlPNHCl407qiWb1rQkickO4urUiXZZP/2JXVusrPPrlO9w6cmJgsggJwPGizbC472czijn0pY82gS7EEZu4qK2GgorRW2Tri/Ae+GWyLHvirneHuGj+Pl+kRd3tlZhG5Kt+vaYpWwUSYNKdehVGOvcsVw1/5NYdEnbvXBtLTNYikCvAjWgAjBqJZpYVtorJgkhR9vQreaxOFCpprez/uLrZ7vGMcMg==
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(346002)(39840400004)(376002)(136003)(396003)(230922051799003)(82310400011)(1800799012)(186009)(64100799003)(451199024)(46966006)(36840700001)(5660300002)(30864003)(8936002)(8676002)(2906002)(4326008)(70206006)(81166007)(336012)(83380400001)(26005)(2616005)(107886003)(36756003)(86362001)(1076003)(110136005)(54906003)(70586007)(316002)(42186006)(478600001)(966005)(41300700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 13:53:59.2802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d455834-1353-4715-85e6-08dc2c9b3a8e
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEUP281MB3619
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28190.000
X-TMASE-Result: 10--15.613200-4.000000
X-TMASE-MatchedRID: MJVoq7xhPdwAsgl6PZgqJJIdC0Q5JDAcyiAijCjuVj1rIVA3IGfCC6DE
	DQa+uiKUQpP6/vBOuJOlW+Td8jdY4qzXlgZwZIcECiqhjJdax2wcmAT4Y18od5GeN+9dVIq356v
	0NFZuss0RwDRaF62aWYjjuLUZBvudsAlcI2jPyDJOt04VVWpqKdZEjr6xrP/hVV0tOmM6MuVI3M
	5iABIg/kcD/txLcp4xKvaHFeFLctIt7jkgkQPLkDj8DyU/gPmig7bJEu21E12KGqfvdmN8aM8SS
	yAROkr3YvK2zELHFAVPtfvKBHCqm39gIn+mT2gpaqTPZHEzWB5wAwiTYnDIhOaq2+8i+oCV7odP
	l3EMwgiKPCSsR9yX8OQZ0yQK80NUk/dA6P3T5Fup4lnMsTvchY4eLDiNVLeb8Yq7KCpNJN8Br6z
	SVbVmpMNNg2m9+XlMMhf2mvgSdBqqOBtFSnX9XyE8raaf46xMa2iy+hqfVDyW56JO955kYAt0mx
	H7LqIv/3CGExHfLH6+9RoWVmscxhw7WCutUIokFm7cDHk2CrwpSViUCNYhMOK9fjqiORFcAZjsJ
	4RGp+vg4EHeQQT63IIqHp23KYvDBYIaQ0ASMyrHfnPG7+BDZvpS9zfbt9q/YHpd3n3SbeYMwqLs
	3yWGdt9cNTZyIRQyldYeoo7G9XitAMlP4gRdFnx2eIlQG1sMfC4IwOLvyuf/oGTNGh63f1YU7Lx
	eiw6GWa6vTkKxwrI7AFczfjr/7DxTbZHSg/7hXpv5oMxQHsoN9KaC2QHRZa3yW6WZM7Jy2kVzoX
	xGttY=
X-TMASE-XGENCLOUD: 55e136aa-4a06-4b17-9207-5553844ae640-0-0-200-0
X-TM-Deliver-Signature: A046DC272E850D6743516E1653ECA22F
X-TM-Addin-Auth: U9stqznax8oyfYwZ+eLJ5q4uZdxbRSDDB7o7kji/mj3pAqC/bhorZyRZmKy
	Br/gnlzktkYHGv43rpfkkCxs+7iVRENxjA7QD956Av6c2RvnACmuWEG9J5TOmpHAgyYOChMwuBy
	8rBm6V1JjgezuKxaIhpY1VXtorNtkcx+pS3A0p1oX0S+UQ14eysIkRwZ9lHy1WtWCi8LbDcEBFz
	e0D0cFf+9ZonQTZvRsgaJz+QL1c0XWc0aw12fQdL+HeCADUdyjJA0jyy18PhuvvKh34F5Ol/S7A
	ydgp5gy5jbP2Q/E=.d4Xw4w/L9durLueMuikYfln2jDUxMUzG9ALYzYNwZbB+IxGs7e3yxyssrv
	/9U/R+H1RQtZc8T4/kQ56HIvSz0PrBfKxpF2AR3g7+WJzi+YaQKNI/DCgUy8/9Eg7THSrXJVoz8
	5RaI8+0qWAwBjdkhtClde/shNrv5QfhnP1jHWGqplqPxtdRDf+QfwSNJBncCLDJywsHmOFwbjtZ
	kRPXe7L3TSUrG6IG8oHtQSYtvGzYTE/U2dOKOLXdCYS4NjUBdn/zjOTNJhcDjiQt3dTTsUHHJtp
	/EYW0SvQSHuN7l9kEwJ7QBV6tnfOkueZXxXkPvzkoc4mbfrxH1Q541t4+cg==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1707832442;
	bh=wkyN0bavj1OWNJTpKAH4bQrs60NepAw2FdH1VpTV9pc=; l=15657;
	h=From:To:Date;
	b=vKS3uaI7PIexBOvq01wVJd8afhjkm1e2HkARVU9lWWAZfJ6NNb+tSVA9bULWlKrv/
	 ykk7Vm7Pruz0TkhNt3jW7PKiNsa2yjXqctalzB4wnOkLC9dkMku8ZGebDYk+om/uop
	 fwPaVl5RhVevI9k3sm49/T+EopmppnX8P2ZfQ/fodII3eBVHtpU6OWNP3T+ZJOBhS9
	 LF2P48l+jo1Tl+qJ8/b5dIPxbed4StaOJTCWrPyp3yVWBdxzcsNphXQyU/ckBhgBFh
	 GDVEspETCUQDW7GPnK4TZvrodEF5N/uHp1lUI/JZtxJG/Y5GLn4q3o6WGQ8iGwee8u
	 vUvcLC6n+rp3g==

From: Harald Mommer <harald.mommer@opensynergy.com>

This is the virtio SPI Linux kernel driver.

Signed-off-by: Harald Mommer <Harald.Mommer@opensynergy.com>
---
 drivers/spi/Kconfig      |  11 +
 drivers/spi/Makefile     |   1 +
 drivers/spi/spi-virtio.c | 475 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 487 insertions(+)
 create mode 100644 drivers/spi/spi-virtio.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index bc7021da2fe9..0b5cd4c1f06b 100644
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
index 000000000000..700cb36e815f
--- /dev/null
+++ b/drivers/spi/spi-virtio.c
@@ -0,0 +1,475 @@
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
+/* virtio_spi private data structure */
+struct virtio_spi_priv {
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
+struct virtio_spi_req {
+	struct completion completion;
+	struct spi_transfer_head transfer_head	____cacheline_aligned;
+	const uint8_t *tx_buf			____cacheline_aligned;
+	uint8_t *rx_buf				____cacheline_aligned;
+	struct spi_transfer_result result	____cacheline_aligned;
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
+ * See also
+ * https://lore.kernel.org/all/6171c1c3-55ba-4f74-ae60-764820cf1caf@quicinc.com
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
+	th->cs_change_delay_inactive_ns = cpu_to_le32((u32)cs_inactive +
+						      (u32)cs_change_delay);
+
+	return 0;
+}
+
+static int virtio_spi_one_transfer(struct virtio_spi_req *spi_req,
+				   struct spi_controller *ctrl,
+				   struct spi_message *msg,
+				   struct spi_transfer *xfer)
+{
+	struct virtio_spi_priv *priv = spi_controller_get_devdata(ctrl);
+	struct spi_device *spi = msg->spi;
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
+	/*
+	 * Got comment: "The virtio spec for cs_change is *not* what the Linux
+	 * cs_change field does, this will not do the right thing."
+	 * TODO: Understand/discuss this, still unclear what may be wrong here
+	 */
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
+	if (virtio_spi_set_delays(th, spi, xfer))
+		goto msg_done;
+
+	/* Set buffers */
+	spi_req->tx_buf = xfer->tx_buf;
+	spi_req->rx_buf = xfer->rx_buf;
+
+	/* Prepare sending of virtio message */
+	init_completion(&spi_req->completion);
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
+		sgs[outcnt + incnt] = &sg_in_payload;
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
+
+msg_done:
+	if (ret)
+		msg->status = ret;
+
+	return ret;
+}
+
+static int virtio_spi_transfer_one_message(struct spi_controller *ctrl,
+					   struct spi_message *msg)
+{
+	struct virtio_spi_priv *priv = spi_controller_get_devdata(ctrl);
+	struct virtio_spi_req *spi_req;
+	struct spi_transfer *xfer;
+	int ret = 0;
+
+	spi_req = kzalloc(sizeof(*spi_req), GFP_KERNEL);
+	if (!spi_req) {
+		ret = -ENOMEM;
+		goto no_mem;
+	}
+
+	/*
+	 * Simple implementation: Process message by message and wait for each
+	 * message to be completed by the device side.
+	 */
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		ret = virtio_spi_one_transfer(spi_req, ctrl, msg, xfer);
+		if (ret)
+			goto msg_done;
+
+		virtqueue_kick(priv->vq);
+
+		wait_for_completion(&spi_req->completion);
+
+		/* Read result from message */
+		ret = (int)spi_req->result.result;
+		if (ret)
+			goto msg_done;
+	}
+
+msg_done:
+	kfree(spi_req);
+no_mem:
+	msg->status = ret;
+	spi_finalize_current_message(ctrl);
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
+	err = of_property_read_u32(np, "spi,bus-num", &bus_num);
+	if (!err && bus_num <= S16_MAX)
+		ctrl->bus_num = (s16)bus_num;
+
+	virtio_spi_read_config(vdev);
+
+	/* Method to transfer a single SPI message */
+	ctrl->transfer_one_message = virtio_spi_transfer_one_message;
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
2.43.0


