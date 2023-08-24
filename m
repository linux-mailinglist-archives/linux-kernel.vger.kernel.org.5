Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A58D786AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbjHXIsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240607AbjHXIsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:48:09 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2100.outbound.protection.outlook.com [40.107.215.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630DB199F;
        Thu, 24 Aug 2023 01:46:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaPN800neYuE1Na6xKL/YNN5KgZ5cWUlbQy683TlixbSAG5wJWjvyXz56EOQAsJsUnrNoP3k3igTrt+ORtxv+82m2h48mbsvSQG7oHJfXcbHkO8zsYLJJvfYe3138MxohR8Hb+qrrBr91Kwubh7SVDpDWj5aBwxbUwYPPtUhoUwfSiiTIvhKlUL0Bnxw72CRxnOTT+l/PnLLSTVLFNGi0XSbMtNcK58+rQ4bdNcg1XY9AfJlIt0JfJO1dqFEGmxx1yZ73aKaaon/bn0XU7s2h9HDHA+vVckNFkYzyBy63O3AYZkVZbp6zfp8W+rxjcp5vdB8kPJ5fdxAsAuHfMMVlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBW7YUDrFW5AEPUE8vlSwBsrSF5LzqyLyO+gpJqFzZA=;
 b=E7CNa0bQsARiYbAUOtnbotDbG5ApeeyMMigi0jPRQn9aNA5Ol7h+RCOsTy+yUWJf+IheZYd8jg9YsEECQN8eG5J3/PceqFsuV7cPPNtgvsPk7e6PKec2+CD2OxQr/aDT65ViOTSap/wzPQ9I0wx++w+nSiB/damORiCqzWioB4xxWwmuhOIIVAJO6UttyLK5QW+VNGfsqvnEbUKekxQCd2SQ+i66N8ZKw3Ma6z0ebux/7ciML8gqLZQzq9a3nDyj4vHDIh5jdFoiJI7oBTiPTuFbtvYpejgmxt6WNcY5yCyvgTOk9zpIIHY/GnGVdzvRIdG0ojxmet1SVurtNn6/WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBW7YUDrFW5AEPUE8vlSwBsrSF5LzqyLyO+gpJqFzZA=;
 b=Wg+8Qvk+qWRAUDR+6JlRLSgGViorjPf9upeZKpAC7CcL8/h/1vGfApo6OenXqAOScu2aSIoD845+TkW7cfQq8QfKsuT10ZEmzrTdsqQUTH3uRQN8/FxHRtJ54hAEjW6jdhSxUs4xavSB9kdeGgA3cH0pByoeQUiiaoUwUN7l/bla+sso6JJ1+EKM4C/f1CRIjIwZ5Tor20Pt9IsGbR564cKSOjiLVWUPLTR8gfCscSXWjF4qqCJHzEblpTcE6Ia1xr94LlChy/qBFMiJ/h9XL7x1Qi91KZPmvHgJxMaRXpZbn9up6XB4k9nlSkJVjO7LxOcGOxMylsknpuMv7VsdMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEYPR03MB8203.apcprd03.prod.outlook.com (2603:1096:101:1a2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 08:46:15 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::f065:6e23:803b:2a75]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::f065:6e23:803b:2a75%7]) with mapi id 15.20.6699.025; Thu, 24 Aug 2023
 08:46:15 +0000
