Return-Path: <linux-kernel+bounces-156294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE118B00E8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13D3F2847FA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0FF156875;
	Wed, 24 Apr 2024 05:13:45 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2103.outbound.protection.partner.outlook.cn [139.219.146.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B5C1552FC;
	Wed, 24 Apr 2024 05:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713935625; cv=fail; b=lOdwXGkc0c7RWd1QLXrMTVmoo2/EGLjZlpgvIBtGNYod77hSsjwbeBeEDsNKqs3RN7nVo4DeAYdEsfR1Y9e3WaUfq5mrUqB+ClH8YvpdPFpL8PP0ldnkRYQXd+jQ3uiXoomdjrT0a1/tgVxH2Qu59vS6eAXK5lR6/6z9SY2QodE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713935625; c=relaxed/simple;
	bh=b1Wr2FQQ8edG1QXlmD8JBcAjvqSZR4X9Xlisar+4XYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JigAFxMBNGD4gHlYtgHvPhmtkhnhEvn22FFuKNAcHMFEnmDDihWviawiSpazxthsSIZVv8XCG1jTZVK3uxi+1DJGE77XGuNwRn6T3rg1tmpWDbEQncWPxbRMJi2HdhnWWLp+lNl8VstCKTO39Al+V7ITS4S6d4FK7Iq3XOqJIF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acvJi86MSQCJwSGswZIA7/4U3Ydb5HBvPS0D198d0JAvaBMP9aU42SFvTnFEO4fd8N6VYfMt3vyDtPKuhnudnpm9fSJnyOkWMG+0OiWNtZ4QK/A4a9Uhpz+bkS3On3J2ebGMmM4W10ksGtn/XQNViAYAZ0TR+xSVr1dXvR3tDoewI53T2b2Z0OnhSemUvu18HS/h7pdCtUiu9dex92GywqKOMi47LaNCHN89uvgIOQJ/ZstKuDRwJwPFmicXqhkD7GCWtfiJ1WU6odQ/SxN9rDJQFvF6/7dcLPYphbH7hyvoi/ioXrElEFW1E8tGegVdT6XiQ0GeFibVBxQhgQorrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJ45zfvFr8YH4sbFeZ59Y323p6m7eTtOClDR6YZehic=;
 b=UgqBCLMjl/sDwIXGKe7PJGD5qsWa/ccbWGwNrazbicJULR5iM626khHCdu+aWY2PgQytqXRstSnfqDzNcDgTE9DrbMXnBCaBTXKfz6tothksUH7N6dXjg8AdwMW8HK5lqplmFDCzL+0isHJfFjvbbEzTuqPO0R6GeUufgDlriRfXC+FkPLdbRXW4Qfe4cfZ4rGHBEfeBC7hGUzj5Upl0wkyEj4eOCtOY2nFvUoQZYr9yg0q86NwdQL15AmVrLxFKZgNHtiRwsi+s8XXVBin41Jw40IdnxSZW9kM7PAPj4/OKAxof8+np0X31rx2TrcdgQ4Khv2kABUkXLvqQ+Bwb+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::9) by ZQ4PR01MB1268.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 05:13:34 +0000
Received: from ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 ([fe80::301e:ec80:4356:8b14]) by
 ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn ([fe80::301e:ec80:4356:8b14%6])
 with mapi id 15.20.7472.044; Wed, 24 Apr 2024 05:13:34 +0000
