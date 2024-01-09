Return-Path: <linux-kernel+bounces-20898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8539E82871C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6FB1F2536F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021AE38FA4;
	Tue,  9 Jan 2024 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RSnMI9Br"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3AC38F83;
	Tue,  9 Jan 2024 13:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dq1EO2pLLahWBjVRcIdwZw2oRwQLAIZqhK5Jt8tpD1y+/epWtQeS2RcNd32OtiOKJpQY/6JsihVXQqd3lXrnIxmSWQ+fEm/iwJsWJPTkG6ZLVgBwkZZgX+DRdctPLic5V8oh6Bj2AKElgjVxxfKYMX6tjo5JuYYawtESw2Erk1neC0XgLuwGBBxSwoRwQbtqfze+xj+Sf7vz/2pIsACorybXVDC6On9/nHptBFjfZro3Qk5nQ6xrn+cXvsrBW3Z0H39LRwFOmZZvb3ua29aZe4gT1IUon9GpXbRWdqT06KbQCcdO5NxSppAvS2CqGrMeFG5D0yAZ0jDWg3NIYsKSyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfWZIYAFevqUIa/VO6zI4ZOVczOd2nqVIht98Iab0fk=;
 b=I7/4ta9HuVdotnfMX07gE/nLnZwbxNSPVTnMVHcaSB+RwE6OXbyN+/zXq6BGJHPIozo64RteuCpjmdM8RJSnKopra48m2McwhZTm9rNBJrD/nXJzx5KqSfezSF2tO2v7LvzduNB8+2P3lfNzSEK8FNq69lNhNB6yIYRUuuThDdIzONwYWlSoP/27A/BuMfSz/U49wvcdTNdLKS62UR/hBZ1hesjKVj7snIBdSY8gVqyAQFK9EnQUxqtbs5OvlVTPXzRhyxywUL4p8maSVk16MLpHjmBWAXjAAxDvxGuzmge+VnEmvr7hK4Oo+nzwkRAB7tHK2d0DoUa/fQhMLBZUcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfWZIYAFevqUIa/VO6zI4ZOVczOd2nqVIht98Iab0fk=;
 b=RSnMI9Br8TQ/ysuTDhYRZFqqYLycexNtwEI6ucet/qm2SlXygMH53VtiifCYbcJWdBYKOJ8ydWkiQ9r3kyrqCyWWJ487qD8wLIlE3vn24hpQD+RZH+0YsEk2yLnIX1O6h+6tNtVwj6B1SJuSMitCo1c2AUZKX0gcLMUf8JbYWPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by MW6PR12MB7070.namprd12.prod.outlook.com (2603:10b6:303:238::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 13:31:28 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 13:31:28 +0000
Message-ID: <c50564da-87c9-47dc-a546-779a6a82928b@amd.com>
Date: Tue, 9 Jan 2024 14:31:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: fpga: Convert bridge binding to yaml
Content-Language: en-US
To: Xu Yilun <yilun.xu@linux.intel.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
 <f3aeff02-2560-46e7-a712-1f8d323f43a4@linaro.org>
 <ZZ0eVZGcYJ0sFxh2@yilunxu-OptiPlex-7050>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <ZZ0eVZGcYJ0sFxh2@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::26) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|MW6PR12MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a00ec0c-544e-445c-09af-08dc111748f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MXPRX0SvZXIeewAqjWkilIXkiIs3+eBpc5/tlrWOEAXrqFgv641Q7th/ElMfCo3Ppe5sKuEehVh9YIwNCKqaHTSfz1/+khUbZgNiet8/7hmgN4w1UvZDVd75/aMU7niTWxY++udApUwpscT+m4cXd3EE9wUxCQPa810SkjC5GbuSfB8U72omTfqTxcnfaJ82fGteqRSqLvhQFf/4QtP6WUc801CSS0nvxLqYph7JW4csB0kHpGPyX8UdxGYLEyIfmpPGgHPPJzzR6CFwjB1VPWqfjrv70kxeT8b80YDSMwhC32ruJVuwbQ2ncSzM1EV+RCIYKtNnse7/1Rr2QJ9y9+brCxu4cOZ02bHrvxOA7pc1cvUViV5UWGidhuXpDmI83t9UuuunPC5aj5I5sbJrG0SdxfB+RJYtfyEC15II15aI0lbBfKgchofrfECifr66qWUUjB8WvM71SfOXNrxhdC0gRUYkX+7OkeNXsKPtTxzTojYm/Xsvafu52kbRMDp9WlvS3ICm0Of6HopbNThNclQfxso41ZJ92wBejv8Fj0LQiPlWz2qHLkCFire7ALWEVI50EC0xF+uEoHEvHCgSYHmh8/QL8squK/awcZccUzpDnxInKN3oL0wjK9TU3WYHndQfqJF3qnaFlXOJDofRxQx1U618BZKNxmX6xagLGCA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(136003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66476007)(66556008)(4326008)(8676002)(8936002)(66946007)(478600001)(26005)(2616005)(83380400001)(31696002)(2906002)(5660300002)(38100700002)(7416002)(41300700001)(31686004)(316002)(86362001)(6666004)(6512007)(6506007)(6486002)(36756003)(110136005)(54906003)(53546011)(44832011)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckdPVWw4SmNVOFNRNU9QRHFRZnhlZ2ZxSWgxZ0ZLZUwxeTZsRCs4djk0UDFQ?=
 =?utf-8?B?cjVxTXNaQ0czM1h2N1NuUFZRMSs5bkJlUElmZXlPT1FmNE1wTUhqbEJyc0FN?=
 =?utf-8?B?KzlHV2l0cHh5eGRVYlJudWgvSGk2NGRZdjdyd0xiWGFJeHRsM25hbUhkVXgw?=
 =?utf-8?B?TEM3WmUvWWVlL1dBUFNYQmdSNElmNWJobHpLY3lGZitQYnk4TGxhVDZ3TVlo?=
 =?utf-8?B?TUxrVitSek9qVW9OZFJVakppZzhiZlZSK1BXbGtEc1o5M254NER2MThpQk1s?=
 =?utf-8?B?K05kRWphc01kQmx0N0RsNXpCczNYek8xeXJaaTJmMFNqWFhRc01kTWxFNWxa?=
 =?utf-8?B?Q01ocTZEQlhuREZab1Z1M09wdm54TWtoSlFRTzlCU1ZRbEluVldLR1I2VjNl?=
 =?utf-8?B?dVdHMUtTT1YwT0JUd3puY3M2OGRkaXd5VnFkKzJjTnIzaEF6cWVIdWlqWEo4?=
 =?utf-8?B?U1FvejlhQmVYa01pS1RBYmtTbzhnMFByb0pxNlpQSG1CMHNXdlVVTldNOEZu?=
 =?utf-8?B?UVNoeWZHd2xsSytwd0h1dlgyS2lCOUhrN3RwaS9PODVrUUdSS2EyMDJlUXZK?=
 =?utf-8?B?aEhkV1NNZVpHOWFQYjZXRUNUN0ZDNG9OdThCSTNlNUs1czhxR0RGK2V2bW5v?=
 =?utf-8?B?WXJ2WEc0VDBOdlcwZkhsa3psejk5cXNzNzIrY3JnQkxMMERPUWNGSHJTL3RM?=
 =?utf-8?B?RUR1TlVSdWljZERURnJ1QVZhMmRJdHl2VnRyVGNpdnBMbDY3aVpwcjZ6ZGh0?=
 =?utf-8?B?bGpYbXU5Y0pVVnZYSXMzdGdFbFZLWlptWkFpbmpVeS90b2xIYkRpOFA5NVpP?=
 =?utf-8?B?L2hGVzd3TkVVVVh3WmlKbi9UcjZQa054NVcyS3lzbE5GcXB4c0djSGQrTjhM?=
 =?utf-8?B?WHcraFJFdmlXQ0FRdjRYR3hPNHhRWVpTSjg2R0RBMEZvQlVTNjZxa2t0U1lH?=
 =?utf-8?B?K05BNzRiV3AyZUgyajFlZ1QwNzZ3TnhUV0pLRXJnMk5qM2psR3l6bE9nNmtw?=
 =?utf-8?B?NnRqWjB2bnkrOFpvYWlQL1Ezb1VKVTdWQjBsanBQUTM4elJaaUNySWwvVk41?=
 =?utf-8?B?U3VFMGNFbFkvL1BuSWdBY01CckhHODRjdGlta2xuVEZpTlBKYjlsQ1RTaHhh?=
 =?utf-8?B?R01FakJBYm1ZS3luOXYyMld6ZS9GU3Q3NDZxTk52YVc4azhNRzNHSER4aDBO?=
 =?utf-8?B?ME90WVVOOXpsUnNON24yMlJWUGxwUm81Mkx0REVTNnc4UUxaTVkrYlVGYTNE?=
 =?utf-8?B?QzU5K3YzQ1V2aE5zOXNxaG9LaVp6ZjlnUi9DbTQvVzhIMDdRMGJTY2xTTXhF?=
 =?utf-8?B?RFRScUcrN2NrOENvQUtYckx2bTA1M2hPekN4REZlOTFOS3dCKzJUQ1dFQlpQ?=
 =?utf-8?B?ZjRJd0lTcDlQaDdBblR6ZWJPUXAvcDV5Zy9lSStEdVUwMzI3REJuU0lNN29D?=
 =?utf-8?B?V0JEVXhrU1RXSUlmb0F2RXBlSXZZRXBpNG5hOEdJb0lKOGJYZnRzQkg5MWNj?=
 =?utf-8?B?WVhSdVFsZWs1TUxSSlpxN2dUNWg3YVFGSERhOUV6U2tCS2N4RWg1c1JDYkJk?=
 =?utf-8?B?dmNhQisxU3cwZ1dtL2ZBSlB0aXl2NUtyMnBySWdKSkhkN0J1aW9RTDk4bGU2?=
 =?utf-8?B?SEZvRWV2VCtWSnZWdVRSTlZadFdDeEtoaWVubUtKelZ3ZlMxeTVucS9QdVNR?=
 =?utf-8?B?MUk0V0F1YTgzaDNiQUhIUTlaaGJjN3ZMOWZYV1I1VlFDTHJwUVRRYUhPNlhk?=
 =?utf-8?B?V1lMNGl2bEZadnZFam04aitPa3lBN3lwamxCeUVxNVkydkNUaXZyZ0ZGSzNP?=
 =?utf-8?B?TXM2b2Q4dHdTSHNNTDZpdmZjSlFnckVXcGNrTkNTbWZWbjh0bGgzd3dteitC?=
 =?utf-8?B?NGxYMjNMQTFGeE13Y2x0UloveUFMdnNXTmFMMG9QWm9TWEZtSnQrMzNqUTYw?=
 =?utf-8?B?eDA0dDk1LzRUNG1JWFE0N1pLdFBVWFdGM2RFQmVpVHpMdVB6V212eG9FWFJ6?=
 =?utf-8?B?L2NIK2FVTUZtYUc4VjV5V0VOQU9EYjBGdUQ2ZTRKQzdyTFZoNVJ1Y1BSU3FQ?=
 =?utf-8?B?K01qR2NXMXQyVC94REUwZzBsSWNRMTRKWGkzSEZOL3dMRHViVmRRUGRENHZ5?=
 =?utf-8?Q?QwWbg3EN+TCUV/sCPUOc05icD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a00ec0c-544e-445c-09af-08dc111748f9
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 13:31:28.7420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dvMuVLB6eFAEKqQxzBodVn8aLIO6HPHBWmGDA7LA6iY2f3lai6aEmxbtVeEZGDuU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7070



