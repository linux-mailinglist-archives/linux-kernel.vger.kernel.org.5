Return-Path: <linux-kernel+bounces-101217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C5987A422
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99DC41F2238D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3DF1A286;
	Wed, 13 Mar 2024 08:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="z7VuMxx2";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="z7VuMxx2"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2D912E73;
	Wed, 13 Mar 2024 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.79
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710319093; cv=fail; b=AmLfh3p8ZmzF6AZf3w5KUpd+/1L7a5OGitwGg9Iar3/uzFeyoI9o+Ls+GXeYzVwE+7mt+ogDQ0QGADfBImU8x0AnV64AaowcSCmnihUOJcwQmP9OTAe/4YGMspik7Xf6FF6uepelzKm1fHUfb6Wa3SA2B3C8MZfSFzb6mMoJQSk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710319093; c=relaxed/simple;
	bh=CdvoxMRtO45xkbEldRW0HZJ5cPhYJztLQFvhnw2+QQE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c1yFqfzhSD5IZ2E8kGr0Cxy9R+gICYYJadCu1oRmfZtJabW9Vyr9avs+tLvIppyUtQkjA0LLm7McfxF+EyrIi5RdcHZdHZwpIFlIKPGJEdxmpA9pNcbmskfHsWIN6ojnUnSMHga/7xnj+r8znNnx+sQUa/ATM9vx+AiiFsegbgE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=z7VuMxx2; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=z7VuMxx2; arc=fail smtp.client-ip=40.107.22.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=jLTq4UCSj8hq+EUqHCFvcV9M2TsE3cM1rAUxc/VQ4zo/zlujUeP7IzGbKBQdzvAnnJgOO8BI3SeLPVb/Nbo/UtEnY28OUdXyVfiIPwcHb4NEE2bLB5IVYo8U1fQcdjb1/Vx1B920YNlY2bdxQ5RYsQpKqM/BjCUsu0sKpy7UzcjsDL7k7NrBARip9wcAZQ9+uvHj8YsoVif8EqGHfJKk47W4muRFpBWwHGS2GrzcwGN9tXen5YXjb/IJ7fEq6Bb2L/UWXDG3Nr2SqV/wHUs1DqzWdPe5aH3ROZqqkqrbnBQMaTW8xCh7cq6oi43lACyGwfvpssBYHcvIocFEeXfmeg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBGcbZWZqRgvPFPdcKTzNbZJAZIcXtrafZNSMAxk00I=;
 b=gaEkZvh904DotNSclcRERAj/My0FUyMPzfAObg3Gytj1nAQ59ugWg93cA2Hty1m4m8bpVnDRzMqeqAXFpUGr25XY5cdEYjJVsc2FrkZeO4iJzAE6DjDUmbN8gZcZN/PH/8dfSJ0IDoWfhw3IE7j2kf/X3tNFuMet9VbDOKc66FuCVkoSXK0ypZ5ryYcbCB99uGnw67ZzHb+II36tdFS1hxJ2QuNHAFJRpy0xm+EheQcclIE1hz9ct5hxc4w3Xadun4f93RDAOJgPib9Ubk2RZevPDc50nPuv7dngh+p9NRam/zU7tNoojwabFpCg1LjosCdLw8A1aRwPz6WwAKNytg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBGcbZWZqRgvPFPdcKTzNbZJAZIcXtrafZNSMAxk00I=;
 b=z7VuMxx29a6DeFWlHGo8MI6Qr51b908XYLgYYOsseoKPaKXVWzL5gCPuwaILyfmlrvGteAcENMCNBMwKdBUSwdu85HLBWuvoAk5/kInMk0Pde0pDXuFo4CNhPTtUvuQvjPX2+gf7gn0mWY3lX1RUgEJLX2e0IlRns86vRB2Ejuo=
