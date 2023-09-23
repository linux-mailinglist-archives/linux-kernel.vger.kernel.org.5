Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9F97ABE1F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 08:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjIWGfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 02:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIWGfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 02:35:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162F411D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 23:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695450944; x=1726986944;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RiduE2bAto+3L6H2uyNc+Um8DxpUi2MqoCPgdGXZNj8=;
  b=AcFc6fpgxCLXKUocCTtMLNcTcoDLy3P695q+VYx19jwjXrUykx6RQ8v2
   FSCSUQPuK7LaQcrpGY7pbZUdc/YC83td3SGg/tRJfZzQt00KAS6x1s9V6
   eBvuW3xYKOzHrVqPgaoCCUPIuR3lrUU0ATJUnuL2lWGpuO5x/KRSW+Rs7
   Hzcw/VqB8ES5vVZ6K2qiI+zebjNdSXstfBOTyhu7qVuIME8Ia6FbseGpc
   8Nk/G4dhHuEJ/VYJkUa5A//zw34wyx9oZHb+O71h0Vlm6wSKolY77T96H
   Mai9GWBUdbNGyfj8OZRpFVwHEU7G9IxdE7wgkQ9uLGncJHLuKfK7Kzurk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="378278431"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="378278431"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 23:35:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="863217807"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="863217807"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Sep 2023 23:35:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 22 Sep 2023 23:35:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 22 Sep 2023 23:35:42 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 22 Sep 2023 23:35:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKWuGtWSjPAQk63aZg7pTZG3mgVCwyqPzTIvbHb01rjI3JmmfqDM/crB7hZhJfS089KpGzYGf8YbtpB1uY7vf52KXeEQ4NZ1CYzwV0OVnwUGdCwSJxxRVQegIEwtvA3PGDZjzTWzq8ZiQiIPRrW8F25M3ctG1QtcvsAyKGGYBBXRTo22InBq9sjcVDc4aZ8/BVT4uHQmHbf7XF3u3PkZ4CvXRuAWeODMZv/StL9qVgfk0zseya8xmzhN1632gLBSVR8Rek4vniuS14jjsY0S4C5PQkYHk5EZQGN2HLJdLR8Et3/Lut7Wgra76h65H12kT49/dktW5U8aK6TRGZnT4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZU4H3LhSS5ZVim+Bq6qD0+mFjjTTwkGQyUoU5J6KBQ=;
 b=KtHqSto2g5Ozl+E3OL11pAVV3ZbW8TZ8l/nTPUiwGp+jLugshp7g1Y3/i9DunxZwZn6Zlpcgjnk32NmzpT+zkyWlJ/g13UOyMJn+NjlHoHV/nj0WJ0n5/h/dheY4vVOn4ycTSAt4eeET/6gNk+PaBpMR9FxwsQRZLJcjeXvOefyKNY6Zv5htrrEmjjrEttGmUJiftp0arfXH8ckVcDoHC8RmI/TvrwBCJuuXJY8D7k6z1JDZsMBOc0YZ0m8bvI44FAFCOfyx1e74XUd5P1GPhdGDV9ryQZs1XUvHXIN/mNZuR/7ESytjK3YEneGYvDLYybY4Ep6hAPTR60rTLCZBZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH0PR11MB5141.namprd11.prod.outlook.com (2603:10b6:510:3c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Sat, 23 Sep
 2023 06:35:40 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%4]) with mapi id 15.20.6813.017; Sat, 23 Sep 2023
 06:35:39 +0000
Date:   Sat, 23 Sep 2023 14:35:17 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     David Vernet <void@manifault.com>
CC:     <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>, <tj@kernel.org>,
        <roman.gushchin@linux.dev>, <gautham.shenoy@amd.com>,
        <kprateek.nayak@amd.com>, <aaron.lu@intel.com>,
        <wuyun.abel@bytedance.com>, <kernel-team@meta.com>,
        <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 7/7] sched: Shard per-LLC shared runqueues
