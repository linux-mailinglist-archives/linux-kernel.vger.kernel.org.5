Return-Path: <linux-kernel+bounces-128542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CCF895C39
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8543B25B54
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8113C15B963;
	Tue,  2 Apr 2024 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="ymwKlPw7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="XxmUEG9Z"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2128.outbound.protection.outlook.com [40.107.7.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E0115B551;
	Tue,  2 Apr 2024 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.128
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712084832; cv=fail; b=gQi1M6XRS2HXljIRUWsB3o7ITgIJ6oEDKx6xzURXb+8V38Wu1D8gJxpyDQ+vc7cQjcmGy2Vdpt1Wlh8jXZpf61L/3tccgZ71lYrzfeyu5xAI6IubXojv3UCboqcGt+nyjPik8rN2LO5kDUecdODu+lftzv28hdIwgoYlyWpb8pc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712084832; c=relaxed/simple;
	bh=Bumy7mcuKA8RhSM/+Db0nUrGJicVVIl8LA9zEyshMNo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bk4YMfrRtU6MHPiweVJiIFVXuiZ2YK5GS9nZE0vqkHlDqsgDyPjjonkEjp3XCpKCOZk9d14aT8SpP68FBjcbWW7clfWsnLeM4yXPoSkuNWAshGTdnX8lvW1RP77Wqi7zC4/x8yOYBBwgYNyk86MBskJnercUW1axwhB5Uhdxp18=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=ymwKlPw7; dkim=fail (2048-bit key) header.d=seco.com header.i=@seco.com header.b=XxmUEG9Z reason="signature verification failed"; arc=fail smtp.client-ip=40.107.7.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=n+rBIFXcjQpbsOeMGc5/Jmn0Md0j3Tf7DCqu4Slu8UzyfjV2P1JvZLWYcHx+s557FzIDCgZ1OM7vi8HtuH++NE7eET0z4jUDpR3HjoLisZC9ft6IID8lFaYXVmCRRat6m+MAPuazefm9MJdCduJp55koKR0+HiHlYa3K41r7DVCHVQ7xILCmrKIc8Ji5COp9t8tgGCBodgQvs5D1L8LaEAUGLqAbgNbu9TMv0PSFjn5Gtl4/vA5S7A83vSQiImnj5aAAGvbA8HYf5Tf7ASJy82WwIgPOWgtrCpLPJA6NzbQOntieNWyK0/ZfcWbz5UNEifZ1L9D6lr3Q/8TinZD04w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irOEhDtypAU/AVL3t/NwV3sTplFMzHNqYzS/HvwqpIs=;
 b=n+QA7pfUZBYMq0PDgxlB2c0srG04TmWOdJN01h/AZm2ZPHg8fds1U5xMGqRfquctTEeVZQb1VLN5q2bSPcPs9iL/w7lxhMr/qMRd8xLp0JjCrsiwmwafCqLS6TL2be9E8AONmFBthDBlFvrtgwdNoy5u2uMnws0+2Ee1DWLK2wfsAhTHq1cEkW/MG3bgYegVAZAU/IEpZJpOiodRyrNeTP8C2HlBo4tqSv+kdurfO90iuFQmoTjA1C+0fQdXrZqwBx5K/FejZWLr23Bc/h3Skl33FNGQepxpKHrH+qgYWqv9rWEBWVQvDPB3BujMJNX2ClKIY6p0forSyFHgjyMvSg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.81) smtp.rcpttodomain=davemloft.net smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irOEhDtypAU/AVL3t/NwV3sTplFMzHNqYzS/HvwqpIs=;
 b=ymwKlPw7YnOW8xb0TVe2iAnlGNvwCrqRMW8mso3jBFslM3TVyGQXvS2Wy+3GH5a/TaPB3ozi16SeOw4yQ3REvvu1moZP0Y3Vos1kywVyl9gPOJnpkGEABH6sYnBlzhiZeDxLhoSJm3+oKV1kTLOvXBIr6v6LOcPkiRRoHxN94RJAA06ahQpvgAbRsiKlstWFXiO/u4zSMs/s2cEzwfJwgFl5MGO1qvn4hQoRmsfPJ/v90tWdSZth+eiS9FOrIDd1ybiIvDQVTgGdHgECQPo5F9TULjqUiJBBbl2PdMrvVDiEWQa8tk9a6i30jQQYPTfbzlLJTNJbpnJAkSJOaHO7NQ==
Received: from AM8P189CA0012.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::17)
 by AM9PR03MB7330.eurprd03.prod.outlook.com (2603:10a6:20b:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 19:07:04 +0000
Received: from AM2PEPF0001C717.eurprd05.prod.outlook.com
 (2603:10a6:20b:218:cafe::be) by AM8P189CA0012.outlook.office365.com
 (2603:10a6:20b:218::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 19:07:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.81)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.81 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.81; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.81) by
 AM2PEPF0001C717.mail.protection.outlook.com (10.167.16.187) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7452.22
 via Frontend Transport; Tue, 2 Apr 2024 19:07:03 +0000
