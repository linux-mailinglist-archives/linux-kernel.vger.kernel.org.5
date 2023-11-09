Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C352F7E6D19
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343652AbjKIPPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbjKIPPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:15:48 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98AE1735
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 07:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699542946; x=1731078946;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wzmvrM39ArNU8Rxh0uoulhZaBbcVeD79s0dZ5s44W8s=;
  b=S+rf1wKaghvbjM5F3z11WM03aMOBbcvrugrzCORy3vrTRYy6QGEV/0sg
   PQQc1WbtGmSAdGcKgF2GRCIrf0bnOL/YCKBtZEiRfMAeEFVnk9YySlGr/
   UKUb+k+nJ90+TLaEtUo3Jncl24jFuhVfunIMPH2wXLdVUVomsPwuI/+r9
   lVd6pnjPBtyuwhzZUU6Mm6k61r/AphVNFpd2ROzmwqb0g35hwuwzzEkKa
   FZFp5Wg5/VztC8MxfVWk1hWz0QBZV7FVb7KH9Qxvq2jV5S2jSQeRAfczk
   3b071AyQ5+nT8cibwgClRib9CtS5HR73uJvY4VDO0VkDnIAsFjVYAbYjw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="8653581"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="8653581"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 07:15:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="763432711"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="763432711"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 07:15:44 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 07:15:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 07:15:44 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 07:15:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gufUHiZgvrXCOXtZAwNd5ruBRKCvy2VSxBKuraOFHu7RD/+JCYO1aaG/Z+W7H5MljFlVIzWeBHXU8CbbASbBJPbxph4eIooTQQeVad2Av+e4RJ8D4xpoKilBJCMtBrPV5n9QXuUEkfwkSYhlt5ZybDhpxtgzHJufUSNBM5Uewasz+aslZTAbo/u1Sne/V4ynHPd7mNlUWr8i+uVqRHXCrJ7ufj6kRBpZpG7nybI//Gp+Jz+nZEAw9Lr2XCqUC7huAE21K8J9aco/LDrMRKkPLAb5UlWaxShEUcQbEYaP/IRVYFzFT0ybb+wKSI7Q9N+04HRiGx5GxD5WokTzUOh1VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JK/Hja8I0EMSk/NdozL3DefAmVeFJw4OUFqg3RFFtpY=;
 b=V6EWNY3w7kssCFy6TgVwK9qxIiT0M554+JTiuFDCwKAKxAuir1f+k4wpCKVA2Gizwi6MsEyNQrHkY3lsCtYb9ZBLLnHHR0056xt5wyYngDV+Wv0qVMsJp5mpAqL9Tfht4DEiW4Ef0ikcN6B8EN3Jzr1LnPD+sKwJE5CNgSsy1S+SGF/GvtM+21aQ6DWnOawkJ4F+epUHxJY8oBvYCbnHIWkLBErt9nVs173ebuFNW3fRb8duOwhtcLzy5ApI+ge+yNTgbCFvGqxA/n0PdTamKQr9WjJs8395hHeDoOV21hDZL6dP/NudJcWpUP49ydWHVtBagif5leLFbMYUP2DuTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA2PR11MB5017.namprd11.prod.outlook.com (2603:10b6:806:11e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.30; Thu, 9 Nov
 2023 15:15:41 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::53f6:8fa2:1b02:6012]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::53f6:8fa2:1b02:6012%3]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 15:15:40 +0000
Message-ID: <fbdf3664-b162-471d-82bb-58356cc4f7d2@intel.com>
Date:   Thu, 9 Nov 2023 23:15:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Question]: major faults are still triggered after mlockall when
 numa balancing
To:     Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "zhangpeng (AS)" <zhangpeng362@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <lstoakes@gmail.com>, <hughd@google.com>, <david@redhat.com>,
        <vbabka@suse.cz>, <mgorman@suse.de>, <mingo@redhat.com>,
        <riel@redhat.com>, <ying.huang@intel.com>, <hannes@cmpxchg.org>,
        Nanyong Sun <sunnanyong@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com>
 <20231109141141.GC8683@noisy.programming.kicks-ass.net>
 <ZUzs2YfXY3zBKIx9@casper.infradead.org>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <ZUzs2YfXY3zBKIx9@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA2PR11MB5017:EE_
