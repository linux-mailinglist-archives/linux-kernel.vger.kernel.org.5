Return-Path: <linux-kernel+bounces-16524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD81823FAC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B8D92821D2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4B320DE2;
	Thu,  4 Jan 2024 10:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fp+TancX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2049.outbound.protection.outlook.com [40.107.241.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A8B208B3;
	Thu,  4 Jan 2024 10:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXaQ/ngrdbxNVasAqhklXnvorx0nrvRkfbU5aJ0C/ymT9auOaZt6n5zFypx1aYz0SIulaD4C3nfevPf4CYhWMtlL3qrHB5JP/HFE7byluy58Lybng5uJvjrq2KnkVCHJjXtDc9tri0kmTXNnjDqsbpaldW0KuNEO1OtKJhLE6NNfEqlbpp7RoqNcp3s6TlckmQhB4s9xXt0aWfkZJm6sMbBcaAXqzlSpqRNKot2gnHMGgOI7ApVbXnqTBuRR5DuLnfsAp81lwY8RKVwXojVWmz1xFFK3um4OF06d1jL6VHuYaGH/UerWkSFSwUfLzUcMezgiJpdNkRUExhidk5B9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlYAlbsEKcZ/9BSvwzzDxt3ItVqOja6LvWtQ7m6NwUc=;
 b=KIa9BEMs0UCP5Ove2rHCCoIywr9shsgaht+QtvzEzPxmO9WFrW2WtLiqkbqsYjWx74E3reDzAMNMAUhFuBbO3MEsH0dOCwWLzMwzyerWqHgEnNd1lFBBw8jQXBIpT3jjfk/1DqfLFOs+zbVniO93yGiF3cVmH9fPj0j93VRdrI2sLVDk1cRllYspp7KFK9rJ3onxbrGaY4Q3NoHFGyXT5PtmX4mMStqWAigSSmTd/5gvxCfuNo4Z3g2GuSSsDaPEdQMxU0rdDtu6JXtvYGYVB2bcPpFDx/QsbxS11XoEZYNULYUVYkONIqDgoHUQGpVDGuwi65DfMz50c3K4rQ/erg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlYAlbsEKcZ/9BSvwzzDxt3ItVqOja6LvWtQ7m6NwUc=;
 b=fp+TancXsxasOT8DZirsaOHlHrP+WC0t2XpHbI76D2Jg9/lDYS8TpZp4srAsiuP1uYpZE0mcnMW2nOTtbEw+0qfLVaApeDPanPjWcAnSs5nRZPdJbuQT8kvY4iv/FbZ3j4Lc3Hk4mE8SJiMQj2EEcGcvrmlkgvqVJ0+oqRvtcgM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8847.eurprd04.prod.outlook.com (2603:10a6:102:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 10:44:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3%7]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 10:44:46 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/6] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Date: Thu, 04 Jan 2024 18:48:44 +0800
