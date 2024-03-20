Return-Path: <linux-kernel+bounces-108685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CFC880E6B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B672837E4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5453A1BF;
	Wed, 20 Mar 2024 09:17:34 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2102.outbound.protection.partner.outlook.cn [139.219.17.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BB939FD0;
	Wed, 20 Mar 2024 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710926252; cv=fail; b=dYOGupod0qzpnJ/53Zx0oynKwgRJ/cdg7lR/zOKt39RmHV80MHS/s1tjS1f9B5X6+duq6wLp/mftGcdU6LhOHx8zahTKKKvL0gcxfD4qvrw6EKw0m2Zg5IlPBNjPIEfJqG+DjgZhlh+OwayKfst9Gy1fMrMb3qHcEsIqNDR/Dm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710926252; c=relaxed/simple;
	bh=wldLxHIps1iuRB1jZIS1RTByObh7m2y/0mUSyjhkgHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rZuc1ED3HO6uutTc90kaK1hh4Q6PMBIXjvzmfudMwicf3mEuhWssS5d0WiflYm1kbeE1PWAucLZBar4lSWZLRfZJhAuUSw0fuFdu3+jLqY5xbknlu9Ft9+MOtuiBhpISiKCSQzTOxIBphvu5YraavilMwi3tQiEXcOPmZB2I1L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPC/U8hK46TV217lAD5hcfYYzZeRdhzj3gnhnVLXeriWbTx6GSebkUHIyWHqT1zyo1k29TS44E25ch4FVOikqC4uIFTSgc4ngJHh3d19KLkBVW/JZPCzE+A2YuO2eHO24GW6Xy4LaK8lDN0bbWqBTM2OBVWPvYz+pPHYh1kGD6GA4BxetkC76KdlMMEp04/PZ/+y2E7KOC7bf7t4FbBSIDub4lQCx2o2dh5FCmmBcCeWNHwjBIS5KEb+wOYYwXmWMj4nU7J11/50RviuH1IUf8t0tjiUb04mPGkpQ5ZLbg4x7JSWNvWVG1p/q1PEGryRYMXH1gTD31NbjqJOA/to4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOUfjkCTBjLcHR1HlzSzaiiLLbSWgFnU1QVVaUsJq/w=;
 b=eqGWlc0L0ctzrg65IjenbrrBb3f/Hd4MLJ7f35BfyPi9iQMsAYdkhPSPVcSScwJy10EFzqmIlyzAPriubwi4Y7oJtTEb7M5Sl2bsuMrEsdtJEr6DgsYYZ1Bmy3ct8SOEThT144c2B/UVZrYIGf3gSl5VSYKGnaFxhXWodF4H3g/nHX1n0TcMn6U0x2DVsqGLSRtPmvNzZHUq/NKaPXXcT+CGn2KstazXMuKrO2+2m7LfMVYHHAnnq+2RuJT2+9fUkzziS9XUUXdEPdcfHOKjIxQ+IATFcCoKMwgw9n4oBIWmDGIHWeFas2UiklIbbUKX4eEnatL10L+OpzT2kibXZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1034.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22; Wed, 20 Mar
 2024 09:02:48 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::7d98:f313:525d:fea6]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::7d98:f313:525d:fea6%6])
 with mapi id 15.20.7386.022; Wed, 20 Mar 2024 09:02:48 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Claudiu Beznea <Claudiu.Beznea@microchip.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>
Cc: Xingyu Wu <xingyu.wu@starfivetech.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH v2 2/2] ASoC: cdns: Add drivers of Cadence Multi-Channel I2S Controller
Date: Wed, 20 Mar 2024 17:02:39 +0800
Message-Id: <20240320090239.168743-3-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240320090239.168743-1-xingyu.wu@starfivetech.com>
References: <20240320090239.168743-1-xingyu.wu@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0025.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::34) To NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB0956:EE_|NTZPR01MB1034:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c7b4f7a-2167-4717-35f1-08dc48bc8394
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2TpKxCIqj1YGE/knlOHDK20JfRkVSe5XEM7f1M2sKqt2L1WdigiD6zbu0snIb/U59mN00iN3IUaJ/0qRLkK4yuny6qwJtdAq5DlFmEG96ekEwjFm2IG3jdCjtmQjQKYuwtOgHY5rBFgR7PngIlQfGPrmvUbY6Q6U3IhmabueQ88GL3U0O3nN3aSA2WCLIQtz1NQ8EiDyCM8BjtwmLMX0yAfrr/BQ1zpQwktA9ZTrga6vzF1OVaRlI7SEb2J1XIR8ckTuFJx/o7p0gj/OZZE54/hqwQB/XDYdrNOIBP4sf0tkqwhZNOgZ9Yku3d+AM1yYKmZ7chlcQGBIyzSiIGo1mkhAEkFMv1Sf00WZFKQKLYzZolwV0e2AeC3ulH9HPyK1RdLOn3Vrr/F/DwIQW7SnHjPlhZnnqP/H1eR1c0mjmpmd7p7Wb/UcwuZn4sfUm/Ud/1v2Z07rwVtq8ZcMCeG0M5vkyjK/LLJuYLRWxl5/SJv+eP36OMdsQRQ0LrIRlqZVxIqV5T7aAHNZHZ4BboZOzEfc/0+OknaIA2IU7MRu5goE2zncsceUinRm8qwapaDNfTwCHXfq5bfczj/KH/gVno+Ert+KK1IVWig2Ox3xpbFXucIIAjgFprPnllKZh+v+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(7416005)(41320700004)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UgTsg/XytEDOlZkwmV7r4nZgpUgIEzokeWPCOg3sofNDGM/DO1JhiTq12GaZ?=
 =?us-ascii?Q?4KmzVSfeUcodStvp/ININNlKarREwrLg3xA66fOdDx/mCKx1pfL4FNzoTF7c?=
 =?us-ascii?Q?Yjx3QNuxLBNaRmlcdpLZGh0AdrH880atLdMgatpRd6K4l5CT232BU288v56L?=
 =?us-ascii?Q?BjIFSvCQdxDhKq6KQ9BXZfZolAKFnxUJeO27OAiVwzIaMtEQWrr80Jb3+2r2?=
 =?us-ascii?Q?NzvSNdjXQzJ52FJI/a/Zv6//4zPHCp2sHdPfrQdoNx84u8gV1XrEocfqXdiq?=
 =?us-ascii?Q?uSK68OTTBYLcLAcOOR8Gqb6eEFol9RP0ru2SsKKtEbfGboiqsSikXEos43+W?=
 =?us-ascii?Q?y2LvnzBJORntzEdQsq6KWxT8O/U+ZiEKpVd25nyfPck99xRqQqpmMl1FOhIq?=
 =?us-ascii?Q?V3BYGORGYMDp0PX+BHybjKjsWORKb2ewoqV2Mk03uSIEjKr50Fe7Hy4pt8iJ?=
 =?us-ascii?Q?zSQ5oLbx8RpI/j6JcaUPhZjjVZV1Onx80xcSVdliO57TnOHMH94BFgKBbUG6?=
 =?us-ascii?Q?Vj1kGc6gThrNny/6PeqNLG5M/SyWbVp+WUG/4nJSYTA9Hn7qSfFBxpGRNJUJ?=
 =?us-ascii?Q?q0nc3CVRt+/BsJJmzTYIRBB05upW8vrOQnnGgWQx+HhsKYUwH/Fxe2+toRwJ?=
 =?us-ascii?Q?ADJ2JYM9YgYJdHaHCOxrk8UzNNp5bQ6KukyzvaCJSSr0xFsgI9mKEzlC17iL?=
 =?us-ascii?Q?vterFSCYC80jul3ZOlvh/ZjJHlu8pJLZy2NAxWc94iNOT3fRcz/MJnPHFWIr?=
 =?us-ascii?Q?QUVhUeJO908UEATjC1Wx3S90wP4iHGVdV6V5DW/rGsQbOz+oWSL64fbXlgM2?=
 =?us-ascii?Q?oJ1B+zyeY+167bVgNZ7jFLuVFwZb/YXofwRbY7FrcdPfz4X0L3PNeGnxstd8?=
 =?us-ascii?Q?Pusy0oGV7Elx5K58F+XCupa7Y1K8w8X1bJSf+YesiSJV0sarfQs88OOFceg4?=
 =?us-ascii?Q?9cawGT5ZbKp2ayOVPhCQM0otL6AeX7l1ziKkieauDRfB1i+RaxL9S4KqUlAx?=
 =?us-ascii?Q?nmmbGY2rp3bhq2M1sik6g06vn3e85+YQX+wOTPq71JDFaTLsQbbXSkBoVqxs?=
 =?us-ascii?Q?6rT2Xozd776qAW17YkE5bgO7qrW23oXqgKBQC63V7Fa7zafTvAeMG6zXREWB?=
 =?us-ascii?Q?RYNr9TlSJD+boo4zocW4GHcYP1FtkqYa5z1ykxSl+0ZEjE2Wefukn/ZE47Tz?=
 =?us-ascii?Q?9fn+xKH2GYU9soth80fgUoHNmmFa5NVW7B8glDtcB0wlTjBVeNEze7He+WSH?=
 =?us-ascii?Q?iQAccycnffyR2XlT0ihl/x/Uww8+EfvGTFv6kAJjDJzq3RXYI09ZIZd3q/rA?=
 =?us-ascii?Q?Yag7WfNqcTJ8/AUNfO5YTTOCaRMqQI+ROcmqDAZ/35tDmWkxzoMlgIDCHe/z?=
 =?us-ascii?Q?7iUCle3SFPjsmRddpqfAcKQ1IBImcyE9wqY3AXjhWxXh4DkuXC81Ccq5ZJfd?=
 =?us-ascii?Q?7jLDe5O7LPqptJiXDKFbDE2hPNHvWE0mHp29Uv1lZR2g75tUPAhgVFTLhwWk?=
 =?us-ascii?Q?8M+uy6VBQz4SfWfU+x/lh/3W1NLLkGhXo0q3ZvqBRcOxjwnqNuQVN/hLWG+J?=
 =?us-ascii?Q?OGWu0I+BUdDbmSqeLGpSveEs3ziCyOEU5NcMPHrusUP7ctz3/WrWcz2bCuIT?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7b4f7a-2167-4717-35f1-08dc48bc8394
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 09:02:48.0212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fs3UmaKkpajYcIA7tXbyrq6D7MM/EUPINNbI8ZJ3n0O9CrMujQlHV9tvyPb3qCGpbbordc2zWVm15/z2oN6/xdGzsaVngH2L4lvbuOQEp/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1034

