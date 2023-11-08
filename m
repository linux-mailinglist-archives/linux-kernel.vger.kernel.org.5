Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0697E50D4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 08:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjKHHQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 02:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjKHHQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 02:16:51 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D229010F9;
        Tue,  7 Nov 2023 23:16:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eU8NrjE3eR7sFsTNhdPd9WufsewEBjAFQ7sONX4tURWow0yScJnCoBPSwsy2Rkh+J/rY3KXlbTNux8JM/Ug61Gvle03jBmGJZZWpV2myMXt+G4A/YH32hQjUixthEZ5JGX46FYAcsB6azursTKydxxHCIljc2C25itDePJRw/a6v9Q6o6Tptl6+t9yyPVdaWlonrJk6BigwmtaxtLkrEZwD8qc8baKYhq9K87UZcndSJhtuyCFgNF9B6sJ9ioR31gGjHZBDwmDFowmuaeWBZ8GnQ86MrQBFitZ54+AmD/9ojPPz6o0Zm8H/R4BaVoCiLXeH5MLSu6doSHLccplCZ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZi5GIu4gomXHOWfXsFqkLmMondz/H4ZqoTq6A82l4I=;
 b=MpplmKqCPpVrDM8VIXAHbJJQprcb0m6tIu6M+0O9TnLIyCWRX9yR0d/sFi8JzwfnVqDwwQHXmm3zJioORk/ONzDDxlowagExt7eGqmBCpBaDT0wCGBi8qYWJQe8kSLdtDwdb1vvvJO8rRwTn7TWseR+Nsbcj8feGDpvTS3jPi0aNueaITKyqK01ASjbE3dn7QHdeBjNPkkzqVlSe0Ure+9meIiy620UaotAS2/FlPw5Ga5NUqBIYkNEo+2ziSss5+VmtavVoIP5gAewG2rdt+sEOEI2na6e0DkuaQrw4gKlitennJ83fLUP/qBjPVyv7o5RuxIx+7j35+H0a5kXACA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZi5GIu4gomXHOWfXsFqkLmMondz/H4ZqoTq6A82l4I=;
 b=O1s65733vAJWXuAwS3xVrUq4Ifh+LrYbc87CzvKxEdNgCApbAieYNt3JodtMc6omVF+xN8vwMIEtgHHaDsx9RrNH8KZlLmEcL3SUUC542nosVqlv7m9DhQAGkN+gM+uvcGmTnzo1W7xbF9aV/uUgIRvKuPwavuQayAWGbWbfjn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DS0PR12MB8526.namprd12.prod.outlook.com (2603:10b6:8:163::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 07:16:45 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9%4]) with mapi id 15.20.6954.027; Wed, 8 Nov 2023
 07:16:45 +0000
Message-ID: <872007e1-6e57-4dc4-89f5-62fea3c969a5@amd.com>
Date:   Wed, 8 Nov 2023 08:16:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: soc: Add new board description for
 MicroBlaze V
