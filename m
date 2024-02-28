Return-Path: <linux-kernel+bounces-85181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB1286B1B5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92BD6B25A82
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3110159589;
	Wed, 28 Feb 2024 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="bQNTke6J"
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2938314F99C
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709130500; cv=fail; b=jV77U9n8ExaXSrtUuMEOxlWAqE4+g112RO9k29ZlnGyixZkiy9BNkqJV6kPC1ELdtuuoOwGHwhg6DrGBp94aEdEfZWdejk9o6p/pasV+SZdOHogvA0biNUsPYpu4joY1LoEaHwzgkfTwpZYTrqAYg3xxhED2vh6BXD3WzKSOrQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709130500; c=relaxed/simple;
	bh=o5pnakltMFt3zPlYhNq52eRUmYEc5+2aLLunQf0dl3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QjHGqQktm7rbWA9hgnrTV9Fbd739lhEU0INn4K462fT70Uxm+uciCPQFRIiJA8eO6h9FmGl7Dyp3wSTgyffm1hQ8PV1lGFqS2D/AabIaKGYAD8wFR9gP96S/dLFQuQv++4UBtMCUc8IsME3+sTK28lCgF/EXcfeu9qrc87EWa0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=bQNTke6J; arc=fail smtp.client-ip=18.185.115.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.9.50])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 5D4331004E54B
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:28:10 +0000 (UTC)
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.192.213])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 62FAD10016AC8;
	Wed, 28 Feb 2024 14:28:03 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1709130483.016000
X-TM-MAIL-UUID: d40fd90b-a676-4ad8-9119-a6ce98161081
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 04613100003D3;
	Wed, 28 Feb 2024 14:28:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1F3EWAWvF5mlcuMM9Z2/RIsllz73BGfX73/qU1nt8DNUXq/e56BJYBVKIEe3JbF2x3LmPt4vnilQi3qzhmsbiCvayjqsX3kMIT96w3gEuoLsrCqo+4ztf2bdoMf0gAMhKSyJt+b5axDHXO9Orl135M2QpzXNAFSfO9Y8VRCc16B8nkSFeVNM8tLMl1zGGnDoYdCE9Ge/Tj1nwWcECXha9Qt5DL6Mbgp8vTENFe0rO+DZnyeBl5FoTpOfUM+LfTjBLcQlSAFu72Jo+BpQLJUhAcfTfBubpBhy+cwlC+ru8YL2i0DLqTS7Txtv5VcgqFdLweAlEhLh/K2BBxXreA81w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfCCHadleGpKiHoyE1qVPBTdPVQTCDaUuMxCw0+3VHA=;
 b=aAdMv0QDenK2SZz+n71MmLHTjnwb0uWreWWciSCFC7TlNsKWOrIdNHDcwoWLRQ/IQLpnY6XpXH/WK3J0uDMmdCFiCm1rTzZH0gO/pccFzC0Df/sdXVnXKBN8i8T+AWXs0Tnj5auQNyfKxPG6Yohlkwu+SRFAjB2wnd+MrbqOyL0ddK3m35gMiq3Uanmrxx3NrvY+E9vMXI7DFQTHqLZp/D93oo3naljDaqjWGOphzz3dFSxY31t6qSIThPQW9i4GRj0S4ls3nBfWfZnj4Dxl0BWev9W6sWBLVuVRabBDJGVeT+eM2EwHR8ujP9DLXvfS6ikRFlkKDMtLRHkkdfrrGQ==
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
Subject: [PATCH v1 2/3] virtio-spi: Add virtio-spi.h.
Date: Wed, 28 Feb 2024 15:27:54 +0100
Message-Id: <20240228142755.4061-3-Harald.Mommer@opensynergy.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A4:EE_|BE1P281MB2680:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 03695004-df64-44f6-15e5-08dc386977ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hPQELicl0KJHM5c0fBpvkjlxQhydW1Z3mL6Pvmk3kINUdXQLg1W6LKTQoY0xVLknpl4atb/uL6a3uZYtZm9EILxKkOSLTec+u3zBY7ZxiRzPUDoUSf6KycCAkdQe8pSw2pgoNBmQx59vOcq6GynQipNOfw4Rw6/Uo7ApqVOppLfLalMeO5bQUY4wvsbj/5YozdDc+Y9/ZLvKVbJ5Gx1NAfz6pnShZCbexc2gSolMEm1ZuKUvsZYMKZgvFO6f3C6HfLM5wd2hBPmWAWWBLq3ZgWJSnPBEUolgt9I2BtKh/neGMVhhT/VUa9mT6+FScL3CH1loQvA6TuqtO9C9RXvyKehoahx2cT23xYXfkrNFZjBySPnAgJ11NNB3Mi1EsFxM8XDP1xqOigHgQKExmN1KOo7VpCkPYHG1XkK3sc72Qfv0FA56klIsm07ANY0aTEwfFtJnWin71XF61JZVMtcmcTG7Q70pwLMKbcaf1pw7emD8GIy6qYwsewG1xA8F+enSXCX25vm89iL5a4+0mCkJyjskOBVdpShwCUMPEN03lgoVnQIkngbxCiTTHdRxZ/gjJC0RAqhVI1zJnRQXOZF50GRbkTEhHBNmuOpwKQcX+v1OYOUXPU3lnZI+5q6dwWsNzsv/4TMJR6eXgHTg7xNYPBh5g5IqQg5JqXmCbK5u2Xj6he2h80g2p6VwKTeU/7JgxQvgS8tV3+L/YhGvDDfOJb7+mG1z9U+fCJChKF/3QUtLFiS01rhNkiJ5QWG2tfrb
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 14:28:01.1546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03695004-df64-44f6-15e5-08dc386977ce
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2680
X-TM-AS-ERS: 104.47.7.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28218.007
X-TMASE-Result: 10--11.476900-4.000000
X-TMASE-MatchedRID: iCFo82lRN+nJ+P2VFrJmrNbTOt1RbxD5yiAijCjuVj08Sz17UlfNnyzc
	BY1cYZWcMpPx8OFzfY3vVaXvN8Hm+HV2KXA5dledcl8xQtDJjP+NZsEXc444sAD8gVkUxyRf/ML
	WVw0m36wc/67TLVA3Nz5DuftIGbXbh7WxbHud8h0PAv5X53l32wZ56rA8tSWbYUdh2Fo9g6bm+G
	s9Q6HSkSqWIaOjeKhZVVloj1evxlf0P2k3B8GnhDxl1kIwpaZ64DiXvcLDKwtLzssSnXxLpItLm
	Ysuoy662mASxyN7woi8HPJVrIH2AQyeroDP4V8LWucEZobOeTTPaW4rD8GWjC6AUFDL7nwFSD/k
	H/Ym2jL+XkmXDmV7yzsR3s9x8aXjx10k8QqyoAyqiWyHuX1y0KODSWu0oxbK6gfKtA7YhlrtmyE
	vxwC5ZPzygRMUeOgbJpK4F9wnIiY7AFczfjr/7G7XLR36HrMtyoe6R/u46RZ7/YJ3Y50NfE8JXf
	jn3aV92kVzoXxGttY=
