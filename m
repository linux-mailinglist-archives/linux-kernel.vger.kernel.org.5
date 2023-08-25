Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8C9787FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbjHYGTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjHYGSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:18:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7071BF0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 23:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692944324; x=1724480324;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=jYqqgJv16as0ZpJvprC6COZRX1zaqqjAKusTQmNg4Xs=;
  b=BkoNBlX2ZYl7vFgkXlHjrTJLdCtEEnTfeJdZw46r7K7Snb3JNoDoJ7Dz
   8N1s2eHhLd9L1sMrDeXxPvCtLdS189gMswGNcIkl9qUKUcvyMFJgmMELt
   NhcjXcm/Cgu+oIx/O5Z4zaCGhL3g0sPg1fIvW/hEejC+l9sGFzo4Shayc
   1syAgqylQSsXAkGVXnf9Gps5xToORoZpsuBHxrrjlaiNP2/xLOktoprZa
   mIuOImeRRIRDRr6yTJHhBEb6WYItzr59Rf3h5X++K6Ep+wHuJN8QuWxIw
   hGLQm+UJ/LV/V1zuM+oZW0PyCNQc6O0NhsxY7WKAeg1jxtrZ1FB/Rzgaq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="440986095"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="440986095"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 23:18:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="1068125723"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="1068125723"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 24 Aug 2023 23:18:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 23:18:31 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 23:18:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 23:18:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 23:18:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCN0ll1kftcPDhtaI7RUIRWWSOf0Jf7cXhBfRk6j8fSMDaTPE/+Lw/wTZVIU9ZwBFDixYMEV6SMNQLKSvA92XoFDxxyJ1vyZu8kwKqWCUfuF1+Upp6quwpWoJCkRhoe1bacRVvhoWcvUrdywFqvI25VFMDBGzAeozjV4IddayY5V+FWKKms30N0HDHt0LrhnwAiMcKC2dEfE+BKWYfGE5ZCAHGaRt8C/7zT1dpUyB1a3uEL5X3BHtQOd7Bfg27yguT8bHUvdljZoD1pd3Zg30CJ8dWuvF8x15qWtwzeTinElh5oqshAmpJt6aDOqlj/4h7fHjCkKQlDxwm1kfD2oTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MOVL2f7ALWeokvGfi1w7Sh+WQQoDp6fV7mQbidEfbg=;
 b=Yp0BW5Oa9JCHwuDIMpXtkEiSB9ifyvNlTw4uF3j48lpRx6R+sK3CCPvyXOlDyatOKwhdG3437BRMHuMNpgnp1bQAT+gUNcbxS0nW0NcuvrTWJtlHOOgIxzBb+GRmm6+v1SJzVYOi+UYFDtcXcvzP2NUH3K06rTNViUW7AwCPHBgdBKCFwkAymvOhYPHtw+hUPS4WL/o4ofojfCfyYShT6Cg/xTrSKPVMCTH2xthxRw4R6nZ+u9JLYHUggCSBIRQtdp6Bvr60XSGpSYzZ2WTUNL0Jr9+E/qrQcoaeyHVrk8/WmtcBW8JV80A0gvzNGaEO5xrQzOkFx4aN+d0IzREvhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by CY5PR11MB6534.namprd11.prod.outlook.com (2603:10b6:930:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 06:18:27 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9a8d:9d34:4af2:f2e5]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9a8d:9d34:4af2:f2e5%7]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 06:18:26 +0000
Date:   Fri, 25 Aug 2023 14:18:14 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     David Vernet <void@manifault.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Waiman Long <longman@redhat.com>,
        Deng Pan <pan.deng@intel.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] sched/fair: ratelimit update to tg->load_avg
