Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B483776E7C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 05:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjHJDZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 23:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjHJDZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 23:25:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19782FE;
        Wed,  9 Aug 2023 20:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691637945; x=1723173945;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oQr9rmpoHw/ox3Pn80gcJbuvto5eo+xieb8UrEyz4R4=;
  b=GbhvbQktPyomSte8DY3kLmh6e93VLGmEuWmu6tq3n8+fD/A4mrXUUtx3
   kPN2lPFHm1bdmkLb74Ol9MgydNX6REKhSwMy2n4azDuBjob5/5NzgOk/S
   F8Ihw6EU4Fkka5z88/aaAf1Y/dPqzR+4mfr/EjDSSDZGvW/oGYpGVZ0Po
   MN0O6kre57T4ZWMWk7jts9uImjAZpSf1eV+a8HRkFm6T0ZFIQ5HYW8w/r
   tMxT54knMQw5zdVKysUTkqTXx0PAu2UlQbz4KPuKU739L/LIH+otQ4M+Y
   QCWGKXHQjjyXFTaFV6G5/9NhRhss0TFRT+KD42HIEYpj4HCNhky4W3hZy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="402245055"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="402245055"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 20:25:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="797446597"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="797446597"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 09 Aug 2023 20:25:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 20:25:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 20:25:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 20:25:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 20:25:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7aDx7XoJLpE7nsq6bsxddjauMMBcH7ZZJm2Pgwj1XaoD5BCVk37ArG90uYfUPm/bWGtUhgr9BtIlTadeVuALIgyU7ChORuF3Ogw4DGkWxUq8/fIvYK6cgtCEG8AF8FpN7MSNYR1Pezjrbp2W7Vrekx+MC2O12yFFOhNvjCeaFaJQcWRjZW8xpoNgaTG32NaJChj76yrP0qdNrr15pQAnA7eAwtURBXrKuTjj3kWNvz3Fqrx1YGv1U+CYZR1tXChugkGDgUI6Ek5j7RSKTta77jS8U15bxDz4xhB66IRZkhXdmgvWjGtOEON6AMf/cURA0yPLS6CE/jAjOA9cy4qvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9pZB2WZCYBWIYVqvzXZNZU5OrPzEthpSOXJ9saoux4=;
 b=HwDBYjrXh9Vhn+aycrmi0zPEdOGQsYH5/l+kDbZbZtJkiG2MhUH53XzHwVSxO5HxT7XLaDag3E1of4WiaJNjvLuP08JiRuXoVmv2UXV8S/IqBuH1GH8nnbnZN05ts68B4yfEP35JYLZ4VTzmbEH8ccCNE5e6H/TRjdGmKLygU7XFuhBLpOL0uqHdx/XdGaDR94LLK2tRMVjrMPvqyRroRsjXGC33XoKHnK+iYyQLcNB5IKJmAgzndnP7tHTv3RpSsDUBGKFEPbQeHWqH7vRnp/+CA3QvAMkwn8PKnZT9SlRcXIN56CJuo2U2nWJjpcAolv4Vp57HZi8hd4xpLpWPEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CY8PR11MB7135.namprd11.prod.outlook.com (2603:10b6:930:61::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 03:25:36 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 03:25:36 +0000
Message-ID: <399e78b1-a0bd-7705-51e0-070632d4fff0@intel.com>
Date:   Thu, 10 Aug 2023 11:24:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH mm-unstable v1] mm: add a total mapcount for large folios
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        "Yang Shi" <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
References: <20230809083256.699513-1-david@redhat.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <20230809083256.699513-1-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CY8PR11MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: d5cf25cb-e90e-491d-fb05-08db99517669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KGY7T6iW4ow1qREzyua2MG2qicVZhsaH0Zu0lNRFdEsKiC8C4U64/WYJC1Fy3V088NsKIsSii4vm27NmSa9vSSyEHzSyKMTDHl0y2xRvk7zNywne2UaxpPqRkZMgbLwCIqVUW+ZSHYPCgPerWBmkQ/ZvoqKOvCVuikmj94ZU8hdTy8Wh3jQ1b3BdZvK9NOonsz7MS7WzQ6BHxw/whv3KBZnNcUdNd345rbkvuwLAklmmt6G9v+BSqVFBSU3sLA4wDSGrCqbgcHSOzVdmgNwzwj6vVLNVh2z3te+Rvl87ow3nI9hDzIfXoqOqBCjV86G9a1IX4wjnTzLvcPvYL/1+NP3fdZf5PzdtrPevfD1DGf6n9PebvpKB6WlkU8Upod1k14GNI/nR8lTLNPlZZlea/bGXH/swdG79c9X7IvW9JhuK1T8AXuPjFqz5rlgB1HAv51o/RBs4vygVX1bNVeu9LVbY2BeDk/mzvRDakMLrAnYYVvd3IJ7yP39OuFrK2rs2J6p6dwsmOdWJGWTAribvPJYChSyqkPrygwUPpqan93rNBi2RCnZhO+ZPhybeBdhtoxNLtCb+XjhNUT49YA2tZBtMVFyA8IsmPOM2mTlJSanXsVXhfTUlctlnVx0sMhNX62mUAX2xdH8FhF4cEgVhMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199021)(1800799006)(186006)(6666004)(6486002)(6512007)(31696002)(86362001)(6506007)(53546011)(26005)(36756003)(2616005)(83380400001)(38100700002)(82960400001)(31686004)(316002)(30864003)(8676002)(41300700001)(8936002)(2906002)(66556008)(66476007)(4326008)(66946007)(7416002)(478600001)(54906003)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnFYTng4NkdMTlFYOExrK2NJK0h2OXRQa0FLK0tLa21HaXV2b3lZRGVrZlZE?=
 =?utf-8?B?bFF2eUlUWU4rZzJnZHp5c2lhcFJ1eDdEYUJkcXNSMU9LUnpHN3pZWStIQ2pz?=
 =?utf-8?B?VVpTVFk1L1FTeVNUZmlYaDhpTnpPSXF2NUdocG5GZnZDNjBSUENHZmFIMlBC?=
 =?utf-8?B?Z3k3N1hiWWhvMVRyaFFTL0lmZkxYWlVqUnZxdmVnc1BmM20zMGIvdEFnUHcr?=
 =?utf-8?B?U0lKMXljS3cxZ25ET3B4a2FYSEVGK3J5MStMSnIwSWxPTjR6ejdlNmtvZVFR?=
 =?utf-8?B?VUNhK2lIL01yUHAvNnM1RWZCUDVNVXFFWE5IaXJnMFNxcG9EaTNvWWx5WG9L?=
 =?utf-8?B?M200UFRaOGVOYkIxMFpsZyswYWN6Zm9KV0ZXbXRCcVZyS1hVV2YxSWlVeW9D?=
 =?utf-8?B?U290WHRTaHJXMzBucVNxZVpBUW16VFo3OU90TEs4TmxwNE5hMmVtMzlYNlBM?=
 =?utf-8?B?dTJ1UnUrOWlaWmd6UWpqK3dyVWNmYzIxR0JubEx1cTNLUUNhbHYvKzhIOEF5?=
 =?utf-8?B?VG9aa1lDeXA2amVQUEZkbzgrZHdNWVpmNGtlMkpnMXg0WnpadzQvMHo5TDcr?=
 =?utf-8?B?VzNvWDYzKzdueW5mcmpFWHVlaVZxVlYxaittT2hlQ3l6dll5ZDE4aDdOc0pn?=
 =?utf-8?B?UVVaUTFFbVc0K3NQQy9EZTJtWXU2eEdvYkdDY2R1VWZONDBXa0M5WVVldWsx?=
 =?utf-8?B?WnAxUFpzZjVXZzVoSkhnV2hPR1Z3Mm9FdGs0YkFJYVZZSFFGTStnbE5qNUJY?=
 =?utf-8?B?SCtxS3ppbVVaajRHRmdLUkJPcHFjdjRST24zMWxJWFA4a1NMaXFFWHl3SWlM?=
 =?utf-8?B?ckF6N1BKTmtvK0c1anduek95Y3N0V2lpU2Y3dVFFR2V6OUZQMUpEMnh3WTha?=
 =?utf-8?B?UWFGY2NTWEZyRFlybVlmaEMzT3hFdjJxUTk5U0VmdTdOenVQaURYR1JuLytB?=
 =?utf-8?B?RytVbm9YSGdSU1Z0Q1Y2LzMrRUdNano0Y2xKV2FFZnZLTHFUZlQvVU8rc2Iw?=
 =?utf-8?B?WGtrZjlFQXlzZ2ZBQ2hXTDFKczJ5WnYxbDR6Wm1ZakZBeER4UWpLeXJDdjJF?=
 =?utf-8?B?aHpqWS9zMjRhTDJIbzJoSHZmUWJxQU9uOGdtMi9YS3Vyd3BQL1NzVnVZaXV2?=
 =?utf-8?B?QjA4cTMvNm4zd2MxNFJyOG4yMSs1RHBNWUpCMzhvd1JLZmVHcDg2ZHdlRVNT?=
 =?utf-8?B?T0JyRVBsS1kvRGJ4ZmZpZ1ZENit1UHVLNC81RjZrQ0I4Q3RiSS9mRC9Gbjdi?=
 =?utf-8?B?ZzRqZzB5cEptdlh2eXl5eVJrVklPL09mSGpiWkkwODIwMFZRUjVlYTNiditn?=
 =?utf-8?B?N1Z0Sm1rcGVyR2pybStQWEVqcjhWWU1jOE4yZGNyd2xtOUh3UHZBcTlMRlY1?=
 =?utf-8?B?eHkwZHB3dnhjSlpNOTcvV3JteU4xOXBaa0IzMnQxMzNYbm5qNU1ZZTVibjY5?=
 =?utf-8?B?OXAyVDl1dzNTbThCTlphKzRDT3BZaEs3bER0ZWZDZERGb0tnOVExTFFXbUF0?=
 =?utf-8?B?MW16WncrNjNrRlFndDhOV1F6bTU3RC9yNFZQdXRrZ1Vvb1NCczNqMk9TTis1?=
 =?utf-8?B?NGpTUXlHOS9NM0VYUjJiaXJxUlJObmJBaEw5TEJXdzZsVGt0NUF5ZzVvOCtF?=
 =?utf-8?B?ZURDUVIxOTgwc29uVXcweWhNeXFOREJGalIwTER2SGMvVEwvVzVSdGdENDZC?=
 =?utf-8?B?ZFUzLzZIS2EyaVlNcExjWjVjZkVkelhYSVVnN3doN3NJZXRIQlQ1Uk5OYUxh?=
 =?utf-8?B?SWQwc0x0UERlWU9IaDEzZzUxckZWV1FZOTJ5UHo3SENkaUU2Zk1aNExrMkRT?=
 =?utf-8?B?Mm94dzhJWk5UdnlYNExpbThEUG1ETnptazJSM1ZrU2JtVVpEK0wwbytVK2dR?=
 =?utf-8?B?bENLUnJoYzVyemIrdjVUS3FIQ2lBZXRna3ozeFFURDN0STlLbHl1MGdrWFRT?=
 =?utf-8?B?VUdLTnEzSGJyOGRvWEJEVlk2dUZDTE9DUzJzSk04N1JUM1d2a0dkK3dYL0RR?=
 =?utf-8?B?ZFdDVUNSRHJrYWJSRFpuMGhJNElmSzhBV3RPZDQwbEF4N3pZVHlTWEpFZE1D?=
 =?utf-8?B?RDFzeUtjYXVraGtRcGRHLzE0TFQya2diN3RvTmpYVkVkc0VVRGJTdm55TGkv?=
 =?utf-8?B?UWRic0FFSUxYcDhMcG1IMklqdGR0V1hPQ1BYVWI2SXlCbU90MVZuOUZXNGp5?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5cf25cb-e90e-491d-fb05-08db99517669
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 03:25:36.3148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ZZ1EXByh8pO4HxWvtMtWoOKYycEwGy9ssMCtqhYxIZTvPVoSg7mqSUwqD8x23JQle3H1KlA4SEe7iki4MHuqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7135
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/9/23 16:32, David Hildenbrand wrote:
> Let's track the total mapcount for all large folios in the first subpage.
> 
> The total mapcount is what we actually want to know in folio_mapcount()
> and it is also sufficient for implementing folio_mapped(). This also
> gets rid of any "raceiness" concerns as expressed in
> folio_total_mapcount().
> 
> With sub-PMD THP becoming more important and things looking promising
> that we will soon get support for such anon THP, we want to avoid looping
> over all pages of a folio just to calculate the total mapcount. Further,
> we may soon want to use the total mapcount in other context more
> frequently, so prepare for reading it efficiently and atomically.
> 
> Make room for the total mapcount in page[1] of the folio by moving
> _nr_pages_mapped to page[2] of the folio: it is not applicable to hugetlb
> -- and with the total mapcount in place probably also not desirable even
> if PMD-mappable hugetlb pages could get PTE-mapped at some point -- so we
> can overlay the hugetlb fields.
> 
> Note that we currently don't expect any order-1 compound pages / THP in
> rmap code, and that such support is not planned. If ever desired, we could
> move the compound mapcount to another page, because it only applies to
> PMD-mappable folios that are definitely larger. Let's avoid consuming
> more space elsewhere for now -- we might need more space for a different
> purpose in some subpages soon.
> 
> Maintain the total mapcount also for hugetlb pages. Use the total mapcount
> to implement folio_mapcount(), total_mapcount(), folio_mapped() and
> page_mapped().
> 
> We can now get rid of folio_total_mapcount() and
> folio_large_is_mapped(), by just inlining reading of the total mapcount.
> 
> _nr_pages_mapped is now only used in rmap code, so not accidentially
> externally where it might be used on arbitrary order-1 pages. The remaining
> usage is:
> 
> (1) Detect how to adjust stats: NR_ANON_MAPPED and NR_FILE_MAPPED
>  -> If we would account the total folio as mapped when mapping a
>     page (based on the total mapcount), we could remove that usage.
> 
> (2) Detect when to add a folio to the deferred split queue
>  -> If we would apply a different heuristic, or scan using the rmap on
>     the memory reclaim path for partially mapped anon folios to
>     split them, we could remove that usage as well.
> 
> So maybe, we can simplify things in the future and remove
> _nr_pages_mapped. For now, leave these things as they are, they need more
> thought. Hugh really did a nice job implementing that precise tracking
> after all.
> 
> Note: Not adding order-1 sanity checks to the file_rmap functions for
>       now. For anon pages, they are certainly not required right now.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Yin Fengwei <fengwei.yin@intel.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>


