Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738037D9DF5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjJ0QYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjJ0QYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:24:47 -0400
Received: from refb02.tmes.trendmicro.eu (refb02.tmes.trendmicro.eu [18.185.115.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBD7106
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 09:24:43 -0700 (PDT)
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.19.34])
        by refb02.tmes.trendmicro.eu (Postfix) with ESMTPS id 415E2102E3D5F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 16:10:38 +0000 (UTC)
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.196.113])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 88BDE10000C5A;
        Fri, 27 Oct 2023 16:10:35 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1698423035.253000
X-TM-MAIL-UUID: 9deed503-f4cb-4898-9a0c-a33bba343f7f
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.169])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 3DDF710000E3D;
        Fri, 27 Oct 2023 16:10:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfAMH8CbSPdYj6ticWt4ZKey1h14RZuLKmj6jGRsYGgLM6xoplKwyuD9+hkldnyvXn9boeeOgcrLT8ApWYWCZ4D98cvpTGGyHjdvBHbqNdZcC2MfPMce3BEFVm2xl0IewjoOoWMy0+W4bt17xMLztqi6NN68YeMJ3T2+1KfleWtLTeEA3FFnczxVuq7Rk0uU9zeerqZtInKzq0j5g9ItD+frekmSDt1JtPaPsEmYE0H8KKKy4lwBYEIIzPdg6kfVSt857qu0708b4eu5+jOl5FoMh+ZOGivxVEVZJMcY0EPFpzyAzfNYTs7xl0dzRo/IkRXm133sFnArEgtV9Zcruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SgWXIIQAlWczZR7W6lWPARwr+sttzxA86uuhqIa4PE=;
 b=QMqH8AP/hZfnv4Y9yUFXJz7Kr7towwE4ITszvSL4mBRIu6FgMETIjy/kT3sdY6oJyjOKlWYltON3CQov3Wo0SEEtmdJ5GMYSsOSeVaehcD7y9Oc7DjgcHIM4YqtIJkuni9eRMfmr/qMY6aZnC9I1DwyeSzi6LQLt7EDALTlwtCUaAc2uDQ9VakHXoU7mVWbGT3Wlo+P5xcuIzH9jMtTqL6aOnjIl2hcKIZ7lV3yIgIYcRkBiJJjnORnMPolFKd5q3ZF4wteW+YpGV9xLWF94EgdEXjjgV3/2+wodJSk5VJbHP4yi+jMJHsgPgRTgpnD9Mpd4WGROo4TcXxwBFpQt6g==
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
        Harald Mommer <harald.mommer@opensynergy.com>,
        Harald Mommer <Harald.Mommer@opensynergy.com>
