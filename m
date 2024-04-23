Return-Path: <linux-kernel+bounces-154762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E378AE0A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E442A1F2107D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040905FDA6;
	Tue, 23 Apr 2024 09:08:22 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2103.outbound.protection.partner.outlook.cn [139.219.146.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23185FB8A;
	Tue, 23 Apr 2024 09:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713863301; cv=fail; b=SRS6wntwSLrYlQ2zvpKOhXXlAC4AoDgSh/hN3vrwWnXmMVHHfKwqm774S96V7Go/tn+RPaDq4GWQwdwk6QNKTjONx+QBtGMvHWdfYXjdLoToKZqt+imoN9Am8YooNAPLobKKb9/7ia/WTdWoBjNYoEoUyGp3akKwto7pRGiEdDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713863301; c=relaxed/simple;
	bh=412bFqvSqNGn6MZpeYvBdoeaJBBVRdjdrVRpLjglQgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VvTSc9kiVoiNU87w8sRKwH9DuYPIx9M9q3STJGNrit19ouJjFzPClmZ6GqxsIXEuSjo7xZN4GlrJEso8fh1+mqOapEDgNAYlZ1gvpkzkN0mENSYHH2G2jXaYL5qjzjPoctALuqqQRcmVhuuCeIM9+FteWCCFlCLMAcExIPNmoxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuWQB+bWIVXnGmzZbsMPTKr7ZGmikoBkiIXCA2z65Rcv6QfZPuI42kOj93ztJxhRdVn/uexcfWzVBRZBk0sNTVz8cTUQ3Lqyj6hjsnNiE1qg9TSV2jLgkXuCkOYw86tNrfxk7oufvZxQthILuJh6Ggb+rYUE5C0Y632ZcTeJ1WO1qa5IS6JqVDR41T7B6co9BVjnFwsREPDK5bPEzx7VgaDhJC4mXdD1N3Gp/dGZogEJgTD5Km8QMQDZ5hsUqYp/BHNi/RNqzjKMiibjaeHu1ivN0wUGyTRZwHe3FrmrB1TS3i5PMxpmPcqVCZq/O9J9BZv2N5HfUg+t2nVkipOqbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBbcEid8WijpR0ClFgB8yVZ5bhElHnfLckNgQ8+4QSU=;
 b=eR15KyR/rCjaSaHR95ZAwGr2MKLNqmweO0LjBZsccL44W5g1uP+j566B1PFpxfeO4lGV6cvivUZ0IBZYWJW+06k1UJdxy/8SlT7kv1elxnWD4+a3tQNZVIahLp+7+Vjfy7/MbEQEUObCfQkGgzAaB+fTXEJwn1T+sTKyV0xm7whKHBu9o0qicaixc8UqoThri4HGi4gbyMCwnP43OwPp4lHfV4PC7Z0sDBM9iXIwW4DKBuGHYczID7lv8Nuqa3orjbOeBtFqiPkLcLhORbJTDaWVwpEn+R5PQXao1WI1+vPWb+ZIN0IDs6zp7NLtQ3sU7wIgY5hWe+nwf9Ia97pOIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1002.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33; Tue, 23 Apr
 2024 08:34:17 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::e903:99a6:10b7:304d]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::e903:99a6:10b7:304d%6])
 with mapi id 15.20.7472.044; Tue, 23 Apr 2024 08:34:17 +0000
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
Subject: [PATCH v2 1/2] ASoC: dt-bindings: Add PDM controller for the StarFive JH8100 SoC
Date: Tue, 23 Apr 2024 16:34:04 +0800
Message-Id: <20240423083405.263912-2-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423083405.263912-1-xingyu.wu@starfivetech.com>
References: <20240423083405.263912-1-xingyu.wu@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0022.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::31) To NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB0956:EE_|NTZPR01MB1002:EE_
X-MS-Office365-Filtering-Correlation-Id: 5411580c-5984-41f2-a34b-08dc63702a5c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BPibnEEWZTBnolsY+8afLEwP80i9m1pxODW1YdKhEylv0SZEP0oAtZuCGCO15oGfTKXB1YMIgsmwY8wv4DOax3lA1SYfWEeIPxCak+7iRscWo1JL28iTbnP3bBnCbcnUWyousbP+vMLjm0LezLMBrlSl5ydtHp2pfzsMvilUUsfElm1Q2YzVGRLFrYEWwAGiRV2f4q1okw6vRgPt1cgVkyLxWt6cOxP9izZ7qhuUJpJSBnjNQBv9l6t3vTTuA58GEeEHZofGBZl5mdorTrxGs4iBcKdmkU9ebDef6YToLugl5RtNI57FQzMWwpqHJCS88HjKVwMHm7K6H614PKcf9ycj0dlAbGipCvTAFJ4PgdAtTHosLZUhEMoH3sEI+alzLpCui00JKHJhD2MBhHqJkygpWDsbN6SsnFqz3w8i90iBUY3duLB7uMNUlnjOEyKhpaDgqplWnoDmRE+X4tLZLJjYQ/AHVFWdxn1OW2Q4ZZykp2r/lXq7equIGZWEPwR4AvgwyTROEMWUFngXbMyYLDtXyCBPy+dPJgJE05EjHvjWwfzTvRSG5qfHtR4ZAtvJQWV1ypPGmc/tdVnxxzQtLz4wh0xePZTTv2wEA34mg2g3yl0nyi1fVfBJb9JQAmp8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(52116005)(366007)(1800799015)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9XvDn1KdlSufsH5qn7QHrbggK5cRJhmY6CwhhZw724E5+RgVgUonkTxpBf2n?=
 =?us-ascii?Q?hWDFg/etpV5rMBpVIbO+uJgxC5zxkht8z8QURNUfZ9hTbnT3xPX59am4HMeA?=
 =?us-ascii?Q?QN7QSk864ezCdXw0/32md0m8q1+eXZWrWCtqYfQ33kK8+HWYNHE0N3iXByhL?=
 =?us-ascii?Q?fcUTt4QrggWE8u2wxtp95Z4DCe0zBHYVHv9Fo27XZ+BwjAeefNYUozqyLWxy?=
 =?us-ascii?Q?kAGldmW2mu6CXX/uDp2V6rQXzk2YWA+5poBm1Dtvl93cAmUGTqgllUV5U/O6?=
 =?us-ascii?Q?3Y+WrXCyAD8docssUYhTfsB6dWwOyn9d7MCewtMG0TzRygoD2v+jhmvhWX+f?=
 =?us-ascii?Q?dzPyjDhC9WwngeLK5MlE6k9m67Hj6ULdraG8Q7S/Sqpq5zHJGET5hlZqcR0h?=
 =?us-ascii?Q?ODV+J9KSF3S716qSlgZN75exf0IcPYSyWuatp8Aw+07GT/aTi9I6LqfgJeW1?=
 =?us-ascii?Q?921Un1ZR5BY50qKDaJ35oessqbV8Hp+Z01FIxK9UcEqFDL16hBa3UT5frR9L?=
 =?us-ascii?Q?fjPfHxXOLEZNxYO1l3qTWUWHKORjzn865VxGVgxbmMbYdzTlPmaCU8k/2RRZ?=
 =?us-ascii?Q?XCaZJsv+OzwbTkzuspEFgVADkvWlpdoZX37yxu9wLDDi+M8KpLKFI6GT0ljj?=
 =?us-ascii?Q?qEWpsHoDurO1xeAnC2oUOsZBiPYgKbCE47THTtBE7b315SQ0HPlkJlPs8yr3?=
 =?us-ascii?Q?zfqKff3GYtc0aYVpWxoqZCyWLY+8dpgRtGpEW7zf5XczU93i03EwjdzgJN7t?=
 =?us-ascii?Q?HYyXoJyBinaJp0zoodUu/4rYWYM7db1Jrc6+n7JZoseaW8kjQUAIHSkcJt2n?=
 =?us-ascii?Q?nb4K7AV6aFaTS77h9R3C2hisRaCIfi4e3IynULQku10asK+10Uby3JF7snsN?=
 =?us-ascii?Q?wxVgsVqcAQVduMo32mbln4q/j0gJtcJH6tcVEFOvFqweQj1zTJhzKF0nUdRI?=
 =?us-ascii?Q?++Ncmi5G2FxQuDo8SvjaHhprGYPjT8JoDaKlZKQQdLbA0YNQpj9iZDTcRk5e?=
 =?us-ascii?Q?upTSVNQ2IbpFlyQWFGRQ7ZyvEMNcUvIcjadrrUrNDyQk6wsJ36exk676uBGq?=
 =?us-ascii?Q?j3gY4E5FKQ9vjw0ZSXl9JPmUSH+E/Mua+g35Y0CsSacWIIYjh/k4OQNwQpVo?=
 =?us-ascii?Q?Tb8H6O4Hj0ZC9v2TgxI6IjW6x800uoEr1Abatz0ZE5udo/HCtcdbPYVAmIwb?=
 =?us-ascii?Q?S560DG48mFfAznYi3OTZsVzCoRRqplVa5qjs/7a0KXyz/wyQrQIbEMjwaq/b?=
 =?us-ascii?Q?nrtX5O3AYIeoEywcbqD/srRQHjX5+lQ331Ck/rp5QyoPfI02Av869AsnuoWJ?=
 =?us-ascii?Q?yIiANOtQvUZcAN3Tws/lcyqLeF62SlwNGljBhi0giUiVWezyEhh9YXS+Yuf3?=
 =?us-ascii?Q?8CchtNvT3EcschYtyUWhisqw+1d1+3PiAbczx1E6YND4J3R819kgZnb7/zy8?=
 =?us-ascii?Q?EBxD/wbm8egeFz2U9ciT/yU3Ty3Kp/Qk5L0hubow2KMWc4Lr/GvroiCGo0Gw?=
 =?us-ascii?Q?YjEg8T53mWtHt7Tuq4LFjnfI7ehDJ9IxP/yJafFERKSBj8w8jbX3JcRJ9b1u?=
 =?us-ascii?Q?gvZq4eWSyfrGGRYG/q6jlvJ0JoK+V8lnIO/6NDcOYZIdy66rzzVxjnZ1pFtC?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5411580c-5984-41f2-a34b-08dc63702a5c
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 08:34:17.9235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyGDa+jMvtS+9tHYckjaQLFln9zRA/49TAvNAIM9hjsM4cPznOgDdPGbmneNfWD5/Khu5MWD9A80WOm6HrZwLmQlglqWN6NVSvtzk22dUQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1002

