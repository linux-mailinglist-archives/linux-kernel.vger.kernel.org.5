Return-Path: <linux-kernel+bounces-95841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3E48753D8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CFF91C223CC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7FC12F5B0;
	Thu,  7 Mar 2024 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="XtUCoo7F";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="AF5DAjpC"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2130.outbound.protection.outlook.com [40.107.20.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D0B12BF3B;
	Thu,  7 Mar 2024 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.130
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709827628; cv=fail; b=iQPmSUXZqd4CmSGiDQ7WPruHdC/QQ7xVF1WGH5/fzN02ccHgJ3bPrQsO6jVmmlwzQ6kqetOpxQk60PGRmDKieBDfEg/XsZGy6LxbjnYQEuh/dvAapp0Apdg+9TlnJGm1+s534nQYi7IsxjayQhNi9CqgjfDb+3bUcyAZre+jhK0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709827628; c=relaxed/simple;
	bh=dWJeGMTvRUPSyyWNt9cj/iQ4napPpXHZSXJTo17pxVU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TDsy6/OxTjdu5KnWOvTpQMNGyGHjdPItddrCSdHZwx10yk6x1UGLudpmQoyrDBkD8cGN8W/jln9qoOPk9qk8Wb7uugT19gM5VPy1C4ywD7qdXcmuLniaY8+gV4nejq5VObM7pmkFb/pDpETjkW97hLhJC2E8ZuL0uYa6+wgABrM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=XtUCoo7F; dkim=fail (2048-bit key) header.d=seco.com header.i=@seco.com header.b=AF5DAjpC reason="signature verification failed"; arc=fail smtp.client-ip=40.107.20.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=TU1Qs7+pr6amSFo9kIPXYqcIWGJTb0UVixUjYozcfQXxi6XzKMJJtdsFDgB+P6C08ySx8uoiZ/ef54j8cEytLiDX29IGHfS4hZuTECIdXsqm6m7+r/KbPREI1E5PaeRTVZCySLi1COxTROvpxGRW1QO6nTBKwl7BRFoog7wCsXFJ4OaNp3B+rhRD/RYkrLCoJUY4rqw/cZ+FtKuzD+wkpQBg9OjNjJ94T0uJ697xNi5rFMhnvPbgcaFRYmpV2sDssa6qMVqAfcNHbGFvgnkRD5gX36K1UYLBIa1wRuoAow4t+pfZ9IcAkJhoPFnhGmx5EatQFZyF3C2C8hUxBKPzrw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3BP0SRa3LTCynSc+ENvXX9j9W2/2FwQGr2zeIx3/wk=;
 b=CdpyY6l23/MJHpJxHtFce4v7KVQNqYn5tuuAwm0cgisOYIcfsAgYHiK6GHVXEWqMxMK2czvTErywKvFg5Khl9stzfi6lNnC5LBmCrniaA49vVPutFUB0dXMVRKkpMMvqFRjfiOg9vjhKK3HNFP1V83YJRhzeggYxfh8S3XBywwDI9E/97nwR5viag5cAFoGV+xNY7B8rFF2NMq8sC1VCvLrMpd3+WmTq+tqyti/lFv3JLg+heUFsdcBHr/dM4vcHd6qxgXPDGqPmtP1NF/d4XMhRYkHOj6g4mXLeuDVrL7YxLTwDOaCIjLcqEHazr5P4D85/hs/MkNTdjPLnXtnW4Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.81) smtp.rcpttodomain=davemloft.net smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3BP0SRa3LTCynSc+ENvXX9j9W2/2FwQGr2zeIx3/wk=;
 b=XtUCoo7F6QWIZ6upfFPL2wp5KM+X1cKwrdriSnXUAMWoP1dXnRbBdBqAtdvltPsfOEXn6VZPR/hxhRoNtYgh7StlHqctd1MDBbwVTxUAfnu2P3bd8/aFkZ5IEOZTewZd1LaqkOfQK16vSm9dL7IB8q59z5nc/c/h0I0ifegcbGsdnWTVaoyG8vOkTsEDGBES7Qk8NBMsN9WW+iu/dOzPRQoiKYHVY/zgdGXUKksNCEfRcO+E/8n+JMFBanruWMinqO+jSQeTPdPf+iJSZ98LPw6PlADCjZBBSdJvqLtvrOlyKGfe2ev9EkQOlMPj26T7mrjY0tjWocnoxRsfNerQsA==
