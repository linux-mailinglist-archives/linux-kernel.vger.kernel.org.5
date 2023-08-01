Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D1D76AA29
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjHAHmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjHAHmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:42:21 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CD0E4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 00:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690875739; x=1722411739;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=M10su+juxIhyhcvveaBNBnycNvIbZFFGgV8ljSp28vo=;
  b=ReRzMA3HzjJOsRGYQ1OBB/AD+iRdS03Uoji1VBJbycecV1fMsCAr8y7w
   JcUxy57+WBwJ/haPh8C7AlkdgCsWqHixEg2nMKC5qKAKqvGhT79b/flKV
   IxRVpvBZdeAkPymHc6kj9G0vhI/xuYLCZcs2N91DU/5XyOawHK02Uws8B
   7CIRvm2GgynjzUX8n9yy6pTKX404pJZ2SVXF6Rdabkv8Kb0rX9nGkvohx
   x8BT1WPGJE+RwdQV8vrFUrovEPdwiNjR0ThQBlCjFPp+EHxePehfEjG4N
   QvkXELcU8avn50090AD0PpgKRPiiqN0sbpvXuyRj0DHi4EUZYb2ISMNhL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="349521279"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="349521279"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 00:42:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="818700818"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="818700818"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Aug 2023 00:42:15 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 00:42:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 00:42:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 00:42:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmu49uxWugopxvMxzazV2/T0F6GvCCM+sGtCfChgGcEmn14+WnWPiJtzvSP49r9MAHThkG7go19+Zs8Ua6hu6vOBSEiEuwer6lin6KmMNl8L+B0lqrEOaQioDYWPrZvyOUnWpoMVpH18cd3Q/+BSgHQujiui+sdSvMLZCoT6CBhJnyB1aIJcAxt6tTX7Pm7gpFa2avFgNmafIAi9rYSMvZm1Z5UmjRp1s9B/ObyaXSZ+iyO3Ns2LE1AT5X7hvXaloe3OMftwN3d5giw7LEY1N1VdQFCER7/u+Ld0ibS7NyNWOUaw7nSPxiPyJkGSgQdDiWU8tKZCfhKwGTgguskpvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eTmCAeAzvb7HWdak8gUZFSVusC7sBmyK+30dpB/usM=;
 b=MYFUXmaKqiOPEcn4YEANRgp+Ztj8gUioiAZOaVfZq7nVmA+zFf6bdld7y/bkiDlR6FXRaX6blMZKgusntHWrQZ0KArPQst0tcwwKVEDd44lvOBrj59+sRtZdYroEvjAuGXYwXALNYl5KU6QklycWa+/76IwmTYCthJVTZLr+uC2DljoISpS7ZQoZVwli69udNTHcz/q+86V5Xhr3GxDGx3V+b3+KXKI12XcBxHrp9lCbRLzCXEetUJ1OP5LV1cdiK6JW3Ul6F7w62oUWJFa2e67jXqmzajV4WpHDVOzzWQyd67h7RM5OpSJ/GS3+lYKA3wLxCjASnPSOgfVjhVqycw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by CY5PR11MB6342.namprd11.prod.outlook.com (2603:10b6:930:3d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 07:42:13 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::d4:a7ee:93ca:1a7a]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::d4:a7ee:93ca:1a7a%3]) with mapi id 15.20.6631.042; Tue, 1 Aug 2023
 07:42:13 +0000
