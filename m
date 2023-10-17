Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC447CBDDF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjJQIiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbjJQIiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:38:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4DBF2;
        Tue, 17 Oct 2023 01:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697531888; x=1729067888;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=oPG0mAv9RnMxiBM9II5Kt+jutepxKiqmHxcrPo829tc=;
  b=X3sd8g6zuk242S0Qi6uS4gmaP57DEJUj4WDOuLtF4aS3GZBRwp+SREet
   x7EsOvjZr9EDwEemwBVM98CZWvgrcXyU28+wK9t56sEJNWj9MSCQG2NfI
   bRQ1nXPpBbLNPb0c7oiUUd1EoEEgE3C6q9RBd5l7JdX9nYb5vrPCaF8YL
   kofD3/gLP3+aVo7Y3pQ8S3jY10Vasho25/cX3LMpbSqYUP67i+noMT/wj
   CHKsxUHLRTwmKhEArSEl1hkFcBaGSO3rQXK/GveZG2W1UE7Y/Cu5IbM4F
   kexotnIR9tEIpJEPiyIo48g5blHdc56o8wcreapq1frLYsQ+Tg3qsA1LR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="4334892"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="4334892"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 01:38:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="872469176"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="872469176"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 01:38:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 01:38:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 01:38:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 01:38:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeiJP2r6jCqwEJWoAwRF4XT/83lXYHH7qfW2bBy7uVpU3BIJOucbGyWvrlwY2aDHuAQq1GNjQrBljKlhOIcqXn0nACLdjZCQP/Fq7DzpOvt+6kWliVQ7RQfC8nosZEdkbt3EEBaZticsZVQNlMAEa+hAP+rTEcE4t9dwjaVd3cNKfR8Q86JcvsFbmmUxAjqwGncVYWQnXnZ5n2NsidDKA11GRqxjMCu3ZBLeO2CE5yxIJc6syQe6g4Q+Gqo4DjdGBnBz7qpA239z/t2vXsrdFhqNH5XK8noNTcz6SIeNOaU3ql4A1O/V5nOVzahf2nhdvOEZ0BnRsHntX6W+IdpfHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtkH6L5zmgXxMf6Caoi5NdIeOc8GA+Yc/ZXdrUW8EWE=;
 b=lTngFFP0zylBA7jlwvr8o/gTCNER6H3HRrYslC/gOqpg3LD4fPcnNN5vkMwZN4zfEDWxfcpUPHjayDBwQpsIadWg0nNPCx41s/hUEET/L2tvvkGsDuUtl9OX1SSd3/rLoFnxGcOsi6IISxwi7UaY1APLz05DJjhn9kAcEU7aEs8Wj9tNXsovaa2lSPD5S3b1+kOIGxAuADF/P2Md2//js9UfV2GHM/6+SL8ROgWm96xZ23BebprTRFhecPq01GjXAaof/uC/4zGPIetBn9+srHSBbv9YzU/0BxM1rPjeVGonBa1Pu4qGwj9TmDkNp2CmEbc6Dm2xhgQJHiyWcivcuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by IA0PR11MB7791.namprd11.prod.outlook.com (2603:10b6:208:401::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 08:37:57 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17%5]) with mapi id 15.20.6863.046; Tue, 17 Oct 2023
 08:37:57 +0000
Date:   Tue, 17 Oct 2023 16:37:43 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Dmitry Safonov <dima@arista.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Salam Noureddine <noureddine@arista.com>,
        David Ahern <dsahern@kernel.org>, <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, Dmitry Safonov <dima@arista.com>,
        "Andy Lutomirski" <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Bob Gilligan" <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        "David Laight" <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Donald Cassidy <dcassidy@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        "Gaillardetz, Dominik" <dgaillar@ciena.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        "Leonard Crestez" <cdleonard@gmail.com>,
        "Nassiri, Mohammad" <mnassiri@ciena.com>,
        Simon Horman <simon.horman@corigine.com>,
        "Tetreault, Francois" <ftetreau@ciena.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v14 net-next 08/23] net/tcp: Add AO sign to RST packets
