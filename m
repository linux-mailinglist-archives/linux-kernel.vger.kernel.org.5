Return-Path: <linux-kernel+bounces-166370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FEB8B99A6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75AE1B23033
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77E278C9A;
	Thu,  2 May 2024 11:04:07 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2097.outbound.protection.partner.outlook.cn [139.219.17.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76ED69956;
	Thu,  2 May 2024 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714647847; cv=fail; b=n1NfKESFNV9K2Rm1ejSAoLKFQyR7IHamgPpFZR2l/z9xB+0bqErQgyxEwnwultwJrstaFB+Tn2Ug4mnB3qqQ3Mtsd1bcx03kNexkZY+ftxRDE2jeo4TpL5emHJS5DIZWHgtwgH/62tM9z5yuAbjF4ZmOPbS4439y+MEdvI+GVIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714647847; c=relaxed/simple;
	bh=YZV4m/Go5HCUknFlcEE2bllxpXR5ulK4Hqhz0kXI7kE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NmCQ3NqKI4w9fJz1TcyWNFVoQYfK4cBktAIm12/zxU6EhlepVnO3Ofn1LwwcYQxHmxGlsN232MTQSiKl230oaaSIWj0LMeNm5PAQJ6rqeQYlIq0yWsBhDi2XbSzGeMxGvzRbYsjcNibK5qrLiqwCix3Dnzzb0uR/uwCBUcV6xok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhThb/+LTIs1LxU9ECswqNxHOIbX2UP+DWKnaxnAB9qevoKRdKODeEJI1oAIaw+XMW/9VD4lOfHJcIeIcreMPxmjS03yiGyIxFR9wgNvgdluzoSzdOHrqFCdOcjGCW4xhGM+E60Qy5EokYI/EJ3DPgc0SOBdGboM708laImRxSW0nEbub938RHCEiBZQqqOr5qfXC8zH2mHFksNkeXG5JcEKA9opHL5qf0PV0E0hgoB4jQSXpaFGf3HNiFXCeGPXm5UXTTrzDQ8Ks+LQ6Rc4B+RU+LpKfeAM562PcsJ8FpNMfRPkTaEMP4dHEMF+v49XNrBcxS8raU8DCQ9dHNgK7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65gAFbegy3qtC5XiGeKdwtGYoGTNV5lALcCnzt5+GFo=;
 b=SszaPzzC+SMEnB2apjWybMdZ7sHmef6nqG0MegH0ljH4xjGK+y9rQqhToZu4RSZmqovoX3qZxqNAIWwFpwgZbuK2uqU72UYtxDlbdcOHKIn/qR+rsuQ/0L9f2i0xvqOdS3ZwtG9aQ1jLQojc6D+b/Win30rtxE6VlMh0WGNnZ6IfcPKAiShfV02+HNWjOtkbnpk61eIxh1B7l0Gl4QBrGvoyPTv0iVpAQvAYEl4dzTEnkD+Qkmqb+6OTSXTSfO5NBkyD7RsJ+aheqa1TAiiaAWQkExRKZuOQcae0D0wbxMws+c6P+vxx8OLYgVHG0EbQ8M735SiEOW+fVfVz222W1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::9) by ZQ4PR01MB1284.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:14::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 2 May
 2024 10:48:32 +0000
Received: from ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 ([fe80::301e:ec80:4356:8b14]) by
 ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn ([fe80::301e:ec80:4356:8b14%6])
 with mapi id 15.20.7472.044; Thu, 2 May 2024 10:48:32 +0000
