Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765907783E9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 01:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjHJXDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 19:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHJXDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 19:03:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2CF271B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 16:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691708584; x=1723244584;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rqDjLTjBKukbbHP74RZFn6q520wsx27WDHcuSpG2Ckg=;
  b=IzqX3wShCksyQWPOMqaMRtM0oouZwvsVzlP66dZ3CC5+fFarxcgTgYjA
   KT4YAlIGPb//ZuI6Pne1e4YNUSfKKtov32k49j+8V5h7XNsQa4vP0dRqN
   vLp7CIMoIg3lt27+x/fEj5wM3TOMu0jukmaTLgjZMfJg+CfOXGxgGOlhw
   MZSx7oaWJjqWE6oYJM/C4ocbf6AIliec/dDHC8crpMlfja5HmDvKvBvv0
   ageHeUn2lFibCAjW9K8Gpj++L9kE3NY47usESjXL3PsONmesoijvCnL+f
   uLnAY7ur5n0LQmcf60uQhVz6bTNdyIAJDjY/Yp7YAf7Rte9pF0bmLWQDF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="402510722"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="402510722"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 16:03:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="875925210"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 10 Aug 2023 16:03:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 16:02:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 16:02:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 16:02:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFEA12NzUvkPnccGY4galUCobsHFEW/0NnKuKs1iryTKXo/0MlGEBZ92eZoxFpOruAVzwlbyqd6CGEqCaswC1YVOmT6L163KGprCTKekCu7KLWYvh8mZfRx21Flv/WarEIEi/RHUpmBs1SYw2tKeB3NI1C+gSXPyhBkc1K6dmIFRMNrcp7etlHtvBI+fb7qZnhQ+1w4DzM5maTJj2deOcYuL4+QGTsijQ1qqGIAs3K/nqLwcNYAVPLNqZw9vK0qWVohYkxrRL3B27TD2wxt4KrDVkQVB362qHWC/QiV4X1OsCEATli9kjb40NwE4cPMWF7oOpkuhs1W/FwrdsM3ukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWzIPxGESfdcbbgREnWJv+IY8Gnxej3Qa9BWICLatJA=;
 b=LR9a0VDa9TBJNLA+V8LnjaRRhJv+RzBb3jCgrvAueM84JzDSsl7RwzPJfBXBZ9Zu+9dWA+9/OMm8EK+O9k+1kd2Q5vz0SfrYzPu0gMmlW4wBT3OEZYSt2KebncaVVGzjDyB0whZrEXOQjBNk2IgXIFRMp3L3S5vZF5M0foMYPmnEZbHRilLwPba8H5w6Rl8oEZ8FFjchVoTKoaJG2XRln398vRglylPtJw6Wo4vyiN7iRseAoe5TO+faYhhHTBqi/wLEqUT7DQBEXv+lEor0ExFSuffvy7aiCSJ5QxzuQnVfjNui0oidtJCx2G7qxgJ1bPoJ/M7+/8A6kUDC6JduMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by LV8PR11MB8680.namprd11.prod.outlook.com (2603:10b6:408:208::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 23:02:47 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::1583:5154:e7bd:58f]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::1583:5154:e7bd:58f%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 23:02:47 +0000
Date:   Thu, 10 Aug 2023 16:02:43 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 28/30] x86/microcode: Handle "offline" CPUs correctly
Message-ID: <ZNVsk2a19PuNoeSo@araj-mobl.amr.corp.intel.com>
References: <20230810153317.850017756@linutronix.de>
 <20230810160806.562016788@linutronix.de>
 <20230810204605.GF212435@hirez.programming.kicks-ass.net>
 <ZNVNibrpZ9bJLok7@araj-mobl.amr.corp.intel.com>
 <20230810210511.GH212435@hirez.programming.kicks-ass.net>
 <ZNVbc7qy8k49Dwhi@araj-mobl.amr.corp.intel.com>
 <20230810222957.GJ212435@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230810222957.GJ212435@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: MW4PR04CA0287.namprd04.prod.outlook.com
 (2603:10b6:303:89::22) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|LV8PR11MB8680:EE_