X-TMASE-XGENCLOUD: fedd0450-47e8-4b03-a918-1b87bfe3a173-0-0-200-0
X-TM-Deliver-Signature: 857D7F3D8C4387D40CBEAADF9B9BE7AF
X-TM-Addin-Auth: zMGgZk9xRr+PfGVyTaUGsku3Fkr4lpQcWDaimzLMLnUcyJkOahnpRO9xLon
	OQMtF/sXT+sHuvYUjAEaEcBZjQHceBs86k+dGTdPzfmuxJx+pq/a4eJ9uMkViyIJxhhrQaOisop
	bwpCU8lWpJZ7lVMAGoC99qK2J2Z7z6SJuqf0RHheeWX0FLR7sQH6akmVgf1DrF2C5iWhUnHcAC+
	4tVn03kWToc4L4sJJPKskJaE51aB6Z7eN5KhVwt6xIVymcD3s1l9VFZgJWQeLnfaAzPB++JRIIj
	E3gk691fr5KVPlA=.cesp1uzlXJ+fOXbwRTFHHRlwX1nTXPXfE/e9xhE6VKMdwtT1beUJbPHaUh
	rmsl2uLzIEGcRKj6EJ+wNCw/KpZSZaahDdlWVGRnP65bN2hqzG5vsIwFKLJth2Ca6WlJw5SvzmL
	vN9VlQsVsuMZKhKjyfygC1WOX259/9jioK7L60YS0z585BqPjlu7ZjPWF84Ff7/1KMM5RjdvFM7
	2k9tz8nWv8cnQHu7aYXQuhzVdD5IEyxbJH6GW+GpKrelJuPJ29bnxjk/Cn+KtRVGVRnMCuFu04F
	YRZaKHpwg3U4KBNH5oB2rNxb5hCMlPsk2rUETxkPfEqX/V9a9gjl2Phk1XA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1709130483;
	bh=o5pnakltMFt3zPlYhNq52eRUmYEc5+2aLLunQf0dl3I=; l=8276;
	h=From:To:Date;
	b=bQNTke6JXcR90Ve7TR9hgYWcXqea8O7YJHhn+nTtZQRngS/uwXo2tQrJnQRmY7h9g
	 FSvU7JvvFKV663fW7tS+2/ggI9buo0uhyWHkGSH/KXnDwts64rl02RW0pTtfrvabMs
	 2MQLIwOxfMP2aYlJKShswRCmEHcOlmtVF7dczQu2WEnzcvJ07n4KdbHdR3nIH6YIl3
	 yZqQJYIWJAjWCWU7Q9EFKPBZhQL7krTZ+SMoELjZ0loKDq5lqAX8slWvpxpLEnX5MX
	 iXio27id8oUIQl1qo5OWd3/GMMcWQtfRIIVhBAwIuM9ekPLrdRASd8Jqwz0hyxKlVY
	 e5jxLi6MJ2S5g==

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
2.25.1