From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Michal Simek <michal.simek@amd.com>
Cc: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eng Lee Teh <englee.teh@starfivetech.com>
Subject: [PATCH v1 1/2] spi: spi-cadence: Add optional reset control support
Date: Wed, 24 Apr 2024 13:13:16 +0800
Message-ID: <20240424051317.2084059-2-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240424051317.2084059-1-jisheng.teoh@starfivetech.com>
References: <20240424051317.2084059-1-jisheng.teoh@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0024.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::8) To ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1154:EE_|ZQ4PR01MB1268:EE_
X-MS-Office365-Filtering-Correlation-Id: acc065dd-291b-4286-10c4-08dc641d4a6c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6LeCuUyjvkJ0E+x6IJWQrqI2wFGhQ4iKzHmgAADp9hZ3csfFUp5ZdlbRA4nw1H7hw6Fuh/rxqFf2ZbwkepnBKQy5Ez/+YFtnM2gtMefDv2Ndnl5LZCR3hhn7OmomOb/PXG/RBkzzjSwNW/KEq/CdE2Fa+0O/XQWYHkEkrGRBeQv8c47w+pS6qNqDNj8Hl6QG/+l4hwmu9jxnptoFjDWzpDsyhMgGcTvGf5KmKKHCvNFqlsIvSXYufrNz+zaq5mkyNroCaux4sedoQrEGRt3FAmqbqZPsJoNP9Gvl3DEIXoWxM8cpQ8lG2DxpWk6Q5uXqInoOv9LQ41msORoQyp7uDBMIEHygPAeJMu5BIjRTOqJ4OHhiHRy5sJIfroSuFz9Taw3D/f+kUM9vbKL4PaHNdqPUYsYysPUBNfccZtsJEYvKDMdZAJ/osPNKZZCEk9Aw9hbgaTxQhoHw+GO8mPQnMBhNE3RsZAoIbpFXmbxDwP8LUZkUZEtVkSSOlUuqs600sdJhgjeVz7Wfa3GdjqD2IHX5UIAnlhayGvnP0Mn7CYgdu94aSR41R5yjhv/2WjvvzifZxwVTKPvM35HrZgHGZoNr45rj2+wi6BPOCT2cdkjDu2FdC3a02MfOhAeFXQ3i
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pSly78CsVzafIw+NUoe7KXiqbCvjBNvy38ta/waeaUMQrVE5xTfCUP+Ud+jx?=
 =?us-ascii?Q?OURHrGH1D27evKyahaj8NdAeSIMNxuXbzare1s6m5MB77OSb0/TIvlH66nKO?=
 =?us-ascii?Q?0TTO/Fdajj4cZERtfCTVOKvMjfN9Sm9tqsm1lwT0pnKCT0QCjPcrgEtMSZJe?=
 =?us-ascii?Q?RbiFtyHniv2HNGD7/wnqPPmsPKCF83aGyLHT7nLvhA0UAWJku7qTb68FxiZN?=
 =?us-ascii?Q?rzBq2kX6eS+qPoh0PcmnUFgHtIRM904Ow6aP3roHls4xxDMfEToByJPP4581?=
 =?us-ascii?Q?oajq/Sdvgod2kgO/0FqAvUorwrnbUxwxwmk5dXLWInIQBtixnFuu9LXeywIj?=
 =?us-ascii?Q?dJdCTFlTjvLQurdS0EmxyRfcFSJ6UT+Rh67vhvg1Np+dLhd9YItRoz+tSXnw?=
 =?us-ascii?Q?FLYep0yg2DwNN1jKLu/1u8EziHodC1FXYVHTrhtKsE+sY+AthtpHyHjFJ2OP?=
 =?us-ascii?Q?xE3FMaLecbmlQcixfKaqJMHb0oB7XIeGjc/dqTmlV6ljQXspvrHEti1ybwYe?=
 =?us-ascii?Q?l7hNYx1XdKssDTHTE7JkQJKAiOh4ydYBNWP5E355tKOUsSr665UCbWEgmmw6?=
 =?us-ascii?Q?9gUgT3fnva759tvONdnrhUFVo9Y5BFGlrDUTgJyoTaWyMzwTJm4kK3NGojoy?=
 =?us-ascii?Q?DDgMzCmxWHbXkyqheIgaG8VMmKgb01c4e48Sm8VuSCeurnYdrNXeC0lVWxwg?=
 =?us-ascii?Q?y7uCFlsbs6r9A3ZitXsVvL7DxBohkAImIlAM9IxRemdMzd5IPkxQHFryjPh4?=
 =?us-ascii?Q?/uv91NwAeACnR7e0lkTyWw9fPvfvNa9rHiDf8VKV2fjWB38N/RiB3hTy+TBT?=
 =?us-ascii?Q?nEix0hc9RKZZtj5TJl3/SVWRiTUnibsRTHZTREsriXAb98FnbnpJL7E2bht/?=
 =?us-ascii?Q?XTiRTwNiU6WuS0CvAXb5JaTG4LJHkkLwnG0uZ+dzI1WX3qNC5o3Vej9zpElQ?=
 =?us-ascii?Q?2FGuOaTtu//zB91K+XPc3tlCbqvFOzIY37x8de0li10Ja5V1PBGJR51iCdxs?=
 =?us-ascii?Q?GvIP0tZHEdl41WMec6RSTduQwN2awnn8iZ6OH8nSQHgdupGuwhztE4x4fYMH?=
 =?us-ascii?Q?ojWV0PEHTCvt5eJ77SSH+wIxPUjbaRdjX7oFjM3zs4P952lvuXondaOQeP0y?=
 =?us-ascii?Q?lW36Z4P7YKCMu+XQr30xBEWkDR5tzKabzFFNf5lv7MCsN7Lhj8NJcEKk/tZC?=
 =?us-ascii?Q?saL7aQqi8T375z/FwJiwVSodHMd5xExv5KsLoUh4rNFYt4b4m0lYNh8Tjhiq?=
 =?us-ascii?Q?KbpSa8DV8PzpDfe0PVi6TsX0oaQArl/xet4y4GbxPiGuqEG/pyajPDYcF6O6?=
 =?us-ascii?Q?bBLSUc1PiwjFiOmyCyO6ZYchWd7URKZ4a4u8y6zkWTN1PmRDpzo2+BCkScOy?=
 =?us-ascii?Q?J2kTMWSU83GgQbRxYq+jB3y0whUkBOGvA5LlgQFB2QlquR5RO0AOTwquKQLi?=
 =?us-ascii?Q?EfKRNhA7cKhSVx9ms8eeZTI9o5LiJak5uHZKEbSWaEDz1ugKhvs1kO+kQ2jo?=
 =?us-ascii?Q?8JRUi8qfXSoEobZGfpZxxtsE60Uvw4ow8WQ6I5INNVVUqvdtCw+Qw8me5420?=
 =?us-ascii?Q?h3T3OAvX+6iRa7wUXw3kG5rQUyBOqPWco1IEmPSflnXgBoBMb+0lGLMh2Zw9?=
 =?us-ascii?Q?AA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc065dd-291b-4286-10c4-08dc641d4a6c
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 05:13:34.6839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oapej/tjWyrm3sf6RruQAF93eIN3sEHE0sAc8GIecpcegg607B4AMtuLQgHS7F7K4AOg/T8LxZRPAhH2DUjbC5hHgNFLzZrNMR3hGJHoLsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1268

