Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064157D8051
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjJZKNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjJZKNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:13:34 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2075.outbound.protection.outlook.com [40.107.247.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D0F198;
        Thu, 26 Oct 2023 03:13:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KP7Qew5Q/IebgzeLyjB6ML6FcPlbtoAWaxMXmUNVQx5nYhLwtPw0h5hR2EFbe6XdGRfWH6V7cli6glmIIRjmmjPPYkglJVPIZvamrAaZ8ciSDdjKtKojpakeSp6mZkeiyb+ZS88oHXlB1e88C5mGvKMEFfcXe9OiDAXpZt221ueAXGutjW1zGA41aC3otpaZgYiX6f7dciN2fyrumj4Q+UVk7vL0CqZF/PXM7otD2CnC9KYkCg6PMNEWoeKa6gE9XzvVa/qBD3qlHh9TxvwuZu9gmafZ8TverQlRsQMGLhoxIvdJwnLjNZ0kCEI4EYCtOi6teSAcxjepfryt6V/OOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vU86Lgx/Cba4DVtl+DHsyuKKrioMs/jT1UesPmT7+00=;
 b=W254FZy6qgVUqDAVTickLIgT/kpQElpSfJdU5Avc9Okhc0IIDQJ8aygpQoU8q+ZpImIp6UKLnA8hkIPCvYn49UyO4zzIueuHqdY18uLDVuwndycsFGWTZV1tk73/ne3sx/rw+itRRfuwJrYcJ7soh2hpZ2/cjj4RbG88otXcftIsCNWyjCjEVp7y/wejlxX6sAx4yy2ejhYKaJ9hdP4+FVkR8SgCs5Z9Mmdze+2Ox9EFtK/+qICdkMmPwbWeqtdkSkkSIj/1H9eqcNajCSY2FnTM01Lhm1CQXnbDV+VHPtoYCw5YJbvbmxi85GI4vaK8VK75UCx5n+9y6zdtM8jbXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vU86Lgx/Cba4DVtl+DHsyuKKrioMs/jT1UesPmT7+00=;
 b=u/iJadvQnJmYwLlJNsIaKcVfW1MgHGN+37PbWPm0B4NGOQ10YT669Qt4O7lcvtidiUPvwmzRcEoeEWwoqz5vTFxcPA7RUuMKh3leBMlq2MGBW0Zy/gpxXh44XEol1y5Idi1Wm+RSFqOm1QGNKvSNfmXZTsZPEClSSHzqoSdoGBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DU0PR08MB9848.eurprd08.prod.outlook.com (2603:10a6:10:443::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Thu, 26 Oct
 2023 10:13:25 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::a309:1d65:f5fb:436b]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::a309:1d65:f5fb:436b%6]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 10:13:25 +0000