X-MS-Office365-Filtering-Correlation-Id: e380c9db-6521-4722-90dc-08dbe136bc20
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eH5zgaQ4qDhb+IJTvPxVFB7dXt13vyuUIQX8V35DFmrS5RECI5E5NZXIQ89sUlwATnpzvXqlr0fMLMT9OZNH/SPo0qOSZkrrK4OnpQ3tBYyQGW4NFwVU5kKZOU435OppxmegvrXwYa0FlGXZx2n763iho187d6FEbj33eXto8rzN+OdyVt4gTZti7nQ9tjfQDaSsqdBkpCGw9eC393Og7YjL7lDJ+6EGIMG8LTI1tV1ED5c6SdqOH+IOV+6bujGWbudgUpHHAp87Z5ea1c7AwayK/ZW8GvV0UzTjdeH4RlLOoyDQ/la0PCu8T+YTO2oY1dOsIjyNRi34oBsTmOP0C9o54bBaYlhEZJLRe4ayVJHvbygiQS7GAcpMHodTVDaarvOOrbtbdaaNOAE2gMK3nqNgw7GsPiWKK/ltcCjswZpPFnoFwILI4n2l9IQsXAgYSaMFYt1ZHIbBHOmumaSS/0h5+9YqiYnXBwFTewvJ0m0hVOyv3E++wLKgcycBPfVgIWN0528IFB6pgNSfQT6M7fpwsjEjQEYDCTvXOWR4uuGpP3W1ihnkNMNuQxJ6kvDoXSksX5+H9BbnkVKB8AR0bIawmZ8uwkM+QA/QsKF/MXbpypfYezZ8mFDnS5/N5a+wRoHMCsGvtIHfyMV8oFdO6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(346002)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(31686004)(6512007)(53546011)(478600001)(6486002)(2616005)(966005)(6506007)(6666004)(38100700002)(36756003)(86362001)(82960400001)(31696002)(7416002)(54906003)(66556008)(66476007)(66946007)(83380400001)(2906002)(41300700001)(26005)(316002)(5660300002)(8676002)(110136005)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0MwUWs3VitGQklmV3VkNUpMVG93d3UyQkFQbUZlVDNuMTVEZG02WWVnTith?=
 =?utf-8?B?QWltQjUxSW1JbVh3N2pON092UGZONHJNQmUwbVpaOFhCRU50aHdDVVZGU2pp?=
 =?utf-8?B?MTlNUzE5TktrTGRxSWh6K0wrdld3MzdSY3IxdWV1Q2hmQWhYU1FhZUpXcEg5?=
 =?utf-8?B?MmtQM3VOOFJ6czBLdnQ1UlRFSWY1R0t6Rkc5akdLRGF6RUJGVE84aFhNME1S?=
 =?utf-8?B?NDUxTjdZQy9nVFVoNXhYVFAxeWpnaERWQlAvK2VUYWhxOERqdjVSQXdKVW1x?=
 =?utf-8?B?cmRodmFNaExCUHBQTW5ETlJHYmJiWXlJMWFkdkxwSkRNenlZWlRZSkNLODRX?=
 =?utf-8?B?VmlTREJKSDRtZzhRcTF4WUlRUWZOSnhlek8wWjNVQ1lWLzAxZ2YvdFhWTnVT?=
 =?utf-8?B?Y1ZGZ2pJNHZyQzRKVkw3eXcrMXBmZkl1OS9MWTJ1L1JNaldqb2FRQmprVG50?=
 =?utf-8?B?SDFjcnl0Z3ZsWlJ0Z0gzeTRTMGhkU0dKcEp6QWgrZGUwd3I0K0dVMys0bUQ3?=
 =?utf-8?B?eCtQMjg2TkpSaS9rU2lUQXV6L2VhbE9Mb0hqSUVkY3V4ZEJSMkd0aVJCRHpp?=
 =?utf-8?B?YXVuUTBMa0VjL013UFpYK0Z3S1grRGVlRmpVdlVCWCtOR0czcGcyOTFjeVg4?=
 =?utf-8?B?Umo1bE5YMHNXTEU5WmxnSnVlK0V6VGRnVkpuMitrWkYzL20zdnpMMHVHNVU5?=
 =?utf-8?B?L0ZkTWhXV2ZZTWhiMnBlOEZhYXNrckViYWVtelh6V1pwVjUxR3FONTNtbE5x?=
 =?utf-8?B?cXMvUzR1SHljY0I4Q01MQS9lK3Z0S1gxZFZwVmp3aEZVSzRTVmlVQlR6ZVls?=
 =?utf-8?B?aTI4MG1ULzZwckhzWldybkVqMG9LWm9tc2JMK3lxRG1MUVp6NW5ZYjl0WGlr?=
 =?utf-8?B?T3R6c3Vua1BkZGVQaXAzdEJ2eEFoUWVPMTF5NG5yZzBKQ2IrU3d1dEt0dmFp?=
 =?utf-8?B?andIVVI1N01SbkhhaWhQOTZPc0hLanhNMzc2TkROVzdSYzR6M1Rra1JOMmdB?=
 =?utf-8?B?aTExenQrOVFsVXVtY3dONWpZaGJBZ0F4WmNkK05pVzNtdkVFYmp3b0lBeVdo?=
 =?utf-8?B?N1gxY3VSVVAyMUVrNDQyRU45cmFvK0lsRzdJc3p0MnRKOWc1cW5rYnhFMThs?=
 =?utf-8?B?WUdUSGxtYXVJa2hGMFp2ZzRXSUhwb2ZCdlQvZGN6d0I1S0pvbnJQSk1mRjB1?=
 =?utf-8?B?V0hITUJwUVdDc1pieG1LV3dVKzQvMkJsOHVyMlV6dEZMMndGVXBqZmtldlE4?=
 =?utf-8?B?Q0lreEZ0R2ZZMkhxamZWak9IMlVveVBLZWdCSGF3Q0JCdDNneUovREpXbzU0?=
 =?utf-8?B?ODVpeUFwUE5FVENIMG16M212M0Ftblg4Tm1hZWREbjF4WmJKKzZYcnZpNCtu?=
 =?utf-8?B?L0RIazdKckZRYnVqYUp3ZU9CelYzVEhmMTM1NEFiTTMxMzR1eHpGT0hRTW1h?=
 =?utf-8?B?ZkpUdE9KM2VnNHphYVozZUtjVFNwY280VXJnUzd6cll1RFlnU0VYUmREKzRa?=
 =?utf-8?B?SDFuYjdkbDUyd3hkNHRwWUdOMnJHdklDSEhMN0orTFVJMzB5dGQ5NzMvdG9R?=
 =?utf-8?B?WmhmRnE4R0w3cFJBRFZQYU1tM3g3MzJKL2t0UGVLSVkxRFZXVGJoOWFuS1JQ?=
 =?utf-8?B?dGl0WU1LaTJqOVVpUFJxczZJanNCMkRMTjBIZXZ3dll5MWlQMnJqU0ZqS0Zu?=
 =?utf-8?B?ZHBIQ3RsWURsNFczNVQxZFVZZktRZmFvbzNTdGdXOWlma1g4dEN5VmsrK0pp?=
 =?utf-8?B?R04vRjQ5ajBSVDk2ZmM3WXhjbkJ6emZwaFllTnNIaGlTanZLa1EwcU9xWmRx?=
 =?utf-8?B?TFgydVpTMTVwWVh4SWZRODRBa3JjKzlhalEwaUlYTERERXVVUDFhTDBTNm5h?=
 =?utf-8?B?QjdDTkEyVDduLzRXUm1RNUd6RzVVOXBJdDhnZnZCQStkZEZ5ZmdKOW5IU0sw?=
 =?utf-8?B?SU1GeHBYVWdIQTdEcGhTSDEvejBCR2hPb0tNalJ2bGVldEJUY1paYVNuRFZJ?=
 =?utf-8?B?Y0hiM214a28vMXdMYTJTVzBhall0Tjc1RVBlT2RGNlR0eVVCaUc5Q0NhU3cx?=
 =?utf-8?B?aUJ1L3FpRUQvSUlSTlZsYlVkb3ZxdElQTXBxaURuZks4c2ZUWTA4bDIwUVZj?=
 =?utf-8?Q?csqIbWJ0tMowOhIZxdvBcX9Jh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e380c9db-6521-4722-90dc-08dbe136bc20
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 15:15:40.4894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVL0rIIPoMRuEGhdS4p2kHc9MpzmbgfacEBXqLd+oiGnEdSm27HXI/hnRuORxlkJDxzx2NwjhCaB1XppcYe0Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5017
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/2023 10:29 PM, Matthew Wilcox wrote:
> On Thu, Nov 09, 2023 at 03:11:41PM +0100, Peter Zijlstra wrote:
>> On Thu, Nov 09, 2023 at 09:47:24PM +0800, zhangpeng (AS) wrote:
>>> Is there any way to avoid such a major fault?
>>
>> man madvise
> 
> but from the mlockall manpage:
> 
>        mlockall() locks all pages mapped into the address space of the calling
>        process.  This includes the pages of the code, data, and stack segment,
>        as well as shared libraries, user space kernel data, shared memory, and
>        memory-mapped files.  All mapped pages are guaranteed to be resident in
>        RAM  when  the  call  returns successfully; the pages are guaranteed to
>        stay in RAM until later unlocked.
> 
> https://pubs.opengroup.org/onlinepubs/9699919799/functions/mlockall.html
> isn't quite so explicit, but I do think that page cache should be locked
> into memory.

Here is my understanding. It's related with write to a mlocked private file
mapping. From Peng:
"For the data segment, the global variable area is a private mapping".
So it's data segment of ELF file and mapped privately by ELF loader.

For this case, even ELF loader is updated to mlock the data segment, a
write will trigger COW and a new anonymous page will be allocated and
mlocked. The original file mapped page will be munlocked in 
    do_wp_page()
        wp_page_copy()
            if (old_folio) {
                page_remove_rmap()
            }
So it's possible the original file mapped page is reclaimed and later
accessing will trigger major fault.


Regards
Yin, Fengwei
