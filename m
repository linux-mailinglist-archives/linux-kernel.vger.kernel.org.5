Return-Path: <linux-kernel+bounces-5169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E70ED81877E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1251F23C48
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBEA18626;
	Tue, 19 Dec 2023 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=softnautics.com header.i=@softnautics.com header.b="M2no/BJp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2126.outbound.protection.outlook.com [40.107.222.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0311D18629;
	Tue, 19 Dec 2023 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=softnautics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softnautics.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+EtSZG/vE2TIR/4UEOUQFW+sqAb4WMGXuNBuljAsLT63hP+VEOF/O/cunTMEGNxTN/RWc+9Kj/ja8YbqbL78WQsowt1V7hGuLZdXOsH5/CHinlZv8VswHd8w1XdPZE1cwL0RXGeFHWQAQhFVthaL6Z9emjiJw+bEMPJHjkwUra7Ka8/slNnpG3d9/2x6ym7FkOyrotqT1FgIKA+Ilckv2Jw69nhkDx1qjn+EKVVF9dYtsUOkwnBvuNhQj3TYnFSNUPh0BKKS8oa2574mZF3VJG0dta9jfKb43H4D/IoBIin39CPVvLVGnVaHy28cAeOhujoFFq2bvUroNYb7G1X8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnN/Xa+VcKbJh29VLU2oyn3d9HaQzEPNb5YwopwqpLc=;
 b=GI8WAZ5lXwUSuiBnlEE9qG8+N6n4LsvybleKuzL37wGtaQD14Ri+EV5bGDjoDM/7gJ0e9JSc90xNrjwAuz5WdargHF1CJjtCjm/3914k1k+34+rfwGn9avNLIJ7AFwW3A+svUtVB7WDUdeKFFu1xMqRILuOOZpIG1r8+5ZkI/LAJ+sv5JQsvMiqboZn12yWrR3HVv1aPGb8zmlyR5TpBFXImS2Tvr35tFUJU4ZQScwqF8fPAkFVjGeH7WwgFIpp4OHlLmbA3BDN1tNOBX7EhL6sprk+pOf2MK0MqZq2+vcyuBIjvOhLCDdlPRDwPoGqOEbC9mB56+U62SjrWnuEdUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softnautics.com; dmarc=pass action=none
 header.from=softnautics.com; dkim=pass header.d=softnautics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=softnautics.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnN/Xa+VcKbJh29VLU2oyn3d9HaQzEPNb5YwopwqpLc=;
 b=M2no/BJpiGqnT6X0LaohUi2Ou3yNuNTbEArUVOBWyE20+DYGP0Ggd8DnziEKxx9Y06ITD1vQ62vRWuBwFqnl/qO3xjbd8xPWY4Xwe3szDq44JVoTgLzVo38sswffMVArYiIYgu/tHhanHTYQy250TGk96o1/9H9yrRxKvMcyuDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softnautics.com;
Received: from MAZPR01MB6188.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:4f::5)
 by PN0PR01MB9979.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:13b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 12:30:07 +0000