Date:   Tue, 1 Aug 2023 15:42:02 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
CC:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>, <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/1] sched: Extend cpu idle state for 1ms
Message-ID: <20230801074202.GB20269@ziqianlu-dell>
References: <20230725193048.124796-1-mathieu.desnoyers@efficios.com>
 <69076f8e-191b-2e3e-d810-ea72d8ff18bb@linux.vnet.ibm.com>
 <79fa8a62-a74e-2623-9f03-1f1af85b6c07@efficios.com>
 <ZMH6zVe4ezzyoNxr@chenyu5-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZMH6zVe4ezzyoNxr@chenyu5-mobl2>
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|CY5PR11MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: ee79ee8d-67a2-47e2-d256-08db9262d1e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B/P+tKnutvYk2bq74n+pPr0dN/VRNlcVzZAzDs2x/Q5grQ/HZZslYYbdqO4rdWsSegCRIWWhuDFpW1xgzuxvYUatX0tcWXswBAwNgMgD8g4WdqTFwWg3eQwx21M5lIWp7vqTlpycIAPEHhQHlWwAK6B5sUXk1Un6eFFg5XP5Kf8sxa7pkIt7ZJxVQvwyf8hei4MJmWnVT/m/XLZOtC0uTGtCClIgtqYebJzYyXLQDbBPAETf4IqvTMBdQiyyChcP5nqPmx5iPhfH5NXZBhyUkqjE05b+chfyjOwYqVkSvf9syO+MdpmGMMy98vyxXbML0Fq6y7GzTDm/1Rlt6dooL0D+r96DQF9R6h5rjPTc7JWmToKqy44z6q/V5mCL1wofkSlmK+chWeNNZARoHVZ0V/G+/tho+AKqcba7OTULU2VytEpu09+JlkVMLbzvbqzT0cydMHnKk+J3fx5c4eqnKQiH5pOjaTKW8TM775JYUJ0StUrK8YhW7d2mhFRctHOvOGYP9STk7h+UoFELHi7WdNTLQe3ug7SBU3tQg3dsulU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199021)(7416002)(38100700002)(33656002)(1076003)(6506007)(5660300002)(53546011)(6636002)(4326008)(66946007)(66556008)(66476007)(82960400001)(54906003)(6512007)(9686003)(966005)(478600001)(33716001)(2906002)(8936002)(8676002)(6486002)(41300700001)(6862004)(186003)(316002)(86362001)(6666004)(26005)(44832011)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fYPi+oeNEwu51/PNBUInNJLH1ZxliwPwCHZrARpnT2jwTA8fxs+pM/YCuMZA?=
 =?us-ascii?Q?kglOXK4mmqyJuPxPiB4yPPZUga0DrKKxm/4o4FbP97jIuYj1SF0l5Ehxkmk6?=
 =?us-ascii?Q?GojPw+Qte15OuDTVemdRPE901FGaHSWQVsL9NuHq+H8hRME+/EQ5t7eZ7Gxf?=
 =?us-ascii?Q?4jqTrHvNZms1E+yYHGA/WTozxajNtCRYD7f22z26MA8Ttn7a+tEtG0gZZuCz?=
 =?us-ascii?Q?+gZ/tG78Db2d9fd1/MjtkLypjeYOTd65OTUpmmHuFiQlIDEOrMScKWk98uen?=
 =?us-ascii?Q?4F0wKDS2rw5n0O+9C130ye6A7Wwiztb+IiCseSeQ677e5WQgeMc00dJzNTfR?=
 =?us-ascii?Q?d8CsNS8w0zrUVfPrOn/RAmf0YOZ86wohjyEZpjqCUUoR+Y89EUI9wK4Bjv1x?=
 =?us-ascii?Q?G4VqKrYkF8M2l0whqxWD6xFaiL0eAhye8HcMVKKOV+6vsgP7tyHZNI5Hhu81?=
 =?us-ascii?Q?mJKKYUvHogsEdz7JOlhLF58bf5osBPTh5a/fkNRbOwWj5pWGBh4i9LHyomiG?=
 =?us-ascii?Q?dOnKWIncM2cYK9LqJATSiNhg/s4qQeVLpWyFNuqMHcXNQcpVam0ELP226bZa?=
 =?us-ascii?Q?k1Jx+ciBFsDHlAgXs811SV9+vmTEVnaIIiHmC2umyfZUvy+85YLtneaTdhxa?=
 =?us-ascii?Q?VGYg08ezKgohLKvALPVMb/xhbU6oaPHYLtHSU46OZhnYaysk3P3+q5YmACn0?=
 =?us-ascii?Q?orFsJ8oi+WQdWIJMaoE/VygCwjPjg7Lo/QN41LjM0cT3bDP7JAFOG45jMtZa?=
 =?us-ascii?Q?efrXKrnE3v8XUvtIe7jSwwkHLel3I1psIM0T6rH28T3UQODwqUoOWBlYpNt5?=
 =?us-ascii?Q?wXPMXxwc5TiWLp+xKc2oQ4hpNsAdAzEuCACmzRkhPAo9dw0Kb41QfDCkwBck?=
 =?us-ascii?Q?2lWj6aSeKAtHbb+TYWJXb7T9xFBylyqxm47z5LpkSwVYu21eHjnW7RJA8NUG?=
 =?us-ascii?Q?hiinXvkFNx05aj2ip+2zo9RkGyjbW5gp8rYwfNBgfopL66vRY88FhTo+fnJk?=
 =?us-ascii?Q?vAyQajlJfstmstM4i2L6sitW3nMEyIzLjJJw/MPYXilCPOlWICGtLy/LwFKF?=
 =?us-ascii?Q?LoZm9bIL8FU4uzcJmxLp3ro46zgS1rx4BLOGuUVuNyeCeu6TMe/cKBzVzPnt?=
 =?us-ascii?Q?Dy4wSuzmGTv66GwjSDVvmcWhMEfidgTR2FwtCmiN6XlYfQkGPXwIsydZmtzs?=
 =?us-ascii?Q?jtOfYDNV7BxEid23v02xzHG+KDIsp9BMHoawvwdcwvfApkO5YiADUf9fwpEk?=
 =?us-ascii?Q?1P/0lQ6yEEgxM+AR/Zbu5AOj+YxkUH735SJzvtPhWsYMBmCNO94FayXFbLnw?=
 =?us-ascii?Q?WF1ggN7oL50weeOnM6qdZ9d+XS3xZZYCUrqE2ltohhXlxxuO7VyVytWmFfub?=
 =?us-ascii?Q?2OawmiPV69lvoqE9l7IpP2T/vpeJsy3aISazKX/T5q4BLJg2bKxOLhyegvNq?=
 =?us-ascii?Q?6wIomIjr0wuvYFHQtP5VkVqY8zIm2XgYwxDSYM68PBmDXSA7/FwpT9YF1jpY?=
 =?us-ascii?Q?0DWMZfoA8V0hHkfEfaqWT+z35tyEimOjSI7n7uAkwfJOzBQRCe61g7Bl49d+?=
 =?us-ascii?Q?aVglYy3rWRNoTFef4Y/0DEOuW8/Jlj5EmGKgpi6B?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee79ee8d-67a2-47e2-d256-08db9262d1e2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 07:42:13.0072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1mHx5PE276/XUEAzuzoH4XzcRCjnjsR9CYLRqaPZw3fQNxfjHTwXb5keczbu34O+Hm5HpTcdAS+qdeIjPGAjjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6342
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 01:04:13PM +0800, Chen Yu wrote:
> On 2023-07-26 at 10:07:30 -0400, Mathieu Desnoyers wrote:
> > On 7/26/23 04:04, Shrikanth Hegde wrote:
> > > 
> > > 
> > > On 7/26/23 1:00 AM, Mathieu Desnoyers wrote:
> > > > Allow select_task_rq to consider a cpu as idle for 1ms after that cpu
> > > > has exited the idle loop.
> > > > 
> > > > This speeds up the following hackbench workload on a 192 cores AMD EPYC
> > > > 9654 96-Core Processor (over 2 sockets):
> > > > 
> > > > hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100
> > > > 
> > > > from 49s to 34s. (30% speedup)
> > > > 
> > > > My working hypothesis for why this helps is: queuing more than a single
> > > > task on the runqueue of a cpu which just exited idle rather than
> > > > spreading work over other idle cpus helps power efficiency on systems
> > > > with large number of cores.
> > > >
> 
> This looks interesting. And it does help power efficiency but how it could
> improve throughput? Is it because of hot cache locality waking up task on
> it previous running CPU(because it will be easier to be treated as idle),
> or just reducing the time in select_idle_sibling()?
>  

According to my tests on Intel SPR, part of the reason is reduced
migration cost due to tg->load_avg. I think it has similar effect as
your previous patch(wake up short task on current CPU):
https://lore.kernel.org/lkml/cover.1682661027.git.yu.c.chen@intel.com/
Both can reduce task migration somehow.

Thanks,
Aaron

> > Good point !
> > 
> > Can you try your benchmark replacing the if () statement above by:
> > 
> > +       if (sched_clock() < READ_ONCE(rq->idle_end_time) + IDLE_CPU_DELAY_NS &&
> > +           READ_ONCE(rq->nr_running) <= 4)
> 
> If I understand correctly, this nr_running is to filter the case that the system
> is saturated? If that is the case, maybe 
> 	rq->avg_idle >= sysctl_sched_migration_cost
> could be checked in case there is 1 long running task and we don't want to treat this
> cpu as 'idle'?
> 
> thanks,
> Chenyu
