Return-Path: <linux-kernel+bounces-16528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F502823FB9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78F91F21D2A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD655219E1;
	Thu,  4 Jan 2024 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="B65NjVW3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2047.outbound.protection.outlook.com [40.107.241.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5885E20312;
	Thu,  4 Jan 2024 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8tNNVkgyN5kllZAVTCoLimWSKWot+rTnnCsQyTAiLLEa4M+GAAyuI9DExCqqS2Sml3+q7bD3ej5I7QTW/uW0kYpWjbcy16fg96Vpld3qLaDT92OUa3JMEMDcgyV9apUN29BLIwVFWq1Q/YlkJlmnml/XuB3/Ko4UKKwuWLg0RoLUwZxFnqL/Ndv8tms8ZdpuleyPg10KlhMYN3TSoKaVeYXA+G6JI3VySJQi6RsRJkeS5AMjsCWJRzkonw4b4RuVMsKAMjMdq72in3YP9UZZaKeIT3PZ72Mc0W5tYPCAnzhevuP8I5hWkTB1ljwKL1R5y6Io7NN3N1LUvvqy+X3Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XN+OpbrcmTMT4H3pi5hwwbDfxt1SyViDK34Q/cTJNEg=;
 b=NI9qsy0dTQv61u3qPtXZ4jK9EaOFzBjUlzSfhlMWr92PnzJrIETztW18YZzPPd05U1sPK2222dAalyRqd9nL55a9M4rACIlDXwTy0pZPRujHi3oAfrz1W1vFh6X1QcS26+kxcdkNwIy9aBOI1z3nPtfUD87Bh8p9vXxthtppE4ai5m4sDVIRNoZYEE40Ir3vlztiCCSZrGcTM6Yb5HSUw/0TLWXzib7ZEcxgGmMMQmF64ilRi7RVDjBa0lPmJDS04fATboPtcbcK+OOjq+45MaAsc7fXzQ6+ZBs6KlbyCY51adTsVQ2X1mPu0e279ao3wUFJxMGJynSRF5Aca2cP7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XN+OpbrcmTMT4H3pi5hwwbDfxt1SyViDK34Q/cTJNEg=;
 b=B65NjVW3M8CqYyVGkdQhS+lgsfZOKWtZB2j5J1e7KSxF9wY1TvLJsbNluFBi7S3AJP1ocaxeKJItiUPuf4IwgBkQU2QwL7SPUKqhAl41qgXNGbVWQRqgrcZ3JCjVf7alJ2xFbfY7qBZendrbbyEXdTLWZYkUP8Hp4IAJEcgjMNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8847.eurprd04.prod.outlook.com (2603:10a6:102:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 10:45:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3%7]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 10:45:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 04 Jan 2024 18:48:47 +0800