Received: from MAZPR01MB6188.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2abd:88a2:361a:d653]) by MAZPR01MB6188.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2abd:88a2:361a:d653%7]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 12:30:07 +0000
From: Sunil Vaghela <sunil.vaghela@softnautics.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	michal.simek@amd.com
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ASoC: xilinx: Embed IEC958 sample rate val to channel status register
Date: Tue, 19 Dec 2023 17:59:55 +0530
Message-Id: <20231219122955.104696-1-sunil.vaghela@softnautics.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1P287CA0021.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::24) To MAZPR01MB6188.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:4f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAZPR01MB6188:EE_|PN0PR01MB9979:EE_
X-MS-Office365-Filtering-Correlation-Id: c42b5210-cdb0-4736-b2ee-08dc008e3bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ie1g8lcfzYS7PhpINH9YTqNZsPHgD4Onj6yhsYzSwug685cstz/Dmq7IjidSLxide84rxBqGTfD8n0V+yTl/SWhhI2IFtmt8WBrv0AEmiac5CfQi2lCLdXOdtqYmuufJGUh5WwH9jeT1c2HJLu6B9Wur/+18sXRKDD/KqW418PGvlDeI/HUhDgsETk/OehueVQ+F91+TSQc2un54TuLZokVZE6e4yLx74VgrBOKZK6BSs7UORXu8+N4HMS/lLaaH7lq8dE+2PX40fZLlVTvDUiLcxfSAsTd98g5XasDV/3xkT6t2rOIWfVV+HT93xkm8vvTE/OR0KmJ+fRaaKIGCLIAmr9ZgB978VP8MbfEdN0C2kQeCzCGZ6hY2yU0/QSjVzBb5XWKTjBVvIJ+hvMXRRdnGaNG+VngP7Y4Cl3a20KMIYobhJzTDxBVkPl695jBLdzoxGkzXriblb3823ktwzfh34FrkKqKcuP2vCgyZfDJHIsdK4lAniKKaEJVbo7oSs53leHqVSllc9QVeltjcC04U7K6etxwJi+oqmFWzHHUrm7v9jkv2SheFnySgXjExtRy46P1hr9rxMvUc//JuIlCZs09NfouTBKQ3zVpc6p66vZzpyFrMzlHWSUsLM4BG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MAZPR01MB6188.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39840400004)(366004)(136003)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(2616005)(1076003)(6506007)(6666004)(52116002)(6512007)(55236004)(83380400001)(5660300002)(44832011)(2906002)(41300700001)(4326008)(478600001)(6486002)(8936002)(8676002)(66556008)(66476007)(316002)(66946007)(38350700005)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x0e1OfJqP1S7DAu1DMuIRknp4+yX/2F/S6zOp1l2OGIDWT5pZomqoUNWnYPn?=
 =?us-ascii?Q?3yZRhqK3fusBzJJWXgTXnIDBgY5am7i/Pb2p5K/UbIhExWa2iTTli0ajmU6B?=
 =?us-ascii?Q?ZPgVIBawKCYQS1iUi0QlSkS1rha8LPFGTqk3vSfRXDgM9sHqt5k3+5hdxzua?=
 =?us-ascii?Q?GXYo3oL3r8YNTj7Jl2rs7Rfti8s5k0ZOgWgo09aJGtXpdC4wSDc8EjMXKmbZ?=
 =?us-ascii?Q?ijj8oehP+fsduqEoa75fdcV68G/D20mYq9RyZnWNAMyjnWaQ0VF4EvWH0YFd?=
 =?us-ascii?Q?1IP9ukW9MtlG5mMieGkctiiXk2u/FqwhWSuq+Gh1ECYFmpm2Y+HkAVIuG42i?=
 =?us-ascii?Q?foqWPcQWjzD/nYfbz3Z++26fCtt6BQzYVv2PYt+yQ2atNXGh5P0APaYjMoqL?=
 =?us-ascii?Q?n5w4T0z+Xd8RUxqzzl5rbOn38hI1t47gnDGHHwgZODndU7PRN6I4rZUmg+vM?=
 =?us-ascii?Q?sPEDM06Kyt6j2CPrGwzzp3OdqyXCVSAO2Fcijgml5vyoy78xkG3ycjgealwg?=
 =?us-ascii?Q?bigr8S+BNuIvt0lfrvTJPGkDypvw9juYg187dAPRFqyyDnAGFrK5wb5jn/0y?=
 =?us-ascii?Q?dhCxypjcQ6mWl+YzSht88RfDiGkTZUhqJ148xIDsrOs9RqNEfkq5zN4PGS2V?=
 =?us-ascii?Q?gJwHjugV71E2mO4pN+yxgZsmpEzgE47diCE0THkrNPfy99QISLgnSIIbPUkN?=
 =?us-ascii?Q?3xxSGuHprBwiLuctjMnt65UnmFqgrnX46lHq4q6pddsKY52vQm2PCzTlM6EX?=
 =?us-ascii?Q?d52SN2E80gtPl1PgmQtuqCYWJkqsnQOClKV5uzMMnv0io4f/73ENgBwOyh4F?=
 =?us-ascii?Q?bXDiyGQ/sprK7VwkZIeLUfUnKVfd4vDtK+50QN0nGUNuDPGsldXF8Mylxzxo?=
 =?us-ascii?Q?BknBtF9ZuQ83/HOnxyz4EqDDrsgxcHIn8L6Bmosa/zpYUDj1kYkfCvuxuKff?=
 =?us-ascii?Q?kKTgoKWoulkd5CaFmwC5LngC2Fx//u+U79EA/k1LS2PCB9uaHyXi9z2+dGrL?=
 =?us-ascii?Q?CXMljNKCEo8rO3JlQAdyCkxCig5YfQfGLCUMJhIxR6VZACfQ6LVz6C472jjS?=
 =?us-ascii?Q?CITJD+NwkUthOUzVkYGGPld1acWOP6NA51pW6obUr4M+RJYRZRjNPPPthHO7?=
 =?us-ascii?Q?JKvwlzKvduPcFzJJQ7sQ50BhQsWzFFJ1Tx0q6qXYWugTP8mYD1cyLK60qtmO?=
 =?us-ascii?Q?PkSQDTcWCbkm1a2GDeVg5BjHZuRENjQo0N9HZU9zx5CEC+o/62Www0zP+8xL?=
 =?us-ascii?Q?bK50vY6x+dln7tpVBwbD05TblNXkEgyWFOrAMLw4Aq4+TuAJ7SOtH8rPkWNI?=
 =?us-ascii?Q?1YgRF/wEbNFmyjlCLauOZrZZDEzqNLGWJL75JorVWnIaBwmgPfgnXhdqUK1w?=
 =?us-ascii?Q?w0USKAnMpEFaandoYyRrLhoGjrshYOBSx7UReGsFq0McfH+S9UKU7jLMVqHX?=
 =?us-ascii?Q?MMGZUynwFQp+I6815XR6L8bPnqb+CSRC/4dN5j0yv0oH/NgR9n2We43xXFRb?=
 =?us-ascii?Q?kqKhG2ahW5nk6nqqLisPVF0taCLoErqv4+m/ias3v1ddooQ8p7Nekkr9EfRj?=
 =?us-ascii?Q?mybPRFHSHHWqvjKeq2Y/OTPinUB+FAmbYQqzsFOfJPfGx6Dhj3AEkfAYiQxU?=
 =?us-ascii?Q?NEvUG5llIfVCYme4W572je8=3D?=
