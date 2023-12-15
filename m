Return-Path: <linux-kernel+bounces-875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1A381475A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B2F5B22042
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277032C863;
	Fri, 15 Dec 2023 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BYXqA111"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDB32C68F;
	Fri, 15 Dec 2023 11:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5garSyRhuQpbG2urg1VHWQErCyzfN7XmM+HTc9eJI1QC01IgbIFNhKmU+ln7Bs58eo42TTGl1DmM/Y3Af7yhvD7u0nNd7kEf3WafSRrs78uPQ5GfVljb9mOuCRtoavzeJ2LMwbZL1GlsZ8UHOzV36b5w28BaOEtIiT7zmLXuZj1QMphAarSraQwOAY++mYyFXDBdK4aShghGukS6cYkpwrDmz7BWeYoeJlkgAm7vVYYfqNzwYRbdRnKmFcEP8Zt1W/ACziU+0uQw/z4HZKcCKRGrkhovnoRsId8DQ0WDCEqCryL3I1xADPN5qbTKalv8FjcMlJnvf0De4qB88Xzyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ttjgFeI5wJugBEIpLxKg6PFf4dnpcoUQA3Zo/09ZCs=;
 b=N/HGGEHiTUroWhTuK5Is5Z3sncaL6h/QZbtwLAJ9s3h4k/UjIh1voQaPmZx6ro+FFIWITk8wsjqBhmvIJ11Sr+24Wn2c1snA3UVOCPu+fBgcW4/GSIjipb7mO3rZno3pjvnFnl/oOwT+NZZqml1Y/MG1dpqiU3UucjbPhvBswjwRy5V+WcRH7uiemiiFwyw0yDbh1tu+lfgKlRDTIOz4380FFJcO+aYd6D54hViDKjG3Z98eams6HWu2xqauo04qxjuFdRuwWdjEAMzu4os29t/058QhK85oh17MJ4Cd0B5Jigpe2Rk0azBynNpaCjbrI0UFpryqL6Si4/EHpv1cqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ttjgFeI5wJugBEIpLxKg6PFf4dnpcoUQA3Zo/09ZCs=;
 b=BYXqA1119WFfFkcsTDOCJCdpMVvD3/KpcqBJYx604WKj8EoJk9tXI/doJlnB6fvedtcoAaWf/3yQex/g+6uSbw1MK+fhDuxDijsfFpDyr3gu9+n/Q/Naos396+OjTgwSYLXxVoy93anj3wu+Cysf1xi+NCwmpP9zLso161usQng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7435.eurprd04.prod.outlook.com (2603:10a6:102:88::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 11:52:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3%7]) with mapi id 15.20.7046.015; Fri, 15 Dec 2023
 11:52:22 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 15 Dec 2023 19:56:30 +0800
