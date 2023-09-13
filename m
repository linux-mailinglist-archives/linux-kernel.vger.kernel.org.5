Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A1D79E046
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 08:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbjIMG4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 02:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjIMG4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 02:56:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5997A1738
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 23:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694588198; x=1726124198;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=5Tf7fjvfl+SrWFT3j4X059l7y5Dc2BuU4zXYQSNH5K4=;
  b=H8REp+dgqCKJ4gBHCVxcc8xuNGyqq4m91DwNYUSiNae+xxfkgpR89+pT
   l8+qmgg+MlpZj15DNNMs1mj3KmfseRGs2CLtOPDdb02zI/qvWp8vflDFB
   9od8bSIFy+Wh7/IzLedymXZS9mRJz5ED78JlmLEkn3GNpK6Ktw3XcSjXZ
   0qaOguTZAunD0u0w/vM4nQke6eK67elPT8FQTx6z2sSkL/AD+3AZYU3Rt
   3eYr2wnhT/SC8gcmRxtJEh585xbcLSh5qrf6iAhq4hIb0WmoW257n3A7M
   X6jarOamUXsQhu61TvJdF8rEydfiOK/qnDBQICnCnYyJPnlnnHzNTRezb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="382390537"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="c'?scan'208";a="382390537"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 23:56:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="809564278"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="c'?scan'208";a="809564278"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 23:56:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 23:56:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 23:56:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 23:56:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0jk/qb7Whvr/SmPp7yV2e/7Pfc1Wyo7l4p/3oYYL00b5En2FeM4eh3+qNaeBq/atiKzUX6YjA2juLWsKVlcHhPeZtutv6tE7Qr+OZsoXbzhjC8UnbizyeaUV691iVKzUmCihvMlTIuSVjk/BecGkIshG9lkDxzkSfEBSejlowJcvkPiXQZs9MTY5w8OZ7xNTtpmieVGOInbGmu3DZuEEz9QswtDh0ba91c+dyxGiKcTZq4uSDuJVbvLAVI/IPlW98r+fVU44segfVuDDQlxwLh5Il/ANeBL1CfqnBIBK9G5nfixuIL4xhuxSF8R3vCK81xz2qnmbouz7xTuzERN1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDKYrs8KEGU7mJE410wBT++XlpQdGvQFzNFjNtjsyA4=;
 b=PbeaJhWEXFPwXk5Hhgs9rFfYKR4MBh/A9ALblM5ygCtv3pqX81T4elkzSZnLBEDrkGg5H7pKLJ5P/ntYCuUyoP0WPsuwZRxbGcy+6FTF0CC0TsqGLm0mGtkkwCK7D1zHBdKkeA1//llafsq3KaXfSfAPCw3Eg0dSwdsK7eYJmTz2h0wfTsb2Vv4En4RE7kQQaIp6JXr1FkYK+bacyOZEMGXlEaiMqVgjQaFmOeovcIAf12anJvNQRajVDvA4RBwQx4HO2k39rZVTzXddR/VMOh3iw8+wY37QRHHAe2rgYSymfgPHP1GrBtXq5Lk0s36YGZHVp9COUiEVU9CW9OnSQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SN7PR11MB6994.namprd11.prod.outlook.com (2603:10b6:806:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Wed, 13 Sep
 2023 06:56:34 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::488d:7cde:d174:b775]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::488d:7cde:d174:b775%6]) with mapi id 15.20.6745.030; Wed, 13 Sep 2023
 06:56:34 +0000
Date:   Wed, 13 Sep 2023 14:47:03 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Chuck Lever III <chuck.lever@oracle.com>, <willy@infradead.org>
CC:     "Sang, Oliver" <oliver.sang@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>
Subject: Re: [linus:master] [shmem]  a2e459555c:  aim9.disk_src.ops_per_sec
 -19.0% regression
