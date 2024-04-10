Return-Path: <linux-kernel+bounces-137865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558D489E87E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788F41C216C7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 03:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED148C122;
	Wed, 10 Apr 2024 03:46:39 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2133.outbound.protection.partner.outlook.cn [139.219.17.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D59DBA41;
	Wed, 10 Apr 2024 03:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712720799; cv=fail; b=UJ3TOwQZjxTELgLiwaqyjOwwf45j2HLz+zF/olqcUwqdXtQjl5yjhMAsqBTnztiUNBhHIO2KG8FWvKuxhY1x2vyP14WvQASV3MjEL/dO5bFg8zdft3+u2mldJW26ouCzSmY/PepbCwYYxmmkLGVDbD/bI73s1Z/bnYdkgVJAOcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712720799; c=relaxed/simple;
	bh=OHCssj6P9836bxBkW9i3I+ExmBMlSFBu8UzczJgWy1k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cUFHJdqSpC6XxuiUiPeEOTiZjNfRrIm69hCY2Ba/Ncphxv9W+oEf2VFLNxFIUohXFBOA9nSx+qiNz2LupMr4lZYL+y/CEDa8HPqlFXGk54hqJC1oT9t8/aqLngS3skBQvrNoEE3gKSSCR89nRPZ2xebkNt+X+F5Q4wc2gfeRtW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1//TsHPYbRhvzg40MUBvtqzmBZOYIqH2bRw6dEwPnPgafTu1GxeTOwJhRytC5V7alxlXDeZHEGSc06rHoQSVlY5wHMP/c38dqVyIPo+S3iNpy/waY556tt/o/r40rbfHY03VAneO0hsSrebG6bI7l+o7qUScXmM2CYAHMGUki6/cDlFxBr4MPFwuI2Ji3IcJ5AYKjdolRGmSBig3VAVkwZmOgTcGuemZR5AZK7hxc2TOkuL+zPAsilm7LQR9mAWkw4Y0q1AlBnt/l4HHveF9ezJdc3zYm/3YE2VodPT5/HZcpvGlqDin9PaUQuxGdyCMQta1NdWz1kf5DC5aEBXuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OyzaIpuYkm7hUH6I2Tsyav8LQgUQuoSS7RWMmfsqVw=;
 b=d4payKHQxR2v6AoFuut3aDgw+ELZhNLi9p/4gqiRPsjjuiv2e13uMeYUYcxPeZ3nNhDr2cMx0tC8M2pAiB+bojWizNt0VHW0VBFFEJwuMMKflojcO39Mur0HhSPvnowc4fVjK3yvo8L5pzoi1V4xb7jrb5QRp0E1nV0H6Auxto+jkq1rfGasFKVsQD+DQRhXUYdMipj1pCx6fMMBAqfmyJTEiDTkmHL27AvF2i90hIwFO29ovNb2G16nk8mL9R3F71aBX5OSMaIYZJCvJEmwAcIKJGE3tA9HEUsZJehO8w1F+zLaq7xc0yHNYaIlSpJP+fVM3vBzQzLH4+lf0HjmrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1132.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 03:31:55 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::6174:711d:d93:87c9]) by NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::6174:711d:d93:87c9%4]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 03:31:55 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Emil Renner Berthing <kernel@esmil.dk>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Hal Feng <hal.feng@starfivetech.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 0/2] Add notifier for PLL0 clock and set it 1.5GHz on
