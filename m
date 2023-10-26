Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CA17D7FCF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjJZJmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjJZJl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:41:57 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2041.outbound.protection.outlook.com [40.107.241.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CA6195;
        Thu, 26 Oct 2023 02:41:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bxxa6neCJDPYZjLS1A5tppBlRNIjZoA2GHmlFCUq+wKEDVcyd5s/hb6IOYmWK4XZKjYYesDPTaItlalFNJmUJMFV5QF7JjXqcAQVqmKLI5WzLJt75uPWbI9gtLj0+Z8o+LVkpGPffifJQwkmkC8iGnEJdz67dwRkQHGdiq+cCSdKPsLoe8sNfIrDcgwY4HuAcuVhhbdADDDUJer75f01KMfx5Nizdzhv0iJF46r6zvZNWUizHvo0HlbrjAcOUc7lX3HhS1sLAoWNquAJ77KbIGKHLOKiunjSXUEc69vJG6ytyGLfXsjlJswEvV54WAQ8QlNiC7ZvnpZH3LfRFlMqow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ow5pvRSFci8FURhEb6dW8RZBuwo3nFVFJVsIf2pNDYQ=;
 b=PnQFHXAVN/z8+3Q7jniCUUSJ2o7dkdjN9fcm0WotCSm4bN28CiWRbd3TFtbUmUObOQILIQX1fJ5GYI7dXT0UJqFA9GB+1g+Uy6DDOJYINPrRMlR4h3om5+co80pYzn8CKcjkli2C7sYvINiSse3XURtTAoVpRWL1lq0IMblJS2+XDlxqrH+W9L+vIdm/1aakxA0Cx5brONhtxmVchf0PR+0PzUgW4SGghLo/s/2Sjv5otSXcAGkGmolLCS5NJZDMUOzF8iyVq/TpJ49ogPoL7N5eZtMIz6n1UlTVskMMnbOEl/XgPixK9lexjbYjApwR3BY/LumYSGI7oZxra6F8NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ow5pvRSFci8FURhEb6dW8RZBuwo3nFVFJVsIf2pNDYQ=;
 b=YbtCQN7lGvNMX8ALIehCH9arZAAlLuw4lSo+mxaTxfOY5bZMXtYAEDSLjLw7n6mR2v6qOs0SYIdtxOqIHkRjsKA54ZmvxYqFT+bBqBe15e/J5+Tyb77g8/cQYTVr1CMgenpQSksM2B2o21hDjVZCLdsrvSXc7zM3qpNrwcI2OrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DU0PR08MB8929.eurprd08.prod.outlook.com (2603:10a6:10:464::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 26 Oct
 2023 09:41:50 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::a309:1d65:f5fb:436b]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::a309:1d65:f5fb:436b%6]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 09:41:50 +0000
Message-ID: <8fec6c89-548b-43b5-8361-869663a58573@wolfvision.net>
Date:   Thu, 26 Oct 2023 11:41:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: rtc: nxp,pcf8563: add hiz-output
 property
