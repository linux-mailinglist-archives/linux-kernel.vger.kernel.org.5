Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF067BF0A1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 04:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379356AbjJJCJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 22:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441863AbjJJCI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 22:08:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D74E9;
        Mon,  9 Oct 2023 19:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696903734; x=1728439734;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=O4Sd5e3o4McqHoipIszGVZp9ZD1nAtfHMtdprBcjzPw=;
  b=Pf/BF1CQzn0ym6JL3XRdHKueQoeP8amZPsVGtGV/XBM/+gTm/cYXfXPj
   J9kv/qs8R18yktHG6A+A5gMsb4Ha8664/YibCVuOGVxoAevHWpG2pry5c
   K9DID0CYmeANfuMF0h+IFW1L7BzUNFBFQgm+HMC8Zor1ka0TT95srka8z
   +L+I+1aXliGF6kMhA0CVX+Q8joY1tJweN4jIemIFmud4J741Cgn0FGUel
   oFtLPHz8lKUhuidXhwU2iEal2pUoCCCCgjsBW9fgCw3iky37iTO4q27DB
   1wf4JFZgAcWma2PVDtZt53oVc0niyfCMDVSWL3rsgCl3DOKQZAVQA9x6v
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="470553797"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="470553797"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 19:08:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="729900978"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="729900978"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 19:08:52 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 19:08:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 19:08:52 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 19:08:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMtclbcig//juOxBsaJ/ozQftYdhFNEDa66yhElkNKFh97morQVyP4tsX4haWktTxplyPiw9DtpMDaa0eeAF/EJEV82jEXw98SgkF+u/TP7Skflecmhhwrmxdai6cWMBYeuJQK9eZcMQRt/ZirIPAKjEGP6S6/+6UPsp4xVqeoG8RtkJsYz6IL561FZtlA5HOalDdHJykY5XSbQsPRriEJGiDNrP3r6XcqApumkY2n/EtpkYrPI5vah5fJnvUxnpj71Ul9J2nZgtv911XNu1O/NipEPDkD7wLCOqe29ZKLdR2yIaVND+97K9DJDjM7QvbOIOHgqofBPVKpjzA5FrPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdY/IoqWiIDcmsdurTgJSXAh/znim5pHn5SK8L8sWTY=;
 b=OvXKXZdZbfnqdn5L+xSvttMYNJkZqYrL4v6BmswOpgGRPE8ptZT4Pq+uQcRngsqoQIxA8JNu3hidnUC3R3c/laTtn5+tP3rVILxJ78Nt0S0DdCPVz9b1ronzANkn85IAlL02YAbHxcUqiBcADBwlVwxQAsexnhEKRnTzpNDIRW8gEFHVdTEOZ09rUdALeRR5kQQTGn4v6gFcNpJ+LSpmgoKDL3FCpSlVnap+VbVqAiKIF2TCtISUfJNO1i6ueABdQpCk9giymaHYuhXSRpQYk+lems+kfCR6ddEw70K3O/vFGuR/ryhUsklKrtC5GQqU5znfhMWYBkiOOLtuAv3qYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DS0PR11MB8231.namprd11.prod.outlook.com (2603:10b6:8:15c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 02:08:50 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%5]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 02:08:50 +0000
