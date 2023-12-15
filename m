Return-Path: <linux-kernel+bounces-873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874F9814753
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4691C232E1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDC325106;
	Fri, 15 Dec 2023 11:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VPowCvnC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2043.outbound.protection.outlook.com [40.107.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8C62556D;
	Fri, 15 Dec 2023 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyyDpilbRxjdrSMI8aS7OLGe055Ax9yinjmQcKjQHRPpctdEYfa1FRdO4dp01DRMCOV8ESAuSy4y/IHznzbKFgkwFxb3Df49S8Rgdl324NzAsfnX5ra9+b0TAC3bHQ8LX4aMuPo8a8N94FXgwFAnAWThqirNWYnAnwdOFpulV5sk1m2a4ksYHRtLZdG5ab2JdFj+16khRYs5zW0Uo8nWdeI/yq1MrFTZVqBAQhRTmwbKXR9DoRUm68pq9TZrJ8NNV+NlBnaBkZA/yRp5cOA9AI0J5bSYdgMBupa4zJSj4ljt9IjaldeDLebhrhjjH15oK5dSnDHfNozemU4O1dKCJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WArr+GKRwQhChos07cYAns1GrsifHS9XSM2OK3y6H3k=;
 b=miLN5fpyvaPthZJFvmRbPRjqvW+TkA9jjyIsPLt1BKGqNUB877EsppEOUv8KjgNZwmCVZ4eQ+OpJCeyeNIb6PyrB35x2udyS8EzJVkmaU692BUq6BG58s/i0zPDXM+R/iPu95akXWFDWQuD66pNrr6RVoMcJc39BIFp4yDLlm9kzlG3J2S2lQG9uupex7qTvaQ1/qA5mXBc3NjWNVFGrvs7steFqWIa/K7uPH3W4LnmBYyVKYF/0LqqqttvJ9ygxKW1hLeMu0N7NmCslFWxEise+ERUK4J0nqih9kM34OhztfnaKfS5/Ch4xuAYkujYpusnyJgIaOKarwlxeBnCyWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WArr+GKRwQhChos07cYAns1GrsifHS9XSM2OK3y6H3k=;
 b=VPowCvnCKW1bxscHQeR5/STvOiTXNolU+TuQzcBbCXaXNyt2yKkigC9DABXe6rKZa+7/XjePNfNw66tBRq93FiHbmtPVDqB6RaQ97VmODfN6saUZN3a2U0FWevmVLC5KKrgsyGeYDy/1oSUVQqjxNWWV7fGshdZq35qjEldp9v4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8328.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 11:52:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3%7]) with mapi id 15.20.7046.015; Fri, 15 Dec 2023
 11:52:11 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/7] firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol
 basic support
