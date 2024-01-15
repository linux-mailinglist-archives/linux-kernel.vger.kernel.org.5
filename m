Return-Path: <linux-kernel+bounces-26255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8342682DD93
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D23B1C21D3C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D7917BB4;
	Mon, 15 Jan 2024 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C7rv/k22";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MCAssNnL"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7977C17BA7;
	Mon, 15 Jan 2024 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40FEa4dW018707;
	Mon, 15 Jan 2024 16:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=hfrx6qzPOz6RveRcILfn032X8SdvZPh2IziLHMigwjE=;
 b=C7rv/k22HumZcwEnf6A2MlyG4B3Hh3dDH72hpEUWGFX1PybxI/KTN8x2URlgUUqUR4e3
 khul+lCYGecP/WWzkuqBilfXTMjBGIqbkrsHMcGUg7z1Xi4SLqHJ6X3ke2yEPXZCQw2A
 w5HmcLUUESOmVj21jlvYH8EM/cjDR7fY4y41Ki6YazWsJbOJXzyZp0uIQWOFKIiQ8x+r
 tH+WhWmY4O2N+dsTkbTca5Daj2eTjHlLjOZ8oSGki0uK1CtBGUGNdDzNyekeisMEPddx
 jJhTCilni54BdjOr9aV+va1zg+AWcOVBQG/gR9Tj5ED/arCnHAb/27OpTfUdr3k9TBJI 8Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkk2u2p9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 16:26:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40FFOeuR009528;
	Mon, 15 Jan 2024 16:26:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgy69xey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 16:26:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fba7t/Xs1yVTxBrP14EWKj9jsW0YVx8zcYh1YyxUK91b3xXNXr5AF1ldFm/hHxLH1AVJGogF/YwzlkAZ4O7FspISDd8m2lPWbwX83pbUVvITsrt5Gq8lNZoPstHwxgZABxMRGmfO1YQFEXHgkaYWFBk7uG049Bl4dimZg5iLHiTMCJuiR0NDkhEy/b1D6htnzK+Pbl+XvIhQGIS367acuRO9AffhvnK4dJ+ykdl1koAFudV9HJkkUwSrzMoGWH6xotKE86pSpVZynX72DYIgkrFL9K62zJg927SQkcVEZkKk7lq0hPFm/Zesvl1IPv+lJDBnCKGQBjwCfmWQVlaj3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfrx6qzPOz6RveRcILfn032X8SdvZPh2IziLHMigwjE=;
 b=Q2JZS/UyQygJkwaKvSjYAVjDb6qZ3Vp+jrk5YH7d4FUTUCXtG/m3DaHneiI2wXYIxtKFu8Y1usnsbBanTBfz4K2X1wwkqPilG2tXXbd4jIKLhaZ82vxRLArJRJ4/SLlXRWnNjrbxK4+sLmTqh7vDFMcGHiwXq/8z5hMBr2HS1/FuHzvqXWp46Bjw7vZTYzxUj7DDHp/6Q90ttfZguL8JalF0Y9G0HYQ7YTwErnF1BI5YuWBmg7C43ra+FLvY+JFCNE7AckwsdJO0Nw55VTOjPS5boRf2wP+AhSZg6j1Yauhr2AvwmFQajDhVJoiIPNpZfQeMSU2XQRSgPnME9hfdKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfrx6qzPOz6RveRcILfn032X8SdvZPh2IziLHMigwjE=;
 b=MCAssNnLONrU8yTMroJSnpspmxvJSXrVIMJoq37iCl22TSjr6HDI+KtxQMUlxQKTrNpTHf4A3xAGCrIY017DIo/fhtwemwIbaHp3da3nMqgzn0LsVUtQ/oYLzSByM8Opj4gtO8Ybcdwjix1qNY3gHESWk88jgrLETYp02yk/k5o=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DS7PR10MB5973.namprd10.prod.outlook.com (2603:10b6:8:9f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 16:26:15 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5%4]) with mapi id 15.20.7159.020; Mon, 15 Jan 2024
 16:26:15 +0000
