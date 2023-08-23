Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D05784EB2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 04:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjHWC0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 22:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjHWC0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 22:26:35 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2135.outbound.protection.outlook.com [40.107.215.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF634D3;
        Tue, 22 Aug 2023 19:25:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ra/8ttWzwsERIohKW8cVxA+7+/HDHtfVABAgJlRh9moCsGgKaNM2xZOtC5SvsyF6Y0Sc9BWboyDwKVF/yf1BwipGnrfiP6CRemVP+ch8FHixHv6Z+x05HnNJjBLPcoz6h8Tkgq7CjJdpYtVSPvXrtanF1WdX29ytvxSuFMrbZz1sfBvtgR077ElvPn4Z3y9Z8GMD5gZz9zHcvWYpWMDaoGQXW7GToDERVG+T9W7bjJl9l7/3a3bsanOgRevOBeVw92b8Oq5/H3XSDJgPErWA27Z1Nd6xC+0IBAsG258gMlmph3M3OuemvlUvh+vTyZyayZKaIovo9FFheBhUh0k2pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qo3/Hu2ipxAGkoU1GPuc0+PGiajr1dNpa+Y4IDQdww4=;
 b=HU8RudIEvvP45NoYHF4hPFhTqSjGL4sMJ39ftf7orEZcUEwxt9HfJj49TKy7TGuqt9nJ3/WiQzHLhxBxqy3rotNeVbVpZl8J74l7FpucOIxVnGTJEl+gQKuQIbOazTtSW1Aoimz8PIFyf7T+sqrmdBndDQFUQHBdBEkpe0sus3XsEkUH05ANx1MGaySQu83pHyqPtzg7Lu5IRUgXMCoBTc2jUpOcawC0RjTCYm/5CYOh+CXHGrQknfavmjNXXTVEzE6X29QA0nH0tpHqN87++RoFtKhnTwRWBA435n5L8nxsJKGIoc7d/uKkNlWbAZmcHryE5s5mv2yI0zaJSfIXcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qo3/Hu2ipxAGkoU1GPuc0+PGiajr1dNpa+Y4IDQdww4=;
 b=QKP4etB7qCjsvR7Ed9Oj1S20txRnHH2leqXrGgoR1lAADZfgu3W+QSCpjJBzNvPfbBc00q3x67buQSiplzTOW81TNt7QeojEEST8lUH57KFwZ/utlxs5KZX/DfXeyDtKZCz8fy3NRyA/VTnGqi2Z/pGXS+AsPaacMpxIojR6jpqNYtFZ3aWvrSLSRdE4OyJgjII7pmCdpQwxnVxxauWf451MhyBzZUnc6cD+cYg8vMtxhVLYrAYsrU8jBT5DXb7Ec5nYEXG9uaONzUzeBukcNcQV494aucn6BZw92m6oiUgRavSCvt+SdZBbpePZK00QmGx7x+5u5Rx4TqMZASHrAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com (2603:1096:4:1d5::9) by
 SEZPR03MB7356.apcprd03.prod.outlook.com (2603:1096:101:12b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 02:25:43 +0000
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::6f04:4b62:1127:59ed]) by SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::6f04:4b62:1127:59ed%4]) with mapi id 15.20.6678.029; Wed, 23 Aug 2023
 02:25:43 +0000
