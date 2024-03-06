Return-Path: <linux-kernel+bounces-93233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43418872C9B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE39C281960
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71ADD529;
	Wed,  6 Mar 2024 02:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="LuS/opAT"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2111.outbound.protection.outlook.com [40.107.215.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9337D3D6C;
	Wed,  6 Mar 2024 02:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709691231; cv=fail; b=cHtdPKFtP05o9ew6vkE4HfUnfnccyPo1I2JuL4WkG91cRzQP6K9hrlovFiER+jhq9CSLNDdwrGrIsiLfMwSaNuGTFpq/P0ufHyWcjJna4TaAP5JAD+TcRyaL7cX1STYa3ARkHdxaIjzGBR6DXTSks/BJlKsCtOqQRBSb5HX1yjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709691231; c=relaxed/simple;
	bh=xNYGZoWlzHbVfuIATGkOPTG6UpPOpNhbxgTF/tOlvoA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=d1wG9vZHFWBq3Wz6OOQA7kzYZit4I2prA9c1c3/+fvylL6u1AWEWjOOzV9NCqaJgydMLi8G0MlFkYoLiWdPpxL1IBxykH0Ov5Zaz4fIDexflusuU/d8edFt42CooheYBc54E6MslB2bFBDkyZTV8lcDRcU4MeYM3bIc4llrcew8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=LuS/opAT; arc=fail smtp.client-ip=40.107.215.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEeyAEw51PinFjeYXfmr3+akR8hjd2BMo2tVbdRWI3oA/iZxoI6keoNCWU5E655xQ/ptYRDn52yoA8Qe9rEiStEyT4HpTjVw3EmBGI5+OsNmkXQrjewpUrOaN+lUbzNQKJfa5sUYux85yBrg7kfYC2JRfW1/quvwBjj2P82ymRMORVt20qvKCej3n2oXt/K35veWkV3Gg89MYnbNC0Ws5pjD4BDNQzcNV/U9hC8bHoRPHAojDlBP1niKrFabx0BuJEugHwlGGWK6XO+Ib7E58cJJEkcmTo3gwPO+FU9Z52D5lCyDGRwpZaDxaFq8ZoJhtyupIBFpccJ+6ZZLhx2JXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KL93+ujzocRUtDxl7h0P4yL/C70iNiR6ozlQK/n5HY8=;
 b=LSISqNRnRDJJyKF7HjJP2azRsnFFV7F0TbreK2TIQ293Dds+Lf309QLBUs2JdNY9nrmFaHDTvfny6WmZTl40AjXfaXhcn2UXs5tIOy/52e7CRBQs94qrD3N8z2+b16tLFMtREjBPAiDxNKcW0lwVJjNm9c01xhc5sf0uhhkwTrrS0cy2q9Ns/xMCuCnGK8Bd7XmLkopbzSNtHRozBIKQojXe9xYPdRw8CGPlgf85r+rUqWmeeJ6AE/z6/qKmti1QhmhNioG4XmggAhk7JMUgTp1OLZwgXrErjxo9mlwlkiiK2romr/2UZ/jKKOLerX8mPybmHpX80FT/BVRtuFXWTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KL93+ujzocRUtDxl7h0P4yL/C70iNiR6ozlQK/n5HY8=;
 b=LuS/opATZ3QyogCIM1rYBwTJrRKJlAvbdiRHvizr6spi6Ih0EWN/evRKgaFoAwITi5kmNK3lwajHutEr7MavLQd/kuA199IGnpVrgDHwAcgbeGL0/GdfzRqHSDFvpnfp8uxrGMJ+WM2DZvaumNqpnHr5ZgNr3WNCsl14n8EMc+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from KL1PR02MB6283.apcprd02.prod.outlook.com (2603:1096:820:dc::11)
 by TYZPR02MB7558.apcprd02.prod.outlook.com (2603:1096:405:4b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Wed, 6 Mar
 2024 02:13:45 +0000
Received: from KL1PR02MB6283.apcprd02.prod.outlook.com
 ([fe80::87a8:fbd4:757d:2f75]) by KL1PR02MB6283.apcprd02.prod.outlook.com
 ([fe80::87a8:fbd4:757d:2f75%7]) with mapi id 15.20.7316.023; Wed, 6 Mar 2024
 02:13:45 +0000
From: bolan wang <bolan.wang@fibocom.com>
To: johan@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bolan wang <bolan.wang@fibocom.com>
Subject: [PATCH] USB: serial: option: add Fibocom FM135-GL variants
Date: Wed,  6 Mar 2024 10:13:33 +0800
Message-Id: <20240306021333.1128448-1-bolan.wang@fibocom.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To KL1PR02MB6283.apcprd02.prod.outlook.com
 (2603:1096:820:dc::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6283:EE_|TYZPR02MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: 000ef43f-adb9-48b4-ab0b-08dc3d830ce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gCHXS+8LKNSu1mftdHzX3CQt86O33jLuxPcpEVZb+E5x5929olt+Zjz4j9wOVxl7Z1Z0tVOpoOrc1MPCFEZwSxVUk2/SZ3p/xFNIoXs3XJ2KUMo6I1oLBL11/uzVugsBSLwNnxrl4UFi+WA8OI314CB6pmTfmZSJKJ+um7pwIsJCwipXnLzhAbsCgGX2BoMWQMbq09egTNC8pTKoIhHNF3IsfxJoeSnAzzVbHrGdtN48Q8WhQf9pYg5M+wchVnY/FUPcgN2jfuZ5R9l2/oJV2nV/KamEb8BcTnyyr+CqAVuUBmBq61bWddbiY40Ohga/E51hr/T1x0XB6cjeezN0zWIepoY/kZ2ouvQr0TAOTQWxLw2wH2PLZlDb45I8kS8cVFjkClCtoDiLg7kiH67lUv3adhjj/CZ/+GSzMmnMJ7nBGP/LesIU9Ixg34wakvOBsSug4gUs3rPdJKv6VmXuqhPvsxlrOnSRAGoyrUL+eF0FZ7ucuajYPaJg60zr8Lm+n64gkn0l9PBjPcRMIZw+LxoUTvUf7EzM64tqnCPDlXfkXDjkZyAE05grlJ5bQ1QWTDaE2mD3+mBxRd1nVZ9UiayxSOdMx05qowiVlQA7vTcXJ32CbEbGggyJOZ8uKJfXBfDatw3DslhV3iDkDNJbBgQ+zbf18o9BnYLtONfxpI2FaqQ1LMKgVg4LvjO1gV7bdf1/+11i9C1zJ88X9hIwgcDE0fp9XIo37+iOhYrDgFQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR02MB6283.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bc73VcBFo+mPevHXsuyP0J0wEuj6LtzoGJbwLNcDaQIcWkxZB4SfzAhYUL8e?=
 =?us-ascii?Q?PAnCFziBQw6OA0zk3o5wEzfU08Lbp9Fy3QD6pv7JHDVK2tAHb4Tyj001Luc3?=
 =?us-ascii?Q?SP7KFN5ZwyY1HYzxHtbN+SO5GJaihy0jHAaz154SKmyEjvZCJW5jf2vlFaJc?=
 =?us-ascii?Q?C3rvPnyFXiAPTQutexYTnvgQ5tJwCobDF9Q0TaqM534YTbwN/swCBSm6NuY0?=
 =?us-ascii?Q?yLP3mT/RGuZx41zuKspGG1q1y3ykzIeuY5sgenmptt+CQOX4+YgtcjaldO68?=
 =?us-ascii?Q?E8zRbOpgvTm5sg8QGLsBaDeihMJbfu3sHvCO1Xn3HY6M6PbSA46MdGNlkzKe?=
 =?us-ascii?Q?4tnvO/pl3ffPuvkB7aPP463YVoNWTeceOt4AcqjVW5vdwdQFe0aNgEjaO2+D?=
 =?us-ascii?Q?YBPDYZZWpoh8AODWB3JbfMz5DLVgqiIHO2qb4lu0ZpdTf9ljnzsTo2F0d/2U?=
 =?us-ascii?Q?qbuu1rMkRjCLMmss5tBjynuEVNetDd8VozjBYw6WX9Lfb4xcvrqJH+Jnv+LP?=
 =?us-ascii?Q?Ub14xEgoNcEkUsK9DGA8ui6TF8SE/ryD30WxWoe0vMef9stSxVSMaJijnCal?=
 =?us-ascii?Q?gypz8e+cHkKJjnOZURNSznEIDUnX5efdb2AzM4UWozyXrUMSjy2qcr7GJVxk?=
 =?us-ascii?Q?XaATrv8Xb+lUhwNI8Cq0c86SYl6lvQyr/Df4xyXu2v63y7b788wbM7zEYQhY?=
 =?us-ascii?Q?mMx3p8gnUXyO4LjwTLDBS10RQPd3pOR71aRx6R0PgCy6Cx27dHdEMK78OzMF?=
 =?us-ascii?Q?lcMZQEaBdAx4hNZUCTFDHZ00OvrJb1MJMEaC5bVoF2qiPG+2vZVOPl1HT4oi?=
 =?us-ascii?Q?vA3Soegie48AVODhhcDTQ6Rlm2UWxWbnZEyOOdRFdkZWMOqHKyK3157pN1BN?=
 =?us-ascii?Q?ynKfmN/AIKp2n+6o++Q5xln3tOJjWQZk31XRNporjOKLpDeSBnkyAkvxkVPE?=
 =?us-ascii?Q?PdixDkhxrKqzY/SahAy24hNvjjG/f72dK0IKbJY0VHBSkJb4gjaYfFE8ZLwA?=
 =?us-ascii?Q?65/aLpOlmSv5toBnC8uO8FHFF7gFTKyK/vLqKSUtzU6KO4EA8AFHY38glYq7?=
 =?us-ascii?Q?Y5aDRlX5hCcJqa/t4C3xR/xuuhCi+/EqX6KqtrQh3YLWQJM5Y3hTIvmDDI18?=
 =?us-ascii?Q?RkoquhvX601m5zxMa28nIKi5Oudwkb2K3FbjjLvfobR68HmCw2sOswurVI9W?=
 =?us-ascii?Q?2klm2miEGOg5GVgnL5JYno4lMTUvZCx/AhKr2fvF2TOQ6xJKGVgGdsHGQl/E?=
 =?us-ascii?Q?fFZnm2ELVDrDMjkRcTtmaIEB6/P7XmLWZn7Qwg8f3FY/+IouUibPFmeIyhAO?=
 =?us-ascii?Q?N2vqGVgO5RY3k9OZNIa5QaCsAyjhsD5gg07iwgQu30OIXe+djP2Jn1qejxWc?=
 =?us-ascii?Q?S6467JV4rCjzvYe2yvasMcBKmyBB6uXmIno5j/SdzC4stXANKKpbm36cpwNR?=
 =?us-ascii?Q?aXnyGg4Tvft62Ns8rlPlE0cTcvkRZXGfgBVEWySNQu7ntxe26hEaVfrXqADQ?=
 =?us-ascii?Q?yHQp+AZ3/X6dVu3hu9x9dp9sgN/ALy55g3ZdJNtu8H6psH+sD+ccxCFpdQs7?=
 =?us-ascii?Q?vYKEmqTgpEJcqpFzHWGPFelYgZfhdXtrmWfCgdZA?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 000ef43f-adb9-48b4-ab0b-08dc3d830ce6
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6283.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 02:13:45.0205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQM7LEC9mbjSczLUz3nmSh6uT8uHqfFelr83uvfnMIY/lsW6ubwBfVg+uLFBIMGDnBgdYMsRNOBGjd9cveW7aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB7558

Update the USB serial option driver support for the Fibocom
FM135-GL
LTE modules as there are actually several different variants.
- VID:PID 2cb7:01a1, FM135-GL are laptop M.2 cards (with
MBIM interfaces for /Linux/Chrome OS)
- VID:PID 2cb7:0115, FM135-GL for laptop debug M.2 cards(with adb
interface for /Linux/Chrome OS)

0x01a1: mbim
0x0115: mbim, diag, at, pipe, adb

Signed-off-by: bolan wang <bolan.wang@fibocom.com>
---
 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 2ae124c49d44..0981b8d8020c 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2267,7 +2267,9 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0xff, 0x30) },	/* Fibocom FG150 Diag */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0, 0) },		/* Fibocom FG150 AT */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0111, 0xff) },			/* Fibocom FM160 (MBIM mode) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0115, 0xff) },			/* Fibocom FM135 (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a0, 0xff) },			/* Fibocom NL668-AM/NL652-EU (laptop MBIM) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a1, 0xff) },			/* Fibocom FM135-GL (MBIM mode) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a2, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a3, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a4, 0xff),			/* Fibocom FM101-GL (laptop MBIM) */
-- 
2.34.1


