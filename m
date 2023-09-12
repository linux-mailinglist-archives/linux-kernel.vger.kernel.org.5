Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FAC79D4B8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbjILPYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbjILPYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:24:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725D9CF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694532266; x=1726068266;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=/ySpguvrNyTCOp7YxJe+On0WEgXReMAQc2KrbBWXkJg=;
  b=ekBUFbgvjozJ8frfK5hVegK/yQan3HZLWNQOQSitDI1EYfRGJ4pB52KH
   hjarL32zQUJ09avI4MmhitLXhH7TuqBQXQpkQnw8y5FCn64rLlFRUZl0Z
   z1FCSDCFrPl2cZFbF1bojoix4SC/9yhwOgk9DBeUCC7Z5VsHTc6UHJsC+
   vOky7p8e8+KLk66OT/5iZQPkzVB2/n3vg+RJ23AOMQwTjQEfUy8ydq71J
   ekfb/xPxrt9siM5yL9t7dsxDqVwlSo22l64NPUzsAIDSvTRJXrqbvQlBw
   E4CnidNcIwT7OdIM5gctuTDfKn0fjzK2KqkI9z7GcWHHU0kjxuvjS0LKF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="382216708"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="382216708"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 08:24:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="917457012"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="917457012"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 08:24:17 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 08:24:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 08:24:16 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 08:24:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KukxovPVWwV0mUaGxxPITdCSz7k2NrTNoyFne/LKIJpzNwXswGhhIZyuRLlGVNdNGhCQK2oTrmgcxJQWRPJVLDBOReM8DkGYb0euqKMrwERZU2htwOjOEqM3IEPJ5kOVbyKFcPPfHpUdCbMQLo7TYeq7PQF1+hz30iZkgbjNPorUWvCLU7mm0Ru1BxMinPxb9r3+mZvb5vWz+6110VXNNbHYxITFmuswCmT0VLld3hvEArqYqGHSxzBISKriS4SoriRpfvit0FsryYT58WEu4qsyHw1BWeavnWpsaFTS2KyXPu/Ezntg/mDXf9s/slAaWQQq+X7iNC1GnkVvrOOlkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDoTI8P8JFZ14niMQFLIDh4fgSM3mytMfl3eDH5sHUk=;
 b=kDinYqdXHqK1zGryrckKWYJ9wC6/bX5VCelWeNaLchOgpw48sORzEU8WzoT4dpRUCLqhadQokZzdVl1E+kCN/MkGkqExajRxebYnVr7T15rItj6lf/tvyBgQKGpQo/Bos6BJ0RIssnjj8L21KLfAJqK/pn5851pZwQIhiM8sS90bwUx7qjA7Mlin4/wgYMgr6mpHm6g3KR2qgYh2V7JBB+tofVlbZlju4aVLHDvxFg/+SeEHBX0IzcM3tum9knpdX12j/mE7w1dp0zi5RP5ql6HgwEgd3S41Gh8ZgO7AlmaVoKyg+sK/cUissqDqcWZsL/gYi9p6rt8MF5z54Eplkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by IA0PR11MB7956.namprd11.prod.outlook.com (2603:10b6:208:40b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 15:24:14 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::488d:7cde:d174:b775]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::488d:7cde:d174:b775%6]) with mapi id 15.20.6745.030; Tue, 12 Sep 2023
 15:24:14 +0000
