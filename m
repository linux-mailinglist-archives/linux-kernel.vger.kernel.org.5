Return-Path: <linux-kernel+bounces-94933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C458746E4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D52182813AC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F6C1CD05;
	Thu,  7 Mar 2024 03:37:25 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2126.outbound.protection.partner.outlook.cn [139.219.17.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14D01DA3A;
	Thu,  7 Mar 2024 03:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709782644; cv=fail; b=dXMh76oh+eQfVQbfQR27i2TDnFAOyoIXyPmkv85EWO/1XdxB9ZZSruCc72Tm0UvhcMEz+2NDEQaD8Y4GnlXp277rOZvcI51SX54R+BR8t1qRbfUMq1L0zjSu/sE2WY+A8otvJguo2sLRaB5njadi73ez/ZKUVjZTNJY3hmPuUL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709782644; c=relaxed/simple;
	bh=o1yMXFW0J2O7V4Lu/Ta4uTKaCzVzs1/lyaRX0oB0o8c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=B1MxVfNk+XXcsjMZPnwdwobeDbdh/vTiPseJfSNkJ2fsPX7gsDtwynEFHjDiA4MbUdcmkyuV+0mDUCsY/dI+ENAHAhU6Nvfh1VYm38JF903m6jYS7v4celC2fNPuOmPkRFEZ10ArtsWZEYLOM2gK7UWrHwYOJ7XDt8ZAhkqZBuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSd59/5qhnGyNFl+iNt3/7M+hqDz8YH+BeQmVtOiIpKiWtU66yhHVg/iPykUikDfcb0jTnYBaF2VlhAMqt+MmnpQdPp/7nQRs8BW6aYuFRSgxjdFeHkqub7Q5sizC1xydLHwW12fOvK0A1ipJwN/Msz2MbnIxP1MVm1yMnwSl2QwWSl7ARzLbvZ6VXh6KuBZS/FgjfYqynLaqNZF4h9+HVjsdy1GUQUYcjCfGRgmHLuM36qsqHnD1EO/tsT7+5vpbuvoO/6DPiqJM0iC7AiiLQcUdpZkbOcPRlx4J7SMspLJdpWIFfXtC3LZ09Kj9nTwhwDNSfTkENTeNAdwyccowA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MX1olTlcZrtEXi9JIHQZwQ6ksHNLblsom6QitkJEn0o=;
 b=RtO4Gkll26+Hjsi0a3ByS8XJug0Ks/EvO5oQJnst8jBItMbOxRJlz+tLZBJ550jAco/DTYzGOu9GxoZxAjgkVpz5iUUPlbXd11epN+gWJ+mEs35B1qRZY/reus4eXSoDd3HFnsZSLwtMlkB1YLk5AGEV7eqGDAAsRTXlPWMWRX40uJwRE0JEY8o+05MZzDTJNMqW9wzo9qLB68hN/DaInt+EVLIrsF9ly6dbzokbrJHJ7jf1Yn12+HyNFg43YzAdEvHnLJE3fno/g4QOly0ZF6gBXkgWKAOkeMTK0bBHeXO4PU6LVvdymGgUdau9wB1OWHjmw9OUNqX8aT4KSHzczQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB0969.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 7 Mar
 2024 03:37:16 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::20e3:6cc0:b982:ae95]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::20e3:6cc0:b982:ae95%3])
 with mapi id 15.20.7316.039; Thu, 7 Mar 2024 03:37:16 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>
