Return-Path: <linux-kernel+bounces-100855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA0E879E38
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6722B1F22C95
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC1C143C60;
	Tue, 12 Mar 2024 22:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="eST1s2rh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="YjMVyqLD"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2092.outbound.protection.outlook.com [40.107.8.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E715414375A;
	Tue, 12 Mar 2024 22:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.92
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710281366; cv=fail; b=J0G37zt+7Hw6OOfbcZUp/VVKzWdJMWfGbwKvOWeGTGFFzilgVSjWwiygaXfDoFbkE30C1b86NzVocmvGKHbs+YaYogzoHpf80M90gos+EjyG/1zEt0tq5MWKtInYZhfOyit9+XpKbDGPfOoysfiW9F7VVhSDMq8LTOTqEPybtTU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710281366; c=relaxed/simple;
	bh=4lD8Yjv+fMXV4AMKGhlGGWI68Xjz3UCcLQ2913wfu/4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SyhONUVn5aNwdkPNlfZT//SBT8aWHrlnYw49SFPte5cUnHNP6o00nJb83I6PwIoVa2cWa0Qdu5Hw/P25pCMHGC2aM0yuWocFqe6p10MgNhFVJ11UfnZmmAaCU5KZ8sqe+T7ByIZ2pqMVvL+R7arSKQT4coDKTiTxMiiaxoUQVSA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=eST1s2rh; dkim=fail (2048-bit key) header.d=seco.com header.i=@seco.com header.b=YjMVyqLD reason="signature verification failed"; arc=fail smtp.client-ip=40.107.8.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=JA6M69FoesHx9VqzioALS5oJU1XUoUQYjDW/lQ+10UDlimJms+RSU3E0JeeZYBrU75+VqUBnKeTIXE0ao/YZYwvw/vyWtByqsIaY/OktLtiQ7Eb8pCrSLiQtL34KgUwayQsiDVhI9/wbAn2pRO87I2ZHHLVO++BP58PFIsHudGO74Ojh5INYIruA2OVogVOQ03MQqtmspKhvkMu9A54EikaD4pYqq2BFaMLjjuv2rvvV76sLuE8fME89EgVCaq0TLIpdOFmILQOcL9bws7oG/SbWzyBoQ9fu3KWb8PWXhNZi/aC8MH7ruTzqUVYr7vHTB+YR0Sae5t4374JRHNvGYA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lD8Yjv+fMXV4AMKGhlGGWI68Xjz3UCcLQ2913wfu/4=;
 b=D3EbyWW3nPDxtrDJ4j9FAE4NvHmju2lfdHZwX8DsARn7zOlKp5A/lHSwx7S27xrWvF0zRLwuGmO7E1MN6Ivrg2w+V+Bn91GptHrJG0QWHcygtrg33hR5apcB4qrb/Iwp4ii2T81oVbyYfawCWyVZ6nBzWx0dNFAMzaeQMkL7naLwNlN+woV/NWdhpjokXkiVArNSw2WVFVEbHtZDdPSaN2A5bK2BE7AwUMfUhudZ7qQLtcFlSi/HeprZB5hD52gBM3/qHifj9A6EMeQSlghAkh1LrsGWxHOUzWAQvukO2Y7KzgfGLeK2Zrp3jiw0KC1jbJ/OMhgby4kfFQKXco3KGQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.87) smtp.rcpttodomain=bit42.se smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lD8Yjv+fMXV4AMKGhlGGWI68Xjz3UCcLQ2913wfu/4=;
 b=eST1s2rhlxKC3gcGQcMZD8vi6q84yvL6VglmhttC5QVEM7w/cXbVRoLu1i33/uKV7MVBOIxYLVxbaPb3F97NilWSDM2omcTBVQyC58bRwPTJYC85iWNVai8bbV8lJN4Quh8+rC7fwyfy82oZW3+MifA69HQornYdFrl2J5LykaUEwRk609szyKguRV1QKzTeU0F6+y3IWsOLc60YgrP78ctEAEyytDsmXZWCu83vtUGgFYn2QRwqzHyXjpLjnwwLbc4Fs3yYZR7By9AvYO49G7OOcH6e6mwqiK2v2VW+8yyZDdo1zRNSL7RG7wIpBWrgKH59AxCUeZb5cox486Zr5g==