Message-ID: <ZQFa5x1THIYuagWR@feng-clx>
References: <202309081306.3ecb3734-oliver.sang@intel.com>
 <C85F44FD-BC7D-421B-9585-C5FDFAEA9400@oracle.com>
 <ZP++GV9WURg1GhoY@xsang-OptiPlex-9020>
 <84984801-F885-4739-B4B3-DE8DE4ABE378@oracle.com>
 <ZQCAYpqu+5iD0rhh@feng-clx>
Content-Type: multipart/mixed; boundary="v89NNaz3wl2zv5tw"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZQCAYpqu+5iD0rhh@feng-clx>
X-ClientProxiedBy: SGXP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::17)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SN7PR11MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e33f7cc-9e66-4025-9515-08dbb4269118
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8fW9uvsw117qfWyL4MvON0ei6j3cH5HSf+PPHXnZI7ZyIVodMsVmjeTr96/dKq9x+9tbbPWco4NbgqloSXiL3STdhUnTGaeRS7K9w3yr4cvfjaLxuQAf8RAW+RbzeCP/NucydUDCLfAyIQopOYqsIcH/aFydPPp0M+XOaI8dWGqm4fjrly85KME3n+PpCZtsdH4B545RlupKmvtANb9wlLV9RKe+9poI3mAaVhTj8wWr/kfWQemQkmsMLBVEsjTB6ss6HgkWEaZPboWcqTg/njeiBj8UFS1+jhDJJs06NpX50gm3rCMtiewkvrsZByCJeFLrxC2DDt91Z/tc++LuzFWfQJcVwJxQaOxk/7sJYaMpJDv3n7Fll6WhI2zZWRRgVU3IcsT8gb3AR8Dpa78kbio69lVrwr9JgLz5xcKWCHRLVzIAm5pElLE0V+dx6IF2iv+xrKmA4KsY6ozFBaP59p9Tg+Guqg2BYAWYKfWHfxuWxIrVshCpauNi+AdFXiSKBwcPmSASS/MwGFyRApkyIXvsoRt++LKj8hVLLaaZBj/YWV4ApufWTWFQhJ2gyPz+aPtD54MmHUwZRmT/4BZ9mNm9DTDgS1ybpUwyG3WqGGo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(136003)(376002)(396003)(39860400002)(186009)(451199024)(1800799009)(2906002)(6486002)(33964004)(44144004)(6666004)(6506007)(478600001)(966005)(83380400001)(6512007)(8936002)(9686003)(26005)(33716001)(54906003)(66476007)(66946007)(44832011)(316002)(66556008)(41300700001)(235185007)(8676002)(4326008)(5660300002)(38100700002)(107886003)(86362001)(82960400001)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEFpalAxUW9VbkxEYmN3RFNXSEpKTGdmcFgya2VjcXJlWW5sMzRQZkdxclpK?=
 =?utf-8?B?Q2MrQnlIVityY2xNNjFQVlhZbGdiV1hzUi93dGxGOGFLa1NBK0NIL0lVTkpY?=
 =?utf-8?B?ZzcyRXZLQWN3RC9hTDUrTTdJTDM1Uk5YeGNiUWk5Z1BNVTJHWEg4WER0MERm?=
 =?utf-8?B?SUI1b0tRTjFsYjFUeUcvMHVnT081N0RXNUJxK2hUUkdkUTByL2JJbTlOZmI2?=
 =?utf-8?B?TlVhbzBYMW9EZFFDVmtSSUhhUHducWg3UFl2azB3V0pmNXRXTHc3Wlg3UU5E?=
 =?utf-8?B?V3VXMFhjZStjWmZBdWhka0daSzhFcWhTMlVTZ04zQjJGUkNUcnhDMVh0RkVV?=
 =?utf-8?B?SEgvVWpVQldjeWdtNXBYMmRIb0NDRytiK1dka3ZQRE9lUEQxTXdJc0R2cmVT?=
 =?utf-8?B?aGpyNEI3QjBaMG1KOVRVeHU2cnFLZzFLWFZ3ZTNYZmNxYzZrK0hBZTNhUXor?=
 =?utf-8?B?T1d5T3FvSmNsZWphZSt0VFBhYXRnRUhZUm8zWWRyZlZyNElFZGZLdzlzN1Vn?=
 =?utf-8?B?dmE5K1FpYTBydktRdlRjTnk4K0RiNDdKeGFPMXJxN08rSktHRWQydnNQdnRP?=
 =?utf-8?B?RU9NYlN3R0hNMXhmOUtXMUs5WncrUzZnV2hodnlTQkdtQU5vZ3l6VGdYdjUz?=
 =?utf-8?B?M21qcUVsTE80cXd6UXRJVk56RnUwWE54TUowN2grNmkvOWRsMFZWcnk3THlO?=
 =?utf-8?B?eHNyeTFnVEhWU0dhd2dqMTUvSkx4dEg3WjhOaVdaZW9KTHRLWmRCZUMyZ1g0?=
 =?utf-8?B?MEtYbnRqUGJjdnpDL0NNR09PSGFJVXlmRHpLVjc4K3ZERWdNOE5IMVdNKys2?=
 =?utf-8?B?SHQ5QkIwS2JKZUNiNy94QjgxSi80MElRT28zbENJVENIWUxpNy9sK0kxdzcx?=
 =?utf-8?B?UzNPWi9kZVgxSXM4eDZab0VJWkJSeWdMVTJzSnJNY1RzUnJiNjFVRjRNRmwy?=
 =?utf-8?B?M2ZSOGJ3ZVMwczFNcEFQNWE1NzhmWnorTEJ3eFNUUERHbG5JOE9YdzNQZ1NS?=
 =?utf-8?B?aGZXMG45NHB6N3FDd2N3MG5FbkVZUDd2aUF2TmdneWhIUmpYN1g0TVkzVmVo?=
 =?utf-8?B?ekNHK0RQZzYzdFk3OHBDVThIakNaWmlyOXVhZGtaekRSR0hTN3A1TUEwdnFJ?=
 =?utf-8?B?RldTZ1BwQ2xQWnI3Nzg0NEgxUkRwSmdMcktyZkZyTlpXd2ZhZUdSdnZ5d0dW?=
 =?utf-8?B?TUdMYjNoOEhzaHE1QzAyZ0NpMGV3MDF0eXhHYlJwSXpXd0prTVdzalM1c1R2?=
 =?utf-8?B?NlYzbVl1TzhRMXRwTWM3dW9tS3ZhMEFPVm5UMENPUjFob1FBZnNXSm5PQkI3?=
 =?utf-8?B?Y09sbDRUVytwL3NlZ3QyR0tPc25WcDJoc1lOSmNkQkF5UkxFcEkxL3BtdUQz?=
 =?utf-8?B?eGFGcTYyUFJuRDZUZlZld0JMZUJCanR4MUxMWEdJcVh4enQ0MUhyaHFwNkFy?=
 =?utf-8?B?OHNXT0NmS3dEbnA4SnJoVUc5NjlJOUtXQkJMU29FdzNZM1NIUURUaElJQUJS?=
 =?utf-8?B?MFRpY2Y1czcwMk1YVHdtK1dqcUxqbUNzL2FaZVJLT2ZGMGw5ZENoL3pvem9M?=
 =?utf-8?B?WkNFOHU0NG5JTEFGSmIzUzcxemVmYWZVUlQ4Y1JUTDdiODNNN0MrdjA5SDYz?=
 =?utf-8?B?M3RPQlJjZGt4b0JIRGxNcXFBNEhUT0lacHpVWXRpeVNWQVdJeE1XYlIvdlNn?=
 =?utf-8?B?MGZ0SWNqakRNSkFQUHVLYUhSUjhzWnNCRVBJRGMzQlhlY1lydmhReG8rRXYy?=
 =?utf-8?B?Ym4zRlRkUWRqYkVkenVoV21JQzNIMElHRW92eE5LWWpDU2VZVG1VUVBROXAv?=
 =?utf-8?B?dnNIanZXdE9EZkF0dlQ0RzkzQ0xibTNQR1g1YnhOdTh5UkxkOTRrMXcrZXYw?=
 =?utf-8?B?SHBqZzRjMVhLNmVERHFuZHFjd2g0K3ZraUZDejdUR2RHWEVSYjZZeXVlVmFw?=
 =?utf-8?B?SFQrdzQwSWQrdXF3NFQ1bERFRUJkMGFadGxEOXdDd1VaaDR3c0xwUElNUHhU?=
 =?utf-8?B?SDRhNDU3bkJqL1dVekNORWdhcVpjWlBCMFI5TzVUL2FzOW9zU2xXcUZCWVlE?=
 =?utf-8?B?YjltN2VBa1NvVEVUcWgra1o5VWx1bEN5Vmh2aGQ1VlVBOFFYbFhqNHFnT0ll?=
 =?utf-8?Q?jVekZxzW/hbyT95Q51T5VV5BQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e33f7cc-9e66-4025-9515-08dbb4269118
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 06:56:34.1740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHe+sBb2aLYl0gvSFUMk/g2yfgftgR4ohbryycFd4hix4kzQCoPK9nhv/Ggok8wQDZHaWCg9545E0TGxgfqKBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6994
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--v89NNaz3wl2zv5tw
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Sep 12, 2023 at 11:14:42PM +0800, Tang, Feng wrote:
[...]
> > 
> > Well that's the problem. Since I can't run the reproducer, there's
> > nothing I can do to troubleshoot the problem myself.
> 
> We dug more into the perf and other profiling data from 0Day server
> running this case, and it seems that the new simple_offset_add()
> called by shmem_mknod() brings extra cost related with slab,
> specifically the 'radix_tree_node', which cause the regression.
> 
> Here is some slabinfo diff for commit a2e459555c5f and its parent:
> 
> 	23a31d87645c6527 a2e459555c5f9da3e619b7e47a6 
> 	---------------- --------------------------- 
>  
>      26363           +40.2%      36956        slabinfo.radix_tree_node.active_objs
>     941.00           +40.4%       1321        slabinfo.radix_tree_node.active_slabs
>      26363           +40.3%      37001        slabinfo.radix_tree_node.num_objs
>     941.00           +40.4%       1321        slabinfo.radix_tree_node.num_slabs
> 
> Also the perf profile show some difference
> 
>       0.01 ±223%      +0.1        0.10 ± 28%  pp.self.shuffle_freelist
>       0.00            +0.1        0.11 ± 40%  pp.self.xas_create
>       0.00            +0.1        0.12 ± 27%  pp.self.xas_find_marked
>       0.00            +0.1        0.14 ± 18%  pp.self.xas_alloc
>       0.03 ±103%      +0.1        0.17 ± 29%  pp.self.xas_descend
>       0.00            +0.2        0.16 ± 23%  pp.self.xas_expand
>       0.10 ± 22%      +0.2        0.27 ± 16%  pp.self.rcu_segcblist_enqueue
>       0.92 ± 35%      +0.3        1.22 ± 11%  pp.self.kmem_cache_free
>       0.00            +0.4        0.36 ± 16%  pp.self.xas_store
>       0.32 ± 30%      +0.4        0.71 ± 12%  pp.self.__call_rcu_common
>       0.18 ± 27%      +0.5        0.65 ±  8%  pp.self.kmem_cache_alloc_lru
>       0.36 ± 79%      +0.6        0.96 ± 15%  pp.self.__slab_free
>       0.00            +0.8        0.80 ± 14%  pp.self.radix_tree_node_rcu_free
>       0.00            +1.0        1.01 ± 16%  pp.self.radix_tree_node_ctor
> 
> Some perf profile from a2e459555c5f is: 
> 
> -   17.09%     0.09%  singleuser       [kernel.kallsyms]            [k] path_openat   
>    - 16.99% path_openat                
>       - 12.23% open_last_lookups      
>          - 11.33% lookup_open.isra.0
>             - 9.05% shmem_mknod
>                - 5.11% simple_offset_add
>                   - 4.95% __xa_alloc_cyclic 
>                      - 4.88% __xa_alloc
>                         - 4.76% xas_store 
>                            - xas_create
>                               - 2.40% xas_expand.constprop.0
>                                  - 2.01% xas_alloc
>                                     - kmem_cache_alloc_lru
>                                        - 1.28% ___slab_alloc
>                                           - 1.22% allocate_slab 
>                                              - 1.19% shuffle_freelist 
>                                                 - 1.04% setup_object
>                                                      radix_tree_node_ctor
> 
> Please let me know if you need more info.
> 
> > 
> > Is there any hope in getting this reproducer to run on Fedora?
> 
> Myself haven't succeeded to reproduce it locally, will keep trying
> it tomorrow.

