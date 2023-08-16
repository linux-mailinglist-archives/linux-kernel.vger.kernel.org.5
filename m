Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC4477DA0B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 07:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241984AbjHPFzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 01:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242066AbjHPFze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 01:55:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E591E19A6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 22:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692165332; x=1723701332;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NVLePOugpJ+iWozto+MJnhtPO1SGf5ecO1m2LJPcH8g=;
  b=CjywhO9d+suAQfmyq9Q/6OorysTpC1DvnD0tSKE4vUe727+7Isef0exF
   Jf5IzjnOKz9R6AqWylkytdMMnJK3AsD0o84W5F+7x7ahrsc6TdXDJTm2q
   AuPrpQX/EfqMEaQ5yPIj8QYOWbzHGIn2g1qoFt7tHP0T5humoldePSsjb
   GQklUj+M0S0IEn2Tce+qOCIa3qJCmNw96D+H91FfOf85oxO/MJ5x1aN4g
   H88/g/3P1vEImOlU23AKFQsjbcJsJOImYUGq9ydswHCGFOnirFEcyo1fS
   snBJyLVMqHUnQS8L2J4wXvXYFegxCxZU5qnkVFThjMiUeyyzzyf6vHmqK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="362602346"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="362602346"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 22:55:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="857689802"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="857689802"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 15 Aug 2023 22:55:31 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 22:55:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 22:55:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 22:55:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 22:55:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyWUAEzcx32uBEBmpg8+NPoeSDgA7pOymZ4RGioR1YqwNN2Qfq6alAX/eVRdM1/g8rn6pxeXWPD8mMlvsaIcCISw2MbrSgKWHkliccBt5gnwJOCLHBae1/BUVQQXpmmtH1brWFFo9WZ5kOhQq/AozoPh/gmY0+rMGyH/QrdukOpbT7/KldrbgywWz3TCBd/pFk+8EB6SadFGM27UZpWgUjXYvdStimeY0NahaOozE/egwx+yl4f7gDrAk+xN18ykXiaa2hV0dJihLx+J7XqoU0Hq0DJd/lC06KjBzVxQpDCyyU2qLRlOm7DiKdNJRO0npFtnQrQ4I3VgV6wpMK2Gmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suQhYUtRYOjiemh4U+cDsn6xQUMCAFgL5HKSDs/+HSM=;
 b=nGP3d1P/BRpXb6ncFG9qOTq/Kw7872NS1QGu2OL+gyjt+/i1MmjiSmLG1hD0012yCEQ+SGh9W/wsWLtdJweoTpFuUg3pizvXw4M17tIvvc8TjkkhHMxUiTRJ9TT91vgVGCGIs8hywyXF/cz6QDacNIDAhJZ1T2vhltYofN4Cr2eCyfQdlJhTCuVY9GyrCKoLSmJkQ+jcXONlELNahDp0GtZtLPS34Uo8qtl00FFy2jC2h9Laq8qwXbDEOGOxNU7AEckaYMD7gm0oern3zhpOBf7vtycsMpaxE8Jfw/Bw35UsS011vCGo8jShmVKGJyiDBISJUge+BVSeZZXsUx2fxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by IA1PR11MB8150.namprd11.prod.outlook.com (2603:10b6:208:44c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 05:55:13 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9a8d:9d34:4af2:f2e5]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9a8d:9d34:4af2:f2e5%6]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 05:55:13 +0000
Date:   Wed, 16 Aug 2023 13:55:00 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
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
        <linux-kernel@vger.kernel.org>, "David Vernet" <void@manifault.com>
Subject: Re: [RFC PATCH 1/1] sched/fair: ratelimit update to tg->load_avg
Message-ID: <20230816055500.GA1291@ziqianlu-dell>
References: <20230816024831.682107-1-aaron.lu@intel.com>
 <20230816024831.682107-2-aaron.lu@intel.com>
 <ZNxTzGQifArbj4UJ@BLR-5CG11610CF.amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZNxTzGQifArbj4UJ@BLR-5CG11610CF.amd.com>
