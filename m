Return-Path: <linux-kernel+bounces-22847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0450482A3ED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 124E1B271B7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645CF5025F;
	Wed, 10 Jan 2024 22:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QlOoX64N"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2053.outbound.protection.outlook.com [40.107.8.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B6450256
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 22:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbJgrYsrYlH1S2Zl95jBBzyadghnypDY3WBQkw1BlJgDdI2YHUWQbAU6aq1O+iVa9i0C23Ige5eRpv4exfaz+W9DQ+hlCenuet9zoO6dLD/h/ZXw1gCJ9qaMqi8pAqvci+VQhydl6eQmOi9ngyye/luUpuZslZUexjJrJSDs8XcG0Mq++DOyLxWoZuzkschZ5A85QTm2iDnOYtxB+7uL+U6+cfXGlp5cBf6P/0uIGkowgUjjAFaZ75unVoiNlNuYfBT/l3HoSTeymjpDlyCNdJA98EOXg2r0xdTxCAPWRu4lNm6vhrN2ovH6cG6Y7BvBW1Uu12V+xPoTJLcZBzoIDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmnH87CpHTaoGerLr1lh0Vryna06nz4iOHuAemGPm8g=;
 b=iRzMYRgqmkilukWWpi3lH2jRVLg+mxGhhvzNlpWIbbjyLNmQDk55hv/CpCbBv1xBZkYG/s2IGPy0bCWAN6tWPprobkePeUHeywUS06DVFAcEWrZpEjses2LbJKKhls9b2ODh21nNYk1l47y2Dj6ffueMJVlrk+DNsQzwAkQszApwZu8C3NcINRcKqYZTOuP3J6/QIrf2h7zSuTTVBKQwaOPGgVIVCWadHp2jbGn4q6JRARLNmzSUQ57sypJeXWASc9dxVud/79qkimYUEtPP9XcLsbD/f2pMInhYBtFSaMrFgPQM5rWO56Up1+HQeZNTVcHsFWsOV5zf2V+vbNal1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmnH87CpHTaoGerLr1lh0Vryna06nz4iOHuAemGPm8g=;
 b=QlOoX64Nzx+ZIwzBwb95pX6RIRyZPKD5zRhV6LWCU/i1d0/SFq3c3okD/Kiw4oqv5jXpTMtNCYDGONLGthLBha/bzA1s3sBiYac8tIPZad//8aIWu7Wx8+oEoDyY6rkTmYP72H0BqMz/wivL09BilmTcZoY2CVaTK/RmdI31SQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by DUZPR04MB10014.eurprd04.prod.outlook.com (2603:10a6:10:4db::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 22:25:31 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 22:25:31 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com,
	imx@lists.linux.dev,
	joe@perches.com,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	miquel.raynal@bootlin.com,
	zbigniew.lukwinski@linux.intel.com
