Return-Path: <linux-kernel+bounces-28645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043BB830147
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58E64B24A52
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C8F1170D;
	Wed, 17 Jan 2024 08:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jz25DrTf"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2025C1118C;
	Wed, 17 Jan 2024 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705480060; cv=fail; b=YzXWMVvgg1cEIyBFGfSHXw9OL8iMY8om1UpvXwH0zmUrbtCciJufAjcx1grKp1ZUQFn7ZQ8ypkDl3Wk79gZb4qh4zIoPooWaNh3M1hYfKWYreRH2/bfiOfEqwIQncxS/6UqgbtvNhilLL9sg+gq1RO1wmOlRF/6AFXEJpGf6GCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705480060; c=relaxed/simple;
	bh=J/isrpyhjq3jan6pixd5Jd9GPnMzGtBN4/IkvCZRJR8=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=UfRt1JMSyJ19obUaVqWXFQWzv/blg2pfdHV7Kd+tduzkc3cxPvwrZ8ZUHQiLvP0P04cOTSxNgn/pI0Nz1yHt4nubwW8iDLSdNFhHx63I6olivNoHLKrO7vLXCH7QMMdI1Le4gZHOb4R7adu6bjgHrxp1eaC8xOIuaIkvfoH5ycM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jz25DrTf; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xn0Jr+uCQ+K6rro3fG60DYdq11fLoFmzkY/21pZoKEyKvui/zMNbQpHH0JoyMXcwpe+pICW7tTA0rJyuUZCphe0bQXXieXFXUjEJZm637WoyZYyHxrxSW3LMLY5aBfl6I9zO/VIDkiiR/s4JVUeHDiBUB02v+U7IcsJDk1QPtqLVwdVlLdaXpMva0A9UFdW4WHM7YEM3ln6xpi3So3Cv/46sdiE0A59BS976gy/a2AClEk293XGDZjL2b1CQf52OUmX8pyl/WoQoRr5SPu3Ffx0l81g5K0V9QgUn+LJCmMrLevDI3K8srQQMTWymJz62S7rBvQCB1a/ocCF+4aUaXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHlpGJLSLbDlheJY81dPW2VwiTme+EdXM+PO9HUxkSQ=;
 b=GQsKhTNl20XHgDU06VS89xg8APvNWGc8z8/DnjQQlVnMjpt4AZMTz+AnwpNJbG2rE+/4glvTZvzWN90A+Pr/wIrbscCom4rozFAgSb76ORIWGRbnY8R6AKBQeia1eMGeAkOYJc6SshldUd+zPRuaNiOsRjNOhVFQKUBWLF/8FKfa8TIV37zqIIkB72zGlhzfBdunGvY5fOI0qnDVKrP8E34Fm+AuQyHn1vcZ50ONeBYF0g81nsZ298WvsAqKkrL4+C07qnnTNE/M9vuxeeFCHs1iXP1ZEmANq+/Sy43aizHqAgStR9cb6eAz1DGRq4n4+xHmzIiHTgG+xjSwXf/hPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHlpGJLSLbDlheJY81dPW2VwiTme+EdXM+PO9HUxkSQ=;
 b=jz25DrTfr1PtnWpRkLORO/LZ9bT0095Xv0VYIuH5+c1cD20Otvw/0zH9yZCrT9es5lBp521d6zYMuAfXrQehxKLj6H4KUOe7ZugF7Ur2wXV5EKgITbzXvyLHjVhDW8pysdyUf1sDkzAEBuLhuucS7EYlOooOfwPucp7gUElDYN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 08:27:36 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7181.018; Wed, 17 Jan 2024
 08:27:36 +0000
