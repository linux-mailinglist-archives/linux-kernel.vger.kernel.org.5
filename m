Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F144D7DEE9E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 10:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345388AbjKBJHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 05:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjKBJHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 05:07:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FA712C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 02:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698916017; x=1730452017;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3xfCJavXa7Y1N6DcXjZJ9WldrgY2xkx2nCeKVbJ6jfo=;
  b=XghcoNw5YvKv8z1NtAqMBAK1evrtirzG4VMhqDizoOAUTaN+UTaVzWcF
   G83bgAaul8b6aHhW5MiWIVJ5yZ58MLrwgvbinYwgmMF6Se3KQhsYr9ERA
   A5B115CoqqYAnPAhtmf3HfLE0yw4V0J4qlBQ/pc88SjDJM+V1EnF4gUj3
   U3STFM5GNHiQR8COlTnmnnQ170BAttjrpeJyttbmT/j/zPaLO/fbXmJBd
   aWwDPGglAZWQr6KRSDwLRb4R2Lb874m8guom/ET3VtYQhItRWRoDumqGy
   8FeVm7tZo7YvAQWmxUbYVtGdPi0LloQy6F4M4gPquKFjDY6l4AErDwMvY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="10198326"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="10198326"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 02:06:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="9310228"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 02:06:56 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 02:06:55 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 02:06:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 02:06:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 02:06:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBjliAIaYj9OyQHR5Gj4X/62sDkI2aaNRwJptyVoaM/sd+XIs38GXV5v9J/4yvPAABTfTtJUssW8okmDJK89ANYMfvID6MdDkyVsCzSwOpxk8b/iOhE7e2vrSX3w7qsYPbucyfdBtv02IHym9dRZNxhJdMLTylzNaP8SapH8fSRLNxabC61Yfte1S97sJ0PZQs0AtrKwv6KkwbePSye5eFHTB0WyGLHsp4HhSjmsguZP89vw9gxW343A4WET043n+XRFR2TBLYN5nfR2uqu1yFwmAKRS3ZTcx46Vtg9aWq4aashOskVzgqtEToJk3O9h/M61aL5BQds7r13GEJ0tHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8n1QJ+ZD0K+E236fm7zJHv/SSCyHxfkpg9jJxCmf2I=;
 b=EjeBXQVvPSW3bxmFMZxq4/dcUg7ycgWvuRHvjTBi5TqqN41tfAFsxuWaVo0UFZhFc527CK8QzyrU7AHv6T9lDN9T/ad7COwbFcvOe0ZYAgXCrD9TqVtyLNnjXvhdv/zfMKeEwkG6YNUWMA5sMAsQ1mUF3W9BM6aJDbiKd8DPdTSncRqWJDgHyovCU2+mbiJhTKOVYuzcU5XvMye+ejIa6UyTxPC1Iye0Y7L8mt7P+kvKz+If9a763uAEjj2Mcdg/zVSi9VHXPQjPPby4WJvjmkXgpwMrhCL1KoIc9h3+IrxahWUosMJezKfMnU1TOtayEUClAQ7soPvCXrPT6PLdjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by SN7PR11MB6897.namprd11.prod.outlook.com (2603:10b6:806:2a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 09:06:53 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67%4]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 09:06:53 +0000
Date:   Thu, 2 Nov 2023 17:06:44 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
CC:     Yonghong Song <yonghong.song@linux.dev>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: kernel/bpf/helpers.c:1905:19: warning: no previous declaration
 for 'bpf_percpu_obj_new_impl'
