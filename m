Return-Path: <linux-kernel+bounces-25395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233B082CFA8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 05:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6941C20D54
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 04:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33521851;
	Sun, 14 Jan 2024 04:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gb6vNDYn"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2077.outbound.protection.outlook.com [40.92.15.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E591FA3;
	Sun, 14 Jan 2024 04:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+ScGabO9DdMza2mOz24QamZ1dEL1zoR5/Mxos6csBmdzExpvEuHcoUPBSCImEZHZ6lEWSVc1QgE0Ykx5zdF/7yAw4fC1wf195FrxLBbzuCAgcbHl2Imu53SBK1PilqgTqUJFal7BtS1+cOlxZGJwQtt2RCas6ARluGFdgWCh1Hg/KyjMxdb9GTAZWN0c/VGHLPuH8J/f06DzwGYSet8oi6vsT46JPqU6BRAwtiVSYu02N1NUwJABQa4AQEqm7UWqd2puaNHa6c52empudJcZTxU5/t+LYkOHv8n68u4Z+iuQB+W7OO2naYECTBVrHk+c76ShG+oTu2Dv10/yRdL1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnActkFdCaPBuzsHH5fhWQPc+iuoldTepdEiRde4iFg=;
 b=Jn7jiGmR+ezn9IIuD4SD41L51Yz7bZmyQP8L6fbJEdqBnU+7ksQWMxf2pl1KlcGQD1tCJp47Gln7GztStNSuyaKmcnLeiL6kOKvRVGOT8XQ/bjyNWzQ0ayM4GIjxXLewA5YdgUrsWJWvUCseXymvxZ2pBMIZotS+U6EkFEhthM2WwxT7hTM/bm7sMxAVvXXydLx/PNQ3uWS0B+vfp149NPuOcimELeUQa+rF+WZOb2iEl8ok8gHcR0DEAFPYzX31OmCr2d8OfclQ3hYvv7MBd36ljlYePyRZoIDd/sPjDaE/jiECCmVzYvuOKKXat60DHU+kEp2OHvmTs6Ch1f94eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnActkFdCaPBuzsHH5fhWQPc+iuoldTepdEiRde4iFg=;
 b=gb6vNDYnzY0pAkfk9K7NzatZ4wPYJNOW76kQPZgBN3ChPtykMcR3/21n6XvR+Wl17P9bbDVYbo7r7q4v52HywEkxUxadSO7SGIpRwM+CAofTeiyLLR6SX3UqtSpX8/ssmqAmRTgA/StiYMRfbv3hDwIGYbhBUh32Pi3lg38FDmBhMx2D44Z01Wkq6pTT0mTc2l7ItifU9hHqqXM9rqilyNzW0PNxGqBjjlIFuFwf3tBu0CqeyDCbqKLDv339SvQvTP4LbQPryLoUiIYJnL1UbjEUCRFXeFvAnDfz2Av0yfA2KNJ48BAxvrsB4u+qyxxcFQjlVTe2E/Oovntu5ZuLRA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MN2PR20MB3477.namprd20.prod.outlook.com (2603:10b6:208:265::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Sun, 14 Jan
 2024 04:17:19 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7181.020; Sun, 14 Jan 2024
 04:17:19 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v6 1/4] dt-bindings: clock: sophgo: Add clock controller of SG2000 series SoC
Date: Sun, 14 Jan 2024 12:16:58 +0800
Message-ID:
 <IA1PR20MB4953B0CD5B8796102DE358C2BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA1PR20MB4953C774D41EDF1EADB6EC18BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953C774D41EDF1EADB6EC18BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [zukuJu83YtElcdFPpG3AJ6OQdRiPShRwaFypJOXiPdgXFZft0yx+xLFR33eW+4Xr]