Received: from outmta (unknown [192.168.82.135])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 2688720080F8B;
	Tue,  2 Apr 2024 19:07:03 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown [104.47.18.105])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 85CC62008006E;
	Tue,  2 Apr 2024 19:07:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPb2g2nlS1c7hRi710Pglg77bxI1EF3aCycXrw/AfbbH3DwlUt1vkt4rSkAHDTfaDhPO8dOGV85WrMmRCNRmUecQE4zq5YAKHpowccszECFnAIoBkuDZGkR+XEr4WfYujG7py0uTVNGWtqnPWVhEi93srIiEwCPnC5hhgizXifq/OB4r7UgUVmXvQ+rqLJamlfDtR0q+iOjofx2mFg3COnfYKhy5qpmi57ywqSuI9+hGS3VozQLPGSIpjmZkCsF6g9HiTTzc7397eErHjPf6zDCpb9tQ7NJIbPqUcZQsh5lDxm2OOpLiD0tYE2JSqrbEIlhrjvee6a4VKEn1UcydNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xF96jsRoCWbeqCirlRwjdYlx4wGPBVPup76VuAEap0=;
 b=aKnl2gLGDtz1/rmWlnaE1FbXe8pxgx8xCaJ8vO1/uskVVWTsC/BcpOfz8Psz+fqhqXFMw2FUNLc7VOQ71btW66BQ4NdZHmyNrWkKKGDLWczkJ8fz5doPuBFfEmH8DTRIlj5xwkhVSxV5YI8CtsxW5YBwVGWWMqrzAyW/K6Toux7yDQMW/WKtFj4e/9TOKsEhq7yQcvVK7u39Q5E0ZjmwWSog+GeIGw7HDaT12JtNnTN3WKSWZBRIar7mQDiAuxQNtKp8bY9AlzBEhGpW8py2pFYOpCo4F4ZZQiMCJGNMfKq3uTLDWpYzT3H06uEC/qP6Or1iVMLsMlVdtZNR5DOmXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xF96jsRoCWbeqCirlRwjdYlx4wGPBVPup76VuAEap0=;
 b=XxmUEG9ZssOIt5xLsZJ2K6kQvgkUvmhDlK/264hmWvLE9NfliF4Z78RmTsMBfhyHsj+CFPk6qkNrv9HJh1KWPPFDzG8WiLowLFX3/Rb4quMiRKD9IvR5DJg8amvd0NFDbrpNs5n+kgZLQdPHqWfW0dHgFIqmBNLvk6NhQB75ZZ74qlc4MFjix6vtTQOxfimOODpy0pU2xT/Ya+f3Gpe/Td2n6VmJfwsBn1Sz7NS2ifhNKtEDl6v9wttSG9uhMf6vfb9tOP2KY7e1SJ6zMaJobMSJDCXVz6CGClUTmUSpL2ZgoT1+2gKjuTn6zSbS8M3CuyV0e2qqtzt/AylglUKRew==
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by PR3PR03MB6363.eurprd03.prod.outlook.com (2603:10a6:102:71::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 19:07:00 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::84d0:c817:1e20:5554]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::84d0:c817:1e20:5554%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 19:06:59 +0000
Message-ID: <87ef3f80-77aa-4833-b74e-a2e950bac442@seco.com>
Date: Tue, 2 Apr 2024 15:06:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: fman: Remove some unused fields in some
 structure
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Madalin Bucur <madalin.bucur@nxp.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 netdev@vger.kernel.org
References: <425222d4f6c584e8316ccb7b2ef415a85c96e455.1712084103.git.christophe.jaillet@wanadoo.fr>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <425222d4f6c584e8316ccb7b2ef415a85c96e455.1712084103.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::12) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR03MB8847:EE_|PR3PR03MB6363:EE_|AM2PEPF0001C717:EE_|AM9PR03MB7330:EE_
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 Pafn6gjJNxIoxh6Z5e3+vy94DNUy7pxmQ17bMlquz1BQnlx0/4hzsdrVetH8KbpJ2jTXR8IlTvn/B1S5F7hc7BHIMFiFE7g+Sx9/hu9VGMMtEXzp24MSJcbw85Ag9O22pUfxKom9xG1PZF73muNZukKJ8CStrvkFrevWLOz2MmJAWXT1GtRgpoi2wxB0H917y2zxEr1g2lDQetGHaQgO9I8Ak3N2K0L7CKaXa3+IOT7NxXeDiI/G7DJ9TyPZ6TsDijyL5gp6cK121vZQsI36MaKY7UNvwCNhuk864ncr4Yap4MDN0p7IKfaqz/dJ+ZV/2WNCd6F4+8rEbIenSzOfMuo6CnxZ/fVezycvW3jWGDW+lWXVP5EuqrX+DGCWSEET83+Er3D0B93Ki3e107WBdiuDwsqwpXYMAj/EMRGT32hJQST7yumOovUHVJ+KHoVMrWzEDKwgO/HQJF1J3rLXFv6bBH+u1qUFZ69zEq5WbxcnqIciZi1hCK15Zk92HNqRk4+vzsmbyhXd+ctuK6c8HMIA0Iudz1GE+v4fDNfnwU83Kf+N9h6X6y7p4yeGF0pLiAZbzKGJU8lP2R14lYisJKbhFAc6k/TxmlYSvuUUWwnpfXR+y5jPoDZjuAf6aNJ45dpkWYd7UdAKsz0ss+c04IWOwx1JArKnYF7lEB33+rP2BxPDPWFWEch7sSDG5Z/AHPzm9NCbdAMXkHaHfjIkJf6uNsiJBnR7jJThfms1iNc=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR03MB6363
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccfbb59f-bfd1-4185-3510-08dc534814f0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Nle2OV/3GN+Y3/Cnh3FdAJKU4o0RRX6Uy/hzCitG4O9E5nzAZGkBheiCNMuMrwONiwOlzT7UbW9gJBqExAJSu5SzIF/U4RtD/aEipN0aJIyl/Ct//qaKKc/RjqoA04ApltOBB46t2yliXrTwRMjlX5vK02MfyY7SPgt1f0DMMsCOMAJH6z69RNJXPs2XgcfFGPhWa+XZ/s+0lLZpH5nX6ueVJBvjlQYBOMP5v6m7llt6jCmj/U87aIMRfkWyroxBTwgUTlEk3iIm0hhoZGJsQlCZiHeZxh67FaSZiUhHTkT00HzJDZ+7/pfO49lhzC9iwiIcyzG9xmxoxD3Y9ocAO6whq1uLbhIaCpDPd9mK5LNCLFhxtfShp84SaKQSTy1goLktwjzNEx9BuHjvqoXaujQg6rkBduWR2bGRWwVE9nG6lq+SgVHSGUAPyItxA5uALHqcHOC2fOT1S4XO//BlgHaac7zQWB5yFyt3Bjo6HlTKm+xAH6ezfeiCc3RiCd/to+cAHKy5asl0urdTOSDbT8MrYipm0pydxm4hcjC6+mFOugmLadzgfXK9wZhk406HLlXwO82+ZGE/DzpLeW+cOeo/q7dBEv3DGNdqcj3PWzS47uurlpTHKbxSTuERrAaL+c0r3quDxAf7qh0sDANIbNU//7ILowgkEBr6kTCi6P9QZss0+7DYnmwishfMYxNxCIN955MvvB/9hkpqoY6k7O5igrM9ZbCgJEgnwstrUvLXyjNn6bkiQfuwVxQ246zN
X-Forefront-Antispam-Report:
	CIP:20.160.56.81;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1102;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 19:07:03.3336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccfbb59f-bfd1-4185-3510-08dc534814f0
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.81];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7330