Subject: [PATCH v2 3/6] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240104-pinctrl-scmi-v2-3-a9bd86ab5a84@nxp.com>
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
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704365357; l=30286;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=KwPmf5cWc8W/xn3nA8DTSRpevUkumXSUbPjKCYtwWrQ=;
 b=Na/pwstiQ5z6NjDIBOK8omu2kBeTPOIVQEOOfZ0BXIwZ0FKKptgbyIfEfs3gDKOxJTInv943q
 vuMq4rDF/L7CsPiY3m0kOykK/PPToeI72fCT0wrnCiu4pvayr5D5CyZ
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: cb250456-8d82-4252-6234-08dc0d12346b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wljW7zLNQnLWR5xGo/9286BPDhYdU16CCFiRfrBO6ypO1wMkljzptYc98Y1Q7rdOESZemj3vG4wL+qao83x9AssfMJQ4gAHJwhxVtIPn8Fj5pWNfar/glppG4ZRwCb69F6ADJA3C/h5PrDZ7C4QmOfYLrQVzjmBJklREuq0OcBS8rHVY71Fz6GmworaZ10nttDEKKFkdYfILnT1iMQISwzXSCfV48evNouRLW8ubqTMFPCbQ6MjE6NLfO7BnTzo6HYX753E0F/Ozb4r8PIdvXKwbWneS4mil39OcFDZ52MMfShJD8+2gE41pQ07qP5wTgpaMchK+qbp0itivg//AqjxYX8+RKKFbmdIO7sSz86iEF1QHCnFPDmKzZwAAsTamOE2N+W3TC0PhhG49rYj3141kqpX7uElpR/Q1KlIL/1ZwJKEKt231I8f6WAgvVgvtNK6rYO5kT3CJtPwbx1Ettsq60JdHqK1u2e9NuqklNEwuJGabAnVv0MtLtiK1uOJ/juFJRyu3d2CR312QWpfcgCjT+9d8uU6CGT7p/j6/UyGCPZylhL92cOI97rhrQSPQKbfPG6rgQlU9Jk2gzNmjA7rdNdK1twS8OxDHlhIiXpqfmyub2HVek60uwATe9VX6tEOpxBZvBSV4iJiGRvmcvQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(66476007)(66946007)(66556008)(6486002)(4326008)(8936002)(8676002)(26005)(54906003)(110136005)(316002)(83380400001)(6666004)(478600001)(52116002)(5660300002)(41300700001)(30864003)(2906002)(7416002)(6506007)(6512007)(9686003)(38350700005)(921011)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGNUd01TTXM2WFdBMVN4bUM0T2tGaXBvZ2FKYVNQbDZlaEpzb3FDTEF5anUz?=
 =?utf-8?B?QU4zcktQWGNTYTVBRWx2bXh3enoxREtSY0c3eTR3dHpHNHZLcGdYZTZSMUlr?=
 =?utf-8?B?dmdNTmpUcGgweUxGcWE1NTV3OE1VTjJmcEFLZ3A5MElrNmV5amExZ2dOWmt2?=
 =?utf-8?B?MG0wdUZEOVZ3RHkwNWdOb2w2UGZzOVc0MTlzbzgwajFhTWpHWHpuTVdLRU02?=
 =?utf-8?B?ZWFHOE1iTTJ4dlNuSUhuRmxXSkE1T2VXRTR1UnZNVW5UUmVLSWlyeTh0QmRY?=
 =?utf-8?B?K3V0OHhiTzlGRitycytnU3VUYnBSdnhUYXFlUk1rTXhhU1lDQmw3Mlg2a2xz?=
 =?utf-8?B?aXVCZksxeW5UWjBYYjY5VjFlSGZQQVNoU0U1RVNVSW9QTUJXNXdPSklTSCtK?=
 =?utf-8?B?ZllSQjduL243OCtoK2wzUWUvN1MxU0l4Yy8vQTBwMHBmdFcvbnlvOXFyQXU5?=
 =?utf-8?B?TlJ2b2Uza0UwdjVLd2d3dVU3VWZ6d3lEWHNHTmIzOWlXQ1hmOStRaG0ycGhK?=
 =?utf-8?B?Zy9IMWw4cHlpWWlBMmdRdk40TllGUDZtVFkwam1BaWtiUXFGVFBRSlFEZkUv?=
 =?utf-8?B?ME9FZmJxZHF1ai81QXB3WUZ0NDFIYWRBOTRxRXlaMDdKaHZDUFBSN0dJZnQz?=
 =?utf-8?B?dmQxamovRUdaNWljUGM4UHVqQU05cHY4dVV4d0FCSVc1OFdDWlFFVnhxKzl0?=
 =?utf-8?B?QmNCRmhCZm5RTk9hZjF6QmI0VEJic2hmZE9WZjFLdlE3d29wb3FoR0NHaE9J?=
 =?utf-8?B?TFI4ZytHNUp3dlJySC9pWnA3SVMxZUVTT0cwbm1aZUpvbmtlZFU5STFHMDhv?=
 =?utf-8?B?NzhMN3dVcnNGbjB3RXplRzZ1bEpIYlFiWW9XTndFYjNya1NkMDNra3I2bm1F?=
 =?utf-8?B?TEVFYnFJQ2JBUVdWZnBXeWdiZmpHVGhBVUN1Mi9EaXNMaXN2eTM1UEl5RXNu?=
 =?utf-8?B?VWdKaGw4STkzVzh4bk5kcFpDUzQyT1gzVHRDR01RcTBLdWM4emtSamN6cVRj?=
 =?utf-8?B?L1NhYTJFMHkzU1k1Q1puZm1NTGtJZm1sUVJCQ3orUzNPMVFGMVh0cDNYYkdQ?=
 =?utf-8?B?bnpYNG9XVzhiV3FpSS9uYmYvU1BPbEV3YmhhOXdtNm8wZlJxeVc2S2VlZWpU?=
 =?utf-8?B?Smt5QnNUN0VPK2dIRzVoQTFqNE5wNnp3b3plK1YvU2RneFNrT09seWVWdDRH?=
 =?utf-8?B?VHZZa1pPWWRpS0RFVjNNa2ZGK3Nia2JOZkFpVGJEdFU4YXIwcysvWFdkL2Nm?=
 =?utf-8?B?cU9UcTRDdU0wS1NFcE5MbkN2RmdVSE1HMVlHWnhhbnZ4eWM2Vm5LQXhubmR2?=
 =?utf-8?B?dXlZdVRmNmtaWEJDemlZdUJZUW4wUzIzQU9idTdWSjA3QW5SQW5aRUJGRndL?=
 =?utf-8?B?bHA2dmRtMVBvV1FaYzJkRjF4S3R4dXV5NTQveFVkMURaakRYdEpoYnk2L1Nk?=
 =?utf-8?B?NkYrSGFWOU94bzI4QkM0ODN3N04xa2dFZ2thTmR5UUJ2L1hCWTUvc21QSTY0?=
 =?utf-8?B?M2R5RUV0ajBvY1dtb1p1MkdpbzNPUFdtZmRUV0J6QktIL2RoVEFWb1g4SDJh?=
 =?utf-8?B?cVo4cWJhdlZzT0NGVFZRb2s4dU8zdnlMZE5nNVpGY1NZcTVGUWd1MkpaWDM4?=
 =?utf-8?B?a3pvOW5KZjdvWjNEY3hXTkFzWUJOVktUMFhTa0JiS2F0czNKMkwrUW1pU0s1?=
 =?utf-8?B?OGMrWlhNd2lXck5KNkVCKzFKa0ltcS9peXpOM3lCVzNubjFwYUtWeGlvZDJI?=
 =?utf-8?B?NU1lWjZDSlAvUkdOYURKUzlPdGo3ejlQSTEwTC9zM1F0a2x3aHBzdHFRUFJD?=
 =?utf-8?B?ajRGOTQ4UUl5WGk1UnpZTHM1UmVtMEV5MFAxS0JmNWZYRzFQVjJPYVdONWR4?=
 =?utf-8?B?N1VFa0w2dER5b1lsLzFic0h4RUxWSkROcFFNT3kvVDBhRTB6QkNQMldiWUVE?=
 =?utf-8?B?TUJsdFFzOGdhOFEwWjFMVEgvSU45eDJQZWpodEV1WFY3ZkJZTjI1b3RpeENm?=
 =?utf-8?B?QlVFU1g3aFdkSFR3eDV0UEIzMnZBUVphTWt1a0NiUkpyeDJJYjcwK1dsSDJS?=
 =?utf-8?B?LzR0ZUN6NSt4T0Q1cnMvTVhnc2dBaVM4SmFzYzlwMEFOUWtVWTN0UFFwMDJN?=
 =?utf-8?Q?MZuzTdVhic5eKtvCnolbUef/a?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb250456-8d82-4252-6234-08dc0d12346b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 10:45:02.1492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gqBGZYgebGvYFfI7T3+j9cV3O0e/5L+08thAfj0VOKqJinokIcdPlykjJTY9o/OYHXpSLsjsvtF0v9LGZCtBaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8847

