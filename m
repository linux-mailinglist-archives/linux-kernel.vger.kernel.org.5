Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7E47B50F7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbjJBLOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236658AbjJBLOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:14:51 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2085.outbound.protection.outlook.com [40.107.105.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2A6E1;
        Mon,  2 Oct 2023 04:14:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JITrncauMWRbDBZcVhk8Npw71NXUBLB4NybppC4TcL9D3JLah34cjEUn6RzOXeAbYSDwMLku4hzpskQ7qBpfmIs1xpGlsdyL3yQdkIZgW6L4bTcWaPrp1wRVvHVIssK5pt7qXbST1PfDCJ0VAch5pLcmr4blwTEfGq6VyOxrXcvjZksUiwpedOFG40TTblXCqRubuupKOeBLpdO0NqE5WvaX0F6UFSIKM0TBRg0qRLFdKb9/biwedANPAzeGY8Nryy3vduaHWQ9YwEGk3QILT6G9fjLZ7n+1Cc2EJoH57lNIsdhdOYjpAjlxW/zssfh81DiE+Agw6Qgem+g4ZTkcmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRwP2IgiUF0vLdIxnm4vuo1qXgNpn5XMpob++q1rGvQ=;
 b=UEOTw3oZ0ZxrN7+2aMIy5MKU8zJTqbTCsxM2PqgJOZ1QtTSca15NEpUYCQ7BWqLqEOVB3tvjHkEhU1TcxlhyupSqo+tTIspXqqsbfgaa8TOvlBeJR0xC8nqTqNEFX95BK3a7oxWm2BCsSZD3Ecfp1WogvhirIM0haoTQjMeK0M8/f+WE6vQpREy/OXCR3TdNLpaN9RZVL8UgJgVjLFvnVnZ946GdSdJ6m1euoqp3VD9sbgilUlMaeCFkrHuJ1xsxKVV/Zay8vhEK6Sk71K1MYyT8ig0JSC6+VoKLTCsmPy6pSCdGU+sHZa5V0QFqYjvmRBA1sZcf5XTALXhG/1P9RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=bootlin.com smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRwP2IgiUF0vLdIxnm4vuo1qXgNpn5XMpob++q1rGvQ=;
 b=RILuJ9rAtZoNw3jz3BGV0NdTdLGp7BD62GGE+FRiGUfla48EUhe1Lb/oB2XZvdRyuUKIkVIJ17UwUCnXznm8FuiziXBkaakY1fR0YDgTLgMxbxeiHD+PRG9Pkp36qCH1DFzxwM/WHpew/lNwffO3qJiv5FxpWmXrmqyXFg3Xwbo=
Received: from AS9PR06CA0779.eurprd06.prod.outlook.com (2603:10a6:20b:484::34)
 by GV1PR02MB8634.eurprd02.prod.outlook.com (2603:10a6:150:92::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Mon, 2 Oct
 2023 11:14:41 +0000
Received: from AM3PEPF00009B9E.eurprd04.prod.outlook.com
 (2603:10a6:20b:484:cafe::ca) by AS9PR06CA0779.outlook.office365.com
 (2603:10a6:20b:484::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30 via Frontend
 Transport; Mon, 2 Oct 2023 11:14:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF00009B9E.mail.protection.outlook.com (10.167.16.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 2 Oct 2023 11:14:41 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 2 Oct
 2023 13:14:40 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 2 Oct
 2023 13:14:40 +0200
Received: from se-intmail02x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 2 Oct 2023 13:14:40 +0200
Received: from pc53218-2308.se.axis.com (pc53218-2308.se.axis.com [10.92.111.2])
        by se-intmail02x.se.axis.com (Postfix) with ESMTP id 70913B11;
        Mon,  2 Oct 2023 13:14:40 +0200 (CEST)
Received: by pc53218-2308.se.axis.com (Postfix, from userid 9850)
        id 6C48241688CF; Mon,  2 Oct 2023 13:14:40 +0200 (CEST)
From:   Anders Sandahl <anders.sandahl@axis.com>
Date:   Mon, 2 Oct 2023 13:14:14 +0200
Subject: [PATCH] rtc: rx8111: Add timestamp and nvmem functionality
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231002-rx8111-add-timestamp0-v1-1-353727cf7f14@axis.com>
X-B4-Tracking: v=1; b=H4sIAAWmGmUC/x3MPQqAMAxA4atIZgNNVaxeRRyijZrBH1oRQby7x
 fEb3nsgSlCJ0GYPBLk06r4lUJ7BuPA2C6pPBmtsYRpbY7gdESF7j6euEk9eD4ODcSM55qouBVJ
 7BJn0/r9d/74fxxY3iGcAAAA=
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Anders Sandahl <anders.sandahl@axis.com>
X-Mailer: b4 0.12.3
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9E:EE_|GV1PR02MB8634:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f7296a7-0039-4ec6-f23c-08dbc338c5fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cnsjuX6akgl3g3sRzQmpfWm3tDbWNy7Z/QlitrIkdVraWF+oSqCpcCf8hmTyg/hA0/hnJ+XC4w6h7xsvzyENhU6EQdRqHSfI+7JcI8SMmTS1qg5VTJ9vnFgpJMUznNozFfKFtaeDMueBj3BISemJgW+bJ6qXYAvUxpsqIzcRE2HFcopwTb4fqy5fawkXvCjhksVCbgsrnGhYbXNPuBwD8/wTEnhcvPWn/hpaoVsMJ849E7Lx0zfbtdXhs/je0mchh1rkabjVopWBYb+zoBSupVUpdLCmKbINzj23JFfSax+2EpmL8BUYtlksqnCz6oj3eN6nBcZl362Q9rMJfGhJ0x8SmrWIBK7XV9TtX5PcrHrcMz+lkE0jjpG45mcqd9OSSmcNvhN2FOVilM1zmLmW5jPpHdaLfAKgZaZN3Tx182x1NBa8PC1wbATcoL/sx11TRN7haChDfHVjWL8er4AAnc6mSETKVaLOWLsu9l0QmbufXCroJ2rTQ0jZuN0afDwmrpVb1vdEALKBpbIHJtH5cm/LYUIm9g/oq6zvExWLciO/4jkDcUgFkjd/tJq5F/lwbIF0pQjoNBgDZdk+uE0P0KNyTHhKFKB6VB0bGs0YbueZxwlXBFVB7errVcJrX5rjIFKBH/x4+GpCatRpsVN0IKrX0ggNl0sTaGhjiUFPADDY7c3eZ/V4PLk/UQTbM3lYD7Dac/Qxd+gnxEEAZkJSeIKUhnL2HcuVuWhcQPB5BWj7aFbzqK1LyIzWQH9hCip1
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(82310400011)(186009)(36840700001)(46966006)(40470700004)(966005)(478600001)(36756003)(47076005)(44832011)(5660300002)(40480700001)(2906002)(316002)(30864003)(4326008)(8936002)(8676002)(41300700001)(70206006)(70586007)(110136005)(6666004)(42186006)(54906003)(2616005)(107886003)(86362001)(40460700003)(26005)(336012)(426003)(6266002)(83380400001)(36860700001)(81166007)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 11:14:41.0149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7296a7-0039-4ec6-f23c-08dbc338c5fe
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8634
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add timestamp by external event (EVIN pin). Also add support for nvmem.
If an event occurs the time stamp can be read out from timestamp0 in
sysfs.

Nvmem will be used as an ordinary non-volatile memory until a '1' is
written to timestamp0_write_nvmem file in sysfs. In that case time
stamp data will also be written to the register area shared with
nvmem.

Signed-off-by: Anders Sandahl <anders.sandahl@axis.com>
---
This patch adds NVMEM and timestamp functionality to the driver for
Epson RX8111 RTC chip.

The base for this patch is an unmerged patch stack:
https://lore.kernel.org/lkml/cover.1692699931.git.waqar.hameed@axis.com/
---
 drivers/rtc/rtc-rx8111.c | 299 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 290 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-rx8111.c b/drivers/rtc/rtc-rx8111.c
index 15ff776f739e..d6e4c9baa1de 100644
--- a/drivers/rtc/rtc-rx8111.c
+++ b/drivers/rtc/rtc-rx8111.c
@@ -56,13 +56,24 @@
 #define RX8111_REG_TS_CTRL2		0x35	/* Timestamp control 2. */
 #define RX8111_REG_TS_CTRL3		0x36	/* Timestamp control 3. */
 
+#define RX8111_REG_TS_RAM_START		0x40	/* Timestamp RAM area start. */
+#define RX8111_REG_TS_RAM_END		0x7f	/* Timestamp RAM area end. */
+
+#define RX8111_BIT_EVIN_SETTING_OVW	BIT(1)	/* Enable overwrite TSRAM. */
+#define RX8111_BIT_EVIN_SETTING_PU1	BIT(3)	/* Pull up select 1. */
+
 #define RX8111_TIME_BUF_SZ (RX8111_REG_YEAR - RX8111_REG_SEC + 1)
-#define RX8111_TIME_BUF_IDX(reg)                                               \
+#define RX8111_BUF_IDX(reg, min, max)                                          \
 	({                                                                     \
-		BUILD_BUG_ON_MSG(reg < RX8111_REG_SEC || reg > RX8111_REG_YEAR,\
-				 "Invalid reg value");                         \
-		(reg - RX8111_REG_SEC);                                        \
+		BUILD_BUG_ON_MSG(reg < min || reg > max, "Invalid reg value"); \
+		(reg - min);                                                   \
 	})
+#define RX8111_TIME_BUF_IDX(reg) \
+	RX8111_BUF_IDX(reg, RX8111_REG_SEC, RX8111_REG_YEAR)
+
+#define RX8111_TS_BUF_SZ (RX8111_REG_TS_YEAR - RX8111_REG_TS_SEC + 1)
+#define RX8111_TS_BUF_IDX(reg) \
+	RX8111_BUF_IDX(reg, RX8111_REG_TS_SEC, RX8111_REG_TS_YEAR)
 
 enum rx8111_regfield {
 	/* RX8111_REG_EXT. */
@@ -99,6 +110,11 @@ enum rx8111_regfield {
 	RX8111_REGF_INIEN,
 	RX8111_REGF_CHGEN,
 
+	/* RX8111_REG_TS_CTRL1. */
+	RX8111_REGF_TSRAM,
+	RX8111_REGF_TSCLR,
+	RX8111_REGF_EISEL,
+
 	/* Sentinel value. */
 	RX8111_REGF_MAX
 };
@@ -133,12 +149,16 @@ static const struct reg_field rx8111_regfields[] = {
 	[RX8111_REGF_SWSEL1] = REG_FIELD(RX8111_REG_PWR_SWITCH_CTRL, 3, 3),
 	[RX8111_REGF_INIEN]  = REG_FIELD(RX8111_REG_PWR_SWITCH_CTRL, 6, 6),
 	[RX8111_REGF_CHGEN]  = REG_FIELD(RX8111_REG_PWR_SWITCH_CTRL, 7, 7),
+
+	[RX8111_REGF_TSRAM]  = REG_FIELD(RX8111_REG_TS_CTRL1, 0, 0),
+	[RX8111_REGF_TSCLR]  = REG_FIELD(RX8111_REG_TS_CTRL1, 1, 1),
+	[RX8111_REGF_EISEL]  = REG_FIELD(RX8111_REG_TS_CTRL1, 2, 2),
 };
 
 static const struct regmap_config rx8111_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.max_register = RX8111_REG_TS_CTRL3,
+	.max_register = RX8111_REG_TS_RAM_END,
 };
 
 struct rx8111_data {
@@ -148,15 +168,191 @@ struct rx8111_data {
 	struct rtc_device *rtc;
 };
 
+static ssize_t timestamp0_store(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	struct rx8111_data *data = dev_get_drvdata(dev);
+	int ret, etsval;
+
+	/*
+	 * Clear event only if events are enabled. This is to protect
+	 * us from losing events in the future if events have been disabled
+	 * by mistake (error in read function).
+	 */
+	ret = regmap_field_read(data->regfields[RX8111_REGF_ETS], &etsval);
+	if (ret) {
+		dev_err(dev, "Could not read ETS (%d)\n", ret);
+		return ret;
+	}
+
+	if (!etsval)
+		return -EINVAL;
+
+	ret = regmap_field_write(data->regfields[RX8111_REGF_EVF], 0);
+	if (ret) {
+		dev_err(dev, "Could not write EVF bit (%d)\n", ret);
+		return ret;
+	}
+
+	return count;
+}
+
+static ssize_t timestamp0_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct rx8111_data *data = dev_get_drvdata(dev);
+
+	struct rtc_time tm;
+	int ret, evfval;
+	u8 date[RX8111_TS_BUF_SZ];
+
+	/* Read out timestamp values only when an event has occurred. */
+	ret = regmap_field_read(data->regfields[RX8111_REGF_EVF], &evfval);
+	if (ret) {
+		dev_err(dev, "Could not read EVF (%d)\n", ret);
+		return ret;
+	}
+
+	if (!evfval)
+		return 0;
+
+	/* Disable timestamp during readout to avoid unreliable data. */
+	ret = regmap_field_write(data->regfields[RX8111_REGF_ETS], 0);
+	if (ret) {
+		dev_err(dev, "Could not disable timestamp function (%d)\n",
+			ret);
+		return ret;
+	}
+
+	ret = regmap_bulk_read(data->regmap, RX8111_REG_TS_SEC, date,
+			       sizeof(date));
+	if (ret) {
+		dev_err(dev, "Could not read timestamp data (%d)\n", ret);
+		return ret;
+	}
+
+	ret = regmap_field_write(data->regfields[RX8111_REGF_ETS], 1);
+	if (ret) {
+		dev_err(dev, "Could not enable timestamp function (%d)\n", ret);
+		return ret;
+	}
+
+	tm.tm_sec = bcd2bin(date[RX8111_TS_BUF_IDX(RX8111_REG_TS_SEC)]);
+	tm.tm_min = bcd2bin(date[RX8111_TS_BUF_IDX(RX8111_REG_TS_MIN)]);
+	tm.tm_hour = bcd2bin(date[RX8111_TS_BUF_IDX(RX8111_REG_TS_HOUR)]);
+	tm.tm_mday = bcd2bin(date[RX8111_TS_BUF_IDX(RX8111_REG_TS_DAY)]);
+	tm.tm_mon = bcd2bin(date[RX8111_TS_BUF_IDX(RX8111_REG_TS_MONTH)]) - 1;
+	tm.tm_year = bcd2bin(date[RX8111_TS_BUF_IDX(RX8111_REG_TS_YEAR)]) + 100;
+
+	ret = rtc_valid_tm(&tm);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%llu\n",
+		       (unsigned long long)rtc_tm_to_time64(&tm));
+}
+
+static DEVICE_ATTR_RW(timestamp0);
+
+static ssize_t timestamp0_write_nvmem_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t count)
+{
+	struct rx8111_data *data = dev_get_drvdata(dev);
+	bool enable;
+	int ret;
+
+	if (count <= 1)
+		return -EINVAL;
+
+	ret = kstrtobool(buf, &enable);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_write(data->regfields[RX8111_REGF_TSRAM],
+				 enable ? 1 : 0);
+	if (ret) {
+		dev_err(dev, "Could not set TSRAM bit (%d)\n", ret);
+		return ret;
+	}
+
+	return count;
+}
+
+static ssize_t timestamp0_write_nvmem_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct rx8111_data *data = dev_get_drvdata(dev);
+	int enable;
+	int ret;
+
+	ret = regmap_field_read(data->regfields[RX8111_REGF_TSRAM], &enable);
+	if (ret) {
+		dev_err(dev, "Could not read TSRAM bit (%d)\n", ret);
+		return ret;
+	}
+
+	return sprintf(buf, "%s\n", enable ? "1" : "0");
+}
+
+static DEVICE_ATTR_RW(timestamp0_write_nvmem);
+
+static int rx8111_sysfs_register(struct device *dev)
+{
+	int ret;
+
+	ret = device_create_file(dev, &dev_attr_timestamp0);
+	if (ret)
+		return ret;
+
+	ret = device_create_file(dev, &dev_attr_timestamp0_write_nvmem);
+	if (ret)
+		device_remove_file(dev, &dev_attr_timestamp0);
+
+	return ret;
+}
+
+static void rx8111_sysfs_unregister(void *data)
+{
+	struct device *dev = (struct device *)data;
+
+	device_remove_file(dev, &dev_attr_timestamp0);
+	device_remove_file(dev, &dev_attr_timestamp0_write_nvmem);
+}
+
 static int rx8111_setup(struct rx8111_data *data)
 {
 	int ret;
 
-	/* Disable extended functionality (timer, events, timestamps etc.). */
-	ret = regmap_write(data->regmap, RX8111_REG_EXT, 0);
+	/* Disable multiple timestamps; area is used for nvmem as default. */
+	ret = regmap_write(data->regmap, RX8111_REG_TS_CTRL2, 0);
+	if (ret) {
+		dev_err(data->dev, "Could not setup TS_CTRL2 (%d)\n", ret);
+		return ret;
+	}
+
+	ret = regmap_write(data->regmap, RX8111_REG_TS_CTRL3, 0);
+	if (ret) {
+		dev_err(data->dev, "Could not setup TS_CTRL3 (%d)\n", ret);
+		return ret;
+	}
+
+	/* Configure EVIN pin, trigger on low level. PU = 1M Ohm. */
+	ret = regmap_write(data->regmap, RX8111_REG_EVIN_SETTING,
+			   RX8111_BIT_EVIN_SETTING_PU1 |
+				   RX8111_BIT_EVIN_SETTING_OVW);
+	if (ret) {
+		dev_err(data->dev, "Could not setup EVIN (%d)\n", ret);
+		return ret;
+	}
+
+	/* Enable timestamp triggered by EVIN pin. */
+	ret = regmap_field_write(data->regfields[RX8111_REGF_ETS], 1);
 	if (ret) {
-		dev_err(data->dev,
-			"Could not disable extended functionality (%d)\n", ret);
+		dev_err(data->dev, "Could not enable timestamp function (%d)\n",
+			ret);
 		return ret;
 	}
 
@@ -330,6 +526,62 @@ static int rx8111_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 	}
 }
 
