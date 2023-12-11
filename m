Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6F880C1E5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 08:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbjLKH2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 02:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjLKH2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 02:28:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75647D9;
        Sun, 10 Dec 2023 23:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702279724; x=1733815724;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=YvnOSWYaxi2h11g451VunpWpIeKqI3Ya7WekX/Yw97U=;
  b=a0WIlQlRDgapi/YzS6VwXztKS8Bfie2ZkXZHVi68eKxkTdE9oPCQVzNf
   0/QBRJqhnV9MdP0oHVQOZcoSvwO2g7G3i3HlSTYEGHjyjZVTd1hL82tjc
   ml7GaT+Gsw6iRCs9GvkkYwKNiE0LQNljXq7bCp3OP/REcXnG6C+A3N13+
   npoa8JgRkf93Qezuht9q1Jqm2tvHVkKEeS1obkq+WPz/NV+0HLhbq8h/s
   QkGQxB2wtd2VAun/nE5ke3SW3P27t1joHe/lq5fQJaYMNNUWvE1F8wLLx
   b94YYChKT+JTj4FWqDT6P9N+G6s5AWmb42rWlx/1Ae7r/5oMmUHyR8I8e
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="398460667"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="398460667"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 23:28:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="946196626"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="946196626"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2023 23:28:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 23:28:28 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 23:28:28 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 10 Dec 2023 23:28:28 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 10 Dec 2023 23:28:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZiNqsrx5sHjEkiyxxmZeXOr1Ptve37wSiuBe7NTvnaG2qzB7uk3bgqY46urTacstkpzQI7Eq4WA/h+5Gb7bn7NUsp9zSGTj8u2tEuTMRPyx4DzlPVjNq/JaWs8stYUV3rJOuHGA2z3lfhoI0LKGc0xH3j9G0617Qs/aZT+YeitucWjhLdqpyPXt68OFMN11fxRwvI0teB51kV/LM0WErCzZLWTMFlHaZd9XEL7zkGTe+NRWvwlgu6iZ0mNoCi58GWkvgLvAN04oZDiLz+MigItaSBCWNePGzR7anho63VTSM+1q8T4OMDcpVGNfxayY2cm6VrezkZnPnGvSRZvyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPog49dv3VeeyMW7KhZ96r6RMYYCSds/Kq4ofjhjTqk=;
 b=URqNKeP0joauGa3xm53d3DE6tGA4WFTLBZQIr9Cn1279gP3cgJM5Jq6kDP/O3rRhecNWSG3uhBerngpHxvzuDyO3Xczau69Co3s+F+xdRIK65VeezrsMgD3H2UO4/VCKt8i2SKK6rzKtnIC8D0i3yiaZ7qIEuSeqgOC8FsF4F9zzog/FAFkGdZ1xdP7mGBUwa2MColuA/ss82xlBCR9FnkErSmrf6ZnA3syzaG6f7xbp9YC8X/NB5Tcv2Pe5Z1ya23SjSWqNO0S2XYg+5sE23VQ1URBhS+RWGmCKg5ESb7+5fHWhxTfcK1kDe/SIcqqhAXRAnrmvvLauh374jEuPDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB6520.namprd11.prod.outlook.com (2603:10b6:8:d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 07:28:25 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 07:28:25 +0000
Date:   Mon, 11 Dec 2023 15:28:09 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Tycho Andersen <tycho@tycho.pizza>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        <linux-api@vger.kernel.org>, Tycho Andersen <tycho@tycho.pizza>,
        Tycho Andersen <tandersen@netflix.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v2 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <202312111516.26dc3fd5-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231207170946.130823-1-tycho@tycho.pizza>
X-ClientProxiedBy: SG2PR01CA0130.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::34) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB6520:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f8b6e3-9221-4799-ea08-08dbfa1ac2a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pdT3IJvSF0W9issgqGImsq2b/Inxp6qZzI1bKBs1D/hqYg7En1QqJSNl84GKBAIC/J1EmKpVEyrHPTMh0lvkTJJUU08QV8PLBFCHn/f1SiHJdNjW57WKLZH9mHlbaoULRsQxo/ajvwHkwU4vxpzBqBLNPScJF3XTFUkBm0ihkfllmwSDf7WA/GJKZJ+3yJOAVFavd6W2Ihzp/Bx5GgCX5vJiK2F5aM3eH1GHkJ/1qx366x1ykg6uCyc0qp18S9/sl56rXwjDvTNv6hMSQsQKluz3V+4hY+hIzR5EfHAirMJOKNwR8kTBnqvpApAFLXWtPotCx0GoJlqZDFQAOuZgFff6nV0hWcDxLdoqhacFuuW31T1UuJj1+Gh12nRUswIDFObGAWv7gxWA7iSzFvGJwIUZHGYDdsHuOoKp3xSaoO/07J5COxdjdPz1um001Lz9FuOhinUNzvqyZWTjY4g9+h9QeXAdOR0lhMrzCD/aNRu4paUTiHX5vbxPCkd9rRsGurxvwvyO5dndZ3RRsT+J/CmTzxy8nXNomFn9wbqhhLU/CQHyoGJ0dpdrVGRUh+sxz8YYoph0t4T1uXtXeCHieQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(2906002)(478600001)(41300700001)(82960400001)(66556008)(66476007)(54906003)(6916009)(66946007)(966005)(6486002)(316002)(38100700002)(6666004)(86362001)(4326008)(8936002)(8676002)(6506007)(6512007)(36756003)(5660300002)(1076003)(107886003)(26005)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RcE5axlvI9OKsRL+kufJW/kf4T0DH7e9K2l8ax8RXGAvazw+LvT8LG9UcXGy?=
 =?us-ascii?Q?y8FczusSfnRwQmOpJv/52+7OLWDv7koM4HNxk5ApYC0w+BTBFripH1a/Micj?=
 =?us-ascii?Q?UXumOZcHNF9Is4twCuGVLvAtXeXuOg6bcI3f/GLT6YNQnRD7h8tex2zRm0CK?=
 =?us-ascii?Q?Y2Fycbm9kxKm5uATw37oVhy38IOLDHL6EP8n9hfuOeap09l9I42PFAHlNNeO?=
 =?us-ascii?Q?jFl7ambLyBWdpBoLsptXKgpH7hl0Xqhanerfu84d8GZsmHqzphnwv1WacdBx?=
 =?us-ascii?Q?T/2ux7+R4zx9cj58CH8FWYAh7jjaFgE1KYCmcm/L5HTIy2MPy+NZrsZUS1Zy?=
 =?us-ascii?Q?E5WsykHBkaWo9YAttVztr2fAFmDZ2lW6rhL3aKlRzJ/53d5fb2VW/q/k933W?=
 =?us-ascii?Q?fRqff62zJJARcWzk8cCnSYT66VWtC8NZPHdsPEZjvgjdxbHABor7rzzl5FWh?=
 =?us-ascii?Q?ow8GQXnP3kVuR04teePDDCE6hoHOn5PKR1LfGHtvDuYQDxKL2uve7RZsyNY2?=
 =?us-ascii?Q?rE4Fl2P+1cX1ZHI2nVgdj57GVgjFdMryKthZwFV5rgtRYmB0FXrplECYGtY0?=
 =?us-ascii?Q?ka9nBe64Zgfss5pe8BhuoaFu87CYB49WGWtqRcnlWuLlgh0DInYK5nbVayc5?=
 =?us-ascii?Q?ervqTCYMxacughhg0MI31Wuv+Zjjxvlyq7OxBRsATRjzir4U0E51N4OJoDey?=
 =?us-ascii?Q?gAg97Lvyny3IPKYXn2GI0ljoMUjETqFG/tv7RlQqdo0VwdLYvGUV745UNomw?=
 =?us-ascii?Q?LShEwgsrSDx37j48yDKihnHIbG/hm44bEP9oehzrCqmQDQEb5JQI8E7x4jfQ?=
 =?us-ascii?Q?43n1quYf4/A8nmxVOE2SmGGInvbut8VrxCPtN6trAflFChVnAjvZ1T6nWfLe?=
 =?us-ascii?Q?VOR3lRDuSW5UZNvdGwdiRkiR2wqCRgudDTarQXpAUEtvfJqTo/5hrlrQ4B72?=
 =?us-ascii?Q?cnNKZ7jU2tKwgjlMNzqhTXbRyqpiIglzZCoqepLoaZ4+Cj3ZS0o4YaYn7UNH?=
 =?us-ascii?Q?hN7TPqmx66YN9eQ9equ5n499fQF6+KARWDAmM9S0As5pjU2NuL16m1KCQ+fu?=
 =?us-ascii?Q?OSAe+CAWa5mNo6QJtApScswER3dykefIkf3iSS/F6oej91hE8DeTOGnfe1Zi?=
 =?us-ascii?Q?kPBdyvWgsqf3FU8bbwLijm3MLoyaKIR56tRZXQVkf/EZNHUZ5W5Hodh0/0UI?=
 =?us-ascii?Q?8QL6VEQ7WLeEg9ChVz8pgwy9Ry3TxTpS3C4puBhe37Y24KChCmGnoz50hSB3?=
 =?us-ascii?Q?dt4KtbdiK/PrcpA/C8HFmm2DSanm+VD0LFNP1Tbidq61ldt+n0lvsU2/qCtu?=
 =?us-ascii?Q?S5iatRbyQyChUQapYEym4TX+fVxxQwUDNOTKDGurnUPKHU3TGbkdkXM6cUzI?=
 =?us-ascii?Q?HIm1g9/I8ueb49cI88HLOKNENu3dYVEQQUA3+YkkiWUTrw1h4Mxwmq4YIMyT?=
 =?us-ascii?Q?R3yA/GXsoSTEJpvaw4RAM9u+e0qnRmyrWoCDtAHxfYDPFI22Hkf/YJFgozzj?=
 =?us-ascii?Q?UgUnLbdIaCu3HtPbT/8JqicSNJJ4O+5hcuLRYaUoqHO5WfXm8OQSP5TO5hE6?=
 =?us-ascii?Q?ZcZVty+n/yHJw+wytt2ysbzthSUEoZUE06KL9gOltEjlQfGbXF1k7+wkHaSi?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f8b6e3-9221-4799-ea08-08dbfa1ac2a3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 07:28:24.5451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOyGB4iYTlUkrQv+0v4OkJOi/j5MbEKOPXgEU4Q+nc2ShwikN6IIGbhL2L+kpU6zRD3+nfCjdJnk9xp7W+UhFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6520
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "kernel-selftests.pidfd.pidfd_test.fail" on:

