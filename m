Return-Path: <linux-kernel+bounces-6559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBD1819A56
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA724286367
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D1B1A5B3;
	Wed, 20 Dec 2023 08:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="04XLp17U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCD31CA9A;
	Wed, 20 Dec 2023 08:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePZCM7XRhIuNGV4vK0fj/mfNfAMTLdkIwNkFRBbMAgwzl6Pel9eRQDEkhrvFBay/aNtsqZeWCV4CLV/eMFN3XdLrku3q/s9AZwiCVP3Ln0SRKCnIwDYDwTdud0+OW1AAae7vCNpHQzUUKhD7o1v/WszWFqGjD/pIiVZxG2NO/J9i4RiFxyYsDJHVWb8eb9U6bXp/axyYG5x0vpAqYxe2pPsQRFVMxkDQ4ERXl82/S+1VXBTTYCRh922W8RqTortUY+cT7DV/n7+iHm7uj5c7cymV7Nn9UtNdw938c8pXiLmrHn0O+fYWYCIL7/dhjpvi24BlmkBqDShh+kaxVwtl6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuXv/VygaqspcGOlVZyu2xp8S2uotHFW9mKIYRVo5pE=;
 b=dQxEFudm3AlxB3vlKCDFYe0K0NuaMfUWghT4pocXbz/+AGTNNHsWQXZSalj12ae/X7H54I7KdEd4WV1xhNdfCiV+TH2R8pfDA1x05VLzHnRrkMWz7cPWEV6ufuy4c8q0XrH1qJnsHWzTkGVOwx0U/D5dWs5dXpE+7OTBkp8HiOMOwIJbhrYoMFhlaqDNWaT0UnNLDHp2LLHBs1SHq5vCYlWOHM8utUdHnYGq698SOMOJm2BwNZsxNZy2BNCSukP3If8Q+GNliERgW4RDKeR+1VVtLqotbgvAjr0QqbWo9xzofXu1KxJq58kW2PM3BbYjACKpHV3J6UI7W5scWyIYDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuXv/VygaqspcGOlVZyu2xp8S2uotHFW9mKIYRVo5pE=;
 b=04XLp17UBKsLoDEwpcqajMGZEbOlsKpNhOupAzljz6QhKLej5ZbxxvwtXdDQeP1GtKfm2w2tuFEVOgZBpPtZCyJahbpeALboGrGc/WQk4KWkUOVzwN0tRRYTP7os4rMG0eKsFdnwk5o6wP9ELlblLqamdBlZ2+Qr5+7iYLKe12w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by LV3PR12MB9410.namprd12.prod.outlook.com (2603:10b6:408:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 08:20:36 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 08:20:36 +0000
Message-ID: <70774949-7309-4a84-a224-13cceccbb3f3@amd.com>
Date: Wed, 20 Dec 2023 09:20:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: firmware: xilinx: Describe missing child
 nodes
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com
Cc: Conor Dooley <conor+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>,
 Rob Herring <robh+dt@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, devicetree@vger.kernel.org,
 kishore Manne <nava.kishore.manne@amd.com>,
 linux-arm-kernel@lists.infradead.org
References: <5bb16305a05692de29ee2aa2accc793e23b68dec.1702997680.git.michal.simek@amd.com>
 <fc7863a2-d3c5-47c8-9484-ef9cd6d7dd5d@linaro.org>
 <bcc3a802-70cd-425e-bb33-3ced81c038fd@amd.com>
 <5be15b6f-ac6e-4cab-bd83-ef3fa50e1886@linaro.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <5be15b6f-ac6e-4cab-bd83-ef3fa50e1886@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0019.eurprd05.prod.outlook.com
 (2603:10a6:803:1::32) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|LV3PR12MB9410:EE_
X-MS-Office365-Filtering-Correlation-Id: a5479d54-66a2-4d6a-46ab-08dc01348a9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EIUm1lYMc05LnPtRqZidt5wLWylekjJCO3FMYC9rSmuGpd9GL0Lssl4+7yhQq8WQtnlpbtEDP1F21cwQIB8nWAXYoIq82hj3PHAuvat9/i27Lk5aO0Ky2ibcA+Jp0LYek1Rj/9Md6GYbQM7MvnX6OtxV2wzlP95bbad/xj6/LUU/OGKnrIR051JCI7Ug1HstpH7Du1xRI+TUW2bPlt0ToRrsl9NqQqpfACJkHDOS+zPmMpJATfu0cIDkXdhll2JPQ10X34OoCacJc/URPSA1KCLngNqOcbAw1b4zzicAECLU6aNyE32vwJEolKiMVtKrRWSUJJHBbpwE6JbVoIYBGUbK7HfgRhVxRB+k6igA7FEVSOnKMcPUP5kCQiel4VUH75GQuI0NE94cLNvCEDyxSYRVJ+6SlvpEZKY12GH2AktBp6yanVE71QJtswMvy9OME7SFwS2PDxzyWbNBSf8aC/aFIZkvvW6REMq14foGMQGZ3/JS2swpi3uEQjR6kOsVM0HbCY4dR1AHxwixhHxrGqOv7cIEHaK7qLwqxifyeJE0X7VHCffsmQeSc0A2J6yGpqEfLtZAYTowugiwzFaApRYjLewKH+9gHR4Ko8QrNOtIl5J2IyK0v0ukhY8PNfOKlb+MA/PJ9022fOpbgJVhrA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(31686004)(2616005)(6512007)(53546011)(6666004)(26005)(6506007)(83380400001)(38100700002)(2906002)(36756003)(86362001)(31696002)(478600001)(41300700001)(8936002)(4326008)(8676002)(7416002)(5660300002)(66556008)(44832011)(54906003)(6486002)(66476007)(66946007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDNYQkpnSnpZZXZQZktlY1NzWmJLOGE0bWhGSmt1NVF1WHZmWHBlK3VwS3Nk?=
 =?utf-8?B?SXdGWjZLMEtKNTU1L1poRURXbUc4MUlXTmw1UWNnVTdpbWZHcWk5UDgzK0I0?=
 =?utf-8?B?QnIySk5DaENuNGlRTldQWjMrWGI0OER1ZlRhR0hBazE5YzY4cEljWVZXK3Vh?=
 =?utf-8?B?Zmh0SG94TUlqWUE0cUdDK05kaUpLSEthTFRCZ1RrcElIY0pSU0Y3by9rZHVR?=
 =?utf-8?B?TXExL1JkMmgrRjEwV2pqaC81Y1NmTmJVbGxRRzBnWnFMU0ZWUFhMdEw0Ung5?=
 =?utf-8?B?SWRaYUFVL1pFWnFzWHNiMmJ1bXhWekFGZlNOU1h1UlZEajhzNnB4aVBtM252?=
 =?utf-8?B?NXFEYUhEL3Bxek5vdFlCOE9uemg2OVdFVWhIbVg4S0w2cTNuS3lVRHY3ZzBT?=
 =?utf-8?B?MTN0Ym5wbnRzSm93aHlEMWQxdGlrUFVVRUNuOFpwNG9QRkFpVnJvSWVuZE9a?=
 =?utf-8?B?ZHUvRy8wbzNwSDdCZ1NwRGxQalRHcDhIY1VkTkZ5akdDY1lDbDhsemlOOUdV?=
 =?utf-8?B?RDRlTndsUnFXQ1NvRDFNblNQa0VodXRFcTlQZmRaazhvMExtdmJnTFc1ZlQ1?=
 =?utf-8?B?bEI3a2tLbTBSbXdXSWorNlovVVM0cElSV1NINGF1SWN3bzVnczRhTE9qTml5?=
 =?utf-8?B?cE82a25HV0xRY3BIQVdKTmdKZnQ4Y2YyVjBoeWN3RERjSzJxMThyTHovRlNS?=
 =?utf-8?B?Yy9yTzF0MjNvYURDWWo2dmRrTEU2T1dzY0NNSHhGM0tnQU9rY2lUS2d5YXN5?=
 =?utf-8?B?VUptZlNIR2s5SE1rRnd0RkI0U0N2bjExdE1INGdSbm5ic1NVSXptYUhCMkxl?=
 =?utf-8?B?Zm92Y1VWRFpBVXpHSEVvaXp4SVdUZ1RzNkNSQng4anczcGt1Z3hxYzhJYS8w?=
 =?utf-8?B?YVBMakptd3drMDM1ZGJ6MFBqNEZDenZKK3NBQjBIRC8rbisrTDBYMkxKMElm?=
 =?utf-8?B?cFd0cGJjSzM4clA0ZTliOVphNUFyRmNoWklPU1VKdzdsV1hsc1kyS3VpYkpi?=
 =?utf-8?B?VGZwejJBNUtLNlNBbkRRYjBncG1uSC8yVGNGMnpRdC8zWkF2ajFQbTZnTEJE?=
 =?utf-8?B?ZUgzYW1POFY0ZDl1cEJvY1lFYnNuemRaTHgxMThjZ3Z1VFk2dFNOUFY1YXZ1?=
 =?utf-8?B?eDBodlFwaTllS1lDQXVDWDVtTDY0SnBDZVVqc3FxclQzVzB0bHliV0g5YmZl?=
 =?utf-8?B?R0VNWG5wYlFlZmJxUTNZZkR0SEh2dmd0MGMwMnprdGV4NlJzMUpKbmFudzNF?=
 =?utf-8?B?YXRtRTBFaWlpUlNkRGVCbm5ieXUyN2FrcG9IVnNvRmIyUXdPZjgwbUpxUVZ4?=
 =?utf-8?B?YmlsaVpuL3BUOTh4b3NraWErcHdkM1BxbXJtc2g4THJyeXhwTFdZMDdYbFZ6?=
 =?utf-8?B?SG5PMitJVklUMUlFTWtMN1BVZlUxZlFrRzN5aXZNUGw4TGFROWpONnpETzFT?=
 =?utf-8?B?RDF1WGdnL3pKdTNtY1lKQktWOVR3SVphVDhrR29laTV1b0xUVXg4dGNmOEwz?=
 =?utf-8?B?c0hNb0ptMW9pa1VaN1NBQWM1YjFSS1RkNGNOZUtpeXJPWERxTU4wWlZzMWVs?=
 =?utf-8?B?ZU1vVHpxQjZwUENkaDZxNVg1Q0Y5RTFDeG9aNHFDZlFaQXRsMGF4bnUxbzVs?=
 =?utf-8?B?cDVSVU5tU1paVU0zT0w3KzRjei9pZFJ2blI3RlY0bFRoUGZubFZ3M1BOTzNP?=
 =?utf-8?B?SWt5bU9kY1IvUHMyYlQzQTNNWDZ0WElId2ttM3REcjF6QnNFa1BhZDJ3Y1Vu?=
 =?utf-8?B?LzY4VVNMK2tveHRCRWN0N0kzeGdBem5vUnoySmQrMHlvMEF5b3FwZU5BQXAz?=
 =?utf-8?B?d2Y5U0NVZ3F6aU1UeWdKVk9oVGZiU0VabHFUWVpuTWpiSnp5MENUa3k1TjVz?=
 =?utf-8?B?NDBqMTFPUmpRU2hGTnpLb2UwVkRvSjl4UkJ5V1hrcE95bDhPeFcvM05rN3hz?=
 =?utf-8?B?Y1k5K0xqT2J6RlRseFFJbzVISFJ2MkFvQmFIM3pKekJpQmUwMWY1L2Y5Skl2?=
 =?utf-8?B?RjJEVThEcVRZcVMzQTVpMUs5bi9KVGdzaDBMci9zUTNybVBKLzQyeE5SV2Mz?=
 =?utf-8?B?YWhFQVFxRVpuOXhobmRwU3ZHWDQ1dVpwc1ZHZHhVTjN5dlFxS253WXdCaGZi?=
 =?utf-8?Q?FXLzRsbkXTf4UfTL542HrolWj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5479d54-66a2-4d6a-46ab-08dc01348a9f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 08:20:35.8844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rowb0rtWY0jn6xVurm7jVail8/NsTIkbHpPnz5cU6NDoJRPOmVzopDkGXQ14Xv3r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9410



On 12/20/23 09:18, Krzysztof Kozlowski wrote:
> On 20/12/2023 08:57, Michal Simek wrote:
>>
>>
>> On 12/20/23 08:53, Krzysztof Kozlowski wrote:
>>> On 19/12/2023 15:54, Michal Simek wrote:
>>>> Firmware node has more than fpga, aes and clock child nodes but also power,
>>>> reset, gpio, pinctrl and pcap which are not described yet.
>>>> All of them have binding in separate files but there is missing connection
>>>> to firmware node that's why describe it.
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>> ---
>>>>
>>>>    .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 31 +++++++++++++++++++
>>>>    1 file changed, 31 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
>>>> index 3d578f98ae2c..0662544f86f0 100644
>>>> --- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
>>>> +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
>>>> @@ -53,6 +53,37 @@ properties:
>>>>          vector.
>>>>        type: object
>>>>    
>>>> +  zynqmp-power:
>>>
>>> Can we rename it to "power-management" or if it is a power-domain
>>> provider to "power-controller"? Assuming nothing requires the old name?
>>
>> I don't think there is any name dependency and node name can be renamed.
>>
>>>
>>> Also, all these nodes/properties look like not ordered by name, so maybe
>>> it is possible to add new nodes in some order?
>>
>> I am fine with it. Do you want to sort it before adding new one or add new one
>> and sort of all them?
> 
> Maybe the new properties can be added not in one chunk but
> as-ordered-as-possible?

It is more about that current nodes are not sorted that's why they should be sorted.

Thanks,
Michal

