Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D43D7C4FE1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345779AbjJKKRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjJKKRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:17:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE23A92
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 03:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697019439; x=1728555439;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AhIBeQ8xzohjys0CkT9qHnKzPV1P0VQfp7FOqTWTGKU=;
  b=c0qknO/mKgHNCCDRliuTpaiiFZFEm3T7N/Ma1C9USEAee+eUDuWeNoC3
   XsXyqoM55E1wVM+dUV01u1gH13q4Y/7G9i4wsPfTgkt+KDCKKF29tJtds
   d39ljI4Ao3VyD1o4hnTr5vsghviqDi4rQu0sEcpYsoKMuWxYWK3/uexk4
   YEwY1eNSlrdJ4n2eBnFNQy5wCl/Y7IkdSokA7IwXRdk3TEW7ASxJDcdkm
   Exj2gu7ezkY8x1CQO3HC9V+v7A3Ixp8a5IabVctzuIP2Axgd7q/482uk3
   y2DEDT3sgwXjqd6tuiD9KBa9t5CBEWomeOo+ETXVmUVQiyYIxx5MhIc/Q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="415672456"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="415672456"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:17:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1001051988"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="1001051988"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 03:17:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 03:17:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 03:17:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 03:17:09 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 03:17:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RU1eEwiuReKOz2efSolVSVIm9UsJnsuAxxWHJFkgRP7lhEk0vbPWN8w//7RespIv+pCtcLV9Ec0yQFvoBZoHN+1zVS9Izvxx4Uz3lzxlB0yCafrxsu9/dx63t6dy6EKtF6dPhgPKUBra71sKmoZSVUN07ygwlbbxHbEmnVFAIjnEIUr95k+yZB6EjTmFvt/JqTTxGaVHe+PHPHq3TCbOq5B3qKfaooKljVNzhlyWyDtmxYxLEzmIO31CrVOALdoUx+uENPP+fsPh2O3mEbMU/w0uTaLWjZ1vV/ivGYh0uFOLND6FrmE4Y9mQdNX9JXWD7KvA5poN0/cnq1cO0S2VAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGrIPzB/q1uT15idDmlDlNf/jaK9nA9RxFQR1XfHumc=;
 b=EyP0F0M3vmrZGJWyET83X+Jnz5dgqF/FnPVDKXT2nYaIrtuXVlByiMSl6zCF4S6iJD/p5hIBoJUDOIbCe2XJ1ghIVgCiton7Pxot9xq0Uko/PWAZuGD3+RlBwR9t/H/xhOvLucieWP799edq3jJFLEQh7w/CI84G+Bc8c+FrqZ/DDbqd7PbNr3j7VLq9nw6Uy8PM4QhTRSx0uVPV15ReRmX7EyeaQWMttUqdbtxXV+KATAGVe1nNxfMvo9VHOmz1i9aGEFoAd8YNIywXgjJesV6/CJTVPzoYnmmuOhD80wbQ1sultv6Jyhxf0xCtom3EhUkvJ3TDG0D1uAmWJSjNAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DM4PR11MB5437.namprd11.prod.outlook.com (2603:10b6:5:398::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.40; Wed, 11 Oct
 2023 10:17:08 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%5]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 10:17:07 +0000
Date:   Wed, 11 Oct 2023 18:16:49 +0800
From:   Chen Yu <yu.c.chen@intel.com>
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
        Aaron Lu <aaron.lu@intel.com>, Tim Chen <tim.c.chen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, <x86@kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Bias runqueue selection towards almost
 idle prev CPU
Message-ID: <ZSZ2ERMysY7iEo+x@chenyu5-mobl2.ccr.corp.intel.com>
References: <20230929183350.239721-1-mathieu.desnoyers@efficios.com>
 <ZRfKKxBzfu+kf0tM@chenyu5-mobl2.ccr.corp.intel.com>
 <0f3cfff3-0df4-3cb7-95cb-ea378517e13b@efficios.com>
 <ZSOMOhhkPIFmvz97@chenyu5-mobl2.ccr.corp.intel.com>
 <ebe4e40f-37df-40a9-9dfc-7f2a458151bd@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ebe4e40f-37df-40a9-9dfc-7f2a458151bd@efficios.com>