Message-ID: <20230825061814.GB464990@ziqianlu-dell>
References: <20230823060832.454842-1-aaron.lu@intel.com>
 <20230823060832.454842-2-aaron.lu@intel.com>
 <20230824184807.GA6119@maniforge>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230824184807.GA6119@maniforge>
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|CY5PR11MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: ef2aa3ca-507d-4411-24a9-08dba53317db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3gSg+YKMjO1+48cEgVLercQW41cTh+Vz4dWs1R0ynU4+1002MQDa0M3lmNdCh4U/UoA4SlAiCMdGyZysL5htGkwCxPRCuabG9pyl3MiKdvMLM4fI6wfsYmBgWU1HxwOHWmGkWdrCeh/54jKL/X3t/uxwdEQKaGdoO9JU9RRIyfVj3X6q3A9S75BrkLbWm7uoxVt7xYhIaJP0eMCttBVu/0DMZgwiRFE6uigo/lb3SeBpL755+zgnf5oJIc4sYvZMasdEJ2yhnqT6TV5AijdaDTo9sfag0UtjikdHkzdeXg6BrYm6hMZGyoK6s0NkRsx2IYegyOc2O8i3PNKoGWZftFMNx7cf8bQC8dFE240TWlN0hpdhfuLb5uvGeP4EXP5M/dyFj6akffC5Q9x/T3OsZ0/elE6cpzuwTPcQ+U/2Haw5hIIXKcYddX0W1JDLGL2u49MXVrrzNLy+loh4YFLoGwrU9CyQnPxhWqHTjqAvdzwjTd1WXATtsPHJlnj06pYaCvSDDJXpI3gvmHf6my/4kjGlGv3nwPZCpp7m2IHIG75kq+y+/k1ycwW6CDmYUbYl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199024)(1800799009)(186009)(82960400001)(38100700002)(66899024)(8676002)(4326008)(8936002)(54906003)(33716001)(41300700001)(6486002)(6506007)(33656002)(6666004)(316002)(6916009)(66476007)(66556008)(66946007)(86362001)(6512007)(9686003)(26005)(478600001)(1076003)(44832011)(7416002)(83380400001)(15650500001)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Ps0UaO+PyI/VZNoPcxl5dI7AB7XdHUsXi3tRc8xjgwkDOEsYsPzLITTCKf?=
 =?iso-8859-1?Q?BtJGF0yyINleO1U4f/YFeqH7YI5PMO2RIaYhXUpeGB1nX3grvS4YTGLMAI?=
 =?iso-8859-1?Q?kuxR8qAW9eiNn+roJyNmaHqihTIcCi1199DTh3BF0nMv4PhYzPS7Lp2HTN?=
 =?iso-8859-1?Q?OxbXvIeA0R37orqWTv6WYEjIvLS2AMnVB5WM25PoUPSnS3RMjUHpfhImx5?=
 =?iso-8859-1?Q?HhbfS5EpkUg6uLZry0AzPjgvOaeeekuz+XLZlQ0HM7YbMvLv2H0kxxjR/0?=
 =?iso-8859-1?Q?zAlyTa4crccILqQrsq8w6/4qL/SOOSxFUY/FlAaGPU6RygkQVRJ7g7E77p?=
 =?iso-8859-1?Q?H25M17/Bhg5OCh3wM0dv1c0OFtfI4ysRNqwkUYJ3tPpnBb5a72nQyS1+YO?=
 =?iso-8859-1?Q?7GuofCtErKtQjpM9LB36er8/WqVuDiKG0BMMGoNWzCGTd/3+9tw8LHEiwS?=
 =?iso-8859-1?Q?IiQ6+AkOZaS+83rPK8PwxyK3KP+CfnmurhWgfRmDLwLKVnAbH7obL2jnMJ?=
 =?iso-8859-1?Q?PL8zq1VYmuGzIlqEkiMb4CgLXZXb6mNUADnT/i0NpM02FjodiLj1sg77zk?=
 =?iso-8859-1?Q?IHilPriyWUgd7uPpBPqxfxQmr/tNWQNve2YpCwEV2XFe4QfQfaZHzgRnUg?=
 =?iso-8859-1?Q?6dR7fxnvxq+6OZbhS0FktfA6AfB0SpEnf8K27nPP2p4dO8bgGGdshasIDb?=
 =?iso-8859-1?Q?4SCNKRM76WBC/T8W2aiFURgy3tbEJZtIGOSky2azflq/JrAgryYEy7JiP5?=
 =?iso-8859-1?Q?7H8/wtkQajWNqGP4BHZMbg4Yf0nTyZeJcviBD1VNu8/U30liWd38hTwzNg?=
 =?iso-8859-1?Q?98jonAYpkiBin453zHj52ok/TRP16n9TL2xaelwyp8/tA1F3FaHT1m5yMQ?=
 =?iso-8859-1?Q?61ELle3uiEW5l+p9/pz1PBILpCLKbz4n4Xdhmyd2FpKQ6znAcRHQupJsvP?=
 =?iso-8859-1?Q?/lHq+M3Z73yV3qX6TRcLUYTBsb5VGLWC14wqYHfaEclE7r9RiE0dqyPMxx?=
 =?iso-8859-1?Q?RWLJI7PmcD9jW8yz+k9UyHrvjR2lazfRXbG+/QEZtq4A0ZdWIIHIY04PJv?=
 =?iso-8859-1?Q?1lTCP9TH/4QBEbEX1MTfAEgvJ9PIBQFrbpP/mGjAIOB1e+BVVME2Ng+Fds?=
 =?iso-8859-1?Q?uXvp6/kPCB2unqP+1xpIkN2qbJuiWrvv7RE8FPnHei99gL13mC1fEAIdU9?=
 =?iso-8859-1?Q?4T7fMADIxITR2CzBajahZ2zrm4pfjxIUZFqVT3k12qSGLqklTdayc6JJ01?=
 =?iso-8859-1?Q?iFs5OB6LtcDXD0FZdw7n0hs8/AmtzAhBdVasWmI/2KmRuTyzVJ4XmiM/Ih?=
 =?iso-8859-1?Q?wKJfxJiyrOPRPcogcyS0jBT3OkVI0AYkzmgN5B1HflCOTdhBuQEb4tvI63?=
 =?iso-8859-1?Q?yrcRUBXlBdcr9sRZqgIROYGbkSv62l9BMoo+TSmKpdc/xd9bO+3NO2UFhE?=
 =?iso-8859-1?Q?VH7d0XH5CJP421pV+4OsmJgK0bjH3eXodxbRlPAMrF/H1skdVXz+RlFw7G?=
 =?iso-8859-1?Q?fLu3h3BkT62E5/timn630nISjvBXFCw1dgXYAC+IH1sq2rRbUbODXnAOpj?=
 =?iso-8859-1?Q?z1gtUIa2YeATSSFtjTaVk6TfBw4gmAi3lxPVWxNYF2QLWomSJsfzV67Olu?=
 =?iso-8859-1?Q?S1VguzjsgBkLqjVkeOS0496u0We0NMl1mr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2aa3ca-507d-4411-24a9-08dba53317db
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 06:18:26.6674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJdBbxDSsw+djsTe0p7snmk4yuPhjCwvPJEiP9QJubhr8SXKMmv7StWU6GsLGphebRi+TtWNgS2WpJm36oWGAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6534
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

