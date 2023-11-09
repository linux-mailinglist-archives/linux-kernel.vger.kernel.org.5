Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6AD7E6717
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjKIJsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjKIJsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:48:43 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEBC271C;
        Thu,  9 Nov 2023 01:48:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZHwBZ3yQ7grber9mr6zRpwXdj0Z9GgNxnnobae3R7Z+M/qU4GaPnui74SBq/sMA9cy2TLaBePnQiJlG8WhlKRBlJAANq+bLhMdg37XAGXTeRcGYyzeaVkMpIaa3jMmJ7ItHhejg9NseQVSynwa6lSh4ThNdM2lAtszqRfPxaWAtopSt4SKwinyXy6XrLb3dRo2WBC6DFJ5fVDRWaVgSYBTpEtf0tyYtVsGARURhwLCnbPLMLHpMtGTH6wZjRoVAzVuHk7Txn0jOjrusAx2seJVMqbB2KvIyPyN9jcvwFz3qvLfe9z7ZMoYK7kNNUqwgKr44zYkCeDmmvn/mWkysGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Obr4dzdxPwVGvtJ/w5/cp6ZAxRQYBRcR2zv1VaP9u8o=;
 b=AzMnHyTpSf23RbCCquAif+2hW1yFa/lvRRCmbb9HlzsiwOqxs7fQJjETisPKE+BxfcLwjZW3z6+Z4aF3P0YrQjLJLYjL3L+bUCP36ij9Glm9lpW9GbUz74e8VPt9RgEL7uOUeYIOZB7xxv8iXQ6kkaMQYIu64QJifYrKCEfV5OQT8tAk1zwYwVVU7hUdMmWi/Avqy3pZPvn22RvDskl104LfbIzFqWRhUsB4ou1QRchlCgUpmdMbhR8LpFUwh7g2aK5C56CmqINzIlmC+4iJ58ORket+jILLkxC6zashOVOSnKJGN6s4OTn8+T6lBb5rqvrIj+mOUCzeZ2bRyCrvBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Obr4dzdxPwVGvtJ/w5/cp6ZAxRQYBRcR2zv1VaP9u8o=;
 b=I+/yr5Qqtl9z5O2fwzoNmvr2vo5hAEabA3LWRRLcnmmNRL8b+rJr50PALF5xTX4Ty9P+qh0YSAgt3CNTFsYC1l7Q3s7h/jHRHX0G+/JsMdLbNm6xLuY9dk8EjeogP9O8uKE+T7UvJvbviKiS9Ws149HsWhADiyQOXUl1AYzhQys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4765.namprd12.prod.outlook.com (2603:10b6:805:e4::24)
 by PH8PR12MB7230.namprd12.prod.outlook.com (2603:10b6:510:226::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 09:48:38 +0000
Received: from SN6PR12MB4765.namprd12.prod.outlook.com
 ([fe80::10eb:f44e:608a:ec4]) by SN6PR12MB4765.namprd12.prod.outlook.com
 ([fe80::10eb:f44e:608a:ec4%7]) with mapi id 15.20.6954.028; Thu, 9 Nov 2023
 09:48:38 +0000
Message-ID: <9837164e-6946-4c84-8ddc-858c2309999f@amd.com>
Date:   Thu, 9 Nov 2023 10:48:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: soc: Add new board description for
 MicroBlaze V
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, palmer@dabbelt.com
References: <50c277c92c41a582ef171fb75efc6a6a4f860be2.1699271616.git.michal.simek@amd.com>
 <20231106-hangnail-prankster-a04e713bed35@spud>
 <4223470c-5596-4168-9c89-e701559fbbed@amd.com>
 <e9fef49e-c0ca-4f7d-9618-151216e25280@linaro.org>
 <92d95425-5bae-4ada-8fc3-966e7bfbd815@amd.com>
 <90f9991e-26a3-498e-9449-c96663987459@linaro.org>
 <20231107-darkening-daylong-deef34169798@spud>
 <872007e1-6e57-4dc4-89f5-62fea3c969a5@amd.com>
 <b1b5b020-600d-48c0-aec8-c866c4c29c7a@linaro.org>
 <d62a1b46-d44f-48b9-9f93-647fe2a6f8a2@amd.com>
 <04242b1b-477b-45cd-bcb8-0125e705b71a@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <04242b1b-477b-45cd-bcb8-0125e705b71a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::19) To SN6PR12MB4765.namprd12.prod.outlook.com
 (2603:10b6:805:e4::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB4765:EE_|PH8PR12MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: cf9b9383-3b7c-49b8-ead8-08dbe1090b66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TpWqwMk6CzhLxRTAFTZ4k3Kb33kHcsZR3m14yPDoXLS8HBhAG3G0fijlNMRCEcLV9U7SjCIEekRIkyCI2qTCp52Hn/nr35TG7ncX1JXVz7gibEudffefwzkruzr3RELe4oCt5QtnsUn1QSjahbfc8oglsnLhyrXSxSBqXUlOd9F1LQLtU0NhPWkwhraHC02dax3LebvsmR2syuGDVwD7U9pVKDfpPyktIv1LdsFFqhjrLLr/e31X6PLx8SBpQL2a0GZOqC5DBFOLmd4NlZ6p+9GSd42STlETqS8Q2ZFkQmMwsiGQTw2H18G89Uxg65FdQcbKB5I9ySBxnQOJAYnmAVHW/0WlDMK5rwephXczUn2xdFbtg/sOa+7DJ8iU83FqeICx4Q9y8IYPrnZDeshYxBwwVPHt1bEkMbpsMcC5/xP37mXHubmr+Tn+V0ixkEAKKI89S0yJgZM2mopRnEFymCYBmw2vtPOqY/gOiPzi7iBri8ocraUpAE0U7/wW3TuDQxFM3DWOQ8eW11Icb+8kTwtzrzFhpV2puD5xDZBU5L39269geuuXzhLRzExbV9uIpZbMRNcUKGB1yP4ZgvMl5epW1pta/NbuxxqPVfKQXYXmuubkyD9tqS09t/DTE1417n7ckdeB2JlljdJdKBb9dv8VNl1pMJ1kvte4IFeiB6id3QUWFTSyiz8fUltrK9vE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4765.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31686004)(83380400001)(31696002)(4326008)(44832011)(8936002)(86362001)(41300700001)(8676002)(36756003)(316002)(2906002)(966005)(6666004)(54906003)(6486002)(6506007)(53546011)(478600001)(110136005)(7416002)(66556008)(5660300002)(38100700002)(66946007)(2616005)(6512007)(26005)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnVCbXBkRkRmL2h5eVQzRUdkdE9hWmpLY3NXU0s1bWFvblpOdUI3S0NOQmJj?=
 =?utf-8?B?UnFraTFORmtuT2lOZkpHQVZyV3pBSnlueThIc2w4UTE3SGFwbjA0L2trMnJz?=
 =?utf-8?B?Tml0Nkc3Z3BjME9la2hEQnJEQjRpVDVkZ2ZoeDRIWUlaL1dsMzNkZmtvQmhB?=
 =?utf-8?B?SkVsM09uZUxNbUxrUGZlYkhtUzlENzRrMm9IZHhPZXhOekxqQlphaG54WGFn?=
 =?utf-8?B?eFprRVYrOEcrUkVQcThDOUdBb3VxZkx2ZHRTTTZEUnIvMFk1WkM4ZldhRWJq?=
 =?utf-8?B?UldMYWc0cnhhRXIvbXhnb1crVElISXk1WVpDN1M2Qk9XRjd5NEFySHJEbEJ0?=
 =?utf-8?B?MUZYWVo2a1RYVG9JZWVqOXAxQWlCcVNzY1Z4cmxHL3ZLMVA4aXBEejROd0tT?=
 =?utf-8?B?NGdWWWFpZld0ZEJ2eE8xS0lnYTlXL25qdWMxT3U0Q1kyb2VvUzBBVlNoekdX?=
 =?utf-8?B?WS9LSDRKNUxYTjB4U01jMGZqcFN3MkNKc21RQ3c5dVBtZFN3NGdObHNBM04w?=
 =?utf-8?B?R3crYi9hUkRkRGRnbFJNMHVVb1FsSDFtMU5WWTZ4ZTh3dDg1bjhLRHJwZUww?=
 =?utf-8?B?OTE5WWZld2tZOFQyWEtwTWF4d3dneVlEVGF6SXlLcVlkL1FpN3hHUzZXSGpm?=
 =?utf-8?B?ck1mbGpXZmxENEpvQUFpUXZFNjg0TFNKOFVabmRnRFhSZXo5eS9rdDdPMTVr?=
 =?utf-8?B?dVE0UHNXZ25xTHk1bXdwd00xNTF5bkdDbE9sak4wVWFZMlNSUWFaRUZWVnlU?=
 =?utf-8?B?dis1ejBzOGxCdTViS001cjlvZTRza1VhRTZCRjR1OGZTZXNMbjRmdXFZcE95?=
 =?utf-8?B?b2VERnlXdC9wUmVoV1o1RXd5b0VzOWQ5c1dmUlZWa2J3TmdJbnNmakJ2Q3hD?=
 =?utf-8?B?YmoyUzVSbkdoMDk1Vjk1dFZHN0JZdkN5ay9Rdjh4dSt3bkhGM29TTVFxdzJW?=
 =?utf-8?B?Um1lVEhDZzFYd0oxNkI3YzlYUEF1K3RjMTdXejFHZjEwTWt6ZjF2dnBkTmlm?=
 =?utf-8?B?dVdVbFFZOFcxZ21jUXF5eGpVeCtCYmMwS3FEcDRITm5zSlNLaUJManVqVW13?=
 =?utf-8?B?clJiNjZOQmREYjZYeGV0Tzk2ZUV1TU52TlZzVXRlRFN1Tmkyb2F3eFlnYXRM?=
 =?utf-8?B?Um5yQTVpeVNCOCt0SnhpRGJUQy9zckpodWJ3eUJ0eWhOVSt4TjlKZDVReU1H?=
 =?utf-8?B?Wi9CZkJsOTQ4TXAxZmJEOWJjUWgzb2wyVVhmc0Jzb0dYUUVtV283MTk5K2I2?=
 =?utf-8?B?MW5SS29xL1lTSHdOQURmNVprcWl1RENDa1BQOTQ0dldMRjR6aC82V0IxSVdN?=
 =?utf-8?B?OHNKK3RGNkpFdXYvU0hBZlYzeUg5RVdibEY1TUVlbThIMVJDVk82NGN0Y2Nt?=
 =?utf-8?B?Tm1aMFd0S0pRVUo2TmdRWnNyeTl0V01SUHprbGhSN2N2bTBQVkhTc1pFckgw?=
 =?utf-8?B?SG1ITEszMUI0M0Q2VGQvWEZZaXFUUTI2SXIvN3prSUtvRkQ4bk9KbHU5cHlT?=
 =?utf-8?B?MVNWTHRva0RPOURmMnNGNWYvaDNiT0FSNm4zVlN1TVRmUldJV1poaVB5S2hL?=
 =?utf-8?B?ajBtMEFtemk5WHhDd0pqdVFxU0lySTluV0tCaG1uQTdZeVlncWoyL1hVdGNK?=
 =?utf-8?B?a2lqNHlKUE5rcGl4anQwQ0N4VDZlREttQVY3ZzlRWmZjL0ZHU3o3YjlQV0dY?=
 =?utf-8?B?c1ZrTkR2bzc1UHY2MVM5bXN1OEU4SU5TaksvTTdkVEZ0Tys5R0hWckh0YlJ3?=
 =?utf-8?B?aHp2UngyTFM3WnVwU1ZJNUlUOHg3R3EwVWFESTJSMWIxcytzT0s5aTRzSklH?=
 =?utf-8?B?ZHYrZyt6bGFJbWE1ek5HVS8wYjZ2dUVJay9IWCs1eS8vREo1SWRBaVdtMGp2?=
 =?utf-8?B?V2kvQ0ZjQ0J6enExTlgyYVRFMHM0YS9SOUhMS004OFBVaEpNVStJZFY1QWVp?=
 =?utf-8?B?ZzFwcnY2OE5MZVN4aE1rRTd6YnVJbnM0dHZVd0JNa0Nva2cwdFVoclZMMTdW?=
 =?utf-8?B?cElYYWhZeTBORzd1K2JhaHA4cGovQ1kwS3NnVmNmSzVzSXYyREVPeDBRT1Vv?=
 =?utf-8?B?Sko3N1YxMUdwSVZoWmozKzlUbVhPTVdBQXgxblp4OHBaZVBOKytuanZiVVo3?=
 =?utf-8?Q?VNptPNF4918MJ2IYTlu43gDry?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9b9383-3b7c-49b8-ead8-08dbe1090b66
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 09:48:36.6538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNH3tJgjg3rAfjRn73TeLfirhzzXMYJxMVh5YXzmU27apQpKCPtlceaDsstaSDTU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7230
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/23 09:36, Krzysztof Kozlowski wrote:
> On 08/11/2023 11:11, Michal Simek wrote:
>>> I meant that creating a binding for something which is not and will not
>>> be a product does not bring any benefits. Why do we even care to
>>> document it? Who requires it? I don't. I don't see DTS or driver, no
>>> need for compatible.
>>>
>>> That's why entire discussion starts with DTS (and/or driver).
>>
>> We have dt description for soft IPs like uartlite
>> Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
>>
>> We have 16550 compatible IP with
>> Documentation/devicetree/bindings/serial/8250.yaml
>>
>> Simple ethernet core
>> Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
>>
>> Axi ethernet
>> Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
>>
>> Adi clock generator
>> Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
>>
>> Adi fan control
>> Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yam
>>
>> Adi adcs
>> Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
>>
>> and much more.
>>
>> They are IPs from vendor catalogs. We can talk if it is a product (definitely
>> yes if you need to buy it for your design). But all of them fit to the same
>> category that you are composing your HW design with them.
>> All of them as standalone can't run. You will never create a product with just
>> uartlite IP. You need to add cpu, clocks, reset logic and others around to make
>> a product out of it.
>>
>> Our mental model is HW designer create new IP, we are writing driver for it,
>> customers can buy it (or get it for free) and use it.
>> They put it to their design, create custom board and sell it as a product.
>>
>> And in this particular case HW designed create risc-v compatible CPU.
>> I expect this should fine
>> https://lore.kernel.org/r/d442d916204d26f82c1c3a924a4cdfb117960e1b.1699270661.git.michal.simek@amd.com
>>
>> And discussion what we are having is pretty much about how to share the view on
>> the system.
> 
> That's different category. All of these are part of SoC. Here we talk
> about the SoC and I had impression that you added compatible for the SoC
> alone.
> 
>>
>>>>
>>>>>
>>>>> I spoke to Palmer a bit about this, and what I think would make sense is
>>>>> if you had some sort of "reference design" bitstream that people could
>>>>> download and run on xyz AMD devkit. If that existed, then we could
>>>>> document that configuration etc. Otherwise you're in the same spot that
>>>>> a lot of IP vendor stuff is, where without there being something that
>>>>> qualifies as "real hardware" using the core, it doesn't make sense to
>>>>> try and create bindings etc. It's the same for the various people in
>>>>> the RISC-V community that created their own CPUs that they run on FPGAs.
>>>>
>>>> Aren't all ARM FVP models enabled by SW before soc vendors put them to a real
>>>> chip? Is there any real product available at that time?
>>>
>>> FVP also finished one. They do not claim they added compatible for a SoC
>>> or CPU. And that's my impression here.
>>
>> Are these real chips?
>>           compatible = "arm,foundation-aarch64", "arm,vexpress";
>>           compatible = "arm,fvp-base-revc", "arm,vexpress";
>>
>> FVP are Fixed Virtual Platforms. Pretty much emulators similar to QEMU.
> 
> If your case is this one, then few parts of description should be
> rephrased in the bindings.
> 