X-ClientProxiedBy: TYCP301CA0050.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::14) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240114041702.644522-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MN2PR20MB3477:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b8a20f5-112e-41e3-ab40-08dc14b7b2db
X-MS-Exchange-SLBlob-MailProps:
	Om8TgR6f4EDHDmDz1kJnX51tgKpLn0gouZK8ssAGUUFBBY3qHhtkaERSuLNtNQVubOPNw2z0btGqdSm4sDZZxj9eaTSRbFg/eNFmloDqZD57OplIyVHJB93Cr4OvSTPw4G9osep+wAG/CsaZpQooFMhGV7wgVqOyMpj5RFunIJQkD9K4pE1n67wn3r6dgsalZ7PTcUeFrD76EPZaUPtlrPPQgHpiFveKSREUNX7GBONTJOzDa2t9IZxRschMEmw0ia8Owmm5K51Y24KRcOkKVH6OwkUOzelrTGi/AmP8nASWADuGOyOEoyrKz6mN/GZP6ZJZrknFm/y1QIBtZXPQhz3WVlelV09GJzP8PC8oXq7DIF95BoX/FSBRZ5enVZsS5tGvn+xGjr6r54DSMyseRVaCcrhjquShvUDB0Q+st/+zN6LdC5nXYrrZQ24LuFkj2RtAB7YluVd3dRJWFdYwgLFdgTM2DAf/m8JdfYB/9LGQndnvxdA4L1hmDnGCjLUz37l/y3ItHr3ugeUybSChd/+WVJ51tvH1l/3T4q339w1lBkGKKSn+Te6iZBZh/BBn9BUYz0Y2J4M4LmSBEQZOyR5b06FerYxFe/33wRVcPu4QBYEqqadxSftThpQXOsH+GS8LCEuClPjOzGkcKWN9cYEiF3SIou2COGGd6PNNhfAqlxAWZbr65BPw5RwDsO0T+wA4nD5Yr2ayTIm6GTz6YNpidh1l7OIjKNmJik08GzNZAQcAkE9usL6WrzjEC4wNbZ7VQWFgHqJLBmMYg6A/ZYGq77BptsqLmhgMGVL7xFY0PBCPpYMO/lKPcG9rIHm+XUJUUUGHEMYsAKQ8Zqri3k/59litnHHB
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/AiwMY3+ay7HVOsjs5dcSXVyEZb/kwaWNM6o4v+DP0GLsmi04/Fg1lXZVbymSDszLve3QRl0jE6MQ9ZPxQfqTNHLzoYTzTal56I8dcxInQfPFCd49gSGGtljXpJb5ce0SPEw0KljMuz62qVYwM2ervt6FiljdqT0pAE6bOGv00rKVjd9YVZ8AcwAHLE2e7eCFvFkuhw3oi/J+EY6TsWZtXpbMGX5CdBWtiZXsoixOMnF5jZfXbEAfE/DyGUsG5vy79AjiScFvj2RtKp7ekWUX9lrPDQnQKF1bMtC+hR2BUhu2YRdhys4bqkQgNkyGW9Q3hC55UuEBTHouiU8k229Z8xlrNcCNGliUFaCFq478NnJc0YidTql5cmlb98fLsykhP1dt20mWJ+6yoXNqmDhaH2lNZdCI43hXyb+ZjktS3zc2yhiKOMQbGU9PAveoittOcJcNExmmF70/mZMNgSrvfRUT5apnCvuVKmmdkUYBJZovsl9r0uEgiHPG6cQs22dwgTuPS6iZuz8hyMQgvmLQo3PXNdoSEizwJgtPUEL3QieIBrZK2mWpPDTZjweat+mGeMldXKOq9zzc80is64gd6PufancrcjDSH0vs23cOPBrOnYflauvFvEOLeURk5UHf33xByVzHq+RK4o86ohvhct7UyrOclel8AEdoueKV5A=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rrxcECgECojLFtdHQTUK6PWSyKZzA6VCqR+Me6wjwji8XqaGrbvOIgbws7vz?=
 =?us-ascii?Q?Psa//Hbnmp+1RW9qbj/97fxo/17/ZL+lPKmcyhYhSLbDJNqbX2OHbMVTvNj9?=
 =?us-ascii?Q?wKg9vV+Y3lO15NWlNbuBOcwJN3TzN9uwMvqLo6a+b3fEgoqgVU1/0ikTGF7K?=
 =?us-ascii?Q?yL9rhNzBuj9CQZKtSk3PVGBZZCbxJJvVADgRGIyFXQsG4g4+4BNkL/yy3cUi?=
 =?us-ascii?Q?i7VBh9A42HRJmNTbYQ2gc1+ylWr93Q/l3bFryPONuPEnYYHoXLDzX17+58fy?=
 =?us-ascii?Q?MgUMJceqKsslqcvomuSArS5DFzeGuDMjif8vlv/zDssHTfrEuPTs8lmGPnPL?=
 =?us-ascii?Q?GuBpOPNvi9nxrN4/DVAxQZmsw+asaow5tCHpYCfVg3Du/ClErSC+60rN8iVs?=
 =?us-ascii?Q?ByztEmQEen4kPTSURQY7rhWURqvOsDAmZXOLdN2he9/kEwxEZvg4PicOLULi?=
 =?us-ascii?Q?16e71gAPax5vLKQORtkzS2rjFtyw9x/h5T0GgjH7UQBkh0Plctsk/zih7qmM?=
 =?us-ascii?Q?58wMprXuQmNNCnnPly6uPJF2UO3TjpPAAjzVQu1ibe86Ava3yUqT1YDTNbjJ?=
 =?us-ascii?Q?Zcewv/XQrkj4Te6Oo4MoMU3FOIRo25FW+LgRHDXRLAl/5c6SO56IhWSJM4Cf?=
 =?us-ascii?Q?95ISl1biOp+n9HgVs779hS+QZRdP7Y7Kp1AkpAVdDLcc5R5KGeWm02swpAgV?=
 =?us-ascii?Q?S+Qb5j/F9jfKbQUZ/BULry5c9rArpXsF8wJ91F2ZON0jUNE7vtkQN2hz1Yq6?=
 =?us-ascii?Q?aAyhxHjFfdr6gMAv5G+/4/yXC/41TYkTqLYJdYnmrlsUcnE81ASVsaUYmDmV?=
 =?us-ascii?Q?rDoIQj5GH+98Uukaq95VGSjtJe2kbaZa33mekCv03CgYX00jCuGOY4p8QgoZ?=
 =?us-ascii?Q?4THUeHEpNH/ndpH+IVKlFvrus5kjfnrj5awN/qRgFCOPiDz4NVRWt6KuYa4M?=
 =?us-ascii?Q?Z/pkPli/IiqFJOWaK53lwtDmfG9c9DnyWWcVSQnfkrmU+Wk6IKHZcVzZjHYP?=
 =?us-ascii?Q?W+PQGeoZbBlmzmtMY+huhF5qli/IjsuFov38uh2nwQG2FPd820Hf20vlmAld?=
 =?us-ascii?Q?b1/oH1s6dZutDuKOyqDuDwgY9sR9e9+bTYOq0UIlwvu+192gSNS8NNZ9/VBy?=
 =?us-ascii?Q?FIQq0HPOe9dx1lzCQbm7rRffOVdYHPHQS5UIwA87woOW4W/Wo1t9zvDnSISc?=
 =?us-ascii?Q?t42L+f1cNU3jrdN9YflOiz/oT1ZXftbu9GhFAToQxDnycZlE/L+M0z5GtezF?=
 =?us-ascii?Q?pJ9S/MWJg1i/WsB+TXyOPjVPn8QW+Cjbnv20C/GPeg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8a20f5-112e-41e3-ab40-08dc14b7b2db
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2024 04:17:19.4031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR20MB3477

SG2000 series SoC has the same clock as CV1810 series, but the clock
related to A53 is functional in SG2000 series. So a new compatible
string is needed for the new SoC.

Add definition for the clock controller of the SG2000 series SoC.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Link: https://github.com/sophgo/sophgo-doc/releases/tag/sg2000-datasheet-v1.0-alpha
---
 Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml b/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
index c1dc24673c0d..59ef41adb539 100644
--- a/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
+++ b/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/clock/sophgo,cv1800-clk.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#

-title: Sophgo CV1800 Series Clock Controller
+title: Sophgo CV1800/SG2000 Series Clock Controller

 maintainers:
   - Inochi Amaoto <inochiama@outlook.com>
@@ -14,6 +14,7 @@ properties:
     enum:
       - sophgo,cv1800-clk
       - sophgo,cv1810-clk
+      - sophgo,sg2000-clk

   reg:
     maxItems: 1
--
2.43.0


