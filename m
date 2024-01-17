Return-Path: <linux-kernel+bounces-28684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B1D8301D4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0E311C24ADF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DFE12E7D;
	Wed, 17 Jan 2024 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CgUTZyB+"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2017.outbound.protection.outlook.com [40.92.102.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E65312B69;
	Wed, 17 Jan 2024 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705482215; cv=fail; b=llLr/6E4ukRxI1cenXjMawR8HyWs6FPqE5oQRfEwrt3jP4NG2YxryfvtUvqxGVsyY2kl/AcmQbMmR7gp1snMNICz5kSF9dpONa3l6O1aFRa8JwuArHsaZbiSiIhJ8p4BYqHXct9S29ob92CpvhK9/EpfbpIcRiP57fafa0IcQuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705482215; c=relaxed/simple;
	bh=rF+8ZFiEhiY75EWmYSN13vnEURzzrMkwgCVIXvoPXC4=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-TMN:X-ClientProxiedBy:X-Microsoft-Original-Message-ID:
	 MIME-Version:X-MS-Exchange-MessageSentRepresentingType:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=lB+5Z36Ki5vUQZXpEdhPyJQZpFFWfkvXQJJhu7RqZw5SEOpqwKonjK7TjtnNzKVMaw9SVyrxoxMTBKafvmUp2knoYuEsidpetklHYeKHk2ByM5zGukxUU/v6fv8GODkPhd+85bcjus4/RIObaUqSLQgXEbjqtu6tiE3IBaUbN7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CgUTZyB+; arc=fail smtp.client-ip=40.92.102.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h01gmrKvBCdCUCQKXTdlesxcGy6lnzT3dZIO/TlK5cYfDeYP4nkyGDIZ1aq3/2viQjT4gVVrodaulXdhmCSWE+SAG0Rc5DiF9md9P0AzFONg7TaGaFo2NreFUPkw5wtaUeIDc3hypjCtOrMnHSB6aFnYr4WlhuUBsKbzi66a0vVmRtsTFd++Ksep+n+hKccHtjkgk9WPBOZLN2Mpz5zHvNk+XB3CteuSSHw+HDCP2XRDovjf3ZMJ94w6uLJN/W7zzJRupgws1Row4PkcCeoQDlOXAadX8XxiJjip6wIzs103h26huYT9fGGkK0uWqYnTDhUwaptWL2fGfEXWNtb0Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvVYJShW9oPs76rq4fQ8+izi4NZmkLJ8sLvFGaSLLNE=;
 b=DhUxfiKsDcXDkkV7qVC2L/dJwtCxOMSwR0OKnu0/vQOJcQXBQGVzV0MtZugD2zMlLz42vdOSCHcVS9l3z/GYhwkGb8o45Zif4Ez3PFPmI4yeJIXjwFjUaPcQj2ewuURKnGVEsY2C839PSbgcXAr8eUHCwlEocx+ZJmf3BH3x/stHEXQb9sXM3wRIG1oEaMY2JEptIoXE/KhvxJ50iWdMnZ+QK8JSq4A7sVQQ+Zl+MoFGp/vUGsBr8xXkz5HqxQsKJoaf5G+l0k12kNKDEoxvqbikGZp5wlG9ubf8jSe70afexD8ZYWnCVoT64pN8KV05qOO8FVW8GPuZAkDC6fqeKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvVYJShW9oPs76rq4fQ8+izi4NZmkLJ8sLvFGaSLLNE=;
 b=CgUTZyB+mZtlF63NmyGgENNafTiI1o1DCgRRi2sG0IKASm8QtE5xEonZOLx+yFnlAuk/4Awru27a5foKsLqBOYkce4n4BhAVfCTCGbDCDeKKcUG3HBBWF/iaGZqeCFn7D9XVF7bdkz6p5kqBtIP14bn/+xOkJqT3ElThbQQuDcFs5GNlybNYVWil6RbToOZBn3TJms2eNgkp9ZQFolLJt9e4EjF2OmkJAFjaPJBeYU4lE4r5ACIQVcSzNGzNymV6s6R5eOH6ZwpFBvKFcTgs0KE5DCj+v6knFIaxBJQonxh3rGUQrL69AT6LDALb++0L5uqbJOBjNdORUZ9yAqfmOA==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB0967.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 09:03:27 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d%3]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 09:03:27 +0000