Message-ID: <ZUNmpE2OTpuKcxjW@rli9-mobl>
References: <202311021613.I5dZri9c-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202311021613.I5dZri9c-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|SN7PR11MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: 77703494-566c-4263-fab0-08dbdb830df9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tM7Eo5QQ4Knp/YQR2zaUb/b/JsVr9Cc8ciwky0zt/5VmISSU7fQOiau0PLov0CQg5BBHgkIaoCNoSZ8Z/UEcfGJFgmd1+0EpHi/6ovPeoE8wsGCY5+8ksh7Q8R1m3Y5Y1/KviRSdbcl32H4hDdrifrj5Np+IxTu1mWNwSJu52hPLyVSF0HSZGyKMcnCMuiTbbYk1Z6D4wTrFyK/DauBBc6X6w2JowHxvqmZRGytWPdn/Txun4jT9hz0KRauB4N3J4m2e8WjjBCrYEhKMdvBIsgYrkbsB/AvE7+SnRuylbIOoU52NEPNw1JLM8UNycUt0xTdBVueHpMfGm7ZXLEN+atqTUP3Rc2/F9UvkTgCAfLM5fdLWdWq+N7cvbW7PvC9Zk8c/QaG01rhybJqEs7GkgX9/u3z7ULEyAYiWqWoSvuUkaFUrByDNrIBgjCQ3qZ9frtvE0sHwls8fxwIxIizcjf6P7WAYUG6+NpnJovCjew5d70brqEqOpYDSpjBDvn6WZagXrn37MYBTGO4pvtbwvqCJr2SSl6y0/5US6iAZNqxMbfT6eEZmVSSQhFB5wQI6ic7vabUDFbBSIfpevmdAIwAFWoMI115ZEnFqAoeI0p+0kL3iUMaqhSb1416JKqWDHbyauN7ZKPhRxLMnJSrbHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(366004)(376002)(346002)(136003)(230922051799003)(230173577357003)(230273577357003)(64100799003)(1800799009)(186009)(451199024)(6512007)(26005)(9686003)(6506007)(8676002)(6666004)(5660300002)(54906003)(6862004)(6486002)(66556008)(33716001)(966005)(4326008)(66476007)(8936002)(41300700001)(44832011)(6636002)(478600001)(66946007)(316002)(38100700002)(2906002)(82960400001)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dMXGHlPWxSq/9p4qX+y9IHAATO5wK3lgMzvcH2W12ulSCLAjmG03iMFACLb/?=
 =?us-ascii?Q?4HQvo/bv6i6eWWMdgBb/Wz6oH/Nd39z3liBUDLFu/biTOFtEZ0eDRSYB6fh9?=
 =?us-ascii?Q?7J0jMSVxTyDu/lSgBQa1Q55naYcq1zwnqjIglvrEZCdruFbwRWqRdnamCXsY?=
 =?us-ascii?Q?bDVF1S6V9gpdNd944+cOHuXMF5S+y32E5xYcQSZJfuMvCQomISXeMfdollcY?=
 =?us-ascii?Q?VaveOMv939jJMpZWMhVsIg0r88BiV3BMKgR0/Mb1ANzlL2Kl8ANWatJuKt2n?=
 =?us-ascii?Q?DHdwfN0fU//XtWL+pq0hiWmaVT64eKwsAN7rupqvQ9cSapPs1kerh45YZEqg?=
 =?us-ascii?Q?9U5RL6KRKIck0DDX8bIiKYBaQRKXigSWli7MxO16jZMX5nGxvSXbCPguH+Ht?=
 =?us-ascii?Q?tFe+KK5M1q9OR0hFDvpMqjjysl0CksI6DJ2IECe2pXQuQZQoGMJOToaaM2Ww?=
 =?us-ascii?Q?ifR9jiL3eYNT6pktmPsBk5z900rqpNcbLyU5nSPTFSZ44MgZwD+yFT3EGv5w?=
 =?us-ascii?Q?DCcZFh5BRtIE3y9Ccp8RqCLPM2O+8uNWxnBb9SDCzwFnOissg4wYNZgS8TKR?=
 =?us-ascii?Q?B9a+73mdMEvsIVYajFhG+9vaU+31P528TCT7KkAWF3hnQbNAugBUgaxzPorZ?=
 =?us-ascii?Q?nFVZaA1LGxbqr+jxx0F4vxavndiNHquWZzCB6mmoGAFfk0CXZhIZuzbtYNu1?=
 =?us-ascii?Q?uN4eRnRxDEwegYpKoJsRkY9MUQqeKtkJfjcQdr+w+ky1WpVIU8iVEawPzXBC?=
 =?us-ascii?Q?Jh13ExQnuHS5ltmCJQp2K5d09R8NJueSnznpC5VK1569nF0Wia4K27moNAD+?=
 =?us-ascii?Q?/CsXyGFtQSf162XcCwm7tMDyusGoPDlMYgpPljV6tHYSC2pNbzLmXsv9BsmM?=
 =?us-ascii?Q?QJb+tInh0/Hp0Ec4N6PiBXyphfuDlzIniUGUxQ77k3mB+Iyp4LfjN7GcByGQ?=
 =?us-ascii?Q?bbGXpPQvjmmh/cF3x3qiZDMQ4a/tZTt0VLTj0VkDst0xyRYs/Fdik+NknexN?=
 =?us-ascii?Q?c0cURM0OfPTJl5hXBc631P70Tpe+5OCORXxGU+Y0BrLHbo3mEmIHLFfUHc8c?=
 =?us-ascii?Q?UzULN+m2GmGjEFVqh5iCOViaPhQqLMzAr+m5vGaDu7I/rw0pOD6AtxONpKwJ?=
 =?us-ascii?Q?Q9HqmacOubGbciVc8hoIn1l/eI5HxKobgD3FE1nd0h4TmnoFWpj0Fmt/AUQi?=
 =?us-ascii?Q?lRmNsOXwskVpWINAlk3vCHdzE2W8224sfCsRqdNzXNrgm50mXi+ijLg5s5TU?=
 =?us-ascii?Q?RGfEVBKoTN9MIp3o1+/pLYPVDSCXGCNQjqT/aNHCBu2abKbNpIowUk9K2XNq?=
 =?us-ascii?Q?PoKUS5CgJgX+Za+0Ws8fsIz52dmdXYvCuLN1AFNOTspz0eFucArfCJq91Afq?=
 =?us-ascii?Q?LJFD/pe8sDVIZXjufghPHRgwzZuaSf9EDd+0Vhqx0bFr7Xkt9LHgqbUTZt8b?=
 =?us-ascii?Q?HEagwKdc98pSf3kPJHFNhNog336ugoGTcrQrC1JqAP32rEZxg6WxZIZexyGS?=
 =?us-ascii?Q?ywXSGo79/Tp1D+U0KcYAfYGEJFkqRqZ0F3jStG7hycb9Uc+a0lYGMciqawWU?=
 =?us-ascii?Q?R1aEAbxLGJqGnabNQCtTwHNfXjEgl+q/2uUv2LaD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77703494-566c-4263-fab0-08dbdb830df9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 09:06:53.1700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLoP16Ud9GPGfOH653JBnTHKkl3N0gTPgU22h+WMh4lBbZ03YzdNdUiLwV02TNGzug21ri51SVD6Q0oosjT4Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6897
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 04:42:39PM +0800, kernel test robot wrote:
> Hi Yonghong,