Add the drivers of Cadence Multi-Channel I2S Controller.

The Cadence I2S Controller implements a function of the multi-channel
(up to 8-channel) bus. Each stereo channel combines functions of a
transmitter and a receiver. Each channel has independent and internal
gating, clock and interruption control. It alos support some of these
channels are used as playback and others can also be used as record
in the same time.

The I2S-MC is used on the StarFive JH8100 SoC and add the compatible
for this.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 MAINTAINERS                      |   6 +
 sound/soc/Kconfig                |   1 +
 sound/soc/Makefile               |   1 +
 sound/soc/cdns/Kconfig           |  18 +
 sound/soc/cdns/Makefile          |   3 +
 sound/soc/cdns/cdns-i2s-mc-pcm.c | 262 +++++++++++
 sound/soc/cdns/cdns-i2s-mc.c     | 724 +++++++++++++++++++++++++++++++
 sound/soc/cdns/cdns-i2s-mc.h     | 157 +++++++
 8 files changed, 1172 insertions(+)
 create mode 100644 sound/soc/cdns/Kconfig
 create mode 100644 sound/soc/cdns/Makefile
 create mode 100644 sound/soc/cdns/cdns-i2s-mc-pcm.c
 create mode 100644 sound/soc/cdns/cdns-i2s-mc.c
 create mode 100644 sound/soc/cdns/cdns-i2s-mc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1aabf1c15bb3..640dd70470e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4560,6 +4560,12 @@ L:	linux-mm@kvack.org
 S:	Maintained
 F:	tools/testing/selftests/cachestat/test_cachestat.c
 
+CADENCE MULTI CHANNEL I2S CONTROLLER DRIVER
+M:	Xingyu Wu <xingyu.wu@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/sound/cdns,i2s-mc.yaml
+F:	sound/soc/cdns/cdns-i2s-mc*
+
 CADENCE MIPI-CSI2 BRIDGES
 M:	Maxime Ripard <mripard@kernel.org>
 L:	linux-media@vger.kernel.org
diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 439fa631c342..99133baff518 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -83,6 +83,7 @@ source "sound/soc/apple/Kconfig"
 source "sound/soc/atmel/Kconfig"
 source "sound/soc/au1x/Kconfig"
 source "sound/soc/bcm/Kconfig"
+source "sound/soc/cdns/Kconfig"
 source "sound/soc/cirrus/Kconfig"
 source "sound/soc/dwc/Kconfig"
 source "sound/soc/fsl/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 8376fdb217ed..d0d3d8d22eee 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_SND_SOC)	+= amd/
 obj-$(CONFIG_SND_SOC)	+= atmel/
 obj-$(CONFIG_SND_SOC)	+= au1x/
 obj-$(CONFIG_SND_SOC)	+= bcm/
+obj-$(CONFIG_SND_SOC)	+= cdns/
 obj-$(CONFIG_SND_SOC)	+= cirrus/
 obj-$(CONFIG_SND_SOC)	+= dwc/
 obj-$(CONFIG_SND_SOC)	+= fsl/
