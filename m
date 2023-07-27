Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22ED6764E89
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjG0JGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjG0JFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:05:51 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2119.outbound.protection.outlook.com [40.107.215.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D877F559B;
        Thu, 27 Jul 2023 01:46:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=di5c7gdjfrkpj6mkVDpkN1YQu2s9aPfC51QRHG7gyZK64tsAl7OeNccCTnRTnrgd9NxXy+76lWqOPDugxjGtDt1ocH6pLRyMaC9WcZ04HW2H9972w4HSpgz82Doc8r/XI8KcyY39SDz+tjbBWJlc4U4LhqRccP3wkfPfezDFD0piybQSuOkmu0cLFefdVHkAzzajSHH+cKydifpvcvRoOvc3bDVTDyrM5555uK6YkkVarl4KE2swQDy+IOt1fbyLXmNbrMBVeyrpQ6o5RTUU4oHNyOFZdra4gtl6FIv3s+Wxlpv4wzHd85p6AnNPvD+1iTm1jj4E0MHoKud95x8x9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3l99f3CPhXJXZvIwSMdBMOV87DY1Xjeiei8xduWf1UU=;
 b=d3Udnq+sL8ri7qbY7AWIE6/7Q49BVDcMPhAn3v1DQHahF/HcTRbpNXTU8mGt+jJdbTZesFbMVqbH50Yr2vrSKit7b7tNm4AGJtTF8PQhReKYEIcwGMpHytcSbFiagh9q7GAyoE0oXnSivKmbrFAyfnBNc95OADeaT5h9ML7qvGo/iSYfEkKK2gjaHqcQRzfAxfseiQL5fi9vV9J0cTLnPDkYNfWJ2LJ1NQHn3G515jJq0oi9sy/M1hqWSDUtJ95ouoel8woWeOK5ACkgXLS9O09zCHViqC5TV9rx1FSQNsrFlGuNe5ECJRFLbp69KJUYnBeGIZJyPxoa+X4yGMoBkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3l99f3CPhXJXZvIwSMdBMOV87DY1Xjeiei8xduWf1UU=;
 b=v8B9RQR2hs9jotOH2433+yydnJ/bLIiiLcfrEJrUCNbGOEa+pqLCeMLNjed3AN+XdSUTF80W2AT7uNke486bgAmyN6DQo588EYiWAi8kFR4/6HV0VIK3yjDTZSqhhn5kjL0ZBkexAt1Or0smXz6g1i3SjJ7/5Vaw7jvQ2lfNRwiT+1cMF1FjstWMzcywe++nCPtKCEHgeJbpk5PFOWo/nRC+Kfl9lwL0GLF5UiZX0FXEhK7q07AE/2IQ8Ejra8CckLk13yOK/mzD2VTFYvXupgKU17krHpPGR3IeBq+zkgUQbfwnczwkpoIp7RV8nQUmFjllzHurB4c8UYFMqiPuDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB7221.apcprd03.prod.outlook.com (2603:1096:820:cb::11)
 by SEZPR03MB8232.apcprd03.prod.outlook.com (2603:1096:101:1a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 08:45:57 +0000
Received: from KL1PR03MB7221.apcprd03.prod.outlook.com
 ([fe80::15ea:573f:2ff2:f723]) by KL1PR03MB7221.apcprd03.prod.outlook.com
 ([fe80::15ea:573f:2ff2:f723%5]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 08:45:57 +0000
Message-ID: <9da24c47-341b-1581-0043-a6c1cdce462d@amlogic.com>
Date:   Thu, 27 Jul 2023 16:45:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] arm64: dts: Replace the IRQ number with the IRQID
 macro definition
To:     Kevin Hilman <khilman@baylibre.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, linus.walleij@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20230721073214.1876417-1-huqiang.qin@amlogic.com>
 <20230721073214.1876417-4-huqiang.qin@amlogic.com>
 <7hcz0ei9r4.fsf@baylibre.com>
Content-Language: en-US
From:   Huqiang Qin <huqiang.qin@amlogic.com>
In-Reply-To: <7hcz0ei9r4.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0271.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::16) To KL1PR03MB7221.apcprd03.prod.outlook.com
 (2603:1096:820:cb::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB7221:EE_|SEZPR03MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b4f4a4b-f79e-42e5-0e7d-08db8e7de3fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/lXqHylDZ+EFWuOlteSV61yLFuENK9C5weQAA8cujRt9iePA//mmlezaTtM0TICoqnh8Gu4Lo/U0TxSF2hZCqHzeZUdcCcS3Vwfr+7nMsmUvqR+GWzZe64D9CqiYDcS6nQaOHueoHNUHHRICVi1/0McARp2+Dz4mhkJqbsDLHIzJkNv2gJqcn6naATBve8HQDCaLSHQ8zXg3yFJ53uJnhNRyBMUniVjWFdiIjn8XkXaHNbuoa1EGrePdA2nVEcxZUMhVlN9QwSTWrI2vmIfkdeU/7hCINKXizYSuqcUr8smjiPVRojY1pNcrNPNapb17P4OBAfnpsqTuBlXpNwpqVBZGX4wIDCC+wNy6CI2+LteoAAqFaXEr7lNDSdlD3yPkG4G4jI5Y7Zk93fhIHuIkfviVl5WkCEs8sjkMzAKyUge7RGkOkWa/fnqRV5Q5YbcjYVaqEwemu3X/TbvynkTCtukajJuLIno7hx863QWFz7rlBnU1gSP5t+6HnTAka4gpkdmqymi6QFWQPhnZAkZ2cE1i5zgTDGKFSjYUXWIe7LHR4Xd9aE51GQET09+m6mLRZzLQV5D1up+p+kazpcu7jWO3Cp6SNkcOdJFnd2CMAGreqJWeGKZ5IWxHjkpPBXoVdGEs0eqFSQGJdkm8aSLyVZPsV49sPKZAm0BdjFr1fRbupBVpYB2zj2dlpObq6cqWKCyYLjKNBkK49cC3YwmAw4ymr6aSkJ0BUSq6SAkTCs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7221.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39850400004)(366004)(346002)(451199021)(86362001)(53546011)(26005)(6666004)(52116002)(6486002)(478600001)(66946007)(6506007)(31696002)(83380400001)(6512007)(186003)(4326008)(66556008)(66476007)(2616005)(31686004)(316002)(38100700002)(8676002)(41300700001)(7416002)(36756003)(5660300002)(44832011)(8936002)(38350700002)(2906002)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHJnWEFNZWdyOFE4aG52NTNmaW03ZGwyeHdYTXhrT2VJaFA4d3BsODNOVDlF?=
 =?utf-8?B?MmN6cnNkejhDTFRnR3E2YW4ycmxWdzZyNGYyWklkQjJseExISDB6ZHVCU0hJ?=
 =?utf-8?B?b3k1Rk83Z2FOSHVKWVRZK2dBR3FYZVNuUWRmU1NUWE1zV1lUaGxGNTVoMjJH?=
 =?utf-8?B?U29rTmdIWFlpTFVyVTlQbW15a2JqZ0JudlFQYXFTN0tYK3ZKNHdNazd6SURr?=
 =?utf-8?B?TlJkYklWUFp2WFMzdnVwYnJJKy9nS2tHSUdNRzFyVUhJZm5EMjZPUElRL05Y?=
 =?utf-8?B?VmxwK2UrMjdycXlsbWlYcGhZZnNPenpLUm9SekE0K0hMVjdaZWszc2FKYkh0?=
 =?utf-8?B?cVpnSU9CeWRrVU9kZlExeU5GSFBxdGRIbDFxejh0bTRHYi9LZXNzVE5XSTFa?=
 =?utf-8?B?d2JjN3dsd2EraTdZUW5OZkRsbnBnWHZSdVJCTlkyZUE4NGdLUmtpK0ViNkRh?=
 =?utf-8?B?dkc4UWw0NkE0MDkwWUtLZGU4eTEvaTZGd1EveGVzUnk4RVpEYnEyWUphbXRm?=
 =?utf-8?B?WkJDRGQ3YkpkQ3Z0SHlXQ01DeEVGSDh4MTJiK2NhMTVhVFRneFVqQ0I3MGRv?=
 =?utf-8?B?a1BRT1pSbTNMbENiK040V3BRQi9nZ3Q4dG1mZWhJWGJ0aG8xN3AvaldWblpK?=
 =?utf-8?B?dWNYdFlyalBxL0c5b2NGRCtINXZZQkFCT2JHY1hsYzJSdS90RE5RQ2VQV0pz?=
 =?utf-8?B?ZTdzSFh3M3JxbnJJOXNRaEY4UDVMOXF0dktieUYrWnQ1RFhCajZiRzRvMnVt?=
 =?utf-8?B?TGQ2TGJlcUVpTkdWeXdFTGs4Q3E0eEVEbDdIS3Y5VlJtSXBlV2gzOW51S0pK?=
 =?utf-8?B?bnBEVVVDNElvS2s3QTZCNFA0ZW9pYytwZ0UyeFFZc2FBMkx6ZEZ2aSs1SlR0?=
 =?utf-8?B?ZlV1bXFGdjZEWjIrdjNndEk5Y3YvQ0NnaGRRbGVyUytkb3hrcjMvUlhtNWsv?=
 =?utf-8?B?YUhOODJZK3ZxVVFxc3hSL2UwYUErUVZYc1Z4RTBVeDlIRXNJY1NEUEkxcVdp?=
 =?utf-8?B?T0Z0VEc5T0IxNjhsUWk3VzNIU3g5SWN5MDBZdVlMWUh4NEszTXU1SERlYU9Z?=
 =?utf-8?B?aVJ0Z2JLWHJwcWQrQ2hyUExkbGd0SDZrTHFSbENIaWhYNnRiWG1XNDI0ejhO?=
 =?utf-8?B?RmdId3dsU0xKcEdtd2VjbkQ1Ym5KcitteFhvMHRsRlV0aVBEai94blg0d0lZ?=
 =?utf-8?B?U2EvMWNTak04V2E3NDNJNWJEc0NpM0tZVmRoUXBucGxYczdoRTVWN3VkbkJz?=
 =?utf-8?B?eHlXVVppMEx0dENueE9WcEx0eWI3MGdsMjJUajJDMlA5WHIxMUFRQ25JZHp3?=
 =?utf-8?B?akxUeTNjK0JaNDFsV3pIVXFhcURqT2FYQXFjMWZpMzE5a29HbUtxQzRvcmdl?=
 =?utf-8?B?cjhFWE9FWDJJd3Z5VktCVlBrVkMyRWdmQ1lOQVZLclA1dGFqQ01pbUxXTGJE?=
 =?utf-8?B?SzhSWXdSMFl1emZxYmhXZzVvQ283dGFZVVVPRGpQa0JMbnBjNlAzZWRVT25p?=
 =?utf-8?B?Mkp3U21uQzloSlVLWC9KUHZNODczMC9yRTNYZmZKYU5XQ2FMY2lFc2F5OWFt?=
 =?utf-8?B?QmxBWExINnI3aFlpcGF3KzRiVUhsM1JsTUh5alEwQWpzc3ZqaElaM2Y5T3ly?=
 =?utf-8?B?WlhJdkEvY0VwUWphNVltRG5YQ3ZpZk84MDhpVThyMmQ3dGVsak9LK09UNDFo?=
 =?utf-8?B?R0x0K2E4LzFpSzJYRkRKTVlDWjhRcElCcmorUjRvK0FTYUNic2UycTlLNGs4?=
 =?utf-8?B?M3ZIY1haeVBJTXlDZGk0NWJyKzN1dWRKOGh3amJjWTBBMWxyK1VadGtHMkpU?=
 =?utf-8?B?eGxYVFF0bnQrZ0N4VGR6THVKRE5WNVV6OEtBM0lIYktyK2xra0E5TXpxTmdl?=
 =?utf-8?B?VEQ4RFZ0VFM2QlFEb01EZ3NsUVR2YnNlMzNjbzNvWllyaGpVb3VpM0FMZmwr?=
 =?utf-8?B?NnErUWpuL3FnQ0QySkRIQmlaNzRIUkM0a1dTT2VnWVZxdndFdDdFb1VHUThm?=
 =?utf-8?B?Um1JK3BPTzFybFg2VlJvQ21CMmhNVlNXelZvb3hZaWtkNWFtTElFMVAzU3lr?=
 =?utf-8?B?b25XZUtUaWhuTWNabjBkMytqWWplN2x3aUJWYi9zdzFvb2w4Ymd3Y1BoZkJZ?=
 =?utf-8?B?VlJkNnlqRkN0N3dNakFQaTkzOGNGUjFvc0I4ZkR6UzZta21XN00zMVBSYWZk?=
 =?utf-8?B?b3c9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4f4a4b-f79e-42e5-0e7d-08db8e7de3fb
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 08:45:56.5713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2LuHYAdf46ssrpkI4HaBqy3FQF7W7Jfj0ry9pZYSSamEnLWdHLjcvOwU52jMoPoq3Zt4zpdpCtmsUHG89uPSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8232
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin Hilman,

On 2023/7/27 6:33, Kevin Hilman wrote:
>> Replacing IRQ numbers with IRQID macro definitions makes node properties
>> easier to understand and also makes GPIO interrupts easier to use.
>>
>> Associated platforms:
>> - Amlogic Meson-G12A
>> - Amlogic Meson-G12B
>> - Amlogic Meson-SM1
> Does this mean you tested/validated these changes on those platforms
> also?

Amlogic's G12A/G12B/SM1 have the same GPIO, and the GPIO interrupt number
is also the same, so I only tested on the SM1 platform, and the test results
prove that these changes are good.

Best Regards,
Huqiang Qin