Message-ID: <202310171606.30e15ebe-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231009230722.76268-9-dima@arista.com>
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|IA0PR11MB7791:EE_
X-MS-Office365-Filtering-Correlation-Id: fdc45323-ad18-40af-caa2-08dbceec5c79
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GMV/db2YflK47EI+ZavwehBPLZgT2SuThRzHOd2PR1a13+ceu/fo8OmozhlUFNEPbdPrYLazcB9PCRYratt1OKE4IbQ+iyYjX+mysltDnkfWTHzuWZjMR6iFJze0pfpNbv4Onhs33if3G6hkqsIsMCiHhaCkAqJYkywgy6j6/th96pczgGSfMswnlS2RI74A8MbmCShtRdw8Js0DEHSiU7U4dvbyKCQ1ArkvZeNKt3QQ5+ZcqxseweCnMGa3e1AzfQOXsaBctiqGjU2TnHha1Wf/1096nwU146paNiCTsxFFEF7qPHuoRB6bMargHUR5q+Ekd2T2LxYjhgovS/rAg9hT+VtSROuWVcH95oDqtJd157JH4Fn1VilD0JfhJaIBkuUe7Z6k+xOL4Jm4SG5W2wEwqoPvQzpdSIdLBKdP8CyVZIf6AKPqDDcOfO0Ne6QONM/Y5PRrQquIEL2+EBaWgRyoBropiui7leiq5E09WZiGZEcWvx+gAnDwQpSfAY14Etb8WeFlb7cYJiD9jsLYvKG7x06TBhRU8Zh6/0pKi0nxpvjXuFsXibE1mF3I3bgvvmc46jC/Yz0MW34PxfHyKY/05t4UHVlal0yV89ieQd5kSJS8irr2dLKqLvWN4/9fc6l9W9ifBD0boGxFSCG68A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(36756003)(86362001)(26005)(45080400002)(478600001)(2906002)(6486002)(6666004)(6506007)(41300700001)(5660300002)(966005)(82960400001)(38100700002)(2616005)(107886003)(1076003)(6916009)(8936002)(54906003)(66556008)(66946007)(66476007)(316002)(4326008)(8676002)(83380400001)(6512007)(30864003)(7416002)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?etHpyq7UVOEqecL3bA+mT407up8PL1JvXHWC8Fq5QtrjCFIDrFNceaTDNLL9?=
 =?us-ascii?Q?3rxWmTdpDm7TCDix+mMg6mw6cE6DvNAhEijRm6G3psiZhkiqsp87GpI+D74m?=
 =?us-ascii?Q?XaH4j4pptXEYdLyt88rzQxViuw9pLQrYmqmi4jk1uOtBP1I2qB9C5OBVyShI?=
 =?us-ascii?Q?KokrWgii/tGly6dDjAcy993hOwuaV/nw8GbOrjtzLz/p6gQIqxX296Q+qpEI?=
 =?us-ascii?Q?zPGDLc/7K0O4tSRm7Y3K98I9bUNnWuLq62MGCHVLIkEnRTIwN2UJJAL59PoX?=
 =?us-ascii?Q?Y0u9aokBKIGvjDOxYRMIJLS0KdYRlBk4CxqMiySPj82G0tB6pBA3ciMEvVxG?=
 =?us-ascii?Q?WLro6ijlb32NCe4ouLgSsILqdSszRyMs6SkfUTWMssdN0Dag7ba9nVv4wYmV?=
 =?us-ascii?Q?ymZLGERbRFhWd5zOwyksKFEqc0HN3WXDnovvIUeXr/rThBuiqO4qw0mho5TV?=
 =?us-ascii?Q?f2kQOUeVQH0Qx1y/XQ33bRZCO97FQ0CDZ3qRrTA0o3r6nTfJjDiU96nF7zit?=
 =?us-ascii?Q?iDxZYB+VGogDT2/t6nMCGi6RkJo3IXHUjYTqappb3n1XpC3BuSvPlleC3xYU?=
 =?us-ascii?Q?aTe6dMMg7tN4Rj4kbtcpCi7WuHv9H9zrVeIWqDvfGQX59ZJQWHJDKpFUZEsN?=
 =?us-ascii?Q?Q0tNsfe8YtnmpAaq6vOobXcYcn3E6CwJ5jhE9Iv3FsNwrYHhFgJAt2NZ5fnF?=
 =?us-ascii?Q?mD0zjvsnAQgng195m459GOxr/Gb9O/k3N0ddIW2KuqtZJE5YgaHbj4/0Urix?=
 =?us-ascii?Q?S7umDS9XRZjEFodMFyaTrtwPIWN4X0/75vTJ5A76fSDevBWKYc9veoNVHjCI?=
 =?us-ascii?Q?DNTOYnA3JrpqpxvmXXm3kIt6l0wOad/ynMKBZNWlnO+h7P8H8wSgAC7PoMBu?=
 =?us-ascii?Q?5R/DhqyBBAFulE0x2Fkr2Cn7kCgtKww8yofhew1wl03vOnXsCcT4mgj6B6+l?=
 =?us-ascii?Q?pDRGEHRIz7D9rvHf2NbAU3ELh7FGh1FtmTalz0C7hObjfVD8EHwUZhfEdSCK?=
 =?us-ascii?Q?tAbO05CKTSoTVqqZdeGiI7EmJNL1SzSY3BxM5spbF1NM+B5iMV25SEKIFrGd?=
 =?us-ascii?Q?gK2vlSU/f6GTnhVm4qjrQ4YPwntfQPrhTxYvwaG20y7C4GZcw8RPo9Y1teOJ?=
 =?us-ascii?Q?koJTtaN0wnw1TWkHhc1ewnT+ffKF1E+TfsJViGNNmr/Ok1NtUWrmFbp7it6D?=
 =?us-ascii?Q?CCrMyFGaPrVTHOkcr05e+bUralaA+6T8ixCQCfCwzciaVW7bvtuEAA6OCWMq?=
 =?us-ascii?Q?SywjXElDZvnk03rCEJp1l/vs0fN427cTZ/OMl6n2Mo5BSCbTESYBbWjT40pQ?=
 =?us-ascii?Q?TZ6hM4VbGfaDBZy/pU6dtF+8zIWnetr5o8Ynn2R7cYd2HJF4hXemCvgRlTht?=
 =?us-ascii?Q?ueLq7enimHJ3Kk/ubJ7DNfIaUaRCK8TN+HOdZplAPUqZKqvsNLZPqWd/Urr1?=
 =?us-ascii?Q?oeakYaBJSyYPa9UFhl1/uwJpwirjei0w4I2LxOstJP2XvDTTEvpzfJejU1ti?=
 =?us-ascii?Q?MP2wo3VpgtA4B6CKfNU2vscibVTR3qVQzKzSo44t3Q0fXlb77Jb9LXezKJOz?=
 =?us-ascii?Q?6b2prs1QEWoz10ohlN7jNdtWFZoeE9vPnmtonvCjtJso6NeHg/bJ54vBbn+O?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc45323-ad18-40af-caa2-08dbceec5c79
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 08:37:56.8724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAD+vWjB88Lvlfu212V9806NqE0ScvaQw+akmzUD96qwwes3cXJZAbUaQopppxlZ7H4cl0WDT+rKZ2bTZ0PgUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7791
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_net/core/sock.c" on:

