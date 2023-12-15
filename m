Return-Path: <linux-kernel+bounces-878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B45F814764
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4E528523C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AD82556A;
	Fri, 15 Dec 2023 11:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WQGGrouA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319142DB7D;
	Fri, 15 Dec 2023 11:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEQVQMfVfilFBoZB1zZBbYW4il0JJ6z3iRMPQgO6iNsKZeWF+dXRpFQUZCC2vSJXM4PcQ+nBBHVPl+EK2bHaSC4xILBZZXY/EZAC7N38kTXs58gvWMJAwAsnrWJr3Q1lYmozoITOb5I/ABfJRrRuAMDGcHlgJv1tIQIFMvH3wezwR7ZXyB9/BhFZfMow5CZssUeCioRcWpaF0WVpG1QRcOH8wO7PVQVQbe+vEpptZgE55H5SmBxnyT80ZKoknILbLrNbO76q3rQkhnBmtBEpgsvRQoBqSG2DcBZAW10WQFyFO/rVIyphwdfhqRew1IQaar0XNEdwQi6+6ns1xu3YUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hvCTZQ34ARoTcAEb9gi2pms+orD3tP1pF3608JG7T8=;
 b=ghlnCd+N1B5F3Au+1/lhvI1jv6Er1bfirTGoQPr9LVVQPlFrmt3JARxQQVkADixS2I7112eORTiaMaovreTDMwgdxHcOIs6JQa2PCWxcOU8yl0nJ5bCCNP1NeCpDhqKclMWgaaeYePK7L9/DU29gKGfvbG0HRWrAqLse70vpnh2bYU082tJ3kpInoN9338njRyD6Ry2LA7hYxttZwhEsMyKwsRCYgwQ5JSuZRSzuXnM/1wKuW95A1A7ir8J2iYI1fJDgweIHOveFVJZv8Qnm46tEUHhV39mE3I4Ioi9iWsNNDpq98mheDdhX/s8eXXR01j43qf+ZOvwTeDj+Ysu46A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hvCTZQ34ARoTcAEb9gi2pms+orD3tP1pF3608JG7T8=;
 b=WQGGrouA/3s0Z9BiiQPB1qgzdb5fP36V5LF5t9lguXKZ5aBiDflCjRUKYOVOk0PSsSnOch+UDqJoA1btjg+GY8hhZmpOXfSjj3S3j4fmEnON86C4SNCOMEe8xpipYRVqU7GHnvpnPfdEgObgsXUiuUsjMazFPm6/ZJ2hPHOyZjI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7435.eurprd04.prod.outlook.com (2603:10a6:102:88::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 11:52:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3%7]) with mapi id 15.20.7046.015; Fri, 15 Dec 2023
 11:52:37 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 15 Dec 2023 19:56:33 +0800
Subject: [PATCH 5/7] firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol
 basic support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-pinctrl-scmi-v1-5-0fe35e4611f7@nxp.com>
