Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABB5792BBE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243825AbjIEQ6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354523AbjIEMSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:18:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E321A8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 05:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693916300; x=1725452300;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iwu9ZP+3SKRdduSnw1cQjQ5MR55HRbuE15NADiGhRV8=;
  b=PmcXDvAMIMIeJPXSsJz/Z9FzyMx5EepnhKZwyMQ0DmKoRVbHMDYpzEx1
   lsyy2PNpGT7gkdz58gJXjjF1UGMqev5UGqXjwedRpqILqlEbouex8kEos
   DQXOldHeqeZvV91cvho6j2VMgjiP1UaeGFwKYdmqolIbSGGiHlEHdycoE
   VhXDeZGZKNurxnu/YlNJFy/tM4wxZAhYsHmei6mDBoneK/en967Zl/xB0
   BpliNTWdNCnH/50QteCEAg1I3G8a2MUk74V32YslSImU4lAFGXob4fwq+
   561wI/pk4nNIJdO99F2kUlqxWinJKPSrjl8M4c7lZ7NIFhBPMVwKiuTEq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="379500038"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="379500038"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 05:18:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="776184868"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="776184868"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 05:18:19 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 05:18:19 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 05:18:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 05:18:18 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 05:18:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAs1O2PvDgM2eJDk/I4RjtL/4UP/jautPA987gXWUyQx/zh9jTuwH01c7FiyWnraWJAAA7kH4Dh9jDklj6TByFf7h33k4Q2EB7+00rSJMIgY9tWNU4zOyCRxfOx7CxoPOxKMpClJIJpNO2AJ7uQO3hndsJ6yxEijG35K2HGoxi0ICBm2Yjc3LAzdmZpa0hE3JITfygW4vwdKLfdQWS1AXi0993ink1WfQbayWmjZHSFiuAeApCDfqly2iRZTeCmWotXel0YDOBXxEoZ7bFwCoNcU3QywVqBJ1WKA8CbLIfvU/2hIqU1Qwapu3T7XohANmWcZycBekhmyCvrsfm9LYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4O5620JIu3NexKEB7HVx/hIaWvLy/PUewuER17r2u8M=;
 b=S2254e7rx9QbkZpFe7pBtn+Pqd8COge5YUppkV1GKy8ylk/SJ6yWTZLfCvH1AKSsXByc5OpL7EbSVF5tinNrXXd1z16tULghdtlw0pm0troZxzOvspqwBcf3a702D12agQ8XjItgOgcnoaw/10VD6Q8/SaHssmNtNgCwZMSFkdGAPpEleRdz+5Vdr+0wdjVG/3wBbTqQ2kjRIazts9IL+3UoTfZOylSDH48oU8x0j+Tyud99tlKDYADvioJn7Wkb3FblTjwqINxffRAwm1vd/gXHHTCUrKmRLAKfs3FtjMK4CnKCS1NAEo//g2Etc5lH/rluH72Ye3ivv8KyNq86RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by DM6PR11MB4754.namprd11.prod.outlook.com (2603:10b6:5:2ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 12:18:16 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::b844:be65:8430:f80e]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::b844:be65:8430:f80e%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 12:18:16 +0000
