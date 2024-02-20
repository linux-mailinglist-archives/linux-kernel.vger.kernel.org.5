Return-Path: <linux-kernel+bounces-73575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F5985C46A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1A41C22CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1BE135416;
	Tue, 20 Feb 2024 19:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="vz/GG8ex";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="WRFdrEaw"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2118.outbound.protection.outlook.com [40.107.20.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7AF78688;
	Tue, 20 Feb 2024 19:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.118
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456391; cv=fail; b=sA7ol1oB3yQ2mGKmWz3LtFceEroIU2sbC/ZuS0ygzSh3LPXk98q5sBefU+L4NQTr3O4mkXTyMafvpRp1SHYLminSLYdyDpMZUe5AQvx3yhc9ahw9JSOi4d02c2AdSOnkDDNV8cQd7aszSqBC5l0Ec069/eu3xg6YgPG3oyTAuEc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456391; c=relaxed/simple;
	bh=nAENB2f0qZECVsvD2cDTIjXZD09EeLXaTNMVMEW1R84=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W99L8fkaFSSaDBgRrFoQ2cSM3od6K+5//XfJbcOUpjG7pzfGIm72Ro8Yjr+KOaFOGYJ9K1QylWrNfzFXyN2P9r9a8ESbpiAdVXe7SINpXRIfyyOFd2+0uPVz7h6r1hlFt+XBoz34AmdPgr9SuvkJ1vqS/IiH7mZKSA8fURvyg5Y=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=vz/GG8ex; dkim=fail (2048-bit key) header.d=seco.com header.i=@seco.com header.b=WRFdrEaw reason="signature verification failed"; arc=fail smtp.client-ip=40.107.20.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=KdvtXq1IbpsMVi67OreRyaZWonjz1GaExUhcqDhv9tJWvdAQmN7fIQwK3YE3uNHvqRG/ZnuY70f9oPxp+2qaNTWeLFO4z7lHkcJ1pbQUZ3LjseRKAsrvJutpQknfrlI8HlM5p42tHME4aybiQOpzjv95MgfubjgGnS/Le6AULewLDtnYmNzr3yRoEULAuGAUeQZPUl5QJGn0wnb0BVc94I31y0RtKKEt29rqq8AwpV74EoiO10dRiEhWG3FnYkMKqJLLMcL6Nq6jHyR+IFjoGAO8RBMv1wOihxrZVPhSOJ+V4OiVBoqjo6KxJrb7ECbyF/koPgin+g8J7FOiAJj2Tw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8r8FkUebiJ1/QYVf2dw1W1q3LVre5LvfBKSsZ9P1mo=;
 b=MPbZpUNHSHYTgwdvO+rE5BUVbfzjgY5IGgF2Rf+rjz0dY2RjyJ39litTq2s4m1PbSwGaQTMlEQToUECPxJuAKue/4MlfPeATPXbA5plK++pXb0846nAq+3GRwd0O3UY8kYdX/ed2EaE0rd0P/XSvNrmYFp1a1xI1bMTLKrV6BjoMckgMz3/KDJQxmaidB51w+pBEcc4pV9UN8QZ6Fl3JPFJDizib+0LA5GGiK0daW3pSsNHNLlrJqc+3YqlPQFf8Rfwo2uzXvsyMUBL+rFvp8f2XiviqkyM4Ld3h8nLdvlt8YCty1XJgzNOHM15J2TtZjk8nZ/65W8cN7jC3k6JpTQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.85) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8r8FkUebiJ1/QYVf2dw1W1q3LVre5LvfBKSsZ9P1mo=;
 b=vz/GG8exEwMlLRvBYSL1J6tCtzN/82tZdFMXIDO1M25nhfzBf7kv1XVreRLyXNC2zY82XLY2UMmW2z7M0Mg7NBkBhcxq/gUisf2SVNQdAzv6FLPCnch3nFKDjuvA81v3g5ciIq3WnNdLEeHuDAcWzM+3NVY1m+n6/C+jhjsEo2hF0m8vBl+wqH4dbEeqk5OtPxC3V+tQjNW648qk/mY+/T45nBMVrgeFNZyP5jfSvwew8nTWraSY+l13EK6luIS/fpxX09w6hUcjaCZkHKaqO5Hz5Feh7D0V9KNDsImoBVKK20cyUXIdo5nSunsVLPpE4rUhc+VItTufcUnfzpMucg==
