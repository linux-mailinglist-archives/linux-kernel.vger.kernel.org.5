Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5235B79D5BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbjILQFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjILQFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:05:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B1210DE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694534696; x=1726070696;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=bUpqw5xzN+qkrhOAfG6rSYbYHPtyG2PShuGLDlguTTM=;
  b=iMH6jsdXooOd/MXwAptPcTKuSBwra86lz3xqaHExfkhZDCVqwFgwh5U6
   c3xw+S+ZIl9pujmAeh268XIER0NiafTaD/3Nrq8an7zZTZemabxOZpr/7
   ebg9mdO50xpw664oRINiWD4YMwJ34uj7Ni6OpRG13JS9CXAcom37tHBUa
   GDM6s2pXSUXwX9M7T+GO2R1gbUMH2/fq5cvsC9BDxxSXMoRBq1HDZX4Oe
   reFWOgnA9u6FkXw13ppgKzuz5qKPwDXKLjNY3NI9Mj8CYPrccIUDS9ZrX
   XArDtZqvMs/y/AK2WDvHaBGfKiU6rHHQz0h2UaR8FKW6wy/wmZGxwdQ5M
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="368681851"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="368681851"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 09:01:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="773088837"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="773088837"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 09:01:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 09:01:45 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 09:01:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 09:01:45 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 09:01:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpCLyPRznQ5tzepugqLMRjQ2u5Wp2VxX8HPcXfC2ViJf0ZrIsHiYcitF1g53N/WRRQ1HZNGpgxpCL4oqg8VAipmz/dTrU94rVJsGruvVcbP7s1uqGRjvt/kCexCIxdWSQhHV9N0/vGM0KwRzQdLVIzZruauyaUsgVCI3BRDdHh5U7CpjwjOxw8GwyGKlhdmTihaXxdUsEuOUW2qjerAv5AuBiZskGg4u0wkNKpp+jEzs13zwHpniUxLLALhKKZjkET9FolbLoOpkwWHbtb9+SJsIgFTWGgF5nvkvcUL0a4lEuh3xGkApGLIfTckNYwrJVOpP70Fz+GkzMjOijHIUiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGUfwF8Rvld5EkVxrTFn+xu/qRjLlYTds9lTwwsOgII=;
 b=WFgOgQ4Xncq9srACMVLkmpOa5SmcmIpfxsTp9OAKdoEIH83cGLyR7VwDbeplQoEfbk3XuLGKctq2pj5mjiMNRhU63JsN288CDqMzQJCXgVKln9+SWf+jawbTh0QhwM9aLZSFfZI/wdSCitLXPluhj8GwCGPTNbWdOmHIti5VUnSnL6aEiGhm5KZVkhhzzuO5mk7N3pl4SiEGRetTzdlTuebVYM6nrwpOPToib87ITX9lmkRdRX1+beVGAu5VoaVUU1kMQRhMOAtxiVuhu/b7ZPRlgEz5/nrxMlgc/sBljQp+IV/DypUzzL5mEpo+CiMRvzlLU7Zeywz6Pf1kqIrhZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CY5PR11MB6234.namprd11.prod.outlook.com (2603:10b6:930:25::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 16:01:42 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::488d:7cde:d174:b775]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::488d:7cde:d174:b775%6]) with mapi id 15.20.6745.030; Tue, 12 Sep 2023
 16:01:41 +0000
Date:   Tue, 12 Sep 2023 23:52:09 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC Patch 1/3] mm/slub: increase the maximum slab order to 4
 for big systems
Message-ID: <ZQCJKUz37HTnPTtT@feng-clx>
References: <20230905141348.32946-1-feng.tang@intel.com>
 <20230905141348.32946-2-feng.tang@intel.com>
 <CAB=+i9SP2j=VEDi52ga0WgPWSeDzdmTYisA4PAnR26Natp3swA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB=+i9SP2j=VEDi52ga0WgPWSeDzdmTYisA4PAnR26Natp3swA@mail.gmail.com>
