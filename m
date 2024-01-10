Return-Path: <linux-kernel+bounces-22202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23C5829AC8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3936BB26025
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FF44878C;
	Wed, 10 Jan 2024 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="ocMAh/a9"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330A548781;
	Wed, 10 Jan 2024 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFOyVq03gFtMWMRTiWQxqIFkR2VL8wu/1djPpYb51ow0UKczCG+SvkuHChhoXvXx8aaBPQcLUUhgyRpN00fZqZnnpYJDlwhkPsTws5k/AJ3+r2BfD4Fn5iScGUBJ6gMy5ByX/fryh8hUDzgV3YZWbyUzzLcibTnio11pFYGqU6M5gOewkfws1G5l10pVUbf1PJHQ4grkbiwrvUxa5uuo1E8m0la3OgEAlI0uSmEvWBD0r65da05YqDkG+1fdNxRYPRI13XYVZytA4FQxHVVYIl9jKpZynrjKq+XAvVicyNWPZ85y9Lx+a4/ziDGy5nmsw2WW/vIywoYyofir9JfSHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Elo8zqBmIJ+ywlz5i189I/WJHjwT7a2hGCTg/rZxK8=;
 b=oacJfjjH0gdYyMnY0N1Ym/MM/JE34ZQWY+oO5S8JP9sXLDDvHvcEur6OqlVwHMmWZWiF5Q77LzE17qP0EoQwLe03GcGUpMmTMQKNtMPwJgVOVR62ryLLqkwhyRKb0Lhs0Ljjj+hYrhVzGRwWLuAapqhW9gr6Z+N291s/vk8jtIZaR2wxm9U/GJvF83m3ZnDUKaD/b6rshFlb4rP2U/gfd0HZgo1ZzbUza+gB/KQVGR4gq/rvpHCYUK+QSmi7ElsXKVqVmV77d0lNoie/F4xk6HqSR22uU4G6AqhU3+GPDpcp2ia9bgcQ43Qh9xz2v/ksJWYPWv9los78OIK+RyJ/yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Elo8zqBmIJ+ywlz5i189I/WJHjwT7a2hGCTg/rZxK8=;
 b=ocMAh/a9tB8iMriirKYq+T9kqwDL5sU5mIODRZH9B3ccFM6+NH+nwLqy68WO+OCdRIqetwyImSR6gujD1zfz68WCCplEgoYmgvBfEPLsMqUM8bsIk9L0lW/tvpSHOvuHAqv8JM7m2sP9vlqiDEZlZZA7RU3l0fo0IOVYQD02ydc=