Date:   Tue, 12 Sep 2023 23:14:42 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
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
Message-ID: <ZQCAYpqu+5iD0rhh@feng-clx>
References: <202309081306.3ecb3734-oliver.sang@intel.com>
 <C85F44FD-BC7D-421B-9585-C5FDFAEA9400@oracle.com>
 <ZP++GV9WURg1GhoY@xsang-OptiPlex-9020>
 <84984801-F885-4739-B4B3-DE8DE4ABE378@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84984801-F885-4739-B4B3-DE8DE4ABE378@oracle.com>
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|IA0PR11MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 09dc0b1c-bcaa-4f7c-f2e6-08dbb3a45246
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nr0d3TLi4WZaEDlmE9aVvY9+wLCrwgTAkVsAbtomkrv1XJjtiXk+2NVBnUV32UVvItEuNyJ8n/vZTUuHFMdk8OKZkvmp0+ErS0+6G+xjC0qfO9k5OyEs67SslT5LqPQo7PeqcxL6n5m+QUbFUnm2JMJNXIK5bet2v+4JlgixFrGyU6DP2VY7gxHBinmF9V02sdjdvECKcWuHWsi0FszBQ1JaN00UnuLYNA9A+e/7AEzOtPjmT/dQOmHfdF/d2g3kQXBX62ErYYLKt1I4VQrBr40RJUw9Go/KoKanZPl8WUqEabql5L15KO8BkdrhrwtSidS5DHUmCNb7iyx4f84NyWSZhZxTY3qiXYI09OxvB5qNC6xrS/XRpPyroJFOU0e2Lc4i9qLKRgWVk+xT9bbcEujvB58jRqNchHJkEtx9V2senc26fUdzQ5ctQSIpHsfhR0Q7Iu8hOYboQiWf/G/udPJE+/VoyqRhimZVBJyME+b1mQTirQded+H2SoyZDCJy3QDa9INHFmgHTrGxVRQ5laocVZTO7Qty8pzrSfU650vcUy9R6INq7wlR6P7PDTpo2sLZKZw1hmiBj+Wdmr7hy4VnrtFPFGxb9cisXA4X4r9nfBlnJvFHgv+6YZ54amqSe7LPdXLf4B7/nUl4eAXnfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199024)(186009)(1800799009)(6486002)(53546011)(6666004)(6506007)(82960400001)(86362001)(38100700002)(44832011)(9686003)(83380400001)(4326008)(107886003)(6512007)(26005)(966005)(478600001)(41300700001)(316002)(33716001)(2906002)(66946007)(66476007)(54906003)(6916009)(8936002)(66556008)(5660300002)(8676002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG5wQmVCWGkxSVBKMnRMSWRmWFV0RWJsNDlOQzEyTWlHSkc4czhZUDhWWFB0?=
 =?utf-8?B?akg5UHRWRUtNMWdnZ3pzUGxSSUxNSmdhZUxJMnlpZEcwTlpnaTRzbHg2azF0?=
 =?utf-8?B?aFhRTDR3eWJrRFBoc2tiRDE3K3pNTklpU2x4M0Iwb1Q0Unh2Vkw0ZlN6WHZ3?=
 =?utf-8?B?cEU1Snk0aDM0L0Z4ancwSUI3azU4R1FOU0piRDJxQzBoRWFJbHc5bUp1cGFP?=
 =?utf-8?B?am5PM2tsUVFaUURZbEkvTEcyNFpzL1R5MFRsQlpGQkpZV3hwbzlyTlc4VE0r?=
 =?utf-8?B?UVoxWXVmRFJ5UzcvSUhMSTQrZUJockdtN2h3YjdDNzNRVmcreThzZVhwYlh0?=
 =?utf-8?B?ZFhDL0lmN1l3Zk91UmJZeGlON3J6d1I4Z3g5cWRhNnFqV2drbHhFWVFMa1JO?=
 =?utf-8?B?NmJHRmdmaml6TWhEdW5VbnBhaEdkWG8yblhxaDdYRUFsby9CWkJhdjJSckJ3?=
 =?utf-8?B?TXBBV21EK3FwS1dWdE9CZE8xQVV0N1d1NjlSd2liRWRXdGxYNE1ZMHR2YVlq?=
 =?utf-8?B?blcwU0tXcUdsUkZJd0ZhR3lVRm1IR056WlpCYUhMeldTTXNUNWpoVnlMYVhS?=
 =?utf-8?B?Q3dtU2NuTmJCekFQR28ydWhDY2l4SVBra0JzVW81QVFRRS9SdUhPbnk2b1FC?=
 =?utf-8?B?anZtVnlWY0t5V0lnb3U0aVd1bWFDUkRNSGtlZjU2RTdEcUtZZ2JiUlJDYVJi?=
 =?utf-8?B?cG1jZk1iSGtVemY0N2x2Mm8vNlpMZnZGWXBCRjJyR3pKQzVXeUlubTh5ZVhm?=
 =?utf-8?B?aFY4L2krTmVZemdUK2huQUt3RDlvZ09vRmFkVjRMOTh0TXRCNlp1QVVvdS9T?=
 =?utf-8?B?aHA0T2R2ZkZINHprNHc4czd2YzRzTGtrTnBPTE56Y0VlZTZYbzBWMng1cUlR?=
 =?utf-8?B?TVI4cTViNnVZS1FpZDVnUUFDdkx0TGVmZFNXY3E1ZGJyVC9rbGZNK1E3SFcy?=
 =?utf-8?B?SHNSWjUwQ0NRQ0lUQk5OM2c3djNud0NWazJWSEJXYUlseWlYcEc1QTdoNlNn?=
 =?utf-8?B?Ry9iSWVaTGF4Skxjd093c2lqdS9MQnBFanV5NmZvYmpOUWRVTXJqSHdlbTJ5?=
 =?utf-8?B?bFh0L3BobXpjWlhhS01ZNG5xWnlLSHRBU3FUZVlPSE4wZExMU2ZFam1TZ1hT?=
 =?utf-8?B?V0lwUmxIeXhJZjRNaDQ2WjBpQUxQYzBveGlVRElNc0JGa1BoUVpWQVpYNUh2?=
 =?utf-8?B?dzhHWGZlemtGcWU1WEQxdTNhdzlvbFlHMUJhK2drM3BSdGY0a2E3c3dpZ2pZ?=
 =?utf-8?B?L3I5MVphbVpMUkluWXFCSlJMWXM1QzhtdUIvcHpjTlBrWExCTFFBR1IwdmdH?=
 =?utf-8?B?VldjdFZBTnl1aktac3A2Q0NQZGFPU1VQc2E0cWZqVXY4enpNRHUwVXA1M2tN?=
 =?utf-8?B?aTZqOHozSmxOMTEvVzNEVUEvYm14T1JpSXFEN3NaektyM0luU3JKdGZIVXYz?=
 =?utf-8?B?aFVMNnNmeWloTllsTmVXTTd4MWU1UW44Nis2NldPSGd2aUFPNzdaVkpBcUNZ?=
 =?utf-8?B?cjZYL1RiaUtRc1VSNkdTMmpQVU96UmcxejVnM3VDdWxkK2RPYkdETWhiQkd5?=
 =?utf-8?B?WmVobjM1dHljeHFxdW9URXpheXhicHZlNlpSc095bmtCcWtaaXdKTGFIbmZp?=
 =?utf-8?B?N1hNd1c2OW55NG11MkNSb0VsY2VMMUVlYUxLRjBHMytKemY2UlhvT3pGYzNV?=
 =?utf-8?B?L2xjRThKTDhYNnAyZk4vbHlOOVZUTWo4eE0xVksvck5EMnN0WC9ZNGhxelU0?=
 =?utf-8?B?N3hKVzN2a0NLWTlCc2lyUE9Rb1JpelZhUHhydlVUYmxpeHdUNDFqSk5uT3Zt?=
 =?utf-8?B?UzdhQ2c4L1JVV2NHK3hQQnNoNWhHbitrZ2NnNURNRUFIK1JDQWtTbjJsTzZy?=
 =?utf-8?B?azA4dGRldzZmL0YwbEsvUCtFWElFbnE1MmVHU2hxTS9HZFZ4VlVRbWo4cFFK?=
 =?utf-8?B?Q0w2bk5BNWRyVlJvRFBIV1lpclBIM2R5U2xJSTJQWjZTQXIzS29mQXJYQXlN?=
 =?utf-8?B?clU4UEFlMDRxZk9DWTdkOTYwcFExVTdjamtJR01KNFJzWTRzRkYySUlIa0c0?=
 =?utf-8?B?K0RkbENNMHlObzByZlZaRGg3RVV4NE1Kb3ZIUGhGY3JkSWdXWnZVWkExSWlR?=
 =?utf-8?Q?drxMzLShWshT/GC7vqCU+K7cl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09dc0b1c-bcaa-4f7c-f2e6-08dbb3a45246
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 15:24:14.3963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2dgMuSHjWXrHhfV3kyEJXUDblmLPch9UWwZG3TNZtUTpoZ5GhHHJbE1v4DVey7BpMeeta6lrepZYFbvVcJtggA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7956
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chuck Lever, 

On Tue, Sep 12, 2023 at 09:01:29PM +0800, Chuck Lever III wrote:
> 
> 
> > On Sep 11, 2023, at 9:25 PM, Oliver Sang <oliver.sang@intel.com> wrote:
> > 
> > hi, Chuck Lever,
> > 
> > On Fri, Sep 08, 2023 at 02:43:22PM +0000, Chuck Lever III wrote:
> >> 
> >> 
> >>> On Sep 8, 2023, at 1:26 AM, kernel test robot <oliver.sang@intel.com> wrote:
> >>> 
> >>> 
> >>> 
> >>> Hello,
> >>> 
> >>> kernel test robot noticed a -19.0% regression of aim9.disk_src.ops_per_sec on:
> >>> 
> >>> 
> >>> commit: a2e459555c5f9da3e619b7e47a63f98574dc75f1 ("shmem: stable directory offsets")
> >>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >>> 
> >>> testcase: aim9
> >>> test machine: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 112G memory
> >>> parameters:
> >>> 
> >>> testtime: 300s
> >>> test: disk_src
> >>> cpufreq_governor: performance
> >>> 
> >>> 
> >>> In addition to that, the commit also has significant impact on the following tests:
> >>> 
> >>> +------------------+-------------------------------------------------------------------------------------------------+
> >>> | testcase: change | aim9: aim9.disk_src.ops_per_sec -14.6% regression                                               |
> >>> | test machine     | 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 112G memory |
> >>> | test parameters  | cpufreq_governor=performance                                                                    |
> >>> |                  | test=all                                                                                        |
> >>> |                  | testtime=5s                                                                                     |
> >>> +------------------+-------------------------------------------------------------------------------------------------+
> >>> 
> >>> 
> >>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> >>> the same patch/commit), kindly add following tags
> >>> | Reported-by: kernel test robot <oliver.sang@intel.com>
> >>> | Closes: https://lore.kernel.org/oe-lkp/202309081306.3ecb3734-oliver.sang@intel.com
 