Message-ID: <418418af-64db-445e-8f73-3085b1846722@amd.com>
Date: Wed, 17 Jan 2024 09:27:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: fpga: Convert fpga-region binding to yaml
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>
References: <2a48c720bf0efce77d68a0bef10b47671b35506b.1705413862.git.michal.simek@amd.com>
 <3aef2fc5-f213-42e0-9b72-619364ef6c76@linaro.org>
 <66fbb19e-72cc-4fb9-9069-abc351b1525a@amd.com>
 <b2dd8bcd-1e23-4b68-b7b7-c01b034fc1fe@linaro.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <b2dd8bcd-1e23-4b68-b7b7-c01b034fc1fe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0114.eurprd04.prod.outlook.com
 (2603:10a6:803:64::49) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|SJ0PR12MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: 01761adb-e245-4590-2007-08dc173628dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ce+fZ6lUcDKVRIK6RDTYfFI2jDDVaOYU9pQxt9DSIgVon9+xZ70T29/BX9ok14zp9GvIfvKR8yGRQeGI75KdWdQYQtsSp2xhZtcWH3yg+nhq3hmBb/Se+YyYnhAfWX/l8kk2fJMTqFbWtB1JESCDokx9L4gpJ4QDRiQu+4iPzb7FfdfzigSgJtmVSaSzqf1ChdfDw+XOg+bg6vmuf33MYjOxLRdVu73p1WAsya66pH6ts5i3Fa7E7aJsGB61F/deJjiDoCFqT5WlqeTMmHw4FoUaI4U+okZcePEA3mvLtS0gO6HZwR5rbL3hs6KfAUj02lMcvb6KVinmYM3rnkuqSaVigo3kalWEqgbBVRv8ipcFKQtAVF+tubTv7TRd6yqJ4UIgQq3UOTNNmm1ek6ZPb5CrAdhaX65YiFnKcE4gH50eykMMrKNn83c27MfRcw2vKbuyv265slK8OGoFtTivjGBJjR4Zl9fjstBXO/sn7+KU3UOOEvk6+muJAMUDy60tDKKp8LJ7EXQSVgWkrWWobyx9kat0Qf+rT8D2hFuQlhEOlViLrsHrhQLybeiZfNJfiXtgb7RYLvmcRHkM7fpu+ou/mv0eTU6y+1w2C6z5shyTDB3viibdEU2MX2ru3MI8q/tM6MSn3g2+1BrXVaKwuA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8676002)(4326008)(8936002)(5660300002)(7416002)(54906003)(66946007)(66556008)(66476007)(316002)(2906002)(2616005)(26005)(36756003)(86362001)(31696002)(44832011)(6486002)(31686004)(53546011)(6506007)(6512007)(478600001)(6666004)(41300700001)(38100700002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVNZRXhQYzFTUnZ2dXVlbXhGL3N0WFdVbmpCNm5temZQNVhJRXZyZWxBUnFH?=
 =?utf-8?B?aU9sRlVwdys3blV4M25sS3pQOHJoQlMxeWtpS0RPQWNrZ1BCTUNNWGZWbDdL?=
 =?utf-8?B?SEZYcjhSMHdleHNVOXR2UVRtNzArbEcxZ2ZNYnpsbDI3Q0lYSjdEQlBLT2pj?=
 =?utf-8?B?bURyaU9JckN1ZzliczNJUy9Md2ZTMWtnU2tTWDFNOFZvOU5Hc05DUXNCdUx5?=
 =?utf-8?B?RVVoU2ZCK3RuZS90OVByMkw0MVBjcHVYQ2Z2QVdmV0NGcGc0VUVwRGhWZWI3?=
 =?utf-8?B?TkNoU1ZQZ3FRekJSR3BnejRmNUI3M2ZZdHl0TWNONXE1Sko4OXlyemRWS3dY?=
 =?utf-8?B?NkxHYmNGd1ozMk1ZY2FSTTd5RmRjaDRPeVhXT1FpYmxEb3BRVXpNcHg2TUVo?=
 =?utf-8?B?MjhYVkhIYVhFT3JZeGFTaFNaeTk0Z1RXTXpaY3JwRWdjcWxaZDJQbjB6QlYr?=
 =?utf-8?B?SXo1K3RqWHZGWC8zc25YZUJla2Q3akdPWFdwdytBdGFYVmJEOGs0bmF2cDRh?=
 =?utf-8?B?WTFVTFlUaDdmbDNkME51bkU1Nng2Mk9KNC85T2NhdEZDWkN0MXNTNy8wYVdK?=
 =?utf-8?B?NG5Wb1BpMVhrVHMwRmNYTUNHcHRpMWpiQ2dWb04xQnVjU2xreWVQODVhVmM2?=
 =?utf-8?B?bjFydC9waC9TeXFpV1ZrUllvbW5FVWlNZHpnSHZTVWxjRW5hNFd0Y0E0SDhp?=
 =?utf-8?B?aWtRZ0tzSXNvS0gxbnNobWppRTU2SXlsNW5PRUdlRnZKR2N0NGF2QnB6SHQv?=
 =?utf-8?B?bFVBbkQvMzQ1TjBNczJpZkIyWlJrQTB4ZHF5dkxESVlxT3BzRXU2UW5UTHlp?=
 =?utf-8?B?ekhwa0JRc201RFErZTVLNURTNWVjdnErU3FpdnVoemNWY1pLRm9vUXIvdlZx?=
 =?utf-8?B?NE94QkR1ZENHVDd2bG1ZRzVXd1htWmc4SVFUdGdBV1FUcGhXK2pxRi9vbjUw?=
 =?utf-8?B?MVhFNEFTWXVqVzVqNXVpRGpDRjZZMXJOWVNFL3lEV3AwMVJUZzRqQVZxc0Uw?=
 =?utf-8?B?SjJ1dkZQcmd4aTU2TlZvbjFTVDh5S0ZQQURuQ3drTy82Ylg4VXR2THlRT3kw?=
 =?utf-8?B?Z2Y3U1pQTHJsUDBDN0R0aG1xTiszRWJzNVBRWVlSc254ZTZmVWZCemw5bnFK?=
 =?utf-8?B?eUM5VjlyUkpwNnpuMS9zOVhDNlZMNDZwekYydHU4dzQ0MmpjcG5uc09kQnk3?=
 =?utf-8?B?OTNONmVBUnNNQlpzeVI2ekJaZWJ6S3NiSnpDMWRRRVlyRERYZ3d3ZnBleFp0?=
 =?utf-8?B?T2YvaHlSa2tFZzVTd0JncWJ1d3VDdzRFVUdlcWpsT2N1dzMxb3k5a3FBM0JW?=
 =?utf-8?B?RzliSDZrZitCbEJSd1M4bEpXSUpJUzJsL3BYWnhqZVRRSTNrSmpGZDRxeklQ?=
 =?utf-8?B?TzZYSlVBRkh3cTJocjFpUVRHaUJrYzlFOTYyV3dKaTFLeXFIQ3NaOTZLZFJR?=
 =?utf-8?B?ZDFGMk9EY04xVUt3SE9lNFZPWW5zQ1hTTStNQmVSZTcyRkRib1NESVF2ZFdo?=
 =?utf-8?B?WWJuQms0RlFMUmxWcGUxTEtkUDZUeTVFQi9XY3JnUURyaXZsckYvR3l2bDNy?=
 =?utf-8?B?SEJ0MEE5eDc4WUNTc3Z3NCtCcG9ZeUs1czhTMnNSRTNlY3R0R3JObERZVmRJ?=
 =?utf-8?B?NDZYeEFiVkRsaVJNTDFYQWJOYUsxV3VmQmpDS0hBNHZwQUI3eGQrWWQ0c094?=
 =?utf-8?B?K2lUUG1ManBiend2RUo2ejVTL3FaMW5FSkdCYnBjWDhvTDd5ZUt0dENwOVF0?=
 =?utf-8?B?eko0d2ZBcUpvZTJhK0dMNzVISHprK0RpYmNMamhuUDMwVXMrUXRMd080RCtp?=
 =?utf-8?B?SGcra0NpbG9sdnJqV05lY2kzQmlmRGVKOC9hVU9IdzlCOHRERVZ6VEJvNFQr?=
 =?utf-8?B?Tkc0bXgvc1F3c3RLdDFDRG01VEU3K01zeTgzcktXR0dYaXdFdXV4NURNRHhN?=
 =?utf-8?B?c0M3a1llbm1MMm8wMzlHYXdhZDZTRkt6aWp6WkNXeUxRNjBLTUVTbnc4OThy?=
 =?utf-8?B?SkRKWkxaeHhlckVaSmV0YldKQndBTjdVbXB2MlJLYnVROWZBaEVGcEFwVEw4?=
 =?utf-8?B?KzQwaFJWbzRpdlI2d1JBTUZ1L3Zhbm9zQ2dVcTNHZC9IOVMrN0l0NUEwSjZL?=
 =?utf-8?Q?u4JQuhIr/NE8Gcj4JBbXmNGo5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01761adb-e245-4590-2007-08dc173628dd
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 08:27:36.3343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NUNjNl+txfYy4W3FnH9x8FhcRjEqrI6sCearGr2duM9o0Uwt2y03o4QULqG+wQhD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6903



On 1/17/24 09:14, Krzysztof Kozlowski wrote:
> On 17/01/2024 09:07, Michal Simek wrote:
>>>> +patternProperties:
>>>> +  "@(0|[1-9a-f][0-9a-f]*)$":
>>>> +    type: object
>>>
>>> You put (0|[...) to disallow @0001? I personally would not care, dtc
>>> handles this, and the pattern is confusing. Just @[0-9a-z]+$
>>
>> This is actually taken from dtschema/schemas/simple-bus.yaml to allow all nodes
>> with regs.
>>
>>>
>>>> +
>>>> +  "^[^@]+$": true
>>>
>>> I dislike it. How is this binding supposed to be used? If in standalone
>>> way, then you allow any property so what's the point of this schema? If
>>> fpga-bridge.yaml is referenced by other device-specific binding, then
>>> all properties will be evaluated here, so the same: you allow any property.
>>>
>>> Depending on the usage, this might be just like other generic, common
>>> schemas, so end with "additionalPropeties: true".
>>
>> ok. I am fine with it.
> 
> But please verify my idea. If it is used standalone, then you should
> drop both above patterns + additionalProps:false. If it is used as
> generic schema referenced by something, then you could keep one pattern
> for object, but actually it is redundant, so I propose to drop them and
> additionalProps:true.

additionalProperties: true works for me.

I was looking at how to describe cases where you have normal MMIO IP or also 
things like fixed-factor-clock without reg property. That's why I looked at 
simple-bus schema and took patterns from it.
Not sure if there can be something else out of that patterns but if you fine 
with just permitting everything that's perfectly fine for me.

Thanks,
Michal