Subject: [PATCH 2/7] firmware: scmi: support compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-pinctrl-scmi-v1-2-0fe35e4611f7@nxp.com>
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
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702641405; l=8215;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=octm0BA3uvc+p2ruS1Kv1VgICMJ0bEcK+On781/jDL4=;
 b=lmqXh2KUy/q9rVerANBN9wkNsOj0vSX5kfJ+J8WGmjEIqsADCuSMRHl4xtv/x7xzw3DQ7NC68
 EILWd7AEo2lDKZpJRq8Fgc0sH8MoxWDYDn+/09U7YsyQcpO0eeZSCuo
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
X-MS-Office365-Filtering-Correlation-Id: f53e9504-8d76-4c42-562f-08dbfd644c17
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Sx2Te6BOp6rRf2ivKBY4J7rvWBmt1uPtk2XR+a4NlIc35jek1uy4T9LnLPjicLyQTdAKxrg5aQp9iZLUKj1UZmk8dgl614TzcijjFmgLhbn9euRg87zkWHrx+6QY4pbfuJyaSzHojE2X34CudRDCcl4CWmqNQnuQcvqPBPvcbjouQevGNhqdje33ak7YLp7bq/RHCKGPb213rO7H+CaYbyKZEBXLjOe3zqudrWvnBEB8TQksmnsiU5R8hnlpbOgYBdn+NkUPlCDP+/HV3J0gdlSE9cI/uMcxi/NAZsyfztsvzS6G45SWgB31LJnTC3QF3Tyco8oOMo4jpUjJsFj6w9xvEI7fpuP6J8tU3zDLMtFES36NRr3xPf7UKvyMFokpiWrc4gU92aTlVDO23hPkW+cOTWGAz7UQx6s9mF9ZT8B6oFY/gw4T6pjth5fbDh3T9O3c87kE9QR1u3aFMYQCcaPYPad6qtVuWhyCTmgp3sRS6v8paXSNp6amcjSRS+KCemCwtREc0BMUBMsIK+7uWD04VuYLXtlU+xdaQGzzX4l93YBAfui8oiD8OsE9CCQcc84hRXocchmdLbxCp9UBANGOlr8CnGv7Bss5aYjoU1yCPiK78Oa3UtjH6wxUBFelqtoRTsN9TAAXbFK48x1YtQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(86362001)(4326008)(8676002)(8936002)(5660300002)(7416002)(921008)(38350700005)(41300700001)(36756003)(478600001)(6486002)(83380400001)(26005)(6512007)(9686003)(6666004)(52116002)(6506007)(110136005)(66946007)(38100700002)(66556008)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXRmbVNkRmtyV1NCclF1UzFYNGhSUWJJblE2OHJPYUlRNFBwMkhYUUVmbnAx?=
 =?utf-8?B?VWhUSkFzMG00UVh2cDBYeklmUWVhTnB5cjM5RlJwYnhyUThCblRLN096cWE5?=
 =?utf-8?B?MTdmMlFKekRWREhuOUtVY2V1NlZVbHlTN0d4MFpjTEc4b04zVjMxZzdPZC9O?=
 =?utf-8?B?cmovMjlpMzBCUmh1dVcrUmpkdTZ4b1VQRzFjRWlEdVF0L085bkJWZ1F6c3V0?=
 =?utf-8?B?RlI1RWtZamY3NXAvcFFxQVZwZ09Wc215NWZKb1BidkFtK1ZjYk1POUJGc0Jt?=
 =?utf-8?B?WUplZlF6WGcxR284SDRWZVdlTFFPdzM3MFgvaWlKSVNZanJ4eGdSem5VQmpv?=
 =?utf-8?B?SzV5bHFsZnR3c1RuSm1sSFpURFFyNGNheDJTMGxoRFZwV1JRckI3bFlma2JR?=
 =?utf-8?B?aHNkOG0zT3E4RWVidC9aUVRja29kN2ZFUENrWllGTlFRTzJvRjlYbWM1aXVS?=
 =?utf-8?B?eCtQc1d5a1hBcStCWFB1aDRoVk03L3h0SlhPdXZLR1lyV2I3RjluTW9haTBI?=
 =?utf-8?B?WUZiTmZXc0xBd2Y0REVGa2RVK2tIM0JvT2thKzZvajBrb01BektwQTNYT2FX?=
 =?utf-8?B?VmM2VUpCNUdpWHVScHBqeW5DdXBCRGkxQXlJbytPMXU1bk0vSkl2ZjI4TThC?=
 =?utf-8?B?YXVJTEYxS1FlY3NObFVJOFd3NFNaZUVPRWM3bHVlSWtNWkRlSzlrSkdnWEQy?=
 =?utf-8?B?UCswSExPcEhYb3ExUWFaVHNxc2xsT1YvOWRNSVFySEhCNkVoQjdISjYzb0Zz?=
 =?utf-8?B?VmJZQUwrTVorSHZCdHBpWVJEVVNvM1JJcTM2bUthRSszNEZMU3VRdXByK3l3?=
 =?utf-8?B?bWlTdEdSdmcvOUtONlo4OUI1Nmx2UlRZbzhVOG01VzVBWjZ4alVVTnRrajY2?=
 =?utf-8?B?VHRnT1QvN1dtQ3VOSEZVK1FwblRmblQ1MjY0Y2JXaVpTU2xYTWx4S1BGV2ll?=
 =?utf-8?B?eVRnNTdWYmJxdndPQ2dYOWlEdmZUK2FkMGgwUmI1NkdGV0twTm1mWVZJMUpz?=
 =?utf-8?B?Z0M3aEpmMkxwVHlhSzJPUklOOFczVlc4Sk81SXFKdC9zaWFVRUIyV2Q3aitv?=
 =?utf-8?B?WDd0S2R5ZXl0UHFzQzVmeTdXM1Q4eWlxNTdTNFNBZjJTUHNPdjl0MG9vb0ty?=
 =?utf-8?B?enQ5aC9GMDZ3aGtkNlZtUEl3Znl1NWU1MzN2b2VEYUJqK2s5OHVXQXZqZ1Yz?=
 =?utf-8?B?em5kcDJwcmpzaVhjaGJWUS92bmVJTElMeGllZkIzNDBkdmVXZ0gxL1VoNUNV?=
 =?utf-8?B?SHFIVmpIK0F4bmJ0aitva0JkRitQMUlqSnRZS29pdFVGVDdtcmtadXZUanhp?=
 =?utf-8?B?QThmOXdFdGpGMVJ3Y1JxZ1NaeUpLTWlwd1ZuL0g0N2dCYmh0QUJwdk4rbjBo?=
 =?utf-8?B?VitQRGFOR1l5V1JGcE40WTVjelpCRUVOSFo5dDFVbGZuNDR2TWxzeEQ5dzA2?=
 =?utf-8?B?bXE5RU1mdEFjbVAwaUJhRjI5TlB1d3dKTm1qdXIzTHZ2MGlHTGNnbTlVaXFQ?=
 =?utf-8?B?OFRYUEdKTGRVaGdVTnExbmw5em5jbFZtTHNVV3NlWEtGQ3l1aFpreVd1Wldl?=
 =?utf-8?B?QkNhOXNta0JUbVV0V2Q3NGZZeVJYVlF4TnArK2RwbkxYR2VpK3I0NjhLUVV5?=
 =?utf-8?B?MTQzTnQ1Szd0ZWc5QzIxTTYrM2F4dFJzUkJnTWVUZk9ldmlKSTUvWEYycVNz?=
 =?utf-8?B?bm5EODdUVEExM010aHVFL0l4K2FmUklWMWNpV1FhTjZrSlJFbnBtQnE3U3Bh?=
 =?utf-8?B?dHF0SUdCdTJ3K0RHa0VNNFlHVWJzdDk0cUVnck5EUFRzOHM5NHRTVmJ6UXVq?=
 =?utf-8?B?RmpQRUFmdEg1WTFiK3FhZGFXL0ZsNW5NcEdXSldHT3RQcWxkN2tzeFJJejQ3?=
 =?utf-8?B?Tk03Um5sTkk0bXhoVTgyeEpJeFNTQ3N0Q0poV09OVHgwZGNOVzFwNXNDYmFH?=
 =?utf-8?B?SmRRYlJueE1yMlNqWFdScER5SEdIN1MyNUhkdldDTXhMY09ydXFObVJwUTZp?=
 =?utf-8?B?M0lHdm9DbU1BYUdyOFpFOXJNL3FjKzMrRmhCdTR4WVp0dTMxWE9CcWpiQUtn?=
 =?utf-8?B?d3FINjliTDVTcS8zcU5mZDk4RXpYNm96WDBMb3o4cXUrTSs5VlhmWk5yVmtR?=
 =?utf-8?Q?0gW2eGCaPKMlVW2/NvADk4ABG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f53e9504-8d76-4c42-562f-08dbfd644c17
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 11:52:21.9609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEmKK58xLoBU4lUE+TSssEgBE/p4cKq40r2a7Snhq1JA2FNAEu1DMbkykvBNYc155M/9cYbUYgF8jGkY54hlTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7435

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
index c15928b8c5cc..c999edd18cd3 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -194,13 +194,21 @@ scmi_dev_match_id(struct scmi_device *scmi_dev, struct scmi_driver *scmi_drv)
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
@@ -325,11 +333,14 @@ static void __scmi_device_destroy(struct scmi_device *scmi_dev)
 
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
@@ -405,6 +416,7 @@ __scmi_device_create(struct device_node *np, struct device *parent,
  * @name: The requested-name of the device to be created; this is optional
  *	  and if no @name is provided, all the devices currently known to
  *	  be requested on the SCMI bus for @protocol will be created.
+ * @compatible: The compatible string
  *
  * This method can be invoked to create a single well-defined device (like
  * a transport device or a device requested by an SCMI driver loaded after
@@ -421,14 +433,14 @@ __scmi_device_create(struct device_node *np, struct device *parent,
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
@@ -442,9 +454,20 @@ struct scmi_device *scmi_device_create(struct device_node *np,
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
index c46dc5215af7..930a24e0d712 100644
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
index b4f8f190351b..3174da57d832 100644
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
index f2f05fb42d28..19a06b872afe 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -839,6 +839,7 @@ struct scmi_device {
 	u32 id;
 	u8 protocol_id;
 	const char *name;
+	const char *compatible; /* Optional */
 	struct device dev;
 	struct scmi_handle *handle;
 };
@@ -848,6 +849,7 @@ struct scmi_device {
 struct scmi_device_id {
 	u8 protocol_id;
 	const char *name;
+	const char *compatible; /* Optional */
 };
 
 struct scmi_driver {

-- 
2.37.1


