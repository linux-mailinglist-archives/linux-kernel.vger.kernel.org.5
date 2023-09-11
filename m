Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E33B79A13D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 04:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjIKCaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 22:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjIKCai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 22:30:38 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2134.outbound.protection.outlook.com [40.107.215.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065551B8;
        Sun, 10 Sep 2023 19:29:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1Qdz18EyGVz316sRGhS5hzjW6ygvfYyM3s3H66sdX2IB1sLEYBDuY0CYC1O51AO+jNaN4pSVlyPHD27+LB/VZ1TiKB072/3jKpJ5H/Ia67EizMISShsMSPPvnLYkMX8JY/IsYKAaPEoQV/wn4mykOaiMmGgfCYXA6AutP5QgA50YOTK5GeFRTE7KPlfGovOdVyC4UuAgVOv57ENED32B6meLUSuX/cPXXWa66KuZFUTe9ATU/4izvO+CAOGVghXPj+V+ZI/k0JeRYfv5/w9YMW3WLZ6Kuc6NraXS+dD9UloqCOi2BBKc73TIyGTQXacClMyCZnVqfjWXDTUi4SkbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OxEmTJVm2ocsRO5ZgHYbCDwSRQhUgsGYHPgkGabEfw=;
 b=I44+H+gCYlScfTFunJrRA6aMIDpZ2YJGRzIverr/fxiXZ4kb52jZM/i66DQAcChl8UnapF0XxwAirFPse6LQSp61DccpNveqAa4n1MymjS0CzNhjM2ClOFqbmnL3xSU8B96hwOPC816fJ96nnU+DB0uPyMlVemtU/60sdj/Jde/4lHllhjNBQNHVtyEY37pezS+hwQ4KLVEScURT0ci1EgQt6Msfu8zvyhTUbHxyAdp9M6Qehv6yrS8OBNc3cEUJroeUMUpOxVXGcxKEOVb+eQ8SVI1ZzPNU6qdXW9OXcHCyvN0NvY4mx50ACL+pxykQsG0H8t8S1voXjixrMq9tbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OxEmTJVm2ocsRO5ZgHYbCDwSRQhUgsGYHPgkGabEfw=;
 b=tde9ZcHxOOigPYj3EMN6L5WDO1nBOnNVnW0UCFDAGGMFOg3q2/30zWM2kVMs4ZSn3bhg9mvdOiSwERXaBMCIx7/YEvAiTn1VzfHS0xc3d3NHzE4xMLYh2oLcvMJtKCZdjVdmIB2IitcqzGe6rBy8TrOp/CCxUcfVJU+63Qf59a15TRu3oJmSpx5FSjYEpD5Cw1zHC0huEmx/4n6pWFgtQ02rdq9nl31XqBc7E/JvW9eKxD6rBUkDlf2zxLUlP5INftWslIBd9Ik9HQELvlHohch5fVQvAf7kj3BWLrKTGTYR0IrE6Oca1n7TkAxd2rcILt6dhLlooyJ3CiUnrWWxiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by KL1PR03MB7744.apcprd03.prod.outlook.com (2603:1096:820:ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Mon, 11 Sep
 2023 02:29:43 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::f065:6e23:803b:2a75]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::f065:6e23:803b:2a75%7]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 02:29:42 +0000