Received: from AS9PR06CA0269.eurprd06.prod.outlook.com (2603:10a6:20b:45f::32)
 by DB9PR03MB8171.eurprd03.prod.outlook.com (2603:10a6:10:371::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Thu, 7 Mar
 2024 16:07:02 +0000
Received: from AMS0EPF000001A6.eurprd05.prod.outlook.com
 (2603:10a6:20b:45f:cafe::63) by AS9PR06CA0269.outlook.office365.com
 (2603:10a6:20b:45f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Thu, 7 Mar 2024 16:07:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.81)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.81 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.81; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.81) by
 AMS0EPF000001A6.mail.protection.outlook.com (10.167.16.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 16:07:00 +0000
Received: from outmta (unknown [192.168.82.133])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id C381C2009538E;
	Thu,  7 Mar 2024 16:07:00 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (unknown [104.47.11.233])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 67B6E2008006E;
	Thu,  7 Mar 2024 16:06:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAI2DOM9P6Dik55gDUw8bJtluaolMXLRN7tpPe21kDvCLEgsfcbO9Q6M+RETjQfkOSe3ePFAXlqYti9YD8rBA9Y9YY3ItyXEmORlUsjM+CwEp2npKeucGrnT3OD8BZLo3VYW5z0FGycvpTYm7V2AsGf7liXAb0m0lRV6peXANIVR/Ls2PiNF/IF045fzdv/lXrKz+hoZZtuKGXxWTRGpoTY5FqypF/4nCsoNaLJxWjdQZea2Vwue53UckU9KGr0yBN4iuAOVQl7+EBgkS7OWS9k1RRZBf1ABTJWCgTl/00e5EsYwEqm18FxRhBwfqy0K0OKfzO233/eZK7y9I8ZO1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rp0Z9ViayFSJp44sUeapg38rOSthCkv+31xFhxJT+Zw=;
 b=L00ybHIMRUCIm7LCOEwe6/9IKnF2kFKEFUBBvedA88QF4ujEQNlBobY7NT3iGOVn2AY4Mt5FPfhXCY2+IRjTeAp6C+LU9xXuc99rA7UvT4prap9FVbLfHDBxEUFVzIFNDOgw8Ad1BNb2Vbvv0ji71OPl9zAJMKB1/fb1nB+Bs77oFMDt0LQa7VRoB8zMUfkABoL0Fa7eS3LG07Ufym3Qaf+ceHsTzR3QcDxvQQRKzyR9gYnAN3B1ml3CG+ei9mtkBaaj1Z3rkYO8MSibtY7QOgCTYKKfVg/9E3w34mlxzC3EIsCsjZZ4XiKrGNyb5xQqyQRnjUCQw8L53zCWfD0yRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rp0Z9ViayFSJp44sUeapg38rOSthCkv+31xFhxJT+Zw=;
 b=AF5DAjpCnmkGykKnIF/yAS8bk48LK/GbvC7fa45bTm7mUXsYQnVE8uIN8YicQn7VqQN4XT5Pv2+jaf7fFk9foHTQ9ZSbzb8CA+SrTeOiRPsB8ftowWA5eK+bThRfaIicOxXrhWYCl+aIEnVdWBhWPROjn0PfPzA2KH0uxwBqOOuh5mMhRhNGqB3eu/DHeYuwGC8a64JpvySMWdnJg7NGZ6bcD4qKcNtgZVd0PtFeyHg8bi5HKYSSxf/dS/vqTnrYDS2whfTlXZJNajspRq3hAwNCRwbwLJ3lq6dB0jmY2x5rvQ84Y98mB+5at6k09R/uG553XkMf/jHNbWSDJ1ZlMw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DU0PR03MB9008.eurprd03.prod.outlook.com (2603:10a6:10:47e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Thu, 7 Mar
 2024 16:06:56 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::84d0:c817:1e20:5554]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::84d0:c817:1e20:5554%7]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 16:06:56 +0000
