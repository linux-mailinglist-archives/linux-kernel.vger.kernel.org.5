Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369E4788053
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242654AbjHYGuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242617AbjHYGuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:50:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E924019A1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 23:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692946202; x=1724482202;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=QIZC1erlvVG1rl3NdurDRb5Ed2QbdSbksPl3bdKSGhw=;
  b=KQ3svJ0D9V/Wp5FiDbnSNoz4sKCEE/FH7ol2cEsuIWjo0G5+oxBahMMz
   QduuV7elrG2mxl70UI3im2YrLkNT8bca8UkVt9OQFrS6aAInOXRCOg5yl
   idfxLwflNcAtaXeLEm/DIn3AJthqMCzoKUoILZCN3hGDRAMJVHUdpJ4hl
   ++8p3VD1AMxyeo5AviTshGGIytsYDLzzw6D+YJgvPIQuKa0JGjd5o/2Y8
   ZK/jqywHNaGFk1pQ8N0xLkqrITKc1kDItPBDbBD3DamBVCLR/MG1jG2Sa
   4kJLMxd65Niq+3lK891gtrHqh/xISJ0ghMKXODRVfITkZnferPxWAxSpX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="377389399"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="377389399"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 23:50:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="802861495"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="802861495"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 24 Aug 2023 23:49:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 23:49:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 23:49:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 23:49:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hL5HTER7LBbWWbcvrtzoP3oVSbhAXHSCa1gGxDN6rKnNWTsBunefGlZnVS7Dji+T9pZvg26iylBVVQWoKAOz+3xCrr5wUwHc2Ecn+Sg6jveBLdlYginJYRqJ6VBV+7PLAZI98MYLWpSySIJJlE94whnHcm/kMhR8gsJ4Rm+pacxhvR6go+28L+C+64zuIr8o4BryPpXx1xeMg3B2NEMqv8rh2FaXNhmzXbe5nmNJMakUDoM8frAbCSJ6FH0D7y5a5F+fP4ckwknmnZOKtXSghllB6VqzR5lzeMW8/kiZ4z8CmktrNJcn53D2Ib+IrsnY9zoObseTOwx9BWlH8cQNOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBLwbQ8E/CuFxkwsNJw/NII1aZPoeWau3OMKAcpin/s=;
 b=lBIE+mV+oBQURDxNBL4go43kt/4VMZPuNoA5sZmU0kKqp9zJr26aDFPZLIr1EP8QhHZqgroeiA6fzrc7B0rUVPiMSZseeMtsTpW3vMJJ5Qs9Be+FcTOI6h0mgDBffiHztYXoBSII0xclEiGznE34FP8Jw+OJx2FOeOHgS46zXgciUVuUDyL8gL4wVfFhIOkrPOojVoHPS0wGUO6lqmETMcj+9j53WfI98J9XEixTduQNYqmJn57wyFlEZ++ytPfvi0FjXQWF/tOQcdVI4Kd0UKH+63RoDCSFXnHiFu7492AoyJzcJgbmimrNq7q97qQW8mjkxKy38uDNhbXW4k+YiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SA1PR11MB7063.namprd11.prod.outlook.com (2603:10b6:806:2b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Fri, 25 Aug
 2023 06:49:43 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9a8d:9d34:4af2:f2e5]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9a8d:9d34:4af2:f2e5%7]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 06:49:43 +0000
Date:   Fri, 25 Aug 2023 14:49:29 +0800
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
Message-ID: <20230825064929.GC464990@ziqianlu-dell>
References: <20230822113133.643238-1-mathieu.desnoyers@efficios.com>
 <20230822113133.643238-3-mathieu.desnoyers@efficios.com>
 <04be42cb-0e8b-25f7-a34b-41b2873f39d4@efficios.com>
 <c7fe33f9-51bd-80e8-cb0e-1cefb20a61b9@efficios.com>
 <20230824075208.GA459974@ziqianlu-dell>
 <6e5ff343-0c4f-526c-eb53-890afb773563@efficios.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e5ff343-0c4f-526c-eb53-890afb773563@efficios.com>
