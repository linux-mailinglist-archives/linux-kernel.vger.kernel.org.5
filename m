Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DB87D0975
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 09:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376390AbjJTHYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 03:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376510AbjJTHYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 03:24:01 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F0D1717;
        Fri, 20 Oct 2023 00:23:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsQsPwHm1Xl+qvLKlG+rAv7kJHBetTylZGxqoFPRNShDtrE3+SIROT1nQLmVbvxv7gLxHjvqVGWsHOA7krVO4IT2BqF74oo8ihOe0iG1h17pjEpRkt3iuqrBGyz7W9NeAjQ/ci8rpLqfNsq48SOYNVf1hicH6PsBOQZ+fFIvfLm4XdZMzzBSho84vbdF8MjUKserONlrSCvy8A0vaB0fec/J7wvHkILzzjYWZh3SrqiNF5LHQOtsMmyWx9Utv/I89GLDeBM7jWjkBfsp045UCJfG6vaTQOGXZF7poZJKfaHPjQUsb7I/7x7lL4i7e1qA54meEuH+sCWJs0QBESg6iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6H40kfbmTOgsp7yR+oCx1SAXsFdJv1oRmwd7gnJMLA=;
 b=lZ2OsPrFN5k/okVWbbzp71J05qT2Hwy0zoh1T2Iq2asi8chhDu5ttNocMm5ui4wsuLzWd8B2sd7MOk+i0u9tw+/ClXUK87qz0mxcSp42umjLkSx/LAzY56bmnzmnD5vp2zhffMkBsDZG9swC8ZXbDDVMhtRXB6IYqv62wg5aRkjBeXVh5W/L/X8dyXMJHL72FVWDHbhbnIbAu5lk0EwmUJ9lnfQaYqcUDFj6AVfpwmjLLcwPbhBEGvqN6Wrv6PVJAyKVHa8RqTi3cIPLeDPspU21RKgpwUKK39dsrBJIgTJ7KG0DLk/A69KVTefWYnkD2i+orQJZ7oyY8Sc476Z7aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6H40kfbmTOgsp7yR+oCx1SAXsFdJv1oRmwd7gnJMLA=;
 b=ad9Nn1nyJ5ukT3yAuIE7BzOvfbaB6DfToXzclnL/6uzqy3j28E9vrzQTPpYt0ueCXEIHpZzRakvPvuL7fUQWXp/lYy6DDmlMbFFIUL0j5IlH4gHIVsstSmItQdP1AC4EULN1mmFDC6ucC6LSEp1u9Uxn3eRE3u02GdhPs9uoeXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by MW3PR12MB4378.namprd12.prod.outlook.com (2603:10b6:303:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 07:23:39 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::b220:eeee:98e7:a62e]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::b220:eeee:98e7:a62e%4]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 07:23:38 +0000