It can be reproduced on a local machien with CentOS 9 (similar to
Fedora ?), and some steps as:

* download source code
  $ wget https://sourceforge.net/projects/aimbench/files/aim-suite9/Initial%20release/s9110.tar.Z

* untar the file and run 'make'

* create 2 files 's9workfile' and 'test.config'

	$ cat s9workfile
	# @(#) s9workfile:1.2 1/22/96 00:00:00
	# AIM Independent Resource Benchmark - Suite IX Workfile
	FILESIZE: 5M
	disk_src

	$ cat test.config
	test
	disk_src
	200s
	/dev/shm/

* run the test with cmd "./singleuser -nl < test.config" 

The test case here is 'disk_src', so I picked one file 'disk_src.c'
and attached it for quick reference.

The kernel config of my CentOS is different from what 0Day used, so 
the perf-profile and peformance score are a little different, but
the regression trend is the same, that commit a2e459555c5f has about
20% drop.

Also the test platform doesn't matter, I tried on several generation 
of Xeon servers which can all reproduce it. 

Thanks,
Feng

--v89NNaz3wl2zv5tw
Content-Type: text/x-csrc; charset="us-ascii"
Content-Disposition: attachment; filename="disk_src.c"


/****************************************************************
**                                                             **
**    Copyright (c) 1996 - 2001 Caldera International, Inc.    **
**                    All Rights Reserved.                     **
**                                                             **
** This program is free software; you can redistribute it      **
** and/or modify it under the terms of the GNU General Public  **
** License as published by the Free Software Foundation;       **
** either version 2 of the License, or (at your option) any    **
** later version.                                              **
**                                                             **
** This program is distributed in the hope that it will be     **
** useful, but WITHOUT ANY WARRANTY; without even the implied  **
** warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR     **
** PURPOSE. See the GNU General Public License for more        **
** details.                                                    **
**                                                             **
** You should have received a copy of the GNU General Public   **
** License along with this program; if not, write to the Free  **
** Software Foundation, Inc., 59 Temple Place, Suite 330,      **
** Boston, MA  02111-1307  USA                                 **
**                                                             **
****************************************************************/
#define _POSIX_SOURCE 1			/* turn on POSIX funct'ns  */

