Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B501758BD2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 05:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjGSDIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 23:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjGSDIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 23:08:04 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EBC1BDC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 20:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689736083; x=1721272083;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DwLO+FbXagyTdMBSwlkhn0bfa16ViugplZVpLiRTdX0=;
  b=bRdMjrPenbnsbnId8mURvF+gaa/GAlwb2CJSO0Jvttnx5WygkF1LlOvC
   3cQy29X8Pib0/uXD1REouWIcjqwbpR/zIiasvoT4q4km3YwAk0rb9PIHI
   DcmMiV2gl4Ava0h9c0otAhJoXUJJ/DNHWtNZMWHtoEng5wT/qEOYMo5ys
   A1zbjLXS6jt/8RdiwseLldWSeEuVjTnnFHVerXNhdJGR6FzZctQoJivjf
   oRW3bSpfQ80FqT5sYoMUV1EY3/h2wwRUDAE9eGcU0dh2sDdt1xTCrsh4A
   tiX5vgn0DNf6VAaVG7At9zCTvMCsEbkH+/0lFboYBqBZO6y89VldnvFOF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="369006848"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="369006848"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 20:08:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="897760828"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="897760828"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 18 Jul 2023 20:08:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 20:08:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 20:08:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 20:08:01 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 20:08:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+j//eiEJHQsOyZzNK8Cc3qibcI6KfE03RDlInfmaTqxXWRLzgogQlHaF7YqpUVhwGPnMaQBbS3CfKZlP/tye5YhongEEljaCZoztVyBZ+fiRn84I3BxGNPQkrUW6p/ww1funnqa/xEZCZNDTPiLCpjKh2orIbCV+KXZqLQAAhXDLKzXk6qrNP0lcATo10sAeLYI+q4BcG8ODsU1zA4kEk7K4m+61PfCZXNYt6DcG6RB9Rj/0g0bfkupmHyjSwOW8rN3iP8dQ5RvalBnVe+AunS1QnHpGA+qjPylV8i3i8xBIEPbHM1EaTaKW/s73D3VLbjKoH/MECU0rivhqFkJKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQL1GrjhxjZ3BmDi1LIAaa+6VWeFIFV7s2Rb6++udl8=;
 b=jD7rB741LrKydAe6ps6Nn1CprSJ9BUeZabM6fWAVTuJryjut30gst907joLRFxG1AJFWDSy3L/mg38s9Hqr4vYUOEOzRVjhyf+RTHuCeGCnOflyFQhMd0GwOVITmAN2Z/3TZVilUPOqQ9cTiML9Z1mMLMj1p6wLHKtV025KCjI0RdjDuiIptlmpbvbOiZKRo2NJMNIQNp1rdd/ORbbos474DanLdTp0PR9ALHDE89mTl2wWYBhx14UcJTvMO1yeQe2iF+IEWDhDS0vPFqdeDGsrjmfeERa2Uk9Vcdzmnu38h741Mr2f7M0OKAaifTwmznbYpe/FbTSYAFGoA7KL6Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SN7PR11MB6725.namprd11.prod.outlook.com (2603:10b6:806:267::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 03:07:59 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::57e7:80ff:c440:c53a]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::57e7:80ff:c440:c53a%5]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 03:07:59 +0000
Date:   Wed, 19 Jul 2023 11:00:06 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     SeongJae Park <sj@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <damon@lists.linux.dev>
Subject: Re: [PATCH] mm/damon/core-test: Initialise context before test in
 damon_test_set_attrs()
Message-ID: <ZLdRtnibyGIu6kPc@feng-clx>
References: <20230718052811.1065173-1-feng.tang@intel.com>
 <20230718161656.78877-1-sj@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230718161656.78877-1-sj@kernel.org>
