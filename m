Return-Path: <linux-kernel+bounces-73783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 322CC85CB2F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B476C1F22922
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD7B154BF0;
	Tue, 20 Feb 2024 22:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="Bd1CddRB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="g5ysXB2A"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2120.outbound.protection.outlook.com [40.107.8.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69E4154457;
	Tue, 20 Feb 2024 22:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.120
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708469583; cv=fail; b=SY+tb0wpcm5PYMiHRsoHoaLRVaHu0u7OckCTSIT8vkL2wO39Mh9Oa12JZWa1IbuvmVv1c8mpdpzYafUoKITN9YOExuRb4xsUIPGdX4Z27APY/vDiwymGNoGeIi/gnqa8iydsMKRrPhJpcg6RKZIZ3HwtFROIb3aawBH93o+tl1I=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708469583; c=relaxed/simple;
	bh=JzLOEHdAy0BNDcnJ9yXG9/19UtBOmrxycIrFfcmrNeM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cYPdRLkkm7IgjywoeLKPoI/Lm3ZWj1PjWxed+IxAewTBZLLvCMHu7wq6jnIj2HfHLzdlQF08AO6dCKkfRnsDv7wiqTmJP8KJFvKsiyTbGO4zUu7LhZy+dTGe+/Q7CuuqM7HtjJYUDIC+kv/IRDrB2lF4Gn8HXf5YaLXYeR8CG9Y=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=Bd1CddRB; dkim=fail (2048-bit key) header.d=seco.com header.i=@seco.com header.b=g5ysXB2A reason="signature verification failed"; arc=fail smtp.client-ip=40.107.8.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=f0YufQN3fWiGxeMf9SnDCdUaX0XMQ3S/1deNEE7nUvRlsV9nnBOd/EZTMOpWyaO2Kcvbw+JXT9dVCwoEV/E9C573thC1LrEvMvZ5w38lAxabytGsh7bFtVWNtdrWyt8x4FiUNmh2CDFQpFAUTjcsBe4/lTkh26+XLMcTDWkChSF7OkiSFsGn0UCY+eJrialSTBrSH+6TfN7H9UHsdSV0JOR0JmmMTcsGkP3dW/z/6st6hds1AYZCeYVsX2MMr9vxft7PP6yuA+P5y5UgJiEDedry/ucL0aEACnjplC8UrCOw1oz708UuuwRPOvjZaQo3kLVlUWKHCx9jYa07J9BEsw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzLOEHdAy0BNDcnJ9yXG9/19UtBOmrxycIrFfcmrNeM=;
 b=L2bwOkdaWetkIGWyDB4eJOIJanpjP5lxXhL3gTPRrT7jXyyhlZyr2MDkpOiNdxEUDd8bvTu1sWOrZjYke/0wbeeCBZl0SqFU3C1Vnnw1chuGR7K8I68XKKhnAKuy7vpjX12PbpkbWezSx4CDe+Dy6w3U+c6OOdgm3JuEJ7p5B3Vbr6RaaCg15QhTJ11ONihdCz2i6UIZb7EFyjsrZS/bUp0nQBqEN61e66U5YQuxDpG2lcBZge4c9s1Nhdyzs1Je+s22cAZ68UdEEYr6V7oE8pcRqjT192R4NDbQpQeDtOcWwDGAdgXTuPew99yGfrwLd7iWhlAgGcSxZnlKAAfOqQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.84) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzLOEHdAy0BNDcnJ9yXG9/19UtBOmrxycIrFfcmrNeM=;
 b=Bd1CddRBmFlWIxPe19cKCl7b/IlmKNXfL4atcvx2ci4+hnOb1cuvmD61bgPTsSCCc6UHRiVPR4Zw/W+dq6U1KoeJF/7bfR7GetGZKsJpfvffpAiJLDLTgt2CETsrN6YMs38byaVhFoxrCj36TyJAQwvx6+YORlu1n42D4jqSCQquNmI9RSBW5mvm8ndI+Ty4BWytovtQI/sDhg81W8m+jci/5OEnNFzZJT0yFaz72tIjasaSVyYcdSnLPY8XAYJd/UHksQ+uW+Iaaahnieq82cfH7aBtBJLDzgpz4jKoA5sJuk23VdIa8yJhLFxD2Nxix8H2b4pJQXYtkpB3MzGL2g==
Received: from DUZPR01CA0087.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::18) by PAWPR03MB10092.eurprd03.prod.outlook.com
 (2603:10a6:102:364::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Tue, 20 Feb
 2024 22:52:49 +0000
Received: from DB1PEPF000509ED.eurprd03.prod.outlook.com
 (2603:10a6:10:46a:cafe::fb) by DUZPR01CA0087.outlook.office365.com
 (2603:10a6:10:46a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Tue, 20 Feb 2024 22:52:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.84)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.84 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.84; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.84) by
 DB1PEPF000509ED.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Tue, 20 Feb 2024 22:52:48 +0000
