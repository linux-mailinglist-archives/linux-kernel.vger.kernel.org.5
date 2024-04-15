Return-Path: <linux-kernel+bounces-145636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EADC8A58D2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9EE1C20C4F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CBF129A73;
	Mon, 15 Apr 2024 17:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="xvDu4wh0";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="xvDu4wh0"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2089.outbound.protection.outlook.com [40.107.7.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BF31292E6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.89
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200886; cv=fail; b=PSr2eUMzVH5qu4M3rf6x0MH6zRAJG3Dt/h08JAvUrrjmFacm/qIO33J1VckAR0ZI552dKGK7nu36z2Yh2X+1JDx4t+x4cXAInQljiPaif0z4XxHe4Ugw5bdn4CN5XcIjou+NuRjqAlHcnCllNdnkMQ7gXtCI0cODkDOEWqaeJDk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200886; c=relaxed/simple;
	bh=2HFOrFI+rwpxaBYUh3Kudq+Yt6NWofKE38eiPedmozY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D9u4G+7WlnWWSjvnxaDfbDnJdIVWuiKSC037pppBvsIjXXshX62AZU8NRyFEdAhS79P0oL6zSsgMxQ4eQsU+BImn7DgXWRfwtTFE05rYNWdXrDa+DxZXsjOYvs24uG8U7vVGcQr0txm9W5ZvQY/MlQbVt/KXfcXptv5eFXLYLfg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=xvDu4wh0; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=xvDu4wh0; arc=fail smtp.client-ip=40.107.7.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=niuqAlhpccPsPlUMR5RtlmQTCBLbKyTIwYPdw3ZG4c4YKeRR0RzKivdr+eY+UNngzVRJODjaZXpzDVS3t82Jzo0t88AKsxwlFHeZ7/QlO3xeTZQtYGvCpLVQ9KOGU6UTA/g4FBfYzoK6MNamFnXVAOgxwdBvSazXBpyXLXbK9R2CUt3kBeGXM8Y334VhvuM5E/gGo1d7wQuOYl0rh/tqvhAwFBjRzUprKw2YuT00C27adfwO0izTxrW+aGJ5tzKZtcOI6TWLIcxpkWuqnUHDLlDC87tCsPBolm4kJobVoAYadtX8Jz48l8tvak3odVz3KkxP5f213Ow+GWMYgoqApw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/UHzZ6+hlzx+EyhgchAHatIawDZ2i1SvlmJbb8grXc=;
 b=aP208+MO06US4SXj3pGae1i76SRvnwJQS0+hzE6Jp9RdwDR05JLpIblTN2LoHw5s1Eo015EQz1AEWvUneTo74TO3uJJmUfrnftwblQIXq+MyA8cHwCQZybN83V1DPiTTjJ8Ck9ofQJpsW86qE87rSiGyxZMotPAbxoGRy6GFu/k92J7eURh0wsLDRi27yH/5mQH0PsRSpDO/AZSGCNfzpTafNI7Dq0UXaAfsWrWR/wNiduNLyGOTYBFIWKsDnsHAMvMaN0vX4KmM+wH4ooXj+IOziFboSGf+YUYTJBXOURkxQCL+IZGknT8b3+B3wjv4qzdXimnVx/2Dn5mF92Y5eg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/UHzZ6+hlzx+EyhgchAHatIawDZ2i1SvlmJbb8grXc=;
 b=xvDu4wh0PV1Q/N6OQMcBh3NgMta/sO683OUC/9ErboXT/mxLmMcPL8e2cewE+jDm2BErQttkNJzSdXSrqRE6NcE7WkrOQKz4JC25XXSdCTj2rUZnNKIZrPJAS9DMfqrtoROVPokRs87kkg8KOzrDwNZrUWokJFQLiUSI3NI/Iv8=
Received: from DU2P251CA0027.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::33)
 by DBAPR08MB5816.eurprd08.prod.outlook.com (2603:10a6:10:1b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 17:07:41 +0000
Received: from DB5PEPF00014B8B.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::d0) by DU2P251CA0027.outlook.office365.com
 (2603:10a6:10:230::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 17:07:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B8B.mail.protection.outlook.com (10.167.8.199) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7452.22
 via Frontend Transport; Mon, 15 Apr 2024 17:07:41 +0000
Received: ("Tessian outbound caed45120527:v313"); Mon, 15 Apr 2024 17:07:40 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7dfb1db0e96f8598
X-CR-MTA-TID: 64aa7808
Received: from 59bf19142602.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id BEE9CA0C-0473-43C0-9663-FFC89487A9D3.1;
	Mon, 15 Apr 2024 17:07:30 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 59bf19142602.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 15 Apr 2024 17:07:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhfHF/rAM85II3P1YZodWGFTFl6BAY0oo06Pk/8/bzcwanaStJyJa+p5cvpT5UL6UOQkTevZy3cEbO5aMsln2VDpB2Z1uibOAnJws5NdAsdmX7vgQrU9GkOeXEdy7MhKpVj5OmGDEJpHy6eljrnJMW2GYoBBJZKqKOUflXyNlP1Utr845rKor8nCK1vj8WRiecvJGOoW6o3zSqEt+3ocI2kEpQ6dIPel4pVXTl6mT2FHa3/7mynIc8Mh8u8BC1Ftt415q3S24ai6xZWSyEnHDFsPbLjL0aACa29pDTuxlRMoJRBsetCuBDwWwOXOkuHHynGrSvqBS10RQcHNWc6pLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/UHzZ6+hlzx+EyhgchAHatIawDZ2i1SvlmJbb8grXc=;
 b=er/B3PSMPqOsQlVI9/9fTgWdMQ3JjqSMBDMco3v1cHybJj0XU/+Z1+g7WN8TqDMlUB3nIf46xCaOoM5dx4OUBwKNCqo+TD9XV3ZOQMbPBjPWlmpAtnBJYQTywXsrvbIPNsvziCfTLnMqcIOpox973dVmdkh9ho6YIxeay/JzT6WhDP0JFj51Fiymz39k0Vz4LZ6PXRCGPl02C30vHGbBF/kwIXnm8hJOyPg7ctjcJUMmFJ7LQ6DBAa+Trd4OqG0twQZgvcvs8uD8QN7pT46tQEl/UQcLMbV3AMY8VJt04pGL+9553KD/khRUkkCJDzKAFmAVLCERWZUvurwNEe4JEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/UHzZ6+hlzx+EyhgchAHatIawDZ2i1SvlmJbb8grXc=;
 b=xvDu4wh0PV1Q/N6OQMcBh3NgMta/sO683OUC/9ErboXT/mxLmMcPL8e2cewE+jDm2BErQttkNJzSdXSrqRE6NcE7WkrOQKz4JC25XXSdCTj2rUZnNKIZrPJAS9DMfqrtoROVPokRs87kkg8KOzrDwNZrUWokJFQLiUSI3NI/Iv8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com (2603:10a6:803:c4::31)
 by GV2PR08MB8750.eurprd08.prod.outlook.com (2603:10a6:150:c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Mon, 15 Apr
 2024 17:07:26 +0000
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::77d4:d040:b19d:6472]) by VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::77d4:d040:b19d:6472%4]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 17:07:26 +0000
Message-ID: <3888d7c8-660e-479c-8c10-8295204e5f36@arm.com>
Date: Mon, 15 Apr 2024 18:07:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com, wuyun.abel@bytedance.com, tglx@linutronix.de,
 efault@gmx.de, nd <nd@arm.com>
