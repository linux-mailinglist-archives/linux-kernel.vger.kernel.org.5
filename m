Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498A6786AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjHXIua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjHXIuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:50:17 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2108.outbound.protection.outlook.com [40.107.255.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181EEE68;
        Thu, 24 Aug 2023 01:50:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Os5Ip5G78X5b4rTMhDwnGasHQJOlVhGGe6VUnKLMxgpd1E2tKDoK/ANqHrVciXo+HzhtMrLIgCsEV/eqmi2aIhZBQM0rpapLREEFuP8dOzx93zLx672DcczXhlfo64cm12z/mTuTmfi1yZbLzOeQ/Wgx0Zh4OmzofOUXxb6qn9Za7ELh+U5rHNNW5H1V9f6EuZ1cOUWrNu5gxPoGRKfHC5401PSlXq6ctrzpU72sGJLDI/gJd2ItjsiYav8BeuFXGXjy1OV8CKBAAzIpzfKU8MK9HHPW9xeG3ozUUSj1yut/VvchrOb4pDvqNG0E+My9Fu/A1689tor1jgY5uuP/RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37Vl5Nuu2wsxh2ubxYsgjMJwR/5AB0inptuA3fXV7Tw=;
 b=bpZy6f+82AkswMHxo1aADP1sx0ib94nfQ8jT6x8kOQCJIsTO4w6blXk/uc0/NKfUboBSCYGNl7hT3Mp4od+IIi3GQv/lkIqav4dyAIsNRBIYcJW8hAJZ90vZ5Vy291cVwIG8z6Ml8N7/UlL5Q47TMud5hA2uXs8I9DO0/mYvwUTjy95aiB062vk2r8+3GDPE50YMPWXmPRLS9LiElLgbwCCuJ6SxNk61dp+XXyu7NX+8sZJ52CEz8G2/zIqVRgR93q7/mt4XTkgBEP11n064m/znwdPl0PYLTD5pS5jm6UChCN7GA0yxIMKgha5zsBNRmXU2ms4hgdSYNKLZYEf2yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37Vl5Nuu2wsxh2ubxYsgjMJwR/5AB0inptuA3fXV7Tw=;
 b=E6JiG2YLcUui5UZKj7sBgprqMo4peA8nN4xrbX2seN3xU/dtCFtOyeVgtmMYWeNKArtMst+PYzRAv0oxDmY3EVnqFn7TmxCX/QKPa9J4s40C8Ewwek6xD5arqN5vRaAIhTxjA2tRUYTP3kW/yD0E1C8ecFLrxtq5a+0aW+bVsAGqkXXpHgVvxJr+kPFeqeFYw2JfLQMAzpadbS5VKeCKO/fJ22vczMypyZaWOeX++3A05ISluQR37bJr7W5R9t0lZw/sTc1a8IyKWOntEEpAZkLnaLy6RFZ8xOfF/3w6YhHcr2mBT6TtWEWNfLoHaDAeyq4B2YFRwkKBHOb82CsqWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by KL1PR03MB7527.apcprd03.prod.outlook.com (2603:1096:820:ea::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Thu, 24 Aug
 2023 08:50:11 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::f065:6e23:803b:2a75]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::f065:6e23:803b:2a75%7]) with mapi id 15.20.6699.025; Thu, 24 Aug 2023
 08:50:11 +0000
Message-ID: <7180c992-2dbc-f673-56d4-a328c11c7faf@amlogic.com>
Date:   Thu, 24 Aug 2023 16:49:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2 5/6] soc: amlogic: Add support for T7 power domains
 controller
