Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82405755CCE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjGQH0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGQHZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:25:58 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2102.outbound.protection.outlook.com [40.107.255.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D315410C8;
        Mon, 17 Jul 2023 00:25:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrU9C/3oF03YQQBfNxZsUl56FI9pjhUkLBFd8PUDvC+HV54uAWAyJeQgOfWSp3TlgmE8QnN32FAn0aH8Zz0oKwG6snfDCU/PPl+Nqt8U+spGAiX9KTzjp8Jld0pyLBjmnwHmK4zf5n3G+NqHo8A26979zFR2KVageT57MF3sX7NCpwvGEF2JiZE6RQrgPgXOeC/YaoDS8+Z8xdjSGUMd3VrCyCK6MGvKYPGaTBLAws8eyitoqXjr4tfeYLI75AajKX7c8xrRdEBcBNfhmgeX96SLmGy7Soax1UlIAAqtyG/Y0+yUnCDuzqFCIBo3WnLokoXIf/FexptTg5idOQpy5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nP1eSOEtSi/P2fVLhoJFFTDAjCXwfXgvhdw6OdCMQE=;
 b=iF6oxrCf3KGYDJG1EljLkwJ6BRuz8grffo8Pbn473qEUPFcihBK5UwAcF/C3qvc/qlLo6XDQTHuwZkq+mJWQaSRNnmSa6gKaXmrFn3B2OEEd7qv9PCoRKo2Nxo8q3y+iJcde5SVbdfT9qqrWw9KRpWY6sXVJZHAvzP9+IO7B/dAu9682RdYpk4Ng3KwE+RpPo/kw5xuDBExZfhqT3Qk7gyOzD5348skm+Wsz83kmTObTlMfruc7Jfhbn7j1zJJvD0aAr3505v3o6mnvucH9JnYcwuFPOY80nhFMG3i/rhohSHfRQs9FREx+58fyPNXl+z4yfLUEgpCkqSj3x+NRdrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nP1eSOEtSi/P2fVLhoJFFTDAjCXwfXgvhdw6OdCMQE=;
 b=apS95ZZbLcgXKAaCVPvrqyBl3bKICBGhgVi+HIuQQKMa88ZinGAUfGPurN7shIijAPCnNmqt2wiTzmUQgA8coCRU3gBp8ow0wbZ0J2zXOh03tkZqbb2zqJCrJgmyu44T70aSgUN5hNkZl4qy0ZRe+K2SDcGpbKbK+azx1MpyZNlPFHtLKqGzhWnaShDqdcviamgv2b6WUhV0VLtPmb7r+aMFPsdiu66ej202VuHdlo0/9oyc0Sk90522+uVm0+9N+KuphiRcvNKu94yDq+COvcCX0dn0Wayt/9nvMPk6KM7rX4iUwGW9uLbh7AN91wj/qPExmU+AohfS0P0r5My+oQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB7221.apcprd03.prod.outlook.com (2603:1096:820:cb::11)
 by SI2PR03MB5804.apcprd03.prod.outlook.com (2603:1096:4:144::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 07:25:02 +0000
Received: from KL1PR03MB7221.apcprd03.prod.outlook.com
 ([fe80::2563:fe04:95d:7031]) by KL1PR03MB7221.apcprd03.prod.outlook.com
 ([fe80::2563:fe04:95d:7031%3]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 07:25:02 +0000
Message-ID: <3e71a3cd-dc40-c3c3-8fe7-5c95096cc462@amlogic.com>
Date:   Mon, 17 Jul 2023 15:24:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V3 2/2] pinctrl: Add driver support for Amlogic C3 SoCs
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230714122441.3098337-1-huqiang.qin@amlogic.com>
 <20230714122441.3098337-3-huqiang.qin@amlogic.com>
 <CACRpkdbbUga0biH=1tkCgRzUqNiDGdVf2woda5X2s43ct-na7Q@mail.gmail.com>
From:   Huqiang Qin <huqiang.qin@amlogic.com>
In-Reply-To: <CACRpkdbbUga0biH=1tkCgRzUqNiDGdVf2woda5X2s43ct-na7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYBP286CA0033.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::21) To KL1PR03MB7221.apcprd03.prod.outlook.com
 (2603:1096:820:cb::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB7221:EE_|SI2PR03MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e84de3e-7b30-4e98-39af-08db8696ef42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /qsNsCYLQ/1+VwyHk5buLXQk4BftRk7ixcRts5F2qjeS3woBqVba3NOQGBiEYo0X7k0j9G9cd0QoNZppMqhZ88xAvfdHCjnDQXL/bPzT0RexlbCKtcibaA4tPBfedmW9Y9kH5boFQIivSPeT9Pq0h6FhlbFTJaw69bItSh3o2LBvAoqWeJ7j5Ivynre1Ta9W9e2cSWZAErvuw9nzicepdhoYuz/mH8UbUDH97zrMLEOgUMAGtA5V66sFxays/lQCP1UKrjn4xYLpIi3dBIOTYqluTm5ug/TILoGPYA82w/Js2IEmviLoa3ja2PWNhcKVP/11B7bogeiqKo0HbQncAwWskat4bX535lYbnNXdcgQOnukaXoefFJ1FVJSOtVW2HOSiInNMUsES5rqFwm8+rytI5frTSLeSBAJh8X9eH0QUrlAsszCdr/j/LEOiKOQiFxNNgwLrOOQh/ZBApG3FuVkpn6fExkt3qLb7rtjen92GrVRu2m5C1UYrq5Ti9q5NOMM0EOoHSXfe/Wxt+po0oC2xu2huln07BHGca2v5U/TtmSmQyFFH6XcN+kimwq4Sca7reTfNghvaBh2w6//n9cXskCFu5QZ2d0N7k7Qk1haAad1JJaRV61WpNVPfg8dH3hhbzq3CSI4OTH5lA7vWskkGGNDgi46TKOjFPafGsomjhtqs4uRecHmPQdG5dfkPif+Zsu8iskKlO29Ymx/nj3h5viDilZFAie17/dU8fik=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7221.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(6029001)(4636009)(39850400004)(366004)(346002)(376002)(396003)(136003)(451199021)(31686004)(86362001)(31696002)(2906002)(36756003)(44832011)(7416002)(6512007)(186003)(83380400001)(53546011)(6506007)(26005)(38350700002)(38100700002)(6486002)(52116002)(6666004)(4326008)(316002)(66946007)(66476007)(6916009)(2616005)(66556008)(5660300002)(8936002)(8676002)(478600001)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S29jWUhsaVlCelQ3WlFjdTArTU1xNFlJem95S3lqcTBjU2lsLzZPbFdEcG9H?=
 =?utf-8?B?ZzNJSFg0eXJ6Rk1zeUFtcnR4MzhWNWExV014ZGpnSEowSmd2Mm5yaGY1UVNG?=
 =?utf-8?B?RklxWlR6SVRVY1JrcTd5MWVBLzR4VEZBSlZYL095dXZIRXZZZXp6V3BUUG9Z?=
 =?utf-8?B?TXluS2RKaGZZNlA4TGVqN0d6b1Eyc2dmYS95MFh1QWRNenNHYVpiM1hGZjhY?=
 =?utf-8?B?a00zZzlXS2FhZ05kcEZLQkxtbng1VmdKSFduRmQzRFFuYzg4elJ4a2lEYUlJ?=
 =?utf-8?B?cmxXM3ZuN0dVYlErV2Zuc3ovQlcvMEZkdk4vblFWeXFPeTV6bkRBdkl1cW1V?=
 =?utf-8?B?c3N0djdmNDZoUjlSbzdJQ09mbG9VTlIxUmJOdXFxa1ZlZTVORk9KQVRoclJa?=
 =?utf-8?B?eHlDZmdzRlRzcExTTUNLYjI5S2c0YlVwYmNJcmtGVUFkYlFMd1lNSkZiWVVO?=
 =?utf-8?B?UGRDNTR3UU90aE4rVFprUmdzRFd6WVVmRDZXMXN2RHJMdDlFVTlmTHd6ZFNX?=
 =?utf-8?B?cWFVVGJOUEN6TU8zUXJqN01BOEhvZ3VxSGUxQjVzVjd0eEVoOXhwd01zQmRK?=
 =?utf-8?B?WWFhRHdEcVI1UGNFSXIrbzg3ZlVzSXJsK0tHOFdaYURBVS9lcWcxRENxZUtN?=
 =?utf-8?B?UXJ6OXJ2WFNkRFVlVG5zUjUvbzN0ZS9INEM3WEQxV3lDVUJNeE9oWkFoMm1S?=
 =?utf-8?B?TXltTU9zMHFYd0VsT0NvamNqbFdFbkdsRTEreVN1Tis5QmNZaG1BaW1OL1Vv?=
 =?utf-8?B?d0NtR0d1S2JKU2xySmpmS2FWU1NmVXVRaE54S3o4OUdCUFVKeXZhL0Nxamx2?=
 =?utf-8?B?UDFKcnJBVUpubGRXNzZRZnZ5T1EvQUh4RlhWVWZxUTRnTSs5OUpHcUtDaFUr?=
 =?utf-8?B?SmdQc0gybllLcFZnM1M1NFVDbU1sT1JTbzh0ckZRMlZXYnMrcjVrd09PQWZW?=
 =?utf-8?B?aCtVU3Jta0UwRXhwZjhiWUpPSFRoNXRsYkRLSFRrVkZzdVFhMVQ0R3lFWG4y?=
 =?utf-8?B?K01pbzMzYzd0LzBGdndxcE1vcXh4Zi9KY09nSTBPb0xjNW9ZaW40Mlc2KzBI?=
 =?utf-8?B?U0NFekd4VWRXM1AzNmlNRFVQeGZUYWRBNFg3ZUo2ckx0NnpJSmNDN2Rnd3hy?=
 =?utf-8?B?Y2h3dkJIakpNeW5JRWh3RlBmK3M4TkxQQXVreUVVb242eTlMbWpwc3hCQTQ0?=
 =?utf-8?B?bDZHSXNuUHc3RW01OGNmNXJFTmJXcGVaekJBbWVpZFZ1TWVaQjBBaUZIS0VP?=
 =?utf-8?B?TnE2bjBEeUhiM1FGSE9OcEh4OVE2cHIxNFdsam85Mi9abGwwZWNuQ044bmJu?=
 =?utf-8?B?NEpPdTVPQkJIai9BbzFzdHplNmlNMHI4azdYcU1ROE1XZ2tFc1hVTS93Yk0y?=
 =?utf-8?B?TVovODhHOVhlbzJpRE1ERmVlZ1didy9KMWl2RVFxS1orSmxrSjVVWmRwaW9a?=
 =?utf-8?B?R1FISXU5eGdPTER3dEY3ckl2Q2NrM00xWll3blI4ZVJMMlJaaVA2ZXBQQ1FD?=
 =?utf-8?B?bUkrUjZkem8zUnZDTFI2blZZbElmbGJUVkZIelpxOUxyT2FJenU4RXdkVmhG?=
 =?utf-8?B?dytKRGo4K3BuYy9TYmprR1VCRGZsQ0lLbnZSWlpPKzNueWJxWHFIU2t0djhD?=
 =?utf-8?B?VFZPNzV5aTYyd1lYS201aHEzUDJTSE5ZRWIxWkJVTFBGT2ZlOU8vZlJDckhh?=
 =?utf-8?B?M2dkTzMzekNmaTNuUk5qUitIeUlvdVhFSmRoeXBDcEZPeVV6S1czUmZBQ25T?=
 =?utf-8?B?V1hmeFVRRWJTMHluRzMrT1BPcGFXR2ozRmlRbkRQQVdOSzhVTzF5MUZIclNi?=
 =?utf-8?B?djdMQm5CN1MzYWN6UHRTdForWHVhcXV0M1RLZ3VEd1Zta04xZ2hNdUhjNllJ?=
 =?utf-8?B?dnpwT29jWHdEZUJnTnN1TE42d0dsbjVYa0FXSERnU1dJb1hVOWNQYlI0Q0Rz?=
 =?utf-8?B?RGRoREhyaWJMam9HNzY0Ukt1Q2U2U0wwaDZ5R0M2R3pUSUJrbXdYWFVaNmhB?=
 =?utf-8?B?VFpwVTNJZVoxQlhJTitaSzlFdDRWWkhsRG9nd3Bkc29qeVFIWURjWGJOcjB0?=
 =?utf-8?B?MTFVc09KeGQ5QnBNeU9NZ1Y4clZPMzdEaWkvb3pJSFM2WUluL2NJdXhJalFL?=
 =?utf-8?B?TmVQaUdwbEtWZEkwTmRtcEd0TXBmYUFSNVFPQ3dwdFN2bkEzc3QreXBvSGl3?=
 =?utf-8?B?UXc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e84de3e-7b30-4e98-39af-08db8696ef42
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 07:25:02.3062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LqVFPSY+sNaB7cYKk00N0JkW5O15a6iR0SJ0UAC/mDtCJrT0IjZDfhZUc2qfu5bzBPRTMjw1wytjo1nqz9VvXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5804
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus Walleij,

Thank you for your reply.

On 2023/7/17 5:20, Linus Walleij wrote:
>> Add a new pinctrl driver for Amlogic C3 SoCs which share
>> the same register layout as the previous Amloigc S4.
> 
> How is the spelling of amlogic there in the end.
> 

Okay, thanks for pointing out the problem, I'll correct it.

>> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
>> ---
>>
>> V1 -> V2:
>>   Added a comma to the last item of the array and a period to
>>   the commit message.
> 
> Andy had more comments about the header inclusion. Please
> include all used headers directly as requested, I think it's a good
> idea and avoids confusing compile problems.

Yes, this is a good idea, but when many files must include the same batch
of header files (seems to have become a kind of template), it seems like
a good choice for us to put them all in pinctrl-meson.h (actually been doing
this a long time ago).

Attached is my last reply to Andy:

> On 2023/7/10 15:33, Andy Shevchenko wrote:
>> ...
>>
>>> +#include <dt-bindings/gpio/amlogic-c3-gpio.h>
>> Seems some headers are missing. The rule of thumb is to include
>> headers the code uses directly.
>> Moreover, using a "proxy" header is not the best idea.
>>
>> kernel.h // ARRAY_SIZE()
>> mod_devicetable.h // of_device_id
>> module.h
>> platform_device.h
>>
>> pinctrl/pinctrl.h
>>
>>> +#include "pinctrl-meson.h"
>>> +#include "pinctrl-meson-axg-pmx.h"
>> With the above, it might be that existing inclusions become unused, so
>> drop them in such a case.
> 
> According to Amlogic's pinctrl driver structure, the code to realize
> the function is mainly in pinctrl-meson.c, and pinctrl-amlogic-c3.c
> is only used as a data file to describe the pins of the chip, and for
> similar data files, all need to include pinctrl-meson.h and
> pinctrl-meson-axg-pmx.h header files, such as A1, G12A, S4 and so on.
> 
> The following header files are included in pinctrl-meson.h:
>     linux/gpio/driver.h
>     linux/pinctrl/pinctrl.h
>     linux/platform_device.h
>     linux/regmap.h
>     linux/types.h
>     linux/module.h
> 
> Here is a case for each dependent header file:
>     struct gpio_chip chip;         ---- linux/gpio/driver.h
>     struct pinctrl_desc desc;      ---- linux/pinctrl/pinctrl.h
>     struct platform_device *pdev;  ---- linux/platform_device.h
>     struct regmap *reg_mux;        ---- linux/regmap.h
>     Basic types of linux           ---- linux/types.h
>     MODULE_DEVICE_TABLE()          ---- linux/module.h
> 
> Since every data file will use them, let's put it in the header file,
> so as to reduce duplication of code.
> 

If you still think it needs to be changed, I will add them in the next version patch.

Thank you, looking forward to your reply.

Best Regards,
Huqiang Qin