Add bindings about the PDM controller for the StarFive JH8100 SoC.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 .../bindings/sound/starfive,jh8100-pdm.yaml   | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/starfive,jh8100-pdm.yaml

diff --git a/Documentation/devicetree/bindings/sound/starfive,jh8100-pdm.yaml b/Documentation/devicetree/bindings/sound/starfive,jh8100-pdm.yaml
new file mode 100644
index 000000000000..50401e177f41
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/starfive,jh8100-pdm.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/starfive,jh8100-pdm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH8100 PDM controller
+
+description: |
+  The Pulse Density Modulation (PDM) controller is a digital PDM out
+  microphone interface controller and decoder that supports both up to 4
+  channels, and an Inter-IC Sound (I2S) transmitter that outputs standard
+  stereo audio data to another device. The I2S transmitter can be
+  configured to operate either a master or a slave (default mode). The PDM
+  controller includes two PDM blocks, each PDM block can drive one
+  bitstream sampling clock and two bitstream coming data (mono/stereo)
+  with sampling clock rising and falling edge.
+
+maintainers:
+  - Xingyu Wu <xingyu.wu@starfivetech.com>
+  - Walker Chen <walker.chen@starfivetech.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: starfive,jh8100-pdm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: DMIC output clock
+      - description: Main ICG clock
+
+  clock-names:
+    items:
+      - const: dmic
+      - const: icg
+
+  resets:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+  starfive,syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to System Register Controller sys_syscon_ne node.
+          - description: PDM source enabled control offset of SYS_SYSCON_NE register.
+          - description: PDM source enabled control mask
+    description:
+      The phandle to System Register Controller syscon node and the PDM source
+      from I2S enabled control offset and mask of SYS_SYSCON_NE register.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - '#sound-dai-cells'
+  - starfive,syscon
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pdm@12250000 {
+      compatible = "starfive,jh8100-pdm";
+      reg = <0x12250000 0x1000>;
+      clocks = <&syscrg_ne 142>,
+               <&syscrg_ne 171>;
+      clock-names = "dmic", "icg";
+      resets = <&syscrg_ne 44>;
+      starfive,syscon = <&sys_syscon_ne 0xc 0xff>;
+      #sound-dai-cells = <0>;
+    };
-- 
2.25.1


