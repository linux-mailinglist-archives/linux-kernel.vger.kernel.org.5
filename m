Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010557E8ED7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 07:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjKLGiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 01:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLGiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 01:38:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D876F30D6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 22:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699771092; x=1731307092;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8PdKGTvs/jezUOi4sgQ+dWSCFBcg5AZyU8ZvSfVvTjo=;
  b=kJ7//CMqnsMphnEkdawglj3vRnXX9oSKWp6HsHm0fmEXGrw6QEOnhuNs
   95G/UWohTtVQiE3LeyZ3nvJO42L5tJfYOED1E00RBPGC6OhD83hi2Gjn6
   SuaZLtsaG6ZNp2mStbtEZd1naOuK/MTYJKg2ZOUYXiWO+3Ud8nzuKLem+
   MgRkn5X6Yu+Yd3oeueTjrsIZ8BfA9nzbKsuXiiM8ANLqILIz+d9+V/Ma6
   +oUv5wqWB4c4Cdr1u84e2J3NVoefDEE6dZOQYB99XgXVPb2effc8vfemJ
   vwSfTCLvKi0IHIix0NpHyNe1/OzLjQN/Vo1jFM0GIEQNRA/Ecmf0FMwYh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="421411231"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="421411231"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 22:38:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="11793114"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Nov 2023 22:38:12 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 11 Nov 2023 22:38:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sat, 11 Nov 2023 22:38:11 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sat, 11 Nov 2023 22:38:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwEvQ1uXXqo0uwUQEaHwZOVecHeqxyze1cTJPp+OLTZ0OC6safAMEiApVgXkNogRMz9NWVzafDBneVWmTvrIbN6+n9mW1sZYma1LrfPBTxcjgmXdPP358KDGcJp0GO2+BkWJ54exg6w6G+tD04ZbJ95mKO9HzxXs9Zx6I+vCZs5N31DWG+v398ZBx7soXW6l9RVVEkmTbknplpt+BOoFgxqSCZqQ97aHTCPZVx4DROVmbYUx7yMTkX8UNIzfQw1CLl8Iot5rZDxX7EM1pQGHLcO8YL3oq00tQJlj8WIZWF4WlOLZMbyxRIIxF34Y7xsstGm3b8SoMVagmUJaLEsBxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LsY2/qIVsd2cKz3M1Guo9xGsBBfTnJErhg7LcxR7Co=;
 b=mUjPdFnwF54Wk3mJPI57izqVIwMYVDp7h4HCz0pFjsze2/WSzl7UT6DOVCsXcSkSltp4wHqnWRVSSVFigefCSgRvx8aX/RvL87T+EQx1sbxNy7r5lNmLLtJE+bz/3cz3akH0emdNsjtT0n4Hk9c4KrsARJvYf1ejBuj+UOyp9zydYIrtOrc9i7WKPlq2DVNIRfdhjobLkjAhANerCRvASO8R2UajMxgTzCCLJ66TXBpDnLj6+ixjnwNWsdxnE7Suvj+fsd/CUzg7ma00wo9nHwAWV2aQO5V2I1Ax+GYD0FSjXFa/EBHCIog5MEDXWWIxORyaJZeilH+9Mc164uZAOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by CY8PR11MB7339.namprd11.prod.outlook.com (2603:10b6:930:9f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Sun, 12 Nov
 2023 06:38:08 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67%5]) with mapi id 15.20.6977.028; Sun, 12 Nov 2023
 06:38:08 +0000
Date:   Sun, 12 Nov 2023 14:37:53 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
CC:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: fs/file.c:351:17: sparse: sparse: incompatible types in
 comparison expression (different address spaces):
