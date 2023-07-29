Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2039767FBF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 15:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjG2Nxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 09:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjG2Nx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 09:53:26 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369DE10FA;
        Sat, 29 Jul 2023 06:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690638803; x=1722174803;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B0MewXeiXgYrhBzX8uAQ1ZxgCyUaYo50KqjQlW7sC2E=;
  b=IZXAO3TN1B3aMkrIUUthR5YAKmyQQXOzwtL74TGq+cLCiTQ4mZ5K0G/Q
   bsI6qVq5WkRIRb5k6NkYb9mB/spOx/cP20YOkPzL6XDgh3seTQG1zBjbd
   7gOR6opH1zdYOA+5L+e7L7wbaMhw8e998xbaVOhW7ZU0J4exrzNiPl3qE
   JhQVpu9z5gXN467gxvLNhMfuVXvwqz12Xd0DejA/MGiUUKaC87Z738Qxf
   P5Mx9D40hAQRMH+UnB6KndoN+R4TUbc2NYk/6vU+nkd8l9se3cz1RYIqW
   PPhWOxVDzDjzmb/JklBGdYyPy7gnL9XWpsl79T5TBu+f+Lyyp4iiXfacL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="349060876"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="349060876"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2023 06:53:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="762861469"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="762861469"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 29 Jul 2023 06:53:22 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 29 Jul 2023 06:53:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 29 Jul 2023 06:53:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sat, 29 Jul 2023 06:53:21 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sat, 29 Jul 2023 06:53:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwTCaWIU56eWj79cE+vhomBBAa42a9j9S+S3JLFsnH/fECcjkBLpQWihGI/ovSJ7AInPamP+9V0ev9y7SFaKUSP3z8Ny1LUyBd5m+WM5xIzc3+pww83gUs/giyHrq5e7WIZPK2uQx2o9E34UxVEuYAqUOHj2jITCflx/GLDjR+v5tgAn6wtPEaINHjmC+iQDj5VTaLsWpZkiMRfZOxTdjmD962sKpPewLVrtm5EnubXKSZpYh1pC2hXG+HuDaz0pYqNDaykgRZBGFIUPvEKQ9yWciAVLjdigB7C0E299U/c6YvC49lx2dg5ujNRRf9e1+VkPJi10Hww6eH13nQMeZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onXSiyRMLpy4ukK1bK6cf/S6RzMR2iCKccKGZ1id/3Q=;
 b=c4mD6WdEwYYxKnZ1jEPnkJ1f0itoiaCo/r8ISA1Qwms0JvZZgehfv+Brm2UwVXzb65PXi5pqZCr2EMPKJkc7Ct2kqpZOnJWdGLC9FRPpZedotKy5Zw+n8SDZo+ioopsVwMQKOgltflTUhX448aycXYPqPatvMQiHxAza3IdgVkJqOstFHdktaTMcZH62nZfz89bQWmFvjRGQ1oBRSTuyMVQBFRf3uqnrFmdbejNiPlk34YrXzpnQPF0Vxvq48wN5ZvGWLR+EDiqUr18yrs69VmxpKxyE5gJ/z1iYBBolacBMQGsK2KOVtGML34OO5m1S8fG8CF1Zay8uzFdX6dPJhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA1PR11MB8489.namprd11.prod.outlook.com (2603:10b6:806:3a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Sat, 29 Jul
 2023 13:53:19 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6631.039; Sat, 29 Jul 2023
 13:53:19 +0000
Message-ID: <24e7429c-14ed-d953-e652-eac178de76e3@intel.com>
Date:   Sat, 29 Jul 2023 21:53:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] madvise: don't use mapcount() against large folio for
 sharing check
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <willy@infradead.org>,
        <vishal.moola@gmail.com>, <wangkefeng.wang@huawei.com>,
        <minchan@kernel.org>, <yuzhao@google.com>, <david@redhat.com>,
        <ryan.roberts@arm.com>, <shy828301@gmail.com>
