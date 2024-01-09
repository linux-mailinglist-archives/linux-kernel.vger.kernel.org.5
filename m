Return-Path: <linux-kernel+bounces-20405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05539827E55
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 06:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF3E1C235D5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD871873;
	Tue,  9 Jan 2024 05:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CIVO2ejF"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AB6646;
	Tue,  9 Jan 2024 05:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrCNSIVHZ9Ku8Qmhy6EvPfwrm0UafTnKNezHT6e7pqvkBvclF6HAE/a4hHbZvFsyCIr5wvWvL0GpfszgqqZg92K+zw43ZvU36Y7yvb7UmXqtq9+m8/SMvqCqSv2W1IMay8kiqmFURzo52pJ9HO7OaejYBL6Zf3YMYOmjh67D1d/41oeT/Hs9A/MmIeLTIJkmx5ck6B/eHwLFnwV6nfzoCTd2adC1Q9OlhFWoWpbFMTwuhLksdUFoLiLLdkcZouBU2wvIhWk1xhHXhx2EgF/sF7fEFZZvjgv+CFQOWu3+k1WRRJYEXs585+/fa0MjxhGoxLOvool1EC/vM4apGNJiZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJBAg9at4SySdpk0H41dhzwrh0m9WEbs/M7wyHIadEo=;
 b=nnaV+bDf5VTUFoSUnrRptmTChYioz6squmDgpDVffiYUs2cHQ1TIqwcW5VFieErJLvGpdk4KrDUlbRe5ry5Net3smJdkDjiUoyv8baiJtH5dsxcDgAWdmCmFRXR83rdW73Zt2PQ1RfUBdtEp9prkTY+wngM6Rx3ZrZGe5VdbARUaEvf2Of6/R/vx76HLcFHfPF/6VLW5wkS+GPcboo0i8SUoCgwqc8Ar3yJN+VLQI7M4MUT5H/iCoqw/7a7c20TbFx6pCR9NyDP38nGFSCXndgYTH6de+Yk11/+k5Kt2JzAXYsdIe9KVgodbVbQGa3CcIhCquvmLPymmiHFzeOM6mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJBAg9at4SySdpk0H41dhzwrh0m9WEbs/M7wyHIadEo=;
 b=CIVO2ejFGdB9HhMD/LpLV6YUYuAWoVYbMpgMN/98XADc28BQ6utZrnSdjTvckRyeUz3cX5+8NTgo93xbevjgYYwLX6ndxKkHBMCR1ljdm16CgZyhicSNy7gV7ebAZbeFNuvitYN5fvVOs5kPYiJFlbv9KRarnhV9LI9W3N6cOIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by PAXPR04MB8110.eurprd04.prod.outlook.com (2603:10a6:102:1bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 05:26:05 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 05:26:05 +0000
From: Frank Li <Frank.Li@nxp.com>
To: alexandre.belloni@bootlin.com,
	linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org
Cc: conor.culhane@silvaco.com,
	imx@lists.linux.dev,
	joe@perches.com,
	linux-i3c@lists.infradead.org,
	miquel.raynal@bootlin.com,
	zbigniew.lukwinski@linux.intel.com
Subject: [PATCH 1/1] i3c: master: fix kernel-doc check warning
Date: Tue,  9 Jan 2024 00:25:48 -0500
Message-Id: <20240109052548.2128133-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0064.namprd11.prod.outlook.com
 (2603:10b6:a03:80::41) To AS8PR04MB7511.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|PAXPR04MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e97e04-0030-4615-1058-08dc10d37a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BJvWeYvJzLKWimwPoguKgaOWQbiWkCI/gca1i6XZUXHZu1cHL8CUF4FOsc6Pa0JWd5Jk6yx7pkXRMSTnXSm/shqzdQMC0gIl4Yz0NrKyFq52OzWvYS//AIbHddIHcpxlHddMtewuVWB/chBqC58Uw749vPobyQWZQTWtL/M22o4ieMIwLM/tJCfH7OXj7w2IaRo2tfF+SmLYLQbX47Njo/UpqS+IvlWw1J4IE/tbAZ2V8YOGeDnfCjQKcRWR3qF7dlJ4/nFnA1p9CduR6KSBxz4tIuQB+s58/USrwa8kh5ACMXx2QtR8oaf8XycXuEjp+141hxA9+o9sZqJ9BC7/OCW7m69u+eI8VVtelufZJOuFjozZdH/Z2Jib4iCWwC4QP/QTYaIsntDM6a6x84vKG7xZHedB/2TQLBq+8O+btj7l5PUHrGlRO19hmu4Rhtw6st1f8t+gSLq+84ppNcMLaNXIwdr9NBs3vhy7/lfzt/pJzIS0ONr4QsSYpqgMvcuCFm97gQ50/uXwONHz5n7vIh5mr4XlmUOvxrx4HhZiHglSMR5uga9AGDGMOXdALMO7z4hX7tC6uwza15+Y82Q1t4SNvuupNlLIT1Vcoj9HSejQ4w2QsP2ObQo2/D2bC1c3quVnk/LgpYTEUF+iODrCATk4g3+n79/fhfUbri20/OM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(230922051799003)(230173577357003)(230273577357003)(1800799012)(451199024)(186009)(64100799003)(2906002)(38350700005)(5660300002)(41300700001)(83380400001)(478600001)(6486002)(26005)(2616005)(1076003)(38100700002)(52116002)(6506007)(6512007)(6666004)(8676002)(8936002)(4326008)(36756003)(86362001)(66946007)(66556008)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?is5CA8i7i13JA+soXlJDr3baFZ/qyCY13jZHLz+XItT8w5grv+eJa9ObF3Yb?=
 =?us-ascii?Q?O7/8LUe3WAcBNGQvtoqSV3nkRJRb9XyAQQNaFWyal9IgCT5GP0Sn3GX6PnDb?=
 =?us-ascii?Q?Ha/E6UYKGE6igekAORXBjBLq4tGkQBsJUiPzW5XQ8Dw/oF4SIROs/m+QGq/W?=
 =?us-ascii?Q?ecYK/4DzioInjbn/ZSxRzAJQxYFxWRgpMXce7eBaHg1qRxVjkUC2+CNbWGBN?=
 =?us-ascii?Q?FYa8FH1OR2Ej0AlS4UIiG3eWP+lkyDQDogCt04i84NEtSVKfOP3+9KwQXEc4?=
 =?us-ascii?Q?jXr2DrtBQ0AZqm/jJy78N2rpeEe0mWAvgcrzre/rH8hP8/lKooVfGBWZhqZy?=
 =?us-ascii?Q?x+sbzX+oImQ/On83KeOBES7h+4ftMuOUZ9ukPvTHoEjHx28fO4D80fGkFq4m?=
 =?us-ascii?Q?1r3KxkR5Iudoe9fBJvYeNwmxHQxmm2nDzK1+2py3WEKLi8XxCm759YCgfcI9?=
 =?us-ascii?Q?V5PzBQdDeVwG0v9ByRpxyBpzaCyPn1ri4Qg4azXxg7phL02JVbLSpO7Iqf2i?=
 =?us-ascii?Q?67YwkXGelKJM6U6N5MIyq7JlzFGV165F6O3isyyQLmWgI9lzRB2NUWeOpcjx?=
 =?us-ascii?Q?uYBhMwKBj+4fhUJ9d3O3gxA/gTDXIc7+jzFykBlP/1yzPuDQ20BWtku2n4co?=
 =?us-ascii?Q?O2npmDLU4O6Y+xOVh5Za0piTF6fd6bHlspmUNXU4K7Q4VdYjxXdbYPSA+bNS?=
 =?us-ascii?Q?Mn4nexyZTt3dtPXfDLKkmLNU6bzIKoGSfeB6Hi/IdJDidXmVLx2O4AexmRaU?=
 =?us-ascii?Q?z4kbL6jMMXLawqpORg4lEJmbp0A1hFsompJBERqhio1DfKVEiwvfG8utYrep?=
 =?us-ascii?Q?lBg0FIRVsljwtKMXdFWu53GQ8bKsrmGsdQOpbZ9GbmpsWPdmbuPv0ON4d1Js?=
 =?us-ascii?Q?8MnJgLU1rBsmpYCBwVqm8xmDo9CRUKj49YwqFEDl+AsGO2oj5ngjc0JK3SOj?=
 =?us-ascii?Q?j1wgJvy4Gs8Qh1ibWhQT6GPL6EjZjrYYs6REpGpz/Hplo1PCKUqrx2zEo1Qu?=
 =?us-ascii?Q?wm1ztNuhmAq32rQxReWxJ3jOSy2KtrD1TUYpoe5HmIIL/LU5gqdmXU7gnroY?=
 =?us-ascii?Q?/1dJdL3v3Ln/sjr4I26xjNkO80bNQ9Pu4jsC3rUnU8aupfN5XmnkVhUnRHd5?=
 =?us-ascii?Q?JednSB1EN7uKfLRBp4nrfOV1nnx3o/WWP1rzvUpVm3spYHRh8aXQJpnmKWAm?=
 =?us-ascii?Q?gi9JVNCqYF8suRSfoWIwIID6UjQndoS39fZkvga5BIZrYRpjjEauWX5cOXcV?=
 =?us-ascii?Q?f6z2ZhDZqoLqt7vOrGbor4XvqFlsBl9yk/QQ5S+rMCz4Vf1qbM175j9XkzbI?=
 =?us-ascii?Q?cxa9Hj2JGYCJkA0Bky6nVvL2tRAyEJqp3QfDb33icR9cRbZbKFyGSSHLxGAi?=
 =?us-ascii?Q?5eNzkNEmpkGOV+uBPt67HXuwDPZGJn7TRY4YltUH9QVUXs/4VyRgSuxK1Sw3?=
 =?us-ascii?Q?lXus/ibB6HYLAX2+aJ3aSYxDztkg1zXBTmwxfLzQZBGXNZFz6V7Rny0tIQUo?=
 =?us-ascii?Q?uBrqWrFMMaIISB3l0AH9nPg8DtjCmvb3eBePCXxV9Gj0F6SLxMc1EEbnkZpY?=
 =?us-ascii?Q?+a7phMjgDm6pvxsTJ2ea4uYKwGVXMCcv+eyDIUsD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e97e04-0030-4615-1058-08dc10d37a50
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 05:26:05.7447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYAQuXbGeFZca7CuUC635RW+jxyrIvnXkmYajsM2dhUy2qoJf48IVNHPILzSzJiO3xe0M/r+EDIEXyPwFuJTZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8110

Fix warning found by
	'scripts/kernel-doc -v -none include/linux/i3c/master.h'

include/linux/i3c/master.h:457: warning: Function parameter or member 'enable_hotjoin' not described in 'i3c_master_controller_ops'
include/linux/i3c/master.h:457: warning: Function parameter or member 'disable_hotjoin' not described in 'i3c_master_controller_ops'
include/linux/i3c/master.h:499: warning: Function parameter or member 'hotjoin' not described in 'i3c_master_controller'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 include/linux/i3c/master.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 65b8965968af2..1cbf0baca65fe 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -426,6 +426,8 @@ struct i3c_bus {
  *		      for a future IBI
  *		      This method is mandatory only if ->request_ibi is not
  *		      NULL.
+ * @enable_hotjoin: enable hot join event detect.
+ * @disable_hotjoin: disable hot join event detect.
  */
 struct i3c_master_controller_ops {
 	int (*bus_init)(struct i3c_master_controller *master);
@@ -467,6 +469,7 @@ struct i3c_master_controller_ops {
  * @ops: master operations. See &struct i3c_master_controller_ops
  * @secondary: true if the master is a secondary master
  * @init_done: true when the bus initialization is done
+ * @hotjoin: true if the master support hotjoin
  * @boardinfo.i3c: list of I3C  boardinfo objects
  * @boardinfo.i2c: list of I2C boardinfo objects
  * @boardinfo: board-level information attached to devices connected on the bus
-- 
2.34.1