Message-ID: <e9932f90-a011-ee9b-ef09-f2e2475bdd0d@amlogic.com>
Date:   Wed, 23 Aug 2023 10:24:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V10 1/4] dt-bindings: clock: document Amlogic S4 SoC PLL
 clock controller
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
Content-Language: en-US
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <d2a6060a-c8a0-51c7-f621-1bed2c3074b4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To SG2PR03MB6730.apcprd03.prod.outlook.com
 (2603:1096:4:1d5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB6730:EE_|SEZPR03MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 69cd66ec-2791-40c3-bcf6-08dba3803fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nDqNw7Kn7FUhnlHeJPECp+hArgIS37L1fTm3Y03bmNXVqRmZc5dOshDpFsp18L2xpxj2Iuu1pXwSUUjJWOjvA5LaMMr+vbG9azyclG/SYuevdx563inklwkWKnuZnIQAZkgUyyI4cnHVTXtg2imgetloNBI3XyHu4qq+kzplmTAADVmAU1qJX2HOoBYx8uKxzxfBcS2AE4jLh9yPlLkW6QSJ6e1YcpdZJl67FSFBj2Q7l4IW9kwjO8F7trRNkkDFjGwbl/GB41/WRcZNHmQC80udwtemEePJ3/esSaAy/9HWItYHt51oS7+lU7lbx4S3qOAuIdgiVifZOFT4kRSLKLja32jiKRaRndfv3qbfrMcmtMnGMl4Q9uKC+xjkWN0zol4WakgHjcVJcokDTgpxxwSRca9+TFtw9PMVbKdMyCihvXgfwd5tTWsepAhnZDv9uZCNN0LWy5SjyPZdSJVFitr7eoEjMZb4X2ZtxYCxN+946igXHKh9vafh7PmoMZmDLTcbZlwosTUiqqk4MNkpBwgsAUeeCjLlJtWXOnU6fqqb4KpW6L6dJ/H8C+KtMWSWmKL+qPakAJdzcf3P0YcCKu49NBBrma4iqfwfuhlSKwsbGJSK74pW0yVRKbjp1PAqEpv+YvWaVTeL++2JsbcnUZASMrIjflzNb4WKs6/s9HdrJDMihJhZJxh9BPmJFmoO6AZnsB5k0kMnKlPy3kAoUwJNW3JJyvLVpb+UK6FItdC+RR15UiQ+9jMpAS1/K8Ja
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6730.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(376002)(366004)(136003)(396003)(451199024)(186009)(1800799009)(921005)(26005)(2616005)(478600001)(107886003)(6506007)(6486002)(6666004)(53546011)(6512007)(38100700002)(41300700001)(66946007)(316002)(66476007)(66556008)(110136005)(12101799020)(31686004)(83380400001)(5660300002)(44832011)(4744005)(8676002)(8936002)(4326008)(7416002)(2906002)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekZXczhjY2habkZMTDcra25sTjhOWHVGdVJhTUorcTBvdTFrbjRWVEZTTThP?=
 =?utf-8?B?Zm50b0FhYjU4MVhHbkJrYUZOZkpTT3drRDlZQ2QwVmJSaVh5aUJOZFQ5eGZI?=
 =?utf-8?B?WEg5aHhoNURkUlRXc2NVRmlKWHN0U0JTN3VqUVpPaHgwbCswZXFLNW55OEN6?=
 =?utf-8?B?enM1aWFvMFQrUFlhemJScFRqb3dlVTFUR1NFaFpFSTdIMWhZWDErZitrSXJr?=
 =?utf-8?B?b1BkeFEwVU9pUlRqRWJCank2elFsc2Z4UWdCQUV3VXFHN1Z0TUJ6QzNoVU5y?=
 =?utf-8?B?Vm1LL3ZDL1B0SHlleHB5REo4cURkbWtjeTQvclE0TXVMNDJBUmNlUHloYktm?=
 =?utf-8?B?NHhyUVpRTS9kcVRnY1FSQlJVYXNRcWFJSTZoUUFtbjBDNU53cEJ4SEhaczZM?=
 =?utf-8?B?VHp1aTFZMFNKOHY4M1habFI0Z09Dd2lnMFRkK2kxQzU0RFZtMXR3cy9uTng2?=
 =?utf-8?B?SW0wQ3U5NGVRcjdHRjFXRjZva3pZM3M0Q0c1cXpycTFNdzlHaTQvMmdwRS9t?=
 =?utf-8?B?eFZmdnh6dHRkbStZNzgwVUlXYWZmeFpmRStnSHQ4TUdidjBjSmozYTA3RjJq?=
 =?utf-8?B?YjdoU08zNXdIUGxiNjVEc0dINExPY2pMcmVXc3lEV1BRczRWSWhHTVp4cE9k?=
 =?utf-8?B?cmtTdnN5bGhjSVliQmtvdWV2M1pQT2hhZE1aL3QvOUNFenB1dnYxVmhrUjFh?=
 =?utf-8?B?YnFmUFJ2OFdsd3FjVnB1WnduM0pUY3BybmliejhvTzJQR2FmUnI2WkNZR0Fm?=
 =?utf-8?B?ZTlaakMyNkJLc1dJN3NRaXI0bkl3SzlmMHNwcXF4NFpQdWZVa0ZEbGRkUlV6?=
 =?utf-8?B?dFI3V01jT2dIeVZlcVVpTyt3aDNRWUMwblM5THBaMXV1aitoMytpVUNMOGR0?=
 =?utf-8?B?SzhqaEJVM3ZBby9TVFZoT2F1VVc2ZGF5dzlFdDRhdnZUL2tEZDBwT3ZCNWFX?=
 =?utf-8?B?c0FYS1NCU0F4YzU0S21vNklTdEx4QVJ1YWdGaHR0WnkyWWZsM1Z4WTkwUHlX?=
 =?utf-8?B?OWdGejRaTUttR1gvRlBZdzdPK2h4VFJQaFdzazAxRWN5d0lvV0V5eUJZL29h?=
 =?utf-8?B?Y2cxa2t6ZGNzSWJ5SEFrbWoxL3ZoV1ErR2lWN2tvMnppNjM5cEwzTy9JeExJ?=
 =?utf-8?B?TjJLQTUzRDhpaFNFT0Jza003Um81VkNGREttWnlpSmpLakhZaTMycHJ0dHht?=
 =?utf-8?B?MGd3cGJlRVM2UTFMNFZHNzBFWEpKQ0dRV21mRXkwckw4Z1VRMmdmS1pSdjZn?=
 =?utf-8?B?WDl4WnBXc0lNNUg3YWs0T3RDRTdzSThSK0JVcG1WTFhuaGxDdWhNSWd4bXU0?=
 =?utf-8?B?WUdTaklLMjFtY1psTnA1czhucTE5S29PZzgxOTFxRkp1QXBoQ2s4UlJSY2wz?=
 =?utf-8?B?NVIrR3lBY0V0Mk8zdlc5V1pucWNzZDJvRVNxajRnSUR5R2NFVmV3QUpvMmpG?=
 =?utf-8?B?Zks1M3hLN3daZHF5b3lhSk13ODA3RXFXN2dSUlloa0hJTlUyVzNBdTJmMnJi?=
 =?utf-8?B?emF3RjlDQTFSbExKRXlIK1RmdW5KaHhwZWg1eElzTC84Yk94VjNaWkV5Wng0?=
 =?utf-8?B?RC9DeHNFVE9Xdkd4WURpTjlYQ1BPMW1aZGFoM2liNytGM0p6T2lhRTk5Qm5y?=
 =?utf-8?B?Nzh3RWgyVWJYdWJMRW9qNzRUajlLYm9FSTVxVFh0dDJBWkZDRytPanZNZG9k?=
 =?utf-8?B?aUJaTXFibk1VVVVWakY3UUw5SUtLbmcwcldVQ1B5alRPeHppMktOaVFZamFy?=
 =?utf-8?B?OHYyYlZaSjVtTUVJdFF4VWp1d1dYRndidWxsd3B0ekEvQkxrcHRvRlMrMmxW?=
 =?utf-8?B?emE1MHJLQTJYNmt5L0E4TTVSM1RCMDNZODVYdUM1SkcwTWd3UU1oYVZnQlB0?=
 =?utf-8?B?aURBcTN5OGl4eU5qaHY4S3BGSml4NE82WUE5NmVsblZ0ZWpSUEkweFc1N0Zj?=
 =?utf-8?B?S0tNTjhMdmZxZXFrbkhtc1FVdnBXYnFYSzJQMktXbHFCT3MyR3Yyc01LZ3RU?=
 =?utf-8?B?SVMxdTFjV3JTK0Q1N2VqWk5DL096Q0F5eVc2T2tQYzBiSTdKYXhramZhTjVj?=
 =?utf-8?B?OUpsRXZGWndqejJyVHFpUFEyd3ZQVDArbkJxRWpKUklWZ2JNNEkrNTBQamZi?=
 =?utf-8?Q?RCaWL3T1gwZnecGHOBgosxoER?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69cd66ec-2791-40c3-bcf6-08dba3803fbe
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6730.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 02:25:42.8587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/5lauZnVgRaWUI4PnXpc+v/xzjYHKn4vZUwhw+8cf2r4t7Lm9ID5hjXra6/sZ1aytpkFxU40tKgkm4X/dTE9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7356
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/23 0:32, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> > On 22/08/2023 10:27, Yu Tu wrote:
>> Add the S4 PLL clock controller dt-bindings in the S4 SoC family.
>>
>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> 
> Lovely. I sent youa  friendly reminder at v8 which turns our you
> ignored. You keep ignoring, I will start ignoring as well from now on.

Hi Krzysztof，

Sorry. I did not forget the friendly reminder in v8, I consulted you for 
this at the time, so I re-sent V9 after adding the tag. Because it was 
just "meson" that was removed. But V10 is based on Neil's patch, which I 
think is a bit of a change. So I didn't dare add it. Instead of 
forgetting your reminder.

So what should I do, I'll follow your advice exactly.

> 
> Best regards,
> Krzysztof
> 
