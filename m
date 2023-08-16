Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8345E77E10F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244952AbjHPMEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244990AbjHPME2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:04:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CC42121;
        Wed, 16 Aug 2023 05:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692187467; x=1723723467;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Ll7UvJB5CV31469/d/BJt54nenooFuPTE7nvuqLi9a8=;
  b=KrN7vwneWLZhYMxDJSKg5u18bEVx1FJV/cVaktUesdP0IH97zNxQqyWj
   bZPclo95VjiSmNTC1YeUz4hqjiBqs0+SWeKMIeb+Vo8/jJP7CKfJjEZuV
   b/oMBCnOsjVrWclB0LDMhysG8RILnNhzV4d+52JA0dUgEMLvWdf7ldlHc
   fhLsYTrcbYAZYmwnFYrVfj3+Zibv7w10zn80hStjzj6Q43LdZG3G4SXA0
   E6RdNnNHTp4jtr5XfvtVwTGHkTiVr05BNwee82diqa73EBHAIwUY2cftA
   vgQhyFkrX0vwZ3/s0zPY8V3SNxg2KBTiCrw4LjI7TEP4R9sLfBhSR+zOC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="352838153"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="352838153"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 05:04:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="769161301"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="769161301"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 16 Aug 2023 05:04:25 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 05:04:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 16 Aug 2023 05:04:25 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 16 Aug 2023 05:04:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3o3IWLsLhkVZ2QvIItiSViRaJJ/9bieY6B3G9hat0KYcne54gNbOX/QUcqstOM99TeNiy5MHKOT93Ary1ZjiLaNWpQhYtJw5aOyO1Jb4CCminHh7/l0LnlfQvYDOmm1lki0rmF9wzwGCHnMs6GuQ2RKgDc5E6Hrkl9kV13qnYtcR8s8g3H4qdyyHTAjWOry9JY55h1A0cYIfBWU37hsD15JFeRx7OFu/IzBqT1KBZdpGrGEihN6bFprOWJxt0SRHeaqq0suLXNmRcguPNmHu+C4Co4/N8ONRbB+pokJ59U83R93SvKCDLJdJlmCwOBPTCzVMRv+lqLYeOJq5+WYjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTka6RKPcgP5buvcb4PBnw5VybHQx1EoEle9A0K8c3c=;
 b=WTKBGV1xtd7teSrOd5Ky0x86wtdGV68iNJlXPNNfqzM1eUVKuzOK0IeFS76hO1ylZW4tXrA88bGYPMz2YKUeYaPK8oQK0qCcJFA6RPeRDZN6YmWMONLiETO4zHESyJH8O3h7LxuKEFauz1HxDIYYX64DU2qxZ2rX7gqFCjr0m0UE8LQZBPK85isfYFnlnTvIuCVXFI9mi67racISzJ8AuobFtXhwzD+R+SUWCjQ1Kr75JZ2EnFr5vYKE6zNLXXQxsDKOSL+ZZbFVExZvhncT3CfE0i3yM9SLP9xf7FKmG/DBp+ZtQ5qXz81r9ybBxUESe8n8RX275B+cNAkZG9GYzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CH3PR11MB7761.namprd11.prod.outlook.com (2603:10b6:610:151::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 12:04:23 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 12:04:23 +0000
Message-ID: <4412ad3c-ebed-40a4-8f4e-83bb1b53b686@intel.com>
Date:   Wed, 16 Aug 2023 20:04:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] madvise:madvise_free_pte_range(): don't use
 mapcount() against large folio for sharing check
Content-Language: en-US
To:     Daniel Gomez <da.gomez@samsung.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "vishal.moola@gmail.com" <vishal.moola@gmail.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "david@redhat.com" <david@redhat.com>,
        "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>
