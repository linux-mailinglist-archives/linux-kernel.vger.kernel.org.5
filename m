Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEDB810D09
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 10:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjLMJJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 04:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjLMJJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 04:09:20 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2070.outbound.protection.outlook.com [40.107.249.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE38AD;
        Wed, 13 Dec 2023 01:09:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNrXG0WmTHn6CZuwJAXUoH7UpVYelM47OewZfY+TPHuwE6QCCiKHHH7c2tjNXLIQppJ7DSrF/xv9fWuq8k9+g9zkH1rPrCFU5UyqG6CfL0VfKfv2GBgVo/INO4Daq45W3xCC9Vu5xdYY+WOwq+UYlrmwiDhzNWRmCHaBiIK5ZzatCVqQ+ntuHnkKuo2V6nl7WGbEZTpdZ4MLbPahvZQQ0YvoWq+ACQfXYVTj0WxWGogol7ADiJUNQZW9Cj06LPj/FJ0vfMoxbQ9s7j2aRCtBbgHYJJFYPOC7NW0K325CVsNK7HmJNf+miOpSWqd12NaRVhrlZ0Ut3VNyd1cJXVtXJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zFpN/3kJ927lymW58oF6ZQARggZE7jGV18xhqSu+6U=;
 b=XdbxXIH0Fv7QEBgMK2dsi9LTWYzv3LcKhVddEruo8QLD6OePCZXVbY/1wOUQMRXVXwHQ/V/bguWalMmocFO/OIihJokoB72TmVOkHlpMr0ZpetDmVdty/m33ClmWr0XEGy1OrJUW1aCWb0GWSjHjL3sn/CKfXrScGt/giW4vZnAo55z1KnYQGyyelcjOVtBmQrbVTU+RYSmBsPyyJUJU3Etite1xZXkBv9zJaZOwPjt6LCQKAqXdfyPA7kAq6Tk82f3owwCUWbZrWBS6yqA3UOcx9PsiesUwY5EBeuZLaa+LQKhzvSnp/XW2DodzR7owVbAiBKVfGiS3HmQYO2ygQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=bestguesspass action=none header.from=topic.nl; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zFpN/3kJ927lymW58oF6ZQARggZE7jGV18xhqSu+6U=;
 b=PHAbtGX3vmHmB67qNGC/uT8kwULcRxHAug7ZVpp9L+TIKmwrU8GD5WuoFNqdFm7IYTFXNeEhzLRkg5U29HnUbmfR6YirBWPIuVZBU5bICKrXXllQZWRwO8PugXBsF4ZSjGzvxeQsweRyjj3ToM+6M/XgmCmQ0tt2piLItsQRHEaN5rIS4DkGN7a3yRPXuEpXVVJ+fEk5xLxKBmdhE0fLAzOj8VgQ+wMCvOvApfngqh4OVloi5zu6wkQ6JqE3GJ2Kv0lxSv+bNt/JLi3X7mtfiKnD9USxYY7is6geRsP/EbGgcfh4CpCJEu6vSMzWJvZpYmn0F+E5lBoyXTAADZGzow==
Received: from FR3P281CA0054.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4a::18)
 by DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 09:09:23 +0000