Regards
Yin, Fengwei



> ---
>  Documentation/mm/transhuge.rst | 12 +++++-----
>  include/linux/mm.h             | 31 ++++++------------------
>  include/linux/mm_types.h       |  6 +++--
>  include/linux/rmap.h           |  7 ++++--
>  mm/debug.c                     |  4 ++--
>  mm/huge_memory.c               |  2 ++
>  mm/hugetlb.c                   |  4 ++--
>  mm/internal.h                  | 17 ++++---------
>  mm/page_alloc.c                |  4 ++--
>  mm/rmap.c                      | 44 ++++++++++++++--------------------
>  10 files changed, 52 insertions(+), 79 deletions(-)
> 
> diff --git a/Documentation/mm/transhuge.rst b/Documentation/mm/transhuge.rst
> index 9a607059ea11..b0d3b1d3e8ea 100644
> --- a/Documentation/mm/transhuge.rst
> +++ b/Documentation/mm/transhuge.rst
> @@ -116,14 +116,14 @@ pages:
>      succeeds on tail pages.
>  
>    - map/unmap of a PMD entry for the whole THP increment/decrement
> -    folio->_entire_mapcount and also increment/decrement
> -    folio->_nr_pages_mapped by COMPOUND_MAPPED when _entire_mapcount
> -    goes from -1 to 0 or 0 to -1.
> +    folio->_entire_mapcount, increment/decrement folio->_total_mapcount
> +    and also increment/decrement folio->_nr_pages_mapped by COMPOUND_MAPPED
> +    when _entire_mapcount goes from -1 to 0 or 0 to -1.
>  
>    - map/unmap of individual pages with PTE entry increment/decrement
> -    page->_mapcount and also increment/decrement folio->_nr_pages_mapped
> -    when page->_mapcount goes from -1 to 0 or 0 to -1 as this counts
> -    the number of pages mapped by PTE.
> +    page->_mapcount, increment/decrement folio->_total_mapcount and also
> +    increment/decrement folio->_nr_pages_mapped when page->_mapcount goes
> +    from -1 to 0 or 0 to -1 as this counts the number of pages mapped by PTE.
>  
>  split_huge_page internally has to distribute the refcounts in the head
>  page to the tail pages before clearing all PG_head/tail bits from the page
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6a95dfed4957..30ac004fa0ef 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1187,41 +1187,24 @@ static inline int page_mapcount(struct page *page)
>  	return mapcount;
>  }
>  
> -int folio_total_mapcount(struct folio *folio);
> -
>  /**
> - * folio_mapcount() - Calculate the number of mappings of this folio.
> + * folio_mapcount() - Return the total number of mappings of this folio.
>   * @folio: The folio.
>   *
> - * A large folio tracks both how many times the entire folio is mapped,
> - * and how many times each individual page in the folio is mapped.
> - * This function calculates the total number of times the folio is
> - * mapped.
> - *
> - * Return: The number of times this folio is mapped.
> + * Return: The total number of times this folio is mapped.
>   */
>  static inline int folio_mapcount(struct folio *folio)
>  {
>  	if (likely(!folio_test_large(folio)))
>  		return atomic_read(&folio->_mapcount) + 1;
> -	return folio_total_mapcount(folio);
> +	return atomic_read(&folio->_total_mapcount) + 1;
>  }
>  
>  static inline int total_mapcount(struct page *page)
>  {
>  	if (likely(!PageCompound(page)))
>  		return atomic_read(&page->_mapcount) + 1;
> -	return folio_total_mapcount(page_folio(page));
> -}
> -
> -static inline bool folio_large_is_mapped(struct folio *folio)
> -{
> -	/*
> -	 * Reading _entire_mapcount below could be omitted if hugetlb
> -	 * participated in incrementing nr_pages_mapped when compound mapped.
> -	 */
> -	return atomic_read(&folio->_nr_pages_mapped) > 0 ||
> -		atomic_read(&folio->_entire_mapcount) >= 0;
> +	return atomic_read(&page_folio(page)->_total_mapcount) + 1;
>  }
>  
>  /**
> @@ -1234,7 +1217,7 @@ static inline bool folio_mapped(struct folio *folio)
>  {
>  	if (likely(!folio_test_large(folio)))
>  		return atomic_read(&folio->_mapcount) >= 0;
> -	return folio_large_is_mapped(folio);
> +	return atomic_read(&folio->_total_mapcount) >= 0;
>  }
>  
>  /*
> @@ -1246,7 +1229,7 @@ static inline bool page_mapped(struct page *page)
>  {
>  	if (likely(!PageCompound(page)))
>  		return atomic_read(&page->_mapcount) >= 0;
> -	return folio_large_is_mapped(page_folio(page));
> +	return atomic_read(&page_folio(page)->_total_mapcount) >= 0;
>  }
>  
>  static inline struct page *virt_to_head_page(const void *x)
> @@ -2148,7 +2131,7 @@ static inline size_t folio_size(struct folio *folio)
>   * looking at the precise mapcount of the first subpage in the folio, and
>   * assuming the other subpages are the same. This may not be true for large
>   * folios. If you want exact mapcounts for exact calculations, look at
> - * page_mapcount() or folio_total_mapcount().
> + * page_mapcount() or folio_mapcount().
>   *
>   * Return: The estimated number of processes sharing a folio.
>   */
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 291c05cacd48..16e66b3332c6 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -267,7 +267,8 @@ static inline struct page *encoded_page_ptr(struct encoded_page *page)
>   * @_folio_dtor: Which destructor to use for this folio.
>   * @_folio_order: Do not use directly, call folio_order().
>   * @_entire_mapcount: Do not use directly, call folio_entire_mapcount().
> - * @_nr_pages_mapped: Do not use directly, call folio_mapcount().
> + * @_total_mapcount: Do not use directly, call folio_mapcount().
> + * @_nr_pages_mapped: Do not use outside of rmap code (and not for hugetlb).
>   * @_pincount: Do not use directly, call folio_maybe_dma_pinned().
>   * @_folio_nr_pages: Do not use directly, call folio_nr_pages().
>   * @_hugetlb_subpool: Do not use directly, use accessor in hugetlb.h.
> @@ -321,7 +322,7 @@ struct folio {
>  			unsigned char _folio_dtor;
>  			unsigned char _folio_order;
>  			atomic_t _entire_mapcount;
> -			atomic_t _nr_pages_mapped;
> +			atomic_t _total_mapcount;
>  			atomic_t _pincount;
>  #ifdef CONFIG_64BIT
>  			unsigned int _folio_nr_pages;
> @@ -346,6 +347,7 @@ struct folio {
>  			unsigned long _head_2a;
>  	/* public: */
>  			struct list_head _deferred_list;
> +			atomic_t _nr_pages_mapped;
>  	/* private: the union with struct page is transitional */
>  		};
>  		struct page __page_2;
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index a3825ce81102..a7b1c005e0c9 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -210,14 +210,17 @@ void hugepage_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
>  
>  static inline void __page_dup_rmap(struct page *page, bool compound)
>  {
> -	if (compound) {
> -		struct folio *folio = (struct folio *)page;
> +	struct folio *folio = page_folio(page);
>  
> +	if (compound) {
>  		VM_BUG_ON_PAGE(compound && !PageHead(page), page);
>  		atomic_inc(&folio->_entire_mapcount);
>  	} else {
>  		atomic_inc(&page->_mapcount);
>  	}
> +
> +	if (folio_test_large(folio))
> +		atomic_inc(&folio->_total_mapcount);
>  }
>  
>  static inline void page_dup_file_rmap(struct page *page, bool compound)
> diff --git a/mm/debug.c b/mm/debug.c
> index ee533a5ceb79..97f6f6b32ae7 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -99,10 +99,10 @@ static void __dump_page(struct page *page)
>  			page, page_ref_count(head), mapcount, mapping,
>  			page_to_pgoff(page), page_to_pfn(page));
>  	if (compound) {
> -		pr_warn("head:%p order:%u entire_mapcount:%d nr_pages_mapped:%d pincount:%d\n",
> +		pr_warn("head:%p order:%u entire_mapcount:%d total_mapcount:%d pincount:%d\n",
>  				head, compound_order(head),
>  				folio_entire_mapcount(folio),
> -				folio_nr_pages_mapped(folio),
> +				folio_mapcount(folio),
>  				atomic_read(&folio->_pincount));
>  	}
>  
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 154c210892a1..43a2150e41e3 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -583,6 +583,7 @@ void prep_transhuge_page(struct page *page)
>  
>  	VM_BUG_ON_FOLIO(folio_order(folio) < 2, folio);
>  	INIT_LIST_HEAD(&folio->_deferred_list);
> +	atomic_set(&folio->_nr_pages_mapped, 0);
>  	folio_set_compound_dtor(folio, TRANSHUGE_PAGE_DTOR);
>  }
>  
> @@ -2795,6 +2796,7 @@ void free_transhuge_page(struct page *page)
>  		}
>  		spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>  	}
> +	VM_WARN_ON_ONCE(atomic_read(&folio->_nr_pages_mapped));
>  	free_compound_page(page);
>  }
>  
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 5f498e8025cc..6a614c559ccf 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1479,7 +1479,7 @@ static void __destroy_compound_gigantic_folio(struct folio *folio,
>  	struct page *p;
>  
>  	atomic_set(&folio->_entire_mapcount, 0);
> -	atomic_set(&folio->_nr_pages_mapped, 0);
> +	atomic_set(&folio->_total_mapcount, 0);
>  	atomic_set(&folio->_pincount, 0);
>  
>  	for (i = 1; i < nr_pages; i++) {
> @@ -2027,7 +2027,7 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>  	/* we rely on prep_new_hugetlb_folio to set the destructor */
>  	folio_set_order(folio, order);
>  	atomic_set(&folio->_entire_mapcount, -1);
> -	atomic_set(&folio->_nr_pages_mapped, 0);
> +	atomic_set(&folio->_total_mapcount, -1);
>  	atomic_set(&folio->_pincount, 0);
>  	return true;
>  
> diff --git a/mm/internal.h b/mm/internal.h
> index 02a6fd36f46e..e4646fed44a5 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -53,10 +53,10 @@ struct folio_batch;
>  void page_writeback_init(void);
>  
>  /*
> - * If a 16GB hugetlb folio were mapped by PTEs of all of its 4kB pages,
> + * If a 16GB folio were mapped by PTEs of all of its 4kB pages,
>   * its nr_pages_mapped would be 0x400000: choose the COMPOUND_MAPPED bit
> - * above that range, instead of 2*(PMD_SIZE/PAGE_SIZE).  Hugetlb currently
> - * leaves nr_pages_mapped at 0, but avoid surprise if it participates later.
> + * above that range, instead of 2*(PMD_SIZE/PAGE_SIZE). Not applicable to
> + * hugetlb.
>   */
>  #define COMPOUND_MAPPED		0x800000
>  #define FOLIO_PAGES_MAPPED	(COMPOUND_MAPPED - 1)
> @@ -67,15 +67,6 @@ void page_writeback_init(void);
>   */
>  #define SHOW_MEM_FILTER_NODES		(0x0001u)	/* disallowed nodes */
>  
> -/*
> - * How many individual pages have an elevated _mapcount.  Excludes
> - * the folio's entire_mapcount.
> - */
> -static inline int folio_nr_pages_mapped(struct folio *folio)
> -{
> -	return atomic_read(&folio->_nr_pages_mapped) & FOLIO_PAGES_MAPPED;
> -}
> -
>  static inline void *folio_raw_mapping(struct folio *folio)
>  {
>  	unsigned long mapping = (unsigned long)folio->mapping;
> @@ -420,7 +411,7 @@ static inline void prep_compound_head(struct page *page, unsigned int order)
>  	folio_set_compound_dtor(folio, COMPOUND_PAGE_DTOR);
>  	folio_set_order(folio, order);
>  	atomic_set(&folio->_entire_mapcount, -1);
> -	atomic_set(&folio->_nr_pages_mapped, 0);
> +	atomic_set(&folio->_total_mapcount, -1);
>  	atomic_set(&folio->_pincount, 0);
>  }
>  
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 96b7c1a7d1f2..5bbd5782b543 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1009,8 +1009,8 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
>  			bad_page(page, "nonzero entire_mapcount");
>  			goto out;
>  		}
> -		if (unlikely(atomic_read(&folio->_nr_pages_mapped))) {
> -			bad_page(page, "nonzero nr_pages_mapped");
> +		if (unlikely(atomic_read(&folio->_total_mapcount) + 1)) {
> +			bad_page(page, "nonzero total_mapcount");
>  			goto out;
>  		}
>  		if (unlikely(atomic_read(&folio->_pincount))) {
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 1f04debdc87a..a7dcae48245b 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1070,29 +1070,6 @@ int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
>  	return page_vma_mkclean_one(&pvmw);
>  }
>  
> -int folio_total_mapcount(struct folio *folio)
> -{
> -	int mapcount = folio_entire_mapcount(folio);
> -	int nr_pages;
> -	int i;
> -
> -	/* In the common case, avoid the loop when no pages mapped by PTE */
> -	if (folio_nr_pages_mapped(folio) == 0)
> -		return mapcount;
> -	/*
> -	 * Add all the PTE mappings of those pages mapped by PTE.
> -	 * Limit the loop to folio_nr_pages_mapped()?
> -	 * Perhaps: given all the raciness, that may be a good or a bad idea.
> -	 */
> -	nr_pages = folio_nr_pages(folio);
> -	for (i = 0; i < nr_pages; i++)
> -		mapcount += atomic_read(&folio_page(folio, i)->_mapcount);
> -
> -	/* But each of those _mapcounts was based on -1 */
> -	mapcount += nr_pages;
> -	return mapcount;
> -}
> -
>  /**
>   * page_move_anon_rmap - move a page to our anon_vma
>   * @page:	the page to move to our anon_vma
> @@ -1236,6 +1213,9 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
>  		}
>  	}
>  
> +	if (folio_test_large(folio))
> +		atomic_inc(&folio->_total_mapcount);
> +
>  	VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
>  	VM_BUG_ON_PAGE(!first && PageAnonExclusive(page), page);
>  
> @@ -1289,6 +1269,10 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>  		__lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr);
>  	}
>  
> +	if (folio_test_large(folio))
> +		/* increment count (starts at -1) */
> +		atomic_set(&folio->_total_mapcount, 0);
> +
>  	__lruvec_stat_mod_folio(folio, NR_ANON_MAPPED, nr);
>  	__page_set_anon_rmap(folio, &folio->page, vma, address, 1);
>  }
> @@ -1310,14 +1294,14 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
>  			bool compound)
>  {
>  	atomic_t *mapped = &folio->_nr_pages_mapped;
> -	unsigned int nr_pmdmapped = 0, first;
> +	unsigned int nr_pmdmapped = 0, i, first;
>  	int nr = 0;
>  
>  	VM_WARN_ON_FOLIO(compound && !folio_test_pmd_mappable(folio), folio);
>  
>  	/* Is page being mapped by PTE? Is this its first map to be added? */
>  	if (likely(!compound)) {
> -		do {
> +		for (i = 0; i < nr_pages; i++, page++) {
>  			first = atomic_inc_and_test(&page->_mapcount);
>  			if (first && folio_test_large(folio)) {
>  				first = atomic_inc_return_relaxed(mapped);
> @@ -1326,7 +1310,7 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
>  
>  			if (first)
>  				nr++;
> -		} while (page++, --nr_pages > 0);
> +		}
>  	} else if (folio_test_pmd_mappable(folio)) {
>  		/* That test is redundant: it's for safety or to optimize out */
>  
> @@ -1346,6 +1330,9 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
>  		}
>  	}
>  
> +	if (folio_test_large(folio))
> +		atomic_add(compound ? 1 : nr_pages, &folio->_total_mapcount);
> +
>  	if (nr_pmdmapped)
>  		__lruvec_stat_mod_folio(folio, folio_test_swapbacked(folio) ?
>  			NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdmapped);
> @@ -1398,6 +1385,9 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
>  
>  	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
>  
> +	if (folio_test_large(folio))
> +		atomic_dec(&folio->_total_mapcount);
> +
>  	/* Hugetlb pages are not counted in NR_*MAPPED */
>  	if (unlikely(folio_test_hugetlb(folio))) {
>  		/* hugetlb pages are always mapped with pmds */
> @@ -2538,6 +2528,7 @@ void hugepage_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
>  	BUG_ON(!anon_vma);
>  	/* address might be in next vma when migration races vma_merge */
>  	first = atomic_inc_and_test(&folio->_entire_mapcount);
> +	atomic_inc(&folio->_total_mapcount);
>  	VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
>  	VM_BUG_ON_PAGE(!first && PageAnonExclusive(page), page);
>  	if (first)
> @@ -2551,6 +2542,7 @@ void hugepage_add_new_anon_rmap(struct folio *folio,
>  	BUG_ON(address < vma->vm_start || address >= vma->vm_end);
>  	/* increment count (starts at -1) */
>  	atomic_set(&folio->_entire_mapcount, 0);
> +	atomic_set(&folio->_total_mapcount, 0);
>  	folio_clear_hugetlb_restore_reserve(folio);
>  	__page_set_anon_rmap(folio, &folio->page, vma, address, 1);
>  }