commit: e6d9be676d2c1fa8332c63c4382b8d3227fca991 ("[PATCH v2 1/3] pidfd: allow pidfd_open() on non-thread-group leaders")
url: https://github.com/intel-lab-lkp/linux/commits/Tycho-Andersen/selftests-pidfd-add-non-thread-group-leader-tests/20231208-011135
patch link: https://lore.kernel.org/all/20231207170946.130823-1-tycho@tycho.pizza/
patch subject: [PATCH v2 1/3] pidfd: allow pidfd_open() on non-thread-group leaders

in testcase: kernel-selftests
version: kernel-selftests-x86_64-60acb023-1_20230329
with following parameters:

	group: pidfd



compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202312111516.26dc3fd5-oliver.sang@intel.com


besides, we also observed kernel-selftests.pidfd.pidfd_poll_test.fail on this
commit, but clean on parent:

bee0e7762ad2c602 e6d9be676d2c1fa8332c63c4382
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     kernel-selftests.pidfd.pidfd_poll_test.fail
           :6          100%           6:6     kernel-selftests.pidfd.pidfd_test.fail



TAP version 13
1..7
# timeout set to 300
# selftests: pidfd: pidfd_test
# TAP version 13
# 1..8
# # Parent: pid: 2191
# # Parent: Waiting for Child (2192) to complete.
# # Child (pidfd): starting. pid 2192 tid 2192
# # Child Thread: starting. pid 2192 tid 2193 ; and sleeping
# # Child Thread: doing exec of sleep
# Bail out! pidfd_poll check for premature notification on child thread exec test: Unexpected epoll_wait result (c=0, events=0) (errno 0)
# # Planned tests != run tests (8 != 0)
# # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: pidfd: pidfd_test # exit=1

...

# timeout set to 300
# selftests: pidfd: pidfd_poll_test
# # running pidfd poll test for 10000 iterations
# Bail out! death notification wait timeout
# # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
not ok 4 selftests: pidfd: pidfd_poll_test # exit=1




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231211/202312111516.26dc3fd5-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

