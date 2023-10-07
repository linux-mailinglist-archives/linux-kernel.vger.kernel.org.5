Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F647BC359
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 02:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbjJGAhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 20:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbjJGAhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 20:37:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C80DBE;
        Fri,  6 Oct 2023 17:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696639050; x=1728175050;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cy0uKGG7R7z72n0MgyNSFRmL3Yp6sBPfpF7uY1mfUw4=;
  b=giQL/B20/iUP//fpwn8wWyuxCll4vuhDpp4fjdfJHKx0Cyo+HyoyVkR1
   moj5C1pQ6J5k3SlAA8J8FirRLYjdxxDCJ8tAhN8zrkAFeZ0LXU3sfMw0t
   JMZqlHxSdL1HidZBnHs5B7smjVa6xtHLcwQwDYAvfREpOfLMXZM7Fkhvu
   clM1zxa2Evu3IoczZx8mq65oaHRvcjM5xQ0fNMGrbQT/wtLrmU0CwmXvI
   5/bZrkEqjx1L0qw6C2P3AyWt4TSdeeWtdEa/F0cJ9yEjjkSs+dItESnR+
   HBJ6s3rcsGnaDd3zFyLV+Ph4gHGC8jLfW7mE0Z9JoWFEOQQV5c0UUYlbN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="470132842"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="470132842"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 17:37:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="781831994"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="781831994"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Oct 2023 17:37:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 17:37:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 6 Oct 2023 17:37:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 6 Oct 2023 17:37:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6BPCL3FaqPflMYoC1QRBG8kYSJ1A9axgpg5YNNE8z9zi50ox88SegmUAQaYE3ObTtGVt3bt0xJSNz64+dJ2L7+o+0z3bbWTMDNT3/50sdcUh+IxuKXll5MYNm7W+l/4ae16F+X6vij5Ha2iL4yiOrlEZfWnBn1n6Ss+yOcXus+V1pA/xq4UZ7IL5aDGec08rUkRuaJGmve+IsIR5b//IRd/d0O7zbFDCOnU6gTLS+M+4Qp6QhWVl7lw9oRtkYXY+AjRs6RMWTUz+f/sWqhMd8zLWz+Rvz6syXX3crKNPpE9PA9Pp3WJXtYeFbvR7SAOkt5iMndAcQFdNlPF93xZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPvx5DTCP7TAPTvyAyeLp2rV3+xj4CE+yRnn/qJ/hcA=;
 b=Uk+pAnTeU04fhbJboWJehJpwa32gY+jVrISvNqgtKlU4IM4SMWy5mQpdipS1y63XEeOG4ocKVmuTpfOkJqQBo9z54KQH7LqDjRsxKMZWtS5uzha846d0FVhEX095e1PjlhhqZ8cJcMKvwC0Hg0yefJ/hD7qBHxPdErcSLHLeoI2akMdx6AwbVG9jBDnYd8o+7Xw/GtNcmFjfE8Jg+LKE1ZWmQZXDAkFny1p2rjBm2/g9vd/eLWdfTiD30DG9sRhA4xL/l3luYfIPXs0o5MRv3G+LrptGLTusrVaENn3jyZLcYSMt8UBonfsXSNxaO1Dw3j4t92oTtNQTI9D4prCXmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CY5PR11MB6162.namprd11.prod.outlook.com (2603:10b6:930:29::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Sat, 7 Oct
 2023 00:37:26 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%5]) with mapi id 15.20.6838.033; Sat, 7 Oct 2023
 00:37:26 +0000
Date:   Sat, 7 Oct 2023 08:37:02 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Mike Galbraith <efault@gmx.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
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
Message-ID: <ZSCoLllO/cYnnIMi@chenyu5-mobl2.ccr.corp.intel.com>
References: <OS0PR01MB59220AF3959BDC5FEFC0340F86CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20231005150258.GA36277@noisy.programming.kicks-ass.net>
 <CGME20231005150845eucas1p1ed3aae6b90c411b5c26a5dfadf7e0733@eucas1p1.samsung.com>
 <OS0PR01MB592295E06AD01CAEFBA83BF386CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <553e2ee4-ab3a-4635-a74f-0ba4cc03f3f9@samsung.com>
 <867f5121d7d010cacf938c293f862b0cea560ec2.camel@gmx.de>
 <20231006140042.GG36277@noisy.programming.kicks-ass.net>
 <e2645a659b6fc1c592e2f2dc45273c361a2d2f47.camel@gmx.de>
 <20231006155501.GH36277@noisy.programming.kicks-ass.net>
 <20231006192445.GE743@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231006192445.GE743@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: SGXP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::34)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CY5PR11MB6162:EE_