From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>

Add basic implementation of the SCMI v3.2 pincontrol protocol.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Co-developed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 MAINTAINERS                           |   6 +
 drivers/firmware/arm_scmi/Makefile    |   1 +
 drivers/firmware/arm_scmi/driver.c    |   2 +
 drivers/firmware/arm_scmi/pinctrl.c   | 930 ++++++++++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/protocols.h |   1 +
 include/linux/scmi_protocol.h         |  73 +++
 6 files changed, 1013 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0275a2c58f0f..487bff0d44c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21322,6 +21322,12 @@ F:	include/linux/sc[mp]i_protocol.h
 F:	include/trace/events/scmi.h
 F:	include/uapi/linux/virtio_scmi.h
 
+SYSTEM CONTROL MANAGEMENT INTERFACE (SCMI) PINCTRL DRIVER
+M:	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
+L:	linux-arm-kernel@lists.infradead.org
+S:	Maintained
+F:	drivers/firmware/arm_scmi/pinctrl.c
+
 SYSTEM RESET/SHUTDOWN DRIVERS
 M:	Sebastian Reichel <sre@kernel.org>
 L:	linux-pm@vger.kernel.org
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index a7bc4796519c..8e3874ff1544 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -11,6 +11,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
 scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
+scmi-protocols-y += pinctrl.o
 scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
 
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index a12afc254afa..4c3752749105 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -3050,6 +3050,7 @@ static int __init scmi_driver_init(void)
 	scmi_voltage_register();
 	scmi_system_register();
 	scmi_powercap_register();
+	scmi_pinctrl_register();
 
 	return platform_driver_register(&scmi_driver);
 }
@@ -3067,6 +3068,7 @@ static void __exit scmi_driver_exit(void)
 	scmi_voltage_unregister();
 	scmi_system_unregister();
 	scmi_powercap_unregister();
+	scmi_pinctrl_unregister();
 
 	scmi_transports_exit();
 
