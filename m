Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5AD786A65
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240549AbjHXInj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240629AbjHXInT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:43:19 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2137.outbound.protection.outlook.com [40.107.215.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F4119BA;
        Thu, 24 Aug 2023 01:43:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5rXi8todLtCwYghQ8KxskKCi5V303+0TSPIkfa1N2J6TehD8aZ6VY8LhuNmRchXSV4UwJhR1CNNHT19tIBGvLDbZr8Pky1tx848iGbHllSKiaHKuVwnzv+UAWIXYXswbbgy1N1IuP/Yl7pX8JPNbb5wU1VpF9Afo3fAbzoV4Zeyq3SjF9/dbi9lSwR/79KNDEI88+ctUbEDW9Gvlb+mHQ9M/xDxZZy2VpVENBbbiCVA2Z7CyBM3oni4ksHLNQtcQ30eZbamoFfUedIoDbJQjH7Ppgd7J68KRf/l+ByJE0rbZshkzZq4tGNlqOP5YhJRBuc0LepT6sfUE/48OgfRsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3BTpD4cOvuZRhSc2XzzvaGCH/+fVXx1m9e1lkp7BqU=;
 b=ngOwYe/GIR3mfQZ9eVpzeANwvKM8CKQfAh1XNKi8XkMIplzYxvsr33Q285fNoahn+MBrVVPyz2Isjlq+vfE7T9T/MhndwUHDSx3n0qYKbQDjrkqvpFH7DEnnEiVJAMxafvXSXKJRBzAwWy3usInwEvY5RT46dmBVb7oj0qVftUcMhpfX2NMxbApz/OEeEjpJ7dkoc7BOcXPRwk2mr1meilHp7G550EN4cFptq5+aY79QSG4Rl3sER60zwwNUQiezCvXCOG+GdeDjnngzZPz9soxeAp5l9XaG1ZSv53cp04m40gPcxzGrCo92NKwnnqRiwvOhcRR4G8qMZySGKAAvng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3BTpD4cOvuZRhSc2XzzvaGCH/+fVXx1m9e1lkp7BqU=;
 b=aCPAv8EXj4WZ6JwmDXqRhyi1uQBRgK3D1OmKM7ARx5ImKIiiMAHa2KhbQQpf/QCkahzh1xRBAO9rqVFunZnRHdcKOsYMVqUniEWTOlDvQDYW49D34asaAsKeVQMDpxpB9D5s+i2kTRUMICFv051vDxL6bTZ2zjAEa5peEtAb2EW/pdhxV7NM0hkVo/bh1vdPj93MqC7XZk2QpCcdtAm1BMQY2JvwMtq1b1YMrlFznwsj7k/dT2UIBaMVYckiqO+9trAr9ZLyshIanfA2ww/wFlS7PHQZMmD6wpb9UK3sjE9ndg2AnYFmNmbqmWZlzFbSdr8bBTgCFdjghTi9mUaUiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYZPR03MB5310.apcprd03.prod.outlook.com (2603:1096:405:5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Thu, 24 Aug
 2023 08:43:04 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::f065:6e23:803b:2a75]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::f065:6e23:803b:2a75%7]) with mapi id 15.20.6699.025; Thu, 24 Aug 2023
 08:43:04 +0000
Message-ID: <3aa87be6-4961-9074-d417-d84e9c981195@amlogic.com>
Date:   Thu, 24 Aug 2023 16:42:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2 2/6] soc: amlogic: add driver to support power parent
 node