Message-ID: <eca71e44-c5bf-4989-846a-2d700fe113c0@oracle.com>
Date: Mon, 15 Jan 2024 21:56:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/59] 5.15.147-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20240113094209.301672391@linuxfoundation.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240113094209.301672391@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR0101CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::13) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|DS7PR10MB5973:EE_
X-MS-Office365-Filtering-Correlation-Id: 60d8c385-7856-42ee-ba3e-08dc15e6b204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xaca1IE0At9Eu8BBASe6fcI4IimwYQUPuiXdg0fJRx2OqLdNNPzxbwSs4rlujYu5id6rp+udYLywAb8g+mhtRoioHP2EZbgGMtTohQQ5uwkRtieWlj8itG2VoEcArvASIQdjkAdr7aEf0wzXWum0R/JmQLBsRvCC0xwZf0jBTFHvcFbPehlu1+Gh+1f6v/5RM77OqfBeZX2MI6AI7yR1kUB1xDz5mjNEOnB5pM83X1LYDX+5TGboWnYbiuhnHw90KByxnmLZXsDKp9Y2LA909dyr8zA0UbMICSX6OFFVox7hAaXC1Tp6UNxKp3FveOhXL36tcu9ICcFw2+7+mxbKi6sua+/2L7bavcgCfhXCPKFjQu/85ho1YsgDVj4eqmgsD2AZEqLhD2Bnq04VToo+87A2z/sCjCWy12eu7PH8QpCSL0EZelzKzQsSXtYQznslOWn8Zo8APZ5RoAijaOVpbRHUCH2vUzn8g5FbLhdyN2akw0CU5Y4x3W/1DniZZrg/9OxmxK0WEe8jLbI7bnCLLFHpsjikysyHN1juyvrP4NBp7ija4p6aBM7gKac+XI9LvxQTZaALcoh7jrhCcF88S76Xfst3d1OKEk89Oaa2XKaZjbhF7Q8+P+iMXKTlpp2fqn1u2tkvvgN9HHKh/yYFyw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4744005)(31686004)(4326008)(5660300002)(7416002)(8676002)(38100700002)(66476007)(66946007)(66556008)(8936002)(966005)(316002)(31696002)(86362001)(6486002)(53546011)(6506007)(2616005)(107886003)(478600001)(41300700001)(6666004)(2906002)(26005)(6512007)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q1Jlbk9zWld5cldEczBzeEdTbSsxai9KRDc4TE1SWHpVK3J5T09LZk43Y0dm?=
 =?utf-8?B?aFcwdmdJeTQvd3ZHSE5tUmkvZUdtbTYxR2xUaG43V3M3dWsxRVQ0YXFCRHhn?=
 =?utf-8?B?Z2pXMnJyeGdUbWdERUhhc2ZOSHJtSkozMzNTTEoxQzg4YW5RSzFodnZiOHJ0?=
 =?utf-8?B?bFJTWGQ1SUJVSTNaY0cwc1JBV2VhdFNpNmYrNnJ5aHliRitNbXJFUlZwYW9X?=
 =?utf-8?B?Y2llWGhDT3N4QlRYU2FxUkFOVGw1QkRiS3gwcVZtdXNQRi9CR2VWVXlCNEY0?=
 =?utf-8?B?cllkVk1kVnNyaVozaTdhd3RjTEZDR1FPdnBIQkpjUHd0bXVEMnpVNXFRdjVF?=
 =?utf-8?B?RWYxeEV6dTFTVVNQdG9xMlZSNGRTNWE4OXV2UHNXNm5lb0U3MjBSWi8vMHBy?=
 =?utf-8?B?bVE2Y05vRTIza0xaZlZubzVxU01MZ1pKYkZ3TGhYN1R5YmlnUThHM0hkNFhK?=
 =?utf-8?B?bElGZElpTGxVOUtIdnJrSDkxTEt0MEJRVWhsVytFWVUwZWp6RUsrekFnTWFt?=
 =?utf-8?B?Qkk0akhiVEZsNlFUVkJLTTNyS2l6blRoS1lRK2R3SDFaT3VMdlR0OFAzb2F2?=
 =?utf-8?B?eUJiajkvRFdxdEw5Ym56NURGNzA4YzQxYjJpMzdyeE11TWxscjM1NGVUM3Bj?=
 =?utf-8?B?YUh4ZDh2S25wbzdJeU1HWHpneThveS9TOXB4b2V1cUZHYURqVnliZ3BWaFJ4?=
 =?utf-8?B?ZGd1UXpISm93d3NUcDl2U3dUR1YzcWJyQU1LQyttS3MzTzJLak5oSzQ3THhm?=
 =?utf-8?B?M3QwVk9VSkNSODI5OG4vL3B2SlFBRnRPN3M2MXVUcDI2Q0swUDduMzdSa29W?=
 =?utf-8?B?R0pkdDJKOFdoNzZZK09jdFBLcUNlNUJHaEZVM01LdURRTjV5N0ZMN2JpemUx?=
 =?utf-8?B?YmJScStaTWtkNHJhRWRxR0pTVEFZbm11QmJqN0ROc1RvTG9wREx1TGoycWQ3?=
 =?utf-8?B?ek9TMzZaR09nQVBDaUE4MVBISkllRG1yaW8xUmhXTWd4WmtNcjVxTzVCb0lR?=
 =?utf-8?B?ZmdBS3hGaTdxbFdXY3JMV1h0TWlvQmxVaGE4ZVVMLzBtZWxJUDhTa3lOSEJV?=
 =?utf-8?B?ZWozZjJhNEpYR0w0Q1cvUlVzbDQ5N2tQL2pnKzZlSWJHektKU2p1RXRib3NI?=
 =?utf-8?B?SjliM3laeC9wQ1hqUnQwQ2hMdHYxU1Q5dnlPblFrYWdBbmpqMGpOWTFmNFlQ?=
 =?utf-8?B?ZUtjL2g5MEw5WEpBcjV2QmNwdi94cElWMmplR09IdVNZVFowSWFsTXpieFVW?=
 =?utf-8?B?aFIzdDhJVFNhaUtTY3FYYWpvNGEvRzRnT3dCVEpoczIzeVlTc3E4dDk1Qnda?=
 =?utf-8?B?ejUxVDFTTDU5Y3FZODl4a2xsYVhNQ00zSCtkbGIxM2dDaVM4RHd0RUREMjRt?=
 =?utf-8?B?NWZtRXdwL2RnOHJBN3JCRDMyWS9PZTIweHpuNU5RTWpYSERoZ2hoT2dkNW1a?=
 =?utf-8?B?cWFPVjJKRmRZc1J1aWYxVmVENm1Sd3RrUWlIb29yM1NaR211dmhoZHVSVmdj?=
 =?utf-8?B?ZmRRODRnYVovQkx2azNkdEdGUXJpd1V2V0EzS3ZDMmdxNDh4enZXRnd2anI3?=
 =?utf-8?B?VHFQV0EzM1ErNFBJNzhXZmNhcE1kSThGWHcySWRKbFZRdzgrOWxJN2F5SElU?=
 =?utf-8?B?QzNNRFluaDJvby9tSFpoR0Y0T3ArSnJQN0t6N2xYZmtzOXZhRWVMUXVnVHdK?=
 =?utf-8?B?SXg0SzVUNFB1aXQxWVBLNWhWSmhKMnpPdzlxZEZyTGJwTVZRSXprZFN6aE9o?=
 =?utf-8?B?Qll1Z1ZEMkpUU25HejM0MEhtMnB6bHVkZnFWcjBubGFtR0cwNTk2WHpsYnR2?=
 =?utf-8?B?NTZJT2tlQmhsdkZDdWtyRmpSSTVZTGJxN2crT2d3cU5nL09LRFd6VFd0dVcr?=
 =?utf-8?B?UzVrWWVRSGN2VHVBSzJmYUIvUjlRRjF2SWNQVGtpRWhFalVFU2FJQ3J4YzNF?=
 =?utf-8?B?R2V4TFBpRnRRekpIWTRFKzZPWDV1TlkyYkQ2bXBlMkdCSXZWWGVmMjh6RjZL?=
 =?utf-8?B?NGxvUWoveTVTZjlwdzBLUFp4bG8wcUlHSkorTmNkS2VPZ2dOUWgxaW9pUVd2?=
 =?utf-8?B?eUZKaE1TU1RhOEYwMVNoUDMwNUROeEtBVFlQZ0xzeFlsOHZxeXVrdXdCV3M5?=
 =?utf-8?B?WEExbGx2Tis4cFUwbSt1TFhlTy9tdlpxR2lOcWFiem5XY3NxdVFvd0JVMEh4?=
 =?utf-8?Q?FyWEs+qmLNpJNtJmeM6DG/8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	z/RJJ0Zkzz60LK9/zAo+MDz8w6Kds73XtReJnW72Qk+O1/lHRCuRIyMzbL/ERKESHGn55TeZXvbBZ5piPzrWnjxifBtojrhuxjxMKRssU/ToD8tRSO5f4HWsMCXZRmngycqhVQq8N+oUWDTqnT05rOzlKno3BOLR/EoeImu9SVD81wv6Ie5U8qzgXbDNC9NOZWkAUEjhgm0HPYDaIffzSJyABxzHRoeDD4L7wk5E2Dw8E9/OaRjOjCbUxGqBGCoJhG3QjIj/JDFdWOoxX75IVL+jgRLjyouHAva2DrnhALD0sJPuNLyvfSGhCvrNx15u784KjPHfhmwI4AECYMS35K9/V48wwfnzq9bGp3QefeDhkrvOUJGph3Og9ISdgA5DPyJSfFLhJTHZIiH2DULu2N+uGw3q7ZnD5VGMdriBtEqIx2V8LeicRZGIEZXTXgeIRed1wWvDho2s3qKSD2mgcd1nk9sLMmIwDE0ubWYXnfVul/tDVcURp0sUxrfmbkanNJMJlq8/aM0Sy2aOb5+jERh0885B26MUVNSnzTJQzShNwC+txmANBWkGFiWFgTOJ9hjFr2wGmBQrHoyVLzxI0dHaBl9Gp8Tudm0GIALTOEc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d8c385-7856-42ee-ba3e-08dc15e6b204
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 16:26:15.5878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kPf6DhIyVzEg2XJ2XQey7AErittchLj8BGP2RMEIL074N7+7/ARBROPOOPpd1GiH6EfqZFruJE0fZrS77gTQpooL8RCHvKFFvdGJ9BmBU6RJQ1VuhdjpbBSk4XWyK9l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5973
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-15_11,2024-01-15_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401150120
X-Proofpoint-ORIG-GUID: FpQs7tDAeCfvIlnRVOf7_2HiiMQDmDa9
X-Proofpoint-GUID: FpQs7tDAeCfvIlnRVOf7_2HiiMQDmDa9

Hi Greg,

On 13/01/24 3:19 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.147 release.
> There are 59 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 15 Jan 2024 09:41:55 +0000.
> Anything received after that time might be too late.
> 
No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.147-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