X-OriginatorOrg: softnautics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c42b5210-cdb0-4736-b2ee-08dc008e3bfb
X-MS-Exchange-CrossTenant-AuthSource: MAZPR01MB6188.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 12:30:07.2639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 17b76cff-50c6-4f7a-9198-dd4afc5f8bea
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7yrHgwf1+uvbaSHgAibABq8Ls+7hRXsBzkJw1G6Juqp+uCx93yS67fP9gGkmG19Fd7VqWeZGQXZOrDM1LctXhR0C4XSXn8PuMIEKoR5NYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9979

As per IEC 60958 specification, bits 24 to 27 of channel status register
indicates audio sample frequency. If these bits are not set, audio
analyzer always shows 44.1KHz sample rate, irrespective of any sample
rate audio is being played.

This patch fixes the issue by setting IEC958 specified channel status
values for different audio sample rate in [24:27] bits of MM2S Audio
channel status register.

Signed-off-by: Sunil Vaghela <sunil.vaghela@softnautics.com>
---
 sound/soc/xilinx/xlnx_formatter_pcm.c | 74 ++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/sound/soc/xilinx/xlnx_formatter_pcm.c b/sound/soc/xilinx/xlnx_formatter_pcm.c
index 299cfb5e2022..041010203ba5 100644
--- a/sound/soc/xilinx/xlnx_formatter_pcm.c
+++ b/sound/soc/xilinx/xlnx_formatter_pcm.c
@@ -451,12 +451,48 @@ xlnx_formatter_pcm_pointer(struct snd_soc_component *component,
 	return bytes_to_frames(runtime, pos);
 }
 