References: <20240405102754.435410987@infradead.org>
 <20240405110010.631664251@infradead.org>
Content-Language: en-US
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <20240405110010.631664251@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0291.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::15) To VI1PR08MB3919.eurprd08.prod.outlook.com
 (2603:10a6:803:c4::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3919:EE_|GV2PR08MB8750:EE_|DB5PEPF00014B8B:EE_|DBAPR08MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: 32fe6e8a-9856-4f3f-8dcb-08dc5d6e8f6b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 rBjusJ6tPR4DywAsOCXL0tFl8GHCryOjfbyrtmCRpI2hg3kWsnNeMD8Zvvm8f5n1In3U+2QheW+BR4OQ2YyRi8mKsFNElUQ/7VsZAuBxUCxrfUH8eiM5m7pVdA5OXotUJqCCUp3j4EIsKCff/4hOde2Y6kedgApVaoLKLRRvhEGu8ewN1qBkr6j1NmNm5KEUoVeRT61Yqns+YEBBkv/GiJ6GFukpjubJfS88EQHQu3L4eP6pvazFn0he1TpfaVMihF61IoRngtB4TBVUqWCvmbk2sHLMkilarrYPgDuFjMNZfrQ75sO1TOpwoeJVSOn+EJhKKowSgw1YIupncYvtBgzNNzxHYhzkfExrEsOXXlRteStVStoOS5p6vQtP4ma8uH0oKP5ljVvS3HMmT1NoOqp8sOZmlbgOelIMG+B2JsrlgbMS3MDeCmTbMGTVLvwF7yrfSu/vfJQDWoSIM2cAMQ6NTfnnbcRKaYDqVHeETXwTQvBYX6z0KyGabz5Mf54kfUO2ix+ayYSWjEQF3vefhdH3ou/RdbF2APwgkBexNDIjsU/X79QTtrEEwIR03arXG6MYKBV3LpxsG2Vz/1jjkatjk7rxpr0TG5Q0CUBNnnksEzaGR7jERmaQpk2/ll1WM5g30bc/JmSGA9iOwto3FXmpIVf8QWYZGL/3TooGDyvlmZdBe7w4KhOEWi2H6vArPNkUh+GJ87gM2AjtF8Y96g==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3919.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8750
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B8B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	518dcfe3-e8de-484b-229e-08dc5d6e865f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ogryEx41o8fTaPPlJM1Hm9ahavz6Sm+BHGg9YIHtfZ9qiuvjMNSNEP/Cy8rRCPLo8D1HOaMr1wOmj9S5VHH6EVUAmo+8YyJfXAGnZLPFC81re50yWWOMybAvuDPbNxtiZyO1wusGhkDSP3gGvFGecmobXdvbAHGW6sJrTKUGKftFIZMJ0AfBnJD7DO9GwFhlEjPbILObVOmVkB+pufhE6r8yWTVsdoR+7Llgyasrc/2y1gbseFiF2DHzbybdwXJs2ojCJQ7qDxOhGN4PiDJtmnznNyL5ePNgv9VdD5fHWvUbAnGIr6Vi5j8lvhouFu+nrLUu7Zm1IEdiZMFzEOiERWtQbZhDDSGh+80DcDbY0/sccGvAnkcHTl6zHEumoAojHiXIF3UnJXLsSAYNXL9uQ8Vy7Enp8gNq6b0DxQlzlQ4g1o5PWhN1VcvircT3uGK4OIBhvtwnIaXHNlLchtBI896exHvgbGcgavgJGy61cFmODVLq+9pFm9ymTAI0NuqttpSsEsuf0u7YiQMrie7ZAM1Sepmwyx0Qj4Hti8NB7/8YR77WXLqVvDSPDbOLgKCU2dm/yzG3ZXuCl9wC6l4IOlIBRLaxp7mP73gyFoS3eLseu84by488/gNzfG9sVYceAZtLBl8M7tYQY2IQ5Wc6AuJE7XzgJe/iYaP5200VvXNpjKkK15GKMaWc1qfCrIX6k+1CN7jfq7u2oAJdtb30Ixx2k/3cjV3aTK5WRAJMn0wEvlj6cMQAHbXk7tzZEKCgtXb4a4OSJvcwhmuugL1hyQ==
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 17:07:41.2494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fe6e8a-9856-4f3f-8dcb-08dc5d6e8f6b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5816

Hi Peter,

On 4/5/24 11:28, Peter Zijlstra wrote:
> Extend / fix 86bfbb7ce4f6 ("sched/fair: Add lag based placement") by
> noting that lag is fundamentally a temporal measure. It should not be
> carried around indefinitely.
> 
> OTOH it should also not be instantly discarded, doing so will allow a
> task to game the system by purposefully (micro) sleeping at the end of
> its time quantum.
> 
> Since lag is intimately tied to the virtual time base, a wall-time
> based decay is also insufficient, notably competition is required for
> any of this to make sense.
> 
> Instead, delay the dequeue and keep the 'tasks' on the runqueue,
> competing until they are eligible.
> 
> Strictly speaking, we only care about keeping them until the 0-lag
> point, but that is a difficult proposition, instead carry them around
> until they get picked again, and dequeue them at that point.
> 
> Since we should have dequeued them at the 0-lag point, truncate lag
> (eg. don't let them earn positive lag).
> 
> XXX test the cfs-throttle stuff
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Playing around with a Pixel 6 running a 6.6-based kernel with this
series backported on top, I spotted a noticeable performance improvement
on the speedometer benchmark:

- m6.6-stock-* is the 6.6 mainline Android kernel unmodified.

- m6.6-eevdf-complete-* is the 6.6 mainline Android kernel with
this series applied on top (along with a few required backported
patches).

+-------------------+-----------------------+-----------+
|      metric       |          tag          | perc_diff |
+-------------------+-----------------------+-----------+
| Speedometer Score |     m6.6-stock-1      |   0.0%    |
| Speedometer Score |     m6.6-stock-2      |   1.23%   |
| Speedometer Score |     m6.6-stock-3      |  -0.22%   |
| Speedometer Score | m6.6-eevdf-complete-1 |   4.54%   |
| Speedometer Score | m6.6-eevdf-complete-2 |   4.95%   |
| Speedometer Score | m6.6-eevdf-complete-3 |   6.07%   |
+-------------------+-----------------------+-----------+

Also some interesting improvements in terms of frame timing for the
uibenchjanktests benchmark. In particular the metrics of missed
deadlines and jank (late) frames, which seems to indicate better
latencies.

+-----------------------+-----------------------+-----------+
|        metric         |          tag          | perc_diff |
+-----------------------+-----------------------+-----------+
| gfx-avg-frame-time-50 |     m6.6-stock-1      |    0.0    |
| gfx-avg-frame-time-90 |     m6.6-stock-1      |    0.0    |
| gfx-avg-frame-time-95 |     m6.6-stock-1      |    0.0    |
| gfx-avg-frame-time-99 |     m6.6-stock-1      |    0.0    |
| gfx-avg-frame-time-50 |     m6.6-stock-2      |   3.46    |
| gfx-avg-frame-time-90 |     m6.6-stock-2      |   1.19    |
| gfx-avg-frame-time-95 |     m6.6-stock-2      |   0.24    |
| gfx-avg-frame-time-99 |     m6.6-stock-2      |   0.48    |
| gfx-avg-frame-time-50 | m6.6-eevdf-complete-1 |  -30.45   |
| gfx-avg-frame-time-90 | m6.6-eevdf-complete-1 |  -48.44   |
| gfx-avg-frame-time-95 | m6.6-eevdf-complete-1 |  -51.32   |
| gfx-avg-frame-time-99 | m6.6-eevdf-complete-1 |  -52.48   |
| gfx-avg-frame-time-50 | m6.6-eevdf-complete-2 |  -30.32   |
| gfx-avg-frame-time-90 | m6.6-eevdf-complete-2 |  -48.16   |
| gfx-avg-frame-time-95 | m6.6-eevdf-complete-2 |  -51.08   |
| gfx-avg-frame-time-99 | m6.6-eevdf-complete-2 |   -51.7   |
+-----------------------+-----------------------+-----------+

+-----------------------------------+-----------------------+-----------+
|              metric               |          tag          | perc_diff |
+-----------------------------------+-----------------------+-----------+
| gfx-avg-num-frame-deadline-missed |     m6.6-stock-1      |    0.0    |
| gfx-max-num-frame-deadline-missed |     m6.6-stock-1      |    0.0    |
| gfx-avg-num-frame-deadline-missed |     m6.6-stock-2      |   -3.21   |
| gfx-max-num-frame-deadline-missed |     m6.6-stock-2      |   -3.21   |
| gfx-avg-num-frame-deadline-missed | m6.6-eevdf-complete-1 |  -85.29   |
| gfx-max-num-frame-deadline-missed | m6.6-eevdf-complete-1 |  -85.29   |
| gfx-avg-num-frame-deadline-missed | m6.6-eevdf-complete-2 |   -84.8   |
| gfx-max-num-frame-deadline-missed | m6.6-eevdf-complete-2 |   -84.8   |
+-----------------------------------+-----------------------+-----------+

+----------------------------+-----------------------+-----------+
|           metric           |          tag          | perc_diff |
+----------------------------+-----------------------+-----------+
| gfx-avg-high-input-latency |     m6.6-stock-1      |    0.0    |
| gfx-max-high-input-latency |     m6.6-stock-1      |    0.0    |
| gfx-avg-high-input-latency |     m6.6-stock-2      |   0.93    |
| gfx-max-high-input-latency |     m6.6-stock-2      |   0.93    |
| gfx-avg-high-input-latency | m6.6-eevdf-complete-1 |  -18.35   |
| gfx-max-high-input-latency | m6.6-eevdf-complete-1 |  -18.35   |
| gfx-avg-high-input-latency | m6.6-eevdf-complete-2 |  -18.05   |
| gfx-max-high-input-latency | m6.6-eevdf-complete-2 |  -18.05   |
+----------------------------+-----------------------+-----------+

+--------------+-----------------------+-----------+
|    metric    |          tag          | perc_diff |
+--------------+-----------------------+-----------+
| gfx-avg-jank |     m6.6-stock-1      |    0.0    |
| gfx-max-jank |     m6.6-stock-1      |    0.0    |
| gfx-avg-jank |     m6.6-stock-2      |   1.56    |
| gfx-max-jank |     m6.6-stock-2      |   1.56    |
| gfx-avg-jank | m6.6-eevdf-complete-1 |  -82.81   |
| gfx-max-jank | m6.6-eevdf-complete-1 |  -82.81   |
| gfx-avg-jank | m6.6-eevdf-complete-2 |  -78.12   |
| gfx-max-jank | m6.6-eevdf-complete-2 |  -78.12   |
+--------------+-----------------------+-----------+

Bisecting through the patches in this series, I ended up with patch 08/10
as the one that improved things overall for these benchmarks.

I'd like to investigate this further to understand the reason behind some of
these dramatic improvements.

> ---
>  include/linux/sched.h   |    1 
>  kernel/sched/core.c     |   22 +++++--
>  kernel/sched/fair.c     |  148 +++++++++++++++++++++++++++++++++++++++++++-----
>  kernel/sched/features.h |   12 +++
>  kernel/sched/sched.h    |    2 
>  5 files changed, 167 insertions(+), 18 deletions(-)
> 
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -542,6 +542,7 @@ struct sched_entity {
>  
>  	struct list_head		group_node;
>  	unsigned int			on_rq;
> +	unsigned int			sched_delayed;
>  
>  	u64				exec_start;
>  	u64				sum_exec_runtime;
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2154,10 +2154,14 @@ void activate_task(struct rq *rq, struct
>  
>  void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
>  {
> -	WRITE_ONCE(p->on_rq, (flags & DEQUEUE_SLEEP) ? 0 : TASK_ON_RQ_MIGRATING);
> -	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
> +	bool sleep = flags & DEQUEUE_SLEEP;
>  
> -	dequeue_task(rq, p, flags);
> +	if (dequeue_task(rq, p, flags)) {
> +		WRITE_ONCE(p->on_rq, sleep ? 0 : TASK_ON_RQ_MIGRATING);
> +		ASSERT_EXCLUSIVE_WRITER(p->on_rq);
> +	} else {
> +		SCHED_WARN_ON(!sleep); /* only sleep can fail */
> +	}
>  }
>  
>  static inline int __normal_prio(int policy, int rt_prio, int nice)
> @@ -3858,12 +3862,17 @@ static int ttwu_runnable(struct task_str
>  
>  	rq = __task_rq_lock(p, &rf);
>  	if (task_on_rq_queued(p)) {
> +		update_rq_clock(rq);
> +		if (p->se.sched_delayed) {
> +			/* mustn't run a delayed task */
> +			SCHED_WARN_ON(task_on_cpu(rq, p));
> +			enqueue_task(rq, p, ENQUEUE_DELAYED);
> +		}
>  		if (!task_on_cpu(rq, p)) {
>  			/*
>  			 * When on_rq && !on_cpu the task is preempted, see if
>  			 * it should preempt the task that is current now.
>  			 */
> -			update_rq_clock(rq);
>  			wakeup_preempt(rq, p, wake_flags);
>  		}
>  		ttwu_do_wakeup(p);
> @@ -4243,11 +4252,16 @@ int try_to_wake_up(struct task_struct *p
>  		 * case the whole 'p->on_rq && ttwu_runnable()' case below
>  		 * without taking any locks.
>  		 *
> +		 * Specifically, given current runs ttwu() we must be before
> +		 * schedule()'s deactivate_task(), as such this must not
> +		 * observe sched_delayed.
> +		 *
>  		 * In particular:
>  		 *  - we rely on Program-Order guarantees for all the ordering,
>  		 *  - we're serialized against set_special_state() by virtue of
>  		 *    it disabling IRQs (this allows not taking ->pi_lock).
>  		 */
> +		SCHED_WARN_ON(p->se.sched_delayed);
>  		if (!ttwu_state_match(p, state, &success))
>  			goto out;
>  
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5270,6 +5270,10 @@ static inline int cfs_rq_throttled(struc
>  static inline bool cfs_bandwidth_used(void);
>  
>  static void
> +requeue_delayed_entity(struct sched_entity *se);
> +
> +/* XXX bool and pull in the requeue_delayed_entity thing */
> +static void
>  enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  {
>  	bool curr = cfs_rq->curr == se;
> @@ -5356,18 +5360,33 @@ static void clear_buddies(struct cfs_rq
>  
>  static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
>  
> -static void
> +static bool
>  dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  {
> -	int action = UPDATE_TG;
> -
> -	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
> -		action |= DO_DETACH;
> -
>  	/*
>  	 * Update run-time statistics of the 'current'.
>  	 */
> -	update_curr(cfs_rq);
> +	if (flags & DEQUEUE_DELAYED) {
> +		SCHED_WARN_ON(!se->sched_delayed);
> +		se->sched_delayed = 0;
> +	} else {
> +		bool sleep = flags & DEQUEUE_SLEEP;
> +
> +		SCHED_WARN_ON(sleep && se->sched_delayed);
> +		update_curr(cfs_rq);
> +
> +		if (sched_feat(DELAY_DEQUEUE) && sleep &&
> +		    !entity_eligible(cfs_rq, se)) {
> +			if (cfs_rq->next == se)
> +				cfs_rq->next = NULL;
> +			se->sched_delayed = 1;
> +			return false;
> +		}
> +	}
> +
> +	int action = UPDATE_TG;
> +	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
> +		action |= DO_DETACH;
>  
>  	/*
>  	 * When dequeuing a sched_entity, we must:
> @@ -5407,6 +5426,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
>  
>  	if (cfs_rq->nr_running == 0)
>  		update_idle_cfs_rq_clock_pelt(cfs_rq);
> +
> +	return true;
>  }
>  
>  static void
> @@ -5432,6 +5453,7 @@ set_next_entity(struct cfs_rq *cfs_rq, s
>  	}
>  
>  	update_stats_curr_start(cfs_rq, se);
> +	SCHED_WARN_ON(cfs_rq->curr);
>  	cfs_rq->curr = se;
>  
>  	/*
> @@ -5452,6 +5474,8 @@ set_next_entity(struct cfs_rq *cfs_rq, s
>  	se->prev_sum_exec_runtime = se->sum_exec_runtime;
>  }
>  
> +static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags);
> +
>  /*
>   * Pick the next process, keeping these things in mind, in this order:
>   * 1) keep things fair between processes/task groups
> @@ -5460,16 +5484,29 @@ set_next_entity(struct cfs_rq *cfs_rq, s
>   * 4) do not run the "skip" process, if something else is available
>   */
>  static struct sched_entity *
> -pick_next_entity(struct cfs_rq *cfs_rq)
> +pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
>  {
>  	/*
>  	 * Enabling NEXT_BUDDY will affect latency but not fairness.
>  	 */
>  	if (sched_feat(NEXT_BUDDY) &&
> -	    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next))
> +	    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next)) {
> +		/* ->next will never be delayed */
> +		SCHED_WARN_ON(cfs_rq->next->sched_delayed);
>  		return cfs_rq->next;
> +	}
>  
> -	return pick_eevdf(cfs_rq);
> +	struct sched_entity *se = pick_eevdf(cfs_rq);
> +	if (se->sched_delayed) {
> +		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
> +		SCHED_WARN_ON(se->sched_delayed);
> +		SCHED_WARN_ON(se->on_rq);
> +		if (sched_feat(DELAY_ZERO) && se->vlag > 0)
> +			se->vlag = 0;
> +
> +		return NULL;
> +	}
> +	return se;
>  }
>  
>  static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq);
> @@ -5493,6 +5530,7 @@ static void put_prev_entity(struct cfs_r
>  		/* in !on_rq case, update occurred at dequeue */
>  		update_load_avg(cfs_rq, prev, 0);
>  	}
> +	SCHED_WARN_ON(cfs_rq->curr != prev);
>  	cfs_rq->curr = NULL;
>  }
>  
> @@ -5793,6 +5831,10 @@ static bool throttle_cfs_rq(struct cfs_r
>  		if (!se->on_rq)
>  			goto done;
>  
> +		/*
> +		 * XXX should be fine vs sched_delay; if won't run after this.
> +		 * Either pick dequeues it, or unthrottle. Double check!!
> +		 */
>  		dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
>  
>  		if (cfs_rq_is_idle(group_cfs_rq(se)))
> @@ -5882,8 +5924,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cf
>  	for_each_sched_entity(se) {
>  		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
>  
> -		if (se->on_rq)
> +		if (se->on_rq) {
> +			if (se->sched_delayed)
> +				requeue_delayed_entity(se);
>  			break;
> +		}
>  		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);
>  
>  		if (cfs_rq_is_idle(group_cfs_rq(se)))
> @@ -6729,6 +6774,40 @@ static int sched_idle_cpu(int cpu)
>  }
>  #endif
>  
> +static void
> +requeue_delayed_entity(struct sched_entity *se)
> +{
> +	struct cfs_rq *cfs_rq = cfs_rq_of(se);
> +
> +	/*
> +	 * se->sched_delayed should imply both: se->on_rq == 1 and
> +	 * cfs_rq->curr != se. Because a delayed entity is one that is still on
> +	 * the runqueue competing until elegibility.
> +	 *
> +	 * Except for groups, consider current going idle and newidle pulling a
> +	 * task in the same group -- in that case 'cfs_rq->curr == se'.
> +	 */
> +	SCHED_WARN_ON(!se->sched_delayed);
> +	SCHED_WARN_ON(!se->on_rq);
> +	SCHED_WARN_ON(entity_is_task(se) && cfs_rq->curr == se);
> +
> +	if (sched_feat(DELAY_ZERO)) {
> +		update_entity_lag(cfs_rq, se);
> +		if (se->vlag > 0) {
> +			cfs_rq->nr_running--;
> +			if (se != cfs_rq->curr)
> +				__dequeue_entity(cfs_rq, se);
> +			se->vlag = 0;
> +			place_entity(cfs_rq, se, 0);
> +			if (se != cfs_rq->curr)
> +				__enqueue_entity(cfs_rq, se);
> +			cfs_rq->nr_running++;
> +		}
> +	}
> +
> +	se->sched_delayed = 0;
> +}
> +
>  /*
>   * The enqueue_task method is called before nr_running is
>   * increased. Here we update the fair scheduling stats and
> @@ -6742,6 +6821,11 @@ enqueue_task_fair(struct rq *rq, struct
>  	int idle_h_nr_running = task_has_idle_policy(p);
>  	int task_new = !(flags & ENQUEUE_WAKEUP);
>  
> +	if (flags & ENQUEUE_DELAYED) {
> +		requeue_delayed_entity(se);
> +		return;
> +	}
> +
>  	/*
>  	 * The code below (indirectly) updates schedutil which looks at
>  	 * the cfs_rq utilization to select a frequency.
> @@ -6759,8 +6843,11 @@ enqueue_task_fair(struct rq *rq, struct
>  		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
>  
>  	for_each_sched_entity(se) {
> -		if (se->on_rq)
> +		if (se->on_rq) {
> +			if (se->sched_delayed)
> +				requeue_delayed_entity(se);
>  			break;
> +		}
>  		cfs_rq = cfs_rq_of(se);
>  		enqueue_entity(cfs_rq, se, flags);
>  
> @@ -6836,6 +6923,7 @@ static int dequeue_entities(struct rq *r
>  {
>  	bool was_sched_idle = sched_idle_rq(rq);
>  	bool task_sleep = flags & DEQUEUE_SLEEP;
> +	bool task_delayed = flags & DEQUEUE_DELAYED;
>  	struct task_struct *p = NULL;
>  	struct cfs_rq *cfs_rq;
>  	int idle_h_nr_running;
> @@ -6849,7 +6937,13 @@ static int dequeue_entities(struct rq *r
>  
>  	for_each_sched_entity(se) {
>  		cfs_rq = cfs_rq_of(se);
> -		dequeue_entity(cfs_rq, se, flags);
> +
> +		if (!dequeue_entity(cfs_rq, se, flags)) {
> +			if (p && &p->se == se)
> +				return -1;
> +
> +			break;
> +		}
>  
>  		/* h_nr_running is the hierachical count of tasks */
>  		if (p) {
> @@ -6877,6 +6971,7 @@ static int dequeue_entities(struct rq *r
>  			break;
>  		}
>  		flags |= DEQUEUE_SLEEP;
> +		flags &= ~DEQUEUE_DELAYED;
>  	}
>  
>  	for_each_sched_entity(se) {
> @@ -6906,6 +7001,18 @@ static int dequeue_entities(struct rq *r
>  		/* balance early to pull high priority tasks */
>  		if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
>  			rq->next_balance = jiffies;
> +
> +		if (task_delayed) {
> +			SCHED_WARN_ON(!task_sleep);
> +			SCHED_WARN_ON(p->on_rq != 1);
> +
> +			/* Fix-up what dequeue_task_fair() skipped */
> +			util_est_update(&rq->cfs, p, task_sleep);
> +			hrtick_update(rq);
> +
> +			/* Fix-up what deactivate_task() skipped. */
> +			WRITE_ONCE(p->on_rq, 0);
> +		}
>  	}
>  
>  	return 1;
> @@ -6923,6 +7030,10 @@ static bool dequeue_task_fair(struct rq
>  	if (dequeue_entities(rq, &p->se, flags) < 0)
>  		return false;
>  
> +	/*
> +	 * It doesn't make sense to update util_est for the delayed dequeue
> +	 * case where ttwu will make it appear the sleep never happened.
> +	 */
>  	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
>  	hrtick_update(rq);
>  	return true;
> @@ -8463,7 +8574,9 @@ static struct task_struct *pick_task_fai
>  		if (unlikely(check_cfs_rq_runtime(cfs_rq)))
>  			goto again;
>  
> -		se = pick_next_entity(cfs_rq);
> +		se = pick_next_entity(rq, cfs_rq);
> +		if (!se)
> +			goto again;
>  		cfs_rq = group_cfs_rq(se);
>  	} while (cfs_rq);
>  
> @@ -12803,10 +12916,17 @@ static void attach_task_cfs_rq(struct ta
>  static void switched_from_fair(struct rq *rq, struct task_struct *p)
>  {
>  	detach_task_cfs_rq(p);
> +	// XXX think harder on this
> +	// this could actually be handled correctly I suppose; keep the whole
> +	// se enqueued while boosted. horrible complexity though
> +	p->se.sched_delayed = 0;
> +	// XXX also vlag ?!?
>  }
>  
>  static void switched_to_fair(struct rq *rq, struct task_struct *p)
>  {
> +	SCHED_WARN_ON(p->se.sched_delayed);
> +
>  	attach_task_cfs_rq(p);
>  
>  	set_task_max_allowed_capacity(p);
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -29,6 +29,18 @@ SCHED_FEAT(NEXT_BUDDY, false)
>  SCHED_FEAT(CACHE_HOT_BUDDY, true)
>  
>  /*
> + * Delay dequeueing tasks until they get selected or woken.
> + *
> + * By delaying the dequeue for non-eligible tasks, they remain in the
> + * competition and can burn off their negative lag. When they get selected
> + * they'll have positive lag by definition.
> + *
> + * DELAY_ZERO clips the lag on dequeue (or wakeup) to 0.
> + */
> +SCHED_FEAT(DELAY_DEQUEUE, true)
> +SCHED_FEAT(DELAY_ZERO, true)
> +
> +/*
>   * Allow wakeup-time preemption of the current task:
>   */
>  SCHED_FEAT(WAKEUP_PREEMPTION, true)
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2245,6 +2245,7 @@ extern const u32		sched_prio_to_wmult[40
>  #define DEQUEUE_MOVE		0x04 /* Matches ENQUEUE_MOVE */
>  #define DEQUEUE_NOCLOCK		0x08 /* Matches ENQUEUE_NOCLOCK */
>  #define DEQUEUE_MIGRATING	0x100 /* Matches ENQUEUE_MIGRATING */
> +#define DEQUEUE_DELAYED		0x200 /* Matches ENQUEUE_DELAYED */
>  
>  #define ENQUEUE_WAKEUP		0x01
>  #define ENQUEUE_RESTORE		0x02
> @@ -2260,6 +2261,7 @@ extern const u32		sched_prio_to_wmult[40
>  #endif
>  #define ENQUEUE_INITIAL		0x80
>  #define ENQUEUE_MIGRATING	0x100
> +#define ENQUEUE_DELAYED		0x200
>  
>  #define RETRY_TASK		((void *)-1UL)
>  
> 
> 
> 