Content-Language: en-US
To:     neil.armstrong@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
References: <20230824055930.2576849-1-xianwei.zhao@amlogic.com>
 <20230824055930.2576849-6-xianwei.zhao@amlogic.com>
 <97c05c1f-1d59-4dc8-9a1b-ae2fea61e094@linaro.org>
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <97c05c1f-1d59-4dc8-9a1b-ae2fea61e094@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0181.apcprd06.prod.outlook.com (2603:1096:4:1::13)
 To TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|KL1PR03MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: c4b0de6a-9113-4cbc-da5a-08dba47f2007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zS98ERu2vFCfr07X48fJzHQmNdaa2jDmoYoIV3P45VziSU9MQtC2RaS8nB3YZOs0q1mC7ogtkYR4sMj9f/8ePUmCVyY84mpxqWwmfA9m4A2Zp51AwvMl6DfHtYbtEGMsPema4dZ2ZwUxx+AoUNCRnW1wpjInG0o47Ars34sV0XDEe6uN/Ar12U/3XfOzVrRIAK57G91VFw5evooBKvEN7MdfJcS1c3xVIrpEmn4xfO0lYX7EwQOH1bm3COYcYRSZ0PoPOK6XrpGEZ6LC3yKtLXWic3b2Tf1ydYFPxh1EJ8rUdE4Y56m5CbIMPxe5Pugbyy0zhAtUMRleWyUHTjqsgVx4eBDBS/kujq8T3z3iWfwSV4u1hP3O5q5PRiSpl+45k54hMdf6hc/bh3bu5smyyAVxjvX0eRi4dUBd1WtXyqwyDN51vrjroUhzkaWFLdbzHGFqZOuyD+kuejZMg6c37R3TtXeiX5eThMRh0mHlcmW3mL3VpR/JecN0b3LfH7mcMxnq5vY00PYk7oXJfDWwor1Hd4ekoFKZRtksIevhqZwMWAsgfx/cKt+lxvvQ1c8TCTfBlDRUufAtXuTRk1lN9SGaSJ0BTuBHk222O08n/c4rKEUPpW4k3sCDNgiK18Yg3AUyMho/H2Bu3gy4iU+LLjiR30KMM8UJwBvdIUdOHO8yGsToDPlXrvIVaGj6h2+vByAKtUbPGWzjOWPmZY7p6tVGNBwLjW2M8veA05//YpE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(366004)(346002)(396003)(136003)(451199024)(186009)(1800799009)(2616005)(6506007)(6486002)(53546011)(316002)(12101799020)(8936002)(8676002)(4326008)(54906003)(66946007)(66476007)(66556008)(41300700001)(6512007)(26005)(5660300002)(44832011)(6666004)(31686004)(478600001)(83380400001)(36756003)(86362001)(31696002)(2906002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2xTaHNyUWVUbEUwT3ZobXJjZG94U1ljREVleVJOMW5scjRpSnZWVFB2aTJs?=
 =?utf-8?B?c29meTIvSXNMMlVUSUZmNzhsS0hMaEJack1RWUZWakdueG9OSzNrOUNaUkdR?=
 =?utf-8?B?K3ozN2tXZ0c5bzlxbC9mZ1dpeXFZN2hUSHMxWEtmZHRVamZIUVFxM1dHYUdj?=
 =?utf-8?B?MkcrZlFLSVQweWx0MkhNUjEzc1BxNGRpTXJYWi9vNUs0Z1lxZ0JuNGVlUHRn?=
 =?utf-8?B?c1UzVTRLSWtFUlowMW9EeWN5S1BxRUE2ZFEwYWkzVXZMZEVOU3dwYVU3T2g2?=
 =?utf-8?B?M0ZxSnFmdG5NSFgvV0UzRytxMGVvVEI0emdUV09peVFJazZCZmxWYzZkbVdB?=
 =?utf-8?B?ZlhBTU1xTy9TM2w0aGxOWmZoRHpxOTVoY2VSM3pqSG9HNjl3aDdDRGM0WDd4?=
 =?utf-8?B?TGtub1BiTU1tR3pZd2hCQ3NEMFlyU1E2ZGM4MkEwR01odGQ0a2R1NVRtSHN2?=
 =?utf-8?B?SXQ3OHVyeDNKMXZmRk5HVzA0K3lUeS9Xd3RZblFiTjFEcFl5bUFEMmM2c09y?=
 =?utf-8?B?Q3ByZVFCMmdMT29JalBSK1MreUY0UCs3VVFrRTZJdzRRcEhabG5JTFpqUHdJ?=
 =?utf-8?B?akFSaFFkNGR3d0EzVG9VTVloTUtMS3ZVV1cvZ1VWbVFlL1RyTmJWL2FyN1lO?=
 =?utf-8?B?NUdyQlFBREZka3k2ZkYxRFFLVnN1cENhazIvZ09jK0ZXeHBoMVVlU3BEUEkw?=
 =?utf-8?B?MFlFTDczMExrajNBNjFTSFI0QmFxUnUrOFdROHBoOUROWmsxd3VPbVVMT2wr?=
 =?utf-8?B?R0VsTXBZdnN0SXBEVEN1eEcvb2ZNUWZVbFIxMERXUTV6ZUNBTnNpNW9vdWpW?=
 =?utf-8?B?STFFWTNUMEgxQVdQQndiOXdKK1lzVytVQWYxQkVncGFqVStuampRYkFVeHVN?=
 =?utf-8?B?eDBOSEhFVFpxUnd2Tk1SMCtyWWsyZm0zY1FJNXZGWEZhUVlUMHVkVVVUT1h6?=
 =?utf-8?B?WEM3dDY0WjY4dURkc0ZVbEZmcVVFcXQxZm54UU1WdDI4Um4yd2RFTlU4ejhq?=
 =?utf-8?B?R2RlV3RDYml3NWF2ZjFUR1ZvV0hOTlJsMjd4UjVWMUpNZEd2d3M3bUtVREVP?=
 =?utf-8?B?Zzk4QXoxK0t6TnpLY0dyeXFqSHp3aFl1RWkvRFF2YTBuZU9abnJ0Wkt1VnFK?=
 =?utf-8?B?bzJkY3dQRHhUZzIyRi9aVUlHT0pMeGRLZkVnUERoWXRVNlhiRUtpYk1BejF0?=
 =?utf-8?B?bWNEajVBVUtpRGd3a0poMTJPUXUxc015QzVBS0hmQ0F6SDl5czlqdnJXbzJY?=
 =?utf-8?B?dFpJaUNnMEJFTFNXZ0F0OUpsSDJ3SHdBRDJsTUxva2FtL1JkVlgrQ0U2R3VP?=
 =?utf-8?B?ZXp6Y3Z3LzRVUVBmcU56eS85Wm84MDFzYmpSSWE4aklzZ0FvanAyR2ZzK2pD?=
 =?utf-8?B?bFdHTjh3L2tQcjArb245RGV5R3hPWi9kRFFycW5zcXF2aWJ3VnNFVk5YU0w3?=
 =?utf-8?B?NGVkRlpTU3loR2ExL1RjcTAzMVh5aVVLZ1VjU1J6NEtNRk5oWjJYdFlXY1ox?=
 =?utf-8?B?Qk43NnJqOUVsbUJ5Rkg1cWNTTW5CbU9nZ1FrWkF0M3ppR3dzRE44TE8xUmdw?=
 =?utf-8?B?Q05QdHEzaFo0Wjd2OWhITjhoeWVMZmlYeEsySzlPZEpEWjRkRDJ4M3Q0WVht?=
 =?utf-8?B?ZEh6MU1LbUZIWHRsaWExY1F6azFWbjFvcjFlZFN6bGZmQnNxcDF6YnIwbE9y?=
 =?utf-8?B?ZEFYaCtZVElxV0RLWVZZN2FqT1JjUUdJTG1JUzQ1eDRKdzRzb2RYNWhqVStP?=
 =?utf-8?B?OWZVZzk1V1M1cHNvMGJ3Wk5HcXova2lxdStXaDhrU3BUSHNRdHhNN1JLWDd6?=
 =?utf-8?B?MHRiMmJteFJZSmlvT1dtT2pOK1pKZlNMYzBzbFdMNUZGVmZocVdaOW82blA3?=
 =?utf-8?B?OFlkalNDU2xXZy9jWm5Hb096TTRXV3RMUTFkZUhIYXd1U3d2MjY2WTUrNGF6?=
 =?utf-8?B?L21lODM3V215ZERrZmZLQ04zN0s1TG16dElWV0JiZ29GZzFVWWR2ZDVGTTFl?=
 =?utf-8?B?V3c2a2ZwU21nZFZpV2Z6Rk0xK29veDdOSjUxaEl0ZW1Bd3pSMEJlbzU2dEdC?=
 =?utf-8?B?SFN1QWtLWTNqM0djMXR5LzZCUXMxUTZmbjZhWEE0bjVvQWhjcDMzcjA2SW14?=
 =?utf-8?B?amFPTXlidnU4V3JuSE5TM21rVEd6WElvZ2EvSERaWUZTTWhFWjJTSU0zMEla?=
 =?utf-8?B?VVE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b0de6a-9113-4cbc-da5a-08dba47f2007
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 08:50:10.9584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npjlhtlWUx0YbXLcbEIopWs6YQu4+MslBi9nxAcWRc8CoMHyzkCFcLaJFP/BdO1EgKPK49JsuR/kXvYgarHLhiDTr1Cigcj1JAEqXuwklBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7527
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
> On 24/08/2023 07:59, Xianwei Zhao wrote:
>> From: "xianwei.zhao" <xianwei.zhao@amlogic.com>
>>
>> Add support for T7 power controller. T7 power control
>> registers are in secure domain, and should be accessed by SMC.
>>
>> Signed-off-by: xianwei.zhao <xianwei.zhao@amlogic.com>
>> ---
>> V1 -> V2: Modify T7_NIC flag  "ALWAYS_ON"
>> ---
>>   drivers/genpd/amlogic/meson-secure-pwrc.c | 73 +++++++++++++++++++++++
>>   1 file changed, 73 insertions(+)
>>
>> diff --git a/drivers/genpd/amlogic/meson-secure-pwrc.c 
>> b/drivers/genpd/amlogic/meson-secure-pwrc.c
>> index 3e7e3bd25d1f..2233f6cb7e71 100644
>> --- a/drivers/genpd/amlogic/meson-secure-pwrc.c
>> +++ b/drivers/genpd/amlogic/meson-secure-pwrc.c
>> @@ -13,6 +13,7 @@
>>   #include <dt-bindings/power/meson-a1-power.h>
>>   #include <dt-bindings/power/amlogic,c3-pwrc.h>
>>   #include <dt-bindings/power/meson-s4-power.h>
>> +#include <dt-bindings/power/amlogic,t7-pwrc.h>
>>   #include <linux/arm-smccc.h>
>>   #include <linux/firmware/meson/meson_sm.h>
>>   #include <linux/module.h>
>> @@ -164,6 +165,69 @@ static struct meson_secure_pwrc_domain_desc 
>> s4_pwrc_domains[] = {
>>       SEC_PD(S4_AUDIO,        0),
>>   };
>>
>> +static struct meson_secure_pwrc_domain_desc t7_pwrc_domains[] = {
>> +     SEC_PD(T7_DSPA,         0),
>> +     SEC_PD(T7_DSPB,         0),
>> +     TOP_PD(T7_DOS_HCODEC,   0, PWRC_T7_NIC3_ID),
>> +     TOP_PD(T7_DOS_HEVC,     0, PWRC_T7_NIC3_ID),
>> +     TOP_PD(T7_DOS_VDEC,     0, PWRC_T7_NIC3_ID),
>> +     TOP_PD(T7_DOS_WAVE,     0, PWRC_T7_NIC3_ID),
>> +     SEC_PD(T7_VPU_HDMI,     0),
>> +     SEC_PD(T7_USB_COMB,     0),
>> +     SEC_PD(T7_PCIE,         0),
>> +     TOP_PD(T7_GE2D,         0, PWRC_T7_NIC3_ID),
>> +     /* SRAMA is used as ATF runtime memory, and should be always on */
>> +     SEC_PD(T7_SRAMA,        GENPD_FLAG_ALWAYS_ON),
>> +     /* SRAMB is used as ATF runtime memory, and should be always on */
>> +     SEC_PD(T7_SRAMB,        GENPD_FLAG_ALWAYS_ON),
>> +     SEC_PD(T7_HDMIRX,       0),
>> +     SEC_PD(T7_VI_CLK1,      0),
>> +     SEC_PD(T7_VI_CLK2,      0),
>> +     /* ETH is for ethernet online wakeup, and should be always on */
>> +     SEC_PD(T7_ETH,          GENPD_FLAG_ALWAYS_ON),
>> +     SEC_PD(T7_ISP,          0),
>> +     SEC_PD(T7_MIPI_ISP,     0),
>> +     TOP_PD(T7_GDC,          0, PWRC_T7_NIC3_ID),
>> +     TOP_PD(T7_DEWARP,       0, PWRC_T7_NIC3_ID),
>> +     SEC_PD(T7_SDIO_A,       0),
>> +     SEC_PD(T7_SDIO_B,       0),
>> +     SEC_PD(T7_EMMC,         0),
>> +     TOP_PD(T7_MALI_SC0,     0, PWRC_T7_NNA_TOP_ID),
>> +     TOP_PD(T7_MALI_SC1,     0, PWRC_T7_NNA_TOP_ID),
>> +     TOP_PD(T7_MALI_SC2,     0, PWRC_T7_NNA_TOP_ID),
>> +     TOP_PD(T7_MALI_SC3,     0, PWRC_T7_NNA_TOP_ID),
>> +     SEC_PD(T7_MALI_TOP,     0),
>> +     TOP_PD(T7_NNA_CORE0,    0, PWRC_T7_NNA_TOP_ID),
>> +     TOP_PD(T7_NNA_CORE1,    0, PWRC_T7_NNA_TOP_ID),
>> +     TOP_PD(T7_NNA_CORE2,    0, PWRC_T7_NNA_TOP_ID),
>> +     TOP_PD(T7_NNA_CORE3,    0, PWRC_T7_NNA_TOP_ID),
>> +     SEC_PD(T7_NNA_TOP,      0),
>> +     SEC_PD(T7_DDR0,         GENPD_FLAG_ALWAYS_ON),
>> +     SEC_PD(T7_DDR1,         GENPD_FLAG_ALWAYS_ON),
>> +     /* DMC0 is for DDR PHY ana/dig and DMC, and should be always on */
>> +     SEC_PD(T7_DMC0,         GENPD_FLAG_ALWAYS_ON),
>> +     /* DMC1 is for DDR PHY ana/dig and DMC, and should be always on */
>> +     SEC_PD(T7_DMC1,         GENPD_FLAG_ALWAYS_ON),
>> +     /* NOC is related to clk bus, and should be always on */
>> +     SEC_PD(T7_NOC,          GENPD_FLAG_ALWAYS_ON),
>> +     /* NIC is for the Arm NIC-400 interconnect, and should be always 
>> on */
>> +     SEC_PD(T7_NIC2,         GENPD_FLAG_ALWAYS_ON),
>> +     SEC_PD(T7_NIC3,         0),
>> +     /* CPU accesses the interleave data to the ddr need cci, and 
>> should be always on */
>> +     SEC_PD(T7_CCI,          GENPD_FLAG_ALWAYS_ON),
>> +     SEC_PD(T7_MIPI_DSI0,    0),
>> +     SEC_PD(T7_SPICC0,       0),
>> +     SEC_PD(T7_SPICC1,       0),
>> +     SEC_PD(T7_SPICC2,       0),
>> +     SEC_PD(T7_SPICC3,       0),
>> +     SEC_PD(T7_SPICC4,       0),
>> +     SEC_PD(T7_SPICC5,       0),
>> +     SEC_PD(T7_EDP0,         0),
>> +     SEC_PD(T7_EDP1,         0),
>> +     SEC_PD(T7_MIPI_DSI1,    0),
>> +     SEC_PD(T7_AUDIO,        0),
>> +};
>> +
>>   static int meson_secure_pwrc_probe(struct platform_device *pdev)
>>   {
>>       int i;
>> @@ -257,6 +321,11 @@ static struct meson_secure_pwrc_domain_data 
>> meson_secure_s4_pwrc_data = {
>>       .count = ARRAY_SIZE(s4_pwrc_domains),
>>   };
>>
>> +static struct meson_secure_pwrc_domain_data 
>> amlogic_secure_t7_pwrc_data = {
>> +     .domains = t7_pwrc_domains,
>> +     .count = ARRAY_SIZE(t7_pwrc_domains),
>> +};
>> +
>>   static const struct of_device_id meson_secure_pwrc_match_table[] = {
>>       {
>>               .compatible = "amlogic,meson-a1-pwrc",
>> @@ -270,6 +339,10 @@ static const struct of_device_id 
>> meson_secure_pwrc_match_table[] = {
>>               .compatible = "amlogic,meson-s4-pwrc",
>>               .data = &meson_secure_s4_pwrc_data,
>>       },
>> +     {
>> +             .compatible = "amlogic,t7-pwrc",
>> +             .data = &amlogic_secure_t7_pwrc_data,
>> +     },
>>       { /* sentinel */ }
>>   };
>>   MODULE_DEVICE_TABLE(of, meson_secure_pwrc_match_table);
> 
> With updated subject:
Will do.
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
