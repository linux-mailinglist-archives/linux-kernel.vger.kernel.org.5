Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71457D9DF4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjJ0QYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjJ0QYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:24:45 -0400
X-Greylist: delayed 846 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Oct 2023 09:24:43 PDT
Received: from refb02.tmes.trendmicro.eu (refb02.tmes.trendmicro.eu [18.185.115.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB4F9C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 09:24:43 -0700 (PDT)
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.19.56])
        by refb02.tmes.trendmicro.eu (Postfix) with ESMTPS id 4A143102ED1F2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 16:10:38 +0000 (UTC)
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.173.48])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 3172F10000F21;
        Fri, 27 Oct 2023 16:10:35 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1698423034.897000
X-TM-MAIL-UUID: d2c7dfc4-b41d-4ace-97e2-a4b5c1493321
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.169])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id DB51F10000E46;
        Fri, 27 Oct 2023 16:10:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHZKQhzaKDt0RVb1KVmyj/9Tg6u12ogAswdZMz8rlvH/lmejwHFpSOGlv5yl4UQ0pFhsjKVSwUqEMHZGCeVKjXmOAmgBNpFGyAZGQ+hKhQ3tahgGP6EKlN45aWDwDcYloUBMJaj20sfwTKo/Jb+C21UPyJmtORiT+w9z/kR1VXnzVIifH04oUMuNFNIqdIQBcTjJWLxmkovop97noxQG3dXIetdsf6jpFuZ3UPFBc/XvuNBGkj7nOtoMqmxbpeAZ/trjzEeq14eUT0++X+U9+delvmA3sdwAMJBBu714lbOoMHE06RODlm4wXUN6rTJQyioBFT0QG1MqvM1kPGNbXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtt+mhEMfH+mKaQi3Z8Txs33WznzBC9LPxm9/e/4qc8=;
 b=XktcoUI3H3jPOo5ASzk7ynYbAm/K1U7604hpXThlXq3SBP4/nUbfEDaS+DvbuLIkQmYaG+I4W5Hk2U3p5G8i6owSS1YR6cdHvBPVrpbLsvecyfblu1wIvIuEn1RMFimAaXyIjahN54Hfvfxk9piGRrla850BDxEzbYk6rfWFeWqYLx9MAzBQhuXdJHgYaOdyAW/SDk2bMR1QlPleTc6GjtnCZYpBcYsRPkPgDBrR19UONlPFLEphL3RRMKv3ycaEap/z8Y3bpT/HndsTW0I+NcZfQgyQ4qwc5mSU5/eiLkhYa7Dk+1LWz5IeGlWqVDk2C5LJK3fMwZf7QJJ874ORWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=gmail.com smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=opensynergy.com; dkim=none (message not signed); arc=none (0)
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From:   Harald Mommer <Harald.Mommer@opensynergy.com>
To:     virtio-dev@lists.oasis-open.org,
        Haixu Cui <quic_haixcui@quicinc.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Harald.Mommer@gmail.com
Cc:     quic_ztu@quicinc.com, Matti Moell <Matti.Moell@opensynergy.com>,
        Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
        Harald Mommer <harald.mommer@opensynergy.com>