diff --git a/drivers/firmware/arm_scmi/pinctrl.c b/drivers/firmware/arm_scmi/pinctrl.c
new file mode 100644
index 000000000000..aa6e698e7b7c
--- /dev/null
+++ b/drivers/firmware/arm_scmi/pinctrl.c
@@ -0,0 +1,930 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Management Interface (SCMI) Pinctrl Protocol
+ *
+ * Copyright (C) 2023 EPAM
+ */
+
+#include <linux/module.h>
+#include <linux/scmi_protocol.h>
+#include <linux/slab.h>
+
+#include "common.h"
+#include "protocols.h"
+
+/* Updated only after ALL the mandatory features for that version are merged */
+#define SCMI_PROTOCOL_SUPPORTED_VERSION                0x40000
+
+#define REG_TYPE_BITS GENMASK(9, 8)
+#define REG_CONFIG GENMASK(7, 0)
+
+#define GET_GROUPS_NR(x)	le32_get_bits((x), GENMASK(31, 16))
+#define GET_PINS_NR(x)		le32_get_bits((x), GENMASK(15, 0))
+#define GET_FUNCTIONS_NR(x)	le32_get_bits((x), GENMASK(15, 0))
+
+#define EXT_NAME_FLAG(x)	le32_get_bits((x), BIT(31))
+#define NUM_ELEMS(x)		le32_get_bits((x), GENMASK(15, 0))
+
+#define REMAINING(x)		le32_get_bits((x), GENMASK(31, 16))
+#define RETURNED(x)		le32_get_bits((x), GENMASK(11, 0))
+
+enum scmi_pinctrl_protocol_cmd {
+	PINCTRL_ATTRIBUTES = 0x3,
+	PINCTRL_LIST_ASSOCIATIONS = 0x4,
+	PINCTRL_CONFIG_GET = 0x5,
+	PINCTRL_CONFIG_SET = 0x6,
+	PINCTRL_FUNCTION_SELECT = 0x7,
+	PINCTRL_REQUEST = 0x8,
+	PINCTRL_RELEASE = 0x9,
+	PINCTRL_NAME_GET = 0xa,
+	PINCTRL_SET_PERMISSIONS = 0xb
+};
+
+struct scmi_msg_conf_set {
+	__le32 identifier;
+	__le32 attributes;
+	__le32 configs[];
+};
+
+struct scmi_msg_conf_get {
+	__le32 identifier;
+	__le32 attributes;
+};
+
+struct scmi_resp_conf_get {
+	__le32 num_configs;
+	__le32 configs[];
+};
+
+struct scmi_msg_pinctrl_protocol_attributes {
+	__le32 attributes_low;
+	__le32 attributes_high;
+};
+
+struct scmi_msg_pinctrl_attributes {
+	__le32 identifier;
+	__le32 flags;
+};
+
+struct scmi_resp_pinctrl_attributes {
+	__le32 attributes;
+	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
+};
+
+struct scmi_msg_pinctrl_list_assoc {
+	__le32 identifier;
+	__le32 flags;
+	__le32 index;
+};
+
+struct scmi_resp_pinctrl_list_assoc {
+	__le32 flags;
+	__le16 array[];
+};
+
+struct scmi_msg_func_set {
+	__le32 identifier;
+	__le32 function_id;
+	__le32 flags;
+};
+
+struct scmi_msg_request {
+	__le32 identifier;
+	__le32 flags;
+};
+
+struct scmi_group_info {
+	char name[SCMI_MAX_STR_SIZE];
+	bool present;
+	unsigned int *group_pins;
+	unsigned int nr_pins;
+};
+
+struct scmi_function_info {
+	char name[SCMI_MAX_STR_SIZE];
+	bool present;
+	unsigned int *groups;
+	unsigned int nr_groups;
+};
+
+struct scmi_pin_info {
+	char name[SCMI_MAX_STR_SIZE];
+	bool present;
+};
+
+struct scmi_pinctrl_info {
+	u32 version;
+	int nr_groups;
+	int nr_functions;
+	int nr_pins;
+	struct scmi_group_info *groups;
+	struct scmi_function_info *functions;
+	struct scmi_pin_info *pins;
+};
+
+static int scmi_pinctrl_attributes_get(const struct scmi_protocol_handle *ph,
+				       struct scmi_pinctrl_info *pi)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_pinctrl_protocol_attributes *attr;
+
+	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0, sizeof(*attr), &t);
+	if (ret)
+		return ret;
+
+	attr = t->rx.buf;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		pi->nr_functions = GET_FUNCTIONS_NR(attr->attributes_high);
+		pi->nr_groups = GET_GROUPS_NR(attr->attributes_low);
+		pi->nr_pins = GET_PINS_NR(attr->attributes_low);
+	}
+
+	ph->xops->xfer_put(ph, t);
+	return ret;
+}
+
+static int scmi_pinctrl_count_get(const struct scmi_protocol_handle *ph,
+				  enum scmi_pinctrl_selector_type type)
+{
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+
+	switch (type) {
+	case PIN_TYPE:
+		return pi->nr_pins;
+	case GROUP_TYPE:
+		return pi->nr_groups;
+	case FUNCTION_TYPE:
+		return pi->nr_functions;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int scmi_pinctrl_validate_id(const struct scmi_protocol_handle *ph,
+				    u32 identifier,
+				    enum scmi_pinctrl_selector_type type)
+{
+	int value;
+
+	value = scmi_pinctrl_count_get(ph, type);
+	if (value < 0)
+		return value;
+
+	if (identifier >= value)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int scmi_pinctrl_attributes(const struct scmi_protocol_handle *ph,
+				   enum scmi_pinctrl_selector_type type,
+				   u32 selector, char *name,
+				   unsigned int *n_elems)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_pinctrl_attributes *tx;
+	struct scmi_resp_pinctrl_attributes *rx;
+
+	if (!name)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, PINCTRL_ATTRIBUTES, sizeof(*tx), sizeof(*rx), &t);
+	if (ret)
+		return ret;
+
+	tx = t->tx.buf;
+	rx = t->rx.buf;
+	tx->identifier = cpu_to_le32(selector);
+	tx->flags = cpu_to_le32(type);
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		if (n_elems)
+			*n_elems = NUM_ELEMS(rx->attributes);
+
+		strscpy(name, rx->name, SCMI_SHORT_NAME_MAX_SIZE);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	/*
+	 * If supported overwrite short name with the extended one;
+	 * on error just carry on and use already provided short name.
+	 */
+	if (!ret && EXT_NAME_FLAG(rx->attributes))
+		ph->hops->extended_name_get(ph, PINCTRL_NAME_GET, selector,
+					    (u32 *)&type, name,
+					    SCMI_MAX_STR_SIZE);
+	return ret;
+}
+
+struct scmi_pinctrl_ipriv {
+	u32 selector;
+	enum scmi_pinctrl_selector_type type;
+	unsigned int *array;
+};
+
+static void iter_pinctrl_assoc_prepare_message(void *message,
+					       unsigned int desc_index,
+					       const void *priv)
+{
+	struct scmi_msg_pinctrl_list_assoc *msg = message;
+	const struct scmi_pinctrl_ipriv *p = priv;
+
+	msg->identifier = cpu_to_le32(p->selector);
+	msg->flags = cpu_to_le32(p->type);
+	/* Set the number of OPPs to be skipped/already read */
+	msg->index = cpu_to_le32(desc_index);
+}
+
+static int iter_pinctrl_assoc_update_state(struct scmi_iterator_state *st,
+					   const void *response, void *priv)
+{
+	const struct scmi_resp_pinctrl_list_assoc *r = response;
+
+	st->num_returned = RETURNED(r->flags);
+	st->num_remaining = REMAINING(r->flags);
+
+	return 0;
+}
+
+static int
+iter_pinctrl_assoc_process_response(const struct scmi_protocol_handle *ph,
+				    const void *response,
+				    struct scmi_iterator_state *st, void *priv)
+{
+	const struct scmi_resp_pinctrl_list_assoc *r = response;
+	struct scmi_pinctrl_ipriv *p = priv;
+
+	p->array[st->desc_index + st->loop_idx] =
+		le16_to_cpu(r->array[st->loop_idx]);
+
+	return 0;
+}
+
+static int scmi_pinctrl_list_associations(const struct scmi_protocol_handle *ph,
+					  u32 selector,
+					  enum scmi_pinctrl_selector_type type,
+					  u16 size, unsigned int *array)
+{
+	int ret;
+	void *iter;
+	struct scmi_iterator_ops ops = {
+		.prepare_message = iter_pinctrl_assoc_prepare_message,
+		.update_state = iter_pinctrl_assoc_update_state,
+		.process_response = iter_pinctrl_assoc_process_response,
+	};
+	struct scmi_pinctrl_ipriv ipriv = {
+		.selector = selector,
+		.type = type,
+		.array = array,
+	};
+
+	if (!array || !size || type == PIN_TYPE)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	iter = ph->hops->iter_response_init(ph, &ops, size,
+					    PINCTRL_LIST_ASSOCIATIONS,
+					    sizeof(struct scmi_msg_pinctrl_list_assoc),
+					    &ipriv);
+
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	return ph->hops->iter_response_run(iter);
+}
+
+struct scmi_conf_get_ipriv {
+	u32 selector;
+	enum scmi_pinctrl_selector_type type;
+	u8 all;
+	u8 *config_types;
+	u32 *config_values;
+};
+
+static void iter_pinctrl_conf_get_prepare_message(void *message,
+						  unsigned int desc_index,
+						  const void *priv)
+{
+	struct scmi_msg_conf_get *msg = message;
+	const struct scmi_conf_get_ipriv *p = priv;
+	u32 attributes;
+
+	attributes = FIELD_PREP(BIT(18), p->all) |
+		     FIELD_PREP(GENMASK(17, 16), p->type);
+
+	if (p->all)
+		attributes |= FIELD_PREP(GENMASK(15, 8), desc_index);
+	else
+		attributes |= FIELD_PREP(GENMASK(7, 0), p->config_types[0]);
+
+	msg->attributes = cpu_to_le32(attributes);
+	msg->identifier = cpu_to_le32(p->selector);
+}
+
+static int iter_pinctrl_conf_get_update_state(struct scmi_iterator_state *st,
+					      const void *response, void *priv)
+{
+	const struct scmi_resp_conf_get *r = response;
+	struct scmi_conf_get_ipriv *p = priv;
+
+	if (!p->all) {
+		st->num_returned = 1;
+		st->num_remaining = 0;
+	} else {
+		st->num_returned = le32_get_bits(r->num_configs, GENMASK(7, 0));
+		st->num_remaining = le32_get_bits(r->num_configs, GENMASK(31, 24));
+	}
+
+	return 0;
+}
+
+static int iter_pinctrl_conf_get_process_response(const struct scmi_protocol_handle *ph,
+						  const void *response,
+						  struct scmi_iterator_state *st, void *priv)
+{
+	const struct scmi_resp_conf_get *r = response;
+	struct scmi_conf_get_ipriv *p = priv;
+
+	if (!p->all) {
+		if (p->config_types[0] !=
+		    le32_get_bits(r->configs[st->loop_idx * 2], GENMASK(7, 0)))
+			return -EINVAL;
+	} else {
+		p->config_types[st->desc_index + st->loop_idx] =
+			le32_get_bits(r->configs[st->loop_idx * 2], GENMASK(7, 0));
+	}
+
+	p->config_values[st->desc_index + st->loop_idx] =
+		le32_to_cpu(r->configs[st->loop_idx * 2 + 1]);
+
+	return 0;
+}
+
+static int scmi_pinctrl_config_get(const struct scmi_protocol_handle *ph,
+				   u32 selector,
+				   enum scmi_pinctrl_selector_type type,
+				   u8 config_type, u32 *config_value)
+{
+	int ret;
+	void *iter;
+	struct scmi_iterator_ops ops = {
+		.prepare_message = iter_pinctrl_conf_get_prepare_message,
+		.update_state = iter_pinctrl_conf_get_update_state,
+		.process_response = iter_pinctrl_conf_get_process_response,
+	};
+	struct scmi_conf_get_ipriv ipriv = {
+		.selector = selector,
+		.type = type,
+		.all = 0,
+		.config_types = &config_type,
+		.config_values = config_value,
+	};
+
+	if (!config_value || type == FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	iter = ph->hops->iter_response_init(ph, &ops, 1, PINCTRL_CONFIG_GET,
+					    sizeof(struct scmi_msg_conf_get),
+					    &ipriv);
+
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	return ph->hops->iter_response_run(iter);
+}
+
+static int scmi_pinctrl_config_get_all(const struct scmi_protocol_handle *ph,
+				       u32 selector,
+				       enum scmi_pinctrl_selector_type type,
+				       u16 size, u8 *config_types,
+				       u32 *config_values)
+{
+	int ret;
+	void *iter;
+	struct scmi_iterator_ops ops = {
+		.prepare_message = iter_pinctrl_conf_get_prepare_message,
+		.update_state = iter_pinctrl_conf_get_update_state,
+		.process_response = iter_pinctrl_conf_get_process_response,
+	};
+	struct scmi_conf_get_ipriv ipriv = {
+		.selector = selector,
+		.type = type,
+		.all = 1,
+		.config_types = config_types,
+		.config_values = config_values,
+	};
+
+	if (!config_values || !config_types || type == FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	iter = ph->hops->iter_response_init(ph, &ops, size, PINCTRL_CONFIG_GET,
+					    sizeof(struct scmi_msg_conf_get),
+					    &ipriv);
+
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	return ph->hops->iter_response_run(iter);
+}
+
+static int scmi_pinctrl_config_set(const struct scmi_protocol_handle *ph,
+				   u32 selector, enum scmi_pinctrl_selector_type type,
+				   unsigned int nr_configs, u8 *config_type,
+				   u32 *config_value)
+{
+	struct scmi_xfer *t;
+	struct scmi_msg_conf_set *tx;
+	u32 attributes;
+	int ret, i;
+	unsigned int configs_in_chunk, conf_num = 0;
+	unsigned int chunk;
+	int max_msg_size = ph->hops->get_max_msg_size(ph);
+
+	if (!config_type || !config_value || type == FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	configs_in_chunk = (max_msg_size - sizeof(*tx)) / (sizeof(__le32) * 2);
+	while (conf_num < nr_configs) {
+		chunk = (nr_configs - conf_num > configs_in_chunk) ? configs_in_chunk :
+			nr_configs - conf_num;
+
+		ret = ph->xops->xfer_get_init(ph, PINCTRL_CONFIG_SET,
+					      sizeof(*tx) + chunk * 2 * sizeof(__le32),
+					      0, &t);
+		if (ret)
+			return ret;
+
+		tx = t->tx.buf;
+		tx->identifier = cpu_to_le32(selector);
+		attributes = FIELD_PREP(GENMASK(1, 0), type) |
+			FIELD_PREP(GENMASK(9, 2), chunk);
+		tx->attributes = cpu_to_le32(attributes);
+
+		for (i = 0; i < chunk; i++) {
+			tx->configs[i * 2] = cpu_to_le32(config_type[conf_num + i]);
+			tx->configs[i * 2 + 1] = cpu_to_le32(config_value[conf_num + i]);
+		}
+
+		ret = ph->xops->do_xfer(ph, t);
+
+		ph->xops->xfer_put(ph, t);
+
+		if (ret)
+			break;
+
+		conf_num += chunk;
+	}
+
+	return ret;
+}
+
+static int scmi_pinctrl_function_select(const struct scmi_protocol_handle *ph,
+					u32 identifier,
+					enum scmi_pinctrl_selector_type type,
+					u32 function_id)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_func_set *tx;
+
+	if (type == FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_validate_id(ph, identifier, type);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, PINCTRL_FUNCTION_SELECT, sizeof(*tx), 0, &t);
+	if (ret)
+		return ret;
+
+	tx = t->tx.buf;
+	tx->identifier = cpu_to_le32(identifier);
+	tx->function_id = cpu_to_le32(function_id);
+	tx->flags = cpu_to_le32(type);
+
+	ret = ph->xops->do_xfer(ph, t);
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_pinctrl_request(const struct scmi_protocol_handle *ph,
+				u32 identifier,
+				enum scmi_pinctrl_selector_type type)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_request *tx;
+
+	if (type == FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_validate_id(ph, identifier, type);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, PINCTRL_REQUEST, sizeof(*tx), 0, &t);
+
+	tx = t->tx.buf;
+	tx->identifier = cpu_to_le32(identifier);
+	tx->flags = cpu_to_le32(type);
+
+	ret = ph->xops->do_xfer(ph, t);
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_pinctrl_pin_request(const struct scmi_protocol_handle *ph,
+				    u32 pin)
+{
+	return scmi_pinctrl_request(ph, pin, PIN_TYPE);
+}
+
+static int scmi_pinctrl_free(const struct scmi_protocol_handle *ph,
+			     u32 identifier,
+			     enum scmi_pinctrl_selector_type type)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_request *tx;
+
+	if (type == FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_validate_id(ph, identifier, type);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, PINCTRL_RELEASE, sizeof(*tx), 0, &t);
+
+	tx = t->tx.buf;
+	tx->identifier = cpu_to_le32(identifier);
+	tx->flags = cpu_to_le32(type);
+
+	ret = ph->xops->do_xfer(ph, t);
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_pinctrl_pin_free(const struct scmi_protocol_handle *ph, u32 pin)
+{
+	return scmi_pinctrl_free(ph, pin, PIN_TYPE);
+}
+
+static int scmi_pinctrl_get_group_info(const struct scmi_protocol_handle *ph,
+				       u32 selector,
+				       struct scmi_group_info *group)
+{
+	int ret;
+
+	if (!group)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_attributes(ph, GROUP_TYPE, selector,
+				      group->name,
+				      &group->nr_pins);
+	if (ret)
+		return ret;
+
+	if (!group->nr_pins) {
+		dev_err(ph->dev, "Group %d has 0 elements", selector);
+		return -ENODATA;
+	}
+
+	group->group_pins = kmalloc_array(group->nr_pins, sizeof(*group->group_pins), GFP_KERNEL);
+	if (!group->group_pins)
+		return -ENOMEM;
+
+	ret = scmi_pinctrl_list_associations(ph, selector, GROUP_TYPE,
+					     group->nr_pins, group->group_pins);
+	if (ret) {
+		kfree(group->group_pins);
+		return ret;
+	}
+
+	group->present = true;
+	return 0;
+}
+
+static int scmi_pinctrl_get_group_name(const struct scmi_protocol_handle *ph,
+				       u32 selector, const char **name)
+{
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+
+	if (!name)
+		return -EINVAL;
+
+	if (selector >= pi->nr_groups)
+		return -EINVAL;
+
+	if (!pi->groups[selector].present) {
+		int ret;
+
+		ret = scmi_pinctrl_get_group_info(ph, selector,
+						  &pi->groups[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*name = pi->groups[selector].name;
+
+	return 0;
+}
+
+static int scmi_pinctrl_group_pins_get(const struct scmi_protocol_handle *ph,
+				       u32 selector, const unsigned int **pins,
+				       unsigned int *nr_pins)
+{
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+
+	if (!pins || !nr_pins)
+		return -EINVAL;
+
+	if (selector >= pi->nr_groups)
+		return -EINVAL;
+
+	if (!pi->groups[selector].present) {
+		int ret;
+
+		ret = scmi_pinctrl_get_group_info(ph, selector,
+						  &pi->groups[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*pins = pi->groups[selector].group_pins;
+	*nr_pins = pi->groups[selector].nr_pins;
+
+	return 0;
+}
+
+static int scmi_pinctrl_get_function_info(const struct scmi_protocol_handle *ph,
+					  u32 selector,
+					  struct scmi_function_info *func)
+{
+	int ret;
+
+	if (!func)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_attributes(ph, FUNCTION_TYPE, selector,
+				      func->name,
+				      &func->nr_groups);
+	if (ret)
+		return ret;
+
+	if (!func->nr_groups) {
+		dev_err(ph->dev, "Function %d has 0 elements", selector);
+		return -ENODATA;
+	}
+
+	func->groups = kmalloc_array(func->nr_groups, sizeof(*func->groups), GFP_KERNEL);
+	if (!func->groups)
+		return -ENOMEM;
+
+	ret = scmi_pinctrl_list_associations(ph, selector, FUNCTION_TYPE,
+					     func->nr_groups, func->groups);
+	if (ret) {
+		kfree(func->groups);
+		return ret;
+	}
+
+	func->present = true;
+	return 0;
+}
+
+static int scmi_pinctrl_get_function_name(const struct scmi_protocol_handle *ph,
+					  u32 selector, const char **name)
+{
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+
+	if (!name)
+		return -EINVAL;
+
+	if (selector >= pi->nr_functions)
+		return -EINVAL;
+
+	if (!pi->functions[selector].present) {
+		int ret;
+
+		ret = scmi_pinctrl_get_function_info(ph, selector,
+						     &pi->functions[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*name = pi->functions[selector].name;
+	return 0;
+}
+
+static int scmi_pinctrl_function_groups_get(const struct scmi_protocol_handle *ph,
+					    u32 selector,
+					    unsigned int *nr_groups,
+					    const unsigned int **groups)
+{
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+
+	if (!groups || !nr_groups)
+		return -EINVAL;
+
+	if (selector >= pi->nr_functions)
+		return -EINVAL;
+
+	if (!pi->functions[selector].present) {
+		int ret;
+
+		ret = scmi_pinctrl_get_function_info(ph, selector,
+						     &pi->functions[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*groups = pi->functions[selector].groups;
+	*nr_groups = pi->functions[selector].nr_groups;
+
+	return 0;
+}
+
+static int scmi_pinctrl_mux_set(const struct scmi_protocol_handle *ph,
+				u32 selector, u32 group)
+{
+	return scmi_pinctrl_function_select(ph, group, GROUP_TYPE,
+					    selector);
+}
+
+static int scmi_pinctrl_get_pin_info(const struct scmi_protocol_handle *ph,
+				     u32 selector, struct scmi_pin_info *pin)
+{
+	int ret;
+
+	if (!pin)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_attributes(ph, PIN_TYPE, selector,
+				      pin->name, NULL);
+	if (ret)
+		return ret;
+
+	pin->present = true;
+	return 0;
+}
+
+static int scmi_pinctrl_get_pin_name(const struct scmi_protocol_handle *ph,
+				     u32 selector, const char **name)
+{
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+
+	if (!name)
+		return -EINVAL;
+
+	if (selector >= pi->nr_pins)
+		return -EINVAL;
+
+	if (!pi->pins[selector].present) {
+		int ret;
+
+		ret = scmi_pinctrl_get_pin_info(ph, selector,
+						&pi->pins[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*name = pi->pins[selector].name;
+
+	return 0;
+}
+
+static int scmi_pinctrl_name_get(const struct scmi_protocol_handle *ph,
+				 u32 selector,
+				 enum scmi_pinctrl_selector_type type,
+				 const char **name)
+{
+	switch (type) {
+	case PIN_TYPE:
+		return scmi_pinctrl_get_pin_name(ph, selector, name);
+	case GROUP_TYPE:
+		return scmi_pinctrl_get_group_name(ph, selector, name);
+	case FUNCTION_TYPE:
+		return scmi_pinctrl_get_function_name(ph, selector, name);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct scmi_pinctrl_proto_ops pinctrl_proto_ops = {
+	.count_get = scmi_pinctrl_count_get,
+	.name_get = scmi_pinctrl_name_get,
+	.group_pins_get = scmi_pinctrl_group_pins_get,
+	.function_groups_get = scmi_pinctrl_function_groups_get,
+	.mux_set = scmi_pinctrl_mux_set,
+	.config_get = scmi_pinctrl_config_get,
+	.config_get_all = scmi_pinctrl_config_get_all,
+	.config_set = scmi_pinctrl_config_set,
+	.pin_request = scmi_pinctrl_pin_request,
+	.pin_free = scmi_pinctrl_pin_free,
+};
+
+static int scmi_pinctrl_protocol_init(const struct scmi_protocol_handle *ph)
+{
+	int ret;
+	u32 version;
+	struct scmi_pinctrl_info *pinfo;
+
+	ret = ph->xops->version_get(ph, &version);
+	if (ret)
+		return ret;
+
+	dev_dbg(ph->dev, "Pinctrl Version %d.%d\n",
+		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
+
+	pinfo = devm_kzalloc(ph->dev, sizeof(*pinfo), GFP_KERNEL);
+	if (!pinfo)
+		return -ENOMEM;
+
+	ret = scmi_pinctrl_attributes_get(ph, pinfo);
+	if (ret)
+		return ret;
+
+	pinfo->pins = devm_kcalloc(ph->dev, pinfo->nr_pins,
+				   sizeof(*pinfo->pins),
+				   GFP_KERNEL);
+	if (!pinfo->pins)
+		return -ENOMEM;
+
+	pinfo->groups = devm_kcalloc(ph->dev, pinfo->nr_groups,
+				     sizeof(*pinfo->groups),
+				     GFP_KERNEL);
+	if (!pinfo->groups)
+		return -ENOMEM;
+
+	pinfo->functions = devm_kcalloc(ph->dev, pinfo->nr_functions,
+					sizeof(*pinfo->functions),
+					GFP_KERNEL);
+	if (!pinfo->functions)
+		return -ENOMEM;
+
+	pinfo->version = version;
+
+	return ph->set_priv(ph, pinfo, version);
+}
+
+static int scmi_pinctrl_protocol_deinit(const struct scmi_protocol_handle *ph)
+{
+	int i;
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+
+	for (i = 0; i < pi->nr_groups; i++) {
+		if (pi->groups[i].present) {
+			kfree(pi->groups[i].group_pins);
+			pi->groups[i].present = false;
+		}
+	}
+
+	for (i = 0; i < pi->nr_functions; i++) {
+		if (pi->functions[i].present) {
+			kfree(pi->functions[i].groups);
+			pi->functions[i].present = false;
+		}
+	}
+
+	return 0;
+}
+
+static const struct scmi_protocol scmi_pinctrl = {
+	.id = SCMI_PROTOCOL_PINCTRL,
+	.owner = THIS_MODULE,
+	.instance_init = &scmi_pinctrl_protocol_init,
+	.instance_deinit = &scmi_pinctrl_protocol_deinit,
+	.ops = &pinctrl_proto_ops,
+	.supported_version = SCMI_PROTOCOL_SUPPORTED_VERSION,
+};
+
+DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(pinctrl, scmi_pinctrl)
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index b5c65f26207b..996410962b91 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -348,6 +348,7 @@ void __exit scmi_##name##_unregister(void)			\
 DECLARE_SCMI_REGISTER_UNREGISTER(base);
 DECLARE_SCMI_REGISTER_UNREGISTER(clock);
 DECLARE_SCMI_REGISTER_UNREGISTER(perf);
+DECLARE_SCMI_REGISTER_UNREGISTER(pinctrl);
 DECLARE_SCMI_REGISTER_UNREGISTER(power);
 DECLARE_SCMI_REGISTER_UNREGISTER(reset);
 DECLARE_SCMI_REGISTER_UNREGISTER(sensors);
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index f2f05fb42d28..d8e2bb828ee7 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -717,6 +717,78 @@ struct scmi_powercap_proto_ops {
 					  u32 *power_thresh_high);
 };
 
+enum scmi_pinctrl_selector_type {
+	PIN_TYPE = 0,
+	GROUP_TYPE,
+	FUNCTION_TYPE,
+};
+
+/**
+ * struct scmi_pinctrl_proto_ops - represents the various operations provided
+ * by SCMI Pinctrl Protocol
+ *
+ * @count_get: returns count of the registered elements in given type
+ * @name_get: returns name by index of given type
+ * @group_pins_get: returns the set of pins, assigned to the specified group
+ * @function_groups_get: returns the set of groups, assigned to the specified
+ *	function
+ * @mux_set: set muxing function for groups of pins
+ * @config_get: returns configuration parameter for pin or group
+ * @config_set: sets the configuration parameter for pin or group
+ * @pin_request: aquire pin before selecting mux setting
+ * @pin_free: frees pin, acquired by request_pin call
+ */
+struct scmi_pinctrl_proto_ops {
+	int (*count_get)(const struct scmi_protocol_handle *ph,
+			 enum scmi_pinctrl_selector_type type);
+	int (*name_get)(const struct scmi_protocol_handle *ph, u32 selector,
+			enum scmi_pinctrl_selector_type type, const char **name);
+	int (*group_pins_get)(const struct scmi_protocol_handle *ph, u32 selector,
+			      const unsigned int **pins, unsigned int *nr_pins);
+	int (*function_groups_get)(const struct scmi_protocol_handle *ph, u32 selector,
+				   unsigned int *nr_groups, const unsigned int **groups);
+	int (*mux_set)(const struct scmi_protocol_handle *ph, u32 selector, u32 group);
+	int (*config_get)(const struct scmi_protocol_handle *ph, u32 selector,
+			  enum scmi_pinctrl_selector_type type,
+			  u8 config_type, u32 *config_value);
+	int (*config_get_all)(const struct scmi_protocol_handle *ph,
+			      u32 selector,
+			      enum scmi_pinctrl_selector_type type, u16 size,
+			      u8 *config_types, u32 *config_values);
+	int (*config_set)(const struct scmi_protocol_handle *ph, u32 selector,
+			  enum scmi_pinctrl_selector_type type,
+			  unsigned int nr_configs,
+			  u8 *config_type, u32 *config_value);
+	int (*pin_request)(const struct scmi_protocol_handle *ph, u32 pin);
+	int (*pin_free)(const struct scmi_protocol_handle *ph, u32 pin);
+};
+
+enum scmi_pinctrl_conf_type {
+	SCMI_PIN_NONE = 0x0,
+	SCMI_PIN_BIAS_BUS_HOLD = 0x1,
+	SCMI_PIN_BIAS_DISABLE = 0x2,
+	SCMI_PIN_BIAS_HIGH_IMPEDANCE = 0x3,
+	SCMI_PIN_BIAS_PULL_UP = 0x4,
+	SCMI_PIN_BIAS_PULL_DEFAULT = 0x5,
+	SCMI_PIN_BIAS_PULL_DOWN = 0x6,
+	SCMI_PIN_DRIVE_OPEN_DRAIN = 0x7,
+	SCMI_PIN_DRIVE_OPEN_SOURCE = 0x8,
+	SCMI_PIN_DRIVE_PUSH_PULL = 0x9,
+	SCMI_PIN_DRIVE_STRENGTH = 0xA,
+	SCMI_PIN_INPUT_DEBOUNCE = 0xB,
+	SCMI_PIN_INPUT_MODE = 0xC,
+	SCMI_PIN_PULL_MODE = 0xD,
+	SCMI_PIN_INPUT_VALUE = 0xE,
+	SCMI_PIN_INPUT_SCHMITT = 0xF,
+	SCMI_PIN_LOW_POWER_MODE = 0x10,
+	SCMI_PIN_OUTPUT_MODE = 0x11,
+	SCMI_PIN_OUTPUT_VALUE = 0x12,
+	SCMI_PIN_POWER_SOURCE = 0x13,
+	SCMI_PIN_SLEW_RATE = 0x20,
+	SCMI_PIN_OEM_START = 0xC0,
+	SCMI_PIN_OEM_END = 0xFF,
+};
+
 /**
  * struct scmi_notify_ops  - represents notifications' operations provided by
  * SCMI core
@@ -824,6 +896,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_RESET = 0x16,
 	SCMI_PROTOCOL_VOLTAGE = 0x17,
 	SCMI_PROTOCOL_POWERCAP = 0x18,
+	SCMI_PROTOCOL_PINCTRL = 0x19,
 };
 
 enum scmi_system_events {

-- 
2.37.1


