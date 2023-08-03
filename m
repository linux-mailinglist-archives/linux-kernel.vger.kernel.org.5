Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB90876E5E3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbjHCKue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjHCKub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:50:31 -0400
Received: from mgamail.intel.com (unknown [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BED30DB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 03:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691059827; x=1722595827;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=fsdPQZzGGJZx6ZHV2zG0A8uxzk316pGfz9rmkfOGrUs=;
  b=GvRhkMzb+URl3pYyPXlqJSTk/rOjh0MfZxQ8UzRdzijF8Ise3MQKhhkD
   2w2EjkHGawPAcib3bzAzxTrLvMZPNLygcFhsxBs/m37Mya4GF+J1nMIdS
   GNJLz22yefkVGKyM70icaGLkDh/MYGxv8XjF+K4bAWJQWIXs2jGljDZ8m
   giowIa8q0opbtRqr2a+vPZZHRwLhqycG58NENs8KBkfLLt70neNQLxc7x
   7n4mpr5bnvFYASr3DgXRB/bNm9osGF+iiWDoC3nDqp/+RMef1l5mzZrCX
   aEd2GA7ENFlFUA4GhFEag7rytIl19WmdJ89Q+fpKoXPw1I5OcJKiYj1vL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="436146472"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="436146472"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 03:50:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="794952435"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="794952435"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 03 Aug 2023 03:50:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 03:50:25 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 03:50:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 03:50:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 03:50:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgbPgSlgKadauUtDVlndVqMk3M9evAYdYNyeIwGOhddlnMU/sB/MOQOM3vCWuSgs3cRt5eyWloPn79UW1dyQyV8Z75KC7SsyfH3/wM8azU08lNWE+Twt827mC/jKLWnCun57DbSlzW9VkrClvCcOev6kAIOHpMu+PpPeZQvVQiGw41eIoh/UqadAjbcHWELpqe25jhfepYa+UrPMwrC9zgkgWYsnSWUtY0hnf4CZRNuUNY1t99LMDM7t63ivT/Q8W6Y8uRnI8Qy44uJSg+BK7nUwI4wxLq0/LO54NNNNwlmPJB1FEsocndXVlZQ87Lh4uiCpnllKCMcoY63Gni+4hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVpZDlWZFKeyCJJ9TW2A7n02dDQZcM9FJgdLnbqybAI=;
 b=U3LMZvSnTXWmQuPPCmR69eWUIIBsPhMtFrQNCjgLYsWLG2hhy3Ecc15gLlg5uJVFlb0gP+F3reSmDRV0Gsgu+QUqPAg7toRLver2JihLRoyjUIcYGJ7I9mo3C5C4XJ7lgXmpaCN/krhRU3+AQdNyVsENOCRKN0i4l0C3NOwfNFCBMh97bPCIqjIIfgK5yby/1crUp67N8W1H8PzCYThMgSeGL2we5ZElJ8k6CPaZHc2xq0fdR4igxqaAABBHHXTjXbXMmGdsUXy4oBkP/vdpWEixDVe2B+jcJe7LDFWUStqvWCTWehYGpGu1OwqqAR37nQpmKk6+q50fyiY8kwgb6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SJ0PR11MB5629.namprd11.prod.outlook.com (2603:10b6:a03:3ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 10:50:23 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 10:50:23 +0000
Message-ID: <66332544-c102-9134-a1a5-c4e4a82b66b9@intel.com>
Date:   Thu, 3 Aug 2023 18:48:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] mm: add functions folio_in_range() and
 folio_within_vma()
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <yuzhao@google.com>, <willy@infradead.org>, <david@redhat.com>,
        <shy828301@gmail.com>, <hughd@google.com>
References: <20230728070929.2487065-1-fengwei.yin@intel.com>
 <20230728070929.2487065-2-fengwei.yin@intel.com>
 <502afc9c-0760-76af-d224-2a3428089850@arm.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <502afc9c-0760-76af-d224-2a3428089850@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SJ0PR11MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a8f868-5ad1-457a-fd9f-08db940f7043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x6dXoxYqtWKOiXYwA6h7Ae8rLe+/5IbCDuiTS2v26y9tQI+gXp5YrfXfzko2fG752krwh4HJqMwSAM246sxo+13XpWdh+C3i6LmysAexzU5vb6P1Rpwtwhj8gVTnBec8SezBjHH1RXxMl0Qn567hw0xk5Kg2Tsgtv7kchfQm77Rx/D2zrXqVIzGS9F55NImwTOwMp0TubF1j5MI0liJgNywJRKh3XwgZ7e5i5/az3U4iWi37D9yMLWy+nIO6giv/5zYkeEWr42emwNY9sKxLNMMQWg6e2fz8oH5G/7DVFN51/gzyDR6BSENHiKsyjIL0k8dFQ+lyE39X2XFUILTI7vE7NHBQw958P7+F9sKQxVCN8gZ2+QWy4zB4eZ8DbOQWA5c3v2W6r2n8OnqdIV0VzxvwDcCYK6vnklQPV1IC/kCaCg7Jk6R/Io9BB2nV8v1uVUSGUg0BEEXnhHv2HFntiQ+pX5AAGrxYF41N+9S1l6QQslS9oYCUX5+ee/WY3blMpfR+NUVtiLuCRHLzDKFepHWO0VNzdvPwzw18vQQSuQzb4rxYiav3/uxZadmwx+yDD+IjJw8i5XohGetky4TVw1rMZUMXr1Y7GQaOswvlZQWq/xbWynxe3VR9ffG0AWdW9tDTqf6d5t/0QSSBTgM4Fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199021)(31686004)(2906002)(6666004)(478600001)(6486002)(6512007)(36756003)(83380400001)(82960400001)(2616005)(86362001)(31696002)(316002)(66556008)(66476007)(66946007)(8936002)(8676002)(186003)(38100700002)(26005)(5660300002)(6506007)(41300700001)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmNuMU01YUx0TkVSWUp1aEJEOUNxeTE5VVNOTlh6Z2N5dkNOaW5CczZNb0Rm?=
 =?utf-8?B?Q2VhQTMvQUdQOTJFaUVFRzIyWW05T2tKSy83YUk2ajhoenhqclA5WTFJQWhh?=
 =?utf-8?B?djNSK2xFOHk0aGJxVENiVzQ3Z2lxakN2VHBsL3RtcUUyQWtrNG4rMFdBRXd4?=
 =?utf-8?B?STlXOTM1NFE2M0xielJTZ3EwR09Bc2tpQ3NnY2tQNVV1SFFqcVhQN1NSWGVq?=
 =?utf-8?B?ZTdvV1N1NjZ4Q3Z1WjQvZ3ZBRWVBK2hKV3N2TTVpcVZNRzI5eE82d2JiMEEx?=
 =?utf-8?B?Q1ovMUo3R0FxcEVhTXEyaGlDRGlJM1hDc1I2ajJtMTJ2aFFPcE9OTXhUbjVK?=
 =?utf-8?B?R0tJMThWRFBPd0dhTmEvNllYTTVRYmV1b1pmTWlqZ1VMbnMyanhyWDgzSmY4?=
 =?utf-8?B?dUR5QXF1c0lnblpja3B0emhJcXRqRVlEVjNqTDJDVUZacHY2VitaK09TTTJE?=
 =?utf-8?B?MVphZ1JUazViYXBmWGk2ODdTUGVOSEx3TkNMTEQ2NDNoS2ZLK2o3MW1IRWFV?=
 =?utf-8?B?REgwV1Z4ZWJTS2xGVFZKNlFONGdFNjhVblVRc0grTEowWU5zZk5nRUNhdEhZ?=
 =?utf-8?B?TEdjVnFVRHlaVE9vQkowanZWMWZsUHZUa2RkNjM2WDVRVnpwbERlUEJZWkpJ?=
 =?utf-8?B?N29JcGRxN0d1UWZvTklNZDVDV1lZTDJyYnAwVFRxVnFnVlFvRTU1MUZVMkkz?=
 =?utf-8?B?UkZ0T2xlbDcyQUtvajJzcEFLVGtyYlhXWFdrRk9VanRBcjRvWVc4UVNjOTcx?=
 =?utf-8?B?QmpkTDA0YlBWc09ra3ZWRVRqdkRQa0w3MmdkK0d2bVAvcEJMQ3cvT3pxdCtZ?=
 =?utf-8?B?enNhQUNyUy9aeVozUEtQRzVPaTF1bEUyaEVhMllPOSt2bGtGZ01TR0h0VmtY?=
 =?utf-8?B?bGpwbnROa0RsN2Y1RDVOMEFzRWxuVFVialZubVh4ZkJRZzRxWGpHSzl1WkhN?=
 =?utf-8?B?dEcxZmQ1VnNxWFNkOE05aHF0NmdWZVo5bXBtTm9kNklzYWQ5K2NuT0hwRFZv?=
 =?utf-8?B?RGhncmJ0YmVkQzZkYnVhdk9zQ1VRY3ZnM2RWTVE4amt1Ri8rZmVPUXVkdlMv?=
 =?utf-8?B?RjJOWFJZWlIzWTlBYTAvQURCYUt0S2R5VSttSS9aSERPRS9jOExaRjF4d3JV?=
 =?utf-8?B?aTV1RHA3NEQ4SndpdWcrb3ZaY3RhVCthMSt1UC9RZDg4dkVYa2FYRXBaYXJB?=
 =?utf-8?B?NG91NVhmQ3UrTCtpK1YxRmIwMG9IR2lWQTRON2tHcndvTkhTZExFMkcxTVpw?=
 =?utf-8?B?VDFEQ2ZqV0ZVV3FoMzdrczJQdER5b1AyL0FCVUdOeWxKeTdCNkRQWmZkYnVo?=
 =?utf-8?B?aHBFMDl3Mmo2S01XenJKTCtDVmtWS2VzNG9UWkI4MFMvRUVLWndiNFNvNFB6?=
 =?utf-8?B?RXJkdDNnV2x5WXYvWDlNK1ovRnMxOXJvcWE1Rmx3K2FJanZsWUdWOVJ5blBJ?=
 =?utf-8?B?cU9LQ3NSWDdMcTRNd0dpNjlQTlR4NWJTUnJHeEZiYUpDa0JySnZ0VmJkRHBO?=
 =?utf-8?B?Sk9pZG8yUlRtNWN3UHB3NEp2Qk1IT0srR0tHalEzaEVRTjBsVzFCUjN1c1pO?=
 =?utf-8?B?aDJhQStvRjJNSVFXS3N2ZC9pQ1E2bzN2SnBxQ0dpYjRwUHAxSDlpM0oyLzlS?=
 =?utf-8?B?M0gwUzBoemN1TGhVdlgrYkFHWnk4OEVYSnJ4YzloVVNjQ01sTjhxUkFmbUtK?=
 =?utf-8?B?c1J2ZzE4TkMreHdaMmo3Q0lMWkx0eGRSbGZsWVY5bjh3YVRpZlJsdUh3Szcw?=
 =?utf-8?B?SDFJb2d0MmlPd1FJeFNHcjZNUHh3bUwxeHhXUWdkMnpxbTVJeG5oNEh6MThu?=
 =?utf-8?B?UVQwQ212QXlrbjlqTGFUcmxCb3JFUUtVbEZGTDlEcXNXTkZRczhZaFE4WC96?=
 =?utf-8?B?K0hmSGh1cEFvTDU2VEZ2ZDF6MVloVVdHRVVHVWhZajZxb2s4dnJsc3ZVc0RD?=
 =?utf-8?B?NnRtVEtSa0FzVlYxL2dycktsbnAybG5DblA5L2ZxSkVwb1RwQWx2bFJPMEZG?=
 =?utf-8?B?ME9SZ3hhZGxyUnJzeWRKTVErTUVYTG1jbEM3d1BtRFE2TTYxQmJTVGRUZmJ2?=
 =?utf-8?B?RlE0V0NMREp0TmpSbDN4eE5SS3p2SHNIODZDYUVqL3M1UkVCWW0zZS95Ulht?=
 =?utf-8?B?TEJGL2swR3ZCWXREdEJGWWpuUENaZXhuSzhNVHl6NytrMFRQTEp3dzdkcUpJ?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a8f868-5ad1-457a-fd9f-08db940f7043
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 10:50:23.4333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9KKw8UgcIfElM880w4mR/iWCRCPKnq0QBHcYyTsVIOfWLaofZkMr96jfk0dVRhXFkn/6fPCwJtje9D9PYTlR6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5629
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/23 17:58, Ryan Roberts wrote:
> On 28/07/2023 08:09, Yin Fengwei wrote:
>> It will be used to check whether the folio is mapped to specific
>> VMA and whether the mapping address of folio is in the range.
>>
>> Also a helper function folio_within_vma() to check whether folio
>> is in the range of vma based on folio_in_range().
>>
>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>> ---
>>  mm/internal.h | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 69 insertions(+)
>>
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 5a03bc4782a2..63de32154a48 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -585,6 +585,75 @@ extern long faultin_vma_page_range(struct vm_area_struct *vma,
>>  				   bool write, int *locked);
>>  extern bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
>>  			       unsigned long bytes);
>> +
> 
> Hi Yin,
> 
> I wanted to take a step back and consolidate my concerns about this function. I
> should say that my understanding of the pgoff and index stuff is shaky and I
> could therefore be wrong about some of this; if this is the case, then sorry for
> the noise! But something about this function doesn't smell right to me, so I
> figure its better to raise it...
No worries. And thank you for looking at the code ans share the comments.
That helps me a lot. Really appreciate it.