Message-ID: <423f82b6-d6b8-ee2e-1b31-fe5f1552553e@amlogic.com>
Date:   Thu, 24 Aug 2023 16:46:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2 3/6] soc: amlogic: init power domain state
Content-Language: en-US
To:     neil.armstrong@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
References: <20230824055930.2576849-1-xianwei.zhao@amlogic.com>
 <20230824055930.2576849-4-xianwei.zhao@amlogic.com>
 <91e4a3f1-84ed-4433-90fc-bdfb9b08e57a@linaro.org>
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <91e4a3f1-84ed-4433-90fc-bdfb9b08e57a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::11) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEYPR03MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e535ddd-0cab-4028-7079-08dba47e9390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uvhdhvg9AGtj9O7JLNR9YhGzJugCo23GReqnbQe902l/HxoUCzAzVP97eMw1d/S9H0GXobxkKQ3Cp4ZJl+Rhva+L6Z0/WUpDsJMgVOFEXRWxkc01WWUrUhSb5A4dyKv9eQXVnYaQJsdMDGy/17yQPazaq02EIRLLppLmV+o+W2qHPLGL43sYyowtSWOSXDlfBPYm3iL06OoOzT2+JNB+anU1wdkuZQtCW0Jhq4r6KsZhCQnRnOjnObrwipGitA0crsR8b8UGuXjz3hfUW1q6fVElI2DfFwiNg/ktdz3jZuY4h/PLwnXEiVnUXyEGq4WIYngEtSRglQqDwYqUhyDcK0Yb0+7J/1VQXbRmtsIWiyZICBPqKVNyT/Z6x2ow9QbRxJTXjjIgVo2yD6trprODgSwlmMYOjazKIp+8SE/ZsHDbAta/cYMovHGEliF4k2clqkrEr4DvzvRNvARXkkudcTXDGkM0YxCQ4Ak4AyFUm1lKJ+YAj6uy4UFulO3ozLX+x+qnfgI9bYEQPYivl+S49XE4pmWJ4UGxEHjeL7iBPw7lctqtB7+MC5xj5MagKjCTl+KHUhJ0EACHcTdcpPnadGr2hU+fPRLo63JZ43ucF2ZzI4x1g0axFJTYYBznIRiz1s5aKsmgPbsudonkVS/N2vz7RhmrYz7JPzY5wxIoy+QcY7+c7EypZR9ywrXBDZlBBiSONrqYcF0wm5KVKXExNAe2SM6Tfo6sQy0DRVYIgANNv/yfQEKZ+EbqDZQCPxY/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(396003)(39850400004)(451199024)(186009)(1800799009)(54906003)(66476007)(66556008)(66946007)(316002)(478600001)(26005)(44832011)(38100700002)(6666004)(86362001)(53546011)(6486002)(31696002)(41300700001)(6506007)(6512007)(12101799020)(31686004)(4326008)(8936002)(8676002)(2616005)(5660300002)(2906002)(83380400001)(36756003)(45980500001)(43740500002)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3JrNjNZdHRHSjh1Y2JkdzcwWHo4MktBZXhQVFFvck1laWFQdUZZU3d3M2s4?=
 =?utf-8?B?L0tzeTNCN2xsaDIyWXFiS3J1a3ZmTnpVeEtWSXJIVVBmQ0RQc2hLMFZYSGdD?=
 =?utf-8?B?UTFqZDVXOEp0Z0Rjc0FRTTEwc2o5ODVubmg5WmgydlBZc1lEMGhDZGFxbVZq?=
 =?utf-8?B?L2FXN0xxbm85UUV4OWw4akVkRFR1M1hyVEVDQUFXcVdRWGduWkE5YUZwdjFv?=
 =?utf-8?B?QnlacWFjSHYvbUV3eFlKQlN1UUVQTzBNcUVVaVpSTWFjV2kvMWZNa0xsaDVs?=
 =?utf-8?B?YWdCaDAyNHVvZVR3ZTdteGVCNlBDSnRIT3E1ZmMxRHJxb0U5bEtDQjlDaHM0?=
 =?utf-8?B?cmx2L0R0WXR4bnhPaUlVSnJMeS9oN29Ha1ZCcWxFVUJML3MrQ0plaFRMY0M3?=
 =?utf-8?B?SWRFbkZENm5DT09tZXU4WUFRUHJZZklIQjU2RWpkTnIrenZYNFZqMWM1aEdW?=
 =?utf-8?B?NHlsZ0lPSEY4b3N4YVBieXpFcHI4SWhaVFJ5Z3A4UzhHb2NHMWZLSW44WWpj?=
 =?utf-8?B?NVN3dFJxK3lib2R3VG5tSWM3MUluQzNOZnI3cFpyS0hndlE1cjRsMjhxeU5J?=
 =?utf-8?B?YWpmaGtDaTVLL01Ca3daSmNTQTJkb3lSQ2ZRU21vT3dxYlBvQURBVmlYN0px?=
 =?utf-8?B?cTJvamxvTlQ5M1RSUDl2bExSUkV3K25WdUhWRlA4MXF2SEw0ZHpaQUhwaEgr?=
 =?utf-8?B?WXk1V0VUZUdrS2tWRVc0aTgyMU9tWE1qNFFSUUJWeEk1cWtDWjlSSFJHK1Nk?=
 =?utf-8?B?Zkk5V0FTTVdSRGVRWjlyVVR4aTVKZFQ2bFNqblArNGlxd21zQk00NTU2Njcr?=
 =?utf-8?B?bncwb21IQkh2SHh5V0RVOGNhTGx5U3Y5aWc2QVM1NUR0RUw1cWM0REMzYWRL?=
 =?utf-8?B?TzlkaDcxVGEzdEJvQmhwL2liblZDVnhjQjZWdWN5Qm5BME8zSG1zL0hHR1Fk?=
 =?utf-8?B?WkNwOVRaWlR5aEJnVlIvWHJEWjd5QnYybTl2KzdoWnRkZXRKSmdYTEVZWXNE?=
 =?utf-8?B?SGlTelJPUjBhaTZaOG5JaC8vNy9VazdhczJrSThUeU02OHpDV1c1V0pSWXUz?=
 =?utf-8?B?VG1FWm5iaG5VQkErRFRVUXJZTUJCYTU3ZkRISVR5NUR3R2ZOYi9wYlZNREFq?=
 =?utf-8?B?YXhCemhaS3RYK1VBTU5mdVhMcWtVbW5UaUliQ2pPYTRCS2hGdDErdndneVVy?=
 =?utf-8?B?dnJnQ0I3U0wrUFhDRVB4OHhZdVowaXltQ2k1NEYzU2VhU2kwYngxV2F0Q2Zs?=
 =?utf-8?B?VnN6enJsNmVhbkVGOFAvdUl5MUYvWkREaW1oOEJ0SDBEMzNTK3BXYmwxZmNp?=
 =?utf-8?B?bitGRTRDS2F2cjcrOEo4MGllMUtCL2ZpMHgyOGMyZ24xaCtjZGNhNEhZcFBS?=
 =?utf-8?B?NjNZbWJLREE4RmJKZDNDQXB1cHRPQVJEcFdJSi9zUlR1N0JVTnoweHFuVWlj?=
 =?utf-8?B?d1hyZFcyMkgyTFVXaitZUEluN1llQVgrZ0JlR0cxemllTHZaZlFPV1pLL0RF?=
 =?utf-8?B?WnowNVRnZlhvcFA5QllObjMzVG5HM1RIeFFPRkRPdU52RHdBdkdxNDlqNEpC?=
 =?utf-8?B?TldZKzJ2TXRRaFkyYllFcHZlRkRyY0JzRFFKMTNZcmM5T0hHVUlMNXN6b2tq?=
 =?utf-8?B?UTgrUDR5UEVhNDBFUWJ4TDJBenBtV1VHNUNzY3FPT2FnQlBNZVZBU3U2Z0RO?=
 =?utf-8?B?dzFkZlNzSkNod1hIS3JremI5WExDZ0pqc0k3Z1QwUWVpTzBYVmxaQ1hZS0Qz?=
 =?utf-8?B?bFhIZzZYU1hIQVVUZm54Z1o1V1pnQU5lT2t3Vkw0ZzlqbU5KT0Q4T2NDd1Br?=
 =?utf-8?B?U0s0dzVvOU9NMHpIMkg0SjdqMVRsVFFNejg4TzcyckhSQm1EaEYzWlU1YzF0?=
 =?utf-8?B?SFNDVWV3T1E3azEwVWZKNHdaYlpjR2E2SG92U3RmVHVUQmZLcnNpRk1TazZD?=
 =?utf-8?B?bHk5eDkyaEFWeWd1SnBTYmFJWWExWjI2T1FHaisvSmlCNEJ3dk5VWDV4VzVS?=
 =?utf-8?B?emFiMmY2Ri9pR2sreEdENFNHenVSNEtSOEoyb1lpVVdsZnZkVEoyN0pkTDBG?=
 =?utf-8?B?ODBESzYrWG1qQXo1NVNqVC9qTWIvUTArYnJPSkhtM0J1SkxtNGUzZ3Z0RzdL?=
 =?utf-8?B?dGs3K3IvRzBGUUxJdWVhUEVldHZNOWpiOHh2R1l2QzVsYVhhNXNuK0JHS1Q3?=
 =?utf-8?B?T3c9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e535ddd-0cab-4028-7079-08dba47e9390
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 08:46:15.2650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sa3Wap/jp6Zk2bb1JYXoSV81YzfmbMRWnOaaIl1UzjCEw03Dg1cii2Lh+fyyEQCLHFEDl148HVhqBFG7q9ThLZ2VaPg7iDCWwbMcbnEqnyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8203
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,
    Thanks for your reply.