To:     Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
Content-Language: en-US
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231107-darkening-daylong-deef34169798@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0035.eurprd08.prod.outlook.com
 (2603:10a6:803:104::48) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DS0PR12MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c4656b3-1e70-4e4f-c815-08dbe02aa9d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x3WF0kvN8+lsiUmNWhT/I5L9G9iRx75dxSfkPu8SyGQFzUwxZOpO3MN4lcY1owIC4VORngObm2OCTatSSFT/BzY/5QIAXhSmf8BZXc0j3Xrwhm9BAQ/1IS987D8fC9lvDjUjjdGd5nt2LpZYVdjb3WtDbr5zI6hf06MJ2XsuU+v57vEYHlebN+19JZMqL124urvyhS6cuPH5xNPi0OSj3C/fcJACdL6Jwz1pqn4TZnZ7vhKKZldU2AROzUbkIEK0p/eB2c13B802BaVftuRDXFJTpPm7eMjCQU1pyTbOXwo8pt3ZK/mQ/O/Z8YOkrAnxbXPRE+5QehzbnM8aQrugGUiRjKniE1Ag5ZR7pMBRjOQSJGx5ysj7oDNwPShIj0Y/6DfEtw+pjF+EO8n8cSEWwWMbTVty6wRsHMHSliMJUEOigntyTHQ5beUW5cku8n2Hc+uoPV5RTfQLnWFaZ0i92JgmDhxNR8vpUfqKhvGIiFhSk1acLk3qF3IJDfqRbN0K57XwuIZKzIgryi4uornnFrQ01mf1W4hgA2DRAnzG/JPMKdxxX4YbkM4OSMJofoREcOLgaS/OOiPbyYOQPKInG2yTPJa5XodMLs7DYplfFxJ7uWFbWHOF9BqwsSGEM7yjgs/kIpUFWVASkbxsNzYibA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(8676002)(44832011)(8936002)(4326008)(54906003)(66476007)(66556008)(66946007)(110136005)(38100700002)(41300700001)(316002)(31696002)(36756003)(86362001)(5660300002)(2906002)(53546011)(2616005)(6512007)(66899024)(83380400001)(26005)(6486002)(478600001)(966005)(7416002)(6506007)(6666004)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFlacDNIVEpRWFI4bVg4YlRrbGwrSnFYc00rODkrMFJ3cWV6dG5HUTdxSlk1?=
 =?utf-8?B?TFlmMmdIUlhTbnZSUDdTNzQzVjR0bHd6MDNlMHpVdGFCOHZraDBzZWNVQ2sr?=
 =?utf-8?B?UjV1L01XZ090MGxySEZFL0hQZDByWExBY3dPdFNwN2pmTVNnQ2QrZTFjWE5j?=
 =?utf-8?B?SHdlMkExVGxZUnNaSHN1Rm4rNm9ad1hONHh4Yk5iS3dnS1JVK1graFI3dFUy?=
 =?utf-8?B?Tk9pL0lXZFR2bDhyaUpsOEluMzBycUJhWFIzVXMrTXNwRTVzdzdvc3dRaCtU?=
 =?utf-8?B?RkRuQ1F6V3ZTVGQ2SC9PSDZCZFJkb3dGK3RpZFlsVXFlVHFEV2RHTHZDcXFL?=
 =?utf-8?B?aGZtK2dNWVBnVG12VGljQ0V0Ri93V2RoUGx2Vm9JbmNqM0dreTZ1TGJpVng5?=
 =?utf-8?B?cnVIQTJYUHRlMFA3bzZVQkQ3L3daaGU4S3hLYnVJQnlVci81UXIyVlNsS0NS?=
 =?utf-8?B?NzNaNEljcUFpWFoxdXlxQTJRQXBLQmR3Znp6ZEhtTWUwWkNRb0FIQWhtS2xQ?=
 =?utf-8?B?VFR3QWkzQkcrWC9iYU0yUG9YNXFJQk5uR0Z3bWtpMUdsWUpnTDdUVml6UVBK?=
 =?utf-8?B?RGZBZkxqMmkxZ3NWL1BhamJiRHBnRFBOWDZ1ZVpsNitpb0lFL1hCNXZ2NzFT?=
 =?utf-8?B?bnZjeGpmcEpvYnlPZElyZ0pNbk9MclQxZ0lSdEtESThrYTNaVHU3YkZRdWJt?=
 =?utf-8?B?MzJtSnNLT0I3RTZhV3puOXpHZDY4R3o2VGUwNVJEOWZBSUNqMHpwMHlJRWt5?=
 =?utf-8?B?S1ZzbCtZOGl1VG9obnZaRDQ2b3pLbzEzeXVOcUM2Qk1NWDNJR1F3UmVQTG5D?=
 =?utf-8?B?eERVR3V4cUd1ZjErZEpRaEc1Z3o0YXNyNWlWc0xiOEYvSCtqU3JEOGFHT3ZS?=
 =?utf-8?B?RE51eXZvMlBvRkhmQnFZWjRUU2Z4aThGSDl4eENWbE9LamREMkhFdUJrTnhU?=
 =?utf-8?B?Z1dmQ2w0YzhwejZqSjk3NW9pckVLbWR3R3l3T1BySkc5WHNDWFlSQmZXMENu?=
 =?utf-8?B?WjBrZVJrRUNDTTFxVE0rMlZmZTFTblFDUkZrUUpLZlY5aVV3OStzTEVzeTc2?=
 =?utf-8?B?RkVVU0ZSOURjOG1GY3pTREtvbW9UcklPcjBMWEpNZXdwTGlHaDBuSXIwc0p5?=
 =?utf-8?B?dURiN2pZL2g4dkhKbmRBRHN6eEc4ditmQkhRWDFjODNRNmxHcUVabDBpQ05R?=
 =?utf-8?B?dWFOWlhaM3B2TE5QcFZNZjZlK3lpb0RSS0tDOXVxRjNBN3k0MGVqa2UzZTdZ?=
 =?utf-8?B?Q21kY25Pd3RmdW5hV1EzMTFYdDdiK3oyUXliejVKQnNuakFYWlNnT0IvU3Yv?=
 =?utf-8?B?M3pIbUVWSXNwaEN6dGZNdDYwcCsycndoWGpBUDBYMENhYzJUTkNVMFNDVWlH?=
 =?utf-8?B?ZWVuMmpYSk5LTVdqTGVocmxEZnZwSFUyKzFPOWtEbkN3dysrdHpmVE5ZaUpR?=
 =?utf-8?B?aGlLc1ZmV0J4cENKZHdTRktRK3BPNXpucTZTTmw4dWgreGhMNWdUOWUvOWJm?=
 =?utf-8?B?Wlp5bWVlenluZ3dmMVQvZWZsSnF1RDdQQU9xRUc1Z0NXcXlLYjRxeFlleDIv?=
 =?utf-8?B?Y1hZalBBc2VkWG1WRUg1dzg1NUNKMDJya0tBRmVLTHVRMlNNTis3WTBQRzRx?=
 =?utf-8?B?eHZpcUEwNk1CTXZUOURwS3crS2hPanRrVXo1UTVpUVhYOTJqNk84dUMza2FC?=
 =?utf-8?B?TzRzSXRML1p6UW50Zld4Uzcvcm5GNDR5anhjcEh5TGUrU0UwTmJiWGlsckE4?=
 =?utf-8?B?NTZyTUFiaVF5SUpFTEtnbWI1QTJuZlFMWmdrL3dId3E1ZXRUb3p3SEhFM0dZ?=
 =?utf-8?B?eG1TL0NzRWJwazVzMkh3VlN5VkllNHZVN2JYN3l3WWphMlR2eTVxQktLRzJF?=
 =?utf-8?B?NVRaZFFrU0M2bVlGeUZGWVhXZWVPakoxaGpXM1ZTcjdwYVF5N2pBT2xxakdE?=
 =?utf-8?B?R0I2VUhrOERyQVhVWllMSjhsdmxXd2Fvem5kVFNHblVrOEd6RXUzNnFBSzdk?=
 =?utf-8?B?YzYyWUQvRU9hQmxNdlRBWkpXNCtpRStWaDFaemJFcTZraXpuU0pwYXh3emdH?=
 =?utf-8?B?aUhOcXBlME1DTGVwMWYxUnNmU3JMOFpUT3FsSE9DQ0xweEFuajFWcWlpeE5L?=
 =?utf-8?Q?rwF+I0bTQCzJot4JATcCqZlVn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4656b3-1e70-4e4f-c815-08dbe02aa9d7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 07:16:44.7107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q7aKsuQ3HmUptc2zNFih2Btfykczju6RvlI2WA08uA9L6OjWqYhVd8t2qo9GBQnz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8526
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/23 22:36, Conor Dooley wrote:
> +CC Palmer
> 
> On Tue, Nov 07, 2023 at 01:38:15PM +0100, Krzysztof Kozlowski wrote:
>> On 07/11/2023 13:09, Michal Simek wrote:
>>> On 11/7/23 12:27, Krzysztof Kozlowski wrote:
>>>> On 07/11/2023 12:09, Michal Simek wrote:
>>>>> On 11/6/23 18:07, Conor Dooley wrote:
>>>>>> On Mon, Nov 06, 2023 at 12:53:40PM +0100, Michal Simek wrote:
> 
>>>>>>> +description: |
>>>>>>> +  AMD boards with MicroBlaze V SOC
>>>>>>> +
>>>>>>> +properties:
>>>>>>> +  $nodename:
>>>>>>> +    const: '/'
>>>>>>> +  compatible:
>>>>>>> +    oneOf:
>>>>>>> +      - description: AMD MicroBlaze V
>>>>>>> +        items:
>>>>>>> +          - const: amd,mbv
>>>>>>
>>>>>> You don't actually list any boards here, but instead permit having only
>>>>>> the SoC compatible and no board one. The SoC compatible is also
>>>>>> incredibly generic. Personally I don't think this binding makes any
>>>>>> sense as it appears to exist as a catch all for anything using your
>>>>>> new cores in any combination.
>>>>>
>>>>> I think I need to define any string for compatibility because it is standard
>>>>> property. Because this is soft core it can be added to any board with AMD/Xilinx
>>>>> chip. I don't have really an option to list all boards.
>>>>
>>>> Why? Either there is a product with this soft-core or there is not. It
>>>> cannot be both.
>>>
>>> I am doing basic enablement. I am not making product. Product will be done by
>>> our customers using this core.
>>> There will be thousands of different configurations done by customers which will
>>> have products with it. Also there could be hundreds configurations done on the
>>> same board.
>>
>> If this is the same board, then why there is compatible for it?
>>
>>>
>>> Does it make sense to have board related compatible string like this if this
>>> evaluation board is used by a lot of customers?
>>> "amd,kcu105-mbv-ABC-vXYZ", "amd,kcu105-mbv", "amd,mbv"
>>
>> I miss the point what is the hardware. Evaluation board is the hardware.
>> If someone changes it and makes a new product, it is a new product.
> 
> To me, this does actually make (some) sense.
> The first compatible is "soc" + board + design.
> The second is "soc" + board.
> The final one is the "soc".
> 
> I say "soc" though, because it is not a single soc - it could be any
> configuration of these soft AMD cores on an FPGA in any quality,
> possibly set up heterogeneously too. I don't think trying to define a
> generic compatible for it like this makes sense as the soc part does
> not come close to identifying a specific device.