Cc: Walker Chen <walker.chen@starfivetech.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH v1 0/2] Add PDM controller for StarFive JH8100 SoC
Date: Thu,  7 Mar 2024 11:37:06 +0800
Message-Id: <20240307033708.139535-1-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0019.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::22) To NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB0956:EE_|NTZPR01MB0969:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a254a11-87d2-4c0b-4c1f-08dc3e57e279
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p7hq0KEiG378wmDEFK06Kw1c0Dy+VgMHkhcqMOTopkBBeerUaQTprIZNd8lZPI39nkrfoXf2Qqu0/+9TUkQqBGnsAfeiwANbwuFmHqcvLpQNTzApgUHaNCq9E1vvQsnKiPXo6uSXAeo8KHsZv2AphGI+89cqVuqtRud4dtrv3OtxeUx4kI+XRmXw7lUEW30roV4+1g9XjuW/Ll5mrIm3hIWnDxt5532rwhuweLQ7BTOB2LOI8JeJGhdV74NE1egLLvmZUhFEbAL7gNmdkbYrOK304BfAuEy1zeRBwN/4WdPnKgY7q3owdP9GnUSiYglQdSiE0FS5NqYC/8hYLByrUxw8eYt23q25oeVtRwny8ZMKdsVgGSeH5sdOeJsu78QJNdsoyVzfe+GiLH+gfhI79KKK6LwaKFkIDPmkTLHFbiM4Qbj0uPxTqTxUmvN7KQ55htl+6uDt5nZqbjHf3AndVePyx556Vxathrv74TOusrS3ouMORa2ms38oyDLBjPDsezZASyXA2TOBsyUuMoCJjf+NheiX7H+1KZ8FfNgXz49zoe4nkMx8Jrf2PooVmMJ+MAQAN1UPLuuUOGvQUkxH5GypJLL5qVIjt8tTa/3m3bc9eUMF8M4oQm5Qjq9vug32
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U08vIIyGAS4q+L/he8cZvNXOSlJjZ7HUZ4rRTWMtd16DdlasVIqZ1rSlYzjl?=
 =?us-ascii?Q?JTonEoYDYZxrRqPSSQxPtt31716nZ77OIF9CqRYA/D7hlzW+yic6DAEInMSD?=
 =?us-ascii?Q?dAO7MCe6iaUTucqgOfT9Wr9W9AcCh+K92td8K7VgHKu9pk9ppS4hrnoPa2a8?=
 =?us-ascii?Q?UDac7M8w0sW3JvtxC66DVQEgZngagNn5/wVg0pNrZU8SR3UMTMCdkX4I+/Ok?=
 =?us-ascii?Q?PNrBctRoNHjFYtbrDvoF8s6sh5tYe+Q5KzyhV0sAlmn//S1V/NDVOB98HTb4?=
 =?us-ascii?Q?ItJI5ZzJS+UvqfW9T0IeLtLgEJiRoOZlzozYJmc4ZBY7xS5i27SVBIWjR0Ih?=
 =?us-ascii?Q?SIIjttUb5SRbYNkXEKFlQ2rXIvd6kaFpuka4aD3FHAtZr7FhYQHbKymiIAzP?=
 =?us-ascii?Q?/acsg1FrD2oGU7VoQloDPicSwy6x1nlwyPRx83bQ0vwMupqPzdgV5IcW3stj?=
 =?us-ascii?Q?qIAgKnYEaUOOBWTr8rjGb0R6dCUmqbWK7aw+lhz7TBSSpCd2xt7YeSAkeWjd?=
 =?us-ascii?Q?HCgzrlBPHFXnfl0vP4Rjvz0JethuS+qPEfCGdRr7z9WZ74pRj++lDlSFZQ7U?=
 =?us-ascii?Q?3FNQX1oyvQmHTWCiv+giRdaqI+tzbypmyJqSlDZoiLpGJmyGbN9NpixlliPy?=
 =?us-ascii?Q?Xp5iP6TlpVmrL76xCfN8LuPEJnxOMrrgVEmfhi60GYOManrynfIFhChxSKmx?=
 =?us-ascii?Q?DmZaKls3oApMYGiGsyV8mUj1hgOGnYDJUcbrBDCFfE1OrbZFVYh5F6xNDwrI?=
 =?us-ascii?Q?9WTIeMr9wvDmhvVYQy6NH8xtlukP/G+znqrx7/5aWlJzQJNxDJgUJjnQ7WRg?=
 =?us-ascii?Q?saYl2/kXL2iXF6Cab8YrJ/XO2ACotV1+1ISAIad4d1jjVxNoiZqraIMreSTL?=
 =?us-ascii?Q?sykeia+8KHgYc0g57FnDvztcnWOs3vWgIRRDqGcqS8M5TRZnOIfoGFedf8n0?=
 =?us-ascii?Q?DeEsCCwA4BsMJn7iaxSVdvJ8SK+0ZPdBdiUAHvKG0b94u/7yFjhgcLCg3xXt?=
 =?us-ascii?Q?5ZUhfuCxwX8PA+kZrU+YKDwV9AC87r7i6U6CDZo2bSzB/RKiYQSQgiiFBr5K?=
 =?us-ascii?Q?OYzkqtuwbql2fNYNPjKMBcb609Asz1XBifpD7ybI+LbS51qDAYUoCssrYe4B?=
 =?us-ascii?Q?fI3Oysr9MHpR/33wyc8H7FNfeZX6sjlGUSJ/47b/CWEoSUunGQee2HuWykMp?=
 =?us-ascii?Q?6AFf1AsYDWhwLDTJ7E9fN2qyjYrZiJelbCHFbIk4RCWyYMNg1XwXmKVmDLfu?=
 =?us-ascii?Q?ZqIMZaHKPJTlfo6jpPfAab4BJgr6l0aX2DYgE4NxrVDuZNAk+Q32/jUwOGGd?=
 =?us-ascii?Q?qQ6FGaK0iP0Zy+GkTO+ablU3Gi7+30iN53cV3F1vGg8f0jucKIo/OWquHx2d?=
 =?us-ascii?Q?SMS52Hw9kx4CsqelM4riyQ0KwGFnCRix1ZBagp+l0foa1Z4H4cIq8q8gQ15c?=
 =?us-ascii?Q?a/YzeYoAZAK2IzCJFOrAAMGlhQKj4ws33ordHtsy+v+4BUXG0HUzD+CbMPjA?=
 =?us-ascii?Q?w5dqxqKw4EFOpGIeAeH803GJiuy2k+pF/K73XP5xcsfwRsr/LS7ARgTSeIJq?=
 =?us-ascii?Q?lWZX3TtzlBSG+/sk1R58cx+KbVgGxpbmOcVLbO9b2gwfFtJRFdVcd1EM9w6G?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a254a11-87d2-4c0b-4c1f-08dc3e57e279
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 03:37:16.5496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FO+uI6Tqtn0F/IMOKS6x5RErVmlOo2z8IAQrtdNLa/+7K0Ep8M9syN7EL8E6xRwVOvagQIJI7ryRriu7Wpw5OmWLAYOGCxHjeIYR35MlsU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB0969