#include <stdio.h>			/* enable printf(), etc. */
#include <unistd.h>			/* for chdir(), etc. */
#include <stdlib.h>			/* for malloc(), etc. */
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>			/* required for creat */
#include <signal.h>
#include "suite.h"			/* our goodies */

static int disk_src();

COUNT_START				/* declare counters */
	source_file * disk_src_c()
{
	static source_file s = { " @(#) disk_src.c:1.10 3/4/94 17:21:22",	/* SCCS info */
		__FILE__, __DATE__, __TIME__
	};

	register_test("disk_src", "DISKS", disk_src, 75, "Directory Searches");	/* 100 c and s files in fakeh/dirlist */
	return &s;
}

enum choices { STAT = 0, CREAT, MCHOICE };	/* encode choices here */

#define FAKEH "fakeh"
#define MFILES	75			/* number of entries */
#define MYBUF 160			/* MAX size of input line */
#define MSCR 5				/* number of scramble passes */

/*
 * dsearch exercises the directory search mechanism of unix systems.
 * it is called by the disk test program. dsearch assumes that it is 
 * invoked with its current directory is the parent directory
 * of the hand created directory that is distributed with the benchmark.
 * it assumes that in this directory is a file "dirlist" that provides a list
 * of file names under the current directory, along with a list of names to
 * search for.  some of these names are to be stat'ed while some are to be
 * creat'ed
 */