X-MS-Office365-Filtering-Correlation-Id: 2303b3ca-8793-4f04-7937-08dbc6cd9424
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /vygn0ww+c6JUfL7SFhIQs5bbk065+RpF5nvMWjA8xPYqI+R6u/0hXm8xt1KCR0Z/mHBMwh5rXymDmT6umL6r+/XveHL+Da0xXbI+EB3b+y/NpDdx9hFzrqm/WgDhFI+0KhC4x9YC6qCYyx3XEWCP08aS0aC/coZ5/pSAcU82JJtd2HI9mRFVYUMwJ9lKtMVaKYyEnMgOvJCTxjxP1C6SPv26RJYsUu37EXvGQ8o8wDwqnvsi2XrEcwMDRFIprhr2TH8jbvYOZxw75MJzXkPu9MTgmZpNrj/iMijN/Qdy9cClaj9NdXJ1fYLTzQSx1xrz4WHkowsMwAaYWnB9STz5QriWIEBUr98ZrUtTHm+w70K1jCz5lwx7+5+Oe1NykoxwZWljkCr9pBxwOy9mbVYxJcs+SwgQCPn26KOhaFnp13HxapVn2VR2EAd1xiN04z1iP5fFjz/Js9O+la8k0+u+Do/A2zOO1aseGhiGJGtfI2n+Qq+9EXSr5enhAo9mjatbKrVTNjuulsSsfcbEDEyRK+CC/UK51KMAn+6vX4jwnGQr9GlqEEXhYBG6GIgmwFR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(83380400001)(6506007)(6666004)(478600001)(6512007)(53546011)(6486002)(86362001)(38100700002)(82960400001)(41300700001)(2906002)(7416002)(5660300002)(316002)(26005)(54906003)(66476007)(66556008)(66946007)(6916009)(8676002)(8936002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DgBfgKgYofyR2ngcbv91SJJU5tlPqa0zGFgof2UdILO82FFQJXmOJhIoKAPA?=
 =?us-ascii?Q?ToIK/7LhUCY3EdHN2x+e8/mDkf4UMx1OZnXP8Q+LepaMgaglcUYqyloSKNug?=
 =?us-ascii?Q?hTwgEca+pFhZeURY9U7q8hNrlvTlhWNq7YuwPrhTeOXzqoaJUpCzRR5eT9ro?=
 =?us-ascii?Q?TpJtSXYbo7doQYHQZ/bd9riwKImzGw2zR4TVLuIQsVRlq5J1LZfbd598mLI7?=
 =?us-ascii?Q?tjJfLuBefHB/jdCndq3fGPHU0H8sO3digYx48SDGenJvgYwUnVM7eFIRpMEu?=
 =?us-ascii?Q?NMECW6gd4T2i9ZjBa0Fpib8ag5diTTuIpxyKZRfK0Uf89d/dwSNZCUHTEB9L?=
 =?us-ascii?Q?RBCpdLJA+m6ELy56FbS9fFEOpe9CZ7Z/W+ZsiOIF3mR8MGirkhZMiy9rbDsT?=
 =?us-ascii?Q?WFxfz4/fVVHHWNqQKA3kct8AHCUcGoSj3cZPfGmPvgjY3NPnhKaq2Am1AiCV?=
 =?us-ascii?Q?SpwmeHvV7PEQDDR4vNk641VX2YokuHztzh42/PqGp4irWunKZy3gVe3iXBAc?=
 =?us-ascii?Q?shw+S3b0Fu0GyrKxQuPKO+286IbtQBfPLWUI5a5aZzlCX0KO5UbWrB/EDgi8?=
 =?us-ascii?Q?b/vYE87IMS5SwpsENsTB7QhqSt/1L5QDegUR3XaItYZYinYIc0nn74OY2dIA?=
 =?us-ascii?Q?W90LihJFW7DIl4yNjldxt29ui8mMQfqGzFHzcrPrkXAXflBYoF5ARkhwbYqA?=
 =?us-ascii?Q?6bR85Jrv/5pAw2lc5ocolobWGjHA/UcYS0HMxJPuv96h2omQ90Wa8GdBV75J?=
 =?us-ascii?Q?PcL6W19ifnB+839kw6PNeHIsAm5DT1OvafZ4ibaaiPndllBA4NN7a6J6siRU?=
 =?us-ascii?Q?bsoar9uSV6ZQ09nmQt0W52CxY+Jb3sD7ihFDQF7Ub62K9Phd9oXnygyuCfgz?=
 =?us-ascii?Q?Wdi4gaATtj8y7TQCay+8XrgjXAxNVBv+XAYBvJu/q5mBB3E/W2Y8nz7IzEWq?=
 =?us-ascii?Q?PjlKnrn3HLIUdg28WJq8vC/8BNG7HoyqM7p97Jl051e0wROxngn0tkqV3JJL?=
 =?us-ascii?Q?QoaL1hxq4d07kCdHwQPkmuweRj+UXiHp2hvAW1L0vvXfKNIageD23xt3PjqJ?=
 =?us-ascii?Q?jK6UMkK0AQHZQW4TR5ShIbh1pv1RjqeOBOq+gHhc9IQoraw29dw/80wm4MLa?=
 =?us-ascii?Q?r6iINIgjAc4+Zx727Z3zGVzKIDP7o2smvC8vOlxwlRwsQpb8Z2uggNUjpZg0?=
 =?us-ascii?Q?O6x0IwRL3uQWapsxEeZKNFumfgV3F0ycm2ObfpQmu+JaXROGMc3vMCSyBjA7?=
 =?us-ascii?Q?k/yLub3w/JBZUupzoJ/nJGmnjQLOFpF5Hn7ju+EZhpZka7GLD6pYAcgFzFZ/?=
 =?us-ascii?Q?eMHhMxg7zJNacPPB1guNtS4/CE9dVH2EAoU9OYrrSnhoqKiJU02KfRAmJM6H?=
 =?us-ascii?Q?fA2vWM5mtvFZtUuHxbvBNRGy1lUfYwhoWpvGcJd1mgmtQIUnAR01e6FfxHel?=
 =?us-ascii?Q?RES73umo8DTyUY5WmDELhmmOrweRJXrWKPNuyUxSm5cJ7PD8voU9JoMOEClC?=
 =?us-ascii?Q?h4sNMAl0zXK/kaKeAxyr5AWX6F7unqoBtl+Y7m87q8bOAiq5KkUIeu4aLeIH?=
 =?us-ascii?Q?DypVkQZ42+C1wLJpS3ifvhD8/mXRrq3j0aZ1euKj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2303b3ca-8793-4f04-7937-08dbc6cd9424
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 00:37:26.0508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: saBgpBGKjrQKNFVdITA0G3vLnydw3swnkO5iY0e915FNrEpxjLrrarMEaWxlg31XPKuvzs7s/GQq06N3nyQ8aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6162
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-06 at 21:24:45 +0200, Peter Zijlstra wrote:
> On Fri, Oct 06, 2023 at 05:55:01PM +0200, Peter Zijlstra wrote:
> 
> > And yeah, min_deadline is hosed somehow.
> > 
> > migration/28-185     [028] d..2.    70.264274: validate_cfs_rq: --- /
> > migration/28-185     [028] d..2.    70.264277: __print_se: ffff88845cf48080 w: 1024 ve: -58857638 lag: 870381 vd: -55861854 vmd: -66302085 E (11372/tr)
> > migration/28-185     [028] d..2.    70.264280: __print_se:   ffff88810d165800 w: 25 ve: -80323686 lag: 22336429 vd: -41496434 vmd: -66302085 E (-1//autogroup-31)
> > migration/28-185     [028] d..2.    70.264282: __print_se:   ffff888108379000 w: 25 ve: 0 lag: -57987257 vd: 114632828 vmd: 114632828 N (-1//autogroup-33)
> > migration/28-185     [028] d..2.    70.264283: validate_cfs_rq: min_deadline: -55861854 avg_vruntime: -62278313462 / 1074 = -57987256
> > 
> > I need to go make dinner (kids hungry), but I'll see if I can figure out
> > how this happens...
> 
> *sigh*, does the below help?
> 
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04fbcbda97d5..6a670f119efa 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3632,6 +3747,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>  		 */
>  		deadline = div_s64(deadline * old_weight, weight);
>  		se->deadline = se->vruntime + deadline;
> +		min_deadline_cb_propagate(&se->run_node, NULL);
>  	}
>  
>  #ifdef CONFIG_SMP

Is it because without this patch, the se->deadline is not always synced with se->min_deadline,
then in pick_eevdf() the following condition could not be met, thus we get a NULL candidate
and has to pick the leftmost one?
	if (se->deadline == se->min_deadline)

Regarding the circular locking warning triggered by printk, does it mean we should not get a
NULL candidate from __pick_eevdf() in theory? And besides, we should not use printk with rq lock
hold?

thanks,
Chenyu