I am fine to skip it but it is required property which has to be defined somehow.

> 
> Until someone actually creates a product that ships with this, I don't
> think it makes sense to try and define a binding.

I disagree with this description. I am coming from FPGA world where it is too 
late to start to deal with dt binding when you have a product.
You are saying release the product and then start to deal with dt binding. When 
product is released there must be stable dt binding.

> 
> I spoke to Palmer a bit about this, and what I think would make sense is
> if you had some sort of "reference design" bitstream that people could
> download and run on xyz AMD devkit. If that existed, then we could
> document that configuration etc. Otherwise you're in the same spot that
> a lot of IP vendor stuff is, where without there being something that
> qualifies as "real hardware" using the core, it doesn't make sense to
> try and create bindings etc. It's the same for the various people in
> the RISC-V community that created their own CPUs that they run on FPGAs.

Aren't all ARM FVP models enabled by SW before soc vendors put them to a real 
chip? Is there any real product available at that time?

I will try to find out if there is any official plan for releasing any reference 
design against any evaluation board with commitment to supporting it.

>>> Or I can define qemu one.
>>> "amd,qemu-mbv", "amd,mbv"
>>
>> QEMU is not hardware, so not.

I am still trying to wrap my head around it. In qemu we are actually going to 
create model for this configuration but based on what you are saying here we 
shouldn't really have DT which describes it.
That's why we likely end up in situation that qemu create DT description self, 
put it to memory and u-boot/kernel will consume it. The only difference is going 
to be that DT will be used but won't be checked against dt-schema.
I personally prefer to have DT pass dt-schema checking and tell qemu guys, this 
is what qemu should generate.
But if you think that this is wrong approach I will let them generate whatever 
they want and will just check functionality. It means u-boot won't have DT, 
Linux won't have DT and I am done.