Received: from VE1EUR01FT077.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:4a:cafe::f5) by FR3P281CA0054.outlook.office365.com
 (2603:10a6:d10:4a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.21 via Frontend
 Transport; Wed, 13 Dec 2023 09:09:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 VE1EUR01FT077.mail.protection.outlook.com (10.152.3.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.18 via Frontend Transport; Wed, 13 Dec 2023 09:09:23 +0000
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (104.47.30.105) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 13 Dec 2023 09:09:22 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from VE1PR04MB7471.eurprd04.prod.outlook.com (2603:10a6:800:1a7::11)
 by AM9PR04MB8194.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 09:09:18 +0000
Received: from VE1PR04MB7471.eurprd04.prod.outlook.com
 ([fe80::ec21:cf04:ed05:c7b1]) by VE1PR04MB7471.eurprd04.prod.outlook.com
 ([fe80::ec21:cf04:ed05:c7b1%4]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 09:09:18 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        Andrea Collamati <andrea.collamati@gmail.com>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: spi-dac: Add driver for SPI shift register DACs
Date:   Wed, 13 Dec 2023 10:09:10 +0100
Message-ID: <20231213090910.25410-2-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213090910.25410-1-mike.looijmans@topic.nl>
References: <20231213090910.25410-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.23e530d1-f5da-4919-8889-d7109d21097b@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0021.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::31) To VE1PR04MB7471.eurprd04.prod.outlook.com
 (2603:10a6:800:1a7::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VE1PR04MB7471:EE_|AM9PR04MB8194:EE_|VE1EUR01FT077:EE_|DU2PR04MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: c76557e9-aef8-47a6-0c98-08dbfbbb32d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ZEL0EEzDsT2UmCJVdKGArgG1blRmI3HtkzNgQFbTXcRqyrwSoYjBv0FS5rczxtZ3YK095yZc79N9h1Pi5Qo5GFzUZV1YUm9eMeiSr7HjQ9Cq/i7VxbL3EaMc4gp6TSmdrhcbJtbU4iE5ubL45rIJ3V+sI1iUK4gbfUGdu50BWjKEgAo3zXju4fkR5+iOJ6xemKwdz5F24NT+yUiVyxQ3AvKsEDxIFz4dEnQuCkfpy75MligTJTS3hPvgky3n1jLwH/E0S+gMcDlqiMNZx9oqtNHryzcjrFaGeygLQ2jU9+W5lZ7HhoYhnBfAdQQ+IuFOgj1aL/dhjYsEU/3KcUpiGk627KOYAnDzGn8bz4aFjD/jlTjRumlsWJD9cYfqwjOpbnYNnVKNyv8KmnwwBtC58YTvD1QzguJcWRlNpbQUeP5e5yerlL0jgxj5fYChqip8ODUwDRrZktv7C5MM+zp/ioa4RyPskU1G3yKEqfbJetDWJzUk94vC0B2LJQ6IjkBEarCBi90zfOOIO14b63nEJZ7/0avMJJphwTaj0HEyIysMAIC50U06s2A648dp6yMGOTVgLeBs36uvqr5copnkwRu3gkuAeyDQcWI/OLb8J5fYeKfQ3fZ3Y79ai95TiKbf
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7471.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(39840400004)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2616005)(83380400001)(26005)(38100700002)(44832011)(8936002)(316002)(54906003)(8676002)(2906002)(5660300002)(7416002)(4326008)(66476007)(478600001)(52116002)(41300700001)(6512007)(6666004)(6506007)(66556008)(6486002)(66946007)(1076003)(38350700005)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8194
X-CodeTwo-MessageID: e76d5a6c-a58d-47d0-ba7f-fb9ea0e39155.20231213090922@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT077.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 297872ce-b299-46b1-52fa-08dbfbbb2f9a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fKOes0ydokEZqbfp/a9NJBvf43vHwo9TVUCChPPKF5vCzKPhWnJn9a9/u+sNvI6Y1PqbgYJiOkWBQe6HJzKFLEgfUENO/OTx5phm4BM1bZF/EXIfbfP9ChbZhO1DlMnlZw9qhSVqIqSyYyriymWBFzkobaOf7ot4hgqALaY5ImlWDppOkKAb9u40kZSU9GORmy6XO5IobXPoDQmitkeRgtisv3+P3+ZnKqnmjq/FsgArTIoxj3ifDkhrxwzxW9rnNpwJcyvvfdhyIoGFXhuwfp2JoYBR8ODUP2KM4uEpozc3cF0kBEPXiT7JiA5hpt2dChinweHUmiVtqx+g9J9za0OZSYJtwDCjA3j2RKALePJlX4Vnbb3gP6SR3EYx00SPzfQCitA+VdcMVdfPdhVWSvwRG+HX/nhsgPyVC9rqBuxdhyqar8j6a+8VqNcL7nke01wWqYoHCbttrbPzYR9cUmbw6AoqbfB7viz/TvfBgz74YWGQlm9qXiq5oOeaNMtoPHJJ5VcHi5i5WMqvqx7ICJAOCofP7qk46PvbPRC152/VBLZISnhw1dtL7/RbQ0hU2pEVDCROMFMHOgXwwB1olji8LWLNioRqM6igYYG947PHuCiP4Zj859KE+WgSuGHCAfgH6uzyWRZ0NqXwWBIAfMJzXviYUUbWOySMFVtZ7FsnQkrcJ4ufYoCBbVZEUdmo/ZoMZmIo9T2ko6O3YzUemw==
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39830400003)(346002)(376002)(136003)(230922051799003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(46966006)(36840700001)(2616005)(1076003)(26005)(336012)(6506007)(6512007)(6666004)(36860700001)(47076005)(83380400001)(5660300002)(8676002)(7416002)(44832011)(4326008)(8936002)(41300700001)(2906002)(6486002)(478600001)(316002)(70206006)(54906003)(70586007)(15974865002)(86362001)(7636003)(7596003)(356005)(36756003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 09:09:23.0014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c76557e9-aef8-47a6-0c98-08dbfbbb32d2
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT077.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8774
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for generic serial shift register DACs like TI DAC714.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

 drivers/iio/dac/Kconfig   |  11 ++
 drivers/iio/dac/Makefile  |   1 +
 drivers/iio/dac/spi-dac.c | 212 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 224 insertions(+)
 create mode 100644 drivers/iio/dac/spi-dac.c

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 93b8be183de6..bb35d901ee57 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -410,6 +410,17 @@ config MCP4922
 	  To compile this driver as a module, choose M here: the module
 	  will be called mcp4922.
=20
+config SPI_DAC
+	tristate "SPI shift register DAC driver"
+	depends on SPI
+	help
+	  Driver for an array of shift-register DACs, like the TI DAC714.
+	  The driver shifts the DAC values into the registers in a SPI
+	  transfer, then optionally toggles a GPIO to latch the values.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called spi-dac.
+
 config STM32_DAC
 	tristate "STMicroelectronics STM32 DAC"
 	depends on (ARCH_STM32 && OF) || COMPILE_TEST
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 5b2bac900d5a..33748799b0f0 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_MCP4728) +=3D mcp4728.o
 obj-$(CONFIG_MCP4922) +=3D mcp4922.o
 obj-$(CONFIG_STM32_DAC_CORE) +=3D stm32-dac-core.o
 obj-$(CONFIG_STM32_DAC) +=3D stm32-dac.o
+obj-$(CONFIG_SPI_DAC) +=3D spi-dac.o
 obj-$(CONFIG_TI_DAC082S085) +=3D ti-dac082s085.o
 obj-$(CONFIG_TI_DAC5571) +=3D ti-dac5571.o
 obj-$(CONFIG_TI_DAC7311) +=3D ti-dac7311.o
diff --git a/drivers/iio/dac/spi-dac.c b/drivers/iio/dac/spi-dac.c
new file mode 100644
index 000000000000..0c0113d51604
--- /dev/null
+++ b/drivers/iio/dac/spi-dac.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SPI generic shift register Serial input Digital-to-Analog Converter
+ * For example, TI DAC714
+ *
+ * Copyright 2023 Topic Embedded Systems
+ */
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/iio.h>
+
+struct spidac {
+	struct spi_device *spi;
+	struct gpio_desc *loaddacs;
+	u8 *data; /* SPI buffer */
+	u32 data_size;
+	/* Protect the data buffer and update sequence */
+	struct mutex lock;
+};
+
+static int spidac_cmd_single(struct spidac *priv,
+			     const struct iio_chan_spec *chan, int val)
+{
+	u8 *data =3D priv->data + chan->address;
+	unsigned int bytes =3D chan->scan_type.storagebits >> 3;
+	int ret;
+	unsigned int i;
+
+	/* Write big-endian value into data */
+	data +=3D bytes - 1;
+	for (i =3D 0; i < bytes; i++, val >>=3D 8, data--)
+		*data =3D val & 0xff;
+
+	ret =3D spi_write(priv->spi, priv->data, priv->data_size);
+	if (ret)
+		return ret;
+
+	gpiod_set_value(priv->loaddacs, 1);
+	udelay(1);
+	gpiod_set_value(priv->loaddacs, 0);
+
+	return 0;
+}
+
+static int spidac_decode(struct spidac *priv, const struct iio_chan_spec *=
chan)
+{
+	u8 *data =3D priv->data + chan->address;
+	unsigned int bytes =3D chan->scan_type.storagebits >> 3;
+	unsigned int i;
+	int val =3D 0;
+
+	/* Read big-endian value from data */
+	for (i =3D 0; i < bytes; i++, data++)
+		val =3D (val << 8) | *data;
+
+	return val;
+}
+
+static int spidac_read_raw(struct iio_dev *iio_dev,
+			    const struct iio_chan_spec *chan,
+			    int *val, int *val2, long mask)
+{
+	struct spidac *priv;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		priv =3D iio_priv(iio_dev);
+
+		mutex_lock(&priv->lock);
+		*val =3D spidac_decode(priv, chan);
+		mutex_unlock(&priv->lock);
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val =3D 1;
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int spidac_write_raw(struct iio_dev *iio_dev,
+			     const struct iio_chan_spec *chan,
+			     int val, int val2, long mask)
+{
+	struct spidac *priv =3D iio_priv(iio_dev);
+	int ret;
+
+	if (mask !=3D IIO_CHAN_INFO_RAW)
+		return -EINVAL;
+
+	mutex_lock(&priv->lock);
+	ret =3D spidac_cmd_single(priv, chan, val);
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
+static const struct iio_info spidac_info =3D {
+	.read_raw =3D spidac_read_raw,
+	.write_raw =3D spidac_write_raw,
+};
+
+static int spidac_probe(struct spi_device *spi)
+{
+	struct iio_dev *iio_dev;
+	struct spidac *priv;
+	struct iio_chan_spec *channels;
+	struct gpio_desc *reset_gpio;
+	u32 num_channels;
+	u32 bits_per_channel;
+	u32 bytes_per_channel;
+	u32 i;
+
+	iio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*priv));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	priv =3D iio_priv(iio_dev);
+	priv->loaddacs =3D devm_gpiod_get_optional(&spi->dev, "ldac",
+						 GPIOD_OUT_LOW);
+	if (IS_ERR(priv->loaddacs))
+		return PTR_ERR(priv->loaddacs);
+
+	reset_gpio =3D devm_gpiod_get_optional(&spi->dev, "reset",
+					     GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpio))
+		return PTR_ERR(reset_gpio);
+
+	priv->spi =3D spi;
+	spi_set_drvdata(spi, iio_dev);
+	num_channels =3D 1;
+	bits_per_channel =3D 16;
+
+	device_property_read_u32(&spi->dev, "num-channels", &num_channels);
+	device_property_read_u32(&spi->dev, "bits-per-channel",
+				 &bits_per_channel);
+	bytes_per_channel =3D DIV_ROUND_UP(bits_per_channel, 8);
+
+	channels =3D devm_kcalloc(&spi->dev, num_channels, sizeof(*channels),
+				GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	priv->data_size =3D num_channels * bytes_per_channel;
+	priv->data =3D devm_kzalloc(&spi->dev, priv->data_size,
+				  GFP_KERNEL | GFP_DMA);
+	if (!priv->data)
+		return -ENOMEM;
+
+	for (i =3D 0; i < num_channels; i++) {
+		struct iio_chan_spec *chan =3D &channels[i];
+
+		chan->type =3D IIO_VOLTAGE;
+		chan->indexed =3D 1;
+		chan->output =3D 1;
+		chan->channel =3D i;
+		chan->address =3D i * bytes_per_channel;
+		chan->info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW);
+		chan->info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SCALE);
+		chan->scan_type.sign =3D 's';
+		chan->scan_type.realbits =3D bits_per_channel;
+		chan->scan_type.storagebits =3D bits_per_channel;
+	}
+
+	iio_dev->info =3D &spidac_info;
+	iio_dev->modes =3D INDIO_DIRECT_MODE;
+	iio_dev->channels =3D channels;
+	iio_dev->num_channels =3D num_channels;
+	iio_dev->name =3D spi_get_device_id(spi)->name;
+
+	mutex_init(&priv->lock);
+
+	if (reset_gpio) {
+		udelay(1);
+		gpiod_set_value(reset_gpio, 0);
+	}
+
+	return devm_iio_device_register(&spi->dev, iio_dev);
+}
+
+static const struct spi_device_id spidac_id[] =3D {
+	{"spi-dac"},
+	{}
+};
+MODULE_DEVICE_TABLE(spi, spidac_id);
+
+static const struct of_device_id spidac_of_match[] =3D {
+	{ .compatible =3D "spi-dac" },
+	{ .compatible =3D "ti,dac714" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, spidac_of_match);
+
+static struct spi_driver spidac_driver =3D {
+	.driver =3D {
+		   .name =3D "spi-dac",
+		   .of_match_table =3D spidac_of_match,
+		   },
+	.probe =3D spidac_probe,
+	.id_table =3D spidac_id,
+};
+module_spi_driver(spidac_driver);
+
+MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
+MODULE_DESCRIPTION("SPI shift register DAC driver");
+MODULE_LICENSE("GPL");
--=20
2.34.1


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
