Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A10778257
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 22:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbjHJUu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 16:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjHJUuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:50:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95AB270E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691700623; x=1723236623;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BM7delvZNtWMmLz5l0dnV5lic7q7V9+xjptE7by9HWE=;
  b=Wjrx0EXVwkc/x4ucv5QapV4yi9XhpCAlcxFsIgsYMDPKC0PSQydTUO79
   oXweRDqJI1thtrZY2rWTWcrx8LmW47HZxMpd3OL2mLwy7kIAvfeQjeDxL
   d6Z95leduLr2Bx3HYpW6tkkoyVBWaIw4GzKZcyUkT0Cy1j5xJgyQi+qGm
   6hyMB/ZmEm0BiJ9WxmJXUsts4aV3nga6akOTVp0tt+vIciE7oexs+QA2h
   w1KtOcFe/vRcgFj8aBt8Za9V4x6WLgE3lQAaHHKOyDrKodUanRxvYpMk+
   wgx4q5eO1qh+ih0LUZj09y7cP2jk5QOK7udS2gqC0XXrxPeGqIY28D2tu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="351124740"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="351124740"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 13:50:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="735550695"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="735550695"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 10 Aug 2023 13:50:23 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 13:50:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 13:50:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 13:50:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfwgdTnFvrIp0rLZ85vL41URISSyRrV9b/4LFqGIjHETH1cLvVq+VkJhd6zfnl90PU8FHNiFV6HQopP40MYOVlziiyBNxEdrNBN96xA5VKw4Lni5xzS4VjyOHs1cZBT0XrqNnwiwjy0a2z9L/yZJ8itWyHw6H+VbzQlWVIO638wTwvJtURXaQrHH0LEjf3LS1EHnEZbQt7EEiLXzrcD8gjjd8sq/uvPbguJBLC7AxOvh5xOOmfOxKNA8D3qH7NjzbavZhaFDXxe5u80u0029TQ55rRFEXeS9BS4YSpUx6bag29eUGfAVmaGZ84Afxzx8OfRTUkZfEBmdwmVvcBYdWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWHkGnnVJyDrAny6UkWjzyFRw/LU30g+OuJWGMA5A+o=;
 b=Z+664VA4VMo3dV8qnMM05iHuZXDmp8eJOK4xURx6AjYgffZrQJopbgT5JJ4xVSELvwwSWFRbliPCZIsOsbFYv3zi1rQDw48EQOTRWOUQfK3m+tU4Fv+5/YP5v/6Ue/cOgyNPtITkWFL0qvUbv50wrYerS5rHBCxb5OHWH79/Fa7S/z+XmpmiMLn8LBiWJ2S1f0oeejcr3ehdNmS9QUxaWA2cU1Vz4rN0+KdvBkCnDJAPvyys5YFCo/glJ9bIAviAtUBkx0LzEUTsK7HX7EKyu+T66GthhWNmhsxRqwlfoulbqHJIiCxTx99/3Avd2DhxPij4ZKXCB8BxwvZYCVDPTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by IA1PR11MB8097.namprd11.prod.outlook.com (2603:10b6:208:457::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 20:50:20 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::1583:5154:e7bd:58f]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::1583:5154:e7bd:58f%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 20:50:20 +0000
