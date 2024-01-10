Return-Path: <linux-kernel+bounces-22571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AD9829FD8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125D01F2869B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF774EB47;
	Wed, 10 Jan 2024 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AydPYmx4"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17E04EB2F;
	Wed, 10 Jan 2024 17:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PklvnoS3eRrsuKI/oESu9ASvF0SwMBzWyeb8otH/UHKcVhcRp07y27niF9DIZsDHgdiLkwV4x8TdvQwQkW6qU1PvQZ0GTaaNj+rzMMOWCDyRGLuETpokdxH+0FVZOvxhW59UqkMrvAtzz+bqc8oZN0KKx4CDTl8HRBcXeKy3dqfUka9j9QoszxzncX4BnkfzJHDmJwEQsOEVTE19pEdtOU/tUwzD9EMIf66xtPGkOrLOMuIZ2nQQWPy532Wv1lCVIHrlIvbnMBsF7OL9mTw6HqlK+Bl69PrHgQOT5caYNgKr3VEUi4+KXriDYK4UGq4pb+mglEcJgKoXsW5p3lWkMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJqjdxYQGOe7eBpumvGxkqtfd0tBuGBzqxIW9xAyGlA=;
 b=ZAy3wLim8ufHRsRmEUn1GKrCdHVWOXbhgZyhvpdR1WrKTOSi5oU+RDi40naCcJOst3bYfVcJNbpKGG1E8PrnqYnREIuHeecO3ncud3rG+Y9lIHAuBgXTh7eIzThtWU0tLWvPd2zTfgYBdtkgZIc8pntiy3HSCg/CxUYhNtwC9p9QTVMrU5/OsVg+uJnlKNKaOtotSv3UqKpDfPIP2xx0EQnZDRqkWNt8SE8ARr4LCGjjRHrDdFRzudClyv5fMMjErS9poodh9ri7A8iOFuUxUlaSHghVOXOHFcD7Ts/+FBWmVUPoyOeD7qjjCBmzK++Lh2zUABdh//EyBBkLWaP0jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJqjdxYQGOe7eBpumvGxkqtfd0tBuGBzqxIW9xAyGlA=;
 b=AydPYmx4A5X2ZDRYJOXxrbgU2qv1jz04139w3vwKQm0oJY05ggkIVE68xmN0yxqOag/PwiGk8i4RT3bjnQrcjbu2v5uwl5eqUVxJ9zYuy1fELDLvlNRLWWo7quZgT0fxY8Tdiejsfs4v5U6HyGrwwhV/nUv7rPI/ulzmmueyEcQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by DB9PR04MB9332.eurprd04.prod.outlook.com (2603:10a6:10:36c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 17:53:05 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 17:53:04 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com,
	robh@kernel.org
Cc: alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com,
	gregkh@linuxfoundation.org,
	imx@lists.linux.dev,
	jirislaby@kernel.org,
	joe@perches.com,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	miquel.raynal@bootlin.com,
	zbigniew.lukwinski@linux.intel.com,
	devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org
Subject: [PATCH v2 6/7] i3c: add API i3c_dev_gettstatus_format1() to get target device status
Date: Wed, 10 Jan 2024 12:52:20 -0500
Message-Id: <20240110175221.2335480-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110175221.2335480-1-Frank.Li@nxp.com>
References: <20240110175221.2335480-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0145.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::30) To AS8PR04MB7511.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|DB9PR04MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e8e635c-ab26-40a6-3c1c-08dc1204feec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GByjKMOFA1gx6RQ7xxoLj2gQn5JOpGcPDrbRHVBEkME4/pi+5KV76pjtV2cmDGaM3lZ+KlMhayfMMoxGPT7ObLPX2qHKaqungrIyzdrxY+EqrBxNkvv/QZZMu+1KYZgY/Xie8Zegi8cIKlywZpfnZx3fgZ6RU8L/7Z75uqXYpbUaKCtokwEHuAnH+Xc5MIgPQ6pp0/lysJWRSmH/ll/iYHWmiE2u3962AopzHKFtLoyILSb8hb8mmlOd+aCNzImwagIza+t831EsMG6uWgckFZTtwxZdm2o0AsJ/75w2c3ohBZVbK5SyCc+UZt5iDtKzpRtNz7fcl/lFJSe1IBkyJzWav4d7BGQYw3BJ7U3pIxsG1sVcm/DXQJRBiUkDefqEdlhbbU25wt7VxoGfdtzZoWrwIRgJ3ZKvqdhDV8qxnH6JPCsP+MLM5ioHSAOJvbKWufZ322LE1/EOrgNZr5mF2qUhCu7dI9tV1ni7VPzFOkmOZ2ZHADENR0KsXfThgj7kwYTbBDWzjmWhnIjNd8Pg3l01zprDPelm5khWX/IG2KYXN1xz0UETE0ntXjLE8TDA8+L01uEICDHQ37Gui5DBQ9i+tcGjqvJXB6b1/kzkS6RpgDFr9G+p8gD4BdqHSuAM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6486002)(8676002)(8936002)(86362001)(5660300002)(4326008)(66556008)(66476007)(316002)(66946007)(7416002)(38350700005)(36756003)(2906002)(41300700001)(38100700002)(6512007)(52116002)(6666004)(83380400001)(6506007)(1076003)(26005)(2616005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SXOxOmlXUOj6QMKGLXWkEMiPZwNlC6XPD81RsGvw7ZvpVQ4+FMgwFRKmtOXq?=
 =?us-ascii?Q?WozUj2/4SmkF12p/hUK2+jKTN5PDdcs+SWE09YiZ/ne9GFHr60iPxU1VTSZJ?=
 =?us-ascii?Q?MNm1anCsIjWgI3LdmerlnBtGW8Yo1up7eq8yvlc84/YZ1SXZJ0KHH6vyYULL?=
 =?us-ascii?Q?ebIU2bQCy2WCyz7INL+xCJ/a35Tf5T4Q9X55XJvCp1ngKrtrD2ciJTr9isWu?=
 =?us-ascii?Q?c0JQaK/5OJMdZD8bMldYMWJkHeNeJ24HIJcTgdpBbj8nNDFJWB+gPjslTwfA?=
 =?us-ascii?Q?Qjllyc1BHLKcuqC8mLbCMqj7jZ6poOJ391TuSi9uPeN9f5hsxS1B1mDgHHr9?=
 =?us-ascii?Q?nRjxrpFA5FWHWvsG2j+tZK2Jr1jqbTO8qgVbwffpOX11DXKEdOyxBJcLN37f?=
 =?us-ascii?Q?0g31LimKl1beEVYqt5YDQnHGKyOwuB3LLVMptXcoiAtlD0cQBqqbsMStfeCB?=
 =?us-ascii?Q?NS1DOvRJYB8c++MBocMsATeOMmnDDzpY/7U/QpJG8eolu3OaNrXQMMc6kX8C?=
 =?us-ascii?Q?1wu5N22HUQBiBt67/kfNSM1kke8/Yyo3RFHuQUDH3ELNKUrA7uc3JIZzX4Sm?=
 =?us-ascii?Q?KVSn8TVMsS1WHkTVc0mXfpoDZzcySamxmkLMabYDncb6+LWr1HNbV2iHPTr0?=
 =?us-ascii?Q?4xU2aqULwZCdblL5lZiinFHKEL84ryzop2Xub1I+IrBUYYOpXaCXHgn3i7cm?=
 =?us-ascii?Q?htdBQrc39zYnEtbG5EvuXD3PzPKLKIxPVWT+Z/CCySJE6Vk21+CxVHoNUEMI?=
 =?us-ascii?Q?6oPYT2QdvNWaOMlZTlWMToO6qic8cBMf1cwL1Dt/4yr4qqufcJ7OwpLT30YI?=
 =?us-ascii?Q?sdRbzeBF1mHVtmokg47HFSFtbzV7sSqEZDmkij2jCi5wSCrLyXj30xEraTIH?=
 =?us-ascii?Q?tW/vOYjBQH1dIwKMmtPgkRe4XWK4893lv7eguRLd8ezMC55OMO2NNXxNwXq/?=
 =?us-ascii?Q?ReUhm3FX/wuGEmSbhsdyXNTJ8r64LRsnNyv+ilSlg6R6pKz5Jm35yCjsItVV?=
 =?us-ascii?Q?eYtUUne4qOXcFp/ns0fBYe/c3PkWAPASGiWZ47pfrXyw5TW+I7v6qldroY43?=
 =?us-ascii?Q?IxZNA0hTuKTZK3uPWYCSAf3aPNo5PsM315JgPKysBYok1oIdYKxQHzEofcRF?=
 =?us-ascii?Q?yLpd7r56U/5FJfCHiAyOXHeMRKoFcv9zMiuabvuwyJInXoS82FTgZwKWtLWN?=
 =?us-ascii?Q?SVEf+nsMtRpth350Ce4JcYRPlZwjowaUzsN66X9wtqp/io2G2b3UbeJZXbC3?=
 =?us-ascii?Q?sqUgjXUlO2Vn4rAhXs0bNY9JiOYsiFDeZuGoY+WNzFXiYSExaRkgT9rsEBjR?=
 =?us-ascii?Q?qZI4h5Lk4pIEGNM+xOjqCN2BTj1u/pAKqeju4YmWZppEYvsLU88F916rq/B1?=
 =?us-ascii?Q?x4E5zj+Fs6pHSj9lMlNAPoU4il61+RVpvU72xQv13V+0izy7Zv4VfT1/AESH?=
 =?us-ascii?Q?K0Ozd6xtj/sfCr2+p/IWD3dJ/fnL5UxOzQhGSUukSvL6Ilt423nq4cnedhP3?=
 =?us-ascii?Q?6vFp2UBEwKB0DIW5f5qIJtb5h2kmvjxQxG+IyimBUiRlZSSp9rKMuK9F272Q?=
 =?us-ascii?Q?3SVAmmNew0u+u/wlh6o=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8e635c-ab26-40a6-3c1c-08dc1204feec
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 17:53:04.7471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlXhbrcutyVNt88c8j/hgDrsrxwd2UHPuf53f5tnytENUt7YU3Hi1NoFn21yu2zFWY2ebH3sE25OReYUl5ws4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9332

I3C standard 5.1.9.3.15 Get Device Status (GETSTATUS):
Get request for one I3C Target Device to return its current status.

Add API to fetch it with format1.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/device.c       | 24 ++++++++++++++++++++++++
 drivers/i3c/internals.h    |  1 +
 drivers/i3c/master.c       | 26 ++++++++++++++++++++++++++
 include/linux/i3c/device.h |  1 +
 4 files changed, 52 insertions(+)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index 1a6a8703dbc3a..aa26cf50ab9c6 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -196,6 +196,30 @@ void i3c_device_free_ibi(struct i3c_device *dev)
 }
 EXPORT_SYMBOL_GPL(i3c_device_free_ibi);
 