From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Michal Simek <michal.simek@amd.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add optional reset control for Cadence SPI
Date: Thu,  2 May 2024 18:47:58 +0800
Message-ID: <20240502104800.3030486-1-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0005.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::17) To ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1154:EE_|ZQ4PR01MB1284:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b76e1a-4d59-46df-c8d9-08dc6a9568f5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+dPzqEoQojSwn1pWC+32Rvvl9TSQCh/3a0uvMnYxIAIwSv++wUMBK87CH5KxCpwQj3L4ZXKoEFcvEYAPxJOBjGPhvgtb4ZQ32KZxPOx9A258MO1Qikjca4ZWGCta+hpg1RjFU+yey10VstebMfkH7TPRg6vmOmc6n1xMeIxpvCyObZ/jpfJVJeCLTVmL3yuKwewRyvV2hwM9VkuDNSlUS/63K20U0BsZyb76h2L+fxt/3IpphDfSL3n3BsYDRwFKkfPcoXk+J/gs64Fq7pLJ9gylNmmZTcMyohFenSoki7SYBSgqSDJGGC77gKWyeXinVTPjgFGDWDDnYgcmFITj13xCZ1p5RIJP6BbReBTOYjftcHpWs1DyVNVYGmn0eUOSBaMBt5XwsqKjy5wN3XOoHJ1+RqSPxdxuvX4CYMqNkR6Y8D88N8LauW+Dt7LXIfxZqD6n39tD+y3IsiFtS5qeT6IV+4qd920rB65zxHdiiuSR1nE1WjRwnC61/8YDsgnOSHv0ZC+WO0DxxuQCNhaSXngEpSxcPIUgRGfNEmfM2k0YoLE7P6T3wGXfgvDuDh7CNgsHmM30kMzd59ZYwHj67ZJ5bKUL13GaU31HhRPXrzJtpKaNNLrUbnEdXUig0f9v
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(41320700004)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?efck+ESUiXwIPO3bOjlx355Aj93pYCSRnTFfDpPgx/wr9COImvBL/O57N4lk?=
 =?us-ascii?Q?CgBv6X6g5ONOGmGJjcYbnCvTRvsVhN2em+XzgaLBYGFlbWRS4RoLm1i0GWBR?=
 =?us-ascii?Q?1u1OHiLOV/J+bQxGXo46hBF2HJghpGkHIs3AzhSmeNmHOT1Iy39XlsowJnFG?=
 =?us-ascii?Q?f/VmLfNK31m8Q0zkhoUalXXsJmG4ajfZh9KaSZEodzhr9WVOHs7jezkLHt6N?=
 =?us-ascii?Q?rehgcXsdwqJqRHfapb9HV4GMtbx4OEsDrpIKPXRfQbTd2XONYMnmhHheYo+R?=
 =?us-ascii?Q?mv31He8AOetyHYf/4NAZeNBTuIqtsXiEUdM9N0Eg6LPv5pvhqwL6Vb/xHPla?=
 =?us-ascii?Q?Y9JWanaBvoL2Cc9dEqL3SVtqOMBU6Qor8esRJZF5LTivHXFY2hV1SkC4P0SN?=
 =?us-ascii?Q?xbztwOQC2OZjhoFKtbI7opxA0q6hCDorQOE1ZCx01Ucu6y45HaR3bJbqT07N?=
 =?us-ascii?Q?V/tDdCPsiI0TGhX9rnROXt8L4GP2wLml0ejWI6Y+sLv7ZJKRj/oRYduXpt6s?=
 =?us-ascii?Q?rYgPOPUbJj3EPOxIi8VUINmCjqg0hr27beNfq5oTb+9dbrHiqlcb1R+CjErK?=
 =?us-ascii?Q?hmdVHjJJKLRATyAvfTgGWRwYYe3fNJIi0PGVhG4oKx2Eu00uKHRUd1I4JLpP?=
 =?us-ascii?Q?nbvWzECb2kohq91Ibm8u6FG0oGxlID/RfMy42cXJYrKIZavmS8kJcz7ZltC7?=
 =?us-ascii?Q?JLmoRlRY1djeKR5IFEQELdQDH+HstC+plV0Iox/n4EgHsfr7qkNID7kIUNov?=
 =?us-ascii?Q?JyBtNAJBmt/niym4ddHfY9CVMEV3rEkvXCICIEhhJIQ2vv1ncGpk1EH2rbWx?=
 =?us-ascii?Q?iP7ai+dVDqRHMj+wVbSwbAh8F6xfi6jsGlBlEKlALYBLWZbHRQFy5QLLzUqN?=
 =?us-ascii?Q?gkDq0G0g71qmxO8dmpXus4Z6ifz5nJLBhrMKr0BaW916sR9TnpL+iZ0a/aCe?=
 =?us-ascii?Q?kXU1rdqdMD4pEPspdphvjhY+5M7wTXO4zIObvQFNpxQTNYxtEynl1/EkYvRS?=
 =?us-ascii?Q?mOqNm8sR5fVvNVpnhh8cgtYWIF4y8S0XGckyEkkXzzbXg13wCuSO/rkscvMW?=
 =?us-ascii?Q?KVVqJXnN+nzchpqT+DJloCl0IMBg20/oECvzdIJILerVVIRTCcKUYYIXXTN4?=
 =?us-ascii?Q?0xrwL6O0R8rqx9Nz8QU4vJNBfQjpjxpO4ZaSaHBuE1uBHBK6NxEJPv18Rfwb?=
 =?us-ascii?Q?xkM23xnnc0CmivR2NMRhU+FFqJmwBBsCj/FdEZUJKLXkmaz3gZkpePZt3Tts?=
 =?us-ascii?Q?BZBbkkE1ZCxBnOFXVIovtEiixF79iDQbfq+5AjqhN1sXx1HqtIK594uAfUM4?=
 =?us-ascii?Q?hFGsWWe4OOazxObAInRbzP14fAKgTMIEMsoCmAnAY9n8VW9pFpUAJX7sTppu?=
 =?us-ascii?Q?nlD8eTl7D94Q9iZ0hoGz8Tp3egVF+ErDqYuYxXM1W+wDTelyWkHc8bA2h6x1?=
 =?us-ascii?Q?tS4xyaPezDUf1Jhi13LQCT0zLK76IF0rr9cCqR4rAjHZJcvFb20UnHfCVarx?=
 =?us-ascii?Q?eQGHsOrtLXfLw2yduWhViZ7n7uXWgnSVl+k32gguRdntN5kS4ipFefsSPMxG?=
 =?us-ascii?Q?8AP/0esUm2P+v9e+CoMWfFb4jPM1SFioNTxqoGBfpT9TEm/2TquuHXyN/MM6?=
 =?us-ascii?Q?gg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b76e1a-4d59-46df-c8d9-08dc6a9568f5
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 10:48:32.5863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gh5GIYzm012A0Fy3V8hUQaDJOPgFjbip2/ARqj6vOo5t2u/j0axruPdm1bi87Ic2B0tH9kjEZy/PqjWVooVS9AbGkomNTSi/8ca2T7U/7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1284

The first patch adds optional reset control to support assertion and
deassertion of reset signal to properly bring the SPI device into an
operating condition.
The second patch documents the optional reset control into dt-bindings.

Changes since v1:
 - Dropped resets description and added reset-names property in dt-bindings.
 - Specified "spi" as reset control name instead of using NULL in
   devm_reset_control_get_optional_exclusive().
 - Included reset.h in spi-cadence.c missing in v1.

Ji Sheng Teoh (2):
  spi: spi-cadence: Add optional reset control support
  dt-bindings: spi: spi-cadence: Add optional reset control

 .../devicetree/bindings/spi/spi-cadence.yaml        |  7 +++++++
 drivers/spi/spi-cadence.c                           | 13 +++++++++++++
 2 files changed, 20 insertions(+)

-- 
2.43.2