Received: from outmta (unknown [192.168.82.140])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 41A1820080F8A;
	Tue, 20 Feb 2024 22:52:48 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (unknown [104.47.11.232])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id A39DB2008006F;
	Tue, 20 Feb 2024 22:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dimVd1rnh5LRWZXPy85xApD8/jCj1Td6hz9iTEO/6aDRZRu6PPQR8Pn+IF3l6tjzxZqdFPFLemffvvHgJyJlyaeSJZJVPGgZnLKljDWRnkx88RByMykrRFB6cMRItp6nj717McgNQSQ3hKwU1/cSOTDJxwTHMLQA7+XiiZXW4UJs+qfQXKAEsQgvpi1uXVfBZbvN7flYBis2CVLq1ApfM0vXC6hbIf3cQtd4BrNw1QbepO206T9Hy5r87OFS+Q2Q0loByLW8jUru0ScDK8QiHqehEwgeG5S5z41YSN5SFT30+3r0BZw6+bccWSxvHL4HuHkMGaejCOESCrpNE/aNXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lu8vDOgjmbgVg8E+BOPnKEdkHGCyZTIdlAOL2bXWijg=;
 b=Js1pWybbNU1x06ciMRlKFN5cG9/NECfi5UehPp+6bxXi5MWRfvoDgF7UqkN6xch8GcAhv0lpovtBGrr9Yiibj3rRw/aIaXc7d5YkqrBQyonQVwGWCXRUIBlBldUSsKByWLf/bIuLOrkeKBLBaEIqO+E1MM7/vbOEvqenuKo9C+OqVOD2YuVx8IIWZGQKYahWvhQv2y2a2qvKvY+SOhzA17cBDI4mLs/htZu+ygBjPWs9e0L6eR+pO031iIDqvJmaKqRmccwufyssUVmqmyxtWkoV2L9pmHonlj9bm53CrF3BHVZWFoKBUfgqD/qxASNSDALFdhE2aYCCBtgy8BNOYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lu8vDOgjmbgVg8E+BOPnKEdkHGCyZTIdlAOL2bXWijg=;
 b=g5ysXB2AE5pKQMVXYp/5unb80YRM13oBoqo5n6mUM/pDqRh7JzSAQmrSGqoHgigkWsb3ctOVxYSAngh80YIg2IuC7hG6FkACKzugLOke1J1wl0YJL8l4zxawXLIzGZ+7DCn10lVfvnFhZqrSYLZ79zkth0U9RaYWBoP4RbwwzuWIcauU8LghWLHRHNayuu//wn1sEm5IhZNbH9uz5grIy3+/zsoeS6hckatLmfLaIITEMNsojH/S/MwMR70/RkCM30JxIjMoIIud6ZmgUO95gbjHArBK7MXqaVg1BZLWYgI2XbJHvWVqiQb/Xm9kKylPbBPdFQQvf3i3QnRu+ex7MQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AM9PR03MB7758.eurprd03.prod.outlook.com (2603:10a6:20b:3dc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 22:52:41 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::9529:5f9c:1795:a94c]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::9529:5f9c:1795:a94c%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 22:52:41 +0000
Message-ID: <e39c811e-ad9d-4e90-8710-629b822944e0@seco.com>
Date: Tue, 20 Feb 2024 17:52:36 -0500
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
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20240220223706.o7wc5r57omkmgtgh@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR19CA0012.namprd19.prod.outlook.com
 (2603:10b6:208:178::25) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR03MB8847:EE_|AM9PR03MB7758:EE_|DB1PEPF000509ED:EE_|PAWPR03MB10092:EE_
