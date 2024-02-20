Return-Path: <linux-kernel+bounces-73810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4771585CBE7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AB561C21FBD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C402154C07;
	Tue, 20 Feb 2024 23:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="NHm6o83I";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="NSo5lqrI"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2134.outbound.protection.outlook.com [40.107.20.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CB7154451;
	Tue, 20 Feb 2024 23:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.134
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708471040; cv=fail; b=gLrfzIBcmQZz16+t7bffPP73ZOyCV5EHTGR0CbIV4kJZc6wNJAt79s3uQA7bnvx1XSd4hcK1DIRKQ4mT5GtCNruHALS1Fasb3EhH16q+HpDM2F3ME/2u3+RJ31eafeDUp/n7kFWLNlLhf6lV11+Bx2vaj57Ne5dMfX5mEjVBGgg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708471040; c=relaxed/simple;
	bh=ZksUlpzB3Skb+6Q6PPYcwt3Gz5U0cJlc6HUVqpiLPL8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t+Tbu0Y1LgzYSv6Ccx5go1RurmectPla3JJ4TQcfeaTa2XeyGSJlwq+O2hWV0KG0vka7JJfDLFg97yyJeb8CIXeyOXdLTe3/sMwQln+7u81XX8Gqy5+Pw14zSuIZ1CF4JGLrncSYIjsp5KhmUVGLqWOC8tc/aPeu0VfDUKKnVCs=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=NHm6o83I; dkim=fail (2048-bit key) header.d=seco.com header.i=@seco.com header.b=NSo5lqrI reason="signature verification failed"; arc=fail smtp.client-ip=40.107.20.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=MaILBgTlWc0hHtPshbmQ+XBJn0W8Ql9YHrWH03T37u51GlRNYU2tAuOk9fFF06FYqqOOPOZWbOZojakhfB0TC+XKd9CiJKMWWgQlzHt7FLlNiFnVNmctteozN5cML5bUPG+PLC5cCr3rt/BQjnaqzLxd+899XI7iaM07p26COB86tuNAdiuCglkRw5IOIVCs4qFpSrBvb07ed/1Z1elmFEtIfYTyg0WA3Pv8RFnBCgpFnzu0Iugjpswo6tGxs6LXBDHR7SmDb2P98E4MtdF6bu2hWoNiz1fjE4ANKqmeEUNiRdnYb1yQLNceMkW37W0V2F39DqEi9uAIamDtyPpJiA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZksUlpzB3Skb+6Q6PPYcwt3Gz5U0cJlc6HUVqpiLPL8=;
 b=RPbuSTbIQAaVgy9Zspo6TdtZdk+3CoSgTF4O3gbelschLngskJHCMgFAeU39BsqOGivYEAq8h4cdvTqcEBQQo97HOJbA4p9M8JFN0vb3RhiBOfYC0Xgzyxw1HYZgWerJuv9hP0yh9oSCsTecTqzfMIyWZdPgrWkGtjehxTWfsB4c4B/DvMEtfN0B9qcVwB7+KlJHv9MhIsBgNSmPPDTSiwmFKonWdB6nm76CEQpJSsw+13nT0GOI2+0icj4sjoLnGpXTVCPpHOTLXezzLfsHHg+41XEkgn4dDBYmaBtHa+cYtlpQt/g54G59ISAJ5YRAExBWBWNkzFi4uc/h/SATDg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.82) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZksUlpzB3Skb+6Q6PPYcwt3Gz5U0cJlc6HUVqpiLPL8=;
 b=NHm6o83IJ6/MqZdKX12Ws4UFcMiC9vk/6o176R30aR7zDchfEvAfxH0sbnqT9mBwdFVtIapzhGASFepm0uPOGzcBemUrThdKOGDbYrjwXTVvfyr86igkh8rHSZldlbRTnn43/EZ1oLVwftUBRHRnS2z+TtD+fvTTUsYpTpQbTrKcnWJSR1FVRs7mAP9LDXJLdNMYYEQmeVdX4c/yA4zpyeyKhW0rXEpTZBvplWOj7Q1HqS8KM+lqKlA1HCqqxKokvRoy+Iw661Nre8JYq3/AR6B92ZoUATNnTs5X6i1iw/pZyIYuZljOiAlbvSTGtMbkbUbbxm51xtgKqBlxJo9SSg==
