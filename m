Return-Path: <linux-kernel+bounces-25936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D814E82D886
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5FC1F223DD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623DC2C690;
	Mon, 15 Jan 2024 11:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="rSIBlR+3"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2053.outbound.protection.outlook.com [40.107.8.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7111E2C689;
	Mon, 15 Jan 2024 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHohSjpvz+s9HbYYXJPDHYWUYe2nEf6OwZAxcx0rdERwNaHBFwHZ3H5arTYX/+0VfTe/+xsZxLVyhl/9o5HMm3WUBFYtjI5Nhx0G1A3SfwHDut2tZK7N52zI6+aHe0Xe2i7NoKSU/dqiKVBalSIfMOMY6+9WRow4FNA70TjVqKly9PKNfzjCOJO7dcd0LQPQHfjAFynfMTTjNhBHIofEeiy7Nsk0graB8fIYoge/LWm9yvvZfVzinYTIcFn8nrz7TN2SkUF5fwGQNabcOAad9o4LHmN+7Je33kXM6FGr4P1Qf/NcfGxOn9uzGkYqfrfF5HW1fSkv5Aqe2CqPVGFIPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgVM7JRmmtXtqZ6V4DdUPPFf0LDy81n7E68xlBOSVQg=;
 b=MPU17mZj12NPxVnqB202hhiBBLgWm5n/HMjyOVaKGHEcpxJHiqcvZRaAG0sHkp2ieIycd0izuRkPSpH3nUCLe+kMVatXebtW6o14EP/zBHt1tNT72Kt2WUdiAlQeK1BlYuPhg1sT1TqrQ1QiQLVqh8Eum6TVfqlghb0R6W59PZvVqwm90QGGaMtCAsO1ZP44ehb2wiWmtNa89A+m63GQ4ESujJ0VvQYhcHXrhI7eZry5X6E0ZQyoXdQabNCTubMe27llKhwZYCPpMOFbfERHbfkijS0mwnX0aIwUa0piKCHYCNOmzmZfEUPmmnbJPRu3oimOon8YGwe0fWXJ2enJLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgVM7JRmmtXtqZ6V4DdUPPFf0LDy81n7E68xlBOSVQg=;
 b=rSIBlR+3O8ZZBX7FtphjQIXHOOdNGVd/TXkDgyayoVmfRImpVI6siR2Gha3gYnCs7jsJ/ZL/hfiS5EbXLAdMpoyBqrJpd86ZCPWv+LPFKb0vVmVIbB9DOkedt3ddQIRSp1IptWA54h62GjQ6fI4QlxXMuKlyEU3R11twNSBUqIg=
Received: from AS9PR0301CA0060.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::18) by AS8PR02MB6582.eurprd02.prod.outlook.com
 (2603:10a6:20b:23b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 11:44:42 +0000
Received: from AMS0EPF000001A1.eurprd05.prod.outlook.com
 (2603:10a6:20b:469:cafe::3e) by AS9PR0301CA0060.outlook.office365.com
 (2603:10a6:20b:469::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23 via Frontend
 Transport; Mon, 15 Jan 2024 11:44:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001A1.mail.protection.outlook.com (10.167.16.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 15 Jan 2024 11:44:41 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 15 Jan
 2024 12:44:41 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 15 Jan 2024 12:44:41 +0100
Received: from pc42775-2107.se.axis.com (pc42775-2107.se.axis.com [10.94.129.29])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 5F2E212253;
	Mon, 15 Jan 2024 12:44:41 +0100 (CET)
Received: by pc42775-2107.se.axis.com (Postfix, from userid 21033)
	id 4FA9E305E83; Mon, 15 Jan 2024 12:44:41 +0100 (CET)
From: =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Date: Mon, 15 Jan 2024 12:44:36 +0100
Subject: [PATCH v3] iio: light: vcnl4000: Set ps high definition for
 4040/4200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20231221-vcnl4000-ps-hd-v3-1-6dcc889372be@axis.com>
X-B4-Tracking: v=1; b=H4sIAKMapWUC/32NzQ7CIBAGX8VwFsNP01JPvofxsNBFSCxtoCE1T
 d9d6MmLHmc3881GEkaPiVxPG4mYffJTKCDPJ2IchCdSPxQmggnJheA0m/BqGGN0TtQNVLXSNlZ
 Zg9CRImlISHWEYFzVRkgLxvqYI1q/HqX7o7DzaZni+whnXq8/G5lTToGJRlstlOrbG6w+Xcw0k
 rqUxX9bFJvrtuvZIBngt73v+wdETSTGAgEAAA==
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@axis.com>, =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705319081; l=4326;
 i=marten.lindahl@axis.com; s=20230329; h=from:subject:message-id;
 bh=xGUucvlIatyjRrDJE1pzdqErfXfNxgimwy9OhXFjGHg=;
 b=fvmNik2AbQ9Y+h2RY5XFPjVcGi/FCgahpQxLnM06ODHoLScxBT+Uefu8KHW01v2GwuAsH3wBM
 EG1bQbPofpUCVtrAuQuaRunSPj7LPLUkJo/TlT9JCTj5Mkjs19RczMf
X-Developer-Key: i=marten.lindahl@axis.com; a=ed25519;
 pk=JfbjqFPJnIDIQOkJBeatC8+S3Ax3N0RIdmN+fL3wXgw=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A1:EE_|AS8PR02MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: f09d0e0e-7239-49e2-31f2-08dc15bf5cb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TyuuZpiERr5NFF/8ytEp5oZmVSkcupMax5JTJNRV/oMg60Fv+3MMVjpKxuK7sI4QwkF7DMRXDoAI6lotUsOklW3L6SOK1eAH1Dd3R3MarNTv9+7gNDVVeG4ksfWPrdF0r2EzMh4vJnGph6seSCs0/wlra3XqqspyPeT9Y+tJgi9/po5496GfswyQvwJ23REyvfB8Zm74B0VQPpPEic/KQRaiEZ9sl/NWc244+uWFg7Qv03FsgTe2IwF9xWdNeD95AQKcYnvCUfQwX0ccVPG+zp7g/BrOXzVnnEvpNKoEOsAfPZkYvQBcKwy4iNsWOK3VLHmt6BAVoKgLJR59ZsrGYrp6aSsGtJ2cO+5wX6V2J8W8RarQuQ6voMfIZw5AeXHYdOzf2uZatLq+etS94/22Y2XpcwDiqF5aim6k5IWP40EgZjR9mlEnnzpWknaySOaNJtuxhuKnQ5qUjGf3sQMI+Ub2YCzZTrVnFxtuD8+mI8pqhWAfS2Nld2piKeaS0D4524/barW9Wt44/r+eKZpOHdl6Vw6aun/kzJ5fTrTiL1HmZ8gf70p5rxT7manQyBBQF77zyfp0GIVOCI2NKbsI2Vih5ARAou8Yvs4lVY+FSA2+8Kor0R8MemIZmp+efmMitfapf6EK9SSNkfqAVOyvbIsJd7OokTtJY+VWrjZvzVwwYEaBBsdodDDiP03LbA1FmIL6yHHfmuu+dZeF8Lejb3v72FUnJZGgAq2W4QZ+4sIlez6b4AKgjMIwX2kDJ0X+
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(81166007)(356005)(82740400003)(36756003)(40460700003)(40480700001)(86362001)(26005)(426003)(336012)(6266002)(66574015)(83380400001)(36860700001)(41300700001)(42186006)(316002)(110136005)(70206006)(70586007)(54906003)(107886003)(2616005)(47076005)(966005)(478600001)(5660300002)(2906002)(4326008)(6666004)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 11:44:41.7443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f09d0e0e-7239-49e2-31f2-08dc15bf5cb0
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A1.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6582

The vcnl4040/vcnl4200 proximity sensor defaults to 12 bit data
resolution, but the chip also supports 16 bit data resolution, which is
called proximity high definition (PS_HD).

Make the vcnl4040/vcnl4200 proximity sensor use the high definition for
all data readings. Please note that in order to preserve the 12 bit
integer part of the in_proximity_raw output, the format is changed from
integer to fixed point.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
Changes in v3:
- Abort probe if register accesses fail.
- Remove unnecessary brackets.
- Link to v2: https://lore.kernel.org/r/20231221-vcnl4000-ps-hd-v2-1-1b6790d30ae6@axis.com

Changes in v2:
- Update registers for sample rate to align it with 16 bit sensor readings.
- Change sysfs output from IIO_VAL_INT to IIO_VAL_FRACTIONAL and scale by 16.
- Link to v1: https://lore.kernel.org/r/20231221-vcnl4000-ps-hd-v1-1-a024bfb28896@axis.com
---
 drivers/iio/light/vcnl4000.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index fdf763a04b0b..4e3641ff2ed4 100644
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
@@ -386,9 +396,32 @@ static int vcnl4200_init(struct vcnl4000_data *data)
 		break;
 	}
 	data->al_scale = data->chip_spec->ulux_step;
+	data->ps_scale = 16;
 	mutex_init(&data->vcnl4200_al.lock);
 	mutex_init(&data->vcnl4200_ps.lock);
 
+	/* Use 16 bits proximity sensor readings */
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
+	if (ret < 0)
+		return ret;
+
+	regval = ret | VCNL4040_PS_CONF2_PS_HD;
+	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
+					regval);
+	if (ret < 0)
+		return ret;
+
+	/* Align proximity sensor sample rate to 16 bits data width */
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF3);
+	if (ret < 0)
+		return ret;
+
+	regval = ret | VCNL4040_CONF3_PS_SAMPLE_16BITS;
+	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF3,
+					regval);
+	if (ret < 0)
+		return ret;
+
 	ret = data->chip_spec->set_power_state(data, true);
 	if (ret < 0)
 		return ret;
@@ -901,8 +934,9 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
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


