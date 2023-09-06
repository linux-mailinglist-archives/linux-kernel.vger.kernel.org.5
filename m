Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8609779356E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 08:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241693AbjIFGjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 02:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238278AbjIFGjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 02:39:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC5DCEE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 23:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693982343; x=1725518343;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iRSFMFENOOq8YfEuc99HwTah1DHxcPWyhZfQFTwprVU=;
  b=Agsxg+2x41CUW09cy8MmDhz2mw3qXDRImbolv/8nxa++R+vand0ntrig
   gHQADnCBYmHiBpTDUDWg7/l1Rg05hYCRsXC81B15GVvGKKIBffFkr07A/
   jMvLRw778zhNyXcJuyKnJORRxqo41U4yAeNPU2GulBj9X26P5+r0UEQQm
   6Iqjz3i14zxH52oICeT7noQmEwA0QQiQqZatnr6SRVRkj/y0WjB4Fpe3w
   z3NqWMXrOkIilXG9l07H+WU+9TRITXz/Kc2x/ms1mwLlmupAY+Dqv9Wgq
   i3OrPAleGoyCF2V+6rKrV3KTvmpC8O90x36zli43RlZ8OJLC0amAaHZXl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="380791299"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="380791299"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 23:39:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="718143228"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="718143228"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 23:39:02 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 23:39:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 23:39:02 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 23:38:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJ1QDeBXIQCdyQt4sdioEOw3G4Dnyh+uKD+xHfqRyFHxcyNTpfi1P8W/s0rxR4yJ7Ju9TPbURYT+OZOLAyU8duKDS1JvUqXchmqzxd+/BmgBdSFp/GAx2ZASfZTjr5ezctpQE9bQXl/sswAjkZXwBvhyUe2vsOMyGaMN00XJMMFqhO6ZgPi9NzCFeup16MTcLtJ45uaiQ/Im1u5WNUFZxmJkHr+OaK1L+tGn/xWLGXhBeVI93mVHsxKHv3NBXmSJS2lP1xbauQsOUDzHJE+vM4oZN5JqoKtRsVXfDEasAoPvIBRIO89eHWnhYh8XYlxGhWo8LsYw0s2aZauWM8Ri1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwoqQYHte4jfM23M3LbVnQntrSbr4cyLgNXOOk9ZmtQ=;
 b=GB+HKhKyG9sMYvclSzZB7UIqmRwYxSv2N5ShwUGEOGdoEyjqO7HtbgrXWp+vWTkZRUZTQtIvZnKRO1r4fqEQdbD0SLGQ6NZkOIFariZOZLbmbyaAlAS2s39Icsj06ERwGMwa1UPcLL07tJRYSP6BCvXhKYkkYWSDGjcPDpKAz2QJsgBDCSoYM6K3K4LI1A1SKkDACdf5/k9aVJA4pC0mGPihjk0DhbjTfdUblP1SgLB2oLwzC0R9IvJObE/qYg2epwku3QlSY5JjDzy0UxMLGy7BEu9MpGKblJazwRrV4PsYTRH04Jfk4ZgZEPMq7xvYsZ8EM8Xvx50p6vaesuwOfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by CY8PR11MB7361.namprd11.prod.outlook.com (2603:10b6:930:84::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 06:38:56 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::d0db:d23:1d85:ed85]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::d0db:d23:1d85:ed85%4]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 06:38:55 +0000
