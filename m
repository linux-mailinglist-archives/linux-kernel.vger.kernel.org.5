Return-Path: <linux-kernel+bounces-118914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD4588C11A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747381F3C2BA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DEC5A0FC;
	Tue, 26 Mar 2024 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="qrXB22xJ"
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD514E1CC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453591; cv=fail; b=C/8WiYjrd2Qu8qSY/8Cp74GxtCkJ6KJVMy2PuoRNJLQyZULk3V7JTZTqII72+oIzWhy2tP9vY1SygZTF06REYbWxfE0WV0LqZzYI1vUBVCFgjznPO6mcmDpwM214ff53cDIJfkAlZX73J47/HAlAkuHjxdIqR79/TA/iZvVtXYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453591; c=relaxed/simple;
	bh=RUCMbZXCwwGsmfFDXhCqWRcvPA0UePjvWJw35UvnYJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XwIYiGdXRkbQgD/SZzsl27+8Lp8FU+iOBGQo/KJrG2PvAK65O3Y913kWVgMHi22YXGkU/6THoaTc+770heiHYggUpXOaTXDMhlB7O23EgO8dr8XpaO9Ed1PJSb3kMvhxMllyyw3ogYMRy9dX5UH9Jc8SaWywIPbVuC0bH41ThTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=qrXB22xJ; arc=fail smtp.client-ip=18.185.115.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.19.160])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id DF0A21005551B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:28:30 +0000 (UTC)
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.197.65])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 5B3791000135B;
	Tue, 26 Mar 2024 11:28:23 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1711452502.906000
X-TM-MAIL-UUID: 800889e0-d4f2-4fc9-94a7-ec310aebe0b6
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id DD6E31000286B;
	Tue, 26 Mar 2024 11:28:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ei77m5iFljxkNMJrFBvET62xG2acoem7bmsPxBWIGfyQOnGKdMxpwdUrtAACZV9NTl14oZzLg6AvlWNpVK74SgSZDI7/W3yCgWfqc71YjVZf7GIK1h1cWVa+Rjug8biZnSHpWSLV5dDNq3pHJkOSFrUv9HUrVWXlwSGVhzVYrRIFXI66n2ffh1LZ453rmRjGUmf3/+CDNw3fkrOQBaiOyVRApigbgMD184yCUScC6/1QXR144Y9UIt60xCC1EB9TA4lRX5TUVE+syP02pU8FAfKdYOI54sBfTEgNqKWf6hiEmsBnuP/Ey6ytvj9Zas/FPcbCvQoRrp0r1ZT4WJ4IBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qehKsg2EKnD0NammV+WmhZctPF0eql/fkULcKKnm8vE=;
 b=f30SF+FFuTb1CuTYltc4tMSQBGI4OOQmnBGJD5z3zslTgDv9l52AYa0+4ap+1aP0PtEvex/hux0hvFaaE+QdWWnNJe4YEh/jG7BB1QUaxRJxgeiBUZBrDst4ry6KnH6cKnu44RZxHQjwvDIDjZ/Tquijh9fkR22n95Sva31YHRP+dJCbz20vu3KO91+PUoWvN166cKhYgUHhwKn5GA3YOAbAg2xiGMYZpZNarzvN9NHp/fwpcpz3e6DnzyP8jl0uawd7I95XVDYbqb1JYEj94mekCMc+wa1bFuObNty7pbCx9ANaMJzz+sfABss4SfenTuEM2AV8tkkfULGOl78Fcw==
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
Subject: [PATCH v3 2/3] virtio-spi: Add virtio-spi.h.
Date: Tue, 26 Mar 2024 12:28:11 +0100
Message-Id: <20240326112812.31739-3-Harald.Mommer@opensynergy.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326112812.31739-1-Harald.Mommer@opensynergy.com>
References: <20240326112812.31739-1-Harald.Mommer@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B621:EE_|FR6P281MB3456:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1401b9c0-f509-4d98-e758-08dc4d87d749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vaxNecGHKLu3Eu1SN5UKMRqpRwZde1Bk4V0R0/AYreGqYljR2prOMVVume8OMyMuBZWbK7o092i8xQ8XFL1KRNd191J98LyhqRRxOUgN4koaMTP5DCJUULADL5iitIK8vMbWTE89aEoiPGf4TlidDtlG3pYd44sTmimLsBqmFD9Q6693mbPjpTqjgeC7AhEdZTXq3g7IIZ7FOE7ntG6f7i5FEn4MO3ex3b7mK3rnFXyRPuJk7g4yqno/zYTGU0FFur87+ZIgHIE3BBlSlF64PalHDY8P6ego8qo401/vTdeRlvbJnhQD7scelQX+zVy5jegJ0WiYP+c7JN2YQ27nptap1VFyeM1cYJkOZ2KGNYQcCKeBiUxGiWZILNrCY2L09ME6TjwwrhaSlp3KtxEqoQWO8F9QLHw1eiKrU+uF7PfnNOb5V/D5cgCK1hmXjRDFFYpIkTbisbiBT6sR8JdqjhIq+JfayihQA56QmQ30/tDB4G3lKpCJ9XNk9ikN1glcI8emTaX901TEwdQ8RRRk8lHmtxfUCOAIT5HoPU4uLY73EnhVoRIPzJcv+BUeVelVkAfnnEiF8+C60xI9m7esbJk7hRV1wovV6rylBQNcC6uDzVrWeJwUIHml/X87ujXbgzSfI1MbA7Obge7olEjtXy0abyv2axdpshUUgBeZoJnRuGdK1pWb0GJV3TXI5RtBFQmWXjellVkgJQhk8fKXrY9WXMXGcjL2XbhGK2Q+p+0Pn3aFL1+9ikR+ydN3eias
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 11:28:20.6230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1401b9c0-f509-4d98-e758-08dc4d87d749
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B621.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB3456
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28274.007
X-TMASE-Result: 10--11.476900-4.000000
X-TMASE-MatchedRID: iCFo82lRN+nJ+P2VFrJmrNbTOt1RbxD5yiAijCjuVj08Sz17UlfNnyzc
	BY1cYZWcMpPx8OFzfY3vVaXvN8Hm+HV2KXA5dledcl8xQtDJjP+NZsEXc444sAD8gVkUxyRf/ML
	WVw0m36wc/67TLVA3Nz5DuftIGbXbh7WxbHud8h0PAv5X53l32wZ56rA8tSWbYUdh2Fo9g6bm+G
	s9Q6HSkSqWIaOjeKhZVVloj1evxlf0P2k3B8GnhDxl1kIwpaZ64DiXvcLDKwtLzssSnXxLpItLm
	Ysuoy662mASxyN7woi8HPJVrIH2AQyeroDP4V8LWucEZobOeTTPaW4rD8GWjC6AUFDL7nwFSD/k
	H/Ym2jL+XkmXDmV7y3dkxDD6JpuZx10k8QqyoAyqiWyHuX1y0KODSWu0oxbK6gfKtA7YhlrtmyE
	vxwC5ZPzygRMUeOgbJpK4F9wnIiY7AFczfjr/7G7XLR36HrMtyoe6R/u46RZ7/YJ3Y50NfE8JXf
	jn3aV92kVzoXxGttY=