X-ClientProxiedBy: SGAP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::21)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CY5PR11MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: 233ea5e0-ae82-4201-e819-08dbb3a98dfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ijlYlX/1suc9loeKyGgrfUKO6tfHFH14/Bc5O2KIqdC/9azJetClvYDobmtvmqrt9zCAPnZVdPASIaqQaIFN1BnK7oLphrJd/3hEzsT0HcSOoW4gpP0445LVETifHzdjemO+ZqedEU8HYJIBCsPOD7SmlCj59hI7XnkBNxbl/TPv36DDpRjWUZGZ71b5J5lW/oO61l3iTD2iaswu0JvQVzGPbMIT+HAvZdfNcGY1Ko/lGWP9l171mKlLkTc6ag4Dm3HFavljcne6DqVi7JoihOe9gBXMkQp4DgJWxw22nOoQccr4xpjyvw6vycdFPYxppn537DKN6cPV8SSW0790tbaqTwQQn/RyWMRTAzqPAXcnE6Sr0UN+U1PF3EvG8srjSO1/ZBvukWpD/vS0kxwgn9gpNO2C8DGagJwsRo523VGrRNU/blz0plQxkvnnMzMK9s+i5lvNVXgPT5he/yMMSC+D3NKExTmmqG1O4tyUbpslESNsIuFcC+sPcCqOoWx1Vq9HP8uNpkJeP6fqu1UjERo2JkEbLrqv2zbklO7baKw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199024)(1800799009)(186009)(4326008)(82960400001)(6666004)(6486002)(53546011)(6506007)(33716001)(86362001)(38100700002)(478600001)(2906002)(8936002)(83380400001)(9686003)(6512007)(966005)(8676002)(7416002)(316002)(26005)(5660300002)(6916009)(41300700001)(66476007)(66556008)(66946007)(54906003)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUhReWlyQUZ6NmN1QThnSFlPOXhZKzd1ZnR5c3dadDhJVkdpY1JYQU1rR1dR?=
 =?utf-8?B?dFIzM3FiSkx2cG01bmN3UU1SYWtOVjNXdkorM01JaTNpQW5XWHJrU1B5Rjhh?=
 =?utf-8?B?Q1Z4RTBaM2xnWHRpdW81MlFZb0pkKzhuNHVOc0hoUnRvaW9TZzNEcGJnbHhB?=
 =?utf-8?B?MFhPbC9HUzdZS1J1R1cvTWkvZkpleHhKYTBYR0lkOCtCUzhsOUZYTWNlcXZu?=
 =?utf-8?B?TXFjL1J2Z1p6ajdrc0xHQ1hTeGNFWUp0WmR6LzJZTnBJd1RtZzZ5cFFKemRK?=
 =?utf-8?B?cE1FUW9uSStlSkU2NXdvbHdMbzYwNWh5b3JITnJPRHdhZ0tYeSs0N25vWTJD?=
 =?utf-8?B?NFdRUi8vT3h4QjhCYi8xeEpnYnRVVUxub0xVbHhPUDRuTVUxdGo0dUs1dUN4?=
 =?utf-8?B?VnJMWkQzSTBsaU1iWjNKOXBaaWdORERCbTRrcGtjUDdZaWlOS0RvN1ZjQWpV?=
 =?utf-8?B?QUs2aXB2MitYMGtzeVREOGNySVZCNUl6c0QzeTU3ZFhXVVdoclBFb0RsUFdo?=
 =?utf-8?B?SURzVHNxbGtwNVNxTGl1d0NYUHRrRHRRNWV3WWJzQXBhMFovUEcwcHZrTHVU?=
 =?utf-8?B?SHBzMytMcGs1d0k4bGdseEM2VWpYS2JQUFh0UmZ3ZlNybngremZWOUlFa3hv?=
 =?utf-8?B?bkQydTFwbTJnVlQ3Nm51RUNRdVkvcnVWTmVOWjFBTXVTazZWVUZwQkxRWDFk?=
 =?utf-8?B?a2hwcG9sQWhvWjBnTldkL24rcU9SSnA4dFdUU0NSQmozQnJIWU1mcEx4cU1l?=
 =?utf-8?B?alYyYTd4aGpGRkFRTVlsRGZnR2NEbnp2Vlk4UGZDRlRhaGpWekxpQ1VHUDJQ?=
 =?utf-8?B?b3VkYzg0d3FNa2pwRmF0UjJsa08wSVRjT0MyMUNWMTZteVM0WHp1dXhTeGYw?=
 =?utf-8?B?cVVhZ1ljQ2xMMnZxWFpHWFdXUUdKcGVtc0szVzdPYmo0UDdpWW1kWjBnTDJJ?=
 =?utf-8?B?UjBScVF1UHY0TDcyMVd5dW9TL3l0ZE8vOXVPWGtBNVllTEhlRFQ5RFJYSVJX?=
 =?utf-8?B?YldQaStRY21kYm9wNzRPdVhtREhjeWpUTzB0WGQvd3pMNEFEZnpwM3laa0d4?=
 =?utf-8?B?QjVWSEo5cDAydkYxWkY3NDB3SXEyZ0ZYbkZ0d3F0V21KUnl4eGRtY2Jrei9R?=
 =?utf-8?B?RzArNkdjR1ArTXJ0aHFsa2NoK2Q3TXNaSkZFOHIyYytla0FYYzRrdGFlanha?=
 =?utf-8?B?NWNUcmluWkpsTzk1YlJkV3VPWk1SMXBTTkxoWVcyNk9rWDRGaDNFeUNHb3M5?=
 =?utf-8?B?T1I0RzhhSisrajVPVFdYajQzT1N5ZnpYRzNMQThGb3FtNEtJQ0g0YlJ0RUxX?=
 =?utf-8?B?bDcybHFIU29VcWhpTWM5QnplbFpINzdjOGgwc0RnQXZsY0ViOWZQM25QQUo0?=
 =?utf-8?B?OW1QR2xGOVlEbk5MS3I4R0xHV3BtRDhscVFYbGJFVjhmUEV4WXZzS3dhRGxo?=
 =?utf-8?B?TUVGR0NxdUtHUllscE5DNWJ1TlFZNFR0L001eW9jOUZFeG9KVXdiV0krMDd1?=
 =?utf-8?B?YU40eG1LWjBYUGx4K2YvNmxCRnBVdis3K29kRVJHMG0xY0xHS2dsQVJTbElm?=
 =?utf-8?B?WC9lak5kbjc4aDRqRHgrbFoxS0dPdkplbFV2VzNvajIvZit6QkNBTDBzd3pp?=
 =?utf-8?B?Z0VFdmN4R2xQSU9lcXo1dDBQQVBPdnlvUzBNUVdyTTlZY0NpMHY5WVJCdWdT?=
 =?utf-8?B?ZnA5ZHJNeXRield2UTBCZnAxVjY2alN3emQ1OHNRMktCNTJrUU9hSCs1bHh5?=
 =?utf-8?B?K3ZGallwcHQ2VXcxV1ZNWndPbmQ1cDJwYklHSWZ0bjFSUE5mVjRSQ1I1YTZX?=
 =?utf-8?B?UVAxdVBvUEZCYnpvY2d0dUo2VFhuMnVObVZIOW1RSE1paXczY1FZUis0THZv?=
 =?utf-8?B?R2o3dlNsaGFpU29SVUllaUpNNHpGQkxsUkw4WDNCSUEwbkcrYnR5ZTJXenRk?=
 =?utf-8?B?SGJDR0ttd1IrTWNJOEdFNnMrL0k5RkFhK1VPQk9KQWUxNG82OTdWWThYUkNG?=
 =?utf-8?B?eUJnaE1xVnNRZTR3eEwvdTVPQTF6bVlpbmJ0YTVIb1Vzay9FWE10aWZTeFB5?=
 =?utf-8?B?aFZyL0hpL0Fya1pwWUEwYkdTZUF1SFdvV2pDaEhQS2hsdzlqQ3lCWTBEeUR0?=
 =?utf-8?Q?OM0boFe5FFBOR21mjuwXXwfgW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 233ea5e0-ae82-4201-e819-08dbb3a98dfb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 16:01:41.9085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y1k6cajq2V0vYDGPeFK5L3g1ubTLyD34MCj88mfioPR944yrtIT5z3DqDijap0k5sAoRIBPc7jP5hO3ljfOuwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6234
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hyeonggon,

