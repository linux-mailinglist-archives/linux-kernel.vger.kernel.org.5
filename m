Return-Path: <linux-kernel+bounces-8698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8D881BB3A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A5C286C8A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACCA55E46;
	Thu, 21 Dec 2023 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="He8pDCV7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2088.outbound.protection.outlook.com [40.107.6.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB8E55E40;
	Thu, 21 Dec 2023 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMscm0r35LjwL3CFXR62c4gJ6o50vQniFUYMbSXumfG5GZb4EGRw7E3pHnQ7A6PWC1iRNNgIBJuZuWevumtenJPuRvYew+ptSbBlLkBKEIWqKMQADvfzXaSopz9wLPBu9FogA386AhFoMqnvqIn//PpzG0cZcXUBO4t0z6gw3mAh8ZLG1ZJHHikaAGkDoPGJkpEKJv2Q17ED5VJDixa5PsXwJ8N0NzlZnWK4jmlCSBMDE/jzpOu6XPE2sS87YhfAS7N7Pt1NmNdtK7eYOTgWS75xj/7I2GvGY4VMY88laTxnKRAkLFTgVTIc1inO5t//lGJj4K/Udc9zVBXlCghgFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpKKXSAyO9uvD12+EVLjQVwPZsZbc/ScMYbPDC5U6fU=;
 b=EN1ybIckpAV8EmwXN6JctA3Awtw2HCLWTAkolWpRx1CSVtrAuts40fwxdls1dEASE9ISte+DRu0OMx4hITLvTbXq2SgR0xfdvEfuGl8yKeuxFXsuMJddf2R0R8neiabJmMX+8tXO1uDm2lFG3Kt2VX9q++FE388pO3erV/4lH28gTfYT7eu7gKDE22RlPkYtBHCvUwD9ndNZzdWEMTR28GQbrtAnVx9kA40zw9QLe4Np4P+HtR4OwvdxZTIoIwv7RCYLO0vZl0wswqRCHh5RgIckKnHxRxWla4xniK01CY//mr4Qsrqg7H+hXpr8wpQtGugV7c5UCqfgXWDepOVPOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpKKXSAyO9uvD12+EVLjQVwPZsZbc/ScMYbPDC5U6fU=;
 b=He8pDCV77TrZTl6sy1LQ0BOVz9SSSjaKPRc533hVG+/EkUqBCPmwYLLkwWlx9ydDrvQQDTxyVQqf/3V0JlozQ1jL6J+zvhj1PunXw83X06lrUlPuQ4buwplCDUL37FqH6GoPfIL39W3Slr98E+aPJW+0ne2oRzrVHZe9KJZ34bU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by VE1PR04MB7438.eurprd04.prod.outlook.com (2603:10a6:800:1a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 15:44:40 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c%6]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 15:44:39 +0000
From: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: andrei.botila@oss.nxp.com,
	sebastian.tobuschat@oss.nxp.com,
	pirea.radu@gmail.com,
	"Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH] MAINTAINERS: step down as TJA11XX C45 maintainer
