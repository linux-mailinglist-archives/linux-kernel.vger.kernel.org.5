Return-Path: <linux-kernel+bounces-63631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C57D0853282
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24E1CB2341B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912AA57303;
	Tue, 13 Feb 2024 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="mM54R01r"
Received: from refb02.tmes.trendmicro.eu (refb02.tmes.trendmicro.eu [18.185.115.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9C256766
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832971; cv=fail; b=mFGp/D3nPujScVKxveUYWKeTne3D+KD51eERMZAAfZSY/hrDs9UANPbLsrWLv+1ML8zaSIulj+/+UtACOz78FoD6Q+/Qv4UYEljvqU8so370m3+Lw69Jed7znAJEAofqfMG2PZjL9U3+AyWXK//NYa7mFyXOK6IZEeB4cKvn1Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832971; c=relaxed/simple;
	bh=MMLTwLsBLQiCFddV9MgXxO9XOUi+73eqcpU1Jv2B2JQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KpRsbRKi3e+PGUM8VhrzGsbLzfp4o/pffIpBCY/XNPMK3odfwquc8FprekS5aUkka4bOIQdFsiECLELFx6OAob5xPmSxX+NRt8Nk/jvw/Iw5zRBb1YANG4R3of6HLfYI+QEbVMMqXF6U0HUop0fKTq72wI8PKHbQH/wYs+80qNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=mM54R01r; arc=fail smtp.client-ip=18.185.115.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.19.34])
	by refb02.tmes.trendmicro.eu (Postfix) with ESMTPS id 5511E100571FE
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:54:10 +0000 (UTC)
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.165.80])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id AA350100017AB;
	Tue, 13 Feb 2024 13:54:02 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1707832442.354000
X-TM-MAIL-UUID: 696aa899-9606-4642-97bc-e6a4c39a0a81
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 56A7610001510;
	Tue, 13 Feb 2024 13:54:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVA6SotB1SSABkji0F+ZfFqXUByKraj0OkThvFuk6Dy52Ivt7kCrmSxIDF5UQplJyoSCOyismvt6sTXpAieEcubPd6V/q8PS48Z6mk/IMS06zLQYHs/fMzTgEPcdfqGckmM/l7ui5ju7aLoMr3aX5Uer4bgW1r6ZBlAkCqaQRLiUqqUJFd8AxYwTcJW5O7T1L+hc7uiAGLHRdvm0waapGY6DnYDo2LEYNHX9c4N3vME73Tam4eRqRwVlWBZQOJlcQFXLo/GRwUcO4k9r7QxzKbePTbD5jE2BzGxafavp5bOdLvaVDfjwal/VzM7rp+8A+cPywWm6q6l6hdi7AvC/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAalIBvrAAKRw96Ri2LCsjVCwboEE7CoSzmcW9TPGJ8=;
 b=WtH2XEdhet0qhGEURPxZFPEpToMk397oM6CxRUWwsjyZYf4IWT4lVnH0QavFUHYERagZp91+ri+JSeQHnYvms0arNftUSEU4JUzpVVhhip54yeqRTTwaDOUpr/IHrvyOi2qsb3k/GuLEj1Unse1CS8dXI7uTKBdL1hYMq7B7toMMKVBsO+tbJOqeJnQ09n4AsfNq1vcFfcUBj4ttMQfNmWJIEL+b681GKA8HusdKscuqnihlhUyvukeOZPVLsClQlI9FBDwpRAPnFfpqlh+chujxvw4R+5HsKD0WtdewdTh9jkJM0bQSvlRDNWG91/A25H43hFHw/8CnzS+VIAmeCg==
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
	Harald Mommer <harald.mommer@opensynergy.com>
