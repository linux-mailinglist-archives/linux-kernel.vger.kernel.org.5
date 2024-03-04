Return-Path: <linux-kernel+bounces-90869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43006870613
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38B91F2347F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA30481BA;
	Mon,  4 Mar 2024 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="rTR9ts+b"
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362B23F9E8
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709567041; cv=fail; b=Dv1qH/k51f5MG6OKqhoILodV4cqUi6TXaaZkEMSD7BphCtr+O9QH1jie7LeiGBh6/f5YhBUKRgXuTHmNU5WLZLQTL0jxdFeF4ozCPylXUz7D2ZF6pIeuMoqoxc2AE5Zaov2j+k4JiDznQjm1IZLPa+iZ2Du4oDuwKPgv7w+vTW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709567041; c=relaxed/simple;
	bh=RUCMbZXCwwGsmfFDXhCqWRcvPA0UePjvWJw35UvnYJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dE68jThUlN2/al+BpJ9LPoIMs04GBhQzCzmLyiq0MTL2EH431MwLBTdxtqUs1kx3REw8JbrhVFI2VQc50J2aQ1uA5AvDu1wYxZufJVpzChs9uVSfLEy62FJ0rSSovAUIIUyEfJedhDmiWojdOD35VGTf8AxuGYnLla3cVafdo/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=rTR9ts+b; arc=fail smtp.client-ip=18.185.115.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.191.80])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 9FE9010000064;
	Mon,  4 Mar 2024 15:43:56 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1709567036.254000
X-TM-MAIL-UUID: 1b8e373b-6521-4df1-94da-9f2bc55e59e9
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 3E41310047C4C;
	Mon,  4 Mar 2024 15:43:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuJx0ckiqZRb+dvEEpWfkxG8PE+1hQP6aRfruE8YuvazK+jUhfRFd6qg2cT3y1KQm8kTGsAZ8ZPoTClu8VfANa5AuvMHxR27KSAm2m8rSP2FSx2Dgo9CHp4cXIwLoOyBWqOuN6q3VyXeORIuqlDPqRrW7UiebhnPgmyxLMpmROQfzNYdQp6Q3ccEZFraMFM6mIZ0q2+UQrehZiUBvt1hbCtXba4a0R+/y8FoGv54++aw2ufXuxpxtanzaON58vXyPw0xm3Ntsvi41kkzrf/Z8E8HgJezAuMFGIpLmE85SJc9OzzSre6KbhcC6ww85lKa8kvnR7aTpRtMnF3OK9GMIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qehKsg2EKnD0NammV+WmhZctPF0eql/fkULcKKnm8vE=;
 b=Hil/iMp5sKB4AZ5WbgWa1JK7dGp/4V91ZHHoDjh/9bLfPP7H0BcTX+c/6lr52Zjcgxz5ODQ7VGBzXerIIoSI1qTSdMChegG+ezS+wSSwqACzawBpfKc10t6GIJPfiIBt+B4UHPY9F1WLFOGudUUoTKNj2kXrU8Lai8BT5cXLtEIWV6AkqXOHLSRbwu2zwZ5XRaZe1Hc96reSdpOB3F/AFWCHjUnpt9Of3+Zs13halDd5hmRKi6Lzq3uaB1YjP15vdef9fZuIga6uJUIqjph647NcE+HgL1JdDnyv6t9XgGboK+EozHm42/pT07WKkfNjmFwdZUd8hxrDEYy7DzwuQg==
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
Subject: [PATCH v2 2/3] virtio-spi: Add virtio-spi.h.
Date: Mon,  4 Mar 2024 16:43:41 +0100
Message-Id: <20240304154342.44021-3-Harald.Mommer@opensynergy.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304154342.44021-1-Harald.Mommer@opensynergy.com>
References: <20240304154342.44021-1-Harald.Mommer@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C6:EE_|BE1P281MB1665:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0ea1a3d7-77e9-4eb9-a510-08dc3c61e56d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xMBilczQ3KkM+xzqRYjkX91tq3K/CgJV3fKJ4NcE2DgQps8YaK/39iyB/1PZHWqEc2BpXzRiGp7ePyiPOSebBsRGNb08ZKLYmumM8cgMT4VKrZW+Fx4DctBspVW7NFVsA00X/MAnDvPcTLwQBSkxVLWCfxrMbfnt35lGe9Z73k+qg0Fr6Fd+QgpBkDt5MOJKIQCwxEjQOvYe7RJyLkn4TV3olLDPjPj72yXK9CnD8gWlsOHJ/3poqSLRAW8WS90jaGXXa+u/nzlFL8vOiQ+48OQYTGQcujdu6Mmt7mc41Ptgry6rIZABg3tjnhnOlHy5zxwxR34W6QNkifh96S/MYDtUBMJ8240jZNnHaGKSegfuEeIiNnZkDcoa4oyTmx0JinoEs3GzeT1bmYNVl4VfUPszlvh+EPg74XdA/Vq2woUKrlHdf0VkkEFrp1iQ3Hj0yHFmAMjymMIZHgsOnxLJ0X+ApCIoOASD2mbG/a+kSpA7KbR6DPBWM/AX2t7ajX4A0dC7wjzoQyMF3H/Zb5DDYmUQriWKSO5lUrYryS9ZKS6sEl4/RrJ4Ti9EQOkKSGgvuZae9w0PE8HiwFPnOo8qODmDedNi6JfP5SLUzn8fKCfbvfTxXy7J2caF3uYun60LHZ69VHGWB6MUTyoDBwh2trTgPO26AysfAPU6bzzS454UKnzoDiwclkN54XyFiQW9M878djkQhckHaGIp0ECDABTb+uDIpfaDaL34BeuDVADpV9MYcCB35ncEK/O158mf
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 15:43:53.6867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea1a3d7-77e9-4eb9-a510-08dc3c61e56d
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB1665
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28232.000
X-TMASE-Result: 10--11.476900-4.000000
X-TMASE-MatchedRID: iCFo82lRN+nJ+P2VFrJmrNbTOt1RbxD5yiAijCjuVj08Sz17UlfNnyzc
	BY1cYZWcMpPx8OFzfY3vVaXvN8Hm+HV2KXA5dledcl8xQtDJjP+NZsEXc444sAD8gVkUxyRf/ML
	WVw0m36wc/67TLVA3Nz5DuftIGbXbh7WxbHud8h0PAv5X53l32wZ56rA8tSWbYUdh2Fo9g6bm+G
	s9Q6HSkSqWIaOjeKhZVVloj1evxlf0P2k3B8GnhDxl1kIwpaZ64DiXvcLDKwtLzssSnXxLpItLm
	Ysuoy662mASxyN7woi8HPJVrIH2AQyeroDP4V8LWucEZobOeTTPaW4rD8GWjC6AUFDL7nwFSD/k
	H/Ym2jL+XkmXDmV7yzsR3s9x8aXjx10k8QqyoAyqiWyHuX1y0KODSWu0oxbK6gfKtA7YhlrtmyE
	vxwC5ZPzygRMUeOgbJpK4F9wnIiY7AFczfjr/7G7XLR36HrMtyoe6R/u46RZ7/YJ3Y50NfE8JXf
	jn3aV92kVzoXxGttY=