X-MS-Office365-Filtering-Correlation-Id: 6949bdb6-f738-404f-1196-08dc3266a94a
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 ShCCZ2oXW3t0u9c03bh7TIkeJYwX+tBs0DDfre1Tdke832QBegnhPv1KN3d1rPer9TOx1kUgPT0lyH57LqnKVMQMqwqx+HMAuz/+/N4HK9iMD5lu+Z9RFAMh42aqfrKHW0J2f5ze0Bg5nhCvvyvEh8qxhC7UdJfA+swEew2PCAXhykWIoMcyHB+3lA69c7BOTvjMJiz+zvnxoamhUWkj86bftad7eQosV2M/WBYV56Xxh58erMVS0nmWWxIY1kcKvY3S8g5Vo/cgjbY6nRg+RcYxAx+xZsnRcCe0Yksbci8Rm+of0r9RxWPmy79ySzNvobH0jH/zdcVjf/dFkZp3Pcn6RvSzo3+ibtkkN9QXPCQCirCA7soLkkDJn5A3Im9UvIbtTjlYW/pjL3t0mNMzoKrnqZieCxsEOaiHQgk4bBQs9jWyfNa9euhez5FDlfKqq46k2ibTkJWz7jRPQck9Qmnp4nGsH0rRFhiuudD5YYfvgXGE0YRj+SwkLTpTB0cToOwK1VkBWdqDezwibL5jqHWyU3QbfHXzMuyiiEpj2kLyIU9ZnrQtr3W/egO2Fih4EozFQWbDu0q/GxdU8ad3b08T9r4FGVy7cMH34sDO4YoFj6BQWZ6ZF3EMcaNVZ0ge
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7758
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	37ffa3d2-cf4f-4f6a-faa9-08dc3266a484
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gbW1hrTFozoKz6SlLppJyCa7XTzEdtX1/sZ//M1deH9giSZaMIbgyV4CAg4Ti21L6oIsOwbYYUJwIBslsulkX0i1IP96sCFkwJ1g95K1ILmS0HrWyAncOXh54wrV7CYK3gKVTIeVzxwF9UMX8FNFN019YJ0EVRuUO6y+YITQV0pqN4RrGf5tBqp0nXV+RWr/taqYgR35zUCx0MfRlELeAQpgpHWGOFid0JZgMJnCFB1MkZRCpMP67p11dsIm6M4iRHiWYBigcjiEsblAn42gA2r59w4kWJaGxJn08+tsUUOiE7vMUhLuFMDF23a9jsD2IHVEXzdfN+8TrPe4OjqZCmhfGoBoHY42ZUM1XbaS00eaQf+uU2BzvCdO16DxhjrLB1YCjScd4IkZKqoE2RqBj0BMUuM78QCinJw87iqhxpEh3xo56ZjMGl2UCs6yUQL/EjOE9gE/9AGTCD3RwHrQAZoe0MGMXPkQOYKpmHhkGCvlcH5RRyrktNx1ZrbtFUT4WFOTf0dH4kHMcedI76xoPkyzCXWyK7a/RUYyuvQdK9IOkP3Egu7ou/ycD1VxkghcIzNl7EbDcGWMzIwjFOS55GdwCckZGeKN75CdjFtbg1D7Yz8F1aiJOl+TRNKiEojOsViD8rBZCktuDAQ4LFqWPQ==
X-Forefront-Antispam-Report:
	CIP:20.160.56.84;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1102;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 22:52:48.7399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6949bdb6-f738-404f-1196-08dc3266a94a
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.84];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB10092

On 2/20/24 17:37, Vladimir Oltean wrote:
> On Tue, Feb 20, 2024 at 02:12:52PM -0500, Sean Anderson wrote:
>> On 2/20/24 09:50, Vladimir Oltean wrote:
>> > Notice that unlike fm1-mac10 (node "ethernet@f2000"), there is no
>> > pcs-handle-names property (fm1-mac10 has it defined in fsl-ls1046-post=
dtsi,
>> > whereas fm1-mac9 doesn't. Don't ask me why, I don't know....)
>>
>> I think this is just because this ethernet is always XFI and never (Q)SG=
MII.
>
> Is that so? With SerDes protocol 0x3333, won't the PCS that's connected
> to fm1-mac9 use SGMII/1000BASE-X (thus not 10GBASE-R)?

Yeah, so I guess it just can't be QSGMII.

> And as for QSGMII, what's the relevance of that? You can't have one
> device tree good for all SerDes protocols and RCW pinmuxing options.

The goal is for the "generic" includes to be generic. So the board-specific
stuff lives in the board-specific device tree source. And the only thing
board-specific is the phy interface, since the drivers can figure out
the rest.

> Either there are 4 MACs aggregated onto a single lane, or there is one
> MAC per lane, but I've never encountered any use case for alternating
> between these 2 configurations at runtime, or with same device tree for
> that matter, have you? QSGMII seems to have been the original motivation
> for listing all possible PCSes of a MAC in pcs-handle-names, but again, w=
hy?

With SGMII and XFI, the PCS sits on the MAC's MDIO bus. So for SGMII and
XFI if we don't have any labels we can just assume the PCS handle is for
the right PCS. But for QSGMII the PCSs sit on another MAC's MDIO bus. So
we need to tell the MAC where to find the PCS. This means we need to
supply multiple PCSs to the MAC, and thus we need names to differentiate
them. Since MAC9 doesn't have QSGMII, I suppose I never bothered to add
names.

--Sean

[Embedded World 2024, SECO SpA]<https://www.messe-ticket.de/Nuernberg/embed=
dedworld2024/Register/ew24517689>