Subject: [PATCH 1/1] i3c: master: svc: return error when read length bigger than 255
Date: Wed, 10 Jan 2024 17:25:03 -0500
Message-Id: <20240110222503.2381599-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0018.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::31) To AS8PR04MB7511.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|DUZPR04MB10014:EE_
X-MS-Office365-Filtering-Correlation-Id: 150f2404-1b34-4e12-7d8f-08dc122b0e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ml8T4Xq0uuG3k78GpTvoTPNduDwmsubKF4Itov5zW/N1JtrUkKDcTBiCtk6GWMFRpEyppVWETQ+ppszk7oKsO4oHQMTbRSWtxejaKDEVXPvcvfhUg3LB7uY9Eq5LlRq9uLyOS/hgto/t4+kq9oQWRTtqNIjmKVhIWEVbNkLL5W8zDmjUDYL6NxhEwxsNzJl9VS8O3GZvJLTcNuCi8vy955eUpBD2XXN1lbl4D0QKrpa/O+wTuN+ddRAJBy6w5CNEIGJsErVMwS6PiBVKJhfPmrQb4ebvl8Jbc4/yi89hfOHNB9J2nByioyXJUiQm0nWljTZbzoND/tW5WOcN951SpGihXNWRwqNbmWgq56WPusSuIC827hEDaWioZu2W15MVp4wjj3BQsXjmate3ixzBxORyCuR691NXpt+if6e4l34JUS6QymouiAMijemTZnLULxiSnfWYQvt4ZCX0kQi+uwLnCcvk8p2m/uaavNd0o2MsRMKwrIsf4KelHKBuCFr3mMmRhBxEw2Y1ks4DS+VrQrLXY57yuuxX8NiOvaZwIOBxxdOsq1vu8assAwYt0col/aY88kQfNrmleBbhFlOP3HKf6BnhN4xNwQaKQBAI9A/Gm/4HXEbCBWGKjXb7+IUXG7TWIt76Q6KpqYVPow7dUA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(39860400002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(6512007)(26005)(1076003)(36756003)(86362001)(34206002)(38350700005)(38100700002)(4744005)(4326008)(5660300002)(6666004)(2616005)(6506007)(52116002)(66476007)(66556008)(8936002)(8676002)(37006003)(66946007)(316002)(2906002)(41300700001)(6486002)(478600001)(135533001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q0YfMT+/HuVeEzoDerJANV8D1xL8nTxX8ioZs/AHnHftOWQ2XdQFVLozqEBF?=
 =?us-ascii?Q?rEk7M7rHBIzLnALg/kaWR4AnycTLdf3+20DI152+HOy9xis9di8PHUGrYN7r?=
 =?us-ascii?Q?5UPLigQbuGgmltYkoj9NvQpaRukF0+9MyeidoUTNOEpPBhYSlWXn0a3gmjH3?=
 =?us-ascii?Q?xezGLnYWLGH5vYdQlJ5egsLUHcohPyRtUJxUxx0G/UNqJsIXGWxBuH44/c+b?=
 =?us-ascii?Q?fk2kdkZlyrJEZAIVk1SHsPORXm35logPEspG7AeKG/m+T6LA0OJg/8AqDdGw?=
 =?us-ascii?Q?AX76OTiKaW3Kwvc5ZVYA7g3UWm0AyqqS5G+OeOD1NhUzoGZFGq1Bytkj1khn?=
 =?us-ascii?Q?F61nZ19KvffmnBngzr00LgsalVB63KP8M/S3uQAX91ku4v0xzI75TF11wCtS?=
 =?us-ascii?Q?aoCdIjJfFP72LsA2miXL7GfvbVjwzBS54vveWCuKMUQyeXqU8FySASrzLkoj?=
 =?us-ascii?Q?QFs7B/5i0mOq2/L8RVcMzfRJpz+8o51OQvzK2BOdRmoU/iU7c50xRAjPAwPd?=
 =?us-ascii?Q?HfvVDUNhYKsq1PFh84hMNDzf/2js784rNCL3vuIUUDDJWz+MY2TC4d620ARb?=
 =?us-ascii?Q?pd+zvDcQ+vtG5xMTvkn2UFUPSSp2IGg0ZTLwEIDpHzapbnS+xa8on9/VI7s1?=
 =?us-ascii?Q?xYen3brHlaPIR/oc+1P962/DzXDVo0P2vmr48kaOj8xr1FYZE+4/XRKXjzr3?=
 =?us-ascii?Q?sQguc1Xg2dMxHFY3fkADV1L2oA86cUuQjCdSiC2GljF4G1U3QCBCOG7vG7gL?=
 =?us-ascii?Q?eBClP7d4906zYwrlEkPR6NUdeNfklvVq4DRiewvqaSXcYkgwsoeydappbbDg?=
 =?us-ascii?Q?1NvmGdxGumi5dHktL8/l6LzZaYcYlJMDT/DkjzqvV4zMBMLQq/+LZJf3ZtKM?=
 =?us-ascii?Q?37pV2ED0paWSGjT0iWJL9zstuCUrKymyPAIL8AMBJevH+rWyIyaYHR7xA4RO?=
 =?us-ascii?Q?ENDmfRnhSu9w51OYYVf1DHCFP/04uMurDC8YhvcT6b1DR3/EhQjayQnxGfvb?=
 =?us-ascii?Q?qmioE3+AQOfQybohGkM3RHCfFHgAQiijxynTEwASSdMVMSfZkGx7jYpiiDZT?=
 =?us-ascii?Q?mXmCXz5F+StCOSsCvtGydhcK3rkgHWMyhc0CyJefov37vwBKoNwdFYp7eBDz?=
 =?us-ascii?Q?OBvG2QcVIWpC0bQDXjGd+F7yZ7Dt0p8lEulaJ8w+31JNeZk/ecq5VNjqCfJM?=
 =?us-ascii?Q?MdTJSAlYm9apr5wxzZofCK4dBnpwV7olQgm9GBrmVXF9CwmZ2ZaGAXR0NpVv?=
 =?us-ascii?Q?yjfMDnSYbzAUhK7ZKfGShpgmpWD7x1O1jB80Z17lOIamkREADXAhnTCOJctY?=
 =?us-ascii?Q?ErpuUAY6daxFe8UBC0NZ6ldsZPi20/GohWQwQJADlH4xu3X2EsyfTVTklxlf?=
 =?us-ascii?Q?m8bOtO3JNngrnFgKwjx8tvtc6Lpw94RNziRz6dQnh4LLdocHLO9TP8wQXyxB?=
 =?us-ascii?Q?zXK9c/t9KSaxO9wYr0J70ENrc+LWmq5Ft/vv4WdnhFSnf0FHlVKPjroIgme2?=
 =?us-ascii?Q?pYDLSmxiMAEGxCLJxoUVPDM+db8LG4cBQPKZHgFon8beqAUqh61I6XZG/xVf?=
 =?us-ascii?Q?2Yrz2IcH0a4wQ2Zc768Ywe5AMe9cAo8+HGW9RNCK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150f2404-1b34-4e12-7d8f-08dc122b0e04
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 22:25:31.1228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9rZSlp+FUXh3Wl7ps0Ps2gi+6PoFs2SQWlRgCd05mCcLz1DE0/W2XIT1L7IjEkSq1QqK2yRUud7hZ6dxvUitQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10014

RDTERM in MCTRL is 8 bits. Add a length check to prevent silent data errors
when the read length exceeds 255 bytes during each i3c_priv_xfer operation.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index bd10bb698da0f..181b56953fb28 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1375,6 +1375,11 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 		cmd->len = xfers[i].len;
 		cmd->actual_len = xfers[i].rnw ? xfers[i].len : 0;
 		cmd->continued = (i + 1) < nxfers;
+
+		if (cmd->rnw && cmd->len > 255) {
+			dev_err(master->dev, "only support read less than 255 each xfer\n");
+			return -EINVAL;
+		}
 	}
 
 	mutex_lock(&master->lock);
-- 
2.34.1