Date: Fri, 15 Dec 2023 19:56:28 +0800
Message-Id: <20231215-pinctrl-scmi-v1-0-0fe35e4611f7@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOw+fGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDI0NT3YLMvOSSohzd4uTcTF2TZNMkA2NzkzSTZDMloJaCotS0zAqwcdG
 xtbUAccJ9zV4AAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702641405; l=3586;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=pAWpJqoFFqdLHmTGmRObVjm8YL8FM1jb885qED/nIkY=;
 b=8ORGIt0vTFeWVNkuecJ0l/NRu0E/eiwQj4VeBf2nC0w0f6lXXUPZIxa0GP70CdtUhyEWtKj+P
 dbdcerFku4gC7W7KYOYdts7u6rpeYsqX6P51PD7/H0cYv6wgfVTF3it
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: f83daa0b-e9e3-49dc-983a-08dbfd6445cb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6aGDvcuY6cwneWEcsx87uBi0gDl30XSVZFZ58COwImRgH6D8iAXJOGdOnAObTAdf7vLTLC8LB7+Wo7E7eEhya8miLaYbNZlZflaxkTfsL/tEfvNIpt5bgIoBods1CoyT6limGdKeSXkAWJ/3wnkx/TV+yIFNEACLWdP4rU+bFm7Q3REtYPxiGvlVu7qioyNeP6Df3NbCqb8hVHDyWv/02W58deduDIXOz8tig2CR3mqpJEbxHKHyNd8XoUafePtVKzAQqipySLQPfDTjRMSO54UhDaPadTARl+SMovp6jIuybcB5UEZ8ExzMaak4iEs2UPuDEO4aU9b5HRjXhlWIIpwajKMqUMPlgUARbpjMhvyzTVt8rh7H+SGz1GPzG3zoBQQMaZaiBAhn919Gns1Jm/AiJAJYScVFni4l4fzSHR+Rys1A5deKNlE/BLBvR8CRt3xMZWosIL8LydhwgZW6brHQIJ8QbSg0mlMZvve7CtSV8FhVHlfbvVZ/JlDIiDzF/VPHkUCfCpU60MhLntwpz/ZopqwkKsSJJmJ0PAtYeQyiBsHzAEGFth19jr/ftEPxIp6zsEIHND8gSCe5v+q73/J9XpjYb29aD8q9QenFmzBzHyBGtoQeybq2YRdDSjBV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(4326008)(8936002)(8676002)(4001150100001)(2906002)(7416002)(5660300002)(478600001)(6506007)(6512007)(6666004)(9686003)(52116002)(110136005)(54906003)(66476007)(66556008)(66946007)(316002)(966005)(6486002)(41300700001)(38100700002)(86362001)(36756003)(921008)(38350700005)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjJPUXBoQ2wwcmFkYlNJSDFwdGFDbWxURDZiTGJCbkp2V3FQRStHVTdKWG1j?=
 =?utf-8?B?bG9zaVNuRHlzcmFyeDN6QlhBOGErVWhiME5iUlA3RC9yWWJzdUorcGExZzVQ?=
 =?utf-8?B?OVF2SWkyTWhPc0xxUjhtbzd2ZVB0eVZ0K1VPekxKRkZuUHdiYjZCeGVIN29n?=
 =?utf-8?B?c0FhVGxEN2NSMFRYSmxEMWNyOEEwQ3lvVHdRYmlSUU9hWForZFZ6d3pNQkQy?=
 =?utf-8?B?aWU3UUVFcFJUUm83WTRRMUFWaWd5ZFkrTTJiclc1U2JjRFdOVEdFM0VEcC9m?=
 =?utf-8?B?U2ZSS21zOXIzRWs3Q3lsQ0lVQ01HOS82Q1JuRGtNSUMzK0pVeDJuV0lJQVRG?=
 =?utf-8?B?aFBwM3NjelRNNXZXdlI5dmsvN3JzSTR4b2hEdzhIZFFtQk9oR1c2cXVOSVN2?=
 =?utf-8?B?c2pLL3BlTGlVcjd2b3lDbU1zcWh3Y255MlJSWGJTRENQckZLRkVJbXhuMlRC?=
 =?utf-8?B?c3N6akxFTDA1N20xZzBWNnFNNXdOTG9DSEJUZVUzbXhRbjdnTWxtMUtSTHBB?=
 =?utf-8?B?RjdsRnhwUnZSeFIzWXk2cVRvUElzL0ttRWcvMkUweW1ZM1J5ZE5GZkRrdjhQ?=
 =?utf-8?B?d2NvU09FQlBUSjVYNEc0ZCtOWWRKUHJ5Y09LY2JqUWtmUy9DbDY1aG8wRWRR?=
 =?utf-8?B?aGg0MU9WRVQxMitZQTRYNmpFV3BzK1YvS0tXY3paN21LcjBiZ3dkT3VLVUNJ?=
 =?utf-8?B?UmwrOUs3ckZFc3RvL1RGUVFRWXlPYzFTZmJGc2ZkRm5yeU1nQXhQM1JXUFRY?=
 =?utf-8?B?cVplZTNBZmp3WHFaNGo2cXZIZWpFb0xZNFUvMDh2YXluS3ovaWVYN0YvZEpM?=
 =?utf-8?B?VzRjQmJlYkpHYmRySVdDU1ZKUGF5REZYMThxTE5rVGFYcGVLOGFzMTN6dUVN?=
 =?utf-8?B?TXJJV2R4b3N3dng0NUpYOG01ZVNXYTNCOCtROGY0ZFROYVlyWUs5NXY2Wm5l?=
 =?utf-8?B?ck9wcy8zTDhEbnFQbEFoem51WEF5R1NhRmpFaC9pdnVla3k2aGhuT2U5ME54?=
 =?utf-8?B?VEpTR3o5eTdHZUJ4Szl2STN2Mzk0YUtteXFRUHZCQTk2blB4S2pRZ1JoNzlI?=
 =?utf-8?B?Y05GVmxyYzdvcEl0SG4zNGhyemZGektlcStOSm0yZE1xeWplcS9kcnAvYkpv?=
 =?utf-8?B?RmlKN2VrT1N6aUhpVTkyUXZ1bEhySkN5SVowQUI3aWhQTFF5R1lyZEhrMlBa?=
 =?utf-8?B?eEpuZ2ZJWm1RRTJpeGpNQTR6ODBXZnBxZHlJQzVMMmZLeVQ5dy8wWTZDanNr?=
 =?utf-8?B?emdpZEczZ2NJY3NGV2lHenRUMlNvUnFHWCtjQlpUNlprU3JnM0tRL2NLanVM?=
 =?utf-8?B?YktzTXhuNitwRGZkR1h4b3R5VjFIZnprTDhBcllGVlNUZXlFWmh4ZTFYNHdq?=
 =?utf-8?B?SGlvaGp3amhVdjd3Um11R0xyNGtJZVh1bnhMT2IyVDg4SnozODBCanVENWF3?=
 =?utf-8?B?SkgwV29CUG83cEpSMklRckdyK3hPRTNxSVl2ZGxqdjRkYTNMeEQ2eEhHWTVy?=
 =?utf-8?B?NGhRR3piSjhqNzEvVkdGTU1nbnk2SEEvbWV5MjFCNzFNbm81eWN2RSthb1RQ?=
 =?utf-8?B?NEJRYmZ0N0xwVWZRVFRwZjdFc1VBemhhVVA1QjBzdEl5aEpNTmVIODg1WEJP?=
 =?utf-8?B?bmp2TjZNNjJ3U0FaWkhBMURIVlZ2RUYxWUx4RXRBYjdqSDlzb2R5S2lSSmF2?=
 =?utf-8?B?WTRnL05Wc3hneTQ1RUQ3NFNTQkxJOW83WEd1TW1zMWpaVjl3UU5VTEdhQ1FI?=
 =?utf-8?B?cjNSVE5nUUxmd1JrQW9INXYyUE5aaUxGQUZOZVFONVZzWmlBWjc3WHlKOGFC?=
 =?utf-8?B?eXZJWENiSzdoMk1iU0dPWWdqY3loSkpkNmE3Qkc0YnBuZW9Oc3dXclgvL2JT?=
 =?utf-8?B?QVQ2SFdQVTQzWHErUURxeWl5ZlB1ZGxpblNZSnNOS0UxTGVUUUx1RjJwZHVE?=
 =?utf-8?B?eUdyRDFmWFoxRTNyNVJSVDgxRDVLekcyKzB6UU02WU95T1hraVNpd00rQUFn?=
 =?utf-8?B?Q1JRWjI5SklKTmJmWGtaKzR3K0o2dUJUWXNSV1MzSGV1SjFpM1BrZjhHK29G?=
 =?utf-8?B?eS9PYjV6SnNWSTNRTHladHVPcHdBMDZZQWRYQURmVVlUVmZwa0E2a3lNVytz?=
 =?utf-8?Q?IbFPiBY9v9o1ZiRhBtZingfhR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f83daa0b-e9e3-49dc-983a-08dbfd6445cb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 11:52:11.4665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqJoWbNw0w1mPObJ71DwrYsOzr6n/R+JFcvEAfncpvikZPkZF44e31RiQ6aVp7sJyPfxzhw+qzEzGYCON82/uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8328