Subject: [RFC PATCH v3 2/3] virtio-spi: Add virtio-spi.h.
Date: Tue, 13 Feb 2024 14:53:49 +0100
Message-Id: <20240213135350.5878-3-Harald.Mommer@opensynergy.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA0:EE_|FRYP281MB0301:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 37d0b7db-dcf8-4e3d-0de2-08dc2c9b3a8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o4go5xaC9tzJl6c1MpetCXQ5t6a4CWRwWZKIP0RokDkAwI0y/BGQc0S1y/dZ7bCQL/US3/Wk42MZc3s5TNaHulucUxHvnyB0JAjp1rf8SyuXiJRd7xGwSeoj3Jn2xwENIBMAILdWaEr9Ct7Kfvr2UdzB85p0TuhtxA7Lcl+GvOoYc+8oEPEGgn5CxsyHSKzUvPA8HOPl40K9SVujO4Vn1F2tDVaTexg/pkykRfA3TnZ0EWqUEdY9qxH5W2Yh4mbtXwa93/bl1sagJZKaYCPU5tk4pX9mThM1iiym/wAX90/GIPdmzhBWIzTD456DEchiH11Ss9L3sFy4g71LCFfxsMAcCmlWo9yclyFzSXeVB24V5shBWn0CmjiOqnKYqef1AdNkS/sFlHCTKdR0+0ffpmv05knXgFkLXtbf96mvQUCQDQyTqX1jiJNOTRkiWV2Sp9WikrEAcQcfzWD/VReEJIHnPjU+raDTBVXEbj0H/+7rf5HYBE7EmaneKDZH9V1mYe6HI37MC6E077p6rK6mXJEzcRMsHKWkHGmqM9jU9/d5aFegeHbKeHkeRMg+kb+rf/pgb7gESZaR0HVaEf3UjFkjTNA4xnASf5D8+PdvbsM=
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(39840400004)(396003)(376002)(346002)(136003)(230922051799003)(82310400011)(186009)(451199024)(1800799012)(64100799003)(46966006)(36840700001)(5660300002)(2906002)(26005)(36756003)(2616005)(83380400001)(1076003)(107886003)(41300700001)(478600001)(81166007)(336012)(86362001)(70586007)(70206006)(8676002)(8936002)(4326008)(42186006)(110136005)(54906003)(316002);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 13:53:59.2796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d0b7db-dcf8-4e3d-0de2-08dc2c9b3a8c
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB0301
X-TM-AS-ERS: 104.47.7.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28190.000
X-TMASE-Result: 10--11.476900-4.000000
X-TMASE-MatchedRID: iCFo82lRN+nJ+P2VFrJmrNbTOt1RbxD5yiAijCjuVj08Sz17UlfNnyzc
	BY1cYZWcMpPx8OFzfY3vVaXvN8Hm+HV2KXA5dledcl8xQtDJjP+NZsEXc444sAD8gVkUxyRf/ML
	WVw0m36wc/67TLVA3Nz5DuftIGbXbh7WxbHud8h0PAv5X53l32wZ56rA8tSWbYUdh2Fo9g6bm+G
	s9Q6HSkSqWIaOjeKhZVVloj1evxlf0P2k3B8GnhDxl1kIwpaZ64DiXvcLDKwtLzssSnXxLpItLm
	Ysuoy662mASxyN7woi8HPJVrIH2AQyeroDP4V8LWucEZobOeTTPaW4rD8GWjC6AUFDL7nwFSD/k
	H/Ym2jL+XkmXDmV7yzsR3s9x8aXjx10k8QqyoAyqiWyHuX1y0KODSWu0oxbK6gfKtA7YhlrtmyE
	vxwC5ZPzygRMUeOgbJpK4F9wnIiY7AFczfjr/7G7XLR36HrMtyoe6R/u46RZ7/YJ3Y50NfE8JXf
	jn3aV92kVzoXxGttY=