X-MS-Office365-Filtering-Correlation-Id: 1574ac58-0fd8-44cc-b386-08db99f5e9e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XmnwDFGgy9Xbk334FSBdZhW6MoU2Z7z14UmGJ/wFrVqN9JzCxOmubfcnbrRf8tGJuYLMIuWG0uywJjqANiO/SpH+E18xZZeXeUmskjG7VbHgHqNZvZSHj8TgsQxmIfvz8y4u7UHdd9WHYIZiackZezlc1CR+TtiRg2d82YPIobuKnIYiqmIbcxI17Xc5twbeW++TIkEBVrDHg1QOlrUs6Aqw1NCao2zfVUbFWKwNx51ckznPs0yXSt9IbbKA7Unu5GZmjJMauJKZ63TpdkD4m9f54a0m7Ct1JzHG6ejHEARso9RnphQwKIfyra7lhlhJSkKuwGed1EToxh0udYc6RxUIy1mlFiMM4a3DFtUdoolCmln9Iifx5Zznf4oAMiP279sO60XvbhuseacjBlkKZwSnqbxWFqYdp/SIIVXauJXMCnBw4h89m/RZEyrPhbZQ6MakGoXZcofwXp4BWDs57U35TnbdhWZ9my4BrzaGCt4xDkgI7+zyQHuhy+/SkgSDvYgyCNY3pqjNKrSdtavIpaPc/jCvxALbJM80DXM6Jal7q592JRCw3wuhSFhxsmwi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(136003)(346002)(366004)(1800799006)(451199021)(186006)(8676002)(54906003)(8936002)(86362001)(6486002)(66476007)(316002)(6512007)(6666004)(6506007)(2906002)(478600001)(26005)(38100700002)(82960400001)(41300700001)(44832011)(4326008)(6916009)(83380400001)(66556008)(66946007)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D58KupdptL4PvvmpKQPAVQYZydCk5Np2AiHrwnaqf2PH2NZEeyZnmnSWOM8E?=
 =?us-ascii?Q?zs2LiyXKWw40HrG1j730knXZOyiyIid15V/HodpwsaoPhfBhBPfFF6PDKfPD?=
 =?us-ascii?Q?1xut8inqGord1b39OY2AvGfQFG/8MBzXOKsT3rqM/AI/0tqI3OfjMEcOHRh1?=
 =?us-ascii?Q?yOBS3y/q8yG4kISA/rfFSAU/Ysy/ULI6Gl50e5HIGlrBhjfFtOnXE00okGvs?=
 =?us-ascii?Q?iptIe4y7U849+mEhgEK4IecrMc8RfzctjbnJj6oepqjZkKivaOofN+/XoAbH?=
 =?us-ascii?Q?le8iVMppksP3Anut27jstKhyG1v+zfjfN86OM2Dbdd3kZgaHR2MauvezYHjC?=
 =?us-ascii?Q?hL8R2J95aA8USP75SFJZQq17twomAtWVNuXhpaOAvXbNis8SRTr9EPyDQbF2?=
 =?us-ascii?Q?9RkZL13Ez96w4o1oUyV7T/u1V9HPXBDfEmS0DvV5Gdr+D3riWMegd4X5TR5L?=
 =?us-ascii?Q?Gw2+7S7fjOZQ9jPCiCjKRLEpMxxmf+uoYX+/AOALRNu4TA+b5r81BlKrIlJM?=
 =?us-ascii?Q?SK4F0N7FvZeaCXUVtkOdiY7Zlfh2WBWqiCFF5r5t/ZBELPe+PCwWKrAwsEEY?=
 =?us-ascii?Q?24MWt4NJ65y8Jw4qtyzH0gjjJxblKcxGzNSJvcvLsTy4SvnkHISlZE1nt/4/?=
 =?us-ascii?Q?gk4i9MGeqk4cNdij03Tae7MPRRLk6pAA2/jUq5Jucn03rPPyzMAfyrbsEj/F?=
 =?us-ascii?Q?dFghs+GlqJqNaN21Z81wpat+SDu+iuMkhip4BH9PLqrBWj0pAtyQoNacV0s0?=
 =?us-ascii?Q?yKobnflsQfkhw5HfebygdPYU3A/jlY8L4OeYfTmttCPR5zkgZgh/e2Op1rL2?=
 =?us-ascii?Q?0h85/V9gckVB2LXnnnpM9bd4hhPl0lxkrHL0Alku8QFK7F4gji65zEGst+Lm?=
 =?us-ascii?Q?yGpj8GOgjhkSO6aIkBmTAnBnlYFsIRvr6i5mSMUUhzBomQkVsbD1pU41igOf?=
 =?us-ascii?Q?zvgy0JR4VL4WLyKIQk/p5S1HH+N+nwC47hslCX1UEQCcvH73nJN3aeSYwnqH?=
 =?us-ascii?Q?hYmCZVdEBcCEOjViqRc8Es/hIyjZEUzG777ANetYluSkfZGVz6ZymShL27In?=
 =?us-ascii?Q?M10sckTgOV2lio4Hy3VRD+ToSL/Uj63UpPgtONSURjoFad9/UcIz+BXONerC?=
 =?us-ascii?Q?pTMfxUFBsp4lTI5tfs28c7FdY/ERavDWMMNCGARp1swr8VI09fH9iBsWzvJr?=
 =?us-ascii?Q?T2DuQHaWjKyywlkF0XE2sGAulqK1to01L5cIPs7RAnK1XzNYtklRrpycfoJI?=
 =?us-ascii?Q?q0BjOBM1EAGiARvIMRhym3R3UtIbm/FVE7Eq6tYbr/f9hHcoBugVr9MtmGN/?=
 =?us-ascii?Q?T4D9y3eXZIDupchMVK5WzsPU/rlo5oo6A+Bsj1LJt7KcplPBcNDjMoyYeutd?=
 =?us-ascii?Q?342pthYdanclBjN8aJmSNFWMB0HHcg4m8rFwvLLGDTvygj4/IfjrYwSKd/Ds?=
 =?us-ascii?Q?YDjtXJKKN132cBgBngFos2YloNRfFeZKDs0Nzk3E5RC0fiD1JEncUNj9xvG7?=
 =?us-ascii?Q?rNy92PFuuO8+3svCnLnpesUZOXwfAzd95RDuZPhtRvRS8BvVh46lg1GECBWB?=
 =?us-ascii?Q?cxvvZ+UcfAUkqoyMok+0rCES+A8PfYogtay3O71u?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1574ac58-0fd8-44cc-b386-08db99f5e9e7
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 23:02:47.4784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QC60C6/SfEbtTISzglWcmvt8fYraGNG11KXhta0wQus32ra/BZhigPMFT8PG17BHRBXIZ/XNp8nHvW5sf3i08A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8680
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:29:57AM +0200, Peter Zijlstra wrote:
> On Thu, Aug 10, 2023 at 02:49:39PM -0700, Ashok Raj wrote:
> > On Thu, Aug 10, 2023 at 11:05:11PM +0200, Peter Zijlstra wrote:
> > > On Thu, Aug 10, 2023 at 01:50:17PM -0700, Ashok Raj wrote:
> > > > On Thu, Aug 10, 2023 at 10:46:05PM +0200, Peter Zijlstra wrote:
> > > > > On Thu, Aug 10, 2023 at 08:38:07PM +0200, Thomas Gleixner wrote:
> > > > > 
> > > > > >  	for_each_cpu_and(cpu, cpu_present_mask, &cpus_booted_once_mask) {
> > > > > > +		/*
> > > > > > +		 * Offline CPUs sit in one of the play_dead() functions
> > > > > > +		 * with interrupts disabled, but they still react on NMIs
> > > > > > +		 * and execute arbitrary code. Also MWAIT being updated
> > > > > > +		 * while the offline CPU sits there is not necessarily safe
> > > > > > +		 * on all CPU variants.
> > > > > > +		 *
> > > > > > +		 * Mark them in the offline_cpus mask which will be handled
> > > > > > +		 * by CPU0 later in the update process.
> > > > > > +		 *
> > > > > > +		 * Ensure that the primary thread is online so that it is
> > > > > > +		 * guaranteed that all cores are updated.
> > > > > > +		 */
> > > > > >  		if (!cpu_online(cpu)) {
> > > > > > +			if (topology_is_primary_thread(cpu) || !allow_smt_offline) {
> > > > > > +				pr_err("CPU %u not online, loading aborted\n", cpu);
> > > > > 
> > > > > We could make the NMI handler do the ucode load, no? Also, you just need
> > > > > any thread online, don't particularly care about primary thread or not
> > > > > afaict.
> > > > 
> > > > Patch 25 does that load in NMI. You are right, we just need "a" CPU in each
> > > > core online. 
> > > 
> > > Patch 25 does it for online CPUs, offline CPUs are having a separate
> > > code path:
> > > 
> > >   microcode_nmi_handler()
> > > 
> > > vs
> > > 
> > >   microcode_offline_nmi_handler()
> > 
> > Since the code enforces all primary CPUs to be ONLINE, the secondaries are the
> > other thread of the same core. So they automatically get the update when
> > primary does it. 
> > 
> > The secondaries are parked in NMI just to avoid the risk of executing code
> > that might be patched by primary.
> > 
> > Or maybe you had something else in mind. 
> 
> Yeah, not placing constraints on who is online at all. Also, if both
> siblings are offline, then onlining will re-load ucode anyway, no?

We need one thread in a core online,  because a MCE can happen and we don't
want those running something stale.
