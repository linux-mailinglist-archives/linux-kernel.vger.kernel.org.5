Return-Path: <linux-kernel+bounces-94936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D91F78746EA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FB63B23850
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B84225634;
	Thu,  7 Mar 2024 03:37:31 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2126.outbound.protection.partner.outlook.cn [139.219.17.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF57E15AF1;
	Thu,  7 Mar 2024 03:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709782650; cv=fail; b=jdf1v5XsDTUKFVFCPbpPrdfmdp9HoZ/vmjZWH0WjiPoOrj8vsvUHFtw785IeyDqysNWMqqbF1ErulvnDdWMg9PiLLHnC4WGNlxVms4z6ODJUJ4jAnuflcGJ1Vh3+31WpBbYxUGcSDqhHOwmBfeU7NIFJnEGeP1GJpE4+BBL0ECg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709782650; c=relaxed/simple;
	bh=7sJQdk8d2KQj2wV/LzlSlii2qOddHRy1hy9knecb+zg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P+X5dYm3RGwSey+h7Gh6OK8ggH24ZkEXkBarQKWCEEd4Mt15ZTeWQH5YymcOGm7U6SuvOCNrIEWBQ2PfsJPLfDGdg6+whg0gLU8fHzmzqCvdEhWwhyck9tiHU3eg9ft+hhMagPupnR/oxzuzxtAHUjmrN0UQgGDLALf9GLasZkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TR6IALJf4ovDzJj4CnOENv8UWSbL4NHcszCG6il2LUEkTSw6EZr9vkmhEEq6L7Z0tIc3PwNat5aYs/3dVXPxLYNR5ewIBx/ut4WZ47DREQ64LQo4fazkf+4UiO1kVJubyhynMgg84LypE2GFkcrONz3Dg0X8Ik0f/KKCU71qVjiGp+5M4C/6KjZxEhO0Vx/QNHourPwwEUrge2IJ0QMqABYRRxfrjKWVkmLrU38xpw74KTYRsKJ4F1vVqdt3hYWM/6ymI+JyW7jfgrRrDww5VuQcVxjb10pNSSx9R/df6qZfRYYAUJSYjWqXt253+F/JiBXKTAOGBsx3Eg6c5oqO8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKo4Kvq1AJ3f61iAOqjZIXhSQCjGJf1RIyEnRJVaMnk=;
 b=azxsUJgC5B6X+MgZYs9ovoRV5PK0ShV4oE//CO0zgrOJsnvrXc8v4gXCgZhleuU/ieHy/eHoUfCZMmtBGrHgDIllQ/ZBIMM23yt5HTDrNuB9Jy20DmLF4uZNpOEODDzJFeABcxiHMOanDfHkVU/nzFS3uibluu79oT3HlY88bwEdPwzzsEUW+Mk10qTboDxzYY8tUzemC7kuGWZITKVnVWfLQB0KKyBV+lm1ft/9FbxbdGv//KXnNpVqIpXtpH/M1vTpxUUGHHkxvERJSfPbd55g8RFE9XBKtFAtjvqrPm2xld4Jb+XGJWCPXY66obGxQzgoWcwcNUuPIeGteGSf5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB0969.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 7 Mar
 2024 03:37:18 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::20e3:6cc0:b982:ae95]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::20e3:6cc0:b982:ae95%3])
 with mapi id 15.20.7316.039; Thu, 7 Mar 2024 03:37:18 +0000
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
Subject: [PATCH v1 2/2] ASoC: starfive: Add PDM controller support
Date: Thu,  7 Mar 2024 11:37:08 +0800
Message-Id: <20240307033708.139535-3-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240307033708.139535-1-xingyu.wu@starfivetech.com>
References: <20240307033708.139535-1-xingyu.wu@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 32876c54-9dae-4795-d27d-08dc3e57e36e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Az5xyCxehlCDk++IzGzqmg95ctV4ssumEYxoy3Y++7YQpbjbNEDp6XyWmHG2c1FVo4fFPD80oNO84vXQ5tISi2sUf/7PAdLHmZgHdqUK2APBSObeZzSqFDGbGabFlQ7a3mWwtJkYkIO0hgPV5CnA87CR7wgRPtoH+GdyG6J0oG7EvuPMpmGtmZjPELZ7r0w8OUyfhLcsmZ+0x2GvcROTbCSo8XXhncuDboD25h4jTifTO04PNwiU+MB2SuTtenpB6oC3bf73XR1VVwuR/sJyBnp3GURt3ZZ4hr16QKhbKk9/V8gQMn9X3bs+2NU12KGVKotQ5BsoPd9laXJAjuLDJzbIGp31DWJ+40HjtTLdZ8mhMWMn1f+Mv01/U/DAGf3qbTXmOfZtD+TgDip5RkBuRavoHx5sN+eQJYwNvT3sZoFoFXb0lwzMeO+/LpEq2IgE6YoKuSNIQGQZhoBak88sFCL3Q+qk18gdX/fgZb4gVQVDoB3676wGSUyKzzdBcwymOgymDVdyE8BH5hhcp4QBDqo3ALIepAD5OO4u9Au5tyfIjwhnemiWrvosKQHkN8aewn4mymleFurk0jr/zJD2+nCVdD1rQLR2DdqDsTjrtmgYwGfUtXy/H9vtoA03QVKi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IcxGLqMR+5t1RDRGuxKLb+r7JS0xW2E3V77rfpKWuRUKEVPFVupIrCtPrEMX?=
 =?us-ascii?Q?riRbFvitKrNN487wm5EzfnGeKTwMrxt8BrjMbsSAW9Ipp8rC4Q8tOVpwKGIc?=
 =?us-ascii?Q?ciqLLzNg6/ZYvMoRPZVaB5GvjmUdBfu7Jo25y59xzqQLUiWWKREWnXVmMf2+?=
 =?us-ascii?Q?75IVW3GDaInXDcB/tj+h9uJu+ThHgI8YImpc/ghMUauyU3BCTMAfRP8MdyVi?=
 =?us-ascii?Q?pSS1fxCClkCD/SFOHTJILF/kWA6UHGwqds3Cdq+C3LJMVovK6hmXs+GwOyZw?=
 =?us-ascii?Q?0p93L8ilqw9wR5cCDAUYELjgg9L8XV4RaGEUN2o31Rodm6Lyp8MP3QH+dghd?=
 =?us-ascii?Q?q4Yqyql95ZZvxCyFbdzwzTgW+ep02QZ3J8hErWpyFw4m2t82XSKsQ5SBSiqc?=
 =?us-ascii?Q?58L3Z+YdsBR04nuQQnMNSx6xMN/Cy34MXFTuXCOZUgqctd22Epm9FNETH/l3?=
 =?us-ascii?Q?Vj7FL5/2iSvVvrZ9vj2UGpGHlFCTgsilrGh9VfOR6qvHxaJHjNe3p0CJfAuT?=
 =?us-ascii?Q?8qyqKL3I1/LLYtwxPp9Bs+REfGf741jve/Vf6QrLmo8B2k9H4eOZVCQGK9Rx?=
 =?us-ascii?Q?RAiHw2KtARZL02tuKz8ujj6aGqVZyoFPRU1ZmnfA7JPt6LgM5XoCL+Mmk1J7?=
 =?us-ascii?Q?mypZ6dJ88Ni1tunxzp+aAQLBCItaWiJe2+Ep1nlvTsdgvsM2627mPsk9Ke07?=
 =?us-ascii?Q?vWQAM+6/q1o1eZaKuql/hvYneZsKhi0oFeVARZri1ypQXDE+qzQM5U8uF7hK?=
 =?us-ascii?Q?b+HF+L4j6APWg5faOojguSmvf96NKVaNf9zBjHZiwCAV/SLKujhKxN4+N5O2?=
 =?us-ascii?Q?lcWTZ4uy+pFkve6QV65j5GkwFJoVlaI1Yj1Up7XnLRZFmsM46/n0TtbrObI8?=
 =?us-ascii?Q?L9+ZrqHSBKYXUtm3rnn1ZtyJ8Uswx5LJGpidC0w95WIklZ08gOEhbIYljVRf?=
 =?us-ascii?Q?K+s4BRdpVSg1fwFpcLWxCw7a5FxWGLs7JYXmfvHCa46iZ418t1T09yqvnT1w?=
 =?us-ascii?Q?6Kl3Mpm9E+9wka5llf0HNbu4FU4CG7z0JucE9uypFBHag1j8BU8XlnF8SKfS?=
 =?us-ascii?Q?3ax0HH6FkRDtwUzk+gMO4Kc8+FqIUWNrziOcOCe+CYMOGI3bH51sGm0PQxAB?=
 =?us-ascii?Q?s8cBFpqa2tYkpYxoNKK2Lpohz92SurVgIGX5UAE+Zwq4si/Io1KVG1SmnFid?=
 =?us-ascii?Q?2whyuaQkOY9eq4CfTVl9KRKLkid12hAw+nLF9BRwLPjupxcjOpLyxUYi3s6Y?=
 =?us-ascii?Q?Qt3Co1ROLs6VJVIYmNBbr5TABM6rx/oooanzi5u4JvNdNlEtfn3Hj5NGmHQi?=
 =?us-ascii?Q?8D89exJ4OroyBHaLslIqlD9MQ0kb1MhExihlI1d1eQKXP7YfDADlF0w4khHI?=
 =?us-ascii?Q?qnVcx+5z0VstJbipW8aXsyNPeRXqInQaXY6zDO8eZ0xq9nONxb/PVoXzaGOu?=
 =?us-ascii?Q?A+LJ6bSwxnl80AYN7Q5qyzQlZavaYeApgfrIGkJsQwwv13aZPqUMfof8mWul?=
 =?us-ascii?Q?vVKiZ0L5wcT/u8lT/gwmxpvMqcKzaXgh4JTfr2F0FBrv6CtEF3b0lQAax4AD?=
 =?us-ascii?Q?+bF1Qqxk0SYep5n1hj2zmSPatrRa0HkzkLiZxce9+BKeRArIqDsiVykp9Abt?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32876c54-9dae-4795-d27d-08dc3e57e36e
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 03:37:17.9947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ibMASXDNpT/1QvUcWRtMH7e8kNEnGDHPiDtS8T2j5b6ecov1a1JJ1t3e0xKKwLikG4on5slSGaQiE0iY57ldbFAZyPwtem89dsEvyLV14E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB0969