commit: df13d11e6a2a3cc5f973aca36f68f880fa42d55f ("[PATCH v14 net-next 08/23] net/tcp: Add AO sign to RST packets")
url: https://github.com/intel-lab-lkp/linux/commits/Dmitry-Safonov/net-tcp-Prepare-tcp_md5sig_pool-for-TCP-AO/20231010-071412
patch link: https://lore.kernel.org/all/20231009230722.76268-9-dima@arista.com/
patch subject: [PATCH v14 net-next 08/23] net/tcp: Add AO sign to RST packets

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-02
	nr_groups: 5

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/


compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310171606.30e15ebe-oliver.sang@intel.com


[  221.348247][ T7133] BUG: sleeping function called from invalid context at net/core/sock.c:2978
[  221.349875][ T7133] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 7133, name: trinity-c4
[  221.351666][ T7133] preempt_count: 0, expected: 0
[  221.352614][ T7133] RCU nest depth: 1, expected: 0
[  221.353518][ T7133] 2 locks held by trinity-c4/7133:
[ 221.354530][ T7133] #0: ed8b5660 (sk_lock-AF_INET6){+.+.}-{0:0}, at: tcp_sendmsg (net/ipv4/tcp.c:1336) 
[ 221.374314][ T7133] #1: c27dbb18 (rcu_read_lock){....}-{1:2}, at: inet6_csk_xmit (include/linux/rcupdate.h:747 net/ipv6/inet6_connection_sock.c:129) 
[  221.375906][ T7133] CPU: 1 PID: 7133 Comm: trinity-c4 Tainted: G        W       TN 6.6.0-rc4-01105-gdf13d11e6a2a #1
[  221.377820][ T7133] Call Trace:
[ 221.378447][ T7133] dump_stack_lvl (lib/dump_stack.c:107) 
[ 221.379373][ T7133] dump_stack (lib/dump_stack.c:114) 
[ 221.380186][ T7133] __might_resched (kernel/sched/core.c:10188) 
[ 221.381100][ T7133] __release_sock (include/linux/sched.h:2097 net/core/sock.c:2978) 
[ 221.381960][ T7133] release_sock (net/core/sock.c:3520) 
[ 221.382784][ T7133] inet_wait_for_connect (net/ipv4/af_inet.c:609) 
[ 221.383763][ T7133] ? autoremove_wake_function (kernel/sched/wait.c:479) 
[ 221.384757][ T7133] __inet_stream_connect (net/ipv4/af_inet.c:701 (discriminator 1)) 
[ 221.385741][ T7133] ? kmalloc_node_trace (mm/slab_common.c:1133) 
[ 221.386702][ T7133] tcp_sendmsg_fastopen (net/ipv4/tcp.c:1026) 
[ 221.387685][ T7133] tcp_sendmsg_locked (net/ipv4/tcp.c:1073) 
[ 221.388642][ T7133] ? find_held_lock (kernel/locking/lockdep.c:5243) 
[ 221.389536][ T7133] ? mark_held_locks (kernel/locking/lockdep.c:4273) 
[ 221.390437][ T7133] ? lock_sock_nested (net/core/sock.c:3511) 
[ 221.391359][ T7133] ? lock_sock_nested (net/core/sock.c:3511) 
[ 221.392335][ T7133] tcp_sendmsg (net/ipv4/tcp.c:1336) 
[ 221.393153][ T7133] inet6_sendmsg (net/ipv6/af_inet6.c:658 (discriminator 2)) 
[ 221.394010][ T7133] ____sys_sendmsg (net/socket.c:730 net/socket.c:745 net/socket.c:2558) 
[ 221.394927][ T7133] ___sys_sendmsg (net/socket.c:2612) 
[ 221.395844][ T7133] __sys_sendmsg (net/socket.c:2641) 
[ 221.396671][ T7133] __ia32_sys_sendmsg (net/socket.c:2648) 
[ 221.397562][ T7133] __do_fast_syscall_32 (arch/x86/entry/common.c:112 arch/x86/entry/common.c:178) 
[ 221.398485][ T7133] do_fast_syscall_32 (arch/x86/entry/common.c:203) 
[ 221.399401][ T7133] do_SYSENTER_32 (arch/x86/entry/common.c:247) 
[ 221.404363][ T7133] entry_SYSENTER_32 (arch/x86/entry/entry_32.S:840) 
[  221.405255][ T7133] EIP: 0xb7f59579
[ 221.405931][ T7133] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
All code
========
   0:	b8 01 10 06 03       	mov    $0x3061001,%eax
   5:	74 b4                	je     0xffffffffffffffbb
   7:	01 10                	add    %edx,(%rax)
   9:	07                   	(bad)
   a:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   e:	10 08                	adc    %cl,(%rax)
  10:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
	...
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:*	89 e5                	mov    %esp,%ebp		<-- trapping instruction
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
  2a:	5d                   	pop    %rbp
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d 76 00             	lea    0x0(%rsi),%esi
  35:	58                   	pop    %rax
  36:	b8 77 00 00 00       	mov    $0x77,%eax
  3b:	cd 80                	int    $0x80
  3d:	90                   	nop
  3e:	8d                   	.byte 0x8d
  3f:	76                   	.byte 0x76

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	ret
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	8d 76 00             	lea    0x0(%rsi),%esi
   b:	58                   	pop    %rax
   c:	b8 77 00 00 00       	mov    $0x77,%eax
  11:	cd 80                	int    $0x80
  13:	90                   	nop
  14:	8d                   	.byte 0x8d
  15:	76                   	.byte 0x76