X-ClientProxiedBy: KL1PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::25) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|SA1PR11MB7063:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d4319f9-91cc-4dfc-39b0-08dba5377657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V0gOmyyKq/t5fKdigVshEXzyIqwbISgvWpsUGmC7IsGLpbOwkTe7zWZbLn4j2kcCUcN4fFgWNVWGtO4gUDVxJUBiUDGOUWupRdI9/kIkzDsAivx9QRbdNiYjQ2kL4VvF268BTQQP+fNBuFDZ/9M+xbGn+Xb1rN83lOM55IwXz8QHf9txBufyZc6vAWYhoGk9ZsN3MBPsrHvus2yKfQQlwyjwyOAZK5C4/sZ8h53vkh4VsUDpLFFey+hPiIR2S/8Ty6KY8LYeoEqpA7ClUFymYgNPynvyAs4wjlgtCpb6qUfiIp1wY/jpGiI18dIpHe9XonJYRuo4FaVb/ZMNEAZniCNtqZ5BYDI6YIg/gXSSOIkSuA09BVh6YTftch56AM3biBDtGbLLDiRVxQv0sAWQ/dpnM9YCb/our4IfZiAJ9tKLCeZhXtB/5k9aXyiAmx1U2bPp6FrDk5UlshlOKKtkmjTDJ/t2ocZ/6P6+fYy9V3loxsTp3iTWYfpGf9bXHui++Q9MLHdd41d2fv6MNAR/SoftAjflGP8aOz32X8vMQk/gMy1CBTrExLzkMOLdCPSL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(136003)(366004)(396003)(39860400002)(1800799009)(451199024)(186009)(33656002)(83380400001)(2906002)(82960400001)(33716001)(38100700002)(86362001)(9686003)(6512007)(54906003)(66476007)(66556008)(66946007)(8676002)(316002)(6506007)(6486002)(6916009)(41300700001)(53546011)(5660300002)(8936002)(4326008)(478600001)(6666004)(1076003)(26005)(7416002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?7vWiy5ATGsq5+uYvrWAcjyE+RTsvZyyfkEQe9qpGjGa5vIgW1txb0hHwU3?=
 =?iso-8859-1?Q?FaICC6Dt1wu0nnmZ6R6lMrgEDmCk/5aUIsz3ocS2Xqj2ziT/0LVf+1uhQ9?=
 =?iso-8859-1?Q?wfFxaiAQpkm9BFiFlSZxsvrtabhUP1KwDcJvphX20DbfGI/3BuLtrY2Hki?=
 =?iso-8859-1?Q?eYGIYXM5rmvtk/gXVd2giYjo47o6ykZiggZMR13DLJDH3gSEJ2WP9fLb4l?=
 =?iso-8859-1?Q?QHmZJ7kodpt6SgXi24G2Tm8qjYnJJybaJoWS8q7W+E+v2aTHVoHSLNDd/+?=
 =?iso-8859-1?Q?hKxCOSFEITMk85Q7wHI0t5LRnragxqQyicHjeC63B/MfIR06YYTLndo0V0?=
 =?iso-8859-1?Q?5cLxHBiWbEQIRJPOfpwvcSCC9HvwnzRNvwPrP/qstmm8uMEQYzauEFHqRz?=
 =?iso-8859-1?Q?rPQMaNOd7JcYgFhkIlvOvawiEzepdOUcK21n/wqAkUjklG61cXdC6aEGXt?=
 =?iso-8859-1?Q?+GDyxOKhs0ehH9IQX9k+fGtr1IQ2DsFV9e/iJVUyQJsWytb4ymns5Z4QVj?=
 =?iso-8859-1?Q?3l6dZmFW7kYc1b2sHScCiU7dhla2dO7vzk9ZNSy/FxmuAELP9Fr/b1/QFZ?=
 =?iso-8859-1?Q?0lnPNcCfQPXHUgd4+U/+EXgH203HjCiQ5JJqzTdRLo70Cv9rYt53iRnl60?=
 =?iso-8859-1?Q?yZeDm2OXu/l1UErCYEtf+67TjGYqFKo3GypZevrDdl/TdxWAgcdG1DaUyV?=
 =?iso-8859-1?Q?H3JJx29E+ulaqNtMjFUQMEsNTza4XA4s3g60kyB7/81yz5wDAPHf6anR1R?=
 =?iso-8859-1?Q?aAbQT/CaOAbmw69DfXuIiRF+nMY6vH4o53upVN+llsdmrpVPyjwMjIE0CR?=
 =?iso-8859-1?Q?emPuYxcbR/Q3GmJw8/8XQ+tsrmB21rY+KYEO8ImJs3xMu6Qmk9EqINSDOh?=
 =?iso-8859-1?Q?056l32lcknqaQLdH4oc+inhKDZywahhDZT2rrCAXYvwFfPpYukCsHeub3S?=
 =?iso-8859-1?Q?KxVfQ4uDKBLtxbFjj368LYjyeVFocCfeOql8PhQl07od6KramSVv7JXNRS?=
 =?iso-8859-1?Q?guEOwZUiKtGaptRHmYerpeZ4EuAVAWaWhdXn6npju7/lY+oHJVYYJR+nAg?=
 =?iso-8859-1?Q?pK2p2PHFq87oSc1KfFNGiJpc1a6aoL7v08D2Rpap+HMj0yl2+9GUie8ZTI?=
 =?iso-8859-1?Q?PeFqgk60MeEVWxzxcR0FenK/+K2Mh69C3oF8jOMHPfDLKzqrNgCbkZfRDd?=
 =?iso-8859-1?Q?Y6M0r71FI8TSpkWAL6gFx/sTHmD6QLQQA3EZVjaRMxAymaCHY4LvoIYj6C?=
 =?iso-8859-1?Q?nD/BxyKcUvoWTfmZw7F/WhHLNR7UUFPjSKIAaGlGD/Qg6YCMirq1H6PDWl?=
 =?iso-8859-1?Q?mZOazsWrGL/0GEbVdNDeSaoyqL3mqu0QFysoV1X9ZTS4w83EHm8YGh8cEG?=
 =?iso-8859-1?Q?C2q9YdWrQuPzdzSSIGRz1NF3r4GmDuy5g0vRli2o354N3rziTe6WUm8Whn?=
 =?iso-8859-1?Q?xB7LSXyGEHbcMxk2nKUu0qzegHSpTrC/FkB5FqmfIZ1xmcAsR6y5cMyETg?=
 =?iso-8859-1?Q?Yj11BPM4w4rWLJ32TQSFWBJ1X/wWTTYKtz6iXRG3Vqia32dLObANIUiE+W?=
 =?iso-8859-1?Q?rAeXkYc1ZiZbBExlpy+zDQlWc7xShi0n9IJnoYsut03TsG1xSn1NXOSv0x?=
 =?iso-8859-1?Q?LYKdsaTpfIq7JllbK0B48/LGVLTraoS1Ng?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4319f9-91cc-4dfc-39b0-08dba5377657
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 06:49:43.3335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41LbQ0Jm8dCfRkHB6SsaeCsDdA6h0jB7LeWqT4o+MeQlaItG5L/9c9O2RMzFgmZUXPwZVgPunfmjHmAA/4wKAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7063
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

On Thu, Aug 24, 2023 at 10:40:45AM -0400, Mathieu Desnoyers wrote:
> On 8/24/23 03:52, Aaron Lu wrote:
> > On Wed, Aug 23, 2023 at 02:52:17PM -0400, Mathieu Desnoyers wrote:
> > > On 8/23/23 11:26, Mathieu Desnoyers wrote:
> > > > On 8/22/23 07:31, Mathieu Desnoyers wrote:
> > > > > Introduce cpus_share_l2c to allow querying whether two logical CPUs
> > > > > share a common L2 cache.
> > > > > 
> > > > > Considering a system like the AMD EPYC 9654 96-Core Processor, the L1
> > > > > cache has a latency of 4-5 cycles, the L2 cache has a latency of at
> > > > > least 14ns, whereas the L3 cache has a latency of 50ns [1]. Compared to
> > > > > this, I measured the RAM accesses to a latency around 120ns on my
> > > > > system [2]. So L3 really is only 2.4x faster than RAM accesses.
> > > > > Therefore, with this relatively slow access speed compared to L2, the
> > > > > scheduler will benefit from only considering CPUs sharing an L2 cache
> > > > > for the purpose of using remote runqueue locking rather than queued
> > > > > wakeups.
> > > > 
> > > > So I did some more benchmarking to figure out whether the reason for
> > > > this speedup is the latency delta between L2 and L3, or is due to the
> > > > number of hw threads contending on the rq locks.
> > > > 
> > > > I tried to force grouping of those "skip ttwu queue" groups by a subset
> > > > of the LLC id, basically by taking the LLC id and adding the cpu number
> > > > modulo N, where N is chosen based on my machine topology.
> > > > 
> > > > The end result is that I have similar numbers for groups of 1, 2, 4 HW
> > > > threads (which use rq locks and skip queued ttwu within the group).
> > > > Starting with group of size 8, the performance starts to degrade.
> > > > 
> > > > So I wonder: do machines with more than 4 HW threads per L2 cache exist?
> > > > If it's the case, there we should think about grouping not only by L2
> > > > cache, but also sub-divide this group so the number of hw threads per
> > > > group is at most 4.
> > > > 
> > > > Here are my results with the hackbench test-case:
> > > > 
> > > > Group cpus by 16 hw threads:
> > > > 
> > > > Time: 49s
> > > > 
> > > > - group cpus by 8 hw threads: (llc_id + cpu modulo 2)
> > > > 
> > > > Time: 39s
> > > > 
> > > > - group cpus by 4 hw threads: (llc_id + cpu modulo 4)
> > > > 
> > > > Time: 34s
> > > > 
> > > > - group cpus by 2 hw threads: (llc_id + cpu modulo 8)
> > > > (expect same as L2 grouping on this machine)
> > > > 
> > > > Time: 34s
> > > > 
> > > > - group cpus by 1 hw threads: (cpu)
> > > > 
> > > > Time: 33s
> > > 
> > > One more interesting data point: I tried modifying the grouping
> > > so that I would explicitly group by hw threads which sit in different
> > > L3, and even on different NUMA nodes for some
> > > (group id = cpu_id % 192). This is expected to generate really _bad_
> > > cache locality for the runqueue locks within a group.
> > > 
> > > The result for these groups of 3 HW threads is about 33s with the
> > > hackbench benchmark, which seems to confirm that the cause of the
> > > speedup is reduction of the contention on the rq locks by making the
> > > groups smaller, and therefore reducing the likelihood of contention for the
> > > rq locks, rather than by improving cache locality from L3 to L2.
> > 
> > In addition to reduced rq lock contention, I think another reason this
> > improves performance is because it reduced task migration. Not sure if
> > it is the case on your test system, but on my test machine(Intel SPR),
> > task migration number dropped.
> 
> Yes, it's indeed the case on my system as well. It cuts migrations by half
> (9.2K/sec down to 5.0K/sec).
> 
> > Hackbench on Intel SPR(2sockets/112cores/224threads) test summary:
> > - performance improved for all three cases; the more tasks(groups), the
> >    more performance gain;
> 
> Interesting!
> 
> > - task migrations dropped with this series for nr_group=20 and 32
> >    according to 'perf stat'. migration number didn't drop for nr_group=10
> >    but the two update functions' cost dropped which means fewer access to
> >    tg->load_avg and thus, fewer task migrations. This is contradictory
> >    and I can not explain yet;
> 
> Neither can I.
> 
> > - rq lock contention dropped for all three cases and it dropped the most
> >    under more overloaded case: nr_group=32.
> 
> The fact that you observed rq lock contention dropping is a good sign
> that doing more queued wakeups is a good thing compared to allowing
> non-queued wakeups across cpus sharing a whole LLC.
> 
> At this point I'm not sure if the reduction on rq lock contention is mostly
> due to using queued wakeups rather than grabbing remote rq locks, or by a
> side-effet of doing a queued wakeup rather than immediately doing the
> wakeup, which would open a window where the target rq is still considered
> idle by the various code paths within select_task_rq_fair which don't care
> about rq->ttwu_pending.
> 
> > It's not clear to me why this series can reduce task migrations. I doubt
> > it has something to do with more wakelist style wakeup becasue for this
> > test machine, only a single core with two SMT threads share L2 so more
> > wakeups are through wakelist. In wakelist style wakeup, the target rq's
> > ttwu_pending is set and that will make the target cpu as !idle_cpu();
> > This is faster than grabbing the target rq's lock and then increase
> > target rq's nr_running or set target rq's curr to something else than
> > idle. So wakelist style wakeup can make target cpu appear as non idle
> > faster, but I can't connect this with reduced migration yet, I just feel
> > this might be the reason why task migration reduced.
> 
> Many code paths in select_task_rq_fair don't seem to care about
> rq->ttwu_pending.
> 
> In wake_affine_idle, for sync wakeups, if nr_running is 1 on the waker, we
> choose the waker cpu as target.
> 
> In wake_affine_idle, if none of waker or prev wakee cpus are idle, then it
> uses wake_affine_weight to find out which of the waker/prev wakee cpus are
> targets based on their respective load.
> 
> If wake_affine_idle cannot find an idle waker/prev wakee cpu, and if
> wake_affine_weight finds that the prev wakee cpu had a lower load, then
> wake_affine returns the prev wakee cpu as target. This happens even if the
> prev wakee cpu is not idle.
> 
> This "target" cpu is then passed to select_idle_sibling. It expects the
> available_idle_cpu(target) to check again to see whether the target cpu is
> idle. However, it also uses "sched_idle_cpu(target)" which _only_ considers
> nr_running (not ttwu_pending flag). Likewise for the other similar idleness
> checks below in select_idle_sibling for prev and recent_used_cpu. The same
> happens for the case where a per-cpu kthread
> stacks with the wakee.

sched_idle_cpu() mainly concerns with idle policy tasks and if the rq
does not have any idle policy tasks, it will not return true. Since our
tests do not use idle policy tasks, it should never return true.

> I've tried adding checks for rq->ttwu_pending in those code paths on top of
> my patch and I'm still observing the reduction in number of migrations, so
> it's unclear to me how doing more queued wakeups can reduce migrations the
> way it does.

An interesting puzzle.

> I'm starting to think may want to explore explicitly rate limiting task
> migrations as well.
> 
> For instance, we could do something like this:
> 
> Within a 1ms window, if a task is migrated more than once, the following
> wakeups would consider that the prev runqueue should be considered in
> priority (as if it was completely idle) as long as its load is below a given
> threshold.
> 
> So every 1ms tasks have a chance to be migrated to the idlest runqueues, but
> we would then eliminate those frequent migration patterns which end up being
> bad for cache locality.
> 
> Thoughts ?

Not sure if this is a good idea. I had a feeling it could hurt latency..

Thanks,
Aaron

> > 
> > Below are detailed test data.
> > Base: 6.5-rc1.
> > rq_spin%: The percent of raw_spin_rq_lock_nested() as reported by
> >            perf/events=cycles:pp
> > migration: cpu-migrations reported by "perf stat -a -- sleep 5"
> > 
> > The cmdline used is:
> > hackbench -g $nr_group -f 20 --pipe --threads -l 480000 -s 100
> > 
> > nr_group=10:
> >              time  rq_spin%  update_cfs_group%  update_load_avg% migration
> > base         46s    1.32%        20.06%             10.78%      10.227 K/sec
> > this_series  37s    0.57%        15.08%              7.05%      10.722 K/sec
> > 
> > nr_group=20:
> >              time  rq_spin%  update_cfs_group%  update_load_avg% migration
> > base         69s    2.57%        19.68%             10.74%      12.098 K/sec
> > this_series  41s    0.62%        12.11%              5.78%       8.617 K/sec
> > 
> > nr_group=32:
> >              time  rq_spin%  update_cfs_group%  update_load_avg% migration
> > base     192s±25%  15.12%        25.83%             9.33%       12.141 K/sec
> > this_series  71s    0.47%        10.98%             4.58%        8.198 K/sec
> > 
> > I also tested applying my "ratelimit update to tg->load_avg" patch and
> > the test summary is:
> > - performance improved noticeably for nr_group=20 and slightly for
> >    nr_group=10 case; nr_group=32's performance is roughly the same.
> > - task migrations dropped for all three cases; nr_group=20 saw the
> >    biggest drop.
> > - rq lock contention dropped for all three cases and again, nr_group=32
> >    saw the biggest drop.
> > 
> > Below are detailed data.
> > Base: peter's sched/core branch with my "ratelimit" patch.
> > this_series: apply this patchset on top of base.
> > 
> > nr_group=10:
> >              time  rq_spin%  update_cfs_group%  update_load_avg% migration
> > base         36s    0.55%        0.46%              1.43%       15.034 K/sec
> > this_series  35s    0.56%        0.52%              1.53%       13.751 K/sec
> > 
> > nr_group=20:
> >              time  rq_spin%  update_cfs_group%  update_load_avg% migration
> > base         47s    1.28%        0.73%              2.33%       21.217 K/sec
> > this_series  42s    0.60%        0.69%              1.69%       14.130 K/sec
> > 
> > nr_group=32:
> >              time  rq_spin%  update_cfs_group%  update_load_avg% migration
> > base         70s    2.38%        0.60%              2.19%       17.855 K/sec
> > this_series  70s    0.58%        0.63%              1.77%       12.331 K/sec
> > 
> > Thanks,
> > Aaron