Add the driver of PDM controller for the StarFive JH8100 SoC.

The Pulse Density Modulation (PDM) controller is a digital PDM
microphone interface controller and decoder that supports both
mono/stereo PDM format, and a Inter-IC Sound (I2S) transmitter
that outputs standard stereo audio data to another device.

On the JH8100 SoC, PDM and I2S are fixedly connected as follow:
PDM module 0 --> I2S channel 0
PDM module 1 --> I2S channel 1

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 MAINTAINERS                     |   7 +
 sound/soc/starfive/Kconfig      |   7 +
 sound/soc/starfive/Makefile     |   1 +
 sound/soc/starfive/jh8100_pdm.c | 395 ++++++++++++++++++++++++++++++++
 4 files changed, 410 insertions(+)
 create mode 100644 sound/soc/starfive/jh8100_pdm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ecaaec6a6bf..7923f70d1192 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20941,6 +20941,13 @@ F:	Documentation/devicetree/bindings/power/starfive*
 F:	drivers/pmdomain/starfive/
 F:	include/dt-bindings/power/starfive,jh7110-pmu.h
 
+STARFIVE JH8100 PDM DRIVER
+M:	Xingyu Wu <xingyu.wu@starfivetech.com>
+M:	Walker Chen <walker.chen@starfivetech.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/starfive,jh8100-pdm.yaml
+F:	sound/soc/starfive/jh8100_pdm.c
+
 STARFIVE SOC DRIVERS
 M:	Conor Dooley <conor@kernel.org>
 S:	Maintained
