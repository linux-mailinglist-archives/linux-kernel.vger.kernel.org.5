Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7E07EAEC2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjKNLYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNLYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:24:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92181D9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 03:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699961047; x=1731497047;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1+rDgLwGsZ1EOFIvCBhRWDBfpNmuRwbLDpEFLReNjmA=;
  b=eL/4ztfwQYvVSXBe0RcdFDFRrJln1F0I8YpTCCVAp1aeU+hB75cckb2M
   2ap8149OGfrZMhpanerKWQVgJwVLBMRUyotqoTNAc9daVulVDvBaRUJJ/
   1ICjiQKBS3Nmy0AHV/ASuxrhofIDmJ0JZ9e6nlQQG8WlkuA+wBG/+Iycv
   HQ4wRMuZ4KL64hncA4HvuUWazljPCb0FClqIkWj6tqaczoykd7F630oYq
   gNiyNvwrgLcTLJlU3l+ShIw35D/Fk9P/GfwPLXGurcX9qIWYYaZwwZkiR
   dogjMrgkseQ72b2jQkBgbV3uftwTcDj4/ODp2HUA2MXJx8+9mob7nD8T+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="3694792"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="3694792"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 03:23:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="938050619"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="938050619"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2023 03:23:38 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 03:23:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 14 Nov 2023 03:23:38 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 14 Nov 2023 03:23:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vev6NpLJ549KhvvN8WZ67h/XWDbhntDeCJ0cNHXc5NrEP7aW+rUHDS8LQ+tLIv8u+FvUV8881EsKn3GQePos9rLEdGw1sRmowyQ8SiOuC3On9aiCrKcYqSUP9uGnrPVzgOeDeZjiCiOnlSOgDUIPigC8tSQpJDFuwrwYmvHncuZxN8F/EQGrev12hmWeJt5BbeclrAws1kZvQQm++IOn3XTW6PZSfSZ5j9Oli9IDDXmj642OolDTPoZ/W9LwH1D1S9EqsF2iHPS3vTHRVt+8hFneUTUeSB3GdBoz5md4hSsSqbCGPtKjPqIoiu0BSQ5iNcEUHt61E/1cGHKTmZehFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fi+7Hv4DxxcavbB4/OyfeuOZwxB8oVIobF/GVylsLI=;
 b=EybGxVJ44cDQ67997owSl8TuuhrYQdgOEkAYupORNsc3jqHrSylgfMqL40B3V9x8JC87+7yYrLEFtn/h1hBuj5krl1GD4uyn0m2CLSO1tib+4+LpBkJjZeWtNnygbQDA6bJu+Rik5lYqrtHT4QRgHRWOG7GwMhD2A+ge4Mffv2ORmkObNVMFOTJ9o7bkdWvcTxw/Y2vZnMwb0CUvmluxWCsObLbpgCleNZmPYTjJMeUjxBgWda9siPDlpgL1NKcFmkxNvazl4VeJerBCKJyVt2WKqp9HO7uuecOie0zSIikfPkMWPGFVoiK+8VIXVSpKOZW84wx+qDKr3rjkeEOiHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MN0PR11MB6208.namprd11.prod.outlook.com (2603:10b6:208:3c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 11:23:36 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::53f6:8fa2:1b02:6012]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::53f6:8fa2:1b02:6012%3]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 11:23:35 +0000