>>
>>>
>>> I think customers should be adding their compatible string in front of generic one.
>>
>> To what? To evaluation board? Why?
>>
>>>
>>> Years ago I have done the same thing with Microblaze where compatible is defined
>>> as xlnx,microblaze only.
>>
>> Again, what is the use of such binding?
>>
>>> When customer take this soft core, put IPs around and
>>> create a product they should extend it to be for example like this.
>>> "xyz,my-product-1.0", "xlnx,microblaze";
>>
>> So there is a product, not evaluation board.
>>
>>>
>>> And over all of years I have never seen any single customer to try to push dt
>>> description for any Microblaze based product.
>>>
>>>>>
>>>>> I am happy to change it to something else but not sure to what.
>>>>
>>>> Alone this compatible does not bring you anything.
>>>
>>> I don't agree with it. It is standard property and I have to define it somehow.
>>
>> The property is already defined, you do not have to define it. What you
>> define here is the value for compatible. Why do you need to define it
>> somehow? Who asks for that?
>>
>>> If not, I get an error.
>>> .../xilinx-mbv32.dtb: /: 'compatible' is a required property
>>
>> So you have a board? The patches must be linked to each other, e.g.
>> preferred way is to send them in one patchset.
> 
> There were patches sent to U-Boot for an example configuration:
> https://lore.kernel.org/u-boot/d488b7016e0d1b1324c64d8a8b2f033851aab6c6.1699271804.git.michal.simek@amd.com/

thx.

> 
>>> And it tells me that this risc-v compatible core runs on AMD fpga and it is
>>> compatible with it.
> 
> Basically, it provides no more specific information than the cpu node
> does. From me, it's a NAK for a compatible like this that that permits
> using it in isolation for any core configuration and combination.

I hope you agree that if we ignore compatible string for the whole DT that DT 
describes HW is very reasonable way. It means you know what CPU is, what timer, 
console and intc are.
It clearly shows how MicroBlaze-V AMD design will be done for others who are 
interested on using it.
It also shows and explain what drivers needs to be enabled in defconfigs.

In connection to above u-boot. I can simply remove DT patch from that series (or 
move it to readme) and just say these IPs will be used that's why I am enabling 
them and point them to public announcement. And configure that DT will be passed 
via address in DDR and that's it.
But I simply think that DT is providing better view on the system.

We will of course extending our device tree generators to provide DT description 
directly from the tool as a starting point for customers.

Thanks,
Michal