Message-ID: <831c9c56-a8ed-3739-00b6-326653be3d36@amlogic.com>
Date:   Mon, 11 Sep 2023 10:29:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V3 0/6] Power: T7: add power domain driver
Content-Language: en-US
To:     neil.armstrong@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>, linux-pm@vger.kernel.org
References: <20230829020404.4058677-1-xianwei.zhao@amlogic.com>
 <82001107-3e72-4cc7-b7d4-8ca1a840b508@linaro.org>
 <4303c141-30df-4a2b-aba7-f11a98db9941@linaro.org>
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <4303c141-30df-4a2b-aba7-f11a98db9941@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP301CA0025.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::12) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|KL1PR03MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f98647c-9c6a-49c2-0de3-08dbb26ef43b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PwK5vogpmctVV9s96N6T1CCKTP3FJduH/QQr666HznO3axMao0WVPtzSfoFiPHk63Qf1S6m6sIpqoy5xN1/aixoFLrFTFNHRXpzVjZS5lP23GEmQH2cNtjv2sJ61JChtAe9Gj4Hl69n47sC3cN1SzQwtZeJX/JsyR4j4zF5pUnalfxk91bNeoJLTDYmevsro/ty9EoICsgKHOSCQcbwBSEFYNdj63xVCMQ+A44b2FZbipw33Cm0v56g4YfHA8ewqgWa+9IW1Il24k43qi9AIgp+UeD52Lj4b3L+9JV5r1X671D3tu8zuG6jOjJVt+skxqQmaY4hbLTDGQxPUL0nh5hVoK3IjSwvvmDtyUxwGPzRA0OlWjUAgv+mf+fPUnh6wBX6gVsmngb9fprTnR56FHTam+Jb/UUWXXTBL6bym0+cmg8airTGXgF6sc+H1wfjB00yDvP+V0w/aRCzd7GhUcOvc29ZW6yEElGFvOUJ9AH0tv/qXZpMMZlZQFSOWdXzTDUTDpiqewE8UGm+UE8pqjnOAAD2W0pmtjzxM2v8ixRQaU0ocpuc9jTymhSbnfy2ram9yC+2lVOYyh04p+fH3wO5m9GGxdKDiM+SAxmaBkrQhcYwtZr403n7SslRce+JDi3qEBzeHEiqMpCI1V9uNMeoOxZq9AdvFVEO21EFaL9ckqosRumd/iXNzlOOF2t4HnNjfSlaX9fKh2lEcQfbU+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(39850400004)(346002)(1800799009)(186009)(451199024)(6506007)(6486002)(53546011)(6666004)(6512007)(478600001)(83380400001)(2616005)(2906002)(7416002)(26005)(44832011)(54906003)(66476007)(66556008)(66946007)(6916009)(316002)(5660300002)(4326008)(8676002)(8936002)(31696002)(86362001)(36756003)(38100700002)(31686004)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWdGbmx0eWhEVVNseXU1ZjVTUlg5Sm5QRzc2TlZoUkRKZjJyTUlZZDRpTW5N?=
 =?utf-8?B?MXdWQ0hHdEc3cWdGdEUzVE1HT1BBd2drZDNGYzJsanNGMENNYTdFblMwRzJC?=
 =?utf-8?B?TUxvc1ZxZ2NzNXBZRkVpLy9NN2Y4SDBaZXlHR2JOTWRpdUtOQ1BDVTZaSERL?=
 =?utf-8?B?c2tJSnEwb0szLzVGSDhlMXQ2c0lPaUdvd0h3WFE2eHJ4ckk0QjkwSlFOSjhK?=
 =?utf-8?B?OFNNYU9Ec1czeHVseUpxSzBSVUxycnFKcjQ5NGk4bHQ1ZUhSZTZRRHdYRklH?=
 =?utf-8?B?UWc5Rjc2QTRTWjd0aUxWNVliVkdFM3d0bm15RUpJbDNjUk9RZWFHdW5SdHo0?=
 =?utf-8?B?MlVzWURSWFAvc1lOSUZVT0wzSGxBUklSY1V2ODVnVDZjNTNobmVKVDhaNFlx?=
 =?utf-8?B?dmdhcUNRNnR4VXVudDc0anZjVlI1OXpkUUxnUWxEL3QwVldseER2ZG5nTTNh?=
 =?utf-8?B?MHh6UWZ2M0VRUkFoc2ozSVBLakVLRE1Xd3Q2YVdicDFkNGk5TGZaSjNVbGpy?=
 =?utf-8?B?aWJZQXlsNzlReG9ycm9waWo4NWtSVEtPTzVWekVBcDAva01kTVJGK3pYakR4?=
 =?utf-8?B?a1pyQlk4UWpxNitLSVJCQzNLcDVjUmU3bHpuK2VOdkxwZUpQM09BdlIvR0FD?=
 =?utf-8?B?bC9lTTcraEZCZjYyMGVUSU9LYWdSMGdNbmpVS3JyVnVLMVh2ZDRibkJsM1hG?=
 =?utf-8?B?N3pzaVRLNitITXZvT1lBdy9ZbzBYa3psNS9wWXBqYzh3N2NKZ0p6M1NwTysv?=
 =?utf-8?B?RFNoR3J1d01IVkRlR0o4dXZWWWFSUnRVNkViTW1lZldETGluVmNzcXpXZUcx?=
 =?utf-8?B?djR6MTUwS3VKY0FKZDNLbHpiNk1SVHdXc0R5YVd5YVFFVTNpc2lkelZ0UEZo?=
 =?utf-8?B?MjBqVVMxSE5kTUE1ZUlJVndrL1lydUJDUFprUnNoUjJKTVZ3OVM3OUtuN0Jk?=
 =?utf-8?B?U1pzWjN4dU5uZ1F0TlljRCtTcmFxWStlQ2VtcFNMY050U0c4TEM2Z2hYMDM4?=
 =?utf-8?B?Z3QrRDk3bUNENmwwNlJjb2RybklYM0tOaEZPakd2SUVJNVl2UFN5S0hnMzFC?=
 =?utf-8?B?OTlLUWIzNWl6NzlmVUhscGQ1Rmp6MnZJeDdMSkJQZC93Y01wWi9hN3cvYjhp?=
 =?utf-8?B?Si91R2JsSWNaeEZPU0FUVGY4K24xandqeWMvT0Vta1pVKzh5ZVdqOUpVNnE2?=
 =?utf-8?B?dFZtT2tUWHhWb2lQVXEvVVdzbVVocy90KzUycHY3RWh0bkxEZjB2blJhdzFE?=
 =?utf-8?B?STJ1K3czNXBxN1orbzVCcnlpdnkrQ3V0ZUhlaUtYKzZyZmMvSjJ2bW1QdzFn?=
 =?utf-8?B?a3UwNFpPY3RoSElxeHh1UnU4MFNoRlFMVy9LemtHcEgvN3VDVjh2QW9tWnRv?=
 =?utf-8?B?RE54a1BHUG9zbTBpR0VyVS83aForRFdtVVB4SWxsd2RrM1h1OElvTjBBNzFG?=
 =?utf-8?B?VXdIaHRKNFo5TFc3ZXN5QXBYYlRTZEFSVlR6RXNrRFEwcllIVWpJV0FqQ1p0?=
 =?utf-8?B?Ujkrdm1TZGNnOTR1UnZFOXlCU05hS3o5MHl5ZmNKYWp4SWVYNGl1THEzOTI3?=
 =?utf-8?B?Y0taUGpLWHQxWUpTR2ZuVlY1OVI1dEVSS29oblVrZGxnZVF5NmNXTEd3QUZx?=
 =?utf-8?B?RlEyZldseDB2WVFvSHJ0QWhLVnM4d0hreWJUNHlBbjF0U2JBcmhkMFF3SE5K?=
 =?utf-8?B?K1hZcVRjZnNDWXpKZ1VidjM4QXlraFJMS2Y1U2VveHU0SEZydnFsZHNiU3Bv?=
 =?utf-8?B?c0xHR3lCcjBGMm5aZ0tNQk96WmRpTVZUbHdoeGJ1emdRc2dNZHhLbGVFQ3FT?=
 =?utf-8?B?b1o4ZTlRYWloMjVuMXlRa1lqamlYOHdLVHNtNFB5SmhzL3AySFkzbVdadC9Q?=
 =?utf-8?B?SVNoRHVQL1A5dnJsTHlOakJHcUZWUHl1T0ltQ2NIVWVJZVRibHJXL01Vc1Fy?=
 =?utf-8?B?bkpTUmd1L2pCRjYyd2MzdDRUckNVTThpNjlIZ0FpWllFd3dTcDJzdGVTclUx?=
 =?utf-8?B?Y1B0eHhRMnZYcCtNRUZIZ3QyS0l4MFp5NzZGY2pNbDJYaVI5bTBnbWkzY09p?=
 =?utf-8?B?SXYvbzd2dWNmOFlOKzViSCtJM2UzMktwY3FSdEZtSGQxNEFheWdOTDlxMFQx?=
 =?utf-8?B?WW9QSzJXbm9MRlJEaHkyc1c2MGhNM0F5R2JUM29SK0NCUS90WWZyWjIycEZz?=
 =?utf-8?B?Z3c9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f98647c-9c6a-49c2-0de3-08dbb26ef43b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 02:29:42.0796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bOGWKIUhoPNM8/eMhTJKXWns5z2CHIjEqaA//ZjEBQXismEnnEfyGl6bCiry7a/YMnHVhg/qmRkx5cPowgJwvzuIJgH6dAsjA60Sqte5dM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7744
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,
    Thanks.