Date:   Tue, 10 Oct 2023 10:08:31 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Phil Auld <pauld@redhat.com>
CC:     Biju Das <biju.das.jz@bp.renesas.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <ZSSyH6pCu+v10xsB@chenyu5-mobl2.ccr.corp.intel.com>
References: <553e2ee4-ab3a-4635-a74f-0ba4cc03f3f9@samsung.com>
 <867f5121d7d010cacf938c293f862b0cea560ec2.camel@gmx.de>
 <20231006140042.GG36277@noisy.programming.kicks-ass.net>
 <e2645a659b6fc1c592e2f2dc45273c361a2d2f47.camel@gmx.de>
 <20231006155501.GH36277@noisy.programming.kicks-ass.net>
 <20231006192445.GE743@noisy.programming.kicks-ass.net>
 <ZSCoLllO/cYnnIMi@chenyu5-mobl2.ccr.corp.intel.com>
 <OS0PR01MB59222333D50ADBAD1786DA9A86C8A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZSD9wsBPUfhTULf7@chenyu5-mobl2.ccr.corp.intel.com>
 <20231009142740.GA437913@lorien.usersys.redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231009142740.GA437913@lorien.usersys.redhat.com>
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|DS0PR11MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 59d93cc5-3476-4c91-e385-08dbc935d810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dhhqhlnnvqdOEMw6+pJ0I6jMkIcSr3/tCUTDVP4HIe5PlDLEgov3dxGzY9Aj8Ssay9c/4fVA0wfzNlaUBVWmNIiLQbkI5uLM078MDgTrrsDsIq94TEG2wdKxRM3wAcaVPa1tl2RNOopW+StOJWd172nX7vEH1mOi6XZ+Gk2bu1LpZf9aklbL9M7isVc7zW3sDfsrjEEjPoPTYylirLnywxwRYk4wC84btlI18qKaqZB+MziU+r1AMoaX+I3O4fQbo95QM7jwWj/IPhBxfdSW3gs/lKcgndRASqU1h7n1b3PhxdDU2UWS04hZ3zfkJUWuZPNWzX0015vimJofdY89pVk/aGJr7IThB9PPoM/07woWi2AC6WQR2H+7BC+FMrHYYAqr8rPYIym3VW4jOwHU6Q82In2xlKoux5WCajBfsEtUP6O+0JETDs9HTA0fq0EFcFUcfj3C/SO7JbMCpdnMjyhxxOR+4jALSRacd8IExPIel16h9WED0SD8LD7BxNgbCGMzhrEOEnF6NvavXeAU9s+nEv1PBcyWBjMP+/Iiji47MDzz1mJWLUmlggn7Suf+E8VGezv2+gFQlI4QGPSWfmEtOxO8dWetIntKEvUB4k4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(82960400001)(86362001)(38100700002)(2906002)(6512007)(478600001)(6486002)(41300700001)(8676002)(4326008)(5660300002)(6666004)(8936002)(6506007)(53546011)(83380400001)(6916009)(66476007)(66556008)(316002)(7406005)(7416002)(66946007)(26005)(54906003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MFQV5dkvSZIu9wo5nNUoa5tm7m+0+k14Hfv3o+71Y3RXl4bXPYqYkFwolJCJ?=
 =?us-ascii?Q?f52TQ9MM+eglEeiMZkLmovRfup2U3pWEzD8fvfhJtGaGhk1M9P93xjKhOovP?=
 =?us-ascii?Q?eTb91sqwYKJ+05LeFU2F8FViCzxGZXbQLhMzP49IBkAi7BdAnHQabH3ZAiY/?=
 =?us-ascii?Q?2VScJElgK6QvwwsS3OtZSU0vQyMjo8acshx0BxpOJ6FILB9xgyg3GQ2fNwwg?=
 =?us-ascii?Q?Stt3TZtx7WWeuiW/4QHUz435IjoUFhwFD/8+FG3hfU0Xi0x+YbfpLlvg16Tg?=
 =?us-ascii?Q?WrFAOU/KpepEiBxizxQUpRms0vRjDBmOiVqz5MTR2E0ApTpI2FKnlipE7/N4?=
 =?us-ascii?Q?QEXfqDDbgA56ktBBdy4WcYCunUvMPiU45rC8EXaCIsMVIEDpYD+ENYXnv+Oe?=
 =?us-ascii?Q?88eDd0t8sdGhfxpiJY7E9CvSjcMZtHDjrUt3O2KhpswR5Inx5Dql6LTI0rQf?=
 =?us-ascii?Q?9fc/zVQOiweoUhLCZ3xVSTFAYI1sxBYLjZIPE7UbrPxyoHGaPH1fenPeF9r3?=
 =?us-ascii?Q?SVNcZNCzEzkj0CRyF/ut1S7kIrWWcRjZt+29M3OgyMzN3+a19qoShu7OBsb+?=
 =?us-ascii?Q?jo0yUJVvpvEyN3RWJnXBo8k2oZczlIzLyf81Rh8P1ECI/vBtDyVl5d9N9jkz?=
 =?us-ascii?Q?1xzDJp5od+8YzYXSXN6ULpBvG+xPW5+y16qvj98ogBjo1xNOlWorVHIO598I?=
 =?us-ascii?Q?039rOIaRPWgvse61kWhuYC87i4+utGe7ZYM8HXEQUgdzXsEI/9MT46XXUEsw?=
 =?us-ascii?Q?ZRGiqiiFeVysauCdjIDMjj1nonmteWSlZAByA6ZHaqWSUh53rqB0ftMFoAXp?=
 =?us-ascii?Q?eAGggn3ibel1Uv6w1yUHSzol4QqjLAugEtudBxxNAUVolkhh0HMjtf5D5tQV?=
 =?us-ascii?Q?ctnbIQ7GMqwDrNKU7RP1KfIpvOUIfa8psN7iMOt5YHJzuqTEJcjuL6CUrxk0?=
 =?us-ascii?Q?jT8Et+rAbSQpye3k9ZVzHGhrKaZrlE+2hjn8vwqueBUJHwPelIxc0kgo1A8f?=
 =?us-ascii?Q?9u/uYMSRfB1yWnDtjpeP1huUfl+UcYoHvaTreYSYCCovgEmuUwqNghGXNp08?=
 =?us-ascii?Q?CogwFE9NcGskAcKDoGfO+KR3pmdGXErkbi9jBiGREi20592n2m9/mcLpuQ8O?=
 =?us-ascii?Q?hO1AXokENqo7qkZp7qYs8M+C81jNyYyfN28+yfGeBD40BW56BKKMpg9AU3aB?=
 =?us-ascii?Q?AksNel6fVwR0RPz5UCFmI0CMowSm6lp78PeVLpZ2gj/yeQILqeTlyrb3EZAv?=
 =?us-ascii?Q?6SCajr2jWnMWojPf4nZQSuVpWTfLmbBIc0sikl3mJECBVoDih3OSOB2mf0/T?=
 =?us-ascii?Q?ELE1OsPhiE9dnzx2OW7d3FOARN71dkwkX6p3lFz4rFwJqhKttzSIRb0KtMjF?=
 =?us-ascii?Q?CTWVvDVzFG5eP5T4MLDCigpjc6Q0u2Z46/SydTjwkX8ca2IjkoZvi7+ZZf30?=
 =?us-ascii?Q?/C5PVmCwQghDzGtr8yopODS+Yu9bP+zp4Xxt0tcA9rR8S3sjwxrvXTcxTw7+?=
 =?us-ascii?Q?so5/gw/kfb1dgrgSw533X2c0++wus4bbEcHbsv6zsmTuJ5MW6z79ut9TspSZ?=
 =?us-ascii?Q?ZKa62FaM6Mrw1lgqjgVCdRSAyo6XGaLHCQhRUqwQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d93cc5-3476-4c91-e385-08dbc935d810
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 02:08:50.0187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AB/W2D5FrGx7qLvDEIOAd5YPk2wgBRywDLsHaX/Y9amyGewwJcvYqrdn8Oyqt9Kxlfo0JIolWekZXdHx7nKnCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8231
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

On 2023-10-09 at 10:27:40 -0400, Phil Auld wrote:
> On Sat, Oct 07, 2023 at 02:42:10PM +0800 Chen Yu wrote:
> > Hi Biju,
> > 
> > On 2023-10-07 at 06:26:05 +0000, Biju Das wrote:
> > > Hi Chen Yu,
> > > 
> > > > Subject: Re: [PATCH] sched/fair: fix pick_eevdf to always find the correct
> > > > se
> > > > 
> > > > On 2023-10-06 at 21:24:45 +0200, Peter Zijlstra wrote:
> > > > > On Fri, Oct 06, 2023 at 05:55:01PM +0200, Peter Zijlstra wrote:
> > > > >
> > > > > > And yeah, min_deadline is hosed somehow.
> > > > > >
> > > > > > migration/28-185     [028] d..2.    70.264274: validate_cfs_rq: --- /
> > > > > > migration/28-185     [028] d..2.    70.264277: __print_se:
> > > > ffff88845cf48080 w: 1024 ve: -58857638 lag: 870381 vd: -55861854 vmd: -
> > > > 66302085 E (11372/tr)
> > > > > > migration/28-185     [028] d..2.    70.264280: __print_se:
> > > > ffff88810d165800 w: 25 ve: -80323686 lag: 22336429 vd: -41496434 vmd: -
> > > > 66302085 E (-1//autogroup-31)
> > > > > > migration/28-185     [028] d..2.    70.264282: __print_se:
> > > > ffff888108379000 w: 25 ve: 0 lag: -57987257 vd: 114632828 vmd: 114632828 N
> > > > (-1//autogroup-33)
> > > > > > migration/28-185     [028] d..2.    70.264283: validate_cfs_rq:
> > > > min_deadline: -55861854 avg_vruntime: -62278313462 / 1074 = -57987256
> > > > > >
> > > > > > I need to go make dinner (kids hungry), but I'll see if I can figure
> > > > > > out how this happens...
> > > > >
> > > > > *sigh*, does the below help?
> > > > >
> > > > > ---
> > > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c index
> > > > > 04fbcbda97d5..6a670f119efa 100644
> > > > > --- a/kernel/sched/fair.c
> > > > > +++ b/kernel/sched/fair.c
> > > > > @@ -3632,6 +3747,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq,
> > > > struct sched_entity *se,
> > > > >  		 */
> > > > >  		deadline = div_s64(deadline * old_weight, weight);
> > > > >  		se->deadline = se->vruntime + deadline;
> > > > > +		min_deadline_cb_propagate(&se->run_node, NULL);
> > > > >  	}
> > > > >
> > > > >  #ifdef CONFIG_SMP
> > > > 
> > > > Is it because without this patch, the se->deadline is not always synced
> > > > with se->min_deadline, then in pick_eevdf() the following condition could
> > > > not be met, thus we get a NULL candidate and has to pick the leftmost one?
> > > > 	if (se->deadline == se->min_deadline)
> > > > 
> > > > Regarding the circular locking warning triggered by printk, does it mean we
> > > > should not get a NULL candidate from __pick_eevdf() in theory? And besides,
> > > > we should not use printk with rq lock hold?
> > > 
> > > Is it not a useful error log? At least from the initial report Marek Szyprowski doesn't see "EEVDF scheduling fail, picking leftmost" but seen only warning triggered by this in the logs.
> > > 
> > 
> > Yes, it is a useful log. I was trying to figure out the safe scenario to use
> > printk.
> >
> 
> You should not use printk with a rq lock held as some console implementations
> (framebuffer etc) call schedule_work() which loops back into the scheduler
> and bad things happen.
> 
> Some places in the scheduler use printk_deferred() when needed. 
> 
> I think this will be better when the RT printk stuff is fully merged. 
>

I see, got it! Thanks for the education.

thanks,
Chenyu 