unsigned long mrand();
int get_list(FILE * file,
	     char *list[MCHOICE][MFILES]);
void scramble(char *list[],
	      int num);
void cl_list(char *list[MCHOICE][MFILES]);
void errdump(int line,
	     char *str);

int
dsearch(char *fakeh_dir)
{
	FILE *fp;			/* file containing filenames */

	int
	  fd,				/* file discriptor for creat, etc. */
	  index;			/* loop variable */

	struct stat stbuf;		/* stat buffer */

	char
	  cwd[256],			/* hold current working dir */
	  errbuf[80],			/* build error msgs in here */
	 *flist[MCHOICE][MFILES];	/* the list of target files */

	if (getcwd(cwd, 256) == NULL) {
		fprintf(stderr,
			"dsearch(): can't get current working directory\n");
		return (-1);
	}
	if (chdir(fakeh_dir) < 0) {	/* move to directory */
		perror("dsearch()");	/* if error, print it */
		errdump(__LINE__, "dsearch(): directory 'fakeh' is inaccessable\n");	/* and dump */
		return (-1);		/* return failure */
	}

	if ((fp = fopen("dirlist", "r")) == NULL) {	/* open list of filenames */
		errdump(__LINE__, "dsearch(): file 'dirlist' is inaccessable\n");	/* handle error */
		chdir(cwd);		/* move back up */
		return (-1);		/* return error */
	}
	/*
	 * end of error processing 
	 */
	if (get_list(fp, flist) < 0) {	/* load the list */
		errdump(__LINE__, "dsearch(): file 'dirlist' is corrupted\n");	/* handle errors */
		chdir(cwd);		/* go back up */
		cl_list(flist);		/* close list */
		return (-1);		/* return error */
	}
	fclose(fp);			/* close list of filenames */

	scramble(flist[STAT], MFILES);	/* scramble names */
	scramble(flist[CREAT], MFILES);	/* scramble names */

	for (index = 0; index < MFILES; index++) {	/* loop through files  */
		if (flist[STAT][index] != NULL) {	/* if not null */
			if (stat(flist[STAT][index], &stbuf) < 0) {	/* stat the file */
				perror("stat() in dsearch()");	/* handle errors */
				sprintf(errbuf, "dsearch(): can't stat '%s'\n",	/* create error message */
					flist[STAT][index]);
				errdump(__LINE__, errbuf);	/* print it */
				chdir(cwd);	/* return to proper dir */
				cl_list(flist);	/* clear list */
				return (-1);	/* return error */
			}		/* endo f error */
		}
		/*
		 * end of if not null 
		 */
		if (flist[CREAT][index] != NULL) {	/* if creating */
			if ((fd = creat(flist[CREAT][index], S_IRWXU | S_IRWXG | S_IRWXO)) < 0) {	/* try create */
				perror("creat() in dsearch()");	/* handle error */
				sprintf(errbuf, "dsearch():can't creat '%s'\n",	/* build error message */
					flist[CREAT][index]);
				errdump(__LINE__, errbuf);	/* print it */
				chdir(cwd);	/* change directories */
				cl_list(flist);	/* clear list */
				return (-1);	/* return error */
			}		/* end of error */
			close(fd);	/* close the file */
			if (unlink(flist[CREAT][index])) {	/* unlink it */
				perror("unlink() in dsearch()");	/* handle error */
				sprintf(errbuf, "dsearch():can't unlink '%s'\n",	/* build error message */
					flist[CREAT][index]);
				errdump(__LINE__, errbuf);	/* print it */
				chdir(cwd);	/* change directories */
				cl_list(flist);	/* clear list */
				return (-1);	/* return error */
			}		/* end of error */
		}
		/*
		 * end if creating 
		 */
		COUNT_BUMP;

	}				/* end of for */
	cl_list(flist);			/* clear list */
	chdir(cwd);			/* go back up */
	return (0);			/* return no error */
}