Subject: [RFC PATCH v1 3/3] SPI: Add virtio SPI driver (V4 draft specification).
Date:   Fri, 27 Oct 2023 18:10:16 +0200
Message-Id: <20231027161016.26625-4-Harald.Mommer@opensynergy.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231027161016.26625-1-Harald.Mommer@opensynergy.com>
References: <20231027161016.26625-1-Harald.Mommer@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1EUR05FT055:EE_|BEVP281MB3714:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a35195b4-3aad-45ae-63d0-08dbd7073f51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F6xvqaxpbQA0dNwGIyjsUwdfBYLoIFLG18rHpF1mjTqmQZIHIm9uzhbsIIEzb5lEWYIuSqwZQAjPvEWbU6RagZGzjbfx3V+qWpfY2SvNMHvjkiHbj75JNEnoAlN2ZKPEm8J3FHS5AElq0tXakMFrp6BcZ0qpENRjspt0Q0j2mUZSCAjbKtZTjMebhPcAT4AxFgL5sBOWMknwsyXp5hK5eYRpd4xoiN1VJO5CJ39OjD2ZAeNRDyVzMmkdD3E9Nn96dsmvQA4sSPushCayEJ2Pb7tfn8C1u3v7z7Xk1z7fxHLxdDUHCO8+no16gzucgF+LZUvIJkBq6zSF37dba06IT9HdLulyRfSinqyCcJDYSqe7v4im1OPvNeiir9FFh09+NoSuPaJFkV/Qkj3xzf0spAzCrF3UpXYe6iTUsDYnlkVkAPj5Xov6Vh6O+I76QLxjSzIJxPzo2vB0at9hJ43ypUvVCAteXS+f19X6vBKCcFHMvl4ft5DHu/M/QMVBPMmLyVo51j84CMf2mPNahYNf99TU7mjsjnIHwL0JkUzl3L++byFXfn+IcRphNiR3NBRbAYzzBFmfBl0owPNTRFCMz39npKAerGhjVlaT6ANEFHMhl9B4Pt7Ll50KAUjKgj/DnPjncL59P+cCKRakiVo/Icf7CQj0edpXuz5XrCY8Cq61x1LqDCG2y8klRC06uOtBx0uo1KlG8fU2fupm3QbmqLEaEBU717bOke3bu+30D4A+F3WBuvIKtXD7lonHDbZEMfMTGssiRna4D8skCUItqrxLrZx4UhqdVMKE2zdXxuirbtz0qKycUgOvnfOIWbgD25rGiblHCAvhr45ErAbNEQ==
X-Forefront-Antispam-Report: CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(346002)(396003)(39840400004)(376002)(136003)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(82310400011)(186009)(1800799009)(46966006)(36840700001)(107886003)(1076003)(26005)(2616005)(47076005)(478600001)(83380400001)(42186006)(336012)(30864003)(5660300002)(110136005)(8936002)(2906002)(4326008)(70206006)(70586007)(41300700001)(36860700001)(8676002)(54906003)(316002)(81166007)(40480700001)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 16:10:32.9161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a35195b4-3aad-45ae-63d0-08dbd7073f51
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT055.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEVP281MB3714
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-27962.001
X-TMASE-Result: 10--21.085200-4.000000
X-TMASE-MatchedRID: xZx1/qd+HIKN9LPjAFtecYruruLIWfnxZK1SF2R3edjIRhEhdkLWErIJ
        H52hwBT85vU3PxoHxScBbVrnmZTB9CT9X8pqzpZCsX4aFYAMIYPIQQwRv8gPjskXIF34mJLKOnp
        NWpJkOQuTIJr1EFP8Nn7U1eUtsS59MsZYFnBjXTV4lyF1lyvUrR4s1tXUFaIfHDvYNMCF1TvuFd
        YlS5E7Nw6pq/Mfxb3zC53mke8P6z6REDJJp1YHqglnZD3sv7ndJbzZuwLx+4VSITmUaxn9yJtJH
        ckr5y9ewjvemIJg2HCgCXi7nt2Ddfz2TcZayMphVkHd5sq6oNnAmqJNCjDgNooap+92Y3xo39zs
        KQPf3cbVSOBCvDP8U/2HxK9n+Tc7S+Wk8g+gmgVqpM9kcTNYHgf8yw0JGfKV7tAcMwbOJSTlNiA
        90QUbyXkJxKdHU0G1yqXazjH/6ht2T4ibWvfZlzZ4NKr/TszHFhw/aE2qU5q9i+/f9tLGG4+gXY
        wwcotABt8o8YIvRfpWm8JHnOCM60JzOcCJYMAHUirF7gO7fvl+rvFZ7FWrXLIHDXkfbgxHP+b5W
        SKqJ6uXU1iXHG9ZTC2ARklQdzvlI9o+AsKg//X0k0bHb1p9aOA4l73CwysLuzAg7efo/wWn5XVN
        L66dGRfJtYaonC5p3TgQvhGIvpf506pVrbWKEbr2u0KWqQKN49PDUGWeloGwyk/KxS4xTGV19+v
        wZgtPkwqrpu7B7Huuj5xyE+WP6ZRbcOhs8P631NIaO5sWivgIyIQE9neGFTB4jJltGVDbLN5wGP
        X3TPXYeXOEzfM22ez1ZBVjJwp/DeUZOJCXHMgz98W5VRR2G6JYuGaIjh0/6T/LTDsmJmg=