Received: from AM6P195CA0064.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:87::41)
 by AM7PR03MB6564.eurprd03.prod.outlook.com (2603:10a6:20b:1c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Tue, 12 Mar
 2024 22:09:18 +0000
Received: from AM2PEPF0001C715.eurprd05.prod.outlook.com
 (2603:10a6:209:87:cafe::3d) by AM6P195CA0064.outlook.office365.com
 (2603:10a6:209:87::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Tue, 12 Mar 2024 22:09:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.87)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.87 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.87; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.87) by
 AM2PEPF0001C715.mail.protection.outlook.com (10.167.16.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 22:09:16 +0000
Received: from outmta (unknown [192.168.82.135])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 48DAE2008009A;
	Tue, 12 Mar 2024 22:09:16 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (unknown [104.47.17.169])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id E7B8B20080075;
	Tue, 12 Mar 2024 22:09:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UU8e85C/pkUV74BMBafeGpYt6adeiVlex3tm0VyZBcZRIdi6IAN5u+MypT5Nfv6uHPem2g82S13fAMJzJH/f+ghXYZvhZKuYkES9d1DBcpZRr/MnShJAN5FwSlA1OxS9VmdcmWb0Aa24I3OAy3qe3RqjFKWdM9bp4BvEnzDgkNb4SCkvSJmPJtBeGwI4FJMRRi1hllJKNv4nfbUfGcX2EPxq6XhGBmg/6MR4wbvxziteIz6Nnn4azXOE/mWPAgm80HUDIMNeQh0bvLdLstayGjrXsG8d1Ti8W6p26NRDOr0V7ITrPFAPwnwqUGuh/mWKo5X7h4LrXjtRdpEZ3f+LJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fjqq8k7ce0eGqMz3Lq5GUBaYl/Y+cNjDDLglKPDNKh4=;
 b=QEfQm6rJ57cpRp4R6Ds0WTCqZK/PbcaGj8R2yW89WK3jAxTL3jO+FAvIV461c+DDKarXto2EUD42vObcOm7R1NVF+rghg8MW6xe0a/8JMbbccrPlBqyBchHQ4tMThkjCUK/5ix/b7dtQvtDtEJKMAG1U64/rKiZKVnmSZC/brIG1hmalB/mrVRSqU7U2Xdda8xNrbRnLtUnnvSxTRfklaJJqz6zFwa0qoJ+coh5DwKXKP1pjclJUaY9htisT8GxF3m8koH+8+sp5JdCiVVwNatvTAsli239bjUq9EYMU4qXkjhonO6DgegdIK9Qh7a1q1MMPs2pSkxbnASf7Y7iBCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fjqq8k7ce0eGqMz3Lq5GUBaYl/Y+cNjDDLglKPDNKh4=;
 b=YjMVyqLDmQ7kSQPVy8m8xzCc6ykRMoeExPBz8dZCnX0YSQ55+558Rc649GIGPVHLGa0RpcQA/VCxBTyHc3GMz8fh7eykMbvFoEoH/y8y/hIyLSCLo/TFnLBWVpUP3BsixRRbA4UagCaUKTBDw2iyM5EhDAhqEHpZuITnkzUXTXomO85i8DlePTx+ay8BH5KMteguz0T8d54FsmX+vQ6NgBmH370WhayHUvn6e4QSvjx/MyZqURhvSsA6Ipuy9tudbjcRY9X1HpigOVukSTIEw4FZwtfydttAvoeedYgh1E7gzVMWF3nHAwqYzmRzVvp10Flb+yOw3S634tXYLEf/dQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DB9PR03MB8145.eurprd03.prod.outlook.com (2603:10a6:10:373::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 22:09:10 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::84d0:c817:1e20:5554]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::84d0:c817:1e20:5554%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 22:09:09 +0000
Message-ID: <7fc69bf7-4f89-41c0-a800-6e7d450d8b20@seco.com>
Date: Tue, 12 Mar 2024 18:09:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] nvmem: add new NXP QorIQ eFuse driver
Content-Language: en-US
To: Richard Alpe <richard@bit42.se>, srinivas.kandagatla@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 niklas.soderlund+renesas@ragnatech.se, Michael Walle <michael@walle.cc>
References: <20230410082051.2948510-1-richard@bit42.se>
 <20230410082051.2948510-2-richard@bit42.se>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20230410082051.2948510-2-richard@bit42.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::26) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR03MB8847:EE_|DB9PR03MB8145:EE_|AM2PEPF0001C715:EE_|AM7PR03MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b803e02-2f3a-4855-2cb4-08dc42e10ef2
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 XrsAQBYP8aUZYNbVgWHwwLSPN4agnqwRGDF4dokOPD+ITjt4z96OFhE/fUciMk8O20CEM9qU36UZYunUlksd5xqb/6dwhFXWeS+13FOna0RzeheHdkebDV9LzYkA8bJPGHCwC2+H0zjOoivgFyaWprKYZmor44D3d5A5LN0P3crSCK6jxNr7iP5aQgGVIiu1V3icdGRBOelfwoPMml7IVySBiKbZ2wvycO11Kvz8/7EeqjVIoT6H/D68HuLNRVh06eSYkJLyEl/0l6tRGRGO10yV/6yMTHAllampQrRLsBNwpjCHW8tkqbvwVPOHPRzqIFHwhZMeY7Yx2F/G7OvifhsxhXS1/jMnzcNt/80t3CWHtZdUeWcA7+1H30PHFXW93yaA/oFMamB/lSjfaL+tP3FDRGzfjrYx5nGe2fo5VvCOcLpVgrOdX5af0iHaqnG9ralIwja4hSQAOFqJjng5Uwb5dSdsYmKC5iTFkCaEjPr6Yi/0I8wFHM0Mj5QCGGO721Se8gtqUAitSWIsQT9JHyaiLlv2YXWdxpxPtvzeNtMMqjZAOAwhEJhGLLrlW/0FuZB3azybcH70U0/SSln4ivVycZxMaQNB7FjZvlAo/H/M9iYkuQwMXsUatI8it7wyFhZNipQAZdjDJkv43X5Ti1wmixO2cN+GnmdCtvJAWmhXbkDgqz+ofV1Grf66udprLhekcZ9wsJRBXATI1KFUtwFa6NzwRVBiP1wcsiryo9E=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB8145
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C715.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	58a46dd3-5006-4e24-49b7-08dc42e10ac4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cbPgq71lUHpHBnNNmQqlu2gkOxiDkdp2bXBykfUe689dwaN24uWhrxzB97vKZOml6fG3zuRvvyBXrqOm1X6zeEcUf+3EE48orVn3CIPLH1es91kgxbzokY7mqHRtTB8kmeLIzX2vfj7VDjlZV/cmReIAiiig15kwyhvDKfzP2LzcJgJRCc6ryAjZkafvOKXHZGndX8vdQqtf0S56H/dUXYLwxQdrxwv9XstCQAzG2GHjicEXtoqlCeMYM2vELly/Mha/Tb3/mNZoIly7H1pPTYL+KxZj+pi1TNPQyRet6mWlh3YXf0vgak2r+5ecRQYyoBK+jTIJMxglquRpIYVYFtp+NUXeTJZcwS5vbld1TFrlkjQE7GuWMROyajQ6NKbDAwgjMX7/qZ2bmDHgHz8QKc6D2z5sDZJQa0rd4YyNW06XGMgwLp80fmGumOVCajKa8BkkRQe6Syi8J2u69Ym1ki5dMO/Rl0XukwP+UZUH//bqxWTPYBFTxDZ5CVWnDSRTwA7APpXPY+4jgHFDoxZOtOeFIMBnea8qklHy92jaq/VyjEmerBS7CXLGUqhjSI1oilSbnVbu9frjIPY27wOEP3DDb3yXWFs6lDM/cNtAIDFvBOP094264lFvu+4ar/u6CGLr50va9464jGAV2tyUvF94h9fMne8+VZ1SGNdO60y5lag+a6nTxJuoeFR/S8diXPcjwtU+V6L+Sz/OLcLGzymbePwaC3ICK7WALdmmmieXXoIV/TYfxNZl7T0h006R
X-Forefront-Antispam-Report:
	CIP:20.160.56.87;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004);DIR:OUT;SFP:1102;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 22:09:16.5126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b803e02-2f3a-4855-2cb4-08dc42e10ef2
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.87];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C715.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6564

On 4/10/23 04:20, Richard Alpe wrote:
> Add SFP (Security Fuse Processor) read support for NXP (Freescale)
> QorIQ series SOC's.
>
> This patch adds support for the T1023 SOC using the SFP offset from
> the existing T1023 device tree. In theory this should also work for
> T1024, T1014 and T1013 which uses the same SFP base offset.
>
> Signed-off-by: Richard Alpe <richard@bit42.se>

This seems like a duplicate of layerscape-sfp.c. The hardware is
(presumably) quite similar, with the T1024RM referencing the QorIQ Trust
Architecture User Guide version 2.0, and the L1046 (e.g.) referencing
version 2.1.

I think this driver should be removed in favor of the older driver.
There are some problematic bits: most notably no offset is applied by
this driver, so all fuses have an offset of 0x200. So we will need to
implement/document this only for the "fsl,t1023-sfp" compatible, which
has already made its way into the T1023 devicetree...

This really should have been caught during review; a quick grep for
"SFP" would have revealed the duplication.

--Sean

[Embedded World 2024, SECO SpA]<https://www.messe-ticket.de/Nuernberg/embed=
dedworld2024/Register/ew24517689>

