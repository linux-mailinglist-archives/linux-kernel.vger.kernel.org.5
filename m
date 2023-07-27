Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0EF7646D1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjG0G0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjG0G0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:26:02 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D14F1737;
        Wed, 26 Jul 2023 23:26:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O55bVvdhrInXaWYHWNP1DqiORg2aR0qb5X6aOPaQxSNEThGj7HY8mOiuGs8/TPQ4fkJfAFqAmfNZbk8qIbLb8rH7WIqLLYXZP2M4GZX3ezwV/2OiQJAB8LfYMU+I7ECFkIR5CJVzNnyjngp1Ve+sHKopotCdM9TVB83Da+x+Jd3JeOxg0SL4HiTfIEprNL2A9/w+6yc7OWwch9fyxK990HzWY4TB4XXFG3VchcGKtMcfwvaLzZE9kus/WpFaW3KLx+wUBWRfH/dTxkctQeQF0Zv4RW30+r8w/VbqUrYvb+w8Bo3cD13x8tRErHh3Xyc4LlwinJ2iXH+H1F4rHHiv/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcODz18rhgRatcof0e/BtogCSic7HtNrwH8nFM+OvWA=;
 b=jAyLWj9tcfjeaifVDme4RfazBiVVdMpsNbG2FoKqKRuAf3ie+GHBN56fraMxngAcVdB8xohxyd4/cB8Aw+fiFG6hMUMMvSulgfw/l9s5v5BfmXvgmG/YzL0R1UAWqlAyoxE+gnii9iIbiH4Yaj0jD5+WMVF+GIC8zXOjsLd9C1HUBPcEpbuzSgo7cfZohXQVJj6dit9KcM3oe4aEUSu4qS57jZ9qSx3uheSeHMckZnJq4e1/TKzgB6NDvZF8erOrcxBKFFxxodrjEmi++3MBtR4p8G95cyKyj2Ya0u9dfcmKe2bdpMdhN0By9HAV4Mr2vFuMCgZ74upv7BvoAYqNqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcODz18rhgRatcof0e/BtogCSic7HtNrwH8nFM+OvWA=;
 b=ZVFm0LxPrXsIilFXQuUCftETLC8xMuQr5EQOpu3NJWedjK/Ott5pV1cfUNFLJRBkGWAf+F9vxeQOn7ifovPkr45bMyvBADbaS2hfO8vDJ0rJWfAq6YuZu23yqZWXf464QPKjbKWCYOutKMzLN77QF4G27e+KQsyAav1JpFkndP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by BL1PR12MB5378.namprd12.prod.outlook.com (2603:10b6:208:31d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 06:25:58 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::7790:1431:1e52:44db]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::7790:1431:1e52:44db%5]) with mapi id 15.20.6609.032; Thu, 27 Jul 2023
 06:25:58 +0000