Content-Language: en-US
To:     neil.armstrong@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
References: <20230824055930.2576849-1-xianwei.zhao@amlogic.com>
 <20230824055930.2576849-3-xianwei.zhao@amlogic.com>
 <741c1e35-648d-4c2f-a939-24bcbec93911@linaro.org>
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <741c1e35-648d-4c2f-a939-24bcbec93911@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0161.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::17) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TYZPR03MB5310:EE_
X-MS-Office365-Filtering-Correlation-Id: 664e41ac-07b7-49b7-9d9c-08dba47e217c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o08+0lI/Cty9vmKF0D/fjvSl7HNJPoc7d4MGNcOXxFzrApINy7Cg+hqCKC3P75upcu7p9qqF3U7FnOglvcUr9gPPn0KOpn9XVnEBvi8Uu5uziqQsmF+pTyw6Sf9VMlT4vz07fyWkyHcNdclQVf04RQc7OwKsesrCW/w3LiwIb4gVHlcL6I/sF1Fx9rHwKj4akf1z7ij8p0OyFMQALv5HnLZMrJv7HV/L40wxXH01TL8JpXMm+Trb6bxtxPK+oVSWFO26X/qMtcNvsKWEjhZbJp08Yh+6YP6jUXBG91JD4PAVPAvPRJScqZ8r1qCseqOfDDakgEfZVsxuxip9J3dpDpYiFSv2DT+oBnTX8xjBBdz259BXoUDAnNN/OELbg48Ih20rZZXpMCjtICjiCp3wJmEvBo9DUrRACvKiwz3WG2k910FNZPMATtKw1BlyY2FnAr35ENQYSgDTPwqgtMCqyNEZFRUwdU3F7iU2oQVb4t1wRd2nDYAsNMqv2lEjBMLylOdhDAlfxv1ZxBPTYmumQTnUz5DpOTvI79zh5yqOkkx9Y4L+RpflZW/MLrKbz2/7q4iYejJsSG0+vRthm6dCTyUx1GMUrjjbQXuEk3UDcIKwAA+CkMHsJVAIKOUFg1+56QyVRJ4UtCIK3ahp/9LY0RCJ+GIq0RqAAxcSkO9YGerHrBVYPTMjD5bdvUSV9GNNKOtfg80LuSsf3vLtiSGfQZ5Qk6X+EtJR+L1Lxb0fagA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39850400004)(376002)(136003)(451199024)(186009)(1800799009)(83380400001)(38100700002)(26005)(36756003)(2906002)(41300700001)(6512007)(478600001)(6666004)(66946007)(54906003)(66556008)(6506007)(316002)(6486002)(66476007)(31686004)(53546011)(2616005)(5660300002)(31696002)(12101799020)(44832011)(4326008)(8676002)(8936002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW5ZYUptSCt3OHZweFhtaS9oVVRMTXRUR3hqMVRZNmhqNWZKZW1TcEx1NDBK?=
 =?utf-8?B?b3JaNm1jRWtwZ0FYMS85MjA4OWJwWEFhTkhjdno3ZmhJRDNWTFhBV0pjNDdI?=
 =?utf-8?B?ZTJ0a3FiMHRtZDZ5UzNlcm5odXBxRnQwakwrN0ZBWFZwcUJBci9Nc3hXMFVy?=
 =?utf-8?B?K2E2bDRwZXlETS85ZUJ4WGNIMmdpOVdYU1RGOEF4TmIrcDlueDVxRnJlSG9o?=
 =?utf-8?B?VmF1bHkxenZLUkNWZ1FkU014Y21PMTNOOXpXVExvY21vQ0drVGJKMDlwQncv?=
 =?utf-8?B?OVJMRXd5U0pTSm01NHdiOENHQlJ4OGNqa0J4SWFHYjBhS0E1cHlEYWIrcWwy?=
 =?utf-8?B?SWUxSGg5V28zNXViS3llQm9FMzhKeUNXbFV0ZERseUNHcXd4TlVXcXY4NFBy?=
 =?utf-8?B?NjRwUlpLUzY3MWMvRkpCUEpMeDczSzVjUUxJdlNOUjdGNGJrN0M2S295UEFG?=
 =?utf-8?B?WHZ1Z2ZnQzFRM1VFMzd2aTl4bHFIWmxGOEQ1bnBpSlFpRG9MdFNIN29STnFJ?=
 =?utf-8?B?emtoeExMd3NyUTYwbzBxTFB5M29ZZkppTStldjRqYnpyKzVKZTI2RnlabmZJ?=
 =?utf-8?B?anpvdmtucm5uTi9ac2lwVXorUDJNT2Z2SjZ4WWtJR1RIVG1Yd1c1dnd6dnRI?=
 =?utf-8?B?RW05bW9GNkdmeGM1azJ1dS80VGdHL3Y3dVRhZGF3WlRta3NtL082VHZTVlI1?=
 =?utf-8?B?RHFZQ2ZVaTlvR1RtQTVXdFlPcXdTNEtldWxjNkN2ZzM5UzExdEpsM1RObFd2?=
 =?utf-8?B?dHUvZjdYMzBxd0lTRldDWi81NkIxZmo1cEVaSlpYb29jd3AraW40blBodGtm?=
 =?utf-8?B?Y29YVDdQOGRncmFCQVdsU3ZGUHpQbUJRbUxzYzgwVG5hSmdLYnNGMldZZ0s0?=
 =?utf-8?B?dXBMUXdvNWZSNStvd0tSZ0QwY0tqYTJhcWVnT0JVYkVRcEdPU3VqWWZZSkVm?=
 =?utf-8?B?WHlsNDlsS2pscXI4cjR1TmcyVlIyc1A4THg3VW9PeTNQaVR2YXZQNjhyRko4?=
 =?utf-8?B?aVNHNVhLL3ArTmpEYjVjMFpkTURIMWxaOFJNdmxvQmhNTmp3NXRNaUxjeEcy?=
 =?utf-8?B?cWE0RGMzS0R0aXNYdmFuZ0dxR0hNQUk3WUNCeGZ2RnRrV2lBSGJIdWpJdVNt?=
 =?utf-8?B?TnhCblI1K1hnRmtCeGNYVlFjTDhlZW1kSVlZcUIxcHQyR1ZuWXZ6dEhKS2tM?=
 =?utf-8?B?dFN1aU5tRXp6RlFUQ2l6dmtpTmdXaitHRTNuZjgvRWFTaHBmSkpZSjIrRUI2?=
 =?utf-8?B?d2lOK3ZSc0JwOFg2Tk5HU01ad0ExeDc0aHdqZXp0Sm81OUwyY2ZjNm1IaXU2?=
 =?utf-8?B?T3EzM21VWlR2WXpmMDU2TnlRVXVpR0lFMHY4VWxaTmRhSGhSaVJucmdhZ0Zx?=
 =?utf-8?B?d0FpbkdUanZGZElLbjNqdlZOY20za2cyeTFlWmJncEVyeTRicHEzQ0EvelRz?=
 =?utf-8?B?M2ZzOHM2bWpDSXpqWVFUaGNySmYrUzNzSHJ1dzQyM1NRaCt6QmZIUFd4RWtY?=
 =?utf-8?B?Um5MbGRoT0l1REkvcUd5L25uRi9wb1ZiMUNpbGlJN1hoTUNqeUUwUzVkTXVG?=
 =?utf-8?B?OFpoQ2FORTgyUS9GelRla3IwY21oanJyc3crUzN0SUFiQzhwY1NSOVcyVjlJ?=
 =?utf-8?B?R1hLTWJyUm1Zd3BPbkZSVm5iVlkxeTFmNndZTUVOM0FkZTF3Z01TeTNOU05R?=
 =?utf-8?B?QmRzYzl5dDltVldBMkZQYnNlZmJZWDBRdkR4Y3pBMTZ4R2JqTVhIWjdRK3Rr?=
 =?utf-8?B?NGZBN2NUVTYyTU9TKzhaSXZCQ0ZMb2VsSE13Yk5qUnFrenhhdXRSM0MxL2NB?=
 =?utf-8?B?NlFvRmpEbTI1TzBYaHV0aHNPSTVHcGxaN0g0Tm5DaE1PZTRNeFFoUTY2Tzli?=
 =?utf-8?B?VGxtWlh2MHZaQXBFa3JrVElMRTBoa0tUbDliTVdKRWNFRUoxamNScXB4YSs3?=
 =?utf-8?B?RXJsS3N6UmdjVXo5SVVPUjVrMWQ1UTVmMzJ0b296N0Fmc200eW1XbmVkc0Ir?=
 =?utf-8?B?bVVKeURSZ0QyK0IySlpjSS9zbWV6S3EyL0c3V1QveEMwTFE5V0lKWktCbXR1?=
 =?utf-8?B?bUpJL1lJM3lhVmZ6VDU0MHBkS045TTNUcE82N3hWcFIyaU5aZDM4emdtMjdx?=
 =?utf-8?B?MVFvcDh4UG5ITnVvKzl2VDA4U2VuQ2tBeW5ESzVlbnE2bE5mcyt1eSs5SlZr?=
 =?utf-8?B?MXc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 664e41ac-07b7-49b7-9d9c-08dba47e217c
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 08:43:03.9807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQZ4fcKUZNLJCo2b3qm3rGT3J4qGSWpAmXDLc62k5q4dzUtfn8ChcljtZLfL8rhFJ0LjC32+/0yplVQ7EcRmklfRy1gU6/1LjcZlswFs7Fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5310
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,
    Thanks for your reply.

On 2023/8/24 16:27, Neil Armstrong wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi,
> 
> On 24/08/2023 07:59, Xianwei Zhao wrote:
>> From: "xianwei.zhao" <xianwei.zhao@amlogic.com>
>>
>> Some power domains depends on other domains, Such as Amlogic T7 SoC.
>> Add parent node to support this case.
>>
>> Signed-off-by: xianwei.zhao <xianwei.zhao@amlogic.com>
>> ---
>> V1 -> V2: None
>> ---
>>   drivers/genpd/amlogic/meson-secure-pwrc.c | 26 ++++++++++++++++++++++-
>>   1 file changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/genpd/amlogic/meson-secure-pwrc.c 
>> b/drivers/genpd/amlogic/meson-secure-pwrc.c
>> index 5ac2437ab8ad..76527f4946b4 100644
>> --- a/drivers/genpd/amlogic/meson-secure-pwrc.c
>> +++ b/drivers/genpd/amlogic/meson-secure-pwrc.c
>> @@ -19,10 +19,12 @@
>>
>>   #define PWRC_ON             1
>>   #define PWRC_OFF    0
>> +#define PWRC_NO_PARENT  ((1UL << (sizeof(unsigned int) * 8)) - 1)
> 
> This is fishy, just use UINT_MAX
Will do, use UINT_MAX define (~0U).
> 
>>
>>   struct meson_secure_pwrc_domain {
>>       struct generic_pm_domain base;
>>       unsigned int index;
>> +     unsigned int parent;
>>       struct meson_secure_pwrc *pwrc;
>>   };
>>
>> @@ -34,6 +36,7 @@ struct meson_secure_pwrc {
>>
>>   struct meson_secure_pwrc_domain_desc {
>>       unsigned int index;
>> +     unsigned int parent;
>>       unsigned int flags;
>>       char *name;
>>       bool (*is_off)(struct meson_secure_pwrc_domain *pwrc_domain);
>> @@ -90,8 +93,19 @@ static int meson_secure_pwrc_on(struct 
>> generic_pm_domain *domain)
>>   {                                           \
>>       .name = #__name,                        \
>>       .index = PWRC_##__name##_ID,            \
>> -     .is_off = pwrc_secure_is_off,   \
>> +     .is_off = pwrc_secure_is_off,           \
>>       .flags = __flag,                        \
>> +     .parent = PWRC_NO_PARENT,               \
>> +}
>> +
>> +#define TOP_PD(__name, __flag, __parent)     \
>> +[PWRC_##__name##_ID] =                               \
>> +{                                            \
>> +     .name = #__name,                        \
>> +     .index = PWRC_##__name##_ID,            \
>> +     .is_off = pwrc_secure_is_off,           \
>> +     .flags = __flag,                        \
>> +     .parent = __parent,                     \
>>   }
>>
>>   static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
>> @@ -202,6 +216,7 @@ static int meson_secure_pwrc_probe(struct 
>> platform_device *pdev)
>>
>>               dom->pwrc = pwrc;
>>               dom->index = match->domains[i].index;
>> +             dom->parent = match->domains[i].parent;
>>               dom->base.name = match->domains[i].name;
>>               dom->base.flags = match->domains[i].flags;
>>               dom->base.power_on = meson_secure_pwrc_on;
>> @@ -212,6 +227,15 @@ static int meson_secure_pwrc_probe(struct 
>> platform_device *pdev)
>>               pwrc->xlate.domains[i] = &dom->base;
>>       }
>>
>> +     for (i = 0; i < match->count; i++) {
>> +             struct meson_secure_pwrc_domain *dom = pwrc->domains;
>> +
>> +             if (!match->domains[i].name || match->domains[i].parent 
>> == PWRC_NO_PARENT)
>> +                     continue;
>> +
>> +             pm_genpd_add_subdomain(&dom[dom[i].parent].base, 
>> &dom[i].base);
>> +     }
>> +
>>       return of_genpd_add_provider_onecell(pdev->dev.of_node, 
>> &pwrc->xlate);
>>   }
>>
> 
