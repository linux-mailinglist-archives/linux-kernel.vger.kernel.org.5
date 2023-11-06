Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA137E1A32
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjKFGXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjKFGXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:23:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4038DB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 22:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699251779; x=1730787779;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=weEuC/9VSBHLkvm9pZJCghf4D0pZvsqjgAEUcoBxppg=;
  b=GkZqXS3OhzpTpZTdWn/zqR8UX2UgAFJwirZTz0ytU2ABiO7jSC7f+BDM
   zmde/qfwW/CSC9B4QdJFOnykUHqFUSmUxhvM2Llb6niNxLGW7Ua8iYpe6
   KPNMGnSL0EZyW1bRT0bXLU498N8YPaXOwcO+gNZ9NIEO9h1mJdShs34Zo
   jyv3xViW74D29Q1+XQFhFkVRjs/iHc27k8zvetcmcqyUF6i3zix7UiacB
   zJyPby3Fl4yCauOKlc2FBfQqpZy1GpcF3SMXrsX4D+bNjS3sPIZYojF+U
   bABajvaOKQmYedSsPiaa16FpThcq8K6n2xlN1RrDPHPjjEbSF6Zw8OHQY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="388097434"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="388097434"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 22:22:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="832626590"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="832626590"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Nov 2023 22:23:00 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 5 Nov 2023 22:22:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 5 Nov 2023 22:22:59 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 5 Nov 2023 22:22:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvfTzZCUy3qhwp4n3GGVVSThs+w0kV2l83GeRAKJKS7L1ww4MIsjX/eG9aY+ST03Zy5a8u/DVvs817LLbfb2tP2xIjaNpSoloNqT138eX17S8cwZFYw5UQ1SfwQI8m7xPN/Zs9IfX7bGYnJU3h4QybMOgsIY1WZ0sxX5CWe/bmYhx3PqIOMra2hcWI0gzvUPzCr6UV4sZGdc4FngPX9awYKATdd/zU3yS1XdvY52gInl5f8lcqWjjYKu5EiM2RovyZX3iZouBOkhAvotmy04SxnnDT3OWRR1r8z1UQxXunoUhJRstkgOq3mvA3BSMDEPS3edk45zDhd8aBF/e+dtWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqZKNmYVYvAAbnIvpBAC4AfZkFoCjnEodClKroEdzHE=;
 b=HIrf/fI5i5T3JjXNkZ6iW6pQiEnMHXSPr7duuocVRSz95NXEE6CA7LFLHH3pESY0SZJ/qlE71jyVNb6a5XzcEP4LVYdEeEyC3pGW93JUY2qUBHryk8OF4vlPJGA3KnKad0Y8slNNsmUEEqvZDGJ7F5/CWRBtTnEvHoey8L91kvdGZPGSr5LFvduPwcz7fYsRRtbP2f0ai61Qt0WY6av7kqBTxEQrFZ5woFyJvCWY8NrIovDY1qReHIyWqt1IvjpYqQbNSe7TGjwK4Bd5QRrV+82EYR7Np3apf9ZLuAIuIaG8i0Me67IYr1rPXIXO8QuuzSgpT8HA0YftSfbcYFZk7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by BL1PR11MB5382.namprd11.prod.outlook.com (2603:10b6:208:31c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 06:22:54 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.6933.028; Mon, 6 Nov 2023
 06:22:54 +0000
Date:   Mon, 6 Nov 2023 14:18:11 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Nadav Amit <namit@vmware.com>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Xavier Deguillard" <xdeguillard@vmware.com>
Subject: drivers/misc/vmw_balloon.c:200: warning: Function parameter or
 member '5' not described in 'vmballoon_batch_entry'
Message-ID: <202311061016.YX1N3JbG-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR01CA0159.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::15) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|BL1PR11MB5382:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bcf14ee-9589-49c3-8176-08dbde90cf94
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2+eJRTsBnF0Z49v6ahOHTn41FeoW747R+u3/KLuOx52DfvySIItgroRVMgA2QjzTIwlnQPd0bJd57CIHnJxzIfu+LrPI9at0ABoPdwoHuH/RRXC0XqMg7lS/Tx2pkM3Ez6Uj7qa9c2popnxRC1VyvhsvGakEftn54C7P+v68iAtqo4UxCz7WghEA3P0cMvHQeH3CJizPYTrDxGxIBQbNowBbPIPPUbN4jGmbqS396y2FprSczXw7k48yFh5h2eaC8Id5OSLc0vsdMrujWTy6eO0qJE/asfZp4eoGMD5eHAlqgRmUiZHngIhmtu38EhVn7t8zvVQjjvrI1XghuY9rIPqrdemt5BeKUJ3kRwbzI36JIH7OFuT9EFZBqIhECI/2m8ojap+5U76oYbPLSJtLQU/3dSKoQkiFsoPgKzJO/qGHItvl7HjIgQGnAf8gCPvNxs08c3Xc/WSX/4uWB3Jy6Dpe86HvlSiMDMCvL8uLP0U9AVqPQT+S3MBNwR9OgAv/qfugC/B6mbNODdgNbyfsqoT1QpADpYSh1uHxNC85OH+vU/z3Lp69jLcvXYnVrMWYvDyCSYv9CouvAN7hLZRivxu1zOFjHcHFTGHq26sdkwWH83/ulUfqvh9d1aEepRaxphjm+4lzoh+IfUAuBG5K1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(186009)(1800799009)(451199024)(2616005)(83380400001)(6666004)(6506007)(6512007)(82960400001)(26005)(1076003)(6486002)(478600001)(966005)(38100700002)(66476007)(8936002)(8676002)(316002)(66946007)(66556008)(6916009)(4326008)(5660300002)(86362001)(2906002)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hJwDV2y12Fk+Ur+PkF/UzyMSQUQdIC/UFGedGkisghf7VeYEKFKjSYMsIckF?=
 =?us-ascii?Q?M0KKHL7fyVW1dWvui5BGE+SJQcnrVy/jmjfe+hdgkeNZFDZbLOvdZfuKRIyW?=
 =?us-ascii?Q?RVB/cdZ8E6JaOpUnEQNkAGQ035gmQmta9dauYzrURtWO1zvMylm9c/+w703q?=
 =?us-ascii?Q?55WpZpYSNNU4QTWt4RI5j//Mq06Sti0IVmQULS1uXgTi3zg2HN2Jd/SFBdEW?=
 =?us-ascii?Q?qCd7FxXTaXy+sDWC+GQfBuJQZEypOiyCwAboL+JFsIvj8N/SIgPHpbD8GXaV?=
 =?us-ascii?Q?HX7gCGfeNRbROb5FKwcyEbk39ZFNsUtxk06mOtp1RqOmdm+UoWtzG6Ymf2Cr?=
 =?us-ascii?Q?PtnJ82S2m9pWhSo9JAdt/4V2/680pxEpz8zcDy1YParsSuz+fVhPHTzpRMMs?=
 =?us-ascii?Q?6/f3uT9P23ML4ExUyYiImk8GhQXi1gtCDgdE38UY8RQyoNiYjSpje1VypSRP?=
 =?us-ascii?Q?cm9unQuNXBKmELrdqqBbGyyR0t5PF8U0Yo8pmW34pFDYPlgg8Bo7nA/Q7V5z?=
 =?us-ascii?Q?zwrazGZdsCjwhg7WdORAQDLQVtOa0iadWfY0V1/RntExDVtDQHF5EUJYV/eg?=
 =?us-ascii?Q?I6oCcMV1kJvnZ92LBNQz04QkIkwJQgm3HzLANGfoTJd3l5kwzSimAuNp6BRS?=
 =?us-ascii?Q?mhPv3YMiBeo2gCT+ZqmphEO6sY66TNdqNV9LyKf0FGCh5/qj6aabztAmhefi?=
 =?us-ascii?Q?NIZBIpaEiyuY1gqwhaioEdq3Q7CyBN8C2BZ5s3CHCFVT6DO/kJIOeQAWEByr?=
 =?us-ascii?Q?pqyOTIhEfb3sT+4GXdBnSuQOe3Q6OQb6DIzTDWTzAar9tmYomkjM9m5INmOm?=
 =?us-ascii?Q?2ndWznB8QztYsOfjKEKWbg/2J5jOG/KztpiNs6UBHBDNiOzq6iy9/tgh0TzO?=
 =?us-ascii?Q?mLB2b33JAFr67fquyvvoK4Yrqyb5YwVAbIW9SXwCSqCWbcB1HxMiI79+RE79?=
 =?us-ascii?Q?HhCgaQimmgen3ilC/86PPjJCVjcxhcF436b3I+ITSzWfSoYtixJn7aYsnh/a?=
 =?us-ascii?Q?WRno+nAcYFZFScm4e+k0yQgRDJNzmiUBKIG7MZ/LVwUJRt7cS+YCnYF8u6rM?=
 =?us-ascii?Q?9ls8LjsaILabQjEK1D1fjscAEP2Z06uC/82IG1qtUNgGhWGS6/00AfYTmOTa?=
 =?us-ascii?Q?SF14FleSGAuCZW0Msdnk8grg9XdlNCR4nqHBo/qD/DIyQg2CHJP5i/Cj3NRt?=
 =?us-ascii?Q?/PeDS0taocAZK+F4b6cm4cuUmjCVBr7Cd4CKlbtUFBvaDOuQauCGxeFgQnJ8?=
 =?us-ascii?Q?a8Tzna6UihHJ4vCyblmeU8qWnpqy2bri2CTFcMz/bXEYfOwj6HqCXEP9Tlnc?=
 =?us-ascii?Q?eENZkMOVchD75vTeOL05mfJJmOi3HCy1V3wzHGQ9UqcPX6oCqkiTpzVQ474l?=
 =?us-ascii?Q?EnT3rlONNEw1+OI6SRJhHyduHqnARtQOZOkDrpcG4/RJHumLKfRKQlGKETqQ?=
 =?us-ascii?Q?MUCq4yBxKvjjPR1dKuNSnC9w2lqpIFNa6c4JQ8Rew294GaJdYsbtq4fJ6J/V?=
 =?us-ascii?Q?9t1dsYkKnQrKWBWu31qDn8zoDLGH80T0pbELPtTJHcwwN+ibvyyrjbjzIK6U?=
 =?us-ascii?Q?QaNaqUWyvmxkJKI/wwFHOFHZVaaOLCc0FnMgpe6t?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcf14ee-9589-49c3-8176-08dbde90cf94
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 06:22:54.3409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5jytfxoJUoM7Z2Xz9fUVZmBzMe09zGmkgE7Ktl+gVqH/BsmkSAkjLInyEH2j5iWUNnbweO5F7N+lHF7Fyw/KWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5382
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   77fa2fbe87fc605c4bfa87dff87be9bfded0e9a3
commit: 6c94875799eaf99bfdbb0efce21d75e1c56e96d5 vmw_balloon: simplifying batch access
date:   5 years ago
config: x86_64-randconfig-103-20230827 (https://download.01.org/0day-ci/archive/20231106/202311061016.YX1N3JbG-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311061016.YX1N3JbG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202311061016.YX1N3JbG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/misc/vmw_balloon.c:28:
   include/linux/vmw_vmci_defs.h:159:33: warning: 'VMCI_ANON_SRC_HANDLE' defined but not used [-Wunused-const-variable=]
     159 | static const struct vmci_handle VMCI_ANON_SRC_HANDLE = {
         |                                 ^~~~~~~~~~~~~~~~~~~~
>> drivers/misc/vmw_balloon.c:200: warning: Function parameter or member '5' not described in 'vmballoon_batch_entry'
   drivers/misc/vmw_balloon.o: warning: objtool: vmballoon_deflate()+0x1ca: sibling call from callable instruction with modified stack frame
   drivers/misc/vmw_balloon.o: warning: objtool: vmballoon_debug_show()+0x73: sibling call from callable instruction with modified stack frame
   drivers/misc/vmw_balloon.o: warning: objtool: vmballoon_inflate()+0xa1: sibling call from callable instruction with modified stack frame
   drivers/misc/vmw_balloon.o: warning: objtool: vmballoon_work()+0x84: sibling call from callable instruction with modified stack frame


vim +200 drivers/misc/vmw_balloon.c

365bd7ef7ec8eb Philip P. Moltmann 2015-08-06  188  
6c94875799eaf9 Nadav Amit         2018-09-20  189  /**
6c94875799eaf9 Nadav Amit         2018-09-20  190   * struct vmballoon_batch_entry - a batch entry for lock or unlock.
6c94875799eaf9 Nadav Amit         2018-09-20  191   *
6c94875799eaf9 Nadav Amit         2018-09-20  192   * @status: the status of the operation, which is written by the hypervisor.
6c94875799eaf9 Nadav Amit         2018-09-20  193   * @reserved: reserved for future use. Must be set to zero.
6c94875799eaf9 Nadav Amit         2018-09-20  194   * @pfn: the physical frame number of the page to be locked or unlocked.
6c94875799eaf9 Nadav Amit         2018-09-20  195   */
6c94875799eaf9 Nadav Amit         2018-09-20  196  struct vmballoon_batch_entry {
6c94875799eaf9 Nadav Amit         2018-09-20  197  	u64 status : 5;
6c94875799eaf9 Nadav Amit         2018-09-20  198  	u64 reserved : PAGE_SHIFT - 5;
6c94875799eaf9 Nadav Amit         2018-09-20  199  	u64 pfn : 52;
6c94875799eaf9 Nadav Amit         2018-09-20 @200  } __packed;
6c94875799eaf9 Nadav Amit         2018-09-20  201  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