X-ClientProxiedBy: SG2PR04CA0177.apcprd04.prod.outlook.com
 (2603:1096:4:14::15) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|IA1PR11MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: ee791201-96d5-4b29-5893-08db9e1d5b6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1kNv7ED1f1YzLq6nPVFXH1AVFxqU2Nmv/zs1AL41z6LtbgGMpjn9mw0LHpEwUByD+UsnjBmIWiMYyFERmW+V+URtm/p5XgjC11wY5+x9Usnbgt1HErqhfQO91GgW6RmVXkK4cV/0zgtjeXzYEzsRLoeuz4jiv46Znz51886spVwwq0pVgIJGuaxzBfHNjMF7k5OGkrUcY1YYgq8ZSeQkWeT5jHxJuqg5rwXkEfyRDK5KNGeyrkZywDKXflWzxhJTfO746FAUqsPJYD6FGOB+KYJ9pOja9G/33BZuAngedOcwxp5faOXKcwlqqU1TGstTRJwPq2lsnet6ZUp/4J37XhetgIQbmfaC/6bcIVUilLZFfRmztT2gHmJriiZo0gSrfJyqAxigyaRUaObfrJWIvhcwJqZ+yDCMVV1N1WZ7QBWGWLJH0i5+dVOuQ5XnJVpxKf3ZB9M4uEtggDLoVIUsdQYrVA/9c/UZ3jjaWkfflYlAbNaBzI+YwH+hFdUtumaRUCtRrAtNzT6bf+89Mq1o+M/B63d9FG5ptDHk9bfS6uoTi+i7SYtna/A22mT6kWKT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(39860400002)(396003)(346002)(136003)(1800799009)(451199024)(186009)(6666004)(54906003)(66476007)(66556008)(66946007)(6512007)(6486002)(6506007)(2906002)(478600001)(9686003)(15650500001)(1076003)(26005)(6916009)(7416002)(5660300002)(83380400001)(41300700001)(316002)(44832011)(8936002)(4326008)(8676002)(38100700002)(33716001)(82960400001)(33656002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UshcumJ3cHYJ/TwZVY65WdtQmS9J5ipbkrkfoviw+ZMxlOm2JxSZVM6kFi5v?=
 =?us-ascii?Q?t7kljXTdpm3qaf/JKiQC+YtI+LfwifB/hs3hwJxLahUejas4pq3FD3HKbn4O?=
 =?us-ascii?Q?Oal8Z8bdLCsETj0ZEOdeeMjcoqnfL9W7y3ANv9T3dUD/G9daJPYH1qmaBZTL?=
 =?us-ascii?Q?YyyUm7yvFD0Sykw/DUw2C/ryUHtJmVU/IxKuX7LS0yw1hFBYKpJ9WbP53od2?=
 =?us-ascii?Q?vHbS/joSDy7ZKWdhGknPWrjW9K2hnnISvk1yxlJQnSbjvU66YlV9xorIrcwd?=
 =?us-ascii?Q?NF5WYQIPsLwHL8kwW9sHu6FQUtpSO/hoM+KRrp2Lg5n/vZ1G9l0W/+sZPdnL?=
 =?us-ascii?Q?mz64xYlTFWg/ayWg5q6nGE2uLXXh278WGlcidQ40rjlWBHe7NCgCW4KEX6W7?=
 =?us-ascii?Q?9hj8t/5cU0+twnDP8BolCRls6H7Y/XpqM4B+MRWeJd0LslyYTbxC/ny15XkK?=
 =?us-ascii?Q?WwP/M9aZh5ar3TTDdI1zuimkN4EtDpIO+Bfo/6MN/52TniFW/h/WLudEcp8Z?=
 =?us-ascii?Q?I8ymMS2TF0ZDJ2I4vw8hcNQgT0E3rM5BxG/PPvtBRJ82rK+WNdHE8dbOU5sO?=
 =?us-ascii?Q?As/dnReC6ALhTQZODx7fHWn85e7/F/wnMS52i6YueWDC1413LaYeGfy/01OB?=
 =?us-ascii?Q?g6xxtYKRM+ljkufw7esPt+WRb9yXNZn6VYTQumtjjAa3T9hQjAZlF3HIqg8r?=
 =?us-ascii?Q?eSugE67DJH4xxcNbwqVQyA+jZAWP0XCKLggApUjAAwYWOR7yCGhlXi6mZkph?=
 =?us-ascii?Q?VHKBwGKnxCvhoJO306s16rXV5P02LTx+EIzPbCsyG8ijUR/0GpH8vzG+/Bfw?=
 =?us-ascii?Q?GNQKaR/87p06Kmg3K0BdxHIpsvItZHo8VxFaTuszC/Ab5nfCg/XsQkZOCA6L?=
 =?us-ascii?Q?IpuyTWBphEXUUnOjrVBGTmNfHAPxvLXcUH1itxOFw4YJgmA8DNdFUO/a+3H7?=
 =?us-ascii?Q?jAGDYCTJDdzmagMDB2gTqWD986xFErPbycAXctjd4wRRr4B7jFXAfwoJBrXd?=
 =?us-ascii?Q?XHYCWBT62bkSK4IjrMEwG1xyy3k50a1v/MWGxu+p3sO5rCmR6W0FuMhavdAG?=
 =?us-ascii?Q?5CnBDIRHfEtW8qjLG8XA1Orki8FB/geT//zJ8ytPdB0QVyzWgzQRhv5OSEsP?=
 =?us-ascii?Q?N/dU5sDS6UXq2iurRinMaIh3436xjGL5+YJ/Z3XYg3XyQaMilqnRr2dHxTsC?=
 =?us-ascii?Q?XbXcdHLNj5Vid8XQaKaLuy/ud6yXMYXRxJ0lK64UoN0uDBh+ZS/FbTONdn/v?=
 =?us-ascii?Q?cd99S4nXjrLpOwA8DK1Y9hj7kQJBQ+Yco0t0poOqeuDr6En15w6HpWxE3a6t?=
 =?us-ascii?Q?/0ffkOWmvca2uQLZ7H/oePnFJYNzZ42EPqy3FlChacUVmqJCVu5P8fHdJ2TL?=
 =?us-ascii?Q?gtbzTFP/RR1UoK5T/YiTv/gSyv9umbQ9OZogkdEa+PpjA67ACkVALSYPC2jy?=
 =?us-ascii?Q?kFPphecNGTF8j07one+icyDhb8cUzjwCtS+nCp/tcC7xSuviRAHorjOcv/v3?=
 =?us-ascii?Q?It4Flvn1kNaq/q8dnYBn6eZnhHrVGTuO4wSVhk8oH5AKLJgUCNSqwQpDQjI/?=
 =?us-ascii?Q?AoRYg/J9vYRQ3MYb9trld+nbpN8sL6k0xW+fPrPE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee791201-96d5-4b29-5893-08db9e1d5b6a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 05:55:12.9812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ucrM0gH8nnh3U5n24ug7NqfJ7Cx8+av5hg2HimyzAOIj095XedZUy1D6vCWOOFhltB+8XHdM8bX4F0pEyGEzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8150
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gautham,

Thanks for sharing this information.

On Wed, Aug 16, 2023 at 10:12:52AM +0530, Gautham R. Shenoy wrote:
> Hello Aaron,
> (Adding David Vernet)
> 
> On Wed, Aug 16, 2023 at 10:48:31AM +0800, Aaron Lu wrote:
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
> 
> 
> Interestingly I observed this contention on 2 socket EPYC servers
> (Zen3 and Zen4) while running tbench and netperf with David Vernet's
> shared-runqueue v3 patches. This contention was observed only when
> running with the shared-runqueue enabled but not otherwise.

I think without shared-runqueue, the migration number is pretty low on
EPYC since it has much smaller LLC than Intel's.

> 
>   Overhead  Command  Shared Object     Symbol
> +   20.54%  tbench   [kernel.vmlinux]  [k] update_cfs_group
> +   15.78%  tbench   [kernel.vmlinux]  [k] update_load_avg
> 
> This was causing the tbench (and netperf) to not scale beyond 32
> clients when shared-runqueue was enabled.
> 
> > 
> > The frequent access to tg->load_avg is due to task migration on wakeup
> > path, e.g. when running postgres_sysbench on a 2sockets/112cores/224cpus
> > Intel Sappire Rapids, during a 5s window, the wakeup number is 14millions
> > and migration number is 11millions and with each migration, the task's
> > load will transfer from src cfs_rq to target cfs_rq and each change
> > involves an update to tg->load_avg.
> 
> With the shared-runqueue patches, we see a lot more task migrations
> since the newidle_balance() path would pull tasks from the
> shared-runqueue. While the read of tg->load_avg is via READ_ONCE on
> x86, the write is atomic.

That makes sense. More migrations, more overhead from update_load_avg()
and update_cfs_group().

> 
> > Since the workload can trigger as many
> > wakeups and migrations, the access(both read and write) to tg->load_avg
> > can be unbound. As a result, the two mentioned functions showed noticeable
> > overhead. With netperf/nr_client=nr_cpu/UDP_RR, the problem is worse:
> > during a 5s window, wakeup number is 21millions and migration number is
> > 14millions; update_cfs_group() costs ~25% and update_load_avg() costs ~16%.
> > 
> > Reduce the overhead by limiting updates to tg->load_avg to at most once
> > per ms. After this change, the cost of accessing tg->load_avg is greatly
> > reduced and performance improved. Detailed test results below.
> 
> I will try this patch on with David's series today.

Look forward to see your numbers.

Thanks,
Aaron