Date: Wed, 10 Apr 2024 11:31:46 +0800
Message-Id: <20240410033148.213991-1-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0002.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::23) To NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB0956:EE_|NTZPR01MB1132:EE_
X-MS-Office365-Filtering-Correlation-Id: ba8bb759-87f9-45c2-71b5-08dc590ec4f6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v1BGuvOV2m3yd99T/nTPZ9raXRx/dhnbiuQP9bQC2SnpBydmzFvvcYFRyF3NckAPF2Ph+GSAWtFyEZPeYlv44WESJ10Zt0QDv4TrE5wUPblbrpd4jYuwBlcJNUt553CCReKt3fqC54Hp0ujGIINKvARyEuXjJZ2yelzso3C0RDGJ4woWNYWE8skW9Rui1YEbKVGLMyJsnb3Huq+7aOl5WGmjGU0cObWDyYJMaZ3JymNnI1kUKVkF54tUhQoOcYalPmNdJ8BqOg7MdDOs4kK9eeAtr3jKxju3GM5p4E1f8OGfunTQWZqQgcqYd8Z12g5aLpMwidSdFNcY0HMtjdBoA9enYk1SfQzhAfiGw9tH67YVK/Dv+h232LNBYQSPwb89uTjr9KHeM//7wC6WqB0zoqmamYBckGsdCNm62R98t40UiFYNyBqxV6MVn+g8MC4qMaf1B+5YWKyrdhwC6DQVa0ixy5sPFXc6JyPpiZjAl6zQqVhn3i2jVgbqKogQi/mT65yMbg+8GW1mTJ/ppJSH/zS++zwSr0MxtWMl/tCuBwgqoVCu5avW524fOYbV42AXekLgSCQcvu2HCrqCq+cs8B599ny5YsdIe7tZLUZyDs6j47reAmes97N/PzOkHFou
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3B5iQuNSYOGb29ylvKxQ9eqztyQrNrv29G4Q3YkG5PuUZwrAE/XlLQjw5+rv?=
 =?us-ascii?Q?cbw1c5kFuEeQVxrEZvwY4OXIvEkuALMFrFhd1MfRH84yV3AnmPrc/RtX94Ni?=
 =?us-ascii?Q?J8rxMRAEIep3MDo9k6I5Jh5foeqsYUdTTv38bKQHcs6DoDClVahhLGbFYuoI?=
 =?us-ascii?Q?CZrU/dfzVC/nV/ujL9Wi/yH6WGFiLFqRzB1LBNp6yPt3XwmzfhwDVMP7I/qh?=
 =?us-ascii?Q?dSpBs/oe8nx2RCcNGzolfzYtrq9H3RuYHRnSPvMNrLN2QIqnKpyAlCkA9ZPI?=
 =?us-ascii?Q?zMRwJGAVaspHsjezgG3dNTOcJmsmNZSSRRVrLQPw0JrQff6haEQqPJdhRP46?=
 =?us-ascii?Q?KIgkJCAB/IGjEHzlYxxDqo7U57wgKpUyx+VC5ODHs9eItn7hKDSIJNykgNGX?=
 =?us-ascii?Q?iou0CbsfgQpAl//OU1Aake9Nt3meXFtB+UqEt12LAecWcGB4NBnbLMMfNmco?=
 =?us-ascii?Q?zwVr8LICD/jGuUew2Akw/Pc5HxYU+Q3DAIBqXZUVLGAR3aym7jnY5FMGGDop?=
 =?us-ascii?Q?tCE+yk/BUrLcu+rreyjXP8UJYdUTQggcoTxKKh9Qzo1+irZ9hZwCef/IxP77?=
 =?us-ascii?Q?uckm9Y9dXrbdb5V2E4qK39SielyT/XOsmQhJqaR5vVORVpQJ+qkQxhmHd2pJ?=
 =?us-ascii?Q?iGQ7YHRD3VRkCkyRzvliQhQk4HZak0+XU3r6/HOwE7OfrmZUdN5BbgA7Hdm2?=
 =?us-ascii?Q?azqPShinIHSCIEBc1QIA/rkNg6uDWej9pYPFV2cUYYkH60RBAtE5NUU/8M6D?=
 =?us-ascii?Q?ijTBUHPsMoMhhWPKketZF7hw1HfyrKnUHS5LAtEf9VUObA3hSR9v7dVxA5ov?=
 =?us-ascii?Q?Q0i9MiFUeV+xJSuPac7OZteQRYQHuVT+RqfEX0ab0I4Pl+nVRsBrMmgSm69y?=
 =?us-ascii?Q?03UWwLuRjij+Rv/IJTqZtnQW9ijEstaE7uciUIYPqjrE1OUfNmtB3pE8NXVM?=
 =?us-ascii?Q?va3eOBL/hO0/V0ossOch15+iA35dFm9jUnaURA4h3hH79NfC9W0yYMHcm1e9?=
 =?us-ascii?Q?Nc6+CpM8GyLy6Ch6ApYtGiwJVia296bP95boVvaIXd4O31qioPeAHHeb1Bs+?=
 =?us-ascii?Q?xtdzOlgQQqoKQUWKJ+7Tnu1A+82k5SIL2wPhY4jQZ26DoK6tgctL0FRJekVc?=
 =?us-ascii?Q?lQPuJnTkBdIHhrWTV8DgPC6TQlqqLjbqL27De4EAeqPZRZb46MyZvTZgHQsW?=
 =?us-ascii?Q?xBlVoxiC+RP7BQRJGCR6ThGN7MRJeGBVhJTZqqwVWEgkqJz4M9xrULDLEMmN?=
 =?us-ascii?Q?mIXACkPywLbQdk1KWPnrTRlloeMaqAc0Dy6We8+JOTamzPF6zLg2o91VyQ+4?=
 =?us-ascii?Q?fswrGhrLsOLcRF2GZnC33hrbIWsELeMkJNvFiDmeGydANubs4ApQiUfUd5YD?=
 =?us-ascii?Q?ps9wT5D71x/XjNOzewBjJti2zYaseZY+/80qFsTiYdkYDbvlH3IITJpj5BTz?=
 =?us-ascii?Q?rF/7LjqIDAt6Pt6GiKWnWgiOPssao06iNxjLUs8TqhyVsrkkXUPw9nJ24im8?=
 =?us-ascii?Q?y9qw97Dzra0b+J0+PhlvqiRqc6zam/J8vqztPk+OSgS4uSUlOVr5d4csGyrj?=
 =?us-ascii?Q?4ubXpRU5d6A1NoKNOxlRUVL31C27k4USl8SpbYLRtt8GdfKNYPTiRmkq1H7o?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8bb759-87f9-45c2-71b5-08dc590ec4f6
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 03:31:54.9810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i753RIXX+9pTsfJt81JCT5tsXo+5EyUUzX/T0C73pPLydFZKbsTbDy5s00ULq9sMhea4q+IfmTtKNE5lH7KoQpLww34VaHUF7j/n/P6q3sk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1132