Message-ID: <d3dcb034-f589-41bb-8a67-1de8ce51db8c@wolfvision.net>
Date:   Thu, 26 Oct 2023 12:13:23 +0200
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
 <8fec6c89-548b-43b5-8361-869663a58573@wolfvision.net>
 <202310260956166bdcb845@mail.local>
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <202310260956166bdcb845@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0220.eurprd07.prod.outlook.com
 (2603:10a6:802:58::23) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DU0PR08MB9848:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf81278-65ab-4c19-6aa1-08dbd60c311d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k99v89U0BklFehDkIw/hZv0KAo9sSZcqzufQ40mnAhS2m8tHYvgKf5VXLs/lbyq3x9bW4vl25k7SZc4pwdSW6ZTxWIJ85E1CfaInaiwZOUWquXX1GPfjekB/zLwxzMxwg2ywwRs5MwA1iwCPzO+EltYL424G2jA0rYPituUGL3Gv/6vjRd+gL3Z/uheGzsoQ/bTPQDJLaEb0tdW9NsOEJPzVX8n7kShkmP/gx4KznBLVTTl/RK2+p08XAaI4geB6EtrcXZq5NJAbqD7pAHwKYRGeokE3qbKtiXJ01iaRkHrmL6KN25SK+hOvTxpN1c2rwu2HRxw9V965lDZ6OAAzURgrcKdzdZAvv9HBFsgnjk87Z+dS9eaCnSc6ixLXgJbi3PZKUpd+87ClWfv/3+KeyRwkJXVbUWbgxxjRecGLlIBlPCFkmEdvdlU5Pl9b6V/YaZWcyP4E/tzUtb0TEgms4uCzQOZORI+bVUZhA+NHxu2ZRTCpizNNfrFAzb/UJcPG0ZeoBK99SvlsM2urLOvco3kieoHkZgdCcNZAKLQdsyqWFXacsqYrS9IHsu1BKlKIE3b1g3T3J85dpsNXl3/FYJbblu9coeh7+HoonnJ/7ksmD/0uqwyYcUCFtYwQOXYs8x9lTR3rd4jwN5T9kT98Pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39850400004)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(66899024)(2616005)(6512007)(44832011)(41300700001)(5660300002)(6486002)(8676002)(4326008)(8936002)(478600001)(66556008)(316002)(6916009)(66946007)(54906003)(66476007)(36756003)(6506007)(53546011)(86362001)(31686004)(38100700002)(2906002)(31696002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3Y4endhcmFUVkhSRi9nVkQrTExyd2RVd3pJaVZLVHNzeWpHVXIzNkkwVmo0?=
 =?utf-8?B?SEtnaHVlQkRQZGhZWERSbWtZVU9hamErOXRvU0pvNDlpYThKcWh6MlNzUWdQ?=
 =?utf-8?B?a2FRMHBmanByQktBaU4yTjNKMndnczJQSjJJREgrbEtibnJ1ZzI2Qk1wSGRU?=
 =?utf-8?B?QlBDZnduWXM2Q05maXV3bUpEczcxSVZPNFNtb3pTS2p4OW1Xek5VZCs3OUVQ?=
 =?utf-8?B?b2tRUzVrcHBhc0hQUGx0THd0OXd0WHlsNm0wK0VxL0d3dlRTTHYrR2duYW05?=
 =?utf-8?B?c29zTWhlNjNBby9rZW5rOG5EL2UrVk9uVWFYSkw5Y0htbTJrb2xaK2ZLUlhR?=
 =?utf-8?B?TTZoeXppMkpRK1V5dHc1RUs5bVlCQWFJYmNwOHkvdXkxWkNJVmhNWUNldll6?=
 =?utf-8?B?eUh4bGhBWmczanZDTlRGbGRCTkJPdmNDeVNVSHozVG82SExKM3dONUhJUXlK?=
 =?utf-8?B?bTNlNHQxKy9TbkVOVkR2SGhFMzhGaGFDTDc3T0ZhWEF2MUVLeUdCa3lzV1Jh?=
 =?utf-8?B?NkJDL0VMVzUzRUJhWmFvUHNYODdSOXc2cG9UNzB4ZG9yWUF1TjN1WlpLQW52?=
 =?utf-8?B?Z2sycHZlU2Q1anNQZTUyaTlUL2hWak42Ym10eEZRNEVpTXF1SFp6VDZsYzBh?=
 =?utf-8?B?KzBjN1RNcldVUzdXQ0F6S2VjVUE0eCszYWxCODJWRXV5eXlyeUQ5NVJTbWc5?=
 =?utf-8?B?RXFlTk90KyswK0FyVTRVNjhOZ0E3Z0hWbUxmL2t5enZxa1Z0RlRrQUVpQkR6?=
 =?utf-8?B?L295L256cHlRVzF5SHdieUNoYWZ5SGRXR0hacFN2bVFTN01ZbFZUOWIxZ25U?=
 =?utf-8?B?NTVta2ZlREJqcWNFVEwrYmhxQnM1dzZEQS9IMHhmYlRHWTdkN2ZRUE4vZWRN?=
 =?utf-8?B?eWNOcUNsazQwSG16Szc3K21hVCtPS3pyZzE5eGZNNGhvakQxUnA0REtKdU1w?=
 =?utf-8?B?dW1Fb2VxR3B3Wjh4ajFMUlRwaStmUC9aTnhzc3JId1V3SFNVQmYzRVM3TzRj?=
 =?utf-8?B?Mnk0U0l3VnVmTFp1b3E1NnFnaGJUNzBMSWNpUWV5OEV4cmk5bGhid3N2SmFy?=
 =?utf-8?B?enZwUmp5UFJncWFyVTdpWEZsVXc3SGNNQzJrK0hvdnRJbnBiQWdHcjRkdFM5?=
 =?utf-8?B?NXFuNjUzYzlKeWpVVTJHdjhjOFdrRUhuaXNGUnkydk1zU1F6VUxQWGxDSHBh?=
 =?utf-8?B?V3pudHpmaTlhZVFHVUFrNHFReWZ1YnFzcmF5aVliaWFTbXFkZlNNbWNVSWU2?=
 =?utf-8?B?eE9EdEN1dWtFYjZpaDBDT2wvSVBjZDlJdHFGWHlFZWFjVTBLb09nL3krTWlK?=
 =?utf-8?B?aHAvZmY5V2FIVWxCZlY1S2x1RlJnOUlkbzFyWndUMmFScTViOWRNL3VUa2lM?=
 =?utf-8?B?bWpKeUVrTjdxZFpaUTJVRkFYc3lYUVd6YXo2YjU5ajFZRnNqR0taenhiUDE3?=
 =?utf-8?B?WXNnRjR3cmFsOEFjSTlERW5rV01VMmM2Ky9DOWhaVzFvSU9UVzlsWW1KWFFO?=
 =?utf-8?B?UmE2QUtqM1c5OVZETW5Oa3lQOFlidm1WYmpjd3RUT1ZhSFBGV3RPUktlNnd2?=
 =?utf-8?B?Q0VJOURYVUlVRjY0VHQ4VHphWGN2Q1o0YWJuK2JUaUkxdmpKV29oYzlvZm9Y?=
 =?utf-8?B?TnhLTFVacitOenZ4MGJ2OVNobUpKa1dKNy9DbnkzYjlidFVwMzBzMDlGWHhp?=
 =?utf-8?B?emI2bWN4SU1LUmVQWHRUaWppODJCVlJSRlZUdDRYbEIrWG5lVm1UdVdTaHow?=
 =?utf-8?B?YTBIZTlzK1QyL3Z2SFByMzluZTZhclRaL3EvUUVXOEdFQ3JVYmdEVFpMOEtQ?=
 =?utf-8?B?S0hMU1ZUWExkbGNZdHFSTkU4RmpUU0NsbmhSZHBOU1hvVXpYdkV5T2dKbXJi?=
 =?utf-8?B?ZXVqVm9PZ1BiMmRWUWxuU1VVdGVjM29KQkZlTkR4MU9xK01xVUFzVEdWUDhT?=
 =?utf-8?B?Vyt4WHNwK3ZsRkQrdEFGYmYrNWNuY2RuMjJCQW9WQmJ2L2xITUxlMHpWNmpw?=
 =?utf-8?B?eGFwNTQ2TFFNYS9od2FPU01RRmNqYTJKc1BGRUk5Z1FpQytnOHVSakRsbjY0?=
 =?utf-8?B?cUh2T05VOFZJdDlEazB5TkdITllpenFQcFY1Wm1TQ2x3OElTOFNYVXRHUTJl?=
 =?utf-8?B?V3dUb09GZW1nTXJqTk8yVjVjUDR3Q0NoYTkvaHgrZFJXZlo0Tjd0UlB5UDMr?=
 =?utf-8?B?T0NSblVZNEUxMmJrYXR0VjFZNXFnaTlRNUFtWFZaNFY5L21SNU9vdC9mbDlq?=
 =?utf-8?Q?4+u0Hc0cC0WkHWEPg4GmcuhpoX0lGEZd4XLeKp3L24=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf81278-65ab-4c19-6aa1-08dbd60c311d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 10:13:25.6489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yp/dnjoSqN0pWQdUkK9vvQq/0zgdrIYfGv82pxq7n7NzVj2eB1i88sfkKyu+ysL4BqqqGZ4TgYmsMJcvKjMXDcO0oS+8EKJiPM191oDp/2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9848
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.10.23 11:56, Alexandre Belloni wrote:
> On 26/10/2023 11:41:47+0200, Javier Carrasco wrote:
>>
>> On 26.10.23 02:50, Alexandre Belloni wrote:
>>> On 26/10/2023 01:23:21+0200, Javier Carrasco wrote:
>>>>>>> +  hiz-output:
>>>>>>> +    description:
>>>>>>> +      Use enabled if the output should stay in high-impedance. This
>>>>>>> +      mode will mask the output as an interrupt source.
>>>>>>> +      Use sleep if the otuput should be only active in sleep mode.
>>>>>>> +      This mode is compatible with any other output configuration.
>>>>>>> +      The disabled value acts as if the property was not defined.
>>>>>>> +    enum:
>>>>>>> +      - enabled
>>>>>>> +      - sleep
>>>>>>> +      - disabled
>>>>>>> +    default: disabled
>>>>>>> +
>>>>>>
>>>>>> If instead of using a custom property, you consider this as what it
>>>>>> actually is: pinmuxing, then everything else comes for free. With
>>>>>> pinctrl, you can define different states for runtime and sleep and they
>>>>>> will get applied automatically instead of open coding in the driver.
>>>>
>>>> I am not sure if your solution would cover all my needs:
>>>>
>>>> 1.- With pinctrl I can model the SoC pins, right? That would not stop
>>>> the RTC output though, so the 32 kHz signal would be generated anyways
>>>> even though the SoC would ignore it. That is one of the things I want to
>>>> avoid.
>>>>
>>>
>>> No, you would model the INTA pin.
>> I am sorry for insisting on this topic, but if I get you right, I would
>> be modeling an interrupt pin (INTA) to keep it from generating a clock
>> signal when the RTC itself offers a high-impedance mode i.e. avoiding to
>> use the RTC feature.
>>
>> Is that not a misuse of the INTA pin in the first place? If there was no
>> other option, that would be an easy fix, but why would we not implement
>> the hi-Z mode when it is available? If I see a pinctrl-* modeling an
>> interrupt pin, it is not obvious that I am doing that to stop the clock
>> signal and I would have to clarify it explicitly, especially if I am not
>> interested in the interrupt.
>>
>> I would rather implement and document the hi-Z mode the RTC offers
>> instead of using another mode like INTA which actually can trigger
>> interrupts. If the implementation must be different is of course another
>> topic.
> 
> There is a pin named INTA, it can mux 4 different functions:
> 
>  - clock output
>  - battery mode indication
>  - interrupt
>  - HiZ
> 
> with pinmuxing, you can select which function you want for the pin. I'm
> not sure what is misused there.
> 
> Can you explain what is your actual use case? I'm starting to understand
> that what you want is simply disable clock out because you are not using
> the interrupt.
> 
> If we assume we are never going to use battery mode, then we could
> simply used the CCF for this like the other RTC drivers.
> 
I want to model the INTA pin as a clock source that only should run in
sleep mode because its clock is only used in that mode. Therefore I want
the pin to stay in hi-Z during normal operation.

I do not want to get any interrupts from the INTA pin and the battery
mode indication is not relevant for me either. I do not know the CCF
mechanism in other RTCs though, but I think that the hi-Z mode
accomplishes exactly what I described.The assumption about the battery
mode is therefore beyond my knowledge, but my first reaction is that we
already have the hi-Z for that.

So in the end I just need a mechanism to configure INTA as hi-Z, which
the driver still does not support. There is another application where
the clock output is not required even though it is physically connected,
so hi-Z is again an interesting mode and the battery mode would be
available if it ever becomes relevant for anyone.

