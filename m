Return-Path: <linux-kernel+bounces-8779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F57681BC20
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC391C230CF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B9741C8C;
	Thu, 21 Dec 2023 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="N1gIBHrn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2074.outbound.protection.outlook.com [40.107.6.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD231643D;
	Thu, 21 Dec 2023 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laxzwBURjshYdzgo6ZxIngFae1KK03jEkoLJeKv0L+lL304cZUtCbkHsMU+KDCcB05Mp/qhabm+ZteV90OCDoQHceajbsjvTU2OAKutuhVouTZ5raaxmxwC4sTKIO/RI2uSfisOmVKnt/gg+0duJZ40hIxxajMqRTUeXa9YIaj1L//1g9RQ1lxXA0bcxHu9UlJHpSq935o7MUvq6B/zV7Y2JaisNXSzJJGjJf4Gvv/yoyQkUVZw/wbQcbUQAJsg0pbj8y1iivXGa5M/Jtu6UGmw5OaJ4SBYVvmYpVrb74c6vzMlpz41Awpneg/ry6dFEgPQatoNrbq1MSOM4cMnpeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gvtBNsbiB2AbYAW8pW3e6IcRrfTtQLJK7hRTAJpkn8=;
 b=Ngpv951Mh0N6YsG/CrWbfp9E+ThJH5kYWZuXPzJ3uSp4FGcpHMCzrsKGW5mCv7z+90BLrnYZHWSp3uFejGPfEgHOBRLDrbFCl1sB1fO9Wq7RFrkXz/iKowm5667lXGgp+lY8xoPgQlUGsViofsypEASlZ43rnC8Tvkaex0UOiKVc/IDTwe8EsCWaZPJLb0mZehOEeK8bGkVt/xxvsleiSeg0Qjp3zosaNU2BMPmtErwzxxQJuLPdDFjRB622Fmu6C2zRtJyKcTk+pfrVZQP6pgQcuKc0CEWSlW5p4bawXxbWrYBlUfBBn5asM0Y4q2LPW9Iq6KUeRk6lPSpVivNmDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gvtBNsbiB2AbYAW8pW3e6IcRrfTtQLJK7hRTAJpkn8=;
 b=N1gIBHrnV0zz0CDdNqKvrX/Urs5CH5SUDAnFE7ZW2mMxigCU8isGAdlSsCIc8kFn4gQu/2wbhFoM9wGmRGmhEXYf2E/jJvLLOLwrXK/atzrDDhKMV6fqfC9kzrrAqnpLabMMYIX+wgg7Hq9/ammLXjbPugdiCH4Dq30gKWswzkM=
