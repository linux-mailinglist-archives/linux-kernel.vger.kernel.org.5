Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1BA78508D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 08:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjHWGUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 02:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjHWGUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 02:20:39 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2119.outbound.protection.outlook.com [40.107.117.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFFB184;
        Tue, 22 Aug 2023 23:20:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGCoC6b2bBUIfqVcc4hfFOBeXeVb3ZOpspJ7r/oor0cE5lmG4EsB3L15tmMvtylYryD4RUTLuWKtWzNdnCtVTMmF5SIGaaxQdSdHcl05LcA42DVGWXN8auD30Utthy9uimFvz3Dpe3ES/tDa27Nc3wrkzdgYhKqvr8qThpzT3i+yFutD9FPH7yiQUepuVrynqfN7mrtRFfJRDkpJaKA6IlQ6Lf+3SY3SoRWVGpILtzDZTyKiAeEmKSWNZAxsZeHO8Ci1qoqJBKYbs8BXmTOnvri/lNjOrYxxnOZt3GSaKzbks9sJ8doXScx26KMX3aiQT/sZZv5gAWaAY4fgxg+kug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiaKFYgo2ubnNwqn9Elmno7haNkh+PvmJJxdTHlp2JI=;
 b=ArnUpOGuH8E+5s+BoKVBzBGNNHqhlxs2q8R/J5U5k3VP6va76BySgml9Spxhns+/DAaD/44DwXaL/t8lsm0LcspG/ARjUlJGPca0j2DBEGfYHDO+ylftRyGLneJBakg1t06Ys6SOiOecyFTGlZrE4aBlDK/1M1HDyen0jimOuaLaV5EywqsOXF/UCA9e30IJG+r5xZgzIovsM6EE7+2yyzNqbrIXUHZOLk4fOGmg+5JgDVkBXBvdH6NgEfFCeKgQNtymdpre97DqMVcVHDGTWBDABtsCiKT3M2XKVj0lfIVekXFGCjVj3ahG6ckFEg05gzh474dQUKHDM0vfedNEZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiaKFYgo2ubnNwqn9Elmno7haNkh+PvmJJxdTHlp2JI=;
 b=uvcgfbmk1DuOqYzyFMsD4r05bsE9H54Lkx26ol4+oDQG/oQscoZSGfAVRB4dfobkct/ZmVXAEe0jXGPrEPJv3IPrGanf4EjJkf821fzfqpcliRviY3fZkm6/ESQDunMPEqLEsv/Jy97aJHATVEF4Nj00Za74As9iHq7Aa6Lk2wpYFI5yeWVfvVIyGj3G83h7MadRm5YU03rnN8KgqA49ueZCp5kZo9eZma/2Q9ryoRwXUAdlLNnfc1gQIm7i1oRJNfCtlQJ+lJ+vJTGB/TaasKBeudXFLXgWAooV2T6Ti6v1l4C/dwjHIXV1tsuY6RrMqi3A051evJorS2RIRFwfLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com (2603:1096:4:1d5::9) by
 SI2PR03MB5194.apcprd03.prod.outlook.com (2603:1096:4:106::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.25; Wed, 23 Aug 2023 06:20:34 +0000
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::6f04:4b62:1127:59ed]) by SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::6f04:4b62:1127:59ed%4]) with mapi id 15.20.6678.029; Wed, 23 Aug 2023
 06:20:34 +0000
Message-ID: <eee9e730-f69b-1150-07fe-0d40a14b5a50@amlogic.com>
Date:   Wed, 23 Aug 2023 14:20:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V10 1/4] dt-bindings: clock: document Amlogic S4 SoC PLL
 clock controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kelvin.zhang@amlogic.com, qi.duan@amlogic.com