This patch is to add the notifier for PLL0 clock and set the PLL0 rate
to 1.5GHz to fix the lower rate of CPUfreq on the JH7110 SoC.

The first patch is to add the notifier for PLL0 clock. Setting the PLL0
rate need the son clock (cpu_root) to switch its parent clock to OSC
clock and switch it back after setting PLL0 rate. It need to use the
cpu_root clock from SYSCRG and register the notifier in the SYSCRG
driver.

The second patch is to set cpu_core rate to 500MHz and PLL0 rate to
1.5GHz to fix the problem about the lower rate of CPUfreq on the
visionfive board. The cpu_core clock rate is set to 500MHz first to
ensure that the cpu frequency will not suddenly become high and the cpu
voltage is not enough to cause a crash when the PLL0 is set to 1.5GHz.
The cpu voltage and frequency are then adjusted together by CPUfreq.

Changes since v3:
- Added the notifier for PLL0 clock.
- Set cpu_core rate in DTS

v3: https://lore.kernel.org/all/20240402090920.11627-1-xingyu.wu@starfivetech.com/

Changes since v2:
- Made the steps into the process into the process of setting PLL0 rate

v2: https://lore.kernel.org/all/20230821152915.208366-1-xingyu.wu@starfivetech.com/

Changes since v1:
- Added the fixes tag in the commit.

v1: https://lore.kernel.org/all/20230811033631.160912-1-xingyu.wu@starfivetech.com/

Xingyu Wu (2):
  clk: starfive: jh7110-sys: Add notifier for PLL clock
  riscv: dts: starfive: visionfive-2: Fix lower rate of CPUfreq by
    setting PLL0 rate to 1.5GHz

 .../jh7110-starfive-visionfive-2.dtsi         |  6 ++++
 .../clk/starfive/clk-starfive-jh7110-sys.c    | 31 ++++++++++++++++++-
 drivers/clk/starfive/clk-starfive-jh71x0.h    |  2 ++
 3 files changed, 38 insertions(+), 1 deletion(-)

-- 
2.25.1