Message-ID: <ZQ6HJW8TnmOWAKC6@chenyu5-mobl2>
References: <20230809221218.163894-1-void@manifault.com>
 <20230809221218.163894-8-void@manifault.com>
 <ZO7e5YaS71cXVxQN@chenyu5-mobl2>
 <20230831000147.GA506447@maniforge>
 <ZPBvN9W6RYOr51zQ@chenyu5-mobl2>
 <20230831191444.GD531917@maniforge>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230831191444.GD531917@maniforge>
X-ClientProxiedBy: SG3P274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::23)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH0PR11MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: 19bc0c7c-a4af-46c2-ea18-08dbbbff4c1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KT5HRwwmKF6nBRY31kox4fOBbITWMDzw8/q+0pOrYtepPlQMFPkBzXQR5bx7dE4RvzXdXZi3gyZMEaeSUW//3+9c2w0WFy0P2v6tMt41Co/AlcVXZApIxiz4bK/6KBwQIdu0ePYNKSjTMgc1tWmhBNOCfF5xOA+2qVI+9Sp09+EwaLJFCL/jwjZj58cCf3p2arhb0FiiNzU/NeAy7E+fpn+eOJm7CcYbTQw1/8pWtTkjDxzQZ1wcyag/eIqdl6CIM26kxW34hVt0z7NcorEl8H1SFD4skDHKMBnnkG7k3xDozMKcepEan3BmOMzO50lp67TPa00H94KjCxggg2gereBg19XfaZ1A/FRzc3SnqhdfRKPMZmWlkJ1dHFKBYQ8+jRTJAMZxmqBRG4VUUWTLTrnAptETPAKFXCfe7rEHIyOjQZUYNdrfCNyvrWPwfi9dy8zWK1fCvpaIH7EiIqoSXOuE9jIIhQvUqEIc0Wjb/Zfm+Sq4zgEm0+si8RiUDBKKiQz0EJQPrgMYrfZyeO62T4UyPq0LzsgOgn5//pgmHerSPS/8lT8JNt0BFdz2IlE9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(39860400002)(396003)(136003)(366004)(230922051799003)(451199024)(186009)(1800799009)(5660300002)(107886003)(26005)(41300700001)(2906002)(33716001)(7416002)(38100700002)(82960400001)(86362001)(4326008)(8676002)(8936002)(478600001)(6666004)(6512007)(6506007)(6486002)(53546011)(9686003)(6916009)(316002)(66556008)(66476007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bw7Y4Gd5NuVfp24KIRbRC+eIAv2ibLQ61803ui/9fMha/4hEYGA1hkav48Kf?=
 =?us-ascii?Q?e+rVpnqtiF9hQv+Fsbf3lwFaQLMnnAAGHrQBcrCKsxWnu8m8+r7XwJtkCNuJ?=
 =?us-ascii?Q?o4SLm5hI6wtEomEvaPbpBLYtyhlGmv1Cg0HfZohjaod/PU4zGIn0huJj3Vdx?=
 =?us-ascii?Q?YalLrEU9OhIBtz+E+74kJvuJWqmc75+vTUhADb0WE6Hw9cHMUg/cGogMZcof?=
 =?us-ascii?Q?C1444ty7eXCMM0S9DcPy6LzIbomgsd42GfXkDzgmhEuIzzBo/oV6OpwEkTqd?=
 =?us-ascii?Q?+GxI381E7ie8FGacNa24MiIadSC0Errg42kKLJR1Gjw/GVgUqHSLau3LPXuZ?=
 =?us-ascii?Q?YZ6verJCDNolQha/tO4L+ErKVxjfk7f/qWzS9GuxTudqk7q1j5hDXku5TBQ6?=
 =?us-ascii?Q?DCAmf6gqVSwIGti/znp0E37GzE/SMQxg/nMFa6xUEz8vZhc+CWbJEwS5dRjX?=
 =?us-ascii?Q?Qf4inB8Ww3YE6W9foP1H9BTPgoFEyJdSDRiHNSjjdI/ksa69Rb6nWy5ScTSz?=
 =?us-ascii?Q?wHtTPV5uCA3P/yekMuUSgQENx7pxYW5tlm9cEWxqjD/pZd2tOCgXnjNTfM2d?=
 =?us-ascii?Q?BfkY9eUU7ukBe51qaWwHFGaoemEST3aqEwNFlVXYOjdwfsJxl/sXQICZ4jHI?=
 =?us-ascii?Q?oobqf8q2zdw1m3Tnx9H0zuxlW6DjqMSph90YJcEqIeXfM3QqOTY+HQXacDhY?=
 =?us-ascii?Q?GphYAM+Qw1GNxknZhrtgTIpNZzhUJxToxFBKcKUlMN3xfziSud3LC78247LA?=
 =?us-ascii?Q?SF5G3KwVyAqG6yeD1nK6LADxZiYkMX1yheMPqriyYVcDdsGrMZMVUSHUJSUJ?=
 =?us-ascii?Q?eMydpUjI8c8XXUvXdEorphPuyJEpPPNNzfbtrIVX4AMpCTDYQcWTdIbYagrE?=
 =?us-ascii?Q?a940RgqbhkIFc4HHHgGEr5cSk9zBjyIMeE5Oq2u9LRFXJF2vdiubP5MO19Mm?=
 =?us-ascii?Q?+aILfOgM+4fvNQy98mhakRaoGOuw1dqk+Fmp/0vTt/QBezKeUn2JcDp/bzxx?=
 =?us-ascii?Q?eedQFq9QCkUKtixLAMFAiZuXsgc+yhqGMRcwWGxfubDr6gXT/8QZKyEXZiXo?=
 =?us-ascii?Q?chnDI6lsiGSRGrKx/hKFJ5p09U3vtITeun1DIsGQZvVrrkNzArFqxZjQrxC1?=
 =?us-ascii?Q?TEUygmlzZSjmy9l0+cPXbs/d6mPlxtPKB3qQvJGUfrbaLW6EKTLSmv77zDBh?=
 =?us-ascii?Q?MJZRNo+h86DRybr+cyRF4dX0b3xugK2Ir4qofExpUypvpj2xi5neYV2ij8nC?=
 =?us-ascii?Q?Rr/9dAUIulq3p1HWThZGNdQB534PDi9nKPfNiRTkFdaR+m+JKPGQgShLIo8N?=
 =?us-ascii?Q?2cOkVLozl34QDLKNhYgF0qUxow7b7kvQPNvPwO5Tc5tgOaqhB0lMUJ0sdu1/?=
 =?us-ascii?Q?tHHEaF+MfOXqN9UNlPsFXWdirIDJwlr65AXtmES9sIWfmignTef/GgPE8OGe?=
 =?us-ascii?Q?beDmdjroRorbArOwJC4Rw9HkIVwr59O/R9H6luYkv1fWl8DoyejtmnSMOB35?=
 =?us-ascii?Q?gpmxpaBvqGeBfnl1KizLDTUtroYGlbYNWLuSJfgk5pB+ajGGwCP8qZgJiXC5?=
 =?us-ascii?Q?okzJg21uURQn1oEtKOAUhDBgmNjFbEeoY3VJMIER?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19bc0c7c-a4af-46c2-ea18-08dbbbff4c1d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 06:35:38.1784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/VX16sox6Gqjsh8YVYY/fL127rF6zfg9fc2SGsrBJ639O620mpfyKPm48hLCTyhipwPfZHksjwmX7A6yX5GlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5141
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-31 at 14:14:44 -0500, David Vernet wrote:
> On Thu, Aug 31, 2023 at 06:45:11PM +0800, Chen Yu wrote:
> > On 2023-08-30 at 19:01:47 -0500, David Vernet wrote:
> > > On Wed, Aug 30, 2023 at 02:17:09PM +0800, Chen Yu wrote:
[snip...]
> > 
> > Let me run other benchmarks to see if others are sensitive to
> > the resource locality.
> 
> Great, thank you Chenyu.
> 
> FYI, I'll be on vacation for over a week starting later today, so my
> responses may be delayed.
> 
> Thanks in advance for working on this. Looking forward to seeing the
> results when I'm back at work.