On 2023/9/8 20:45, Neil Armstrong wrote:
> [ EXTERNAL EMAIL ]
> 
> On 08/09/2023 14:40, Neil Armstrong wrote:
>> Hi,
>>
>> On 29/08/2023 04:03, Xianwei Zhao wrote:
>>> First patch is that remove C3 some power domain ALWAYS_ON property.
>>> Second patch is that add driver to support power parent node.
>>> Third patch is that turn on power if initial power domain with
>>> "AWAY_ON" property state is off.
>>>
>>> Other patchs adds power controller driver support for Amlogic T7 SoC.
>>
>> Please re-send to Ulf Hansson <ulf.hansson@linaro.org> and
>> linux-pm@vger.kernel.org since this driver has moved to the
>> GENERIC PM DOMAIN PROVIDERS subsystem.
>>
>> I'll take the DT patch since bindings patch was reviewed.
> 
> In fact I'll need Ulf to provide me an immutable branch or tag with
> the bindings in order for me to apply the DT patch.
> 
Will res-send.
> Neil
> 
>>
>> Thanks,
>> Neil
>>
>>>
>>> Changes Since v2:
>>>   -Modify subject.
>>>   -Define PWRC_NO_PARENT UINT_MAX
>>>   -Remove modification that transform is_off into 1 or 0 using !!
>>>
>>> Changes Since v1:
>>>   -Fix license from "GPL-2.0-only OR .*" to "GPL-2.0-only OR MIT".
>>>   -Modify T7_NIC flag  "ALWAYS_ON"
>>>
>>> xianwei.zhao (6):
>>>    genpd: amlogic: modify some power domains property
>>>    genpd: amlogic: add driver to support power parent node
>>>    genpd: amlogic: init power domain state
>>>    dt-bindings: power: add Amlogic T7 power domains
>>>    genpd: amlogic: Add support for T7 power domains controller
>>>    arm64: dts: amlogic: t7: add power domain controller node
>>>
>>>   .../power/amlogic,meson-sec-pwrc.yaml         |   3 +-
>>>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   |   6 +
>>>   drivers/genpd/amlogic/meson-secure-pwrc.c     | 127 ++++++++++++++++--
>>>   include/dt-bindings/power/amlogic,t7-pwrc.h   |  63 +++++++++
>>>   4 files changed, 185 insertions(+), 14 deletions(-)
>>>   create mode 100644 include/dt-bindings/power/amlogic,t7-pwrc.h
>>>
>>>
>>> base-commit: 413f5c02929bb33042bbc4ee233166550a5fca70
>>
> 
