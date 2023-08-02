Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF7876CD3C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbjHBMno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbjHBMng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:43:36 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C645E4;
        Wed,  2 Aug 2023 05:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690980190; x=1722516190;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/bWwSlVLcT3QdcDHUJfSmJKSVt06V/ykSNYG93Wz2wA=;
  b=ktDvAPCwy3Df+O39D+5yDOdvzZjTv3Tf1zwb87gr6VTgS9DjGWhuQ+a8
   6Ji+BFoz8KSuf3wTq3tMkRXeY5gET8fHJEGXPxbCcO2mF0bQBUSf1bBD4
   8NnfLUYGe5xKOW9BaUl51I/YMKsNoevnmSzf6026kxW+WK7dGW3TO8Mob
   CSwjlyRMMiq30RgSb5nP2IyBbXC1hFq7qB1v69Xy/KQB5E1yflG8W9czT
   BKJXJt818FE3QK0BMgdnnVOtQy5Y+jF9ex59ac0TTOWf7MiZbHewwlPtB
   ToLuw2gA6vFrUmCk0EvbVCtprb2a2d054X+sTddEdxXX4runr/npa71Tn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="349172556"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="349172556"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 05:39:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="819204721"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="819204721"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Aug 2023 05:39:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 05:39:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 05:39:33 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 05:39:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJVwiW4yECx+HeSNEVkVLO7yRJ9jQKko3bYxfPonYz0SGvYTRIUbgOL0Z8DqvyQC87NQqCUamjdoDCUpAtf/HfQiG5DamMayQXKyiWgx98GLHNjumGF6eEKgeiy5nkNlRIYxq7R5p3exqvKL+YQ9qgaSUKPX+bwr0y2sjrOdvMc73k3I+JWQq2VzgL26TXwNqdtqde0zz/Yo8OujMs87nz8IPbW7TD10LQUL+lFNG+QeJ1HTcLuGer+CTYLh4dDw4pqjSO2drqSoIxHsxH6GXv+TrPnJEvXoPnfPRkJmctEZKanzhYFd2rJQ/1TikC3kiEUDqywFlpHBugO2JDpW0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKvROnJvxPf5J2zmTEXxq6ayCHKoKJWFkRV+xAhFVL8=;
 b=IsV3xYvU3T97WgpNEroIGneQLiUk5g4RlXZK7S9PH2934Vgkckqtn9jygnJcDj5K90ChahkDidghQ1XiLvfkOS3mNuGEPGvQ7Be/iJfgbrqGki3nMDkW1V9JuKR5agkRzR2rJyxE490Rc+spSl3cM2BzryYXw8/tcsi6KNqngLfXzXDnDt05CcXt+oDD1KxcjfkR+nywsfTstbQMpAdb4gwL2Ar+EjOlXnzdwDl5FqaHq47C4CQVhnFPhOdT/JQQWNhFWHVMzd/ERCTJWwcRFa5/AgqZxz9vmwzKyD5F/CKgyPM7N3pZ8JD2crw6Ss77xvlPXyOE9q43uGufiwu0Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA1PR11MB8447.namprd11.prod.outlook.com (2603:10b6:806:3ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 12:39:31 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 12:39:31 +0000
Message-ID: <29cd58c4-08d3-c03c-7232-15f85878934d@intel.com>
Date:   Wed, 2 Aug 2023 20:39:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] don't use mapcount() to check large folio sharing
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <willy@infradead.org>,
        <vishal.moola@gmail.com>, <wangkefeng.wang@huawei.com>,
        <minchan@kernel.org>, <yuzhao@google.com>, <david@redhat.com>,
        <ryan.roberts@arm.com>, <shy828301@gmail.com>