+static u32 xlnx_formatter_get_iec958_ch_status(u32 sample_rate)
+{
+	u32 tmp = 0;
+
+	switch (sample_rate) {
+	case 32000:
+		tmp = IEC958_AES3_CON_FS_32000;
+		break;
+	case 44100:
+		tmp = IEC958_AES3_CON_FS_44100;
+		break;
+	case 48000:
+		tmp = IEC958_AES3_CON_FS_48000;
+		break;
+	case 88200:
+		tmp = IEC958_AES3_CON_FS_88200;
+		break;
+	case 96000:
+		tmp = IEC958_AES3_CON_FS_96000;
+		break;
+	case 176400:
+		tmp = IEC958_AES3_CON_FS_176400;
+		break;
+	case 192000:
+		tmp = IEC958_AES3_CON_FS_192000;
+		break;
+	case 768000:
+		tmp = IEC958_AES3_CON_FS_768000;
+		break;
+	default:
+		tmp = IEC958_AES3_CON_FS_NOTID;
+	}
+		return tmp;
+}
+
 static int xlnx_formatter_pcm_hw_params(struct snd_soc_component *component,
 					struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *params)
 {
+	void __iomem *reg;
 	u32 low, high, active_ch, val, bytes_per_ch, bits_per_sample;
-	u32 aes_reg1_val, aes_reg2_val;
+	u32 aes_reg1_val, aes_reg2_val, sample_rate, ch_sts;
 	u64 size;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct xlnx_pcm_stream_param *stream_data = runtime->private_data;
@@ -533,6 +569,42 @@ static int xlnx_formatter_pcm_hw_params(struct snd_soc_component *component,
 	bytes_per_ch = DIV_ROUND_UP(params_period_bytes(params), active_ch);
 	writel(bytes_per_ch, stream_data->mmio + XLNX_BYTES_PER_CH);
 
+	if ((strstr(adata->nodes[XLNX_PLAYBACK]->name, "hdmi")) ||
+	    (strstr(adata->nodes[XLNX_PLAYBACK]->name, "dp"))) {
+		sample_rate = params_rate(params);
+		dev_info(component->dev, "%s: sample_rate=%d\n", __func__, sample_rate);
+
+		/* As per IEC 60958 standards, whenever transmitting a valid audio
+		 * stream, HDMI/DP Sources shall always include valid and correct
+		 * information in Channel Status bits 24 through 27. For L-PCM audio,
+		 * these bits shall indicate the audio sample frequency. For
+		 * compressed audio formats, these bits shall indicate the IEC 60958
+		 * frame-rate.
+		 *
+		 * Channel Status Bit Number     Sample Frequency or Frame Rate
+		 *   24    25     26    27
+		 *   -----------------------     ------------------------------
+		 *    1     1      0     0                    32 kHz
+		 *    0     0      0     0                    44.1 kHz
+		 *    0     0      0     1                    88.2 kHz
+		 *    0     0      1     1                    176.4 kHz
+		 *    0     1      0     0                    48 kHz
+		 *    0     1      0     1                    96 kHz
+		 *    0     1      1     1                    192 kHz
+		 *    1     0      0     1                    768 kHz
+		 */
+
+		ch_sts = xlnx_formatter_get_iec958_ch_status(sample_rate);
+		dev_info(component->dev, "%s: iec60958 channel status bits 24 to 27 value for sample rate %dHz = 0x%08x\n",
+			 __func__, sample_rate, ch_sts);
+		ch_sts <<= 24;
+		reg = adata->mmio + XLNX_MM2S_OFFSET + XLNX_AUD_CH_STS_START;
+		aes_reg1_val = ioread32(reg);
+		aes_reg1_val |= ch_sts;
+		dev_info(component->dev, "%s: MM2S: AES Encode channel status register value 0x%08x\n",
+			 __func__, aes_reg1_val);
+		iowrite32(aes_reg1_val, reg);
+	}
 	return 0;
 }
 
-- 
2.25.1