Message-Id: <20240104-pinctrl-scmi-v2-0-a9bd86ab5a84@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAyNlmUC/3XMywrCMBCF4Vcps3Yk1xZc+R7ShcaJHbBJSUqol
 Ly7sXuX/4Hz7ZApMWW4dDskKpw5hhbq1IGb7uFFyM/WoITSUkmLCwe3pjdmNzMaZx9CD8Yb10O
 7LIk8bwd3G1tPnNeYPode5G/9AxWJAoUnbcn0UvrhGrbl7OIMY631C8XgQcSmAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704365357; l=4501;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Mnug5Jo77HdpS8MygXGGooXxDHfJb5eIasSMZwUTozI=;
 b=l2Iq+yQfOqm09eaosqhQk7XBR4ysLSb/4pa0Vm/8z1fm+K+O9JxaFk2Lhlue6panASJY4SxrC
 iVUw8ITjHDXCGC1ym9iUJm6gSNf+FaeBILKkbry3ROOeWD3GXKAbZhs
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
X-MS-Office365-Filtering-Correlation-Id: 3b0a6d86-e427-4950-b422-08dc0d122ac7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kAZvt+pKnwkLpNpL1YWmZiaHuCOhlAfO4xiHV76DXhXN92gHdUMVLYLcZfvWKKD1+4Ee8AAURqH0dmbt/leOXeBAsNZrWBT1u5VBIOf8eFPpEQy7uMPS1QUKVzzp8aaMLHBFMd/VO0fkrlVrT7tUphJUyshrgRrsIBw/mg8/jVkayMmPJVv2pLXhtR/52P3Z38WOGqRL3GkGAlcNXK9pndePG+mcOSQe8s9VU7DfpQvfcYgg3LUF7T4/sgSnN/Gg762FF5szyzAD0YFj7E5UZi2dyVGnqCASFMPeZ65YpE3VVRG0GqwtqiHzdPPlot3WOfrISnaavvNcfEShSiE+hLwgG55q0uNCFr8TovImIuoqb7y0vUS0XG4d8xrewdEaeuAM4cq7MeHxn3c0uu73YUQiI9o7GKEoeq3mfpSwlersbSf9felM6iVm7s/O2I1/MbMVn6sN9XQ9535JJGFDrqXHFsYtUVuqBfE9QD0Hpd6LNqd/0bXfqtpY27wfh6ajsahSAmc+8I/tEqO8rY9mTB/a3GGMPtHygn6L6ZD/wpZLwDzm+VRL6/jKOa+1dDekxkeZlIgmCtx3xUV7QNqhMwsoH2Pxrxw89Hep8heeMGwDi7rDfS+VKDw+Jq5aF6oz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(66476007)(66946007)(66556008)(6486002)(4326008)(8936002)(8676002)(26005)(54906003)(110136005)(316002)(83380400001)(966005)(478600001)(52116002)(5660300002)(41300700001)(2906002)(4001150100001)(7416002)(6506007)(6512007)(9686003)(38350700005)(921011)(36756003)(38100700002)(84970400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkdRKytYNnBkYVBMdW84RVF6RGhVek9PWi9rRHlNWW9VZHNiaFlLeFlhdVdp?=
 =?utf-8?B?RkZYY0thRlp1WmtRZktrMU51VldvVlBBSit1SnRFdXptK201aytWdEhZVEV5?=
 =?utf-8?B?a1ZjbisvNnRnYUtLeGVZZDJscDcwdDVuNDkwbDREbHdxMEVGQm1DMFg1N0hy?=
 =?utf-8?B?QmxqOHgxNnJYSDNsaEN6MnkwaS9EYUJMWjF4bGFtUW9NSmVCVVBib3ZqL1V5?=
 =?utf-8?B?Zm40RkhFT0JaMk42NUhlTnk4dE1KRHJoNzRvU1ViQll5a0tBVndRVUhPVFBF?=
 =?utf-8?B?NmFOTGp2UjRIblJGRU1iZExXblRINDBtcTJCRUNMV3NUVXVIb201TjQydVRB?=
 =?utf-8?B?Z0JOQzhjUmRBaVpzYTJYQW1tbExmMDJVM2J3cUNrMXgzb0tENDQwVkMrajlC?=
 =?utf-8?B?MXNqNEVLZis1OUJQMytjT2tnaWRYdkMwU2orck15UUhhYlJhek42Uis2dzhK?=
 =?utf-8?B?V2JvblVDQVRyUTJac0ZkNTY4bHdrYU44MzJQcnpPOW1USHRnZXRpT2dJaUtt?=
 =?utf-8?B?WGlINGEwU2d2eUUxOG1Kd1BsMEtVbHArMDh1VWpwUDhZNzIrUnJ2L2JMa0Jn?=
 =?utf-8?B?WTBrNlg0encyanlXY29CSm1pNlJ0QkliekdwdHladldMNFFodStwaXZVNG4x?=
 =?utf-8?B?OEpFZXRuc2JkSW9oekc4aXNqbUhOODhIZ01INmN4SlM3WGVTc2tKd1B4Nzhr?=
 =?utf-8?B?RnlqYXJJUkRKbjkyc09TSUFiZSs4YzlYSkJVTzlUSDYzOHdyVWszejduSGdU?=
 =?utf-8?B?a1dRaUFBSmNzR0NRVXcvVzhkRTlDODRHV08wdG45dVN3MVpWcTUzVHJ6L2o2?=
 =?utf-8?B?Z1ZiUWF4akZsdjcrRXlGdVNqSDFmZmRkRFdRM0RsdEZJbXN4Z0xlL2VGcnFa?=
 =?utf-8?B?eElMRlBDK1k1Ulp6eDZqdXo5YjZ1ZFNPVXROMmxMT1M5WDYvRTBOUTh3cFZt?=
 =?utf-8?B?MEZqamNDa3RaTVU2RVlKb3VjZ3duc21rNXdKRVdPSGJmM3V4WjM4cW5xdjdm?=
 =?utf-8?B?Z2JWNnBhNVpnMHliR0E5N2JuN0JUeW55aSt0UzB1OUtIMi93WkFUU2xwemVj?=
 =?utf-8?B?Z20zOGNqT3JkREJ5MVdlM2FDSFVIQkNoNUJlVklVd29HRUlyZG1NTFhXd3Fo?=
 =?utf-8?B?ZE9pZU5nUzdpa2J2VThtdVRROEw3RVF6MUx4L3czR0c1QVpNU21RQzlJWFRD?=
 =?utf-8?B?UlkrN2VsT3g3ZjFuZzhpRUYzNDB3N0RzbmZVSjFDaWp5RSt5d2prQ3o4RkNy?=
 =?utf-8?B?akVSTXhOZXNjUjJkQkJxbjR2bzNHT1c5MGRHam5SUW1XR0s5TzRoNVc3VHBG?=
 =?utf-8?B?VWRUcTdDR21rZHJaeTVpaTJRWXkxUk45WElPWkhmL1QrMWpJUkc3U0dRRVJ3?=
 =?utf-8?B?OG00UlRkNTZBdE9pd1BLeVprWjNaYTJGUzJEZTJSMGt1cEo3WC9LVlRPdHFV?=
 =?utf-8?B?VUdjNkQzcHEyT1ppblJhMWxlZE5oLzFhUkg3QlpiYlFGYnI2aXg2ZURUd0d3?=
 =?utf-8?B?aXE1TW5tYWt4MTNmODhLRmI3eUt3ejRIdEQveE15ckNkOE0xckVLays2SXhr?=
 =?utf-8?B?YlJHREMxcDZqbVR5RU41Nkw2cTRmQmNMbGdhTnh5VTlEKzM2UXhiQWdDL1c4?=
 =?utf-8?B?OG5DbkRWSkxlSnkwRHRRdFU3VHhOdUJ3Tjc1MGlKYS9oUHhlODFVWm1lNHdX?=
 =?utf-8?B?YUlMSS9ndVV2QlA4Z3prNjJXUDVuTTl1bEFIUWl1OWZlTWJZR1dnQjhOQXpM?=
 =?utf-8?B?eXRJdHoyemlTbDFpZjBDMXNkeGN0RXRNbnE4UDFkQXZTY2wycWJ1dDhmeWNM?=
 =?utf-8?B?WDRkeWExcjM2N2lPVG9YY3Jtc2VoRitlYlFaSjkvakNOVEQ3am5RS1ZzL1ZR?=
 =?utf-8?B?a25qMk1VMDVJY3hQN2J1b1NURzg3VjJrSUhkSWF2Y0YwL1IzaHJ1ZEdDZW11?=
 =?utf-8?B?RW9KMVhNTkdGWHR3VjY5RmtocnM1NGNEUTRRbi91ejBmcFc3SG4xVjcwZlpm?=
 =?utf-8?B?ZnN4Ulg2YzdMbm9wbUNjeGNpMjNpQitHQ3NOV1c2SnFhN2hhdWR0RkV5elVh?=
 =?utf-8?B?OE0rVHdVYkZSMFhKTUxwZ3UxMjdjMWg4SU1tTXU5R203VGVyckZxZld3akhW?=
 =?utf-8?Q?bz8wxawb6cgBvh0F5qu6LhTki?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0a6d86-e427-4950-b422-08dc0d122ac7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 10:44:45.9656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOoEfknGcdw4q/QZEMCNkC448GTfcne2yebVDPDfGgCyJBeBoK9vNa7O5ZI7IVAgT7CZj26W8yqjsB57o15hbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8847

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
Changes in v2:
 Added comments, and added R-b for Patch 1
 Moved the compatile string and i.MX patch to the end, marked NOT APPLY
 Patchset based on lore.kernel.org/all/20231221151129.325749-1-cristian.marussi@arm.com/
 Addressed the binding doc issue, dropped i.MX content.
 For the firmware pinctrl scmi driver, addressed the comments from Cristian
 For the pinctrl scmi driver, addressed comments from Cristian

 For the i.MX95 OEM stuff, I not have good idea, expect using compatbile
 string. Maybe the firmware public an protocol attribute to indicate it is 
 VENDOR stuff or NXP use a new protocol id, not 0x19. But I think
 current pinctrl-scmi.c not able to support OEM config, should we extend
 it with some method? Anyway if patch 1-4 is good enough, they could
 be picked up first.

 Since I am only able to test the patch on i.MX95 which not support
 geneirc pinconf, only OEM configs are tested in my side.

---
Oleksii Moisieiev (1):
      firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol basic support

Peng Fan (5):
      firmware: arm_scmi: introduce helper get_max_msg_size
      dt-bindings: firmware: arm,scmi: support pinctrl protocol
      pinctrl: Implementation of the generic scmi-pinctrl driver
      [NOT APPLY]firmware: scmi: support compatible string
      [NOT APPLY] pinctrl: scmi: implement pinctrl_scmi_imx_dt_node_to_map

 .../devicetree/bindings/firmware/arm,scmi.yaml     |  50 ++
 MAINTAINERS                                        |   7 +
 drivers/firmware/arm_scmi/Makefile                 |   1 +
 drivers/firmware/arm_scmi/bus.c                    |  39 +-
 drivers/firmware/arm_scmi/common.h                 |   2 +-
 drivers/firmware/arm_scmi/driver.c                 |  32 +-
 drivers/firmware/arm_scmi/pinctrl.c                | 930 +++++++++++++++++++++
 drivers/firmware/arm_scmi/protocols.h              |   3 +
 drivers/pinctrl/Kconfig                            |  11 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-scmi-imx.c                 | 117 +++
 drivers/pinctrl/pinctrl-scmi.c                     | 540 ++++++++++++
 drivers/pinctrl/pinctrl-scmi.h                     |  12 +
 include/linux/scmi_protocol.h                      |  75 ++
 14 files changed, 1806 insertions(+), 14 deletions(-)
---
base-commit: 8f266a167d1f0ca34668f05cd8c01bd245c8698b
change-id: 20231215-pinctrl-scmi-4c5b0374f4c6

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


