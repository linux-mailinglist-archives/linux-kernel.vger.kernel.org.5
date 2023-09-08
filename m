Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4D3799168
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 23:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244052AbjIHVLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 17:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjIHVLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 17:11:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D105DC;
        Fri,  8 Sep 2023 14:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694207491; x=1725743491;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PkXtTShPON2qPQyL3LA8sDoL9IE/xPHPemTfxQt3zSw=;
  b=KdkP5uYMWFhGMWQayeIhD+nHXagYYSCfCDRMfh85QKh00fM7wws8LV5F
   me7ByMsSygfx5JWs2LKh9l6oFMqznSlrOn+KVsOd+Ez324rbpcjYbAeOz
   9Xux/Lq0+SjbkduAyCRk2Ar7RibmIbjFAR6eg80mddfcFoKsJY/lH07oj
   ZsBqOlIbndXsGsGgxOGKbdrrUOACw0726IalqIo5LhTadrrHZnCzMnTvp
   +jgGkYSaEjj3/Iql6kHNnmATAxdhEBdswAsZ4gSnNw7v4owfOOUWkf7/A
   a2Lkemc4TTSYLa2QYHGxwjJ2q1MrbE9438FGUrnCiejMfYZvzMjT/zieb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="408727313"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="408727313"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 14:11:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="742641794"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="742641794"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Sep 2023 14:11:27 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 14:11:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 8 Sep 2023 14:11:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 8 Sep 2023 14:11:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoHoN4bqjvzKc7WIM922HT7I7szHOjiBp9wlHkKgE+ICTlIZg6vB25CTjyLFCW+ScTjSs6rRMMZxVUfLwoP8/Bt/SxfovERBYEA62iVA0TnB5lJGK7T38CMs0ZGkpoxTD3rFdwOjlAJ7JbTdrUTtId8X2W8oXNPGqL7ZOkcr4cN+hpyOgzuhG3tnTQg9/4THfA3+6AKH4yPkY0GxBTsNLL9iEtJKpX9w4LpHbDt5o1wp6+lnSO8dQCgRyoJlh85fulhHlwlt8aT1KMRg94j0HCBbsxe++jstf209LdzYix+zjtNcNTyd/U8994VMehV69aY97risW8btiWYX2LfQLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wsV4b1dxknIYzAQSgGih7OU612NiJX3uhvAzCVE0UM=;
 b=IXPj/u3JPogIX0lPYX15G6bRegx3meFeQEa5x5pqQyUG2X3+6KIrQzzfrKpziGU5i1bvr5RfmazntItQsZIKeyPBzHsQexX6auqzuDH8HeI6QM2NvOR2UKctD7l3Hj42qznNGsJRRJJ51vs3UKIInN2oCPluWEVGQyVkPVypbFaeLefpQTdMfceBuSULXcnF5qHcH4uniQ5uYoBIMirah0FSvjCM4E5UmZIipFtUbLGoarXsCCvog2P9Wnl9A7TssXHPEcNC80YR0AIvjGJYrjAsiLmFCCCvHGiCmTbKO4R1L+7qR0RlMa5U5gyHy8N3ggsU1di/iyCyYyZu0YYNMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB7847.namprd11.prod.outlook.com (2603:10b6:930:7c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 21:11:24 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b%6]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 21:11:24 +0000
Message-ID: <c6450b46-72f4-fa7e-e583-0347832f2eff@intel.com>
Date:   Fri, 8 Sep 2023 14:11:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH AUTOSEL 5.4 01/10] devlink: remove reload failed checks in
 params get/set callbacks
To:     Sasha Levin <sashal@kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
CC:     Jiri Pirko <jiri@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <jiri@resnulli.us>,
        <michal.wilczynski@intel.com>, <shayd@nvidia.com>,
        <netdev@vger.kernel.org>