X-TMASE-XGENCLOUD: 44cb6254-3f5e-4549-8bb5-33f70b537e8a-0-0-200-0
X-TM-Deliver-Signature: 5E67B3C025996EC1749B3D340DD53436
X-TM-Addin-Auth: KbdZA+5dhMZOPzZrfYOnan+UTajkTVj2ukijp6YVYvVKOVz4XVO8UUlqJUO
        eX71OBG4AZLHqqToTq4KRUJVPWpmhm1PnhzgyryJGjXYgPUS+C0gCuoux2UXoGisPARSYzbnySd
        lfVffw8+GwBj7Wd2b8JmP4sWtCCeNDEvyGDT9efv1EB13WDBxJIu73MMhOWkl8FfC4djtk4BFj3
        PlJCppMNx4neY1fhEHpt3giS6wxW7fG8L+vAZJgrlcRkGTzgukJ0r4sMXMN65c7pPyPVl5Gh/pM
        fZlktK/3EAVPlIY=.l/9heWXDsyq9Zaab/R8ZSnV015hWbkp/Xtl0lm54QV2Ur6QSBPmJKx464K
        /t+0PivOOEH0AjrJgB0443wB0MSHT7HYLNhxJm4su3hjZPQ84Efv3lkM814+olbFuKgFtQRil94
        bffaCJk5SzesK3jRczkLkFpfQWbwgvri2+ggimM8YheMGXAC4zh7MjHQM9GomKoO88FexeND4OT
        apMY5nfdC6O2aelYNI0N1Xqdoj0wmIM2Aqmm+J0gEjVvyoHOm/f/SX5TNgSwMq9g52AwKIVuBy+
        +6hyWdFPTySeNwaV2zO9i3PnKp4UodreGrOfDnPbOBvqiOIulzD5J4NvTAA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1698423035;
        bh=0PpFx/KqEEeyBjCq0p75rmHIVhjxqmmq29y9Y6AcKX4=; l=17392;
        h=From:To:Date;
        b=U69BsUaEA3VCn49PziC5gtk6LE4x/rDXyFxHwRdI8nDmN1BNfixQTcUunKIbVP6WN
         mO2cLP6M3Fw3cqqPv0Ilq7mXsYCOyWiZMBjDguo16bnak+XQf5zoFsxGTxQDWARfR4
         J6bBRIqRPymmdkBpdrKSMud0iInLbk0wYqatgfH6b4efn35NPMNBZYFEnEEBNRSWMn
         IBuOVSQY+IAUEGEfON0bCQDd9zp7dTdl2pesVvIPXWdRKcBoLqEdYVxOYBmKH75jl9
         K2iJKZvw10nsKJ2afcoI807PlDImFu3Ca7RzVWW8wofxZyLoIVeaLMrXatKYPIn4B1
         poZtQ9j0Mgm8g==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harald Mommer <harald.mommer@opensynergy.com>

This is the first public version of the virtio SPI Linux kernel driver
compliant to the "PATCH v4" draft virtio SPI specification.

Signed-off-by: Harald Mommer <Harald.Mommer@opensynergy.com>
---
 drivers/spi/Kconfig      |  10 +
 drivers/spi/Makefile     |   1 +
 drivers/spi/spi-virtio.c | 513 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 524 insertions(+)
 create mode 100644 drivers/spi/spi-virtio.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 35dbfacecf1c..55f45c5a8d82 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1125,6 +1125,16 @@ config SPI_UNIPHIER
 
 	  If your SoC supports SCSSI, say Y here.
 