On 4/2/24 14:55, Christophe JAILLET wrote:
> In "struct muram_info", the 'size' field is unused.
> In "struct memac_cfg", the 'fixed_link' field is unused.
>
> Remove them.
>
> Found with cppcheck, unusedStructMember.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
>
> For fman_memac.c, I think that it is a left-over from commit 5d93cfcf7360
> ("net: dpaa: Convert to phylink").
> Maybe, #include <linux/phy_fixed.h> can be removed too, but it is not the
> purpose of this patch.
> ---
>  drivers/net/ethernet/freescale/fman/fman_memac.c | 1 -
>  drivers/net/ethernet/freescale/fman/fman_muram.c | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/n=
et/ethernet/freescale/fman/fman_memac.c
> index 758535adc9ff..92b8f4ab26f1 100644
> --- a/drivers/net/ethernet/freescale/fman/fman_memac.c
> +++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
> @@ -267,7 +267,6 @@ struct memac_cfg {
>       bool reset_on_init;
>       bool pause_ignore;
>       bool promiscuous_mode_enable;
> -     struct fixed_phy_status *fixed_link;
>       u16 max_frame_length;
>       u16 pause_quanta;
>       u32 tx_ipg_length;
> diff --git a/drivers/net/ethernet/freescale/fman/fman_muram.c b/drivers/n=
et/ethernet/freescale/fman/fman_muram.c
> index f557d68e5b76..1ed245a2ee01 100644
> --- a/drivers/net/ethernet/freescale/fman/fman_muram.c
> +++ b/drivers/net/ethernet/freescale/fman/fman_muram.c
> @@ -12,7 +12,6 @@
>  struct muram_info {
>       struct gen_pool *pool;
>       void __iomem *vbase;
> -     size_t size;
>       phys_addr_t pbase;
>  };
>

Reviewed-by: Sean Anderson <sean.anderson@seco.com>

[Embedded World 2024, SECO SpA]<https://www.messe-ticket.de/Nuernberg/embed=
dedworld2024/Register/ew24517689>