X-TMASE-XGENCLOUD: 2cdb8844-120b-422c-8a6e-b8cce0da194b-0-0-200-0
X-TM-Deliver-Signature: 60FC3A04E62E0EE8B8F94EC11D5234F9
X-TM-Addin-Auth: ExrGHleHdKVbsO/n+LHu0UURC954fLr/9szaF2LSgVlH0sbT5d3acaEOtEk
	zp/d1jTsu3rIMAOHdzCd7WdOeRMpc1LUfUvFqyJ8DANNaQrRGVrcQxtG6DPoIX9PppkngEWQJ8W
	49NKJYTbBPF5H2t/j1RlJT4BhnmJmZNTAzbVaGCsJ34UvubOGX+OhuE2rJxNDvFJm3ukCieWt2F
	p0614r1wEQvOc7xuG7jEEJH3aH4NZWx5jNR8IPfp3F1b33fLz3gA39r3ffq13RAV+msgLQ9OFP/
	py3gbf+8FZPVESU=.swLnvJm85bl9UBjs3vGrkFvYs7aiAff3ZkV5vBMCdU6Oz/MGAPnpLnJ5Aw
	Oxv/83ifi3P0nvcbGhr2fakFSINVJDkCW4zsUN3doOBukaa4mYxgq1QQtAg664WnEpPFKCLZSE0
	yAIQGnpFnbyQem0EC7DvdYyVTE5UZQATYLjuqpdC+2ObKV/rKSwHZiSDgSVIBPwEOqpsdO6u91k
	HKPledIj6DyHktwpKoutVKXVkJwZ8DnLxYEa7F+l8Bezbie/4arNltwO7g//TiDQdCkQ4UbWv/1
	T1DzLc7kWU4B13uY9aEROHVikMQjy2LmWob7xbURanqeQVOB02ctBM1V/eg==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1709567036;
	bh=RUCMbZXCwwGsmfFDXhCqWRcvPA0UePjvWJw35UvnYJI=; l=8276;
	h=From:To:Date;
	b=rTR9ts+baFwsmIrxSz+z89w+DoKrOJZdpB60scJoSI+3ndQzxtT1J45SnGJo3dW0X
	 FCCK93ruEly9YwqX/WbqQMhkKDoGS8l6wN6DzegAkkGoMc1joCZfWe7F+UZUQBlJ2i
	 sugKfCBwZU4SMGm1l0DiF2aV5NxxjvR5HxtCdzgh4+suFYFotuPcsdP4XIcsFumMuw
	 e6bikXStddR0w2/4OwPSUjz1ycOMmEhIDKq8fK+KIIg8m9GvzIWtz5qMbHn3zwnBKo
	 P76BKgsM2flOnbr19n2WjqhJ4bfnVnWbmMOBGzgFh456lgrn6pqv8IMkse4re7FM6R
	 QkYs/qNvUEneQ==

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
2.43.2


