Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C316F7B0812
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjI0PWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjI0PWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:22:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB91126;
        Wed, 27 Sep 2023 08:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695828165; x=1727364165;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HrLzHyx7Iv/5h7ANGFTblFbN0dY1nA03hFYfMqSWyuA=;
  b=KCkkJitJMaaafGFYBSxeHIFBW1X9N91jPiQOc8jwFE6H/SQ1wVtc99yP
   TqJYBzqQzltSEzESnhwx77w/c0cnR2OKo2Fqa+TGXf/q+gtWzH4iJKex7
   DMA7q0RTlx9KlpK4kkbYeDUhNdfGuhg/FB8SBneUQW6153aB1TQB7+Q1k
   XIMJCQODekqwxhmARQi/9Wg8UQfx61e7KdabUDF0e/FSPSLBgXoegFAqF
   q6pedwPnyNiXjCpGOFB7FqQgHU+SIrIBIJ/e1ErpriR7QpczwTCnHtiCV
   OLNdINav0ENHaUR1HPirXkyTNxAAO3PYuDhZxoxLG9ipsdBAv4rnba3lT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="412761319"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="412761319"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 08:22:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="996182071"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="996182071"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 08:22:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 08:22:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 08:22:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 08:22:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 08:22:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0bIiNKvHSBo1f0G21G1wMUZxkwAotmM2fljUIp1TxDuw53wrbX6cJ9qE6egKUstHHAryurtkSJNg7nNTX1Ot5vwi+pf/SM8Ijio6NhyyI4HFMCIxcQ/Vt2QBlWG0rvxw7Uv4ccS5hbhCLAtTqaSQ0KNVV+PJ0/pzb38AZP1+sG5WDWO+5tDoe6GAOEEbJDtZDX8BXe2fAxEt1K/GmKgmXRlY+1ySek583NantLGPOkG4U7LlIpa3L3KbqzyaFV+FE0pThy3GmejYYvxkkR2xRryI9xlVgTxxS/M/hkWsPUvHxSoPkoemiI3DX8CnezBiZ1GMtfDqgZjsa8xMPY/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEGhPnxAGj5oJeCl19HiYSzE8z25nMKA+FhD7wziW9M=;
 b=E96mqnxY2YxX3BeKV2XDg/kxspaAGuPEo7iqq2szR4OcPVQD4+bKKR7NlQAyMiKXsxM3YVIPq7VOauDIhMjp2/PbeW04gWPodBnfJE49pBBHpyXwuaRYhIJPxmWQCiSdpQFHvS+VefL82yAPKHGEemznq58DXLLkbZEXs8Mjesi71QWpJKJ77AvswSYDUKUCWOsoHbaKimor7npS4g08Y1dk2d7uBnQmFrzf5/Dt0j8J4wQaWr569qkC1IGZ11KSrXSKgupyPc1VqhewML1J+DTeXOff8pYcM2YDVBsUzamhzOGQhJK0d3iR9a9SSZr/LdwxTp6yJrT94rZGlrXlyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB6742.namprd11.prod.outlook.com (2603:10b6:a03:47b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 15:22:42 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 15:22:41 +0000
Message-ID: <b4b96520-2d23-9102-09c0-802cedaa70fb@intel.com>
Date:   Wed, 27 Sep 2023 08:22:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v5 3/8] x86/resctrl: Split the rdt_domain structure
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-4-tony.luck@intel.com>
 <5f1256d3-737e-a447-abbe-f541767b2c8f@intel.com>
 <ZRMnCFWzcxa6Qa4E@agluck-desk3>
 <5b2fd31e-3cef-3c35-7d17-411cea27502a@intel.com>
 <SJ1PR11MB6083D9AA22033235210BD847FCC3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <595d6062-fece-83c0-5d5d-2f9405f6b842@intel.com>
 <SJ1PR11MB6083210E470189053CCD1F70FCC2A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB6083210E470189053CCD1F70FCC2A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: 76415c17-2e0f-4e21-f5f2-08dbbf6d9786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C0UbWvZXimFibCcbHFhW+cm7RNjiUtjuU0zrLbjSrAYxA7mNaYRsk26h4LvSg3f/eG9hsFZt0q67UxuFJgroqEmqPjlBbtg5VM6tp25kI2lgjB4UxL0h2YXf+RTXREFzTp5Co4uA/XTLrZEIL/6+rKnCY//eum/rUpgQ6bGvNwR/bPpefATC2J39LBgw408W0Hqe6dAdbb9lz8twKCWNH3rQbu/fH4z8ph7doV1v7z89zKsVZrxG4sGufHOVejeaNl+4LZD1Ag3PdUf4z/W4zb9wv2pmFQxnjlt7HhGckO5+iZQRjZm+QG0A/pcU9QoJVWKnq+j5NTD89eWjxSKjAV1Gm8QTYLn68pMor2GvUfoDlqc9bT3tJhBedWugvPQ8F1N0by5mcstuqLVkfRADlknsQrympOFTwM6p4DMFbl5d5MiUjXia4Ydx9l+4GZXEUx4NFDCXmFlvGzeeabFrcCV7fPyiYJ0Y5HuSanu50q5AI6rVawI1UR6HnHxfeJc1V9yuiS17GUR/qtLEDtjMl3yCAVUvkDFkaAUW2D++xZYPCOD9md4sXOBTQ1JLWK1/Wo6h0fiTzK6zCxmNOyriEFIYC24UAlvRIY+o8V/rtX44pt7EbQ3G6xL3UgdivO1NTa1t5WBTf6PUvB6hUJV15w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(136003)(376002)(230922051799003)(1800799009)(186009)(451199024)(6636002)(6486002)(31686004)(2906002)(7416002)(5660300002)(41300700001)(66556008)(66946007)(44832011)(8936002)(8676002)(6862004)(4326008)(66476007)(478600001)(6666004)(6512007)(53546011)(6506007)(26005)(2616005)(54906003)(37006003)(316002)(36756003)(86362001)(31696002)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTBSK3pjSWlaNEVGRC9HbDQvclliRnJzMXJ6dWRNQzk5NlhOekxzMEd4OC9E?=
 =?utf-8?B?SVR1ZVc5K0FaWWxMOHlqOG02MEFzRFZYUFhrYldnbHk3Nkw4a3dxRlRVZnBJ?=
 =?utf-8?B?TmZMekM0ZCtCSWhuc0NRN2tIYWRzd0lHbHVwT3lUVWFNaE1SRUswTlZob3Bw?=
 =?utf-8?B?UmpyejZJZmNSSGJzSXhMdWViYklTV0psWFJrVWg1OFM0RVYyZXROUGdFMHp0?=
 =?utf-8?B?SXRJRjVBV1R3eHNPYllpYllVMlhSQUwwbEs0eGIzZ28wdVhLbUEwa2V1anB2?=
 =?utf-8?B?SitWVEZIelFTWFgzenFwVGFCWHU0UzNQUzZkc25admxrZFc4TloxOXNYRUhr?=
 =?utf-8?B?NlFHS3pQZ3ZUYXNrR0RTNEM3LzZ1a245cWdqRGFhQ2I5Z1BDTjhZbXlKU1Jp?=
 =?utf-8?B?S3FzTy9aYW4wRG5JQTVsVksydHo3MGo1b3kxL3c2djdBY0Z1UC9kNHFGZnQ3?=
 =?utf-8?B?dm9qV1dDRG01Vkl0RGpIT2dZTENuenFFSnZzcGtSVjFodjMwSkNXdzRYYTVV?=
 =?utf-8?B?YW1hajhTTXpSVjhZdW9GSWl5ckJ1WXhDRWdPRDhxWm5TQ3Q0dTdlRk43VXhO?=
 =?utf-8?B?NGNCNGFQZU8xQk9vYWp4MDE5bm9nRWRwMHN4ek9lNHVuekRreHlWY3RBci9j?=
 =?utf-8?B?WHVMMm9MUEFjTnhyb3E2N1FZcDR5RWxGMEQxNmNWc2lsZWw5dmJabnpBTnpN?=
 =?utf-8?B?eC9IY2xkRXFJOUVxMDdpTzBmV2ticG9PY0loOGcxZHptK29KbXNvZ1NPVUpZ?=
 =?utf-8?B?QVZsMjR2N1I3WUFoZmN5N3FnZjBrTE5EM1EydTNnRmYyckdOL0pRSmIxYlZH?=
 =?utf-8?B?RTZzNlJiRG1rVlF6T0x0SUJsYWx2bzZPTHRLbGliakhIK2J5cWo3QWwrWFJh?=
 =?utf-8?B?RUVEL3oxOWpRN1NxbHdrY3M3a0RXUkx2amxLVWJjNHBEUXFxU3BCTkg4Wm92?=
 =?utf-8?B?VjZ1d0tIZE1UakJIRjQvOC92czdvYWlNY0lsU3BZR0MzaURMOVFyd0VZK3JI?=
 =?utf-8?B?dWZKNGtZZUxuU29YVTlMd0FBbW84RERFTWVhSk1YVCsvMW1lZkZhdUtZdmFp?=
 =?utf-8?B?OUhsOXZpRG9CR2RuR2R6R0tVUHdYNU1Hb21mcDkwZHRwd3l6VjRlSXR0NC9V?=
 =?utf-8?B?WnRrK2ZPdzlIdnZ0SUJuVFJyMVRwN3dVeVg5RkgrMkErZThwTW9uL3JnTGg0?=
 =?utf-8?B?WThzeitlM05Rei9kbUN0YmlXbE40YlJTVnowb0RuSGFDNXJXS1hvZWhiNGxh?=
 =?utf-8?B?QXlkdjUvN2xPY3gzakdlOWpPTDNvZ0I0T09ValRSNEU4UkFIRWFJYW9NMlNr?=
 =?utf-8?B?eHlkdTVuTHlsZ1NGYkY0dUdyWm5LaVMxUGJ0OXhrbndQRlpHVjllM3F5eGpC?=
 =?utf-8?B?amx6TzBJQUVLY3M0d2w2R2VhT0xrUERISXY1dVV0RGJObUdnU3lTTXAzcnVm?=
 =?utf-8?B?b3hTR2ZBMEJuWjRQQmxoQ25sTFFUWGtEMjRiWU9ZSkZ2QzRKOVdaK1VtRnFH?=
 =?utf-8?B?SlpoMEI0S2RpbGJjUDNpb05NUUdVRmVyYXI5OG1iaE1QeThDbjgyMklvbXRm?=
 =?utf-8?B?L01NUE9xaGNKMjlCMjN6Z0gwSnMwRUh6Z3V0dU5Va2QvMlFtTEhGOEI3ZC9X?=
 =?utf-8?B?TWt6ajBXOUI5aElwbzI2TzRDdEQzWHo0bU5DZmsxcUY2SnFGeVJMMStJZjRT?=
 =?utf-8?B?Z1B5d0tnU3NxT0dhUUNzdXRDS1diNzRqZ01LT0dRQnQxOUIvcU92eEFyL3RS?=
 =?utf-8?B?THVkSGNrZlQ1ZHhmMEFycURwTkVURUVHQjRVaWxWZXNHL2xXNCtrT1pRQlNn?=
 =?utf-8?B?TVZPdEREbzU1a0VhNEpJM0xDbTdVcTZiUzUzSXlUNFVibmlrYlh4OWNvZ05z?=
 =?utf-8?B?b3FXcWVpQkJKV3JlN0Fhd1FhdW9UNWNhMnI3VXl3RmRYUXJYZVYyUXk4MjRm?=
 =?utf-8?B?SVJhaEc5SXpRd3lkbG9GeGp1VGlSK0R2UHVHMHQwZmVvUEU4Qm9XK3B3bU1I?=
 =?utf-8?B?Ny9rczlUNU5RdzRoSnNpTkNVRFZldlh6T2xrU2lnQ0w1TDRWamtJVnh5bXhy?=
 =?utf-8?B?bTFSU0lZQ2FOS1VpWGt6c3JTRkkvTGpEUjIzQ24zT3hNQ0RjbHorS3VsL3E1?=
 =?utf-8?B?VlM1Nkd2RHlwc1lYR250SU1ObklqK0JNdEMydUhJK250UUthZlE3YWhIZEdX?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76415c17-2e0f-4e21-f5f2-08dbbf6d9786
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:22:41.9085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkXbPtZSyrAVSFAlV/nmgbNRtMjje+QgESXBC4lOYhjG1cIOeMgud41avI/f7GJ3SvNL1enqxRmHu+VUbi4/QpUeyfkzI719hX72TNB5H5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6742
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