> 
>> +/*
>> + * Check whether the folio is in specific range
> 
> What exactly is the function trying to do? I *think* the intention is to figure
> out if a folio is fully and contiguously mapped within a range of virtual
> addresses belonging to a specific virtual address space? And I assume you want
> the answer to be precise? I'm assuming 'yes' for the below.
> 
> I think the only way to do this is to actually check each PTE. And that causes a
> problem, because a folio can straddle multiple PTE tables, which causes PTL
> locking issues, and means having just a *pte pointer is insufficient if we need
> to traverse multiple pte tables. So perhaps you need to allow for a false
> negative in the case that the folio is not contained within a single pte table.
Let's check the users of this function first:
 mlock/munlock: Needs only care whether the folio is in the range of VM_LOCKED VMA
 madvise: Needs to check whether the folio is in the range of VMA and
          range [start, end). This range is from user space. It could contain
          VMA range (in this case, we only need to check VMA range) or is contained
          by VMA range.

So we check:
  1. Whether the folio is in the range.

     To do this, we need to first check whether the folio->index is in the
     VMA range. If not, we know the folio is not in VMA range. Just return false
     without further check.

     Then, we will check whether the folio is in the range which is defined as
     [max(start, vma->vm_start), min(end, vma->vm_end)).


     This is the version in RFC as I was not aware of mremap case and forgot the
     page cache case. So if no mremap with an anonymous folio, this check is enough.
     But we need to add PTE check for mremap and page cache cases.

  2. Check PTE for mremap in middle of large folio and page cache
     If the folio is normal 4K and if the folio is in the range, it's not possible
     the folio is partially mapped to two different VMA. So we are sure this folio
     is in the range.

     Currently, check PTE didn't handle the case you mentioned. But my plan is
     checking whether the folio is mapped cross page table (by checking whether
     the folio start vaddr and end vaddr has same value for low aligned to PMD_SIZE).
     If it cross, I will treat it as out of VMA range. Otherwise, we can reuse
     current check because we know the PTE pointer is always valid.

     Obviously, the PTE checking needs hold pte lock as you pointed out.


My understanding:
pgoff is important if we have folio and VMA and want to know the virtual address of
the folio mapped to. Like first, check whether pgoff of folio belongs to VMA, then get
vaddr by:
      addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
rmap_walk() also depends on pgoff. You can check the vma_address() and rmap_walk()
implementation.

> 
>> + *
>> + * First, check whether the folio is in the range of vma.
>> + * Then, check whether the folio is mapped to the range of [start, end].
>> + * In the end, check whether the folio is fully mapped to the range.
>> + *
>> + * @pte page table pointer will be checked whether the large folio
>> + *      is fully mapped to. Currently, if mremap in the middle of
>> + *      large folio, the large folio could be mapped to to different
>> + *      VMA and address check can't identify this situation.
>> + */
>> +static inline bool
>> +folio_in_range(struct folio *folio, struct vm_area_struct *vma,
>> +		unsigned long start, unsigned long end, pte_t *pte)
> 
> The prototype looks odd to me; Fundamentally it seems to me that you need the
> folio, start and end virtual addresses (the range you want to check that it is
> in), the pte pointer and the virtual address that the pte represents. That
> virtual address allows you to figure out the offset between the pa and va. Then
> you can look at all the ptes to figure out if they reference the folio's pfns,
> and use the va to pa mapping info to figure out if its within the specified range.
> 
> I don't really understand why the vma is useful.
> 
>> +{
>> +	pte_t ptent;
>> +	unsigned long i, nr = folio_nr_pages(folio);
>> +	pgoff_t pgoff, addr;
>> +	unsigned long vma_pglen = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
>> +
>> +	VM_WARN_ON_FOLIO(folio_test_ksm(folio), folio);
>> +
>> +	if (start < vma->vm_start)
>> +		start = vma->vm_start;
>> +	if (end > vma->vm_end)
>> +		end = vma->vm_end;
>> +
>> +	pgoff = folio_pgoff(folio);
>> +	/* if folio start address is not in vma range */
>> +	if (pgoff < vma->vm_pgoff || pgoff > vma->vm_pgoff + vma_pglen)
>> +		return false;
> 
> Why is this pgoff calculation helpful? Surely it's only useful if the folio
> belongs to the same file that the vma is mapping? Otherwise the folio's pgoff
> might be referring to a completely different file than the vma's vm_pgoff. So
> you will get spurious results.
> 
>> +
>> +	addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
>> +	if (addr < start || end - addr < folio_size(folio))
>> +		return false;
>> +
>> +	/* not necessary to check pte for none large folio */
>> +	if (!folio_test_large(folio))
>> +		return true;
> 
> I don't understand why you don't need to check the pte for a small folio? As
> above, if the folio doesn't belong to the file that the vma is mapping the above
> checks seem wrong and you can't conclude that the folio is mapped in the range
> without looking at the pte?
> 
>> +
>> +	if (!pte)
>> +		return false;
>> +
>> +	/* check whether parameter pte is associated with folio */
>> +	ptent = ptep_get(pte);
>> +	if (pte_none(ptent) || !pte_present(ptent) ||
>> +			pte_pfn(ptent) - folio_pfn(folio) >= nr)
>> +		return false;
>> +
>> +	pte -= pte_pfn(ptent) - folio_pfn(folio);
> 
> I think this could wander off the front or back of the pte table into arbitrary
> memory if the folio is strddling multiple pte tables.
> 
>> +	for (i = 0; i < nr; i++, pte++) {
>> +		ptent = ptep_get(pte);
>> +
>> +		if (pte_none(ptent) || !pte_present(ptent) ||
>> +				pte_pfn(ptent) - folio_pfn(folio) >= nr)
> 
> Doesn't !pte_present() also cover pte_none()? So I think the pte_none() check is
> redundant?
I think you are right. pte_none() can be removed here.


Regards
Yin, Fengwei

> 
> Thanks,
> Ryan
> 
> 
>> +			return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +static inline bool
>> +folio_within_vma(struct folio *folio, struct vm_area_struct *vma, pte_t *pte)
>> +{
>> +	return folio_in_range(folio, vma, vma->vm_start, vma->vm_end, pte);
>> +}
>> +
>>  /*
>>   * mlock_vma_folio() and munlock_vma_folio():
>>   * should be called with vma's mmap_lock held for read or write,
> 
