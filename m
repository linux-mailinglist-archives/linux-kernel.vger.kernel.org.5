Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4DC8098B1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572883AbjLHBmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbjLHBme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:42:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F70F1720
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701999761; x=1733535761;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ma+5YJEoIWsnr0xMvNDZkAo3WW1PArvrhqgCyGDsLKM=;
  b=ilBG/74B4aKMIoD5/Zpxmti0AXuFHTOz0KUzIVPruE2OiMpQ9XIlZ6Mj
   OWxBQh71lowIttQM596zaz8O3dq0cHz1fOTO5Byevdp1BbuKRPjyvPW8W
   2K1O2s+Jhs+Nb+se7qbkTKbm+HUXXvlyxPS7m4816PV7a8FpKDC24aTLJ
   5eAD2g50RjVmc0bzmetMwUN1w58bhkYIzMjehzl+76dhKVqvWoqm4h3lt
   3c846uxnxGljs3MNFG6OwUIgo4pk56XzuSZOKdjjuxSVvfOamlP4euuvb
   yY7YdHVFDMwWNSvq+WIYROxG/1cjfpSamhuy2Fntb58ut3RZmmp7/d4L5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1223658"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="1223658"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 17:42:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="842427113"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="842427113"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 17:42:40 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 17:42:40 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 17:42:40 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 17:42:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0HUcOJddY68CpdWzPC9VgnolEX4ldWiYjEeXMVDrk9Y/sBg4S6mXMIDbI24MlVp76kOgKlGMpOWKjWgVwLdbWp5rirmSCq9zy7Y8p/ZNjz7oIbxpnEJSjbWRpuQegy5xjY/p87iLUTRSSoXbE2juwcPDRoxgx1sX7nZonv7hAWRB2aSH3jhj2R+lthCrMxgD0cULXwGKN7hRoIx0+Mc3KRY51JfQH3PJ2aX1iBrhU7KOuzEc9CPZOWV/GLn56Ls4Aq6etSM3uQDSAkymjt/4tdsHDhB1KSQUtduNx1Hsoof3ZQ0bqWBdwr+jSmDbbm1hebutRzP0ldlUOm4VKhugg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQ0POXozeNSjEcKE82ZHxwwR7lTImO5+YPPLHUlz05U=;
 b=mm4xdg0ckj823EPoPNFLTE0M1nRmmQeQ3096a8aeYI124FdeqH7PgTSNZUyLOOsmxL72UfoxYODP3v6Pc/PWe3AOmU38WFpWyN/ihGJ+4MIZlvmsQlIXZ4K4aRt8H2oUxWIAc9cZDc0bzbuPumy3uPcYz7rToxGsPdIiDJ1kcdZcSLrLYaw2ZMPWSrd+Z/OXVlxcIN+ufyA4EBzfPoHqsOvk5GIJK3pi2hP4Xo3e3EuYTtnug4tz1LB5NmM2gDk6tgamZjdUeTHuCFHpDqNcyqs3DB1l4Puqules7E2VaEKegvHBQIKif7hf91injbUpTPmGHJlka4WzV9YpteUfNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH7PR11MB8504.namprd11.prod.outlook.com (2603:10b6:510:2fe::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Fri, 8 Dec
 2023 01:42:33 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 01:42:33 +0000
Message-ID: <9dd3769e-2ca8-4fbd-8e1f-5aa304cdf442@intel.com>
Date:   Fri, 8 Dec 2023 09:42:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 11/39] mm/userfaultfd: page_add_file_rmap() ->
 folio_add_file_rmap_pte()
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Ryan Roberts" <ryan.roberts@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
 <20231204142146.91437-12-david@redhat.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20231204142146.91437-12-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH7PR11MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: e1622334-bab0-4e2f-896c-08dbf78ef2d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ONByXkrQbHfA4Fi13O+6L5C5LBR/i8DXt1uFXB4qj5pN0v1NyId8CJOrGz9rRZpLvbJCvOXo1Qjq0K6FFAoPwwRyBnKYqrn4asRpC/+wkoUaU8sYIJNfTrpn0mjScPL9tXU+9T3uJeNIzFoA+OFtLw5pPR6zWpIDs4EIr0oMVTSnjJ9Eu3fbLHM4u4Z/gMlwX2HOEhPha9QmHQI3dM4hJ3uqpRzw+RkzN8Bk9BEZxJliozwpKtOeCnU9fwW3SMjrj1kgCv5o8VKDO0X6YTD6PhuK8LuMdjm/ecCOwcWrGWeBJB0B3LN6JMwCDmCoQ9YDPmziGjoF2hCzlhdt7AbhJoK/tHbN3iOeMDVeu25m6AdDSI1VXvY4i47JWC0YpWBROA8S4Y5n2+cUdInWAa+AqSBp6NCiiJbR10dTChOHfytnHd9mYo6yAAyCPQ/hT+x4ggZG1TjZRJ/pxxwlmb144oDnOU8QQxyozYZE/7m/Wk/LT9Kz54yNAhONIVKY9FVRV4HgPeIX94c8Wl7I8Gw2Eg3rL8w5tWlonl2rUc0LtW3yEc76WKW1nMbWuOSr/PT/2x2a+qW6wc0JYFvQ6EcuLL46TH6DKCTjQJmMB7xeIldsSqKlFf46ZsPk5fXUui5sPVoraYDmNP2ZmggThxzwreBkEz+dUPbTNNu48+Pa//b3O/cUomo1YlRzm0sRlx8SVmA/7emrL5mpEnfE4mtbow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(376002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(66946007)(66556008)(5660300002)(66476007)(54906003)(478600001)(4744005)(6486002)(2906002)(8676002)(4326008)(7416002)(316002)(31686004)(8936002)(6506007)(53546011)(6512007)(26005)(2616005)(83380400001)(41300700001)(86362001)(38100700002)(36756003)(31696002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUU4ZFZuOHM0Vjg5eHRNTGI2YlpTZTJxcTdWcUp6b016Wm1YYUJaLzJRZy9Z?=
 =?utf-8?B?Nzc0MmR2VDFhbEZnSWJiZU5LdFJpYXpLVHZwbG91U2x5ZmtIaStDM1RCVmRm?=
 =?utf-8?B?NktVa2kzNUdLOGFxTjZzUGhFanAzNzBOVjJ5WHlYQnNweGFYNm41eEFpY1VF?=
 =?utf-8?B?MzZ1Y0VBczdJUHBmeUNCL2lLV1JKYy8rU3B6YVpZczdxc1dMYmdhOWFnOE1Q?=
 =?utf-8?B?ZXVEWTVJZktFZnVNREU4bHNualhpTmo0YTRETjhjOHBOeXpaamNscm81NUNS?=
 =?utf-8?B?OFlYcXZlYWp4b3RpZzl6bzRoZ1piNldVdlVDYlUzTGExL3ZSZmJ4VVIybThF?=
 =?utf-8?B?QSt6aklQakJPZFFETGQxZlZvVng4K0w0NlhNSmlYSk1NMnN3dkZUWVU5dEhU?=
 =?utf-8?B?NWp0Yk5mNFRvbEk3ZWFNeEhPMDlwVWM4dk1ZV09IekswdXlhWWxxVFN2bWJC?=
 =?utf-8?B?OXFiQ0pGMFdJczEzRi8xNk40QWMxcmx0Nm5PVm16ZTFhNWhVUUYzZTdLWExs?=
 =?utf-8?B?YjVUdWZUQUx1TzV3U24rcktZN3lqdmtYQVFRbkdqbW1DOVN5K0Y5Qm94ellr?=
 =?utf-8?B?Q0ZXdHZ6RHd3QlVNeitWdHppeGpyeUJhQzdiUzhwRytmcFduTmIwT2l5Mmp6?=
 =?utf-8?B?Z2Z4NWV5WlNrdndvR24vaHo4Mzd6SXpWREE3Yzg5ZmpIYzJxOTIxem8yeVNs?=
 =?utf-8?B?S1cwZi9FUkdwV2hxdjNxVC8yWlZONi9jbUwwM2IwWkp2VWJqYjRuWEIza1Zu?=
 =?utf-8?B?RzBBdWxiYzh4WmZRblN5cGlINm1hayt5ZHdDbmdCbWRmOURlK0FZejEwNkkx?=
 =?utf-8?B?R0VFbFRORC81NkF3ODkycVJCQmRHcG1Id042bGxjRVBZZklxYUR3MWNxWnJa?=
 =?utf-8?B?bTJubHJ0cU4wb3JORFBaWTk3MCtKbGRleWZoSmwyd1RrN2ErZ2pXYVVJMmQ3?=
 =?utf-8?B?Z0habjBCaTNwQnlMemV5RjBISmJhcXYrTVE5Nkt3eFQ2Z0dRMUZEOE5XK2FR?=
 =?utf-8?B?dStYSDR1a2hTY0lYUEFxd2xxM1B6ODJ2bVNIUDFYTHY4RU9lbmppRW1Zcy9Q?=
 =?utf-8?B?NUFkWGQrNy90THJmTUNDOU5VTTgrY3AyV1Y2ZjhsOWxrVXBUajZSU1lwV3Nq?=
 =?utf-8?B?QlFpeVRubnJ1R1Z0Ylo3NXFnbGNkUU1DaHgwTy80NEt3UTJrVEl5cCt1STZl?=
 =?utf-8?B?RTNYbytFdkpERUFOT0FwbURIaVFGdTFicVhTZmwwM0RKbmRIei9kTjBYVW9S?=
 =?utf-8?B?VCtab01Eb3RNZm5DL2pvTEFJcTR5RGlMTFc5ZVRQT2NWK2lRWTlmVGhzWDhB?=
 =?utf-8?B?UWMrdzNnM0svNW5Sb1Z4ajh4MlFWVlVzMW5VWStHTks2V045VXZwOFdnNHp6?=
 =?utf-8?B?ZWxCUFdjb3pJRVAzUUhXVS9sV1BOc0xtNHhFWjNVc2R2anFqK3pOWk1iejBW?=
 =?utf-8?B?TXVEQmpVSjhrUENsc1VWSTcwQVJoOEc4bTN3ZDFFSG1HenYzbUx0ZkpiYVNM?=
 =?utf-8?B?Zkg1blc2UVhHL0ZzSDcydkJ0WTNsdUFjM1UzWjdnbmY1cEpKMVJza0xka2Zk?=
 =?utf-8?B?NXBiYmNwYWp2UUhyem1vVEw5OXhIMGxSYkNSR3BEbHFjU3hqZzlYZTZ3cExK?=
 =?utf-8?B?bk05T290U2MxZ2JJYXFTNlZwYkdzS0VVTUpqKzlyVFVuTHMrbUd2dHU1eTdW?=
 =?utf-8?B?UGI3eG1FVEw5MVo2Q2wrZEZveVBGZTgwMm1hTXQ4MHpuTFJNOWVUL09odVFr?=
 =?utf-8?B?YTg1dE5Mb09pSlR1NGZDUENydEVMTGEwQmRad0t3VUJVZTRNV0ZJaW5lVURz?=
 =?utf-8?B?TzFpRlRyV1ltaGlCeDlFNjI1TnMwc0RRUkcrQ2JicExzb3kzUDV3bVFFRnhp?=
 =?utf-8?B?cVFFckxLRkRDbC9zR1Q2NGxjMEpOc2JsUXRYZUlOVEJHQks2bkVJZWhrUlJC?=
 =?utf-8?B?SnUzSEUrOURndURjeGE0RVFJd210S1BxeXFYV1ZyU3BnRnFCbmtwdHQxOU1K?=
 =?utf-8?B?dU9SREt4VUY4R3hjN3VtVkxxbys3QXMzRE1lemVZeGdZZGNHcUR5bFcvbjJK?=
 =?utf-8?B?YXUyVVY3LzFQd1FPMjg1UWhSNStyNFc2RmVXMHIvK0dSTGxtRWhoMkFJNDlz?=
 =?utf-8?Q?OyB2aXIsbUjdDPDP0wcDIePn8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1622334-bab0-4e2f-896c-08dbf78ef2d2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 01:42:33.6758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0Gvsu2iYFvRDqLjpfBTCZBonS3eAnA/gGXuga11cRIHM/7YN7RuLrN6ytrf4yh0RYqWa0C1pIQLCEOfRBRmvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8504
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/4/2023 10:21 PM, David Hildenbrand wrote:
> Let's convert mfill_atomic_install_pte().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>

> ---
>   mm/userfaultfd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 0b6ca553bebec..abf4c579d328a 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -114,7 +114,7 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
>   		/* Usually, cache pages are already added to LRU */
>   		if (newly_allocated)
>   			folio_add_lru(folio);
> -		page_add_file_rmap(page, dst_vma, false);
> +		folio_add_file_rmap_pte(folio, page, dst_vma);
>   	} else {
>   		page_add_new_anon_rmap(page, dst_vma, dst_addr);
>   		folio_add_lru_vma(folio, dst_vma);
