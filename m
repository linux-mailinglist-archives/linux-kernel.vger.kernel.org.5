Return-Path: <linux-kernel+bounces-16695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6A0824290
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2501C23DBF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C84622339;
	Thu,  4 Jan 2024 13:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="wOf4cC/t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C9021374
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.19.198])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 5785410C3EC7B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 13:01:53 +0000 (UTC)
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.176.220])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 7C7E210000C35;
	Thu,  4 Jan 2024 13:01:46 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1704373306.074000
X-TM-MAIL-UUID: 5474ea3e-5a98-4133-a7e1-e61acef30fb5
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 123591000040D;
	Thu,  4 Jan 2024 13:01:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMTOQVH5GgGvmKH0ocYlm8p9atXFSedlLCoue4ZpWX2ec1VWAAgpvrTVWeSkf/MnZS8oKM6yHz6ztlmlL8j+Vp67Rb2DZ7fp4ItK7C1pQL+cPAlw7/sdcVBxnSF/h/JmGn8NXRSlVbIUbh/BDC048sCkOMKl8qQRzkhlg1DdFEjpnfTY4r9PMXqYYuaKcDLPLcoZUGWsGPrzcyrG02JguO+T81gGDwKtrpzVAYHbI9a70LHdexiYcbhcIKgNCNcy8kymRi00+6Oovgmrf2hj36ZSGHD7RUf4M0lVWlw7nzrLDcdAXy2FbNBEX0osc4c+V5CL3V2VUMp1WisozpM0rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k373ENbKKgZEygbJ2ZAkGzkQCJqpH/pxUPIlD6aCUPM=;
 b=YwXq/S1eIESO80Qi3ZVlHgxxakgZf54FAIaBcxguNcWhzHBxtxOEVeAQk9yLzrDCBk8KfW+nNqekElVccaN1JeC3QileZCqbjR9TMg8RHfo10HgUyB1CrXbhWlF1p1pRMCXxxTn82SqUL2OSHgAHf9N23W5RsaSSLDc9MnXRfj2a0h1TbufqGhYipU3NIEUa6iWW7Q733YylF0YFZx/APl2/S1zY1zrqdp+ZwsBVxJI2YfSB3AU6J8uBTm5KyAANEI2xQ7yX4EOXhweMcanoFbOyGfKt5vBsv7vc2CA/0L9ZB+YPX+wkmvdl3L9Gbc1pr8nsNA+/uAu+GaUlulx/bg==
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
Subject: [RFC PATCH v2 2/3] virtio-spi: Add virtio-spi.h (V10 draft specification).
Date: Thu,  4 Jan 2024 14:01:28 +0100
Message-Id: <20240104130129.17823-3-Harald.Mommer@opensynergy.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240104130129.17823-1-Harald.Mommer@opensynergy.com>
References: <20240104130129.17823-1-Harald.Mommer@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6EUR05FT019:EE_|FRYP281MB2222:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ace742d7-dc55-48b2-2bd1-08dc0d254d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vl+6k2yOnuPB3/qlmHARLnbJnkgRB1el8kTRVQfchI1TU2AYWKDRe9vETrN1cwLOzABgHB+BX2BdDxHptu7sQdggqua1jLtq0m+ko+6rhVL7JPOey7nr7D4vh6U3vwmGKpRfF9FXO0rT2oQXm6cStXf5sTldNsEzNH+hhy/negxmFkbhDyDeTin0ETFFGsLoOhAU67rVDqs00fheWCN6RTs6GT6I3UQZk6JTOB0SZzyH9TLAsh1YwZmuKM1j1N6rkypga3kNS3FmNSmPni4fhPvsHcU2HbhZZj75rfdwC+0qiLA2Zv7D8ZJIau3Bhr7nkaPbXzFtJAPB5jWtb1jnok2Js+GumS3qDmsK970+mw5Alrc7gkuZ0KGBGidKeQaZGEkfD22QIklHqVBOlxGptRctDjfINGAA1VycRAp3A1/mho99i2YSX4woV89oAKvX4ZqUzJgWZcIY22tTpjaEyL49Vbaw+NMDBlEP3XkhJ5WIcvmksq0rGErDfQ5XwJusjWi5czdpb+qMDbkQFh1Fvb9yds/83KeL2fRfV6lNLoZc+LfUjLNSy6awxDvc+QdB1ZsY5OT2lnX5DK57QlZoqxR6LhYC1yPwGEjNW5C7v4NLO/n5YF9sVakLEakvaA7lkGiZPp678O91ajEh3YrZu6kVLe9+PpxBJ6QyqDxCH+tK3n3mpQBaQ2hOxnusnqjKo3yVbBwh7iK9ycL0rBgUti173Wwx25xld094SdWXy9FdRGti7sI1WxYL/NCW7t/V5c+5CLmJgy9aJIRkEg8x5+QEz/7axp1bZWbLyWxOGWU=
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(39840400004)(346002)(376002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(82310400011)(36840700001)(46966006)(81166007)(36756003)(40480700001)(86362001)(2616005)(336012)(1076003)(107886003)(26005)(54906003)(316002)(110136005)(70206006)(42186006)(478600001)(70586007)(4326008)(36860700001)(47076005)(83380400001)(8936002)(8676002)(41300700001)(5660300002)(2906002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 13:01:44.5256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ace742d7-dc55-48b2-2bd1-08dc0d254d8e
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM6EUR05FT019.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB2222
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28098.007
X-TMASE-Result: 10--11.476900-4.000000
X-TMASE-MatchedRID: iooG+Wyw6IPJ+P2VFrJmrNbTOt1RbxD5yiAijCjuVj08Sz17UlfNnyzc
	BY1cYZWcMpPx8OFzfY3vVaXvN8Hm+HV2KXA5dledcl8xQtDJjP+NZsEXc444sAD8gVkUxyRf/ML
	WVw0m36wc/67TLVA3Nz5DuftIGbXbh7WxbHud8h0PAv5X53l32wZ56rA8tSWbYUdh2Fo9g6bm+G
	s9Q6HSkSqWIaOjeKhZVVloj1evxlf0P2k3B8GnhDxl1kIwpaZ64DiXvcLDKwtLzssSnXxLpItLm
	Ysuoy662mASxyN7woi8HPJVrIH2AQyeroDP4V8LWucEZobOeTTPaW4rD8GWjC6AUFDL7nwFSD/k
	H/Ym2jL+XkmXDmV7yzsR3s9x8aXjx10k8QqyoAwRLjqoJJt/9Ye8/oJiio9KA3+iPIxcfrYMSiY
	ZTF5wqnGDuy8y1qku1w49UOADy4V1QXavl7zci/95KamOz/pC1uHWKUg0X2OjeCsfdN2meg==
X-TMASE-XGENCLOUD: ba89b234-3934-44a6-84c4-040235ab9bcb-0-0-200-0
X-TM-Deliver-Signature: B72596D4D714A3835748EB46EB5CE90D
X-TM-Addin-Auth: 1KFVIkCSBGXQXZhP8D5wxfwGbY75+zxOlF3+dl/37jGTiPf4YnygL/nL6ev
	TjyIirR936Ca8fmIB/TlYCsTHSea2Q3Eo63r+P+FynyxeVBZSkhJHlEwzfo3E37ZRnqOChG7Fqq
	anS918vSy+xe+cBQJmi5cJ8OBW6FrTZaAeDXK+rH+i8MdwXho6mrS20emW3Hj+g+RDJsEOn6NOS
	jeeuW8PQ+7Xy8GY1j8IYKYYNXo3qPx/mSsACEXVXM0ddBIUFGacwxZprc6oNthbqvNp/7+s8HOO
	JhUxUKKcKXGPHyU=.JGCMAh7uqW4fAN+glsdE4l7qrezbL5fL2nAR811mUjrl8/4xCFADlSW7He
	NAfUn9jYOyjhIgEp6KaVIpkdIdh8dvzpRpMKP1+z5WJs952iHjWvbJgUdqK+zB2fNwqPnm6JUoJ
	3XNyEVKIz2pYSJiAIhKiGCtgmadPjzxqx3rHcZ7bKbFdHe3EryAhcJxBAfQOZUP70QjgMuZoWPS
	KmYXn0Vq4QqqsbifJkEs005I4JTwm+pnFv2pIW97OfSzqttytdFil5KcoYMut9duHPbKH7G92ND
	CBumc+I8Az2xXB6RQ0aCx2oyyv9KCMU28GlPpFZg8Td6WMYNX9973SH1qBw==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1704373306;
	bh=2+A1XTmnZ9CYy4BncCWNalSIxkrFck8bq/HilGLrGrI=; l=8296;
	h=From:To:Date;
	b=wOf4cC/t5PUxVHh32vu3tCFgGnXZouSygqewjDKrh0vMWAdSZ3mMNc88MwAqxJlR2
	 6Zx+jNLFUYabMYlNiIyCvA7jCAhvZDoVLrhD49kADEIldfNPXJWsgaCzC0AOeMm4hy
	 9mOX+52xddjwE32+WcEvDEmdI8lZ1wFyLqYCwiIehazE7iH/Bq7I6eanaJV85uYkjr
	 cllmpb9+wPS7XS5uOC5u9q+41hld0ZGReuSuVUR82J9mlng4tyh5narxDRa+XKqCRv
	 iEYDuTrKJ0Yhc/UVS9THEs9iUk2y/dSNt7BcmVkhMMNqPqwQRky/Vd5+TrIayN9Wyc
	 rw52qamO3CJMw==

From: Harald Mommer <harald.mommer@opensynergy.com>

Add virtio-spi.h header for virtio SPI. The header file is compliant to
the virtio SPI draft specification V10.

Signed-off-by: Harald Mommer <harald.mommer@opensynergy.com>
---
 include/uapi/linux/virtio_spi.h | 185 ++++++++++++++++++++++++++++++++
 1 file changed, 185 insertions(+)
 create mode 100644 include/uapi/linux/virtio_spi.h

diff --git a/include/uapi/linux/virtio_spi.h b/include/uapi/linux/virtio_spi.h
new file mode 100644
index 000000000000..d56843fcb2ec
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
+#include <linux/virtio_types.h>
+#include <linux/virtio_ids.h>
+#include <linux/virtio_config.h>
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