Date:   Thu, 10 Aug 2023 13:50:17 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 28/30] x86/microcode: Handle "offline" CPUs correctly
Message-ID: <ZNVNibrpZ9bJLok7@araj-mobl.amr.corp.intel.com>
References: <20230810153317.850017756@linutronix.de>
 <20230810160806.562016788@linutronix.de>
 <20230810204605.GF212435@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230810204605.GF212435@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: MW4PR04CA0345.namprd04.prod.outlook.com
 (2603:10b6:303:8a::20) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|IA1PR11MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: 472d39a6-7715-48af-08e4-08db99e3690d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u+GEaFdd4vsvEnm1D2/8efxkz6C+Vw2ceDk98M7ZEeSkVC4SlK5g6As6JaQK3c0tJIuB/StmPqTaMfT5rzTK5x1M2+4gs3G9ghh5msdQaUAXJ4opiBfbxzsx7nqUOZaI18Er1SGufZah28KzjgddVIMOo9A1rPvur8l2jwNLf4S11QfbK2WteHWFZXb+o5X0wMhG5ky6u2n2t3CSIzTS0auVDcPE8SQwus3jRLRxLG028H9kCFhhmA6aRPhV/5prKHt7TzKb6ozbmpUL4V4pUpDW9/A1sTiYrIcm6nDguf5+Dk8ebGWTsdYYcxded6+DFLMqqCqYVrowcZW1hNCrnQo1l2YPnhSNKOIOTb4yeHfGMhvFS47B1AJSU06H2QxbayLC+r0F2zRpqZIo6HYDJ1xX87E/sKmA858emkeofcB3DbjKwXuUBeH6ppHsH3gXjwoKUbe92+I86DGAyEZHvf4aOJ7yf2qoNRcqtvxcbdCiNH7Zk24vbYsmLdsrgDVDy0qpL9/dHojglb5aAw5118yrwLfmLEExZlXxJTByQvgx6bNobOzJUzcT47KgAsrI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199021)(186006)(1800799006)(2906002)(54906003)(6512007)(4326008)(66556008)(66946007)(38100700002)(6916009)(66476007)(83380400001)(478600001)(86362001)(316002)(8676002)(5660300002)(41300700001)(8936002)(44832011)(6486002)(82960400001)(6666004)(6506007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BzD6WPNBgpKIl+DcgNt3p57dURHt3vBu8ytWidfI+o6uTuHNwOQvQVjeHhYa?=
 =?us-ascii?Q?keu7s6Fb/hfwvx9y9U8QzcEe07UBq1d7DNMowhZZg7fCPg/G1p5x47YIXPk/?=
 =?us-ascii?Q?pFLEavA06PLHGHYbvPyfQz+17luPpdZ/BhE0UhsNPNgv+y7T7iuULN3O2AS4?=
 =?us-ascii?Q?hr+lvqw9w5FrQ6e09ZccVMNb/PNuJoJwkAquHhfQkKKchO5XVbFUdEupoo2z?=
 =?us-ascii?Q?qAfLS/zUYjbip/uSsnsLGUisfEl+oQM29wjlnKIy0glki6qC+J/yEAHF1EXY?=
 =?us-ascii?Q?YnoSB0vKYyzAkAd+VE4p/Dl7vCXwuzjq3KhOg5bfkGG8+VBMCHqvCKNxBvfp?=
 =?us-ascii?Q?seKbbvMmRL3cp903fmn1/CyC/7+Z6uNOZuTohNWcJIGVklhgdsFbZz1ihAUv?=
 =?us-ascii?Q?V42hZuji/k0W07d802V3GM/1wfp8zDWByuY9ujIrbpGHrmcdIY/YPHzEjNtN?=
 =?us-ascii?Q?Jrg8uSnlt2YVotDndoFdfua2ydAGWmcJ/YL6alELfY4mF03piF2ydxqEGTjk?=
 =?us-ascii?Q?tvNC3bCmgqXBQwIV8lpDE2C7mOVYTwCfspdyS1BsM4Z0ib0lAN9pjRH8KSRC?=
 =?us-ascii?Q?Q2xBh0x21ZAGYgYEYfFeQMRfaQ8Aj5op+rE76XJeAe1nlkYDxmSc+mt2aj5B?=
 =?us-ascii?Q?iCUCpxcV+voG1P2j4wwaO/7qsTlkBjUJoit+3V48vUkmiaQ/DbuSe3c2+KV7?=
 =?us-ascii?Q?Uo4ryoxITnI3LP6puwyUWvMI4g0sSwV7t/DxM+XW71rzRAZ+H9aYmC0YsO5h?=
 =?us-ascii?Q?Bl8W6YCOwtLb+Pq8lDcPH0MaYF726hkFDPvvhPrSCk/APAtOw2awxHy8cxfP?=
 =?us-ascii?Q?0ehPhPO2DCEBgDf9pE642gWZRT1uWlr4lF9fW/NFXG6sde9mrgv3hYM/V7R3?=
 =?us-ascii?Q?G7VpolGsev6uAxw2uruKT20hB5tXyrUn6FV9rUerHthOLTrcEcZLHTEntO8n?=
 =?us-ascii?Q?iNs1dA163ZH3LUhK7vwo+oYwgYAdRsUxPvE7IBdtg50R/Szlp8CMRfXlPqKP?=
 =?us-ascii?Q?gs3ulpHXkJ9VbIlQPfuIYLcFm/l9X3DWbNJd51P6qzsIOqH13ZBjxO2jXqvu?=
 =?us-ascii?Q?GGYnyn7NcbUfOBOjDv7z8S+gu8b1vdlNu3sALbjKcxMneIwU/Z/Ea+JVxNqt?=
 =?us-ascii?Q?batHXP3YazEXmI4PhJdCqEYgF5WQC2sCh5MYH6WJ9tix6jaXdMWUJAiJBHpU?=
 =?us-ascii?Q?cRGLzmqvS2yCBRNJI8+dyyNnnxebldmLpk5dXB60OhjqzdSt3whIiFAlz/bR?=
 =?us-ascii?Q?ojEb6ZPy2i2xd7PdBIh78MZdiHA8eYud9QHzAuDAIL+mEs6XwT2go0WOT6XT?=
 =?us-ascii?Q?L0SzM3UsT85ebTZukzHCHDDpoDRfYGXPEj0qKdAO0ohtbnFmScQ2wSsFKhl7?=
 =?us-ascii?Q?kBRn1DHGKn1UqvH7O/JVk1+LfPFldBt5Q7Z7ROY7m/Q7wYLR28e0Sjv6qMqy?=
 =?us-ascii?Q?ezPxrkeWwGTvq6N6EbR9ehD80cIIfAu6jkTIdTwNvqKKEaiCgWLIxopco2lS?=
 =?us-ascii?Q?ppay6W1QklAizkPb82xmBb0sWTAw2fpnxAo30dX9o06XWj2hO9UDL4789QZY?=
 =?us-ascii?Q?b1HUFRfE0EBe/FbBTeQxgwTHBuM+cWNFHAcF3J3S?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 472d39a6-7715-48af-08e4-08db99e3690d
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 20:50:20.3341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MN3+Vo6lh5c6Z28b7k2j7e2dWMY6rwV6+KB5EztI6nd2q64v0gTSBV6evUTjJjOixEHXSi1qLHtXXNpf3o7tcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8097
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 10:46:05PM +0200, Peter Zijlstra wrote:
> On Thu, Aug 10, 2023 at 08:38:07PM +0200, Thomas Gleixner wrote:
> 
> >  	for_each_cpu_and(cpu, cpu_present_mask, &cpus_booted_once_mask) {
> > +		/*
> > +		 * Offline CPUs sit in one of the play_dead() functions
> > +		 * with interrupts disabled, but they still react on NMIs
> > +		 * and execute arbitrary code. Also MWAIT being updated
> > +		 * while the offline CPU sits there is not necessarily safe
> > +		 * on all CPU variants.
> > +		 *
> > +		 * Mark them in the offline_cpus mask which will be handled
> > +		 * by CPU0 later in the update process.
> > +		 *
> > +		 * Ensure that the primary thread is online so that it is
> > +		 * guaranteed that all cores are updated.
> > +		 */
> >  		if (!cpu_online(cpu)) {
> > +			if (topology_is_primary_thread(cpu) || !allow_smt_offline) {
> > +				pr_err("CPU %u not online, loading aborted\n", cpu);
> 
> We could make the NMI handler do the ucode load, no? Also, you just need
> any thread online, don't particularly care about primary thread or not
> afaict.

Patch 25 does that load in NMI. You are right, we just need "a" CPU in each
core online. 
> 
> >  				return false;
> >  			}
> > +			cpumask_set_cpu(cpu, &cpu_offline_mask);
> > +			per_cpu(ucode_ctrl, cpu) = ctrl;
> > +			continue;
> >  		}