Message-ID: <ZVBywdgseRe5mP1V@rli9-mobl>
References: <202311120246.W8nrgLDN-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202311120246.W8nrgLDN-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|CY8PR11MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: 28275795-5c18-45fc-3810-08dbe349ee5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 19zlm8JQsVUgfQUal4l869lZwwS1l3Y/SmX2gjW/jrbagWJrXw7Ft4grQKuh1WYOD4s0P40VyokCC4g03/uhMS1Dt+tV3ADa9VmR4swLCsCaaWm9nfWaRYSH9Q1g6oSw8c82IADTQW/YUi2TvTvt7F8N44kt/Apa12pxqc+yOuK4RmKbHmmg8mFSDBJnE3LiAHmmMHevlto4uWil2EmON3gWRs1DkZt9am0cD9gaWIYl9ne18GGQBb6ZRD0RqJ3L62WzyiIZ6ie/r4dCKt2D41v/VJ8tl+0VXan+cUVKYyo8k3AXFFQdYDiUX/i5lBR77h9P1SLxk3JjiHVPTpHXksZwBabY6yKyvYrzY22hXcXz3FN5Yf2P6bIdQpvsU0MSpF59cNYTXxcTJxdXxzL5UGQY4P5i8gAgvvJTjmQzLjYJLBnnXh5j07LXFV/dVG+DqbCk85nn8mP7fwQd+GfXD2sGq9zKkChDn6oX3YKuf7yUPA54A8lHvknKjnfCM7r4QtZcaK27i4K5GiE6tPT/pO0t+2pe0ahbByfpGh3PyzOKh2545fyi/L+DqIcce4Nt4BUxj/na+B/nYqXDiQZZNyJ4ZM4L8J6jqmMf0SsPfWlgp8uEHYBOf7nf49qGf8vuaR4DnQXjuGOyMd63G7ncfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(366004)(376002)(346002)(396003)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(186009)(1800799009)(26005)(6506007)(33716001)(6666004)(6512007)(9686003)(83380400001)(44832011)(5660300002)(4326008)(6862004)(8936002)(8676002)(41300700001)(30864003)(2906002)(4001150100001)(966005)(6486002)(478600001)(316002)(6636002)(54906003)(66476007)(66556008)(66946007)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KbJ2w477IvUpmHhBmbRDep+IXrEdIXWx/9P15WdZXg8rQmJbp7vLBTtMQ6aL?=
 =?us-ascii?Q?n/Bz9eld1LeZxmjFn2GVpIDCVSPux3lW7Vys/w5rff1TcMHXVkj7YtlRB1//?=
 =?us-ascii?Q?3PDgocnhH6gj7MStNKWkbBVE+XUiQvd3FwIY2nw3BQigoo18KH0iMr8CaQ4a?=
 =?us-ascii?Q?+ES2NrscAIH8RzkM2RFbN42lH4/6fnsg2ZZ7+z+lR/dp8Cn9vLp2zeq5mpLP?=
 =?us-ascii?Q?IUqUp/29s4knPuT9gocF2Uaw2iQ0ChTsYD/lA3HhgQaSd67j2LRmBgGN2b9U?=
 =?us-ascii?Q?R/3xrA2qIkmzi1heMyHdYNqwP9orc4Gcp+d9z2YbsDM/A+F0Kk9z9h/XbOkZ?=
 =?us-ascii?Q?yxCkQ+odirJTIZ87krrZDWBthflp1Z+9Xz7Nhhsf4/FXRDcnGn2ARo0dpezM?=
 =?us-ascii?Q?FSs6typHskYz9xsMeJd+x4LSwtOQwQp84R1D1UJAX7WDUctPkMCQtv3dnvHW?=
 =?us-ascii?Q?bB2HlbZ60CRCjtuTLZERLHxuC2JMB83LqeBYHEtEb3Zl1QVP2HnmjhZsz91a?=
 =?us-ascii?Q?MgkhMTEyYJPVCXr+DamW+R25f1c/LKMf2RCVneGehz/+2MKCbvQbOxY/xRaV?=
 =?us-ascii?Q?9uEPM0k32OIsgR8SDnFM9i5IWtVdMohME0cxbYcdB6t5Glx2CvdP5k4mJe+F?=
 =?us-ascii?Q?rNduLwd3yrYGvizkTrU0CNqhllIqF51TeVI5RKnTFZacnu6lRTWRh9fpMhAQ?=
 =?us-ascii?Q?lXQtZ+CDQ6CsrC0FXQ7rva7IN2qpYH80CBixIugrQYn+j5Y97EqhP/x19rRr?=
 =?us-ascii?Q?yM+gsUgSDSTpfGjBybe9k85I3GZfF5dOS4tEiVNEJm1WPkGV2SH3O2OsBqCM?=
 =?us-ascii?Q?oUipQZaeX2KFNECYMMyvmBhPmshjpTYUhlSLvO3my7C+7aZTnM4+UkvFL7pG?=
 =?us-ascii?Q?NYtssinVdoqzWKOpTaPGxH2/8sh9HuVVqt8XgTKMKovXNjjtprX3qY2nW8/j?=
 =?us-ascii?Q?hEbjN+Fts7Ku0MIpV77ANArMJL2J1L4aF5Y1tMR7QL/M+728agO6Um0rSoiZ?=
 =?us-ascii?Q?+7tvOMaJcDpqCp3Cf/PiILeaO/n/Ngz5nz5/CAfExUuQhJ09nsRV9c3cGy5z?=
 =?us-ascii?Q?cq5JGiSp1l6LsyGKwMX0pJ6hT+uRdwiz7DIEMF9QjPg4EelhfDz60D6382ip?=
 =?us-ascii?Q?JCamTusaA5Co/HzIiloR7WYXu9IdR+dzRq8gh7o1iUJxxT2hwqhBcam6rL5C?=
 =?us-ascii?Q?HZx/RdWhZw7YMqvLIn7T+YOV2Qguq8dS1nHaRkS+Z7cpbAIUV6zinAoG5ykw?=
 =?us-ascii?Q?nlccV2z3eoPxFbUZDRCj/EKwLnZrikqsnTrTMjE04dheo89ybQW8SiXwR83W?=
 =?us-ascii?Q?XGn5gT7JV2HZ+EhzlCl3xvX/9Y9t1rw9hryAJvjkTlsPc/Y32f+NwM+hw9iC?=
 =?us-ascii?Q?Tej3FP2fbb2ezPNU0iU1OzCPW0I7kiJhy/sg4L5jsDJ7smrk/GZKWFebbI9H?=
 =?us-ascii?Q?UKvCU1rw1DTbre/NCeCpKNT/HrmNDc5wNans0Tlv9jPNSSWRfuDUGxFsbtWM?=
 =?us-ascii?Q?wZMwuqiaRrbFJEvzvmZkHX/F2JgX7U+x0Cgof4lL+caYA4smYl0ferh/sB1C?=
 =?us-ascii?Q?sojxnh+W7RRLiRDOV7kNU9zUEiwLhbZZvIDHUO5q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28275795-5c18-45fc-3810-08dbe349ee5c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2023 06:38:07.7054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7nlHOYKcMAcPsxXPgtOCcqKdoACrOB+l0oMY4ei73IFTg2ElTKaFQArrpE9SjOEn+UePnr++Gs25xkl89Ac49g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7339
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2023 at 03:19:54AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3ca112b71f35dd5d99fc4571a56b5fc6f0c15814
> commit: 423a86a610cad121742ebe698ef98a3b4c87b5dd rcu: Add sparse check to rcu_assign_pointer()
> date:   4 years, 10 months ago
> config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20231112/202311120246.W8nrgLDN-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231112/202311120246.W8nrgLDN-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311120246.W8nrgLDN-lkp@intel.com/