Date:   Tue, 5 Sep 2023 20:18:05 +0800
From:   kernel test robot <philip.li@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: mm/slub.c:2142:15: warning: variable 'partial_slabs' set but not used
Message-ID: <ZPccfSJvDXi/xOnI@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0156.apcprd04.prod.outlook.com (2603:1096:4::18)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|DM6PR11MB4754:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f3802a-7291-4b63-bb45-08dbae0a2eec
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zJXAUGiKXwGDznl0xGVRqwC8qCjpuMJmNdW4DZ//9skh9OkLLUyy+J68LmzEQjkmOv+epNobKbK77w/hnLjiDJ2D8ZLL+tZjfeKD3outxPNQpY+C5oJsebH0u3zUc+SItkd1V7njxf8pVeZiZCISGk/qeJievb3w2WzrCkJhqK+OneiwnVQRFeyPZAUKZ5s9wfwtT24KCA0506vZb0gEIhTcIfT1At8IbhuozgykLZYA6C7v6gNsObl2HBY5vEjmaDUrVDU5dLWVFrEfWlLLQj3wGcjTZaslIEg5NRAWtmR5g6aykZzRqgrn37m7OyGUtq/eggzFOAOjYkUeo9kcLdk/bhbWJKqxCzJF1wTIt4OLmOvuSJX8RVw4jGHgaavFtAGzVqd+kR+IHk3min2YKRwWsGVrFFc3SkEMHqAg3JDXOc2xWSrKaXUflxKYIyJ3aPf+Y2HhyqQokFGbJkX47yIE3AYpO3SgHDdHX2oNy+zD4l7jVHDf93U0ht+H6I8P/5gh6vZ6Sgb/bCSZYu2zEQ6JRvsecZEECeBh7zgtKcY85aQ7svChG/r7RC01n+D8Ma/AOOUJW0xnmSH8tBZC4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199024)(1800799009)(186009)(8936002)(54906003)(316002)(6916009)(8676002)(4326008)(66946007)(66476007)(66556008)(6486002)(6506007)(6512007)(9686003)(41300700001)(26005)(5660300002)(83380400001)(478600001)(6666004)(966005)(4001150100001)(2906002)(33716001)(86362001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mXgZmeu4QyI541yJyzKrvzc0Mx+mFRRKgUttDRYseVVDM1s5zXuZpcVvH+5E?=
 =?us-ascii?Q?/EzQy/pObzmcrEQszaEsUUkLN37diYveVk4yRu2mUlvbAxxWIUNbjVlAL8yb?=
 =?us-ascii?Q?Y1Pygv2QfYxQ+db8cGSDda4eV4LrF5wnVcdIBpgALpd972CxjX9bR/CLQHEs?=
 =?us-ascii?Q?u3Zfva8Imw/48VI7Nnkj50WzYqZ+gq4WDj/tKGCURgzfA5j9WqHxiraMIrLq?=
 =?us-ascii?Q?iVMQmAx7BnZXQ87xILJNPRNSpNaYhOTjn2HZ9oeo09ibT9fiEseEDwaaJFPV?=
 =?us-ascii?Q?8MUMRBcgJy2AY2gdiJhBqsXTqRIXbzu4Kg8ThKMh7o7Zn/DPNurnXTvTIRLR?=
 =?us-ascii?Q?ndzg/YMMN4/Jn+ux0L9s3itSa0N/3oyf+2p4HKQVSBBw8XPTUKIJJBZpJ7K7?=
 =?us-ascii?Q?AHSDOuAXB9Y8JgZShu71ALMJT02n8j8DImny1KqP5ejwen6ltlV2sDwUpS8C?=
 =?us-ascii?Q?itKPrUC1y1+8EHR2r4Bra3CH87nmVfrYZtOt/1PbCzOyKaPVI+RZ2HNdHOSr?=
 =?us-ascii?Q?t6IeknHqGCop/NHqv59q05BcbP0m1PHsuzkqlbO/iIH13tSzyIBbVNWfItqw?=
 =?us-ascii?Q?enUpsy9eh2hfLEqjvWn2lKOZkIhlWw0oIO3KutfS7vAqytzTNolpgPsBwxO2?=
 =?us-ascii?Q?Fo71mIrHASXTlcutk9pnHR30WsdCgm84SV552rh0EmWNwaPwDAktjtUdj+KB?=
 =?us-ascii?Q?tesF+FXEwdeb2NztEJnE1HS4+MTqzbYb4utC3V2NSFwYlx3aDr4RXZbOpHIq?=
 =?us-ascii?Q?6q9oVnfZ6+40X+v0x8Kd9AjleyZwkdtuQdNgQeF4S2nl2uDBk8SJoZxEdRAy?=
 =?us-ascii?Q?iTVEFq9EVtzTvk238OBkuCVcs7Rz8cO2GEQkU0zyODv9/10g8f0z9EWuK68V?=
 =?us-ascii?Q?UNjf4le76W6tse0KlNPD3bozd3jk4Rn4dCDB8Rmi5Yvy44b6ZvpMeGwJhDv8?=
 =?us-ascii?Q?U4cjb4ZbWOwu4BdwvmUckcf56PSX7WXIxBrwcJa7sWMFewAoGKoIcrkT8BoC?=
 =?us-ascii?Q?LmspwqbpRFzxdbkLVB82mFzINjrddrZ2JAZFPVaZ5bcTEZpjkKPU/4XezUnV?=
 =?us-ascii?Q?ZyWLonx6OEga/Nzkp2StqdvzWFxjHQqnZ9AWoQVahHkizJjrysPFjzi7I24a?=
 =?us-ascii?Q?d+FHtq1GSGlxhUtPXFc+xbMmB/UJURV5yj8k6dhwOr7ps/E0pr7h+BrXU2+2?=
 =?us-ascii?Q?ixV7tZEeGlMwWOkCL4NEbuE/MRpx7HWISlx7KyqYGdVy0xO7XiwzAnLtcqva?=
 =?us-ascii?Q?ANInb+zWZWyc0MYlNyLVZKjxafrHfZ6v75HaJ3BNg/MbvyJxdOSYBMAO+1Tl?=
 =?us-ascii?Q?5HgNwScDKcnH661Jc2jJecridxHf9sDpumDah3nQJ+NSsaCIhC95MGtMnrFT?=
 =?us-ascii?Q?kd2x81+FHuJlDl/gmhKR4Z8eTrpMgC/wnYXeKdUtVFbk98100/+22rINLB02?=
 =?us-ascii?Q?u1M7lD5/QnrZKDUII7px6NEAZx2Qb7G2HBF01nzhGdsl07mvQJklUhINKQjN?=
 =?us-ascii?Q?CKZEbwiHQ9T0ztZDgZkMw4w1X+oaUuYRb/IQK1kIp86hdiew46C/L06u3iyD?=
 =?us-ascii?Q?QsAnq+B99KJQfhk5NaJcNN70LexM3rSSuHa9o0Cj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f3802a-7291-4b63-bb45-08dbae0a2eec
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 12:18:16.6547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4iSk0ph1FF6NPxn+IjXrK+VyHTXm4YKNRoH9kNtfUaW7Ax/JdMoXlFbpLB4uMYr6CULKj4M1QudRIzZuzfcPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4754
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vlastimil,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3f86ed6ec0b390c033eae7f9c487a3fea268e027
commit: bb192ed9aa7191a5d65548f82c42b6750d65f569 mm/slub: Convert most struct page to struct slab by spatch
date:   1 year, 8 months ago
:::::: branch date: 12 hours ago
:::::: commit date: 1 year, 8 months ago
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20230905/202309051941.72ZiILCM-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230905/202309051941.72ZiILCM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202309051941.72ZiILCM-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/slub.c:2142:15: warning: variable 'partial_slabs' set but not used [-Wunused-but-set-variable]
           unsigned int partial_slabs = 0;
                        ^
   mm/slub.c:1681:21: warning: unused function 'kmalloc_large_node_hook' [-Wunused-function]
   static inline void *kmalloc_large_node_hook(void *ptr, size_t size, gfp_t flags)
                       ^
   2 warnings generated.