Many thanks for the review!

On Tue, Sep 12, 2023 at 01:52:19PM +0900, Hyeonggon Yoo wrote:
> On Tue, Sep 5, 2023 at 11:07 PM Feng Tang <feng.tang@intel.com> wrote:
> >
> > There are reports about severe lock contention for slub's per-node
> > 'list_lock' in 'hackbench' test, [1][2], on server systems. And
> > similar contention is also seen when running 'mmap1' case of
> > will-it-scale on big systems. As the trend is one processor (socket)
> > will have more and more CPUs (100+, 200+), the contention could be
> > much more severe and becomes a scalability issue.
> >
> > One way to help reducing the contention is to increase the maximum
> > slab order from 3 to 4, for big systems.
> 
> Hello Feng,
> 
> Increasing order with a higher number of CPUs (and so with more
> memory) makes sense to me.
> IIUC the contention here becomes worse when the number of slabs
> increases, so it makes sense to
> decrease the number of slabs by increasing order.
> 
> By the way, my silly question here is:
> In the first place, is it worth taking 1/2 of s->cpu_partial_slabs in
> the slowpath when slab is frequently used?
> wouldn't the cpu partial slab list be re-filled again by free if free
> operations are frequently performed?

My understanding is the contention is related to the number of
objects for each cpu (the current slab and on the per-cpu partial
list), if it's easier to be used up, then the per-node lock will be
contended.