X-ClientProxiedBy: SG2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:4:188::12) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|DM4PR11MB5437:EE_
X-MS-Office365-Filtering-Correlation-Id: 304f126f-b24c-4f51-d802-08dbca43388f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hlmeKN6o5+xRnJtZCXFyUmEa19SGLg34SWZUEG6z9kSaQntDf32O/gqMlaHovVakkjVY3tO1wlRTF398cR8iVPYzPIrQ4aWEaacK/tP7w5c5g7aYfHgfr/HQ4FoWec6LiPeP1NJ7rSsBFoezMqISAzZ1r6pwVc5d+MOrauxZdhBr+r0dQQ92u25Ii3llqiIHnrs08zpfRIPYr8e8fsM08rZF4KecahRNqkhoEJnqsJtEDuyHomI2bPSoeqFVe5ljxf41bbDkApt08BTQ792OV6MAkyfXWsdphTppnI+yCIkkGRBuAkWxcxILXAtsf/Vu6T0bZ7VCKyEYJ3m09nPJOEnSjXuVvQzN1UJ1SYS6YHgi8o1vuUsqX9Agyb/MCNDtLMYYoCTJ9XXplVjpz3WkkVZqxdUVlt+/J7tKOfyPtbIme8vz3xzr6IJdLHFvQLltx2Q7xZNVO6wAEBbVPEzQwMDHku2cP/+3PClPvl+Wb5YX/+uQVV2TwOBBad74g9U5L7POAiRnrGDIx4SSoF/EYztHau1PyHQXNimmovir1inya14HkZsxYXenNjBfIpW21vlRzzTcPSNzfHZsPkPGpyNrKeiYfA1IEVRlviuygZ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(39860400002)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(53546011)(6512007)(82960400001)(86362001)(40140700001)(38100700002)(2906002)(26005)(66946007)(7416002)(83380400001)(4001150100001)(6486002)(6506007)(6666004)(478600001)(8676002)(4326008)(8936002)(6916009)(41300700001)(316002)(66476007)(54906003)(66556008)(5660300002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DKGq4SMjjFm0jLYy6KatIZxLy3yQVW71OpscgEodpQrps14/N4oKPzZucgaM?=
 =?us-ascii?Q?HBjUMBuLlSF3vZwFhELWeDPHdwH+gMk8XiPxm4wn3gl6xR1xiiFudeAL2k0q?=
 =?us-ascii?Q?AisgtDVIgnxDunjUuVkCty++cIxcn7F51+PbtEhgGk3ahqTbUfp+MRhg5ud/?=
 =?us-ascii?Q?GbkIx0+XGtPpAqH4Dj00wCHMOSHDl1um+dO63TBAAyBWjVvM+QsN4d2rJ9C2?=
 =?us-ascii?Q?UPgYT33seSLgvVwfqeVyVTIeWtJTVd2Ls8HqoceMU+p300ZbS+Y57HQ990rW?=
 =?us-ascii?Q?3ex5GLAxqawSiyHGIUBJvRPN3o62tiGhiYM+bFMd9mryQKPibth+6iHrt+0g?=
 =?us-ascii?Q?Ghwu620TH28+W36kgg1fW/OfLIOxSYq0PsjLsq9zziGhl9KlvdDPH710KKDa?=
 =?us-ascii?Q?iismZJTpRzlz1Q4jedo8pLce608e4oh22L5oS3bPfrd1+ICFBmIPE1aD2Mzk?=
 =?us-ascii?Q?qHgIzYr7MnAAd9wHdQ85GojYBvcLj6K5sGJn6OR2zCaaA7s6/ZCRjCgUycxN?=
 =?us-ascii?Q?a1qW/GOBzvqVtEqerZ1GYEO8NVttUHRYdlI+LJKVAoHt0j5zMBKxIYC83Ezk?=
 =?us-ascii?Q?XZbYC28hi4V7FHzxG47w4fc6XqYGbwcV8pJR/qGsRvruqHxEU3lwWFrE0e+c?=
 =?us-ascii?Q?DIjQMPMRAkgNRH2Zx7Terzv6Ue93CbkVA+23+PNaSfv5TLUraRD53i2BVJwi?=
 =?us-ascii?Q?Ul2cVu/K/d77SOxtpyx2PHLziw93eBPDoXvoDyFfdYOnPqeR5RAlhkXCk/YR?=
 =?us-ascii?Q?ZAf4TnIYHAJTSPFxisFDElLvlki/aX/Cg1sKh293K/miNmdSX4uA99AivZGh?=
 =?us-ascii?Q?gpROLSZGIA76sfr72hPFwr65YY4j+QmreJs2UGgPFHyemJHoKwwJ07OOZezC?=
 =?us-ascii?Q?dxPWcjKoaE7UrefFWLHVataxwB8aP54KXUFeYAi1jsO0qIp8Ebo3Aqh3WybZ?=
 =?us-ascii?Q?YTrHhx1e66tI+voIkTE933g4qL+knts/CemP+93O6Lm7T1VmjKIxMnm1ZVZK?=
 =?us-ascii?Q?7qSe93ZauSN9MB+DQbpa+1s61GkU7JqWwFWEUQirK+lu60Jz54nbqOGWYiIb?=
 =?us-ascii?Q?AGtZIbvhlJw++DSikkS3Fxq3kTmQZduIGkCc9QWF8guOlC3Ks81j+fMLM78V?=
 =?us-ascii?Q?8geHh/q0HyYpcGNKmVrN6BSjrLNMHFI4RAh0suVwBkuv6EBXtqx9f3//iOri?=
 =?us-ascii?Q?jGk1i4ZXJukrTRSkBwy7JBzugEB1U+2jm6Q/TtAOA9Rz2hXsk5byTx+O1JsR?=
 =?us-ascii?Q?R7/W4QgoLNngrb99SKZjXb9ALyd/7i2iFv9xJMNZgmRVKb1VqeB6N4EZXKGT?=
 =?us-ascii?Q?y5IS2k8t6VJwhvYlm4VaDF0KhtW5hhcDpv6YczWc4ilc4E4JlHGlQYmt67F9?=
 =?us-ascii?Q?yUFRNqkYlvy3x5+KkAB07kuldH1ufeVT25pjU2T2IYg62io/7gSmqDQR00Nk?=
 =?us-ascii?Q?Lq0rxqDz5BM+CXLxtLQ0vrC3wXbQUVMIOnrdfo2o5Jccyt3M3auZW4wtmllu?=
 =?us-ascii?Q?C43f7wu0XGtMcVddIITXSpJiK9O1zo9yaOPcMAvFR/Bo0o1yvOfF4jS6dmxg?=
 =?us-ascii?Q?TrwVAaH6DKkZ/ptX0pMg5Ra89Vh/DuJaMQ/3GHvH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 304f126f-b24c-4f51-d802-08dbca43388f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 10:17:06.5246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4Co/Nmnwix4Jng3fvo9pdNdAdRFXoA/Kes5Xe1MD0UEropPnyQZB8OVsas8ET7sFpfhv1fUSYKMVvp8MWw5pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5437
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-10 at 09:49:54 -0400, Mathieu Desnoyers wrote:
> On 2023-10-09 01:14, Chen Yu wrote:
> > On 2023-09-30 at 07:45:38 -0400, Mathieu Desnoyers wrote:
> > > On 9/30/23 03:11, Chen Yu wrote:
> > > > Hi Mathieu,
> > > > 
> > > > On 2023-09-29 at 14:33:50 -0400, Mathieu Desnoyers wrote:
> > > > > Introduce the WAKEUP_BIAS_PREV_IDLE scheduler feature. It biases
> > > > > select_task_rq towards the previous CPU if it was almost idle
> > > > > (avg_load <= 0.1%).
> > > > 
> > > > Yes, this is a promising direction IMO. One question is that,
> > > > can cfs_rq->avg.load_avg be used for percentage comparison?
> > > > If I understand correctly, load_avg reflects that more than
> > > > 1 tasks could have been running this runqueue, and the
> > > > load_avg is the direct proportion to the load_weight of that
> > > > cfs_rq. Besides, LOAD_AVG_MAX seems to not be the max value
> > > > that load_avg can reach, it is the sum of
> > > > 1024 * (y + y^1 + y^2 ... )
> > > > 
> > > > For example,
> > > > taskset -c 1 nice -n -20 stress -c 1
> > > > cat /sys/kernel/debug/sched/debug | grep 'cfs_rq\[1\]' -A 12 | grep "\.load_avg"
> > > >     .load_avg                      : 88763
> > > >     .load_avg                      : 1024
> > > > 
> > > > 88763 is higher than LOAD_AVG_MAX=47742
> > > 
> > > I would have expected the load_avg to be limited to LOAD_AVG_MAX somehow,
> > > but it appears that it does not happen in practice.
> > > 
> > > That being said, if the cutoff is really at 0.1% or 0.2% of the real max,
> > > does it really matter ?
> > > 
> > > > Maybe the util_avg can be used for precentage comparison I suppose?
> > > [...]
> > > > Or
> > > > return cpu_util_without(cpu_rq(cpu), p) * 1000 <= capacity_orig_of(cpu) ?
> > > 
> > > Unfortunately using util_avg does not seem to work based on my testing.
> > > Even at utilization thresholds at 0.1%, 1% and 10%.
> > > 
> > > Based on comments in fair.c:
> > > 
> > >   * CPU utilization is the sum of running time of runnable tasks plus the
> > >   * recent utilization of currently non-runnable tasks on that CPU.
> > > 
> > > I think we don't want to include currently non-runnable tasks in the
> > > statistics we use, because we are trying to figure out if the cpu is a
> > > idle-enough target based on the tasks which are currently running, for the
> > > purpose of runqueue selection when waking up a task which is considered at
> > > that point in time a non-runnable task on that cpu, and which is about to
> > > become runnable again.
> > > 
> > 
> > Although LOAD_AVG_MAX is not the max possible load_avg, we still want to find
> > a proper threshold to decide if the CPU is almost idle. The LOAD_AVG_MAX
> > based threshold is modified a little bit:
> > 
> > The theory is, if there is only 1 task on the CPU, and that task has a nice
> > of 0, the task runs 50 us every 1000 us, then this CPU is regarded as almost
> > idle.
> > 
> > The load_sum of the task is:
> > 50 * (1 + y + y^2 + ... + y^n)
> > The corresponding avg_load of the task is approximately
> > NICE_0_WEIGHT * load_sum / LOAD_AVG_MAX = 50.
> > So:
> > 
> > /* which is close to LOAD_AVG_MAX/1000 = 47 */
> > #define ALMOST_IDLE_CPU_LOAD   50
> 
> Sorry to be slow at understanding this concept, but this whole "load" value
> is still somewhat magic to me.
> 
> Should it vary based on CONFIG_HZ_{100,250,300,1000}, or is it independent ?
> Where is it documented that the load is a value in "us" out of a window of
> 1000 us ?
>

My understanding is that, the load_sum of a single task is a value in "us" out
of a window of 1000 us, while the load_avg of the task will multiply the weight
of the task. In this case a task with nice 0 is NICE_0_WEIGHT = 1024.

__update_load_avg_se -> ___update_load_sum calculate the load_sum of a task(there
is comments around ___update_load_sum to describe the pelt calculation),
and ___update_load_avg() calculate the load_avg based on the task's weight.
 
> And with this value "50", it would cover the case where there is only a
> single task taking less than 50us per 1000us, and cases where the sum for
> the set of tasks on the runqueue is taking less than 50us per 1000us
> overall.
> 
> > 
> > static bool
> > almost_idle_cpu(int cpu, struct task_struct *p)
> > {
> >         if (!sched_feat(WAKEUP_BIAS_PREV_IDLE))
> >                 return false;
> >         return cpu_load_without(cpu_rq(cpu), p) <= ALMOST_IDLE_CPU_LOAD;
> > }
> > 
> > Tested this on Intel Xeon Platinum 8360Y, Ice Lake server, 36 core/package,
> > total 72 core/144 CPUs. Slight improvement is observed in hackbench socket mode:
> > 
> > socket mode:
> > hackbench -g 16 -f 20 -l 480000 -s 100
> > 
> > Before patch:
> > Running in process mode with 16 groups using 40 file descriptors each (== 640 tasks)
> > Each sender will pass 480000 messages of 100 bytes
> > Time: 81.084
> > 
> > After patch:
> > Running in process mode with 16 groups using 40 file descriptors each (== 640 tasks)
> > Each sender will pass 480000 messages of 100 bytes
> > Time: 78.083
> > 
> > 
> > pipe mode:
> > hackbench -g 16 -f 20 --pipe  -l 480000 -s 100
> > 
> > Before patch:
> > Running in process mode with 16 groups using 40 file descriptors each (== 640 tasks)
> > Each sender will pass 480000 messages of 100 bytes
> > Time: 38.219
> > 
> > After patch:
> > Running in process mode with 16 groups using 40 file descriptors each (== 640 tasks)
> > Each sender will pass 480000 messages of 100 bytes
> > Time: 38.348
> > 
> > It suggests that, if the workload has larger working-set/cache footprint, waking up
> > the task on its previous CPU could get more benefit.
> 
> In those tests, what is the average % of idleness of your cpus ?
> 

For hackbench -g 16 -f 20 --pipe  -l 480000 -s 100, it is around 8~10% idle
For hackbench -g 16 -f 20   -l 480000 -s 100, it is around 2~3% idle 

Then the CPUs in packge 1 are offlined to get stable result when the group number is low.
hackbench -g 1 -f 20 --pipe  -l 480000 -s 100
Some CPUs are busy, others are idle, and some are half-busy.
Core	CPU	Busy%
-	-	49.57
0	0	1.89
0	72	75.55
1	1	100.00
1	73	0.00
2	2	100.00
2	74	0.00
3	3	100.00
3	75	0.01
4	4	78.29
4	76	17.72
5	5	100.00
5	77	0.00


hackbench -g 1 -f 20  -l 480000 -s 100
Core	CPU	Busy%
-	-	48.29
0	0	57.94
0	72	21.41
1	1	83.28
1	73	0.00
2	2	11.44
2	74	83.38
3	3	21.45
3	75	77.27
4	4	26.89
4	76	80.95
5	5	5.01
5	77	83.09


echo NO_WAKEUP_BIAS_PREV_IDLE > /sys/kernel/debug/sched/features 
hackbench -g 1 -f 20 --pipe  -l 480000 -s 100
Running in process mode with 1 groups using 40 file descriptors each (== 40 tasks)
Each sender will pass 480000 messages of 100 bytes
Time: 9.434

echo WAKEUP_BIAS_PREV_IDLE > /sys/kernel/debug/sched/features 
hackbench -g 1 -f 20 --pipe  -l 480000 -s 100
Running in process mode with 1 groups using 40 file descriptors each (== 40 tasks)
Each sender will pass 480000 messages of 100 bytes
Time: 9.373

thanks,
Chenyu