Message-ID: <45d1bb23-4559-4b38-8d26-8705541df69f@seco.com>
Date: Thu, 7 Mar 2024 11:06:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fsl/fman: Add array size check
Content-Language: en-US
To: Aleksandr Mishin <amishin@t-argos.ru>,
 Madalin Bucur <madalin.bucur@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Igal Liberman
 <igal.liberman@freescale.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240307080452.13278-1-amishin@t-argos.ru>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20240307080452.13278-1-amishin@t-argos.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:a03:333::33) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR03MB8847:EE_|DU0PR03MB9008:EE_|AMS0EPF000001A6:EE_|DB9PR03MB8171:EE_
X-MS-Office365-Filtering-Correlation-Id: 44289b72-921b-4f53-b063-08dc3ec09f7e
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 aX5L7umcYILgnYdie60+aysjJsIjWHHFJrahW/V2sUh+5oyNYr8/+Tdfmy2S2s2A5vVjyK7RBf2ZBF4hcdhRI+V0AEjYXqWs0CteepVFZBTa8wXpSOrur2sMi9cvo2Oop/pRet/+SIPNDdGgPpxdXsgLlZu0Z/ifDZNkv4Fymy1vgEPKRLoX0XrSK4RtWNP3vO8FR5rG4ssR/KxrlTcvyFRd3UtMVBt9oKNBVE0hqY4nB8PSU4bZOBCJfJlN1l9TJTxUsjrj/eNGHSfkUYpQqEVy/Z6S8bt/c3HwrWY3KBTSjyM+ugHuhnz/FqSwvmlZbyM/ZCRjC8qc+iB7lNjaT7Jqo4DIKIJHWNgglOHHdkYblgbBT0ddC2jRUsKmdhGvP7rVmXShbzlX/XOPyUgwx7D2SePV2GSaZnV3ehSsjkVvC+mX5amGPNCdT0lvt9/expY5Uk4bQuZdqUdNqR1yMkA0n74QubRsM8WEEp6j8jWmpfdp3/qXpen3zKbubeDn34Gjk3n3xVpIaaiiZeNr1qCes49yxyxZSqTHYM1+ZN1lbxMb9q5aoTTzqGTIoGfWo6H0x2x3wennDkX54ZoN+zSZH9aN+Xfm2U9mOgPLl5Tqq1wWaORS8g8zGPLCIdi5Ee2olbroHzF90UNZ2i1pEW3aGIV07YdjJgeALrBlx0DYPEUYXDe7frP4wD4tOyiY22Q+Si981H2L9FCUtn8dS+tV+8mMu0JA+VWZZSxkkaI=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9008
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A6.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8fbf39b8-d8ba-445e-0d45-08dc3ec09c80
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jFnNKTNCawnht9+3UValOwRlnwtJvy8xat1lmVEC7jJy6BOROPlRIfCUGxGWtGGHLEkkHt7FyxYOeh2lowcql96hinYgcdLE0AdWhy+wAzyPuV8CThaJ78agPoZzHxvttmRYVEF8ZQvm4Sq3899aLyZzuxSI2Na0GZ3IlEvkfnFwtEXSsCW2UKHpXNMbVyg2mrNU+G2sVS8g7kOlMjCVzhMR27luONkUAFmVPUT8GBMakzdGkwRuANyylssowQU2fSZz6Op88kXo4v+mYcHScM62e+wJEH0S6IHKV1q4f04ZpzBdo48gx3HLZRaS23Tf6m97nVprRibPOlMZPKQlhnDiHPu210C8yogLDzlD2FppWb6l14n73wBsQAlZ04T+6fiPyRVADp05pyMH6VGhWv7F3AHIHIrwyAVtCeU5BDSHYQy4GHwGU9J2XGoLbwRHKa0tApuVclFPAkVXNJM24Ttqw9W33xvAyZfNIt+9IH+7Y3kcuH4Hwfw/leK42IEfi4W2kCmr9lO0XbTGzVJAnJX5Hig2ih2Zk1G9sfLti0fqPV6yNzkm/YoMdz1B3Pty8YIxdsorSNJZQoe1yJivRDp+3VLqoqTKyvBX5ca2xcLYwanlcB/iZ5JSK9KHfd33COM8hzidetiFdUdcwu+PAWDhyZV3mVseQXFmJFU1NklpPBfbZp0ZKu8cavAGzD3ZzxktwTZAM5V0+4ZqC23yxb6BARbUx1/wXQGFyk7YE6NuBsLRF2eBCqt+IzDez9Z3
X-Forefront-Antispam-Report:
	CIP:20.160.56.81;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1102;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 16:07:00.9822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44289b72-921b-4f53-b063-08dc3ec09f7e
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.81];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB8171

