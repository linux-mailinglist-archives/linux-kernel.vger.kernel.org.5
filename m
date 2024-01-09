Return-Path: <linux-kernel+bounces-20544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E752E828073
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55F301F2308F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AB321A11;
	Tue,  9 Jan 2024 08:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wz+5ULjy"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2064.outbound.protection.outlook.com [40.107.212.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6641713FF8;
	Tue,  9 Jan 2024 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEAn7vjXo5usrknd4ypySqyG5o7L65MWKGmxUf46aRanw3Sa6Kh02gduNbZxQvw1Vsxy2+uFqfpHSkcRaP44t01qLu1TugiiZW6LCafbR+H9MJ9HBH84cMlxa/twlSSQIBVL45BhLYIZopPpcKOr5okxHN2oAtAmJWAEWiz1GtsU5FmgjH0bcK1iKWad/EWs1v5tyz8Diwqwpd5QTIyLwExydWzCHb38hI1e1c6cU0JTKmxShfy9gx2djM0RI5U+sTB8SgrILbpbCmPqmelAmDzQlpHIacL3jRbH0CPfo2cU5KkjZ9ucsDX4lokXWCusylhhoP598Be63wmRx+KoDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/xPtXlP+xyD/43LpnRdRrygzdakHGErtwhfFQjoLyo=;
 b=gycV3anc10xbgNHmCiU3b2cWHNIhrE+X9FpVOFmSZGcuWvaUtrLXu2fVzJ1Na1vvCnMrVW858Ip8NPSfdDzL9BETCU7GLPgW1tRifQAtCrZGqlIUb3rRyQOrsxZBcw1ueAb5afDdPeLjWuf8v9tqcN4/uF0VPc8cu24V5iRhLIaYghDU6h9oAXm1SNROGiBy8BLie2e2pg6o5vDc1O6yyZYR2Jx2+i8FmQ2a91Ueuq9Si2J1R/LNIG4br19ed+1stNk4FyD8wi16Hm99ogNRbdndrZPojgxXvxvMcebo91SSRkl/rwmBFxz8W1IuygioxqtXnKdwyUTTHox7t5q0qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/xPtXlP+xyD/43LpnRdRrygzdakHGErtwhfFQjoLyo=;
 b=Wz+5ULjyplZLbI1hHprqW1CtSLk3GQkbxiAFr0SDhEx+u8GuYI5u3z9YQ8fcKo198c3zsDX+8dg+iyLOZ0ij4Zoa6gsbB+JYjwb3CERcD6AWm0eDLAmBakI3gt8esHxbzkb5EqCa3kMOxwANCy/t/xodAAYpQmySlrP+XN+O3zg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by SA3PR12MB7829.namprd12.prod.outlook.com (2603:10b6:806:316::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 08:20:51 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 08:20:51 +0000
Message-ID: <d0b7110d-52c5-46f9-8698-ed8e9783d46d@amd.com>
Date: Tue, 9 Jan 2024 09:20:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: fpga: Convert bridge binding to yaml
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, kishore Manne <nava.kishore.manne@amd.com>,
 "open list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>
References: <3100bbc4723643ec1ec7d4548e9ab353c856b564.1704470663.git.michal.simek@amd.com>
 <ab6a9a0e-ab03-4d35-9e43-c90c22dbcb1d@linaro.org>
 <4bcac34b-72a0-464e-91cd-d9e924073619@amd.com>
 <ZZzDHxnMPTuraS4D@yilunxu-OptiPlex-7050>
 <bd356c60-7681-47e4-b45f-d25e70068b65@linaro.org>
 <3bfaab38-6831-41f8-8a7b-9f1f434e0f9c@amd.com>
 <e88205a2-f8b6-42c7-82cc-bfc08a680f3d@linaro.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <e88205a2-f8b6-42c7-82cc-bfc08a680f3d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0300.eurprd07.prod.outlook.com
 (2603:10a6:800:130::28) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|SA3PR12MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: 1890eff4-c53c-478f-c638-08dc10ebe410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TbmcYaiMzvvdNL3u0BSYBYWTajvUm9Ror+y/0HyYtZLFTye3WEkED/j/JF66SIgOH802LpEZMq8Gchis3Uur5wFgEiBgmfM3ltlr829ag4xYsSEys7EtGX4Sq7pKOlKAexCHRQwXBMHUeZorJXRsP+qgdJH0tK0Fip3Vk89G2qjr/BHeBoV7YFX5lR2Zn/JvF+E0fgW3+ZUZBQRlK33qHYQmZpxVF5kJhRqKMYbkN5lXYBlF2g9G6tXw9ubsiygTzGCLD+EFwtuZMeV+jIxMxTbwOLwyvicWtW31/yGfIZ24Eb3G8WMUh/QHR/00DW9nJBxy10vz13hYJV/YMtVyCvFMa0otGBl+qZWCby6UPWUZ9jiOgl/sHfEjHBzulxX36xVYFokG95ISm7QykAIFsXitXQy6PJ6I9LXSTPAYlRgUY/a2sezOPdpSYm4GqMCC18jmv/R99GXaEwpH3mGCvzXu8z73wM+94yfOjVqowJB500YKck8u/+ukaWHEBcA1RdwmPzlM9iPfWEpnTAoAGMk0RwWbuquV6HXdGOllPW1gas0ogbSP8GcVvowZ1aRRYSDbqzjYqOsKlwFW7d4GvS0ynYhxOiCKfKMeE4SuYmRN1EAH/t4azWaHU9SaLAVoc+WIQqjFNFqm6OuvfoyJvkqSTZKDIaEJG3Zel+dgREM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(53546011)(2616005)(6512007)(478600001)(6486002)(26005)(6666004)(966005)(6506007)(83380400001)(5660300002)(2906002)(110136005)(66946007)(66556008)(66476007)(316002)(8936002)(44832011)(8676002)(4326008)(54906003)(7416002)(36756003)(38100700002)(86362001)(31696002)(41300700001)(31686004)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3NLbHh1Z1ErbC9hVFAvVE9rL3JjWnNJQ3E3SFQyaFpkWFMrU29wUWtIQXZl?=
 =?utf-8?B?dWJYMS9sekxuTk5NbFU4MTYybTFCdllETTVxd0NuMTM2WXN1MXNpMWJpTkFS?=
 =?utf-8?B?UU15R08zdWtNU1lZZmkrOW5yNjFZMldQMjIzakszZnFKWVM5a0NTMVQrMTFr?=
 =?utf-8?B?KzdnYXRwY3plVTNOeHV3TERXdU82SytrUlZuaTQ2UkdxT0lncEUzNi9mekww?=
 =?utf-8?B?QVdabHVZQzl3TWE4YTMrY2lnSEp1N3Q0R2lFWXhFU0xPUmorc3BpeWk2VFZ5?=
 =?utf-8?B?aHgvenE2RnE4Y0dtc0x2dEdaVkJzYzVVUUpyTkZOYU9XSDRFZUNKTTBqK2FP?=
 =?utf-8?B?akJtamZXMzdPSFpiZ3ZWTWgvVkQ5ZldEaWZsbVJhRGhVTXZ0TjhoNWN6NGh3?=
 =?utf-8?B?QW5qV3NFZkI5R0pXTnJwY054NWN6Y3JhOWsvMlU2dGd6bWJYeEFqSXk4UUhF?=
 =?utf-8?B?QWZvVVd1dU1iSlFuR0RMcU1BV1puYXl6T1hqeHQ3d2I0Z2lHaE5nZXlKdVRW?=
 =?utf-8?B?OEdMZ0xWa2czdG9DZDg2Um95aFlaWjM1Ym9QbzQ3TXdxUFpvSjFmQ1pjU1Nv?=
 =?utf-8?B?WVE2V0d6bUxBb3lUc3AyMjZBcVc3NjlhVkRPYkg3SC8zRnIwNlNldU1TaEl6?=
 =?utf-8?B?QjkyV0dwNCtxQld3Z2xjUEFyaXRLRVpyMUJTajF2WDZIcGl2T1N6NVNBeWp5?=
 =?utf-8?B?OUQyb1l5aVlYS1h5Vlc3ZTYzdUFITGFIL1hsUDRZU2RBbkg0RlFYS01MRU51?=
 =?utf-8?B?RGVVOER3WmQ4MTFhdFNlZnRZWndNVGRqYjRUVElyb1hWYWlGQktjR1l3T2ts?=
 =?utf-8?B?UEJsRlJlbDE4S280QlZwN3ZhSmFwR000T2ExMjlMamJKZVBWRHRuVHlBQklQ?=
 =?utf-8?B?N3ZkL1ZvbXFrU3VVdlhzay9RSWJBa3NDMUc5L0VqUis3MHlVcnlNVCtRU2Zw?=
 =?utf-8?B?OTRtRzVrV2pDUStWU2UrQ3R2NXZjaytlY3NFRVF5V2QzOEE5RFRSZ1F1TnF3?=
 =?utf-8?B?cmNJTjJrczlINGRjZDBvaGw3dGUxOTFFdkphS3g3QVgybThnNUJlZjFhZWlq?=
 =?utf-8?B?TmZ3OTVLR0ZTWWdGVTUyUmI5NjNEVkZRTUNBTGtHTnY4MVZFWm9xeEU2ZGdR?=
 =?utf-8?B?M3I0YStxaDErYms4aEUxZDRERksyOGcxQ2RGanViUkNPQzRwL2dQelhHUUN1?=
 =?utf-8?B?eEFmaDRwc0lJSVFBSW15dTFnbUVQcy8rRG9RZHpvOW9wWEtMUzNZeDIvMk1E?=
 =?utf-8?B?NnZKelZxOG1nZzFWNjdLa2dNSGRkU0dvYjVGbXNHZkF2N1dlc0lNL2x1STZD?=
 =?utf-8?B?OHhjNXdqRGRtTHNuREpPc0Vwa05CUXgwVnVTMUJXa1ZGVFZXSHpOVkJrMndM?=
 =?utf-8?B?aVVseVdBemhhdmlWM2FZNE92cmtqTWpvbTVOblNvTm9GZmpua1FmMFlaUVlv?=
 =?utf-8?B?K1kzM3ZuWHdha3JiTytsdjJIdHZlNXVLYWZuSENUMDdSendHZ0tpR1AzV25F?=
 =?utf-8?B?b0lnZjNNQ3E1SHVVR0FqZU1SbGFwWFVZb0xSRURpTG1yNHM2Um1rU2cwNStk?=
 =?utf-8?B?Z0FEN0NNeHFVRDR3Z1F3ek03L2xMdStGMDB0b0xPRUdOLzFSMHFLbG9Cc0ti?=
 =?utf-8?B?SjVpMkpwbW1OSUtWcWNxVytacGg3cy8va2cyTGJITHRubzRiaktkbXl4UTVC?=
 =?utf-8?B?cVVHZnI5QzdualBiTnlLdEhzOFMwRlgvbE1ydVRsb3JZTHVndE92U3h2dXIr?=
 =?utf-8?B?VmI3L25KSUNSb3lWZzlLRnVmeGhLSWUzK3l0UmpiOXFIcTh2YzhnbGtXckJO?=
 =?utf-8?B?MnV4bUlFVjhKcm5aU0dzeWpNcVYzci9zSk9Ta1pTUHk3cUwrcjNGMldLd0o0?=
 =?utf-8?B?ZEdyMm44TXkyOGlKVVQrOVozWG14amU1MXRQcUowbkFSdmNHR0xiVjZVOG9D?=
 =?utf-8?B?d0pvLzJHeHhTZjBpbzdHSFNNbkVhbTdCelJIM1VHWk9MMUZ3d1d4VjlNaExO?=
 =?utf-8?B?UEJlV1lNUzBBQlhScU1pK0tCR1B6TUdWbGxyRGNzMFVOR0FpZFpJdGJjdzkx?=
 =?utf-8?B?cDlDakk0U1pkTm5hbE85UFVMTDJ2QXpmM3NXMUZYMWYzbFVTamRkaS9iais1?=
 =?utf-8?Q?rte8Hx5Unf6aDrV9gsPn+7vUU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1890eff4-c53c-478f-c638-08dc10ebe410
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 08:20:51.2090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgbPf4CL/OBSPe5AI9lm+svrSo6AtVZYb39bOUx3S2Uf1LjproxvkNFFVh3V3rkO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7829



On 1/9/24 09:15, Krzysztof Kozlowski wrote:
> On 09/01/2024 09:06, Michal Simek wrote:
>>
>>
>> On 1/9/24 09:00, Krzysztof Kozlowski wrote:
>>> On 09/01/2024 04:53, Xu Yilun wrote:
>>>> On Mon, Jan 08, 2024 at 10:16:17AM +0100, Michal Simek wrote:
>>>>>
>>>>>
>>>>> On 1/8/24 10:09, Krzysztof Kozlowski wrote:
>>>>>> On 05/01/2024 17:04, Michal Simek wrote:
>>>>>>> Convert the generic fpga bridge DT binding to json-schema.
>>>>>>>
>>>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>>>
>>>>>>> +$id: http://devicetree.org/schemas/fpga/fpga-bridge.yaml#
>>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>>> +
>>>>>>> +title: FPGA Bridge
>>>>>>> +
>>>>>>> +maintainers:
>>>>>>> +  - Michal Simek <michal.simek@amd.com>
>>>>>>> +
>>>>>>> +properties:
>>>>>>> +  $nodename:
>>>>>>> +    pattern: "^fpga-bridge(@.*)?$"
>>>>>>
>>>>>> Not sure, but maybe we need to allow fpga-bridge-1? Could we have more
>>>>>> than one bridge on given system?
>>>>>
>>>>> Yilun: Any comment on this?
>>>>
>>>> We can have more bridges, but IIUC people use fpga-bridge@0, fpga-bridge@0
>>>> to identify them. So the expression is OK to me.
>>>
>>> So you claim unit address thus reg with some sort of bus address is a
>>> requirement? Then "?" is not correct in that pattern.
>>
>> I expect it is about that people are using fpga-bridge@0 but bridge is not on
>> the bus. Yilun said that reg property in altr,socfpga-fpga2sdram-bridge.yaml is
>> optional which means no reg property no @XXX in node name.
>> That's why I think that expression is correct. If there are more bridges without
>> reg property then I expect we need to get more examples to align expression.
> 
> If we allow node name without unit address, thus not being part of any
> bus, then the only question is whether it is possible to have system
> with more than two FPGA bridges. If the answer is "yes", which I think
> is the case, then the pattern should already allow it:
> 
> (@[0-9a-f]+|-[0-9]+)?

Let's see what Yilun says. I am happy to align it. IIRC in our case bridge 
doesn't need to have reg interface because it can be handled via gpio.
You can have multiple of them but doesn't make sense to allocate multiple gpios 
to handle it because they can connected in a chain that one gpio drives all of 
them (And I don't think we have ever been requested to write a driver for it).

Thanks,
Michal




