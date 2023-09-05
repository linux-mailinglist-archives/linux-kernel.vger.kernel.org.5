Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7BC7926E7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348804AbjIEQSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345060AbjIEEAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 00:00:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A41CCB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 21:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693886403; x=1725422403;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rqaKKAgX/n+VJuW4czkw2ATEH+f0XVi+O2DFbQd1ilc=;
  b=It7GRGC/9PJV6sSZk/segzLU0SV3Z41iggI7JSXPZS4p5XUL0EvIMySh
   tEbOnmxMViC6bwGlLFZx8a5M46y5s95Z2wXET/fPyRUoXCSAhsC4jjXNW
   fJ5UPEaqQYbYmdVu6mbIyDpCI5EcydpdClMwlDlyku1slUPiEikH1dcL0
   r8S8PGtYbdNZnTJPhgirekRdzbUBAA3CQUgZaQMKn95Yy0LUVSXArY1hs
   iq7JmPmoS1OHEzOi5U8IxRZ2626GVbbarA/gc5b3X+jQlFQD8Ohdgm0O6
   X9tUsoBUHksutS75TBImH9C06sViEP0SFF+xQvHxvNxBDAwmfPbSinWne
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="357005475"
X-IronPort-AV: E=Sophos;i="6.02,228,1688454000"; 
   d="scan'208";a="357005475"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 21:00:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="770180327"
