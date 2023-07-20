Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1A675B5D3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjGTRpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjGTRpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:45:21 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2105.outbound.protection.outlook.com [40.92.52.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00E1269F;
        Thu, 20 Jul 2023 10:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQie4DeeNSr5iwCLYQ2bfCpxSr2qcSP8Ld+6dvpRijR0uO5kfudqnBUAYkYtRBPrGl8WH+rL3awrQv2lf1RNOFvJFE+rAe/glvzACQavViBq0GNQQj1StcZQnJ+vzIRL5g6Yibo9fvnXoltdx0Gm+14zHg/I+AZiy/IGbzc16/ooFIg8uy+noBwex+wejxVA1++53iMOCi25glnlCDxxRxfJIyAF0To+E1GB+BkVsLERDjXTZ8pvWza0D5NeyoP/k6UYrErQH48FVSUwSrVjdesP3cNWSDVi7NmMaNIi8dXyURNWkmrGDV/EQ4p2BabC5LRq8zNoRTn9DquqRHgv+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dln/R/Y0womQgi/U2vrnlyvGevvfnzeMr+HDqhV4YG0=;
 b=OMOlM4/MoOIxdd6QZlD0nKRf3DssoZuUSVCysROmAGObVqiNVNNffZ2r4Wq/L3fDH1gt/ffeewzHBbnXOUjDeZuhk7cnEg1p6ZWZmru+Hmcj61pchOhgb0tDH77Lu2zdJ5ohhuJpUpTRsNcP97BI5ZwwSw+xuHCr5Skud2JWAee0hjmqMCAt+Ke2lDFd5IREPwKfl3yieWQwzvjUJsh03HTEAsONwz531rn2dG+y3v32igd7TuMdjU9czEAWIxfCgZi94INlg4W3DbiwLCOOjmaImerdIArL0tE3h6hmpK90P+ki1yUO5/mg44ooU9BkTKTzCyN5yRxGu6boas0bng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dln/R/Y0womQgi/U2vrnlyvGevvfnzeMr+HDqhV4YG0=;
 b=GhP+Q3qcKnlSLR3s1Esvo/dwyyUBd4MuZsxQPMIiC0se63yqdrQeTJ1w0SQvflDLAgWFH40gFwQ+HwpypiRTANzwYYeirWV/ysY6PqXeqZsReMSKTR0FqCPp1Gx5z9GZuTGzvccXhS8lzbNEDtshxahRAFQlRZBkdT6BnonCBmqCyiYIwrG02Qyt2Cpj3b7MvJNbfhZNdYx0k0/kGbSIFLRxX3ByzcaqdJpcQAPcykq1rPFCLiGizobpUEwfKk5i74oVNUiIyA7qWwGik1SJqib5FFuCtN/zUPTSeb012rUgHiuTRhzlMPr8CSu0WvKd0FE7pulOdDQF35a1SAiklQ==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by KL1PR01MB3809.apcprd01.prod.exchangelabs.com
 (2603:1096:820:41::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Thu, 20 Jul
 2023 17:45:12 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::e01e:6b99:522d:65e8]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::e01e:6b99:522d:65e8%6]) with mapi id 15.20.6588.031; Thu, 20 Jul 2023
 17:45:12 +0000
Message-ID: <TYZPR01MB555645E1C1100ED41B3D02D5C93EA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Date:   Fri, 21 Jul 2023 01:45:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mmc: meson-mx-sdhc: Fix initialization frozen issue
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <TYZPR01MB5556B56D834E02F41C44D81DC95FA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <CAFBinCAJ1E6JKmFTuaJwGpd_MBzHMZ0mMj-1AE3TNeB2_72nZA@mail.gmail.com>
From:   Ziyang Huang <hzyitc@outlook.com>
Cc:     jbrunet@baylibre.com, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, neil.armstrong@linaro.org,
        ulf.hansson@linaro.org