The Pulse Density Modulation (PDM) controller is a digital PDM
microphone interface controller and decoder that supports both
mono/stereo PDM format, and a Inter-IC Sound (I2S) transmitter
that outputs standard stereo audio data to another device. The
PDM controller includes two PDM modules, each PDM module can drive
one bitstream sampling clock and two bitstream coming data with
sampling clock rising and falling edge.
    
On the JH8100 SoC, PDM and I2S are fixedly connected as follow:
    PDM module 0 --> I2S channel 0
    PDM module 1 --> I2S channel 1

The first patch adds documentation to describe PDM controller
bindings. And the second patch adds PDM driver for the StarFive
JH8100 SoC. The DTS patch of PDM controller will be submitted
after the patchs of JH8100 DTS are accepted.

Xingyu Wu (2):
  dt-bindings: ASoC: Add PDM controller for the StarFive JH8100 SoC
  ASoC: starfive: Add PDM controller support

 .../bindings/sound/starfive,jh8100-pdm.yaml   |  84 ++++
 MAINTAINERS                                   |   7 +
 sound/soc/starfive/Kconfig                    |   7 +
 sound/soc/starfive/Makefile                   |   1 +
 sound/soc/starfive/jh8100_pdm.c               | 395 ++++++++++++++++++
 5 files changed, 494 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/starfive,jh8100-pdm.yaml
 create mode 100644 sound/soc/starfive/jh8100_pdm.c

-- 
2.25.1