References: <20231215-pinctrl-scmi-v1-0-0fe35e4611f7@nxp.com>
In-Reply-To: <20231215-pinctrl-scmi-v1-0-0fe35e4611f7@nxp.com>
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
 Peng Fan <peng.fan@nxp.com>, Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702641405; l=29494;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=+gcG9Afq0RuArFK++pu1kDCyeXltNy5uUPVCQqMnVe0=;
 b=0ZMN9Dkh265Bu7IgYx6YM6gbRAKMTgP92o/dWh4Jdx0btNolsg5x9LP8C31DfMFy422X6DN4i
 EGX55OXaOQyAfXvUfNHuLd9IcNPqps3+E0iBH+iT7VoCsAT2HkW4LUG
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:4:188::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PR3PR04MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c601f7-3a14-4b60-2e14-08dbfd645584
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7frURO0flVLkKuQ1IzFH8LX1lWsgE6BeMRcYclxh/vhUrMno0/oeG5VmZN3Z9zO+apzzwTBac3yp95y7XNvhRxM6x8A/EPdC2HZAT+mXxgRc/ELfy6ng0Cur9rLDQwyANWuUeYPhGxTh48GrNxm8SKBl6DFzBk1ou3YCtCsq3PampupUwiZNFiWthQCnJHtWfLVq9fps+7SazmoYINv7f2CfaIPuRDKGdZvhqzjX9U141hX79/KB/zkRuWfwJ9POTn1HOrf3tat53OdWK1mcNPSZik2g4nCeuhGAaBJag8bngZCVyp7g7P0bfsrPwu3GldRJKYQGm6sqOTT7zfserau7nRmArtUNte1BOahzSOL4G4JYKLpDzlBxED+JaW2fGiUtIITxoenmMWGHvQQuv+Hxq9HjYRbnZfQIVLIom9a1vsIGsZA6zYMf2weumhGUm+sp9RNtcMiAEI9XylQnjlwoEntagJIccKkMGxHWbifLj3RkdXu/VEcoWEV/UAZpeI4bdQsmB1msve56c753xUH5ttORB1XSkxNZEaOayQl3dxsOzUxm334BE0lstwiEL/XRczvW7nsrwbA9CCQvG93SPQS4MzJlCXsynsNVaD5qfA3+gqXawF5JR3vWQXWJgMDOq8Z+An2+ksHCB+ZjEA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(30864003)(86362001)(4326008)(8676002)(8936002)(5660300002)(7416002)(921008)(38350700005)(41300700001)(36756003)(478600001)(6486002)(83380400001)(26005)(6512007)(9686003)(6666004)(52116002)(6506007)(110136005)(66946007)(38100700002)(54906003)(66556008)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yzc1UmdaZ0JPQmRLU3ZndGVKUVdCNDc2S3l1aUlFRWR1VFBXRWpEemRMdVBh?=
 =?utf-8?B?aHNYc0lhaWIwWlBvU3E5OEpBR05FQ0F6N2RJVGpwdVk0c1dJNnljMnl1OEl5?=
 =?utf-8?B?Tk9IT3BiM3RpUWYvZ2x0aHhqTUJUZWF5eTYxNWtPa3BxUEgrOVZhZWtYRjEr?=
 =?utf-8?B?alFqRWJLRlpmN3V6RGJVSkYvYUlCaXQrMjUxeThOamw0OUJMQVMwOGpsL2xh?=
 =?utf-8?B?a2NYbUxsM0Q0RmFpbko2UzdrMHJKRjMwK0x3UEQySnZkZmdwN3dOUkJjdXNh?=
 =?utf-8?B?bi93V0p1M3FyMFRIeUJmRTVQOWNKZWp1VWYwa3lXVlNUbnRjZERRVFJoYW5a?=
 =?utf-8?B?OTZwQ3ZSTERHb0VIcFZtYXYycS9XYU1vcHJIdzZWd3U5YTVCNExZQndFYlR2?=
 =?utf-8?B?TVFYZ3pxM0J1R2RRM01YOVkyWHpRTE5QVzZ3cHZadXBtL01Jd3k2emFmYXFN?=
 =?utf-8?B?WElzWUdLM3BJc0IwSTVWWGJtTkYvNm0waFdQZnV4Zi9GcFNiQXNrTG5meEZu?=
 =?utf-8?B?eHdHWlFQSzNsc0UxbWR0RGo0bTdEYVZYYmNqK0dua0FSVHB6a0Q5eVo2NkNh?=
 =?utf-8?B?R0t5Zk13UmpFMWFQdTRYN2JRZmtVMUw0RzJnaUl3aUpiTDZaak9FMS9VMkkz?=
 =?utf-8?B?V0JVS25yUHRsRFNhazJWZGNDL2pCMXRkd2N2M2JRZVJjcnMxeEZ1aG1hQ2xs?=
 =?utf-8?B?b2hXK0psMmRTaDlHMDlGNlZIMWVvZFhLbGdneHJFbmhoRFByQmx3OHQ5azFL?=
 =?utf-8?B?KzNUbnZVU256YlliblJROWJQYjRPMFJrY3RPR0pIRExwRUJjTGpCZThWaCsz?=
 =?utf-8?B?YVRWVmFtU0QvZjlodTNYRXB2ampOWDlibmtkblVMVnhSMjF0WmRPR05ybCtZ?=
 =?utf-8?B?UmtHd0dLazI2TUR3b2orUndQMitwUGlidU85WlBZUk95S3UrMWwveWJhT0xD?=
 =?utf-8?B?dE1LUVM4V3QxR1FYUHRJUysrL1BzRzQzeEdzYzJTT1NxN0oxdVJKdkgyeXBV?=
 =?utf-8?B?cGFudXN2eWZUM3lhT2lhbjY0SUJTMTA0REViV1FYdDhSc3FrNXdFNUV5Y3Vm?=
 =?utf-8?B?Y1BHLzd2dmVaYlhtQ3JHaVkwTTcvT2N4dHZJeDB2K3dwR1kwb3ZZd0psR1h6?=
 =?utf-8?B?VThySUkrUk5PbkhqNXUrM2I4ZWFEZ2l4N2VuWHhRb1lySCtCYi84VXZYMXNw?=
 =?utf-8?B?RGE0RUlodXNGK1FCZ2xBVE9WM0JLNzRtQy95VWtNRWNOc3RXdUtGUVkvV3Fy?=
 =?utf-8?B?L2k2M3VxM1JRKy8vc0hoTE11UEFydG12OWVEeURnSlJiclZqMm5VOGVxdjNs?=
 =?utf-8?B?NmdyclNRbHp2WFF4VnpicnArcVhJU0RDMk5YS1dWc01DZGNIQ1ZkRFg1Kzd3?=
 =?utf-8?B?VWRBV3lJT1dnZ0ZVUnQ4T0ltaysybUs5M3NxUk1odjhnbTcxMHBaQXlGYlU3?=
 =?utf-8?B?dWg1cVZTSjVRb3V1aXl3Q2FGQVFRbWUvcEMrSzAvK2RiT0czY0E3VmpjckJi?=
 =?utf-8?B?UHljbDQ4WXU1OTVGQllJTkVjS0JpQkhnZUNDTXJEMFArVDY0dHFoS05obDg5?=
 =?utf-8?B?cGc2dmthaVc3S2UxRmRGVUREV3g3L0M4ODNoaVdzamkwTXcweUhOblhFNVUr?=
 =?utf-8?B?SjZSSUp2TlBsaitUdDFCcitGYngwK1B6bTNwL3owNjhHQ2tRM2tEQ2JjYWZp?=
 =?utf-8?B?YUsyL3NNOFY5bkNpZ1h0SjY0d1lNZ0Z6R01FeXJxbzlQWGZEMEJ1TnBOL3Yy?=
 =?utf-8?B?N2RkYWcvREtOb1VPK0doRklqSFRGUkNSRytEb3VJb0RWSHdSZmozbkpPS2R2?=
 =?utf-8?B?cU1WcEZMRjl3eEc3MjkrbXgzS240NG5OcXRTYmpxSTJEL29NOXNkdWcwc011?=
 =?utf-8?B?S01tSkFld3pRYzNKd2xDOXBoRzh0MFl3NDByTzJYVXU1dlJvUElKU0NxQmd2?=
 =?utf-8?B?ZGd5Und1ZFFZT1QvZEtFWkRqUWhsUjk1VEtnUGswZGFwSXFMMjZYNWRRUFoy?=
 =?utf-8?B?TUU3azRJbXExa1FwZFJmbDR3YUJwOXdTOXF4QlRzUGRSQU9sWmZwMzUrVHZT?=
 =?utf-8?B?NXVkUmlVSC9teG5FS1JLUk1ydE9yTFBuS1dFSU9BV3dmZ0ZNY1JBRG9ITnRw?=
 =?utf-8?Q?E9VPcRTp7gw7ALCzSpPN1Y0FI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c601f7-3a14-4b60-2e14-08dbfd645584
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 11:52:37.7767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBEsn28xk1R7A//DwG7rBEh4nIvSlz/s/7rvXifv5/P2ITFKnoC/oARKgIk0ZrooRz/KeKK7dUT0AiSLsTIuJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7435

