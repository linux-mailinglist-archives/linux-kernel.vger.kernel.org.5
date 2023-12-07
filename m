Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6450A807D75
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441938AbjLGA6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjLGA6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:58:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67EE18D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 16:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701910722; x=1733446722;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OT4gVueC1x9tAVKK3KWJFCqkjfNPIIc6r9NsjYgxcN8=;
  b=Bjareq2RoHdzGODJGaKA6yrag0mHhCSdAKfpsSdfvdaYDhmXeKYWivub
   nw8awYsZ9GjhtjuSKPOqpFa+RASPvyrPF4Yag7CSG7G75Zr6EgFc4oOm1
   FxQecQfch0iCQ4xaqD/goPaNqyGJHBtILhgXRdRSVdjiG3rXFUC1tdoRV
   k5/tRV+H6MhAiaNYhtwu68HT/S5lRgM6uvnzbBHExf7Mfy7egwRCVbb/f
   mx5YFWDqMrgmCdrmPwg26mvOZcFoMJ/CzBoa4QdHufvBln+zWUwJFmfzp
   FfQqT++uZL31yJBeSJuuKucRI2vMwKgOVgnml+V8bXnC4tZuFgCVxWyJB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="458476362"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="458476362"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 16:58:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="944836731"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="944836731"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 16:58:41 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 16:58:40 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 16:58:40 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 16:58:40 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 16:58:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nw0Nf+HBD+i1GtImUHcOM83WQxdv0xP6C7/+izXyAxzcrNXY8TAIFoZbuqOXDgVjj8hIGOYwKySHi2yE9pv/u+ar3xVYYDnGhW3G2+//7knthMDg9Wc2WYTcZRSkTSuw9G47ZD9ZsJsmNMa7bWlN2MSQzG6n3g+Ik7v/r9Q4CW7S/kgWRyhwJKcoL5P2HQC58K27BIVf9sykqNlEQtzPfE0VNMgg0K4d2YNR0bNCZpQ4K1v4uk2LJBkvP85cUDHOfMVmY7Xr3BleKGJXEg4I1yzu9GS6Vd2oaM02B2PlriMqsJBDRJtD8EDrugQJyPVLykUHAzXdjLkRmyhdtyF/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlO4RjNKxGmGl+twwyoKh1nW3Q2S5zHO2Qs6CqZ6CR0=;
 b=Gnejn3bC2xz38LLtWxdYUSGYsYfS8NOB9cD9XPLk/2LyDX+dwB/0Z/3bOaMeoFXwDK4ep12JGVPfYiZXHws/3d/Shw4VxtHoNyzhE1Q6AzysHgb8YpreVIWqgyMHOWrD23kO0BXctRlNOPAY8NeW7MDy0/greuJ//N3yhRjiamCuswdtkNmi+68s32o7yPceBLliq0XcsLdAdYS3htOoaCkZfADRb9AoGFCnpBkisq0SCHlqtojCC7UOI4my3bRWg2aeGBtfmOo15OBeRI11OaW0WVeAY/RnvMczLVg2kReSBVkBorJzGT5Fnuh+6BVAJHpKnm54NwW8ie3Zio1MPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MW4PR11MB6716.namprd11.prod.outlook.com (2603:10b6:303:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 00:58:38 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 00:58:38 +0000