X-TMASE-XGENCLOUD: 342d10dc-2266-4787-8fd7-d701dfa0e6ae-0-0-200-0
X-TM-Deliver-Signature: 0FFB2234FE11B38C47A96705044378CD
X-TM-Addin-Auth: dOwmgcZM2KrBuxIvr52KJq2h7SBovK/hce0STLRi3uAfboDTYipv3Y8T+YD
	9l0lQZcno9CFdumG7FLg4uWKPv4VAiCbVeUkI4gVzzyhCHhOdfXpJWDZPDjw6Y8ju+KPs1G2wJ9
	O1/uRZ+fkVhS0CquwdrlCKbrJc5/X8Ozj0pG1yMLXlrjlgUayss+l7RESuG2uGnhSpmOYFKVBn/
	4mQJSTRAt51iz0wgl8p5/eUxCFHvl2mTaP13ZUCTlSd9ToEsuRgSp2mCm45g+eBM0LtABAk0kkx
	hpnkXbjF5e9dvtU=.G5k4c+iuE/vyrT0weKv5xOg6T1pyT7qCGt4BygoSI7rhvfmH3K/H7sUYUr
	dJZXNejyTHdllq7CKR999cYJqbMA9DEewe+8Qp0vKKDqUecI9L5MMAkXn2/Vm995yo3CHhYheKY
	snIL/bc9cQWtf6RXiExqA9aD/oWi7qxvc9FW+wSHWUCkR3BcGrP1sX2zb2gKG965yEJD46oT8rg
	MW0q4gbgL7PzVmPgnbG+AXzQ7vO+mAfNDiMEGdurWJcRr36tW0SLXfNSCWPJ9WqzVMVPlgxIPon
	8MzyzL9BFqDuEXsQJr+217U+dJFtSIBpRSgh0tiBPhu2yf9iG22F6RBVi1Q==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1707832442;
	bh=MMLTwLsBLQiCFddV9MgXxO9XOUi+73eqcpU1Jv2B2JQ=; l=8276;
	h=From:To:Date;
	b=mM54R01rurcV5DB1boj6XDajVMatCKlkjfFKhw+LWKdB+tV4MOOlBukFEMgG0G1v4
	 ZIPHfN0AZxfRh7niT+ale03H/AibuVhtzo2l57m7g/CSwk0Krt7wWjRSy26T4d0Yad
	 hLcC8WCKb27U1iF7l9VOjJ2n4xRgzlVkK1H9a9tPbJ34HuRJwsHZnNsNXb4migOcYL
	 wHE0DXwX/dcqELbjmicMKc9/j+qfHjbUkbpXcof20l0iWN21MoSOte/QENyPTe3MnA
	 3wx4OWcZbNG+RQfsGW3olZ+f2JnS7sgVJ21tETNqdZgcQpj3NXXQf9jBxG/hUdlf1d
	 q9BDosuJrEokg==

From: Harald Mommer <harald.mommer@opensynergy.com>

Add virtio-spi.h header for virtio SPI.

Signed-off-by: Harald Mommer <harald.mommer@opensynergy.com>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/uapi/linux/virtio_spi.h | 185 ++++++++++++++++++++++++++++++++
 1 file changed, 185 insertions(+)
 create mode 100644 include/uapi/linux/virtio_spi.h