X-IronPort-AV: E=Sophos;i="6.02,228,1688454000"; 
   d="scan'208";a="770180327"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2023 21:00:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 21:00:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 20:59:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 4 Sep 2023 20:59:59 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 4 Sep 2023 20:59:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrY1opugXpM9m05pzps3YsdzTqcV5GcGvgLCF8ge2G7QGB7UrdANH4LNkjc2DBFBSxo/MyMCUmgB1PxdhCeb/YMx2ErBbW7lGF8LQFT/cgzl81BmPOEfrXinDu8HpWSkpXGWr/dTRh3J0UqgN9Tg++jWHGQR4DQrWOHp5De4pW7usBd4Pl+TQyDPkRxVDUqzoOFgYBjN7+MU2Q0V4uQ858axGIzVPbCEE2VHowfm3/q3rRNRIeHgtj0W4KbbW0jrhHzbcMraewXyDiIxw0eyZn409ktKfoa0OYrHInXS+1r5gyNfnk0LolBdVTK7l5jvJUcXLOiTzqggkj8WHbxTGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4+fPbD3s6qYp9K/KauB4Cl9Al/cPkNK0s/hiHi7oeU=;
 b=LiAyNJZBmjr5mhHkiDtnkRMZ1T/TaKDAl0fWe8Ic4u3rjpcNi0DRmhZpNg9ScrPazwTPpDrEbiDWX9xU4AiouL85raz7UT2cVS/JYhMom/DtKVPWV+28xASQWBAUc5hGN4YKX9o32LRcdb8hbi/rd/FBFLDO+ODcWLCo68lQgLAxg572tTt5sC28jMtemD6ukIuueroTpp3nG+Ak24O+QEubGMNIjn+zOuNsQ0zGZOzRjrSJIad6l+c4u+UdzNC3qKdyjDGgMWjBtOd6/DH2tVeaNb7bSQYBLwCab3giDp/MkeQnGvSPWtHhUyN46YKkOuGBcQNiRUVk/w3jvhNWXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by LV8PR11MB8510.namprd11.prod.outlook.com (2603:10b6:408:1e8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 03:59:53 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 03:59:52 +0000
Date:   Tue, 5 Sep 2023 11:59:38 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>, <tglx@linutronix.de>
Subject: Re: [PATCH] sched/smt: fix unbalance sched_smt_present dec/inc
Message-ID: <ZPanqkKa78ls/kel@chenyu5-mobl2>
References: <20230902074609.1757507-1-yangyingliang@huawei.com>
 <ZPVATM5xfmiFKWtk@chenyu5-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZPVATM5xfmiFKWtk@chenyu5-mobl2>
X-ClientProxiedBy: SG2PR01CA0124.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::28) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|LV8PR11MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 91f43809-3b40-465b-3267-08dbadc48e71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GYWXbMjAzgirP1ct3snqDVITsKK5IQhnfZi2+eDd00l0d/MAEM+zvCus5iFY0Ma0W/sNeCAOJFbEA0Nd82BZcumVb7aLomHULCHcRz44bHgcS9p1I9s9tMiqT8SEtuUBPkHEPbZESrGms/sh9S3vB2fsDXRtmdkjzuOmkjpZU3foJ41qCiPdk06uCvjDqKgV4DRD3No9igKgmMxLp3b8CtjNoMJ6vUXvSVqP2b5H/cM7TXfASE0pBT7Is75MSr7p5qCyLlwyyIdIdMUwgRSUn6jCUTdOVwZFLOikNnaA2JjKym4xrzB9drrWePUOvFaTT5tX+3liPf8Ry8BR/0A7OAnP3tiycvStwAGAY8RuWv4aAAs+/xln9A8u1aAtCm90Cdb+hewiEW6R8xFQKqu3JVk/fm+oaIlalNbaZLgc4Kp95DApj62mRYWMeKLrKml6yIZ2rOoDHVF6mP1nbVCr7U1RcetBIHECHFkbI75Q8E+ZwBCEWMA7vwzd1bPkgU0c08qPcU4FYKtAxfWD6/Jb0qFaYpyojBIAYj4pbz+M0dAeRIHwXVzWV4h+b6k/F9sg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(136003)(366004)(376002)(396003)(186009)(1800799009)(451199024)(41300700001)(7416002)(38100700002)(82960400001)(33716001)(6666004)(86362001)(478600001)(83380400001)(26005)(6512007)(53546011)(9686003)(6486002)(6506007)(4744005)(66946007)(66476007)(66556008)(2906002)(316002)(6916009)(5660300002)(4326008)(8936002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9UW4XamZL7/VAfLD0NeP9SbChMl0WTio2xEQoscWV8X4Uz/6+xtpbqS8q183?=
 =?us-ascii?Q?qFEnl0jUu9E5uBq9oK0xIGGzNtb3vE9OIfwiu4/Pt8NF6u/OjEaWtd/IkQ13?=
 =?us-ascii?Q?jS0jGMMuF5brXtljoE91+4yELVnikfIYn+jr41YbRok0V502XfKVoLz996r4?=
 =?us-ascii?Q?Z1/1PdXtsj+7Gix51AjKg3Iij41BZkKO2EKfA/ZmfBnsgyP7b+B/RMCrWaTd?=
 =?us-ascii?Q?Y0YY1qc3NDBAjVWonKH+f6TiN3kSqe2mxVdKTjAZ+4lqE/iTVzDQrTSiPiQv?=
 =?us-ascii?Q?NORMBmTsPFq/c5VMt1G7Qo1BvahOH+tL4q8zXiME2R5xhPjDqYSb4PPLVDTb?=
 =?us-ascii?Q?fvSSOqRn26Nx7atyEr/FP1cyTAbUphA4PFsqabXE6dSp6kzXG59aGiu5q/MN?=
 =?us-ascii?Q?zPFohc/jO4qRNmOLYwP//j/aOLeCcVghp5sG9uD+qAoexka6drt9BH+nLxAq?=
 =?us-ascii?Q?+WxguzkzMmv8Q6nUG23vhpikKc0s0VNO9tK7X76vrCkxCWeWvDeVUKH0DkZV?=
 =?us-ascii?Q?b5OUFJtC5MUfCwZZDTS2QIOcVqT74/dyUwFMRhpb9LEzYisp19J1qtufqWMC?=
 =?us-ascii?Q?4zgfpHI0FxF9FXA0ueErsOcoqmGtLYDpNgXyajbcyQfxWl+xKc0ZvZqXwVff?=
 =?us-ascii?Q?T69fuzn7JJMn8Ikx2ai9OimQlyAjX0xaLzRgvOOv7iUciqNifiNHtKrDa46m?=
 =?us-ascii?Q?R/hRZmXVndmjlUzUsd7vnIy009rbUCnfqNkbYffd63jvM7v63NM6IEh9a5rA?=
 =?us-ascii?Q?rfPoFzkDiJdc+RTzuJaYZSHh/Cb6ka2bymrOtfw1QYv1jaPsrNesbL90P5Av?=
 =?us-ascii?Q?zdl1YzhvrwePyRrfrIl7+M6RQYgO5V3ubjXlc0KHxGd4i3v8wU2lWIVf6KGB?=
 =?us-ascii?Q?UdRsrNUScMs+JDQoUcTtFoLyZe94m6BQOBWaer/SzQ3AvT9d4hn3UywDgN9o?=
 =?us-ascii?Q?Fy+UIn6yTxEvgboEcSXdc8Pa5pP9Xd1hGjTYsdpvHkEQGwF7t+R5YT3noLZx?=
 =?us-ascii?Q?sYUMkN8p0rB5JeAF49R7pxBEiVH/+Kc5JkNmqFB+tDy6lLd8qqws2EKFn75V?=
 =?us-ascii?Q?pGC4NV2z9G/4qAWmX+Wws00fw3gYUByninuTHe0RWxQbsfVmj0diPSqYFeW2?=
 =?us-ascii?Q?L36+SAXbIwqPmRHk0l83cRGkAI/Rcma/+Otitgy2iQ+OxcE7+2I3r4gOxYNZ?=
 =?us-ascii?Q?gkNKSrdpMtNtPpa54JxpnzeO5JzxwF4/eCieJP+PgsxH7S+Wc8fJpW3DB+7Q?=
 =?us-ascii?Q?UdJ14od7NuY6wjfPjm5VQ4+0Ize7jsYSVa+3/QDKtvjkOlCDJ3O3So09sbPI?=
 =?us-ascii?Q?KSMg6OdKKLOEgm1rv2qgggUBuwoIsZttuhaGe6ViydrPtDqGocACb1ZXqlG7?=
 =?us-ascii?Q?95WfBOoNYlcv6dhGDSPHC8Y1+jFBnowJs3PlHbfPt3GsjwUiLZtmgx9PoBlR?=
 =?us-ascii?Q?x7rcaWP4ggZk2KUgtYXgkYX6iCnYaN57qkqcuh077BX4FB8PITHV6seEvSc0?=
 =?us-ascii?Q?Vp2Xmi0m+I2gBhJnfDnlePHeuLVc30sCIJZuqJgJF2YuF0zcby15Yp496UDl?=
 =?us-ascii?Q?+SgfPLftkJwfaD38PgBszUbTADHCz2q6FdF4fu+b?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f43809-3b40-465b-3267-08dbadc48e71
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 03:59:51.9948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DACC7ZT4xrVM4MJVPBOQ3KrLUn9zHsy+Eff+appkrI1+MEpr7AOmacBGUL5iscavmCADdZNjc2xLPiZa303l5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8510
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

On 2023-09-04 at 10:26:20 +0800, Chen Yu wrote:
> Hi Yingliang,
> 
> On 2023-09-02 at 15:46:09 +0800, Yang Yingliang wrote:
> 
> While checking the code, it seems that the core scheduling also missed
> the error path, maybe we should also invoke sched_core_cpu_starting() to
> restore the context. I'll have a check.

After checking the core scheduling code, there is no need to restore
the context 'broken' by sched_core_cpu_deactivate(). It just tries to
find a new leader if the offline CPU is the old leader, and it should
not have any impact to switch to a new leader if the cpu hotplug offline
fails.

thanks,
Chenyu 