+/**
+ * i3c_device_getstatus_format1() - Get device status with format 1.
+ * @dev: device for which you want to get status.
+ * @status: I3C status format 1
+ *
+ * Return: 0 in case of success, a negative error core otherwise.
+ */
+int i3c_device_getstatus_format1(struct i3c_device *dev, u16 *status)
+{
+	int ret = -EINVAL;
+
+	if (!status)
+		return -EINVAL;
+
+	i3c_bus_normaluse_lock(dev->bus);
+	if (dev->desc)
+		ret = i3c_dev_getstatus_format1_locked(dev->desc, status);
+
+	i3c_bus_normaluse_unlock(dev->bus);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_device_getstatus_format1);
+
 /**
  * i3cdev_to_dev() - Returns the device embedded in @i3cdev
  * @i3cdev: I3C device
diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index 908a807badaf9..976ad26ca79c2 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -24,4 +24,5 @@ int i3c_dev_enable_ibi_locked(struct i3c_dev_desc *dev);
 int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
 			       const struct i3c_ibi_setup *req);
 void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev);
+int i3c_dev_getstatus_format1_locked(struct i3c_dev_desc *dev, u16 *status);
 #endif /* I3C_INTERNAL_H */
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index d3b56c9f601e2..81611a3e3585a 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2923,6 +2923,32 @@ void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev)
 	dev->ibi = NULL;
 }
 