+config SPI_VIRTIO
+	tristate "Virtio SPI SPI Controller"
+	depends on VIRTIO
+	help
+	  This enables the Virtio SPI driver.
+
+	  Virtio SPI is an SPI driver for virtual machines using Virtio.
+
+	  If your Linux is a virtual machine using Virtio, say Y here.
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
index 000000000000..12a4d96555f1
--- /dev/null
+++ b/drivers/spi/spi-virtio.c
@@ -0,0 +1,513 @@
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
+#include <linux/stddef.h>
+#include <linux/virtio.h>
+#include <linux/virtio_ring.h>
+#include <linux/version.h>
+#include <linux/spi/spi.h>
+#include <linux/virtio_spi.h>
+
+/* SPI device queues */
+#define VIRTIO_SPI_QUEUE_RQ 0
+#define VIRTIO_SPI_QUEUE_COUNT 1
+
+/* virtio_spi private data structure */
+struct virtio_spi_priv {
+	/* The virtio device we're associated with */
+	struct virtio_device *vdev;
+	/* The virtqueues */
+	struct virtqueue *vqs[VIRTIO_SPI_QUEUE_COUNT];
+	/* I/O callback function pointers for the virtqueues */
+	vq_callback_t *io_callbacks[VIRTIO_SPI_QUEUE_COUNT];
+	/* Support certain delay timing settings */
+	bool support_delays;
+};
+
+/* Compare with file i2c_virtio.c structure virtio_i2c_req */
+struct virtio_spi_req {
+	struct completion completion;
+#ifdef DEBUG
+	unsigned int rx_len;
+#endif
+	// clang-format off
+	struct spi_transfer_head transfer_head	____cacheline_aligned;
+	const uint8_t *tx_buf			____cacheline_aligned;
+	uint8_t *rx_buf				____cacheline_aligned;
+	struct spi_transfer_result result	____cacheline_aligned;
+	// clang-format on
+};
+
+static struct spi_board_info board_info = {
+	.modalias = "spi-virtio",
+	.max_speed_hz = 125000000, /* Arbitrary very high limit */
+	.bus_num = 0, /* Patched later during initialization */
+	.chip_select = 0, /* Patched later during initialization */
+	.mode = SPI_MODE_0,
+};
+
+/* Compare with file i2c_virtio.c structure virtio_i2c_msg_done */
+static void virtio_spi_msg_done(struct virtqueue *vq)
+{
+	struct virtio_spi_req *req;
+	unsigned int len;
+
+	while ((req = virtqueue_get_buf(vq, &len)))
+		complete(&req->completion);
+}
+
+static int virtio_spi_one_transfer(struct virtio_spi_req *spi_req,
+				   struct spi_master *master,
+				   struct spi_message *msg,
+				   struct spi_transfer *xfer)
+{
+	struct virtio_spi_priv *priv = spi_master_get_devdata(master);
+	struct device *dev = &priv->vdev->dev;
+	struct virtqueue *vq = priv->vqs[VIRTIO_SPI_QUEUE_RQ];
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
+	th->slave_id = spi->chip_select;
+	th->bits_per_word = spi->bits_per_word;
+	th->cs_change = xfer->cs_change;
+	th->tx_nbits = xfer->tx_nbits;
+	th->rx_nbits = xfer->rx_nbits;
+	th->reserved[0] = 0;
+	th->reserved[1] = 0;
+	th->reserved[2] = 0;
+
+#if (VIRTIO_SPI_CPHA != SPI_CPHA)
+#error VIRTIO_SPI_CPHA != SPI_CPHA
+#endif
+
+#if (VIRTIO_SPI_CPOL != SPI_CPOL)
+#error VIRTIO_SPI_CPOL != SPI_CPOL
+#endif
+
+#if (VIRTIO_SPI_CS_HIGH != SPI_CS_HIGH)
+#error VIRTIO_SPI_CS_HIGH != SPI_CS_HIGH
+#endif
+
+#if (VIRTIO_SPI_MODE_LSB_FIRST != SPI_LSB_FIRST)
+#error VIRTIO_SPI_MODE_LSB_FIRST != SPI_LSB_FIRST
+#endif
+
+	th->mode = spi->mode &
+		   (SPI_LSB_FIRST | SPI_CS_HIGH | SPI_CPOL | SPI_CPHA);
+	if ((spi->mode & SPI_LOOP) != 0)
+		th->mode |= VIRTIO_SPI_MODE_LOOP;
+
+	th->freq = cpu_to_le32(xfer->speed_hz);
+
+	ret = spi_delay_to_ns(&xfer->word_delay, xfer);
+	if (ret < 0) {
+		dev_warn(dev, "Cannot convert word_delay\n");
+		goto msg_done;
+	}
+	th->word_delay_ns = cpu_to_le32((u32)ret);
+
+	ret = spi_delay_to_ns(&xfer->delay, xfer);
+	if (ret < 0) {
+		dev_warn(dev, "Cannot convert delay\n");
+		goto msg_done;
+	}
+	th->cs_setup_ns = cpu_to_le32((u32)ret);
+	th->cs_delay_hold_ns = cpu_to_le32((u32)ret);
+
+	/* This is the "off" time when CS has to be deasserted for a moment */
+	ret = spi_delay_to_ns(&xfer->cs_change_delay, xfer);
+	if (ret < 0) {
+		dev_warn(dev, "Cannot convert cs_change_delay\n");
+		goto msg_done;
+	}
+	th->cs_change_delay_inactive_ns = cpu_to_le32((u32)ret);
+
+	/*
+	 * With the way it's specified in the virtio draft specification
+	 * V4 the virtio device just MUST print a warning and ignores the delay
+	 * timing settings it does not support.
+	 * Implementation decision: Only warn once not to flood the logs.
+	 * TODO: Comment on this
+	 * By the wording of the speciification it is unclear which timings
+	 * exactly are affected, there is a copy & paste mistake in the spec.
+	 * TODO: Comment on this
+	 * Somewhat unclear is whether the values in question are to be
+	 * passed as is to the virtio device.
+	 *
+	 * Probably better specification for the device:
+	 *   The device shall reject a message if tbd delay timing is not
+	 *   supported but the requested value is not zero by some tbd error.
+	 * Probably better specification for the driver:
+	 *   If the device did not announce support of delay timings in the
+	 *   config space the driver SHOULD not sent a delay timing not equal to
+	 *   zero but should immediately reject the message.
+	 */
+	if (!priv->support_delays) {
+		if (th->word_delay_ns)
+			dev_warn_once(dev, "word_delay_ns != 0\n");
+		if (th->cs_setup_ns)
+			dev_warn_once(dev, "cs_setup_ns != 0\n");
+		if (th->cs_change_delay_inactive_ns)
+			dev_warn_once(dev,
+				      "cs_change_delay_inactive_ns != 0\n");
+	}
+
+	/* Set buffers */
+	spi_req->tx_buf = xfer->tx_buf;
+	spi_req->rx_buf = xfer->rx_buf;
+#ifdef DEBUG
+	spi_req->rx_len = xfer->len;
+#endif
+
+	/* Prepare sending of virtio message */
+	init_completion(&spi_req->completion);
+
+	sg_init_one(&sg_out_head, &spi_req->transfer_head,
+		    sizeof(struct spi_transfer_head));
+	sgs[outcnt] = &sg_out_head;
+
+	pr_debug("sgs[%u] len = %u", outcnt + incnt,
+		 sgs[outcnt + incnt]->length);
+	pr_debug("Dump of spi_transfer_head\n");
+	print_hex_dump_debug(KBUILD_MODNAME " ", DUMP_PREFIX_NONE, 16, 1,
+			     &spi_req->transfer_head,
+			     sizeof(struct spi_transfer_head), true);
+	outcnt++;
+
+	if (spi_req->tx_buf) {
+		sg_init_one(&sg_out_payload, spi_req->tx_buf, xfer->len);
+		sgs[outcnt] = &sg_out_payload;
+		pr_debug("sgs[%u] len = %u", outcnt + incnt,
+			 sgs[outcnt + incnt]->length);
+		pr_debug("Dump of TX payload\n");
+		print_hex_dump_debug(KBUILD_MODNAME " ", DUMP_PREFIX_NONE, 16,
+				     1, spi_req->tx_buf, xfer->len, true);
+		outcnt++;
+	}
+
+	if (spi_req->rx_buf) {
+		sg_init_one(&sg_in_payload, spi_req->rx_buf, xfer->len);
+		sgs[outcnt + incnt] = &sg_in_payload;
+		pr_debug("sgs[%u] len = %u", outcnt + incnt,
+			 sgs[outcnt + incnt]->length);
+		incnt++;
+	}
+
+	sg_init_one(&sg_in_result, &spi_req->result,
+		    sizeof(struct spi_transfer_result));
+	sgs[outcnt + incnt] = &sg_in_result;
+	pr_debug("sgs[%u] len = %u", outcnt + incnt,
+		 sgs[outcnt + incnt]->length);
+	incnt++;
+
+	pr_debug("%s: outcnt=%u, incnt=%u\n", __func__, outcnt, incnt);
+
+	ret = virtqueue_add_sgs(vq, sgs, outcnt, incnt, spi_req, GFP_KERNEL);
+msg_done:
+	if (ret)
+		msg->status = ret;
+
+	return ret;
+}
+
+static int virtio_spi_transfer_one_message(struct spi_master *master,
+					   struct spi_message *msg)
+{
+	struct virtio_spi_priv *priv = spi_master_get_devdata(master);
+	struct virtqueue *vq = priv->vqs[VIRTIO_SPI_QUEUE_RQ];
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
+		ret = virtio_spi_one_transfer(spi_req, master, msg, xfer);
+		if (ret)
+			goto msg_done;
+
+		virtqueue_kick(vq);
+
+		wait_for_completion(&spi_req->completion);
+
+		/* Read result from message */
+		ret = (int)spi_req->result.result;
+		if (ret)
+			goto msg_done;
+
+#ifdef DEBUG
+		if (spi_req->rx_buf) {
+			pr_debug("Dump of RX payload\n");
+			print_hex_dump(KERN_DEBUG, KBUILD_MODNAME " ",
+				       DUMP_PREFIX_NONE, 16, 1, spi_req->rx_buf,
+				       spi_req->rx_len, true);
+		}
+#endif
+	}
+
+msg_done:
+	kfree(spi_req);
+no_mem:
+	msg->status = ret;
+	/*
+	 * Looking into other SPI drivers like spi-atmel.c the function
+	 * spi_finalize_current_message() is supposed to be called only once
+	 * for all transfers in the list and not for each single message
+	 */
+	spi_finalize_current_message(master);
+	dev_dbg(&priv->vdev->dev, "%s() returning %d\n", __func__, ret);
+	return ret;
+}
+
+static void virtio_spi_read_config(struct virtio_device *vdev)
+{
+	struct spi_master *master = dev_get_drvdata(&vdev->dev);
+	struct virtio_spi_priv *priv = vdev->priv;
+	u16 bus_num;
+	u16 cs_max_number;
+	u8 support_delays;
+
+	bus_num = virtio_cread16(vdev,
+				 offsetof(struct virtio_spi_config, bus_num));
+	cs_max_number = virtio_cread16(vdev, offsetof(struct virtio_spi_config,
+						      chip_select_max_number));
+	support_delays =
+		virtio_cread16(vdev, offsetof(struct virtio_spi_config,
+					      cs_timing_setting_enable));
+
+	if (bus_num > S16_MAX) {
+		dev_warn(&vdev->dev, "Limiting bus_num = %u to %d\n", bus_num,
+			 S16_MAX);
+		bus_num = S16_MAX;
+	}
+
+	if (support_delays > 1)
+		dev_warn(&vdev->dev, "cs_timing_setting_enable = %u\n",
+			 support_delays);
+	priv->support_delays = (support_delays != 0);
+	master->bus_num = (s16)bus_num;
+	master->num_chipselect = cs_max_number;
+}
+
+static int virtio_spi_find_vqs(struct virtio_spi_priv *priv)
+{
+	static const char *const io_names[VIRTIO_SPI_QUEUE_COUNT] = { "spi-rq" };
+
+	priv->io_callbacks[VIRTIO_SPI_QUEUE_RQ] = virtio_spi_msg_done;
+
+	/* Find the queues. */
+	return virtio_find_vqs(priv->vdev, VIRTIO_SPI_QUEUE_COUNT, priv->vqs,
+			       priv->io_callbacks, io_names, NULL);
+}
+
+/* Compare with i2c-virtio.c function virtio_i2c_del_vqs() */
+/* Function must not be called before virtio_spi_find_vqs() has been run */
+static void virtio_spi_del_vq(struct virtio_device *vdev)
+{
+	vdev->config->reset(vdev);
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
+	struct virtio_spi_priv *priv;
+	struct spi_master *master;
+	int err;
+	u16 csi;
+
+	err = -ENOMEM;
+	master = spi_alloc_master(&vdev->dev, sizeof(struct virtio_spi_priv));
+	if (!master) {
+		dev_err(&vdev->dev, "Kernel memory exhausted in %s()\n",
+			__func__);
+		goto err_return;
+	}
+
+	priv = spi_master_get_devdata(master);
+	priv->vdev = vdev;
+	vdev->priv = priv;
+	dev_set_drvdata(&vdev->dev, master);
+
+	/* the spi->mode bits understood by this driver: */
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
+			    SPI_LOOP | SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL |
+			    SPI_RX_QUAD | SPI_TX_OCTAL | SPI_RX_OCTAL;
+
+	/* What most support. We don't know from the virtio device side */
+	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 16);
+	/* There is no associated device tree node */
+	master->dev.of_node = NULL;
+	/* Get bus_num and num_chipselect from the config space */
+	virtio_spi_read_config(vdev);
+	/* Maybe this method is not needed for virtio SPI */
+	master->setup = NULL; /* Function not needed for virtio-spi */
+	/* No restrictions to announce */
+	master->flags = 0;
+	/* Method to transfer a single SPI message */
+	master->transfer_one_message = virtio_spi_transfer_one_message;
+	/* Method to cleanup the driver */
+	master->cleanup = NULL; /* Function not needed for virtio-spi */
+
+	/* Initialize virtqueues */
+	err = virtio_spi_find_vqs(priv);
+	if (err) {
+		dev_err(&vdev->dev, "Cannot setup virtqueues\n");
+		goto err_master_put;
+	}
+
+	err = spi_register_master(master);
+	if (err) {
+		dev_err(&vdev->dev, "Cannot register master\n");
+		goto err_master_put;
+	}
+
+	/* spi_new_device() currently does not use bus_num but better set it */
+	board_info.bus_num = (u16)master->bus_num;
+
+	/* Add chip selects to master device */
+	for (csi = 0; csi < master->num_chipselect; csi++) {
+		dev_info(&vdev->dev, "Setting up CS=%u\n", csi);
+		board_info.chip_select = csi;
+		if (!spi_new_device(master, &board_info)) {
+			dev_err(&vdev->dev, "Cannot setup device %u\n", csi);
+			goto err_unregister_master;
+		}
+	}
+
+	/* Request device going live */
+	virtio_device_ready(vdev); /* Optionally done by virtio_dev_probe() */
+
+	dev_info(&vdev->dev, "Device live!\n");
+
+	return 0;
+
+err_unregister_master:
+	spi_unregister_master(master);
+err_master_put:
+	spi_master_put(master);
+err_return:
+	return err;
+}
+
+static void virtio_spi_remove(struct virtio_device *vdev)
+{
+	struct spi_master *master = dev_get_drvdata(&vdev->dev);
+
+	virtio_spi_del_vq(vdev);
+	spi_unregister_master(master);
+}
+
+#ifdef CONFIG_PM_SLEEP
+/*
+ * Compare with i2c-virtio.c function virtio_i2c_freeze()
+ * and with spi-atmel.c function atmel_spi_suspend()
+ */
+static int virtio_spi_freeze(struct virtio_device *vdev)
+{
+	struct device *dev = &vdev->dev;
+	struct spi_master *master = dev_get_drvdata(dev);
+	int ret;
+
+	/* Stop the queue running */
+	ret = spi_master_suspend(master);
+	if (ret) {
+		dev_warn(dev, "cannot suspend master (%d)\n", ret);
+		return ret;
+	}
+
+	virtio_spi_del_vq(vdev);
+	return 0;
+}
+
+/*
+ * Compare with i2c-virtio.c function virtio_i2c_restore()
+ * and with spi-atmel.c function atmel_spi_resume()
+ */
+static int virtio_spi_restore(struct virtio_device *vdev)
+{
+	struct device *dev = &vdev->dev;
+	struct spi_master *master = dev_get_drvdata(dev);
+	int ret;
+
+	/* Start the queue running */
+	ret = spi_master_resume(master);
+	if (ret)
+		dev_err(dev, "problem starting queue (%d)\n", ret);
+
+	return virtio_spi_find_vqs(vdev->priv);
+}
+#endif
+
+static struct virtio_device_id virtio_spi_id_table[] = {
+	{ VIRTIO_ID_SPI, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+
+static struct virtio_driver virtio_spi_driver = {
+	.feature_table = NULL,
+	.feature_table_size = 0u,
+	.driver.name = KBUILD_MODNAME,
+	.driver.owner = THIS_MODULE,
+	.id_table = virtio_spi_id_table,
+	.validate = virtio_spi_validate,
+	.probe = virtio_spi_probe,
+	.remove = virtio_spi_remove,
+	.config_changed = NULL,
+#ifdef CONFIG_PM_SLEEP
+	.freeze = virtio_spi_freeze,
+	.restore = virtio_spi_restore,
+#endif
+};
+
+module_virtio_driver(virtio_spi_driver);
+MODULE_DEVICE_TABLE(virtio, virtio_spi_id_table);
+
+MODULE_AUTHOR("OpenSynergy GmbH");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SPI bus driver for Virtio SPI");
-- 
2.25.1