[  221.409527][ T7133] EAX: ffffffda EBX: 00000137 ECX: 01ce1580 EDX: 240449b4
[  221.410805][ T7133] ESI: 000000b1 EDI: 8b8b8b8b EBP: 08080808 ESP: bfc205fc
[  221.412147][ T7133] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[  221.481648][ T7133]
[  221.482194][ T7133] ================================================
[  221.483377][ T7133] WARNING: lock held when returning to user space!
[  221.484574][ T7133] 6.6.0-rc4-01105-gdf13d11e6a2a #1 Tainted: G        W       TN
[  221.485904][ T7133] ------------------------------------------------
[  221.487044][ T7133] trinity-c4/7133 is leaving the kernel with locks still held!
[  221.488448][ T7133] 1 lock held by trinity-c4/7133:
[ 221.489401][ T7133] #0: c27dbb18 (rcu_read_lock){....}-{1:2}, at: inet6_csk_xmit (include/linux/rcupdate.h:747 net/ipv6/inet6_connection_sock.c:129) 
[  221.491125][ T7133] ------------[ cut here ]------------
[  221.501170][ T7133] Voluntary context switch within RCU read-side critical section!
[ 221.501214][ T7133] WARNING: CPU: 1 PID: 7133 at kernel/rcu/tree_plugin.h:320 rcu_note_context_switch (kernel/rcu/tree_plugin.h:320 (discriminator 11)) 
[  221.504458][ T7133] Modules linked in: ipmi_msghandler uio_pdrv_genirq uio rtc_cmos processor fuse drm drm_panel_orientation_quirks configfs
[  221.506701][ T7133] CPU: 1 PID: 7133 Comm: trinity-c4 Tainted: G        W       TN 6.6.0-rc4-01105-gdf13d11e6a2a #1
[ 221.508634][ T7133] EIP: rcu_note_context_switch (kernel/rcu/tree_plugin.h:320 (discriminator 11)) 
[ 221.509684][ T7133] Code: e9 87 fe ff ff 8d 74 26 00 8b 41 2c 89 45 ec e9 16 ff ff ff 8d 74 26 00 90 c6 05 09 88 94 c2 01 68 04 84 32 c2 e8 47 14 f5 ff <0f> 0b 5a e9 b0 fd ff ff 8d b4 26 00 00 00 00 81 e2 ff ff ff 7f 0f
All code
========
   0:	e9 87 fe ff ff       	jmp    0xfffffffffffffe8c
   5:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
   9:	8b 41 2c             	mov    0x2c(%rcx),%eax
   c:	89 45 ec             	mov    %eax,-0x14(%rbp)
   f:	e9 16 ff ff ff       	jmp    0xffffffffffffff2a
  14:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
  18:	90                   	nop
  19:	c6 05 09 88 94 c2 01 	movb   $0x1,-0x3d6b77f7(%rip)        # 0xffffffffc2948829
  20:	68 04 84 32 c2       	push   $0xffffffffc2328404
  25:	e8 47 14 f5 ff       	call   0xfffffffffff51471
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	5a                   	pop    %rdx
  2d:	e9 b0 fd ff ff       	jmp    0xfffffffffffffde2
  32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  39:	81 e2 ff ff ff 7f    	and    $0x7fffffff,%edx
  3f:	0f                   	.byte 0xf

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	5a                   	pop    %rdx
   3:	e9 b0 fd ff ff       	jmp    0xfffffffffffffdb8
   8:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   f:	81 e2 ff ff ff 7f    	and    $0x7fffffff,%edx
  15:	0f                   	.byte 0xf