Date: Thu, 21 Dec 2023 17:44:19 +0200
Message-Id: <20231221154419.141374-1-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0021.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::26) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|VE1PR04MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: ad3e6673-b1bc-41be-6d66-08dc023bbdbe
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KOuPEwTYaHUlumZr2virbcsvRFHfI+x7ReA6fxov7c7FNIvCFOkrEIZ+utdOq0ApnxoY6T55DCF9opbI+OLHo2fXkVTYGT1ddY+2uZb/Sco/wKLHwuY59E97s1X9MFteVCe1YnI39fodVelP+6/ryxHzPm9DUQ69LxLJVdpq+6hfEv6ynfyJJk/EqN8vxFXUECBTcR7XKrBpv5z0lSZaQKr8kbPweRG4yozbXPcFMRZR/WVWJHtNx31aZkKX//U7LV9KeiJ3/amteZxRiMnldVGOs9tDDCCjz+YQIIwFKa3GK+La1M8unhjaE1hF9mUKy6s3G8XAZnkrZSmm7YgQ/r4NpL6+dgMd+DD0Wp0p/a/gm0d7INIkz7o6rlmFF5K0lb1nFCvZVWvYoVU8t+mBXZLNBA+aTbmPlDwK6FTNvtggCo0zjeo1wVo47h/0bu3xCXyDwAKLeTkFQVFEM1stPdxehPT1KbP7w50CqEZ2ZYX43HppQ+vQrQIpiC8YVIYnSiiNhNNYfyvZZvvZd2IKzH7Jol4Tm+R43Ta5evnHjjfTTIuNg1AG4oHtVnXfT7BryuYn82tmGCQbxCxAkyoX0md3yzW+YmzrEaL16hKZvGOLUqcZs0fqitgurR8dLxh8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(38100700002)(6512007)(2616005)(52116002)(26005)(1076003)(4326008)(4744005)(8676002)(8936002)(6486002)(5660300002)(478600001)(2906002)(6666004)(316002)(41300700001)(66556008)(66946007)(83380400001)(66476007)(6506007)(86362001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r0bMfNokVrdGB/JO+E/l08YfLbPbHUcP+hJwFKnig/RHgIPRmbCd9ucqDIut?=
 =?us-ascii?Q?UDijfj48aAEff0/rGD+IaLaZjcj/KRSGLrW/jhzDxU/kkR1BgzEqLUu/QCZF?=
 =?us-ascii?Q?4SuoayX5xfr+fAokh4xjFxMxVXHrP/EfHbswnhkqQucobFEDiUI8j+mlrHZC?=
 =?us-ascii?Q?WqgnFQS+ELWcI7R3MVO6esObttGpatB3+LXuLDwu8gWwkL8wdCuS20O+dDiS?=
 =?us-ascii?Q?pEPW9jkFI381Y3K9DGcN6/58inWSnF54mkFx6PiBoMf3FuvJzYD1GbenqjII?=
 =?us-ascii?Q?S7g8uLeuRll3QAUVjnaMDT+NB7Kq3ISfMH4xzjR2xg4Ib57I1vBFs22gtg8+?=
 =?us-ascii?Q?DPZxiuCscvfxzBBFtLL41lXoIZ/6cvmONE0SqogAVUZYX/eQGV/cBrjn5yvT?=
 =?us-ascii?Q?F+btSCmvr9rU8IMMEUHj9rlr9l0EDVRHzyq/Za0qtn5/JcwRB3U077ttha59?=
 =?us-ascii?Q?8cCNO8CUXKquvYSRppVSbMfz2h7kuUfnN2YRuvjhWNWXKRPoSsgpVQyDjFor?=
 =?us-ascii?Q?lp5lYunuzpEFmctXdX/oafK7QjDNB+OKf0QoeCab93dnc714w1F4XoUzGedG?=
 =?us-ascii?Q?3RCnjcT6ygaYBMU6PiuDHwZi4pV43Y/qBPTUMN1AG2tJSQJVdpRY0sowBzWN?=
 =?us-ascii?Q?Nf9lOdAFZzfEq6f37wbaWSOxdjrkVbVpyMThWzA2DOHazvaUyA2Tp1M9SCi7?=
 =?us-ascii?Q?Fq04Fw9RiSaRBZVSIpHEwvUtWEEaSwn2X6uCp9QGU17z3842Fj9the1jD98+?=
 =?us-ascii?Q?mnBFvwt/pqgrXY9c2E4I83JV8t64z2muSvBJcY0L9gmnm6NBZ1iRWDYBw/96?=
 =?us-ascii?Q?2uu5vqhNiqkeJID14E8g4hyqcthCqjj7SFApe5v4Wim5TO7Qer5SwHyBtS6x?=
 =?us-ascii?Q?raqQdKh5Fme+sIKNM2VdPzRYRsQbCqrnc6VVyzPm9yHZAslaOMgCh09scsea?=
 =?us-ascii?Q?fSq4pnwAdb8xQZ1eQNp7UcUCHoiIDW0VnEJD8jidpZcmL3Phvcf5hW9Ka2Wg?=
 =?us-ascii?Q?RD5LFaDJH4bUNSGw6l5bDYoAyjgqtr//IrEGao0DnN3axDnjQu1PDyVoil3X?=
 =?us-ascii?Q?dtYj4x6MsqjaLo+qABhIH3gekB6sdn7qwpSATLOlWS2+vWF39wKepdvtSROd?=
 =?us-ascii?Q?o4Rz3snsjIIDPJCIqWwhxobsW/sjVaTEsyw4PjhBcxdfGm660QBvebqe+mUJ?=
 =?us-ascii?Q?1GRveFHN1fztuZdXhYA+Cq6C10Q2nlMv+2b1LvpXxYCCBQUnOhfcaQe+kk2L?=
 =?us-ascii?Q?d0rhDtUmL2a09olxyzn6bHCYhYMa83q1/H2MEMk98dpiUkAXkkayI825lT6Z?=
 =?us-ascii?Q?mhECgkkflxJkKzilHEwMfyRrTo49hl8uf4hic5r+zGjidG3QShV1gKTRC2b7?=
 =?us-ascii?Q?BT7ljvr37u4gaJz9np2WPc+ZZd8LEWkaeEgtg3QLOWZwc4T/UHdmekNiZ6ox?=
 =?us-ascii?Q?85G5XWfHXhozP2seyce/Wd8/7ZPLN04AqAEW2KQDVQ7vkfVMQIo78U4I7a9z?=
 =?us-ascii?Q?YsgRE0G0/k184DqG3Vlq2kZmjs7uqmobPwK2Nmc4vsozV+IU7TxFExSfHvnR?=
 =?us-ascii?Q?qMNArxGHJ+JimVpatq7b5ZKGueZ8Y/a9A24Kb6nSlFSXZd3h4SZd8e6ePqNO?=
 =?us-ascii?Q?iw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3e6673-b1bc-41be-6d66-08dc023bbdbe
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 15:44:39.3260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3s/jqX88rBnpnBQDURgRczsh/9doVgugcxmzNSE/9nFC1lsHW/IujIIW+0WWNjVSH74qI0Eh42OCMIhXalgnbA9VhD/lXwxLkH1B58DkJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7438

I am stepping down as TJA11XX C45 maintainer.
Andrei Botila will take the responsibility to maintain and improve the
support for TJA11XX C45 PHYs.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dda78b4ce707..5a3cc0ec1cf2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15440,7 +15440,7 @@ F:	Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
 F:	drivers/bluetooth/btnxpuart.c
 
 NXP C45 TJA11XX PHY DRIVER
-M:	Radu Pirea <radu-nicolae.pirea@oss.nxp.com>
+M:	Andrei Botila <andrei.botila@oss.nxp.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/phy/nxp-c45-tja11xx.c
-- 
2.34.1