On Thu, Aug 24, 2023 at 01:48:07PM -0500, David Vernet wrote:
> On Wed, Aug 23, 2023 at 02:08:32PM +0800, Aaron Lu wrote:
> > When using sysbench to benchmark Postgres in a single docker instance
> > with sysbench's nr_threads set to nr_cpu, it is observed there are times
> > update_cfs_group() and update_load_avg() shows noticeable overhead on
> > a 2sockets/112core/224cpu Intel Sapphire Rapids(SPR):
> > 
> >     13.75%    13.74%  [kernel.vmlinux]           [k] update_cfs_group
> >     10.63%    10.04%  [kernel.vmlinux]           [k] update_load_avg
> > 
> > Annotate shows the cycles are mostly spent on accessing tg->load_avg
> > with update_load_avg() being the write side and update_cfs_group() being
> > the read side. tg->load_avg is per task group and when different tasks
> > of the same taskgroup running on different CPUs frequently access
> > tg->load_avg, it can be heavily contended.
> > 
> > E.g. when running postgres_sysbench on a 2sockets/112cores/224cpus Intel
> > Sappire Rapids, during a 5s window, the wakeup number is 14millions and
> > migration number is 11millions and with each migration, the task's load
> > will transfer from src cfs_rq to target cfs_rq and each change involves
> > an update to tg->load_avg. Since the workload can trigger as many wakeups
> > and migrations, the access(both read and write) to tg->load_avg can be
> > unbound. As a result, the two mentioned functions showed noticeable
> > overhead. With netperf/nr_client=nr_cpu/UDP_RR, the problem is worse:
> > during a 5s window, wakeup number is 21millions and migration number is
> > 14millions; update_cfs_group() costs ~25% and update_load_avg() costs ~16%.
> > 
> > Reduce the overhead by limiting updates to tg->load_avg to at most once
> > per ms. After this change, the cost of accessing tg->load_avg is greatly
> > reduced and performance improved. Detailed test results below.
> > 
> > ==============================
> > postgres_sysbench on SPR:
> > 25%
> > base:   42382±19.8%
> > patch:  50174±9.5%  (noise)
> > 
> > 50%
> > base:   67626±1.3%
> > patch:  67365±3.1%  (noise)
> > 
> > 75%
> > base:   100216±1.2%
> > patch:  112470±0.1% +12.2%
> > 
> > 100%
> > base:    93671±0.4%
> > patch:  113563±0.2% +21.2%
> > 
> > ==============================
> > hackbench on ICL:
> > group=1
> > base:    114912±5.2%
> > patch:   117857±2.5%  (noise)
> > 
> > group=4
> > base:    359902±1.6%
> > patch:   361685±2.7%  (noise)
> > 
> > group=8
> > base:    461070±0.8%
> > patch:   491713±0.3% +6.6%
> > 
> > group=16
> > base:    309032±5.0%
> > patch:   378337±1.3% +22.4%
> > 
> > =============================
> > hackbench on SPR:
> > group=1
> > base:    100768±2.9%
> > patch:   103134±2.9%  (noise)
> > 
> > group=4
> > base:    413830±12.5%
> > patch:   378660±16.6% (noise)
> > 
> > group=8
> > base:    436124±0.6%
> > patch:   490787±3.2% +12.5%
> > 
> > group=16
> > base:    457730±3.2%
> > patch:   680452±1.3% +48.8%
> > 
> > ============================
> > netperf/udp_rr on ICL
> > 25%
> > base:    114413±0.1%
> > patch:   115111±0.0% +0.6%
> > 
> > 50%
> > base:    86803±0.5%
> > patch:   86611±0.0%  (noise)
> > 
> > 75%
> > base:    35959±5.3%
> > patch:   49801±0.6% +38.5%
> > 
> > 100%
> > base:    61951±6.4%
> > patch:   70224±0.8% +13.4%
> > 
> > ===========================
> > netperf/udp_rr on SPR
> > 25%
> > base:   104954±1.3%
> > patch:  107312±2.8%  (noise)
> > 
> > 50%
> > base:    55394±4.6%
> > patch:   54940±7.4%  (noise)
> > 
> > 75%
> > base:    13779±3.1%
> > patch:   36105±1.1% +162%
> > 
> > 100%
> > base:     9703±3.7%
> > patch:   28011±0.2% +189%
> > 
> > ==============================================
> > netperf/tcp_stream on ICL (all in noise range)
> > 25%
> > base:    43092±0.1%
> > patch:   42891±0.5%
> > 
> > 50%
> > base:    19278±14.9%
> > patch:   22369±7.2%
> > 
> > 75%
> > base:    16822±3.0%
> > patch:   17086±2.3%
> > 
> > 100%
> > base:    18216±0.6%
> > patch:   18078±2.9%
> > 
> > ===============================================
> > netperf/tcp_stream on SPR (all in noise range)
> > 25%
> > base:    34491±0.3%
> > patch:   34886±0.5%
> > 
> > 50%
> > base:    19278±14.9%
> > patch:   22369±7.2%
> > 
> > 75%
> > base:    16822±3.0%
> > patch:   17086±2.3%
> > 
> > 100%
> > base:    18216±0.6%
> > patch:   18078±2.9%
> > 
> > Reported-by: Nitin Tekchandani <nitin.tekchandani@intel.com>
> > Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> > Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> 
> Hey Aaron,
> 
> Thanks for working on this. It LGTM modulo two small nits. Feel free to
> add my Reviewed-by if you'd like regardless:
> 
> Reviewed-by: David Vernet <void@manifault.com>