Received: from DUZPR01CA0033.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::8) by DU0PR08MB8662.eurprd08.prod.outlook.com
 (2603:10a6:10:402::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 08:38:05 +0000
Received: from DB5PEPF00014B94.eurprd02.prod.outlook.com
 (2603:10a6:10:468:cafe::2a) by DUZPR01CA0033.outlook.office365.com
 (2603:10a6:10:468::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Wed, 13 Mar 2024 08:38:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B94.mail.protection.outlook.com (10.167.8.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 08:38:05 +0000
Received: ("Tessian outbound 7b0d57313a48:v276"); Wed, 13 Mar 2024 08:38:05 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8f665920f9a32b94
X-CR-MTA-TID: 64aa7808
Received: from a6918ddbadde.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id CEE2EF94-9D81-4217-BD98-CB8CFF70F5AB.1;
	Wed, 13 Mar 2024 08:37:58 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a6918ddbadde.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 13 Mar 2024 08:37:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxS1RSHIhC95TL8rtlM7hm/qfjjGyC8VBl2FUIPHhZ3n0z+ZaLJxtYK/lEp+frJL0iIDRBZw8hf8xEM0pTyjyf1Vu1JelFgyXHIpjqlu1m7tdZ29bGuLo2jnHTT8mfyNc2Z5j/LmZw0w4YazaAy2yWiYXkifCfmIcMUXPEs3B1z/PoBT6sPmaUM29CeDSiMghmvFFeGQ0kL50/85HKVE4Gfelhg6T6EONcX2AUuAH8hN2bfgDQiXdbfrTT3MwRrGKDBjbR7g9gIOdvmiRlCRr44iYCBQO9Rg59Re9h4mYXM5QFEbr/rSB8Z8aJVpUCBoxR9wY5a4Vi12425Kp+UODg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBGcbZWZqRgvPFPdcKTzNbZJAZIcXtrafZNSMAxk00I=;
 b=QXD8hDCXnE10BRCjyFwBpBrTXS4KfDmhAuBbtX4/LKJjK6mxu5ip6XypFdw1tFCcvRrPUrrrShQu0/YRwhYzCOwv+d579Np9m9KdBQRm3BhriIyGwPRfar8jLGvWoMmvkbjQ5O0tS2JjWbKmdnA+ZWJakKYK5MD4MXxveuE778a+ElwjzscNNe+aNSUrk2MTY7d9e2zhaxeUoIe54mvb3RjZpO1Cqzm3N4nWD7ICpM3gmrS2M65lbNMHCI17uznrktXlu9Miu8zxilKdnGPbhLYy4LfywL4RY1oqR+G/FpMl7d9X4eMOLrTq34C6bXxs0WFD+NDdBz5PDS8ViC1Y/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBGcbZWZqRgvPFPdcKTzNbZJAZIcXtrafZNSMAxk00I=;
 b=z7VuMxx29a6DeFWlHGo8MI6Qr51b908XYLgYYOsseoKPaKXVWzL5gCPuwaILyfmlrvGteAcENMCNBMwKdBUSwdu85HLBWuvoAk5/kInMk0Pde0pDXuFo4CNhPTtUvuQvjPX2+gf7gn0mWY3lX1RUgEJLX2e0IlRns86vRB2Ejuo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB4289.eurprd08.prod.outlook.com (2603:10a6:208:148::12)
 by DB5PR08MB9997.eurprd08.prod.outlook.com (2603:10a6:10:4a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 08:37:53 +0000
Received: from AM0PR08MB4289.eurprd08.prod.outlook.com
 ([fe80::4a5d:48:bf49:a524]) by AM0PR08MB4289.eurprd08.prod.outlook.com
 ([fe80::4a5d:48:bf49:a524%7]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 08:37:53 +0000
Message-ID: <8cd9b873-d9f8-49cb-89e0-e59f61dc5c8c@arm.com>
Date: Wed, 13 Mar 2024 08:37:52 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched: Add missing memory barrier in switch_mm_cid
Content-Language: en-US
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 Mark Rutland <Mark.Rutland@arm.com>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Aaron Lu <aaron.lu@intel.com>
References: <20240306152443.6340-1-mathieu.desnoyers@efficios.com>
 <AM0PR08MB428936EACB47856176BFDD8CFB242@AM0PR08MB4289.eurprd08.prod.outlook.com>
 <b7660de7-03ad-4d6c-b135-998d2cc0c80e@efficios.com>
From: "levi.yun" <yeoreum.yun@arm.com>
In-Reply-To: <b7660de7-03ad-4d6c-b135-998d2cc0c80e@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO2P265CA0336.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::36) To AM0PR08MB4289.eurprd08.prod.outlook.com
 (2603:10a6:208:148::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM0PR08MB4289:EE_|DB5PR08MB9997:EE_|DB5PEPF00014B94:EE_|DU0PR08MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: a6db69f3-3a1f-4347-a24b-08dc4338e712
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 hA/qrmgn8eQBqjnJOgQXG7DJMbSu41hNHXDStqzWXeI9ZfsuFgPjSH/AyV2PU8IclIRxgNUx55UpkXpr+A4dE6At+2CrHW1M67wqXsa+hqTvtgFOEwENOksF3jYLOpCwr1j+u1Atb2lgDeP57GEyJ8xoXrc9hNkZ0MD1fqBcTWg4YrMQ0l5O8cuJfFQEdRfNak9mZ9u6QhrN/69cTIuteyx8zkau8d42TblYkKAsIt3kn+FGj1uPEs1QTkEJZuHSRgamAU4qpv8AwFsL2dDxMUvOMHQabgiJyRZnjeBxDCuqUUPp2qPwEaxEEgUiygbtOXTbQDcdZo6U0E4NxkPNngPJKwJ6BsK26nImDBqoaKWX8RZnL2bTCUelK9CY75u/m/ZTAsVHKqZcMe/S0D+D3xFKuvjFjp72B5tL+Hq7/OHdBMlKXzjn0vYBnfRGct7+Y0xEUTj+qq/00SRxusFN8kThuCs0Q0c+gHjCBdHtgrmuR9p/KzT7fL8kJKBOd1YPKcaIT2d/OkSd4i3Z7J7CGsLMZnffaf44WgM7LpNrGR0i1n7jHlcda3pJDEr3TAr628V8nyV7MpGP/QMNN7VE2vkJMj23G/dEAuEZ8SXuMx2n+EQiPmRK68VUnVWWMtcnWzr9YDsRdPpH0S5e/bArljg9OxvS5QVwzYomwnIt14E=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB4289.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB9997
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B94.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	00c05686-c616-49f1-3a1f-08dc4338e006
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uOaHMxa1KB1SNZz2/4TtQ0WQNIKgAd6NbX1d5EXkYzOHBx80KZckx4EylChMlH935AC9WYBDu7UK3GWjgKPOhReWVM+BI+9J8uz9bbggBJvT4mk2gYhrTnSFqNFW2p70FYONpA7hFuByKtEuHwC2eics2chv82nZp9URnJrPgFzDpro6P++6TCsM9aY+cjd9Q9a0/secFl0ycS0bTSmfrasuE1XCwuZxN2p4FTXN1dQDu6mOcrz8dJ0KCJqHuClYK0aoPySddio9f5DrpPhpewI3iocK0q6TgiidYEmlc79dM1WYzTPA0n5d1pjXI6HdJ3BPgeTL8At8S46AVHwEGEsDI7gIO/4SqJThcMgmmjD7/KJ3Rc8eANal1/283ORv+2FhEvqRIuaBAqQ/v/H3H5YCBAwZq3DeY7GXlVvimiOqSaVbUapssEXSbp9RvraG96E+8CB9xEDR79KX2f4a7ZqDTWL7+7LJ/PkvnJr2ciAgiw5VKa8F/aS9WV3+7HAEduKySvu9M3liveL8RYmWIWrnDcXgPDsQ/ZoAR4uCfgSi8dzdi3eT8k5ttzbnX4/ByjworhzDFPSy6IXNqlVzEuk9RLonmylyZYJCQo5au5Sg8IFp+GR45S/grMrfLp1uUM4poQvFnJrthVVK23Br+Gs+Ysg1sa9U30gBC7CVCMYbU//Q/KxPF2JV1t3stV+wZFmJt86eMoe+YAFHC5G3WAV75nRcoT2pYcJcS5GYiUO5P6VukXimZD1+vxA+lvb+
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 08:38:05.3599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6db69f3-3a1f-4347-a24b-08dc4338e712
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B94.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8662

index 35389b2af88e..0d5e54201eb2 100644
>>> --- a/arch/x86/include/asm/barrier.h
>>> +++ b/arch/x86/include/asm/barrier.h
>>> @@ -79,6 +79,9 @@ do { \
>>>   #define __smp_mb__before_atomic()      do { } while (0)
>>>   #define __smp_mb__after_atomic()       do { } while (0)
>>
>>> +/* Writing to CR3 provides a full memory barrier in switch_mm(). */
>>> +#define smp_mb__after_switch_mm()      do { } while (0)
>>> +
>>> #include <asm-generic/barrier.h>
>>
>> IIUC, ppc already does smp_mb() in switch_mm.
>>
>> Would it better to add the same macro which do nothing to pcc?\\
>
> Does it ?
>
Sorry. I made a mistake.

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