Received: from AM5PR04CA0020.eurprd04.prod.outlook.com (2603:10a6:206:1::33)
 by AS4PR02MB8622.eurprd02.prod.outlook.com (2603:10a6:20b:58a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 12:58:15 +0000
Received: from AM4PEPF00025F9A.EURPRD83.prod.outlook.com
 (2603:10a6:206:1:cafe::dd) by AM5PR04CA0020.outlook.office365.com
 (2603:10a6:206:1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17 via Frontend
 Transport; Wed, 10 Jan 2024 12:58:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00025F9A.mail.protection.outlook.com (10.167.16.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.4 via Frontend Transport; Wed, 10 Jan 2024 12:58:15 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 Jan
 2024 13:58:14 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 10 Jan 2024 13:58:14 +0100
Received: from pc42775-2107.se.axis.com (pc42775-2107.se.axis.com [10.94.129.29])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id A955511D24;
	Wed, 10 Jan 2024 13:58:14 +0100 (CET)
Received: by pc42775-2107.se.axis.com (Postfix, from userid 21033)
	id A3B224C7785; Wed, 10 Jan 2024 13:58:14 +0100 (CET)
From: =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Date: Wed, 10 Jan 2024 13:58:07 +0100
Subject: [PATCH v2] iio: light: vcnl4000: Set ps high definition for
 4040/4200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20231221-vcnl4000-ps-hd-v2-1-1b6790d30ae6@axis.com>
X-B4-Tracking: v=1; b=H4sIAF6UnmUC/3WNwQ6DIBAFf8Vw7jaAxNKe+h+NB8ClkFQ0rCE2x
 n8veu9x3stkNkaYIxJ7NBvLWCLFKVWQl4a5YNIbIQ6VmeSyFVIKKC59FOccZoIwgO5ar7z2Ds2
 NVckaQrDZJBcObTS0YD6OOaOP61l69ZVDpGXK3zNcxLH+bRQBAgyXynortb53T7NGurppZP2+7
 z8hgGt6xAAAAA==
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@axis.com>, =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704891494; l=4297;
 i=marten.lindahl@axis.com; s=20230329; h=from:subject:message-id;
 bh=yr7qlYWAqhYFjg/56U/db5OwF3uobYAE+wF/94bJd8U=;
 b=RFj3y6XObK2DlzvcBbEmTe03n3iteydBMdkU5911Q/MjklaXNoBBBaCZki32gEMYrFFUEWOB0
 lelwXEkLgrKCBMCb7NtYNYjJ620Obe5uYn0A+2JSKdH9hiQYDeMqvoy
X-Developer-Key: i=marten.lindahl@axis.com; a=ed25519;
 pk=JfbjqFPJnIDIQOkJBeatC8+S3Ax3N0RIdmN+fL3wXgw=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9A:EE_|AS4PR02MB8622:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c9d967-9449-407a-880d-08dc11dbcf2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xUv5e32jDM9GVrpRVPB9Yn7GmCT+RPhT7u8x+IgZVESN0vE5QofQlrur/rf0Xlrxp6GGXD4S4E44gGUztZehfSg9TdujOHD/FWNhlWCqIfLIwGyIrlqBXf0eo0x0bfaSxECv9tvLuW/3cQlG4l8ZP29+quMBFY4+v1VOqTKeFmnhW2zT8yfvkj4w1x6Gv9Qh3pkNvHedn/H8TmkyuCUz9DiW9x7NdmgUpC7g5wx750EuI2Y2iIw7eDXa6q8zrJG0PXGcP/lO0KUqxi5ONwhSHbGJmRqHWsdoUOsYKzRHyA09gYqBvXMgAQA7DrBV1pSFlj5n781WPqwLdBxWBOkLFDI6ZFulPgHy15XU1NWt5UB62KsmIAY8TZFWdIxsDTMHAbnhYjnKxMrsLRgcemZKvRCevkUhdXBMAmyuOD5XuOHRqWog7mtDjX45qJ7qJSWcbJud9A4iaTOL+3rXSigxseAXudYomGfSFsEtd6EEYGNLDCnyC1u4HdijU9SBqiaK7U47tY9oa9k56/vB7c2miRtLhXwaJNpFV68S07dnj72Z45G9WXdMZHuoAwqmniZ3nF6m9hosWYgFOMHRzTZZMOuh2H0qkVvdXmScjIseVnYOfmIatgmIvB42Py+SSTPqjvaSR9EC73b7hGNIMbasUeWZaVAKNvMFa9Ic8KT+zm7h4Kn4te+MOfTyomdhD7KUH09bBrQIDtAXnxZnijN3eSF8YqTZ5v8flWvWP6E4c9JG23A6MFORUxVK90q+e/+9
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(46966006)(36840700001)(40470700004)(82740400003)(81166007)(356005)(36756003)(40460700003)(40480700001)(86362001)(6266002)(26005)(426003)(66574015)(336012)(107886003)(2616005)(42186006)(316002)(4326008)(54906003)(110136005)(8676002)(478600001)(6666004)(966005)(8936002)(36860700001)(70206006)(70586007)(47076005)(83380400001)(41300700001)(5660300002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 12:58:15.0767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c9d967-9449-407a-880d-08dc11dbcf2c
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F9A.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8622

The vcnl4040/vcnl4200 proximity sensor defaults to 12 bit data
resolution, but the chip also supports 16 bit data resolution, which is
called proximity high definition (PS_HD).

Make the vcnl4040/vcnl4200 proximity sensor use the high definition for
all data readings. Please note that in order to preserve the 12 bit
integer part of the in_proximity_raw output, the format is changed from
integer to fixed point.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
Changes in v2:
- Update registers for sample rate to align it with 16 bit sensor readings.
- Change sysfs output from IIO_VAL_INT to IIO_VAL_FRACTIONAL and scale by 16.
- Link to v1: https://lore.kernel.org/r/20231221-vcnl4000-ps-hd-v1-1-a024bfb28896@axis.com
---
 drivers/iio/light/vcnl4000.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index fdf763a04b0b..a078c573131e 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -90,6 +90,7 @@
 #define VCNL4040_PS_CONF1_PS_SHUTDOWN	BIT(0)
 #define VCNL4040_PS_CONF2_PS_IT	GENMASK(3, 1) /* Proximity integration time */
 #define VCNL4040_CONF1_PS_PERS	GENMASK(5, 4) /* Proximity interrupt persistence setting */
+#define VCNL4040_PS_CONF2_PS_HD		BIT(11)	/* Proximity high definition */
 #define VCNL4040_PS_CONF2_PS_INT	GENMASK(9, 8) /* Proximity interrupt mode */
 #define VCNL4040_PS_CONF3_MPS		GENMASK(6, 5) /* Proximity multi pulse number */
 #define VCNL4040_PS_MS_LED_I		GENMASK(10, 8) /* Proximity current */
@@ -114,6 +115,13 @@
 #define VCNL4010_INT_DRDY \
 	(BIT(VCNL4010_INT_PROXIMITY) | BIT(VCNL4010_INT_ALS))
 
+#define VCNL4040_CONF3_PS_MPS_16BITS	3	/* 8 multi pulses */
+#define VCNL4040_CONF3_PS_LED_I_16BITS	3	/* 120 mA */
+
+#define VCNL4040_CONF3_PS_SAMPLE_16BITS \
+	(FIELD_PREP(VCNL4040_PS_CONF3_MPS, VCNL4040_CONF3_PS_MPS_16BITS) | \
+	 FIELD_PREP(VCNL4040_PS_MS_LED_I, VCNL4040_CONF3_PS_LED_I_16BITS))
+
 static const int vcnl4010_prox_sampling_frequency[][2] = {
 	{1, 950000},
 	{3, 906250},
@@ -195,6 +203,7 @@ struct vcnl4000_data {
 	enum vcnl4000_device_ids id;
 	int rev;
 	int al_scale;
+	int ps_scale;
 	u8 ps_int;		/* proximity interrupt mode */
 	u8 als_int;		/* ambient light interrupt mode*/
 	const struct vcnl4000_chip_spec *chip_spec;
@@ -345,6 +354,7 @@ static int vcnl4200_set_power_state(struct vcnl4000_data *data, bool on)
 static int vcnl4200_init(struct vcnl4000_data *data)
 {
 	int ret, id;
+	u16 regval;
 
 	ret = i2c_smbus_read_word_data(data->client, VCNL4200_DEV_ID);
 	if (ret < 0)
@@ -386,9 +396,36 @@ static int vcnl4200_init(struct vcnl4000_data *data)
 		break;
 	}
 	data->al_scale = data->chip_spec->ulux_step;
+	data->ps_scale = 16;
 	mutex_init(&data->vcnl4200_al.lock);
 	mutex_init(&data->vcnl4200_ps.lock);
 
+	/* Use 16 bits proximity sensor readings */
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
+	if (ret >= 0) {
+		regval = (ret | VCNL4040_PS_CONF2_PS_HD);
+		ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
+						regval);
+	}
+
+	if (ret < 0) {
+		dev_info(&data->client->dev, "Default to 12 bits sensor data");
+		data->ps_scale = 1;
+		goto out;
+	}
+
+	/* Align proximity sensor sample rate to 16 bits data width */
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF3);
+	if (ret >= 0) {
+		regval = (ret | VCNL4040_CONF3_PS_SAMPLE_16BITS);
+		ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF3,
+						regval);
+	}
+
+	if (ret < 0)
+		dev_warn(&data->client->dev, "Sample rate may not be accurate");
+
+out:
 	ret = data->chip_spec->set_power_state(data, true);
 	if (ret < 0)
 		return ret;
@@ -901,8 +938,9 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 			break;
 		case IIO_PROXIMITY:
 			ret = data->chip_spec->measure_proximity(data, val);
+			*val2 = data->ps_scale;
 			if (!ret)
-				ret = IIO_VAL_INT;
+				ret = IIO_VAL_FRACTIONAL;
 			break;
 		default:
 			ret = -EINVAL;

---
base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
change-id: 20231221-vcnl4000-ps-hd-863f4f8fcea7

Best regards,
-- 
Mårten Lindahl <marten.lindahl@axis.com>


