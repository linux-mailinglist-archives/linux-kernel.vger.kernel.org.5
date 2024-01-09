Return-Path: <linux-kernel+bounces-20519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A016E828013
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79E41C23CFB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CD411CAF;
	Tue,  9 Jan 2024 08:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sKBSw3d+"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1CEC127;
	Tue,  9 Jan 2024 08:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRUClQiaoBgYSV7a4EL9/7ztR7J1RN4G8PgNNxyuXqULHVPITMYhUeL0uMeVkIGofm4Bal1tZqUl/EnJsD1zcdNgtQeI+cGuZ14GZJr66QmI7kbITWF/deec639eg+36XAvQ+Y9owRcNVNRvz8HN890OuAJ2fJ5PQRP8d8JENkcw5MfX+s8h9uQx5ImyxWEuB2sbXLIbQOI7UJpXpfoHHoTqimwgAGJzWWtaLqoVOnvnna1X0/Q25u9UHeVn0e/2bsKSSe0gJlGmVwsLHY5Orn6bBnaQ/aLS6AjFMxOm8TjjxXAU8+p5F+BggFqLw+3KDtKVdF+oIRkBtAvZc58H5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlBCyzYxIYNhXT9uDa8Lx2eiDMCygQsL7GX3/xMAJls=;
 b=GB4nCtqQ/C+AzsiCG5807pwSX2vMuNg7zlZ0/Cx8/y5Tza3dhw30YDdVPG3MSCDt7bsKkgVl3HtF95xniyo1GMwKdmB+2qvJ4joyt7LF8He6Ii4aeH52+RbfQLeAnlZRljFerSPWcvxAt+jyuZJy+Yjd4B/qkCMVEUBW0U/x8k0XJruf4wkRLBpSj5PcbXwyCUjbnX/LbQ28pGcWmtsH1+qJe+YNrq7shv1KICKViJkFHVx/pvbyXvOya42cPHt2oQ+Dfi+7yq/fl0CcfnUcV4p2ZFooWRoI5H2cFWtvabSbNLe8kn+r+/TyvCNJhgQNRGH27jrgiD+UzIHQKN6Yjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlBCyzYxIYNhXT9uDa8Lx2eiDMCygQsL7GX3/xMAJls=;
 b=sKBSw3d+bQvWxuu7bBQbECQD0e0upq9DJR+CxrD8uSYzbBEHPVr132EhSEtKOezy0RHXLN+sbftKSy7ZDgIFzSrzGb+4Zu/Ung1n6ipccebCmRxmGRyfaBfq3hqc4vkzv4LFAGhH9I5GrR7//AYRW2oJ3ohYvcQWxffCnmF3CdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by CH2PR12MB4876.namprd12.prod.outlook.com (2603:10b6:610:67::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 08:07:13 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 08:07:13 +0000