Message-ID: <c331d19a-d467-4b9d-81b0-e3f727d17ace@intel.com>
Date:   Tue, 14 Nov 2023 19:23:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Question]: major faults are still triggered after mlockall when
 numa balancing
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        "zhangpeng (AS)" <zhangpeng362@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <lstoakes@gmail.com>, <hughd@google.com>, <david@redhat.com>,
        <vbabka@suse.cz>, <peterz@infradead.org>, <mgorman@suse.de>,
        <mingo@redhat.com>, <riel@redhat.com>, <hannes@cmpxchg.org>,
        Nanyong Sun <sunnanyong@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com>
 <ZU0WkMR1s7QNG9RZ@casper.infradead.org>
 <874jhugom8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <2c95d0d0-a708-436f-a9d9-4b3d90eafb16@intel.com>
 <87r0kufm15.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <87r0kufm15.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|MN0PR11MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: 5686ba65-30f3-4ff2-1414-08dbe504243c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HvsK5uC9lMKMkOloqeyOvAWn2I7DFO36yhS0TgW8cE3eDVRXdkwcBwMyyr4EG5V5d5Q9U6Nz44jKKMd/9RAfHVzWGq2HAQy0AdUkiwCX1Cpo48coKKyvDqj/ItPi48RgwYWrPlRbV7ZrNhvhX2fcnLA/0D2b5c2LP1fI66jidwSZyXhroOqppJE9AWRVA+P1qMoR54TzKRJMW4tbyFW6wwHcE1DfIbgv2Femg8SwFzpvRpaDAaC44fvMXhNjoJWK8AvOy1OyPkHJRRCK+RzuvfOPasd+Fpc+0On8Ix+XBaHMTLBEUNRD3mhXTSVTN7DdNGgrxZ7Lhy8gLFtgP6ZEntwzRPddXQFVFyY6Lxz7KUq8BttRjxB/MvE2euA6+xgDSYqv80JGQJ1rZetwyb2MfSJIPl92p+PggoMHcfZfZr7hEWtWZxWvQOWB87pjVO3QwVG8tU+3QpCsp363xBTGFiN9MSotiTaIg5JdWzfeVmPdg5CeuVvPA78pSd425zTYPHkKDwJNTLcQWPIKxpMpECCEppaW9Izvam1lXjGfjf/ZLQ09o5FeDc2sV24lmWIta5ajlPNlOvTzVmpZtNagR7B7rNbnIzvItL0PeKjecslug1vEdYrPKKaE9Kzf+VLhaQnrJ0ua0KDtE+++o8kcSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(366004)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(38100700002)(41300700001)(6486002)(31696002)(86362001)(36756003)(66946007)(316002)(6636002)(37006003)(54906003)(66476007)(66556008)(82960400001)(478600001)(2616005)(5660300002)(7416002)(2906002)(26005)(6512007)(6506007)(53546011)(6666004)(8936002)(8676002)(6862004)(4326008)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0R5Z1NIWEdDSUlZaUtFSGJjSE1CbnJvUFVCcG8zY0NUaWo4cmp6aEFsRGdG?=
 =?utf-8?B?c25QbXd4c0NHRElWZW0xQUdFNGJtK1lIdmswSEpESnVVN2lCVVowZ3JIcDVZ?=
 =?utf-8?B?UmVpZUJpVTZadjU0S2JJK3g0TVJxa0h6cXBNWDNnNjkvZm9PdXZMcER4UjZ3?=
 =?utf-8?B?clZnOGMvTFNscUxKNTFycGRYNmlxa081RU5UZlhib092S2lhaWN5M3FZOEgr?=
 =?utf-8?B?aDZYTk5nUXQ5czdQV3VUNWJqaFdRK09ZQkcyUHVVUWlCVXpGVHhrNm41dndm?=
 =?utf-8?B?ZVNmL1dpSVlQLzNGdFNQaUVtOEJjVGRETVVCSE5VenIvVFZabm9YT3Z4QzEr?=
 =?utf-8?B?c2d1Uk1qcjZ1eVBURzFDbFhubVd1MnVrL1g0MDY1WVdLdnZNK0JpbFJ5cU1E?=
 =?utf-8?B?cjNaa1ZVZFBvUWxNN21KY0g0TlhZZnJJSSs4SVdQQ2c0eXIyMVhIQ29ZYUg5?=
 =?utf-8?B?bXNlTTZkVVE5MmM1cEtTSEk4Z0c5MVYvMFBGdCtGcEtzWUcwWFhNYmVpUHJU?=
 =?utf-8?B?Uys4TUtZSXI1L1dlK3ZQV0JlT09uaWV6TlZHb1hZOEM3ZG9jNXdnc0o2NFB1?=
 =?utf-8?B?cGx6Q09Id3hJRExJcEZUUTBVakkzcnZoaTVJdG01SmdMUVkyMy8valFUZWRr?=
 =?utf-8?B?QzI3cThvNTNIMWRub2FKcUFNNHpwdG5nZ3RyL09Pd0pXeHpJV1FZYkhnS2Mv?=
 =?utf-8?B?WDVkMmpKWlYzSVJ1WjFRYlIwL0RINXQzcllaUEpkTUpQTzlHTjFEL00vSjBl?=
 =?utf-8?B?YWZuN1hzVUFLaG8zTmZycWJ0Vmt0cWF3YkZYMjNuV2ZjUGpPZzlsaGZLRlVa?=
 =?utf-8?B?d0JtRzJkNmN2bStqWlQxbjRYOTVmaUlOdkJwc3ZCYmRJYU54L0hXTVdHM1Bh?=
 =?utf-8?B?d21uYlhHc29LMkx2MC9YZWJvb1ByWG1wOWhFdzdxSXdoaWRJUVcxNGRxalpj?=
 =?utf-8?B?bXY3Q1JqUEFYL1RQa1djWjdLL0tBaWlrY015bFR0K01objNBR25FS3RqcWxj?=
 =?utf-8?B?V3pzZ3FKbXAzTWNOOVk1dWFkcmpGSXNrWkhSaDcwR2VPdFNJeVhDZ2lIeWg4?=
 =?utf-8?B?UmNYQlFVWWFyK2syZW1rSmVMZU0yc3p6Nm5tcnc1T0dlT0xTa0M2VFp5Nmx1?=
 =?utf-8?B?NklEdFgvRFZDWGtGRHIyUFp1Y0cvcmMrNGdwRklDZ0RMK1B0ZkJRbjhzbG1v?=
 =?utf-8?B?SDRhQ3ZNS0dwTS9HWW11S21ORWdPbVArN3dVUTE4dGgvMG0wMUhhYThUWFc3?=
 =?utf-8?B?MHJJUkpxbU1OaHZENXp1NDVlOEovWVdFQWdUcXkzSDlsZ1Q4d1VuWnlKMENX?=
 =?utf-8?B?aXltU28vellsS2tmdGt1TEZublQzaFZQZlZ1dFhtV0JEdWQwVUI4b2hrR0lq?=
 =?utf-8?B?Q3RGdmtmMnJBV2ZYRDlsK0pOU05WUTYrN1FzVnZsMTAyQlpPNEpVTnlVTHJO?=
 =?utf-8?B?ZlhCcERSZytUNFlzakE2RTdOWEp4UEtQejJPS1I4cXVHUlE3MzFhWUJvL1N5?=
 =?utf-8?B?dDIvOEhCZDJrMXBlSWMrZGVFWDFpeXJZckp1OUo2MmUzM05zVzZYQkRJd2dI?=
 =?utf-8?B?YTNWZm5rV2FNYzJSUjJDQm96bHB2TjZhNzJjWlNXcEN5QkFidDVXY1RaUG5E?=
 =?utf-8?B?dzBNRzJ3TnZkam5ZZ0x5ekZ6VUlCNEZGTWxBTTNRbytYN1ZjRElJekplUUQ0?=
 =?utf-8?B?dmNhSFBTc1NrcjJIUXMwM0NsU256a1IyTjI4U0phRXBjVEpEMld3eExIT2lI?=
 =?utf-8?B?ditGZTBacGEyTXZCbDJoUTJOVFJ4V25VbzZIS0ltTnNmR1U5dGdKN0hHdW9m?=
 =?utf-8?B?OHhtSThOK3ZlRDFFakZ3RFBwZUdzV2xkdjlOQndDRTgxa1Q2NHdKU2lSODVU?=
 =?utf-8?B?Vnc4UHh5NW5TVkhTNXJBNlFocDI0QmZ1UEdKM1R0amlnNGltandINmhWdWpH?=
 =?utf-8?B?V2piVDBXcTJLNHg2aWVnY0NHTzBTLzE0eWVCNDArcEEzMGpnMW9GTjJqYW0v?=
 =?utf-8?B?aDA3NVdqRkVORDV2c0NXTVVHNHE4R2FBMjBXU2VPdjlRNG83ajhSOUVmOWw0?=
 =?utf-8?B?elM4TlI1aUMrU0RTNkpBaG8yeXhTUktlU1pYV3pBZ3ZKSTNYUEh1aWpiMjhs?=
 =?utf-8?Q?yjQ53v9aa6HED7HcberB61D36?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5686ba65-30f3-4ff2-1414-08dbe504243c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 11:23:35.8987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gRsM6Lk/xqh2AmJfMs28bPctVDCTMhzI5LHTDxgzv8sTLjef3UkHs2tnyJz5k17afyc8rDJuOeXSCj/+PSuuKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6208
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



On 11/13/2023 10:02 AM, Huang, Ying wrote:
>>> There are other places in the kernel where the PTE is cleared, for
>>> example, move_ptes() in mremap.c.  IIUC, we need to audit all them.
>>>
>>> Another possible solution is to check PTE again with PTL held before
>>> reading in file data.  This will increase the overhead of major fault
>>> path.  Is it acceptable?
>> What if we check the PTE without page table lock acquired?
> The PTE is zeroed temporarily only with PTL held.  So, if we acquire the
> PTL in filemap_fault() and check the PTE, the PTE which is zeroed in
> do_numa_page() will be non-zero now.  So we can avoid the major fault.
Yes.

> 
> But, if we don't acquire the PTL, the PTE may still be zero.
For do_numa_page()/change_pte_range(), it does very limit thing during
PTE is cleared. Considering the code path of do_read_fault(), it's likely
the PTE is none-zero.

My concern to acquiring lock is that it brings extra PTL lock acquire/release
for other more common cases.

Regards
Yin, Fengwei

> 
> --
> Best Regards,
> Huang, Ying