> >> But, I'm still in a position where I can't run this test,
> >> and the results don't really indicate where the problem
> >> is. So I can't possibly address this issue.
> >> 
> >> Any suggestions, advice, or help would be appreciated.
> > 
> > if you have further fix patch, could you let us know? I will test it.
> 
> Well that's the problem. Since I can't run the reproducer, there's
> nothing I can do to troubleshoot the problem myself.

We dug more into the perf and other profiling data from 0Day server
running this case, and it seems that the new simple_offset_add()
called by shmem_mknod() brings extra cost related with slab,
specifically the 'radix_tree_node', which cause the regression.

Here is some slabinfo diff for commit a2e459555c5f and its parent:

	23a31d87645c6527 a2e459555c5f9da3e619b7e47a6 
	---------------- --------------------------- 
 
     26363           +40.2%      36956        slabinfo.radix_tree_node.active_objs
    941.00           +40.4%       1321        slabinfo.radix_tree_node.active_slabs
     26363           +40.3%      37001        slabinfo.radix_tree_node.num_objs
    941.00           +40.4%       1321        slabinfo.radix_tree_node.num_slabs

Also the perf profile show some difference

      0.01 ±223%      +0.1        0.10 ± 28%  pp.self.shuffle_freelist
      0.00            +0.1        0.11 ± 40%  pp.self.xas_create
      0.00            +0.1        0.12 ± 27%  pp.self.xas_find_marked
      0.00            +0.1        0.14 ± 18%  pp.self.xas_alloc
      0.03 ±103%      +0.1        0.17 ± 29%  pp.self.xas_descend
      0.00            +0.2        0.16 ± 23%  pp.self.xas_expand
      0.10 ± 22%      +0.2        0.27 ± 16%  pp.self.rcu_segcblist_enqueue
      0.92 ± 35%      +0.3        1.22 ± 11%  pp.self.kmem_cache_free
      0.00            +0.4        0.36 ± 16%  pp.self.xas_store
      0.32 ± 30%      +0.4        0.71 ± 12%  pp.self.__call_rcu_common
      0.18 ± 27%      +0.5        0.65 ±  8%  pp.self.kmem_cache_alloc_lru
      0.36 ± 79%      +0.6        0.96 ± 15%  pp.self.__slab_free
      0.00            +0.8        0.80 ± 14%  pp.self.radix_tree_node_rcu_free
      0.00            +1.0        1.01 ± 16%  pp.self.radix_tree_node_ctor

Some perf profile from a2e459555c5f is: 

-   17.09%     0.09%  singleuser       [kernel.kallsyms]            [k] path_openat   
   - 16.99% path_openat                
      - 12.23% open_last_lookups      
         - 11.33% lookup_open.isra.0
            - 9.05% shmem_mknod
               - 5.11% simple_offset_add
                  - 4.95% __xa_alloc_cyclic 
                     - 4.88% __xa_alloc
                        - 4.76% xas_store 
                           - xas_create
                              - 2.40% xas_expand.constprop.0
                                 - 2.01% xas_alloc
                                    - kmem_cache_alloc_lru
                                       - 1.28% ___slab_alloc
                                          - 1.22% allocate_slab 
                                             - 1.19% shuffle_freelist 
                                                - 1.04% setup_object
                                                     radix_tree_node_ctor

Please let me know if you need more info.

> 
> Is there any hope in getting this reproducer to run on Fedora?

Myself haven't succeeded to reproduce it locally, will keep trying
it tomorrow.

Thanks,
Feng

> 
> --
> Chuck Lever
> 
> 