References: <20230908182046.3460968-1-sashal@kernel.org>
Content-Language: en-US
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230908182046.3460968-1-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0009.namprd21.prod.outlook.com
 (2603:10b6:302:1::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY8PR11MB7847:EE_
X-MS-Office365-Filtering-Correlation-Id: 60046157-df42-4801-42fb-08dbb0b02863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ERWzzWN+GG9pBxI5SSdJJvunwv5zNoFPLYtv9r6tP24yWO4jcvRzynA65dKqt9cvzIPaSDONKVmVkC/SNKbQmWn+lThwsLp7Xp1wi+uCJ/6dK9XnHJIqta6Xgvc0pCoAc05SADJbHAVBM9m3wBnythwnpe+dw88NdaxLcvlcfiDSjDD2hjbz/At6TK4D9IhCzhr4z/K8wxPjOG2tMBSops65x2Z7Pm3AwFMaBzuv8mlle86t+qRFoSkkgAqt/fmHknfjQ775lIpEUv2zD3Wk7IKA3JP/LgBK1dXTybySWoFfu6ttvivlWCF9X7z14tRBq7rGu18jxzfWr/0pRjnY7gOPy6XMzIZKmfbN3QPbf6DkSMsYhwBKhBrKBL7h4eiM7+Um5q4Xh3JvF4Ad0u4Gi6AI+96DLbNODfsgrie7m3Q7S25xtR313AZ3d+YQsxDtsXEVstYTnONp/EVan/a5HPE/9eQdXbPUM5D2Kg7Hv0Pd1fFUoi6eZqj70CMH1Sy70MNbtSDEIYM1B1FAg6HLBOgI5HfnVOF5D1ZzN3ZE/sn7ePvqCSBNExenZqJmxT5c9hL/IW+5qGNJE8uuUJkXELq4GO88RDQdyyyH3Eip86Ew9XyDoR7Hn07aHLd1fQjKdkNaaJzkyzmFBHa+6LcYjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(376002)(366004)(1800799009)(186009)(451199024)(53546011)(7416002)(6486002)(6506007)(41300700001)(316002)(36756003)(2906002)(86362001)(478600001)(31696002)(54906003)(66476007)(66556008)(38100700002)(82960400001)(66946007)(6666004)(5660300002)(2616005)(83380400001)(8676002)(8936002)(4326008)(26005)(31686004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnM3V3psUHgwZ0oxQWNKcmdTUi9jdFpGYkxEb0kzMStzRmxJTk1JZkVaL1A3?=
 =?utf-8?B?V2hZdSt6YVVVcUJOVDFqd3o2K2hROGFKT0Nrc084bExKemNEdmtWdHR3UzVm?=
 =?utf-8?B?Q1dZK1QvenRVVXVwNVRDenRwektPY0pMbXkvUXdMbUlTU0dOM2JJaGFaRHNn?=
 =?utf-8?B?MTNKRlZFQ1NrU1I5eU1oZ25RQmVBNnFnSzl0QTNQcWpFU0h5WUpGK0dDenMv?=
 =?utf-8?B?QmRtM0ZyeWMwMzJvaDFQOG9KTTl0aWxjb3ZhU1l1QmZXOSs0bFFxUEpPWHpU?=
 =?utf-8?B?bXhxN3BDbDhJcUhFVnB1eXNDQk92RlVtU0F1a0hFQUNXd2dnaWFsZFMrcDNX?=
 =?utf-8?B?d2UrUW9vQU5DZU0zVjVkMlVWTHJOZFc1SzNNMElFUEloUGZHNXJtZUZzWXZE?=
 =?utf-8?B?T24rWFNNSVpvSmpuMjlMZEluSkd6dDljZm1jcGY4Mm1NZjlQUnN4MFA4MTB4?=
 =?utf-8?B?dkR2TDRVRjlLUWZMVEJrdnZmMThrdHVodWQrSlh3WGVpZmVObVBYRVFVVDJ5?=
 =?utf-8?B?NVlsWTlDY3VPU3pIQk9lQU9hVjc4QmhTcy9qdHVIYk9JVXE1K1Npa0UydkxJ?=
 =?utf-8?B?TGo0STFwMDJxbGMvaUtSY3BsQm03eDRqWGxsM0ppUzI3YS9iSDZlaFdxdlU3?=
 =?utf-8?B?RWxTOWdUUmlPWGJQUzJlY2h1anpDVWZwd3dVSzg1TzMveUEwY2ZiRkRGbjlB?=
 =?utf-8?B?dk9uUWtDbkdrNzJuSmVEMS81S2luQ2xScUxLTVRSRzVSRUVZdGxGOFJpYXE3?=
 =?utf-8?B?NXhwUnJWdnZoWkc1dUFCaXEzYmJLVnZJbzgzSWlJeWtyK0VLcFVYS3Q5UDhX?=
 =?utf-8?B?MVZoRGxmK05mVi9sazBRSXB0U012Y2NER3lKZ1h6M1ZFYW9IS1BkemV0eEtD?=
 =?utf-8?B?MkdpSC9xZXgyRFZqK0g4Sk5kVjdBUmhTUEtzTmd0RzBrK05EMFNpYnVuQlI4?=
 =?utf-8?B?Rk5obkJ2bWREOGQrQVI0Q2lYcFdoWlBEZUlSVy8zZ0pTcmxTalBVOWdPWmVY?=
 =?utf-8?B?b29LNlZmWEVhek9GU0NsckxPSmYvVVBrQ0pyM05TT3E1aWh2Rk5TYnM2NWxU?=
 =?utf-8?B?R0dsc2x5RzBGOTF4bUgyZFZVWjgzcGFRc1dwekV1bVRUNlFKVERUZUE5WjhS?=
 =?utf-8?B?M3JXS3hpR2JWSG1wTkxvUWtGVjNCa2thd1N0VmNEYVpHNG1qU05IZTRZbDU3?=
 =?utf-8?B?TkpKakxSZnNnSkI1SFo1cy9CdEZrbUVCVU0zZS9KZFFocGQwd2R2a0pCS3RC?=
 =?utf-8?B?WHg4bXBsVTlLNEU0MGJmYzRWM0hTQ0sxeDF0SFI4bDd2UnFyTnVxUGZCenRE?=
 =?utf-8?B?MG9lMTE0WllBemlBK0xpdXQ0UlhZR0RyUzllZkVZaW1RUndWVU5QZ29OYmdN?=
 =?utf-8?B?bVY1aFZtR3ZKVjBsVDlQdUVXZ0M0UmxPSFJPUWlsWHoyTUlZSkdnTTZkWWFz?=
 =?utf-8?B?bVlyZ0xweUttS3QveHFJd0xieEpkOGc4NkcvdGNZeGh1TGZwTHNweXZHaG9L?=
 =?utf-8?B?ZFpYY2tXZ3lqQWpvMytUSDhCN1RaZUVCUnBOS1YwQ2JvOUFnVFJFK3NoSVJk?=
 =?utf-8?B?dk1ncE9KNUVFZUpPZzBObWthMkNtaldRSHNxSHFVSTM0R05UNFNRd2hvREV2?=
 =?utf-8?B?bDBzc0RudHpxRklTMjFBdFd3YzJiZGZLeC9mZGRZTXhleXdKcllVU1doS2x6?=
 =?utf-8?B?NFpITFQ2TVB3YTRibUx0TWRRYlk5MmowYk15Y21UdTA0NUxmNEE2VDljbzUr?=
 =?utf-8?B?OXE4ZGZmZmxUZkpaVWJWUVdRKy95K1Z1dkdVa0t5QWRNVjRzdHNHMURqa1Va?=
 =?utf-8?B?QmU0dldPRjl4VStNaEVHYS9MZlJ1cmx6L1VtdFlJaUVBSDhCRkk0NWZzbTYv?=
 =?utf-8?B?eHdtaGphcGpqbkJiVlVpWDlqc01uUmljY2QwVVdkU3RDR2I0eXR5NHBVQmF4?=
 =?utf-8?B?MkxUVnNzbkNtUjVkK2NMa1VudlJFNUdHVnZabWVKNkRKSzl5Q1ZwSDNjcCt0?=
 =?utf-8?B?NEdMbmlJaFFYTVVMdEk1ZHA3aUlFZGxuNnErOXZVTjE3ZjVmOG1vR1ZqQ2JD?=
 =?utf-8?B?Y0h6UHBYalRCeWxaMTRrTHhvVmFka2trRU5RTStVYm8zQ29POG9JTE5zcHY4?=
 =?utf-8?B?QVh3NVg0dkF3NWJzMC9ER3NmOXh2bEtpSEFvYzc0NUZhWnI0SDdtYTlOL1BL?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60046157-df42-4801-42fb-08dbb0b02863
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 21:11:24.2578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBAI7+8L7ZZeYNJvqKUNuAACZk2ujJQHFxE1Pc7nLeortn54GiQNu5t0FL1MjPlStQXdmFoZmORvXpejRg6jWShRVJVmp5ivbvagWQvFyqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7847
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/2023 11:20 AM, Sasha Levin wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> [ Upstream commit 633d76ad01ad0321a1ace3e5cc4fed06753d7ac4 ]
> 
> The checks in question were introduced by:
> commit 6b4db2e528f6 ("devlink: Fix use-after-free after a failed reload").
> That fixed an issue of reload with mlxsw driver.
> 
> Back then, that was a valid fix, because there was a limitation
> in place that prevented drivers from registering/unregistering params
> when devlink instance was registered.
> 
> It was possible to do the fix differently by changing drivers to
> register/unregister params in appropriate places making sure the ops
> operate only on memory which is allocated and initialized. But that,
> as a dependency, would require to remove the limitation mentioned above.
> 
> Eventually, this limitation was lifted by:
> commit 1d18bb1a4ddd ("devlink: allow registering parameters after the instance")
> 
> Also, the alternative fix (which also fixed another issue) was done by:
> commit 74cbc3c03c82 ("mlxsw: spectrum_acl_tcam: Move devlink param to TCAM code").
> 
> Therefore, the checks are no longer relevant. Each driver should make
> sure to have the params registered only when the memory the ops
> are working with is allocated and initialized.
> 
> So remove the checks.
> 


Hmmmm. Based on the description above this feels a bit odd to backport.
Are we sure that its safe to remove this limitation on older kernels?

Both mentioned commits are in v6.3 so they're not in any of the stable
trees by default.

Indeed grep over stable/linux-5.4.y shows nothing for either commit.

Thus, I am not convinced this is safe to backport. I didn't double check
every single stable branch but given that the mentioned dependencies are
in 6.3 and don't appear to have been fixes, it seems problematic for all
including 5.4, 5.10, 5.15, and 6.1. No driver in those trees is going to
be registering parameters early so I don't see the benefit of the patch.

Thus, it is my view this shouldn't be backported, at least not without
porting the relevant dependencies as well.

Thanks,
Jake

> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  net/core/devlink.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/devlink.c b/net/core/devlink.c
> index b4dabe5d89f72..5bd6330ab4275 100644
> --- a/net/core/devlink.c
> +++ b/net/core/devlink.c
> @@ -2953,7 +2953,7 @@ static int devlink_param_get(struct devlink *devlink,
>  			     const struct devlink_param *param,
>  			     struct devlink_param_gset_ctx *ctx)
>  {
> -	if (!param->get || devlink->reload_failed)
> +	if (!param->get)
>  		return -EOPNOTSUPP;
>  	return param->get(devlink, param->id, ctx);
>  }
> @@ -2962,7 +2962,7 @@ static int devlink_param_set(struct devlink *devlink,
>  			     const struct devlink_param *param,
>  			     struct devlink_param_gset_ctx *ctx)
>  {
> -	if (!param->set || devlink->reload_failed)
> +	if (!param->set)
>  		return -EOPNOTSUPP;
>  	return param->set(devlink, param->id, ctx);
>  }
