Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B017784C8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 03:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjHKBLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 21:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjHKBLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 21:11:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BCE273E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 18:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691716301; x=1723252301;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4cdCNLUFS08Rlq537lVMk3/VGCFz2a5Ayd1THQpQ5/s=;
  b=i4S5Vmv6tgxUICGajnq1FASKrZbclEQwOTaxOthsjGqGW/pNISZ6TVrH
   w4I2WbYxM8vG7q+HQ/o9tNwHJ7ODu8dwp3HtVZuhSkEi9jqnW9ly8qS4B
   6FNxeeEebzXPS97okBg0iGt0j5RYb54sPS6g4VHG32I6eP4wN0TrwgYkY
   EB9tqsxMeCNTcTTitDGeUvL8CzjJm9sNxay4XVN7U1Eu/qR/j9iMWf2OW
   Zjpu00UJ+qKxc15MizXfZQnuked1Vm8D/IDlZaE2x1KHiaVNnBYzkqlJZ
   3H+3M460gNHKyW+SCAhk0LE90GmJixUDywyOFBp4nzVatRIYUPEnZOZmZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="356529572"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="356529572"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 18:11:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="735607739"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="735607739"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 10 Aug 2023 18:11:40 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 18:11:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 18:11:40 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 18:11:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilqT/R23MYHCb6QSUZo00p9szIWKC6Za+X4mDKcpCgej60WWDq+ZtzjVq72aMbJ8thGKwTfuUq+OIxU+N47xJpLtXX3pdK+GPqBv2Bwgfu4MaHjFLp87Rf5XChFCundzqksmA3oACD7QrjHI8omhIOa1roNhWOMyWu86HOyAfAEbWVGpG0UTjcdbiO/BuktjYUSfLexj+h9Bn+NFkvgTCekgHfvb5P05aRTbbzUfYjavNhZfOPv/YfsIIx+WJjtCDC7N1yYqagVR+UeAj0+nifs5rmCvW3qArCzf4r5xGxEZU0Y6e/fIv3KNlD3ToGpKw994A8Hb6jjflWhBf2tElQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaK/pmu0/7o+qRT1yHi3qXkP75KGZOANZWvI4lqErRI=;
 b=h2U9TUFii5wrCYUQK+SB91s/1j9oAgnL6y2Z9pTYETycBNoXxWHBTQqLTFryWNckyOxebiX4QpfXKrm/gnbGH0+RrP7ecTEGEt2lDtx2OHra6ZBasDZezzN4rbxf+/HNboz5gfCY5/iKkWNOciXHCJ2s4KWeOg/SC4p1r3rnZUIsTqMs1fgZs3VAuIok5hPkW5RZL4ylDhLj/IFkiGkZVOwU3fowIrQrpJ9kuCRAiActmRt80RYw8IVWRSbMsCTJeoRw8bcqhenGUti1dU+RtHCHKitFRcJ7WQ94lZstWYufM4uTXjNqj5EJAbr4Z/estDMRTR6D7MhmdS52DwhL8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by BL1PR11MB5224.namprd11.prod.outlook.com (2603:10b6:208:30a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 01:11:36 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 01:11:36 +0000
Date:   Fri, 11 Aug 2023 09:11:21 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     kernel test robot <oliver.sang@intel.com>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        "Ingo Molnar" <mingo@kernel.org>
Subject: Re: [tip:sched/eevdf] [sched/fair]  e0c2ff903c:
 phoronix-test-suite.blogbench.Write.final_score -34.8% regression
Message-ID: <ZNWKuccyWnS3UJjK@chenyu5-mobl2.bbrouter>
References: <202308101628.7af4631a-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202308101628.7af4631a-oliver.sang@intel.com>
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|BL1PR11MB5224:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b88596-658f-45f8-9f65-08db9a07e888
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vtHMULf9nYZ0KqIdvv7GMaSg0aZWJdTIFlyZcVPY36MmuSZDGOjmTZX8Co0Csr62U10A8Nth73GnYYhLH2JPJEPzKhxPOJEHJojlgtQf8Lh4wCszyxqJuJzP2nxmb4noOhYOvVdLTVZgYshEkjoBR704fGIrGKkFhMhsEu0IoWe5lEnNJBmWS6JCxbkrKErCiXvgNg+EQ3vvYlU7JrvW/xEX7if4M6qntiXO9pDYHxh2ZYWeaR/2fKd8YkH1SXB2Sl3re1r0JdhgJx6hesreI8887Hy3B8T8LBzdqke3zG6bpTRdyNCBSnfc3XG0tkpbQjLHVCFBoVv6BqrzIg9v35DGBWN6IitoizxvxW9j6SY10KXjneeyipjzJ27Acn0yrK520mggPk3dJOu9XqYE8fnijcW3PO/DiAvUuWO/iPp2Aw2dk+nio/ObarF1ZbJ/1k06jfCmiNx3RgRvFyPT9eAfEJSWzVnc5m5ZGrV0uf/1WbzZEXdZ0JbWYIQbiyotVEwwLQ3tmjvj+SiIBV/rGahtSYL3W74An6tPwik1DOQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(366004)(396003)(346002)(1800799006)(186006)(451199021)(66476007)(66946007)(66556008)(6916009)(4326008)(41300700001)(316002)(6506007)(53546011)(26005)(83380400001)(86362001)(38100700002)(82960400001)(54906003)(6486002)(6666004)(9686003)(6512007)(966005)(478600001)(2906002)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qoHaRdg2S6cE+GXduHkVPDc/T2jgFze65k8gOhxNaXCYlPyjne+aMnVq7jl2?=
 =?us-ascii?Q?Rslru+wsfl6k82+h2yIBVVZ64MsQgrkfnPstoykdLZoo6HOV12F7U5UZ3f4M?=
 =?us-ascii?Q?p+MuhzUQcsqozWb+EvfP/8mNSJZ4ZJ9u+QrQRzD2u2f6VCKQaGXUEIhayugz?=
 =?us-ascii?Q?sLDJZSgdTizqmQw9rFLPMcIV4H1Tj+H9Cuzog4mPUyJanPZ//Oco2JdDwyTk?=
 =?us-ascii?Q?eKbE/cF7IXfgY5BzCJmhCC0lDjieSHT0YCvvZiqZXE4b6Lv1AIDyXTf/dKNq?=
 =?us-ascii?Q?4ZbliI/OjNcJL5j3oUo+cqxN+tS41kUGkMTSW6rFt3ikxkSM8fek2iHpF02f?=
 =?us-ascii?Q?wyPqTItgD6rabeJTE1pq8KxiRR+hW74VVc1X60Gzv90m4kkXYNNSach/vfxw?=
 =?us-ascii?Q?vy442mscTSwW9jbJw0Ykq2z2ce9ECDE0bpHICFVfrD12JKjftvV05AUsiyED?=
 =?us-ascii?Q?f9UX1x6G26ntJxgrliUTyk3wfMMwaTKTo0VB3BjGhnjH6rOn6XtAdGZ7YdWV?=
 =?us-ascii?Q?ZpsFgzxtp9me7WIlj7w6l6+GCARopMVzxPPypRUMVcwCrN/6BSUeaS5aIjwZ?=
 =?us-ascii?Q?nZUNlNFb8ueEyzyyIhtDiybJPa38dVwl8Dnp6sIOQKKaVsFMlDLDoadIaQ1i?=
 =?us-ascii?Q?VN4G4QIkBZFuEh9SfgqeiG7BPER6z924waPerbDco+5l8oIARMcdzewtIIYQ?=
 =?us-ascii?Q?3tuAN67iSPBkLB9dbZZDPsID+iWy/tWNQf/8KIw2OhmGVGhJxmZZvVyzrYaO?=
 =?us-ascii?Q?1Mli6tEBFS/UTDooUSUbii8HbzJBpzBTyLZsQihGWGoRSMNGx3boBvQWiUrx?=
 =?us-ascii?Q?cgk/JTYyt9kGBNBSVz6ri4oa2PstpQyECj18K438Vm99xxKaaJdJGAsCmjVz?=
 =?us-ascii?Q?/lNO0mReFCKChxdlkTkZ8EJhR+rVzjV55XEt3hc+i/v8OVRw1TNq39SYEuAG?=
 =?us-ascii?Q?ZXT/GxSXFGYwL2N6ldpXmMlz6JBl4dW/Yh9t/b8DokWa8mgXx6GzGgpxA84v?=
 =?us-ascii?Q?PUj71Ctlpy9aGr2PGOdSR9tBMV1SL2oh5hqiZZyxCxoeRre8UdbJvQN+PCiD?=
 =?us-ascii?Q?VWUwXJ9OlipSDNfn5HbgJRH+WagyOJUz7esaUB/qujKZo0J6UBSMQr0iyVnL?=
 =?us-ascii?Q?PuAm+kJA/1x76Mj45k4NovITVyZjdVt+x1S/kyFbpTv/+qn3CoJkqYChNtWZ?=
 =?us-ascii?Q?3xdWmFk7Bz3IG2oe7VPUpNyCj2Xhxam0cAmKAVFLnGGJGqfnPHLnc55jPal/?=
 =?us-ascii?Q?ZvTNoPSfwDG8wXJRzVlav1StZkn/iqOHAnnh98qgpM6vaXtASfj+bUqE1VNe?=
 =?us-ascii?Q?oLCZW19Y/QwSz95L9Kg1IXyeKV/K3zOukDz3k/tGR+33cV7X1pBdKGSbOV2A?=
 =?us-ascii?Q?9LM066GSKqiD+cNuuwScznc+fn6PEjpgCJFi6M4oYZoz9s7+cXHK/odz0JwM?=
 =?us-ascii?Q?hsqRV9o5Lq5o7iKH4vhtNs/dBdH/XB9/54gqQu7opkTimztU7gO8ITyn+Fwg?=
 =?us-ascii?Q?1My8jE/y8k18TU3KyN4cKUn9J3hVuwYsI4XKID5i59hrgtjDyTBZmZDD8TjK?=
 =?us-ascii?Q?pV5R2j2ET/ZTQRG0BiXKgHuWHDrd+9VfTqA7cHld?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b88596-658f-45f8-9f65-08db9a07e888
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 01:11:36.1707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9AJ21Ozip1KX7lPgQYS71pnzSfMC7FthPgZR0JnjZa7pkGzGsVac+ADaoFXiAmDlIUVaGQ02cX7MvudpAuZ/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5224
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-10 at 21:24:37 +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a -34.8% regression of phoronix-test-suite.blogbench.Write.final_score on:
> 
> 
> commit: e0c2ff903c320d3fd3c2c604dc401b3b7c0a1d13 ("sched/fair: Remove sched_feat(START_DEBIT)")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/eevdf
> 
> testcase: phoronix-test-suite
> test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory
> parameters:
> 
> 	test: blogbench-1.1.0
> 	option_a: Write
> 	cpufreq_governor: performance
> 

It seems that commit e0c2ff903c32 removed the sched_feat(START_DEBIT) for initial
task, but also increases the vruntime for non-initial task:
Before the e0c2ff903c32, the vruntime for a enqueued task is:
cfs_rq->min_vruntime
After the e0c2ff903c32, the vruntime for a enqueued task is:
avg_vruntime(cfs_rq) = \Sum v_i * w_i / W
                     = \Sum v_i / nr_tasks
which is usually higher than cfs_rq->min_vruntime, and we give less sleep bonus to
the wakee, which could bring more or less impact to different workloads.
But since later we switched to lag based placement, this new vruntime will minus
lag, which could mitigate this problem. 


thanks,
Chenyu