Subject: [RFC PATCH v1 2/3] virtio-spi: Add virtio-spi.h (V4 draft specification).
Date:   Fri, 27 Oct 2023 18:10:15 +0200
Message-Id: <20231027161016.26625-3-Harald.Mommer@opensynergy.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231027161016.26625-1-Harald.Mommer@opensynergy.com>
References: <20231027161016.26625-1-Harald.Mommer@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8EUR05FT041:EE_|BE1P281MB3272:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a5f92685-daf3-477a-4868-08dbd7073f49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: njdL5mgFcGMmH5zYzEhCfh2KrBkmdbAiu3NkVVF8QJv8ZQRHM0L82odVmrrzbdA+356oy9hszcNhOm3BKCTxhj0+mWPsWJ6hs4NO4B/R36oEzQ0GpfSLpM6Yfm+EyuZ1RNioyk4F9yXCEOLjDUKnfC2YCwqS3ewgIoVBTLE8XAhm0m2/Rl5fUG3fOAMHstkMC80iDor+aeNgCv09yhQruDm2FhtJ55d8sEVuDZJe6yTmXGUjKvSgr3kSBsXogkFds++lMvY+W8AiB50A9UDhqYPcbhe7ZYZdcO+E5tfdp5qG+uCmzFMSiwuOeH3cg/qHrVYFfqzT4vFJR4ucPGxKxg9kFXrUKWkiQ7P7izN5SstEv+xX+7P0gngE5KnN9OakcP04d4g5CmBmM5hql4H5+D3wn+jAx4mHqR4JUfdqo4xcoH6RH87S4Skvh3l9UGYIaAnKD/qibVYhBCCnIiFNs+OjZHbUHQyV2LiIa/B7PfuLsSywnHShtyPMCx52+/F8VbIrkB+kVh36b1N4wdYCg1cmhT9wnMyLW0le6oMQKC1p6edwkwVNrlPWin382nWBzO/R6Sy4w3kxtpe5EqUJbdY6S9dqPHBv9CtT77TsHveiE4Nb2pRqa7u0GYINvEjH7yYjd5RMWWHK23FmpZi9mALpBUpXtUD9hxMZeHkvfj+bne4GTuhUYbqy37/dPVljBwxMZBH3oI7F1f2LrWQ3A8pYDm/XabA67rMqz+5HF46YdZyrYYSED+57ZMyn9cj1Ncb7UxabGHtOr8XcKehuwDELyn/uWah/Cx/N936UolE=
X-Forefront-Antispam-Report: CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376002)(396003)(39840400004)(136003)(346002)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799009)(36840700001)(46966006)(40480700001)(86362001)(36756003)(8936002)(4326008)(8676002)(81166007)(47076005)(36860700001)(478600001)(1076003)(83380400001)(107886003)(2616005)(70206006)(42186006)(110136005)(54906003)(70586007)(316002)(26005)(41300700001)(2906002)(336012)(5660300002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 16:10:32.8473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f92685-daf3-477a-4868-08dbd7073f49
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT041.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB3272
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-27962.001
X-TMASE-Result: 10--17.674900-4.000000
X-TMASE-MatchedRID: iCFo82lRN+nJ+P2VFrJmrNbTOt1RbxD5yiAijCjuVj08Sz17UlfNnyzc
        BY1cYZWcMpPx8OFzfY3vVaXvN8Hm+HV2KXA5dledCWdkPey/ud0jlXaiQlbRvcA5EsafV350uoX
        Jwchtzy5Tl0lv7cPCk5+PCFJWnbkmqjgbRUp1/V9IhbHCNJtZqFYSmaIHbAjb6enQEs1AJG+i8x
        71YjXky+oMhig7xO3z+HGIBzKojRi9G7fwb24hbnOjEKYddvv6g7bJEu21E12JFoX8AKzcA9/c7
        CkD393G1AnisiuxEGuPhlgxW22SipwdYg5yf5xLCI8Pr2jKCJsY/7XQ4nHVciLW2ccC0rwjSD/k
        H/Ym2jLJd5SiaZ/WQoWUjXyJuICheUeN/PHOKbPFTQGAKRxj5No+48giqZwnEgg3cwDHl/0S3WM
        79W3o4ma3xca03R6M/utaD2GffWp4bd6tiMFuXX7cGd19dSFd
X-TMASE-XGENCLOUD: 0bd6d138-f813-45c6-963b-3de791301a6c-0-0-200-0
X-TM-Deliver-Signature: FFE3750A9159210E0FC42FBE0F8375ED
X-TM-Addin-Auth: 0d/M/DEJNdkQwmN2tYoEVb47CBXkO//emanqI7w85ZuhLxTRYMvs6W68bYM
        Cm4qJbiYRHMj8Mdcmd8ELGzt+kbgtirnEwKOj3ucOpeiDmKRqLFvnnRo62JtZ+F+mWStkJ7gEh7
        SVMVb6x0XxZaGxmu9lp1vm+v7XyyM771fvuUShrWv1BKlrBCUfk6gOknXnGbMqZp9t0PvHSxKW8
        2Qb2bI0+dXijC816vzT8nLvvjt2FfLnGwjayhLcaufbFkM5Hj99EiENtxiIjFZfeorxTq4yYzJc
        Zo5/RLSVYVguFK0=.JKxEv6Ih9RIpdTvCWfg5L2LR5MmlMTvPYjVSwv//WQ4a1l8YyL5bCFSRc6
        eJalyCuGF5c+EMdsTrPi0eHD2wf88W9JsKoRP6+z1E5TDmx3gDGy/2BUgBkC4bUtQMKN/5RdTZb
        +LL/RJ3voTbBxgI+NzkOL4luN6tVvN3FiH7OgqEPEGsIzsBb8SxrU9ZI3bm9hluFqX1qNZeV4Dn
        0Vyz8tYC0B5toyUQV8sbS9d/l3lFU/5sG6O6PHR8d3zKIGYKUGjXI3lz2MOrEHeppbJE+jfldtq
        QlPwXgyN7Utvybtg7IYzJSGHlSGy2tIL3TNNBNSWsYUk1tFRntw074SQn+Q==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1698423035;
        bh=rf8xU9jaPKooqslEKyH3DRwS42hbdsYDlfWoTKiZFGU=; l=5330;
        h=From:To:Date;
        b=JVoNk/PruzGamAIiMFobCWzTUkScWZI0GyIDvAggm5OWZzzTDn1VTzGxu05bjDYBE
         lt7Nxey+6eUpnyCPjf+IylUQ7blYx6/ozY5vQf44fBEI3o5e79RQbb8vLUY4Xv8uM7
         SSIuOkY71GT/9j8lK8N0+Svq97VdpcrT4oJh/cIurCLcjkxg6XGuelji0GZEw1BNi9
         W3Y5g66V/R6p63n+sUIIuiHpu4WsJNjUHdbzqdl4wRD+RmHg9bq9VFjuZYGx+HCNi9
         0KrmY+9XONHG06d33PPq8h2j0aXIX84xHSC3arpVCTyX0hBvtBsogdIR/u1JxQfqVe
         ulLN7JUeND7rA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harald Mommer <harald.mommer@opensynergy.com>

Add initial virtio-spi.h header for virtio SPI. The header file is
compliant to the virtio SPI draft specification V4.

Signed-off-by: Harald Mommer <harald.mommer@opensynergy.com>
---
 include/uapi/linux/virtio_spi.h | 130 ++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 include/uapi/linux/virtio_spi.h

diff --git a/include/uapi/linux/virtio_spi.h b/include/uapi/linux/virtio_spi.h
new file mode 100644
index 000000000000..9cf4335784ef
--- /dev/null
+++ b/include/uapi/linux/virtio_spi.h
@@ -0,0 +1,130 @@
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
+// clang-format off
+/* Sample data on trailing clock edge */
+#define VIRTIO_SPI_CPHA (1u << 0)
+/* Clock is high when IDLE */
+#define VIRTIO_SPI_CPOL (1u << 1)
+/* Chip Select is active high */
+#define VIRTIO_SPI_CS_HIGH (1u << 2)
+/* Transmit LSB first */
+#define VIRTIO_SPI_MODE_LSB_FIRST (1u << 3)
+
+/*
+ * Beware: From here on the bits do not match any more the Linux definitions!
+ */
+/* Loopback mode */
+#define VIRTIO_SPI_MODE_LOOP (1u << 4)
+
+/* All config fields are read-only for the Virtio SPI driver */
+struct virtio_spi_config {
+	/* /dev/spidev<bus_num>.CS. For Linux must be >= 0 and <= S16_MAX */
+	__le16 bus_num;
+	/* # of /dev/spidev<bus_num>.CS with CS=0..chip_select_max_number -1 */
+	__le16 chip_select_max_number;
+	/*
+	 * 0: physical SPI master doesn't support cs timing setting"
+	 * 1:_physical SPI master supports cs timing setting
+	 * TODO: Comment on this, unclear and naming not good!
+	 * Meant is probably word_delay_ns, cs_setup_ns and cs_delay_hold_ns
+	 * while cs_change_delay_inactive_ns may be supportable everywhere
+	 * Or all are meant. And the naming mismatch is the cs_ when the most
+	 * critical word_delay_ns which cannot be supported everywhere is also
+	 * affected.
+	 */
+	u8 cs_timing_setting_enable;
+	/* Alignment and future extension */
+	u8 reserved[3];
+};
+
+/*
+ * @slave_id: chipselect index the SPI transfer used.
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
+	__u8 slave_id;
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
+#define VIRTIO_SPI_TRANS_ERR 1
+	__u8 result;
+};
+// clang-format on
+
+#endif /* #ifndef _COQOS_VIRTIO_VIRTIO_SPI_H */
-- 
2.25.1

