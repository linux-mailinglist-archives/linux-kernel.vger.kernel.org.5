Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81D176B534
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjHAMxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjHAMxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:53:40 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2117.outbound.protection.outlook.com [40.107.215.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2EE2D76;
        Tue,  1 Aug 2023 05:52:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPjDjTpdqZQ0C7TxIyoGZGmoSieXdQHFDa42uQ0LMz3pOb5IdwYLkS4jUC22Q7SdhAfjHD0FamKnEWAqvdKKbTpRDYYFuNfPSDNuMFIvW5xiho+cndb5lMDrtbj96tnVIsPV1ZZ3J4DlTsnBbzoSN5o35zBkpqAn1lEpYawM7cGkhyFjTwTQorZk+GywOwVEgNlEXQ9k50pxcMcAg1ArbIWwehdVy+FZDrfnjy9XREcx9OZs7gU1yW5C+1EuNos4j/E8jijlKsOcouPjTTs4V7LinK4CdsrXfG6YHidlRvjZ2svh/gpMyrtLIHnvbOqvHZniQe8n0bwY7Ok84ZK55w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y11EjV78EaUEhO8KOZU5MedOpcMoaLyt7veAiLa9sZA=;
 b=lsAYRP35vFEvfJk89M1npsfrpVLVWPz3LoXdFKipRuwPIZ+nxoQXg8niv3WWJt45Jg/2+yE2Q7ObUeCqkaraKng2JW5GKTGHYYZSHU1NdKYhAiybnTXByglW4wBwgHuSx8TTLdqfS1M6nYtgWF1PRiqSpXnLO/VUAFea368GhTbKDdZ8AYOeZ9oF/VANFo6EyT4eVD64Z9w4ogtAi9GNQWe6iyOw6hidb3zFlLG0Cx5RO+IFmcoJLJZ/CKnw5ldJj/lm6FTc9Sr2bqxirPUaO5BM2mb4k2UKy3pN8jDWZV0pI03ijhkRw/KN23GwMtUT8q5kcwynH1snINbNDsp7dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y11EjV78EaUEhO8KOZU5MedOpcMoaLyt7veAiLa9sZA=;
 b=bYGAA5+QZ8ZH9A28K93Y8eVPF6n7eP7ogNZg8+wpjtLO2QlnSHc86YAkm6CguXkE54BxiDEfpZtVEEIRlx/0p056eKVscefW7lkx1N+VVOIYbwYScdxr+kL2qoOmsWK+zNJPMsKMvwUnd6u0gYXQKMpP/0ahjk8Ajor97HM/LqJKXVgKHlFv2/cz5IGAkhVCY7aRNrXpFQ7BKulSl1OH3HztQReLBaWpvoL8vSSp3lUW8bvfHhW9AV9XaMPvyCUQtOML3/5c2zLiUD1g7yFeBqPkSL/mhJrwBu+jBKUgY9kj36haGWscaT4L5g6K2lT15bd/1nAyI13KuCx4U3UGMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB7221.apcprd03.prod.outlook.com (2603:1096:820:cb::11)
 by SEZPR03MB6491.apcprd03.prod.outlook.com (2603:1096:101:44::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 12:51:36 +0000
Received: from KL1PR03MB7221.apcprd03.prod.outlook.com
 ([fe80::15ea:573f:2ff2:f723]) by KL1PR03MB7221.apcprd03.prod.outlook.com
 ([fe80::15ea:573f:2ff2:f723%5]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 12:51:36 +0000
Message-ID: <01357346-59f3-5c5a-d456-8e64381fe611@amlogic.com>
Date:   Tue, 1 Aug 2023 20:51:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/4] watchdog: Add a new struct for Amlogic-GXBB driver
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230726112146.1127145-1-huqiang.qin@amlogic.com>
 <20230726112146.1127145-3-huqiang.qin@amlogic.com>
 <20230728071558.xoa3sdku3zkuhtug@CAB-WSD-L081021>
Content-Language: en-US
From:   Huqiang Qin <huqiang.qin@amlogic.com>
In-Reply-To: <20230728071558.xoa3sdku3zkuhtug@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0188.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::20) To KL1PR03MB7221.apcprd03.prod.outlook.com
 (2603:1096:820:cb::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB7221:EE_|SEZPR03MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c5cf5d9-e325-43cc-1e1c-08db928e0a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KFUrIvgiLv8xI8mMni7V/wUElw4wx/ZnDDQjkraP4eCPgQl9sHRsCyDKyw/V1fZWYDzuphXJiLjKmMPARRvckRW1S4H+z7K9x+lZAZWwZPCdczvyHEKTz1AC0urmEZcAHKnkoq/wIltvv8CpMEGFsSd/SKF51LTfJKocDYtjBn7cvtxinhKfoesXxVyrnAF5NF8Y5lACK1BtJmXLZPzdy6UHdXKlF/WYF2CdI/aTH9KeDbp3m1teD7XyjLwQHeaDktjksCHc4jLSLglZMaO9ObO8kJM6aEd6ImZOeBK+4dQtc6epJqZUfriGHOUpl3ng/K88dFFut/okIxbWoemYlzfEgc5rjM2QhyANOgxDlxFRbyzwL/ZDRmU0jxqTf47t9BUnExr79eG5ePvQbgFpz0U490WBbmwMoCEveHNIyo3wEmUoew5x9d1wnK0rG7NejOTARkurB9b4ELG3yvwT7uMuONkTKL97Z+p5O83h3NlEfcb2J47v3ZPYcr6PpjALoEJ+ByWDOkIXbsum4ObM5qb16EtCk/dX6t94unLaoQWC+WhdGpbjrHudo9UupIwmRjZ2VpehqizzMmYsJBNjVmZDd2iIjA77RaHfCnDg17o2/ycUb4WQQucV+SevjwMCFZWMne+aHfitqd5Ao7+7k2Jk8ImRsFdA2ZIJL+0ZfX/84f0b1NJb80szRX6Jg8xpSdQ4xwruuyHZVMlNOEo7INuprSYjkUsMwZu9nsLTOIA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7221.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39850400004)(366004)(346002)(396003)(376002)(451199021)(31686004)(6512007)(52116002)(6666004)(6486002)(478600001)(36756003)(31696002)(86362001)(83380400001)(44832011)(2906002)(186003)(2616005)(316002)(26005)(6506007)(53546011)(38350700002)(38100700002)(66946007)(41300700001)(6916009)(8936002)(4326008)(5660300002)(66556008)(7416002)(66476007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFROK2VNS2xhWVJpWms4Slkrdi9TYkxMZXU4dGdiVitPZldGVGNxODAzUWxG?=
 =?utf-8?B?bk5qbm94eXh1VXloaXAwZXFyVnpSdmFiM1VxMjJMbjFZdzB5TSt5Q09BUDU2?=
 =?utf-8?B?NER6TUJtWnIvWXUva3oyK2dCamdCVFdtOS9oU3AvdERsKzFyWk9kbUVEek9P?=
 =?utf-8?B?ckd1SEFXZTlQbUdySEdNSVFGL3ljODVla2MwZldPTjZpdVFjUUwrU08vbWpm?=
 =?utf-8?B?bVdSTkZrdk5DckErR0JobmNEak4zTzRQajkrbU1LdDFnOU8rT1hBcUkyRVJU?=
 =?utf-8?B?ZnZNYUZ3cGFOaDlxMTlXVGVEMHhyaC9BOGdER20wNHhYZDRwODhCWEU4V0Rh?=
 =?utf-8?B?UEd2aytrbFMwK3JaZGZySXE4Yk9TbjBqanIveXZweEIvQ1RJT21jM2NsUlBw?=
 =?utf-8?B?MmNjOXJ3MTlRTDFJd05NMnlVSm1ZQ3hGZi9nQ3dFKytYN291VnBFUWl1aUc4?=
 =?utf-8?B?OE15c0FTdUp3R1JzbllsUGUzTVRlZG9vVGM3eUI0djR6SnUydnZEZDdUZXE5?=
 =?utf-8?B?Nnh6QVFLZzF1THFaS21WSVpqUE8xaTRHRG5zUUZHS3dDVmQxV2tPeUtYbGth?=
 =?utf-8?B?bmovMGxHWE5PSVZSdmdGSDhVWnZxSXNDSTBIV0tuUmVaRW1aMThxMm1jR1lx?=
 =?utf-8?B?bHdSVFJNa2FJckE1TXIrODEwVVJNZUoyWXBsd2ozZlBBTVpPNkpOME53Smoz?=
 =?utf-8?B?K3k1NUsxS1RoVEE0MklIUUpib3VPM3M3MmtnWEV6NmpGOUk5U1NPNFduNW9u?=
 =?utf-8?B?V0h2amk5eSt0NXljSnRVU0prTTF6ZGNKNUsyS3Z3ZTVraElSVkVaT0V0Z1kx?=
 =?utf-8?B?NVZNREJJWXhUUlFmbU00clBnTXFaYVl0bEJrUzlra1l6UHpLU2NsVVNab1hm?=
 =?utf-8?B?QkhMQUh1VkkxTlJCQytMS1dPYitxSTQ3TU1aZmpMMjJSRGdjZjJNZ01FVTZK?=
 =?utf-8?B?MzVyUXpGbFgrcHBzRkFsNWNmdG1kZGFuV3lacWtxV0ZLNVlTMHFBVjAxSmo3?=
 =?utf-8?B?YWxqY0dVVlUrbjQ2L25ENS9UbUVKRXJ3RXVFSFQ2bHl2bkJldytTaUJ1bDJq?=
 =?utf-8?B?ZWdoNUFaR1BXZzJNSWtMWVRCZU5wWFFiaWhZa0E1RlhQb3locm1jWTd3TGhY?=
 =?utf-8?B?eURxOGR4ckVEb1dib2tzWGU5U0hqTEg4MzdiRUpSWUc2ZHl3dW8zVmkxQ0t3?=
 =?utf-8?B?RlVhVEloV0JYR3pUSjc4STBKNi9mTWFQRXMvMFc1UE5rOFZjWlNuZzQwWi9W?=
 =?utf-8?B?MzMzaFpiYWxXcnZtRlJkdUtsajZkdkx1Tm9MazJHRGE1SXRyckg4NGkyZTNX?=
 =?utf-8?B?RW9HY2Z5L25OT09UTjdOSy9tdjdOZXBDeUZCZ3ZZWnU3WXcxYTU2dktJZVBX?=
 =?utf-8?B?eFR5TkNxU2R4L3llckM1TUhacWhGWjVSaCtxZ3Rha3ZZQ0RmaDYzNUI4RENU?=
 =?utf-8?B?a0hwUGhTeW9MTTVISFFlOE4wTFFESWdZbXR5TGJzSjlackVpc0tQYW5KOGlG?=
 =?utf-8?B?N0F0c0xvSTk5dWlnVGl1eWV3Q2ZPaVJ3aTlYY0hsREd3N0NnSUZzVVdBeXlq?=
 =?utf-8?B?TkJnY1c0RGZOM1h5Y2g5Y1dTOTB4d3NmczZBNjdFN3NyT2pqUE9VY0wxSDdR?=
 =?utf-8?B?bWljdGdDR2dLVXhWWXFTOVdvdHN5QVU4bm9JYXQzczF5bmlrbGpIbWFkZVp0?=
 =?utf-8?B?c25NakdwbkVKc2ZESGgvZW5wMWo1UVRTYlh6d0ZDd1FFM29YcEI2eGpibG94?=
 =?utf-8?B?Ym5hMzByMmJCSzR1S3FiZy9BZ2RWb3VPNDhKcUJwQlZnQjFVWnkwK3g5Y0J5?=
 =?utf-8?B?SU9zaVVIcDcySVRHRnl1cFRlejVZVHpvMjgzZlEyWEVJbFNmSmJBVnZxNzlB?=
 =?utf-8?B?eTJHSS9VYzNkOSs0cUJoMHFPUW5LMkJ1ajIrb2VCSDlXNmhTV21LcXZ0ajYx?=
 =?utf-8?B?YXAyUW80TUZFNmRBWks5cUVLRitDSHpiakU4Q1BYTElsbXYvLzNmdUV2RnNX?=
 =?utf-8?B?ZE8zMHM2SXl0b3U4cHUybFQ5ZHFnK0pGZGdFTmFWRCtHVGpqMWZEa0dlUFRD?=
 =?utf-8?B?SWJxTXo3d1RMMkNYY09XNnlBMkZJajBPclJqL3luY25yS1A4VHNONy9yQ2do?=
 =?utf-8?B?UTN3MGFxb1Z6RlVxb1RXN0loblVjRjRkVUdPMkIzTm1Namoyb3BnSk9pL3RN?=
 =?utf-8?B?WVE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5cf5d9-e325-43cc-1e1c-08db928e0a3b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 12:51:36.2659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Dq+sKuOqmgoLNZIboVW3Q212oZavyqGBI4YAR4Ha61+kbZ0VtTlUHzIXNhrI5gR6drwuNHPOvAmkPUO3eMU3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6491
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

Hi Dmitry,

On 2023/7/28 15:15, Dmitry Rokosov wrote:
> [ EXTERNAL EMAIL ]
> 
> Hello Huqiang,
> 
> Thank you for the patch series!
> 
> Please include a cover letter in future patch submissions if possible.
> It will help to better understand the theme of the patch series and
> group all patch sets together in one email thread.

Thank you for your suggestion. In fact, this patch series contains
a cover letter. It may be due to network reasons that it was not
sent to your mailbox correctly :)

...
>>  static int meson_gxbb_wdt_start(struct watchdog_device *wdt_dev)
>>  {
>>       struct meson_gxbb_wdt *data = watchdog_get_drvdata(wdt_dev);
>> @@ -140,8 +143,12 @@ static const struct dev_pm_ops meson_gxbb_wdt_pm_ops = {
>>       SET_SYSTEM_SLEEP_PM_OPS(meson_gxbb_wdt_suspend, meson_gxbb_wdt_resume)
>>  };
>>
>> +static const struct wdt_params gxbb_params = {
>> +     .rst_shift = 21,
> 
> Maybe it's better to declare rst with the BIT() macro already applied,
> and use it in wdt_probe() as is. And name 'rst' without 'shift' is
> looking more brief.

Okay, I will change it in the next version.


Thanks

Best Regards,
Huqiang Qin