Thanks!

> > ---
> >  kernel/sched/fair.c  | 13 ++++++++++++-
> >  kernel/sched/sched.h |  1 +
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index c28206499a3d..a5462d1fcc48 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3664,7 +3664,8 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
> >   */
> >  static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
> >  {
> > -	long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
> > +	long delta;
> > +	u64 now;
> >  
> >  	/*
> >  	 * No need to update load_avg for root_task_group as it is not used.
> > @@ -3672,9 +3673,19 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
> >  	if (cfs_rq->tg == &root_task_group)
> >  		return;
> >  
> > +	/*
> > +	 * For migration heavy workload, access to tg->load_avg can be
> 
> s/workload/workloads

Will change.

> > +	 * unbound. Limit the update rate to at most once per ms.
> 
> Can we describe either here or in the commit summary how we arrived at
> 1ms? I'm fine with hard-coded heuristics like this (just like the
> proposed 6-core shard size in the shared_runq patchset), but it would
> also be ideal to give a bit more color on how we arrived here, because
> we'll forget immediately otherwise.

Agree. As I replied to Mathieu, I chose 1ms mainly because pelt window
is roughly 1ms. I'll update the changelog when sending a new version.

Thanks,
Aaron

> > +	 */
> > +	now = sched_clock_cpu(cpu_of(rq_of(cfs_rq)));
> > +	if (now - cfs_rq->last_update_tg_load_avg < NSEC_PER_MSEC)
> > +		return;
> > +
> > +	delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
> >  	if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
> >  		atomic_long_add(delta, &cfs_rq->tg->load_avg);
> >  		cfs_rq->tg_load_avg_contrib = cfs_rq->avg.load_avg;
> > +		cfs_rq->last_update_tg_load_avg = now;
> >  	}
> >  }
> >  
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 6a8b7b9ed089..52ee7027def9 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -593,6 +593,7 @@ struct cfs_rq {
> >  	} removed;
> >  
> >  #ifdef CONFIG_FAIR_GROUP_SCHED
> > +	u64			last_update_tg_load_avg;
> >  	unsigned long		tg_load_avg_contrib;
> >  	long			propagate;
> >  	long			prop_runnable_sum;
> > -- 
> > 2.41.0
> > 
