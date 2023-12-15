Return-Path: <linux-kernel+bounces-943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824B8814855
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7C43B22E69
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB612CCBB;
	Fri, 15 Dec 2023 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="UQU3CUJW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2088.outbound.protection.outlook.com [40.107.8.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9492D7A7;
	Fri, 15 Dec 2023 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQtRQbfnUhmrLLeZDiCMPzjKiJin+4CuPdGNalu0iopEC7Jf8xRd1Kf+xub/7A+/mk9Uw8jJPO2kZFwevh0tkfCknPvYjnXt6B0SLX5TxXpn0tniJwAChKbWjfo4Nk2AjS+EwC/UmfAD1FhWqrSnc/gGVbbGy3azEV+OgVMz6jVOKBU0y441cpl2jL5lBwQe0NwirQELkKzEcoFzxcadMswJs+KYMuwcWDa3YiqVDYOfR8bi461ephVPw9vLwd6Xpyi51XsVTEZdlQEdqZ0wsBjJTkZh+JrU1YMPq29e/pVW8iV5R7kHjK858xXZ1OYdt2ke47zDWG8B6vUaXB4KhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UgEm6jGXUzmxCyOfqh+FEbc0eSkL1Nw/Y/sNtqWYjA=;
 b=FSxKoZPHEbob1uHsyJSy3E+HvD0oUkcbpkZBLX6vifgRfLITuDFlI3PgjcomuQPpceqgpwwUuOFWW7VG54agy4afdhWvlPCWJQfrHBSP5kNBA4/N2OBEI6Pp2qbOhl4Di72RrwOsw/7VhI5exbd2vQUeFSP4blTW2+Vv1NEjrNhqmIuaJ1Q+K9V1AE8WFhMs2qvIy71QC0ldLJd1r5VXgYyx//R53b16+bxjmzG5hTUux6motThuw7F4QUPCdbrj6Ie0GCuPQKBuEd+7PLVZVHjGnec+cA7uJqU18Rgnpi8pVTh1YDcTP5ch+hCdURdlhMSsleSYoTKMnqlkC9Si5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UgEm6jGXUzmxCyOfqh+FEbc0eSkL1Nw/Y/sNtqWYjA=;
 b=UQU3CUJWt+BsAQjsJ4GMxigB8JDLdtWp1rYRftMfnBwH14V9Jw1XriQk4fX1499395ICMCtxG2HzKukkuyem8GfvDVqagxDQr0Vx3MjgR2gagA/0j94H6A2gGG4v4toMvWVPPrU6ITMUQtzQZcBOwiJTss3qnMR2khPTUlLgxJE=