This patchset is a rework from Oleksii's RFC v5 patchset
https://lore.kernel.org/all/cover.1698353854.git.oleksii_moisieiev@epam.com/

This patchset introduces some changes based on RFC v5:
- introduce helper get_max_msg_size
- support compatible string
- iterate the id_table
- Support multiple configs in one command
- Added i.MX support
- Patch 5 firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol basic support
  is almost same as RFCv5 expect multiple configs support.
- Patch 4 the dt-bindings includes compatible string to support i.MX
- Rebased on 2023-12-15 linux-next/master

If any comments from RFC v5 are missed, I am sorry in advance.

This PINCTRL Protocol is following Version 3.2 SCMI Spec Beta release.

On ARM-based systems, a separate Cortex-M based System Control Processor
(SCP) provides control on pins, as well as with power, clocks, reset
controllers. So implement the driver to support such cases.

The i.MX95 Example as below:

Configuration:
The scmi-pinctrl driver can be configured using DT bindings.
For example:
/ {
	sram0: sram@445b1000 {
		compatible = "mmio-sram";
		reg = <0x0 0x445b1000 0x0 0x400>;

		#address-cells = <1>;
		#size-cells = <1>;
		ranges = <0x0 0x0 0x445b1000 0x400>;

		scmi_buf0: scmi-sram-section@0 {
			compatible = "arm,scmi-shmem";
			reg = <0x0 0x80>;
		};

		scmi_buf1: scmi-sram-section@80 {
			compatible = "arm,scmi-shmem";
			reg = <0x80 0x80>;
		};
	};

	firmware {
		scmi {
			compatible = "arm,scmi";
			mboxes = <&mu2 5 0>, <&mu2 3 0>, <&mu2 3 1>;
			shmem = <&scmi_buf0>, <&scmi_buf1>;
			#address-cells = <1>;
			#size-cells = <0>;

			scmi_iomuxc: protocol@19 {
				compatible = "fsl,imx95-scmi-pinctrl";
				reg = <0x19>;
			};
		};
	};
};