Received: from DU2PR04CA0002.eurprd04.prod.outlook.com (2603:10a6:10:3b::7) by
 DB9PR03MB8284.eurprd03.prod.outlook.com (2603:10a6:10:30b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.39; Tue, 20 Feb 2024 19:13:03 +0000
Received: from DU2PEPF00028D10.eurprd03.prod.outlook.com
 (2603:10a6:10:3b:cafe::23) by DU2PR04CA0002.outlook.office365.com
 (2603:10a6:10:3b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Tue, 20 Feb 2024 19:13:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.85)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.85 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.85; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.85) by
 DU2PEPF00028D10.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Tue, 20 Feb 2024 19:13:02 +0000
Received: from outmta (unknown [192.168.82.135])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 7065820080F8A;
	Tue, 20 Feb 2024 19:13:02 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (unknown [104.47.14.51])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id C5D2F2008006E;
	Tue, 20 Feb 2024 19:12:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBdg7tuynu65suauh41OvVwS8i49iVLZBaxhkRonkM6lSk3j7gmV7Hle7ovJAY4hWR0aO4PBl8oTr7qrkUkM5fqMy5GknXrDYHLPy3WPkzdrvpYM+xb4NhxfhfvI5LawMuD/M6ERsbU+wJYcl/4yE6vNOnB4vV+ozRHijuCypDfZdD0H6NFb3J9F5YYohUkis90jjR0vOg7xiTUoOIQ7aOQ611Jj4adqrlcZtffjOXT9V/xLgaTs5RHwCMtcocqxOBbZ+620K5ZJN6pUEODXSM99JZKXWF96A+OerAucuoQgdwh52wwMPw+RNx8lv06sMIZypijgdbB0TTLbX+D45g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxXD6y6BMGKaJ083P8Tqvz5UauiSajreppEq4H7jbBM=;
 b=AuWYU39yXQOvskk8qlB3Hdn9JMdakb8att24Iyf7hbInv+IezeT4/XKNck8c7b+FrO4D5mwN0iJ8OptKs5jRzQ7s5SGUAl7Aw0UmbGEHzdyk1xRPDuSjqro3Ps3Ejrm2dAwG808xX5KYsxNVyXQG3OCuMkBY0LpV0XE7U0gJKIjszW6HiNfoApONThs/qVoLWeWYwB49JD0f6LerorV3KiL9uFwoGl1XssfY/NCfOf1WaPgAReqCCBbLUWOiDN10M3qOnEzmlLzvs2rMsgLSAcdQA0m6JTibV9XGj5xcuQM9hgcGQbyr0imvoQAhBDQ5/1zcF3Lb9LrJCH/cOGxUMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxXD6y6BMGKaJ083P8Tqvz5UauiSajreppEq4H7jbBM=;
 b=WRFdrEawsO1Sx50GshlIlaiFCHW1pvgtDt3dOW3bdNswvxad7ssl6ntsYRCh5bVDSefN3hKSCtXVi5aAhRcYggCFPYjVipeyv3lZXWDyM78KUBI8tKBUC4wduTPlD2Ewcx10M24aJjFPIf6blJ0dLyUhYn7RmNp/pRVAr/ofRZeOJ94Av56JmaHjYxZYQuT2jzV5/MzAb2MnYZUWR/nhlleHr0X2zXkh9RBOiqfdaaRx0lflM+vlcqiQbaxiZLXQ9Yay9ae6/RG+PlfuEQSotjQdQlYHZFj+8PDlaIqkjShFeWnStL2b7kzB9u1Dt2ASeL6coeChrlzvNg9OqC9AMQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AM9PR03MB6898.eurprd03.prod.outlook.com (2603:10a6:20b:2d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Tue, 20 Feb
 2024 19:12:56 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::9529:5f9c:1795:a94c]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::9529:5f9c:1795:a94c%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 19:12:56 +0000
Message-ID: <191b4477-7b4b-47eb-bb3e-0e4d08b3b32e@seco.com>
Date: Tue, 20 Feb 2024 14:12:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: ls1046ardb: Replace XGMII with 10GBASE-R phy mode
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
 zachary.goldstein@concurrent-rt.com