+int i3c_dev_getstatus_format1_locked(struct i3c_dev_desc *dev, u16 *status)
+{
+	struct i3c_master_controller *master = i3c_dev_get_master(dev);
+	struct i3c_ccc_getstatus *format1;
+	struct i3c_ccc_cmd_dest dest;
+	struct i3c_ccc_cmd cmd;
+	int ret;
+
+	format1 = i3c_ccc_cmd_dest_init(&dest, dev->info.dyn_addr, sizeof(*format1));
+	if (!format1)
+		return -ENOMEM;
+
+	i3c_ccc_cmd_init(&cmd, true, I3C_CCC_GETSTATUS, &dest, 1);
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		goto out;
+
+	*status = be16_to_cpu(format1->status);
+
+out:
+	i3c_ccc_cmd_dest_cleanup(&dest);
+
+	return ret;
+}
+
 static int __init i3c_init(void)
 {
 	int res;
diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index ef6217da8253b..5f511bd400f11 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -345,4 +345,5 @@ void i3c_device_free_ibi(struct i3c_device *dev);
 int i3c_device_enable_ibi(struct i3c_device *dev);
 int i3c_device_disable_ibi(struct i3c_device *dev);
 
+int i3c_device_getstatus_format1(struct i3c_device *dev, u16 *status);
 #endif /* I3C_DEV_H */
-- 
2.34.1