On 1/9/24 11:22, Xu Yilun wrote:
> On Tue, Jan 09, 2024 at 09:16:33AM +0100, Krzysztof Kozlowski wrote:
>> On 09/01/2024 09:15, Krzysztof Kozlowski wrote:
>>>>>>>>> +properties:
>>>>>>>>> +  $nodename:
>>>>>>>>> +    pattern: "^fpga-bridge(@.*)?$"
>>>>>>>>
>>>>>>>> Not sure, but maybe we need to allow fpga-bridge-1? Could we have more
>>>>>>>> than one bridge on given system?
>>>>>>>
>>>>>>> Yilun: Any comment on this?
>>>>>>
>>>>>> We can have more bridges, but IIUC people use fpga-bridge@0, fpga-bridge@0
>>>>>> to identify them. So the expression is OK to me.
>>>>>
>>>>> So you claim unit address thus reg with some sort of bus address is a
>>>>> requirement? Then "?" is not correct in that pattern.
>>>>
>>>> I expect it is about that people are using fpga-bridge@0 but bridge is not on
>>>> the bus. Yilun said that reg property in altr,socfpga-fpga2sdram-bridge.yaml is
>>>> optional which means no reg property no @XXX in node name.
>>>> That's why I think that expression is correct. If there are more bridges without
>>>> reg property then I expect we need to get more examples to align expression.
>>>
>>> If we allow node name without unit address, thus not being part of any
> 
> This is valid usecase.
> 
>>> bus, then the only question is whether it is possible to have system
>>> with more than two FPGA bridges. If the answer is "yes", which I think
> 
> The answer is yes.
> 
>>> is the case, then the pattern should already allow it:
>>>
>>> (@[0-9a-f]+|-[0-9]+)?
>>
>> Or better go with what I used recently for narrowed choices:
>>
>> (@.*|-([0-9]|[1-9][0-9]+))?
> 
> It is good to me.
> 
> I actually didn't know much about DTS & its Schema, thanks for all your
> input.

Ok. Will send v3 with it.

Thanks,
Michal

