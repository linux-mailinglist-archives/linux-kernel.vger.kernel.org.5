Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698397852D9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbjHWIir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbjHWIfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:35:30 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2098.outbound.protection.outlook.com [40.107.215.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CA41987;
        Wed, 23 Aug 2023 01:32:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cu8QvnsxhV67neejqmy9mLm43o3vSjwGp3h9/S5lAfZwQeYeiRot73tUfGlQosm8ZvkTuShNPO6ONFXxOReK7C5ZYvD7bKuTBhs4e8ydvDnv0/7Dj4ygarGqPQMDcIO+3Ig/H/apNCYFkrjy1UQSFvV0sqTJmWQvpwJw+afEIT6o9O1xf3TZ6/LTOyt0xualbOnV2FMEGBrBq0UDNJArf4H+lhlDOXcLip/d9U4GeaQ8flU/VAOE8qQBC18nLiNUcpk8z+CKfM+jM8rpJ7A6zR4nqfJNhyuAk3GMV1QMOo2ZFT3G21C09HfWQm0ZHPQ+Kzokr44iN3YfQ6Ftl4yQMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5A8loyCUiegWZRuya9vvLUQPZhc9+82DSU0bkkgMykg=;
 b=YtA1SQXATairn5gXKSJbrKaSbBc20Jniezj9PN2Ot/vO8fVvlr9YJPXklkHjFYoi0jty/zEGiDRlIAaaujF8rNECzg3I/byiNAJaipP9fIJ6qQhLxyetttoxmsxHwjhviCu/GUM25w+sZFpEYa8LYnT6+CjWS1h226F8jLRIeo0rAVy0m9EQuYXoQh28THMPjqxBiE1e3WjvUaLdEE+goGbobkfmVkdiMvIbDyXBebKvOwIHiqfYowEBXnQBkAhKaocJlRhXzjoTBED/zcoTWW4BzWil31cJZPYuDUG5uYKEC4Hy/dwPog9MctC8fHpN9tyWrS63tPCRbDaSiUIQAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5A8loyCUiegWZRuya9vvLUQPZhc9+82DSU0bkkgMykg=;
 b=VFnZsKIGeyVqQiLuZFECY+Y8jqJHrSp7gmZVZOAJfthi+a90iqVm1bHw82KOMrnPDlKf+67NYORh+FyNvZqV7blU5hsCDhiT2c4IHUIOzUbkeb1C7ifDWPJpBgVzhEzq6ZrU3cHgerEdIFSkTR0I+OQOoi9y2OdAynrqJV0RTPooPMEfhPBUcsnKvdWA1/x+2FzRtSFmVQy+QfJjVZysngU8OiIEFdlXdKKKwE5iK2X2YUWcEdoYmOClglav7llWF9CVUqrh6lzR0A7FqaPQrmhq46xwcLhsrutKAKXA4Biuds4pczZLvr/aHmyl5F/8hjecyqU7pJkUo2xO+inAIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com (2603:1096:4:1d5::9) by
 SEZPR03MB8324.apcprd03.prod.outlook.com (2603:1096:101:19f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.25; Wed, 23 Aug 2023 08:32:27 +0000
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::6f04:4b62:1127:59ed]) by SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::6f04:4b62:1127:59ed%4]) with mapi id 15.20.6678.029; Wed, 23 Aug 2023
 08:32:27 +0000