Received: from AS4P189CA0057.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:659::6)
 by DB8PR03MB6267.eurprd03.prod.outlook.com (2603:10a6:10:132::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 23:17:14 +0000
Received: from AM2PEPF0001C717.eurprd05.prod.outlook.com
 (2603:10a6:20b:659:cafe::9e) by AS4P189CA0057.outlook.office365.com
 (2603:10a6:20b:659::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Tue, 20 Feb 2024 23:17:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.82)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.82 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.82; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.82) by
 AM2PEPF0001C717.mail.protection.outlook.com (10.167.16.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 23:17:14 +0000
Received: from outmta (unknown [192.168.82.135])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 0FF1520080F8A;
	Tue, 20 Feb 2024 23:17:14 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (unknown [104.47.14.50])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 41FE02008006E;
	Tue, 20 Feb 2024 23:17:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UinJiybBUGTB5ODoAgLtLl/AEqa2+oNnyvi8VpTz1a1hGhPxEHDrg5eaMArQT2Y1mD5xsMvFabZ2jV2iV/VeMCJyf9blRDqVTZgeZifIHxf6p+nkK/csVjF4rET5EpbDNKuLjNlW/FwQxLP5IFRYiTmRZc3jR3DNDzn92jSYNPWyT9tY0O4fe/8+vaBSbS4OCStEyuKclmyTLTD2lq5PVJLeaKduHcJGMU+6npW4u5/qUK4dyzUfsc5EZIct0nxG9+MuRfnVZjgHAGvvN5C84fmukK8oHbYIzigf8QZ/GJ61dFHKmlVRsJb2iaNuJT8jKL9FMRilarI5kMdYtMA59g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiFPZYnfngAWZL9TnT/gDAJVgnTvVA22bA6HxPDBuPc=;
 b=WebVo4pZLqTaOZjQv9MGEXeEKHkh3R/OW6EORmYD4gorwxS5/Za56T7Ozz6fxFA2JxjORn1OBYB7Wm+g4oLtKSQHcOkfksuO2vLFlMYffiWNs2/4iJvxO89GGCmvaTy9/2Je3bGRGz5dMn0FobadTLRHsTO98PHxxBe9ZoB4UjAoeRHBS3HCBXe+c0fnPfWz57hMuip51zFdmh0YQ0ZCpZLvNcWTGp3Ic0EHmGivSjuVGvvqSJIwJ1GPfLpq9/0ZW23gJnDAL4GsZxqFpsBF0t/iW1W3nmXBlcVoffdYxlduM+ogtsJgOkv5y2NwIGn+KtXKXRZuj//dO1UWzeCpUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiFPZYnfngAWZL9TnT/gDAJVgnTvVA22bA6HxPDBuPc=;
 b=NSo5lqrI7FE54s3ZD/mII28MSzRikD3cYV5phxVQLiJ4TSY5up+rIqJXQpJsWE3qeG+YHdeY7ZLeiNGnBhgV83Gxb5XrAeDVumRH8s1I/9Ux89oPWacWMW7xqjIK3pRDOUqw0zro1/+GZ5v/umgVIAmOALDnSFq6yb23xzpfqJ31igbJS2ZtCDgn1AaJfMcUE3NVctKA4PtVDMPF8TAVVDifJ82DY4/mEhTMVVeO9kDhnoG/uFf0UX+X9CIB9SMi3y2VROu1r0QQtt5/1M/HTXLvw0QK9bJamkoDSM2TfBALr2fzsF2nezutst86MQQ+PwY5i1ZPPqra1f+OKVP4tg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by VI0PR03MB10567.eurprd03.prod.outlook.com (2603:10a6:800:209::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 23:17:06 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::9529:5f9c:1795:a94c]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::9529:5f9c:1795:a94c%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 23:17:06 +0000
Message-ID: <bce5cff4-c1a5-4d71-b6cd-a89c55a628ba@seco.com>
Date: Tue, 20 Feb 2024 18:17:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: ls1046ardb: Replace XGMII with 10GBASE-R phy mode
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: zachary.goldstein@concurrent-rt.com, Shawn Guo <shawnguo@kernel.org>,
 Madalin Bucur <madalin.bucur@nxp.com>, Li Yang <leoyang.li@nxp.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240220145037.kf3avnykjif24kkr@skbuf>
 <191b4477-7b4b-47eb-bb3e-0e4d08b3b32e@seco.com>
 <20240220223706.o7wc5r57omkmgtgh@skbuf>
 <e39c811e-ad9d-4e90-8710-629b822944e0@seco.com>
 <20240220230656.cefvrh6avji2elrd@skbuf>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20240220230656.cefvrh6avji2elrd@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:208:23a::30) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR03MB8847:EE_|VI0PR03MB10567:EE_|AM2PEPF0001C717:EE_|DB8PR03MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 89554108-ccef-4284-38b3-08dc326a12c3
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 hTnI0TsgT1h2u+ONx/DovGfM1kduG9bbc6EM4QlO0fxgy9oi7QvJH6G1z3wbMjwbiJjIdXSnv0Ot3ssQG0MNn7phNbSl5pP24y6HzFIdg59SymyEYdYBSfAH8H74AzHoD15obpdiPIAJ/w75eTWS7ArUYPPuKsl9dOJHShumXdk1Xy6qXNOR6jZ+sEqdGew/OPhoVI5lUF6M8Q1JccfFbiqYkxMiF1FuAd5NTm9onJFwOmZwpOTAy0Ae8bqVKaRcGTcY4UMczDSCCZRR5deo2apbpj+pd5Fl/q6ZRZULeB1qkQsG4S1QGQJ7QeYPgBvq0uMRT76XJPFOHJjwevWdM2Ae6k1mVrJEmaX++ayMSCJ0WwYoCAuQBXWZOGv8mfnH8W47ORjcE9wdU7mdCwtKs32Hno+ov98qo3jPR3S3HWWpPZ5/k+w6crJmyDyXmN5DPWHW+snOrWQxpW8w8845dC0XAfZjFTEMNu7rX2Av0nzXjfUlvm/SJtvnQcpuJwWHEmmwQfHVvPmzw4C/MF/gqIFWrKaxA/vSB/8RCwpWBjG5Ef0j+xrFxFFIcPTcoAHRMjUw5qI/EM7jwd79XRLLo+f5SUVea1xa/fsXi8oV3yV0wCH128pfiD3dYsyKq8ZP
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR03MB10567
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a53f7387-582e-47be-6cc5-08dc326a0deb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	flf3nXYRbX9JaYgzyBKXD+2p5JYINok2c4WXh73bUGqaICz5HxQONZvC/T8r8OnnWul0Fe/bW/kzswJ+KRvLKVqzYfoCGLkCUycjGEiWVPMX1GBLhLuKvZ/35H/hMLlGED7jHlCpHvGvY44ERhWZwr+JZkjLhfHNHuON9730CDiwn0RNg4kDNbrLyeOqnDyAdH5yd4/89racBucGPIqKijk+UO1g6Z8ws8Ee1BlmPdd9KMFG9MMmiZMUxhAuSkv+pTAnWyr88vRcVWti92yaCBqkZgO+0v+srO9ir6X8J8EELZ61k9yzqmrcxYq4dR6QujWneX2STbDfpXt3aBzJGAlkvt5vYrN3YWQq0vmOEC3R/19Xq5CROWcrhDMOFE/im/nNiU0mM9AdXUH+hLN1jQW6EX+xWjExpJ634zyrup3qmeKeVkRiCZ/OMABRGdC/39vKZ+jPeEq7JoW0iNc2Ggd0jxYUYUAIJXIeYzJ4mgWQw508gCl654orHlNU6PwrYbB3wKhyfov90fCTf4nc0kKyIxXHjqhG0V+zSzTRq2HDBcT5vDt+ZP4Yw6Fiw0AdZWvFwUgnN6/ohZpnl0DFKxieUk6Bb9eDGdfikWPw/SqyxMYHaOOlvtlSbZ0md5vhYtucFtPfIZOhUMm1uX2PB4RZIQEMH0P3nI4mC8VsPog=
X-Forefront-Antispam-Report:
	CIP:20.160.56.82;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1102;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 23:17:14.2005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89554108-ccef-4284-38b3-08dc326a12c3
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.82];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6267