References: <20230728161356.1784568-1-fengwei.yin@intel.com>
 <20230728161356.1784568-3-fengwei.yin@intel.com>
 <20230728104103.1357b394f9be6352a7c54c79@linux-foundation.org>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20230728104103.1357b394f9be6352a7c54c79@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0201.apcprd06.prod.outlook.com (2603:1096:4:1::33)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA1PR11MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: 5170ff08-0c16-4edf-96d8-08db903b2a02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kPg7XlWY/bceMMAqDw1xIu8R5VyX2cAyOcZRAtUfntHSsEckyuLj2CsPzGIULoAnA4BjAiKqkBV4EyF7OvZHAlJWKLRGzgFAAcZ7fC4CPBV2lilZGV8b9jH/LAiLMNi9aPjJdjfsm6mNH+1CI2mm//JvJfkuUI0Xo+nfFydAH0NFSFTsfOPWafXBpatgVGqcnf4HjukXDDeuvwZzrkcE/jWZgINM+g9ctrJeTNlRBsy9qV4NGMheMSLUPf7BSlHzzzVwG+5wdNPpgdqWyMg/M5R8ZxlS6WahnJBoN2pVDO+1MY0cu6fsMua6vr3qSPO++DldbxazZgCqNVax5Ez7AnoAyTvK1v16JkQcRJ+tNWVsewRWEFaJea97/BisYugm6+qYOHM2xr0q3BN+fGa6HQeHYoR+4LEIHbWXTE+D4tBGnURJ5EzLF52WSpkUm8useVyuP/onBU/k+ECEDPnnIVxLLvSwDeBmqCo0H9fW0Q1e5d62gZE6LH9cMa0KCyrKr86Bzc9wMSkBIz4BBAuOLGqatI47XtEp67cPP0mdTO37hwe2rMdfo99nSnmPpwpOCUDgmUOe7VvYOrccHR/1bGZbAgPjpl0gWrdZJcwkwFs3pj6hqcYXo5hEwLkEQ7sHQA+IqCCzBttTqXbCJAyDDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(2906002)(83380400001)(6486002)(6666004)(2616005)(38100700002)(36756003)(186003)(7416002)(5660300002)(31686004)(86362001)(31696002)(316002)(26005)(6506007)(53546011)(8676002)(41300700001)(8936002)(66476007)(478600001)(66556008)(6916009)(4326008)(6512007)(82960400001)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzRFVEtrVGtWYy9mU3F4UWdqaEdtdk9RejBGVU1Od3dnOHpiY1paNC9WTWJk?=
 =?utf-8?B?QjR4Tk5tZmJqUGpJUVlKVnRqRWVJSXlKT3ZaVVlEQWtzSmM1K2hNYTBHTTlq?=
 =?utf-8?B?OExsV3UxK2Nqd0hhVjB0VHo5Rk52NWV2cmZwK1pnUFVSRmhkVGd0aUp2bUht?=
 =?utf-8?B?eDVlUkZHcnA1OEJpWFhwMUZoTlVCY210ZVhPN1dnVVNNdUl2bXM1SnI3SDlB?=
 =?utf-8?B?cE5SNHcyNFZPTlZkTUtUR3VZd08zbU1nWTFrU0hSVGhMTDl3R0RhT3FMUDlF?=
 =?utf-8?B?RGo1YXhkMlF3TU1keFZpSXkxeEtObXUxMnBmRTB5RXdZQ2sxbzk3VDNlUVNS?=
 =?utf-8?B?Q3pVenBINW4vRyt6b2hlLzFCMUxkYTFreVQ0Tys2R2p2ZE43QkROUTVWOGVq?=
 =?utf-8?B?Wnh3S3BkTjdtQWYybWl1UUpkUTVnSlZyeEJDNWRMTHZjcTNDMjV2Und4L2Zq?=
 =?utf-8?B?dUV5S1ZtKzZwMWlZZWtGdGdUTnRvMGxrS2JBdUI2Vlk5WVgxL0hoRC8yUHdF?=
 =?utf-8?B?RFhVSWtnNGpWVGpyK21DRUZkZ2QvbVVuaE1NSjZHT2FiOENlV2VqSlRFN0lq?=
 =?utf-8?B?N3VrWXFUS3R4YVhIdXp4Tkd1dXdSOFdqckdIVFhuN005MStoQ2dsVG1xNTA2?=
 =?utf-8?B?U2tiYkYyYlhRb3J1eDhBSUtkbExxeVgra2tDQzlKK0RLZlduTU4vMytjU3dO?=
 =?utf-8?B?VUpNMFM3UDBLOTRSbUw2L0Y1emhBRTVJdllmaEVMY2h6RFRSdVFIWlVRRjJN?=
 =?utf-8?B?UkpQNHp3eS82clMrUmdqZVNERFpQYjBKZ29lbWpZQjJtdHlSMW1tcmcyOUd4?=
 =?utf-8?B?RE5rNk95aWovVU5yWXRMYndaUnBtUUh0b0lUYU9pK3lhY2kyUWc4Q3c0NWVX?=
 =?utf-8?B?NG1qSWdHR20zSmt3MFlSeklMdGh3N2dNRFRhbWVRYVFobHV4Rzd5N1NtaHBH?=
 =?utf-8?B?c2g4SmJyUkVPWEJkWmZrVFJZN1l0S1BrRjVHZERSdmNSTm9tZmxPRlRBdkh1?=
 =?utf-8?B?ZndCbXhNUUZxbnEybGc0VlJxRmlhS3RxNVI0dXhaeFBoWHkvMWVkQVJ1ZnVU?=
 =?utf-8?B?N0lCc3BQazZ1M3c5WUFTSkdhSytEVy9zRytCUEYwSWpJMWZuYXhvRzFhYlkw?=
 =?utf-8?B?SmtBc0JCenN5bjljRHp4RWxoaUNEOVZzR2VnZXVJQjBHR2pjS0JENE5BamhR?=
 =?utf-8?B?cmpVNVdUN0pNN1lHQzY5ZkNIdXFrbXl1WFJjQWtqb3dpaVVwc1BJenNVY3JW?=
 =?utf-8?B?Q29rRzJhVHBDWWdpNmc3SmxaTVJjNko5dld5R3M2RlpyNm9uM3RldXM4OVVq?=
 =?utf-8?B?QnhiNzR4cHdWKzFBZDJ6cUgyaGR5R1lKT3JXV21JWEVQa3dadXJhNXA5b0lT?=
 =?utf-8?B?SUx1R0FIT2JhMFRGNnRySG1hMXhBVVc5NmJhZlZFVm50R0laVjV2bEoyNDdJ?=
 =?utf-8?B?bi91K1UyVDdWc0IyVXNqZWt1dFY3cGsvQXB3U3FHQTRqcnRPVyt3dWNrUXRH?=
 =?utf-8?B?TlkwRFh0SjdTZmdyR2lxcmpoUDY1WVFrVmpueUdWdXZ6MGhieWxWeU1DTTFB?=
 =?utf-8?B?Z3FhZERpaU51SUJlQmxFdC9JeEIyM1gxbk55TVpOMGk1d1lubDlnTVZrTzEr?=
 =?utf-8?B?dGpXVkdMbE1qa3JuU2lDb2lSbk5INzZxejVQNG9ZTUJGUlBEcDkwTXlPbXlP?=
 =?utf-8?B?WWxOQk84ejlWR1l3WVZQQTNNbnU1Ym0yYi9ESHl3L3prNmgwcTIxRTN5OXEy?=
 =?utf-8?B?ZUV3TDFSVmczODQ3enVrRlFmQmJUOXN2OS9oZmlLUm9hcDZPUXJNUWt2TTBJ?=
 =?utf-8?B?VzRHbC9Od3oxNUdTZ3JUTXpRZWNKZlhUcHU2aVUzeGxkMFhGNU9NV2QyU05r?=
 =?utf-8?B?bTUrbkVpL2lKemk0R2tMMjBTb2pRU2RRbC80K2ppOTF0Yk5GME9hekx5a1RP?=
 =?utf-8?B?bW9tUHIxMXVaMlBQUnZlQzdpR0xiTWFFSVAwMmYrZUpiNjlMR2pxOG1ndnVS?=
 =?utf-8?B?WHlvckF2ZkNxdGFHVHdMZ1FBa1krSHQ2cTdnRXJ1Ry9Fc3ZzbzlXalJmLy84?=
 =?utf-8?B?ZWRKMksxMEJRdU5rUE5LM0l4VDhpUkVya0VDQ3dCV25GUjhSM1o4QUMrVXR3?=
 =?utf-8?Q?DKwIhqbb4erUHqCun8naZKT9l?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5170ff08-0c16-4edf-96d8-08db903b2a02
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2023 13:53:18.8534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tt+vbRiYgsLDONaPMFgIUXoYoIaZaxuJlI0oVDKSutIhwQUGZrT7vJE0w9VWR7nfrDkM7Y03zSkP639ioas5YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8489
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 7/29/2023 1:41 AM, Andrew Morton wrote:
> On Sat, 29 Jul 2023 00:13:56 +0800 Yin Fengwei <fengwei.yin@intel.com> wrote:
> 
>> Fixes: 98b211d6415f ("madvise: convert madvise_free_pte_range() to use a folio")
>> Fixes: fc986a38b670 ("mm: huge_memory: convert madvise_free_huge_pmd to use a folio")
> 
> Having two Fixes: for one patch presumably makes backporting more
> complicated and adds risk of making mistakes.
> 
> So I have split this into a three-patch series and I've fixed up the patch naming:
> 
> Subject: madvise:madvise_cold_or_pageout_pte_range(): don't use mapcount() against large folio for sharing check
> Subject: madvise:madvise_free_huge_pmd(): don't use mapcount() against large folio for sharing check
> Subject: madvise:madvise_free_pte_range(): don't use mapcount() against large folio for sharing check
Thanks a lot for your kind help. Will be careful for the future patches.

> 
> I haven't added cc:stable at this time - that awaits the description of
> user-visible effects.
The impact of the patch:
  Without the patch, when user calls madvise() with MADV_COLD, MADV_PAGEOUT
  and MADV_FREE, it's likely THP pages will be skipped. With the patch,
  It's likely the THP pages will be split to pages which will be made code,
  reclaimed and freed.


Regards
Yin, Fengwei

