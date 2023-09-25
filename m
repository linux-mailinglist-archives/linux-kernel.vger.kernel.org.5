Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DCC7ADCD9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbjIYQOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYQOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:14:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464C1B8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695658441; x=1727194441;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WvDgWQyU5z6GsYDhB59/gBTgdjZsIRrW+3USnuLN/T0=;
  b=lgUf0wCmJQ/clcdzvSSUhxkrRTZD0VSgRYJWh19yI8raLLQOPAtAyui9
   zXRC0CLyXw8lXz3wAWQS2eWR0Eg9zrCn5hBYsneChxl/+32RFC77fNEAo
   oDpCtO/cDRMH7zUZUCAyQa2DwYyP1dsCQdK6/DlibNTuWLF+OTuD/C9qA
   0TIzJdnRdhUstWz+s7ou1fygAX6JeLY2AUu+p5/kC6WARjyD9EqpGxJ+J
   dFHaVF58ZDVB0W9dIp6kECpAvHcghmTM1qbr6McR+MXCujW4fajYQmx0q
   H0aLFur1Ni3tKb1I6AG8Ls7Vd0+gQti6Pf5GSEF2PLoMR9QF/PzX6o3by
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="467578490"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="467578490"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 09:10:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="838606409"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="838606409"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 09:10:19 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 09:10:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 09:10:18 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 09:10:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVWY1PjuwcftNCINqSpM83fWvydcFklSYc382LbAQZVnpEJ4ttXrc6ZQMhVhklqNcKVVMZReU/1+y///b3L7RG++zCc/vhHZICw4JsXGy5uLaH/xqI8rpnRhskRVQfyIzZNkiZDzpbqoWkIUImM0cVNayNyNwPBmlPSiCL47Gn2D5okKiDh/GBBShkNVvVgJnf9PeFES+Xk0cP/farSVfXeg4HWAUF14a106JpiEwYTjoas8mKckWxPCM3ecy9IZGHboIfzrgZ5I2QUpHdxwAXVKo9cXre0yaiXp1rmHm9PnP+MQxzbGApZD9IHRSmPEPuy2ZufPU1iJn/uLVMOtHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMY1g0JBHHCMZlKPKLtt4jv6UBOHWs5uAzsgqvRTAjo=;
 b=BkifcGgJ4QFyp7fpXNZWcwWAqQG6YDrkR2uD+9gNOkWUZVh8q+oqIZpPYbV+ZXIlTn9YZ0vSfVjSDvOroQR/PyXFMu5DvM1sYMZfx/z5cTAm03YODsBsRqkVKyiKyX8++izkzYrseDrTD0+ynvuuTniPzDdoOlGIkXySAXbahz2m48JcZhk8SQVCK0F2C+ffJvyPk+jUZ23H485OkW2ytICYZHWlCqe0Lw1uKxKwUn+DmZfGvjpaJEOEF34PdOc/ZiGaF8gsGvGbETBaYV1jzW4K9RpCiEehwQqfzT7GHRSTUcXYYiXJuWYAHQgcq+Ph7g8hWB0SAr2ntYmjOJbK0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB8279.namprd11.prod.outlook.com (2603:10b6:806:25c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Mon, 25 Sep
 2023 16:10:16 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5a0:a0ec:2d4:995e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5a0:a0ec:2d4:995e%4]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 16:10:16 +0000