Message-ID: <76fd4d99-e7b5-4fdc-8864-af4a198e9981@intel.com>
Date:   Thu, 7 Dec 2023 08:56:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 02/39] mm/rmap: introduce and use
 hugetlb_remove_rmap()
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
 <20231204142146.91437-3-david@redhat.com>
 <ac9a63ab-e83b-41d5-8a59-c4a137cdebd4@intel.com>
 <e2061158-678c-4a3c-b94b-88005cff15b1@redhat.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <e2061158-678c-4a3c-b94b-88005cff15b1@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|MW4PR11MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: 0008f894-6bdc-4bf9-59ff-08dbf6bfa516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xSrMz0oAe0t+SINsaRMTU+DBaojVT1aTf9lNSYy5eXSknwW8dH6W/rbkbYnE5Li12mCaVp92w68yBSl7pAYtrHsGqKkRQ8cfWOaosHjH2XYsY/wcqRGboUqfvNNIo42/UPgW2GM4gnj+6udmPpx5+3YQOmz4Jbb+RV50QDCs1J42aJtQGfQiFbNSDryWiUamQe7CrPyxs5ucQXMP/eedpdN/UF0HKpuMmQ00CcejlljbADAJhLaj8wfGZi+b2xizthp7gqErggU9ZKO3tUMW13myD6gw/JY0RdimrfBiCHHa1S3TzbBQHqmUBXHZEIjKz39/okQ5oSIT44VSXx3D638qKHBydtdYIRUWXdFS7j8im+mjWOkfPXGdQBhLhFqXlRwilo22F3wGZ9ExBAXenllcMGYTXkmF6Z4MlrAaQseiVI5NnPObwciinjfx6FqT4uvsLHTgBIFMZl8kOBw9ATZngIzQE6kzqreTs+5e+pwYwRaJDmMlPNWLPERR8zzo6W27xNYHXteYiQIOMIHDy/op0haD0bYCy13qqo5818Byk83F1HhiRQMlfO5WA15lvrraCkpy2jfvvCAnxYnT+wnwFo0cpB47x49sHKVS1Ml0DLZ7X+loIk9gDf1A88nPNFzT4DRbghljmwsrWmyiiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(136003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(8676002)(8936002)(5660300002)(7416002)(6666004)(36756003)(2616005)(6512007)(53546011)(6506007)(54906003)(316002)(6486002)(66476007)(66556008)(478600001)(66946007)(41300700001)(4326008)(2906002)(4744005)(38100700002)(82960400001)(26005)(31686004)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3lDOWx5dkFmbEhSR1NuWGk1dWtVSlF6SS9KN1dKd0ViejREQ0VpSlE5NlVy?=
 =?utf-8?B?dUgrdmdYOFpNRlByWGhaTlRZaFZZYzFuaUVxVzV1aThDTzQwQXUvU2ZVMWpo?=
 =?utf-8?B?bGlmR2FYdUIyUW5zQUVvdHFYM2p6WWIxTDRCaEFCcm9aTG1pVlgrVWt6Y0pr?=
 =?utf-8?B?MWpFWnY0R0ZrUlJGSFVybGY4SXRUK2lOZkhDVVB0V3ZmOXNYRm42UTNRd2da?=
 =?utf-8?B?eFJwMGNSMjFUdGV1VGdiVFEzYldVSnFIWVJNd0xJOXVUTUNTQ1NZbm9CNG1u?=
 =?utf-8?B?a1U4RjQyUjg1ckQ5bTQ5TlR5dzJwaHllSFZFNWJkeXR6djZUNUFPQzdmK1Fl?=
 =?utf-8?B?M25ZR2Y0eWlUMlZJQUVXV2pWbk96eFhWbU1CWDRnaHdxOE5DWmd4RFBnaThk?=
 =?utf-8?B?NnZKMVR3aGdPTXMySzVqQmtyMTJSZjMzRjQzV0ZaSXZpZkxuUWRsZ1VaaUdi?=
 =?utf-8?B?andXcDR1ZHFOdHRBaDhaV2xXUUVTbkNodjlpWkZaRHV6dkFGd2l0ZHFlTTRi?=
 =?utf-8?B?VjEvdHFSemNEelgxV29oMFBUb2xyWHVnSG1wSVdXU3hjWk9QRlNJMEZQOE5s?=
 =?utf-8?B?WmRIeGF4elVLR2hMdnJldTlPM2xZK1RqcjFEcXI1UkFKaFhTd096Qkt6dUY0?=
 =?utf-8?B?VkVxN0djTHZVTDIvc1BJODFsVFJLYW5ZcXFLbklnNjhpcHA1dllIMFRYY1JU?=
 =?utf-8?B?ZHVkNmVsbmNmVi9nd09VNmdKY2RyRG9vZVlVNjhtZFVHZUgyM2k1UUdBbGc2?=
 =?utf-8?B?bkFTbEwwMnZLcmJobU1tTVZZakQ4czhQVUZpNlpObFNJUnU2UXRSMGZyQnB3?=
 =?utf-8?B?VlBSMVdjVWRVUFF1S0VHa3BwU25nQS9ENlR2NCtpbnpCNDc4ZzFwNnN3QUFq?=
 =?utf-8?B?R3FlZGZheVNEL3poV1M3Y2FWWGQvSFZTa3dldFh6MXhlTGFmQThUcjlxUEhR?=
 =?utf-8?B?VmlVY2FOL29QWXkwaTl6RkoydzMxdlFxT0YzTGNUQnoyT1BvVUVYNXRBeUZs?=
 =?utf-8?B?L210MktFRXdIOTlCOVBwbFVzUFZxN2YwaTlXaERNNnJrR0ZMNU8vK3VsYm9J?=
 =?utf-8?B?Sm0ySGV1WjNZc01FQ3lyU0dGM3laTDNNci9UUklsdE5VbXZjUXZwcjVIMEZG?=
 =?utf-8?B?RmtMdmVDWTdQenhyaDNpazFSU1VaZ3l3SWlwY2c4THBtVHdtMlRTRnRBdm5i?=
 =?utf-8?B?djFoTG9MOE85MEN5d0JFNTBMSFFZVWo3K3A4bVZhRFZmNzI0UnJSdFhIOWZC?=
 =?utf-8?B?NkF2cmNueVJFKzhCNStEdGMrZjdtMnhzVTI5dTdZbUI0VGhNbHBvMm1YRzJv?=
 =?utf-8?B?NVlLRzhsVEpoaVVaMlNTQVRpUjBXMUo0SllHYVRGRTNGNnh2bzlxOGU3c1NS?=
 =?utf-8?B?Yk81NnZmU3dRVFF5clVYNTZpWHBCNVdZdVJMNGZXb3NTN0F1SC90bjhWRExW?=
 =?utf-8?B?UklxdzFYOFdkU3NTQlRHZzlKd3k5TnNLSy92ejhIWUhkQ2t5dndkUmdSWi9F?=
 =?utf-8?B?ejJkK1ZzRnBQSy9yU0g0UG9EZTN2MUp2Zk5GYVhJYmFXV00vRGVPTTJ1d3NV?=
 =?utf-8?B?dFNvT1gzOUVpWUFMVnBFVzJvL3ZUL20rOEMwMmRVNjRPTlUxa3gyTk5vVS81?=
 =?utf-8?B?bzUzZHVpUUJVcFpNKzFTanlPUVlaRE0xS3lVMXQrK3h5NWp3bVFGdEl3bXJN?=
 =?utf-8?B?SXByRFpWR09HakduNmhmSmE3cG9uZ0pJc1FQTVZxUVB3bDZNa0ZyV25yeUds?=
 =?utf-8?B?bHQ3NlNhYVZKN0Y0SVp2bExZbzU2OTVSbmRVSGFTV0pkcXRhR3FXT2dLK1E4?=
 =?utf-8?B?UTZ2aGljRU11Y0toSnVrVFM0TG9XQTRGTTBTNEJHSHFJTGRFWUxhZmNTM1g1?=
 =?utf-8?B?WGRuWUorRjdkRURIZWxzVm41TURUU1BUdUZFWGpXR0VxK0QxeXhuVnVFSCtY?=
 =?utf-8?B?aFhyT0JGTVV1Q0JDdE1iRTBvRXplYUQ3RWcvWjFTMlJXVE83THc3MTJJakZa?=
 =?utf-8?B?Q0toRmJvaWMrcVh5dkFVekc0K2FWQzA2eUF3NXBoMUJCdm1qQ1hJY3ZMYWd2?=
 =?utf-8?B?YWVzL2ZzbEZSZm1ISmo4a0JHSHdUa3BRSEt4T2ZzZDhnQjh3QUU0OXZncHMx?=
 =?utf-8?Q?1gzY6iPmvj2032l1TmbTzka/O?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0008f894-6bdc-4bf9-59ff-08dbf6bfa516
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 00:58:37.5907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ykqdz+iXhgqGw+1GJ1KqXbOK7DcJvJbvx4i81JTnED7QXP1cCOWY//2Bmn2hlsq2Og+6kWq0pw5MDIkwgd5izQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6716
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



On 12/6/23 20:11, David Hildenbrand wrote:
> On 06.12.23 02:22, Yin Fengwei wrote:
>>
>>
>> On 12/4/23 22:21, David Hildenbrand wrote:
>>> hugetlb rmap handling differs quite a lot from "ordinary" rmap code.
>>> For example, hugetlb currently only supports entire mappings, and treats
>>> any mapping as mapped using a single "logical PTE". Let's move it out
>>> of the way so we can overhaul our "ordinary" rmap.
>>> implementation/interface.
>>>
>>> Let's introduce and use hugetlb_remove_rmap() and remove the hugetlb
>>> code from page_remove_rmap(). This effectively removes one check on the
>>> small-folio path as well.
>>>
>>> Note: all possible candidates that need care are page_remove_rmap() that
>>>        pass compound=true.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>
>>
> 
> I suspect you wanted to place your RB tag here? :)
Oops. Yes. I meant my RB tag here.


Regards
Yin, Fengwei