Received: from AM0PR07CA0026.eurprd07.prod.outlook.com (2603:10a6:208:ac::39)
 by PA6PR02MB10459.eurprd02.prod.outlook.com (2603:10a6:102:3cc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 16:33:11 +0000
Received: from AM4PEPF00025F9A.EURPRD83.prod.outlook.com
 (2603:10a6:208:ac:cafe::43) by AM0PR07CA0026.outlook.office365.com
 (2603:10a6:208:ac::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20 via Frontend
 Transport; Thu, 21 Dec 2023 16:33:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00025F9A.mail.protection.outlook.com (10.167.16.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.18 via Frontend Transport; Thu, 21 Dec 2023 16:33:11 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 21 Dec
 2023 17:33:11 +0100
Received: from se-mail02w.axis.com (10.20.40.8) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 21 Dec
 2023 17:33:10 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 21 Dec 2023 17:33:10 +0100
Received: from pc42775-2107.se.axis.com (pc42775-2107.se.axis.com [10.94.129.29])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id EA543106FC;
	Thu, 21 Dec 2023 17:33:10 +0100 (CET)
Received: by pc42775-2107.se.axis.com (Postfix, from userid 21033)
	id D2C6C2FA7D5; Thu, 21 Dec 2023 17:33:10 +0100 (CET)
From: =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Date: Thu, 21 Dec 2023 17:33:09 +0100
Subject: [PATCH] iio: light: vcnl4000: Set ps high definition for 4040/4200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20231221-vcnl4000-ps-hd-v1-1-a024bfb28896@axis.com>
X-B4-Tracking: v=1; b=H4sIAMRohGUC/x2N0QqDMAwAf0XyvEBbxcl+RfYQa2oDW5VkyED89
 9U9HsdxBxirsMGjOUB5F5O1VPC3BmKmsjDKXBmCC60PweMey6tzzuFmmGcc+jZ1aUiR6Q41msg
 YJ6US85W9yT6sl9iUk3z/p/F5nj/oFyqgeQAAAA==
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@axis.com>, =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703176390; l=2213;
 i=marten.lindahl@axis.com; s=20230329; h=from:subject:message-id;
 bh=YfjuA39nKdg9iZSlK9r5X/Hn6DpToh4RHJ1CD+kZ3PA=;
 b=kUiDxUf3ZPeWg6mZ1otfM5IMb2m5RtK3Ym1ZZuApBfwQ9yjaJlvnrmfc59GaVxsrsDLz2x2Ai
 g1UsMv11zx4B4JPhFw08Nz7Xn/v+I4x3JvMYCjDzSfCixa2CXZZcIbc
X-Developer-Key: i=marten.lindahl@axis.com; a=ed25519;
 pk=JfbjqFPJnIDIQOkJBeatC8+S3Ax3N0RIdmN+fL3wXgw=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9A:EE_|PA6PR02MB10459:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bf1728e-4f6a-476e-fc2b-08dc024285be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Nj4ytmpGxOITi1DhPoZf4eoEXUKwzKggZvoKaZexyf3J0Mge+cz54PlbdJbpUvXK4Tgt8mTZsAHQpObdiypeSGRMRB3nzECRlfDaBYh91GtT2AE+gAPQJzXNjQfb1v5+lcTgz5FnMbqkMtrylAr6T5ic9gaSw/iYauK14AX9KNs/Vq3WKE+d6qTNRhsEvDUd17NcAfybM0vdTGLXg9FQlzjO6hFk/spZ5KeERzrhQnssSe55U59QMB1bHWaoDb9aK2PCIBsNjdEoe+/8C//H5/OKFo18U4IAG6bJICXxY9etctUbFmMBLNBhoRqqT2kUho9UkCSTcwv3yEamzeN9ft89dqWOz2rFnNWqEaAnYNPbJvb1K+g1cRWMCI2GqMS8vkfps6STDSuX6DFL1j3KOA73Jq6rgyJQrzZSqJuFS/RzMWgpzvJSUQaODlQBS66RG5DlmjxEOMteKedB/XRNxuau1D63o6M2cnoqKL2qj7xWA7hFSIjeegB3vNknWZLWXdI+eT+RvlHTfyuTfCHl+ZPfm+2g7aEEIQqCbTE20KmiX7KYQiQMxSJIQkcD0h7ClXIrkLkHHHNn5AVPIoFdOrSWhCRZd8mNKRHkcHmpbC2gSVS0QfRyO560lQjNAHgjCIO7xuUykT0Z51iHxK+IboV2feX7xZTTfVZZVvZlU8wCjCc4K/IVRP0eM6wMahJcArL2MwKYR2gJd6pLXc748YLbM/N1gCdOAG0X0InkP96Yj5ANcNc7n4U8H7NMotqJqFOytiUKMabSSwO2uVKXVg==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(36860700001)(82740400003)(356005)(81166007)(36756003)(86362001)(40480700001)(40460700003)(107886003)(26005)(2616005)(478600001)(66574015)(426003)(336012)(4326008)(70586007)(70206006)(54906003)(6266002)(110136005)(316002)(47076005)(42186006)(83380400001)(8676002)(8936002)(41300700001)(5660300002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 16:33:11.4438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf1728e-4f6a-476e-fc2b-08dc024285be
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F9A.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR02MB10459

The vcnl4040/vcnl4200 proximity sensor defaults to 12 bit data
resolution, but the chip also supports 16 bit data resolution, which is
called proximity high definition (PS_HD).

Make the vcnl4040/vcnl4200 proximity sensor use the high definition for
all data readings.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 drivers/iio/light/vcnl4000.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index fdf763a04b0b..4846f3b698b5 100644
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
@@ -345,6 +346,7 @@ static int vcnl4200_set_power_state(struct vcnl4000_data *data, bool on)
 static int vcnl4200_init(struct vcnl4000_data *data)
 {
 	int ret, id;
+	u16 regval;
 
 	ret = i2c_smbus_read_word_data(data->client, VCNL4200_DEV_ID);
 	if (ret < 0)
@@ -389,6 +391,17 @@ static int vcnl4200_init(struct vcnl4000_data *data)
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
+	if (ret < 0)
+		dev_info(&data->client->dev, "Default to 12 bits sensor data");
+
 	ret = data->chip_spec->set_power_state(data, true);
 	if (ret < 0)
 		return ret;

---
base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
change-id: 20231221-vcnl4000-ps-hd-863f4f8fcea7

Best regards,
-- 
Mårten Lindahl <marten.lindahl@axis.com>