Date:   Wed, 6 Sep 2023 14:38:43 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        "Julien Desfossez" <jdesfossez@digitalocean.com>, <x86@kernel.org>
Subject: Re: [RFC PATCH v3 2/3] sched: Introduce cpus_share_l2c
Message-ID: <20230906063843.GA273182@ziqianlu-dell>
References: <04be42cb-0e8b-25f7-a34b-41b2873f39d4@efficios.com>
 <c7fe33f9-51bd-80e8-cb0e-1cefb20a61b9@efficios.com>
 <20230824075208.GA459974@ziqianlu-dell>
 <6e5ff343-0c4f-526c-eb53-890afb773563@efficios.com>
 <20230825064929.GC464990@ziqianlu-dell>
 <73d2be82-b4da-f87e-a1e3-5c187a268e69@efficios.com>
 <20230828111945.GA504382@ziqianlu-dell>
 <20230901134528.GA46365@ziqianlu-dell>
 <20230905072141.GA253439@ziqianlu-dell>
 <f147f731-95e0-b0b9-9530-7028e6743146@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f147f731-95e0-b0b9-9530-7028e6743146@efficios.com>
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|CY8PR11MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: bfa22ad8-cc52-4b28-f875-08dbaea3f176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rFc0qxygLt9TUxKct8s6sdkWNmsD3eRB5On/wacoNexMLOUoog+T5AtQp6DjDCJougng7gpKT19kUmq9RSK0SkJC19MugSCKXbSLZe+HGtCA84HKykhdHqIhqOA3GK0/yGfwflYIO3VgI4sMx4cTZjZfNLnMNOxaRqLXQC2dCNjI0nRKLp/tkKsgNVhSHui/xnSSaGapFrBxLIBcOcgAqo5Dc3T1AAoEnyfT0Ndx+iPXBvsSnYoBecZnI3Pw3os6gMdgJdQD7Pa/7Nq72ve3MUtFk6iCVTyCz8wXDO5Q7YI7kDTfFsVJKvvdZ02rIwzfIzFYy+7lqauENvSC3vuHfT0R/KX8Ss6q1zzWf2McM+tq9lwiDOoLuWnQ7rnDOnfThzCeNaCKoiimzDFfrYVODUDixn7zc1VOhMe50yvczMaPN0dd1XqH4lX4vSEcB8NJ9OALTibARjWpYBwwr2hJg9289Iem1NRnzjwpWFqRglv+RMjAwgeRVVq/L31yTx1gyy4SJwJFwcd+ULRTo17QagM2Woxy+Iu/20hXD8C+mok=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(39860400002)(136003)(366004)(396003)(186009)(1800799009)(451199024)(6486002)(6506007)(9686003)(53546011)(6666004)(6512007)(966005)(478600001)(83380400001)(1076003)(26005)(2906002)(7416002)(33716001)(6916009)(44832011)(66556008)(54906003)(41300700001)(66476007)(8936002)(316002)(66946007)(4326008)(5660300002)(8676002)(82960400001)(86362001)(33656002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5z+p2DotgwPwrwJBOD1Ykl0+Y1F30fLOBc6DkDXZI6wq7sJkfStBAZvlSgZ/?=
 =?us-ascii?Q?6XoUraUF+knawA4N21hWKGUNW0KU0yDrW58J6WTmNH+Ixdl+wxx3Dk9DXYxz?=
 =?us-ascii?Q?BIeGHo6BdW1+XOX1ijeYcS4LcpLRhDA60A5wYjuRI4Ko6bN1V3+LLBs29JYJ?=
 =?us-ascii?Q?2miM20+fnZQ9f9WLTxpOXaufVmRF3uBDfIGc2bcIfYNWThc0kdgTDZp32oCr?=
 =?us-ascii?Q?B5vARksaohz+IHxTZsZzz5dsn3S8/eDcePdXOqIKrrrrz2wtZodxK/BvWN69?=
 =?us-ascii?Q?/A733+B10CoBKdBC5KbgVvDbaWVt84IyT2yknEHi+rhzdq3rWTPzk31eUXIS?=
 =?us-ascii?Q?PDLNZ5l4Zp9ne00Kzx9Ar0+WYvSfOWVE7j1kCMY+MBet//BgaUvfIkwVLhR/?=
 =?us-ascii?Q?uKhPEy5/u9x5eyxXI6fin6uAk92jgaayjbSlWpw1y/CYZMfG8luWxNSVnvOK?=
 =?us-ascii?Q?K/cT3I7Wrqw1wsLOBFEO2HFR7RfJ9LCeBw/2JtsKHH5eUcxHulFKm5suhG3I?=
 =?us-ascii?Q?+RYGiNFq7Eyc1zC/TRJxQ16G17kJkafvNTksojXdXYDH7JYvZmYenNaDhmdZ?=
 =?us-ascii?Q?0LTiz8LY16+M69VHzEa+t94SxMZ42Xtdp/yVhJW5dwAA5BL6ZtFsAeCcDp/7?=
 =?us-ascii?Q?4fBc3u/XoUL3itpShZD+iZohIwqEkUOcVD3Fm43xPZq43Uq+1E1hiFUDtgaT?=
 =?us-ascii?Q?aO34MTDb17WPSGTJyxuXBuLAmTIIda2xvzpqbNaeo2jw6y1n6TqkV9B4RwnH?=
 =?us-ascii?Q?UTN3ZW2NRpvyNYe7pbVh39U75MScTTChhZDrGydbB8Pz1sH3dVh28K2P3ZEt?=
 =?us-ascii?Q?2Pe/qdd3eNo3XuyrDA+h0BlSEELxJah7i/8fSaBFvaplyiIja24ibioR3n2t?=
 =?us-ascii?Q?athDvsFa1WbgiPQGi7nd6vcCZXC5nb0VK1dcUxPH7ko0LFC2mxHmMjV4E6wr?=
 =?us-ascii?Q?ScgqROFsnOucmjkQHeUF1yOsVsxgFh0UORjZDngEtb3m22/7xITZtpzDjtfp?=
 =?us-ascii?Q?5FtTCs51JhBdSd3T3CUWATPuRswVWLPGnUIYZAPfSV6ZlnuakK8p6gTVi/Kk?=
 =?us-ascii?Q?L6S4RFLhexU6OiC/BB5/sOMO5mSCeYmckzutqJ7o+4Wa2tqRxU/fFa8fmwpr?=
 =?us-ascii?Q?KUOgZl243uXVoiJOHHJnkAVQRmvf51Qlwq7KeoldWZCZoKIwzLBIFgJc7Ynt?=
 =?us-ascii?Q?WR0BsxFMrKok7JWrSEBY5E9V0fBaAAM5svmMtY0tqtoSlaOUoG1GpIfZwP/f?=
 =?us-ascii?Q?o1MY7TCaRkSmcTQnaLVYZ5+q2m+/b0Cuc9ZwU8RtouKskHxw3hfKcQJzeKYN?=
 =?us-ascii?Q?ZUI7xiJoBiJdbXDYtbHy+bV9VNU+wpEAf+doDk/7R0Bo1Fxu0scMkueDS86Z?=
 =?us-ascii?Q?XZI7EZVGYQ0VFYWfytfBw+nyL+iBM4H9t/U1TvewXTJt2QA0CvBdAj6HPEBq?=
 =?us-ascii?Q?gXkoead4seaiwNc3XUeMrZz95ziq0TJYLTY0VHLeKAxnkSbjWIbpo4iwGoPz?=
 =?us-ascii?Q?uHAF/ySMdz+2QT7+FPffOlcJGFzUYBdQz7L1/cyPVg2uNYaie+tBj3KiNzj3?=
 =?us-ascii?Q?onnN3WetUVA/ccSHytpWBE4W2lhnM/wKgWGbhk+M?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa22ad8-cc52-4b28-f875-08dbaea3f176
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 06:38:55.8862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VOI/gahaYYYeW00guFHbrkP7m4GzH7lZ6MevDrtHEpgxmO2UofZX56eF+kdyraroAzhrGKXowwmDY0cSQGn5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7361
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 08:46:42AM -0400, Mathieu Desnoyers wrote:
> On 9/5/23 03:21, Aaron Lu wrote:
> > Looks like the reduction in task migration is due to SIS_UTIL, i.e.
> > select_idle_cpu() aborts a lot more after applying this series because
> > system utilization increased.
> > 
> > Here are some numbers:
> >                   @sis       @sic     @migrate_idle_cpu  @abort
> > vanilla:       24640640   15883958     11913588          4148649
> > this_series:   22345434   18597564      4294995         14319284
> > 
> > note:
> > - @sis: number of times select_idle_sibling() called;
> > - @sic: number of times select_idle_cpu() called;
> > - @migrate_idle_cpu: number of times task migrated due to
> >    select_idle_cpu() found an idle cpu that is different from prev_cpu;
> > - @abort: number of times select_idle_cpu() aborts the search due to
> >    SIS_UTIL.
> > 
> > All numbers are captured during a 5s window while running the below
> > workload on a 2 sockets Intel SPR(56 cores, 112 threads per socket):
> > hackbench -g 20 -f 20 --pipe --threads -l 480000 -s 100
> > 
> > So for this workload, I think this series is doing something good: it
> > increased system utilization and due to SIS_UTIL, it also reduced task
> > migration where task migration isn't very useful since system is already
> > overloaded.
> 
> This is interesting. Did you also profile the impact of the patches on
> wake_affine(), especially wake_affine_idle() ? Its behavior did change very

For group=20 case, wake_affine() and wake_affine_idle() don't appear to
change much on this Intel machine, in that target received by sis() is
mostly prev_cpu instead of waker(this) cpu for both kernels.

But I do notice for group=32 case, in vanilla kernel, the chance of target
as received by sis() becoming to waker cpu increased a lot while with
this series, targer remains mostly prev_cpu and that is the reason why
migration dropped with this series for group=32 case becasue when sis()
fallback to use target, this series has a higher chance of not mirgating
the task. And my profile shows for vanilla kernel, when it choose target
as waker cpu, it's mostly due to wake_affine_weight(), not wake_affine_idle().

Thanks,
Aaron

> significantly in my tests, and this impacts the target cpu number received
> by select_idle_sibling(). But independently of what wake_affine() returns as
> target (waker cpu or prev_cpu), if select_idle_cpu() is trigger-happy and
> finds idle cores near that target, this will cause lots of migrations.
> 
> Based on your metrics, the ttwu-queued-l2 approach (in addition to reduce
> lock contention) appear to decrease the SIS_UTIL idleless level of the cpus
> enough to completely change the runqueue selection and migration behavior.
> 
> I fear that we hide a bad scheduler behavior under the rug by changing the
> idleless level of a specific workload pattern, while leaving the underlying
> root cause unfixed.
> 
> I'm currently working on a different approach: rate limit migrations.
> Basically, the idea is to detect when a task is migrated too often for its
> own good, and prevent the scheduler from migrating it for a short while. I
> get about 30% performance improvement with this approach as well (limit
> migration to 1 per 2ms window per task). I'll finish polishing my commit
> messages and send a series as RFC soon.
> 
> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
> 