+static int rx8111_nvram_write(void *priv, unsigned int offset, void *val,
+			      size_t bytes)
+{
+	struct rx8111_data *data = priv;
+	int ret, len;
+
+	/*
+	 * The RX8111 device can only handle transfers with repeated start
+	 * within the same 16 bytes aligned block.
+	 */
+	while (bytes > 0) {
+		len = ((offset % 15) + bytes > 16) ? 16 - (offset % 16) : bytes;
+		ret = regmap_bulk_write(data->regmap,
+					RX8111_REG_TS_RAM_START + offset, val,
+					len);
+		if (ret) {
+			dev_err(data->dev, "Could not write nvmem (%d)\n", ret);
+			return ret;
+		}
+
+		val += len;
+		offset += len;
+		bytes -= len;
+	}
+
+	return 0;
+}
+
+static int rx8111_nvram_read(void *priv, unsigned int offset, void *val,
+			     size_t bytes)
+{
+	struct rx8111_data *data = priv;
+	int ret, len;
+
+	/*
+	 * The RX8111 device can only handle transfers with repeated start
+	 * within the same 16 bytes aligned block.
+	 */
+	while (bytes > 0) {
+		len = ((offset % 15) + bytes > 16) ? 16 - (offset % 16) : bytes;
+		ret = regmap_bulk_read(data->regmap,
+				       RX8111_REG_TS_RAM_START + offset, val,
+				       len);
+		if (ret) {
+			dev_err(data->dev, "Could not read nvmem (%d)\n", ret);
+			return ret;
+		}
+
+		val += len;
+		offset += len;
+		bytes -= len;
+	}
+
+	return 0;
+}
+
 static const struct rtc_class_ops rx8111_rtc_ops = {
 	.read_time = rx8111_read_time,
 	.set_time = rx8111_set_time,
@@ -342,6 +594,15 @@ static int rx8111_probe(struct i2c_client *client)
 	struct rtc_device *rtc;
 	size_t i;
 	int ret;
+	struct nvmem_config nvmem_cfg = {
+		.name = "rx8111_nvram",
+		.word_size = 1,
+		.stride = 1,
+		.size = RX8111_REG_TS_RAM_END - RX8111_REG_TS_RAM_START + 1,
+		.type = NVMEM_TYPE_BATTERY_BACKED,
+		.reg_read = rx8111_nvram_read,
+		.reg_write = rx8111_nvram_write,
+	};
 
 	data = devm_kmalloc(&client->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -386,6 +647,26 @@ static int rx8111_probe(struct i2c_client *client)
 				     "Could not register rtc device (%d)\n",
 				     ret);
 
+	ret = rx8111_sysfs_register(data->dev);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "Could not create sysfs entry (%d)\n",
+				     ret);
+
+	ret = devm_add_action_or_reset(data->dev, &rx8111_sysfs_unregister,
+				       data->dev);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "Could not add sysfs unregister devres action (%d)\n",
+				     ret);
+
+	nvmem_cfg.priv = data;
+	ret = devm_rtc_nvmem_register(rtc, &nvmem_cfg);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "Could not register rtc nvmem device (%d)\n",
+				     ret);
+
 	return 0;
 }
 

---
base-commit: 2687773764932f57571bfaffc97290e0a63bb48d
change-id: 20230927-rx8111-add-timestamp0-b08c18aa574e

Best regards,
-- 
Anders Sandahl <anders.sandahl@axis.com>