On 3/7/24 03:04, Aleksandr Mishin wrote:
> [You don't often get email from amishin@t-argos.ru. Learn why this is imp=
ortant at https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/que=
ry?url=3Dhttps%3a%2f%2faka.ms%2fLearnAboutSenderIdentification&umid=3Dbdb4c=
fa6-c48e-4063-9c43-6d5ce09db688&auth=3Dd807158c60b7d2502abde8a2fc01f4066298=
0862-eff8dde9dd9e5b6c3f9e726ab81488b46e7dd147 ]
>
> In fman_register_intr() and fman_unregister_intr()
> get_module_event() is assigned to event which is then used
> as array index without size check.
> Fix this bug by adding a check of event.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 414fd46e7762 (fsl/fman: Add FMan support)
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>  drivers/net/ethernet/freescale/fman/fman.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/eth=
ernet/freescale/fman/fman.c
> index d96028f01770..902d05ffff1b 100644
> --- a/drivers/net/ethernet/freescale/fman/fman.c
> +++ b/drivers/net/ethernet/freescale/fman/fman.c
> @@ -2054,7 +2054,10 @@ void fman_register_intr(struct fman *fman, enum fm=
an_event_modules module,
>         int event =3D 0;
>
>         event =3D get_module_event(module, mod_id, intr_type);
> -       WARN_ON(event >=3D FMAN_EV_CNT);
> +       if (event >=3D FMAN_EV_CNT) {
> +               WARN_ON(event >=3D FMAN_EV_CNT);
> +               return;
> +       }
>
>         /* register in local FM structure */
>         fman->intr_mng[event].isr_cb =3D isr_cb;
> @@ -2079,7 +2082,10 @@ void fman_unregister_intr(struct fman *fman, enum =
fman_event_modules module,
>         int event =3D 0;
>
>         event =3D get_module_event(module, mod_id, intr_type);
> -       WARN_ON(event >=3D FMAN_EV_CNT);
> +       if (event >=3D FMAN_EV_CNT) {
> +               WARN_ON(event >=3D FMAN_EV_CNT);
> +               return;
> +       }
>
>         fman->intr_mng[event].isr_cb =3D NULL;
>         fman->intr_mng[event].src_handle =3D NULL;
> --
> 2.30.2
>

Nack. This condition should never occur, that's why we have the WARN_ON.

--Sean

[Embedded World 2024, SECO SpA]<https://www.messe-ticket.de/Nuernberg/embed=
dedworld2024/Register/ew24517689>

