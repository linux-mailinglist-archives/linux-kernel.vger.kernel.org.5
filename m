Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AA97BC51C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 08:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343588AbjJGGmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 02:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343561AbjJGGmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 02:42:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06483B9;
        Fri,  6 Oct 2023 23:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696660955; x=1728196955;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Cb6TWff5geexpr2e7pUjo7hH8wOQf88RbaWw1F0dNpE=;
  b=ESwkNGf+zOuiE8/lUqEekmBgR1qzchyBHeu13zfxvCdUpmILv/W6JApe
   6b8FvLxa80SXW2hbzBU84N5b5AMGJV9wwb2G7/CqQ94w1dN/xEs+xQg5F
   6qgXwBlbb9iD798o6OcwicAWEtXxyWW9ekicmbdyjkrRXwkQWzwURUiQS
   NR2gsqhF2PtfjmgmwkjH8MmPG9+3tNSaIoccBh9r1L1LZw9sn+Cb/LY3w
   EHqXb2N59FlUhVz3yJOXdrixfYGbkspsKLULOpEHzFoBzpxk08+1SI8cT
   M48RD8bgftP6KKfE14fKTkZ6hlzDLbcm3BOGwQTJezbKQBr+t6DpH77c5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="374236560"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="374236560"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 23:42:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="926204262"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="926204262"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Oct 2023 23:42:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 23:42:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 23:42:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 6 Oct 2023 23:42:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 6 Oct 2023 23:42:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGpSgt5C2sWQe1Pv3HYctn/yjfk7W5qxqKBqS/6Nzw67mAVnPoifIIl4/lpEWxBk9U7hxh4yTAAjOY6aRDSWoc289rp28lkyxelaei5vqVOiCTBmHatuOUhtxS8IFtq9/SY8g/rNPdH/0rOi0GnIjNZ85jQ/YB4zz75gVOpfSlks9oCnNU2dUuvCEyn2sXIMJnt2T559ei3jEZF/lMenPMxHPmrA4R6hLYO/MD+fYsods1WZ+yTLPiSTHQNyYN++SPUjIDOPVe8oAY5a+rSMNMWZ44LXKcbSItFp/M+IiSm7ptB40NtoQ2MqMaAt38NCshqkWqLUdlWY2YFsJH47cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0iYE8MqUyV+sz7RKxlas4xU+vFvpJsCgTDLAPekhS4=;
 b=eAmaJmxz4dQgWR+zVgLdqSzlyCdzEDn0gt/YzOqQbWl3KfE6y/iDnQ4I4zLhw8Fg3WSGqgHgFtc76iUyRy+KldxnlCwnXndzaoM7CiijtxbUVoyKBGmmYN6plrROnoLPfgwmE9kRhD5Iy9859LLl/+wyHxW31w2+dai5Rdr5HT75KpYbFew6M4YPCAtyxRs5s3/qiRc3VY1ATwqTf25Llq/D4XVNdjzsF5XY4BABnTirHT4ycvOmTMhFk2imhbKndrc0AGDcXFen9KJ3P5iqIvGf1eAUC/LvYHPzmvevOHMYozIr2lUuDGVct7FEA/MWKYetuk3D82hIr7o50Aerqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SN7PR11MB7114.namprd11.prod.outlook.com (2603:10b6:806:299::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Sat, 7 Oct
 2023 06:42:31 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%5]) with mapi id 15.20.6838.033; Sat, 7 Oct 2023
 06:42:31 +0000
Date:   Sat, 7 Oct 2023 14:42:10 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "joshdon@google.com" <joshdon@google.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "patrick.bellasi@matbug.net" <patrick.bellasi@matbug.net>,
        Pavel Machek <pavel@ucw.cz>, "pjt@google.com" <pjt@google.com>,
        "qperret@google.com" <qperret@google.com>,
        "qyousef@layalina.io" <qyousef@layalina.io>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "timj@gnu.org" <timj@gnu.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "youssefesmat@chromium.org" <youssefesmat@chromium.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: fix pick_eevdf to always find the correct se