[  221.513148][ T7133] EAX: 00000000 EBX: e52d7c40 ECX: 00000000 EDX: 00000000
[  221.514443][ T7133] ESI: 00000000 EDI: eadb5640 EBP: ead7df28 ESP: ead7df10
[  221.515747][ T7133] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010046
[  221.517184][ T7133] CR0: 80050033 CR2: 01ce68cc CR3: 2ae6f000 CR4: 00000690
[  221.518449][ T7133] Call Trace:
[ 221.519074][ T7133] ? show_regs (arch/x86/kernel/dumpstack.c:478) 
[ 221.519826][ T7133] ? rcu_note_context_switch (kernel/rcu/tree_plugin.h:320 (discriminator 11)) 
[ 221.520887][ T7133] ? __warn (kernel/panic.c:673) 
[ 221.521663][ T7133] ? rcu_note_context_switch (kernel/rcu/tree_plugin.h:320 (discriminator 11)) 
[ 221.522722][ T7133] ? report_bug (lib/bug.c:201 lib/bug.c:219) 
[ 221.523615][ T7133] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 221.524517][ T7133] ? handle_bug (arch/x86/kernel/traps.c:216) 
[ 221.525240][ T7133] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
[ 221.526115][ T7133] ? handle_exception (arch/x86/entry/entry_32.S:1056) 
[ 221.527035][ T7133] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 221.527882][ T7133] ? rcu_note_context_switch (kernel/rcu/tree_plugin.h:320 (discriminator 11)) 
[ 221.528945][ T7133] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 221.529743][ T7133] ? rcu_note_context_switch (kernel/rcu/tree_plugin.h:320 (discriminator 11)) 
[ 221.530784][ T7133] __schedule (arch/x86/include/asm/preempt.h:80 (discriminator 3) kernel/sched/core.c:556 (discriminator 3) kernel/sched/sched.h:1372 (discriminator 3) kernel/sched/sched.h:1681 (discriminator 3) kernel/sched/core.c:6612 (discriminator 3)) 
[ 221.531573][ T7133] ? exit_to_user_mode_prepare (kernel/entry/common.c:158 kernel/entry/common.c:204) 
[ 221.532627][ T7133] schedule (arch/x86/include/asm/preempt.h:85 (discriminator 1) kernel/sched/core.c:6772 (discriminator 1)) 
[ 221.533358][ T7133] exit_to_user_mode_prepare (kernel/entry/common.c:161 kernel/entry/common.c:204) 
[ 221.534382][ T7133] ? sysvec_reboot (arch/x86/kernel/smp.c:269) 
[ 221.535255][ T7133] irqentry_exit_to_user_mode (kernel/entry/common.c:130 kernel/entry/common.c:311) 
[ 221.536302][ T7133] irqentry_exit (kernel/entry/common.c:445) 
[ 221.537101][ T7133] sysvec_reschedule_ipi (arch/x86/kernel/smp.c:269) 
[ 221.538079][ T7133] handle_exception (arch/x86/entry/entry_32.S:1056) 
[  221.538990][ T7133] EIP: 0xb7f59579
[ 221.539674][ T7133] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
All code
========
   0:	b8 01 10 06 03       	mov    $0x3061001,%eax
   5:	74 b4                	je     0xffffffffffffffbb
   7:	01 10                	add    %edx,(%rax)
   9:	07                   	(bad)
   a:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   e:	10 08                	adc    %cl,(%rax)
  10:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
	...
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:*	89 e5                	mov    %esp,%ebp		<-- trapping instruction
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
  2a:	5d                   	pop    %rbp
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d 76 00             	lea    0x0(%rsi),%esi
  35:	58                   	pop    %rax
  36:	b8 77 00 00 00       	mov    $0x77,%eax
  3b:	cd 80                	int    $0x80
  3d:	90                   	nop
  3e:	8d                   	.byte 0x8d
  3f:	76                   	.byte 0x76

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	ret
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	8d 76 00             	lea    0x0(%rsi),%esi
   b:	58                   	pop    %rax
   c:	b8 77 00 00 00       	mov    $0x77,%eax
  11:	cd 80                	int    $0x80
  13:	90                   	nop
  14:	8d                   	.byte 0x8d
  15:	76                   	.byte 0x76
[  221.543249][ T7133] EAX: ffffff91 EBX: 00000137 ECX: bfc205fc EDX: b7f59579
[  221.544585][ T7133] ESI: 000000b1 EDI: 8b8b8b8b EBP: 08080808 ESP: bfc205fc
[  221.545872][ T7133] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[ 221.547230][ T7133] ? sysvec_reboot (arch/x86/kernel/smp.c:269) 
[  221.548133][ T7133] irq event stamp: 10576
[ 221.548909][ T7133] hardirqs last enabled at (10575): _raw_spin_unlock_irq (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202) 
[ 221.550576][ T7133] hardirqs last disabled at (10576): exit_to_user_mode_prepare (include/linux/entry-common.h:191 kernel/entry/common.c:181 kernel/entry/common.c:204) 
[ 221.552434][ T7133] softirqs last enabled at (10570): release_sock (net/core/sock.c:3528) 
[ 221.553958][ T7133] softirqs last disabled at (10568): release_sock (net/core/sock.c:3517) 
[  221.555538][ T7133] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231017/202310171606.30e15ebe-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