X-ClientProxiedBy: SG3P274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::35)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SN7PR11MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: 3217850e-e584-4026-fc25-08db88055b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vzk5Z5JJP0YU9JxgR/8Nt1XA+fqMmm3mMTXOrgXUt3zeYsn4s6ov8at+s05Uz/V+JuRGf+Z1Dv79EkU1kpFozNC0OT3ULAd+CLd9GyuMIep3MznXPgpCy2b9LYcRIfPNE1mg1z/sOWjjgEdqrgRfSarMtHZQwMYcfa+/Ly0GopTmkHaK6FqbkUWjwozU9OgGdbUzKjNTtRub4pMXns7G4v7pR0RWnaAOd9CGEmkbXFCV+81PJ34WO+tl3Eear0AVbvj2xWCwgEWDAptKVopqy7djLMsXZkAKUb0rjNXWs+tGOU4Y8pBN0pbcbLqiw96lyySiOhCke8phkoxp8ulf9dm34fvbCc99u3GD2Fzuu41f9Vb/KV7YQVf4XId5+7SnaqRfq5hRsWVgsxxRiOfwkpBfkbokMNbM2Pu9miI+DJCyPhWlUioYttXZaN+q16Ew1Fo8lbZc834Q57IXIsnFQwpGeR0/BZhPKlP7d+MZT6vSMZu5W++qEeNKFzw0zAsdlXtiaBSDjTamws205i9aGgG7jTh25D/NhsZa4DSA5fnzacEcgjiq4VTV8DBc6qbN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199021)(6916009)(33716001)(316002)(66946007)(4326008)(86362001)(9686003)(38100700002)(82960400001)(6512007)(6666004)(478600001)(8936002)(41300700001)(44832011)(66556008)(8676002)(66476007)(6506007)(5660300002)(26005)(186003)(83380400001)(66899021)(2906002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sLBbPYxc5D9dwwYBxst7ucSmc7Thiflnl4ExiKhEpiOwqjB55fpbiqjDxUVb?=
 =?us-ascii?Q?no5+VZotZS2GeuaCOOK4YAq2oHPv9DDRKLUA1OCypNiFMxuEouSTmsPUqq+I?=
 =?us-ascii?Q?j0LkQBurlaX+L/j0tEnR2GGxlzm9sbPL9s+ZutR+JCrUfg25a9JCuixFpqg8?=
 =?us-ascii?Q?NblTcXYKp8lNw7UBXcmhoZbO3SE8bZQ6u5rgbHJqyzlmQe+n6GBBMbx7lHpZ?=
 =?us-ascii?Q?QwBrM1bCajuxjWTrEt4RkLJJkTw4L8j3+7UggQSS3q5LnCnl/S/p95a2pxM7?=
 =?us-ascii?Q?7QCQFHX5z56o+BoIKHW7ugiDj9B+h421EpCWb0J3ZbGXW31syeW0anrmeuk5?=
 =?us-ascii?Q?vXhbZMnhdNsR+oS+cNFNCTPgTWnHpzvsHkcP45mZ1mGJv4jEBCSstdLDgQQb?=
 =?us-ascii?Q?jfIJIjlbUREgN2ADGt3WmMndLSqdutt3IfStYGSCK8SOLfvbgUONQ/ZnrRC8?=
 =?us-ascii?Q?nAeFpCzDtZQSMaFMR199ZJPxXjfL9GYyMfClcgNdb8jPkJp0as9CYY3onGIm?=
 =?us-ascii?Q?ilCrJ8cQiJL1ctQnJ9z8JCUy6PQxmm+yRzM3OXTclcKdLShnXPKhyvZi+/ee?=
 =?us-ascii?Q?iquphHFs6C7gJkwxvn+TaqOBPBZ2PWhwdMzs6gf0+JnAIAi9pqf9SXKmD5eu?=
 =?us-ascii?Q?nuOVj8SdrHqhKmQR9qEG0Km7e6eyeSfEjXulC9t8iNZfK1MWGknZConQHV2P?=
 =?us-ascii?Q?EakowmUFpDCUIislTMMkpAaPLIPMLdd3xi6y4nwahGg9dPPi1lxRASCjkaSu?=
 =?us-ascii?Q?aXGxk+hKkFOiMd/13lDjTDsc7+E0iDnC4WANTVSxE54dSdrbXDle3t5hg55l?=
 =?us-ascii?Q?O+CJ/fynGoApa2MfqQH05vAovvm5+W+37YBaJbOq76zmnKrdjwbnQfzvYoOS?=
 =?us-ascii?Q?HjCk1QyThX3UKcNQvlD1P2v2mqMF3x4TJgWCU9mTczCj+vDUtOqUspabitY9?=
 =?us-ascii?Q?Kf2ae9UuAqHjrGEDyzpTYQi1d7LqHtI3zhQPk//LONuL0naVz7aNuTn71coe?=
 =?us-ascii?Q?7dblqMGNf/Vq9InJmSUhpQllt94St/QW6wDL/wp92OXRXC1PPesjVC435Eqg?=
 =?us-ascii?Q?Px+Tz3dc2tcp45nByX1IlfKl2kSOXlFhnWh9s4vMiuAzx8qJPH+KXcs8NJ2u?=
 =?us-ascii?Q?qjcRLk4O1oRiSFW+A1zzTt+raAkfN8xDMGLZUogmEuSJIwiRfQ2iYVH2dNVk?=
 =?us-ascii?Q?MFdaJqAVWJMUkrDBJbkmeZM9Jha348cB7g+3Tvjbra7mnIgU8HAAOqpHH3uK?=
 =?us-ascii?Q?83FHMHsq2JCkaXTjyQs5ZD4eHJ98PjukOPmtCDnbXwkssD+dpPPe0XIzWUEJ?=
 =?us-ascii?Q?OTlFfka1nIHtZdJNQItxNp8f0FwVL3mWrYBn1c+kbcMtv+0puWHsj712QgAJ?=
 =?us-ascii?Q?DEVRIdVnvCdTBgdovxw3gl8WDH+RC00BhJ31u2tf4t9Fq+J/qVRrO7rW3Tez?=
 =?us-ascii?Q?XKOIsp3qTIRCgFmpCt+OYDkYMlS9XWXnTXTfWlM+0f1YymhILzY+thYCjfDQ?=
 =?us-ascii?Q?AyzOi8MfzelixlDDUrs9b5YpjSqMnNwcwIVharU2Siclx5ZsukP+8brOUUo/?=
 =?us-ascii?Q?kGczaCWWdoiWYVJ1BsQUFk5KNo/SsPaCguKx9PuB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3217850e-e584-4026-fc25-08db88055b30
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 03:07:59.1530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJfHSbe8LhZ6ZJZFZ0p2ScJ1MYV8tY8nkOX7WDRWBNcGy3fdCN8fhou40M/wyM1OIFcDi2p6QdRplFdcxe8dJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6725
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SeongJae,

Thanks for the review.

On Tue, Jul 18, 2023 at 04:16:56PM +0000, SeongJae Park wrote:
> Hi Feng Tang,
> 
> On Tue, 18 Jul 2023 13:28:11 +0800 Feng Tang <feng.tang@intel.com> wrote:
> 
> > Running kunit test for 6.5-rc1 hits one bug:
> > 
> >         ok 10 damon_test_update_monitoring_result
> >     general protection fault, probably for non-canonical address 0x1bffa5c419cfb81: 0000 [#1] PREEMPT SMP NOPTI
> >     CPU: 1 PID: 110 Comm: kunit_try_catch Tainted: G                 N 6.5.0-rc2 #15
> >     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> >     RIP: 0010:damon_set_attrs+0xb9/0x120
> >     Code: f8 00 00 00 4c 8d 58 e0 48 39 c3 74 ba 41 ba 59 17 b7 d1 49 8b 43 10 4d
> >     8d 4b 10 48 8d 70 e0 49 39 c1 74 50 49 8b 40 08 31 d2 <69> 4e 18 10 27 00 00
> >     49 f7 30 31 d2 48 89 c5 89 c8 f7 f5 31 d2 89
> >     RSP: 0000:ffffc900005bfd40 EFLAGS: 00010246
> >     RAX: ffffffff81159fc0 RBX: ffffc900005bfeb8 RCX: 0000000000000000
> >     RDX: 0000000000000000 RSI: 01bffa5c419cfb69 RDI: ffffc900005bfd70
> >     RBP: ffffc90000013c10 R08: ffffc900005bfdc0 R09: ffffffff81ff10ed
> >     R10: 00000000d1b71759 R11: ffffffff81ff10dd R12: ffffc90000013a78
> >     R13: ffff88810eb78180 R14: ffffffff818297c0 R15: ffffc90000013c28
> >     FS:  0000000000000000(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
> >     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >     CR2: 0000000000000000 CR3: 0000000002a1c001 CR4: 0000000000370ee0
> >     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >     Call Trace:
> >      <TASK>
> >      damon_test_set_attrs+0x63/0x1f0
> >      kunit_generic_run_threadfn_adapter+0x17/0x30
> >      kthread+0xfd/0x130
> 
> Great.  But it would be even greater if you could this kind of output after
> decoding the addreses using 'scripts/decode_stacktrace.sh` or
> 'scripts/faddr2line' from next time if possible.

I did run the decode script, but didn't paste it as I'm afraid the
whole text is too large. But yes, the decoded info is very helpful
for developers to analyze the issue. Seems I should add the info
for patches dealing with panic/hang issue in future.


Here is the decoded version (rerun on 6.5-rc2):

[    1.123316] general protection fault, probably for non-canonical address 0x1bffa5c419cfb81: 0000 [#1] PREEMPT SMP NOPTI
[    1.125356] CPU: 0 PID: 111 Comm: kunit_try_catch Tainted: G                 N 6.5.0-rc2 #15
[    1.126299] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[    1.127173] RIP: 0010:damon_set_attrs (mm/damon/core.c:471 mm/damon/core.c:508 mm/damon/core.c:534 mm/damon/core.c:555) 
[ 1.127676] Code: f8 00 00 00 4c 8d 58 e0 48 39 c3 74 ba 41 ba 59 17 b7 d1 49 8b 43 10 4d 8d 4b 10 48 8d 70 e0 49 39 c1 74 50 49 8b 40 08 31 d2 <69> 4e 18 10 27 00 00 49 f7 30 31 d2 48 89 c5 89 c8 f7 f5 31 d2 89
All code
========
   0:	f8                   	clc    
   1:	00 00                	add    %al,(%rax)
   3:	00 4c 8d 58          	add    %cl,0x58(%rbp,%rcx,4)
   7:	e0 48                	loopne 0x51
   9:	39 c3                	cmp    %eax,%ebx
   b:	74 ba                	je     0xffffffffffffffc7
   d:	41 ba 59 17 b7 d1    	mov    $0xd1b71759,%r10d
  13:	49 8b 43 10          	mov    0x10(%r11),%rax
  17:	4d 8d 4b 10          	lea    0x10(%r11),%r9
  1b:	48 8d 70 e0          	lea    -0x20(%rax),%rsi
  1f:	49 39 c1             	cmp    %rax,%r9
  22:	74 50                	je     0x74
  24:	49 8b 40 08          	mov    0x8(%r8),%rax
  28:	31 d2                	xor    %edx,%edx
  2a:*	69 4e 18 10 27 00 00 	imul   $0x2710,0x18(%rsi),%ecx		<-- trapping instruction
  31:	49 f7 30             	divq   (%r8)
  34:	31 d2                	xor    %edx,%edx
  36:	48 89 c5             	mov    %rax,%rbp
  39:	89 c8                	mov    %ecx,%eax
  3b:	f7 f5                	div    %ebp
  3d:	31 d2                	xor    %edx,%edx
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	69 4e 18 10 27 00 00 	imul   $0x2710,0x18(%rsi),%ecx
   7:	49 f7 30             	divq   (%r8)
   a:	31 d2                	xor    %edx,%edx
   c:	48 89 c5             	mov    %rax,%rbp
   f:	89 c8                	mov    %ecx,%eax
  11:	f7 f5                	div    %ebp
  13:	31 d2                	xor    %edx,%edx
  15:	89                   	.byte 0x89
[    1.131693] RSP: 0000:ffffc9000059fd40 EFLAGS: 00010246
[    1.133744] RAX: ffffffff81159fc0 RBX: ffffc9000059feb8 RCX: 0000000000000000
[    1.136273] RDX: 0000000000000000 RSI: 01bffa5c419cfb69 RDI: ffffc9000059fd70
[    1.138528] RBP: ffffc90000013c10 R08: ffffc9000059fdc0 R09: ffffffff81ff10ed
[    1.140778] R10: 00000000d1b71759 R11: ffffffff81ff10dd R12: ffffc90000013a78
[    1.142997] R13: ffff88810ea9c980 R14: ffffffff818297c0 R15: ffffc90000013c28
[    1.145235] FS:  0000000000000000(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
[    1.147463] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.148629] CR2: ffff88813ffff000 CR3: 0000000002a1c001 CR4: 0000000000370ef0
[    1.150046] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    1.151450] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    1.152888] Call Trace:
[    1.153480]  <TASK>
[    1.160117] damon_test_set_attrs+0x63/0x1f0 
[    1.167458] kunit_generic_run_threadfn_adapter (lib/kunit/try-catch.c:28) 
[    1.168050] kthread (kernel/kthread.c:379) 
[    1.168881] ret_from_fork (arch/x86/entry/entry_64.S:314) 
[    1.169756] ret_from_fork_asm+0x1b/0x30 
[    1.170211] RIP: 0000:0x0

> > 
> > The problem seems to be related with the damon_ctx was used without
> > being initialized. Fix it by adding the initialization.
> 
> Somehow the test always passed on my test machine, but maybe that's due to some
> different behavior of my compiler.  I agree that could be the root cause
> because 'damon_set_attrs()' calls 'damon_update_monitoring_results()', which
> accesses the context's fields including the targets list.  Since the list is
> not initialized in this test code, it would cause such error.

Yes, I further dumped more info, and the dmaon_ctx is not initialized
and filled with random data, especially the list_head 'adaptive_targets'.
In damon_update_monitoring_results(), looping that list triggered the
page fault.

> 
> > 
> > Fixes: aa13779be6b7 ("mm/damon/core-test: add a test for damon_set_attrs()")
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>
 
Thank you!


- Feng

> 
> Thanks,
> SJ
> 
> > ---
> >  mm/damon/core-test.h | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
> > index c11210124344..bb07721909e1 100644
> > --- a/mm/damon/core-test.h
> > +++ b/mm/damon/core-test.h
> > @@ -320,25 +320,25 @@ static void damon_test_update_monitoring_result(struct kunit *test)
> >  
> >  static void damon_test_set_attrs(struct kunit *test)
> >  {
> > -	struct damon_ctx ctx;
> > +	struct damon_ctx *c = damon_new_ctx();
> >  	struct damon_attrs valid_attrs = {
> >  		.min_nr_regions = 10, .max_nr_regions = 1000,
> >  		.sample_interval = 5000, .aggr_interval = 100000,};
> >  	struct damon_attrs invalid_attrs;
> >  
> > -	KUNIT_EXPECT_EQ(test, damon_set_attrs(&ctx, &valid_attrs), 0);
> > +	KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &valid_attrs), 0);
> >  
> >  	invalid_attrs = valid_attrs;
> >  	invalid_attrs.min_nr_regions = 1;
> > -	KUNIT_EXPECT_EQ(test, damon_set_attrs(&ctx, &invalid_attrs), -EINVAL);
> > +	KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &invalid_attrs), -EINVAL);
> >  
> >  	invalid_attrs = valid_attrs;
> >  	invalid_attrs.max_nr_regions = 9;
> > -	KUNIT_EXPECT_EQ(test, damon_set_attrs(&ctx, &invalid_attrs), -EINVAL);
> > +	KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &invalid_attrs), -EINVAL);
> >  
> >  	invalid_attrs = valid_attrs;
> >  	invalid_attrs.aggr_interval = 4999;
> > -	KUNIT_EXPECT_EQ(test, damon_set_attrs(&ctx, &invalid_attrs), -EINVAL);
> > +	KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &invalid_attrs), -EINVAL);
> >  }
> >  
> >  static struct kunit_case damon_test_cases[] = {
> > -- 
> > 2.34.1
> > 
> > 
> > 