Message-ID: <3bfaab38-6831-41f8-8a7b-9f1f434e0f9c@amd.com>
Date: Tue, 9 Jan 2024 09:06:52 +0100
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
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <bd356c60-7681-47e4-b45f-d25e70068b65@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0026.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::39) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|CH2PR12MB4876:EE_
X-MS-Office365-Filtering-Correlation-Id: bce2a43d-d34a-42df-d3c2-08dc10e9fc8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iRDqx0XtlicHKyCiV8XFDxd0vECozGmCI1EOFn5ieYGgL605GAio7hshOXGqr/84kT41g7VjF2S65rjt9Z2SE8Kbhy4toTPE/OyjKtnVc5AN6jKCw6zkyu60rv8tfIqEIAI9fnVWto7yFbTdfUKC6PhBblGO4wihQCyHIj2pfhsb96TsJl+NvMqy4HsQuGgH1PVXwO6uk2QpCkt+WnuNC9Dsil4JtoftUwMOCGZ4KqOn4MoG1m/do7LzgtOLpnRm/PXMm+CZcQ79CE5F1H93qbhBguisIF4JiMZ/PsILIeJEolHz0xhH1TLvy6bVOBSZzUS38V8gwyktiOM3PrKAlqnh5Rg8UIhAeeAMfRz5DXqXtS6je2uMJjz2+mQS77IcgPMqbKnpcMQwOvRzGoS6ityix/7D51TUlM+m73AlsGIaNsy+W/v/kWWYw3f8z4KjaLK1MbXkQcS8KOzORfL/NxvAyvuYmi9LfcoGFV8lSKIqrWU3Q/Ry+M3FCVdBS+ehmaaLYtix5MZ9IBNuiS4pE4PbssfSLXk93Akd3Gb5HLymZlEfXtD9lR+Xv2rdAvHahmM7uDqnDJoPgP4ZgvPx08HFeOwGNPD33V7MUHKmSimBD9k/jMlpsMdNrZ17qhYj8HOGU5LgoqLsV2k5GxurTBSPGWUnR33Ki0EDFHRV6lEvx71WSxv7jQz3ryELGmVTVIKkBhPX/vzBALHilZa+hQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(38100700002)(2906002)(7416002)(5660300002)(86362001)(41300700001)(31696002)(54906003)(31686004)(316002)(110136005)(8676002)(36756003)(8936002)(6512007)(2616005)(6486002)(66556008)(66476007)(66946007)(478600001)(966005)(26005)(6506007)(6666004)(53546011)(44832011)(4326008)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXFrS3ZKUmVOVHhLNHhzWnJjaTVDN1JqUWN1OTBMS0ZKRGRRY2tLdkFpazc2?=
 =?utf-8?B?VWxLdDh6ZGVTVXE4cFc0L3RBNEdrcjU1MEhiS1NlWExQMWdJNXNiVTNDTXd4?=
 =?utf-8?B?Z3JaZHBkN0lObFI0UmxqNXRoUFBkVnhwUUZ4SVI2SGJyblNJZTFTWkRFSnBD?=
 =?utf-8?B?dHBVeFVHQlNnekZDaHV5dWFnVDdPQWtFNHJOMEZ3SjJ1SnE2bEF4TWdnRms2?=
 =?utf-8?B?b3puK0ZhT3lQallRUVVZWk9jb0RZOTZWdjNqbGR4K3hLdVVPaDBvREl4VGVW?=
 =?utf-8?B?TGV4dFg5Wmk4THowRVZabVFMRHAwc1NjWGFwYldzd05EUUZmMU1xWDJmNnNm?=
 =?utf-8?B?UDZlN3JBNS9aMURqeXNhcCt4NXdIbzJ4dDRPQmQ4blFqaUpWTVF3Y2hKRSt6?=
 =?utf-8?B?anovUnlqVTVPQUlNZkNNWGwzQmFia1JLUU45WTBTakIwYkpXcXNoVDc0V3ZI?=
 =?utf-8?B?LzdmOSs2TnpNWE1WaWhhRFpHTlpvV2JRcHpMckVyOXVpL08rQWFiS2ZJUE5l?=
 =?utf-8?B?K3hTUmlHdlRzWHZlRHJBREFTVVdWNlk2OUpCOTNLM1pMYWR6Q2VJakpOQ1ZB?=
 =?utf-8?B?cXBiMzdDQ09kWGkwd29EL1Fpc043dGhoeXpRY0kwS2VCMktCVnJxZ1FacExD?=
 =?utf-8?B?YnRnRlcrVDdKcDMwTG5TNjJ4OHN1elBKZXJYeU5QTlhzUG50TVZCSS9WNFZM?=
 =?utf-8?B?MVloOUxEakJKWUM2aVFWL2hmTGRCNUdoWUZDZVE2Y2Npbk02c1g4eGZFd3Fw?=
 =?utf-8?B?VGxJaEQ4L24rV2tJYjN0QklrU2R4QjlDZ2NaWnp5Y3VDMWlzU1lUa3FEVkFY?=
 =?utf-8?B?b2RVdmxIL0FKb0x3WU5WNVZNMUVJc0VMOVkxVm1kbG9HZmFNd3BiVmFMWjdZ?=
 =?utf-8?B?elkwUjFlSklmcUtSMGl1VU5hK2pxYzIyKzNKYzl1QkZ5bGM3cVhrd3d6WE5Q?=
 =?utf-8?B?S2tLWUNENGVlZGRnUjNPR2VZT3VmbFN2ZkpTUEVUdHh6MjRuSzVFSjY0dUxi?=
 =?utf-8?B?UXlNZUR1bUZNQzQ4L091S2xOTWlLNEFBdDk3OFBvWURRQUJ6UDlkMzZQMTAw?=
 =?utf-8?B?VXFJa0RsaG1JYy9YanFMRTBjendUaG9ZSnBHUnpZYUtPOGRXYXJ1a2prd2RZ?=
 =?utf-8?B?eU1PVXhRcUdRamUzT3pZMSszcTZ6T1JMR1dRcUIxempSc0pVdUZ6ek5SdDlP?=
 =?utf-8?B?R1hsTUxLMEh5bUFzZEw5MmNWNTNGOUQreHp5ZDBGS296QldSNFpPbHhvMWFr?=
 =?utf-8?B?TU83ZzJsdXBwVVY3MWV2ZXYyU1cxaWRISndYYW1tMlBrem11VGsrcVFOeGQ0?=
 =?utf-8?B?d1VSVndHM0dnUXZuS0o1Ri85bGJ1ZTdMWHV3YzhpdUNxK21pV2hFbkt3SjVB?=
 =?utf-8?B?c1NxTm9HN1pTSUhKaFo5WGQ0bFlrY1AxcGhPbUZla0JlU3UzMGZLbm5JRlMz?=
 =?utf-8?B?cFpRbktHQy9BT05UeC9rYTA5MU9sRVBUS2hUeFdNN1BVYnNLOUhxNmJsYnlx?=
 =?utf-8?B?OXVxVWlFOHdDU2ZMOFlhZk9TSFJmTXlsbVlNcUQwZnBWNXZXejNTNGY1MUtx?=
 =?utf-8?B?c0tSckZnMTg4ZnVxbTEvZ2JNZHFwWE9XVE5seGR2WmxqMjc0Mnl1eCttQlJF?=
 =?utf-8?B?aW1tN1Mya1FqcFlTYVo5NlBsRzdTTy9Xa05CVzFVbU5zTEFwanZWYTAra250?=
 =?utf-8?B?akZ5L1lHc3RrbmtmVSs0aUlCc2Vob201ejd4WFhZWHNtakJaSXhiTHRrTzU5?=
 =?utf-8?B?NC9pTHl1a09EaHZ1d0h4TmQrNnc0K0VZMmxaQ2FzeW1yZnJVa01XK04wcHRZ?=
 =?utf-8?B?T0lvNFRJRzFsL0k0M1hZTVk5YnFEN1FTZGZmVTJJUCtESjNmdXBBNmFmdzdO?=
 =?utf-8?B?d3d5ek1OaFNQUCtDbTdFdE5nTkVDck1BWGgwWHhFMnAvNXlrdEx5UDV1RVRm?=
 =?utf-8?B?MXg0eWJvQzVOR0VBLzRWdGU3NkEweE9XN2pTcER2Q0JadWI3SGlUOHZvK3RU?=
 =?utf-8?B?YVJpS2RFbXhRQkRhbmpNZFkzNVY3bFpLRjBTRmxCeGh2Vi9MUGhicVd6S28y?=
 =?utf-8?B?MlMvOTJwQmNwZ24vTkFYMEFpT0VGRnJxWURPNHhTQ2huN3ZIcjVIcmpZaXZG?=
 =?utf-8?Q?nmjzNplKV8PUgVEMbxbuoVo/w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce2a43d-d34a-42df-d3c2-08dc10e9fc8b
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 08:07:13.2700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WGrOW0bVBmUHIoN3aJKvXwm8K+ziXdqS8i1z58khe3N8Wg0MFDJfrZc5qPYjYnrs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4876