Cc: Shawn Guo <shawnguo@kernel.org>, Madalin Bucur <madalin.bucur@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240220145037.kf3avnykjif24kkr@skbuf>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20240220145037.kf3avnykjif24kkr@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAPR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:208:32d::15) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR03MB8847:EE_|AM9PR03MB6898:EE_|DU2PEPF00028D10:EE_|DB9PR03MB8284:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b7e00d7-82b2-42bd-8e82-08dc3247f5d6
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 CwghI5hrI/Tm8BnhkYOiA8IbfePlfkZiRPt47XJ/z3Duwc1JoMTCp0oCTrvOIDwHpGMpNf1jmKrWCXsXrC3hKhKVpc/HOJ+u7lB05W0oxbtdHkLyvQGv5Jwz21uCn9jr6eVRyqxnNL5VqCR8IiMFwC4fHnbE9NwxFnXWkqs8LLd65yroPjCYVg1b7m44FFmVmOWRl/OZ66qLOIR67ZXg7ZS1ORNfkloZt1/z0Lbo3IfYoGGIAtqTASWNsYkObLzc6WgEbeZhmbcQpP6AgVwWajgmA7Iiqa85rDzIXNCm0KBbNrRcOv3KKPnshabQwIp20XJVosYFNq8fYNCDA/fMTGMumDGRtzppHf+fawmJg+qz49i84tbasEViOHgIMHoK1/LDvRXwg7G8kHKdbDdASxXu1qMwczBNC7f0LNpewwYHsOQcgsEWHLUVFQvQxP9Po2eAWOiovkdMAFC+NqlaY/CEc26lJHwqcAKKB/QB2g5lUO/4T3uoWWnvWMwn+6ReEFxa4nM4OQ/bU3dbVSbloefsxHjgHc4pldkPCIonmUkzGt7kS1K+dNtEI7T1X680v5/2rnTfQ8jsVje36P88UzIxxT6Ie4O6ppXONZkLZu8=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6898
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D10.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1dfb0ef7-3a79-4d4c-a77e-08dc3247f218
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sLS2A0Mi86ZrWVfMp9yGJNxgq+FQ52iQjWDE3jDfdAeRSKpG7K3Sv5TTJ/s/dxAB7xMEkrxsu2QneR6z+CEuA2jVVw2knfvhRtt+7PQRXBJMZD3GhkSXIxe3FwjK8JVseHlt9qXUWHa3TwEmjB1Ye51gh/WJTXqGmgvsv+jBBEZL10Gp508HmAF/WDe0/h4+h9PYLBBlCP49jPHSCDPbPqYzA2UKbHsjpgfJQXwSdrmmVds1ZUwPyEBN6wF8oO6Q2PRMTNg8Q16yH7ENyLzLr4bRqSHum3TALF5+jKCSoTSMBgM7u6hrThp54LnAKkhxpk27IVT6pMe0xj4KDjpXcYd+qXAELKkMasC7/324I190zBvzIK9852lXaJ9apQv5s1yo5ySvFnIBJtCuP20WhcbaKgtsDyytcIZQGGIbVo8USByKkjloaaSNPFMXb+mGInb2Av0XXUKkOPsHanojAEb6y31aCsw3xkqZcpuUOHXmxxUfBM1sr8jnmsa8jnr7Bjr05UjmiHAhS5tepCycWC0Et76nB/h+9ItRkXwNVtEiiyg9VMPPtcalSj5t2Ee1A9lbXzBscdP77cf/6qW2xoe5491/aYuHGRPVkLPj/ECrYisLnAsw2eLVeOm17GRszouAMgWz/TLOPIAaTWhRlA==
X-Forefront-Antispam-Report:
	CIP:20.160.56.85;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(230273577357003)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1102;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 19:13:02.7376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7e00d7-82b2-42bd-8e82-08dc3247f5d6
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.85];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D10.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB8284