In-Reply-To: <CAFBinCAJ1E6JKmFTuaJwGpd_MBzHMZ0mMj-1AE3TNeB2_72nZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [161d7Lqt2tlivRIhmLwNSrY4pr7hXdtsNq+cDhfcHDs=]
X-ClientProxiedBy: SG2PR01CA0135.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::15) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID: <2ab030da-6998-50ef-017b-1f5655cbdca2@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|KL1PR01MB3809:EE_
X-MS-Office365-Filtering-Correlation-Id: 443b9e9f-4eb0-4b78-2a7d-08db89491152
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RRC8pmU8FQKoo0B+xIYbNqlWYBVra2cAaHJAMlm4w/OLq7yd6Wxh8bMs2DORMj+z3eghFlbm3ALQ9VNTj1tUQ9A9x1DqgSRoWBBnMILEPegBE0cB84PxxWFhtHcvijFyg6tXRZIfdA7pYaHkmDp/V1t/yIBcsBops96V/6qV6143hLbads6SfnTwfhoRC4/aSiaRBtfue7nx35KH9F82rLs2kKKPwYKNX5JfsjQoTvX+/85xaIsbOM5wcAkR7iIp4mBnPtTRJ5nuBciIf8ROgQ6yNgOPClSvUZ0TmXkTh2+7iTg9QpOhUhGaVBgcT+lkV8IsM3G2RndiULXEIpBDhqTdsByaHRuZzzLqpcRad9zViEoT+q5W6EbhW4w3So9PzAHIOFsC9Zu9+ZFM2HuhzJX8I46JbyE0zgAnB/y34mo9ItX44px9Ul7ZnJVHSrwSnH8smpiSa0w1Of+MeGfz46Z33rPD22tW1mvnNOCNmgr9fj4JNJlPydvgixcNLUrt/gDWgMD6N6e82B+k0sK9d+Zio0C+iY5wT7Bb8wkqh44=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWltTXNhT3k3TU90S2pDeElkRnZ2VzRkTTd2ai9UNUZJSWY5Z3lXZU5wamF5?=
 =?utf-8?B?NkZManVKbUs2VzdySXlFUnlYdDk3YTUrM3FyYTVRRjhrNEVQUUJ1a1FYaFRx?=
 =?utf-8?B?VitwUHM3Vm9rbWVOYVdtcFJuVHhpbVlnM0NPMzJyOEZGNjdNS2s5UFZRNExk?=
 =?utf-8?B?VEtVMFg4U254OStmWW1iL01CYkozTjZZdTZzemR3OTBnM3RwbnV5MnBPdmVS?=
 =?utf-8?B?a3UzMUk3eGJBR0hWSG5XMnA2WjNwWjZMS3NaeGIzMm5JZHgzSHhRelExUG1S?=
 =?utf-8?B?bDNGZ2ZpRXZuNFd5MVFKSkRnTlBOdTZuRnhWZWJQU0J0M2hOODQvVndYeXpw?=
 =?utf-8?B?Y0lCTm1qbmlYaTZidjhRQmwxRTl4ekJqbTlQdzlVSmNjWkh4K0FQbTl6UytM?=
 =?utf-8?B?endVWkRuT2tlNVFvMjd4bmxsU2FPN05iOUVCMTRHbXFyRnRJRDZoUXVOeEtM?=
 =?utf-8?B?VGhrZExwUGcyNmR5TzVVcDByWUpCZXRuNUFOT3BDK1lUaTdSbHlJRkorR2JE?=
 =?utf-8?B?ejlEK3hVVDF2NEl2ZTB4Nmx6bS9NSTQ2amdQVmpOYXNaZll6NHJhUHZ4Z0N5?=
 =?utf-8?B?T3FhSno5YXZOR3NVRFRpanc2YTJrWU9DY2FrLzBpYktNVi9oVXY0K1MyQlZT?=
 =?utf-8?B?QWJOaFpOeVhKUWF6cllxb3RjUUpvcE1XVjZhdk9wVkZUZjlhd21qR3Z1MEZn?=
 =?utf-8?B?R2d0VFFsWU1HOTZwOE5wbnNnaHNXMEpYQ1JyU3c4RGZiRmhIZ3FzYkFtSENq?=
 =?utf-8?B?bjJFREVSditNcUgzRG1xTFFqYk5yZUJEbkg2SlRoQWx0SWYxUUhmckpFa2dB?=
 =?utf-8?B?WHM4MUsyMEFWVzhCdFJ0UnRFekNwQU5TSjNTekdvNng1R2pOTm0wY0NjelNI?=
 =?utf-8?B?Z3YzTDdVcnRJeWZxNHlmbEF6ZGk1d252dXJ4ZjlpUFFycUdUZlVYZE1MTXVv?=
 =?utf-8?B?eU9qQVdGbVl1UWowOWZReGxTMWdZRG9qTUV0TGRteVpSS25DQ0QvYmhsY0Nw?=
 =?utf-8?B?RjZQM0thV24yZ3k0YnhsR01ZTWtVeFpFd2Uyd2U1MUExOTlzUWFyWmoveEwv?=
 =?utf-8?B?T1hxUExNa3M3NTk3Q042aWNZUjA1d0MxdVFUVmNNbGFralg1U1JnL2dUcUM5?=
 =?utf-8?B?Umt0S2NSWW9ySk5DMzNjcHlXT24rUEFwZUpXQ0tyU1BDWVpaSzg3ckYzU2hz?=
 =?utf-8?B?UEY1akRocDNmaE9RQS9nZmovbkVFMExQWmxaWDRoS0tZVXRXWWoxZURuajIz?=
 =?utf-8?B?UVZPRExRbUNySlAxVFlHYjNSRFp2QSs5TDJncHgzQ2o4U3p1UTFNMnU0Vk4x?=
 =?utf-8?B?TzV0eXFvOEgyRyswZ3FDbzVTNWtZdVZvSWZFOFgrNFViUUFlMTR2QUxMTWhn?=
 =?utf-8?B?T1RkWmdrcGtQYktBZTRVU204OUlJaFlyTXdKc1dnQVA2czgyOXVhQUI5K3l5?=
 =?utf-8?B?UWI1K1BUN0JJVDh6U3JJd1AzNGwzS1hsaVNpODhxV2doZDNXSkxOcStVQzJu?=
 =?utf-8?B?WjU2WmFBVmw0Qkw2a3BiaExHeC9BTUdEU2FYekgrSk1IRUlJMTAzclR0Q1Bz?=
 =?utf-8?B?WWE3K3FCdnUzcU1pVHR5STlTemlpQjQrcng3bGlFRkFLUFpLRmRFeXRpdWVv?=
 =?utf-8?B?aVlrQ2ZIbncrUWJORVhqUTkvV0x0QWc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443b9e9f-4eb0-4b78-2a7d-08db89491152
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 17:45:12.1951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB3809
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/6/20 3:51, Martin Blumenstingl 写道:
> Hello,
> 
> first of all: thank you for this patch!
> 
> On Mon, Jun 19, 2023 at 7:36 PM Ziyang Huang <hzyitc@outlook.com> wrote:
>>
>> Commit 4bc31edebde5 ("mmc: core: Set HS clock speed before sending
>> HS CMD13") set HS clock (52MHz) before switching to HS mode. For this
>> freq, FCLK_DIV5 will be selected and div value is 10 (reg value is 9).
>> Then we set rx_clk_phase to 11 or 15 which is out of range and make
>> hardware frozen. After we send command request, no irq will be
>> interrupted and the mmc driver will keep to wait for request finished,
>> even durning rebooting.
> I think this is the exact same problem I reported some days ago: [0]
> Ulf is questioning whether we properly support 52MHz clocks correctly,
> so I think you're onto something!
> 
> So this is an excellent finding! I can confirm that using rx_clk_phase
> of 1 makes my Odroid-C1 eMMC work again :-)
> 
>> So let's set a common value - 1 just for initialization. Then let
>> meson_mx_sdhc_execute_tuning() to find the accurate value for data
>> transfer.
> As far as I know unconditionally using value 1 can negatively affect
> other devices.
> I'm assuming that you're testing on an Odroid-C1 or similar board with
> HS200 eMMC:
> On those SoC + eMMC combinations we do support. But on other boards
> (for example Meson8b EC-100 / Endless Mini) there's no HS200 support
> because the eMMC is connected with 3.3V IO lines. So tuning is not
> executed there (if I recall correctly).