Content-Language: en-US
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20231024-topic-pcf85363_hiz_output-v1-0-50908aff0e52@wolfvision.net>
 <20231024-topic-pcf85363_hiz_output-v1-2-50908aff0e52@wolfvision.net>
 <20231025222327c0b5d460@mail.local>
 <2f17c031-30f6-4242-b2a1-1628402b3091@wolfvision.net>
 <1c4a6185-fe09-45d1-900a-10abf48e3fc9@wolfvision.net>
 <20231026005008b8255799@mail.local>
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <20231026005008b8255799@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0253.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::26) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DU0PR08MB8929:EE_
X-MS-Office365-Filtering-Correlation-Id: d1853ed6-ff56-42e8-fcae-08dbd607c74c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3lhhLBGlVVt9vNbUL5ejobEF9c+r45qt0uozNMyauujWOHUcJqqik/5zvLqRGImNx2E38+LoclW4Pla1fbC1vZ5gXutBqFhSHO88zYj9kvg4Gvqb3bx2YI1kydLZAjwr+fSbtC1j13cOg+a7BkqFePlitENeO8XKUm658Ia7UnSgdprSd+lP55VmVnZdrWP7UVCdwlq/5aZ5kQQf2eEij6MPK+Mk50r6gbgdPPYIJP/VK3xz09qMWakFGQGb7n25/Bo8SrkbYR6rJ4FNcfY11UtX8LLutj9CPK1pWlknvbBpB9KbEjxXeTa+rc2Ne3Kz0JSDGIPMd8zwizVdXUrrHTyMLzV9par1tuFugqfTYPIgP55A09dXY/YPnkRamD1uXfvtOoQur8J9lXFButf9OnOpv45whKM9xxr40zjispsnApQb1M3XaU+iITHWr5RJq3BIVlxiTy+vhhEA2dfQqbj8keipttlbVn6POvpFC8phg4aq7MwWF4SRcWx2Pv69liUxmibs4YWHBfL4R81aX7QimGksQMeOks7kL73v6o5BzNA5ZEFH2xQeynK4xE+kWsTprI4F8lFyYJGFQTzit+54OqRfHSdeAmt7uaYHDLKTF3wswmyq24A+mJx2NKHfqp/cTj4kUu6GejFvP3ojRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39850400004)(136003)(366004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(66476007)(6486002)(66556008)(66946007)(478600001)(6916009)(316002)(54906003)(38100700002)(41300700001)(31686004)(86362001)(31696002)(5660300002)(8936002)(44832011)(8676002)(53546011)(66899024)(4326008)(2616005)(6506007)(6666004)(83380400001)(36756003)(2906002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akd1dEJLWU5iRjdMS2EvYUgrWnY5bndOOFN6M3lzaFNlbXk1QU9waHRnMmFH?=
 =?utf-8?B?L01pYlNacHM5WWFwTDV2TUxRdWhxTlZraW1SM0s0K3dQUjV0NS9vcXlNSWJy?=
 =?utf-8?B?MUQ1eDdTVzk5SCsxc0JvVGdnakdBM2xXUHNkdmFDWHZFUHBmQnIyNnUyMWVI?=
 =?utf-8?B?VXR2NkdTbStZVHJPVWFPY2hib0NSTGl3NWpqZjRoYW9qTGVXdkdZRGZhMGI0?=
 =?utf-8?B?NWVwSExsRWtvODZ4U0gwZUJ0bVZ4azI5dmdRaU9CNmlQYXdhaHI3dHdOTllG?=
 =?utf-8?B?T1g1dTY3L1JFdHVFMVh4eDJjUlVXZW9BVGRyTTU0MllaUWNSdGhnbFp1dVA1?=
 =?utf-8?B?eElmMkQ1TG5DZ3lObGoyQ0RqblZmUyt4UDI0TzM3S1NtSHM2eHVSVEhlMDNa?=
 =?utf-8?B?aGhJRjZQN0JwaUd1TTNYZEVWdG45SEZ0OTA1cWkwZ0tjenk5Z0tWZHhLOFNa?=
 =?utf-8?B?aXhFaXZGcU10cTBOL1hhMmZSMUU0NldUNWEyQk1ySE42OSsxUTE0YWFiNitQ?=
 =?utf-8?B?dEw1b0tHUWdqWVdRNm9nWjcwUHpmN254MnUzWmZiMTFiTHphampmZWpmTmZu?=
 =?utf-8?B?c2MzcGVkTUV6NCtUZE5hbis5MHhoSDFFSTdXVlljREo4SnY2L1A4amNxVFBv?=
 =?utf-8?B?NTNKU1VhRHcySkIzOGluOENzVjZWWjVydzcvNU9OTWNwajd3djlpWk1ncjUw?=
 =?utf-8?B?bWdNajRhMkZadURvQisrb2xyOXZ4NW9XYzZiWXo3Yi8yZDZzMllOQ3ZweUNN?=
 =?utf-8?B?UEdNd3M3NXkxanhuMW0xdjgxTnNKRXlUOFJmeXk5UnJCTjVwY2E3T1F5Mmxw?=
 =?utf-8?B?MCt0SUVYRElxVVZ0OG01L1JXaFhkNGR5ZkxmeHF2UjNuZExHVk5vZ1QwSkg5?=
 =?utf-8?B?a0VzR2hJaGplZEROSTB4T2thT05VVFdmVldESEU4amVKU1hNOUtQL2Jrd0d3?=
 =?utf-8?B?Sm94cFdXREQyTWJVeklQNWMrWEtyMFN1T0dBVkpnN2loYjc3N0JpVjlFTlh5?=
 =?utf-8?B?eGRXSkR4OWRkNmVBZlB1NzFiU1h4U2RVaVRLVUpaN2x3bXpzWlpybTlhWnFP?=
 =?utf-8?B?VHJ6aWhVamh3aFAzUFFlakprMjhDVFkzdWZCY29zVFlkL0liMmpqRG4relZV?=
 =?utf-8?B?NU9IQ1pJUWtWYVI5Q29KTEUyVXNrN0lzVXBZSGgrQXlHRUZyd1V4d2tpb3I2?=
 =?utf-8?B?TnZmRVR1WUJFZFBzWWlEbjg0dWtFK0U5SVJ1TWxUbUEyQVN5Qk1kYzlFaEo3?=
 =?utf-8?B?TTFUaGg4V3JJSjB2cFFOZmxNcTBZdUpweUR5YnRXVk9wck5aVUdVRnM4YTNL?=
 =?utf-8?B?cGdCTXBQNEZ3TEVLeEpmMFJoSnV4dWU2RHI4Y3hTcm9uRE5aSE1GNWZFVHBV?=
 =?utf-8?B?K1BpL1JaemFhaDFpTWdIQXFrNjNlOHRYR0tYOWVuZUpMSEtUUG9qM3R6RVRh?=
 =?utf-8?B?QkRoZjRvTnVrVkxTQitYVnVaVzgycVJrc1hkNmFDazIwSVhpd0JpTFMxdDBK?=
 =?utf-8?B?WC9sVjY2NnIvWEZrVTlGNEFHeE1MdnlVcU5uaUU3QUhJL0c5WmNXbmhHTGkx?=
 =?utf-8?B?cEc4a3Znd1d0ZlJxajVCTlhZem9hY3JBL05JMklvcVM3R3FkdWlEdDdLOWVs?=
 =?utf-8?B?aU53TS96WGV0TDNxNllZRmEzZkx0Si8zdU1rRis5MGxqb0RwRWtNRUQvYS90?=
 =?utf-8?B?UzBwaytHTjZrQVExTUNyMjZzamJxY1REUVF1ZUdNZ3JCMlhsZWwxUFc4d2lY?=
 =?utf-8?B?YkZteUNYTTlOY1pqNmlNbGU5WmxOdStSRUdMbWZYcG1BNjltQm56SEYxVG5t?=
 =?utf-8?B?bHlndWxnOEZNWTlXTFA3QVdOUy8xQkI5OHJHcW1KYStuNkJDUHE5bHFFVkox?=
 =?utf-8?B?QTdZcE0yaHdZMEdwV0E0QmVsd0lsMHdUU29PUGZYOVozOGF5YjZSWmJSdGNy?=
 =?utf-8?B?RUZHSENKV3dmQ3BCbHpmbCthaFJSWFliKytqa3dzNXdyVmZiMWR4M09nNVhP?=
 =?utf-8?B?TEluRlhmUWVkQkxHditDMENNMEtHVG1VS0dleWcramJoMWh6eFRuRGtScisz?=
 =?utf-8?B?VkUyWFAzeUIzQllaZXN0QnhRMXVWc3BCZ1hxanh5Y25kTjdMbllQSXdxNHNT?=
 =?utf-8?B?WXNRdUtFNnpxU3NRTm01SmhYWTh0TCtGVVZ3QzZZL1FFYUxFREJZSThoOURz?=
 =?utf-8?B?SWM5eExWQ0tRRHBUOVNGSGFtM2M0T0ZQL1JucnV0Y00vZUNuNVF3bGZTMkNW?=
 =?utf-8?Q?EKwLTQMzaW3+Jp/8dSw1TXRvWG6bBlwfMQU5X5IfWw=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d1853ed6-ff56-42e8-fcae-08dbd607c74c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 09:41:50.1593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Xhz09IsqFQNgQbAT96iDN7YlQDJOvT5N5dfP5luRNhqQGBnBLE7xH8c2Sw6OoQk2qIqBZAetFjjN/PZzWl4jCUTbzsNu5n3B7pA4RqznFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8929
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26.10.23 02:50, Alexandre Belloni wrote:
> On 26/10/2023 01:23:21+0200, Javier Carrasco wrote:
>>>>> +  hiz-output:
>>>>> +    description:
>>>>> +      Use enabled if the output should stay in high-impedance. This
>>>>> +      mode will mask the output as an interrupt source.
>>>>> +      Use sleep if the otuput should be only active in sleep mode.
>>>>> +      This mode is compatible with any other output configuration.
>>>>> +      The disabled value acts as if the property was not defined.
>>>>> +    enum:
>>>>> +      - enabled
>>>>> +      - sleep
>>>>> +      - disabled
>>>>> +    default: disabled
>>>>> +
>>>>
>>>> If instead of using a custom property, you consider this as what it
>>>> actually is: pinmuxing, then everything else comes for free. With
>>>> pinctrl, you can define different states for runtime and sleep and they
>>>> will get applied automatically instead of open coding in the driver.
>>
>> I am not sure if your solution would cover all my needs:
>>
>> 1.- With pinctrl I can model the SoC pins, right? That would not stop
>> the RTC output though, so the 32 kHz signal would be generated anyways
>> even though the SoC would ignore it. That is one of the things I want to
>> avoid.
>>
> 
> No, you would model the INTA pin.
I am sorry for insisting on this topic, but if I get you right, I would
be modeling an interrupt pin (INTA) to keep it from generating a clock
signal when the RTC itself offers a high-impedance mode i.e. avoiding to
use the RTC feature.

Is that not a misuse of the INTA pin in the first place? If there was no
other option, that would be an easy fix, but why would we not implement
the hi-Z mode when it is available? If I see a pinctrl-* modeling an
interrupt pin, it is not obvious that I am doing that to stop the clock
signal and I would have to clarify it explicitly, especially if I am not
interested in the interrupt.

I would rather implement and document the hi-Z mode the RTC offers
instead of using another mode like INTA which actually can trigger
interrupts. If the implementation must be different is of course another
topic.
> 
>> 2.- What happens if the RTC output is a clock for an external device
>> that is only required when the SoC is in sleep mode? In that case I
>> would like the RTC driver to control the output with the modes it provides.
> 
> Even if I doubt this is a valid use case, this would be possible as long
> as the external device node has the correct pinctrl-* properties.
> 
> 
>>>>
>>>> Also, how you define this property means that everyone currently using
>>>> this RTC is going to have a new warning that they should just ignore.
>>>>
>>>>
>>> Thanks for your reply. The warning can only be triggered if the property
>>> is defined, so in principle no one could have that warning yet. Only the
>>> ones who actually define it and use an invalid value would get the warning.
>>>
>>> On the other hand I did not consider your approach, which might make
>>> this patch irrelevant. So I will have a look at it to make sure that it
>>> achieves the same results.
>>>
>>> Thanks again and best regards,
>>> Javier Carrasco
>>>
> 
