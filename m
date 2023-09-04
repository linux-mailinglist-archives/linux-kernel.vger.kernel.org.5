Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D15F7910F0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 07:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348747AbjIDFcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 01:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbjIDFcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 01:32:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959F9F9
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 22:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693805555; x=1725341555;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eng20eePdYjk0jjQDjUecxoiLwsD3ffAF7AD905XqMc=;
  b=WQiTHTY8uJN8u2g3JMLXDJA/MRL5xjsRJB7rWTYoLl4NFB8gXED8RIZK
   Wkmcr+60Gaqc7dCvkUtzU3JxaOnDVMBZ595/l/wwKqOJvixBKuEhIe+rP
   +CvUPE7RgtU4mzy8RMRAyqY15mmBfPVqeNjLLUktHZH7+P4fleqGHWI3/
   eXfcd3xykyPysBaocqJggv35lbNXrCKzGEaQ3SKGGEjJbkxdrwTJDISZw
   LT3e6YlS+P9j9EXFUQ8Ag/f3VJ/+rdI81Ql4ixnzFW6Lu1YBUInzzINpr
   KUD1qKKbVIAnVA5OSXuD6aG1gU1CM4v7UwIbVsa0kDZUdm5STLl8bnNV+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="442914879"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="442914879"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 22:32:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="769857798"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="769857798"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2023 22:32:34 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 3 Sep 2023 22:32:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 3 Sep 2023 22:32:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 3 Sep 2023 22:32:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0V0KjlYqRb534ranDfYVxrwmXh2qAlZbCI+/OWWkBqpKiQ7xO05mkhV5lpAL3qcJoWvLzWBMqeTiXchhXpKDcMVpqvTZilIVc0tjG05ekpqvMsdeHzTlF0mOV7QoPW5dWgz8+tOiWRK28mcly0vMUcxfDJwS/n5I2vEMpQNOLB2AjEz7KH2teONWJK50bxryoYC97uA9H5QHpkfsYtZ4Q2JneRURpOeqBe1zbZH9rSy81j7w5Bs5Jn5SgtApVQpThW8pfBJAlQWWNMpjxMHsDxq7XyizEc/jAf+exYchSDMg84qInvVOV0/nayNaGYnQ9SNFgy9P4UcP7YLRpYdbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+N9z0WBD1VvtUtbWq8xol8tTJ31XZMsYb3Z+k9MM+g=;
 b=dvTh9hKj07jbcP6WOXyHH9/qy6lu4OWCmddsYsswJAMCauIH1WYCxyrRxfDNQbu+v6O+lYYljur3juF0paO5m+XzTW4WQGyyKvHha0ukNoTXEBmbTR3gFsXGnRW04013bHoojwR+qG/sol6h/sl2BlBbkgkPWhMCkX9DZXz5JBjfcNi1eN9fe7UlslZ3xiS7XbIxv1pP0DOYDwIWY0KHLLkf6bV/fn5nmZCUJqCFlvUL/vfTkC9dY3EvwYyCGGfTYh+BSJPIsYSTGZJM6swfG+zfkQYg1Vgk4fPP85vEuLTKherPsQKyIo1FmwmG9l3BbyAXaEfirrC86sKX1WMChA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CY5PR11MB6511.namprd11.prod.outlook.com (2603:10b6:930:41::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Mon, 4 Sep
 2023 05:32:28 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2846:e5f8:b2e8:1da6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2846:e5f8:b2e8:1da6%4]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 05:32:28 +0000
Message-ID: <3b4ab51b-e3e9-a504-ee07-82326e9ee1e9@intel.com>
Date:   Mon, 4 Sep 2023 13:32:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [linus:master] [mm] c1753fd02a: stress-ng.madvise.ops_per_sec
 -6.5% regression
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <yujie.liu@intel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Olivier Dion <odion@efficios.com>,
        Feng Tang <feng.tang@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
        <ying.huang@intel.com>
References: <202307181511.8643eac7-oliver.sang@intel.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <202307181511.8643eac7-oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0182.apcprd04.prod.outlook.com
 (2603:1096:4:14::20) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CY5PR11MB6511:EE_
X-MS-Office365-Filtering-Correlation-Id: bc97c837-c040-4390-5f30-08dbad08531c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QbsEzVK5c/36aBm8tBexgXPsnCGTziZZ0s/fmNGKgMUKR4qPGsjbuTl3BD///4CpoLkEdPlq0Tk6TPn3z/3vuYyaa25K98ZUO7ewlNmU22EVrDsHUfKXEwTZfqgFlfESx1+Qb2NcvIIZznvq3heJBBp6+IF7LFV3IqRfdSMnuAS3ARpB9z0j3dGMKcBusseY9JZKwWnvPNR81NmqnH3q/yFxw4UKH+5J7e2bWhNNcQD4ESGnTo92RAvW9ZbU35VxsMXHBaEDcrYoXSslw5iC6WkSxVTUrzXFO6WrmX4xLF+HzvZrp8y5fCBOUbZzu/ZKKBmej7dtuZUwWKItm91oXMV9zZ+Npz/dyI3xFDEaEKbn2qf0UJT2VDwHAdLdzTiyp0Qzu3mBhiC5qERwPcSTi2UxteFM7iO4j0vsh1La6jAB3dEuYZBK1VntucNTIFn+ydCRBpxTzpv0C4l2PWZRQSIJUKrKBFXdIXIJizabOJDrnVJUDg9CKVbuo2l8oeHr11JLTcKv7hNaYSfJG7GwTcdqsbfk0EKJ/37FPWgsk2YfSZ2Nrnu7WKWW9+ZvBkrDXQV8GwIUO0g8AYg2k5dEae3YASbKF7PDy731d2vQi3uf7jZUvx3YXmXD1K5Slh8eB8DfvZaKJvVEGjvgpiFm7vHor1uWJazxIjErgg6wTyuFzLYTJKvyoin5Cngf/Rm0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199024)(1800799009)(186009)(30864003)(966005)(8936002)(41300700001)(83380400001)(19627235002)(478600001)(6666004)(2906002)(5660300002)(66946007)(8676002)(31686004)(110136005)(66476007)(66556008)(54906003)(316002)(4326008)(6512007)(53546011)(107886003)(2616005)(6506007)(26005)(6486002)(36756003)(38100700002)(31696002)(82960400001)(86362001)(43740500002)(45980500001)(579004)(559001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlNyU0JhSGY5VkVBSGgyRG1uaTY1SE1adlVYTU42M0hYSURsTGhPdG43RmN6?=
 =?utf-8?B?eTRYNUdyOTNrRkRFenR2K0JsSHlYQndSRlhJZWxKakZneXg2QjByNWovVGZM?=
 =?utf-8?B?ZXJmYmVKdXVlY2MwNlNTSTAxYVVOLy8vVDB4V2t6bytGQll0VmQ4dEZoN1BX?=
 =?utf-8?B?UmYrakRxR3BWSk05cTUvVzZ4aWlHMmRGSGhqUW81Q3MyY2xCaXYrWkJtOFhX?=
 =?utf-8?B?cU1hamNKemc0YThrTXdXQlp6Z2tQWGpxQXR3TTV3N3N5clRaQU0wcmlkRUhP?=
 =?utf-8?B?VklSeGl2TEZNZ01laTNaRFZicTV0SUQ3R0ZwVVJPOEVBQXNVWjRwRnUyWm5y?=
 =?utf-8?B?SmZoWFlZcUhiUkFPR3hKeG5IR0h4b2NVTFdzOHBqSnFRcFpZYnBYVjhPT0kr?=
 =?utf-8?B?NzJvZnlxT2xpakRtUGg2N2hyc1ZCM3ZWb2c5OVhJOWNiNzZCYkx3dGZjOWdB?=
 =?utf-8?B?VllUbDYrcCtuS1JybnBreDc5WUhzUVEzSWlZVGg3SzRaayt2QmcwQ1ZVR3B0?=
 =?utf-8?B?TEVGMlVSYTcwYlk2ZXFFTThtUXZENDNzS0RFeGRTOWlUUCtMNHU3MC9lVzFz?=
 =?utf-8?B?cHllcHI4NjN2VENzV0wzenpMck4wcHQrNXNNOTRNVDhhRG1rYk5xdUliMDcw?=
 =?utf-8?B?MGNwOWFsc1RkenZKK0NQbmtKTWxBQThFdVpZcVQ5UFlJd1FYc0ZheVl4MzEy?=
 =?utf-8?B?cnZ5aEtZenAreVVOT29LZlRoVWFkL3FzeThyUEhpRWNzM09FWU9CYkVIS0M2?=
 =?utf-8?B?czdheU0wREh2RS9pNlhzZWdmaUVxMVRqSGtHNW1mM3c5c05GOTNQMEJlWFVw?=
 =?utf-8?B?YkpYenluenJoa0IxS0lYa3lMOU9qTzZ6UGdEb1BKT3V1VEhDdU5peGlkWGta?=
 =?utf-8?B?ODJSSGZwVHBvQ2ZlMU9jNXBwWnM5RmY2NkVxTnlsSzVUM3N3QWVKVWtxR05h?=
 =?utf-8?B?SjJFMk9CaHo0eUxwY1lCOExaUGtBTDZqVHZqSGFKNXpTSDhad1czWHAvSnRr?=
 =?utf-8?B?RTAwc0MwSGEvZzZDUFpHb0V1Y1QydUhmV1c4aXZWRVVCZDhNYm1iUCtMU1pB?=
 =?utf-8?B?M2lQNHRoYzh5dmtCTHp1aXphT1NDeHgzUGRTUVh1NkdYbWErcmZTR29xL3Z5?=
 =?utf-8?B?QkE0TUQ0aC9rMUNsOVZGdGFuSnVNUElrSGx0ZFVZZEFySVREbUo2Vy9rODdC?=
 =?utf-8?B?QlhuU2ozVUU3T2pqY2VLbGpzRjllV29RUHoxU0xhcFlNd2NMdStDQ3pHaEl4?=
 =?utf-8?B?alg2Zjc1TnZ3UFZKUUxYV3BmTU1pS3c5ZDl1aXNodmlXdVVWVkwyNlZGMTF3?=
 =?utf-8?B?TGJYeUZDd0d5czBIZUcxaXUzYVdONzhsT04rNnpyNlFtT2VYSUJxek1RbkJV?=
 =?utf-8?B?dEt1ek93d3ptZllraUJvbktuODFQblBzbkhReExHNkx3TlFxSWJrb213U3kz?=
 =?utf-8?B?SEN3TlZ6MDRMWVBZVG1hdTFLTkw2dGV3TWl0cEFZNHNCd3l4L1Bwc01GYmNG?=
 =?utf-8?B?M0N6U3grd1BvK3dWTDdzRmE1OUJVaHlPYW9jbCtWMmc1b2NDazlsTkhXQzVu?=
 =?utf-8?B?UXhPQnEwQVppbENhcC9DOWk4akdRcGVZemxHdHVCb3JJYkgvcXhVdjRab05j?=
 =?utf-8?B?cmdxWXRxRG9KSlFoVnNqZW12V0hsa1ZqNGxReEh1TEEwU28vREtVYXFVRVM1?=
 =?utf-8?B?Wm9EOHA1R05wb3pHOTIrd0Q4Y0dwOVZ1RVcvSi9OTEd1UzJYOGtwbGl6KzU1?=
 =?utf-8?B?S09sYjd0bWg5Zm5jVzVrUnJLNk5rZEhoRUI1T3dJQlZEaWxxWTdhRk1VK3Vk?=
 =?utf-8?B?S0UxUjYwdGJkMHdER3hQbzVDMy9HMGl3ZjZ4V1ZFZk5jRzhEVDZvUXF4c1kz?=
 =?utf-8?B?blpkVG1FRm5MT2xLZlBvYmFwZmtqak81SWZiYkh2WmdhTzEvQ2JtdjhabmY0?=
 =?utf-8?B?MVNMWW9XRUJEdTViSjFXTXp2RWhRMmduYkhSRzJ3akVNK1pDS3RvWjVWUWhB?=
 =?utf-8?B?WnVPVXdDWE5hUlFZTU9hcDRHZTQyV0FZSXpkZGdnWWVYdlB0SjdsMXBPMFo3?=
 =?utf-8?B?ZU9SdVZBMmZHSmZySVVwZ0c0K2EyYWt2K1QvV2ZDOWxna1V4eksvRWhPbTlG?=
 =?utf-8?Q?pRQKNvUt1ezlW/g3o72tR7ouW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc97c837-c040-4390-5f30-08dbad08531c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 05:32:27.6751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+DL3Tx4QvTrUUpXYtNnpy1CiE5LJXuTgVQfLmusWdRUaKY8PUlwCjVs4rWD3NcfIcoQpbSptrBugWKXLQYhOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6511
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/23 14:34, kernel test robot wrote:
> 
> hi, Mathieu Desnoyers,
> 
> we noticed that this commit addressed issue:
>   "[linus:master] [sched] af7f588d8f: will-it-scale.per_thread_ops -13.9% regression"
> we reported before on:
>   https://lore.kernel.org/oe-lkp/202305151017.27581d75-yujie.liu@intel.com/
> 
> we really saw a will-it-scale.per_thread_ops 92.2% improvement by this commit
> (details are as below).
> however, we also noticed a stress-ng regression.
> 
> below detail report FYI.
> 
> 
> Hello,
> 
> kernel test robot noticed a -6.5% regression of stress-ng.madvise.ops_per_sec on:
> 
> 
> commit: c1753fd02a0058ea43cbb31ab26d25be2f6cfe08 ("mm: move mm_count into its own cache line")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
I noticed that the struct mm_struct has following layout change after this patch.
Without the patch:
                spinlock_t         page_table_lock;      /*   124     4 */      
                /* --- cacheline 2 boundary (128 bytes) --- */                  
                struct rw_semaphore mmap_lock;           /*   128    40 */   ----> in one cache line
                struct list_head   mmlist;               /*   168    16 */      
                int                mm_lock_seq;          /*   184     4 */ 

With the patch:
                spinlock_t         page_table_lock;      /*   180     4 */      
                struct rw_semaphore mmap_lock;           /*   184    40 */   ----> cross to two cache lines   
                /* --- cacheline 3 boundary (192 bytes) was 32 bytes ago --- */ 
                struct list_head   mmlist;               /*   224    16 */   

This matches the profiling data:
      18.92            +4.0       22.89        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.do_madvise
      25.94            +4.8       30.73        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.do_madvise.__x64_sys_madvise
      30.65            +5.3       35.96        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write_killable.do_madvise.__x64_sys_madvise.do_syscall_64
      31.48            +5.3       36.82        perf-profile.calltrace.cycles-pp.down_write_killable.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe


Tested following change (which can make mmap_lock in one cache line with my
local kernel config):

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index de10fc797c8e..9c53f4e691a9 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -659,6 +659,7 @@ struct mm_struct {
                spinlock_t page_table_lock; /* Protects page tables and some
                                             * counters
                                             */
+               unsigned long pad;
                /*
                 * With some kernel config, the current mmap_lock's offset
                 * inside 'mm_struct' is at 0x120, which is very optimal, as


It could make mmap_lock in one cache line:
                spinlock_t         page_table_lock;      /*   180     4 */      
                long unsigned int  pad;                  /*   184     8 */      
                /* --- cacheline 3 boundary (192 bytes) --- */                  
                struct rw_semaphore mmap_lock;           /*   192    40 */      
                struct list_head   mmlist;               /*   232    16 */      
                int                mm_lock_seq;          /*   248     4 */ 

And the regression is gone.


Regards
Yin, Fengwei

> 
> testcase: stress-ng
> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> parameters:
> 
> 	nr_threads: 10%
> 	disk: 1HDD
> 	testtime: 60s
> 	fs: ext4
> 	class: os
> 	test: madvise
> 	cpufreq_governor: performance
> 
> 
> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+---------------------------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_thread_ops 92.2% improvement |
> | test machine     | 104 threads 2 sockets (Skylake) with 192G memory              |
> | test parameters  | cpufreq_governor=performance                                  |
> |                  | mode=thread                                                   |
> |                  | nr_task=50%                                                   |
> |                  | test=context_switch1                                          |
> +------------------+---------------------------------------------------------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202307181511.8643eac7-oliver.sang@intel.com
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>         sudo bin/lkp run generated-yaml-file
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> =========================================================================================
> class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
>   os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp7/madvise/stress-ng/60s
> 
> commit: 
>   025b7799b3 ("mm/memcg: remove return value of mem_cgroup_scan_tasks()")
>   c1753fd02a ("mm: move mm_count into its own cache line")
> 
> 025b7799b35d32e4 c1753fd02a0058ea43cbb31ab26 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>      75.45            -2.3%      73.68        iostat.cpu.idle
>      22.96            +8.1%      24.82        iostat.cpu.system
>    1532875            -6.2%    1437466        vmstat.system.cs
>     405460            -4.8%     386179        vmstat.system.in
>     182.50 ±  8%     +39.0%     253.67 ±  6%  perf-c2c.DRAM.local
>       6540 ±  7%     +18.0%       7719 ±  4%  perf-c2c.HITM.local
>      11038 ±  7%     +14.7%      12655 ±  3%  perf-c2c.HITM.total
>      63.91 ± 45%    +503.4%     385.60 ± 88%  sched_debug.cfs_rq:/.load_avg.avg
>     226.38 ± 84%    +841.1%       2130 ±110%  sched_debug.cfs_rq:/.load_avg.stddev
>       0.00 ± 12%     +31.8%       0.00 ± 16%  sched_debug.cpu.next_balance.stddev
>     245385 ± 24%     -43.7%     138251 ± 37%  numa-meminfo.node0.AnonPages
>     263049 ± 24%     -42.1%     152330 ± 37%  numa-meminfo.node0.Inactive
>     256261 ± 24%     -43.0%     146021 ± 35%  numa-meminfo.node0.Inactive(anon)
>       8816 ±  5%     -12.1%       7751 ±  2%  numa-meminfo.node1.KernelStack
>      61340 ± 24%     -43.7%      34551 ± 37%  numa-vmstat.node0.nr_anon_pages
>      64059 ± 24%     -43.1%      36476 ± 35%  numa-vmstat.node0.nr_inactive_anon
>      64057 ± 24%     -43.1%      36477 ± 35%  numa-vmstat.node0.nr_zone_inactive_anon
>       8827 ±  5%     -11.9%       7776 ±  2%  numa-vmstat.node1.nr_kernel_stack
>    5574645           +17.7%    6559502        turbostat.C1
>       2.80            +0.4        3.25        turbostat.C1%
>   46042553           -10.7%   41114702        turbostat.C1E
>      40.58            -2.8       37.75        turbostat.C1E%
>     232771           +35.5%     315298 ±  3%  turbostat.POLL
>       0.10            +0.0        0.12 ±  4%  turbostat.POLL%
>       5473            -6.5%       5116        stress-ng.madvise.ops
>      91.17            -6.5%      85.22        stress-ng.madvise.ops_per_sec
>      18921 ±  2%      -5.2%      17935        stress-ng.time.involuntary_context_switches
>    4377760            -6.9%    4077120        stress-ng.time.minor_page_faults
>       1451            +8.5%       1575        stress-ng.time.percent_of_cpu_this_job_got
>     868.58            +9.1%     947.90        stress-ng.time.system_time
>   49882899            -6.2%   46774408        stress-ng.time.voluntary_context_switches
>       0.00           -25.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.do_madvise
>       0.01 ± 12%     -32.0%       0.01 ± 14%  perf-sched.sch_delay.max.ms.__cond_resched.shrink_folio_list.reclaim_folio_list.reclaim_pages.madvise_cold_or_pageout_pte_range
>       0.02 ± 29%     -38.0%       0.01 ± 25%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
>      27004 ±  3%     -14.4%      23109 ±  4%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.madvise_vma_behavior
>       0.02 ±147%    +302.1%       0.06 ± 37%  perf-sched.wait_time.avg.ms.__cond_resched.down_read_killable.m_start.seq_read_iter.seq_read
>       0.03 ± 28%     +77.2%       0.05 ± 25%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.vma_prepare.__split_vma.madvise_vma_behavior
>       0.09 ± 37%     -54.0%       0.04 ± 58%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file.alloc_empty_file
>       0.06 ± 13%     +33.7%       0.08 ± 11%  perf-sched.wait_time.avg.ms.__cond_resched.smaps_pte_range.walk_pmd_range.isra.0
>       0.02 ±  7%     +26.4%       0.02 ±  8%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__mm_populate
>       0.02 ±142%    +459.3%       0.13 ± 71%  perf-sched.wait_time.max.ms.__cond_resched.down_read_killable.m_start.seq_read_iter.seq_read
>       0.10 ± 38%     +76.8%       0.18 ± 21%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vma_prepare.__split_vma.madvise_vma_behavior
>       0.18 ± 32%     -63.4%       0.07 ± 64%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file.alloc_empty_file
>       0.28 ± 20%     +82.2%       0.51 ± 49%  perf-sched.wait_time.max.ms.__cond_resched.smaps_pte_range.walk_pmd_range.isra.0
>     511753            -2.6%     498421        proc-vmstat.nr_active_anon
>    1230717            -1.2%    1215541        proc-vmstat.nr_file_pages
>     111859            -2.1%     109551        proc-vmstat.nr_inactive_anon
>     521558            -2.9%     506414        proc-vmstat.nr_shmem
>     511753            -2.6%     498421        proc-vmstat.nr_zone_active_anon
>     111859            -2.1%     109551        proc-vmstat.nr_zone_inactive_anon
>    5787879            -5.9%    5446905        proc-vmstat.numa_hit
>    5721666            -6.0%    5380670        proc-vmstat.numa_local
>    8764839            -6.4%    8203387        proc-vmstat.pgactivate
>    8817630            -5.6%    8321742        proc-vmstat.pgalloc_normal
>    6169256            -6.5%    5767868        proc-vmstat.pgdeactivate
>    4886189            -5.9%    4597761        proc-vmstat.pgfault
>    8040298            -5.9%    7568628        proc-vmstat.pgfree
>    1124737            -5.4%    1063589        proc-vmstat.pglazyfree
>     330302            -5.4%     312509        proc-vmstat.pglazyfreed
>       2731            -5.5%       2582        proc-vmstat.thp_split_page
>       2731            -5.5%       2582        proc-vmstat.thp_swpout_fallback
>      43222            -6.1%      40594        proc-vmstat.unevictable_pgs_culled
>      43109            -6.1%      40479        proc-vmstat.unevictable_pgs_mlocked
>      43108            -6.1%      40479        proc-vmstat.unevictable_pgs_munlocked
>      43077            -6.1%      40449        proc-vmstat.unevictable_pgs_rescued
>       4.02            +3.0%       4.14        perf-stat.i.MPKI
>  5.327e+09            -2.6%  5.187e+09        perf-stat.i.branch-instructions
>   61923807            -3.9%   59499312        perf-stat.i.branch-misses
>      38.78            -0.9       37.91        perf-stat.i.cache-miss-rate%
>   39271495            -1.7%   38622495        perf-stat.i.cache-misses
>    1604399            -6.3%    1502597        perf-stat.i.context-switches
>       2.52            +6.8%       2.69        perf-stat.i.cpi
>    6.3e+10            +4.2%  6.564e+10        perf-stat.i.cpu-cycles
>       3551           -12.1%       3123 ±  2%  perf-stat.i.cpu-migrations
>       1634            +6.0%       1731        perf-stat.i.cycles-between-cache-misses
>       0.05 ±  3%      -0.0        0.04 ±  2%  perf-stat.i.dTLB-load-miss-rate%
>    3024995 ±  3%      -8.7%    2760425 ±  2%  perf-stat.i.dTLB-load-misses
>  6.315e+09            -2.5%  6.159e+09        perf-stat.i.dTLB-loads
>     342929            -8.5%     313646        perf-stat.i.dTLB-store-misses
>  3.133e+09            -6.6%  2.928e+09        perf-stat.i.dTLB-stores
>  2.525e+10            -2.5%  2.463e+10        perf-stat.i.instructions
>       0.42            -5.4%       0.40        perf-stat.i.ipc
>       0.98            +4.2%       1.03        perf-stat.i.metric.GHz
>     632.41            -1.5%     622.71        perf-stat.i.metric.K/sec
>     232.39            -3.4%     224.57        perf-stat.i.metric.M/sec
>      40.09            +1.7       41.80        perf-stat.i.node-store-miss-rate%
>    8117024            +2.2%    8297397        perf-stat.i.node-store-misses
>   12712453            -4.2%   12179387        perf-stat.i.node-stores
>       4.01            +3.0%       4.13        perf-stat.overall.MPKI
>       2.50            +6.8%       2.67        perf-stat.overall.cpi
>       1606            +6.0%       1701        perf-stat.overall.cycles-between-cache-misses
>       0.05 ±  3%      -0.0        0.04 ±  2%  perf-stat.overall.dTLB-load-miss-rate%
>       0.40            -6.4%       0.38        perf-stat.overall.ipc
>      38.94            +1.6       40.51        perf-stat.overall.node-store-miss-rate%
>  5.242e+09            -2.6%  5.105e+09        perf-stat.ps.branch-instructions
>   60941850            -3.9%   58557696        perf-stat.ps.branch-misses
>   38615124            -1.7%   37976567        perf-stat.ps.cache-misses
>    1580007            -6.3%    1479894        perf-stat.ps.context-switches
>  6.202e+10            +4.2%  6.462e+10        perf-stat.ps.cpu-cycles
>       3547           -12.0%       3120 ±  3%  perf-stat.ps.cpu-migrations
>    2977065 ±  3%      -8.8%    2716443 ±  2%  perf-stat.ps.dTLB-load-misses
>  6.214e+09            -2.5%  6.061e+09        perf-stat.ps.dTLB-loads
>     337701            -8.6%     308807        perf-stat.ps.dTLB-store-misses
>  3.083e+09            -6.6%  2.881e+09        perf-stat.ps.dTLB-stores
>  2.485e+10            -2.5%  2.424e+10        perf-stat.ps.instructions
>    7978706            +2.2%    8157706        perf-stat.ps.node-store-misses
>   12509147            -4.2%   11980867        perf-stat.ps.node-stores
>   1.56e+12            -2.1%  1.527e+12        perf-stat.total.instructions
>      26.65            -2.5       24.11        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
>      26.20            -2.5       23.74        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>      26.22            -2.5       23.75        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
>      26.17            -2.5       23.71        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>      17.21            -1.8       15.41        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>      16.22            -1.7       14.49        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
>      12.35            -1.7       10.63        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>      16.05            -1.7       14.35        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
>       4.93            -1.5        3.47 ±  6%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.do_madvise
>      10.37            -1.2        9.14        perf-profile.calltrace.cycles-pp.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       4.76            -0.6        4.15        perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       3.99 ±  3%      -0.4        3.56 ±  3%  perf-profile.calltrace.cycles-pp.read
>       3.96 ±  3%      -0.4        3.54 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
>       3.96 ±  3%      -0.4        3.53 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>       3.94 ±  3%      -0.4        3.52 ±  3%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>       3.91 ±  3%      -0.4        3.49 ±  3%  perf-profile.calltrace.cycles-pp.seq_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       3.96 ±  3%      -0.4        3.53 ±  3%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>       3.90 ±  3%      -0.4        3.48 ±  3%  perf-profile.calltrace.cycles-pp.seq_read_iter.seq_read.vfs_read.ksys_read.do_syscall_64
>       3.52            -0.4        3.11        perf-profile.calltrace.cycles-pp.wake_up_q.rwsem_wake.up_write.do_madvise.__x64_sys_madvise
>       3.21 ±  4%      -0.4        2.81 ±  4%  perf-profile.calltrace.cycles-pp.show_smap.seq_read_iter.seq_read.vfs_read.ksys_read
>       3.34            -0.4        2.95        perf-profile.calltrace.cycles-pp.try_to_wake_up.wake_up_q.rwsem_wake.up_write.do_madvise
>       2.89            -0.4        2.51        perf-profile.calltrace.cycles-pp.sched_ttwu_pending.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
>       6.26            -0.4        5.89        perf-profile.calltrace.cycles-pp.rwsem_wake.up_write.do_madvise.__x64_sys_madvise.do_syscall_64
>       2.72 ±  3%      -0.4        2.35 ±  5%  perf-profile.calltrace.cycles-pp.walk_pmd_range.walk_pud_range.walk_p4d_range.walk_pgd_range.__walk_page_range
>       0.59 ±  2%      -0.3        0.25 ±100%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.select_task_rq.try_to_wake_up.wake_up_q.rwsem_wake
>       4.37            -0.3        4.06        perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.__do_sys_msync.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       2.01            -0.2        1.76        perf-profile.calltrace.cycles-pp.__split_vma.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
>       0.58 ±  3%      -0.2        0.34 ± 70%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       1.70            -0.2        1.46        perf-profile.calltrace.cycles-pp.madvise_pageout.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
>       0.58 ±  3%      -0.2        0.34 ± 70%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
>       0.58 ±  2%      -0.2        0.36 ± 70%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.__get_user_pages.populate_vma_page_range
>       0.58 ±  2%      -0.2        0.36 ± 70%  perf-profile.calltrace.cycles-pp.do_cow_fault.do_fault.__handle_mm_fault.handle_mm_fault.__get_user_pages
>       1.69            -0.2        1.48        perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.flush_smp_call_function_queue.do_idle.cpu_startup_entry
>       0.54 ±  2%      -0.2        0.34 ± 70%  perf-profile.calltrace.cycles-pp.try_to_wake_up.wake_up_q.rwsem_wake.up_read.do_madvise
>       1.64 ±  2%      -0.2        1.44        perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.flush_smp_call_function_queue.do_idle
>       5.32            -0.2        5.13        perf-profile.calltrace.cycles-pp.down_read.__do_sys_msync.do_syscall_64.entry_SYSCALL_64_after_hwframe.msync
>       1.61 ±  2%      -0.2        1.41        perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending.flush_smp_call_function_queue
>       1.72            -0.2        1.53        perf-profile.calltrace.cycles-pp.zap_page_range_single.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
>       1.50 ±  2%      -0.2        1.31        perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending
>       1.46            -0.2        1.27        perf-profile.calltrace.cycles-pp.vma_merge.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
>       1.30            -0.2        1.13        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior.do_madvise.__x64_sys_madvise
>       1.38            -0.2        1.21        perf-profile.calltrace.cycles-pp.ttwu_queue_wakelist.try_to_wake_up.wake_up_q.rwsem_wake.up_write
>       1.28            -0.2        1.11 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__schedule.schedule_idle.do_idle.cpu_startup_entry
>       0.60 ±  3%      -0.2        0.44 ± 44%  perf-profile.calltrace.cycles-pp.shrink_folio_list.reclaim_folio_list.reclaim_pages.madvise_cold_or_pageout_pte_range.walk_pmd_range
>       1.16            -0.2        1.01        perf-profile.calltrace.cycles-pp.__smp_call_single_queue.ttwu_queue_wakelist.try_to_wake_up.wake_up_q.rwsem_wake
>       0.60 ±  2%      -0.2        0.45 ± 44%  perf-profile.calltrace.cycles-pp.handle_mm_fault.__get_user_pages.populate_vma_page_range.__mm_populate.vm_mmap_pgoff
>       0.60 ±  2%      -0.1        0.45 ± 44%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.__get_user_pages.populate_vma_page_range.__mm_populate
>       1.13            -0.1        0.99 ±  2%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
>       0.92 ±  2%      -0.1        0.78 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.rwsem_down_read_slowpath.down_read.__do_sys_msync
>       1.05            -0.1        0.92        perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior.do_madvise
>       0.84 ±  3%      -0.1        0.72        perf-profile.calltrace.cycles-pp.madvise_cold.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
>       1.04 ±  2%      -0.1        0.91        perf-profile.calltrace.cycles-pp.walk_page_range.madvise_pageout.madvise_vma_behavior.do_madvise.__x64_sys_madvise
>       0.95 ±  2%      -0.1        0.83        perf-profile.calltrace.cycles-pp.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.tlb_finish_mmu.zap_page_range_single
>       0.99 ±  2%      -0.1        0.87        perf-profile.calltrace.cycles-pp.__walk_page_range.walk_page_range.madvise_pageout.madvise_vma_behavior.do_madvise
>       0.96 ±  2%      -0.1        0.84        perf-profile.calltrace.cycles-pp.on_each_cpu_cond_mask.flush_tlb_mm_range.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior
>       6.60            -0.1        6.48        perf-profile.calltrace.cycles-pp.up_write.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.98 ±  2%      -0.1        0.87        perf-profile.calltrace.cycles-pp.walk_pgd_range.__walk_page_range.walk_page_range.madvise_pageout.madvise_vma_behavior
>       0.97 ±  2%      -0.1        0.86        perf-profile.calltrace.cycles-pp.find_vma_prev.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.92 ±  2%      -0.1        0.81        perf-profile.calltrace.cycles-pp.walk_p4d_range.walk_pgd_range.__walk_page_range.walk_page_range.madvise_pageout
>       0.91 ±  2%      -0.1        0.80        perf-profile.calltrace.cycles-pp.madvise_cold_or_pageout_pte_range.walk_pmd_range.walk_pud_range.walk_p4d_range.walk_pgd_range
>       0.77 ±  2%      -0.1        0.66        perf-profile.calltrace.cycles-pp.llist_add_batch.__smp_call_single_queue.ttwu_queue_wakelist.try_to_wake_up.wake_up_q
>       0.92 ±  2%      -0.1        0.81        perf-profile.calltrace.cycles-pp.walk_pud_range.walk_p4d_range.walk_pgd_range.__walk_page_range.walk_page_range
>       0.69            -0.1        0.58        perf-profile.calltrace.cycles-pp.update_rq_clock_task.sched_ttwu_pending.flush_smp_call_function_queue.do_idle.cpu_startup_entry
>       1.07 ±  2%      -0.1        0.97 ±  3%  perf-profile.calltrace.cycles-pp.__mmap
>       0.82 ±  2%      -0.1        0.72        perf-profile.calltrace.cycles-pp.mas_walk.find_vma_prev.do_madvise.__x64_sys_madvise.do_syscall_64
>       1.07 ±  2%      -0.1        0.97 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
>       1.07 ±  2%      -0.1        0.97 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
>       0.79 ±  2%      -0.1        0.69        perf-profile.calltrace.cycles-pp.llist_reverse_order.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
>       1.09 ±  3%      -0.1        1.00 ±  4%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>       0.61 ±  2%      -0.1        0.52        perf-profile.calltrace.cycles-pp.select_task_rq.try_to_wake_up.wake_up_q.rwsem_wake.up_write
>       0.76 ±  3%      -0.1        0.67        perf-profile.calltrace.cycles-pp.mtree_range_walk.mas_walk.find_vma_prev.do_madvise.__x64_sys_madvise
>       1.05 ±  3%      -0.1        0.96 ±  4%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
>       0.73 ±  2%      -0.1        0.64 ±  2%  perf-profile.calltrace.cycles-pp.wake_q_add.rwsem_mark_wake.rwsem_wake.up_write.do_madvise
>       0.64 ±  2%      -0.1        0.56 ±  2%  perf-profile.calltrace.cycles-pp.reclaim_pages.madvise_cold_or_pageout_pte_range.walk_pmd_range.walk_pud_range.walk_p4d_range
>       0.60 ±  2%      -0.1        0.52 ±  2%  perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_complete.__split_vma.madvise_vma_behavior.do_madvise
>       1.70            -0.1        1.63        perf-profile.calltrace.cycles-pp.rwsem_mark_wake.rwsem_wake.up_write.do_madvise.__x64_sys_madvise
>       0.61 ±  2%      -0.1        0.54 ±  2%  perf-profile.calltrace.cycles-pp.reclaim_folio_list.reclaim_pages.madvise_cold_or_pageout_pte_range.walk_pmd_range.walk_pud_range
>       0.60 ±  3%      -0.1        0.53 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
>       0.60 ±  3%      -0.1        0.53 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
>       0.60 ±  3%      -0.1        0.53 ±  2%  perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
>       0.60 ±  3%      -0.1        0.53 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
>       0.60 ±  3%      -0.1        0.53 ±  2%  perf-profile.calltrace.cycles-pp.__munmap
>       0.63 ±  2%      -0.1        0.56 ±  5%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
>       0.63 ±  2%      -0.1        0.56 ±  5%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
>       0.68            -0.1        0.62        perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
>       0.60 ±  3%      -0.1        0.54 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable
>       0.62 ±  2%      -0.1        0.56 ±  4%  perf-profile.calltrace.cycles-pp.__mm_populate.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.62 ±  2%      -0.1        0.56 ±  4%  perf-profile.calltrace.cycles-pp.__get_user_pages.populate_vma_page_range.__mm_populate.vm_mmap_pgoff.ksys_mmap_pgoff
>       0.62 ±  2%      -0.1        0.56 ±  4%  perf-profile.calltrace.cycles-pp.populate_vma_page_range.__mm_populate.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
>       0.76 ±  2%      -0.1        0.70 ±  3%  perf-profile.calltrace.cycles-pp.vma_complete.__split_vma.madvise_vma_behavior.do_madvise.__x64_sys_madvise
>       0.66 ±  3%      -0.0        0.62 ±  4%  perf-profile.calltrace.cycles-pp.madvise_free_single_vma.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
>       0.58 ±  2%      -0.0        0.54 ±  3%  perf-profile.calltrace.cycles-pp.wake_up_q.rwsem_wake.up_read.do_madvise.__x64_sys_madvise
>       0.88            +0.1        0.94 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.do_madvise.__x64_sys_madvise.do_syscall_64
>       1.23            +0.1        1.30        perf-profile.calltrace.cycles-pp.up_read.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       1.89            +0.1        1.98        perf-profile.calltrace.cycles-pp.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.do_madvise.__x64_sys_madvise
>       1.83            +0.1        1.92        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable
>       1.88            +0.1        1.98        perf-profile.calltrace.cycles-pp.schedule.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.do_madvise
>       0.92 ±  3%      +0.1        1.02 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.rwsem_down_write_slowpath.down_write_killable.do_madvise
>       1.25            +0.1        1.36        perf-profile.calltrace.cycles-pp.down_read.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.65 ±  3%      +0.1        0.76        perf-profile.calltrace.cycles-pp.wake_up_q.rwsem_wake.up_read.__do_sys_msync.do_syscall_64
>       0.55 ±  2%      +0.1        0.66        perf-profile.calltrace.cycles-pp.try_to_wake_up.wake_up_q.rwsem_wake.up_read.__do_sys_msync
>       1.45 ±  2%      +0.1        1.57 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.rwsem_down_write_slowpath.down_write_killable.do_madvise.__x64_sys_madvise
>       0.95            +0.1        1.08        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.rwsem_wake.up_write.do_madvise.__x64_sys_madvise
>       1.47            +0.2        1.62        perf-profile.calltrace.cycles-pp.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>       8.28            +0.2        8.47        perf-profile.calltrace.cycles-pp.__do_sys_msync.do_syscall_64.entry_SYSCALL_64_after_hwframe.msync
>       1.35 ±  2%      +0.2        1.58        perf-profile.calltrace.cycles-pp.rwsem_wake.up_read.__do_sys_msync.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       2.28            +0.5        2.77        perf-profile.calltrace.cycles-pp.up_read.__do_sys_msync.do_syscall_64.entry_SYSCALL_64_after_hwframe.msync
>       0.00            +0.6        0.61 ±  2%  perf-profile.calltrace.cycles-pp.mm_cid_get.__schedule.schedule_idle.do_idle.cpu_startup_entry
>       0.00            +0.6        0.62 ±  2%  perf-profile.calltrace.cycles-pp.osq_unlock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.do_madvise
>      53.90            +3.8       57.74        perf-profile.calltrace.cycles-pp.__madvise
>      53.26            +3.9       57.14        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__madvise
>      53.18            +3.9       57.07        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
>      52.95            +3.9       56.85        perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
>      52.99            +3.9       56.89        perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
>      18.92            +4.0       22.89        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.do_madvise
>      25.94            +4.8       30.73        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.do_madvise.__x64_sys_madvise
>      30.65            +5.3       35.96        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write_killable.do_madvise.__x64_sys_madvise.do_syscall_64
>      31.48            +5.3       36.82        perf-profile.calltrace.cycles-pp.down_write_killable.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      26.65            -2.5       24.11        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
>      26.65            -2.5       24.11        perf-profile.children.cycles-pp.cpu_startup_entry
>      26.62            -2.5       24.09        perf-profile.children.cycles-pp.do_idle
>      26.22            -2.5       23.75        perf-profile.children.cycles-pp.start_secondary
>      17.51            -1.9       15.66        perf-profile.children.cycles-pp.cpuidle_idle_call
>      16.49            -1.8       14.72        perf-profile.children.cycles-pp.cpuidle_enter
>      12.55            -1.8       10.79        perf-profile.children.cycles-pp.intel_idle
>      16.41            -1.8       14.65        perf-profile.children.cycles-pp.cpuidle_enter_state
>      10.67            -1.3        9.40        perf-profile.children.cycles-pp.madvise_vma_behavior
>       4.48            -1.0        3.47        perf-profile.children.cycles-pp.rwsem_spin_on_owner
>       5.74            -0.7        5.04        perf-profile.children.cycles-pp.wake_up_q
>       5.37            -0.7        4.70        perf-profile.children.cycles-pp.try_to_wake_up
>       4.84            -0.6        4.22        perf-profile.children.cycles-pp.flush_smp_call_function_queue
>       3.68 ±  2%      -0.5        3.23 ±  3%  perf-profile.children.cycles-pp.walk_pgd_range
>       3.70 ±  2%      -0.5        3.24 ±  3%  perf-profile.children.cycles-pp.__walk_page_range
>       3.36 ±  3%      -0.4        2.92 ±  4%  perf-profile.children.cycles-pp.walk_pmd_range
>       3.99 ±  3%      -0.4        3.56 ±  3%  perf-profile.children.cycles-pp.read
>       3.40 ±  3%      -0.4        2.96 ±  4%  perf-profile.children.cycles-pp.walk_p4d_range
>       3.38 ±  3%      -0.4        2.94 ±  4%  perf-profile.children.cycles-pp.walk_pud_range
>       3.96 ±  3%      -0.4        3.53 ±  3%  perf-profile.children.cycles-pp.ksys_read
>       3.95 ±  3%      -0.4        3.52 ±  3%  perf-profile.children.cycles-pp.vfs_read
>       3.91 ±  3%      -0.4        3.49 ±  3%  perf-profile.children.cycles-pp.seq_read_iter
>       3.91 ±  3%      -0.4        3.49 ±  3%  perf-profile.children.cycles-pp.seq_read
>       3.22 ±  4%      -0.4        2.83 ±  4%  perf-profile.children.cycles-pp.show_smap
>       2.68            -0.4        2.29        perf-profile.children.cycles-pp.tlb_finish_mmu
>       3.07            -0.4        2.69        perf-profile.children.cycles-pp.sched_ttwu_pending
>       2.71            -0.3        2.37        perf-profile.children.cycles-pp._raw_spin_lock
>       2.48            -0.3        2.15        perf-profile.children.cycles-pp.flush_tlb_mm_range
>       2.41            -0.3        2.10        perf-profile.children.cycles-pp.on_each_cpu_cond_mask
>       2.41            -0.3        2.10        perf-profile.children.cycles-pp.smp_call_function_many_cond
>       2.50            -0.3        2.20        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
>       1.90            -0.3        1.64        perf-profile.children.cycles-pp.madvise_pageout
>       2.13            -0.3        1.87        perf-profile.children.cycles-pp.ttwu_queue_wakelist
>       2.03 ±  2%      -0.2        1.78        perf-profile.children.cycles-pp.__split_vma
>       5.57            -0.2        5.32        perf-profile.children.cycles-pp.rwsem_down_read_slowpath
>       1.82            -0.2        1.61 ±  2%  perf-profile.children.cycles-pp.ttwu_do_activate
>       1.78            -0.2        1.56        perf-profile.children.cycles-pp.__smp_call_single_queue
>       1.48            -0.2        1.26        perf-profile.children.cycles-pp.llist_add_batch
>       1.88 ±  2%      -0.2        1.66        perf-profile.children.cycles-pp.walk_page_range
>       1.75            -0.2        1.54        perf-profile.children.cycles-pp.activate_task
>       1.71            -0.2        1.51        perf-profile.children.cycles-pp.enqueue_task_fair
>       1.72            -0.2        1.53        perf-profile.children.cycles-pp.zap_page_range_single
>       1.62            -0.2        1.42        perf-profile.children.cycles-pp.enqueue_entity
>       1.66 ±  2%      -0.2        1.47        perf-profile.children.cycles-pp.asm_sysvec_call_function
>       1.47            -0.2        1.29        perf-profile.children.cycles-pp.vma_merge
>       1.43 ±  2%      -0.2        1.25        perf-profile.children.cycles-pp.mtree_range_walk
>       1.52 ±  2%      -0.2        1.34 ±  2%  perf-profile.children.cycles-pp.wake_q_add
>       1.36 ±  2%      -0.2        1.19        perf-profile.children.cycles-pp.madvise_cold_or_pageout_pte_range
>       1.32 ±  3%      -0.2        1.16        perf-profile.children.cycles-pp.sysvec_call_function
>       2.83            -0.2        2.68        perf-profile.children.cycles-pp.rwsem_mark_wake
>       7.26            -0.2        7.10        perf-profile.children.cycles-pp.up_write
>       1.22            -0.2        1.07        perf-profile.children.cycles-pp.llist_reverse_order
>       8.76            -0.2        8.61        perf-profile.children.cycles-pp.rwsem_wake
>       1.20 ±  3%      -0.2        1.05        perf-profile.children.cycles-pp.__sysvec_call_function
>       0.97            -0.1        0.82 ±  3%  perf-profile.children.cycles-pp.dequeue_task_fair
>       1.23 ±  2%      -0.1        1.08 ±  3%  perf-profile.children.cycles-pp.handle_mm_fault
>       1.22 ±  2%      -0.1        1.07 ±  2%  perf-profile.children.cycles-pp.__handle_mm_fault
>       0.88            -0.1        0.74 ±  3%  perf-profile.children.cycles-pp.dequeue_entity
>       0.92 ±  3%      -0.1        0.78        perf-profile.children.cycles-pp.madvise_cold
>       0.92 ±  2%      -0.1        0.79 ±  2%  perf-profile.children.cycles-pp.select_task_rq_fair
>       1.88 ±  2%      -0.1        1.75 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
>       0.92 ±  2%      -0.1        0.79        perf-profile.children.cycles-pp.select_task_rq
>       0.72 ±  3%      -0.1        0.60 ±  3%  perf-profile.children.cycles-pp.__pte_offset_map_lock
>       1.74 ±  2%      -0.1        1.62 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
>       1.06 ±  4%      -0.1        0.94 ±  3%  perf-profile.children.cycles-pp.pick_next_task_fair
>       0.56 ±  2%      -0.1        0.44 ±  3%  perf-profile.children.cycles-pp.__list_del_entry_valid
>       0.46 ±  3%      -0.1        0.34 ±  2%  perf-profile.children.cycles-pp.__list_add_valid
>       0.98            -0.1        0.86 ±  3%  perf-profile.children.cycles-pp.__do_softirq
>       0.91            -0.1        0.80 ±  2%  perf-profile.children.cycles-pp.update_load_avg
>       0.79            -0.1        0.68 ±  4%  perf-profile.children.cycles-pp.rcu_core
>       0.75            -0.1        0.63 ±  4%  perf-profile.children.cycles-pp.rcu_do_batch
>       0.98 ±  2%      -0.1        0.86        perf-profile.children.cycles-pp.find_vma_prev
>       0.86 ±  2%      -0.1        0.75        perf-profile.children.cycles-pp.mas_walk
>       0.76            -0.1        0.65        perf-profile.children.cycles-pp.mt_find
>       0.80            -0.1        0.70 ±  2%  perf-profile.children.cycles-pp.mas_store_prealloc
>       1.00 ±  2%      -0.1        0.89 ±  3%  perf-profile.children.cycles-pp.__mm_populate
>       0.81            -0.1        0.70        perf-profile.children.cycles-pp.update_rq_clock_task
>       0.99 ±  2%      -0.1        0.89 ±  3%  perf-profile.children.cycles-pp.__get_user_pages
>       0.99 ±  2%      -0.1        0.89 ±  3%  perf-profile.children.cycles-pp.populate_vma_page_range
>       0.66 ±  2%      -0.1        0.55        perf-profile.children.cycles-pp.find_vma
>       1.08 ±  2%      -0.1        0.97 ±  3%  perf-profile.children.cycles-pp.vm_mmap_pgoff
>       1.07 ±  2%      -0.1        0.97 ±  3%  perf-profile.children.cycles-pp.__mmap
>       0.74 ±  2%      -0.1        0.64 ±  2%  perf-profile.children.cycles-pp.available_idle_cpu
>       0.40 ±  9%      -0.1        0.30 ± 12%  perf-profile.children.cycles-pp.zap_pmd_range
>       0.75 ±  2%      -0.1        0.65        perf-profile.children.cycles-pp.wake_affine
>       0.75 ±  2%      -0.1        0.66        perf-profile.children.cycles-pp.default_send_IPI_mask_sequence_phys
>       0.44 ±  9%      -0.1        0.35 ± 11%  perf-profile.children.cycles-pp.unmap_page_range
>       0.78 ±  2%      -0.1        0.69 ±  3%  perf-profile.children.cycles-pp.reclaim_pages
>       0.38 ± 10%      -0.1        0.29 ± 13%  perf-profile.children.cycles-pp.zap_pte_range
>       0.76 ±  2%      -0.1        0.67 ±  3%  perf-profile.children.cycles-pp.reclaim_folio_list
>       0.60 ±  3%      -0.1        0.51 ±  2%  perf-profile.children.cycles-pp.do_vmi_align_munmap
>       0.59 ±  3%      -0.1        0.51 ±  2%  perf-profile.children.cycles-pp.do_vmi_munmap
>       0.71            -0.1        0.63 ±  4%  perf-profile.children.cycles-pp.shrink_folio_list
>       0.66 ±  2%      -0.1        0.59        perf-profile.children.cycles-pp.seq_put_decimal_ull_width
>       0.45 ±  3%      -0.1        0.37 ±  7%  perf-profile.children.cycles-pp.ret_from_fork
>       0.61 ±  3%      -0.1        0.53 ±  2%  perf-profile.children.cycles-pp.__x64_sys_munmap
>       1.00 ±  2%      -0.1        0.92 ±  2%  perf-profile.children.cycles-pp.vma_complete
>       0.61 ±  3%      -0.1        0.53 ±  2%  perf-profile.children.cycles-pp.__vm_munmap
>       0.18 ± 22%      -0.1        0.10 ± 43%  perf-profile.children.cycles-pp.unmap_vmas
>       0.44 ±  3%      -0.1        0.37 ±  7%  perf-profile.children.cycles-pp.kthread
>       0.61 ±  3%      -0.1        0.53 ±  2%  perf-profile.children.cycles-pp.__munmap
>       0.62 ±  2%      -0.1        0.55 ±  4%  perf-profile.children.cycles-pp.do_fault
>       0.77 ±  2%      -0.1        0.70 ±  2%  perf-profile.children.cycles-pp.__irq_exit_rcu
>       0.41 ±  2%      -0.1        0.34 ±  2%  perf-profile.children.cycles-pp.anon_vma_clone
>       0.64 ±  2%      -0.1        0.56 ±  4%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
>       0.61 ±  2%      -0.1        0.54        perf-profile.children.cycles-pp.__default_send_IPI_dest_field
>       0.43 ±  3%      -0.1        0.37 ±  3%  perf-profile.children.cycles-pp.__slab_free
>       0.49 ±  2%      -0.1        0.42 ±  2%  perf-profile.children.cycles-pp.stress_mwc64
>       0.45 ±  3%      -0.1        0.38 ±  4%  perf-profile.children.cycles-pp.folio_batch_move_lru
>       0.60 ±  2%      -0.1        0.53 ±  4%  perf-profile.children.cycles-pp.do_cow_fault
>       0.70            -0.1        0.64        perf-profile.children.cycles-pp.menu_select
>       0.34 ±  3%      -0.1        0.28 ±  8%  perf-profile.children.cycles-pp.smpboot_thread_fn
>       0.92 ±  3%      -0.1        0.86 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
>       0.53 ±  4%      -0.1        0.47 ±  2%  perf-profile.children.cycles-pp.flush_tlb_func
>       0.15 ±  4%      -0.1        0.09 ±  7%  perf-profile.children.cycles-pp.__task_rq_lock
>       0.61 ±  2%      -0.1        0.55        perf-profile.children.cycles-pp.call_function_single_prep_ipi
>       0.37 ±  4%      -0.1        0.31 ±  2%  perf-profile.children.cycles-pp.vma_prepare
>       0.36 ±  2%      -0.1        0.30 ±  2%  perf-profile.children.cycles-pp.stress_mwc32
>       0.53 ±  2%      -0.1        0.47        perf-profile.children.cycles-pp.__show_smap
>       0.91 ±  2%      -0.1        0.86 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
>       0.41 ±  2%      -0.1        0.36 ±  2%  perf-profile.children.cycles-pp.native_sched_clock
>       0.36 ±  4%      -0.1        0.30 ±  4%  perf-profile.children.cycles-pp.mas_alloc_nodes
>       0.36 ±  3%      -0.1        0.30 ±  4%  perf-profile.children.cycles-pp.mas_preallocate
>       0.30 ±  4%      -0.1        0.25 ±  8%  perf-profile.children.cycles-pp.run_ksoftirqd
>       0.52 ±  2%      -0.1        0.47 ±  2%  perf-profile.children.cycles-pp.do_sys_openat2
>       0.42 ±  3%      -0.1        0.37 ±  4%  perf-profile.children.cycles-pp.clear_page_erms
>       0.30 ±  2%      -0.1        0.25 ±  3%  perf-profile.children.cycles-pp.release_pages
>       0.54            -0.1        0.48        perf-profile.children.cycles-pp.open64
>       0.28 ±  3%      -0.1        0.23 ±  3%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
>       0.52            -0.1        0.47 ±  2%  perf-profile.children.cycles-pp.__x64_sys_openat
>       0.34 ±  2%      -0.1        0.30 ±  3%  perf-profile.children.cycles-pp.down_write
>       0.27 ±  5%      -0.1        0.22 ±  3%  perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
>       0.39 ±  3%      -0.0        0.34 ±  4%  perf-profile.children.cycles-pp.__do_huge_pmd_anonymous_page
>       0.32 ±  3%      -0.0        0.27        perf-profile.children.cycles-pp.unmap_region
>       0.41            -0.0        0.36 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc
>       0.39 ±  3%      -0.0        0.34 ±  4%  perf-profile.children.cycles-pp.clear_huge_page
>       0.31 ±  3%      -0.0        0.26 ±  4%  perf-profile.children.cycles-pp.prepare_task_switch
>       0.31 ±  3%      -0.0        0.26 ±  3%  perf-profile.children.cycles-pp.folio_referenced
>       0.34 ±  4%      -0.0        0.29 ±  3%  perf-profile.children.cycles-pp.lru_add_drain_cpu
>       0.43 ±  2%      -0.0        0.39 ±  2%  perf-profile.children.cycles-pp.do_filp_open
>       0.45 ±  3%      -0.0        0.41 ±  2%  perf-profile.children.cycles-pp.__update_load_avg_se
>       0.34 ±  4%      -0.0        0.29 ±  3%  perf-profile.children.cycles-pp.lru_add_drain
>       0.28 ±  2%      -0.0        0.23 ±  3%  perf-profile.children.cycles-pp.mas_wr_modify
>       0.34 ±  2%      -0.0        0.29 ±  3%  perf-profile.children.cycles-pp.rmap_walk_anon
>       0.28 ±  3%      -0.0        0.24 ±  4%  perf-profile.children.cycles-pp.kmem_cache_alloc_bulk
>       0.33 ±  3%      -0.0        0.29 ±  4%  perf-profile.children.cycles-pp.__entry_text_start
>       0.43 ±  2%      -0.0        0.38 ±  3%  perf-profile.children.cycles-pp.path_openat
>       0.28 ±  6%      -0.0        0.24 ±  2%  perf-profile.children.cycles-pp.update_cfs_group
>       0.29 ±  6%      -0.0        0.25 ±  9%  perf-profile.children.cycles-pp.exc_page_fault
>       0.29 ±  6%      -0.0        0.25 ±  9%  perf-profile.children.cycles-pp.do_user_addr_fault
>       0.62 ±  3%      -0.0        0.57 ±  2%  perf-profile.children.cycles-pp.tick_sched_handle
>       0.46            -0.0        0.42 ±  2%  perf-profile.children.cycles-pp.smaps_account
>       0.36 ±  4%      -0.0        0.32        perf-profile.children.cycles-pp.seq_puts
>       0.26 ±  4%      -0.0        0.22 ±  4%  perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
>       0.28 ±  2%      -0.0        0.24 ±  4%  perf-profile.children.cycles-pp.__do_sys_process_madvise
>       0.26 ±  6%      -0.0        0.23 ±  5%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
>       0.29            -0.0        0.26 ±  4%  perf-profile.children.cycles-pp.vm_area_dup
>       0.27            -0.0        0.23 ±  2%  perf-profile.children.cycles-pp.mas_wr_node_store
>       0.25 ±  4%      -0.0        0.21 ±  6%  perf-profile.children.cycles-pp.___perf_sw_event
>       0.28 ±  2%      -0.0        0.24 ±  3%  perf-profile.children.cycles-pp.syscall
>       0.27 ±  4%      -0.0        0.23 ±  5%  perf-profile.children.cycles-pp.mas_wr_bnode
>       0.30 ±  5%      -0.0        0.27 ±  5%  perf-profile.children.cycles-pp.show_map_vma
>       0.23 ±  4%      -0.0        0.20 ±  9%  perf-profile.children.cycles-pp.pthread_create@@GLIBC_2.2.5
>       0.17 ±  4%      -0.0        0.14        perf-profile.children.cycles-pp.__anon_vma_interval_tree_subtree_search
>       0.23 ±  2%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.num_to_str
>       0.30            -0.0        0.27 ±  4%  perf-profile.children.cycles-pp.kmem_cache_free
>       0.29 ±  3%      -0.0        0.26 ±  3%  perf-profile.children.cycles-pp.down_read_killable
>       0.19 ±  3%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
>       0.24 ±  4%      -0.0        0.21 ±  5%  perf-profile.children.cycles-pp.mas_split
>       0.18 ±  2%      -0.0        0.16 ±  6%  perf-profile.children.cycles-pp.stress_madvise_pages
>       0.26 ±  4%      -0.0        0.24 ±  2%  perf-profile.children.cycles-pp.native_irq_return_iret
>       0.28            -0.0        0.25 ±  6%  perf-profile.children.cycles-pp.update_curr
>       0.22 ±  3%      -0.0        0.19 ±  4%  perf-profile.children.cycles-pp.vm_area_free_rcu_cb
>       0.19 ±  3%      -0.0        0.16 ±  7%  perf-profile.children.cycles-pp.folio_alloc_swap
>       0.30 ±  2%      -0.0        0.27 ±  5%  perf-profile.children.cycles-pp.copy_page
>       0.24 ±  4%      -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.unlink_anon_vmas
>       0.22 ±  4%      -0.0        0.19 ±  4%  perf-profile.children.cycles-pp.mtree_load
>       0.19 ±  3%      -0.0        0.17 ±  7%  perf-profile.children.cycles-pp.add_to_swap
>       0.16 ±  3%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.mas_destroy
>       0.14 ±  4%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.__mem_cgroup_try_charge_swap
>       0.22 ±  3%      -0.0        0.19 ±  4%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
>       0.14 ±  3%      -0.0        0.11 ±  5%  perf-profile.children.cycles-pp.folio_isolate_lru
>       0.19 ±  4%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.strlen
>       0.48 ±  3%      -0.0        0.46 ±  3%  perf-profile.children.cycles-pp.scheduler_tick
>       0.26 ±  3%      -0.0        0.23 ±  2%  perf-profile.children.cycles-pp.sched_clock_cpu
>       0.11 ±  6%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.vma_interval_tree_insert
>       0.14 ±  3%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.tlb_gather_mmu
>       0.09 ±  4%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.free_unref_page
>       0.14 ±  3%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.memcg_memory_event
>       0.14 ±  2%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.kernel_clone
>       0.14 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.can_vma_merge_before
>       0.06 ±  7%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.__rb_erase_color
>       0.18 ±  4%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.free_pgtables
>       0.15 ±  3%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.__clone
>       0.13 ±  2%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.kmem_cache_free_bulk
>       0.12 ±  5%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.__alloc_file
>       0.24 ±  2%      -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.__switch_to_asm
>       0.17 ±  2%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.update_rq_clock
>       0.14 ±  3%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__do_sys_clone
>       0.10 ±  5%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
>       0.12 ±  4%      -0.0        0.11 ±  9%  perf-profile.children.cycles-pp.stress_mwc64modn
>       0.09 ±  6%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
>       0.08 ±  7%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.os_xsave
>       0.08 ±  5%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__unfreeze_partials
>       0.07 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.dup_task_struct
>       0.10 ±  5%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.mas_descend_adopt
>       0.13 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
>       0.15 ±  3%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
>       0.08 ±  5%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.lookup_fast
>       0.12 ±  4%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
>       0.29 ±  4%      +0.0        0.33 ±  3%  perf-profile.children.cycles-pp.poll_idle
>       1.60            +0.1        1.75        perf-profile.children.cycles-pp.intel_idle_irq
>       8.30            +0.2        8.48        perf-profile.children.cycles-pp.__do_sys_msync
>       2.88            +0.2        3.07        perf-profile.children.cycles-pp._raw_spin_lock_irq
>       0.42 ±  3%      +0.2        0.63 ±  2%  perf-profile.children.cycles-pp.osq_unlock
>       0.40 ±  2%      +0.2        0.63 ±  2%  perf-profile.children.cycles-pp.mm_cid_get
>       2.46            +0.3        2.71        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>       0.75            +0.3        1.05        perf-profile.children.cycles-pp.finish_task_switch
>       3.84            +0.6        4.40        perf-profile.children.cycles-pp.up_read
>      68.93            +3.2       72.16        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>      68.78            +3.2       72.03        perf-profile.children.cycles-pp.do_syscall_64
>      54.04            +3.8       57.86        perf-profile.children.cycles-pp.__madvise
>      53.27            +3.9       57.13        perf-profile.children.cycles-pp.do_madvise
>      53.00            +3.9       56.89        perf-profile.children.cycles-pp.__x64_sys_madvise
>      19.07            +4.0       23.06        perf-profile.children.cycles-pp.osq_lock
>      26.60            +4.7       31.35        perf-profile.children.cycles-pp.rwsem_optimistic_spin
>      30.77            +5.3       36.11        perf-profile.children.cycles-pp.rwsem_down_write_slowpath
>      31.58            +5.4       36.95        perf-profile.children.cycles-pp.down_write_killable
>      12.55            -1.8       10.79        perf-profile.self.cycles-pp.intel_idle
>       3.82 ±  2%      -0.9        2.92        perf-profile.self.cycles-pp.rwsem_spin_on_owner
>       2.50            -0.3        2.20        perf-profile.self.cycles-pp._raw_spin_lock
>       1.44            -0.2        1.23        perf-profile.self.cycles-pp.llist_add_batch
>       1.40            -0.2        1.22        perf-profile.self.cycles-pp.mtree_range_walk
>       1.51 ±  2%      -0.2        1.34        perf-profile.self.cycles-pp.wake_q_add
>       1.22            -0.2        1.06        perf-profile.self.cycles-pp.llist_reverse_order
>       0.97 ±  2%      -0.1        0.83 ±  2%  perf-profile.self.cycles-pp.do_madvise
>       1.00 ±  2%      -0.1        0.88        perf-profile.self.cycles-pp.smp_call_function_many_cond
>       0.56 ±  3%      -0.1        0.43 ±  2%  perf-profile.self.cycles-pp.__list_del_entry_valid
>       0.45 ±  2%      -0.1        0.33 ±  2%  perf-profile.self.cycles-pp.__list_add_valid
>       0.81 ±  2%      -0.1        0.71        perf-profile.self.cycles-pp.enqueue_entity
>       0.76            -0.1        0.67        perf-profile.self.cycles-pp.update_rq_clock_task
>       0.73 ±  2%      -0.1        0.63 ±  2%  perf-profile.self.cycles-pp.available_idle_cpu
>       0.81 ±  2%      -0.1        0.71 ±  2%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
>       0.73 ±  2%      -0.1        0.64        perf-profile.self.cycles-pp.flush_smp_call_function_queue
>       0.85            -0.1        0.77 ±  2%  perf-profile.self.cycles-pp.madvise_vma_behavior
>       0.61            -0.1        0.54        perf-profile.self.cycles-pp.__default_send_IPI_dest_field
>       0.43 ±  3%      -0.1        0.36 ±  4%  perf-profile.self.cycles-pp.__slab_free
>       0.47 ±  2%      -0.1        0.40        perf-profile.self.cycles-pp.stress_mwc64
>       0.60            -0.1        0.55 ±  2%  perf-profile.self.cycles-pp.call_function_single_prep_ipi
>       0.35 ±  3%      -0.1        0.29 ±  3%  perf-profile.self.cycles-pp.stress_mwc32
>       0.41 ±  4%      -0.1        0.36 ±  4%  perf-profile.self.cycles-pp.clear_page_erms
>       0.39 ±  2%      -0.1        0.34 ±  2%  perf-profile.self.cycles-pp.native_sched_clock
>       0.27 ±  6%      -0.0        0.22 ±  3%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
>       0.33 ±  2%      -0.0        0.28 ±  2%  perf-profile.self.cycles-pp.down_write
>       0.44 ±  3%      -0.0        0.39 ±  3%  perf-profile.self.cycles-pp.__update_load_avg_se
>       0.32 ±  5%      -0.0        0.28 ±  3%  perf-profile.self.cycles-pp.flush_tlb_func
>       0.19 ±  3%      -0.0        0.14 ±  6%  perf-profile.self.cycles-pp.dequeue_entity
>       0.27 ±  7%      -0.0        0.23        perf-profile.self.cycles-pp.update_cfs_group
>       0.33 ±  2%      -0.0        0.30        perf-profile.self.cycles-pp.vma_merge
>       0.26 ±  6%      -0.0        0.22 ±  5%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
>       0.31 ±  3%      -0.0        0.28 ±  3%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
>       0.46            -0.0        0.42 ±  2%  perf-profile.self.cycles-pp.menu_select
>       0.22 ±  4%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.mtree_load
>       0.17 ±  4%      -0.0        0.14 ±  7%  perf-profile.self.cycles-pp.__kmem_cache_alloc_bulk
>       0.22 ±  4%      -0.0        0.19 ±  5%  perf-profile.self.cycles-pp.___perf_sw_event
>       0.30 ±  3%      -0.0        0.27 ±  6%  perf-profile.self.cycles-pp.copy_page
>       0.26 ±  4%      -0.0        0.24 ±  2%  perf-profile.self.cycles-pp.native_irq_return_iret
>       0.38 ±  2%      -0.0        0.35 ±  3%  perf-profile.self.cycles-pp.wake_up_q
>       0.29 ±  3%      -0.0        0.26 ±  4%  perf-profile.self.cycles-pp.smaps_account
>       0.20 ±  2%      -0.0        0.18 ±  4%  perf-profile.self.cycles-pp.update_load_avg
>       0.16 ±  3%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_subtree_search
>       0.07 ±  5%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.__task_rq_lock
>       0.18 ±  5%      -0.0        0.15 ±  4%  perf-profile.self.cycles-pp.__do_sys_msync
>       0.14 ±  3%      -0.0        0.12 ±  5%  perf-profile.self.cycles-pp.can_vma_merge_before
>       0.23 ±  2%      -0.0        0.21 ±  4%  perf-profile.self.cycles-pp.kmem_cache_free
>       0.11 ±  6%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.vma_interval_tree_insert
>       0.18 ±  4%      -0.0        0.15 ±  4%  perf-profile.self.cycles-pp.strlen
>       0.28 ±  3%      -0.0        0.26 ±  2%  perf-profile.self.cycles-pp.walk_pgd_range
>       0.17 ±  4%      -0.0        0.15 ±  4%  perf-profile.self.cycles-pp.msync
>       0.15 ±  3%      -0.0        0.13 ±  2%  perf-profile.self.cycles-pp.stress_madvise_pages
>       0.13 ±  4%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.tlb_gather_mmu
>       0.21 ±  3%      -0.0        0.19 ±  4%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
>       0.18 ±  4%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.__madvise
>       0.18 ±  3%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.num_to_str
>       0.14 ±  3%      -0.0        0.12 ±  6%  perf-profile.self.cycles-pp.flush_tlb_mm_range
>       0.12 ±  5%      -0.0        0.10 ±  9%  perf-profile.self.cycles-pp.__entry_text_start
>       0.10 ±  3%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.vma_complete
>       0.09 ±  5%      -0.0        0.07 ± 10%  perf-profile.self.cycles-pp.select_task_rq_fair
>       0.06 ±  6%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.format_decode
>       0.12 ±  4%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.zap_pte_range
>       0.09 ±  4%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.kmem_cache_free_bulk
>       0.08 ±  6%      -0.0        0.06        perf-profile.self.cycles-pp.os_xsave
>       0.09 ±  4%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.mas_walk
>       0.14 ±  3%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.read_tsc
>       0.08 ±  6%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.cpuidle_enter
>       0.26 ±  5%      +0.0        0.30 ±  4%  perf-profile.self.cycles-pp.poll_idle
>       0.96 ±  2%      +0.1        1.06        perf-profile.self.cycles-pp.rwsem_mark_wake
>       1.06            +0.1        1.18 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>       1.42            +0.2        1.57        perf-profile.self.cycles-pp.intel_idle_irq
>       1.33 ±  2%      +0.2        1.49 ±  2%  perf-profile.self.cycles-pp.down_read
>       0.99            +0.2        1.15 ±  2%  perf-profile.self.cycles-pp.rwsem_down_read_slowpath
>       0.40 ±  3%      +0.2        0.61 ±  2%  perf-profile.self.cycles-pp.osq_unlock
>       0.96 ±  2%      +0.2        1.17        perf-profile.self.cycles-pp.up_write
>       0.78 ±  2%      +0.2        1.00 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irq
>       0.39 ±  2%      +0.2        0.62 ±  2%  perf-profile.self.cycles-pp.mm_cid_get
>       0.48 ±  2%      +0.3        0.78 ±  2%  perf-profile.self.cycles-pp.finish_task_switch
>       1.35            +0.3        1.68        perf-profile.self.cycles-pp.up_read
>       0.53 ±  2%      +0.4        0.92 ±  3%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
>       2.97            +1.5        4.47        perf-profile.self.cycles-pp.rwsem_optimistic_spin
>      18.35            +4.0       22.39        perf-profile.self.cycles-pp.osq_lock
> 
> 
> ***************************************************************************************************
> lkp-skl-fpga01: 104 threads 2 sockets (Skylake) with 192G memory
> =========================================================================================
> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
>   gcc-12/performance/x86_64-rhel-8.3/thread/50%/debian-11.1-x86_64-20220510.cgz/lkp-skl-fpga01/context_switch1/will-it-scale
> 
> commit: 
>   025b7799b3 ("mm/memcg: remove return value of mem_cgroup_scan_tasks()")
>   c1753fd02a ("mm: move mm_count into its own cache line")
> 
> 025b7799b35d32e4 c1753fd02a0058ea43cbb31ab26 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>  2.977e+09 ±  5%     -34.9%  1.937e+09 ±  9%  cpuidle..time
>   1.57e+09 ±  2%     +92.4%  3.022e+09 ± 10%  cpuidle..usage
>    3038432 ± 20%     +43.2%    4349518 ±  3%  meminfo.Active
>    3037608 ± 20%     +43.2%    4348692 ±  3%  meminfo.Active(anon)
>    2988708 ± 20%     +44.6%    4320355 ±  3%  numa-meminfo.node1.Active
>    2988570 ± 20%     +44.5%    4319945 ±  3%  numa-meminfo.node1.Active(anon)
>     747629 ± 20%     +44.2%    1078438 ±  3%  numa-vmstat.node1.nr_active_anon
>     747628 ± 20%     +44.2%    1078437 ±  3%  numa-vmstat.node1.nr_zone_active_anon
>      12.00           +58.3%      19.00 ±  3%  vmstat.cpu.us
>   10422399 ±  2%     +93.6%   20172635 ±  9%  vmstat.system.cs
>     145941 ±  2%     +72.6%     251898 ± 12%  vmstat.system.in
>      22.53 ±  3%      +3.0       25.50 ±  5%  mpstat.cpu.all.idle%
>       0.09            +0.0        0.11 ±  2%  mpstat.cpu.all.soft%
>      63.71           -10.2       53.49 ±  3%  mpstat.cpu.all.sys%
>      12.32            +7.2       19.54 ±  2%  mpstat.cpu.all.usr%
>       1206 ± 11%     -73.1%     324.67 ± 34%  perf-c2c.DRAM.remote
>       5740 ± 12%     -34.8%       3744 ± 35%  perf-c2c.HITM.local
>       1077 ±  7%     -75.8%     261.00 ± 36%  perf-c2c.HITM.remote
>       6818 ± 11%     -41.3%       4005 ± 35%  perf-c2c.HITM.total
>    5340158 ±  2%     +92.2%   10261925 ±  9%  will-it-scale.52.threads
>      21.82 ±  3%     +15.4%      25.18 ±  4%  will-it-scale.52.threads_idle
>     102694 ±  2%     +92.2%     197344 ±  9%  will-it-scale.per_thread_ops
>    5340158 ±  2%     +92.2%   10261925 ±  9%  will-it-scale.workload
>     758948 ± 19%     +43.3%    1087255 ±  3%  proc-vmstat.nr_active_anon
>     758948 ± 19%     +43.3%    1087255 ±  3%  proc-vmstat.nr_zone_active_anon
>      29851 ± 53%     -50.7%      14723 ± 37%  proc-vmstat.numa_pages_migrated
>     887090 ±  2%      -3.0%     860349        proc-vmstat.pgfree
>      29851 ± 53%     -50.7%      14723 ± 37%  proc-vmstat.pgmigrate_success
>      45860 ± 17%     -21.2%      36152        proc-vmstat.pgreuse
>  1.425e+08 ± 22%     -99.2%    1205856 ± 23%  turbostat.C1
>       1.44 ± 30%      -1.4        0.01        turbostat.C1%
>      19609 ±  4%     -20.9%      15503 ±  4%  turbostat.C1E
>       1.29 ±  8%     -52.6%       0.61 ± 20%  turbostat.CPU%c1
>       0.06 ±  6%     +80.0%       0.10 ± 10%  turbostat.IPC
>   44599035 ±  2%     +72.0%   76689229 ± 11%  turbostat.IRQ
>       2.23 ± 34%     +82.2       84.46 ± 42%  turbostat.PKG_%
>  1.428e+09 ±  3%    +111.6%  3.021e+09 ± 10%  turbostat.POLL
>       6.94 ±  5%      -1.5        5.44 ±  9%  turbostat.POLL%
>     341.57            +9.5%     374.18        turbostat.PkgWatt
>      49.88 ± 43%    +191.6%     145.46 ± 39%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       0.09 ± 67%     -93.2%       0.01 ±115%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>       8.05 ± 20%     +74.7%      14.07 ± 19%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       1006           +66.5%       1677 ± 28%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>      83.24 ± 35%     -88.7%       9.37 ±104%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>       0.11 ±  7%     -18.0%       0.09 ±  4%  perf-sched.total_wait_and_delay.average.ms
>       0.09 ±  6%     -18.6%       0.08 ±  4%  perf-sched.total_wait_time.average.ms
>      11.71 ±  5%     +15.5%      13.52 ±  3%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
>     227.71 ± 21%    +104.6%     465.98 ± 34%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>      22.61 ± 12%     +54.6%      34.97 ± 17%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       7.17 ± 16%     -25.6%       5.33 ± 17%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
>     344.00 ±  6%     -28.1%     247.17 ± 17%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>      11.70 ±  5%     +15.4%      13.49 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
>       0.01 ±  7%     -35.4%       0.01 ± 13%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
>       0.11 ± 58%     -77.4%       0.02 ± 73%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>      14.56 ±  8%     +43.5%      20.90 ± 15%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>     143477 ± 25%     +82.2%     261348 ± 21%  sched_debug.cfs_rq:/.MIN_vruntime.avg
>    3910496           +13.9%    4454795        sched_debug.cfs_rq:/.MIN_vruntime.max
>     702315 ± 13%     +42.3%     999495 ±  9%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
>       0.56 ±  3%     +15.7%       0.65        sched_debug.cfs_rq:/.h_nr_running.avg
>       2.03 ± 16%     -64.4%       0.72 ± 17%  sched_debug.cfs_rq:/.load_avg.min
>     143477 ± 25%     +82.2%     261348 ± 21%  sched_debug.cfs_rq:/.max_vruntime.avg
>    3910496           +13.9%    4454795        sched_debug.cfs_rq:/.max_vruntime.max
>     702315 ± 13%     +42.3%     999495 ±  9%  sched_debug.cfs_rq:/.max_vruntime.stddev
>    3851680           +11.0%    4274174 ±  2%  sched_debug.cfs_rq:/.min_vruntime.avg
>    4306537 ±  3%     +16.8%    5029214 ±  2%  sched_debug.cfs_rq:/.min_vruntime.max
>    3775558           +11.0%    4192147 ±  2%  sched_debug.cfs_rq:/.min_vruntime.min
>       0.52 ±  4%     +23.9%       0.65 ±  2%  sched_debug.cfs_rq:/.nr_running.avg
>     287.94 ± 18%     -33.2%     192.31 ± 24%  sched_debug.cfs_rq:/.runnable_avg.min
>     487424 ± 29%     +56.9%     764659 ± 12%  sched_debug.cfs_rq:/.spread0.max
>     287.56 ± 18%     -33.3%     191.75 ± 25%  sched_debug.cfs_rq:/.util_avg.min
>     255.12           -12.8%     222.50 ±  7%  sched_debug.cfs_rq:/.util_est_enqueued.avg
>       5659 ±  4%     -31.2%       3894 ± 16%  sched_debug.cpu.avg_idle.min
>   15164704 ±  2%     +91.0%   28964322 ±  9%  sched_debug.cpu.nr_switches.avg
>   17539538 ±  4%     +80.6%   31675457 ±  5%  sched_debug.cpu.nr_switches.max
>   12443131 ±  7%     +75.7%   21858035 ± 10%  sched_debug.cpu.nr_switches.min
>       3.02 ± 15%     -46.6%       1.61 ± 34%  perf-stat.i.MPKI
>  1.174e+10 ±  2%     +84.1%  2.161e+10 ±  9%  perf-stat.i.branch-instructions
>  1.955e+08 ±  2%     +87.9%  3.675e+08 ±  9%  perf-stat.i.branch-misses
>   10542460 ±  2%     +93.3%   20374987 ±  9%  perf-stat.i.context-switches
>       5.10 ±  2%     -45.9%       2.76 ± 11%  perf-stat.i.cpi
>       1122            +7.0%       1201        perf-stat.i.cpu-migrations
>       0.10 ±  4%      -0.0        0.08 ±  3%  perf-stat.i.dTLB-load-miss-rate%
>   15805396 ±  4%     +53.4%   24253313 ±  8%  perf-stat.i.dTLB-load-misses
>  1.605e+10 ±  2%     +85.5%  2.976e+10 ±  9%  perf-stat.i.dTLB-loads
>       0.00 ± 19%      -0.0        0.00 ± 15%  perf-stat.i.dTLB-store-miss-rate%
>  9.617e+09 ±  2%     +87.0%  1.798e+10 ±  9%  perf-stat.i.dTLB-stores
>      29.32 ±  7%     +14.8       44.12        perf-stat.i.iTLB-load-miss-rate%
>    9215863 ±  2%    +157.5%   23727570 ± 11%  perf-stat.i.iTLB-load-misses
>   22498612 ± 10%     +33.1%   29949386 ±  9%  perf-stat.i.iTLB-loads
>  5.759e+10 ±  2%     +84.4%  1.062e+11 ±  9%  perf-stat.i.instructions
>       6285           -26.1%       4644 ±  3%  perf-stat.i.instructions-per-iTLB-miss
>       0.20 ±  2%     +84.2%       0.37 ±  9%  perf-stat.i.ipc
>     361.06 ±  2%     +85.1%     668.26 ±  9%  perf-stat.i.metric.M/sec
>    2377201 ± 11%     -70.7%     695789 ± 47%  perf-stat.i.node-load-misses
>    2206925 ± 27%     -35.5%    1424414 ± 14%  perf-stat.i.node-loads
>      89.11            +5.5       94.64        perf-stat.i.node-store-miss-rate%
>    1638034 ±  3%    +104.2%    3345555 ±  4%  perf-stat.i.node-store-misses
>       1.67            +0.0        1.70        perf-stat.overall.branch-miss-rate%
>       4.98 ±  2%     -45.1%       2.73 ± 11%  perf-stat.overall.cpi
>       0.10 ±  4%      -0.0        0.08 ±  2%  perf-stat.overall.dTLB-load-miss-rate%
>       0.00 ±  4%      -0.0        0.00 ± 15%  perf-stat.overall.dTLB-store-miss-rate%
>      29.21 ±  7%     +15.0       44.16        perf-stat.overall.iTLB-load-miss-rate%
>       6249           -28.2%       4489 ±  3%  perf-stat.overall.instructions-per-iTLB-miss
>       0.20 ±  2%     +84.1%       0.37 ±  9%  perf-stat.overall.ipc
>      52.35 ± 11%     -21.1       31.22 ± 41%  perf-stat.overall.node-load-miss-rate%
>      87.49            +6.4       93.90        perf-stat.overall.node-store-miss-rate%
>    3258006            -4.3%    3117902        perf-stat.overall.path-length
>   1.17e+10 ±  2%     +84.1%  2.154e+10 ±  9%  perf-stat.ps.branch-instructions
>  1.949e+08 ±  2%     +87.9%  3.662e+08 ±  9%  perf-stat.ps.branch-misses
>   10507840 ±  2%     +93.2%   20306310 ±  9%  perf-stat.ps.context-switches
>       1118            +7.2%       1198        perf-stat.ps.cpu-migrations
>   15766322 ±  4%     +53.4%   24180917 ±  8%  perf-stat.ps.dTLB-load-misses
>  1.599e+10 ±  2%     +85.5%  2.966e+10 ±  9%  perf-stat.ps.dTLB-loads
>  9.586e+09 ±  2%     +87.0%  1.792e+10 ±  9%  perf-stat.ps.dTLB-stores
>    9185838 ±  2%    +157.4%   23646171 ± 11%  perf-stat.ps.iTLB-load-misses
>   22428693 ± 10%     +33.1%   29846727 ±  9%  perf-stat.ps.iTLB-loads
>  5.741e+10 ±  2%     +84.4%  1.059e+11 ±  9%  perf-stat.ps.instructions
>    2369252 ± 11%     -70.7%     693656 ± 47%  perf-stat.ps.node-load-misses
>    2208271 ± 27%     -35.4%    1425540 ± 14%  perf-stat.ps.node-loads
>    1632569 ±  3%    +104.3%    3334535 ±  4%  perf-stat.ps.node-store-misses
>   1.74e+13 ±  2%     +83.8%  3.198e+13 ±  9%  perf-stat.total.instructions
>      43.54           -15.9       27.69 ± 13%  perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
>      43.66           -15.8       27.88 ± 13%  perf-profile.calltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
>      45.62           -11.1       34.56 ± 14%  perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       9.34            -9.2        0.10 ±223%  perf-profile.calltrace.cycles-pp.mm_cid_get.__schedule.schedule_idle.do_idle.cpu_startup_entry
>      13.96            -9.0        4.95 ± 10%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
>      14.10            -8.8        5.33 ± 10%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       5.33 ±  2%      -5.3        0.00        perf-profile.calltrace.cycles-pp.__switch_to.__schedule.schedule.pipe_read.vfs_read
>      14.00            -4.8        9.18 ± 13%  perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.pipe_read.vfs_read
>      34.74            -4.1       30.66 ±  7%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>      35.28            -4.0       31.28 ±  7%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
>      34.91            -4.0       30.94 ±  7%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>      34.92            -4.0       30.97 ±  7%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
>       8.80 ±  8%      -2.4        6.38 ±  9%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
>       8.86 ±  8%      -2.4        6.50 ±  9%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
>       6.58 ±  6%      -1.4        5.21 ±  9%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>       1.26 ± 32%      -0.3        0.94 ± 10%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle
>       0.56 ±  2%      +0.5        1.05 ± 10%  perf-profile.calltrace.cycles-pp.__entry_text_start.__libc_write
>       0.53 ±  2%      +0.5        1.02 ± 11%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.select_task_rq.try_to_wake_up.autoremove_wake_function.__wake_up_common
>       0.55            +0.5        1.04 ± 11%  perf-profile.calltrace.cycles-pp.__entry_text_start.__libc_read
>       0.75 ±  2%      +0.6        1.31 ± 10%  perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule_idle.do_idle
>       0.67 ±  2%      +0.6        1.23 ± 10%  perf-profile.calltrace.cycles-pp.select_task_rq.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
>       0.77 ±  4%      +0.6        1.37 ±  9%  perf-profile.calltrace.cycles-pp.ktime_get.tick_nohz_idle_exit.do_idle.cpu_startup_entry.start_secondary
>       0.65 ±  2%      +0.6        1.26 ±  9%  perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__schedule.schedule
>       0.00            +0.7        0.70 ± 10%  perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule_idle.do_idle.cpu_startup_entry
>       0.00            +0.7        0.71 ± 11%  perf-profile.calltrace.cycles-pp.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
>       1.25 ±  4%      +0.7        1.96 ± 10%  perf-profile.calltrace.cycles-pp.tick_nohz_idle_exit.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       0.00            +0.7        0.72 ±  8%  perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
>       0.00            +0.7        0.73 ± 10%  perf-profile.calltrace.cycles-pp.update_load_avg.set_next_entity.pick_next_task_fair.__schedule.schedule_idle
>       0.08 ±223%      +0.7        0.82 ± 10%  perf-profile.calltrace.cycles-pp.read_tsc.ktime_get.tick_nohz_idle_exit.do_idle.cpu_startup_entry
>       0.08 ±223%      +0.8        0.85 ± 12%  perf-profile.calltrace.cycles-pp.update_load_avg.dequeue_entity.dequeue_task_fair.__schedule.schedule
>       0.00            +0.8        0.81 ± 13%  perf-profile.calltrace.cycles-pp.switch_fpu_return.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       1.87            +0.9        2.73 ± 10%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__libc_read
>       0.00            +0.9        0.86 ± 13%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
>       1.41 ±  2%      +0.9        2.28 ± 10%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
>       0.00            +0.9        0.88 ± 14%  perf-profile.calltrace.cycles-pp.__switch_to_asm.__libc_read
>       0.00            +0.9        0.91 ± 40%  perf-profile.calltrace.cycles-pp.tick_nohz_idle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       1.14 ±  2%      +0.9        2.06 ± 10%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule_idle.do_idle.cpu_startup_entry
>       3.38 ± 10%      +1.1        4.48 ± 10%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
>       1.41 ±  2%      +1.2        2.61 ± 10%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__libc_write
>       1.84 ±  2%      +1.3        3.11 ± 11%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write
>       1.68 ±  3%      +1.4        3.08 ±  9%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending
>       2.04 ±  2%      +1.4        3.44 ± 11%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write
>       1.71 ±  3%      +1.5        3.22 ± 10%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.pipe_read
>       2.10 ±  2%      +1.6        3.66 ± 11%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write.ksys_write
>       2.08 ±  2%      +1.7        3.74 ±  9%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending.flush_smp_call_function_queue
>       2.28 ±  2%      +1.7        3.99 ± 11%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
>       2.06 ±  3%      +1.8        3.85 ± 10%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.pipe_read.vfs_read
>       2.15 ±  2%      +1.8        3.94 ± 11%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
>       2.13 ±  2%      +1.8        3.94 ±  9%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.flush_smp_call_function_queue.do_idle
>       2.37 ±  2%      +2.0        4.42 ±  9%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.flush_smp_call_function_queue.do_idle.cpu_startup_entry
>       2.69 ±  2%      +2.3        4.95 ±  9%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
>       3.34 ±  2%      +2.4        5.76 ± 10%  perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       3.18            +2.4        5.62 ±  9%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       0.00            +2.5        2.52 ± 71%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_read.vfs_read.ksys_read
>       0.17 ±141%      +2.9        3.07 ± 57%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.pipe_read.vfs_read.ksys_read.do_syscall_64
>       3.79 ±  2%      +3.2        6.98 ± 10%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
>       4.21 ±  2%      +3.5        7.66 ± 10%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
>       5.89            +4.4       10.34 ± 10%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
>       6.76            +5.1       11.84 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_write
>       9.19 ±  2%      +7.1       16.29 ± 10%  perf-profile.calltrace.cycles-pp.__libc_write
>      57.78           -24.9       32.90 ± 10%  perf-profile.children.cycles-pp.__schedule
>      43.69           -15.8       27.89 ± 13%  perf-profile.children.cycles-pp.schedule
>      45.66           -11.0       34.66 ± 14%  perf-profile.children.cycles-pp.pipe_read
>       9.45            -9.1        0.32 ± 59%  perf-profile.children.cycles-pp.mm_cid_get
>      14.25            -8.9        5.40 ± 10%  perf-profile.children.cycles-pp.schedule_idle
>       7.80 ±  3%      -6.6        1.24 ±  6%  perf-profile.children.cycles-pp.__switch_to
>      14.18            -4.8        9.40 ± 13%  perf-profile.children.cycles-pp.finish_task_switch
>      35.24            -4.1       31.18 ±  7%  perf-profile.children.cycles-pp.do_idle
>      35.28            -4.0       31.28 ±  7%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
>      35.28            -4.0       31.28 ±  7%  perf-profile.children.cycles-pp.cpu_startup_entry
>      34.92            -4.0       30.97 ±  7%  perf-profile.children.cycles-pp.start_secondary
>       8.92 ±  8%      -2.4        6.49 ±  9%  perf-profile.children.cycles-pp.cpuidle_enter_state
>       8.95 ±  8%      -2.4        6.58 ±  9%  perf-profile.children.cycles-pp.cpuidle_enter
>       6.65 ±  6%      -1.4        5.28 ±  9%  perf-profile.children.cycles-pp.poll_idle
>       0.99 ± 16%      -0.8        0.19 ± 14%  perf-profile.children.cycles-pp.nohz_run_idle_balance
>       0.87 ± 49%      -0.4        0.48 ± 10%  perf-profile.children.cycles-pp.get_next_timer_interrupt
>       1.30 ± 31%      -0.3        0.99 ± 10%  perf-profile.children.cycles-pp.tick_nohz_next_event
>       0.45            -0.0        0.40 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
>       0.14 ±  6%      -0.0        0.09 ± 14%  perf-profile.children.cycles-pp.call_function_single_prep_ipi
>       0.40            -0.0        0.36 ±  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
>       0.30 ±  3%      -0.0        0.26 ±  4%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
>       0.29 ±  2%      -0.0        0.26 ±  5%  perf-profile.children.cycles-pp.hrtimer_interrupt
>       0.24 ±  4%      -0.0        0.20 ±  6%  perf-profile.children.cycles-pp.__hrtimer_run_queues
>       0.11            -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.scheduler_tick
>       0.15 ±  2%      -0.0        0.12 ±  7%  perf-profile.children.cycles-pp.tick_sched_handle
>       0.15 ±  2%      -0.0        0.12 ±  7%  perf-profile.children.cycles-pp.update_process_times
>       0.06 ±  6%      +0.0        0.09 ± 11%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
>       0.09 ±  7%      +0.0        0.13 ±  7%  perf-profile.children.cycles-pp.perf_trace_buf_update
>       0.06 ±  6%      +0.0        0.10 ± 10%  perf-profile.children.cycles-pp.__list_add_valid
>       0.07 ± 26%      +0.0        0.12 ±  9%  perf-profile.children.cycles-pp.ct_kernel_exit
>       0.13 ± 12%      +0.1        0.18 ± 11%  perf-profile.children.cycles-pp.irq_work_needs_cpu
>       0.07 ±  6%      +0.1        0.13 ± 10%  perf-profile.children.cycles-pp.__x64_sys_write
>       0.08 ±  5%      +0.1        0.14 ± 10%  perf-profile.children.cycles-pp.update_min_vruntime
>       0.07 ± 10%      +0.1        0.12 ± 15%  perf-profile.children.cycles-pp.rcu_note_context_switch
>       0.06 ± 11%      +0.1        0.12 ± 12%  perf-profile.children.cycles-pp.__cgroup_account_cputime
>       0.04 ± 44%      +0.1        0.10 ± 10%  perf-profile.children.cycles-pp.child
>       0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.sched_clock
>       0.00            +0.1        0.06 ± 15%  perf-profile.children.cycles-pp.read@plt
>       0.06            +0.1        0.12 ± 25%  perf-profile.children.cycles-pp.local_touch_nmi
>       0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.__msecs_to_jiffies
>       0.08 ±  8%      +0.1        0.14 ± 11%  perf-profile.children.cycles-pp.check_spread
>       0.03 ± 70%      +0.1        0.10 ± 12%  perf-profile.children.cycles-pp.pm_qos_read_value
>       0.08 ±  6%      +0.1        0.14 ± 10%  perf-profile.children.cycles-pp.put_prev_task_idle
>       0.00            +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.perf_swevent_get_recursion_context
>       0.00            +0.1        0.07 ± 16%  perf-profile.children.cycles-pp.timer_clear_idle
>       0.00            +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.save_fpregs_to_fpstate
>       0.06 ±  7%      +0.1        0.13 ± 11%  perf-profile.children.cycles-pp.perf_trace_buf_alloc
>       0.07            +0.1        0.14 ± 10%  perf-profile.children.cycles-pp.__x64_sys_read
>       0.01 ±223%      +0.1        0.08 ± 23%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
>       0.10 ±  8%      +0.1        0.17 ±  9%  perf-profile.children.cycles-pp.rb_next
>       0.07 ± 11%      +0.1        0.14 ± 11%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
>       0.00            +0.1        0.08 ± 16%  perf-profile.children.cycles-pp.sched_idle_set_state
>       0.10 ±  3%      +0.1        0.18 ± 15%  perf-profile.children.cycles-pp.wake_affine
>       0.00            +0.1        0.08 ± 12%  perf-profile.children.cycles-pp.aa_file_perm
>       0.14 ±  5%      +0.1        0.23 ± 10%  perf-profile.children.cycles-pp.update_rq_clock_task
>       0.07            +0.1        0.15 ±  9%  perf-profile.children.cycles-pp.__get_task_ioprio
>       0.10 ±  3%      +0.1        0.19 ± 12%  perf-profile.children.cycles-pp.rep_movs_alternative
>       0.10 ±  9%      +0.1        0.18 ± 11%  perf-profile.children.cycles-pp.nr_iowait_cpu
>       0.09 ± 10%      +0.1        0.17 ± 16%  perf-profile.children.cycles-pp.perf_trace_sched_switch
>       0.08 ±  5%      +0.1        0.17 ± 12%  perf-profile.children.cycles-pp.testcase
>       0.06 ±  7%      +0.1        0.15 ± 12%  perf-profile.children.cycles-pp.cpuidle_reflect
>       0.12 ±  3%      +0.1        0.22 ± 12%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
>       0.08 ±  5%      +0.1        0.18 ± 11%  perf-profile.children.cycles-pp.llist_add_batch
>       0.10 ±  5%      +0.1        0.20 ± 10%  perf-profile.children.cycles-pp.copyin
>       0.07 ±  5%      +0.1        0.17 ± 11%  perf-profile.children.cycles-pp.__pthread_enable_asynccancel
>       0.00            +0.1        0.10 ± 19%  perf-profile.children.cycles-pp.resched_curr
>       0.09 ±  5%      +0.1        0.19 ± 11%  perf-profile.children.cycles-pp.cpuidle_not_available
>       0.08 ±  5%      +0.1        0.20 ±  7%  perf-profile.children.cycles-pp.__rdgsbase_inactive
>       0.10 ±  5%      +0.1        0.21 ±  8%  perf-profile.children.cycles-pp.anon_pipe_buf_release
>       0.13 ±  2%      +0.1        0.24 ± 13%  perf-profile.children.cycles-pp.__calc_delta
>       0.08 ±  6%      +0.1        0.19 ± 13%  perf-profile.children.cycles-pp.fsnotify_perm
>       0.25 ±  4%      +0.1        0.37 ±  9%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
>       0.19 ±  4%      +0.1        0.31 ± 11%  perf-profile.children.cycles-pp.file_update_time
>       0.15 ±  4%      +0.1        0.26 ± 10%  perf-profile.children.cycles-pp.available_idle_cpu
>       0.12 ±  4%      +0.1        0.24 ± 12%  perf-profile.children.cycles-pp.put_prev_entity
>       0.14 ±  4%      +0.1        0.26 ± 10%  perf-profile.children.cycles-pp.pick_next_entity
>       0.08 ± 12%      +0.1        0.21 ± 14%  perf-profile.children.cycles-pp.cpuacct_charge
>       0.14 ±  3%      +0.1        0.28 ±  9%  perf-profile.children.cycles-pp.__pthread_disable_asynccancel
>       0.13 ±  2%      +0.1        0.27 ± 10%  perf-profile.children.cycles-pp.copyout
>       0.07 ±  5%      +0.1        0.22 ± 14%  perf-profile.children.cycles-pp.tick_nohz_idle_retain_tick
>       0.16 ±  4%      +0.1        0.31 ± 11%  perf-profile.children.cycles-pp._copy_from_iter
>       0.17 ±  2%      +0.2        0.32 ± 12%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
>       0.26            +0.2        0.42 ±  8%  perf-profile.children.cycles-pp.newidle_balance
>       0.19 ±  2%      +0.2        0.34 ± 12%  perf-profile.children.cycles-pp.__cond_resched
>       0.13 ± 12%      +0.2        0.29 ± 14%  perf-profile.children.cycles-pp.current_time
>       0.28 ±  3%      +0.2        0.44 ±  9%  perf-profile.children.cycles-pp.perf_tp_event
>       0.21 ±  5%      +0.2        0.37 ± 12%  perf-profile.children.cycles-pp.__update_idle_core
>       0.16 ±  3%      +0.2        0.32 ± 11%  perf-profile.children.cycles-pp.place_entity
>       0.26            +0.2        0.42 ± 10%  perf-profile.children.cycles-pp.update_rq_clock
>       0.24 ±  4%      +0.2        0.41 ± 16%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
>       0.20 ±  2%      +0.2        0.38 ± 11%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
>       0.23 ±  5%      +0.2        0.41 ± 10%  perf-profile.children.cycles-pp.select_idle_sibling
>       0.43 ±  4%      +0.2        0.61 ± 11%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
>       0.17 ±  2%      +0.2        0.35 ±  9%  perf-profile.children.cycles-pp._copy_to_iter
>       0.26 ±  4%      +0.2        0.44 ± 12%  perf-profile.children.cycles-pp.pick_next_task_idle
>       0.28 ±  8%      +0.2        0.46 ± 10%  perf-profile.children.cycles-pp.local_clock
>       0.20 ±  4%      +0.2        0.38 ± 10%  perf-profile.children.cycles-pp.copy_page_from_iter
>       0.10 ±  4%      +0.2        0.30 ±  6%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
>       0.10 ±  3%      +0.2        0.29 ± 10%  perf-profile.children.cycles-pp.finish_wait
>       0.27 ±  7%      +0.2        0.47 ± 15%  perf-profile.children.cycles-pp.call_cpuidle
>       0.20 ±  2%      +0.2        0.41 ±  9%  perf-profile.children.cycles-pp.copy_page_to_iter
>       0.23 ±  2%      +0.2        0.44 ± 11%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
>       0.15 ±  4%      +0.2        0.36 ± 10%  perf-profile.children.cycles-pp.check_preempt_curr
>       0.09 ±  4%      +0.2        0.30 ±  5%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
>       0.10 ±  4%      +0.2        0.32 ±  5%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
>       0.16 ±  3%      +0.2        0.39 ± 11%  perf-profile.children.cycles-pp.__wrgsbase_inactive
>       0.11            +0.2        0.35 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock_irq
>       0.00            +0.2        0.24 ± 11%  perf-profile.children.cycles-pp.tick_nohz_idle_got_tick
>       0.17 ±  2%      +0.2        0.42 ± 14%  perf-profile.children.cycles-pp.fput
>       0.21 ±  5%      +0.3        0.47 ± 11%  perf-profile.children.cycles-pp.put_prev_task_fair
>       0.19            +0.3        0.47 ± 10%  perf-profile.children.cycles-pp.atime_needs_update
>       0.31 ±  2%      +0.3        0.60 ± 12%  perf-profile.children.cycles-pp.reweight_entity
>       0.40 ±  4%      +0.3        0.70 ±  8%  perf-profile.children.cycles-pp.update_cfs_group
>       0.36 ±  2%      +0.3        0.66 ± 11%  perf-profile.children.cycles-pp.mutex_lock
>       0.36 ±  2%      +0.3        0.66 ± 11%  perf-profile.children.cycles-pp.__update_load_avg_se
>       0.42 ±  3%      +0.3        0.72 ± 10%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
>       0.06 ± 13%      +0.3        0.39 ± 11%  perf-profile.children.cycles-pp.cpuidle_get_cpu_driver
>       0.08 ±  6%      +0.3        0.41 ± 14%  perf-profile.children.cycles-pp.rcu_nocb_flush_deferred_wakeup
>       0.38 ±  2%      +0.3        0.73 ± 10%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
>       0.44 ±  3%      +0.4        0.80 ± 11%  perf-profile.children.cycles-pp.__fget_light
>       0.20 ±  3%      +0.4        0.56 ±  6%  perf-profile.children.cycles-pp.os_xsave
>       0.26 ±  2%      +0.4        0.62 ± 11%  perf-profile.children.cycles-pp.touch_atime
>       0.48 ±  3%      +0.4        0.85 ± 11%  perf-profile.children.cycles-pp.__fdget_pos
>       0.42 ±  3%      +0.4        0.81 ± 11%  perf-profile.children.cycles-pp.___perf_sw_event
>       0.32 ±  2%      +0.4        0.75 ± 11%  perf-profile.children.cycles-pp.apparmor_file_permission
>       0.12 ±  6%      +0.4        0.55 ± 18%  perf-profile.children.cycles-pp.tick_check_broadcast_expired
>       0.20 ±  5%      +0.4        0.64 ± 10%  perf-profile.children.cycles-pp.mutex_unlock
>       0.36 ±  3%      +0.5        0.84 ± 24%  perf-profile.children.cycles-pp.sched_clock_cpu
>       0.36 ±  3%      +0.5        0.86 ± 11%  perf-profile.children.cycles-pp.security_file_permission
>       0.52 ±  3%      +0.5        1.03 ±  8%  perf-profile.children.cycles-pp.native_sched_clock
>       0.55 ±  2%      +0.5        1.06 ± 10%  perf-profile.children.cycles-pp.select_task_rq_fair
>       0.61 ±  4%      +0.5        1.14 ±  3%  perf-profile.children.cycles-pp.read_tsc
>       0.12 ±  5%      +0.5        0.66 ± 10%  perf-profile.children.cycles-pp.menu_reflect
>       0.67 ±  2%      +0.6        1.23 ± 11%  perf-profile.children.cycles-pp.select_task_rq
>       0.35 ±  6%      +0.6        0.96 ± 41%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
>       0.62 ±  3%      +0.6        1.24 ± 12%  perf-profile.children.cycles-pp.prepare_task_switch
>       0.82 ±  2%      +0.6        1.45 ± 10%  perf-profile.children.cycles-pp.set_next_entity
>       0.75 ±  3%      +0.7        1.42 ± 10%  perf-profile.children.cycles-pp.update_curr
>       0.14 ±  2%      +0.7        0.81 ± 13%  perf-profile.children.cycles-pp.switch_fpu_return
>       0.25 ±  2%      +0.7        0.96 ± 12%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>       1.28 ±  4%      +0.7        2.01 ± 10%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
>       1.02 ±  5%      +0.8        1.86 ±  4%  perf-profile.children.cycles-pp.ktime_get
>       0.57 ±  3%      +0.9        1.50 ± 13%  perf-profile.children.cycles-pp.__switch_to_asm
>       1.26 ±  2%      +1.1        2.38 ± 10%  perf-profile.children.cycles-pp.__entry_text_start
>       1.35 ±  2%      +1.1        2.47 ± 10%  perf-profile.children.cycles-pp.update_load_avg
>       3.42 ± 10%      +1.1        4.57 ± 10%  perf-profile.children.cycles-pp.menu_select
>       1.59 ±  2%      +1.2        2.78 ± 10%  perf-profile.children.cycles-pp.pick_next_task_fair
>       1.87 ±  2%      +1.3        3.17 ± 11%  perf-profile.children.cycles-pp.try_to_wake_up
>       2.05 ±  2%      +1.4        3.46 ± 11%  perf-profile.children.cycles-pp.autoremove_wake_function
>       1.78 ±  2%      +1.5        3.25 ±  9%  perf-profile.children.cycles-pp.enqueue_entity
>       2.11 ±  2%      +1.6        3.67 ± 11%  perf-profile.children.cycles-pp.__wake_up_common
>       1.77 ±  3%      +1.6        3.35 ± 10%  perf-profile.children.cycles-pp.dequeue_entity
>       2.18 ±  2%      +1.7        3.87 ± 10%  perf-profile.children.cycles-pp.enqueue_task_fair
>       2.30 ±  2%      +1.7        4.03 ± 11%  perf-profile.children.cycles-pp.__wake_up_common_lock
>       2.06 ±  3%      +1.8        3.86 ± 10%  perf-profile.children.cycles-pp.dequeue_task_fair
>       2.23 ±  2%      +1.8        4.07 ± 10%  perf-profile.children.cycles-pp.activate_task
>       3.31 ±  2%      +2.1        5.38 ± 10%  perf-profile.children.cycles-pp.syscall_return_via_sysret
>       2.49            +2.1        4.59 ±  9%  perf-profile.children.cycles-pp.ttwu_do_activate
>       2.73 ±  2%      +2.3        5.03 ±  9%  perf-profile.children.cycles-pp.sched_ttwu_pending
>       3.35 ±  2%      +2.4        5.79 ± 10%  perf-profile.children.cycles-pp.pipe_write
>       3.21            +2.5        5.68 ±  9%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
>       0.82 ±  5%      +2.5        3.34 ± 51%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>       0.48 ±  6%      +2.6        3.09 ± 56%  perf-profile.children.cycles-pp.prepare_to_wait_event
>       3.58            +2.7        6.26 ±  4%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>       3.80 ±  2%      +3.2        7.00 ± 10%  perf-profile.children.cycles-pp.vfs_write
>       4.24 ±  2%      +3.5        7.70 ± 10%  perf-profile.children.cycles-pp.ksys_write
>       9.30 ±  2%      +7.2       16.49 ± 10%  perf-profile.children.cycles-pp.__libc_write
>       9.45            -9.1        0.32 ± 60%  perf-profile.self.cycles-pp.mm_cid_get
>      21.15 ±  2%      -8.5       12.66 ± 24%  perf-profile.self.cycles-pp.__schedule
>       7.79 ±  3%      -6.7        1.14 ±  6%  perf-profile.self.cycles-pp.__switch_to
>      13.93            -4.7        9.24 ± 13%  perf-profile.self.cycles-pp.finish_task_switch
>       6.51 ±  6%      -1.5        5.04 ±  9%  perf-profile.self.cycles-pp.poll_idle
>       0.98 ± 16%      -0.8        0.18 ± 13%  perf-profile.self.cycles-pp.nohz_run_idle_balance
>       0.67 ± 59%      -0.3        0.40 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock
>       0.13 ±  8%      -0.0        0.09 ± 12%  perf-profile.self.cycles-pp.call_function_single_prep_ipi
>       0.08 ±  6%      -0.0        0.05 ± 44%  perf-profile.self.cycles-pp.clear_buddies
>       0.11 ±  6%      -0.0        0.09 ±  8%  perf-profile.self.cycles-pp.tick_nohz_stop_idle
>       0.04 ± 45%      +0.0        0.08 ± 10%  perf-profile.self.cycles-pp.pick_next_task_idle
>       0.04 ± 44%      +0.0        0.08 ± 12%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
>       0.07 ±  6%      +0.0        0.11 ±  9%  perf-profile.self.cycles-pp.update_min_vruntime
>       0.05            +0.0        0.09 ± 11%  perf-profile.self.cycles-pp.__list_add_valid
>       0.06 ±  7%      +0.0        0.11 ± 12%  perf-profile.self.cycles-pp.check_spread
>       0.10 ±  5%      +0.0        0.14 ± 11%  perf-profile.self.cycles-pp.ksys_write
>       0.12 ±  3%      +0.0        0.17 ± 10%  perf-profile.self.cycles-pp.select_task_rq
>       0.06 ±  9%      +0.0        0.10 ± 17%  perf-profile.self.cycles-pp.__cgroup_account_cputime
>       0.08 ±  6%      +0.1        0.13 ±  9%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
>       0.06 ±  6%      +0.1        0.11 ± 26%  perf-profile.self.cycles-pp.local_touch_nmi
>       0.02 ±141%      +0.1        0.07 ± 13%  perf-profile.self.cycles-pp.local_clock
>       0.07 ±  7%      +0.1        0.12 ± 11%  perf-profile.self.cycles-pp.file_update_time
>       0.06 ± 11%      +0.1        0.12 ± 14%  perf-profile.self.cycles-pp.wake_affine
>       0.07 ± 10%      +0.1        0.12 ± 12%  perf-profile.self.cycles-pp.__x64_sys_write
>       0.06 ±  6%      +0.1        0.12 ± 11%  perf-profile.self.cycles-pp._copy_from_iter
>       0.04 ± 44%      +0.1        0.10 ± 10%  perf-profile.self.cycles-pp.child
>       0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.save_fpregs_to_fpstate
>       0.06 ±  6%      +0.1        0.12 ± 12%  perf-profile.self.cycles-pp.rcu_note_context_switch
>       0.00            +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.__msecs_to_jiffies
>       0.07 ±  7%      +0.1        0.13 ± 14%  perf-profile.self.cycles-pp.rep_movs_alternative
>       0.13 ±  5%      +0.1        0.19 ± 10%  perf-profile.self.cycles-pp.ttwu_do_activate
>       0.16 ±  4%      +0.1        0.23 ± 10%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
>       0.07            +0.1        0.13 ± 11%  perf-profile.self.cycles-pp.__x64_sys_read
>       0.03 ± 70%      +0.1        0.10 ± 16%  perf-profile.self.cycles-pp.pm_qos_read_value
>       0.07 ±  6%      +0.1        0.14 ± 13%  perf-profile.self.cycles-pp.put_prev_task_idle
>       0.01 ±223%      +0.1        0.07 ±  9%  perf-profile.self.cycles-pp.hrtimer_get_next_event
>       0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.perf_trace_buf_alloc
>       0.10 ±  4%      +0.1        0.17 ± 10%  perf-profile.self.cycles-pp.sched_ttwu_pending
>       0.06 ±  9%      +0.1        0.12 ±  8%  perf-profile.self.cycles-pp.cpu_startup_entry
>       0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.perf_swevent_get_recursion_context
>       0.09 ±  7%      +0.1        0.16 ±  9%  perf-profile.self.cycles-pp.rb_next
>       0.00            +0.1        0.07 ± 14%  perf-profile.self.cycles-pp.sched_idle_set_state
>       0.00            +0.1        0.07 ± 13%  perf-profile.self.cycles-pp.aa_file_perm
>       0.06 ± 11%      +0.1        0.13 ± 16%  perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
>       0.07 ±  9%      +0.1        0.14 ± 11%  perf-profile.self.cycles-pp.copyin
>       0.01 ±223%      +0.1        0.08 ± 12%  perf-profile.self.cycles-pp._copy_to_iter
>       0.00            +0.1        0.07 ±  9%  perf-profile.self.cycles-pp.copy_page_from_iter
>       0.06 ±  7%      +0.1        0.14 ± 11%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
>       0.09 ±  4%      +0.1        0.16 ± 13%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
>       0.00            +0.1        0.08 ± 14%  perf-profile.self.cycles-pp.cpuidle_enter
>       0.10 ± 10%      +0.1        0.17 ± 12%  perf-profile.self.cycles-pp.nr_iowait_cpu
>       0.05            +0.1        0.13 ± 34%  perf-profile.self.cycles-pp.sched_clock_cpu
>       0.10 ±  8%      +0.1        0.17 ±  9%  perf-profile.self.cycles-pp.tick_nohz_get_sleep_length
>       0.07 ±  5%      +0.1        0.15 ± 11%  perf-profile.self.cycles-pp.put_prev_entity
>       0.07 ±  5%      +0.1        0.15 ±  8%  perf-profile.self.cycles-pp.__get_task_ioprio
>       0.18 ±  6%      +0.1        0.26 ± 11%  perf-profile.self.cycles-pp.do_syscall_64
>       0.08 ±  4%      +0.1        0.16 ± 10%  perf-profile.self.cycles-pp.testcase
>       0.06 ±  7%      +0.1        0.15 ± 15%  perf-profile.self.cycles-pp.cpuidle_governor_latency_req
>       0.13 ±  5%      +0.1        0.22 ±  9%  perf-profile.self.cycles-pp.update_rq_clock_task
>       0.08 ± 11%      +0.1        0.17 ± 17%  perf-profile.self.cycles-pp.perf_trace_sched_switch
>       0.12 ±  4%      +0.1        0.21 ± 10%  perf-profile.self.cycles-pp.select_idle_sibling
>       0.03 ± 70%      +0.1        0.12 ± 29%  perf-profile.self.cycles-pp.tick_nohz_idle_enter
>       0.06 ±  6%      +0.1        0.14 ± 11%  perf-profile.self.cycles-pp.touch_atime
>       0.03 ± 70%      +0.1        0.12 ± 15%  perf-profile.self.cycles-pp.cpuidle_reflect
>       0.10 ±  5%      +0.1        0.19 ± 11%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
>       0.00            +0.1        0.09 ± 15%  perf-profile.self.cycles-pp.resched_curr
>       0.11 ±  6%      +0.1        0.20 ± 11%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
>       0.08 ±  5%      +0.1        0.18 ± 10%  perf-profile.self.cycles-pp.llist_add_batch
>       0.08 ±  4%      +0.1        0.18 ± 12%  perf-profile.self.cycles-pp.cpuidle_not_available
>       0.15 ±  6%      +0.1        0.25 ± 12%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
>       0.07 ±  7%      +0.1        0.17 ± 10%  perf-profile.self.cycles-pp.__pthread_enable_asynccancel
>       0.11 ±  3%      +0.1        0.21 ± 11%  perf-profile.self.cycles-pp.pick_next_entity
>       0.14 ±  8%      +0.1        0.24 ± 12%  perf-profile.self.cycles-pp.available_idle_cpu
>       0.09 ±  4%      +0.1        0.19 ± 10%  perf-profile.self.cycles-pp.__wake_up_common_lock
>       0.08 ±  5%      +0.1        0.19 ±  9%  perf-profile.self.cycles-pp.copyout
>       0.12 ±  3%      +0.1        0.23 ± 11%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
>       0.08 ±  5%      +0.1        0.19 ±  7%  perf-profile.self.cycles-pp.__rdgsbase_inactive
>       0.09 ±  7%      +0.1        0.20 ± 10%  perf-profile.self.cycles-pp.anon_pipe_buf_release
>       0.13 ±  2%      +0.1        0.24 ± 13%  perf-profile.self.cycles-pp.__calc_delta
>       0.09 ± 12%      +0.1        0.20 ± 11%  perf-profile.self.cycles-pp.current_time
>       0.13 ±  5%      +0.1        0.24 ± 14%  perf-profile.self.cycles-pp.__update_idle_core
>       0.08 ±  6%      +0.1        0.19 ± 13%  perf-profile.self.cycles-pp.fsnotify_perm
>       0.00            +0.1        0.11 ± 11%  perf-profile.self.cycles-pp.security_file_permission
>       0.19 ±  4%      +0.1        0.31 ±  9%  perf-profile.self.cycles-pp.perf_tp_event
>       0.14 ±  3%      +0.1        0.26 ± 12%  perf-profile.self.cycles-pp.__cond_resched
>       0.08 ± 12%      +0.1        0.20 ± 11%  perf-profile.self.cycles-pp.cpuacct_charge
>       0.10 ±  4%      +0.1        0.23 ± 11%  perf-profile.self.cycles-pp.ksys_read
>       0.10 ±  4%      +0.1        0.23 ± 12%  perf-profile.self.cycles-pp.autoremove_wake_function
>       0.12 ±  4%      +0.1        0.26 ±  9%  perf-profile.self.cycles-pp.__pthread_disable_asynccancel
>       0.29 ±  3%      +0.1        0.42 ± 10%  perf-profile.self.cycles-pp.tick_nohz_idle_exit
>       0.07            +0.1        0.20 ± 13%  perf-profile.self.cycles-pp.tick_nohz_idle_retain_tick
>       0.06 ±  6%      +0.1        0.20 ± 12%  perf-profile.self.cycles-pp.__wake_up_common
>       0.10 ±  6%      +0.1        0.24 ±  9%  perf-profile.self.cycles-pp.check_preempt_curr
>       0.18 ±  4%      +0.1        0.32 ±  9%  perf-profile.self.cycles-pp.try_to_wake_up
>       0.09 ±  7%      +0.1        0.23 ± 12%  perf-profile.self.cycles-pp.put_prev_task_fair
>       0.04 ± 44%      +0.1        0.19 ± 11%  perf-profile.self.cycles-pp.activate_task
>       0.16 ±  3%      +0.2        0.31 ± 10%  perf-profile.self.cycles-pp.place_entity
>       0.18 ±  4%      +0.2        0.33 ± 11%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
>       0.10 ±  7%      +0.2        0.26 ±  8%  perf-profile.self.cycles-pp.atime_needs_update
>       0.18 ±  4%      +0.2        0.34 ±  9%  perf-profile.self.cycles-pp.newidle_balance
>       0.09 ±  4%      +0.2        0.27 ±  6%  perf-profile.self.cycles-pp.tick_nohz_tick_stopped
>       0.25 ±  7%      +0.2        0.43 ± 16%  perf-profile.self.cycles-pp.call_cpuidle
>       0.08 ±  6%      +0.2        0.26 ±  6%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
>       0.33 ±  2%      +0.2        0.53 ± 11%  perf-profile.self.cycles-pp.vfs_read
>       0.27 ±  3%      +0.2        0.48 ± 11%  perf-profile.self.cycles-pp.set_next_entity
>       0.27 ±  5%      +0.2        0.48 ±  9%  perf-profile.self.cycles-pp.dequeue_task_fair
>       0.10 ±  6%      +0.2        0.31 ±  6%  perf-profile.self.cycles-pp.schedule_idle
>       0.24 ±  2%      +0.2        0.44 ± 10%  perf-profile.self.cycles-pp.__libc_write
>       0.22 ±  2%      +0.2        0.43 ± 11%  perf-profile.self.cycles-pp.cpuidle_enter_state
>       0.22 ±  3%      +0.2        0.43 ± 11%  perf-profile.self.cycles-pp.mutex_lock
>       0.20 ±  6%      +0.2        0.41 ± 13%  perf-profile.self.cycles-pp.prepare_task_switch
>       0.13 ±  3%      +0.2        0.35 ± 14%  perf-profile.self.cycles-pp.fput
>       0.00            +0.2        0.22 ± 11%  perf-profile.self.cycles-pp.tick_nohz_idle_got_tick
>       0.37 ±  3%      +0.2        0.60 ± 12%  perf-profile.self.cycles-pp.enqueue_task_fair
>       0.24 ±  4%      +0.2        0.47 ±  9%  perf-profile.self.cycles-pp.__libc_read
>       0.10 ±  4%      +0.2        0.33 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock_irq
>       0.30 ±  2%      +0.2        0.53 ± 11%  perf-profile.self.cycles-pp.pick_next_task_fair
>       0.16 ±  3%      +0.2        0.39 ± 10%  perf-profile.self.cycles-pp.__wrgsbase_inactive
>       0.21 ±  2%      +0.3        0.47 ± 11%  perf-profile.self.cycles-pp.prepare_to_wait_event
>       0.37 ±  9%      +0.3        0.63 ±  9%  perf-profile.self.cycles-pp.update_curr
>       0.22 ±  3%      +0.3        0.50 ±  9%  perf-profile.self.cycles-pp.select_task_rq_fair
>       0.39 ±  4%      +0.3        0.68 ±  7%  perf-profile.self.cycles-pp.update_cfs_group
>       0.34 ±  2%      +0.3        0.64 ± 11%  perf-profile.self.cycles-pp.__update_load_avg_se
>       0.29 ±  3%      +0.3        0.59 ± 11%  perf-profile.self.cycles-pp.reweight_entity
>       0.36 ±  2%      +0.3        0.68 ± 10%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
>       0.44 ±  9%      +0.3        0.77 ±  7%  perf-profile.self.cycles-pp.ktime_get
>       0.36 ±  3%      +0.3        0.68 ±  9%  perf-profile.self.cycles-pp.pipe_write
>       0.06 ± 13%      +0.3        0.39 ± 11%  perf-profile.self.cycles-pp.cpuidle_get_cpu_driver
>       0.10 ±  4%      +0.3        0.43 ± 10%  perf-profile.self.cycles-pp.menu_reflect
>       0.06            +0.3        0.40 ± 15%  perf-profile.self.cycles-pp.rcu_nocb_flush_deferred_wakeup
>       0.43 ±  3%      +0.3        0.77 ± 11%  perf-profile.self.cycles-pp.__fget_light
>       0.33 ±  3%      +0.4        0.68 ± 11%  perf-profile.self.cycles-pp.dequeue_entity
>       0.38 ±  2%      +0.4        0.74 ± 11%  perf-profile.self.cycles-pp.___perf_sw_event
>       0.41 ±  3%      +0.4        0.78 ± 12%  perf-profile.self.cycles-pp.pipe_read
>       0.20 ±  2%      +0.4        0.56 ±  6%  perf-profile.self.cycles-pp.os_xsave
>       0.28 ±  2%      +0.4        0.67 ± 11%  perf-profile.self.cycles-pp.apparmor_file_permission
>       0.12 ±  6%      +0.4        0.54 ± 18%  perf-profile.self.cycles-pp.tick_check_broadcast_expired
>       0.22 ±  4%      +0.4        0.66 ± 10%  perf-profile.self.cycles-pp.vfs_write
>       0.18 ±  5%      +0.4        0.63 ±  9%  perf-profile.self.cycles-pp.mutex_unlock
>       0.60 ±  5%      +0.5        1.06 ±  9%  perf-profile.self.cycles-pp.update_load_avg
>       0.52 ±  2%      +0.5        1.01 ±  8%  perf-profile.self.cycles-pp.native_sched_clock
>       0.57 ±  2%      +0.5        1.09 ±  2%  perf-profile.self.cycles-pp.read_tsc
>       0.62 ±  3%      +0.5        1.16 ±  9%  perf-profile.self.cycles-pp.enqueue_entity
>       0.12            +0.7        0.79 ± 13%  perf-profile.self.cycles-pp.switch_fpu_return
>       0.57 ±  3%      +0.9        1.49 ± 13%  perf-profile.self.cycles-pp.__switch_to_asm
>       0.48 ±  5%      +0.9        1.41 ± 11%  perf-profile.self.cycles-pp.cpuidle_idle_call
>       1.10 ±  2%      +0.9        2.04 ± 11%  perf-profile.self.cycles-pp.__entry_text_start
>       0.99 ±  2%      +1.0        1.96 ± 10%  perf-profile.self.cycles-pp.menu_select
>       1.86 ±  2%      +1.4        3.28 ± 10%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
>       3.28            +2.0        5.23 ±  6%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
>       3.31 ±  2%      +2.1        5.38 ± 10%  perf-profile.self.cycles-pp.syscall_return_via_sysret
>       0.80 ±  5%      +2.5        3.31 ± 52%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
> 
> 
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 