int
get_list(FILE * file,
	 char *list[MCHOICE][MFILES])
{
	char
	  buff[MYBUF],			/* holds 1 line of input */
	 *tmp;				/* holds malloc results */

	int
	  s_index, c_index, i;

	pid_t pid = getpid();		/* process ID, for unique file names */

	s_index = c_index = 0;		/* initialize indexes */

	for (i = 0; i < MFILES; i++)	/* initialize array */
		list[STAT][i] = list[CREAT][i] = NULL;	/* clear to empty */

	while (fgets(buff, MYBUF - 1, file) != NULL) {	/* get a line */
		if (buff[0] != 's' && buff[0] != 'c')	/* if it isn't legal, */
			continue;	/* ignore it */

		buff[strlen(buff) - 1] = '\0';	/* eliminate trailing new line */
		if ((tmp = malloc(strlen(buff) + 1 + 8)) == NULL) {	/* allocate space */
			cl_list(list);	/* handle bad allocate */
			return (-1);	/* return error */
		}
		/*
		 * end of malloc error chking 
		 */
		strcpy(tmp, buff + 2);	/* copy name into buffer */

		switch (buff[0]) {	/* decide on operation */
		case 's':		/* if stat */
			list[STAT][s_index++] = tmp;	/* put it into array */
			break;		/* and leave */

		case 'c':		/* if CREAT; Tin Le */
			sprintf(tmp, "%s%05d", (buff + 2), pid % 100000);	/* make unique name, last 4 digits of pid */
			list[CREAT][c_index++] = tmp;	/* save it off */
			break;		/* and leave */

		default:		/* this cannot be */
			errdump(__LINE__, "getlist(): Deadly error encountered\n");	/* print merror message */
			cl_list(list);	/* clear list */
			return (-1);	/* return error here */
		}			/* end of switch */
	}				/* end of loop */
	return (1);			/* return success */
}



