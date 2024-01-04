Return-Path: <linux-kernel+bounces-16531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516E4823FC1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3671F22D04
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD812231E;
	Thu,  4 Jan 2024 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bfcLIt1s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2048.outbound.protection.outlook.com [40.107.6.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB53B22301;
	Thu,  4 Jan 2024 10:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewr9TDR1AG19CacelmvkVMPBC7BytFOACjQ0vz9iU7bhutZDsaH3mbCropBMOuYYt8QPOWNqcQzAZF6+FfdgMlHKmQPYS7JRePTjjrKpyiX42um78PwKAREu0luTTWIR4+t6tW+YHdKN/ss4vQ4NXwpL7DZjU7tJrDQz1F3wDRpHdiTzERut5iNj9h5/2qiXTXTa7P2dHdEloA+SfoCuBN7FoulnwkN/U6Szhbm6DPGkPq/2d9qmLqH9PDmILHOCA021m+I7d4JglplFjOBBwzZV10hy6K3pInugZlLNVCr3DlQkoVNa5NrUemoj3iBc9uZiGPQs+zRveM/3DMl15w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0B085vYvHv/GmYgoqvl90VanzgCgwz3QndzMlRohe8=;
 b=CpaxaO4CyxVfB40+urL2bq/jKDlgOT/4Trw6RZ7FhJMLjQ9twbz3k6ySq+bSRXQ6SeUrpOlpjSgcVVVHo51XCo8XOJ6//Ydvzg5YQbW4sh+5dLhwmBtDBPwU/tBFe7ae1C78AJweQ4NpNbDiOVwaZoEsyCoiSL5TcIYSAwB3+1zO6SjYg70ZZrB6XqTJeqBIBSk1hK57xvsDMp/lNvMH9rHN0PWuoKHPfmYt88InZcyj07f8D94nnusboz5pI+E2DwSFqIAY+4PEs7O/4fHhUHqfxhJRTclJLvZFF8FkCiTalpv8FJX+hLeWjnr41C4XYsGPKph3SfUX0ye54K+zYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0B085vYvHv/GmYgoqvl90VanzgCgwz3QndzMlRohe8=;
 b=bfcLIt1s067cQ+8CdN+lSo9E3lgZn/U/4QamNHRMpPcqK/bS5AErhezvH+nh8f/4F51G1wTWSjurY91l1o5AmCzIOqSs7N7JKwkUh8aGTRj/HWY0zUJA8ZQXdXliqVbke4mDm5ffSQJwzeSEdahUWvoIAV0rTNeSMxvVzMSI+00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7994.eurprd04.prod.outlook.com (2603:10a6:10:1ea::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 10:45:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3%7]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 10:45:12 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 04 Jan 2024 18:48:49 +0800
Subject: [PATCH NOT APPLY v2 5/6] firmware: scmi: support compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240104-pinctrl-scmi-v2-5-a9bd86ab5a84@nxp.com>
References: <20240104-pinctrl-scmi-v2-0-a9bd86ab5a84@nxp.com>
In-Reply-To: <20240104-pinctrl-scmi-v2-0-a9bd86ab5a84@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Oleksii Moisieiev <oleksii_moisieiev@epam.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704365357; l=8215;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=HKxjvWiYypkOgV8jylYBCQuqa9u8st95SOC7mkLfRYQ=;
 b=761EMAEM0hpudqz6eIK8jdJPapKyapBuQxaTyt1f3SKZ5FqaAzeQq8nHT2yh3KVToS0Dw++9O
 hw5LO+X2VceCiC9TFY1w79/s0Oxj5i+QCTx2S8q7OX06qhstQoXr+gR
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc65258-c0f3-41cd-481a-08dc0d123a9f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	36wgjFjsrlUy10gfZIAmlvuP77SjlllFBDa1IhDbK/yBvpGApxZKN3osuHH74u4FbRgJN8Skerkus5q12IKFSzAuVlfcaiQCFVqPzXOBh+trhNbyBweMKXe1FpHoqwimqC9pCE+l2ZPx1dUWnBtKiaSLYWAFGz/AmWukair5z/ZNYj3Zz3bC3A8Ub0u8TJTTAv+Ef9NopyhVQPip7yW6k3gtfgf+T4xET9l+6VjogojH9u23xThTXLJ1DOUH/zpOdmTTT/ofS1na/CBOOKsedjNMW4VxzcrSxW6oYzDmioREz3DxmsOlpDsAszfcvFg85yFqeLRaLzqVx1pHfwGwE3isXw5CRZli5WLPEUGRlokKfAKCA4rxE/X144a9+Io1WRa08jTHqmoB3dmuJ7xdTWV3azkgRPhN3fAgTx1V9JtkdTnZzDJ8Yih4DKDQT0GifoYDexX3gjAzKl1EvMaei4AWSef3ieV4CUAwAmDKJlH8Kmk1WSS74kpQwqJLrTSXV5uiCDQw+RRNbRIcSBcxk1tJDvmqHZm55rv+lZMQN6vSsAnYR/2ip0UyFjmi7uxopfbSv2hNnpdwVettDS/K4WBmBXr89IbcsoQDCMa3VmA8ESFQb8EQqrirqvhOt578f1cyyx18nllhPCdsv8dwlQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(26005)(38100700002)(83380400001)(41300700001)(8676002)(8936002)(110136005)(54906003)(5660300002)(2906002)(7416002)(316002)(4326008)(6666004)(66946007)(478600001)(9686003)(6512007)(6506007)(66556008)(52116002)(66476007)(921011)(6486002)(38350700005)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QU1uYkhGTFRjeityVDN6Si9DUTFvN1dnN1I0S3NIdldNZ1NCbjBabHJCTHhw?=
 =?utf-8?B?MC9jaUxyZlo3RklIMTlUUjQveTB3UGVnbDRiRTJneS9qVlBjQlNXTk9tVWM4?=
 =?utf-8?B?THh3NDZuWWV2dDFEdE9OTFA0WjFhTW05SVdXQmJ2cEZQcXBGUFpTRzNJNFVQ?=
 =?utf-8?B?SUkxaGs4Z2p1dUFVbGFDdzVmV3VueGdQSGJiS0o2QlJSZHpWUUJUenpUVzFF?=
 =?utf-8?B?bko3ZHRNcGw3QTFPMVk2ejljYnJkOTFCV0FDQ0s2RDk0RWY0RWE3a3N1TGtz?=
 =?utf-8?B?OFhjSnhKTERRc3lkd0JzaG5yUWkzUEJrUXNHZjJ1ZWY0UUZDY3RYNmRyN0NG?=
 =?utf-8?B?Qkh1QTRZSlZrYURTUjNkQkdQdko3UzlLdU5MaDBKSTNiZUJoQ3Bqd0pCdVI5?=
 =?utf-8?B?dlFoQ0Z1bHBwNEhnT0JLRFBrbHpISWZzOTZOK0dYTGJ1T00zcHFWaEJ4cC82?=
 =?utf-8?B?eTM2d0lGMW1vb2NJV3NQc1JFODRUeUJFTHdqakxuN05ON3FJTm40bTR6aFA0?=
 =?utf-8?B?SGNiMnlpQmg2TSttbFVuRVREaERXbGQ5VHdrRGhDeXdhRjlXV242b3VnL2g3?=
 =?utf-8?B?UkNrSnk1ZTBpRjNmR3dhMHZvODk0S1J4a2h1RDVhSWw5bnRXbjBxVHRLMjZt?=
 =?utf-8?B?NUsxbnlqQWZZR1lsZk00c0lnN0ltY29uRGtQNVQ1TTYwVHc3dlpvNTZvK3pw?=
 =?utf-8?B?RkRveEV5Y2RnQTF5ak9xcWdjenRuazBic1pqa3d4dG5Lb0hUTy9KeTJzU0dQ?=
 =?utf-8?B?ZkNhdUx4UVJoM3VpWFJuTFBFaTVzS21xMXdiM0xvZHc2SFJ6N3ZHYkFWWEMx?=
 =?utf-8?B?eDZ5K0x1LzU4cENQaUcwaE1YeElzUm4xZVdhcG1JcmRnbHB5NGsvRTZsVG9T?=
 =?utf-8?B?WkVJbXhhc1FqS1V4bk51Umh2S0JGajJYN2pQdDFteS9DdXczQ0xjM080VHJG?=
 =?utf-8?B?amg1TG04VmRNN0Z0cTQxSkMyMGs5a2lGOWJHYm5OZ0hRZml5YldJTnJlQ1pB?=
 =?utf-8?B?K3VES2VhU0x1WE9oRXRUMWpPc29tSHc4Y1kxQlhFRUN6WFA3dUtPTktWN3ha?=
 =?utf-8?B?N3hlNjZDcjBXZTM1U0J0UTBlQUtQbkx0d3JsOFJWdGNDU3QrY2hML2pDOFhp?=
 =?utf-8?B?eVIwTHRrVHdYaDlhc0poVkpMTHhUczRDYk9KSnVlUmUyZnMzRTQzWXBXUGlX?=
 =?utf-8?B?Sk1YaDhjdnREOHdsdzhwOFpsUjFmaWp6Z2FqZUxhSFF5UzQ5RVJUQzVvSXE5?=
 =?utf-8?B?WHZrMUEwMkNuQ0xaSjJSbWdUMHA2U0o1dXVUcUprUjYzQ3VMSXJkVGdYN2xo?=
 =?utf-8?B?OHZHbTBKQmtYVW5Yamx2ZkF1OTdBTEVwVkl1bUgrV085R0lGRzBwZ1dxcjRl?=
 =?utf-8?B?b0EzcmNVRFpPdXBFa3M4L091UGtOb0s5bldXdzk0dHp3ckV3YTNlaC9hVEdS?=
 =?utf-8?B?NUw1VytSbTJsTGJpVC8vakF1R0I3ZlhJQVZYTkdNeVBJcXdMWUdQTGtJZ081?=
 =?utf-8?B?b1czNXBrenNJdWVHVnJZZ3N1ZVI0RTZBeENPQTNWWWRYWUVkZjlZVGxuTmlz?=
 =?utf-8?B?anluWWpIcTRFL3owSE1TT3A5NjE4TE9QU1FvSnUvSnN2NEhic3VYTXAxNk9L?=
 =?utf-8?B?bms4TVpvRS9BNzRJYUVwWjVhV3o2ZVNCcDhlRTdCR1BXRm56V2F4STJrWTgv?=
 =?utf-8?B?ZTNOanFTSURNUGJ5eFNNQXVsUVZZdjVuRURKU2s5NmlTdG1qY2tCZjRmTzc4?=
 =?utf-8?B?S2FmWktqYjZ3VVRlNG4zRUdrbk1RL2JTRHFqSTlwNWdKMGppZmZpeFc4ODhW?=
 =?utf-8?B?M3N6M2RXdEFaTVprOXp5WHhGQThjZ1htZlZMalR5c0FiL3d6MDhJeEtKalQr?=
 =?utf-8?B?am9ma0tSM0N2Zi9rMHhpbFAwV1k1bi9ENFJ4MThLYm5QMENqV05NU2JXNi9s?=
 =?utf-8?B?UzhRQ2h0Z2lLeE5uVlJFc2FrcG44bkZSZ1ZPSmFXZVlhNUF1dFRjS3Rmd0ZZ?=
 =?utf-8?B?UDRzZEYwc1FGalZ1SWJLRE53bTBHVE5TMC8wVXNsRFFsYkhoYjZncVJxQll2?=
 =?utf-8?B?cHFCZzN5bmRRdFpVOFFvMXZwZXc5Y2xPbHBVeUd1WDJkZitRSVNJM3pSdG5W?=
 =?utf-8?Q?OZDzouatHdEOHrdAhr6xwLiwN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc65258-c0f3-41cd-481a-08dc0d123a9f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 10:45:12.4865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmGWlXOUkv8f7Vl6qRIsz/c9B5ql3GEdU6so3kxi463x65hx7WELM8EZk2dOvmEoml3yI6SdLdllTPYQf6x//g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7994

From: Peng Fan <peng.fan@nxp.com>

i.MX95 use SCMI PINCTRL OEM config type, so it could not reuse
pinctrl-scmi.c which use generic pinconf. Then need introduce
saying pinctrl-imx-scmi.c to support i.MX95, however both
pinctrl-scmi and pinctrl-imx-scmi driver will register a pinctrl device
with the same of_node(protocl@19). This will introduce an issue, because
the pinctrl subsystem will use of_node to find the exact pinctrl
device. But with two pinctrl devices registered by two drivers, it is
unknown which pinctrl device will be chosen.

So introduce compatible string to support cases that Vendor SCMI
driver which does almost same thing as generic SCMI driver, but
has some specific Vendor settings to do.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/bus.c    | 39 ++++++++++++++++++++++++++++++--------
 drivers/firmware/arm_scmi/common.h |  2 +-
 drivers/firmware/arm_scmi/driver.c | 15 ++++++++++-----
 include/linux/scmi_protocol.h      |  2 ++
 4 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 1f9735dbebec..9043f6366fa8 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -214,13 +214,21 @@ scmi_dev_match_id(struct scmi_device *scmi_dev, struct scmi_driver *scmi_drv)
 	if (!id)
 		return NULL;
 
-	for (; id->protocol_id; id++)
-		if (id->protocol_id == scmi_dev->protocol_id) {
-			if (!id->name)
+	for (; id->protocol_id; id++) {
+		if (id->protocol_id != scmi_dev->protocol_id)
+			continue;
+		if (!id->name)
+			return id;
+
+		if (!strcmp(id->name, scmi_dev->name)) {
+			if (!id->compatible &&
+			    device_property_read_string(&scmi_dev->dev, "compatible", NULL))
 				return id;
-			else if (!strcmp(id->name, scmi_dev->name))
+
+			if (id->compatible && device_is_compatible(&scmi_dev->dev, id->compatible))
 				return id;
 		}
+	}
 
 	return NULL;
 }
@@ -345,11 +353,14 @@ static void __scmi_device_destroy(struct scmi_device *scmi_dev)
 
 static struct scmi_device *
 __scmi_device_create(struct device_node *np, struct device *parent,
-		     int protocol, const char *name)
+		     int protocol, const char *name, const char *compatible)
 {
 	int id, retval;
 	struct scmi_device *scmi_dev;
 
+	if (compatible && !of_device_is_compatible(np, compatible))
+		return NULL;
+
 	/*
 	 * If the same protocol/name device already exist under the same parent
 	 * (i.e. SCMI instance) just return the existent device.
@@ -425,6 +436,7 @@ __scmi_device_create(struct device_node *np, struct device *parent,
  * @name: The requested-name of the device to be created; this is optional
  *	  and if no @name is provided, all the devices currently known to
  *	  be requested on the SCMI bus for @protocol will be created.
+ * @compatible: The compatible string
  *
  * This method can be invoked to create a single well-defined device (like
  * a transport device or a device requested by an SCMI driver loaded after
@@ -441,14 +453,14 @@ __scmi_device_create(struct device_node *np, struct device *parent,
  */
 struct scmi_device *scmi_device_create(struct device_node *np,
 				       struct device *parent, int protocol,
-				       const char *name)
+				       const char *name, const char *compatible)
 {
 	struct list_head *phead;
 	struct scmi_requested_dev *rdev;
 	struct scmi_device *scmi_dev = NULL;
 
 	if (name)
-		return __scmi_device_create(np, parent, protocol, name);
+		return __scmi_device_create(np, parent, protocol, name, compatible);
 
 	mutex_lock(&scmi_requested_devices_mtx);
 	phead = idr_find(&scmi_requested_devices, protocol);
@@ -462,9 +474,20 @@ struct scmi_device *scmi_device_create(struct device_node *np,
 	list_for_each_entry(rdev, phead, node) {
 		struct scmi_device *sdev;
 
+		if (compatible) {
+			if (!rdev->id_table->compatible)
+				continue;
+			if (strcmp(compatible, rdev->id_table->compatible))
+				continue;
+		} else {
+			if (rdev->id_table->compatible)
+				continue;
+		}
+
 		sdev = __scmi_device_create(np, parent,
 					    rdev->id_table->protocol_id,
-					    rdev->id_table->name);
+					    rdev->id_table->name,
+					    rdev->id_table->compatible);
 		/* Report errors and carry on... */
 		if (sdev)
 			scmi_dev = sdev;
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 00b165d1f502..ac0d83ed5803 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -149,7 +149,7 @@ extern struct blocking_notifier_head scmi_requested_devices_nh;
 
 struct scmi_device *scmi_device_create(struct device_node *np,
 				       struct device *parent, int protocol,
-				       const char *name);
+				       const char *name, const char *compatible);
 void scmi_device_destroy(struct device *parent, int protocol, const char *name);
 
 int scmi_protocol_acquire(const struct scmi_handle *handle, u8 protocol_id);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 4c3752749105..b78fce62a0de 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -261,15 +261,17 @@ EXPORT_SYMBOL_GPL(scmi_protocol_unregister);
  * @name: The optional name of the device to be created: if not provided this
  *	  call will lead to the creation of all the devices currently requested
  *	  for the specified protocol.
+ * @compatible: optional, the compatible string
  */
 static void scmi_create_protocol_devices(struct device_node *np,
 					 struct scmi_info *info,
-					 int prot_id, const char *name)
+					 int prot_id, const char *name,
+					 const char *compatible)
 {
 	struct scmi_device *sdev;
 
 	mutex_lock(&info->devreq_mtx);
-	sdev = scmi_device_create(np, info->dev, prot_id, name);
+	sdev = scmi_device_create(np, info->dev, prot_id, name, compatible);
 	if (name && !sdev)
 		dev_err(info->dev,
 			"failed to create device for protocol 0x%X (%s)\n",
@@ -2354,7 +2356,7 @@ static int scmi_chan_setup(struct scmi_info *info, struct device_node *of_node,
 	snprintf(name, 32, "__scmi_transport_device_%s_%02X",
 		 idx ? "rx" : "tx", prot_id);
 	/* Create a uniquely named, dedicated transport device for this chan */
-	tdev = scmi_device_create(of_node, info->dev, prot_id, name);
+	tdev = scmi_device_create(of_node, info->dev, prot_id, name, NULL);
 	if (!tdev) {
 		dev_err(info->dev,
 			"failed to create transport device (%s)\n", name);
@@ -2550,7 +2552,7 @@ static int scmi_device_request_notifier(struct notifier_block *nb,
 	switch (action) {
 	case SCMI_BUS_NOTIFY_DEVICE_REQUEST:
 		scmi_create_protocol_devices(np, info, id_table->protocol_id,
-					     id_table->name);
+					     id_table->name, id_table->compatible);
 		break;
 	case SCMI_BUS_NOTIFY_DEVICE_UNREQUEST:
 		scmi_destroy_protocol_devices(info, id_table->protocol_id,
@@ -2802,10 +2804,13 @@ static int scmi_probe(struct platform_device *pdev)
 
 	for_each_available_child_of_node(np, child) {
 		u32 prot_id;
+		const char *s = NULL;
 
 		if (of_property_read_u32(child, "reg", &prot_id))
 			continue;
 
+		of_property_read_string(child, "compatible", &s);
+
 		if (!FIELD_FIT(MSG_PROTOCOL_ID_MASK, prot_id))
 			dev_err(dev, "Out of range protocol %d\n", prot_id);
 
@@ -2828,7 +2833,7 @@ static int scmi_probe(struct platform_device *pdev)
 		}
 
 		of_node_get(child);
-		scmi_create_protocol_devices(child, info, prot_id, NULL);
+		scmi_create_protocol_devices(child, info, prot_id, NULL, s);
 	}
 
 	return 0;
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index d8e2bb828ee7..ee7b77eb9466 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -912,6 +912,7 @@ struct scmi_device {
 	u32 id;
 	u8 protocol_id;
 	const char *name;
+	const char *compatible; /* Optional */
 	struct device dev;
 	struct scmi_handle *handle;
 };
@@ -921,6 +922,7 @@ struct scmi_device {
 struct scmi_device_id {
 	u8 protocol_id;
 	const char *name;
+	const char *compatible; /* Optional */
 };
 
 struct scmi_driver {

-- 
2.37.1