References: <20230822082750.27633-1-yu.tu@amlogic.com>
 <20230822082750.27633-2-yu.tu@amlogic.com>
 <d2a6060a-c8a0-51c7-f621-1bed2c3074b4@linaro.org>
 <e9932f90-a011-ee9b-ef09-f2e2475bdd0d@amlogic.com>
 <c2faccd6-1d77-9b81-d8d9-830e95e804af@linaro.org>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <c2faccd6-1d77-9b81-d8d9-830e95e804af@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:194::15) To SG2PR03MB6730.apcprd03.prod.outlook.com
 (2603:1096:4:1d5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB6730:EE_|SI2PR03MB5194:EE_
X-MS-Office365-Filtering-Correlation-Id: f37cbf0f-317f-487e-ee3c-08dba3a10f49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s7ugeItRuHnZRV2bT2p20BEhCygL/bhOuVVDt0npX3dsPoqpOCEveswmLX4D67VZm64jFeDeMwZkMfMf7jF1EefVqoHocPgUHYCCk+ZSSGvDupXjVrEC1T54ME6jcCWlN13BGeAz4Rn7ppkFSJmwP9GWsIO28k3bRq4gcaHBU77SqmVHNZ1/6DS3KoH8/RQ0ChulHTD3OyzHUIg20Ed9il07RToE9FgispRLrQoYf4D7AN05HintKwW31vwY+3aLHtMqZfKRgyc73DqUBFYUFUBqd1CU0xh6nf8vlIcCwvm8E1cAPHv9TGBaSgGdTWBIksgSfXDPWx2Rs4e6qYSZN9ybQgGzp8Hu4JY5Y3WCzus0iOV0ZR9LbPhFVrdNocvrr8PY1VF3k9XnY5g2yTJI8vj75SSitsS6KeZJtsA13ZsCzk8lVSb1lF/VQz53l5h8A1NYi0VljAJpR8eEFILI6J0YmG7T966gtdaVQdJ8lQFZXWK4bII/itXMuNeYL45xFKU1g5e4lSriO5A/QBAejlsJBcdxfrnRZNhN3GxyRoyAVh/WshqWYnxzVaYLRuNCEG/KvQSY6cxqEdPdu9gBH/2tG7e3Qz9+y2Z1alB3KUWCr4YgTtWKPtbxUIOBHdNPw4Erfuu6kPrECqJw7vR7ghH2/nmN5a+93Ry8b5szpHbu2//m6+UhMD3Ss1Ow/EbJY2G/ETDuejXlfp2aS4zJquqX43hCgM51thfbxHc+7Dbdj243ksy3ru5njPkICkag
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6730.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(376002)(39850400004)(186009)(1800799009)(451199024)(110136005)(86362001)(31696002)(5660300002)(44832011)(8676002)(8936002)(7416002)(4326008)(2906002)(36756003)(6512007)(6486002)(6666004)(53546011)(6506007)(107886003)(26005)(2616005)(921005)(478600001)(12101799020)(83380400001)(31686004)(66476007)(66556008)(316002)(66946007)(38100700002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azN5RDkxbDhYVWFCRHBjZjZuMGtkNU0zVi9NbmJrZnBFZFh4SEVnMUR5MG5t?=
 =?utf-8?B?T0VMWEJzbXdrbDRvcEJnSWJzWldvNXh1QWUxQXpNcXpSTTNqb1FURnBFRk5m?=
 =?utf-8?B?OEc3aGp4OXN3c3JQRUdkZzYrc05JQlc4djhxRkZPLy80Q2RpTm1KZVhPS1l6?=
 =?utf-8?B?WG4xN05ZaGE3Q3JiaUZCdUtPejNPQTN1RWtBNzd3N2w3elRlU21SdU5qY3FW?=
 =?utf-8?B?NFR6RDluLzlPV24yWVEzQUFENVNtN0pMNzVuVmdrdHdIazBiUGc1VnRMNmVP?=
 =?utf-8?B?dVZjSE4xNjQ0NlljK2RBS0lCVVRWSi8xQTNrR05XWjNxcFlYNUFoV3dFczV5?=
 =?utf-8?B?b0dxY2JPQUtabFd4M056WGd5SFdCQ3Y1dUF6Nzd4VHQ3SjRuUTN5cDRoVjJK?=
 =?utf-8?B?Q29JMWxKN2JBVGs5RFV4OHpremNKaUNoZDZ3amYwRmtMRDVtYk1YSkh0a0xh?=
 =?utf-8?B?endJMHVmWVR4MlV1c2Y2TGVIbXJwajlKYXFZSjJnZTFzNU1MU2Y0WDA1MDFz?=
 =?utf-8?B?QzhiSDZicHh2ZElJWnJYclNrM3k3cWphVHRXVXRwa25pREpEZkpqcDFBUmx6?=
 =?utf-8?B?N0NYNnk5a3BMcWo3NEJGZkxZaUFhRG1BdG1rMXIvNko2bzlQSzdvNTJ6MkhK?=
 =?utf-8?B?WU5JdDUwOXJOR1hvVkNTQ2FoK1hYUE01R1B2WGdKbkQrWmx6Q25ROUtDblJY?=
 =?utf-8?B?QjFMd1MxV0lZWWxEY0M1UzIwNFB4cHMxMU9tQWw0Z2dQWlVjMXFsd1BTRldI?=
 =?utf-8?B?YWEzOG96RFNycllWSm82bEZPOVJFeityOFZPdFhYeVBYQlFPZ2c5eU5UcFNa?=
 =?utf-8?B?bmxjSjA5Y21yTVgwRXkzdjQ1QjNRQzdraXJlT3U3QVVBL0t4bXowaUYxeXRu?=
 =?utf-8?B?RlhoaXJpcHZsNEJudTFZZjBSYnpDWUhzNXVRN3k2QkwwTzg2RzRzcWJZcWI4?=
 =?utf-8?B?SFJOaTQzZXVseHYrYTNkTDZMSHkvdE84UEtEYVBIWDZUVGRpYUVpcXQxY1J3?=
 =?utf-8?B?RTRDcVhDN3VqZjd1V0RTd2hMV0laQXRsWnJPL1VVQVdKOUZQUGJZWkRUamc4?=
 =?utf-8?B?QUovdTJpZ2dDamZvemlTMUk5VVV2Mkk0MldobnR6bEIwNUtGL2ozSnVSZU9R?=
 =?utf-8?B?bGJiOG95L2NKakk4cC9SLzhISXVlRWpEQngwbHBBUVJ0Ujk2STY4VUxMZWFC?=
 =?utf-8?B?SXZZRjlTSVMrUkxtTDNoaGRTc3BtcnM0dEVYN2lVTXhQOU5SQjR1amV3TU5F?=
 =?utf-8?B?NU56bjBMR2hYc1JkbmhkdkxFcmUrNDNMdnVxYXlHamc5cyt1UTlRQ3lRQ0hF?=
 =?utf-8?B?dUg2TU1zZE1XeG82QmZVbDhJMTZuQ2NsNnYxNFNPcng3ZGlnTDB4NGdYS1RS?=
 =?utf-8?B?WXhOVTVHVk96dUIrNFEzRnQyZ1ZISEZCa1BMVXp1a2Z1TWR6UnNHVWJ3V2Iz?=
 =?utf-8?B?N1BHTUdOVnZWMTVuT21qTU9QYkgxVHBQUFQ4Z1RZWWNmbFJvZG5yWjJFZCs4?=
 =?utf-8?B?ZEdDOG9tR0V1eUsxQXI5b0wxWkl6NnJoNGVwYzlPR2NNZStUdDBNcWFkcklz?=
 =?utf-8?B?SE9WK09LbWIrdWxEVjFKUWY2OEVXalJGN1UwRk4yWktkRGF6Rml6dTQ1ZldY?=
 =?utf-8?B?ZHBaT01sUkhHRE5TNUlsZFVDOHhVTTdXUG9jdEtRcWJkNEJtYVhlQSthb2hY?=
 =?utf-8?B?RTB0SkJzR2Vvbm5JTkdFNkZ6RFhKQWVXbWppUmgyRkJRU3c3V1BMa3dqVE9V?=
 =?utf-8?B?ME1DaW85bTZtVGc2bWt3cmlCU244bDNhcWJmTGd4ODVweDVKbHJpQ2I2S1RB?=
 =?utf-8?B?UkFqYzV2bW1VZXFSYlVkdjY0L1NTNzU1WDd5U1ZGaDFGcnBVaDB4SkdwZ3di?=
 =?utf-8?B?TktjY3UvV2JXcFVRcWdRSVJGaC9nMXZYclJ2d1NUY3BLN3dIU1ZmaEVBMS9U?=
 =?utf-8?B?U2NVdDh1eVlrNnFFeitrUmR0OFdWZkRkTEhSN3VJR1dCNThQUy9pL2Rhdmth?=
 =?utf-8?B?VEtxd3BRRzJRU0UrNWdCY3hWQ0JoVUI2MVpqbzBPVGJ1R3JIM21KcTdvUThD?=
 =?utf-8?B?RFlJcHhTQnpUajFiZU9KdGZZRDY0UXc4aG04ZjNhNWZtT0N4YXRWMHQ4ckZD?=
 =?utf-8?Q?dZP25uT5sO1rD7NsHzyn+SLci?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f37cbf0f-317f-487e-ee3c-08dba3a10f49
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6730.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 06:20:34.6600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z60PxGdGh90QzQBVsqsIbxQP6/wnW3behwmYShMSoXhxAzfzwtzIdue5GQI+qq9BDHWCavHVpH38cezwHmIj1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5194
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/23 13:43, Krzysztof Kozlowski wrote:
> 
> [ EXTERNAL EMAIL ]
> 
> On 23/08/2023 04:24, Yu Tu wrote:
>>
>>
>> On 2023/8/23 0:32, Krzysztof Kozlowski wrote:
>>> [ EXTERNAL EMAIL ]
>>>> On 22/08/2023 10:27, Yu Tu wrote:
>>>> Add the S4 PLL clock controller dt-bindings in the S4 SoC family.
>>>>
>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>
>>> Lovely. I sent youa  friendly reminder at v8 which turns our you
>>> ignored. You keep ignoring, I will start ignoring as well from now on.
>>
>> Hi Krzysztof，
>>
>> Sorry. I did not forget the friendly reminder in v8, I consulted you for
>> this at the time, so I re-sent V9 after adding the tag. Because it was
>> just "meson" that was removed. But V10 is based on Neil's patch, which I
>> think is a bit of a change. So I didn't dare add it. Instead of
>> forgetting your reminder.
>>
>> So what should I do, I'll follow your advice exactly.
> 
> I don't think there was much difference between the version, which
> received the review, and the current patch. Otherwise your changelog
> should say that you drop Rb tag. Rebasing of something somewhere is not
> the reason, so please describe what are the differences in the patch?

The current patch and V9 patch difference is mainly based on Neil patch 
I put "include/dt - bindings/clock/amlogic,s4-pll-clkc.h" this document 
describes the clock index all exposed.

Next, I should add Rob's tag and resend it. If you have any other 
suggestions, please tell me and I will strictly follow your suggestions.

> 
> Best regards,
> Krzysztof
> 