Message-ID: <790788df-f316-495f-9e90-562d163b3e4f@amd.com>
Date:   Fri, 20 Oct 2023 09:23:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/5] arm64: zynqmp: Add ZynqnMP nvmem nodes
Content-Language: en-US
To:     "Kundanala, Praveen Teja" <praveen.teja.kundanala@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231019060651.23341-1-praveen.teja.kundanala@amd.com>
 <20231019060651.23341-4-praveen.teja.kundanala@amd.com>
 <1fa867b2-3930-4ff3-90cd-022d855036c7@linaro.org>
 <BYAPR12MB3207FC23425007B129ED4D3ECBD4A@BYAPR12MB3207.namprd12.prod.outlook.com>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <BYAPR12MB3207FC23425007B129ED4D3ECBD4A@BYAPR12MB3207.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0015.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::27) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|MW3PR12MB4378:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d7d7d4-5798-4b8e-b404-08dbd13d7ace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qog/jcth/f9nYMqVngjqovFFL3baQUAKADQN3tlZSp8psDHbv6YyxT5PEZfcvoR5o5H9VXFo8qrDbbaTHu0VsEqAVd2BJd6gBfzrpeAE4UAMizyn3gqELRwlY6PFGNjhYY8jDGqHgqFnZO/gM7MB3FzlVrnsK6yDy8HTJ4gSkZQ19ctcqy7w+R/CvTqHs/Quyr3K973OF3hdVChXfCZw23c2dRIYYtkiqN2bjV8mX+MPUyB0X3eg+dPGeW5EPO4vGkyLsEvSlm68kU0mlR1Z310piuUnFycDFn9lNbeI4/469X9V4OQlq7IDNedQG9zACm+SAPR3L7YR797Y2+q3d0uBOZ+UTJ1hpfBQzdtjbqGvfUvXYdxDm/9qm5yvVI+N74aob21YRIDDIf/C8DFuijhNS7NbXUoTGsYlwYSR4vyOma1KDQvYlT+xS8T7ocQWRSNBcY2YtqjkFOtykPIl7zEDnuhdirHf0lOpTmMAd/kfBeFDLjGcGfK+K1iuEyTBajLT4iQJ1o0g5u4OU0pPBGjScUP6pKZsU66FTDY8pKrpPCP8h4ZlUwwGXtnT7aAabH2GcPdqggxpC4ISjgGLw0WEEDM55JXgAQWZjmWtNX6MBgxAdU6gd32fXxKXiEjR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(36756003)(5660300002)(4326008)(8676002)(8936002)(53546011)(6512007)(6666004)(44832011)(2906002)(83380400001)(26005)(2616005)(38100700002)(31696002)(86362001)(6506007)(478600001)(316002)(110136005)(66556008)(66476007)(66946007)(41300700001)(966005)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qmt2K2NSdFF5Zjd5MTd6UzUxOEhhbVQxKzg5R3JlaCtxWEZzUFUwajMrVXRr?=
 =?utf-8?B?RkV0a1lzL1p6WVptd0FNTEl0amxUUVZHR2JjNzh1VE9zSlNiK0diUUo1d0wz?=
 =?utf-8?B?bVUwcVl3aWpTVWJ6bWl0cmhwUFJ4ZEJjdCtCL3ZUUjErMGozVnBaNXZqOURq?=
 =?utf-8?B?RCtybE0xdE9SS29pZTNCd0FjbVpBRjRWamZtbHhUeURuekd6aExjOWZZdHFw?=
 =?utf-8?B?RlBPVjJhMVV3U1ErYUpOQ2JLOWV5MUJ3L1F4Y3FzMkhWQlA2eEs2MmgvVmNy?=
 =?utf-8?B?cGJGOEorcDNuaGJCQko3NXBINkp0MFVSWmNtWm4zQlkxVjdxUWFrcW9aSFUr?=
 =?utf-8?B?NXhMR0FkeHRpL3hqbWRGb3hocFRNZjBva2NLSVR3UkdrQUhFNjduczNTM2Va?=
 =?utf-8?B?ZEdGWXJGc0xBaDZHdzZZR09UYk1idU9HOHgzSmtzT1dETSt1Z2tGQStHUU1i?=
 =?utf-8?B?bzUxQlQ2U1JPRTZiV2pDWjdsNThHZE4zS21FVllSQlpwRHYraUhKTS92b1Bi?=
 =?utf-8?B?VzY3UU1GMjFyZzROYkptRXdkWXd3ZTRVcWk5Vjk5NkJHa2RLczFyZzNHMHJl?=
 =?utf-8?B?bjkzQXJFbWUwMlJmVnFOdTFaZ0JqNitvZmFaU1kwUGU3ZW9WWlFrQ1hzYUNs?=
 =?utf-8?B?bW5oelRnZ3dUVS9GaU11OXovT0pvd2tIYmJvZk5QQzBUOC9wZUhXMWRIWmh5?=
 =?utf-8?B?WWhOUWpXNU9IbmpuSmNYcTg3VDVWVEJ2UFErS2FTb1FDc3doTjNjL3UrWXRR?=
 =?utf-8?B?MWNDbk9obkxySGNvc1BWVFQ1SGx4TUpGTmZUMnFMQmRyK0RlTS9HU0ZyQ2Zk?=
 =?utf-8?B?ZTFxT1BpUXFLUDVNWk1uYlF2K0lxbjBKRHRIYm5sWjhveTY5OFVYTFhxSjA3?=
 =?utf-8?B?bGNPaXZEUVFjWlMyU1huSE1iWjZOR2p3ZHVKNXlQVDJtMEdBWTcrUTkyaE1P?=
 =?utf-8?B?d3N2TnBVUEdZN2ZSOGtMTHpxSHZITTh4Q01ZM3Y3djVsQUN3bk9XbDFSem1t?=
 =?utf-8?B?NG5BeUZHdzVhRGZxVkFqVk55TWFscndhdDdmdytCYzcyK05tYzI1dmVHQ2xP?=
 =?utf-8?B?SE11aDYwMjJUL2hCV0NWSDZkRE5zQjlEK3c5VDRGbkZZQmVwMW5YL3N3N3dB?=
 =?utf-8?B?VGxaUm1aTWtnWXM4Z1ozTmpNNmMvd0ZSS1c4MEROZkRnbzRyUDZJbXVST2pJ?=
 =?utf-8?B?M3V3L1RKWjA5OWdQSG9aMDQxRDBpYWtKSThINzQxS01jaUdyRnp2N2tMeEtl?=
 =?utf-8?B?U2Q2WHBIWkR4YkNROHJ0Z000NjBlWnU1WEhzTTFlTlQ3Wk14dklOU3BOdW5m?=
 =?utf-8?B?V1FpMWI1TFBReDdOZkVwV005ZWRCNytmUDZtUU1xblpnM2ZWK3M0emFvaDI4?=
 =?utf-8?B?ZTVneTBSb1ZXTGpiSXdPSTVLWDJlNzB1NjVNdFcxNnFNVWVyWUdzcmVTMnNw?=
 =?utf-8?B?SmxhdlRxeXFvaVVZaGJsVEo5cnVWRUxyYUZiQ1lGRTArT3ltVWd5THlISFN5?=
 =?utf-8?B?QWtyVno1V29GYURhbDRONVJpWUE1bFdJc2tYN3B2QitieXZuSS9DdFZ3OUlB?=
 =?utf-8?B?S1ZLL3RQUXV2OGUvTkZhemFqbEhGM2N2U2lpa09BZmtxcXJPZDJSZnhNM2Q0?=
 =?utf-8?B?ay9KbE9lQkdUTHNRSzdnOUhjU0xYRTlVMm9TMVZ3N2Yxd2lDN2FYVDdlYktr?=
 =?utf-8?B?VkdqNDFwWE1MWnFWd1JZdXNLeER1QUR0R3M2a1l4ZTZyS1ZmTnlGZmFxNUZN?=
 =?utf-8?B?ZkFEVUtoZFVPU2o2d0l0YStqcUdUdFdrYVJqQ3RZQlErUUYyWE1jMmcvaGlu?=
 =?utf-8?B?T2U0YW9OdEVzbnhWK0VRYk5GTC9Bcm90US94QTYyK2tCSHlMcXNUaFJ4U2Jt?=
 =?utf-8?B?cHE2SUN2RTFMY0NJQmg1VXN1U3dBSHRsTktBalNsYUs4ODIwM3NXTGpycGFi?=
 =?utf-8?B?QW9xdXNTS1Z0Mzk5aVI2Rzc3NVo1aVlPY0YrSjIyOFlmeXVqWVo4b0VRVWd4?=
 =?utf-8?B?L1RGWFZ5UXVHdUU0V0xWMnhlMk1xQ2lDT3ZWdkJ1MkszV3k1ZjVESWwzQ0RV?=
 =?utf-8?B?UW1Ganl3dFFibDJIQ0xrYzFZNTcwQVBuenhOai9RaTVRL1lPMFRUd0NOazlm?=
 =?utf-8?Q?nHrS7MSSSl0WdM2jteXLOJAHF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d7d7d4-5798-4b8e-b404-08dbd13d7ace
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 07:23:38.8701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWqmd0zEMib1J/HxqFJBu75gWwtxd2IiM21njuz7OE4UAGRRQuX1XFGZlt8nkbEu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4378
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/19/23 12:32, Kundanala, Praveen Teja wrote:
> [AMD Official Use Only - General]
> 
> Hi Kozlowski,
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Thursday, October 19, 2023 2:58 PM
>> To: Kundanala, Praveen Teja <praveen.teja.kundanala@amd.com>;
>> srinivas.kandagatla@linaro.org; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org; Simek, Michal
>> <michal.simek@amd.com>; Kundanala, Praveen Teja
>> <praveen.teja.kundanala@amd.com>; devicetree@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH V2 3/5] arm64: zynqmp: Add ZynqnMP nvmem nodes
>>
>> Caution: This message originated from an External Source. Use proper caution
>> when opening attachments, clicking links, or responding.
>>
>>
>> On 19/10/2023 08:06, Praveen Teja Kundanala wrote:
>>> Add nvmem DT nodes for ZynqMP SOC
>>>
>>> Signed-off-by: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
>>> ---
>>>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 59
>>> +++++++++++++++++++++++++-
>>>   1 file changed, 57 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>> b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>> index b61fc99cd911..b7433e6b9d6c 100644
>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>> @@ -194,14 +194,69 @@ zynqmp_power: zynqmp-power {
>>>                                mbox-names = "tx", "rx";
>>>                        };
>>>
>>> -                     nvmem_firmware {
>>> +                     nvmem-firmware {
>>
>> Node names should be generic. See also an explanation and list of examples
>> (not exhaustive) in DT specification:
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-
>> basics.html#generic-names-recommendation
> [Kundanala, Praveen Teja] Okay
>>
>>
>>>                                compatible = "xlnx,zynqmp-nvmem-fw";
>>
>> It does not look like you tested the DTS against bindings. Please run `make
>> dtbs_check W=1` (see Documentation/devicetree/bindings/writing-schema.rst
>> or https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-
>> sources-with-the-devicetree-schema/
>> for instructions).
> [Kundanala, Praveen Teja] Missed it, Will run and send V3.
>>
>>>                                #address-cells = <1>;
>>>                                #size-cells = <1>;
>>>
>>> -                             soc_revision: soc_revision@0 {
>>> +                             soc_revision: soc-revision@0 {
>>>                                        reg = <0x0 0x4>;
>>>                                };
>>
>> Wasn't this fixed already by Michal?
> [Kundanala, Praveen Teja] Took base on Srinivas for-next repo and Michal's changes were not reflected in that repo.

Feel free to drop this from series that it can go via nvmem tree directly.
And when this is merged we can add just this patch via my tree.

Thanks,
Michal