diff --git a/sound/soc/cdns/Kconfig b/sound/soc/cdns/Kconfig
new file mode 100644
index 000000000000..61ef718ebfe7
--- /dev/null
+++ b/sound/soc/cdns/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config SND_SOC_CADENCE_I2S_MC
+        tristate "Cadence I2S Multi-Channel Controller Device Driver"
+	depends on HAVE_CLK
+        select SND_SOC_GENERIC_DMAENGINE_PCM
+        help
+         Say Y or M if you want to add support for I2S driver for the
+         Cadence Multi-Channel I2S Controller device. The device supports
+         up to a maximum of 8 channels each for play and record.
+
+config SND_SOC_CADENCE_I2S_MC_PCM
+        bool "PCM PIO extension for CDNS I2S MC driver"
+        depends on SND_SOC_CADENCE_I2S_MC
+        help
+         Say Y or N if you want to add a custom ALSA extension that registers
+         a PCM and uses PIO to transfer data.
+         This functionality is specially suited for CDNS I2S-MC devices that
+         don't use DMA controller.
diff --git a/sound/soc/cdns/Makefile b/sound/soc/cdns/Makefile
new file mode 100644
index 000000000000..ca8c040e21df
--- /dev/null
+++ b/sound/soc/cdns/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_SND_SOC_CADENCE_I2S_MC) += cdns-i2s.o
+cdns-i2s-y := cdns-i2s-mc.o
+cdns-i2s-$(CONFIG_SND_SOC_CADENCE_I2S_MC_PCM) += cdns-i2s-mc-pcm.o
diff --git a/sound/soc/cdns/cdns-i2s-mc-pcm.c b/sound/soc/cdns/cdns-i2s-mc-pcm.c
new file mode 100644
index 000000000000..95ee9ad759a5
--- /dev/null
+++ b/sound/soc/cdns/cdns-i2s-mc-pcm.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence Multi-Channel I2S controller PCM driver
+ *
+ * Copyright (c) 2022-2023 StarFive Technology Co., Ltd.
+ */
+
+#include <linux/io.h>
+#include <linux/rcupdate.h>
+#include <sound/pcm_params.h>
+#include "cdns-i2s-mc.h"
+
+#define PERIOD_BYTES_MIN	4096
+#define BUFFER_BYTES_MAX	(3 * 2 * 8 * PERIOD_BYTES_MIN)
+#define PERIODS_MIN		2
+
+static unsigned int cdns_i2s_pcm_tx(struct cdns_i2s_dev *dev,
+				    struct snd_pcm_runtime *runtime,
+				    unsigned int tx_ptr, bool *period_elapsed,
+				    snd_pcm_format_t format)
+{
+	unsigned int period_pos = tx_ptr % runtime->period_size;
+	const u16 (*p16)[2] = (void *)runtime->dma_area;
+	const u32 (*p32)[2] = (void *)runtime->dma_area;
+	u32 data[2];
+	int i;
+
+	for (i = 0; i < CDNS_I2S_FIFO_DEPTH; i++) {
+		if (format == SNDRV_PCM_FORMAT_S16_LE) {
+			data[0] = p16[tx_ptr][0];
+			data[1] = p16[tx_ptr][1];
+		} else if (format == SNDRV_PCM_FORMAT_S32_LE) {
+			data[0] = p32[tx_ptr][0];
+			data[1] = p32[tx_ptr][1];
+		}
+
+		iowrite32(data[0], dev->base + CDNS_FIFO_MEM);
+		iowrite32(data[1], dev->base + CDNS_FIFO_MEM);
+		period_pos++;
+		if (++tx_ptr >= runtime->buffer_size)
+			tx_ptr = 0;
+	}
+
+	*period_elapsed = period_pos >= runtime->period_size;
+	return tx_ptr;
+}
+
+static unsigned int cdns_i2s_pcm_rx(struct cdns_i2s_dev *dev,
+				    struct snd_pcm_runtime *runtime,
+				    unsigned int rx_ptr, bool *period_elapsed,
+				    snd_pcm_format_t format)
+{
+	unsigned int period_pos = rx_ptr % runtime->period_size;
+	u16 (*p16)[2] = (void *)runtime->dma_area;
+	u32 (*p32)[2] = (void *)runtime->dma_area;
+	u32 data[2];
+	int i;
+
+	for (i = 0; i < CDNS_I2S_FIFO_DEPTH; i++) {
+		data[0] = ioread32(dev->base + CDNS_FIFO_MEM);
+		data[1] = ioread32(dev->base + CDNS_FIFO_MEM);
+		if (format == SNDRV_PCM_FORMAT_S16_LE) {
+			p16[rx_ptr][0] = data[0];
+			p16[rx_ptr][1] = data[1];
+		} else if (format == SNDRV_PCM_FORMAT_S32_LE) {
+			p32[rx_ptr][0] = data[0];
+			p32[rx_ptr][1] = data[1];
+		}
+
+		period_pos++;
+		if (++rx_ptr >= runtime->buffer_size)
+			rx_ptr = 0;
+	}
+
+	*period_elapsed = period_pos >= runtime->period_size;
+	return rx_ptr;
+}
+
+static const struct snd_pcm_hardware cdns_i2s_pcm_hardware = {
+	.info = SNDRV_PCM_INFO_INTERLEAVED |
+		SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_MMAP_VALID |
+		SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		SNDRV_PCM_INFO_PAUSE |
+		SNDRV_PCM_INFO_RESUME,
+	.rates = SNDRV_PCM_RATE_8000 |
+		SNDRV_PCM_RATE_11025 |
+		SNDRV_PCM_RATE_16000 |
+		SNDRV_PCM_RATE_22050 |
+		SNDRV_PCM_RATE_32000 |
+		SNDRV_PCM_RATE_44100 |
+		SNDRV_PCM_RATE_48000,
+	.rate_min = 8000,
+	.rate_max = 48000,
+	.formats = SNDRV_PCM_FMTBIT_S16_LE |
+		SNDRV_PCM_FMTBIT_S32_LE,
+	.channels_min = 2,
+	.channels_max = 2,
+	.buffer_bytes_max = BUFFER_BYTES_MAX,
+	.period_bytes_min = PERIOD_BYTES_MIN,
+	.period_bytes_max = BUFFER_BYTES_MAX / PERIODS_MIN,
+	.periods_min = PERIODS_MIN,
+	.periods_max = BUFFER_BYTES_MAX / PERIOD_BYTES_MIN,
+	.fifo_size = 16,
+};
+
+static void cdns_i2s_pcm_transfer(struct cdns_i2s_dev *dev, bool push)
+{
+	struct snd_pcm_substream *substream;
+	bool active, period_elapsed;
+
+	rcu_read_lock();
+	if (push)
+		substream = rcu_dereference(dev->tx_substream);
+	else
+		substream = rcu_dereference(dev->rx_substream);
+
+	active = substream && snd_pcm_running(substream);
+	if (active) {
+		unsigned int ptr;
+		unsigned int new_ptr;
+
+		if (push) {
+			ptr = READ_ONCE(dev->tx_ptr);
+			new_ptr = dev->tx_fn(dev, substream->runtime, ptr,
+					     &period_elapsed, dev->format);
+			cmpxchg(&dev->tx_ptr, ptr, new_ptr);
+		} else {
+			ptr = READ_ONCE(dev->rx_ptr);
+			new_ptr = dev->rx_fn(dev, substream->runtime, ptr,
+					     &period_elapsed, dev->format);
+			cmpxchg(&dev->rx_ptr, ptr, new_ptr);
+		}
+
+		if (period_elapsed)
+			snd_pcm_period_elapsed(substream);
+	}
+	rcu_read_unlock();
+}
+
+void cdns_i2s_pcm_push_tx(struct cdns_i2s_dev *dev)
+{
+	cdns_i2s_pcm_transfer(dev, true);
+}
+
+void cdns_i2s_pcm_pop_rx(struct cdns_i2s_dev *dev)
+{
+	cdns_i2s_pcm_transfer(dev, false);
+}
+
+static int cdns_i2s_pcm_open(struct snd_soc_component *component,
+			     struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct cdns_i2s_dev *dev = snd_soc_dai_get_drvdata(snd_soc_rtd_to_cpu(rtd, 0));
+
+	snd_soc_set_runtime_hwparams(substream, &cdns_i2s_pcm_hardware);
+	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
+	runtime->private_data = dev;
+
+	return 0;
+}
+
+static int cdns_i2s_pcm_close(struct snd_soc_component *component,
+			      struct snd_pcm_substream *substream)
+{
+	synchronize_rcu();
+	return 0;
+}
+
+static int cdns_i2s_pcm_hw_params(struct snd_soc_component *component,
+				  struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *hw_params)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct cdns_i2s_dev *dev = runtime->private_data;
+
+	dev->format = params_format(hw_params);
+	dev->tx_fn = cdns_i2s_pcm_tx;
+	dev->rx_fn = cdns_i2s_pcm_rx;
+
+	return 0;
+}
+
+static int cdns_i2s_pcm_trigger(struct snd_soc_component *component,
+				struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct cdns_i2s_dev *dev = runtime->private_data;
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			WRITE_ONCE(dev->tx_ptr, 0);
+			rcu_assign_pointer(dev->tx_substream, substream);
+		} else {
+			WRITE_ONCE(dev->rx_ptr, 0);
+			rcu_assign_pointer(dev->rx_substream, substream);
+		}
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			rcu_assign_pointer(dev->tx_substream, NULL);
+		else
+			rcu_assign_pointer(dev->rx_substream, NULL);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static snd_pcm_uframes_t cdns_i2s_pcm_pointer(struct snd_soc_component *component,
+					      struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct cdns_i2s_dev *dev = runtime->private_data;
+	snd_pcm_uframes_t pos;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		pos = READ_ONCE(dev->tx_ptr);
+	else
+		pos = READ_ONCE(dev->rx_ptr);
+
+	return pos < runtime->buffer_size ? pos : 0;
+}
+
+static int cdns_i2s_pcm_new(struct snd_soc_component *component,
+			    struct snd_soc_pcm_runtime *rtd)
+{
+	size_t size = cdns_i2s_pcm_hardware.buffer_bytes_max;
+
+	snd_pcm_set_managed_buffer_all(rtd->pcm,
+				       SNDRV_DMA_TYPE_CONTINUOUS,
+				       NULL, size, size);
+
+	return 0;
+}
+
+static const struct snd_soc_component_driver cdns_i2s_pcm_component = {
+	.open		= cdns_i2s_pcm_open,
+	.close		= cdns_i2s_pcm_close,
+	.hw_params	= cdns_i2s_pcm_hw_params,
+	.trigger	= cdns_i2s_pcm_trigger,
+	.pointer	= cdns_i2s_pcm_pointer,
+	.pcm_construct	= cdns_i2s_pcm_new,
+};
+
+int cdns_i2s_pcm_register(struct platform_device *pdev)
+{
+	return devm_snd_soc_register_component(&pdev->dev,
+					       &cdns_i2s_pcm_component,
+					       NULL, 0);
+}
diff --git a/sound/soc/cdns/cdns-i2s-mc.c b/sound/soc/cdns/cdns-i2s-mc.c
new file mode 100644
index 000000000000..0038f47fd74b
--- /dev/null
+++ b/sound/soc/cdns/cdns-i2s-mc.c
@@ -0,0 +1,724 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence Multi-Channel I2S controller driver
+ *
+ * The Cadence I2S Controller implements a function of the multi-channel
+ * (up to 8-channel) bus. Each stereo channel combines functions of a
+ * transmitter and a receiver. Each channel has independent and internal
+ * gating, clock and interruption control. It alos support some of these
+ * channels are used as playback and others can also be used as record
+ * in the same time.
+ *
+ * Copyright (c) 2023 StarFive Technology Co., Ltd.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include "cdns-i2s-mc.h"
+
+static void cdns_i2s_set_fifo_mask(struct cdns_i2s_dev *i2s, u32 type)
+{
+	unsigned int val = readl(i2s->base + CDNS_CID_CTRL);
+
+	val &= ~CDNS_I2S_IT_ALL;
+	val |= type;
+	writel(val, i2s->base + CDNS_CID_CTRL);
+}
+
+static inline void cdns_i2s_clear_int(struct cdns_i2s_dev *i2s)
+{
+	writel(0, i2s->base + CDNS_I2S_INTR_STAT);
+}
+
+static int cdns_i2s_reset_mask(struct cdns_i2s_dev *i2s, u32 mask)
+{
+	unsigned int val = readl(i2s->base + CDNS_I2S_CTRL);
+
+	val &= ~mask;
+	writel(val, i2s->base + CDNS_I2S_CTRL);
+
+	/* Wait for the reset bit to done and is set to 1 */
+	return readl_poll_timeout_atomic(i2s->base + CDNS_I2S_CTRL, val,
+					 (val & mask), 0,
+					 CDNS_FIFO_ACK_TIMEOUT_US);
+}
+
+/* Reset for TX and RX control unit  */
+static void cdns_i2s_reset_txrx_unit(struct cdns_i2s_dev *i2s)
+{
+	unsigned int val = readl(i2s->base + CDNS_I2S_CTRL);
+
+	val |= CDNS_I2S_CTRL_TXRX_RST;
+	writel(val, i2s->base + CDNS_I2S_CTRL);
+}
+
+static void cdns_i2s_set_ms_mode(struct cdns_i2s_dev *i2s)
+{
+	unsigned int val = readl(i2s->base + CDNS_I2S_CTRL);
+
+	val &= ~(CDNS_I2S_CTRL_T_MS_MASK | CDNS_I2S_CTRL_R_MS_MASK);
+	val |= (FIELD_PREP(CDNS_I2S_CTRL_T_MS_MASK, i2s->tx_sync_ms_mode) |
+		FIELD_PREP(CDNS_I2S_CTRL_R_MS_MASK, i2s->rx_sync_ms_mode));
+
+	writel(val, i2s->base + CDNS_I2S_CTRL);
+}
+
+/* The threshold of almost empty & full config */
+static void cdns_i2s_set_aempty_afull_th(struct cdns_i2s_dev *i2s,
+					 unsigned int aempty,
+					 unsigned int afull)
+{
+	unsigned int val = aempty | (afull << CDNS_TRFIFO_CTRL_AFULL_SHIFT);
+
+	writel(val, i2s->base + CDNS_TFIFO_CTRL);
+	writel(val, i2s->base + CDNS_RFIFO_CTRL);
+}
+
+static void cdns_i2s_set_channel_strobes(struct cdns_i2s_dev *i2s,
+					 u32 ch, bool strobe)
+{
+	unsigned int val = readl(i2s->base + CDNS_CID_CTRL);
+
+	/* Active Low */
+	if (strobe)
+		val &= ~ch;
+	else
+		val |= ch;
+
+	writel(val, i2s->base + CDNS_CID_CTRL);
+}
+
+/* Enable TX or RX clock */
+static void cdns_i2s_enable_clock(struct cdns_i2s_dev *i2s,
+				  bool is_rx)
+{
+	unsigned int val = readl(i2s->base + CDNS_CID_CTRL);
+	unsigned int mask = (is_rx ? CDNS_CID_CTRL_STROBE_TX :
+			     CDNS_CID_CTRL_STROBE_RX);
+
+	/* Active Low */
+	val &= ~mask;
+	writel(val, i2s->base + CDNS_CID_CTRL);
+}
+
+static void cdns_i2s_set_transmitter_receiver(struct cdns_i2s_dev *i2s,
+					      u32 ch, bool is_transmit)
+{
+	unsigned int val = readl(i2s->base + CDNS_I2S_CTRL);
+
+	/* 1: Transmitter, 0: Receiver */
+	if (is_transmit)
+		val |= (ch << CDNS_I2S_CTRL_TR_CFG_0_SHIFT);
+	else
+		val &= ~(ch << CDNS_I2S_CTRL_TR_CFG_0_SHIFT);
+
+	writel(val, i2s->base + CDNS_I2S_CTRL);
+}
+
+static irqreturn_t cdns_i2s_irq_handler(int irq, void *data)
+{
+	struct cdns_i2s_dev *i2s = data;
+	unsigned int val = readl(i2s->base + CDNS_I2S_INTR_STAT);
+	irqreturn_t ret = IRQ_NONE;
+
+	cdns_i2s_clear_int(i2s);
+
+	if (val & CDNS_I2S_STAT_TX_UNDERRUN)
+		dev_err(i2s->dev, "TX underrun on channel %ld!\n",
+			FIELD_GET(CDNS_I2S_STAT_UNDERR_CODE, val));
+
+	if (val & CDNS_I2S_STAT_RX_OVERRUN)
+		dev_err(i2s->dev, "RX overrun on channel %ld!\n",
+			FIELD_GET(CDNS_I2S_STAT_OVERR_CODE, val));
+
+	/* FIFO is empty when playback start and I2S also need to push the data. */
+	if (val & (CDNS_I2S_STAT_TFIFO_AEMPTY | CDNS_I2S_STAT_TFIFO_EMPTY)) {
+		cdns_i2s_pcm_push_tx(i2s);
+		ret = IRQ_HANDLED;
+	}
+
+	if (val & CDNS_I2S_STAT_RFIFO_AFULL) {
+		cdns_i2s_pcm_pop_rx(i2s);
+		ret = IRQ_HANDLED;
+	}
+
+	return ret;
+}
+
+static void cdns_i2s_enable_channel(struct cdns_i2s_dev *i2s,
+				    u32 ch, bool enable)
+{
+	unsigned int val = readl(i2s->base + CDNS_I2S_CTRL);
+
+	/* Active High */
+	if (enable)
+		val |= ch;
+	else
+		val &= ~ch;
+
+	writel(val, i2s->base + CDNS_I2S_CTRL);
+}
+
+/* Bit masking all interrupt requests */
+static void cdns_i2s_set_all_irq_mask(struct cdns_i2s_dev *i2s, bool mask)
+{
+	unsigned int val = readl(i2s->base + CDNS_CID_CTRL);
+
+	/* Active Low: IRQ are masked */
+	if (mask)
+		val &= ~CDNS_CID_CTRL_INTREQ_MASK;
+	else
+		val |= CDNS_CID_CTRL_INTREQ_MASK;
+
+	writel(val, i2s->base + CDNS_CID_CTRL);
+}
+
+static void cdns_i2s_enable_channel_int(struct cdns_i2s_dev *i2s,
+					u32 ch, bool enable)
+{
+	unsigned int val = readl(i2s->base + CDNS_CID_CTRL);
+
+	/* Active High */
+	if (enable)
+		val |= (ch << CDNS_CID_CTRL_I2S_MASK_0_SHIFT);
+	else
+		val &= ~(ch << CDNS_CID_CTRL_I2S_MASK_0_SHIFT);
+
+	writel(val, i2s->base + CDNS_CID_CTRL);
+}
+
+static void cdns_i2s_channel_start(struct cdns_i2s_dev *i2s,
+				   u32 ch, bool is_transmit)
+{
+	cdns_i2s_set_transmitter_receiver(i2s, ch, is_transmit);
+	cdns_i2s_enable_channel(i2s, ch, true);
+	cdns_i2s_set_channel_strobes(i2s, ch, true);
+	if (i2s->irq >= 0)
+		cdns_i2s_enable_channel_int(i2s, ch, true);
+}
+
+static void cdns_i2s_channel_stop(struct cdns_i2s_dev *i2s, u32 ch)
+{
+	cdns_i2s_enable_channel(i2s, ch, false);
+	if (i2s->irq >= 0)
+		cdns_i2s_enable_channel_int(i2s, ch, false);
+}
+
+static int cdns_i2s_start(struct cdns_i2s_dev *i2s,
+			  struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned char max_ch = i2s->max_channels;
+	unsigned char i2s_ch;
+	int i;
+
+	/* Each channel is stereo */
+	i2s_ch = runtime->channels / 2;
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		if ((i2s_ch + i2s->tx_using_channels) > max_ch) {
+			dev_err(i2s->dev,
+				"Max %d channels: using %d for TX, do not support %d for RX\n",
+				max_ch, i2s->tx_using_channels, i2s_ch);
+			return -ENOMEM;
+		}
+
+		i2s->rx_using_channels = i2s_ch;
+		/* Enable channels from 0 to 'max_ch' as tx */
+		for (i = 0; i < i2s_ch; i++)
+			cdns_i2s_channel_start(i2s, CDNS_I2S_CM_0 << i,
+					       CDNS_I2S_TC_RECEIVER);
+
+	} else {
+		if ((i2s_ch + i2s->rx_using_channels) > max_ch) {
+			dev_err(i2s->dev,
+				"Max %d channels: using %d for RX, do not support %d for TX\n",
+				max_ch, i2s->rx_using_channels, i2s_ch);
+			return -ENOMEM;
+		}
+
+		i2s->tx_using_channels = i2s_ch;
+		/* Enable channels from 'max_ch' to 0 as rx */
+		for (i = (max_ch - 1); i > (max_ch - i2s_ch - 1); i--) {
+			if (i < 0)
+				return -EINVAL;
+
+			cdns_i2s_channel_start(i2s, CDNS_I2S_CM_0 << i,
+					       CDNS_I2S_TC_TRANSMITTER);
+		}
+	}
+	cdns_i2s_enable_clock(i2s, substream->stream);
+
+	if (i2s->irq >= 0)
+		cdns_i2s_set_all_irq_mask(i2s, false);
+
+	cdns_i2s_clear_int(i2s);
+
+	return 0;
+}
+
+static int cdns_i2s_stop(struct cdns_i2s_dev *i2s,
+			 struct snd_pcm_substream *substream)
+{
+	unsigned char i2s_ch;
+	int i;
+
+	cdns_i2s_clear_int(i2s);
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		i2s_ch = i2s->rx_using_channels;
+		for (i = 0; i < i2s_ch; i++)
+			cdns_i2s_channel_stop(i2s, (CDNS_I2S_CM_0 << i));
+
+		i2s->rx_using_channels = 0;
+	} else {
+		unsigned char max_ch = i2s->max_channels;
+
+		i2s_ch = i2s->tx_using_channels;
+		for (i = (max_ch - 1); i > (max_ch - i2s_ch - 1); i--) {
+			if (i < 0)
+				return -EINVAL;
+
+			cdns_i2s_channel_stop(i2s, (CDNS_I2S_CM_0 << i));
+		}
+
+		i2s->tx_using_channels = 0;
+	}
+
+	if (i2s->irq >= 0 && !i2s->tx_using_channels && !i2s->rx_using_channels)
+		cdns_i2s_set_all_irq_mask(i2s, true);
+
+	return 0;
+}
+
+static int cdns_i2s_startup(struct snd_pcm_substream *substream,
+			    struct snd_soc_dai *dai)
+{
+	struct cdns_i2s_dev *i2s = snd_soc_dai_get_drvdata(dai);
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct snd_soc_dai_link *dai_link = rtd->dai_link;
+
+	if (i2s->irq < 0)
+		dai_link->trigger_stop = SND_SOC_TRIGGER_ORDER_LDC;
+
+	return 0;
+}
+
+static void cdns_i2s_config(struct cdns_i2s_dev *i2s, int stream)
+{
+	unsigned int val = readl(i2s->base + CDNS_I2S_SRR);
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		val &= ~(CDNS_I2S_SRR_TRATE_MASK | CDNS_I2S_SRR_TRESOLUTION_MASK);
+		val |= (FIELD_PREP(CDNS_I2S_SRR_TRATE_MASK, i2s->sample_rate_param) |
+			FIELD_PREP(CDNS_I2S_SRR_TRESOLUTION_MASK, (i2s->resolution - 1)));
+	} else {
+		val &= ~(CDNS_I2S_SRR_RRATE_MASK | CDNS_I2S_SRR_RRESOLUTION_MASK);
+		val |= (FIELD_PREP(CDNS_I2S_SRR_RRATE_MASK, i2s->sample_rate_param) |
+			FIELD_PREP(CDNS_I2S_SRR_RRESOLUTION_MASK, (i2s->resolution - 1)));
+	}
+
+	writel(val, i2s->base + CDNS_I2S_SRR);
+}
+
+static int cdns_i2s_hw_params(struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *params,
+			      struct snd_soc_dai *dai)
+{
+	struct cdns_i2s_dev *i2s = snd_soc_dai_get_drvdata(dai);
+	unsigned int sample_rate = params_rate(params);
+	unsigned int channels = params_channels(params);
+	unsigned int fclk_hz = clk_get_rate(i2s->clks[2].clk); /* mclk_inner */
+	unsigned int bclk_rate;
+	int ret;
+	struct snd_dmaengine_dai_dma_data *dma_data;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dma_data = &i2s->tx_dma_data;
+	else
+		dma_data = &i2s->rx_dma_data;
+
+	switch (sample_rate) {
+	case 8000:
+	case 11025:
+	case 16000:
+	case 22050:
+	case 32000:
+	case 44100:
+	case 48000:
+		bclk_rate = sample_rate * 64;
+		break;
+	default:
+		dev_err(dai->dev, "%d rate not supported\n", sample_rate);
+		return -EINVAL;
+	}
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		dma_data->addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		dma_data->addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
+	default:
+		dev_err(i2s->dev, "unsupported PCM fmt\n");
+		return -EINVAL;
+	}
+
+	ret = clk_set_rate(i2s->clks[0].clk, bclk_rate); /* bclk */
+	if (ret < 0) {
+		dev_err(i2s->dev, "Can't set i2s bclk: %d\n", ret);
+		return ret;
+	}
+
+	i2s->resolution = params_width(params);
+	i2s->sample_rate_param = fclk_hz / (sample_rate * channels * 32);
+	cdns_i2s_config(i2s, substream->stream);
+
+	if (i2s->irq < 0)
+		snd_soc_dai_set_dma_data(dai, substream, dma_data);
+
+	return 0;
+}
+
+static int cdns_i2s_trigger(struct snd_pcm_substream *substream,
+			    int cmd, struct snd_soc_dai *dai)
+{
+	struct cdns_i2s_dev *i2s = snd_soc_dai_get_drvdata(dai);
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		ret = cdns_i2s_start(i2s, substream);
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		ret = cdns_i2s_stop(i2s, substream);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int cdns_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
+			    unsigned int fmt)
+{
+	struct cdns_i2s_dev *i2s = snd_soc_dai_get_drvdata(cpu_dai);
+	int ret = 0;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		i2s->tx_sync_ms_mode = CDNS_I2S_MASTER_MODE;
+		i2s->rx_sync_ms_mode = CDNS_I2S_MASTER_MODE;
+		cdns_i2s_set_ms_mode(i2s);
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		i2s->tx_sync_ms_mode = CDNS_I2S_SLAVE_MODE;
+		i2s->rx_sync_ms_mode = CDNS_I2S_SLAVE_MODE;
+		cdns_i2s_set_ms_mode(i2s);
+		break;
+	case SND_SOC_DAIFMT_CBM_CFS:
+	case SND_SOC_DAIFMT_CBS_CFM:
+		ret = -EINVAL;
+		break;
+	default:
+		dev_dbg(i2s->dev, "Invalid master/slave format\n");
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static int cdns_i2s_dai_probe(struct snd_soc_dai *dai)
+{
+	struct cdns_i2s_dev *i2s = snd_soc_dai_get_drvdata(dai);
+	struct snd_dmaengine_dai_dma_data *tx = &i2s->tx_dma_data;
+	struct snd_dmaengine_dai_dma_data *rx = &i2s->rx_dma_data;
+
+	if (i2s->irq >= 0)
+		return 0;
+
+	/* Buswidth will be set by framework */
+	tx->addr_width = DMA_SLAVE_BUSWIDTH_UNDEFINED;
+	tx->addr = i2s->phybase + CDNS_FIFO_MEM;
+	tx->maxburst = 16;
+	tx->fifo_size = 16;
+
+	rx->addr_width = DMA_SLAVE_BUSWIDTH_UNDEFINED;
+	rx->addr = i2s->phybase + CDNS_FIFO_MEM;
+	rx->maxburst = 16;
+	rx->fifo_size = 16;
+
+	snd_soc_dai_init_dma_data(dai, tx, rx);
+
+	return 0;
+}
+
+static const struct snd_soc_component_driver cdns_i2s_component = {
+	.name = "cdns-i2s-mc",
+};
+
+static const struct snd_soc_dai_ops cdns_i2s_dai_ops = {
+	.probe		= cdns_i2s_dai_probe,
+	.startup	= cdns_i2s_startup,
+	.hw_params	= cdns_i2s_hw_params,
+	.trigger	= cdns_i2s_trigger,
+	.set_fmt	= cdns_i2s_set_fmt,
+};
+
+static struct snd_soc_dai_driver cdns_i2s_dai = {
+	.name = "cdns-i2s-mc",
+	.id = 0,
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 8,
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE |
+			   SNDRV_PCM_FMTBIT_S32_LE,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 2,
+		.channels_max = 8,
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE |
+			   SNDRV_PCM_FMTBIT_S32_LE,
+	},
+	.ops = &cdns_i2s_dai_ops,
+	.symmetric_rate = 1,
+};
+
+#ifdef CONFIG_PM
+static int cdns_i2s_runtime_suspend(struct device *dev)
+{
+	struct cdns_i2s_dev *i2s = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(i2s->clks[1].clk); /* ICG clock */
+	return 0;
+}
+
+static int cdns_i2s_runtime_resume(struct device *dev)
+{
+	struct cdns_i2s_dev *i2s = dev_get_drvdata(dev);
+
+	return clk_prepare_enable(i2s->clks[1].clk); /* ICG clock */
+}
+#endif
+
+static int cdns_i2s_crg_init(struct cdns_i2s_dev *i2s)
+{
+	struct reset_control *reset = devm_reset_control_get_exclusive(i2s->dev, NULL);
+	int ret;
+
+	if (IS_ERR(reset))
+		return dev_err_probe(i2s->dev, PTR_ERR(reset), "failed to get i2s resets\n");
+
+	i2s->clks[0].id = "bclk";
+	i2s->clks[1].id = "icg";
+	i2s->clks[2].id = "mclk_inner";
+
+	ret = devm_clk_bulk_get(i2s->dev, ARRAY_SIZE(i2s->clks), i2s->clks);
+	if (ret)
+		return dev_err_probe(i2s->dev, ret, "failed to get i2s clocks\n");
+
+	ret = clk_prepare_enable(i2s->clks[1].clk); /* ICG clock */
+	if (ret)
+		return dev_err_probe(i2s->dev, ret, "failed to enable icg clock\n");
+
+	ret = reset_control_deassert(reset);
+	if (ret)
+		goto rst_err;
+
+	return 0;
+
+rst_err:
+	clk_disable_unprepare(i2s->clks[1].clk);
+	return ret;
+}
+
+static int cdns_i2s_init(struct cdns_i2s_dev *i2s)
+{
+	int ret	= cdns_i2s_crg_init(i2s);
+	unsigned int tmp;
+
+	if (ret)
+		return ret;
+
+	/* Software reset i2s controller */
+	ret = cdns_i2s_reset_mask(i2s, CDNS_I2S_CTRL_SFR_RST_MASK);
+	if (ret) {
+		dev_err(i2s->dev, "Failed to reset I2S.\n");
+		return ret;
+	}
+
+	/* reset TX FIFO */
+	ret = cdns_i2s_reset_mask(i2s, CDNS_I2S_CTRL_TFIFO_RST_MASK);
+	if (ret) {
+		dev_err(i2s->dev, "Failed to reset tx fifo.\n");
+		return ret;
+	}
+
+	/* reset RX FIFO */
+	ret = cdns_i2s_reset_mask(i2s, CDNS_I2S_CTRL_RFIFO_RST_MASK);
+	if (ret) {
+		dev_err(i2s->dev, "Failed to reset rx fifo.\n");
+		return ret;
+	}
+
+	/* Default master mode to init */
+	i2s->tx_sync_ms_mode = CDNS_I2S_MASTER_MODE;
+	i2s->rx_sync_ms_mode = CDNS_I2S_MASTER_MODE;
+	cdns_i2s_set_ms_mode(i2s);
+
+	/* Should reset it after setting Master/Slave mode */
+	cdns_i2s_reset_txrx_unit(i2s);
+	cdns_i2s_clear_int(i2s);
+
+	cdns_i2s_set_aempty_afull_th(i2s, (CDNS_I2S_FIFO_DEPTH / 4),
+				     (CDNS_I2S_FIFO_DEPTH / 4 * 3));
+	cdns_i2s_set_fifo_mask(i2s, CDNS_I2S_IT_TFIFO_AEMPTY |
+			       CDNS_I2S_IT_RFIFO_AFULL);
+
+	i2s->rx_using_channels = 0;
+	i2s->tx_using_channels = 0;
+
+	/* starfive,i2s-max-channels is unique property for JH8100 SoC and default max channels 8 */
+	ret = device_property_read_u32(i2s->dev, "starfive,i2s-max-channels", &tmp);
+	if (ret) {
+		i2s->max_channels = CDNS_I2S_CHANNEL_MAX;
+	} else {
+		if (tmp > CDNS_I2S_CHANNEL_MAX) {
+			dev_err(i2s->dev,
+				"The number %d of max channels from DTS is out of range!\n",
+				tmp);
+			return -EINVAL;
+		}
+
+		i2s->max_channels = tmp;
+	}
+
+	return 0;
+}
+
+static int cdns_i2s_probe(struct platform_device *pdev)
+{
+	struct cdns_i2s_dev *i2s;
+	struct resource *res;
+	int ret;
+
+	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
+	if (!i2s) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	platform_set_drvdata(pdev, i2s);
+
+	i2s->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(i2s->base)) {
+		ret = PTR_ERR(i2s->base);
+		goto err;
+	}
+
+	i2s->dev = &pdev->dev;
+	i2s->phybase = res->start;
+
+	ret = cdns_i2s_init(i2s);
+	if (ret)
+		goto err;
+
+	i2s->irq = platform_get_irq(pdev, 0);
+	if (i2s->irq >= 0) {
+		ret = devm_request_irq(&pdev->dev, i2s->irq, cdns_i2s_irq_handler,
+				       0, pdev->name, i2s);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "request_irq failed\n");
+			goto err;
+		}
+	}
+
+	ret = devm_snd_soc_register_component(&pdev->dev,
+					      &cdns_i2s_component,
+					      &cdns_i2s_dai, 1);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "couldn't register component\n");
+		goto err;
+	}
+
+	if (i2s->irq >= 0)
+		ret = cdns_i2s_pcm_register(pdev);
+	else
+		ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
+
+	if (ret) {
+		dev_err(&pdev->dev, "could not register pcm: %d\n", ret);
+		goto err;
+	}
+
+	pm_runtime_enable(&pdev->dev);
+	if (pm_runtime_enabled(&pdev->dev))
+		cdns_i2s_runtime_suspend(&pdev->dev);
+
+	dev_dbg(&pdev->dev, "I2S supports %d stereo channels with %s.\n",
+		i2s->max_channels, ((i2s->irq < 0) ? "dma" : "interrupt"));
+
+	return 0;
+
+err:
+	return ret;
+}
+
+static int cdns_i2s_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		cdns_i2s_runtime_suspend(&pdev->dev);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id cdns_i2s_of_match[] = {
+	{ .compatible = "cdns,i2s-mc", },
+	{ .compatible = "starfive,jh8100-i2s", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, cdns_i2s_of_match);
+#endif
+
+static const struct dev_pm_ops cdns_i2s_pm_ops = {
+	SET_RUNTIME_PM_OPS(cdns_i2s_runtime_suspend,
+			   cdns_i2s_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+};
+
+static struct platform_driver cdns_i2s_driver = {
+	.probe   = cdns_i2s_probe,
+	.remove  = cdns_i2s_remove,
+	.driver  = {
+		.name = "cdns-i2s-mc",
+		.of_match_table = of_match_ptr(cdns_i2s_of_match),
+		.pm = &cdns_i2s_pm_ops,
+	},
+};
+
+module_platform_driver(cdns_i2s_driver);
+
+MODULE_AUTHOR("Xingyu Wu <xingyu.wu@starfivetech.com>");
+MODULE_DESCRIPTION("Cadence Multi-Channel I2S controller driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/cdns/cdns-i2s-mc.h b/sound/soc/cdns/cdns-i2s-mc.h
new file mode 100644
index 000000000000..1d85332dc4cb
--- /dev/null
+++ b/sound/soc/cdns/cdns-i2s-mc.h
@@ -0,0 +1,157 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Cadence Multi-Channel I2S Controller driver header file
+ *
+ * Copyright (c) 2023 StarFive Technology Co., Ltd.
+ * Author: Xingyu Wu <xingyu.wu@starfivetech.com>
+ */
+
+#ifndef __CDNS_I2S_MC_H
+#define __CDNS_I2S_MC_H
+
+#include <linux/clk.h>
+#include <sound/dmaengine_pcm.h>
+#include <sound/pcm.h>
+
+#define CDNS_I2S_FIFO_DEPTH		128
+#define CDNS_FIFO_ACK_TIMEOUT_US	200
+#define CDNS_I2S_CHANNEL_MAX		8
+
+/* I2S REGS */
+#define CDNS_I2S_CTRL			0x00
+#define CDNS_I2S_INTR_STAT		0x04
+#define CDNS_I2S_SRR			0x08
+#define CDNS_CID_CTRL			0x0c
+#define CDNS_TFIFO_CTRL			0x18
+#define CDNS_RFIFO_CTRL			0x1c
+#define CDNS_FIFO_MEM			0x3c
+
+/*
+ * I2S_CTRL: I2S transceiver control register
+ */
+#define CDNS_I2S_CTRL_TR_CFG_0_SHIFT	8
+#define CDNS_I2S_CTRL_SFR_RST_MASK	BIT(20)
+#define CDNS_I2S_CTRL_T_MS_MASK		BIT(21)
+#define CDNS_I2S_CTRL_R_MS_MASK		BIT(22)
+#define CDNS_I2S_CTRL_TFIFO_RST_MASK	BIT(23)
+#define CDNS_I2S_CTRL_RFIFO_RST_MASK	BIT(24)
+#define CDNS_I2S_CTRL_TXRX_RST		GENMASK(26, 25)
+
+/*
+ * I2S_INTR_STAT: I2S Interrupt status register
+ */
+#define CDNS_I2S_STAT_TX_UNDERRUN	BIT(0)
+#define CDNS_I2S_STAT_UNDERR_CODE	GENMASK(3, 1)
+#define CDNS_I2S_STAT_RX_OVERRUN	BIT(4)
+#define CDNS_I2S_STAT_OVERR_CODE	GENMASK(7, 5)
+#define CDNS_I2S_STAT_TFIFO_EMPTY	BIT(8)
+#define CDNS_I2S_STAT_TFIFO_AEMPTY	BIT(9)
+#define CDNS_I2S_STAT_RFIFO_AFULL	BIT(15)
+
+/*
+ * CID_CTRL: Clock strobes and interrupt masks control register
+ */
+#define CDNS_CID_CTRL_STROBE_TX		BIT(8)
+#define CDNS_CID_CTRL_STROBE_RX		BIT(9)
+#define CDNS_CID_CTRL_INTREQ_MASK	BIT(15)
+#define CDNS_CID_CTRL_I2S_MASK_0_SHIFT	16
+
+/*
+ * I2S_SRR: Sample rate and resolution control register
+ */
+#define CDNS_I2S_SRR_TRATE_MASK		GENMASK(9, 0)
+#define CDNS_I2S_SRR_RRATE_MASK		GENMASK(25, 16)
+#define CDNS_I2S_SRR_TRESOLUTION_MASK	GENMASK(15, 11)
+#define CDNS_I2S_SRR_RRESOLUTION_MASK	GENMASK(31, 27)
+
+/*
+ * TFIFO_CTRL & RFIFO_CTRL: The FIFO thresholds control register
+ * AEMPTY: [15:0]
+ * AFULL: [31:16]
+ */
+#define CDNS_TRFIFO_CTRL_AFULL_SHIFT	16
+
+enum cdns_i2s_channel_mask {
+	CDNS_I2S_CM_0   = BIT(0),
+	CDNS_I2S_CM_1   = BIT(1),
+	CDNS_I2S_CM_2   = BIT(2),
+	CDNS_I2S_CM_3   = BIT(3),
+	CDNS_I2S_CM_4   = BIT(4),
+	CDNS_I2S_CM_5   = BIT(5),
+	CDNS_I2S_CM_6   = BIT(6),
+	CDNS_I2S_CM_7   = BIT(7),
+	CDNS_I2S_CM_ALL = GENMASK(7, 0),
+};
+
+enum i2s_int_type {
+	CDNS_I2S_IT_TFIFO_EMPTY  = BIT(24),
+	CDNS_I2S_IT_TFIFO_AEMPTY = BIT(25),
+	CDNS_I2S_IT_TFIFO_FULL   = BIT(26),
+	CDNS_I2S_IT_TFIFO_AFULL  = BIT(27),
+	CDNS_I2S_IT_RFIFO_EMPTY  = BIT(28),
+	CDNS_I2S_IT_RFIFO_AEMPTY = BIT(29),
+	CDNS_I2S_IT_RFIFO_FULL   = BIT(30),
+	CDNS_I2S_IT_RFIFO_AFULL  = BIT(31),
+	CDNS_I2S_IT_ALL          = GENMASK(31, 24),
+};
+
+enum cdns_i2s_master_slave_mode {
+	CDNS_I2S_SLAVE_MODE = 0,
+	CDNS_I2S_MASTER_MODE = 1,
+};
+
+enum cdns_i2s_transmit_config {
+	CDNS_I2S_TC_RECEIVER = 0,
+	CDNS_I2S_TC_TRANSMITTER = 1,
+};
+
+struct cdns_i2s_dev {
+	struct device *dev;
+	struct clk_bulk_data clks[3];
+	void __iomem *base;
+	resource_size_t	phybase; /* the physical memory */
+	int irq;
+	unsigned int sample_rate_param;
+	unsigned char resolution;
+	unsigned char max_channels /* up to CDNS_I2S_CHANNEL_MAX */;
+	unsigned char tx_using_channels;
+	unsigned char rx_using_channels;
+
+	/*
+	 * Master (value '1') or slave (value '0') configuration bit
+	 * for unit synchronizing all transmitters(receivers) with I2S bus
+	 */
+	bool tx_sync_ms_mode;
+	bool rx_sync_ms_mode;
+	struct snd_dmaengine_dai_dma_data tx_dma_data;
+	struct snd_dmaengine_dai_dma_data rx_dma_data;
+
+#if IS_ENABLED(CONFIG_SND_SOC_CADENCE_I2S_MC_PCM)
+	struct snd_pcm_substream __rcu *tx_substream;
+	struct snd_pcm_substream __rcu *rx_substream;
+	unsigned int (*tx_fn)(struct cdns_i2s_dev *i2s,
+			      struct snd_pcm_runtime *runtime, unsigned int tx_ptr,
+			      bool *period_elapsed, snd_pcm_format_t format);
+	unsigned int (*rx_fn)(struct cdns_i2s_dev *dev,
+			      struct snd_pcm_runtime *runtime, unsigned int rx_ptr,
+			      bool *period_elapsed, snd_pcm_format_t format);
+	snd_pcm_format_t format;
+	unsigned int tx_ptr; /* next frame index in the sample buffer */
+	unsigned int rx_ptr;
+#endif
+};
+
+#if IS_ENABLED(CONFIG_SND_SOC_CADENCE_I2S_MC_PCM)
+void cdns_i2s_pcm_push_tx(struct cdns_i2s_dev *dev);
+void cdns_i2s_pcm_pop_rx(struct cdns_i2s_dev *dev);
+int cdns_i2s_pcm_register(struct platform_device *pdev);
+#else
+static inline void cdns_i2s_pcm_push_tx(struct cdns_i2s_dev *dev) { }
+static inline void cdns_i2s_pcm_pop_rx(struct cdns_i2s_dev *dev) { }
+static inline int cdns_i2s_pcm_register(struct platform_device *pdev)
+{
+	return -EINVAL;
+}
+#endif
+
+#endif /* __CDNS_I2S_MC_H */
-- 
2.25.1