Add optional reset control support for spi-cadence to properly bring
the SPI device into an operating condition.

Signed-off-by: Eng Lee Teh <englee.teh@starfivetech.com>
Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
---
 drivers/spi/spi-cadence.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index e5140532071d..41f2f51d39e4 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -111,6 +111,7 @@
  * @dev_busy:		Device busy flag
  * @is_decoded_cs:	Flag for decoder property set or not
  * @tx_fifo_depth:	Depth of the TX FIFO
+ * @rstc:		Optional reset control for SPI controller
  */
 struct cdns_spi {
 	void __iomem *regs;
@@ -125,6 +126,7 @@ struct cdns_spi {
 	u8 dev_busy;
 	u32 is_decoded_cs;
 	unsigned int tx_fifo_depth;
+	struct reset_control *rstc;
 };
 
 /* Macros for the SPI controller read/write */
@@ -588,6 +590,16 @@ static int cdns_spi_probe(struct platform_device *pdev)
 		goto remove_ctlr;
 	}
 
+	xspi->rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(xspi->rstc)) {
+		ret = PTR_ERR(xspi->rstc);
+		dev_err(&pdev->dev, "Cannot get SPI reset.\n");
+		goto remove_ctlr;
+	}
+
+	reset_control_assert(xspi->rstc);
+	reset_control_deassert(xspi->rstc);
+
 	if (!spi_controller_is_target(ctlr)) {
 		xspi->ref_clk = devm_clk_get_enabled(&pdev->dev, "ref_clk");
 		if (IS_ERR(xspi->ref_clk)) {
-- 
2.43.2


