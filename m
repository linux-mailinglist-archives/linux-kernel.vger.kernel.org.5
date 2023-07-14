Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4A1753533
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbjGNIne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbjGNInc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:43:32 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2092.outbound.protection.outlook.com [40.107.255.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27202691;
        Fri, 14 Jul 2023 01:43:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUVFCAKlbpMYR6WQJeN5eVRu4+KNA/JuGEPmU0g5SAqCELFcYJoDoZgiJ6gLH9y/k5UG1Yq/u5KrGUvgGUznp9uRCoPrR6qg40z8hxEEjFvVfVHloNJAagKiZPQTU5SQ2LvJrXaRCW6e8ukF16eL+SDQysnbToPWqIvgOuXJDJTx9vDH/ApK+5ShYtsJTqVeTUZlu1FYl9f6rEEU5rnoxhjsvnfrX9M/PTLd65rkftkcsnRw5UMR5YDlZKCiZLbA3xfffsEsYP0BUC252WJp7wKAFPjNjIvkVKTZgh74MBpNgtwF8sQecK/w5kz8nf/5TEA4/CLy6aF6s8QOYMm+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f00uiSRa8TjRDhUS1k6R5xmAv/SmE+HOJlZq4rXSOnA=;
 b=AzfrQhpAMNnEK+8K+zzPlQ6w2c05WkvXnzQHGTx1+L8aoKc41EDqR1yoDjdXcIAeAHSHAYA1aF/D3a+Ty2l3zYyT96aixbgZuNnhthsXX+9IdOw+GMjuWdDGPd01wUFzIHKwXuXrsoAjZ21rfcifNoNIyJVEZIAYPnSMQbWZ46TRArPHZVifTtK0TM5TeM+u1eQtuoD2u/NDxxIBY7dTDT81j5pdGPCyr/nfHiLTvcXNLoyQ+byqStEpWPGsWjiJhM069znvMX3u3ud5SdBx/oCrUGzuammY0FqzpxDGPsJ1Ar6rG4ZU4kSAAjKUDMzQdLo0sZoNzkmp2ht41C1nkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f00uiSRa8TjRDhUS1k6R5xmAv/SmE+HOJlZq4rXSOnA=;
 b=mR5L4Y3/6i5NH6pXFvkwzEi8dx0Zvt5RtC8MEBdXGye5n9LrXR0ac5CyG0YjFXKLoQpeVbXmU0eC3lahkgD7MYgM4PIjZMf6qOUunm7M2Z73P8Xov+T4uPFWR8vyg5EeZgUOIcjbacTyYG1FKhMfUX8Bm5UF1VFMWUEf/WcX9oa4BbDAoDXEE9JSixiTLgOFI1vwLqk7UzlKcP7uO1xh5qMhOnA1k12TXT1AU9NXuViA0xi26U5iVuI7iWowCkIkA99rr1rNUZtUv0kDzxw1/A2s8ie2bQfsWIK3a7sh/bBAU/d0geekx/dpDo4mycx8UGjM7u6EgKOJpvFhwiMVCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7384.apcprd03.prod.outlook.com (2603:1096:990:11::8)
 by JH0PR03MB7836.apcprd03.prod.outlook.com (2603:1096:990:2c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Fri, 14 Jul
 2023 08:43:27 +0000
Received: from JH0PR03MB7384.apcprd03.prod.outlook.com
 ([fe80::789a:c612:4676:9034]) by JH0PR03MB7384.apcprd03.prod.outlook.com
 ([fe80::789a:c612:4676:9034%7]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 08:43:27 +0000
Message-ID: <b4dc1cc6-a0b1-1da2-6e22-edc44340c012@amlogic.com>
Date:   Fri, 14 Jul 2023 16:43:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2 1/2] dt-bindings: gpio: Add a header file for Amlogic
 C3 SoCs
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Huqiang Qin <huqiang.qin@amlogic.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        brgl@bgdev.pl, andy@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230710042812.2007928-1-huqiang.qin@amlogic.com>
 <20230710042812.2007928-2-huqiang.qin@amlogic.com>
 <20230710-maybe-mantis-e647d94fd13a@spud>
 <424cb61a-9102-9a43-c999-36939e8d6cc0@amlogic.com>
 <20230711-monthly-return-8792ce346c26@spud>
 <33bcb7c0-0bf9-e3fc-ec55-476c0cbd6105@linaro.org>
Content-Language: en-US
From:   Kelvin Zhang <kelvin.zhang@amlogic.com>
In-Reply-To: <33bcb7c0-0bf9-e3fc-ec55-476c0cbd6105@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To JH0PR03MB7384.apcprd03.prod.outlook.com
 (2603:1096:990:11::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7384:EE_|JH0PR03MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d2421d-d4ed-4377-e3d9-08db844663d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hgyJwrPd7urFxaxeStsrmCYQ3QBW5VbuX3ZTlvPCZ3GckiPAWljy8qgX4k6pcavfhNG+OWlHQGnLonzzJEdtnnYxu1nfriOt/0rlSeZ2lcv6Jy86+aWawfwRGcqM0bDEjLTGR/27bUJumyREm9IeH7zEdpjY8Y3maTc6bLII4+xWJ74p2YrBsHnE4Gc5FLhDs8MstQ2WfxTPa7yIJHVK08fnskzpAMhDdxrms2BYE6/GRnTnnr1JUSA/7YHBH5wuNeqhMffLonZHDpPECooz7H2zZU2UIzCPR2jPeZuSgECM6rqaAzALta0VMF/G4ZgQGfoAGDN41P2fk5bFmgXwwj3l4VFp9RKQ1Q1fhAf+XsFuTwrvFVXD4Bfc48md44vvwYt8V71Gk/dpQ0rx9wBAzCdPMuYjxQH902Y1GG4bdKxHfQuLAEEd43LZ1VhxDxJya9tK77m9k1as92/huZcUDr0LfI7nqyNoNN7UaUg6CaDqZrS8GedRLcLZhy3H9lTKlHMRUHGH5LLlEA6YW31yhkon+BtzwwxIvADRWty4VoD1BFADL4f6cEtv2/DS6zvZMfveK+o+ib5y6/dnrQ+GEJ2OhvSRYseIOhXWFLBEnr3oFt8KOhu0drc8ooY3O/dF3XFhFgqV1F+msAHZA9G02DX0CUkdF3B1JCI9zFqztSGXiiZdEqfRBKVkqidFX8kj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7384.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(6029001)(4636009)(366004)(39850400004)(346002)(136003)(396003)(376002)(451199021)(316002)(6512007)(966005)(6666004)(6486002)(44832011)(110136005)(66476007)(4326008)(38100700002)(6636002)(66556008)(2906002)(36756003)(66946007)(83380400001)(478600001)(5660300002)(8676002)(8936002)(31686004)(186003)(2616005)(53546011)(6506007)(7416002)(31696002)(41300700001)(86362001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sy9jWEcyRy9QUFk1QnFDejcyMFpkTmY2M0ZlbFpMSFdrTTFNdnZqUkJzRWJJ?=
 =?utf-8?B?NjA0d21HWThSZ3RWczdLaEc2eUhUYS8vSWJWdmViVURNMTJlcWRZZ2l4eHdn?=
 =?utf-8?B?azB6UmtOUXhZMlR5TDZzUnVlcThXbGdtb0lLUit1VGNJTXdIaW52aGprT1Jt?=
 =?utf-8?B?SW8yMzVvWlZBWW0wMlRHYjJRTzV6WWtCcEl0VE9LY3BDeHJmTGV6cWMzZlpE?=
 =?utf-8?B?UGVwMkhxWSswWUZxM3BYV2o3SWFSb1daVEswYS9FZFJGb2tWQmRZUjRqVTJB?=
 =?utf-8?B?YjJ1eWtuMlNXUnBIaHduckhVKzE4YnlCRGZjSTZzUkROU3BTVTU4ZVlYbHFV?=
 =?utf-8?B?N2cwa3J4aHgzeSsyc0cxMTFGcVBmb3NTSUlXRlpMVnQ5SGxwVTNIeUlpWTk0?=
 =?utf-8?B?cDJ0aGtPZFFkQ2hPb2l1WnZwZHduRll0QkRFWUVvOC91Q2wvRXRKYy9zVjk3?=
 =?utf-8?B?cCtFMWJDdDJCaGN5eVNhOEJmanZZeFZ2SU5sMG9EekN0RTlybnNiY2V2WnBI?=
 =?utf-8?B?cEVPOUM4dzVmZjQ3S05NaFhuNi9aK1BxMm9xc2ZkakZvc1N0VEtZc0g2VlMx?=
 =?utf-8?B?djdzWHVhc2U4K1BzZ1djRkdVVjB2aVBHbktMYUVtSWpWWXlkSVJUSDI2M2ls?=
 =?utf-8?B?ZFdHbWxFWVJHQnZuTDUrRis4UTRCMTRDSFExU2dURjQ1VnhmRE05SVBOeEZx?=
 =?utf-8?B?RVVualM0b3J6bHBQaUw5dnBuOFdGSnBGejczRTN3Rnh6K3hkZktEOVlzaHc3?=
 =?utf-8?B?Wi9FaUJ4UVlyTzhpKzdpdTRwVVNmemxVQnMrdnA3QlYwWlB3SXl6MXZHMTJJ?=
 =?utf-8?B?QWxDWGZIMkVNaEJJRERQN0VmSEZPNjRKVnJFMFJKdmg4WEl6VnRlMEZKR3pn?=
 =?utf-8?B?S1dBSTdBMXBlOGJ4dGRKaTY3MkwwaktraHJaNlJCaXprekdqT2c1a1NIUE1B?=
 =?utf-8?B?VGlPVlBNamJLWGVkQk96bGxwT1FHdTNMN0E2dUlYTUhQVno0QkRHMVpsSk4w?=
 =?utf-8?B?TW1XUDgwd2N0dUc0VFlWQ1pybi80RkQrMnNrbGdITDhTMkZnRmlkV0Zkc2tV?=
 =?utf-8?B?ZVVzaDhBRWE2RjMxWWFvWkxLcGFFc05abThiV3FsQnhoZHZWemRTa05BZTk2?=
 =?utf-8?B?Zmw4K2hoNDZrU1ZDdVpkWUQzam1IbDJiRDJhYTB2YkpGTzRuZVVpYkM0NnlP?=
 =?utf-8?B?SUprUnVWMUxMTVBMOUlrM1pULy9WWUtLZzhzUWtwRUpYUlpMcnlYQk1mWktR?=
 =?utf-8?B?cWtrVzdOWmFZM0pBWFZyQ3JYZXVYSzNvY01vZ0s2dU9XQWE5bjBCK3EwekNY?=
 =?utf-8?B?UmNselVXVWZrNE9GS3VFaXAzcm1DMk1aRmwxeDZjdFhMWmhuNitpaEVCNHBq?=
 =?utf-8?B?MUxod01qZkNCdmhaSGtiV3R2Nm5DQnhObFViNU9VcjJDWXN6MEk5dlIxdmsz?=
 =?utf-8?B?cUloaUx3WDBKOUdtMC9SUkhHSm5uKytYSnJaZXppa0JxWFVyUzduZEhhY2h1?=
 =?utf-8?B?WHY5L0pQNHFwWlZ0bGllSU93eVpDdmZzbVM5blp6Q3JaUzRDQ0JvLzk4M3Mr?=
 =?utf-8?B?dXdWbDdYb1htdzFXMUNFbzhWaVN6UGpsMCtaRUZ2cSs5YkdXTmVkMDNXQUNr?=
 =?utf-8?B?cmo4NEM5ek8vZW1tYXFJOHNidGhpcG1GaFVwK3dnL000UlA0SUtxSzFwL2VK?=
 =?utf-8?B?WFlpNk4xSUw3czBzeU9DWExmOTNEZmZiWHV1SkxTbkI3Z1loMlAxdWp5M1ph?=
 =?utf-8?B?d2doK3RFcUNqMHF3bGs3ZXQ3aVMyeFRGaHIzalE5alhjc2JaZHVKMFExa1k1?=
 =?utf-8?B?ZnRyN0ZENUw5Q0pDaVdxalhab2x0QkNYc2dyejZ5SXh1K1d0eTU1OXl3S1N5?=
 =?utf-8?B?TnlUY09Ib254T3RJcGVjM0JIN2t4cyt3NzBWclhXOXZaM0ZqaW1UcFFSVFVp?=
 =?utf-8?B?UU5ERmxaUVFFSS9BOTlGLzRieDBzT0RSV21QejdKMEJHRDJJUTAxMElpanFW?=
 =?utf-8?B?WCtHWU1NdVI2eVJ2RUJSRlRMU1A3V1IzOHlTQVRPdkVoWHl4UkorRys0Z1Z5?=
 =?utf-8?B?UDB0K1lHM3cwRW5jNE5OT2lBbGEvalVRNFppRWcrUUJoREc0Smh1SGFZM3A3?=
 =?utf-8?B?UHZQMS9TWEtiNy9GUWljRUw5RVI2L0Z6dkFlL2JOUFRMeTJiRmhSQmpWNzJx?=
 =?utf-8?B?MEE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d2421d-d4ed-4377-e3d9-08db844663d0
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7384.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 08:43:26.7051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLxkLvB17AZaw/nayrR1ML03WBqlD3liPv7+9L7haBKxoq7427sduR5oauKVOPCPmyFCMI2/WkwOxWyDf8sjmBPk3Z3CciXQS85S4JS1wM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7836
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/12 13:56, Krzysztof Kozlowski wrote:
> 
> On 11/07/2023 20:05, Conor Dooley wrote:
>>>>> +++ b/include/dt-bindings/gpio/amlogic-c3-gpio.h
>>>>> @@ -0,0 +1,72 @@
>>>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
>>>> Any reason to deviate from the usual license terms for bindings, which is
>>>> "GPL-2.0-only OR BSD-2-Clause"?
>>>
>>> I initially used the license commonly used by Amlogic (reference: meson-s4-gpio.h):
>>> ```
>>> /* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>>> ```
>>>
>>> But when I checked the patch, some warnings appeared:
>>> ```
>>> WARNING: DT binding headers should be licensed (GPL-2.0-only OR .*)
>>> #37: FILE: include/dt-bindings/gpio/amlogic-c3-gpio.h:1:
>>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>>> ```
>>> So I followed the prompts and changed the license.
>>>
>>> Can I ignore this warning and use the (GPL-2.0+ OR MIT) license?
>>
>> If the tools are happy then I suppose you are okay.. I'll leave that to
>> Rob or Krzysztof, but if you have a reason for diverging that seems fine
>> to me.
> 
> It is very weird that company wants GPLv3 and even weirder that it
> agrees for GPLv4 and GPLv5 (GPLv5 might force Amlogic to do some
> interesting things...). I am pretty sure company lawyers don't want it
> and just do not understand licenses or someone forgot to actually check
> it. Anyway, it's fine for Linux kernel, if you really need it.
> 

That's true.
We will follow the checkpatch suggestion.
Thanks!

> However the argument was "meson-s4-gpio.h" has it, which is not really
> correct argument or accurate. Is it derivative work that you need the
> same license? If not, why presence of something causes you to do the
> same without thinking?
> 
> If Amlogic requires GPLv3 or GPL4 or GPLv2000, please confirm it here
> with your official email. Otherwise, if it is not a derivative work
> confirm that. Otherwise just go with what checkpatch asks you.
> 
> Best regards,
> Krzysztof
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