void
scramble(char *list[],
	 int num)
{
	int
	  i,				/* loop variable */
	  scount,			/* scramble count */
	  rnum;				/* random index for scramble */

	char
	 *tmp;				/* intermediate location */

	for (scount = 0; scount < MSCR; scount++) {	/* for number of scrambles */
		for (i = 0; i < num; i++) {	/* go through list */
			rnum = mrand() % num;	/* get an index */
			tmp = list[i];	/* swap this one */
			list[i] = list[rnum];	/* with that one */
			list[rnum] = tmp;	/* and we're done */
		}			/* loop through each one */
	}				/* for each pass */
}


unsigned long
mrand()
{					/* return integer randome number */
	return ((unsigned long)aim_rand());	/* do it */
}

void
cl_list(char *list[MCHOICE][MFILES])
{
	int index;			/* loop variable */

	for (index = 0; index < MFILES; index++) {	/* loo through all entries */
		if (list[STAT][index] != NULL)	/* if string resides here */
			free(list[STAT][index]);	/* free it to heap */
		if (list[CREAT][index] != NULL)	/* if string here */
			free(list[CREAT][index]);	/* free it */
	}				/* end of loop */
}

void
errdump(int line,
	char *str)
{					/* print error message */
	fprintf(stderr,
		"Error in file %s (compiled at %s on %s) from line %d:\n\t%s",
		__FILE__, __TIME__, __DATE__, line, str);
}

static int
disk_src(char *argv,
	 Result * res)
{
	int i;
	char fakeh_dir[128];

	if (*argv)
		sprintf(fakeh_dir, "%s/%s", argv, FAKEH);
	else
		strcpy(fakeh_dir, FAKEH);

	i = dsearch(fakeh_dir);
	COUNT_END("disk_src");
	return (res->i = i);
}

--v89NNaz3wl2zv5tw--