diff --git a/sound/soc/starfive/Kconfig b/sound/soc/starfive/Kconfig
index 279ac5c1d309..9beb734d2028 100644
--- a/sound/soc/starfive/Kconfig
+++ b/sound/soc/starfive/Kconfig
@@ -22,3 +22,10 @@ config SND_SOC_JH7110_TDM
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M if you want to add support for StarFive TDM driver.
+
+config SND_SOC_JH8100_PDM
+	tristate "JH8100 PDM controller device driver"
+	select SND_CADENCE_I2S_MC
+	select REGMAP_MMIO
+	help
+	  Say Y or M if you want to add support for StarFive PDM driver.
diff --git a/sound/soc/starfive/Makefile b/sound/soc/starfive/Makefile
index 9e958f70ef51..b672425830d9 100644
--- a/sound/soc/starfive/Makefile
+++ b/sound/soc/starfive/Makefile
@@ -1,3 +1,4 @@
 # StarFive Platform Support
 obj-$(CONFIG_SND_SOC_JH7110_PWMDAC) += jh7110_pwmdac.o
 obj-$(CONFIG_SND_SOC_JH7110_TDM) += jh7110_tdm.o
+obj-$(CONFIG_SND_SOC_JH8100_PDM) += jh8100_pdm.o
diff --git a/sound/soc/starfive/jh8100_pdm.c b/sound/soc/starfive/jh8100_pdm.c
new file mode 100644
index 000000000000..8a05a544e5ef
--- /dev/null
+++ b/sound/soc/starfive/jh8100_pdm.c
@@ -0,0 +1,395 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PDM driver for the StarFive JH8100 SoC
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ */
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <sound/dmaengine_pcm.h>
+#include <sound/tlv.h>
+
+/* PDM RES */
+/* MODULE 0 */
+#define JH8100_PDM_DMIC_CTRL0			0x00
+#define JH8100_PDM_DC_SCALE0			0x04
+/* MODULE 1 */
+#define JH8100_PDM_DMIC_CTRL1			0x10
+#define JH8100_PDM_DC_SCALE1			0x14
+#define JH8100_PDM_MODULEX_SHIFT		0x10
+
+/* PDM CTRL0/1 OFFSET */
+#define JH8100_PDM_DMIC_MSB_SHIFT		1
+#define JH8100_PDM_DMIC_MSB_MASK		GENMASK(3, 1)
+#define JH8100_PDM_DMIC_VOL_MASK		GENMASK(21, 16)
+#define JH8100_PDM_VOL_DB_MUTE			GENMASK(21, 16)
+#define JH8100_PDM_VOL_DB_MAX			0
+
+#define JH8100_PDM_DMIC_RVOL_MASK		BIT(22)
+#define JH8100_PDM_DMIC_LVOL_MASK		BIT(23)
+#define JH8100_PDM_DMIC_I2S_SLAVE		BIT(24)
+#define JH8100_PDM_DMIC_HPF_EN			BIT(28)
+#define JH8100_PDM_DMIC_FASTMODE_MASK		BIT(29)
+#define JH8100_PDM_DMIC_DC_BYPASS_MASK		BIT(30)
+#define JH8100_PDM_SW_RST_MASK			BIT(31)
+#define JH8100_PDM_SW_RST_RELEASE		BIT(31)
+
+/* PDM SCALE0/1 OFFSET */
+#define JH8100_DMIC_DCOFF3_MASK			GENMASK(27, 24)
+#define JH8100_DMIC_DCOFF3_DEF_VAL		GENMASK(27, 26)
+#define JH8100_DMIC_DCOFF1_MASK			GENMASK(15, 8)
+#define JH8100_DMIC_DCOFF1_SHIFT		8
+#define JH8100_DMIC_DCOFF1_DEF_VAL		FIELD_PREP(JH8100_DMIC_DCOFF1_MASK, 5)
+#define JH8100_DMIC_SCALE_MASK			GENMASK(5, 0)
+#define JH8100_DMIC_SCALE_DEF_VAL		0x8
+
+struct jh8100_pdm_priv {
+	struct regmap *regmap;
+	struct regmap *syscon_regmap;
+	struct device *dev;
+	struct clk *dmic_clk;
+	struct clk *icg_clk;
+	struct reset_control *rst;
+	unsigned int syscon_args[2]; /* [0]: offset, [1]: mask */
+};
+
+static const DECLARE_TLV_DB_SCALE(volume_tlv, -9450, 150, 0);
+
+static const struct snd_kcontrol_new jh8100_pdm_snd_controls[] = {
+	SOC_SINGLE("DC compensation Control", JH8100_PDM_DMIC_CTRL0, 30, 1, 0),
+	SOC_SINGLE("High Pass Filter Control", JH8100_PDM_DMIC_CTRL0, 28, 1, 0),
+	SOC_SINGLE("Left Channel Volume Control", JH8100_PDM_DMIC_CTRL0, 23, 1, 0),
+	SOC_SINGLE("Right Channel Volume Control", JH8100_PDM_DMIC_CTRL0, 22, 1, 0),
+	SOC_SINGLE_TLV("Volume", JH8100_PDM_DMIC_CTRL0, 16, 0x3F, 1, volume_tlv),
+	SOC_SINGLE("Data MSB Shift", JH8100_PDM_DMIC_CTRL0, 1, 7, 0),
+	SOC_SINGLE("SCALE", JH8100_PDM_DC_SCALE0, 0, 0x3F, 0),
+	SOC_SINGLE("DC offset", JH8100_PDM_DC_SCALE0, 8, 0xFFFFF, 0),
+};
+
+static void jh8100_pdm_enable(struct regmap *map)
+{
+	/* Left and Right Channel Volume Control Enable */
+	regmap_update_bits(map, JH8100_PDM_DMIC_CTRL0, JH8100_PDM_DMIC_RVOL_MASK, 0);
+	regmap_update_bits(map, JH8100_PDM_DMIC_CTRL0, JH8100_PDM_DMIC_LVOL_MASK, 0);
+}
+
+static void jh8100_pdm_disable(struct regmap *map)
+{
+	/* Left and Right Channel Volume Control Disable */
+	regmap_update_bits(map, JH8100_PDM_DMIC_CTRL0,
+			   JH8100_PDM_DMIC_RVOL_MASK, JH8100_PDM_DMIC_RVOL_MASK);
+	regmap_update_bits(map, JH8100_PDM_DMIC_CTRL0,
+			   JH8100_PDM_DMIC_LVOL_MASK, JH8100_PDM_DMIC_LVOL_MASK);
+}
+
+static int jh8100_pdm_dai_probe(struct snd_soc_dai *dai)
+{
+	struct jh8100_pdm_priv *priv = snd_soc_dai_get_drvdata(dai);
+
+	/* Change I2SDIN source to PDM */
+	regmap_update_bits(priv->syscon_regmap, priv->syscon_args[0],
+			   priv->syscon_args[1], priv->syscon_args[1]);
+
+	return 0;
+}
+
+static int jh8100_pdm_trigger(struct snd_pcm_substream *substream, int cmd,
+			      struct snd_soc_dai *dai)
+{
+	struct jh8100_pdm_priv *priv = snd_soc_dai_get_drvdata(dai);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		jh8100_pdm_enable(priv->regmap);
+		return 0;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		jh8100_pdm_disable(priv->regmap);
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int jh8100_pdm_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	struct jh8100_pdm_priv *priv = snd_soc_dai_get_drvdata(dai);
+
+	/* set pdm_mclk,  PDM MCLK = 128 * LRCLK */
+	return clk_set_rate(priv->dmic_clk, 128 * params_rate(params));
+}
+
+static const struct snd_soc_dai_ops jh8100_pdm_dai_ops = {
+	.probe		= jh8100_pdm_dai_probe,
+	.trigger	= jh8100_pdm_trigger,
+	.hw_params	= jh8100_pdm_hw_params,
+};
+
+/* Use DMIC1 in PDM */
+static void jh8100_pdm_module_init(struct jh8100_pdm_priv *priv)
+{
+	/* Reset */
+	regmap_update_bits(priv->regmap, JH8100_PDM_DMIC_CTRL0,
+			   JH8100_PDM_SW_RST_MASK, 0x00);
+	regmap_update_bits(priv->regmap, JH8100_PDM_DMIC_CTRL0,
+			   JH8100_PDM_SW_RST_MASK, JH8100_PDM_SW_RST_RELEASE);
+
+	/* Make sure the device is initially disabled */
+	jh8100_pdm_disable(priv->regmap);
+
+	/* MUTE */
+	regmap_update_bits(priv->regmap, JH8100_PDM_DMIC_CTRL0,
+			   JH8100_PDM_DMIC_VOL_MASK, JH8100_PDM_VOL_DB_MUTE);
+
+	/* UNMUTE */
+	regmap_update_bits(priv->regmap, JH8100_PDM_DMIC_CTRL0,
+			   JH8100_PDM_DMIC_VOL_MASK, JH8100_PDM_VOL_DB_MAX);
+
+	/* enable high pass filter */
+	regmap_update_bits(priv->regmap, JH8100_PDM_DMIC_CTRL0,
+			   JH8100_PDM_DMIC_HPF_EN, JH8100_PDM_DMIC_HPF_EN);
+
+	/* PDM work as slave mode */
+	regmap_update_bits(priv->regmap, JH8100_PDM_DMIC_CTRL0,
+			   JH8100_PDM_DMIC_I2S_SLAVE, JH8100_PDM_DMIC_I2S_SLAVE);
+
+	/* enable fast mode */
+	regmap_update_bits(priv->regmap, JH8100_PDM_DMIC_CTRL0,
+			   JH8100_PDM_DMIC_FASTMODE_MASK, JH8100_PDM_DMIC_FASTMODE_MASK);
+
+	/* default dmic msb shift 0 */
+	regmap_update_bits(priv->regmap, JH8100_PDM_DMIC_CTRL0,
+			   JH8100_PDM_DMIC_MSB_MASK, 0);
+
+	/* default scale: 0x8 */
+	regmap_update_bits(priv->regmap, JH8100_PDM_DC_SCALE0,
+			   JH8100_DMIC_SCALE_MASK, JH8100_DMIC_SCALE_DEF_VAL);
+
+	regmap_update_bits(priv->regmap, JH8100_PDM_DC_SCALE0,
+			   JH8100_DMIC_DCOFF1_MASK, JH8100_DMIC_DCOFF1_DEF_VAL);
+
+	regmap_update_bits(priv->regmap, JH8100_PDM_DC_SCALE0,
+			   JH8100_DMIC_DCOFF3_MASK, JH8100_DMIC_DCOFF3_DEF_VAL);
+}
+
+#define JH8100_PDM_RATES	(SNDRV_PCM_RATE_8000 | \
+				SNDRV_PCM_RATE_11025 | \
+				SNDRV_PCM_RATE_16000)
+
+#define JH8100_PDM_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+				SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver jh8100_pdm_dai_drv = {
+	.name = "PDM",
+	.id = 0,
+	.capture = {
+		.stream_name	= "Capture",
+		.channels_min	= 1,
+		.channels_max	= 2,
+		.rates		= JH8100_PDM_RATES,
+		.formats	= JH8100_PDM_FORMATS,
+	},
+	.ops = &jh8100_pdm_dai_ops,
+	.symmetric_rate = 1,
+};
+
+static int jh8100_pdm_component_probe(struct snd_soc_component *component)
+{
+	struct jh8100_pdm_priv *priv = snd_soc_component_get_drvdata(component);
+
+	snd_soc_component_init_regmap(component, priv->regmap);
+	snd_soc_add_component_controls(component, jh8100_pdm_snd_controls,
+				       ARRAY_SIZE(jh8100_pdm_snd_controls));
+
+	return 0;
+}
+
+static int jh8100_pdm_crg_enable(struct jh8100_pdm_priv *priv)
+{
+	int ret;
+
+	ret = clk_prepare_enable(priv->icg_clk);
+	if (ret)
+		return dev_err_probe(priv->dev, ret, "failed to enable icg clock\n");
+
+	ret = reset_control_deassert(priv->rst);
+	if (ret) {
+		dev_err(priv->dev, "failed to deassert pdm_apb\n");
+		goto disable_icg;
+	}
+
+	return 0;
+
+disable_icg:
+	clk_disable_unprepare(priv->icg_clk);
+	return ret;
+}
+
+#ifdef CONFIG_PM
+static int jh8100_pdm_runtime_suspend(struct device *dev)
+{
+	struct jh8100_pdm_priv *priv = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(priv->icg_clk);
+	return 0;
+}
+
+static int jh8100_pdm_runtime_resume(struct device *dev)
+{
+	struct jh8100_pdm_priv *priv = dev_get_drvdata(dev);
+
+	return jh8100_pdm_crg_enable(priv);
+}
+#endif
+
+#ifdef CONFIG_PM_SLEEP
+static int jh8100_pdm_suspend(struct snd_soc_component *component)
+{
+	return pm_runtime_force_suspend(component->dev);
+}
+
+static int jh8100_pdm_resume(struct snd_soc_component *component)
+{
+	return pm_runtime_force_resume(component->dev);
+}
+
+#else
+#define jh8100_pdm_suspend	NULL
+#define jh8100_pdm_resume	NULL
+#endif
+
+static const struct snd_soc_component_driver jh8100_pdm_component_drv = {
+	.name = "jh8100-pdm",
+	.probe = jh8100_pdm_component_probe,
+	.suspend = jh8100_pdm_suspend,
+	.resume = jh8100_pdm_resume,
+};
+
+static const struct regmap_config jh8100_pdm_regmap_cfg = {
+	.reg_bits	= 32,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+	.max_register	= 0x20,
+};
+
+static int jh8100_pdm_crg_init(struct jh8100_pdm_priv *priv)
+{
+	priv->dmic_clk = devm_clk_get(priv->dev, "dmic");
+	if (IS_ERR(priv->dmic_clk))
+		return dev_err_probe(priv->dev, PTR_ERR(priv->dmic_clk),
+				     "failed to get dmic clock.\n");
+
+	priv->icg_clk = devm_clk_get(priv->dev, "icg");
+	if (IS_ERR(priv->icg_clk))
+		return dev_err_probe(priv->dev, PTR_ERR(priv->icg_clk),
+				     "failed to get icg clock.\n");
+
+	priv->rst = devm_reset_control_get_exclusive(priv->dev, NULL);
+	if (IS_ERR(priv->rst))
+		return dev_err_probe(priv->dev, PTR_ERR(priv->rst), "failed to get pdm reset\n");
+
+	return jh8100_pdm_crg_enable(priv);
+}
+
+static int jh8100_pdm_probe(struct platform_device *pdev)
+{
+	struct jh8100_pdm_priv *priv;
+	void __iomem *base;
+	int ret;
+	u8 using_modulex;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	platform_set_drvdata(pdev, priv);
+
+	if (!device_property_read_u8(&pdev->dev, "starfive,pdm-modulex", &using_modulex))
+		if (using_modulex == 1)
+			base += JH8100_PDM_MODULEX_SHIFT; /* Use module 1 */
+
+	priv->regmap = devm_regmap_init_mmio(&pdev->dev, base, &jh8100_pdm_regmap_cfg);
+	if (IS_ERR(priv->regmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->regmap),
+				     "failed to init regmap\n");
+
+	priv->dev = &pdev->dev;
+	ret = jh8100_pdm_crg_init(priv);
+	if (ret)
+		return ret;
+
+	priv->syscon_regmap = syscon_regmap_lookup_by_phandle_args(pdev->dev.of_node,
+								   "starfive,syscon",
+								   2, priv->syscon_args);
+	if (IS_ERR(priv->syscon_regmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->syscon_regmap),
+				     "get the syscon regmap failed\n");
+
+	ret = devm_snd_soc_register_component(&pdev->dev, &jh8100_pdm_component_drv,
+					      &jh8100_pdm_dai_drv, 1);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to register pdm dai\n");
+
+	jh8100_pdm_module_init(priv);
+
+	pm_runtime_enable(&pdev->dev);
+	if (pm_runtime_enabled(&pdev->dev))
+		clk_disable_unprepare(priv->icg_clk);
+
+	return 0;
+}
+
+static int jh8100_pdm_remove(struct platform_device *pdev)
+{
+	struct jh8100_pdm_priv *priv = platform_get_drvdata(pdev);
+
+	/* Change I2SDIN source to default(PAD) */
+	regmap_update_bits(priv->syscon_regmap, priv->syscon_args[0],
+			   priv->syscon_args[1], 0);
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static const struct of_device_id jh8100_pdm_of_match[] = {
+	{.compatible = "starfive,jh8100-pdm",},
+	{}
+};
+MODULE_DEVICE_TABLE(of, jh8100_pdm_of_match);
+
+static const struct dev_pm_ops jh8100_pdm_pm_ops = {
+	SET_RUNTIME_PM_OPS(jh8100_pdm_runtime_suspend,
+			   jh8100_pdm_runtime_resume, NULL)
+};
+
+static struct platform_driver jh8100_pdm_driver = {
+	.driver = {
+		.name = "jh8100-pdm",
+		.of_match_table = jh8100_pdm_of_match,
+		.pm = &jh8100_pdm_pm_ops,
+	},
+	.probe = jh8100_pdm_probe,
+	.remove = jh8100_pdm_remove,
+};
+module_platform_driver(jh8100_pdm_driver);
+
+MODULE_AUTHOR("Xingyu Wu <xingyu.wu@starfivetech.com>");
+MODULE_AUTHOR("Walker Chen <walker.chen@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive JH8100 PDM Controller Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