Let me comment this below.

>>
>>>
>>>>
>>>> I will try to find out if there is any official plan for releasing any reference
>>>> design against any evaluation board with commitment to supporting it.
>>>>
>>>>>>> Or I can define qemu one.
>>>>>>> "amd,qemu-mbv", "amd,mbv"
>>>>>>
>>>>>> QEMU is not hardware, so not.
>>>>
>>>> I am still trying to wrap my head around it. In qemu we are actually going to
>>>> create model for this configuration but based on what you are saying here we
>>>> shouldn't really have DT which describes it.
>>>> That's why we likely end up in situation that qemu create DT description self,
>>>> put it to memory and u-boot/kernel will consume it. The only difference is going
>>>> to be that DT will be used but won't be checked against dt-schema.
>>>> I personally prefer to have DT pass dt-schema checking and tell qemu guys, this
>>>> is what qemu should generate.
>>>> But if you think that this is wrong approach I will let them generate whatever
>>>> they want and will just check functionality. It means u-boot won't have DT,
>>>> Linux won't have DT and I am done.
>>>
>>>
>>> Sorry, I am confused now. Are we talking about real hardware or QEMU SW
>>> model? Your description clearly said:
>>> "AMD boards with MicroBlaze V SOC"
>>> so QEMU is not a board. Board has a physical form, a shape. Usually flat.
>>
>> Let me describe what we do for all our SOCs but Microblaze is the best example here.
>> Customers open design tools (right know Vivado) and design their system there.
>> Choose cpu and it's configuration like barrel shifter, divider, multiplicator,
>> size of caches. Then put there interrupt controller, timer, consoles, ethernet,
>> spi, i2c, etc. For all IPs you need to choose mmio base address and connect them
>> to any interrupt line you like.
>> You normally target a board, evaluation platforms or just standalone chips which
>> you use on your custom boards.
>> And build bitstream (configuration for FPGA) and also going over our device tree
>> generators which generate DT for describing the system.
>> Very old example is for example visible here
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/microblaze/boot/dts/system.dts?h=v6.6
>>
>> Another example is mb-v description mentioned in previous thread.
>>
>> The reason is simple with a lot of IPs in the design none will be able to get
>> description right in connection to addresses and especially interrupt numbers.
>>
>> It means at this stage you have bistream for your board and you have DTS
>> (without board specific information like i2c devices, ethernet phy, etc)
>>
>> For 10+ years our qemu is taking input as DTB and create qemu model based on it.
>> It means you say via DT I want this cpu core, this timer at 0x..., interrupt at
>> 0x..., uart at 0x..., etc. and qemu generates model for it. Pretty much the same
>> DT can be consumed by SW to run it on the model.
>>
>> We reached the state that you have qemu model which reflects your design choice
>> and at the same time you have hardware for your board.
>>
>> It means same DT describe qemu configuration and also hardware.
> 
> So you can run it under QEMU. I misunderstood your proposal of adding
> qemu compatibles few emails before.
> 
> But if the QEMU model and also the hardware is called "AMD MicroBlaze
> V", then how the heck is SoC called?

Let me talk about MicroBlaze which is the same category and available for 10+ years.
MicroBlaze is the name of CPU core.
And I think none has used any other term for SOC. Maybe just MicroBlaze based 
SOC. None is really creating any new name for it.
We use just xlnx,microblaze as compatible string for the whole DT.

compatible = "xlnx,microblaze";
model = "Xilinx MicroBlaze";

And then compatible string with version for cpu identification.
compatible = "xlnx,microblaze-10.0";


In connection to MicroBlaze V. It is cpu core name and if you want we can call 
it MicroBlaze V based SOC.

And the same DT is used for qemu model and also for hw designs running on 
different fpga boards in both cases.
I have no problem to define it as '"qemu,mbv"' or '"qemu,amd-mbv"' or 
'"qemu,mbv", "amd,mbv"' and fixed qemu model which just match it. And I am fine 
to ignore that it can also run it on fpga boards.

Thanks,
Michal