&scmi_iomuxc {
	pinctrl_tpm3: tpm3grp {
		fsl,pins = <
			IMX95_PAD_GPIO_IO12__TPM3_CH2		0x51e
		>;
	};
};

This patchset has been tested on i.MX95-19x19-EVK board.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Oleksii Moisieiev (1):
      firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol basic support

Peng Fan (6):
      firmware: arm_scmi: introduce helper get_max_msg_size
      firmware: scmi: support compatible string
      firmware: arm_scmi: bus: iterate the id_table
      dt-bindings: firmware: arm,scmi: support pinctrl protocol
      pinctrl: Implementation of the generic scmi-pinctrl driver
      pinctrl: scmi: implement pinctrl_scmi_imx_dt_node_to_map

 .../devicetree/bindings/firmware/arm,scmi.yaml     |  99 +++
 MAINTAINERS                                        |   7 +
 drivers/firmware/arm_scmi/Makefile                 |   1 +
 drivers/firmware/arm_scmi/bus.c                    |  49 +-
 drivers/firmware/arm_scmi/common.h                 |   2 +-
 drivers/firmware/arm_scmi/driver.c                 |  32 +-
 drivers/firmware/arm_scmi/pinctrl.c                | 927 +++++++++++++++++++++
 drivers/firmware/arm_scmi/protocols.h              |   2 +
 drivers/pinctrl/Kconfig                            |  11 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-scmi-imx.c                 | 117 +++
 drivers/pinctrl/pinctrl-scmi.c                     | 419 ++++++++++
 drivers/pinctrl/pinctrl-scmi.h                     |  12 +
 include/linux/scmi_protocol.h                      |  48 ++
 14 files changed, 1710 insertions(+), 17 deletions(-)
---
base-commit: 17cb8a20bde66a520a2ca7aad1063e1ce7382240
change-id: 20231215-pinctrl-scmi-4c5b0374f4c6

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


