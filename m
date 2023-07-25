Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF6D760CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjGYIN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjGYINX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:13:23 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2105.outbound.protection.outlook.com [40.107.215.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE719E77;
        Tue, 25 Jul 2023 01:13:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4vr8Jee4s/dyUWHNlRXpO3i2rd1LD6Igjk4ZLODPGdHG9SIb1aFP0GMd8PlpsD5QEuEzj3BjNS6jw1X/Jsy80BAHZAb+yfgbL9PXoF4hkIJ4UHHH8eH7Y69vzA43U9gu4NTXosAbYhVPyFJmbZkTSrDy+dHXqHBL1M2lsw/JEQ9EQzbM/MKVBvhXdiu+szlzB3NX+YP+DOHk9wWLUCGknael/+24UwJB7cILuYZtRfKTkcJZRHF9VUOcRPfDvJBEeJItUUXEevAQ6P0/Jo9+ktKm3d3YILtpiMraBypZTLHxDPIGePb42oCNgmkRHR9Pqk6o75Sw9ONSgTLbWcvpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xWpJauSvXDGcA8kQ8aRNRst9rmNVSU5ROhMU8ha178=;
 b=lNAv9CE2v/BwncoXJPPydRfNqyGjIuogzVjdxTHdjqG0XNoQE0/HWYJIv8jfroFSC0Axdl8qWfOfQXcLFejkGpczXD6YRARU8IcCu6wyiuRV8PHWGsG8gbiIWhIK6B8KTUDLTjNQbKQw0J5Oi2BpNjZwwzrVMhnGIAxOvSTAEDciKQVMnw9QW0CHnuKxMu1JmIiSuoDZGUu8+JTZjXoevFRU0KNheM/sPptqP70GWeWfVO0iwF97BxG0CcalUq0Yid3gB6spM6Cd6W9H8wUfGqSz4mKvuAonYr88XLjR6uFCVyUzYKmcsYVQ1UjWMDQVjgUF0IG9j55bSq9OEDCXeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xWpJauSvXDGcA8kQ8aRNRst9rmNVSU5ROhMU8ha178=;
 b=oWnI6Qn0L7Id2lBgcLBot7uA7/3L/Ar2+swcKEEQHj6QB5/VrYDVR9TydawPV9ywfyDTjSG3tXYRMdmkWGiqTXnTSPynZmToRQsU0Cnfg+rqrlaWIsfpo6xJVTuUkvuXHOjrtiRmFmsV/d04jUPlgKbLug2zEJ+duWAlhGtg+1AEQxqZl/sjHkpddvK352YzqOBrfzkzqij+jZFZ2LweiQv0AYliM/W4+gXzEqfX4JN/MH4cZz066chf2Ja6GojCSKrv/SxiTzoz6jCNtJDDoplF40t+KsEpQFhqQ+jHxpMzjjLvhOBwlTchYVsYW+EDf5/70O8YSoVUUn3cyYj/gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6228.apcprd06.prod.outlook.com (2603:1096:101:c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 08:13:09 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6609.031; Tue, 25 Jul 2023
 08:13:08 +0000
Message-ID: <9269d1ae-0dc4-e633-082e-ccd75efd103f@vivo.com>
Date:   Tue, 25 Jul 2023 16:13:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 58/58] mmc: Convert to platform remove callback returning
 void
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230713080807.69999-1-frank.li@vivo.com>
 <20230713080807.69999-58-frank.li@vivo.com>
 <5d120109-cbec-f086-c442-f3bd3fd1ebe7@intel.com>
From:   Yangtao Li <frank.li@vivo.com>
In-Reply-To: <5d120109-cbec-f086-c442-f3bd3fd1ebe7@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3e385c-a5bd-45c8-a7d5-08db8ce6fad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IigDUcKR4TZvzdwru5v8Fh5A6k4YGeJjDWWmj8cQXkTAKvnWed1Ox6fJP71SxqmMG6l+9+dvOf1v7FzXwKnfvu8Tnid6Q3jdKJ/wuuGHSRwuh1q81E2w/7mSsrZOXAeoFqeH9Yu+fZDp5/Q/LPQyS62YM3l3j+4bQOwqsSqQmZXN3CV0MrdCpov34pVA1iEkuTztbP9KS2NVxBoMbMjJ0tKtI0lF+PPzFQDCi6vFPfhcDkqWyGwUtx9/T8nr2hvQbq/QCb1qto9rYQkVRlrwS46KkwilAO9BaCZZNcUKPzEbiV0I2BvJHPX6IlhbzSEd6fMAjJkfD7OqA8zbTvCYeEEkXuJapMTUx+r6mP7BoHjqCzRZcuAh8+GDDDs4IDoXA05qWMi37j/GDGKRaJYZzA+/77UVRmCJL3uBKxQGqwO3d+dRhO8Qx8jNLuBFLNZzo5Ae4ASZ2EgnSJiZCfnNtXloidqwMn48K6Ppyap7vd8oPyYfTyqEkmvj0Jim1+NTe76J7tNDNapQKymsESQGkbFuY5FIJRWWTDdHBQhfC+ACDg4gXsSiEKKXijBZ87SiBSrZ9FLSb0riWFYGQIyZKXuZdRUCFHVWyIKUiP66uozf3GbDfw+tb3x2LBrG6nBlC8C0zW+xEfypP27n9MijKDF2u2vt9NMFI69441RD7QMSpRLVF+46dpBYugh5D9Ai
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199021)(26005)(186003)(6506007)(53546011)(2616005)(83380400001)(4326008)(316002)(66946007)(66476007)(66556008)(8936002)(7416002)(6666004)(5660300002)(8676002)(41300700001)(966005)(6512007)(6486002)(52116002)(2906002)(478600001)(110136005)(38100700002)(38350700002)(921005)(36756003)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW0weHNQQjhNY3RKeDZheTNobVBhM2drZnFZalk2QzFUem81OUtVUVBFZFlp?=
 =?utf-8?B?REVvOVI2Ui9WL0RBUS85S0Z0UnZkeXF1QUdNaENmWG1WTStNcURieFFoK21B?=
 =?utf-8?B?N0g3TFRtSzdnZElwN0EzRU8wRUtIejF3M0tka2Q0blN3aVdUdVJOR053ZUxI?=
 =?utf-8?B?dzVleVlnaDVmaHBZQlNqVzczMFdnWW5NUHBOa2FFNlpMSkxJNlAycTRzdk5O?=
 =?utf-8?B?TXJaQXFTaFdvaCtnWGJzRitoVURkVVhGdjlvbHJ3aUZid0hNZGRIRitIVThj?=
 =?utf-8?B?UTFzQmJVZGNTZ0lFSk1XTHpVa1hWL1pRRThkdGZsc2E3WHR1KzBWU0xEc2dy?=
 =?utf-8?B?a1ZjMklUTXpBcm95MnV0Q2VsV3hzbGpPcmJLQ05UK1oxS05mSUtaVUVtTGFB?=
 =?utf-8?B?ckRYdWIwVTFNNTJXK0JtWGxHa3UwZUhqTm10b0MwU1BoUzFGSzRDblpFSVAw?=
 =?utf-8?B?Q1FwUVF3a1d6VXEvRlFUWmxNbUR2M1FWRlp6ZzFza3FEc0F1VzQyWEk2bzZj?=
 =?utf-8?B?RW8vSUNOQ3Q0dWVnZm9EdCt3RkNLL0xheVpSUjViakZ3bEtsQlZ6WWhlR1RM?=
 =?utf-8?B?ZG8yVVhsVytVcXo1UUwxSGNHOGIyL252citRVHZHOXMxMDlNTktzWUtlblgy?=
 =?utf-8?B?b2Y2aHRFbnpxeUNRV08xdmR4a2huY1Zremg1TnkzYkExbjU0SGRCbE1YcktS?=
 =?utf-8?B?TjhBNW9pc3lTMXgxeUFKM3gwdnhQalBRS1JybHNxZG90Q3hqQUsrRU5aTEZP?=
 =?utf-8?B?bUIzSGEwR0xPRHdPUktqTlIwV0xGbkw2elRWc2lpMkZSeEZMMHBxSzdDUWVS?=
 =?utf-8?B?VE5MNmgzYVJNdDY4Q0Z1NktzVkZidk5lcUtlZ1IzSFNHVDY0azg4bkdEc2pX?=
 =?utf-8?B?Y2pBWEFGQ3hRTnRkamxtS1VCeGRvOHh4Rk9BWGY5UkVwR0F6VkNVMERQOFZ4?=
 =?utf-8?B?V1NwQlZjL05nSFFDRk5uOThJRFNOd0pnQXV2V2FhTEtDaXhITWFOZCtuMHhN?=
 =?utf-8?B?ZmZYNTJJTFFiYS84TzhpdlFISkQ4NithTURZUFp3L051d2ZpcDZRSk5vNlhh?=
 =?utf-8?B?aXRqbmRaOFUzVTVGVDgvM2g4eGJvYTNLZldZL1d2STJSbzZ0OW56V1pQL2pq?=
 =?utf-8?B?MTRUa0E0elV6Y2xNU1d6Q05zNXBQbHE4YW1BVzFOVlErd1ExZFRRY3h5U0dT?=
 =?utf-8?B?dlR0d3p3ZFdDcFpjY1ZCdDUvVzNpMlpBZ0dVdXZrakF0K3NwRVdMTUhrSnIz?=
 =?utf-8?B?Um1xR1VXTExhSjRzL1U2a2N6QjFnUDNYQUVVWHRvU1hCSDhtYU1LTDd4TWhz?=
 =?utf-8?B?cC9mWUdnM3JTYVFqdXZBaHJONGF6NFZGdFBUWkpTOVZHN3dQVXVubkgwT0ly?=
 =?utf-8?B?MmVUckJoTGJTVDBMQkFkM3I4Tm43REdyRTNITVNlQy9Kb0ZXaThNdGRrd3NO?=
 =?utf-8?B?VXhXVEUybTFsQnNnVDN3dXovblFqR2E1bWc1WkNwamVZam5pdFZkaXo0MGFO?=
 =?utf-8?B?bDBUZDh4cjN2VXpMS0JJQzB0TnRFZEZsVkRmZURYY3lBTXh1bWFZQllJeWFu?=
 =?utf-8?B?LzhMUEI2cUd1aCszNDM3ajFHdUFSdnNDZVNJbGtlL0grVXJRWFlUbkZRN3Q3?=
 =?utf-8?B?cG1RRjVGMmg1b1BpejRDemw4V2VxL2NWQnN1VDErQy9iQ2VCcUpJWnJQMDQ0?=
 =?utf-8?B?aUZSVmFxeE5XV1MzYXhKalFjWEZVVEdVbUk0MTRQSHhTMFh6bytxV3NKZG9x?=
 =?utf-8?B?amhKSVp5ODF5UmVvVVFxRGxOV21iUlluWTRsSVJrMkI0SlFmdU5VZjNab3JX?=
 =?utf-8?B?ald2cE9KZkNsdWg0NUswL2lNTEtmN0d2UGZKZk9kWlVYc3o1c1BxaUVWVWdt?=
 =?utf-8?B?ODU4L2ttMi9KczY4MXRSN0hsNmU3a2RnMnRmd3ptMWdDUUIrZlllYkdwRU1T?=
 =?utf-8?B?QU5tN1dET21hcFhFYTlzbmhOZWZQRHpUR0FJSVF1aTY4ZU1EVVdLcjNWYlJm?=
 =?utf-8?B?Uy84RWJjbnNoREdCQVFiVVVqK09tY1VPUjhFWHFxNS9mSXNHcXJMWnpSanFY?=
 =?utf-8?B?bXFGWjZNMkJFR2hRdzdiWDVGSExoYWFsaWErcDZVTE5VTjdEMU9QeHpJZHZn?=
 =?utf-8?Q?+wZj9YbKLqY6CMZk/q5XTz2As?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3e385c-a5bd-45c8-a7d5-08db8ce6fad1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 08:13:08.4340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/NfEQa9laDq696YceOYWTeaZjaoM8NPExIMbzJ6AqwXnf9+GSPXfLV6xMacMut1xzvcHg3qYb7rgP980O1Onw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6228
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adria,