From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>

Add basic implementation of the SCMI v3.2 pincontrol protocol.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Co-developed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 MAINTAINERS                           |   6 +
 drivers/firmware/arm_scmi/Makefile    |   1 +
 drivers/firmware/arm_scmi/driver.c    |   2 +
 drivers/firmware/arm_scmi/pinctrl.c   | 927 ++++++++++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/protocols.h |   1 +
 include/linux/scmi_protocol.h         |  46 ++
 6 files changed, 983 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b589218605b4..8d971adeee22 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21180,6 +21180,12 @@ F:	include/linux/sc[mp]i_protocol.h
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
index 3174da57d832..1cf9f5d4f7bd 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -3057,6 +3057,7 @@ static int __init scmi_driver_init(void)
 	scmi_voltage_register();
 	scmi_system_register();
 	scmi_powercap_register();
+	scmi_pinctrl_register();
 
 	return platform_driver_register(&scmi_driver);
 }
@@ -3074,6 +3075,7 @@ static void __exit scmi_driver_exit(void)
 	scmi_voltage_unregister();
 	scmi_system_unregister();
 	scmi_powercap_unregister();
+	scmi_pinctrl_unregister();
 
 	scmi_transports_exit();
 
diff --git a/drivers/firmware/arm_scmi/pinctrl.c b/drivers/firmware/arm_scmi/pinctrl.c
new file mode 100644
index 000000000000..a25c8edcedd2
--- /dev/null
+++ b/drivers/firmware/arm_scmi/pinctrl.c
@@ -0,0 +1,927 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Management Interface (SCMI) Pinctrl Protocol
+ *
+ * Copyright (C) 2023 EPAM
+ */
+
+#include <linux/module.h>
+#include <linux/pinctrl/pinconf-generic.h>
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
+	unsigned long *config_values;
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
+	msg->identifier = cpu_to_le32(p->selector);
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
+
+	st->num_returned = le32_get_bits(r->num_configs, GENMASK(7, 0));
+	st->num_remaining = le32_get_bits(r->num_configs, GENMASK(31, 24));
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
+				   u8 config_type, unsigned long *config_value)
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
+				       unsigned long *config_values)
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
+				   u32 selector,
+				   enum scmi_pinctrl_selector_type type,
+				   unsigned long *configs, unsigned int nr_configs)
+{
+	struct scmi_xfer *t;
+	struct scmi_msg_conf_set *tx;
+	u32 attributes;
+	int ret, i;
+	unsigned int configs_in_chunk, conf_num = 0;
+	unsigned int chunk;
+	int max_msg_size = ph->hops->get_max_msg_size(ph);
+
+	if (!configs || type == FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	configs_in_chunk = (max_msg_size - sizeof(*tx)) / (sizeof(unsigned long) * 2);
+	while (conf_num < nr_configs) {
+		chunk = (nr_configs - conf_num > configs_in_chunk) ? configs_in_chunk :
+			nr_configs - conf_num;
+
+		ret = ph->xops->xfer_get_init(ph, PINCTRL_CONFIG_SET,
+					      sizeof(*tx) + chunk * 2 * sizeof(unsigned long),
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
+			tx->configs[i * 2] = cpu_to_le32(pinconf_to_config_param(configs[i]));
+			tx->configs[i * 2 + 1] =
+				cpu_to_le32(pinconf_to_config_argument(configs[i]));
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
index 08de8dc064c1..e30f91ce53c8 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -347,6 +347,7 @@ void __exit scmi_##name##_unregister(void)			\
 DECLARE_SCMI_REGISTER_UNREGISTER(base);
 DECLARE_SCMI_REGISTER_UNREGISTER(clock);
 DECLARE_SCMI_REGISTER_UNREGISTER(perf);
+DECLARE_SCMI_REGISTER_UNREGISTER(pinctrl);
 DECLARE_SCMI_REGISTER_UNREGISTER(power);
 DECLARE_SCMI_REGISTER_UNREGISTER(reset);
 DECLARE_SCMI_REGISTER_UNREGISTER(sensors);
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 19a06b872afe..516c98252732 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -717,6 +717,51 @@ struct scmi_powercap_proto_ops {
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
+			  u8 config_type, unsigned long *config_value);
+	int (*config_get_all)(const struct scmi_protocol_handle *ph,
+			      u32 selector,
+			      enum scmi_pinctrl_selector_type type, u16 size,
+			      u8 *config_types, unsigned long *config_values);
+	int (*config_set)(const struct scmi_protocol_handle *ph, u32 selector,
+			  enum scmi_pinctrl_selector_type type,
+			  unsigned long *configs, unsigned int nr_configs);
+	int (*pin_request)(const struct scmi_protocol_handle *ph, u32 pin);
+	int (*pin_free)(const struct scmi_protocol_handle *ph, u32 pin);
+};
+
 /**
  * struct scmi_notify_ops  - represents notifications' operations provided by
  * SCMI core
@@ -824,6 +869,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_RESET = 0x16,
 	SCMI_PROTOCOL_VOLTAGE = 0x17,
 	SCMI_PROTOCOL_POWERCAP = 0x18,
+	SCMI_PROTOCOL_PINCTRL = 0x19,
 };
 
 enum scmi_system_events {

-- 
2.37.1