Sorry for late result. I applied your latest patch set on top of upstream
6.6-rc2 Commit 27bbf45eae9c(I pulled the latest commit from upstream yesterday).
The good news is that, there is overall slight stable improvement on tbench,
and no obvious regression on other benchmarks is observed on Sapphire Rapids
with 224 CPUs:

tbench throughput
======
case            	load    	baseline(std%)	compare%( std%)
loopback        	56-threads	 1.00 (  0.85)	 +4.35 (  0.23)
loopback        	112-threads	 1.00 (  0.38)	 +0.91 (  0.05)
loopback        	168-threads	 1.00 (  0.03)	 +2.96 (  0.06)
loopback        	224-threads	 1.00 (  0.09)	 +2.95 (  0.05)
loopback        	280-threads	 1.00 (  0.12)	 +2.48 (  0.25)
loopback        	336-threads	 1.00 (  0.23)	 +2.54 (  0.14)
loopback        	392-threads	 1.00 (  0.53)	 +2.91 (  0.04)
loopback        	448-threads	 1.00 (  0.10)	 +2.76 (  0.07)

schbench  99.0th tail latency
========
case            	load    	baseline(std%)	compare%( std%)
normal          	1-mthreads	 1.00 (  0.32)	 +0.68 (  0.32)
normal          	2-mthreads	 1.00 (  1.83)	 +4.48 (  3.31)
normal          	4-mthreads	 1.00 (  0.83)	 -0.59 (  1.80)
normal          	8-mthreads	 1.00 (  4.47)	 -1.07 (  3.49)