On 1/9/24 09:00, Krzysztof Kozlowski wrote:
> On 09/01/2024 04:53, Xu Yilun wrote:
>> On Mon, Jan 08, 2024 at 10:16:17AM +0100, Michal Simek wrote:
>>>
>>>
>>> On 1/8/24 10:09, Krzysztof Kozlowski wrote:
>>>> On 05/01/2024 17:04, Michal Simek wrote:
>>>>> Convert the generic fpga bridge DT binding to json-schema.
>>>>>
>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>
>>>>> +$id: http://devicetree.org/schemas/fpga/fpga-bridge.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: FPGA Bridge
>>>>> +
>>>>> +maintainers:
>>>>> +  - Michal Simek <michal.simek@amd.com>
>>>>> +
>>>>> +properties:
>>>>> +  $nodename:
>>>>> +    pattern: "^fpga-bridge(@.*)?$"
>>>>
>>>> Not sure, but maybe we need to allow fpga-bridge-1? Could we have more
>>>> than one bridge on given system?
>>>
>>> Yilun: Any comment on this?
>>
>> We can have more bridges, but IIUC people use fpga-bridge@0, fpga-bridge@0
>> to identify them. So the expression is OK to me.
> 
> So you claim unit address thus reg with some sort of bus address is a
> requirement? Then "?" is not correct in that pattern.

I expect it is about that people are using fpga-bridge@0 but bridge is not on 
the bus. Yilun said that reg property in altr,socfpga-fpga2sdram-bridge.yaml is 
optional which means no reg property no @XXX in node name.
That's why I think that expression is correct. If there are more bridges without 
reg property then I expect we need to get more examples to align expression.

Thanks,
Michal

