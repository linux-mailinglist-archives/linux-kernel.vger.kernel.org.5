Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1518D7EE4DF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 17:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345356AbjKPQAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 11:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjKPQAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 11:00:33 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2055.outbound.protection.outlook.com [40.107.247.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CD21AD;
        Thu, 16 Nov 2023 08:00:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7oNF9mAJOOWzuYk3mCoReOks4QVja9EpKisVSr7bi7i/rWT7Xe9oHG+FEf3zjPHvjF8TtwTtlsZ61+vSIA9Bjjr/Bb5IGvjl6pKCYbP1jAXBCwSbHQRQ12sYc9o6VpU9F2slcx/idbtWCVBYAbakGHZY9fM/n5Yw6XBilNdUmg4SUo1LuIbzCeQOEx2YDf6CDRfJoLaRqaJFX/qM4+L1RIWaKPIcKj8QIsUN2RkV4FJNzrPiUftT1NdKMoFIEe9zSZ5iTPfTdVQ9ASrUCKJ8GOxKFSZArPvVbMY5GJLjt3plb93VOJJ/cAElNZGSDi0eBZvzbbT7pAjRT1hFSaeZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8LICqfskccjVVPVKvYb+txoQL8I85WDna+5rUbUqz0=;
 b=BOUh32/QHkYqrO6AdjboppdyFykT8hq3LVB5h9Y+SXNZNOphy3AKMxMfJz6wyJX0rtiFZm6tuxralofyZ4GlBUPtntBMTn6CtMS2ndNNXvBspdxFcRtZyFwJ759HvVDWSc6qmqaKXQCXawbrHZ3BmLyS8DGKaa3W2biFIRR3DMlpZvq9DI/XcwUnkVIW7xaxoHaZ92mKeHiagoggNhxaRQUE2wvWfIm03PAufHwOGJqWd14pnzzhXuiZDXA17pCUN6bABQ0IAXX3s95JkAv2ZHHovsOlEMkZso7tmwIPvAIWH8QAWlGtyK+uzz6KpoARXZ0+RPp06b/Ylkmx20xi2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=2n.com; dmarc=pass action=none header.from=axis.com; dkim=pass
 header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8LICqfskccjVVPVKvYb+txoQL8I85WDna+5rUbUqz0=;
 b=on49I4naEbGHgaSecje0g0CfjPqMzqpKPVu62/7OT0DnaSLlM0SZRGLA4k4H8BSzUNB4E6BL9mtO+CV6gHviBkOhkHJNGc19pnBqoQQsNyxEGGI/XwAe2LcxxJKHiL7BM8VqVn8K47Kfm9WU48QBxlHHigWzIPDr/xvbmAYU4dU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from PAXPR02MB7263.eurprd02.prod.outlook.com (2603:10a6:102:1c5::18)
 by PAVPR02MB10413.eurprd02.prod.outlook.com (2603:10a6:102:2fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Thu, 16 Nov
 2023 16:00:23 +0000
Received: from PAXPR02MB7263.eurprd02.prod.outlook.com
 ([fe80::dfa8:c276:ca2e:b053]) by PAXPR02MB7263.eurprd02.prod.outlook.com
 ([fe80::dfa8:c276:ca2e:b053%4]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 16:00:23 +0000
Message-ID: <368eea0d-0445-4286-8489-9a4a109606db@axis.com>
Date:   Thu, 16 Nov 2023 17:00:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dt-bindings: input: microchip,cap11xx: add
 advanced sensitivity settings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        krzysztof.kozlowski+dt@linaro.org, dmitry.torokhov@gmail.com
Cc:     devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        u.kleine-koenig@pengutronix.de
References: <20231108155647.1812835-1-jiriv@axis.com>
 <20231108155647.1812835-2-jiriv@axis.com>
 <eede2e04-45e5-46fb-ba00-fec0a7862711@linaro.org>
From:   Jiri Valek - 2N <jiriv@axis.com>
In-Reply-To: <eede2e04-45e5-46fb-ba00-fec0a7862711@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0233.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::6) To PAXPR02MB7263.eurprd02.prod.outlook.com
 (2603:10a6:102:1c5::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR02MB7263:EE_|PAVPR02MB10413:EE_
X-MS-Office365-Filtering-Correlation-Id: 7537b837-ceea-4711-5f34-08dbe6bd2410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cs59JSv00Ik9vO/p5xVZzqIp9Y3xr+Y8u5ka2tXPxQlXpRV96TaGfbV79THsjddZVJPLIJ4tj4I7Lp4Eb3fsMnnMO/NLk5yhEZnfhSbwbGbliL2kRAcUaIFwaXdgaUyTrfPWZuoyCEk8B6S/R9UoEDp9pDQZcLh76ezi6dO5QPtoYGYIzBD/3otQAL2Dd+xsen0rdDo+ie6OftVuQXbBbrXJewj/vZtoOZXfbH3MPbDSbSpqz2HlzdgSuixcZ8FlQKGezgRkF6MSOR5rhXMLCWRBCeKAGpfMlamEbGpYouvOCSYgFs1S2bzWC3T0WdaLwdqknCdc6uuQ9NawF03djWLHQnZqHudWobL1GtjiESWS85hVOHLUQbxaMvxEOtracP/W87uO54NA79TrvenF2ozTnDE5SJjxLQSDzaSFuaSmraijZY+zzDhrCwVYqtLv4luGo1EnxTdPLAyz3t6gSYtJM1YxPA6Z1xweKt/xl1mAxkYTTjAxXOchp5QN/0UtHSw1An+tOwqs6jXgyIc4N1sq3w49UCns4xQPy45g6glefDI8PaxADpDdda7Z07QiKD6ZxNr/avsPw6Yk8QDigNnf7892KglJkFRVvJbkfQHux6Xwf6v5J11ZM6jR370QGMd78gaIQaXmmZkKQ4X2IQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR02MB7263.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(36756003)(83170400001)(38100700002)(2906002)(41300700001)(5660300002)(66476007)(83380400001)(6506007)(31696002)(6486002)(53546011)(8676002)(8936002)(4326008)(66946007)(316002)(66556008)(478600001)(42882007)(2616005)(26005)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmlqZDREb21IcVVXMUxZc1NNUkxQNVQ4ZWFaNWJ3UkRCOSs0VHZvTVhzdVR3?=
 =?utf-8?B?QUd4ZDlzUmlydVRjd2xDbTJ5cVpnRU40MnZKcUFtUkZUT0UzMlJjVUMzVFYz?=
 =?utf-8?B?Qi9xQW1GMzlocDJDTVQ2dWZuRmVkWDFOWktlcTd2WDVzOWwvSHJPRksrZVda?=
 =?utf-8?B?ejJlelIxSkxDVWUycTlNMDhlYmQwengwcEdNNGU3QXpnS0MydFdGV1pwWXU2?=
 =?utf-8?B?aVY0SndNSGoycWp1NlExM01KREdWd2Zxa1dERzNLYlA3eWRweWs0VzZ2cXNR?=
 =?utf-8?B?SG96K3B5aU1Ca1UzQVhFWnFFREtTOEFTNUJ3c0FzTzdOa3d5OVlSQnRSeEV5?=
 =?utf-8?B?dzVYcjV3NU5mTWtZamE5eEJaS29Ndy9VY3c0SEUrMXV1NmtQdmRKV2hxRk9T?=
 =?utf-8?B?R2FEOXpma3RJOS8xNDZjNnA0L0V3T2VBSCtGWXdwSXBqQlZ2UHJIYVl4QWNs?=
 =?utf-8?B?SzJVRFpvTGhac1l3cnlma0JHSTA4R1hPUFJlaFdNbll3MjJvaTlvYmxFZ25R?=
 =?utf-8?B?YlQxL1pGMGxob3V5QXdBamtUQ2EyTWtmSUtkbEVLV2I5RmxmTU9nSnV4aTlZ?=
 =?utf-8?B?UkxiRXF2QmZ0WjJNTWMxTmxKdXJLeVpCQWs5dTE4LzR4Z2lVbkM4Tk0zeGhz?=
 =?utf-8?B?Ny9ieTdrMnFIS3BZM3E4SlJZUHY2YytLZlRmMmhYc3daUjZDY3hEaXVuM051?=
 =?utf-8?B?NjB5cFh0cGFtb1l0SnorcmN6TjVWbkN6YytGVldFcDVNcVNBWHphMzNSWXRW?=
 =?utf-8?B?SXI1TGlWblEvK0YrVi9wYzgwZ2taQVBkcWpDZjlrYjlRb3l5RC9VbGpvbWJR?=
 =?utf-8?B?cnhTaVB0WStUN3FUYkJCTUJPQjRMSXRCcjdzZEZGc2JCRjgxbGwzSklpK2hi?=
 =?utf-8?B?L0JMRXFmWkpPMUJRYnNKNUlTUURQRVNvSW9KNjNRQzRwdE9pV1JrS2k4YmpZ?=
 =?utf-8?B?SXFpZ0hzeTdFNVZpVFdFakl0dU9pNmR4Tmg0QWJtRWdsMG5JL3AvbTA5cE5S?=
 =?utf-8?B?MFF4VjNKbWRvRHRzdDh4b2R0QlVTV0UwWjBlODdiK2xHZHZSVzRDVHlVcHJY?=
 =?utf-8?B?QlJsWmlTZnRySkM2TlBGWjZGdTZkbklUb1owU1RZT1pJOXJOZXlRdjdyczVv?=
 =?utf-8?B?LzR5cldaRU5SUklmZ2RJQmxvSGtyWTdPc3VKTXRUbmNsWjVETHlzRXE2L3lm?=
 =?utf-8?B?SFZVd2ZwYnY0S0Q4V2NFYVJLMUdFY3JralIzZnJYTEZ2MGFHRjJveHpSRmd1?=
 =?utf-8?B?d2tOQmV2NWEvT0RzQVdsWFZEdkk1TEdNbG1pTkxWTmlENlU1YXVuWDBWWm96?=
 =?utf-8?B?bDZOS0hsc3lHN2NaRDRPUzRzczhzS2g1NXpsOTdRMzcvenBRajBIUG9ucEEr?=
 =?utf-8?B?aFVhdDRlSS8rcVU3VjQwcXA2b0NuUFRvWStxYzVHWmxkN3AvNEd5U1lsd3Jy?=
 =?utf-8?B?RFRSYkdsYWJPaU5admhmMlZLbkxLOEN3UWN0WXYxcXFiNG5RWUprOGtiOFNR?=
 =?utf-8?B?L1ppd3NLN1lEdG91eXhZTkpqOXJneGtwQ3NzWlg3cGpnM0NLVEtWc1YwWE50?=
 =?utf-8?B?V0VLS1ZOMk9LdjQ0bURnT3J0akZTZGJGMzdFclc5eGhRYkc1c2RmUmxCOUlI?=
 =?utf-8?B?eTNQNGFKYnByMTZtZ2Q4QWZXdmxXMU9sZGpMa1kyZWk3aFBZZUFOSWZNZTRO?=
 =?utf-8?B?b2ZNeU5ISjZxaDZ3R2NWVE0wWDUyazNGN2JISnJDeHFEYWdzdE90aURvbGFo?=
 =?utf-8?B?R0xhZk14UHdEeEx0alhVS0Z0MkNnYXlud3lqVzdTZXd6L0ZuTC9NRW9Pd1lH?=
 =?utf-8?B?cmoxcVpPSGRGS001clZFaXhBYnAzYW5VeTc0M1p4anphcmlZWWNYUGtHRFFz?=
 =?utf-8?B?RDk1TmpsUEpPR0wrak9iSStuYVk3T1VUcmY1YUcySmlneFlnVUhLVU5Wa0dh?=
 =?utf-8?B?VGhCU210dFRFWWcrcmRQVG5DY1VFaHFyV3ZzYU9sQWxkTnluSUhxYXlnQ1oz?=
 =?utf-8?B?dldTSlpxaHg3RlE3TnloNnprQzNsWnVEN3U4VE5PSFQrd1N0T2dmMWdLVXdH?=
 =?utf-8?B?VDlvTG5EenppbUl1dG5BcjdxYXcyZ1pIdy9MeVAvcHdTR3MrVnA3b3QxSUJS?=
 =?utf-8?Q?XqlV9SEKD6OGQf/Ee6ZIIUrDq?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7537b837-ceea-4711-5f34-08dbe6bd2410
X-MS-Exchange-CrossTenant-AuthSource: PAXPR02MB7263.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 16:00:23.3675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgEAtFMbwx51xiWYA/X4kESSx3UvvaEOCSi8Lg22lw5/Yuh0jEn2cnG2lx4thRd9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB10413
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/23 09:22, Krzysztof Kozlowski wrote:
> On 08/11/2023 16:56, Jiri Valek - 2N wrote:
>> Add support for advanced sensitivity settings and signal guard feature.
>>
>> Signed-off-by: Jiri Valek - 2N <jiriv@axis.com>
>> ---
>>  .../bindings/input/microchip,cap11xx.yaml     | 76 ++++++++++++++++++-
>>  1 file changed, 73 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
>> index 5b5d4f7d3482..aa97702c43ef 100644
>> --- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
>> +++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
>> @@ -45,13 +45,13 @@ properties:
>>        Enables the Linux input system's autorepeat feature on the input device.
>>  
>>    linux,keycodes:
>> -    minItems: 6
>> -    maxItems: 6
>> +    minItems: 3
>> +    maxItems: 8
>>      description: |
>>        Specifies an array of numeric keycode values to
>>        be used for the channels. If this property is
>>        omitted, KEY_A, KEY_B, etc are used as defaults.
>> -      The array must have exactly six entries.
>> +      The number of entries must correspond to the number of channels.
>>  
>>    microchip,sensor-gain:
>>      $ref: /schemas/types.yaml#/definitions/uint32
>> @@ -70,6 +70,55 @@ properties:
>>        open drain. This property allows using the active
>>        high push-pull output.
>>  
>> +  microchip,sensitivity-delta-sense:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    default: 32
>> +    enum: [1, 2, 4, 8, 16, 32, 64, 128]
>> +    description:
>> +      Optional parameter. Controls the sensitivity multiplier of a touch detection.
>> +      At the more sensitive settings, touches are detected for a smaller delta
> 
> Which values are more sensitive?

Higher value means more sensitive settings.
I will add this line to description.

> 
>> +      capacitance corresponding to a “lighter” touch.
> 
> Looks like you use some non-ASCII characters for ".

I will fix it.

> 
>> +
>> +  microchip,signal-guard:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    minItems: 3
>> +    maxItems: 8
>> +    items:
>> +      minimum: 0
>> +      maximum: 1
>> +    description: |
>> +      Optional parameter supported only for CAP129x.
>> +      0 - off
>> +      1 - on
>> +      The signal guard isolates the signal from virtual grounds.
>> +      If enabled then the behavior of the channel is changed to signal guard.
>> +      The number of entries must correspond to the number of channels.
>> +
>> +  microchip,input-treshold:
> 
> typo: threshold

I will fix it in Documentation and also in source code.
Copy paste error...

> 
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    minItems: 3
>> +    maxItems: 8
>> +    items:
>> +      minimum: 0
>> +      maximum: 127
>> +    description:
>> +      Optional parameter. Specifies the delta threshold that is used to
> 
> Drop everywhere the "optional parameter". It's redundant. required:
> block tells what is / is not optional.

OK will be fixed.

> 
>> +      determine if a touch has been detected.
> 
> In what units are the values?

According to the datasheet it is dimensionless, no more info.
A higher value means a larger difference in capacitance is required for a touch to be registered.

> 
>> +      The number of entries must correspond to the number of channels.
>> +
>> +  microchip,calib-sensitivity:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    minItems: 3
>> +    maxItems: 8
>> +    items:
>> +      minimum: 1
>> +      maximum: 4
>> +    description:
>> +      Optional parameter supported only for CAP129x. Specifies an array of
>> +      numeric values that controls the gain used by the calibration routine to
>> +      enable sensor inputs to be more sensitive for proximity detection.
> 
> Gain is usually in dB, isn't it?

Usually yes, but again there are no units in datasheet.
There is note that gain is based on capacitance touch pad capacitance range
1 - 5-50pF
2 - 0-25pF 
4 - 0-12.5pF
I will add this to description and change items to enum: [1, 2, 4]

> 
>> +      The number of entries must correspond to the number of channels.
>> +
>>  patternProperties:
>>    "^led@[0-7]$":
> 
> 
> Best regards,
> Krzysztof
> 

So are these changes fine for you?
If yes I prepare new patch revision.

Best regards,
Jiri