On 2/20/24 09:50, Vladimir Oltean wrote:
> Hi Zachary,
>
> On Wed, Feb 14, 2024 at 05:21:54PM -0500, Zachary Goldstein via B4 Relay =
wrote:
>> From: Zachary Goldstein <zachary.goldstein@concurrent-rt.com>
>>
>> The AQR107 family does not support XGMII, but USXGMII and
>> 10GBASE-R instead. Since ce64c1f77a9d ("net: phy: aquantia: add USXGMII
>> support and warn if XGMII mode is set") the kernel warns about XGMII
>> being used. The LS1046A SoC does not support USXGMII, so use 10GBASE-R
>> instead.
>>
>> Signed-off-by: Zachary Goldstein <zachary.goldstein@concurrent-rt.com>
>> ---
>>  arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/ar=
m64/boot/dts/freescale/fsl-ls1046a-rdb.dts
>> index 07f6cc6e354a..d2066f733dc5 100644
>> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
>> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
>> @@ -149,7 +149,7 @@ ethernet@ea000 {
>>
>>      ethernet@f0000 { /* 10GEC1 */
>>              phy-handle =3D <&aqr106_phy>;
>> -            phy-connection-type =3D "xgmii";
>> +            phy-connection-type =3D "10gbase-r";
>>      };
>>
>>      ethernet@f2000 { /* 10GEC2 */
>>
>> ---
>> 2.40.1
>> base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
>>
>>
>
> You do not need this patch in upstream, and I strongly advise against
> merging it as-is. I've just tested pure net-next on LS1046A-RDB, and I
> can bring up fm1-mac9 without any warning.
>
> You'll notice that commit 5d93cfcf7360 ("net: dpaa: Convert to phylink")
> did this in fman_memac.c:
>
>       /* The internal connection to the serdes is XGMII, but this isn't
>        * really correct for the phy mode (which is the external connectio=
n).
>        * However, this is how all older device trees say that they want
>        * 10GBASE-R (aka XFI), so just convert it for them.
>        */
>       if (mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_XGMII)
>               mac_dev->phy_if =3D PHY_INTERFACE_MODE_10GBASER;
>
> So, what gets passed to the Aquantia PHY is PHY_INTERFACE_MODE_10GBASER,
> even if in the device tree, phy-connection-type =3D "xgmii".
>
> Now, _if_ your patch were to be applied on top of upstream, it would
> actually break fm1-mac9 like this (WARN_ON added by me for a call stack
> of the phylink_validate() failure path):
>
> WARNING: CPU: 2 PID: 1 at drivers/net/phy/phylink.c:763 phylink_create+0x=
8f8/0x90c
> Modules linked in:
> CPU: 2 PID: 1 Comm: swapper/0 Tainted: G        W          6.8.0-rc4-0105=
8-g9e1deba407fb #1812
> Hardware name: LS1046A RDB Board (DT)
> Call trace:
>  phylink_create+0x8f8/0x90c
>  dpaa_netdev_init+0x1a8/0x2c8
>  dpaa_eth_probe+0xd70/0xf64
>  platform_probe+0xa8/0xd0
>  really_probe+0x130/0x2e4
>  __driver_probe_device+0xa0/0x128
>  driver_probe_device+0x3c/0x200
>  __driver_attach+0xe8/0x1b4
>  bus_for_each_dev+0xec/0x144
>  driver_attach+0x24/0x30
>  bus_add_driver+0x154/0x244
>  driver_register+0x68/0x100
>  __platform_driver_register+0x24/0x30
>  dpaa_load+0x34/0x64
>  do_one_initcall+0xf8/0x34c
> ---[ end trace 0000000000000000 ]---
> fsl_dpaa_mac 1af0000.ethernet (unnamed net_device) (uninitialized): faile=
d to validate link configuration for in-band status
> fsl_dpaa_mac 1af0000.ethernet: error -EINVAL: Could not create phylink
> fsl_dpa: probe of dpaa-ethernet.4 failed with error -22
>
> It fails because of this in phylink_validate():
>
>       if (!test_bit(state->interface, interfaces))
>               return -EINVAL;
>
> And state->interface (PHY_INTERFACE_MODE_10GBASER) is not in
> mac_dev->phylink_config.supported_interfaces, because the fman_memac
> code is not prepared to handle this combination.
>
> The device tree node for fm1-mac9 looks like this, generated by an
> awkward merge between the following:
>
>       ethernet@f0000 {
>               phy-connection-type =3D "xgmii";  // fsl-ls1046a-rdb.dts
>               local-mac-address =3D [...];      // U-Boot
>               cell-index =3D <0x8>;             // qoriq-fman3-0-10g-0.dt=
si
>               pcsphy-handle =3D <0x31>;         // qoriq-fman3-0-10g-0.dt=
si
>               compatible =3D "fsl,fman-memac";  // qoriq-fman3-0-10g-0.dt=
si
>               reg =3D <0xf0000 0x1000>;         // qoriq-fman3-0-10g-0.dt=
si
>               phy-handle =3D <&aqr106_phy>;     // fsl-ls1046a-rdb.dts
>               fsl,fman-ports =3D <0x2f 0x30>;   // qoriq-fman3-0-10g-0.dt=
si
>       };
>
> Notice that unlike fm1-mac10 (node "ethernet@f2000"), there is no
> pcs-handle-names property (fm1-mac10 has it defined in fsl-ls1046-post.dt=
si,
> whereas fm1-mac9 doesn't. Don't ask me why, I don't know....)

I think this is just because this ethernet is always XFI and never (Q)SGMII=
.

> So, knowing that of_property_match_string(mac_node, "pcs-handle-names", "=
xfi")
> will return an error code for fm1-mac9, now please walk through memac_ini=
tialization()
> and see what happens in the 2 cases:
>
> - mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_XGMII (current device tree). =
The
>   code creates a default PCS and assigns it to memac->xfi_pcs like this:
>       if (err =3D=3D -EINVAL || err =3D=3D -ENODATA)
>               pcs =3D memac_pcs_create(mac_node, 0);
>       (...)
>       if (err && mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_XGMII)
>               memac->xfi_pcs =3D pcs;
>
> - mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_10GBASER (your modification).
>   The code will still create the default PCS, but assign it to
>   memac->sgmii_pcs instead!
>
>       if (err && mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_XGMII) // not =
XGMII, but 10GBASER!
>               memac->xfi_pcs =3D pcs;
>       else
>               memac->sgmii_pcs =3D pcs;
>
> And this is why, with a NULL memac->xfi_pcs, PHY_INTERFACE_MODE_10GBASER
> will not be in phylink's supported_interfaces.
>
> To make your device tree patch work as intended with the current
> mainline code, what you want is to also modify the driver like this:
>
> From d6bda34b132d17d1c236d27436b9335fac22c062 Mon Sep 17 00:00:00 2001
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Date: Tue, 20 Feb 2024 16:12:27 +0200
> Subject: [PATCH] net: dpaa: fman_memac: accept phy-interface-type =3D
>  "10gbase-r" in the device tree
>
> We support the phy-interface-mode =3D "xgmii" conversion to "10gbase-r"
> through code, but not actually through the device tree proper. This is
> because boards such as LS1046A-RDB do not define pcs-handle-names in the
> ethernet@f0000 device tree node, and the code only has fallback xfi_pcs
> determination logic for "xgmii".
>
> By reversing the order between the fallback xfi_pcs assignment and the
> "xgmii" overwrite with "10gbase-r", we are able to support both values
> in the device tree, with identical behavior.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  .../net/ethernet/freescale/fman/fman_memac.c   | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/n=
et/ethernet/freescale/fman/fman_memac.c
> index e30bf75b1d48..0996759907a8 100644
> --- a/drivers/net/ethernet/freescale/fman/fman_memac.c
> +++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
> @@ -1076,6 +1076,14 @@ int memac_initialization(struct mac_device *mac_de=
v,
>       unsigned long            capabilities;
>       unsigned long           *supported;
>
> +     /* The internal connection to the serdes is XGMII, but this isn't
> +      * really correct for the phy mode (which is the external connectio=
n).
> +      * However, this is how all older device trees say that they want
> +      * 10GBASE-R (aka XFI), so just convert it for them.
> +      */
> +     if (mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_XGMII)
> +             mac_dev->phy_if =3D PHY_INTERFACE_MODE_10GBASER;
> +
>       mac_dev->phylink_ops            =3D &memac_mac_ops;
>       mac_dev->set_promisc            =3D memac_set_promiscuous;
>       mac_dev->change_addr            =3D memac_modify_mac_address;
> @@ -1142,7 +1150,7 @@ int memac_initialization(struct mac_device *mac_dev=
,
>        * (and therefore that xfi_pcs cannot be set). If we are defaulting=
 to
>        * XGMII, assume this is for XFI. Otherwise, assume it is for SGMII=
.
>        */
> -     if (err && mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_XGMII)
> +     if (err && mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_10GBASER)
>               memac->xfi_pcs =3D pcs;
>       else
>               memac->sgmii_pcs =3D pcs;
> @@ -1156,14 +1164,6 @@ int memac_initialization(struct mac_device *mac_de=
v,
>               goto _return_fm_mac_free;
>       }
>
> -     /* The internal connection to the serdes is XGMII, but this isn't
> -      * really correct for the phy mode (which is the external connectio=
n).
> -      * However, this is how all older device trees say that they want
> -      * 10GBASE-R (aka XFI), so just convert it for them.
> -      */
> -     if (mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_XGMII)
> -             mac_dev->phy_if =3D PHY_INTERFACE_MODE_10GBASER;
> -
>       /* TODO: The following interface modes are supported by (some) hard=
ware
>        * but not by this driver:
>        * - 1000BASE-KX

Can you please submit this patch? I noticed this but never had the chance t=
o go
back and debug it.

--Sean

> But!
>
> Device tree is stable ABI, and changes made to the device tree file are
> meant to be backwards and forwards compatible with the code (it can be
> provided separately and not necessarily in lockstep with the kernel
> version. For example, I understand Arm SystemReady IR wants U-Boot to
> provide its own device tree to Linux through EFI). So, in general,
> device tree changes which only work with a corresponding kernel change
> are frowned upon (unless maybe if the kernel change is a bug fix that is
> backported to all relevant stable kernel branches).
>
> So at this stage we should take a step back and re-analyze the cost/benef=
it.
> You said there is a stack trace in the Aquantia PHY driver, which there
> is not (in current mainline kernels). I _think_ you are seeing the stack
> trace with LSDK, which is currently distributed on top of linux-6.1.y
> and has not yet integrated the fman_memac conversion to phylink - thus,
> it does not contain commit 5d93cfcf7360 ("net: dpaa: Convert to phylink")=
.
> At least, I do see this stack trace there. I think it can also be seen
> with mainline kernels before the phylink conversion, but I did not test
> those.
>
> The main take-away is: ALWAYS test the patch you are submitting to the
> target kernel it is going to be applied to. Especially in the area of
> device tree bindings for DPAA1, things are rarely as simple as they
> appear :) If you don't, you will have an unintended negative effect
> upon current mainline kernels (which must still work), and not the
> intended effect upon LSDK (more below).
>
> There are a few options to go forward from here.
>
> As there is nothing broken in the mainline kernel where you are
> submitting this patch, the simplest one, as bland as it may sound, is
> simply to wait for a new LSDK release on top of linux-6.6.y. Even in
> lf-6.1.y, AFAICS, nothing is broken except for the stack trace. You can
> keep the patch in your local kernel tree copy to suppress that.
>
> The other option would be to submit the fman_memac change as a bug fix
> for stable, wait for a while for it to have time to propagate, then
> modify the device tree as well. But, it is much higher effort, and
> there is no procedure in place, AFAIK, for LSDK to integrate your patch
> (other than through upstream + a few months of waiting). The upcoming
> LSDK release will be on top of linux-6.6.y, it will make your effort
> irrelevant if it's only for suppressing the stack trace, and you are
> racing against it. This path is only worth it if you have the dedication
> to dig a bit deeper and tidy things up in the DPAA1 kernel support
> (which would be appreciated though).
>
> _If_ you are using an older linux-stable branch but not LSDK, yes, the
> feedback loop between your patch and its effect will close much sooner,
> but you will have to convince the linux-stable people that it's worth
> accepting your driver rework patches for a functional reason and not
> just aesthetic (see Documentation/process/stable-kernel-rules.rst for
> reference).
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=
=3Dhttp%3a%2f%2flists.infradead.org%2fmailman%2flistinfo%2flinux%2darm%2dke=
rnel&umid=3D8bfcbf91-eb84-4daf-8653-378929ed0326&auth=3Dd807158c60b7d2502ab=
de8a2fc01f40662980862-d89d931594581c69e3bf19f86f11d6de905c5a8b


[Embedded World 2024, SECO SpA]<https://www.messe-ticket.de/Nuernberg/embed=
dedworld2024/Register/ew24517689>