Date:   Mon, 25 Sep 2023 09:10:11 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Tomas Glozar <tglozar@redhat.com>, <nvdimm@lists.linux.dev>
CC:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <linux-kernel@vger.kernel.org>, Tomas Glozar <tglozar@redhat.com>
Subject: Re: [PATCH v2] nd_btt: Make BTT lanes preemptible
Message-ID: <6511b0e3a4627_b00c32947a@iweiny-mobl.notmuch>
References: <20230920053712.499439-1-tglozar@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230920053712.499439-1-tglozar@redhat.com>
X-ClientProxiedBy: BY5PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:180::48) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: 400e1fcd-2ce1-4d4d-86d5-08dbbde1e7e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WSgE68VMd3bRBo8FmiKYvfmRl+xG/lVxMiV28tdapToObnxivYWQbO4dGer8Hmt6e8kvpg3vmmZ/vmRqFAR9dg6lAJUFeCVR1k32g0U6Ns+D4yWqxkIWNOx1gVNPzzQ1pUjAnm4PKU5Ey4Y24thM/rtFdyXD3jkdNnbY5JyKPL07idjUBnxV5eokJq8YS0e0ZV3/axIh/1YUTGz7D5d0meuY+dVmJ803q0QvXdk5XK3i36/nJ15M9xxyHAnP0R8sC8aEUZ2og4yc/jMYfGz52x77ORPYQD7futnmmNMPtst/+m7pl5fYA2BRdtfw5O8lLGPVriLjyFqZUOm6QPzTy8LY+RfF7gemlAipmqZYOT4vz7NaNVTYDohupcmO9jZV2AnzdJCt4y8ioGHhsm0pQW81htSviQhSNkxFI85R+/i+aAFfqzbVVyvSOr8uuZK+tS/CbMJgR7EG575RIojT2bR+HOGl41fFX/plOrB/Vds8F2XSMOm5XtL8pfDE8oNv9JRq77/z2y/nXRqqsax+Mc+ZLZvA2AdsuuoYUYo+++0BaXSyU8puLgGl+1C6QB7P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(39860400002)(396003)(230922051799003)(1800799009)(186009)(451199024)(4326008)(6506007)(6486002)(478600001)(83380400001)(26005)(316002)(6512007)(66476007)(8676002)(66556008)(8936002)(41300700001)(6666004)(5660300002)(2906002)(44832011)(9686003)(66946007)(86362001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3t7M1PSi2oQZ9ZIjV2x/ujMuX66/PhgwbrKqxkGgBo7lUFole1gaYDeCtvMQ?=
 =?us-ascii?Q?J7YPwnMD6EaV/ufh39znuAVv08zQ2Q4AWW6QYAccGJH7nzsCkPP4IRS9zVQ3?=
 =?us-ascii?Q?xlJI6ln49+PSXTM4y8USXn3Xvo6q11y1+QmdOlnjZ0GpDLEWZrfylel2+GCH?=
 =?us-ascii?Q?326zwPFNv99A3SJ5MMjr9M44jViEMO8z7YaBuBsFatndvzB0xSEOiMkv9dXx?=
 =?us-ascii?Q?Rk9mTfWR7LK3jWGfpgyg7fFpH9lL5O4m7EBQdz1RQ4PMfidCkBhWr/NqwMRO?=
 =?us-ascii?Q?PoUxeD1LeyTpqTdjog+gNvuLy6B36sv388hqDqOxUWObdqTY512KIZ+yHI/u?=
 =?us-ascii?Q?92IOa/htvaJP371riRe0XPdkE35V6nD4R7mFISvOi/Ho3JY67/lhmOjqZbYU?=
 =?us-ascii?Q?T66EYuiZt07U9ktawOmSotOEZRdaFYZ2Y7VPakgw4VwqJw5+fIzSyep3btbc?=
 =?us-ascii?Q?lRzgSF1h19O0Csnr9xf+oz2UAP8ZidB9l0hYXf5a2QMwJiUj1ilEytSwEGPt?=
 =?us-ascii?Q?4vqLZ0GXcXwFy7+pnYurBtRjAueOTNhFguFWuDh2Dj0EgIDG7U0CSVMrIstN?=
 =?us-ascii?Q?KRfgiUwYVWCFEVDXRuz2FnyIdi4rDgwlHRRdpn3rCAqT0u6InIlGIPNxbCTU?=
 =?us-ascii?Q?Y4eua1LreEk3S4tcBL911qtdN2lF85OFoLrc4te6JmvVBFyxcC45rTscZba3?=
 =?us-ascii?Q?0HNbUNrbahZpVRfAcowNMDNiPM47bC5oSgqD2boCqoe1UIh5CwAKP+8ugySS?=
 =?us-ascii?Q?UhmMKvb2OQvbPeEfAzTULzVN8EhyLcPUloeD2j+gYbWobaqvuSOjQQ0WKLAx?=
 =?us-ascii?Q?aZOUGe46BdhTt1+sc6fX3aqiEXJbZ2ok7YF0QHTDzSGj2m3O1RIRZjLWnmCG?=
 =?us-ascii?Q?qfDAd/m/PuQZlwA96iekSjPzxmzmyl0+z8wH+3YppOOaM9EQ1R+Y/uFWBxAO?=
 =?us-ascii?Q?hlsOEQH6SluBNQndSlDYFM4Ry4Z8L9xfvHy6JHEdCHOM4Cg5o3Q1s0JdXQeW?=
 =?us-ascii?Q?DoXANtFZX37BGx8gZJQPfeb1K3EOB30+LkVye/q2S4pYSZZ6Ry5XBqbiLG+S?=
 =?us-ascii?Q?AwBF1eRwgW06zL4HEoAIMKIQWLopMmN33xzY2/tdvBdIukagHF6gLQPsvKZr?=
 =?us-ascii?Q?U1OlDBRwOxICZEioZk1msCMc9SLmAdWtOQmrPNtHOndSH/k+n9OKsSgYSC49?=
 =?us-ascii?Q?hLZY4SIq2YvaVmkyyHCgFGzmgI2TUzjgnrLgDnv80shL8EFr/kexiQf/X009?=
 =?us-ascii?Q?UdFb3druwBqUB7Ewbsp92jYZiuLVPrzCJA7goHplqlt6rFE0xToJPVDq/7eq?=
 =?us-ascii?Q?eZwtIT+XHcD6PjlOVhx+BOIQVaoK2tchToibU6YgkoUz7wcjrxNiXoUpjFLD?=
 =?us-ascii?Q?Z5F/LHsXBaSnHlstK0aV/kv4kBDcsgiFMPqlPqJ20fRvgp/0ke13fhuLkLZR?=
 =?us-ascii?Q?aVelbepBHujAsFIPbWoieBSDwtfn2kX5/trLeAmrhlh1NBquidxosqNQ4b8w?=
 =?us-ascii?Q?X0Ieii1vjiwkCE2b9WzbfstJC4w9FpausTv0SXoXpm+9kjsPNeByH8bfwje/?=
 =?us-ascii?Q?PLDtukp5E9vsurtXe6Pmsi17r3J+oyDHJasP7KyX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 400e1fcd-2ce1-4d4d-86d5-08dbbde1e7e3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 16:10:16.0923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJWp580sd+rTg/oKeXhmXW7+0hvc95QIFJRub8xFSkyRhRjd2kMc2BHYZSaNGD0Cb4JevaFbc3DD+02PVPocOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8279
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Glozar wrote:
> nd_region_acquire_lane uses get_cpu, which disables preemption. This is
> an issue on PREEMPT_RT kernels, since btt_write_pg and also
> nd_region_acquire_lane itself take a spin lock, resulting in BUG:
> sleeping function called from invalid context.
> 
> Fix the issue by replacing get_cpu with smp_process_id and
> migrate_disable when needed. This makes BTT operations preemptible, thus
> permitting the use of spin_lock.
> 
> BUG example occurring when running ndctl tests on PREEMPT_RT kernel:
> 
> BUG: sleeping function called from invalid context at
> kernel/locking/spinlock_rt.c:48
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 4903, name:
> libndctl
> preempt_count: 1, expected: 0
> RCU nest depth: 0, expected: 0
> Preemption disabled at:
> [<ffffffffc1313db5>] nd_region_acquire_lane+0x15/0x90 [libnvdimm]
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x8e/0xb0
>  __might_resched+0x19b/0x250
>  rt_spin_lock+0x4c/0x100
>  ? btt_write_pg+0x2d7/0x500 [nd_btt]
>  btt_write_pg+0x2d7/0x500 [nd_btt]
>  ? local_clock_noinstr+0x9/0xc0
>  btt_submit_bio+0x16d/0x270 [nd_btt]
>  __submit_bio+0x48/0x80
>  __submit_bio_noacct+0x7e/0x1e0
>  submit_bio_wait+0x58/0xb0
>  __blkdev_direct_IO_simple+0x107/0x240
>  ? inode_set_ctime_current+0x51/0x110
>  ? __pfx_submit_bio_wait_endio+0x10/0x10
>  blkdev_write_iter+0x1d8/0x290
>  vfs_write+0x237/0x330
>  ...
>  </TASK>
> 
> Fixes: 5212e11fde4d ("nd_btt: atomic sector updates")
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>

Thanks for the clarification.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