References: <20230728161356.1784568-1-fengwei.yin@intel.com>
 <20230728102405.7b456eb87fb46042fbce5e4b@linux-foundation.org>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20230728102405.7b456eb87fb46042fbce5e4b@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA1PR11MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b68de2-b220-4c1f-b5aa-08db935584c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SeMUUMbj2RT2czfVDCKinwErLZzvJwBYm5Wj9Dht8LS5Di2ahrOIlfrAPaj+6HEDe9LNG2b4mDUctdTbGsEWqPtkezcbg7C1jKqUSuLjiy5E7ZE6OMnLbRp8b8Z1Plea6RUvKLjBngcedvwfQCUKDHzruQuTB/vRLsh8Bgis/em2n3YailYAXovH258E2iFpAxOSFs/qrAPXJ4AcjIMOwlqv1Bhr+EWRDMVSyM+7NG3wcLGvoLH3LaGcFr4EBvjg34ruyHEOMvZyiur8o+LN3x1ZFrbtxynilaYQWZirR5LNbdJilTV1M4rpr49m/bsKfltrIwmqzXNQZCP3/mefs8rh+bvMWkMmLCPBn6ydA9/hRKxOpzlIBWYMp3rlMvrLV4Pl4BztZpQZczFhYVYBuAnrR6QBw8zXdeK6rUdX4ssgC8oJLSg/LHzNw8peeDRcImX27qV8Mv/btjfpN2Af/eXnVrK45m4Q0UkrD8XQYNCzGHpAj2QX5g0U4bb1oMpEpPszNUCk4iqMbEA1NbMgWlv3SW4cQRrSSLau4kbNg1VsSRJefr3Ji8G2EcdezoMu1bepCm6zoV1Ln1v5IM8UfddNpb7TvTy02jLuh7rHctji8NNdbg5E5b3pKcmySoJe1jomHcsybie5DrF6OG29tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199021)(8936002)(8676002)(4744005)(31686004)(5660300002)(7416002)(316002)(41300700001)(66556008)(4326008)(66946007)(2906002)(66476007)(26005)(6506007)(38100700002)(53546011)(2616005)(110136005)(6512007)(6486002)(86362001)(31696002)(6666004)(82960400001)(36756003)(186003)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STZ4OHd4OTRrbEdqd1Y0K0ZvbGIyc2pReG80S2VWSzN4aC9CTW9WK1BUdlVp?=
 =?utf-8?B?NnRyU0VIU3JlZ0YwakRBdkRsdUcxenVOcHB4eVFQQ3R0ZVVQTG9SZlQzV0Fi?=
 =?utf-8?B?T0dyNTZyTi9kWGg4Q29LTzB1bG1kSTNRbTNKMFFHQmNBOFliMXZ1L3hQSWZJ?=
 =?utf-8?B?b1l5QVVnamV5SVVWdE1RUVBDT2U4cjU4cUlKenpTbkYrRE5GbUdieGlENzlQ?=
 =?utf-8?B?Ti9vaXVkMm9kU2dQQUh0bVZ6Nk15bTZFM0FVTnhDVUJrbEdKUU9NNExGVFox?=
 =?utf-8?B?cVZ0Slo5cFE2TFgraFRQSGNpbCtOMXgwTmp4V0JyVVhaenJsdHFhZ2o3VXRh?=
 =?utf-8?B?b0xzRFdhOVd4K21qYUhET3F0UkUyQWJBM0VBd3R6Z2gwZC9qZCs1ejZOVCtz?=
 =?utf-8?B?dlFTOGNYa2laQzJsY0VkVVIvS0JqdFdsb0V4UHBJL3BtZCtCWnpqb2tNUCt1?=
 =?utf-8?B?V3NTOXNkTWVjM0dwNUNZdFVBRWhkTC9BSG1kdjM1UFE1L1RYcDd4WGtIYjdr?=
 =?utf-8?B?aHlIOEVURXgwV1lFR2d3ZEdpMExyeTM4eWVyRFhQcXN4Zk5pQ1ExSS9RUXZ4?=
 =?utf-8?B?eVB5bVBZZTZ4ZU82aDBLRFRlRTdIK21lM2dkczg3Mi9mWDFzRTROR04rZ1Bq?=
 =?utf-8?B?OS9UZ0xpZ29XRDFKd3BDRVdWRnIvOXBHR3IwdTZyVHRLRUZlSm9mVHFqL28r?=
 =?utf-8?B?WTBWc0hjR25mKzNYNlFzbU8rR2tJTTJwU1lyZ0ZLenFXNFJ6K1I2WkZ6VEpW?=
 =?utf-8?B?M3NucjB2enova1F5TmlaUUpyangrRlRSS3RJTk54OHJHWG5sTVliRnYrUndm?=
 =?utf-8?B?SE8xeEtVellZeXVIWjdyS2tQWjNBVHVEUjRFcmdFWFl4eHVEUExCY3U0SXlr?=
 =?utf-8?B?TEo0Wm5MVWIrZC9lbC9CNm1CZDl2TnNGU2s0MWdldnVyK0NvZXRNYmF0RUtV?=
 =?utf-8?B?YWEwQjlsM1JzaU5PRkNyMjNnNk8weWtnY1F4V1pxaEZ3UTlLcFRwN0wxNCti?=
 =?utf-8?B?WkZPeDByYTR6Y0ZuZWcxejVxVU8raEpheTZqMzZDZUdmeTJkdTQwb2VNbGFn?=
 =?utf-8?B?TlgrTTQyS0JWMi9SMXQ2a1VsblRjSE9TODV2L285akI2RWpIM2FGZXQ4YUlJ?=
 =?utf-8?B?S1d6L2d3VUY2OFRaQm5aa0NqTGNtRC9TekVySXVLbFpPWU1IeFVNZHEvNlhT?=
 =?utf-8?B?bHZEbmdxeDZQYmh3M21ZWkp4eCtXSXJYOHlPbmRmVktac1czYlhJV2ZGYThm?=
 =?utf-8?B?ek90NFUrTFR4cnVNaTFVVWtaTFlRWU9IaU9UNWRDTUpaRXNIeVBHY3NsYUZ3?=
 =?utf-8?B?Q1E5L3BJNnErbXQ5akVmdTJnVmVtUFk5SnZaNnFidXYrdDJHcHVNUWdKbUpj?=
 =?utf-8?B?N2VZT0VJUVdLVjZjNHNsc1duaFNKV25Ibm0zSDUvZ3Jqd3FkMVF1cGJyYWNo?=
 =?utf-8?B?U1ZicGdmMUlWSkpkY3g3eHhEN1paSlZ5azVqUklrUGd4VFQ5V085ejVGMjdK?=
 =?utf-8?B?S0FvRjE4ZjJvSHdOc29vQWVaWklCUjRoQzV4RTJTbnd2T1h3TGRRcFRGUVdN?=
 =?utf-8?B?KzVScU0ySDFjOEpOd0s5WTZXOHUzblhWNDlJQ21sKzlIeEFYN2ppQ2tXTWs5?=
 =?utf-8?B?bU14WVQ3cmluYnc5MFYrTjNMZUhMNnd5akFLMzBiSUtaN0dudFNDbEpZaWJM?=
 =?utf-8?B?Y2ZwZkVWeTJxZ1ZiTFl3dUVPWFdlL1VIMFRKbC9CalJKMlVkVlhoZkdEN2ZJ?=
 =?utf-8?B?TjdHbGc3b01QdmtJNjhMaDY3S0lyK1VWcmV4WEZLWUNEeVp4YXUwVVhvSmNF?=
 =?utf-8?B?Sm1HMkNwbzZCWG1nM1pXVFFWZllYZkZySEw3UkpmYVZsMmh6bWFJNUpoVFhJ?=
 =?utf-8?B?QS82K2d6RVdvdXhiZ0FqR0xWemw3VXAyUVhid0dUQXphcHpBYzVZRnB0azB2?=
 =?utf-8?B?Q0F4RVAwS1lsSXRmR1NWb3RySFFKMmZ2SjZSSWl5QTV5a0lnMHJGTEtHb0p1?=
 =?utf-8?B?WS9MR0t1M2RJQUJOd3ZqNmhrcWhPd3VDNkZsUzVxbWFndit6ZUEzWlJiTWZx?=
 =?utf-8?B?L0xLS2tGaXdoS0phclBldDlUb0Z2cWRaTmRzendzdDB0SStaRnZPNUxvMXYv?=
 =?utf-8?Q?+peP/AEI0fKvj1OnR2l5WOrqq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b68de2-b220-4c1f-b5aa-08db935584c3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 12:39:31.5285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92no3h7vqYNDL7AMgf9bcGrhxiEY7dV8JnwvW6X6AOGOYbxnkoY694x5BiMcAqGkd98eFb92a7B8Ae1GBRWWMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8447
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 7/29/2023 1:24 AM, Andrew Morton wrote:
> On Sat, 29 Jul 2023 00:13:54 +0800 Yin Fengwei <fengwei.yin@intel.com> wrote:
> 
>> In madvise_cold_or_pageout_pte_range() and madvise_free_pte_range(),
>> folio_mapcount() is used to check whether the folio is shared. But it's
>> not correct as folio_mapcount() returns total mapcount of large folio.
>>
>> Use folio_estimated_sharers() here as the estimated number is enough.
> 
> What are the user-visible runtime effects of these changes?
> 
> (and please try to avoid using the same Subject: for different patches)
> 

Can you hold on these patches to mm-unstable? I think we need to wait for
David's work on folio_maybe_mapped_shared() and redo the fix base on that.
Thanks and sorry for the noise.


Regards
Yin, Fengwei