References: <20230808020917.2230692-1-fengwei.yin@intel.com>
 <20230808020917.2230692-4-fengwei.yin@intel.com>
 <CGME20230815132509eucas1p1b34b2852a9c4efe743c8da82867c4cc3@eucas1p1.samsung.com>
 <4jvrmdpyteny5vaqmcrctzrovap2oy2zuukybbhfqyqbbb5xmy@ufgxufss2ngw>
 <2bfa1931-1fc6-5d6f-cba1-c7a9eb8a279a@intel.com>
 <svdxtqiihsjwcbxjp67s6cteprhoxgypf7rjrk2v73ppyn2ogp@ee4ru6vgspl4>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <svdxtqiihsjwcbxjp67s6cteprhoxgypf7rjrk2v73ppyn2ogp@ee4ru6vgspl4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CH3PR11MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd93e40-385c-4ae8-e8f8-08db9e50edd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SuPF5ZTtMbp2i+a4RBYTZK/FWTycc3S5CF0EaDQtILcnL5lEDNjIzIMLrgZ8vaDulKtiQhLhqTFMiRsUazwR4D4pEjfLUYqxOsga6eZ5EOmea4O97ytujxMFfaSTHInh34HKusU9poToJt9d9po3PzJUmOTe4it174uc+EoCd5bHU7cuau8iYpGPxfV1xFct/PimupnFAXYkg85KWdVX4PHXBwp2F07vj693YbZgMGhP3HxaZ90eS8e//BAP7xrIwC88/REe0AVD3ZQVdNH5EPfpSpoPxwL3EvfwAbZ1wsN5cxBinX70tRoNc/nSEK4krLQ+DoDhlOHOHbftnD1K/nOM3HgO+LBGaiMl8tY8fhkrkOvPXR5qysqpP0Lqfo4k6LXGKq1piMG1E1qmldl4wTUf/TUa6e7A/b829W3UWO0DjEpFq+nhLBKwII7GzmPo57+wad3pu03ITxLR9GiiQr7cXDN+NqnozIQED1iyliRkVrhPDFp1Ae9h8iXBEDWqCd+ta5wXU3gZ7q7NmgVnMLp61Psrtc9cYp4QpPzqzE13DqdP4Nt08FmcmOnWviuvF/k9mvah4LlzW8dOfG0YmLyQT+X1J+h6KJYtB7u1+XVaEQ0bTCl6JJ1qEBhBElKngx3FFP76PWfs6oB2+k2Nzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(1800799009)(451199024)(186009)(316002)(921005)(66946007)(110136005)(66476007)(66556008)(966005)(41300700001)(5660300002)(38100700002)(31686004)(8676002)(8936002)(82960400001)(2906002)(83380400001)(26005)(478600001)(7416002)(86362001)(6512007)(53546011)(31696002)(6506007)(36756003)(6666004)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0E5TFNsMUxCTzF1NVFsOUlXWkN3RW1rYlhabkdQeHJvZnAxdDZpYzJzN2wz?=
 =?utf-8?B?U044QTUydVdPQkl1dS9CL3J3T0lPRm1sV2dZa3ZKM2s3WmtXM3NkY1dLUGk0?=
 =?utf-8?B?ODFiRWdUOXgrR2puamRubnIxRmlNRXl1QlFWaWQ1eVc0SFM3cG4zWXFsdmpa?=
 =?utf-8?B?VThlcEx4SElVWHFKRFBmaDBFeW55eURyWWlmYTJvTGttaXRpOFc3UzZCWkpJ?=
 =?utf-8?B?ZUNBaThKRSt2Nk5EaVQycWZ6UDFYTVpLcnBOeHVmSlh1Kzl1QWk4NGVzSnVM?=
 =?utf-8?B?OG9YdDNIMmpGbUkrYXFva2Zxd0VqOFZCY0t3bERUMW5qRm01U2lVQ0FENVBD?=
 =?utf-8?B?Yi9ZM3FlQWQ5elR0aENlMkZsZWwzbkNhQkRveU8vTXlnVmw2RlAvSE9DUmFn?=
 =?utf-8?B?YTEyQnNWN1FNTXA4TGNhNnFJMGJNcFh4VVVtKzcxcWhxekpkYUNnZVh3WENk?=
 =?utf-8?B?blpVQjVraHFuV1hBaVdxYVZMZmh6M2dGWCtpRjhDcVpZNk1YaDdCM1d0TGpZ?=
 =?utf-8?B?KzdsT0x1VWhJTjRwOHp2OXljQnhiME1TRG1IaStPRklLcjk5SkxseVNKc05E?=
 =?utf-8?B?UFp4Wi9xaysvZFBvYmFBNnMyc1RaWHNoSGlETHhDWW41eDh4Y1hXMnVpYnhP?=
 =?utf-8?B?RDlKcE5TU0w4NTNqQ1lhNXZVZHVZL3g1R1hpRFdxQjRmUUpoQVd3QnluTXZG?=
 =?utf-8?B?bW1mQTRSZ2hIb3ZFREFrQ1lJYWREL0dNSlNxR1ZMNFNTWDdVM3pNdS8veDNW?=
 =?utf-8?B?Y2RrVTB5WEFNWFJ6RERmZzEwcFhxMmhIWjlCVUJhVGxuVjRkRWw2MURNcThX?=
 =?utf-8?B?ZVlxMmlmRUFMSDZkL3N1bFFCZ1hKeThrN1ZTWFdDU3Zhc3NPYldjTUc2ZXRv?=
 =?utf-8?B?ZUNrZ3A0UHhlQzMvdE5USys1VlJnM040RVFGaWgyb3JGQmpqUGZZSFM5TEp4?=
 =?utf-8?B?Zzg3S0NvMVR0K0drcWxpMUtoSE9BSFo2WkxhaXVXRUQ1K0FVNVdSUkhaVDcz?=
 =?utf-8?B?UEtoQUgzTUlLSlhwbExEVEpKM0ZxVHQxWW1mZkoyZEx4ZXNVRlpWTE9FKy9q?=
 =?utf-8?B?K3RKci81dFRRd0VvWEV5Ukk0YTBwQ25yWDNLbU9nS2dMRjlMWWl3eFhuVkNT?=
 =?utf-8?B?YXJuM0JWRllNck5hOEVPdjNNYmR5UUFPMVZQV3NaQWlQdG1YTUhCTXdJcnpn?=
 =?utf-8?B?VnZNK0NRemE3K0JhSGxkMmxtMWRRWTNkWU5sS21Qc0Fqa3FXZkpGYldQRjhs?=
 =?utf-8?B?U3lHdzNFRWovdGc3RjE3MEFDczZNZkQwUnBvWVhlUFVVOThSeFQ5aWlmVHda?=
 =?utf-8?B?MjRGWVVqYjBxSE9xOXZKRzRwSjVKNkYvZW9LR1NnMW95akwxWFJDcWVUNW5v?=
 =?utf-8?B?Rnh1R0RaWTRvd1VyOWdmbWd6WFdnU2R0YnplOTc0dzlkbEZxK3Jtb0VDQ09p?=
 =?utf-8?B?ZlZVREprbUdWSi9aYzh1WnF0VjVTckVoUjZhMVIvb0NCNllIQjA4akwxR2dR?=
 =?utf-8?B?VGpDajFzUWg1REVETzUzNGllbFp1Z3o0R09tbUlvQjlyQ2NCVG4wWlNHRWYy?=
 =?utf-8?B?YW5CNS9zQjkyTUV2eU1OL2pDTEhMcjB1dFY4SVdqUjZWVUFFd3JUb3diOXYx?=
 =?utf-8?B?TzB2RWpmZW5LQ3NaQUp6WmZuVlloNmlMYnRJa1ZWWmN0clltUmk1aURidzFC?=
 =?utf-8?B?aDQ0eDlFaHRQOXlzTUMwbjlHbkJNeGdBTU9kUVYxd1NGK1V6ZCtONXp2VW85?=
 =?utf-8?B?QWowbjdpbFBWYkcrbHBVOVBLUlo2RlBNWVZUVDR6bzJKKzJPd1FpaTF0cDkz?=
 =?utf-8?B?Y3YwM1RPSWlGbU5EbUNvZGt5cXFIMDdYVWNlOXNFVjFFdUgzVjlZVUROUUZ6?=
 =?utf-8?B?THFYK3NqOVk3dEcxcEtkS0V3SGswMDNWYnM2WURpTlRHcEp6V3BNbzQ4SE9I?=
 =?utf-8?B?LzkzMDRRVWlITXh6SDgvTG9mQktOY2dZbWdTT2xKcGNPbm9JdkpRWGZyM2Js?=
 =?utf-8?B?a1Z4Tk9NYkZGOUs1RHV6WVBlSUo4UVQ5OFlKTnY4a1VLZXo4Znk2OE1zOWtD?=
 =?utf-8?B?ZkZBWXVIOFBJQjdWR0FoVURibWhzRklRZ01MQzI4YTJ0QXJudnE2MGJ5cXI5?=
 =?utf-8?B?d1IwQXBpSFhicEhIN29XU3NFckdXR0tPOVQ0ZHNYNzhCOERnMHUrLzNOa0Ex?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd93e40-385c-4ae8-e8f8-08db9e50edd5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 12:04:22.9408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8OTouyBi0MTo5WPnVRlP+GCrlvbb8JHYNWn7gX5Rk5n9r3la4wowbKdJvX6euXpPxvFp4mZRgH0NxrcXmgGNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7761
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/16/2023 7:44 PM, Daniel Gomez wrote:
> On Wed, Aug 16, 2023 at 07:30:35AM +0800, Yin Fengwei wrote:
>>
>>
>> On 8/15/23 21:25, Daniel Gomez wrote:
>>> Hi Yin,
>>> On Tue, Aug 08, 2023 at 10:09:17AM +0800, Yin Fengwei wrote:
>>>> Commit 98b211d6415f ("madvise: convert madvise_free_pte_range() to use a
>>>> folio") replaced the page_mapcount() with folio_mapcount() to check
>>>> whether the folio is shared by other mapping.
>>>>
>>>> It's not correct for large folios. folio_mapcount() returns the total
>>>> mapcount of large folio which is not suitable to detect whether the folio
>>>> is shared.
>>>>
>>>> Use folio_estimated_sharers() which returns a estimated number of shares.
>>>> That means it's not 100% correct. It should be OK for madvise case here.
>>>
>>> I'm trying to understand why it should be ok for madvise this change, so
>>> I hope it's okay to ask you few questions.
>>>
>>> folio_mapcount() calculates the total maps for all the subpages of a
>>> folio. However, the folio_estimated_sharers does it only for the first
>>> subpage making it not true for large folios. Then, wouldn't this change
>>> drop support for large folios?
>> I saw David explained this very well in another mail.
>>
>>>
>>> Seems like folio_entire_mapcount() is not accurate either because of it
>>> does not inclue PTE-mapped sub-pages which I think we need here. Hence,
>>> the folio_mapcount(). Could this be something missing in the test side?
>>>
>>> I tried to replicate the setup with CONFIG_TRANSPARENT_HUGEPAGE but
>>> seems like I'm not able to do it:
>>>
>>> ./cow
>>> # [INFO] detected THP size: 2048 KiB
>>> # [INFO] detected hugetlb size: 2048 KiB
>>> # [INFO] detected hugetlb size: 1048576 KiB
>>> # [INFO] huge zeropage is enabled
>>> TAP version 13
>>> 1..166
>>> # [INFO] Anonymous memory tests in private mappings
>>> # [RUN] Basic COW after fork() ... with base page
>>> not ok 1 MADV_NOHUGEPAGE failed
>>> # [RUN] Basic COW after fork() ... with swapped out base page
>>> not ok 2 MADV_NOHUGEPAGE failed
>>> # [RUN] Basic COW after fork() ... with THP
>>> not ok 3 MADV_HUGEPAGE failed
>>> # [RUN] Basic COW after fork() ... with swapped-out THP
>>> not ok 4 MADV_HUGEPAGE failed
>>> # [RUN] Basic COW after fork() ... with PTE-mapped THP
>>> not ok 5 MADV_HUGEPAGE failed
>>> # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
>>> not ok 6 MADV_HUGEPAGE failed
>>> ...
>> Can you post the MADV_PAGEOUT and PTE-mapped THP related testing result?
>> And I suppose swap need be enabled also for the testing.
> 
> You may find a dump of the logs in the link below with system information. Let me
> know if you find something wrong in my setup or if you need something else.
> Besides CONFIG_TRANSPARENT_HUGEPAGE, CONFIG_SWAP is also enabled in the kernel.
> 
> https://gitlab.com/-/snippets/2584135
> 
> Also, strace reports ENOSYS for MADV_*:
> madvise(0x7f2912465000, 4096, MADV_NOHUGEPAGE) = -1 ENOSYS (Function not implemented)
> madvise(0x7f2912000000, 2097152, MADV_HUGEPAGE) = -1 ENOSYS (Function not implemented)
O. The problem here is MADV_HUGEPAGE/MADV_NOHUGEPAGE doesn't work.
Do you have CONFIG_ADVISE_SYSCALLS enabled?


Regards
Yin, Fengwei

> 
> 
>>
>>
>> Regards
>> Yin, Fengwei
>>
>>>
>>>
>>> Daniel
>>>>
>>>> User-visible effects is that the THP is skipped when user call madvise.
>>>> But the correct behavior is THP should be split and processed then.
>>>>
>>>> NOTE: this change is a temporary fix to reduce the user-visible effects
>>>> before the long term fix from David is ready.
>>>>
>>>> Fixes: 98b211d6415f ("madvise: convert madvise_free_pte_range() to use a folio")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>>>> Reviewed-by: Yu Zhao <yuzhao@google.com>
>>>> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>  mm/madvise.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/madvise.c b/mm/madvise.c
>>>> index 49af35e2d99a..4dded5d27e7e 100644
>>>> --- a/mm/madvise.c
>>>> +++ b/mm/madvise.c
>>>> @@ -683,7 +683,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>>>>  		if (folio_test_large(folio)) {
>>>>  			int err;
>>>>
>>>> -			if (folio_mapcount(folio) != 1)
>>>> +			if (folio_estimated_sharers(folio) != 1)
>>>>  				break;
>>>>  			if (!folio_trylock(folio))
>>>>  				break;
>>>> --
>>>> 2.39.2
>>> >