Message-ID: <5ba4efe1-9328-5edc-889b-6e253152cb88@amd.com>
Date:   Thu, 27 Jul 2023 08:25:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 26/61] mmc: sdhci-of-arasan: Convert to platform remove
 callback returning void
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230726040041.26267-1-frank.li@vivo.com>
 <20230726040041.26267-26-frank.li@vivo.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230726040041.26267-26-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::11) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|BL1PR12MB5378:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b9fd13f-f066-4a10-b21e-08db8e6a56e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HwcT0ICqCnz++g6k/24MthN0jqo5vEEu6v+iUKZMzTwa58NqG3Rskwfh8gsE267fOgCgaUoKEJvSIvdOKu9aNZ0T7ThGlNEnUFEwTcxapfRcKME1x68KHSAjEc5Rnjv9ifRwfYYZH9q2XPrKa5WmSKad/paWMmBzV80GO3NqIIkuamq3Q1s/gzGiJKv68qmoL2nm4lgfuP0rhEJAjtXGk6wAn/7hUC7IL9HDmdIs7YibTlRIRA+/hPsDnxjRJaaeKMexFRNtbXvWFyOGEyNobl4oKSB8H0e1+LJuePJfwCIqzv1sDIoezBINwQ1vl/7T/MuYHkoMZYknIcQGhwbpDSuPhnFx4ZbH/Wpi5bcXzL8pxkpjxsLEyct2GOG51CqywtVBzgE2ywqV/kxtre27aOwl+1pKO1XZjHjd3Rs5bLHYAKkhYDO/XI/hSaVgZaKt8soufccizqPg4YGlEe2P6gnJE4RkE2pgIS90pD7WlHzB4ekwK/TcIgpM4z/kb4sG9quvQA3jw89/Zi7JnYwYKl+AUv1+/qbXV88SLKuKFtrm+DKFeybWBJgAvSJVXOgoLVttk20r+nKVtS1DkMDy3hpnwSW6vi4+bg5C7wtCixL9YaHfiqOoFhIDRUCBes3zZcXKrOgMxtHYj+PLY22DPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199021)(8676002)(5660300002)(8936002)(31686004)(2616005)(316002)(53546011)(26005)(6506007)(186003)(86362001)(31696002)(4326008)(110136005)(6486002)(6666004)(66556008)(66476007)(44832011)(6512007)(66946007)(41300700001)(83380400001)(478600001)(36756003)(2906002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y01lSUdqdGZIaXhNK1JCVTlFSXNoRjl2eGVvTllwbXB3aG0vbWxJeis3M3p2?=
 =?utf-8?B?YVE5TlJ2dFRPZGhINGhQK1ZjbHFKSXl6eXF6VUREa3lmb3pobmt5aVVJcFVu?=
 =?utf-8?B?NXQ0NVdZWEtmRGo5Y3dlaXp6MUZTT0ZpOERwTXRhR3RhaU1QNW8zbTYvUGpJ?=
 =?utf-8?B?M1puOVNHZVVBL29rL3BjS2hvV3NWVUV6WWVYR2VPS3JJWHB1VWJJNXBCVUUv?=
 =?utf-8?B?ajg5N3hxTWp6UllCR08rT3dWUUZUNHo0UUtSNktSaElXa0FGajFxT0lhSmov?=
 =?utf-8?B?YTNCbFdOWkp1dllWVFlmdHNiRk9JZjNYSDhxUDFFcWwzTjF3SXkyZ1oyL3l5?=
 =?utf-8?B?SllnNlFYL3djdytBb0tHcVAxa01XL2hsbjZPam5XSWVPR0xEemROeSsrcEgz?=
 =?utf-8?B?OGNLNG9iZGhvZ3FUQmZTVndhbnBORjVSZVNaS1NQZStRM2pVcThqYS9qVkxk?=
 =?utf-8?B?dko4NTk4anBsM2dhc0Z3cFBtVTdkQkJxK0F2ayt2MHpYVTVtOWc1Z3RScUpu?=
 =?utf-8?B?Y0NvVVMrZFgxc216a1hXMXYzbFZuRkhqa1FQWkNTbGpnUWo5bk1uQ2NXOGY5?=
 =?utf-8?B?YmVLV1AxbEFNalNFTzFMQmVYWUFNczVOanJXdTF0NHVlUUxkckg4MmdLNHp2?=
 =?utf-8?B?RWEySW44aWxtczlKV0h4Wk1mUkZ0Ry9xOWpnR3Q0ZEkzS2tkY1dmWXRHVjZh?=
 =?utf-8?B?MTZUZnNwdFpWZ2dyM3U2Wm8xVXF6eDFRWG9nUTVTU3U0N0wybndERFN5NXBU?=
 =?utf-8?B?czNodUxIM3lpS1B2YkVreitTYTVoVGlsdEErZGI5WWpOOWdGdE1tRFN1ZUxZ?=
 =?utf-8?B?STU0MFZpWUM5bzBkSVVNSVZXU0YwN3NET21tNkE5WjlmTVA5Rnl2a2psSkhl?=
 =?utf-8?B?ZzBoaUxyZHlOYndESkx6elRuWk0rdS9oTUh5RDYzbVZHUWRJSzFtdStyRXB0?=
 =?utf-8?B?c2YrUEYyWU1MQnB2Yk1weUpyZ2JlTjNBcE5OMCt2bDZyeFRZQXVFaEVWNzdG?=
 =?utf-8?B?UWZheFAzVGxweXRZWXNJUU8vM3ZNNkFGNE9SWnIvSXhMVWtISXlhQVF3VEh4?=
 =?utf-8?B?Y2M2VFROVG9acU5qeDh4WlErUTNXc1pHQWljZzgwVmUyRy9tRm8wTmQ4QXR6?=
 =?utf-8?B?b29TTW5zSURVd1poSG9qR0lsdGxhWEpDb21jcjFRU2xsK1hrSThUaURsL3Zt?=
 =?utf-8?B?RFFEbW9vWC9rN2pCZWpuUkJpejBPRDBmaWJxNzZJNWJTaXk1ZFlJbE45bm9R?=
 =?utf-8?B?Q3Z5TTh2RFZVZU50TWhEMEMrNHBadWk5YjNSQUVFL3I1KzF4WGwvQnJkS0Nj?=
 =?utf-8?B?OXF5elFzVlZNVEwyVU4xQjI3NUtUQ1JSc0UwVzd4MVJUR20wY2FPYjlialNZ?=
 =?utf-8?B?dzNZRlVmV3crbnR5Yzhhd3g5akRCMmRVNkZmeXFKY0tOczFwZkFkR3NEVkpL?=
 =?utf-8?B?cVcvZy9QUk5kZlpqV2Q2ZDNzWDcwREFjUmFXOEh6UHZ3MkdBYUQySXBEUU1O?=
 =?utf-8?B?UXRtRysweldad3I0MUdiZ2ptM3EzM2V6bUNCdTRSTzdNVHBzbW5LVVhiNFFB?=
 =?utf-8?B?VEl3MDhobkVkeU1EUlFXbXE5TUl3cFpaZERoemFPbWhWNTdqY05qR29JMjFG?=
 =?utf-8?B?NkVVVkRlNmxEYTRPQmNBbTJRV1NWZldkcnhMTXhWSTBsaUFScFpOVlJ2VldG?=
 =?utf-8?B?SVk4WUxUdEZocXhtNmhUamNwQWlUd0ZudHFrYXdBdFFRU21jTnZVdnduT0g3?=
 =?utf-8?B?dE1abVNsaFBtRHc1Z0lYUmFUUGRVUGxESUZPTjg4MmwrUTVxMllCeklSRmd0?=
 =?utf-8?B?T3h6RHI1TDZIdFNoRlZVUUpYLzZORDhsSGdiRkFESDBMMUg5Z2tXNmcyY1N1?=
 =?utf-8?B?RFBsWWFpQ0VFMzZtMkszdENURjhDYW1zVDg5S1VOS1RuK0ZmN3lWTXRteUM2?=
 =?utf-8?B?Q2U3Qm16NGVVS2FoVnRMMkZZZGFtWU50dzdXWkpTN2c1c3J0cnNLZkUxYTdG?=
 =?utf-8?B?NEt6RWs1aklzVHZNdnN1L3FEbHczQ0NsUmhNa0Q0UHNtSmJ6cFE5TmFmQjdQ?=
 =?utf-8?B?OGMzb0VYY3NQVE5Fc2ZsR3psUGcvU3A5UnRSVkpKNG5vcjNzWjhEcHMzVFZx?=
 =?utf-8?Q?nV19iCSw63gac2vF85ByXaEOM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9fd13f-f066-4a10-b21e-08db8e6a56e2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 06:25:58.0808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +t78qe6XE5jii/293Xgmv6BaU41RsoojWeyLcVm1eVMwdEVL3J2QD9CbKpOWKJPX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5378
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/23 06:00, Yangtao Li wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   drivers/mmc/host/sdhci-of-arasan.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 294dd605fd2b..160bab0c437c 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -2016,7 +2016,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>   	return ret;
>   }
>   
> -static int sdhci_arasan_remove(struct platform_device *pdev)
> +static void sdhci_arasan_remove(struct platform_device *pdev)
>   {
>   	struct sdhci_host *host = platform_get_drvdata(pdev);
>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -2034,8 +2034,6 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
>   	sdhci_pltfm_unregister(pdev);
>   
>   	clk_disable_unprepare(clk_ahb);
> -
> -	return 0;
>   }
>   
>   static struct platform_driver sdhci_arasan_driver = {
> @@ -2046,7 +2044,7 @@ static struct platform_driver sdhci_arasan_driver = {
>   		.pm = &sdhci_arasan_dev_pm_ops,
>   	},
>   	.probe = sdhci_arasan_probe,
> -	.remove = sdhci_arasan_remove,
> +	.remove_new = sdhci_arasan_remove,
>   };
>   
>   module_platform_driver(sdhci_arasan_driver);

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