netperf  throughput
=======
case            	load    	baseline(std%)	compare%( std%)
TCP_RR          	56-threads	 1.00 (  1.01)	 +1.37 (  1.41)
TCP_RR          	112-threads	 1.00 (  2.44)	 -0.94 (  2.63)
TCP_RR          	168-threads	 1.00 (  2.94)	 +3.22 (  4.63)
TCP_RR          	224-threads	 1.00 (  2.38)	 +2.83 (  3.62)
TCP_RR          	280-threads	 1.00 ( 66.07)	 -7.26 ( 78.95)
TCP_RR          	336-threads	 1.00 ( 21.92)	 -0.50 ( 21.48)
TCP_RR          	392-threads	 1.00 ( 34.31)	 -0.00 ( 33.08)
TCP_RR          	448-threads	 1.00 ( 43.33)	 -0.31 ( 43.82)
UDP_RR          	56-threads	 1.00 (  8.78)	 +3.84 (  9.38)
UDP_RR          	112-threads	 1.00 ( 14.15)	 +1.84 (  8.35)
UDP_RR          	168-threads	 1.00 (  5.10)	 +2.95 (  8.85)
UDP_RR          	224-threads	 1.00 ( 15.13)	 +2.76 ( 14.11)
UDP_RR          	280-threads	 1.00 ( 15.14)	 +2.14 ( 16.75)
UDP_RR          	336-threads	 1.00 ( 25.85)	 +1.64 ( 27.42)
UDP_RR          	392-threads	 1.00 ( 34.34)	 +0.40 ( 34.20)
UDP_RR          	448-threads	 1.00 ( 41.87)	 +1.41 ( 41.22)

We can have a re-run after the latest one is released.

thanks,
Chenyu