X-TMASE-XGENCLOUD: 64e70656-7c84-4441-bbf5-15d6afdf9f92-0-0-200-0
X-TM-Deliver-Signature: 3CE79F5E2F93C8170345172445B4B250
X-TM-Addin-Auth: PN3VfTKWZeazV0XsUQ2qBTZpdSSb5QOBHU39ifi6nNmph0ezygRGJnp7aAv
	JGnL+XBB8SOUzSWcMbjEC/s3SCT+bVMNBr4d78fkGQ7LoBUFJ3elbH0Nc+ZU3FGtTdnG7c6oiqX
	r/JLE9qptFt5nfQ6m33F80EYLNXnIXRwX7hDa3ZfBseSxAMvc8meQQPA6YzwNYxZmcDkME3ZUoY
	TRg+cVImxDCaKDm3Wr7FFJKU4NO1EDfKpd2ve1+ZGxDwUl1WBJ+Aj+npoHVffkauCsQoZylqj5c
	z29B930sAh15aCg=.yAe8eAO4QUVDRl8ckpenumq0Bkfv4lhO3N+ZfItpCwiqFjCY7A3lTeI1sy
	mqS8fRIxM5ouQjQmUQSoM2DALD39TshySrJwjoni87m0USfPQckf7oDYjJ6CLrYXz+a2ahunWaH
	aFOYmqxm3bAdz7V4FsNAP2TODcmSDSaMnM9KArnL+6At+O22R+AHld4IAqv6//5jFHNRlh3XsUD
	7/mvWgdkinMKXy3L30Wy/NpdmLXobWbjRDzxBomfEBbftkD+mmcGorccbxOI3eCgTjppccbuxVH
	CbRl9utN6xhR7Gu0r8r9EyogdaY5gQ/9XxIpyjFacHMA3Hpa1pKegopKd/g==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1711452503;
	bh=RUCMbZXCwwGsmfFDXhCqWRcvPA0UePjvWJw35UvnYJI=; l=8276;
	h=From:To:Date;
	b=qrXB22xJ35fUR2wha5az1xuvAQeePb09gcWfZkUuNZba+6d9jPgfdFCloNkB7jiWI
	 4Y7dXS638eH7/RnpGYNWfwx5SdnBDBfSraZRlxVAPFBvTNKAp0sqh4slxxL6RCesJH
	 4Uo6gErA9rBc3qhKUHdi4byHQW2+YqA9lwUelDr7uFSPH3m2K7rtwx0+BJ98DcZJ9G
	 z69dH9VfkedUhMjf4LwGSn0fpJ4qfzaWUBmptI1HcGvJJufHF58EFQ+lfMNkFKjk4O
	 bPz+yhr40/BXCPxHFiFs5A6WMrFnnAGNnpy5SgUnRbGwZYXBOv//C85CYP6OoMqPpU
	 OVeF+tCtlhB2g==

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