Sorry for the later reply. I'm so busy these day.

After checking the code, I found the following flow, so I think 
tuningshould work for all cards.

   mmc_start_request()
     -> __mmc_start_request()
       -> mmc_retune()
         -> mmc_execute_tuning()          -> host->ops->execute_tuning()

And yes, 1 may be not a good choice. I consider 3 values:
   - 1
   - div_val / 2
   - div_val - 1

Maybe, (div_val / 2) is a good choice. How do you think?

> What do you think about adding a special case for the 51MHz "actual
> clock rate" and adding a comment that it was found by manual testing?
> For some reason (that I don't understand) Amlogic's vendor driver
> maxes out at 47.22MHz (presumably because they limit themselves to
> using FCLK_DIV3 as input only - but I don't get why...).

With some modifications, I found that the mmc controller of S805 can 
work with all frequency, not only those mentioned in commit 
e4bf1b0970ef("mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson 
SDHC host"). It seem like that every things work fine. I will use a 
oscilloscope to confirm the hardware clock is correct when I have time.

For this future commit, I don't want to add a special case.

> Best regards,
> Martin
> 
> 
> [0] https://lore.kernel.org/linux-amlogic/CAFBinCD0RT0p-jk86W0JuMT3ufohRh1RqWCcM35DKZJpuc10HQ@mail.gmail.com/
> [1] https://lore.kernel.org/linux-amlogic/CAPDyKFpS-UwiaRPMqSpX0mNPrS5p=yJzu3g0=pGyCkWHSYyqWg@mail.gmail.com/