On 2023/8/24 16:30, Neil Armstrong wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi,
> 
> On 24/08/2023 07:59, Xianwei Zhao wrote:
>> From: "xianwei.zhao" <xianwei.zhao@amlogic.com>
>>
>> If initial power domain with 'AWAY_ON' property state is off,
>> turn on the power.
>>
>> Signed-off-by: xianwei.zhao <xianwei.zhao@amlogic.com>
>> ---
>> V1 -> V2: None
>> ---
>>   drivers/genpd/amlogic/meson-secure-pwrc.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/genpd/amlogic/meson-secure-pwrc.c 
>> b/drivers/genpd/amlogic/meson-secure-pwrc.c
>> index 76527f4946b4..3e7e3bd25d1f 100644
>> --- a/drivers/genpd/amlogic/meson-secure-pwrc.c
>> +++ b/drivers/genpd/amlogic/meson-secure-pwrc.c
>> @@ -55,7 +55,7 @@ static bool pwrc_secure_is_off(struct 
>> meson_secure_pwrc_domain *pwrc_domain)
>>                         pwrc_domain->index, 0, 0, 0, 0) < 0)
>>               pr_err("failed to get power domain status\n");
>>
>> -     return is_off;
>> +     return !!is_off;
> 
> Can you explain this ? the function returns bool, so if if_off is > 0, 
> it would return true,
> so I don't see why you would need to transform is_off into 1 or 0 using !!.
> 
I will remove this modify, in next version.
>>   }
>>
>>   static int meson_secure_pwrc_off(struct generic_pm_domain *domain)
>> @@ -222,6 +222,9 @@ static int meson_secure_pwrc_probe(struct 
>> platform_device *pdev)
>>               dom->base.power_on = meson_secure_pwrc_on;
>>               dom->base.power_off = meson_secure_pwrc_off;
>>
>> +             if (match->domains[i].is_off(dom) && (dom->base.flags & 
>> GENPD_FLAG_ALWAYS_ON))
>> +                     meson_secure_pwrc_on(&dom->base);
>> +
>>               pm_genpd_init(&dom->base, NULL, 
>> match->domains[i].is_off(dom));
>>
>>               pwrc->xlate.domains[i] = &dom->base;
> 