diff --git a/include/uapi/linux/virtio_spi.h b/include/uapi/linux/virtio_spi.h
new file mode 100644
index 000000000000..d6923f4080b4
--- /dev/null
+++ b/include/uapi/linux/virtio_spi.h
@@ -0,0 +1,185 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Copyright (C) 2023 OpenSynergy GmbH
+ */
+#ifndef _LINUX_VIRTIO_VIRTIO_SPI_H
+#define _LINUX_VIRTIO_VIRTIO_SPI_H
+
+#include <linux/types.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_ids.h>
+#include <linux/virtio_types.h>
+
+/* Sample data on trailing clock edge */
+#define VIRTIO_SPI_CPHA (1 << 0)
+/* Clock is high when IDLE */
+#define VIRTIO_SPI_CPOL (1 << 1)
+/* Chip Select is active high */
+#define VIRTIO_SPI_CS_HIGH (1 << 2)
+/* Transmit LSB first */
+#define VIRTIO_SPI_MODE_LSB_FIRST (1 << 3)
+/* Loopback mode */
+#define VIRTIO_SPI_MODE_LOOP (1 << 4)
+
+/*
+ * All config fields are read-only for the Virtio SPI driver
+ *
+ * @cs_max_number: maximum number of chipselect the host SPI controller
+ *   supports.
+ * @cs_change_supported: indicates if the host SPI controller supports to toggle
+ * chipselect after each transfer in one message:
+ *   0: unsupported, chipselect will be kept in active state throughout the
+ *      message transaction;
+ *   1: supported.
+ *   Note: Message here contains a sequence of SPI transfers.
+ * @tx_nbits_supported: indicates the supported number of bit for writing:
+ *   bit 0: DUAL (2-bit transfer), 1 for supported
+ *   bit 1: QUAD (4-bit transfer), 1 for supported
+ *   bit 2: OCTAL (8-bit transfer), 1 for supported
+ *   other bits are reserved as 0, 1-bit transfer is always supported.
+ * @rx_nbits_supported: indicates the supported number of bit for reading:
+ *   bit 0: DUAL (2-bit transfer), 1 for supported
+ *   bit 1: QUAD (4-bit transfer), 1 for supported
+ *   bit 2: OCTAL (8-bit transfer), 1 for supported
+ *   other bits are reserved as 0, 1-bit transfer is always supported.
+ * @bits_per_word_mask: mask indicating which values of bits_per_word are
+ *   supported. If not set, no limitation for bits_per_word.
+ * @mode_func_supported: indicates the following features are supported or not:
+ *   bit 0-1: CPHA feature
+ *     0b00: invalid, should support as least one CPHA setting
+ *     0b01: supports CPHA=0 only
+ *     0b10: supports CPHA=1 only
+ *     0b11: supports CPHA=0 and CPHA=1.
+ *   bit 2-3: CPOL feature
+ *     0b00: invalid, should support as least one CPOL setting
+ *     0b01: supports CPOL=0 only
+ *     0b10: supports CPOL=1 only
+ *     0b11: supports CPOL=0 and CPOL=1.
+ *   bit 4: chipselect active high feature, 0 for unsupported and 1 for
+ *     supported, chipselect active low should always be supported.
+ *   bit 5: LSB first feature, 0 for unsupported and 1 for supported,
+ *     MSB first should always be supported.
+ *   bit 6: loopback mode feature, 0 for unsupported and 1 for supported,
+ *     normal mode should always be supported.
+ * @max_freq_hz: the maximum clock rate supported in Hz unit, 0 means no
+ *   limitation for transfer speed.
+ * @max_word_delay_ns: the maximum word delay supported in ns unit,
+ *   0 means word delay feature is unsupported.
+ *   Note: Just as one message contains a sequence of transfers,
+ *         one transfer may contain a sequence of words.
+ * @max_cs_setup_ns: the maximum delay supported after chipselect is asserted,
+ *   in ns unit, 0 means delay is not supported to introduce after chipselect is
+ *   asserted.
+ * @max_cs_hold_ns: the maximum delay supported before chipselect is deasserted,
+ *   in ns unit, 0 means delay is not supported to introduce before chipselect
+ *   is deasserted.
+ * @max_cs_incative_ns: maximum delay supported after chipselect is deasserted,
+ *   in ns unit, 0 means delay is not supported to introduce after chipselect is
+ *   deasserted.
+ */
+struct virtio_spi_config {
+	/* # of /dev/spidev<bus_num>.CS with CS=0..chip_select_max_number -1 */
+	__u8 cs_max_number;
+	__u8 cs_change_supported;
+#define VIRTIO_SPI_RX_TX_SUPPORT_DUAL (1 << 0)
+#define VIRTIO_SPI_RX_TX_SUPPORT_QUAD (1 << 1)
+#define VIRTIO_SPI_RX_TX_SUPPORT_OCTAL (1 << 2)
+	__u8 tx_nbits_supported;
+	__u8 rx_nbits_supported;
+	__le32 bits_per_word_mask;
+#define VIRTIO_SPI_MF_SUPPORT_CPHA_0 (1 << 0)
+#define VIRTIO_SPI_MF_SUPPORT_CPHA_1 (1 << 1)
+#define VIRTIO_SPI_MF_SUPPORT_CPOL_0 (1 << 2)
+#define VIRTIO_SPI_MF_SUPPORT_CPOL_1 (1 << 3)
+#define VIRTIO_SPI_MF_SUPPORT_CS_HIGH (1 << 4)
+#define VIRTIO_SPI_MF_SUPPORT_LSB_FIRST (1 << 5)
+#define VIRTIO_SPI_MF_SUPPORT_LOOPBACK (1 << 6)
+	__le32 mode_func_supported;
+	__le32 max_freq_hz;
+	__le32 max_word_delay_ns;
+	__le32 max_cs_setup_ns;
+	__le32 max_cs_hold_ns;
+	__le32 max_cs_inactive_ns;
+};
+
+/*
+ * @chip_select_id: chipselect index the SPI transfer used.
+ *
+ * @bits_per_word: the number of bits in each SPI transfer word.
+ *
+ * @cs_change: whether to deselect device after finishing this transfer
+ *     before starting the next transfer, 0 means cs keep asserted and
+ *     1 means cs deasserted then asserted again.
+ *
+ * @tx_nbits: bus width for write transfer.
+ *     0,1: bus width is 1, also known as SINGLE
+ *     2  : bus width is 2, also known as DUAL
+ *     4  : bus width is 4, also known as QUAD
+ *     8  : bus width is 8, also known as OCTAL
+ *     other values are invalid.
+ *
+ * @rx_nbits: bus width for read transfer.
+ *     0,1: bus width is 1, also known as SINGLE
+ *     2  : bus width is 2, also known as DUAL
+ *     4  : bus width is 4, also known as QUAD
+ *     8  : bus width is 8, also known as OCTAL
+ *     other values are invalid.
+ *
+ * @reserved: for future use.
+ *
+ * @mode: SPI transfer mode.
+ *     bit 0: CPHA, determines the timing (i.e. phase) of the data
+ *         bits relative to the clock pulses.For CPHA=0, the
+ *         "out" side changes the data on the trailing edge of the
+ *         preceding clock cycle, while the "in" side captures the data
+ *         on (or shortly after) the leading edge of the clock cycle.
+ *         For CPHA=1, the "out" side changes the data on the leading
+ *         edge of the current clock cycle, while the "in" side
+ *         captures the data on (or shortly after) the trailing edge of
+ *         the clock cycle.
+ *     bit 1: CPOL, determines the polarity of the clock. CPOL=0 is a
+ *         clock which idles at 0, and each cycle consists of a pulse
+ *         of 1. CPOL=1 is a clock which idles at 1, and each cycle
+ *         consists of a pulse of 0.
+ *     bit 2: CS_HIGH, if 1, chip select active high, else active low.
+ *     bit 3: LSB_FIRST, determines per-word bits-on-wire, if 0, MSB
+ *         first, else LSB first.
+ *     bit 4: LOOP, loopback mode.
+ *
+ * @freq: the transfer speed in Hz.
+ *
+ * @word_delay_ns: delay to be inserted between consecutive words of a
+ *     transfer, in ns unit.
+ *
+ * @cs_setup_ns: delay to be introduced after CS is asserted, in ns
+ *     unit.
+ *
+ * @cs_delay_hold_ns: delay to be introduced before CS is deasserted
+ *     for each transfer, in ns unit.
+ *
+ * @cs_change_delay_inactive_ns: delay to be introduced after CS is
+ *     deasserted and before next asserted, in ns unit.
+ */
+struct spi_transfer_head {
+	__u8 chip_select_id;
+	__u8 bits_per_word;
+	__u8 cs_change;
+	__u8 tx_nbits;
+	__u8 rx_nbits;
+	__u8 reserved[3];
+	__le32 mode;
+	__le32 freq;
+	__le32 word_delay_ns;
+	__le32 cs_setup_ns;
+	__le32 cs_delay_hold_ns;
+	__le32 cs_change_delay_inactive_ns;
+};
+
+struct spi_transfer_result {
+#define VIRTIO_SPI_TRANS_OK 0
+#define VIRTIO_SPI_PARAM_ERR 1
+#define VIRTIO_SPI_TRANS_ERR 2
+	u8 result;
+};
+
+#endif /* #ifndef _LINUX_VIRTIO_VIRTIO_SPI_H */
-- 
2.43.0