Message-ID: <3fa20b2f-c87f-1896-7d6d-a72b5e8aa6ba@amlogic.com>
Date:   Wed, 23 Aug 2023 16:32:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V10 2/4] dt-bindings: clock: document Amlogic S4 SoC
 peripherals clock controller
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kelvin.zhang@amlogic.com, qi.duan@amlogic.com
References: <20230822082750.27633-1-yu.tu@amlogic.com>
 <20230822082750.27633-3-yu.tu@amlogic.com>
 <1jbkey9obf.fsf@starbuckisacylon.baylibre.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <1jbkey9obf.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To SG2PR03MB6730.apcprd03.prod.outlook.com
 (2603:1096:4:1d5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB6730:EE_|SEZPR03MB8324:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f11a074-8d09-4f7e-4931-08dba3b37ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ct0rhOgHll7CDvU2EQ33sCpsaY799F64xrKIiIp7Okr7K0+UWvFcg8CUi8KO90YmgYSzTCjnKdnu7r6H8hPZjvW2UsHgQV0AfbY3wW7LB8b/HPMrEwlh2YBQWGZEvgerCm0tVN7Zn4HDuWm5unUlFxLUrGWoZNxOEceJ25zCXPphk4S2chqVTGOs4QpP0M+DVnEaGz+f+IpMCKqVLw6ZspH4W+aTyFEJnDuYKcmkSNm1wVtx/mJWi7X0xYQoRsswm370BeQtO9NdW/XxF8JOsff4oR/TsPar3XlUruLOAFDszUVjIGd03ng26wgP1SMdCrM3WzJ0eIhoyFphsejqlJP7TGhWGqQqh9c3a+UEOvZLQ5i6r0kRQNWWpoq4nfQ2J4a55xikhcTXZG6Xmu9Y9gi2d3BhjF/6MRysJlfSl1GPoyGD0S+9UfqFcO5/2IbSQSiIVO7VEe8560wuOf4QR5rhoyZ/TOunpHKDwnBeomY30N0NaArhqqs76Zff4tDvjyMBUxspBBBiazUheQnPPtPmxeIvAC1Kn5SdBfaAolD7MLXvDSl+fRxvd/LKcxvCq+IKg01AeIwpTP91vsIaTUJeCEq0gATWUs2GSwPT31qYoHgJEwuHEaiZWCMeolrCo5vwoToeaJG/fyvTB/7z5QEPenx7yBoNt5IEGoOXKjDzLDcepvN79LFurggs7BHa+Z60+ivdnAv6ytf3ec0hC1a6EsL7P9mfTV/LcdKe4CI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6730.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(376002)(136003)(396003)(366004)(451199024)(186009)(1800799009)(921005)(966005)(26005)(2616005)(107886003)(478600001)(6506007)(53546011)(6666004)(6486002)(6512007)(41300700001)(38100700002)(66476007)(66556008)(316002)(66946007)(12101799020)(31686004)(83380400001)(44832011)(5660300002)(2906002)(30864003)(4326008)(8676002)(8936002)(7416002)(110136005)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2FjcElRQUg2eXg5dFJQeGh2dlpJbk43NU4rb2plWWV2enh1TG9uUFF0TWFV?=
 =?utf-8?B?MEYvbW9YWG5jdEwrZlBxV3cvQXd1aEJ1YlJCTkhSTEZXc1JNRlBWZWdwL2Ju?=
 =?utf-8?B?SnpyK2h0MXp4aEhEaEpjZHA3Mk9iTUdLZ012ZTJrRGNScVNEYWVpemdkQVl3?=
 =?utf-8?B?M2VCaHpYSWZoN2xTY3l1bXZpbWVpdnNTUkRSRXNvNXBSS3ZCM0N4SHllbkVa?=
 =?utf-8?B?akZSUndLakozS3RqU1NYSWdPK2d1QStRbjY0eVJEbitEYm1sMnkxQ1JQVDNV?=
 =?utf-8?B?TDA1SWcyWEEyeDZKUFd0U2ozSXljbWN4eE54YWJ3UUhDUjBQUjMrWDdaZTFt?=
 =?utf-8?B?TTh1KzBXNHN5enhDcVA0bEh6UTdxMGxPMDMyemdrY2s1aFNYTitGV2NCMWpa?=
 =?utf-8?B?Kzdid2ZiYk90S1F3NW5YdGcrSTYvcEppOFRpdnJlREVZaWpLRmFYT0dyeERz?=
 =?utf-8?B?ZDFRVkRydmpnN1VoZFRHc0o3MENzdm9GQmY2b24ybTVjZElMdkQwUWFpSkhO?=
 =?utf-8?B?UHFXTndZbURtVVcwelluQVZwOXpmMGo5MzZoYUx2MjJJejc3ZU85U2FKT1hB?=
 =?utf-8?B?aCtpd0s4QTYyandpUzdaYzE0aVl1cnljaFVxOVl4anJrY05aWGxZTnpZbGtK?=
 =?utf-8?B?WG0vYXJQdDBFL21mWG02TEV2bUtMaDFWb1o2UDBZaDhzaHhvcDVZWFlydG5Y?=
 =?utf-8?B?UmFpcllwTnFKVVk5bjJZS05YM3I3Y0lRbW8ySERhZ3ZONkk4MC9XYlFwVDZ6?=
 =?utf-8?B?QXlMNFVQdmdlL2R3RE02ekZiSzlNekN6czcvZEpGTlpXdHQyTzM3UlNzSjNG?=
 =?utf-8?B?VG9UY3dYVnZLdjlqM0tpUnFXRy9Vd0hYS25SS1QrUllIbVEvdTdvRDh4Y2NP?=
 =?utf-8?B?R1Y0VWxzbEYrakN5d1F4T3FpRkRCbHl3dVpMalpKbkN0SVNqSFo3STBQeCt0?=
 =?utf-8?B?T2FQNm40YXpuMURVZS9ETHRodzJDbHd2eWpGcUxzNFhKbVk1eG1XWVdYaWVI?=
 =?utf-8?B?NXN3SEt2QmxXNnVDT05qWFJQeHI1bld5OVU0a1BWNU5rOE5LS2IraS84TStZ?=
 =?utf-8?B?VGVqSE11WHhXTVM4T0pScU5WTW94UHJyd2drNjZXMWtFYlpwcEJhZGwwTTRU?=
 =?utf-8?B?SW5JNDU5YXc0dmd6Y2tBSjhrdmFTZzR2S0pGNDhiUjlWME5JSTNtQ3BuL283?=
 =?utf-8?B?cWdFcUdkMzh4bmxjMVJ1K1A1UVg1NWxVYUpQeWJyZTVwUTY1T3lhYWMwN2hG?=
 =?utf-8?B?a3B3TlpTSDlwTGdUQmpXeFZOTGhuVTVBRUpSQ0lYOUljaTdocHBZeS8zTCtD?=
 =?utf-8?B?aXlDUlNQRy9EZEhoRlcreURJTklNWDk1MUV4SXNYWm8ySHlHYlB2RXJlMVBV?=
 =?utf-8?B?N2U1M050SzRxL04wQUl5TDA5bzhXMHUvWDl6bm45VFNZbnRGNUFoRldFQ1Uz?=
 =?utf-8?B?aEt2UHEwaEYvLzNBNG5jaHJtRzZRaDYyYjkrTkd3VFZZaTMxQ2duV3NyMmNa?=
 =?utf-8?B?NHFiNDRsaDlpS0N5SDhHT0RwdUxUeUIxWWlKNEFkYVZsdXk0WFNzZHlRaEpu?=
 =?utf-8?B?RnBhLzBwbU1uVW9vblQvQTF0V2ozcXUvTnJDVWJGMEhSdU5oQmJRTFcwVHMw?=
 =?utf-8?B?OCtyZ0JKNWFROUUwZ3lFZHo0cWJkTko4a3Y2bk5FN1IrSG1tRk92U09kd3E5?=
 =?utf-8?B?elB2blZzemo0WmFpWjBac3dDZkl4UlRoZnMyejZqUWdpVUJPSkJWcU9BbWdZ?=
 =?utf-8?B?VzExTGJ0cWVaVG9uclVXQ2lMazNTTzExcXo4aFhIcXZwVHdxZHo1SFNXU09q?=
 =?utf-8?B?cE5DM0JCSmhHVzFYVzN1Rm80VlAxQ0NxRSt2UE9CSVd0a2ZSNTIyN2l0cm1Y?=
 =?utf-8?B?a04yRHBWVk41dGN2cFpWOHR3d0xXaTl3TGp3SnViNk1Wc0kvWTVHR0I3djAx?=
 =?utf-8?B?NzBaaWpaay94aCtBSFNvUTIzbmp5cTgzajN3dkpkRW5EUUJ0RlQzS05zdU5y?=
 =?utf-8?B?ejZBWlhHVm45SXgvZmVPMDluVENaYzZVWHo2R2w5Vkhrd2NEMm8vb1d5VTZk?=
 =?utf-8?B?Z1VwNjRXODBQWXJsUXg2bHp2WExHR1UvWkh1L3diOXpYNkthc3MzZkhSa2kw?=
 =?utf-8?Q?IsisEstEdN6hOSsX1LY0X3QxD?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f11a074-8d09-4f7e-4931-08dba3b37ba6
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6730.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 08:32:27.5661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E7muD2ctIr17sylruc3+nII1aA19CP7RYGlx0Htd28jvGIWuhyMUz3BslB0Rt2yL6NEzeje8CbieuS1PMUzEDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8324
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/23 16:01, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Tue 22 Aug 2023 at 16:27, Yu Tu <yu.tu@amlogic.com> wrote:
> 
>> Add the S4 peripherals clock controller dt-bindings in the S4 SoC
>> family.
>>
>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>> ---
>>   .../clock/amlogic,s4-peripherals-clkc.yaml    |  96 +++++++
>>   .../clock/amlogic,s4-peripherals-clkc.h       | 236 ++++++++++++++++++
>>   2 files changed, 332 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
>>   create mode 100644 include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
>> new file mode 100644
>> index 000000000000..e166563e7b14
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
>> @@ -0,0 +1,96 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2022-2023 Amlogic, Inc. All rights reserved
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/amlogic,s4-peripherals-clkc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Amlogic S4 Peripherals Clock Controller
>> +
>> +maintainers:
>> +  - Yu Tu <yu.tu@amlogic.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: amlogic,s4-peripherals-clkc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: input fixed pll div2
>> +      - description: input fixed pll div2p5
>> +      - description: input fixed pll div3
>> +      - description: input fixed pll div4
>> +      - description: input fixed pll div5
>> +      - description: input fixed pll div7
>> +      - description: input hifi pll
>> +      - description: input gp0 pll
>> +      - description: input mpll0
>> +      - description: input mpll1
>> +      - description: input mpll2
>> +      - description: input mpll3
>> +      - description: input hdmi pll
>> +      - description: input oscillator (usually at 24MHz)
>> +      - description: input external 32kHz reference (optional)
> 
> The bindings described here does not make this last clock optional, but
> requires it. This is going to be a problem since most platforms won't
> have this clock.

Hi Jerome,
	Do you mean that we can delete the description of "external 32kHz", 
because we hardly use it?

> 
> You are missing minItems.
> Same below

I will add it in next version.

> 
>> +
>> +  clock-names:
>> +    items:
>> +      - const: fclk_div2
>> +      - const: fclk_div2p5
>> +      - const: fclk_div3
>> +      - const: fclk_div4
>> +      - const: fclk_div5
>> +      - const: fclk_div7
>> +      - const: hifi_pll
>> +      - const: gp0_pll
>> +      - const: mpll0
>> +      - const: mpll1
>> +      - const: mpll2
>> +      - const: mpll3
>> +      - const: hdmi_pll
>> +      - const: xtal
>> +      - const: ext_32k
>> +
>> +  "#clock-cells":
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - "#clock-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/amlogic,s4-peripherals-clkc.h>
>> +
>> +    clkc_periphs: clock-controller@fe000000 {
>> +      compatible = "amlogic,s4-peripherals-clkc";
>> +      reg = <0xfe000000 0x49c>;
>> +      clocks = <&clkc_pll 3>,
>> +              <&clkc_pll 13>,
>> +              <&clkc_pll 5>,
>> +              <&clkc_pll 7>,
>> +              <&clkc_pll 9>,
>> +              <&clkc_pll 11>,
>> +              <&clkc_pll 17>,
>> +              <&clkc_pll 15>,
>> +              <&clkc_pll 25>,
>> +              <&clkc_pll 27>,
>> +              <&clkc_pll 29>,
>> +              <&clkc_pll 31>,
>> +              <&clkc_pll 20>,
>> +              <&xtal>,
>> +              <&ext_32k>;
>> +      clock-names = "fclk_div2", "fclk_div2p5", "fclk_div3", "fclk_div4",
>> +                    "fclk_div5", "fclk_div7", "hifi_pll", "gp0_pll",
>> +                    "mpll0", "mpll1", "mpll2", "mpll3", "hdmi_pll", "xtal",
>> +                    "ext_32k";
>> +      #clock-cells = <1>;
>> +    };
>> +...
>> diff --git a/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
>> new file mode 100644
>> index 000000000000..861a331963ac
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
>> @@ -0,0 +1,236 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
>> +/*
>> + * Copyright (c) 2022-2023 Amlogic, Inc. All rights reserved.
>> + * Author: Yu Tu <yu.tu@amlogic.com>
>> + */
>> +
>> +#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H
>> +#define _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H
>> +
>> +#define CLKID_RTC_32K_CLKIN          0
>> +#define CLKID_RTC_32K_DIV            1
>> +#define CLKID_RTC_32K_SEL            2
>> +#define CLKID_RTC_32K_XATL           3
>> +#define CLKID_RTC                    4
>> +#define CLKID_SYS_CLK_B_SEL          5
>> +#define CLKID_SYS_CLK_B_DIV          6
>> +#define CLKID_SYS_CLK_B                      7
>> +#define CLKID_SYS_CLK_A_SEL          8
>> +#define CLKID_SYS_CLK_A_DIV          9
>> +#define CLKID_SYS_CLK_A                      10
>> +#define CLKID_SYS                    11
>> +#define CLKID_CECA_32K_CLKIN         12
>> +#define CLKID_CECA_32K_DIV           13
>> +#define CLKID_CECA_32K_SEL_PRE               14
>> +#define CLKID_CECA_32K_SEL           15
>> +#define CLKID_CECA_32K_CLKOUT                16
>> +#define CLKID_CECB_32K_CLKIN         17
>> +#define CLKID_CECB_32K_DIV           18
>> +#define CLKID_CECB_32K_SEL_PRE               19
>> +#define CLKID_CECB_32K_SEL           20
>> +#define CLKID_CECB_32K_CLKOUT                21
>> +#define CLKID_SC_CLK_SEL             22
>> +#define CLKID_SC_CLK_DIV             23
>> +#define CLKID_SC                     24
>> +#define CLKID_12_24M                 25
>> +#define CLKID_12M_CLK_DIV            26
>> +#define CLKID_12_24M_CLK_SEL         27
>> +#define CLKID_VID_PLL_DIV            28
>> +#define CLKID_VID_PLL_SEL            29
>> +#define CLKID_VID_PLL                        30
>> +#define CLKID_VCLK_SEL                       31
>> +#define CLKID_VCLK2_SEL                      32
>> +#define CLKID_VCLK_INPUT             33
>> +#define CLKID_VCLK2_INPUT            34
>> +#define CLKID_VCLK_DIV                       35
>> +#define CLKID_VCLK2_DIV                      36
>> +#define CLKID_VCLK                   37
>> +#define CLKID_VCLK2                  38
>> +#define CLKID_VCLK_DIV1                      39
>> +#define CLKID_VCLK_DIV2_EN           40
>> +#define CLKID_VCLK_DIV4_EN           41
>> +#define CLKID_VCLK_DIV6_EN           42
>> +#define CLKID_VCLK_DIV12_EN          43
>> +#define CLKID_VCLK2_DIV1             44
>> +#define CLKID_VCLK2_DIV2_EN          45
>> +#define CLKID_VCLK2_DIV4_EN          46
>> +#define CLKID_VCLK2_DIV6_EN          47
>> +#define CLKID_VCLK2_DIV12_EN         48
>> +#define CLKID_VCLK_DIV2                      49
>> +#define CLKID_VCLK_DIV4                      50
>> +#define CLKID_VCLK_DIV6                      51
>> +#define CLKID_VCLK_DIV12             52
>> +#define CLKID_VCLK2_DIV2             53
>> +#define CLKID_VCLK2_DIV4             54
>> +#define CLKID_VCLK2_DIV6             55
>> +#define CLKID_VCLK2_DIV12            56
>> +#define CLKID_CTS_ENCI_SEL           57
>> +#define CLKID_CTS_ENCP_SEL           58
>> +#define CLKID_CTS_VDAC_SEL           59
>> +#define CLKID_HDMI_TX_SEL            60
>> +#define CLKID_CTS_ENCI                       61
>> +#define CLKID_CTS_ENCP                       62
>> +#define CLKID_CTS_VDAC                       63
>> +#define CLKID_HDMI_TX                        64
>> +#define CLKID_HDMI_SEL                       65
>> +#define CLKID_HDMI_DIV                       66
>> +#define CLKID_HDMI                   67
>> +#define CLKID_TS_CLK_DIV             68
>> +#define CLKID_TS                     69
>> +#define CLKID_MALI_0_SEL             70
>> +#define CLKID_MALI_0_DIV             71
>> +#define CLKID_MALI_0                 72
>> +#define CLKID_MALI_1_SEL             73
>> +#define CLKID_MALI_1_DIV             74
>> +#define CLKID_MALI_1                 75
>> +#define CLKID_MALI_SEL                       76
>> +#define CLKID_VDEC_P0_SEL            77
>> +#define CLKID_VDEC_P0_DIV            78
>> +#define CLKID_VDEC_P0                        79
>> +#define CLKID_VDEC_P1_SEL            80
>> +#define CLKID_VDEC_P1_DIV            81
>> +#define CLKID_VDEC_P1                        82
>> +#define CLKID_VDEC_SEL                       83
>> +#define CLKID_HEVCF_P0_SEL           84
>> +#define CLKID_HEVCF_P0_DIV           85
>> +#define CLKID_HEVCF_P0                       86
>> +#define CLKID_HEVCF_P1_SEL           87
>> +#define CLKID_HEVCF_P1_DIV           88
>> +#define CLKID_HEVCF_P1                       89
>> +#define CLKID_HEVCF_SEL                      90
>> +#define CLKID_VPU_0_SEL                      91
>> +#define CLKID_VPU_0_DIV                      92
>> +#define CLKID_VPU_0                  93
>> +#define CLKID_VPU_1_SEL                      94
>> +#define CLKID_VPU_1_DIV                      95
>> +#define CLKID_VPU_1                  96
>> +#define CLKID_VPU                    97
>> +#define CLKID_VPU_CLKB_TMP_SEL               98
>> +#define CLKID_VPU_CLKB_TMP_DIV               99
>> +#define CLKID_VPU_CLKB_TMP           100
>> +#define CLKID_VPU_CLKB_DIV           101
>> +#define CLKID_VPU_CLKB                       102
>> +#define CLKID_VPU_CLKC_P0_SEL                103
>> +#define CLKID_VPU_CLKC_P0_DIV                104
>> +#define CLKID_VPU_CLKC_P0            105
>> +#define CLKID_VPU_CLKC_P1_SEL                106
>> +#define CLKID_VPU_CLKC_P1_DIV                107
>> +#define CLKID_VPU_CLKC_P1            108
>> +#define CLKID_VPU_CLKC_SEL           109
>> +#define CLKID_VAPB_0_SEL             110
>> +#define CLKID_VAPB_0_DIV             111
>> +#define CLKID_VAPB_0                 112
>> +#define CLKID_VAPB_1_SEL             113
>> +#define CLKID_VAPB_1_DIV             114
>> +#define CLKID_VAPB_1                 115
>> +#define CLKID_VAPB                   116
>> +#define CLKID_GE2D                   117
>> +#define CLKID_VDIN_MEAS_SEL          118
>> +#define CLKID_VDIN_MEAS_DIV          119
>> +#define CLKID_VDIN_MEAS                      120
>> +#define CLKID_SD_EMMC_C_CLK_SEL              121
>> +#define CLKID_SD_EMMC_C_CLK_DIV              122
>> +#define CLKID_SD_EMMC_C                      123
>> +#define CLKID_SD_EMMC_A_CLK_SEL              124
>> +#define CLKID_SD_EMMC_A_CLK_DIV              125
>> +#define CLKID_SD_EMMC_A                      126
>> +#define CLKID_SD_EMMC_B_CLK_SEL              127
>> +#define CLKID_SD_EMMC_B_CLK_DIV              128
>> +#define CLKID_SD_EMMC_B                      129
>> +#define CLKID_SPICC0_SEL             130
>> +#define CLKID_SPICC0_DIV             131
>> +#define CLKID_SPICC0_EN                      132
>> +#define CLKID_PWM_A_SEL                      133
>> +#define CLKID_PWM_A_DIV                      134
>> +#define CLKID_PWM_A                  135
>> +#define CLKID_PWM_B_SEL                      136
>> +#define CLKID_PWM_B_DIV                      137
>> +#define CLKID_PWM_B                  138
>> +#define CLKID_PWM_C_SEL                      139
>> +#define CLKID_PWM_C_DIV                      140
>> +#define CLKID_PWM_C                  141
>> +#define CLKID_PWM_D_SEL                      142
>> +#define CLKID_PWM_D_DIV                      143
>> +#define CLKID_PWM_D                  144
>> +#define CLKID_PWM_E_SEL                      145
>> +#define CLKID_PWM_E_DIV                      146
>> +#define CLKID_PWM_E                  147
>> +#define CLKID_PWM_F_SEL                      148
>> +#define CLKID_PWM_F_DIV                      149
>> +#define CLKID_PWM_F                  150
>> +#define CLKID_PWM_G_SEL                      151
>> +#define CLKID_PWM_G_DIV                      152
>> +#define CLKID_PWM_G                  153
>> +#define CLKID_PWM_H_SEL                      154
>> +#define CLKID_PWM_H_DIV                      155
>> +#define CLKID_PWM_H                  156
>> +#define CLKID_PWM_I_SEL                      157
>> +#define CLKID_PWM_I_DIV                      158
>> +#define CLKID_PWM_I                  159
>> +#define CLKID_PWM_J_SEL                      160
>> +#define CLKID_PWM_J_DIV                      161
>> +#define CLKID_PWM_J                  162
>> +#define CLKID_SARADC_SEL             163
>> +#define CLKID_SARADC_DIV             164
>> +#define CLKID_SARADC                 165
>> +#define CLKID_GEN_SEL                        166
>> +#define CLKID_GEN_DIV                        167
>> +#define CLKID_GEN                    168
>> +#define CLKID_DDR                    169
>> +#define CLKID_DOS                    170
>> +#define CLKID_ETHPHY                 171
>> +#define CLKID_MALI                   172
>> +#define CLKID_AOCPU                  173
>> +#define CLKID_AUCPU                  174
>> +#define CLKID_CEC                    175
>> +#define CLKID_SDEMMC_A                       176
>> +#define CLKID_SDEMMC_B                       177
>> +#define CLKID_NAND                   178
>> +#define CLKID_SMARTCARD                      179
>> +#define CLKID_ACODEC                 180
>> +#define CLKID_SPIFC                  181
>> +#define CLKID_MSR                    182
>> +#define CLKID_IR_CTRL                        183
>> +#define CLKID_AUDIO                  184
>> +#define CLKID_ETH                    185
>> +#define CLKID_UART_A                 186
>> +#define CLKID_UART_B                 187
>> +#define CLKID_UART_C                 188
>> +#define CLKID_UART_D                 189
>> +#define CLKID_UART_E                 190
>> +#define CLKID_AIFIFO                 191
>> +#define CLKID_TS_DDR                 192
>> +#define CLKID_TS_PLL                 193
>> +#define CLKID_G2D                    194
>> +#define CLKID_SPICC0                 195
>> +#define CLKID_SPICC1                 196
>> +#define CLKID_USB                    197
>> +#define CLKID_I2C_M_A                        198
>> +#define CLKID_I2C_M_B                        199
>> +#define CLKID_I2C_M_C                        200
>> +#define CLKID_I2C_M_D                        201
>> +#define CLKID_I2C_M_E                        202
>> +#define CLKID_HDMITX_APB             203
>> +#define CLKID_I2C_S_A                        204
>> +#define CLKID_USB1_TO_DDR            205
>> +#define CLKID_HDCP22                 206
>> +#define CLKID_MMC_APB                        207
>> +#define CLKID_RSA                    208
>> +#define CLKID_CPU_DEBUG                      209
>> +#define CLKID_VPU_INTR                       210
>> +#define CLKID_DEMOD                  211
>> +#define CLKID_SAR_ADC                        212
>> +#define CLKID_GIC                    213
>> +#define CLKID_PWM_AB                 214
>> +#define CLKID_PWM_CD                 215
>> +#define CLKID_PWM_EF                 216
>> +#define CLKID_PWM_GH                 217
>> +#define CLKID_PWM_IJ                 218
>> +#define CLKID_HDCP22_ESMCLK_SEL              219
>> +#define CLKID_HDCP22_ESMCLK_DIV              220
>> +#define CLKID_HDCP22_ESMCLK          221
>> +#define CLKID_HDCP22_SKPCLK_SEL              222
>> +#define CLKID_HDCP22_SKPCLK_DIV              223
>> +#define CLKID_HDCP22_SKPCLK          224
>> +
>> +#endif /* _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H */
> 