On 2023/7/14 15:49, Adrian Hunter wrote:
> On 13/07/23 11:08, Yangtao Li wrote:
>> The .remove() callback for a platform driver returns an int which makes
>> many driver authors wrongly assume it's possible to do error handling by
>> returning an error code. However the value returned is (mostly) ignored
>> and this typically results in resource leaks. To improve here there is a
>> quest to make the remove callback return void. In the first step of this
>> quest all drivers are converted to .remove_new() which already returns
>> void.
>>
>> Trivially convert this driver from always returning zero in the remove
>> callback to the void returning variant.
>>
>> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>> ---
>>   drivers/mmc/host/sdhci-bcm-kona.c  | 2 +-
>>   drivers/mmc/host/sdhci-brcmstb.c   | 2 +-
>>   drivers/mmc/host/sdhci-cadence.c   | 2 +-
>>   drivers/mmc/host/sdhci-dove.c      | 2 +-
>>   drivers/mmc/host/sdhci-iproc.c     | 2 +-
>>   drivers/mmc/host/sdhci-of-esdhc.c  | 2 +-
>>   drivers/mmc/host/sdhci-of-hlwd.c   | 2 +-
>>   drivers/mmc/host/sdhci-of-sparx5.c | 2 +-
>>   drivers/mmc/host/sdhci-pltfm.c     | 4 +---
>>   drivers/mmc/host/sdhci-pltfm.h     | 2 +-
>>   drivers/mmc/host/sdhci-pxav2.c     | 2 +-
> Looks like drivers/mmc/host/sdhci-npcm.c was missed