Message-ID:
 <MA0P287MB28221065B41ABE67768B98DEFE722@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 17 Jan 2024 17:03:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] riscv: sophgo: add pinctrl support for cv1800b
To: Jisheng Zhang <jszhang@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Chao Wei <chao.wei@sophgo.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20231113005702.2467-1-jszhang@kernel.org>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20231113005702.2467-1-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [MCUEadc/JlyHf5urSc7YByL4+wlsT5M4]
X-ClientProxiedBy: SG2PR02CA0061.apcprd02.prod.outlook.com
 (2603:1096:4:54::25) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <67baa1cb-e566-4915-acb4-d58df73ae4d7@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB0967:EE_
X-MS-Office365-Filtering-Correlation-Id: a16e9abe-313c-4580-ee87-08dc173b29f1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uodcnI0CRPsrTsrtKbl1EfhX9nDdOQA9fkx++dJvCXbwHCnNCDOJ5CmhNp48PIw3yn9ULc7sZCH9EXsODE4XV6ZDfVNzh/tcrzi71F2dzOLra9hStaT22227o42A6rsuhcW9Q+gUPn0sY2MTcG7jHW0qozmaLbxkkeJ7uQ4XC2/LhoFmLA2R4EbnEtSB/NrjgNkyv2xA/1mqgrU2oJ/u3fZ7GWQGwUuDdpkat2uCvYQBBbUd+pAebj0YL/nj+56PZY8+JBqIsa+uQ9J7zblx3yUTMZ9H4cUDjRWI4PF+4OUPTRHjKViNTQjBH5wgLHBl4geGCJbj4Vw42/qGMLrOTs/Qg4XPmPqzaht7xDPOWGFL/5HLbS/w/qHQlzyzkHG+1bcaVRkulNHHPEisDbf7zmXR9CSKJF9AwL+ExC8ejLvYTAXa4M2RZIl7eNePL+qsf4MIVRabtndpjKK0jViuhi1yVnxJKXzkcI3JOiBOjeOWo1lnxfBGH6QIADG2++8lPA8tSEcHxfC57mTvORpAFDH0k4WMg/Ba7667H171P9DBVoeVwGn7muIOQCzmyAIu
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTJPbk0wZllFODZLSDlvdGFqaktXRkd2Y0ZKWE5aVlpoMlg1cVN6QklyT1dT?=
 =?utf-8?B?b21TalBhNXJQcXB3dzdFdjFSNEFhdDM2KzNINUIxOHJQbTJhbGNjVUxlMnpt?=
 =?utf-8?B?L3JQcFBLRS82NGgzSTMvZUpkMHdTVUl6Ni94eXFnSkdVWjRLWktiN0M1eUdO?=
 =?utf-8?B?djRBQWNlRjREOXFwVW1MRjMyMjdpU0htYVM2Q04wbnVYeXFwaE1YaEtoZVFq?=
 =?utf-8?B?UlU3bUhjalBsSTBVUjJNSHpBUzFEQXlKZzYwd3UxSlRwcU1vZ1FUbHBJaExO?=
 =?utf-8?B?bi9uYWMwV3pCWWQzNCswZFlyZGxTT05xSGtLZHk3SVZOWitNQTRGRjVzdzVo?=
 =?utf-8?B?WXJlQU9DemhDU0tHM1Z0Nlp6RkpORjNoRXFYa2lCcW1CU05wdmsxSVE3bGpV?=
 =?utf-8?B?WDROc1R6SmZWdmU5RFJGYnVFN0RNS3l5QjdRN0V0c00xc2p6bnFhNFhTUGx6?=
 =?utf-8?B?WS82aWhOdzNFbTZOcXcrV1g3a3JGTm5TSXdHMWpmeUhOZ1NOcmdTdUV6VUhC?=
 =?utf-8?B?L3VMNVRZRzgvN3lpaXUzaVkyT2F0aTVOeVdMR3RTVjZtTnIvREVCSnIxL0tR?=
 =?utf-8?B?R0FSTDR5NldvTEtoN085bVgrNXc4aDJRS2VZdGJrV295enllVngxMkpSV05h?=
 =?utf-8?B?OVBhR2MwSXNCK0p6clFLS0p6SHhTeEh0OGYzNUx4TlIzcUhRTVY1MCtTS1I5?=
 =?utf-8?B?VVN0ZzdyNjJWbTFRMVZvNjhqSkw5VVY1ajl2MEQ5a01qZFNsTVlGYnBEREhk?=
 =?utf-8?B?bnRUTU1pMkR4SGw5dm5KK25HNHZ6cTR1eXVaeHlrTE9QSlVlUDJHN1NhVDlo?=
 =?utf-8?B?elJBQWZTUXB0WUlEUTVEczBkb2JCdENGUkt5TmFTelVOYUgwc1VZeE4xSUNs?=
 =?utf-8?B?WnhXb096blpoeUlsMFl3bDNUNEIrR0o4T3lLVEFEZzlUajE5OHMrVXI4UE84?=
 =?utf-8?B?akI3a1RCZ0N0eVBuRGhDeURwUXYxV2xFNSt2Tm9iaGMwU3FyQ1U2RktwZmx4?=
 =?utf-8?B?T1FUS2ltT2hIOGtqWksvRDRKN3M4NU5YMVhxazExQ2RDb0d6N3ZEMTRBby9Y?=
 =?utf-8?B?VkYyZmNiNm1UT2cySjlVdnJHazRIbFhGNEZJTVlMS2dhV2ltbDM1S01tbmhE?=
 =?utf-8?B?UmZtSGtZWVB2RWo2bTR5REtuOHIwcG9qMnhvTHF2Sy9FU3U1TG5xV29GNWRQ?=
 =?utf-8?B?M01scWp1TERrWmQwcVpzbzZwbzVJRERlZkk5WXc4WW4rYjdUU2JINmZFYUVz?=
 =?utf-8?B?SVVUTFBTdzZLZXJPeWFzMlZ5WDVwaE9PM3lvSndad3FzRUVLNnhlUXlENWY1?=
 =?utf-8?B?Y0dORzN2aXAwWENCQ2phY2FMT1lVeGpmMVBudEpnWXlDWGgyZnBiRW1CeklK?=
 =?utf-8?B?R1kwR0pVSFd1NTM1Y1JrQjZlT1VVL0gyTGNhUGxWazRiaTlyMGU4K2JyTjJR?=
 =?utf-8?B?V2hNNEkrUiticjVjVDYrRXljRmhmcFM2UjFPV0hVSUF1bXNKcmJQN1NBK3g0?=
 =?utf-8?B?dFgydldZUTdIa2x1V2E5TmhBRzQ0ZlBjZ0F6RUxWRjhUY2FjWGRibXVEamtj?=
 =?utf-8?B?Y3N2aGRRb29IYTBjdktWeUZ4VDZ4VWFRallhbDkyRjVuSmpTL3Z1YnBCMEU2?=
 =?utf-8?Q?OTDycL2IBELJOSETp1jzuc4tZ4v670tud6gkNEWCEUHI=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16e9abe-313c-4580-ee87-08dc173b29f1
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 09:03:27.7295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0967


On 2023/11/13 8:57, Jisheng Zhang wrote:
> This series adds pinctrl support for cv1800b reusing the
> pinctrl-single driver.
>
> Jisheng Zhang (2):
>    riscv: dts: cv1800b: add pinctrl node for cv1800b
>    riscv: dts: sophgo: set pinctrl for uart0
>
>   arch/riscv/boot/dts/sophgo/cv-pinctrl.h       | 19 +++++++++++++++++++
>   .../boot/dts/sophgo/cv1800b-milkv-duo.dts     | 11 +++++++++++
>   arch/riscv/boot/dts/sophgo/cv1800b.dtsi       | 10 ++++++++++
>   3 files changed, 40 insertions(+)
>   create mode 100644 arch/riscv/boot/dts/sophgo/cv-pinctrl.h

One question, when we use "pinctrl-single" driver, should we enable 
CONFIG_PINCTRL_SINGLE? Or just leave it to package vendor to configure 
by themselves?