vim +/partial_slabs +2142 mm/slub.c

49e2258586b423 Christoph Lameter 2011-08-09  2132  
81819f0fc8285a Christoph Lameter 2007-05-06  2133  /*
672bba3a4b2e65 Christoph Lameter 2007-05-09  2134   * Try to allocate a partial slab from a specific node.
81819f0fc8285a Christoph Lameter 2007-05-06  2135   */
8ba00bb68a067c Joonsoo Kim       2012-09-17  2136  static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
bb192ed9aa7191 Vlastimil Babka   2021-11-03  2137  			      struct slab **ret_slab, gfp_t gfpflags)
81819f0fc8285a Christoph Lameter 2007-05-06  2138  {
bb192ed9aa7191 Vlastimil Babka   2021-11-03  2139  	struct slab *slab, *slab2;
49e2258586b423 Christoph Lameter 2011-08-09  2140  	void *object = NULL;
4b1f449dedd2ff Vlastimil Babka   2021-05-11  2141  	unsigned long flags;
bb192ed9aa7191 Vlastimil Babka   2021-11-03 @2142  	unsigned int partial_slabs = 0;
81819f0fc8285a Christoph Lameter 2007-05-06  2143  
81819f0fc8285a Christoph Lameter 2007-05-06  2144  	/*
81819f0fc8285a Christoph Lameter 2007-05-06  2145  	 * Racy check. If we mistakenly see no partial slabs then we
81819f0fc8285a Christoph Lameter 2007-05-06  2146  	 * just allocate an empty slab. If we mistakenly try to get a
70b6d25ec59cbc Chen Tao          2020-10-15  2147  	 * partial slab and there is none available then get_partial()
672bba3a4b2e65 Christoph Lameter 2007-05-09  2148  	 * will return NULL.
81819f0fc8285a Christoph Lameter 2007-05-06  2149  	 */
81819f0fc8285a Christoph Lameter 2007-05-06  2150  	if (!n || !n->nr_partial)
81819f0fc8285a Christoph Lameter 2007-05-06  2151  		return NULL;
81819f0fc8285a Christoph Lameter 2007-05-06  2152  
4b1f449dedd2ff Vlastimil Babka   2021-05-11  2153  	spin_lock_irqsave(&n->list_lock, flags);
bb192ed9aa7191 Vlastimil Babka   2021-11-03  2154  	list_for_each_entry_safe(slab, slab2, &n->partial, slab_list) {
8ba00bb68a067c Joonsoo Kim       2012-09-17  2155  		void *t;
49e2258586b423 Christoph Lameter 2011-08-09  2156  
bb192ed9aa7191 Vlastimil Babka   2021-11-03  2157  		if (!pfmemalloc_match(slab, gfpflags))
8ba00bb68a067c Joonsoo Kim       2012-09-17  2158  			continue;
8ba00bb68a067c Joonsoo Kim       2012-09-17  2159  
bb192ed9aa7191 Vlastimil Babka   2021-11-03  2160  		t = acquire_slab(s, n, slab, object == NULL);
49e2258586b423 Christoph Lameter 2011-08-09  2161  		if (!t)
9b1ea29bc0d7b9 Linus Torvalds    2021-03-10  2162  			break;
49e2258586b423 Christoph Lameter 2011-08-09  2163  
12d79634f8d7af Alex Shi          2011-09-07  2164  		if (!object) {
bb192ed9aa7191 Vlastimil Babka   2021-11-03  2165  			*ret_slab = slab;
49e2258586b423 Christoph Lameter 2011-08-09  2166  			stat(s, ALLOC_FROM_PARTIAL);
49e2258586b423 Christoph Lameter 2011-08-09  2167  			object = t;
49e2258586b423 Christoph Lameter 2011-08-09  2168  		} else {
bb192ed9aa7191 Vlastimil Babka   2021-11-03  2169  			put_cpu_partial(s, slab, 0);
8028dcea8abbbd Alex Shi          2012-02-03  2170  			stat(s, CPU_PARTIAL_NODE);
bb192ed9aa7191 Vlastimil Babka   2021-11-03  2171  			partial_slabs++;
49e2258586b423 Christoph Lameter 2011-08-09  2172  		}
b47291ef02b0be Vlastimil Babka   2021-11-05  2173  #ifdef CONFIG_SLUB_CPU_PARTIAL
345c905d13a4ec Joonsoo Kim       2013-06-19  2174  		if (!kmem_cache_has_cpu_partial(s)
bb192ed9aa7191 Vlastimil Babka   2021-11-03  2175  			|| partial_slabs > s->cpu_partial_slabs / 2)
49e2258586b423 Christoph Lameter 2011-08-09  2176  			break;
b47291ef02b0be Vlastimil Babka   2021-11-05  2177  #else
b47291ef02b0be Vlastimil Babka   2021-11-05  2178  		break;
b47291ef02b0be Vlastimil Babka   2021-11-05  2179  #endif
49e2258586b423 Christoph Lameter 2011-08-09  2180  
497b66f2ecc978 Christoph Lameter 2011-08-09  2181  	}
4b1f449dedd2ff Vlastimil Babka   2021-05-11  2182  	spin_unlock_irqrestore(&n->list_lock, flags);
497b66f2ecc978 Christoph Lameter 2011-08-09  2183  	return object;
81819f0fc8285a Christoph Lameter 2007-05-06  2184  }
81819f0fc8285a Christoph Lameter 2007-05-06  2185  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

