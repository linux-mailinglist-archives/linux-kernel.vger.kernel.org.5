Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B35B810E05
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjLMJrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 04:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbjLMJrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 04:47:35 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2083.outbound.protection.outlook.com [40.107.6.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC56F2;
        Wed, 13 Dec 2023 01:47:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WG2xhU9OXTZe4Wi8YG5/3uDWRjHjz86eWYOdjp+XXvZxo2C+pNxcL1mW//haIDNq5YHWktRz4w3uKZ6Yf+sgbnEgeeIt9AW3H10PZHqM8M8AeYPKp0kSKfCw/ZB8RXdDNz32N6lY0tlElfER1NtPsvyCxwGzzuDesYxIcTMS0KuVVfqOofi5eudtUUBw7VEfzIMOlrh8ClkBVKSM6i8NMO5GJ8a/iV8csjo67deI5bq9MuxlTorvXyJarwpGzNvpl/jUHxcaH4HphF7CJjl4smdKrtnRGrLWM6Gh++ueuFby3TZXTdLjjQ1sL3CJPV49mARxFS453k4mBS8KRaV+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7moYtjm6ua8iOYq6ISsmBsMxas4YK0woi9NeJ2mW7Zg=;
 b=RjQkmx6+aWms7GUOHX0DF2CK8HYcL2drLUZOuY8IvgqnmEirmRA6Vkb9Jogrv+4qx5qTpiBrEw0VoCEqBkI0zvUzRJKgrpKBp9l8OYUXiO762JKF1TqgGvqgbBsw9DSQKlVUVp8fD4rpY8JxpafpY7aI/BBncDJ0AyJrEYSDnE8xqTooLLBbKbOz/dQ5pAR6E4MzS/ibLzn4AGBRn3ORXFwyTTTfjGSMB81EATg1tHZRF7A/3zqC+hRfDkT9EKqx4GsfH5YKBWc7FiajKaj/MbMD4/ukcrRmCq+Ka5b+c7gG0mWYShPH3OHkg3QBNOA+BfhAmcPh+lmtWHGF6GgQPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=bestguesspass action=none header.from=topic.nl; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7moYtjm6ua8iOYq6ISsmBsMxas4YK0woi9NeJ2mW7Zg=;
 b=T+SGEY32hCejp6wnZhFT07Mno2Hz3ckIEPCWk98mYOU5bad5XJuA6rwJ2DOHyDtDuN7S4vygH9ijnOmewXtSo6wsOvIO5K01NJAckYhNq4kWBZV+x8T7w6QZfolptQVbi0r5n7Ms7KjowuHLmdJREnLK4lGuqx8EJbPhHWNXwgxSnS2q1M97l7jflJOeQkPg8BPWgk7Pz9PSuZo5TZ/AeklQe6fcd8dpUtKb0L9lMkL+9DBiPSHq6MIjOSeK0DWE2H2gjFoK8yobOI0U02I5VNNiR0uxUwz5shsLB8yL1VPCMT7daY5ukSr/AZpdVoh1KJj+u+/Wu7EdoaS6vt2H/w==
Received: from FR3P281CA0028.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1c::19)
 by PR3PR04MB7306.eurprd04.prod.outlook.com (2603:10a6:102:81::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 09:47:35 +0000
Received: from VE1EUR01FT052.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:1c:cafe::78) by FR3P281CA0028.outlook.office365.com
 (2603:10a6:d10:1c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 09:47:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 VE1EUR01FT052.mail.protection.outlook.com (10.152.3.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.21 via Frontend Transport; Wed, 13 Dec 2023 09:47:34 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.168) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 13 Dec 2023 09:47:33 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from VE1PR04MB7471.eurprd04.prod.outlook.com (2603:10a6:800:1a7::11)
 by PAXPR04MB8767.eurprd04.prod.outlook.com (2603:10a6:102:20e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 09:47:30 +0000
Received: from VE1PR04MB7471.eurprd04.prod.outlook.com
 ([fe80::ec21:cf04:ed05:c7b1]) by VE1PR04MB7471.eurprd04.prod.outlook.com
 ([fe80::ec21:cf04:ed05:c7b1%4]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 09:47:30 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee@kernel.org>,
        =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Liam Beguin <liambeguin@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Marius Cristea <marius.cristea@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Okan Sahin <okan.sahin@analog.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: adc: ti-ads1298: Add driver
Date:   Wed, 13 Dec 2023 10:47:22 +0100
Message-ID: <20231213094722.31547-2-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213094722.31547-1-mike.looijmans@topic.nl>
References: <20231213094722.31547-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.27993507-256d-4b05-88df-c8643e7f1a68@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0015.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::20) To VE1PR04MB7471.eurprd04.prod.outlook.com
 (2603:10a6:800:1a7::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VE1PR04MB7471:EE_|PAXPR04MB8767:EE_|VE1EUR01FT052:EE_|PR3PR04MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: 643c815f-4378-437a-33a9-08dbfbc08914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: UldDUQoX2Sz2wZl8ZLY4gRcJ9/XqBn+yoROGKfqO6FAkBiKmw31AQA8HWBLdztOAsgbYxyd+mzC0O/JnZ/4vzstMPpz9ShxFv3yrR5MC7lhniZeZ+6L6MgLp0B+ytPEDny3cJavdsen0Wk8SxhmjfCixnyWpnby7moIyD9R+NqABGIkBCu8NcEfcQJmrNl1L/9nvvadsceky/5G+hzmS5tEkPJIm7b+au6grp8C0aAkt8FjwYN8hFdL+mWLSZdqcjfSFZejMOWR+N7nTMr5ZlMC+sZD+/9cELhMkNNgTbpFlirhjVXFg6lwGaSf3MJDpcfX8onUakxvVp2+qBy02tiIaRNPp/eSLI7RqysESK6OAsDRUkg0G1Xmiq/noVxrw8sDYqqqR8N1Bv7C3HUY8tbEAgbFzT/Z/tDmB6JvwEPXMKTEaQ9FL1wBXzU8+HHHyGkwTwfETi8N1dFqom/M7QneuIzEQm10RkXUekWQbLEk1wHvbe3uh4zFsUTQ6K5rq/l6EJKtnr1rL0VtNF+ee9lWttswWX82kLJKqohtAXXUvBNYVKP079ZDE2c+OGQH/EyOHJea2WzwlydsJpc6q3O6Mt0yvEsNXcNVPgwm2kN1hklE1m+SVNFqjFqBjutRr4pLWy4Nys+kNt4Up/zU4Gf0rHAnm4g6yRK82o9ghDfI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7471.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(346002)(39840400004)(230173577357003)(230273577357003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(66556008)(2616005)(8936002)(4326008)(478600001)(8676002)(66946007)(316002)(66476007)(6486002)(54906003)(44832011)(6666004)(7416002)(6512007)(5660300002)(86362001)(30864003)(41300700001)(38350700005)(26005)(83380400001)(36756003)(6506007)(52116002)(38100700002)(2906002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8767
X-CodeTwo-MessageID: 6d2c58a9-9a70-4f5d-b4d6-41e9e6cbedb9.20231213094733@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT052.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8e9fc005-5a0b-44e4-3a5d-08dbfbc085bc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OSOArBEgczAkEE+Z3qt0nYhDpnHnAxOfmqWQ2F/enJid+plsDLaiD7Rn1t1KDh/96v+5n2L+rTX73psBu15hcggvA3NnyIJa3wjJg4zR7Nl6Q9cXcJTcbJM9uN4ZZ5H0gIiOSh7VEAkgydKQHY+A2VrsiQAEWkoCywdV8yOLYlFeukJuxSIMHhEKQCO2kZNPqHkbrE00zkD+73sOK0o/sSwapVe9ZUuEI2jDIz2FQZ3gMoPaTjJclfTu3Gcsbd4P3hPAQ7tUw+VU7dcJH3durDWdBEpPxgjvIfceUXtbEah/AfjYIwCi9vLlqe6unwTz6qpmq7yVXZY5GVLkd6/9fGryQsXuLvRD5Se5NdXJk+L78KqSAigXe0dQV6FqJzMeFEwGuRcP7GBVD+rWpHy940/lX4fdYDw20rYQCpXvU2FWlfEPr641Q7Y1jVLhn75+CPCehfUXxbBfoimGJn3e9bOeIuxH0pf1beatO2RWuL73dxr30vBRqwUiiBYfWaACLH3k0LXkhQQF78jAYAUAFuWLAqWjttGAbYhT40qMBvesoKyZkkGqLMUUDXgNn+YPhNEAF09XYC4FR9Vg85W1bd5jl8kkKFnMjUAAGbRi3x4i5f+GErX78olLYqLyuItQOLvZVuG4y3oFsiI6oIbhym9lK6Ta5Pt12/Uqms05hu7OpmYPvKZAFGRg+sEpQACqCjlYJyCv49jL7kxucySqPRgsGYej9FYvJZXUT5cF9AKX5D0Y3SqxDkEHqvGkAWa0
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39840400004)(346002)(376002)(230173577357003)(230273577357003)(230922051799003)(82310400011)(64100799003)(1800799012)(451199024)(186009)(36840700001)(46966006)(15974865002)(36756003)(86362001)(40480700001)(2616005)(6666004)(6512007)(6506007)(41300700001)(70586007)(70206006)(6486002)(1076003)(7596003)(7636003)(356005)(336012)(26005)(83380400001)(47076005)(7416002)(30864003)(5660300002)(54906003)(2906002)(8676002)(478600001)(4326008)(36860700001)(44832011)(8936002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 09:47:34.9996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 643c815f-4378-437a-33a9-08dbfbc08914
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT052.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7306
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skeleton driver for the TI ADS1298 medical ADC. This device is
typically used for ECG and similar measurements. Supports data
acquisition at configurable scale and sampling frequency.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

 drivers/iio/adc/Kconfig      |  12 +
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/ti-ads1298.c | 740 +++++++++++++++++++++++++++++++++++
 3 files changed, 753 insertions(+)
 create mode 100644 drivers/iio/adc/ti-ads1298.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 35f9867da12c..57ccbf347828 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1318,6 +1318,18 @@ config TI_ADS8688
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-ads8688.
=20
+config TI_ADS1298
+	tristate "Texas Instruments ADS1298"
+	depends on SPI
+	select IIO_BUFFER
+	default y
+	help
+	  If you say yes here you get support for Texas Instruments ADS1298
+	  medical ADC chips
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ti-ads1298.
+
 config TI_ADS124S08
 	tristate "Texas Instruments ADS124S08"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index bee11d442af4..ff0e3633eded 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -117,6 +117,7 @@ obj-$(CONFIG_TI_ADS7924) +=3D ti-ads7924.o
 obj-$(CONFIG_TI_ADS7950) +=3D ti-ads7950.o
 obj-$(CONFIG_TI_ADS8344) +=3D ti-ads8344.o
 obj-$(CONFIG_TI_ADS8688) +=3D ti-ads8688.o
+obj-$(CONFIG_TI_ADS1298) +=3D ti-ads1298.o
 obj-$(CONFIG_TI_ADS124S08) +=3D ti-ads124s08.o
 obj-$(CONFIG_TI_ADS131E08) +=3D ti-ads131e08.o
 obj-$(CONFIG_TI_AM335X_ADC) +=3D ti_am335x_adc.o
diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
new file mode 100644
index 000000000000..54466285063f
--- /dev/null
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -0,0 +1,740 @@
+// SPDX-License-Identifier: GPL-2.0
+/* TI ADS1298 chip family driver
+ * Copyright (C) 2023 Topic Embedded Products
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+
+#include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/iio/sysfs.h>
+
+#include <asm/unaligned.h>
+
+#define ADS1298_WAKEUP  0x02
+#define ADS1298_STANDBY 0x04
+#define ADS1298_RESET   0x06
+#define ADS1298_START   0x08
+#define ADS1298_STOP    0x0A
+#define ADS1298_RDATAC  0x10
+#define ADS1298_SDATAC  0x11
+#define ADS1298_RDATA   0x12
+
+/* Commands */
+#define ADS1298_CMD_WAKEUP	0x02
+#define ADS1298_CMD_STANDBY	0x04
+#define ADS1298_CMD_RESET	0x06
+#define ADS1298_CMD_START	0x08
+#define ADS1298_CMD_STOP	0x0a
+#define ADS1298_CMD_RDATAC	0x10
+#define ADS1298_CMD_SDATAC	0x11
+#define ADS1298_CMD_RDATA	0x12
+#define ADS1298_CMD_RREG	0x20
+#define ADS1298_CMD_WREG	0x40
+
+/* Registers */
+#define ADS1298_REG_ID		0x00
+#define ADS1298_REG_CONFIG1	0x01
+#define ADS1298_MASK_CONFIG1_HR			BIT(7)
+#define ADS1298_MASK_CONFIG1_DR			0x07
+#define ADS1298_REG_CONFIG2	0x02
+#define ADS1298_MASK_CONFIG2_RESERVED		BIT(6)
+#define ADS1298_MASK_CONFIG2_WCT_CHOP		BIT(5)
+#define ADS1298_MASK_CONFIG2_INT_TEST		BIT(4)
+#define ADS1298_MASK_CONFIG2_TEST_AMP		BIT(2)
+#define ADS1298_MASK_CONFIG2_TEST_FREQ_DC	GENMASK(1, 0)
+#define ADS1298_MASK_CONFIG2_TEST_FREQ_SLOW	0
+#define ADS1298_MASK_CONFIG2_TEST_FREQ_FAST	BIT(0)
+#define ADS1298_REG_CONFIG3	0x03
+#define ADS1298_MASK_CONFIG3_PWR_REFBUF		BIT(7)
+#define ADS1298_MASK_CONFIG3_RESERVED		BIT(6)
+#define ADS1298_MASK_CONFIG3_VREF_4V		BIT(5)
+#define ADS1298_REG_LOFF	0x04
+#define ADS1298_REG_CHnSET(n)	(0x05 + n)
+#define ADS1298_MASK_CH_PD		BIT(7)
+#define ADS1298_MASK_CH_PGA		GENMASK(6, 4)
+#define ADS1298_MASK_CH_MUX		GENMASK(2, 0)
+#define ADS1298_REG_LOFF_STATP	0x12
+#define ADS1298_REG_LOFF_STATN	0x13
+
+#define ADS1298_REG_CONFIG4	0x17
+#define ADS1298_MASK_CONFIG4_SINGLE_SHOT	BIT(3)
+#define ADS1298_REG_WCT1	0x18
+#define ADS1298_REG_WCT2	0x19
+
+#define ADS1298_MAX_CHANNELS	8
+#define ADS1298_CLK_RATE	2048000
+/*
+ * Read/write register commands require 4 clocks to decode, for speeds abo=
ve
+ * 2x the clock rate, this would require extra time between the command by=
te and
+ * the data. Much simpler is to just limit the SPI transfer speed while do=
ing
+ * register access.
+ */
+#define ADS1298_SPI_BUS_SPEED_SLOW	ADS1298_CLK_RATE
+/* For reading and writing registers, we need a 3-byte buffer */
+#define ADS1298_SPI_CMD_BUFFER_SIZE	3
+/* Outputs status word and 8 samples of 24 bits each, plus the command byt=
e */
+#define ADS1298_SPI_RDATA_BUFFER_SIZE	((ADS1298_MAX_CHANNELS + 1) * 3 + 1)
+
+struct ads1298_private {
+	const struct ads1298_chip_info	*chip_info;
+	struct spi_device *spi;
+	struct regulator *reg_avdd;
+	struct regulator *reg_vref;
+	struct clk *clk;
+	struct regmap *regmap;
+	struct completion completion;
+	struct iio_trigger *trig;
+	struct spi_transfer rdata_xfer;
+	struct spi_message rdata_msg;
+	spinlock_t irq_busy_lock; /* Handshake between SPI and DRDY irqs */
+	bool rdata_xfer_busy;
+
+	/* Temporary storage for demuxing data after SPI transfer */
+	u8 bounce_buffer[ADS1298_MAX_CHANNELS * 4];
+
+	/* For synchronous SPI exchanges (read/write registers) */
+	u8 cmd_buffer[ADS1298_SPI_CMD_BUFFER_SIZE] ____cacheline_aligned;
+
+	/* Buffer used for incoming SPI data */
+	u8 rx_buffer[ADS1298_SPI_RDATA_BUFFER_SIZE] ____cacheline_aligned;
+	/* Contains the RDATA command and zeroes to clock out */
+	u8 tx_buffer[ADS1298_SPI_RDATA_BUFFER_SIZE] ____cacheline_aligned;
+};
+
+#define ADS1298_CHAN(index)					\
+{								\
+	.type =3D IIO_VOLTAGE,					\
+	.indexed =3D 1,						\
+	.channel =3D index,					\
+	.address =3D 3 * index + 4,				\
+	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |		\
+			      BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+				   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
+	.scan_index =3D index,					\
+	.scan_type =3D {						\
+		.sign =3D 's',					\
+		.realbits =3D 24,					\
+		.storagebits =3D 32,				\
+		.endianness =3D IIO_BE,				\
+	},							\
+}
+
+static const struct iio_chan_spec ads1298_channels[] =3D {
+	ADS1298_CHAN(0),
+	ADS1298_CHAN(1),
+	ADS1298_CHAN(2),
+	ADS1298_CHAN(3),
+	ADS1298_CHAN(4),
+	ADS1298_CHAN(5),
+	ADS1298_CHAN(6),
+	ADS1298_CHAN(7),
+};
+
+static int ads1298_write_cmd(struct ads1298_private *priv, u8 command)
+{
+	struct spi_transfer cmd_xfer =3D {
+		.tx_buf =3D priv->cmd_buffer,
+		.rx_buf =3D priv->cmd_buffer,
+		.len =3D 1,
+		.speed_hz =3D ADS1298_SPI_BUS_SPEED_SLOW,
+		.delay.value =3D 2,
+		.delay.unit =3D SPI_DELAY_UNIT_USECS,
+	};
+
+	priv->cmd_buffer[0] =3D command;
+
+	return spi_sync_transfer(priv->spi, &cmd_xfer, 1);
+}
+
+static int ads1298_read_one(struct ads1298_private *priv, int chan_index)
+{
+	int ret;
+
+	/* Enable the channel  */
+	ret =3D regmap_update_bits(priv->regmap, ADS1298_REG_CHnSET(chan_index),
+				 ADS1298_MASK_CH_PD, 0);
+	if (ret)
+		return ret;
+
+	/* Enable single-shot mode, so we don't need to send a STOP */
+	ret =3D regmap_update_bits(priv->regmap, ADS1298_REG_CONFIG4,
+				 ADS1298_MASK_CONFIG4_SINGLE_SHOT,
+				 ADS1298_MASK_CONFIG4_SINGLE_SHOT);
+	if (ret)
+		return ret;
+
+	reinit_completion(&priv->completion);
+
+	ret =3D ads1298_write_cmd(priv, ADS1298_CMD_START);
+	if (ret < 0) {
+		dev_err(&priv->spi->dev, "CMD_START error: %d\n", ret);
+		return ret;
+	}
+
+	/* Cannot take longer than 40ms (250Hz) */
+	ret =3D wait_for_completion_timeout(&priv->completion,
+					  msecs_to_jiffies(50));
+	if (!ret)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int ads1298_get_samp_freq(struct ads1298_private *priv, int *val)
+{
+	unsigned long rate;
+	int ret;
+	unsigned int cfg;
+
+	ret =3D regmap_read(priv->regmap, ADS1298_REG_CONFIG1, &cfg);
+	if (ret)
+		return ret;
+
+	if (priv->clk)
+		rate =3D clk_get_rate(priv->clk);
+	else
+		rate =3D ADS1298_CLK_RATE;
+	if (!rate)
+		return -EINVAL;
+
+	if (cfg & ADS1298_MASK_CONFIG1_HR)
+		rate >>=3D 6; /* HR mode */
+	else
+		rate >>=3D 7; /* LP mode */
+
+	*val =3D rate >> (cfg & ADS1298_MASK_CONFIG1_DR);
+
+	return IIO_VAL_INT;
+}
+
+static int ads1298_set_samp_freq(struct ads1298_private *priv, int val)
+{
+	unsigned long rate;
+	unsigned int factor;
+	unsigned int cfg;
+
+	if (priv->clk)
+		rate =3D clk_get_rate(priv->clk);
+	else
+		rate =3D ADS1298_CLK_RATE;
+	if (!rate)
+		return -EINVAL;
+
+	factor =3D (rate >> 6) / val;
+	if (factor >=3D 128) {
+		cfg =3D 0x06; /* Lowest frequency possible, must use LR mode */
+	} else if (factor <=3D 1) {
+		cfg =3D ADS1298_MASK_CONFIG1_HR; /* Fastest possible */
+	} else {
+		cfg =3D fls(factor) - 1;
+		cfg |=3D ADS1298_MASK_CONFIG1_HR; /* Use HR mode */
+	}
+
+	return regmap_update_bits(priv->regmap, ADS1298_REG_CONFIG1,
+			ADS1298_MASK_CONFIG1_HR | ADS1298_MASK_CONFIG1_DR,
+			cfg);
+}
+
+static const u8 ads1298_pga_settings[] =3D { 6, 1, 2, 3, 4, 8, 12 };
+
+static int ads1298_get_scale(struct ads1298_private *priv,
+			     int channel, int *val, int *val2)
+{
+	int ret;
+	unsigned int regval;
+	u8 gain;
+
+	if (priv->reg_vref) {
+		ret =3D regulator_get_voltage(priv->reg_vref);
+		if (ret < 0)
+			return ret;
+
+		*val =3D ret / 1000; /* Convert to millivolts */
+	} else {
+		ret =3D regmap_read(priv->regmap, ADS1298_REG_CONFIG3, &regval);
+		if (ret)
+			return ret;
+
+		/* Refererence in millivolts */
+		*val =3D regval & ADS1298_MASK_CONFIG3_VREF_4V ? 4000 : 2400;
+	}
+
+	ret =3D regmap_read(priv->regmap, ADS1298_REG_CHnSET(channel), &regval);
+	if (ret)
+		return ret;
+
+	gain =3D ads1298_pga_settings[FIELD_GET(ADS1298_MASK_CH_PGA, regval)];
+	*val /=3D gain; /* Full scale is VREF / gain */
+
+	*val2 =3D 23; /* Signed 24-bit, max amplitude is 2^23 */
+
+	return IIO_VAL_FRACTIONAL_LOG2;
+}
+
+
+static int ads1298_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct ads1298_private *priv =3D iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		/* When busy, just peek in the buffer */
+		if (!iio_buffer_enabled(indio_dev)) {
+			ret =3D ads1298_read_one(priv, chan->scan_index);
+			if (ret)
+				return ret;
+		}
+		*val =3D sign_extend32(get_unaligned_be24(
+					priv->rx_buffer + chan->address), 23);
+		ret =3D IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		ret =3D ads1298_get_scale(priv, chan->channel, val, val2);
+		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret =3D ads1298_get_samp_freq(priv, val);
+		break;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		ret =3D regmap_read(priv->regmap, ADS1298_REG_CONFIG1, val);
+		if (!ret) {
+			ret =3D IIO_VAL_INT;
+			*val =3D (16 << (*val & ADS1298_MASK_CONFIG1_DR));
+		}
+		break;
+	default:
+		ret =3D -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int ads1298_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct ads1298_private *priv =3D iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret =3D ads1298_set_samp_freq(priv, val);
+		break;
+	default:
+		ret =3D -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int ads1298_reg_write(void *context, unsigned int reg, unsigned int=
 val)
+{
+	struct ads1298_private *priv =3D context;
+	struct spi_transfer reg_write_xfer =3D {
+		.tx_buf =3D priv->cmd_buffer,
+		.rx_buf =3D priv->cmd_buffer,
+		.len =3D 3,
+		.speed_hz =3D ADS1298_SPI_BUS_SPEED_SLOW,
+		.delay.value =3D 2,
+		.delay.unit =3D SPI_DELAY_UNIT_USECS,
+	};
+
+	priv->cmd_buffer[0] =3D ADS1298_CMD_WREG | reg;
+	priv->cmd_buffer[1] =3D 0x0;
+	priv->cmd_buffer[2] =3D val;
+
+	return spi_sync_transfer(priv->spi, &reg_write_xfer, 1);
+}
+
+static int ads1298_reg_read(void *context, unsigned int reg, unsigned int =
*val)
+{
+	struct ads1298_private *priv =3D context;
+	struct spi_transfer reg_read_xfer =3D {
+		.tx_buf =3D priv->cmd_buffer,
+		.rx_buf =3D priv->cmd_buffer,
+		.len =3D 3,
+		.speed_hz =3D ADS1298_SPI_BUS_SPEED_SLOW,
+		.delay.value =3D 2,
+		.delay.unit =3D SPI_DELAY_UNIT_USECS,
+	};
+	int ret;
+
+	priv->cmd_buffer[0] =3D ADS1298_CMD_RREG | reg;
+	priv->cmd_buffer[1] =3D 0x0;
+	priv->cmd_buffer[2] =3D 0;
+
+	ret =3D spi_sync_transfer(priv->spi, &reg_read_xfer, 1);
+	if (ret)
+		return ret;
+
+	*val =3D priv->cmd_buffer[2];
+
+	return 0;
+}
+
+static int ads1298_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			      unsigned int writeval, unsigned int *readval)
+{
+	struct ads1298_private *priv =3D iio_priv(indio_dev);
+
+	if (!readval)
+		return regmap_write(priv->regmap, reg, writeval);
+
+	return regmap_read(priv->regmap, reg, readval);
+}
+
+static int ads1298_update_scan_mode(struct iio_dev *indio_dev,
+				    const unsigned long *scan_mask)
+{
+	struct ads1298_private *priv =3D iio_priv(indio_dev);
+	int i;
+
+	/* Power down channels that aren't in use */
+	for (i =3D 0; i < ADS1298_MAX_CHANNELS; i++) {
+		regmap_update_bits(priv->regmap, ADS1298_REG_CHnSET(i),
+				   ADS1298_MASK_CH_PD,
+				   test_bit(i, scan_mask) ?
+							0 : ADS1298_MASK_CH_PD);
+	}
+
+	return 0;
+}
+
+static const struct iio_info ads1298_info =3D {
+	.read_raw =3D &ads1298_read_raw,
+	.write_raw =3D &ads1298_write_raw,
+	.update_scan_mode =3D &ads1298_update_scan_mode,
+	.debugfs_reg_access =3D &ads1298_reg_access,
+};
+
+static void ads1298_rdata_unmark_busy(struct ads1298_private *priv)
+{
+	unsigned long flags;
+
+	/* Notify we're no longer waiting for the SPI transfer to complete */
+	spin_lock_irqsave(&priv->irq_busy_lock, flags);
+	priv->rdata_xfer_busy =3D false;
+	spin_unlock_irqrestore(&priv->irq_busy_lock, flags);
+}
+
+static void ads1298_rdata_complete(void *context)
+{
+	struct iio_dev *indio_dev =3D context;
+	struct ads1298_private *priv =3D iio_priv(indio_dev);
+	int scan_index;
+	u8 *bounce =3D priv->bounce_buffer;
+
+	if (!iio_buffer_enabled(indio_dev)) {
+		/* Happens when running in single transfer mode */
+		ads1298_rdata_unmark_busy(priv);
+		complete(&priv->completion);
+		return;
+	}
+
+	/* Demux the channel data into our bounce buffer */
+	for_each_set_bit(scan_index, indio_dev->active_scan_mask,
+			 indio_dev->masklength) {
+		const struct iio_chan_spec *scan_chan =3D
+					&indio_dev->channels[scan_index];
+		const u8 *data =3D priv->rx_buffer + scan_chan->address;
+
+		/* Transfer 24-bit value into 32-bit array */
+		memcpy(bounce + 1, data, 3);
+		bounce +=3D 4;
+	}
+
+	/* rx_buffer can be overwritten from this point on */
+	ads1298_rdata_unmark_busy(priv);
+
+	iio_push_to_buffers(indio_dev, priv->bounce_buffer);
+}
+
+static irqreturn_t ads1298_interrupt(int irq, void *dev_id)
+{
+	struct iio_dev *indio_dev =3D dev_id;
+	struct ads1298_private *priv =3D iio_priv(indio_dev);
+	unsigned long flags;
+	bool wasbusy;
+
+	/* Prevent that we submit a message that was still in progress */
+	spin_lock_irqsave(&priv->irq_busy_lock, flags);
+	wasbusy =3D priv->rdata_xfer_busy;
+	priv->rdata_xfer_busy =3D true;
+	spin_unlock_irqrestore(&priv->irq_busy_lock, flags);
+
+	if (!wasbusy)
+		spi_async(priv->spi, &priv->rdata_msg);
+
+	return IRQ_HANDLED;
+};
+
+static int ads1298_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ads1298_private *priv =3D iio_priv(indio_dev);
+	int ret;
+
+	/* Disable single-shot mode */
+	ret =3D regmap_update_bits(priv->regmap, ADS1298_REG_CONFIG4,
+				 ADS1298_MASK_CONFIG4_SINGLE_SHOT, 0);
+	if (ret)
+		return ret;
+
+	return ads1298_write_cmd(priv, ADS1298_CMD_START);
+}
+
+static int ads1298_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ads1298_private *priv =3D iio_priv(indio_dev);
+
+	return ads1298_write_cmd(priv, ADS1298_CMD_STOP);
+}
+
+static const struct iio_buffer_setup_ops ads1298_setup_ops =3D {
+	.postenable =3D &ads1298_buffer_postenable,
+	.predisable =3D &ads1298_buffer_predisable,
+};
+
+static void ads1298_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
+static const struct regmap_range ads1298_regmap_volatile_range[] =3D {
+	regmap_reg_range(ADS1298_REG_LOFF_STATP, ADS1298_REG_LOFF_STATN),
+};
+
+static const struct regmap_access_table ads1298_regmap_volatile =3D {
+	.yes_ranges =3D ads1298_regmap_volatile_range,
+	.n_yes_ranges =3D ARRAY_SIZE(ads1298_regmap_volatile_range),
+};
+
+static const struct regmap_config ads1298_regmap_config =3D {
+	.reg_bits =3D 8,
+	.val_bits =3D 8,
+	.reg_read =3D ads1298_reg_read,
+	.reg_write =3D ads1298_reg_write,
+	.max_register =3D ADS1298_REG_WCT2,
+	.volatile_table =3D &ads1298_regmap_volatile,
+	.cache_type =3D REGCACHE_RBTREE,
+};
+
+static const char *ads1298_family_name(unsigned int id)
+{
+	switch (id & 0xe0) {
+	case 0x80:
+		return "ADS129x";
+	case 0xc0:
+		return "ADS129xR";
+	default:
+		return "(unknown)";
+	}
+}
+
+static int ads1298_init(struct ads1298_private *priv)
+{
+	struct device *dev =3D &priv->spi->dev;
+	int ret;
+	unsigned int val;
+
+	/* Device initializes into RDATAC mode, which we don't want. */
+	ret =3D ads1298_write_cmd(priv, ADS1298_CMD_SDATAC);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_read(priv->regmap, ADS1298_REG_ID, &val);
+	if (ret)
+		return ret;
+
+	if ((val & 0x18) =3D=3D 0x10) {
+		dev_info(dev, "Found %s, %d channels\n",
+			 ads1298_family_name(val),
+			 4 + 2 * (val & 0x07));
+	} else {
+		dev_err(dev, "Unknown ID: 0x%x\n", val);
+		return -ENODEV;
+	}
+
+	/* Enable internal test signal, double amplitude, double frequency */
+	regmap_write(priv->regmap, ADS1298_REG_CONFIG2,
+		ADS1298_MASK_CONFIG2_RESERVED |
+		ADS1298_MASK_CONFIG2_INT_TEST |
+		ADS1298_MASK_CONFIG2_TEST_AMP |
+		ADS1298_MASK_CONFIG2_TEST_FREQ_FAST);
+
+	val =3D ADS1298_MASK_CONFIG3_RESERVED; /* Must write 1 always */
+	if (!priv->reg_vref) {
+		/* Enable internal reference */
+		val |=3D ADS1298_MASK_CONFIG3_PWR_REFBUF;
+		/* Use 4V VREF when power supply is at least 4.4V */
+		if (regulator_get_voltage(priv->reg_avdd) >=3D 4400000)
+			val |=3D ADS1298_MASK_CONFIG3_VREF_4V;
+	}
+	regmap_write(priv->regmap, ADS1298_REG_CONFIG3, val);
+
+	for (val =3D 0; val < ADS1298_MAX_CHANNELS; val++) {
+		/* Set mux to analog input, PGA =3D 6x */
+		regmap_write(priv->regmap, ADS1298_REG_CHnSET(val), 0x00);
+	}
+
+	return 0;
+}
+
+static int ads1298_probe(struct spi_device *spi)
+{
+	struct ads1298_private *priv;
+	struct iio_dev *indio_dev;
+	struct device *dev =3D &spi->dev;
+	struct gpio_desc *reset_gpio;
+	int ret;
+
+	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*priv));
+	if (indio_dev =3D=3D NULL)
+		return -ENOMEM;
+
+	priv =3D iio_priv(indio_dev);
+
+	reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpio))
+		return dev_err_probe(dev, ret, "Cannot get reset GPIO\n");
+
+	priv->reg_avdd =3D devm_regulator_get(dev, "avdd");
+	if (IS_ERR(priv->reg_avdd))
+		return dev_err_probe(dev, PTR_ERR(priv->reg_avdd),
+				     "Failed to get avdd regulator\n");
+
+	/* VREF can be supplied externally. Otherwise use internal reference */
+	priv->reg_vref =3D devm_regulator_get_optional(dev, "vref");
+	if (IS_ERR(priv->reg_vref)) {
+		if (PTR_ERR(priv->reg_vref) =3D=3D -ENODEV)
+			priv->reg_vref =3D NULL;
+		else
+			return dev_err_probe(dev, PTR_ERR(priv->reg_avdd),
+					     "Failed to get vref regulator\n");
+	} else {
+		ret =3D regulator_enable(priv->reg_vref);
+		if (ret)
+			return ret;
+
+		ret =3D devm_add_action_or_reset(dev, ads1298_reg_disable,
+					       priv->reg_vref);
+		if (ret)
+			return ret;
+	}
+
+	priv->clk =3D devm_clk_get_enabled(dev, "clk");
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(dev, PTR_ERR(priv->clk),
+				     "Failed to get clk\n");
+
+	ret =3D regulator_enable(priv->reg_avdd);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to enable avdd regulator\n");
+
+	ret =3D devm_add_action_or_reset(dev, ads1298_reg_disable,
+				       priv->reg_avdd);
+	if (ret)
+		return ret;
+
+	priv->spi =3D spi;
+	init_completion(&priv->completion);
+	spin_lock_init(&priv->irq_busy_lock);
+	priv->regmap =3D devm_regmap_init(dev, NULL, priv,
+					&ads1298_regmap_config);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	priv->tx_buffer[0] =3D ADS1298_CMD_RDATA;
+	priv->rdata_xfer.tx_buf =3D priv->tx_buffer;
+	priv->rdata_xfer.rx_buf =3D priv->rx_buffer;
+	priv->rdata_xfer.len =3D ADS1298_SPI_RDATA_BUFFER_SIZE;
+	/* Must keep CS low for 4 clocks */
+	priv->rdata_xfer.delay.value =3D 2;
+	priv->rdata_xfer.delay.unit =3D SPI_DELAY_UNIT_USECS;
+	spi_message_init_with_transfers(&priv->rdata_msg, &priv->rdata_xfer, 1);
+	priv->rdata_msg.complete =3D &ads1298_rdata_complete;
+	priv->rdata_msg.context =3D indio_dev;
+
+	/* Avoid giving all the same name, iio scope doesn't handle that well */
+	indio_dev->name =3D devm_kasprintf(dev, GFP_KERNEL, "%s@%s",
+					 spi_get_device_id(spi)->name,
+					 dev_name(dev));
+	indio_dev->modes =3D INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
+	indio_dev->channels =3D ads1298_channels;
+	indio_dev->num_channels =3D ADS1298_MAX_CHANNELS;
+	indio_dev->info =3D &ads1298_info;
+
+	if (reset_gpio) {
+		udelay(1); /* Minimum pulse width is 2 clocks at 2MHz */
+		gpiod_set_value(reset_gpio, 0);
+	} else {
+		ret =3D ads1298_write_cmd(priv, ADS1298_CMD_RESET);
+		if (ret)
+			return dev_err_probe(dev, ret, "RESET failed\n");
+	}
+	/* Wait 18 clock cycles for reset command to complete */
+	udelay(9);
+
+	ret =3D ads1298_init(priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "Init failed\n");
+
+	ret =3D devm_request_irq(&spi->dev, spi->irq, &ads1298_interrupt,
+			       IRQF_TRIGGER_FALLING, indio_dev->name,
+			       indio_dev);
+	if (ret)
+		return ret;
+
+	ret =3D devm_iio_kfifo_buffer_setup(&spi->dev, indio_dev,
+					  &ads1298_setup_ops);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct spi_device_id ads1298_id[] =3D {
+	{ "ads1298",  },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ads1298_id);
+
+static const struct of_device_id ads1298_of_table[] =3D {
+	{ .compatible =3D "ti,ads1298" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ads1298_of_table);
+
+static struct spi_driver ads1298_driver =3D {
+	.driver =3D {
+		.name	=3D "ads1298",
+		.of_match_table =3D ads1298_of_table,
+	},
+	.probe		=3D ads1298_probe,
+	.id_table	=3D ads1298_id,
+};
+module_spi_driver(ads1298_driver);
+
+MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
+MODULE_DESCRIPTION("TI ADS1298 ADC");
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
