Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1E27B3880
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjI2RT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbjI2RTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:19:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB991AE;
        Fri, 29 Sep 2023 10:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696007991; x=1727543991;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ufiBJh3SycUZj0pTImc75cdLAofVIj0yeE9iYf+hX/U=;
  b=PesAVSF3yZF55Y5bqL6zN8XMzVb6HMoZrMr7L5fpfBKdrQMjeD4Vhvep
   C68xkbp32fW7bZBEjcZjA/NvNlbIlyBWi0qoSpUzEi6i9+B/Od34CaRAu
   4+Bs7yXCxbvH5jgFcB08ul0v49AQgIxK67YTBo62BVwgZLNewkM4tfxBI
   UAxu15cud2bEtf7kIo04xXXgmNso9VurZefVKKBfqCI8ZJaQQtjQboF/a
   RQtR5hk0geOw9Ug+e11+edB3OyJ4lUXTELqv4VHX6NpifkSo65N0s2EKQ
   6c1a/xMPsmG39XNeeNPLtM0VHx9yqGxa/VLUnDruXDHv92EYVgqbx+3rZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="379619749"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="379619749"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 10:19:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="911399"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 10:19:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 10:19:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 10:19:50 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 10:19:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QD8p5oAOBEZO8XDkcmjLa5AbnnQxxMCtQRNUAqsZEkTZIo0fuxnMwnH6BDEHEx8VasgHiXxc0Ipg0AcRV9u8DWgGf1GAwWuuWSvxiX7LoSAtj9ZqcPxIz4dy7cjsnnqqW7hfMxb9RG0gjXhI7JJgyavJOyRQng0gTJRm/gujyo6jKLCzD6SdQNoOsrQJbxoZkojzi3fAn9gJStQsYjdigNgKS157HfDtlqLVynDkjB4WvPSMgwdzg7OxyHosu8kdQWkv3+cbq4AhYl4+BqhUi+xhxH5+KuDA8xoQUlQqODFVM6aEcYvuenm6tXH52N3CQKnEZc3Ft03MW85S5Y+U5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/69BMXAdG0NbhByTvql9RuLUnCxtLA+WtUzRv/kE40=;
 b=hU1BOHB8YZp3+LqaeIqz1lxZdgpo6WdXia57pLIv+jRNsvhY3Dg9lrdMF2cah59PjQ9250phOuTX44a+/qJ/nAeOrZzR5WmPopi47GX+1S/LvqnrJj65zAJ8I8ujrgtQSIlehcTYc0DXkmOz80Ut/Khagw6kLvjX6OndFrYGR8/cuOwTQqqWa5chDuIxg4FxY8RlP4n0pS5MJptQhqOI/HDNuW7Jyp8h1l7VbCrGaN4vC9tR0B3x+bLUFEK10om14H63fUSq0dGKBhJfgOPaWuC1/npQ5kXw46PaAU3ffGfycbPX3/+EvHMlgRoJwFpW/WwhuObcJzWZ6Qe6eU9H6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW4PR11MB7078.namprd11.prod.outlook.com (2603:10b6:303:219::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.35; Fri, 29 Sep
 2023 17:19:48 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 17:19:48 +0000
Message-ID: <41ad0c01-93f3-67eb-1695-43446d2eb438@intel.com>
Date:   Fri, 29 Sep 2023 10:19:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/3] cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
Content-Language: en-US
To:     Chris Leech <cleech@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Rasesh Mody <rmody@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        Manish Chopra <manishc@marvell.com>
CC:     Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        "John Meneghini" <jmeneghi@redhat.com>,
        Lee Duncan <lduncan@suse.com>,
        Mike Christie <michael.christie@oracle.com>,
        Hannes Reinecke <hare@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230929170023.1020032-1-cleech@redhat.com>
 <20230929170023.1020032-4-cleech@redhat.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230929170023.1020032-4-cleech@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0044.namprd16.prod.outlook.com
 (2603:10b6:907:1::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW4PR11MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 487240bd-5c84-4c5d-7ed0-08dbc1104871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0vW7xcVTT8x8LMkt8gyyYdPp4fG2PIxVZ/3lT6G0KuId9lm+E7e5XFNXJZ9LsEw8LKwPo43FzASSSxSsulzNiV1jtI3yZPc2H3pmtSbf2+fX9ro0XA+pywqCL3V2IfmSXOxe52GKcTseiO/Q0WLCxjGn4uBC42bPnAKWY/SWQsQmDddGTdkxjmEyuBH0sgz12hHMBwN2h83wRA1H87K0Xw046UE1ZknX6kmuIvvfcokygZakJs70WAk9Hs/UphhrGCaoLfXfN8nV/EOenpiG34/zHVWkOrWg3y1LQ8Up87mLPaUtECUBGte2re+kICZ7qsoNJvBa4UNfdqeEDIHVLhC7GzttONL7oHhcEmJYz3Scw6RkwNzhYA22t13WMQG5QeDgK1YxKDxw+7b+msHEzKNhp+EBq3uLvCWCu68bDlJQAk85QPfebDAP3xttcICvz6LebpKZy99ZuOErl+RWwwsRrgXksp/BdLaMgpM98AsiTrh2unL26hSELwwhhGLQxXWf24FeoXHFQHq/yg2EsO+CotuXUj5jIYJoJOfad70z3HBr4HiXHUNFS5LiCvjbzc3YJw7HxA3HENcUwC07YyGnISPbho/vPEiWNAL6kcZvXOLYzR28MxfHlE6mXnfehGLYpGokuI9BRdCpMwkoiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(41300700001)(54906003)(316002)(66946007)(8676002)(66476007)(66556008)(8936002)(4326008)(5660300002)(31686004)(83380400001)(7416002)(4744005)(6486002)(53546011)(110136005)(478600001)(2616005)(6666004)(26005)(6512007)(82960400001)(38100700002)(31696002)(86362001)(36756003)(6506007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2lMeHE1VjRJeGFJUDh4bG1mVDNrM3dqVC91NktXNTcwNWMrS0xGZXFYTGZM?=
 =?utf-8?B?ZE9YTUFMVnpRRmViQTB2OWM0ZU13eXdMV21ZRXZjbzN6R0ZkZjM1cTJSY0Nt?=
 =?utf-8?B?dXF6c0l6QVJnNTVrbmRmaEZlWGFvRlN3UXMybDVzTlEza1Y0TnhoNFE0QUQ3?=
 =?utf-8?B?SXE3OTN6MUFDR1dEaklRUXFZTDJhaTlHclJEenBqWGw2N1FzTytTSllFS1ll?=
 =?utf-8?B?ek5NV3JtRmdiUTRVOFRzLzhlQ3VkMUtzVXlJbitlOHQ5R0FIeU1QTlNhbnVH?=
 =?utf-8?B?em1mWUZocXVpN3crL0IxWkQ0WmxpMWFYNnVpTzlTMlh1NzNkQmZoaFZwaWpv?=
 =?utf-8?B?UDFaTm9QbitscFRremlFL3NkT1hzT0NrL3VuNzdsOFFkRG5mNzdrZVhRbWxS?=
 =?utf-8?B?QXNqM1JHaElEU3hwT3Z2UVUyS3RUWGpVVGEraGZtVWhoQ1ZxL1poVXhsNGJM?=
 =?utf-8?B?VjRMbHJzNHZXMyt2aGt0WjVXRHBjelBJRGJ2Q3h3U0t5SGxjbW1zamNmSDMx?=
 =?utf-8?B?b1A1enVlNzF4TFdwWkNJaTdLaG1ydWJ4RkE4ajUxUkVSeENiK0ZFNGRxQWlX?=
 =?utf-8?B?dll0RHNlbm5ibGhwTVNTak5CZGtMZVNlUnEvYzlkak9DRng5K1V2dzl3U2dl?=
 =?utf-8?B?YWxmNzNuYVNKbzhoWXpOeldmRmdoQityQ3ZRemF5TmVObi9wVTVjRERPYU1r?=
 =?utf-8?B?NmVZMitZaHV1QjBlMVNSVEswcUNzcFpGYWVZQm1MWk9aTFlKSVBSTWt1RmFl?=
 =?utf-8?B?emZRdW9NQVl4ZWNiZGd6VG9FdzNiQUhjT2M4K0cwZXZpRFoxbTJwQ1ZOOHFv?=
 =?utf-8?B?RWJuS2hrMi9Fb2FNRUhjMHRvRVJFTkNnRkpTK1hGNDNGbW9vNkFVUzVFRDJJ?=
 =?utf-8?B?UnhOck1ESW5pSGVkTGZ2THV0RWhxS0ZFQ0NwZUxsM0tDcXowaUZiSjVhTzFH?=
 =?utf-8?B?eExnekt0YUxjQXlQcHZsdGdaZWJ6anVnam1CSGNNN3VWYy9LK2lncWNrZnRm?=
 =?utf-8?B?ckU2SkR0Y2lMUFBXT21EWWVUWlJGenJjM3ByNlVKZEM3LzA2bVo5U0FRVkt4?=
 =?utf-8?B?TEdJcHBQQ2s0QkRpZWlweGhmMmxua2ZaUU45aVR2WXo2OFAwdDNFTklnWGFt?=
 =?utf-8?B?emUvdWV6N1ZKWTk4UWdEOVIxdGdEYlJHOXFqM252cGt4bG85UVJOUUZGYXRH?=
 =?utf-8?B?N0dqTCs2bllTWjh5dHVkVkxjZVR0VGRKdnlGRXJPb3dRbUdMeSs3SXhPMkwx?=
 =?utf-8?B?bFFYMUJlZ0xLekJ6N0ZOc3NHZXlxb2Vnamx0eDYyTFNzSHJLS0RZdWJJYWwz?=
 =?utf-8?B?OTAzMXREV2hFbmVVOTJCRWxyNVlMV2cyZmpFVWVNd1A4MHdqNDlBWEZoaG4v?=
 =?utf-8?B?UWZSNjF3NUZjMWV4RmhNOEljaDZ2VG80ZkkyQ0RybDIxZld1T0REK3RHUUN3?=
 =?utf-8?B?MzlsYkFpbng3SVNsM3M2TzFVNVYvcjBZUTRKZ0dLdW8zVkxaRDlqZnpjek1D?=
 =?utf-8?B?SHdEUXFyVlVZbXRscFNOQzFycjBEOThnMFZWb0xLcnhLRUcyRTNvQzl1dkZG?=
 =?utf-8?B?NmhuMm44VDdDejRHSzJHZTh0MXFTeWRhT3BPOVdLU1B6RHdaVXdmRW5CMXZv?=
 =?utf-8?B?VDlYRmpZYnpLdWVPSFVYOTB1RUk4UXBBL0pKZnRnVUdFWllNTVBacjJhK0M0?=
 =?utf-8?B?WkRpRUdwTzNKVGVQNXQ4Q1VQTTdBZW92SWNqRTR3UmZqZGYwaUtsMzdjTysw?=
 =?utf-8?B?TmRDN2c0MVFaZGZNTktHRDBuZmNpaXB5ZFNDMTFZdGcxMVYrRUNBSHROMXhr?=
 =?utf-8?B?RkJTOHorVkhZVzNEblJmN25IQmw5cVJOK3Yvb3V0WGhDS1lEUmpTNzFYaUVu?=
 =?utf-8?B?bUVhSHlOOVF5T05xTGlwMmZjZGpLaHd6TkszS0hqdGNuVGROZjZXeDFsZVU5?=
 =?utf-8?B?MnFUWmp0VmcyVlhhcVNGUTJtZk96QTFBdjJWR1dRSkw4Ulk5bXMwcGxteElP?=
 =?utf-8?B?TTlySSsrTCtrV0Z4b3Jnem5oN3FMUGNtWHNmNmlPQlRGQWp2YzhWUjBaUlBG?=
 =?utf-8?B?Wm15bkZDWFRwWFdIaXh0bktiQkVsK1FGbEUwZ3JWUzlXTmRraGt5M1JldDJO?=
 =?utf-8?B?eFhtbXJwMW9hTE5FM3BXTVJSYmMwMG5Cbi95T1hiOStKWTEzbk9kUXdITTNy?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 487240bd-5c84-4c5d-7ed0-08dbc1104871
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 17:19:48.3095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YP5dYl2WvGescORXI41PTp83feo6Nn+VkbbOr56tVWM+B+djB7UYAoDlQfrIuk2rF7MwLsggR7FWDMM3+jQEoLMpa7ov5zYr2ibjVNxVYHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7078
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/2023 10:00 AM, Chris Leech wrote:
> Make use of the new UIO_MEM_DMA_COHERENT type to properly handle mmap
> for dma_alloc_coherent buffers.
> 
> The cnic l2_ring and l2_buf mmaps have caused page refcount issues since
> the misuse of the __GFP_COMP flag was removed from their
> dma_alloc_coherent calls. Fix that by having the uio device use
> dma_mmap_coherent.
> 
> The bnx2 and bnx2x status block allocations are also dma_alloc_coherent,
> and should use dma_mmap_coherent. They didn't allocate multiple pages,
> but also didn't seem to work correctly with an iommu enabled.
> 
> Fixes: bb73955c0b1d ("cnic: don't pass bogus GFP_ flags to dma_alloc_coherent")
> Signed-off-by: Chris Leech <cleech@redhat.com>
> ---


Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