Message-ID: <ZSD9wsBPUfhTULf7@chenyu5-mobl2.ccr.corp.intel.com>
References: <CGME20231005150845eucas1p1ed3aae6b90c411b5c26a5dfadf7e0733@eucas1p1.samsung.com>
 <OS0PR01MB592295E06AD01CAEFBA83BF386CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <553e2ee4-ab3a-4635-a74f-0ba4cc03f3f9@samsung.com>
 <867f5121d7d010cacf938c293f862b0cea560ec2.camel@gmx.de>
 <20231006140042.GG36277@noisy.programming.kicks-ass.net>
 <e2645a659b6fc1c592e2f2dc45273c361a2d2f47.camel@gmx.de>
 <20231006155501.GH36277@noisy.programming.kicks-ass.net>
 <20231006192445.GE743@noisy.programming.kicks-ass.net>
 <ZSCoLllO/cYnnIMi@chenyu5-mobl2.ccr.corp.intel.com>
 <OS0PR01MB59222333D50ADBAD1786DA9A86C8A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59222333D50ADBAD1786DA9A86C8A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: KL1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:820:c::17) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SN7PR11MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: 1273b2e5-80d6-4085-b633-08dbc7009429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PqF/X8XBB9DgNt27IVks2wivJSW/uXteVakVUjZI8IU9D4CB9akOnOSfhjlodEFhAamgsm6WpUeDdcSG+ML7+IPRl5+ZGfEAIH8BWc89/nmy2IcaTxbvBijnMbk9W+kDU6lOX/5BmacfkfVtaN7+YtLUBo5f/GedDchsPHudF2dd4hji6LRz7XChEIEgMoCW8dJP4Vh/upCKBSuXMmbIYhlU8mh/vJr8aC+RamG/vYRA3VnlFaD3sHV+u0FxaSxioH1Rj0y+a/ENywArMzZNiQJDoi7b8xzMulgTbI6IOMj/SDT6jrgVTjQ/NgmfQFXHdMkaFLinYYd4mH8FOHHZmNAux9D3AMAU0N/FOp+QAaV1d95fzDh46ihoX+ZvUzS8kq9xu4VVZJPONyV4pDcJPNtDJty0TRfFFlImN29k2q3/jpH0H/PvDKgSzbvUbHbKZoEOnTJygn9CVcm8nNnpavqk+j1TgwV++v714efym5co5Et/6aHiHS54xzVl3IUHuIeEBaW2sJ2akowBhVEpCDjyte815KHUDs/jzl/iB7c5qU4E7xAbCFSHA8UtKoSt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(4326008)(8676002)(83380400001)(5660300002)(66556008)(66946007)(316002)(6916009)(66476007)(54906003)(478600001)(6486002)(8936002)(6666004)(26005)(6512007)(6506007)(41300700001)(82960400001)(86362001)(2906002)(53546011)(38100700002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GCLf4WhDj4IpcOSbtqSmn3BcFusULTvrmMqzVKmL72q0jCSCMfOk1y10yREs?=
 =?us-ascii?Q?jDv7IYW+VscRkfnpXCfi54/GK+mjFLxNWVJJn34JxkompuWLxQ8YikTPvtNq?=
 =?us-ascii?Q?H1pS2lCblDJdSUmb9b8B9XxxlixItAojLCElT7DeV19Aak5PShs59Wb7auaC?=
 =?us-ascii?Q?yfeyx9SPoZ4aSBd+vvr82yF4t6Pdus6bkZ17owBKDyz39ctt3eGBAlGgrKGk?=
 =?us-ascii?Q?0L4F5Zwhh5/u1mIWKiAZlRrZS/m37v23wbkAkulsy/tngysptMqrQ8bAQK9h?=
 =?us-ascii?Q?F3F41C4dS0rJgBtFgfJTUBvJdELaaN2iDR8NkFw0/s9oCUf8Y3MhsmaRhSbc?=
 =?us-ascii?Q?XajkSfZDvdIMKZSlXBju2ZhJ537RRmh1iZHigGzQRCaxjZp4P/L1vB0EtlHz?=
 =?us-ascii?Q?wuDpLZuw5wT7sxoGO+YdaYQk/1+49jSRv81IKsbScJnLXM1AvuV0uEHbCC69?=
 =?us-ascii?Q?vLMqESD8y1UV0V5ISsJSXzmS9GxjATGV/VqfKT9Cqj9RilF8UlyE9ArUSMY2?=
 =?us-ascii?Q?M0RwtKn3mjpjuLbFqNmr8+aRl8zgYDgk9q8U/qnx/bxPUUs0bi0Zlx8YJQ+d?=
 =?us-ascii?Q?C8b/fVxUkHxLDwe/6YUFwwfXposu1XeZ29yKrBWJy78ADRke0gtkTUkuwqxJ?=
 =?us-ascii?Q?E7aKLZKXNyfe5gen/GbSbNuhaGwWMPWMm8tSnQxhOBIWaGlRA17GFbnG9DDY?=
 =?us-ascii?Q?u9O9HGMH4BaBa0TXWdSxZI+fXASoMfe5hGUMxg8PBg3KMKn2+h5cLFoyro64?=
 =?us-ascii?Q?//EtK+Ox45tLDiPUuUGb+cNRSIk9rWF3j8T554alg0llqiw+acLp6/khkTbI?=
 =?us-ascii?Q?K2gTb9XzvVLG8XNfLM/hxc7fTY0L9sqJLiJQeZDGKVV0k9b5Mp6Tj3YjkhUs?=
 =?us-ascii?Q?esLhbrUZx1Fv0gk0CDN4M6scigeNY6DPcX+KWMH/QAD8iTtuPbaGlmgS7vSt?=
 =?us-ascii?Q?tumlFtKggfScMuvq/k1ARdcgSqrWPNPb/onr5qTTHP3l1wAGtuRQ/QAS0WJe?=
 =?us-ascii?Q?2Pk0BRXvV9aqu4g2EUcZ7NVal7AtU8O99GvDEat/Dc245ki+fwvz3NoPuTZm?=
 =?us-ascii?Q?KdKieYSm3vOJboSuYzSbRWb8Qe6IcKl3rOHMtvCkSQVDepJuASzPFqoiBW4Q?=
 =?us-ascii?Q?2WG/mD7KMk3ezoBx/+Pkv0pwjHkDPNktdstHN+ro2UWKU6WzG0vPYvuVmJWe?=
 =?us-ascii?Q?y1/SlSRsuLYmuomvHA/ptrx3NRy8jeGbHkJTkB919OzwZiNjmsU2OGeBepRh?=
 =?us-ascii?Q?kkEODOI2aGFvs7iXKa1QEQyVK2oDPINw+u3b1dIDQflTCz01ej4rgouTcROQ?=
 =?us-ascii?Q?3XJHKpCmEWqYV+GznsaN8lUAjrDFoXITZecP/uu1NGYf7NRRYhSKHp9OB6eC?=
 =?us-ascii?Q?BAUGDyvOLTcsSLoZepsHyRISiBuql+tF9jIzMFFEAtYeVeQVIEtNZd2DMZzZ?=
 =?us-ascii?Q?mtcZdgkkCZJpKDd7R7u/CumN7CcUAdcpqwnWKI3KWk3Q8UZVbU4Xzd1Y4bsS?=
 =?us-ascii?Q?xoACz+PaVMF8khHo0vaanMHjfk0tHfjWCTiuCMXUbTOJ0E3TpnPv/eVBPqvV?=
 =?us-ascii?Q?FUPG4gzTWmaf1oVU7g0d9jY+b7BP+0baL/GPtGHp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1273b2e5-80d6-4085-b633-08dbc7009429
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 06:42:30.8071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kl4U3Dd374y+F73gFAdGC/vW8HJy7UY+IRKb2oQ0+FWzLQct3uDTj2scNaln9utHPH5PnbFNkf920tpfxK3DMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7114
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju,

On 2023-10-07 at 06:26:05 +0000, Biju Das wrote:
> Hi Chen Yu,
> 
> > Subject: Re: [PATCH] sched/fair: fix pick_eevdf to always find the correct
> > se
> > 
> > On 2023-10-06 at 21:24:45 +0200, Peter Zijlstra wrote:
> > > On Fri, Oct 06, 2023 at 05:55:01PM +0200, Peter Zijlstra wrote:
> > >
> > > > And yeah, min_deadline is hosed somehow.
> > > >
> > > > migration/28-185     [028] d..2.    70.264274: validate_cfs_rq: --- /
> > > > migration/28-185     [028] d..2.    70.264277: __print_se:
> > ffff88845cf48080 w: 1024 ve: -58857638 lag: 870381 vd: -55861854 vmd: -
> > 66302085 E (11372/tr)
> > > > migration/28-185     [028] d..2.    70.264280: __print_se:
> > ffff88810d165800 w: 25 ve: -80323686 lag: 22336429 vd: -41496434 vmd: -
> > 66302085 E (-1//autogroup-31)
> > > > migration/28-185     [028] d..2.    70.264282: __print_se:
> > ffff888108379000 w: 25 ve: 0 lag: -57987257 vd: 114632828 vmd: 114632828 N
> > (-1//autogroup-33)
> > > > migration/28-185     [028] d..2.    70.264283: validate_cfs_rq:
> > min_deadline: -55861854 avg_vruntime: -62278313462 / 1074 = -57987256
> > > >
> > > > I need to go make dinner (kids hungry), but I'll see if I can figure
> > > > out how this happens...
> > >
> > > *sigh*, does the below help?
> > >
> > > ---
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c index
> > > 04fbcbda97d5..6a670f119efa 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -3632,6 +3747,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq,
> > struct sched_entity *se,
> > >  		 */
> > >  		deadline = div_s64(deadline * old_weight, weight);
> > >  		se->deadline = se->vruntime + deadline;
> > > +		min_deadline_cb_propagate(&se->run_node, NULL);
> > >  	}
> > >
> > >  #ifdef CONFIG_SMP
> > 
> > Is it because without this patch, the se->deadline is not always synced
> > with se->min_deadline, then in pick_eevdf() the following condition could
> > not be met, thus we get a NULL candidate and has to pick the leftmost one?
> > 	if (se->deadline == se->min_deadline)
> > 
> > Regarding the circular locking warning triggered by printk, does it mean we
> > should not get a NULL candidate from __pick_eevdf() in theory? And besides,
> > we should not use printk with rq lock hold?
> 
> Is it not a useful error log? At least from the initial report Marek Szyprowski doesn't see "EEVDF scheduling fail, picking leftmost" but seen only warning triggered by this in the logs.
> 

Yes, it is a useful log. I was trying to figure out the safe scenario to use
printk.

thanks,
Chenyu