Hi Tony,

On 9/26/2023 5:00 PM, Luck, Tony wrote:
>> I expect you are right and your proposal makes the code cleaner.
>> Could the list_entry() call within rdt_find_domain() instead
>> extract a pointer to a struct rdt_domain_hdr? To me that would make
>> it most generic and avoid using wrong type for a pointer. I do think that
>> may have been what you intended by moving id in there though ...
> 
> Reinette,
> 
> Exactly my thoughts! The function currently looks like this
> (though I expect my mail client may mess up the formatting):
> 
> struct rdt_domain_hdr *rdt_find_domain(struct list_head *h, int id,
>                                        struct list_head **pos)
> {
>         struct rdt_domain_hdr *d;
>         struct list_head *l;
> 
>         if (id < 0)
>                 return ERR_PTR(-ENODEV);
> 
>         list_for_each(l, h) {
>                 d = list_entry(l, struct rdt_domain_hdr, list);
>                 /* When id is found, return its domain. */
>                 if (id == d->id)
>                         return d;
>                 /* Stop searching when finding id's position in sorted list. */
>                 if (id < d->id)
>                         break;
>         }
> 
>         if (pos)
>                 *pos = l;
> 
>         return NULL;
> }
> 
> and a typical caller does this:
> 
>         struct rdt_domain_hdr *hdr;
>         struct rdt_mon_domain *d;
> 
> 
> 
> 
>         hdr = rdt_find_domain(&r->mon_domains, id, &add_pos);
>         if (IS_ERR(hdr)) {
>                 pr_warn("Couldn't find monitor scope id=%d for CPU %d\n", id, cpu);
>                 return;
>         }
>         d = container_of(hdr, struct rdt_mon_domain, hdr);
> 

This looks very good to me. Thank you very much for creating a
solution that integrates well.

Reinette

