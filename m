Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BECA7BC583
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343640AbjJGHXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjJGHXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:23:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F83B9;
        Sat,  7 Oct 2023 00:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696663421; x=1728199421;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zY4VyF0ZYflYLsvPdANc+t8i/oW1LxfMJNc8PGoME6U=;
  b=B1K+axjnYWwFepYfVM29v2ST0SeM0Nc4gN5cpkYlet9Y9vAZNy9Yiv0J
   CnrTfL1heBco3KivW8aG9UNfzbtcslNSbyt6VtRiF/G5UMVZq7aCUDfOg
   eV/llN4QRhNHfjPpqokUaxIEXV4Wtmw3YSkI7DkVzjP4j0r0C1Hx+6BBB
   aZ8Gx5UHDb9zLbQ4zRohysLXYAJVlD3bWFKr2qa4qThG3Zh2vxyVnPu3B
   SxhF97O8zE/NxnCBpG9VXyIDaEPflRFracxnEW8kHxd8rt9Q6djb4vn2C
   Z5dfdqMg6ZMi3c2ntFPkYDx2XEjNLNOsU0sBonwdgN6I0g1XJsmSNBB+5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="5460116"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="5460116"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 00:23:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="818278441"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="818278441"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2023 00:23:40 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 7 Oct 2023 00:23:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sat, 7 Oct 2023 00:23:40 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sat, 7 Oct 2023 00:23:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeASz5r+fSnks+FxRRcfY1kemmqYGtSiLQunoYDPnmuGWNqDVIgNRf1n95R279Ujub4QhRdjnVthCV3ejs38lRscAyrAGWhtEvHzXsKO/haOR8hgHcoOReweN4LFMQd0o88GqT1YFZtIw4kp5OwOf69c1gThRoipaLNBos3ThVcb00+1ivBSbzzFwRjFVXJ73Tq5wyj9Y3/PXnEDEOifrGJeXndyiob0yU4UNDWo0gK5v9ed2/WyIBEaQnBN3JsUYmNfkr54FtAQjhtmamj5HttQAH5pClsIIdXMNmXFuuoDbqfbYSzGl3JWxycKl3knBa1Dta/VRGWG4iZdtyfLcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8Q0d6LTWU+PccojBLxsO6kv+Zcx+kChfB1ngSwe3T8=;
 b=CNfLxyhPJ20qtOshoCO1KJRuGk7Hwzj+1zYcxfdy+GQx7yPO+nwv+ehlR/prkUXLbwoTE+exIeZjojpH57uaHmPPw9Cqs3nRivJbMcqKlGryLOKzXKQvlRJ1DXwfRptH7G4VYXxtmDwkUcaVE7pb/b+ijMmyUF7MkDnZ0sKaoZOwMP+eEphGKHMG/N9OHDqiaG80p/m6jpTNiNTLN8M0yA9IhNywN1F6e4axOFhbgJawfNTILUJZeRuG2CeHFCrKrjkF68XiGJNMZq1hjNOp0rYStz6uk6CYBWb29n2NdIx8D952UAADHragG06cJ05NtMOoUClpUq1vJzjKJDojwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CH3PR11MB8548.namprd11.prod.outlook.com (2603:10b6:610:1ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Sat, 7 Oct
 2023 07:23:37 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6838.029; Sat, 7 Oct 2023
 07:23:37 +0000
Date:   Sat, 7 Oct 2023 15:23:30 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Ido Schimmel <idosch@idosch.org>
CC:     Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "lkp@intel.com" <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        <oliver.sang@intel.com>
Subject: Re: [linus:master] [selftests]  8ae9efb859:
 kernel-selftests.net.fib_tests.sh.fail
Message-ID: <ZSEHcoakN1FeL6ZM@xsang-OptiPlex-9020>
References: <202309191658.c00d8b8-oliver.sang@intel.com>
 <DBBP189MB1433CECC6CBECFD95352EA3595FCA@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
 <ZRmHLPbyTCBvoHWP@shredder>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZRmHLPbyTCBvoHWP@shredder>
X-ClientProxiedBy: SG2PR01CA0143.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::23) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CH3PR11MB8548:EE_
X-MS-Office365-Filtering-Correlation-Id: 02f643ba-aa93-4e08-7f45-08dbc706520f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +MRaCU1d9kKsPNRpeVHh/TW5UWXCxyMTLgTabD5zbaYmLdpZ9OG1YtGuQxA9nWPegKpKNzD5aDVK6CAcfDmeLE3r1a+pbUvp3kLBB5jV3O5pxQzDXV3+Pwwqd0iRpvLQ3xCIjpaYEpKZ7HxWep1mh6aMT7TiedzIkGSs7QpXwH7VoXTr404BH3XReDTil9NLN457qh0/3wBE12Huh41s8ZmwI6lB5JzT18uBONX2yXekOcHa33zcmWGwGLWPc2E7r7t+Te1hS5RV6CvDAjXBHU3pWXvGxk3BZvYwkbqAfLltGeC5UKHMzyghMw57WF99A2UkgA59N8dm3Oc+U+9oa0ZjHIuwBdfir8pF2BRtF89pdFDmUxKfWw9BsFI3sNxtZLTQh2IFyjVExw+WsaJ0TYXHaATW9HelR6LI7nv/uvR1qngrV8L0N3ci9jX/FDeIo3DmxzR3CtPcRHRDMdVhPYryaLVdmRFAPKjUao1YdAiClH8xx+gykBapThUtB3qL/nGDE2MNtKjEYC3hEP3Qlajw9ychO+yxjIhpBt6nj07PMHjZNLKpL4Rm+rB3veswuIdu8J5GmldfSy0dcmzNiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(396003)(366004)(136003)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(478600001)(9686003)(6506007)(6512007)(53546011)(107886003)(86362001)(38100700002)(82960400001)(41300700001)(6486002)(66556008)(2906002)(6666004)(966005)(83380400001)(6916009)(26005)(4326008)(8936002)(8676002)(66476007)(66946007)(33716001)(44832011)(316002)(54906003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9XqDZIOym5Ir9wV5CR7C0gBlo6HBABhwiP92NQToM6Yq3B1mEGNA4PrxJ9re?=
 =?us-ascii?Q?nEyFb1aKfqpmeIfT02dArXlmTNXssmrNiE4/JGR9avI/Iks6MKnu8rqAPjlf?=
 =?us-ascii?Q?MY2tUfKKF93dnMz9nqZDL/UogZQh4N89JEE62kFsdh9TD2sR8I22X0MmETM3?=
 =?us-ascii?Q?KX7nr2Lz3/wV0Z2LCBy7SNCzCWx1v4HgtOZu4Os9lqcR4ufMLTjDaSMYqvsb?=
 =?us-ascii?Q?ZDFjeaFskRCxHfdiOyApdjAACneXb3wgDpf9wb7l3sPrENvkW9Xi8mT3m3yc?=
 =?us-ascii?Q?RPFKzE34xpgH27uLADlc8wE3Ozv5QPm4s2v5m0sb/zPMRLZA/2KJfc+3o1IC?=
 =?us-ascii?Q?m2bn1gh3uXfa40miuobzrxbm9gov8PBRV07sBriap2yotSPqixLKk0qzazAn?=
 =?us-ascii?Q?0uebqv8NyJ1H0ARBgjVVVZIp3qAvFYwtLCESjlC/NIBkPFTGSRq94+1l+w6a?=
 =?us-ascii?Q?BoelsrEZYtd3MrHaofITYugVffyO+YRDso1CXmEOUM8i20Gi+6z33Qv0kJ0l?=
 =?us-ascii?Q?OKT4ie2NvkPjmp5PMLtOncuIEWKAAtlbmNcbLpMDqgMRjOm9OegG3H23qHDx?=
 =?us-ascii?Q?9k6FAXz9L/toZbCY2q+NK0qPZRm5KQPwOUWJh+1x4fMa0PA0aA01HF13zpLZ?=
 =?us-ascii?Q?rR6/PHyQbA1PMtDvhD++nqOcyGMx7fg2D5t50RseBv5QOnz9q7Mo1GPmGIhB?=
 =?us-ascii?Q?Kfnm7PUY6yP15wxRZ4OW9Cd6dygMoe2/R971y1Qcj6NcYSn/cVrq4K0hf4IC?=
 =?us-ascii?Q?MkKD+BPXN49gOAxkwy2F564FlMxq1g0MUqQYz5NJ2Gxn8cPXwgJSktn/wZdU?=
 =?us-ascii?Q?U0jzEPJnJmAYnqJRb+FwW7YbfABhtzz4N4aBl1wDW2f3p1x4DyOyBRavFNb5?=
 =?us-ascii?Q?e0qwyyiCuzq5NKO9UkLEtP4Tpw8MS7r8oymNeTPcoEGWy/ampWiLo6o3HAzY?=
 =?us-ascii?Q?n9odL3wDg/E8PHDhLMFUKZ/0kCICwrero5ykp8dX0RwPZnQqsv5yaTkoJ858?=
 =?us-ascii?Q?p5fu2+QMZdG2bBysqURT6WLz8Jz3UNAH96Go9Dzkf40nvH0Ply4fSFUn+jj2?=
 =?us-ascii?Q?iT31EUcZBI5ygkwCGT1WKXWs+6AdivIJlHb6MoOUdhSBMQ1sBjMUhJW5WiNl?=
 =?us-ascii?Q?udGMkYDXz+yIEp03ShBF0VFdzpZYBk2yZAAtuqyz6DQaHBg5u4HEs/5jPMk6?=
 =?us-ascii?Q?p7rsvIJYKX302cOPECVTtwAmqwd2B5Cjp7BVglsCTD7f0qTuAPTcHD4tfK9s?=
 =?us-ascii?Q?y5LAbxBmACYcSQKo8ivmbviWdZxxY57FfUbp5d+oyrDMVUvuWzq9zT9zELT/?=
 =?us-ascii?Q?QE4PEC/AfKyX0nJQPqNR9RMkgK89TwWYsrqCgxTL613vaWHvi3Rnwr2hnXYs?=
 =?us-ascii?Q?5tpgVSuEFm8ksWqUGcmv2phNt9XLMKh/ap9AQJUsEXFy8ZXZQ++LLdK60Y+A?=
 =?us-ascii?Q?E4Y3ixyZL7SGMTBGZeHw4Nvj5mIqeUwxkr481Id533y4D1EID4T6HmcmRL6R?=
 =?us-ascii?Q?GEOSEN1QwcjQROFAJPhlsxDhi9xjNYCC4NU89PhxZIoS6zEQp8mZP9e6P1se?=
 =?us-ascii?Q?RYi0p3B5XrfQLCa5BtlSyQNOaA3WjkMQmgpXbfwOBYHVPm/ZlCB0Onx/Uyum?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f643ba-aa93-4e08-7f45-08dbc706520f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 07:23:36.6271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDbuT1zqhbiv6qyJmxcBg6g3ha0EnjrlXqT0/tVB8qQp6ADHznk3AhReNy0Vsu3QV8eo4nQB9ahaX4SMbR0Aww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8548
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, Ido Schimmel,

On Sun, Oct 01, 2023 at 05:50:20PM +0300, Ido Schimmel wrote:
> On Mon, Sep 25, 2023 at 06:18:34PM +0000, Sriram Yagnaraman wrote:
> > CC: Ido, who helped a lot with writing these tests.
> > 
> > > -----Original Message-----
> > > From: kernel test robot <oliver.sang@intel.com>
> > > Sent: Tuesday, 19 September 2023 10:32
> > > To: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> > > Cc: oe-lkp@lists.linux.dev; lkp@intel.com; linux-kernel@vger.kernel.org; David
> > > S. Miller <davem@davemloft.net>; netdev@vger.kernel.org;
> > > oliver.sang@intel.com
> > > Subject: [linus:master] [selftests] 8ae9efb859: kernel-
> > > selftests.net.fib_tests.sh.fail
> > > 
> > > 
> > > hi, Sriram Yagnaraman,
> > > 
> > > we noticed two new added tests failed in our test environment.
> > > want to consult with you what's the dependency and requirement to run
> > > them?
> > > Thanks a lot!
> > 
> > Sorry for the delayed response. I will look at this and get back.
> > I am not an expert with lkp-tests but will try to set it up on my local environment and reproduce the problem.
> > 
> > > 
> > > Hello,
> > > 
> > > kernel test robot noticed "kernel-selftests.net.fib_tests.sh.fail" on:
> > > 
> > > commit: 8ae9efb859c05a54ac92b3336c6ca0597c9c8cdb ("selftests: fib_tests:
> > > Add multipath list receive tests")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > > in testcase: kernel-selftests
> > > version: kernel-selftests-x86_64-60acb023-1_20230329
> > > with following parameters:
> > > 
> > > 	group: net
> > > 
> > > 
> > > 
> > > compiler: gcc-12
> > > test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @
> > > 3.00GHz (Cascade Lake) with 32G memory
> > > 
> > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > > 
> > > 
> > > 
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of the
> > > same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > | Closes:
> > > | https://lore.kernel.org/oe-lkp/202309191658.c00d8b8-oliver.sang@intel.
> > > | com
> > > 
> > > 
> > > 
> > > # timeout set to 1500
> > > # selftests: net: fib_tests.sh
> > > #
> > > # Single path route test
> > > #     Start point
> > > #     TEST: IPv4 fibmatch                                                 [ OK ]
> > > #     TEST: IPv6 fibmatch                                                 [ OK ]
> > > #     Nexthop device deleted
> > > #     TEST: IPv4 fibmatch - no route                                      [ OK ]
> > > #     TEST: IPv6 fibmatch - no route                                      [ OK ]
> > > 
> > > ...
> > > 
> > > #
> > > # Fib6 garbage collection test
> > > #     TEST: ipv6 route garbage collection                                 [ OK ]
> > > #
> > > # IPv4 multipath list receive tests
> > > #     TEST: Multipath route hit ratio (.06)                               [FAIL]
> > > #
> > > # IPv6 multipath list receive tests
> > > #     TEST: Multipath route hit ratio (.10)                               [FAIL]
> 
> I found two possible problems. The first is that in the IPv4 case we
> might get more trace point hits than packets (ratio higher than 1)
> because of the additional FIB lookups for source validation. Fixed by
> disabling source validation:
> 
> diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
> index e7d2a530618a..66d0db7a2614 100755
> --- a/tools/testing/selftests/net/fib_tests.sh
> +++ b/tools/testing/selftests/net/fib_tests.sh
> @@ -2437,6 +2437,9 @@ ipv4_mpath_list_test()
>         run_cmd "ip -n ns2 route add 203.0.113.0/24
>                 nexthop via 172.16.201.2 nexthop via 172.16.202.2"
>         run_cmd "ip netns exec ns2 sysctl -qw net.ipv4.fib_multipath_hash_policy=1"
> +       run_cmd "ip netns exec ns2 sysctl -qw net.ipv4.conf.veth2.rp_filter=0"
> +       run_cmd "ip netns exec ns2 sysctl -qw net.ipv4.conf.all.rp_filter=0"
> +       run_cmd "ip netns exec ns2 sysctl -qw net.ipv4.conf.default.rp_filter=0"
>         set +e
>  
>         local dmac=$(ip -n ns2 -j link show dev veth2 | jq -r '.[]["address"]')
> 
> The second problem (which I believe is the one you encountered) is that
> we might miss certain trace point hits if they happen from the ksoftirqd
> task instead of the mausezahn task. Fixed by:
> 
> @@ -2449,7 +2452,7 @@ ipv4_mpath_list_test()
>         # words, the FIB lookup tracepoint needs to be triggered for every
>         # packet.
>         local t0_rx_pkts=$(link_stats_get ns2 veth2 rx packets)
> -       run_cmd "perf stat -e fib:fib_table_lookup --filter 'err == 0' -j -o $tmp_file -- $cmd"
> +       run_cmd "perf stat -a -e fib:fib_table_lookup --filter 'err == 0' -j -o $tmp_file -- $cmd"
>         local t1_rx_pkts=$(link_stats_get ns2 veth2 rx packets)
>         local diff=$(echo $t1_rx_pkts - $t0_rx_pkts | bc -l)
>         list_rcv_eval $tmp_file $diff
> @@ -2494,7 +2497,7 @@ ipv6_mpath_list_test()
>         # words, the FIB lookup tracepoint needs to be triggered for every
>         # packet.
>         local t0_rx_pkts=$(link_stats_get ns2 veth2 rx packets)
> -       run_cmd "perf stat -e fib6:fib6_table_lookup --filter 'err == 0' -j -o $tmp_file -- $cmd"
> +       run_cmd "perf stat -a -e fib6:fib6_table_lookup --filter 'err == 0' -j -o $tmp_file -- $cmd"
>         local t1_rx_pkts=$(link_stats_get ns2 veth2 rx packets)
>         local diff=$(echo $t1_rx_pkts - $t0_rx_pkts | bc -l)
>         list_rcv_eval $tmp_file $diff
> 
> Ran both tests in a loop:
> 
> # for i in $(seq 1 20); do ./fib_tests.sh -t ipv4_mpath_list; done
> # for i in $(seq 1 20); do ./fib_tests.sh -t ipv6_mpath_list; done
> 
> And verified that the results are stable. Also verified that the tests
> reliably fail when reverting both fixes:
> 
> 8423be8926aa ipv6: ignore dst hint for multipath routes
> 6ac66cb03ae3 ipv4: ignore dst hint for multipath routes
> 
> Can you please test with the proposed modifications?

we applied above patches upon 8ae9efb859, and two tests passed now:

# IPv4 multipath list receive tests
#     TEST: Multipath route hit ratio (.99)                               [ OK ]
#
# IPv6 multipath list receive tests
#     TEST: Multipath route hit ratio (1.00)                              [ OK ]
#
# Tests passed: 225
# Tests failed:   0
ok 17 selftests: net: fib_tests.sh


Tested-by: kernel test robot <oliver.sang@intel.com>


> 
> Thanks
> 