This patch increase the order (I should have also considered the
CPU number), while keeping the per-cpu partial numbers unchanged,
as it doubles the 'nr_objects' in set_cpu_partial().

But the 2/3 patch only increases the per-cpu partial number, and
keeps the order unchanged. From the performance data in cover
letter, 1/3 and 2/3 can individually reduce the contention for
will-it-scale/mmap1, as they both increase the available per-cpu
object numbers. 

> 
> > Unconditionally increasing the order could  bring trouble to client
> > devices with very limited size of memory, which may care more about
> > memory footprint, also allocating order 4 page could be harder under
> > memory pressure. So the increase will only be done for big systems
> > like servers, which usually are equipped with plenty of memory and
> > easier to hit lock contention issues.
> 
> Also, does it make sense not to increase the order when PAGE_SIZE > 4096?

Good point! Some other discussion  on mm list earlier this week
also reminded me that there are ARCHs supporting bigger pages like
64KB, and these patches needs to consider more about it.

> > Following is some performance data:
> >
> > will-it-scale/mmap1
> > -------------------
> > Run will-it-scale benchmark's 'mmap1' test case on a 2 socket Sapphire
> > Rapids server (112 cores / 224 threads) with 256 GB DRAM, run 3
> > configurations with parallel test threads of 25%, 50% and 100% of
> > number of CPUs, and the data is (base is vanilla v6.5 kernel):
> >
> >                      base                      base+patch
> > wis-mmap1-25%       223670           +33.3%     298205        per_process_ops
> > wis-mmap1-50%       186020           +51.8%     282383        per_process_ops
> > wis-mmap1-100%       89200           +65.0%     147139        per_process_ops
> >
> > Take the perf-profile comparasion of 50% test case, the lock contention
> > is greatly reduced:
> >
> >       43.80           -30.8       13.04       pp.self.native_queued_spin_lock_slowpath
> >       0.85            -0.2        0.65        pp.self.___slab_alloc
> >       0.41            -0.1        0.27        pp.self.__unfreeze_partials
> >       0.20 ±  2%      -0.1        0.12 ±  4%  pp.self.get_any_partial
> >
> > hackbench
> > ---------
> >
> > Run same hackbench testcase  mentioned in [1], use same HW/SW as will-it-scale:
> >
> >                      base                      base+patch
> > hackbench           759951           +10.5%     839601        hackbench.throughput
> >
> > perf-profile diff:
> >      22.20 ±  3%     -15.2        7.05        pp.self.native_queued_spin_lock_slowpath
> >       0.82            -0.2        0.59        pp.self.___slab_alloc
> >       0.33            -0.2        0.13        pp.self.__unfreeze_partials
> >
> > [1]. https://lore.kernel.org/all/202307172140.3b34825a-oliver.sang@intel.com/
> > [2]. ttps://lore.kernel.org/lkml/ZORaUsd+So+tnyMV@chenyu5-mobl2/
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> 
> > ---
> >  mm/slub.c | 51 ++++++++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 38 insertions(+), 13 deletions(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index f7940048138c..09ae1ed642b7 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -4081,7 +4081,7 @@ EXPORT_SYMBOL(kmem_cache_alloc_bulk);
> >   */
> >  static unsigned int slub_min_order;
> >  static unsigned int slub_max_order =
> > -       IS_ENABLED(CONFIG_SLUB_TINY) ? 1 : PAGE_ALLOC_COSTLY_ORDER;
> > +       IS_ENABLED(CONFIG_SLUB_TINY) ? 1 : 4;
> >  static unsigned int slub_min_objects;
> >
> >  /*
> > @@ -4134,6 +4134,26 @@ static inline unsigned int calc_slab_order(unsigned int size,
> >         return order;
> >  }
> 