Received: from AM6PR0502CA0059.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::36) by AS1PR02MB8003.eurprd02.prod.outlook.com
 (2603:10a6:20b:4d1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 12:43:18 +0000
Received: from AMS0EPF000001A4.eurprd05.prod.outlook.com
 (2603:10a6:20b:56:cafe::3f) by AM6PR0502CA0059.outlook.office365.com
 (2603:10a6:20b:56::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28 via Frontend
 Transport; Fri, 15 Dec 2023 12:43:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001A4.mail.protection.outlook.com (10.167.16.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 12:43:17 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 15 Dec
 2023 13:43:17 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 15 Dec 2023 13:43:17 +0100
Received: from pc42775-2107.se.axis.com (pc42775-2107.se.axis.com [10.94.129.29])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 3A83C10035;
	Fri, 15 Dec 2023 13:43:17 +0100 (CET)
Received: by pc42775-2107.se.axis.com (Postfix, from userid 21033)
	id 33A952FA7D1; Fri, 15 Dec 2023 13:43:17 +0100 (CET)
From: =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Date: Fri, 15 Dec 2023 13:43:05 +0100
Subject: [PATCH 2/2] iio: light: vcnl4000: Add ps high definition for
 vcnl4040
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20231212-vcnl4000-ps-hd-v1-2-1c62a95828c0@axis.com>
References: <20231212-vcnl4000-ps-hd-v1-0-1c62a95828c0@axis.com>
In-Reply-To: <20231212-vcnl4000-ps-hd-v1-0-1c62a95828c0@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@axis.com>, =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702644197; l=4875;
 i=marten.lindahl@axis.com; s=20230329; h=from:subject:message-id;
 bh=reQw6rieOSSDmthGg/ptStNM7AqQg+3POYVpmRVbC9Y=;
 b=h3k/+cK/LLd8JNNgMqbfIPnCuQ/rnpMr+QFVUZ/Wlt9rsmY08JPmtm19YfKb/z3cEivHOajml
 Ff9BOSaxk71CmX0CkL9M2/SoAI/Hx2usFBLJegjRWklwkK0Z4vkP8qS
X-Developer-Key: i=marten.lindahl@axis.com; a=ed25519;
 pk=JfbjqFPJnIDIQOkJBeatC8+S3Ax3N0RIdmN+fL3wXgw=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A4:EE_|AS1PR02MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b7effa-f846-4f97-66e9-08dbfd6b697f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rpAkTTLNsOF8QiTJEljo4FkUxS4PCIbB/rvQh2w8eCf1zatSDfjwlM7HHTVnEoALshhRVXx2qs4lMwl1l+lX/DWJUzuBDwjBuLZ+uXhIuA1554s5kfGRANXQQkKIY14v9abRXts3y38j/IAPIyM781yFJfTWh2BONxYaIRXzSyQg4DLqAM0f/fsOcIuXJF8rQuT4fhN+xTAppC5AMP99wUae6UVCvxoj17PuDeqGEZI8tGl4NFN9XIPIlwQ6cdp3y3N2kYjdVHxSZhAJ14GpPOXiUSemvtMuPnSvZoj4a0pLKYHOV6qWSAQmF72zn5KMSE7ucxOpAo7KPLddIGTqPIjeutZK5BuK2oJ5iJn4yXeeq5mJnWcWoWqSCkrh+t74Mr//KFFY0jGihUHWaxCb+6F7C3LlQtZ3mOTzBStyGh1LIvpqFpdrSq383yibNXUc4GR03Xr5gv388WevzWxYgJnwX3AvFUttOu9RjX9jKkJlGK4kNg6VpwjxpT810Q963DMWl+tmxgyKyirXgixa68n7tG4obTCyUD72p3Ivy6nSJb+m1Hk04L3PyXaN16GrQC389bFThq17uLoWdMIRL4BL1ZP5vfIdWvLh0mFzBg+tZ2gV8jqBGpw8XhfCbPiPbzEIpRRi6CXjTSoZflACc0yNqkps4Tj1bZPy/hDj6VSLwfcgEQoMPKdLL3zzIW+yTRMQZhcWqmtYOlqcijgCuI3WyFHrfoFkiF/l+gfIOwhsZclQ+zVhsHK/oAGlqDZ2mQUkfyEdwHuOqCOug9gc3Q==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(6666004)(2616005)(6266002)(66574015)(336012)(26005)(107886003)(426003)(478600001)(83380400001)(86362001)(47076005)(8936002)(8676002)(4326008)(36860700001)(54906003)(70586007)(70206006)(316002)(42186006)(110136005)(40480700001)(5660300002)(36756003)(356005)(81166007)(82740400003)(41300700001)(40460700003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 12:43:17.6029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b7effa-f846-4f97-66e9-08dbfd6b697f
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR02MB8003

The vcnl4040 proximity sensor defaults to 12 bit data resolution, but
the chip also supports 16 bit data resolution, which is called proximity
high definition (PS_HD).

Add read/write attribute for proximity resolution, and read attribute
for available proximity resolution values for the vcnl4040 chip.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 drivers/iio/light/vcnl4000.c | 87 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index fdf763a04b0b..2addff635b79 100644
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
@@ -170,6 +171,11 @@ static const int vcnl4040_ps_calibbias_ua[][2] = {
 	{0, 200000},
 };
 
+static const int vcnl4040_ps_resolutions[2] = {
+	12,
+	16
+};
+
 static const int vcnl4040_als_persistence[] = {1, 2, 4, 8};
 static const int vcnl4040_ps_persistence[] = {1, 2, 3, 4};
 static const int vcnl4040_ps_oversampling_ratio[] = {1, 2, 4, 8};
@@ -880,6 +886,54 @@ static ssize_t vcnl4040_write_ps_calibbias(struct vcnl4000_data *data, int val)
 	return ret;
 }
 
+static ssize_t vcnl4040_read_ps_resolution(struct vcnl4000_data *data, int *val, int *val2)
+{
+	int ret;
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
+	if (ret < 0)
+		return ret;
+
+	ret = FIELD_GET(VCNL4040_PS_CONF2_PS_HD, ret);
+	if (ret >= ARRAY_SIZE(vcnl4040_ps_resolutions))
+		return -EINVAL;
+
+	*val = vcnl4040_ps_resolutions[ret];
+	*val2 = 0;
+
+	return ret;
+}
+
+static ssize_t vcnl4040_write_ps_resolution(struct vcnl4000_data *data, int val)
+{
+	unsigned int i;
+	int ret;
+	u16 regval;
+
+	for (i = 0; i < ARRAY_SIZE(vcnl4040_ps_resolutions); i++) {
+		if (val == vcnl4040_ps_resolutions[i])
+			break;
+	}
+
+	if (i >= ARRAY_SIZE(vcnl4040_ps_resolutions))
+		return -EINVAL;
+
+	mutex_lock(&data->vcnl4000_lock);
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
+	if (ret < 0)
+		goto out_unlock;
+
+	regval = (ret & ~VCNL4040_PS_CONF2_PS_HD);
+	regval |= FIELD_PREP(VCNL4040_PS_CONF2_PS_HD, i);
+	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
+					regval);
+
+out_unlock:
+	mutex_unlock(&data->vcnl4000_lock);
+	return ret;
+}
+
 static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan,
 				int *val, int *val2, long mask)
@@ -950,6 +1004,16 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_RESOLUTION:
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			ret = vcnl4040_read_ps_resolution(data, val, val2);
+			if (ret < 0)
+				return ret;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -987,6 +1051,13 @@ static int vcnl4040_write_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_RESOLUTION:
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			return vcnl4040_write_ps_resolution(data, val);
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -1035,6 +1106,16 @@ static int vcnl4040_read_avail(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_RESOLUTION:
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			*vals = (int *)vcnl4040_ps_resolutions;
+			*length = ARRAY_SIZE(vcnl4040_ps_resolutions);
+			*type = IIO_VAL_INT;
+			return IIO_AVAIL_LIST;
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -1808,10 +1889,12 @@ static const struct iio_chan_spec vcnl4040_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			BIT(IIO_CHAN_INFO_INT_TIME) |
 			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
-			BIT(IIO_CHAN_INFO_CALIBBIAS),
+			BIT(IIO_CHAN_INFO_CALIBBIAS) |
+			BIT(IIO_CHAN_INFO_RESOLUTION),
 		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME) |
 			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
-			BIT(IIO_CHAN_INFO_CALIBBIAS),
+			BIT(IIO_CHAN_INFO_CALIBBIAS) |
+			BIT(IIO_CHAN_INFO_RESOLUTION),
 		.ext_info = vcnl4000_ext_info,
 		.event_spec = vcnl4040_event_spec,
 		.num_event_specs = ARRAY_SIZE(vcnl4040_event_spec),

-- 
2.30.2