Hi Joel, kindly ignore this report, which is not the cause of original issue.
Sorry for false positive.

> 
> sparse warnings: (new ones prefixed by >>)
>    fs/file.c:335:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file **old_fds @@     got struct file [noderef] <asn:4> **fd @@
>    fs/file.c:335:17: sparse:     expected struct file **old_fds
>    fs/file.c:335:17: sparse:     got struct file [noderef] <asn:4> **fd
>    fs/file.c:336:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file **new_fds @@     got struct file [noderef] <asn:4> **fd @@
>    fs/file.c:336:17: sparse:     expected struct file **new_fds
>    fs/file.c:336:17: sparse:     got struct file [noderef] <asn:4> **fd
> >> fs/file.c:351:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    fs/file.c:351:17: sparse:    struct file [noderef] <asn:4> *
> >> fs/file.c:351:17: sparse:    struct file *
>    fs/file.c:386:54: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct file *file @@     got struct file [noderef] <asn:4> *[assigned] __ret @@
>    fs/file.c:386:54: sparse:     expected struct file *file
>    fs/file.c:386:54: sparse:     got struct file [noderef] <asn:4> *[assigned] __ret
>    fs/file.c:451:28: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fdtable [noderef] <asn:4> *fdt @@     got struct fdtable * @@
>    fs/file.c:451:28: sparse:     expected struct fdtable [noderef] <asn:4> *fdt
>    fs/file.c:451:28: sparse:     got struct fdtable *
>    fs/file.c:629:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] <asn:4> * @@
>    fs/file.c:629:14: sparse:     expected struct file *file
>    fs/file.c:629:14: sparse:     got struct file [noderef] <asn:4> *
>    fs/file.c:656:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] <asn:4> * @@
>    fs/file.c:656:14: sparse:     expected struct file *file
>    fs/file.c:656:14: sparse:     got struct file [noderef] <asn:4> *
>    fs/file.c:693:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] <asn:4> * @@
>    fs/file.c:693:30: sparse:     expected struct file *file
>    fs/file.c:693:30: sparse:     got struct file [noderef] <asn:4> *
>    fs/file.c:859:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *tofree @@     got struct file [noderef] <asn:4> * @@
>    fs/file.c:859:16: sparse:     expected struct file *tofree
>    fs/file.c:859:16: sparse:     got struct file [noderef] <asn:4> *
> --
>    kernel/notifier.c:27:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
>    kernel/notifier.c:27:20: sparse:     expected struct notifier_block **nl
>    kernel/notifier.c:27:20: sparse:     got struct notifier_block [noderef] <asn:4> **
>    kernel/notifier.c:29:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct notifier_block [noderef] <asn:4> *next @@     got struct notifier_block * @@
>    kernel/notifier.c:29:17: sparse:     expected struct notifier_block [noderef] <asn:4> *next
>    kernel/notifier.c:29:17: sparse:     got struct notifier_block *
> >> kernel/notifier.c:30:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    kernel/notifier.c:30:9: sparse:    struct notifier_block [noderef] <asn:4> *
> >> kernel/notifier.c:30:9: sparse:    struct notifier_block *
>    kernel/notifier.c:42:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
>    kernel/notifier.c:42:20: sparse:     expected struct notifier_block **nl
>    kernel/notifier.c:42:20: sparse:     got struct notifier_block [noderef] <asn:4> **
>    kernel/notifier.c:44:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct notifier_block [noderef] <asn:4> *next @@     got struct notifier_block * @@
>    kernel/notifier.c:44:17: sparse:     expected struct notifier_block [noderef] <asn:4> *next
>    kernel/notifier.c:44:17: sparse:     got struct notifier_block *
>    kernel/notifier.c:45:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    kernel/notifier.c:45:9: sparse:    struct notifier_block [noderef] <asn:4> *
>    kernel/notifier.c:45:9: sparse:    struct notifier_block *
>    kernel/notifier.c:54:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    kernel/notifier.c:54:25: sparse:    struct notifier_block [noderef] <asn:4> *
>    kernel/notifier.c:54:25: sparse:    struct notifier_block *
>    kernel/notifier.c:128:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
>    kernel/notifier.c:150:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
>    kernel/notifier.c:183:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
>    kernel/notifier.c:224:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
>    kernel/notifier.c:227:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
>    kernel/notifier.c:250:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
>    kernel/notifier.c:277:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
>    kernel/notifier.c:280:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
>    kernel/notifier.c:317:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
>    kernel/notifier.c:350:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
>    kernel/notifier.c:367:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
>    kernel/notifier.c:394:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
>    kernel/notifier.c:432:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
>    kernel/notifier.c:435:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
>    kernel/notifier.c:462:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
>    kernel/notifier.c:465:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
>    kernel/notifier.c:498:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct notifier_block **nl @@     got struct notifier_block [noderef] <asn:4> ** @@
> --
>    lib/rbtree.c: note: in included file:
> >> include/linux/rbtree_augmented.h:153:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    include/linux/rbtree_augmented.h:153:25: sparse:    struct rb_node [noderef] <asn:4> *
> >> include/linux/rbtree_augmented.h:153:25: sparse:    struct rb_node *
>    include/linux/rbtree_augmented.h:155:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    include/linux/rbtree_augmented.h:155:25: sparse:    struct rb_node [noderef] <asn:4> *
>    include/linux/rbtree_augmented.h:155:25: sparse:    struct rb_node *
>    include/linux/rbtree_augmented.h:157:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    include/linux/rbtree_augmented.h:157:17: sparse:    struct rb_node [noderef] <asn:4> *
>    include/linux/rbtree_augmented.h:157:17: sparse:    struct rb_node *
> 
> vim +351 fs/file.c
> 
> 02afc6267f6d55 Al Viro         2008-05-08  266  
> 02afc6267f6d55 Al Viro         2008-05-08  267  /*
> 02afc6267f6d55 Al Viro         2008-05-08  268   * Allocate a new files structure and copy contents from the
> 02afc6267f6d55 Al Viro         2008-05-08  269   * passed in files structure.
> 02afc6267f6d55 Al Viro         2008-05-08  270   * errorp will be valid only when the returned files_struct is NULL.
> 02afc6267f6d55 Al Viro         2008-05-08  271   */
> 02afc6267f6d55 Al Viro         2008-05-08  272  struct files_struct *dup_fd(struct files_struct *oldf, int *errorp)
> 02afc6267f6d55 Al Viro         2008-05-08  273  {
> 02afc6267f6d55 Al Viro         2008-05-08  274  	struct files_struct *newf;
> 02afc6267f6d55 Al Viro         2008-05-08  275  	struct file **old_fds, **new_fds;
> 9b80a184eaadc1 Alexey Dobriyan 2016-09-02  276  	unsigned int open_files, i;
> 02afc6267f6d55 Al Viro         2008-05-08  277  	struct fdtable *old_fdt, *new_fdt;
> 02afc6267f6d55 Al Viro         2008-05-08  278  
> 02afc6267f6d55 Al Viro         2008-05-08  279  	*errorp = -ENOMEM;
> afbec7fff4928c Al Viro         2008-05-08  280  	newf = kmem_cache_alloc(files_cachep, GFP_KERNEL);
> 02afc6267f6d55 Al Viro         2008-05-08  281  	if (!newf)
> 02afc6267f6d55 Al Viro         2008-05-08  282  		goto out;
> 02afc6267f6d55 Al Viro         2008-05-08  283  
> afbec7fff4928c Al Viro         2008-05-08  284  	atomic_set(&newf->count, 1);
> afbec7fff4928c Al Viro         2008-05-08  285  
> afbec7fff4928c Al Viro         2008-05-08  286  	spin_lock_init(&newf->file_lock);
> 8a81252b774b53 Eric Dumazet    2015-06-30  287  	newf->resize_in_progress = false;
> 8a81252b774b53 Eric Dumazet    2015-06-30  288  	init_waitqueue_head(&newf->resize_wait);
> afbec7fff4928c Al Viro         2008-05-08  289  	newf->next_fd = 0;
> afbec7fff4928c Al Viro         2008-05-08  290  	new_fdt = &newf->fdtab;
> afbec7fff4928c Al Viro         2008-05-08  291  	new_fdt->max_fds = NR_OPEN_DEFAULT;
> 1fd36adcd98c14 David Howells   2012-02-16  292  	new_fdt->close_on_exec = newf->close_on_exec_init;
> 1fd36adcd98c14 David Howells   2012-02-16  293  	new_fdt->open_fds = newf->open_fds_init;
> f3f86e33dc3da4 Linus Torvalds  2015-10-30  294  	new_fdt->full_fds_bits = newf->full_fds_bits_init;
> afbec7fff4928c Al Viro         2008-05-08  295  	new_fdt->fd = &newf->fd_array[0];
> afbec7fff4928c Al Viro         2008-05-08  296  
> 02afc6267f6d55 Al Viro         2008-05-08  297  	spin_lock(&oldf->file_lock);
> 02afc6267f6d55 Al Viro         2008-05-08  298  	old_fdt = files_fdtable(oldf);
> 02afc6267f6d55 Al Viro         2008-05-08  299  	open_files = count_open_files(old_fdt);
> 02afc6267f6d55 Al Viro         2008-05-08  300  
> 02afc6267f6d55 Al Viro         2008-05-08  301  	/*
> 02afc6267f6d55 Al Viro         2008-05-08  302  	 * Check whether we need to allocate a larger fd array and fd set.
> 02afc6267f6d55 Al Viro         2008-05-08  303  	 */
> adbecb128cd2cc Al Viro         2008-05-08  304  	while (unlikely(open_files > new_fdt->max_fds)) {
> 02afc6267f6d55 Al Viro         2008-05-08  305  		spin_unlock(&oldf->file_lock);
> 9dec3c4d306b09 Al Viro         2008-05-08  306  
> a892e2d7dcdfa6 Changli Gao     2010-08-10  307  		if (new_fdt != &newf->fdtab)
> a892e2d7dcdfa6 Changli Gao     2010-08-10  308  			__free_fdtable(new_fdt);
> adbecb128cd2cc Al Viro         2008-05-08  309  
> 9dec3c4d306b09 Al Viro         2008-05-08  310  		new_fdt = alloc_fdtable(open_files - 1);
> 9dec3c4d306b09 Al Viro         2008-05-08  311  		if (!new_fdt) {
> 9dec3c4d306b09 Al Viro         2008-05-08  312  			*errorp = -ENOMEM;
> 02afc6267f6d55 Al Viro         2008-05-08  313  			goto out_release;
> 9dec3c4d306b09 Al Viro         2008-05-08  314  		}
> 9dec3c4d306b09 Al Viro         2008-05-08  315  
> 9dec3c4d306b09 Al Viro         2008-05-08  316  		/* beyond sysctl_nr_open; nothing to do */
> 9dec3c4d306b09 Al Viro         2008-05-08  317  		if (unlikely(new_fdt->max_fds < open_files)) {
> a892e2d7dcdfa6 Changli Gao     2010-08-10  318  			__free_fdtable(new_fdt);
> 9dec3c4d306b09 Al Viro         2008-05-08  319  			*errorp = -EMFILE;
> 9dec3c4d306b09 Al Viro         2008-05-08  320  			goto out_release;
> 9dec3c4d306b09 Al Viro         2008-05-08  321  		}
> 9dec3c4d306b09 Al Viro         2008-05-08  322  
> 02afc6267f6d55 Al Viro         2008-05-08  323  		/*
> 02afc6267f6d55 Al Viro         2008-05-08  324  		 * Reacquire the oldf lock and a pointer to its fd table
> 02afc6267f6d55 Al Viro         2008-05-08  325  		 * who knows it may have a new bigger fd table. We need
> 02afc6267f6d55 Al Viro         2008-05-08  326  		 * the latest pointer.
> 02afc6267f6d55 Al Viro         2008-05-08  327  		 */
> 02afc6267f6d55 Al Viro         2008-05-08  328  		spin_lock(&oldf->file_lock);
> 02afc6267f6d55 Al Viro         2008-05-08  329  		old_fdt = files_fdtable(oldf);
> adbecb128cd2cc Al Viro         2008-05-08  330  		open_files = count_open_files(old_fdt);
> 02afc6267f6d55 Al Viro         2008-05-08  331  	}
> 02afc6267f6d55 Al Viro         2008-05-08  332  
> ea5c58e70c3a14 Eric Biggers    2015-11-06  333  	copy_fd_bitmaps(new_fdt, old_fdt, open_files);
> ea5c58e70c3a14 Eric Biggers    2015-11-06  334  
> 02afc6267f6d55 Al Viro         2008-05-08  335  	old_fds = old_fdt->fd;
> 02afc6267f6d55 Al Viro         2008-05-08  336  	new_fds = new_fdt->fd;
> 02afc6267f6d55 Al Viro         2008-05-08  337  
> 02afc6267f6d55 Al Viro         2008-05-08  338  	for (i = open_files; i != 0; i--) {
> 02afc6267f6d55 Al Viro         2008-05-08  339  		struct file *f = *old_fds++;
> 02afc6267f6d55 Al Viro         2008-05-08  340  		if (f) {
> 02afc6267f6d55 Al Viro         2008-05-08  341  			get_file(f);
> 02afc6267f6d55 Al Viro         2008-05-08  342  		} else {
> 02afc6267f6d55 Al Viro         2008-05-08  343  			/*
> 02afc6267f6d55 Al Viro         2008-05-08  344  			 * The fd may be claimed in the fd bitmap but not yet
> 02afc6267f6d55 Al Viro         2008-05-08  345  			 * instantiated in the files array if a sibling thread
> 02afc6267f6d55 Al Viro         2008-05-08  346  			 * is partway through open().  So make sure that this
> 02afc6267f6d55 Al Viro         2008-05-08  347  			 * fd is available to the new process.
> 02afc6267f6d55 Al Viro         2008-05-08  348  			 */
> 1dce27c5aa6770 David Howells   2012-02-16  349  			__clear_open_fd(open_files - i, new_fdt);
> 02afc6267f6d55 Al Viro         2008-05-08  350  		}
> 02afc6267f6d55 Al Viro         2008-05-08 @351  		rcu_assign_pointer(*new_fds++, f);
> 02afc6267f6d55 Al Viro         2008-05-08  352  	}
> 02afc6267f6d55 Al Viro         2008-05-08  353  	spin_unlock(&oldf->file_lock);
> 02afc6267f6d55 Al Viro         2008-05-08  354  
> ea5c58e70c3a14 Eric Biggers    2015-11-06  355  	/* clear the remainder */
> ea5c58e70c3a14 Eric Biggers    2015-11-06  356  	memset(new_fds, 0, (new_fdt->max_fds - open_files) * sizeof(struct file *));
> 02afc6267f6d55 Al Viro         2008-05-08  357  
> afbec7fff4928c Al Viro         2008-05-08  358  	rcu_assign_pointer(newf->fdt, new_fdt);
> afbec7fff4928c Al Viro         2008-05-08  359  
> 02afc6267f6d55 Al Viro         2008-05-08  360  	return newf;
> 02afc6267f6d55 Al Viro         2008-05-08  361  
> 02afc6267f6d55 Al Viro         2008-05-08  362  out_release:
> 02afc6267f6d55 Al Viro         2008-05-08  363  	kmem_cache_free(files_cachep, newf);
> 02afc6267f6d55 Al Viro         2008-05-08  364  out:
> 02afc6267f6d55 Al Viro         2008-05-08  365  	return NULL;
> 02afc6267f6d55 Al Viro         2008-05-08  366  }
> 02afc6267f6d55 Al Viro         2008-05-08  367  
> 
> :::::: The code at line 351 was first introduced by commit
> :::::: 02afc6267f6d55d47aba9fcafdbd1b7230d2294a [PATCH] dup_fd() fixes, part 1
> 
> :::::: TO: Al Viro <viro@zeniv.linux.org.uk>
> :::::: CC: Al Viro <viro@zeniv.linux.org.uk>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