On 2/20/24 18:06, Vladimir Oltean wrote:
> On Tue, Feb 20, 2024 at 05:52:36PM -0500, Sean Anderson wrote:
>> With SGMII and XFI, the PCS sits on the MAC's MDIO bus. So for SGMII and
>> XFI if we don't have any labels we can just assume the PCS handle is for
>> the right PCS. But for QSGMII the PCSs sit on another MAC's MDIO bus. So
>> we need to tell the MAC where to find the PCS. This means we need to
>> supply multiple PCSs to the MAC
>
> So how did the other Layerscape devices with the same SerDes, PCS and
> mEMAC manage to get by and support QSGMII without listing all possible
> PCSes in pcs-handle-names? :-/ DPAA2 has the exact same situation with
> the QSGMII PCS situated on the internal bus of another DPMAC.

I'm not familiar with them.

With DPAA we used to just try to configure the QSGMII PCSs on every
MAC's MDIO bus. This worked out since if you enabled all the MACs, the
right one would eventually configure the PCSs. But it also meant you
couldn't determine the link status (since you didn't know where your PCS
was).

> It is unnecessary and buggy complexity, and it will only have to become
> worse when I add support for C73 backplane autoneg in lynx-pcs and the
> fman_memac driver, because I will need yet another PCS handle, this time
> not even one that represents a phy-mode in particular, but a PCS handle
> for C73 (with C73, the autoneg process determines the dynamic phy-mode).

There are multiple physical PCSs there must also be multiple PCS
devices. Otherwise your software and hardware will get out of sync.

If you don't want the complexity, then don't design hardware with multiple
PCSs connected to the same MAC.

--Sean

[Embedded World 2024, SECO SpA]<https://www.messe-ticket.de/Nuernberg/embed=
dedworld2024/Register/ew24517689>