Sorry, kindly ignore this report, it is similar one as https://lore.kernel.org/oe-kbuild-all/202309241550.JnHcYTZh-lkp@intel.com/,
and we haven't fixed the bot side yet.

> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   21e80f3841c01aeaf32d7aee7bbc87b3db1aa0c6
> commit: 36d8bdf75a93190e5669b9d1d95994e13e15ba1d bpf: Add alloc/xchg/direct_access support for local percpu kptr
> date:   8 weeks ago
> config: x86_64-buildonly-randconfig-006-20231102 (https://download.01.org/0day-ci/archive/20231102/202311021613.I5dZri9c-lkp@intel.com/config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231102/202311021613.I5dZri9c-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311021613.I5dZri9c-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    kernel/bpf/helpers.c:1891:19: warning: no previous declaration for 'bpf_obj_new_impl' [-Wmissing-declarations]
>     __bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
>                       ^~~~~~~~~~~~~~~~
> >> kernel/bpf/helpers.c:1905:19: warning: no previous declaration for 'bpf_percpu_obj_new_impl' [-Wmissing-declarations]
>     __bpf_kfunc void *bpf_percpu_obj_new_impl(u64 local_type_id__k, void *meta__ign)
>                       ^~~~~~~~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:1933:18: warning: no previous declaration for 'bpf_obj_drop_impl' [-Wmissing-declarations]
>     __bpf_kfunc void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
>                      ^~~~~~~~~~~~~~~~~
> >> kernel/bpf/helpers.c:1941:18: warning: no previous declaration for 'bpf_percpu_obj_drop_impl' [-Wmissing-declarations]
>     __bpf_kfunc void bpf_percpu_obj_drop_impl(void *p__alloc, void *meta__ign)
>                      ^~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:1947:19: warning: no previous declaration for 'bpf_refcount_acquire_impl' [-Wmissing-declarations]
>     __bpf_kfunc void *bpf_refcount_acquire_impl(void *p__refcounted_kptr, void *meta__ign)
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:1992:17: warning: no previous declaration for 'bpf_list_push_front_impl' [-Wmissing-declarations]
>     __bpf_kfunc int bpf_list_push_front_impl(struct bpf_list_head *head,
>                     ^~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2002:17: warning: no previous declaration for 'bpf_list_push_back_impl' [-Wmissing-declarations]
>     __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
>                     ^~~~~~~~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2035:35: warning: no previous declaration for 'bpf_list_pop_front' [-Wmissing-declarations]
>     __bpf_kfunc struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head)
>                                       ^~~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2040:35: warning: no previous declaration for 'bpf_list_pop_back' [-Wmissing-declarations]
>     __bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
>                                       ^~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2045:33: warning: no previous declaration for 'bpf_rbtree_remove' [-Wmissing-declarations]
>     __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
>                                     ^~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2101:17: warning: no previous declaration for 'bpf_rbtree_add_impl' [-Wmissing-declarations]
>     __bpf_kfunc int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *node,
>                     ^~~~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2111:33: warning: no previous declaration for 'bpf_rbtree_first' [-Wmissing-declarations]
>     __bpf_kfunc struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root)
>                                     ^~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2124:33: warning: no previous declaration for 'bpf_task_acquire' [-Wmissing-declarations]
>     __bpf_kfunc struct task_struct *bpf_task_acquire(struct task_struct *p)
>                                     ^~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2135:18: warning: no previous declaration for 'bpf_task_release' [-Wmissing-declarations]
>     __bpf_kfunc void bpf_task_release(struct task_struct *p)
>                      ^~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2224:33: warning: no previous declaration for 'bpf_task_from_pid' [-Wmissing-declarations]
>     __bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
>                                     ^~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2265:19: warning: no previous declaration for 'bpf_dynptr_slice' [-Wmissing-declarations]
>     __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset,
>                       ^~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2349:19: warning: no previous declaration for 'bpf_dynptr_slice_rdwr' [-Wmissing-declarations]
>     __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 offset,
>                       ^~~~~~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2380:17: warning: no previous declaration for 'bpf_dynptr_adjust' [-Wmissing-declarations]
>     __bpf_kfunc int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 start, u32 end)
>                     ^~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2398:18: warning: no previous declaration for 'bpf_dynptr_is_null' [-Wmissing-declarations]
>     __bpf_kfunc bool bpf_dynptr_is_null(struct bpf_dynptr_kern *ptr)
>                      ^~~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2403:18: warning: no previous declaration for 'bpf_dynptr_is_rdonly' [-Wmissing-declarations]
>     __bpf_kfunc bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
>                      ^~~~~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2411:19: warning: no previous declaration for 'bpf_dynptr_size' [-Wmissing-declarations]
>     __bpf_kfunc __u32 bpf_dynptr_size(const struct bpf_dynptr_kern *ptr)
>                       ^~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2419:17: warning: no previous declaration for 'bpf_dynptr_clone' [-Wmissing-declarations]
>     __bpf_kfunc int bpf_dynptr_clone(struct bpf_dynptr_kern *ptr,
>                     ^~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2432:19: warning: no previous declaration for 'bpf_cast_to_kern_ctx' [-Wmissing-declarations]
>     __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
>                       ^~~~~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2437:19: warning: no previous declaration for 'bpf_rdonly_cast' [-Wmissing-declarations]
>     __bpf_kfunc void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__k)
>                       ^~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2442:18: warning: no previous declaration for 'bpf_rcu_read_lock' [-Wmissing-declarations]
>     __bpf_kfunc void bpf_rcu_read_lock(void)
>                      ^~~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:2447:18: warning: no previous declaration for 'bpf_rcu_read_unlock' [-Wmissing-declarations]
>     __bpf_kfunc void bpf_rcu_read_unlock(void)
>                      ^~~~~~~~~~~~~~~~~~~
> 
> 
> vim +/bpf_percpu_obj_new_impl +1905 kernel/bpf/helpers.c
> 
>   1904	
> > 1905	__bpf_kfunc void *bpf_percpu_obj_new_impl(u64 local_type_id__k, void *meta__ign)
>   1906	{
>   1907		u64 size = local_type_id__k;
>   1908	
>   1909		/* The verifier has ensured that meta__ign must be NULL */
>   1910		return bpf_mem_alloc(&bpf_global_percpu_ma, size);
>   1911	}
>   1912	
>   1913	/* Must be called under migrate_disable(), as required by bpf_mem_free */
>   1914	void __bpf_obj_drop_impl(void *p, const struct btf_record *rec)
>   1915	{
>   1916		if (rec && rec->refcount_off >= 0 &&
>   1917		    !refcount_dec_and_test((refcount_t *)(p + rec->refcount_off))) {
>   1918			/* Object is refcounted and refcount_dec didn't result in 0
>   1919			 * refcount. Return without freeing the object
>   1920			 */
>   1921			return;
>   1922		}
>   1923	
>   1924		if (rec)
>   1925			bpf_obj_free_fields(rec, p);
>   1926	
>   1927		if (rec && rec->refcount_off >= 0)
>   1928			bpf_mem_free_rcu(&bpf_global_ma, p);
>   1929		else
>   1930			bpf_mem_free(&bpf_global_ma, p);
>   1931	}
>   1932	
>   1933	__bpf_kfunc void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
>   1934	{
>   1935		struct btf_struct_meta *meta = meta__ign;
>   1936		void *p = p__alloc;
>   1937	
>   1938		__bpf_obj_drop_impl(p, meta ? meta->record : NULL);
>   1939	}
>   1940	
> > 1941	__bpf_kfunc void bpf_percpu_obj_drop_impl(void *p__alloc, void *meta__ign)
>   1942	{
>   1943		/* The verifier has ensured that meta__ign must be NULL */
>   1944		bpf_mem_free_rcu(&bpf_global_percpu_ma, p__alloc);
>   1945	}
>   1946	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