Neither [1] nor [2] can find this driver, what am I missing?

[1]

https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/tree/drivers/mmc/host?h=next

[2]

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mmc/host


Thx,

Yangtao


>
>>   11 files changed, 11 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
>> index 6a93a54fe067..2e3736603853 100644
>> --- a/drivers/mmc/host/sdhci-bcm-kona.c
>> +++ b/drivers/mmc/host/sdhci-bcm-kona.c
>> @@ -319,7 +319,7 @@ static struct platform_driver sdhci_bcm_kona_driver = {
>>   		.of_match_table = sdhci_bcm_kona_of_match,
>>   	},
>>   	.probe		= sdhci_bcm_kona_probe,
>> -	.remove		= sdhci_pltfm_unregister,
>> +	.remove_new	= sdhci_pltfm_unregister,
>>   };
>>   module_platform_driver(sdhci_bcm_kona_driver);
>>   
>> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
>> index 4c22337199cf..a2b6d8f2eeb6 100644
>> --- a/drivers/mmc/host/sdhci-brcmstb.c
>> +++ b/drivers/mmc/host/sdhci-brcmstb.c
>> @@ -430,7 +430,7 @@ static struct platform_driver sdhci_brcmstb_driver = {
>>   		.of_match_table = of_match_ptr(sdhci_brcm_of_match),
>>   	},
>>   	.probe		= sdhci_brcmstb_probe,
>> -	.remove		= sdhci_pltfm_unregister,
>> +	.remove_new	= sdhci_pltfm_unregister,
>>   	.shutdown	= sdhci_brcmstb_shutdown,
>>   };
>>   
>> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
>> index d2f625054689..1702a499b36a 100644
>> --- a/drivers/mmc/host/sdhci-cadence.c
>> +++ b/drivers/mmc/host/sdhci-cadence.c
>> @@ -617,7 +617,7 @@ static struct platform_driver sdhci_cdns_driver = {
>>   		.of_match_table = sdhci_cdns_match,
>>   	},
>>   	.probe = sdhci_cdns_probe,
>> -	.remove = sdhci_pltfm_unregister,
>> +	.remove_new = sdhci_pltfm_unregister,
>>   };
>>   module_platform_driver(sdhci_cdns_driver);
>>   
>> diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
>> index 5e5bf82e5976..75335dbf223c 100644
>> --- a/drivers/mmc/host/sdhci-dove.c
>> +++ b/drivers/mmc/host/sdhci-dove.c
>> @@ -110,7 +110,7 @@ static struct platform_driver sdhci_dove_driver = {
>>   		.of_match_table = sdhci_dove_of_match_table,
>>   	},
>>   	.probe		= sdhci_dove_probe,
>> -	.remove		= sdhci_pltfm_unregister,
>> +	.remove_new	= sdhci_pltfm_unregister,
>>   };
>>   
>>   module_platform_driver(sdhci_dove_driver);
>> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
>> index 86eb0045515e..0dbebcecd8fc 100644
>> --- a/drivers/mmc/host/sdhci-iproc.c
>> +++ b/drivers/mmc/host/sdhci-iproc.c
>> @@ -432,7 +432,7 @@ static struct platform_driver sdhci_iproc_driver = {
>>   		.pm = &sdhci_pltfm_pmops,
>>   	},
>>   	.probe = sdhci_iproc_probe,
>> -	.remove = sdhci_pltfm_unregister,
>> +	.remove_new = sdhci_pltfm_unregister,
>>   	.shutdown = sdhci_iproc_shutdown,
>>   };
>>   module_platform_driver(sdhci_iproc_driver);
>> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
>> index 48ca1cf15b19..5072b59f6165 100644
>> --- a/drivers/mmc/host/sdhci-of-esdhc.c
>> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
>> @@ -1521,7 +1521,7 @@ static struct platform_driver sdhci_esdhc_driver = {
>>   		.pm = &esdhc_of_dev_pm_ops,
>>   	},
>>   	.probe = sdhci_esdhc_probe,
>> -	.remove = sdhci_pltfm_unregister,
>> +	.remove_new = sdhci_pltfm_unregister,
>>   };
>>   
>>   module_platform_driver(sdhci_esdhc_driver);
>> diff --git a/drivers/mmc/host/sdhci-of-hlwd.c b/drivers/mmc/host/sdhci-of-hlwd.c
>> index 12675797b296..cba3ba48e9dc 100644
>> --- a/drivers/mmc/host/sdhci-of-hlwd.c
>> +++ b/drivers/mmc/host/sdhci-of-hlwd.c
>> @@ -85,7 +85,7 @@ static struct platform_driver sdhci_hlwd_driver = {
>>   		.pm = &sdhci_pltfm_pmops,
>>   	},
>>   	.probe = sdhci_hlwd_probe,
>> -	.remove = sdhci_pltfm_unregister,
>> +	.remove_new = sdhci_pltfm_unregister,
>>   };
>>   
>>   module_platform_driver(sdhci_hlwd_driver);
>> diff --git a/drivers/mmc/host/sdhci-of-sparx5.c b/drivers/mmc/host/sdhci-of-sparx5.c
>> index 28e4ee69e100..26aaab068e00 100644
>> --- a/drivers/mmc/host/sdhci-of-sparx5.c
>> +++ b/drivers/mmc/host/sdhci-of-sparx5.c
>> @@ -260,7 +260,7 @@ static struct platform_driver sdhci_sparx5_driver = {
>>   		.pm = &sdhci_pltfm_pmops,
>>   	},
>>   	.probe = sdhci_sparx5_probe,
>> -	.remove = sdhci_pltfm_unregister,
>> +	.remove_new = sdhci_pltfm_unregister,
>>   };
>>   
>>   module_platform_driver(sdhci_sparx5_driver);
>> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
>> index 673e750a8490..72d07b49b0a3 100644
>> --- a/drivers/mmc/host/sdhci-pltfm.c
>> +++ b/drivers/mmc/host/sdhci-pltfm.c
>> @@ -187,7 +187,7 @@ int sdhci_pltfm_register(struct platform_device *pdev,
>>   }
>>   EXPORT_SYMBOL_GPL(sdhci_pltfm_register);
>>   
>> -int sdhci_pltfm_unregister(struct platform_device *pdev)
>> +void sdhci_pltfm_unregister(struct platform_device *pdev)
>>   {
>>   	struct sdhci_host *host = platform_get_drvdata(pdev);
>>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> @@ -196,8 +196,6 @@ int sdhci_pltfm_unregister(struct platform_device *pdev)
>>   	sdhci_remove_host(host, dead);
>>   	clk_disable_unprepare(pltfm_host->clk);
>>   	sdhci_pltfm_free(pdev);
>> -
>> -	return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(sdhci_pltfm_unregister);
>>   
>> diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
>> index 9bd717ff784b..6e6a443dafd9 100644
>> --- a/drivers/mmc/host/sdhci-pltfm.h
>> +++ b/drivers/mmc/host/sdhci-pltfm.h
>> @@ -102,7 +102,7 @@ extern void sdhci_pltfm_free(struct platform_device *pdev);
>>   extern int sdhci_pltfm_register(struct platform_device *pdev,
>>   				const struct sdhci_pltfm_data *pdata,
>>   				size_t priv_size);
>> -extern int sdhci_pltfm_unregister(struct platform_device *pdev);
>> +extern void sdhci_pltfm_unregister(struct platform_device *pdev);
>>   
>>   extern unsigned int sdhci_pltfm_clk_get_max_clock(struct sdhci_host *host);
>>   
>> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
>> index 91aca8f8d6ef..1c1e763ce209 100644
>> --- a/drivers/mmc/host/sdhci-pxav2.c
>> +++ b/drivers/mmc/host/sdhci-pxav2.c
>> @@ -359,7 +359,7 @@ static struct platform_driver sdhci_pxav2_driver = {
>>   		.pm	= &sdhci_pltfm_pmops,
>>   	},
>>   	.probe		= sdhci_pxav2_probe,
>> -	.remove		= sdhci_pltfm_unregister,
>> +	.remove_new	= sdhci_pltfm_unregister,
>>   };
>>   
>>   module_platform_driver(sdhci_pxav2_driver);
