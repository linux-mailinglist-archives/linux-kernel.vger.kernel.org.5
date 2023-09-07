Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E7B797AFC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245623AbjIGR6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245648AbjIGR6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:58:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE70199
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694109507; x=1725645507;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NJUrMM02TBPvll1h+V2AHia2gbjPL6Q6geA3kmPSEis=;
  b=RjAYUz2ZnLAX27JIoTndPz8XVRLNtNHJ8hbLfmStUgZNzNqjRzAQ/RDf
   SrgpNKlaQoL7tls35x9BRtLSVCrw3GUs5oOtgrQD0lncBxgxAXADW+eYG
   DERwBp5ViQ/TZtmGbWN9YPFA6dhlP+Bb5pUmaboyBAEjEJxIaN6UkROsc
   FRbrmheeEx+LbPt9RNowq0szWjijRMhNrmj/rAztwtLT/3ERuYBZPIGb0
   Y9W1MD+bTY7ddy7Jm1ExWUXH2b11uhqCPtfdaf+1Bwc/eQC6CDuSS6LAv
   g5fUFSEla3ekkyogYPpCkWaP9ALpYaO1hKJZsMpgbrEsR5l2IfZElKoiV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="367627591"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="367627591"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 08:05:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="735539276"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="735539276"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Sep 2023 08:05:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 08:05:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 08:05:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 7 Sep 2023 08:05:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 7 Sep 2023 08:05:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmkqSTd2UwYdDJlLNWxcinhSr4UnGJaz4yZ8jqjjg+yQ9TigiV1+POrRqAdWnx59D9wg0R3+YgqRValMXMYISh2rO3h7ql2fzYVZJoMlGv0C0vY2zysfJwX4e4lhgpZBM+rR5HSgUvsuE5O4hIyZYYnPF99uo9CqxBfpmqKv+9Gfofb6J2R7LJ+T39tOeL27z9+V1edo5dG2gPnJ4iCNxd0Mvmj2PZ8UcNr19owz44APciDrbVxvek9SMGoaajQ9PX29Tsf/wls3Okv/dFxEN4VvQt9OR4cVX/3zzAB51R6RFJU6zIEC5OMaqEcUMF0JFg2tcJ25ahb3FvUuMvp3vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03kwySeaOStXbqj4p8QiJ+DBC65nfEiB/Jty1YeVHzg=;
 b=iklBIyJEcdjWJ5fgIAnkUsLUfSZ1Nnah5KorZeVvJ/+stRxPqQoGMYwdvWfhMKiUDYmwDcGLPLzbsdIPIMqiaD/t3A7MonOT8bYQrGGFGjerKH3msNuMz+rETYHIzBp/SIfHqeBY+kgt/PTl3oExIWhiTnkjFggeDbRl/tiiBlCmnvr2oMpC8cDJtxfqgOCa6wxHxcCUwWWe5y1PL8ckfV779iWXOOOaZoocfMDlYuI+1W0hFI0PcODhzvjLRvBBK5XK+jqx58gksxuFFU2sPpSsZGH2Ca89QJhjCSS9nGx6Rz2pZXY01tGMOgQn1lBch1DJiie/FliH8q0osGvMJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CY8PR11MB6986.namprd11.prod.outlook.com (2603:10b6:930:56::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Thu, 7 Sep
 2023 15:05:00 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6768.029; Thu, 7 Sep 2023
 15:05:00 +0000
Date:   Thu, 7 Sep 2023 23:04:45 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Pierre Gondois <pierre.gondois@arm.com>
CC:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>, <mingo@redhat.com>,
        <peterz@infradead.org>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>, <ionela.voinescu@arm.com>,
        <quentin.perret@arm.com>, <srikar@linux.vnet.ibm.com>,
        <mgorman@techsingularity.net>, <mingo@kernel.org>
Subject: Re: [PATCH v2] sched/topology: remove sysctl_sched_energy_aware
 depending on the architecture
Message-ID: <ZPnmjZhBNCcHVVa7@chenyu5-mobl2>
References: <20230901065249.137242-1-sshegde@linux.vnet.ibm.com>
 <ZPGzxEVZhpyZuTvj@chenyu5-mobl2>
 <26d82927-af2b-b1b8-d57e-3d94c98f9482@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <26d82927-af2b-b1b8-d57e-3d94c98f9482@arm.com>
X-ClientProxiedBy: SI2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:4:186::13) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CY8PR11MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 6120cf85-a021-4024-afe6-08dbafb3ce80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4znP6xcyM0TklgkOq9YVO03BY1tjP38NGNAKph9AgzVT8tGqq1P2aEss02f45NLJGFQTAaLSGWIs1MuXKlHuvoQClG/au2+i/0pL/sTqFN52ssqYW2LxjTGQb2zv1maFXbKGayoj9Q2u/FZIetEjJ66rwfgeOPAxfisin8ByrbVrRdqlTWbCCA+EwfEX0Whtwv3qtERzfRNwPEc1u0JAPkoQp666dLsr07rDustqmAkVAkrQShS3tWE2BMN8lujwL1nkbP0L/lc+HcUfkX1Nktd8KQS9m382rZHbA7MA5196txtQgKnrXHj8T9zBUuz+DIBRgtWg2sS/H6iVrIvEWw8BhL8EbIQaeHsD4PEv8mgXvWK33EY0vJeQlCkqjtJM88WiEkYW7oV/qsoPH3Gq9AlqawhnMVKcHO0sbgSoPmWkhI7wA26Kh/ETzC2wlqOFrEaxbvU9lF67sExLdYm4Sw7MVRWxjE5SEO9pCS1AFkdasyPz58CmVCXWeN1GMrlOirOyt4FkvCKe12zIB0FGALSAlrsvKcLJRw1cZridZfHKt3HAxKL4EDiB9chRHzGl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199024)(186009)(1800799009)(6486002)(41300700001)(7416002)(82960400001)(26005)(33716001)(6666004)(86362001)(6512007)(38100700002)(478600001)(83380400001)(9686003)(53546011)(6506007)(66476007)(6916009)(316002)(66946007)(66556008)(2906002)(8936002)(5660300002)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zKDT+vMnzs2xlqFCA0NOrnL2cqmjX4lzo8BBl/OnLJSd17Nf33407A3RK0DL?=
 =?us-ascii?Q?YDanhlAwhG8YJD7zsncgmJcuZKDnMYBepcvwf/ClAkAU4Sf7wUnrb+Uv8uF9?=
 =?us-ascii?Q?LPWPr4btiGOkL1vjOV0vbCzPwCXgVDtXACP5mFzJX/II4SsF+IM8QoZzA9HS?=
 =?us-ascii?Q?RdAPH1F5kp62QNYEYoC1zrgsIpRTE7H81QE/pY9/Be12vTK2Si0pdt1ZHGqx?=
 =?us-ascii?Q?aMuwLJY9AAC8IgVHJ1Nqww0R10Y9obi3C4G0xObM/RYIK0/wNhDtTsx07Dnk?=
 =?us-ascii?Q?PHB+xAyv5bFCoz31A+QFF0tGxxUbi7uk8sziEJ6+AxCOquHQG276t8g0S3Z3?=
 =?us-ascii?Q?9bVJL1fX995By+dLKtwbetDQtdCHFEQF+qclazQu1Krm40R9xO2HIJi09E6z?=
 =?us-ascii?Q?MtXXi7CidM8+Cj2XFx2PD5EFrPgaFg5LANAjAdpUtyYuswuwj/sFNsGJGLdy?=
 =?us-ascii?Q?0irRLJHpYml8mzk49pGgsII7VsqVmQF/Rp2AVEgziLrKN2N+Sb06iYfJb6gE?=
 =?us-ascii?Q?CPdbuMXR0vnRtVRGQpMIwsY9e2xKliZ6nnhZPXUyTxfYDzVocldOHZM3ioK6?=
 =?us-ascii?Q?3Yq+1lRM9FSWubD8sUxDru25saptd59XPEU3wsxucDbGVmyXWLpzTDUcnv0k?=
 =?us-ascii?Q?6l0I39Yeq5mNh7bjyeqBhjJginphwgqA9qXw6z7SuAnAP3zu6lX2UVIVIilJ?=
 =?us-ascii?Q?0mcxhqcmj8ig8Sc+GU+J0h9XPTbM3SNNHVvzeITlPwvIUGMcOoT3xnLUQoN8?=
 =?us-ascii?Q?A1hrPOfS86/MU67mi0pucuqMTFcISOFIbMwsGdsKBD3ihCK7fdQV50JTW00K?=
 =?us-ascii?Q?S6hgvhESlCWGD0odu96sT76t4Ba41P86+ZCCKkGeMYm2aU1jk/0aoIq1HqXl?=
 =?us-ascii?Q?0UlZylgwEXnlG4gI9za8BAsWcFaUQvdj+At0vaPgVRJWzRi/lMbuCq7fMbcA?=
 =?us-ascii?Q?q78zbDkIS6NYtH31uR064JxDmW/1aaDTouyS8QWZ++aAFJYFKG8DgaljT+I4?=
 =?us-ascii?Q?H02/iyIq6fAne/kISKRLb9NziMZDsFi3kNqI9Y35TyY5FiGAJee7p8k0HLWj?=
 =?us-ascii?Q?uI62v4G1MkKxs6b6KcDbiH8VmOvOxGw25TuLn+7hzGCjZP3SoXKUt6WOGMfj?=
 =?us-ascii?Q?OVHwhdIgkrzaC6YoQj7jpyauTD4FP7FNWUa1UcWnett7lA8VljuKWfKEae+n?=
 =?us-ascii?Q?zZWllIqYkn2L+MXxqTYrkMRdfTZP18J0kMwtANqQ0jbToHUA8YaQBfTyI7jT?=
 =?us-ascii?Q?AcN5x28dj98hyQeVbVVKmdS2KUndtNOln2XaZ+6xJte14gh4uXlEKZfWggJM?=
 =?us-ascii?Q?bxpGzOqnk+7RQK3xbhjQk7IZjrWqgB7gMHJjeC9ZAEIgr0p3+zDob9vQSN45?=
 =?us-ascii?Q?g/WqYHdooLtq+ch3h/sf81i6ejCNioB9nLM5zx3are8Lb95kyDqhwlERYzCx?=
 =?us-ascii?Q?WUQqJN6bbPE/gFCex/pcIQXoiu1hMuBnT+T+BVfrumqMUDJB0PZrVL9wC/Qg?=
 =?us-ascii?Q?2ZTc0OjbVhH3pDX0XaMeOOrgvdmXLkC6TVmDSRXgwsrI5VhUR3VHGETRDLSn?=
 =?us-ascii?Q?k9GUc7Q3PfI8Ra6G5JMQP2otgHG1EphzMxQH2fgM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6120cf85-a021-4024-afe6-08dbafb3ce80
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 15:05:00.3825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7xVGcwdoxc9SA2rRQRESglavZagm5sHMNRHgRdPjIy5eNZGBrTwSxqDO+5ngaU/MSsIzeRSaQrD3f+Mc/JgMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6986
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

Hi Pierre,

On 2023-09-07 at 12:21:27 +0200, Pierre Gondois wrote:
> Hello Chen,
> 
> On 9/1/23 11:49, Chen Yu wrote:
> > Hi Shrikanth,
> > 
> > On 2023-09-01 at 12:22:49 +0530, Shrikanth Hegde wrote:
> > > Currently sysctl_sched_energy_aware doesn't alter the said behaviour on
> > > some of the architectures. IIUC its meant to either force rebuild the
> > > perf domains or cleanup the perf domains by echoing 1 or 0 respectively.
> > > 
> > > perf domains are not built when there is SMT, or when there is no
> > > Asymmetric CPU topologies or when there is no frequency invariance.
> > > Since such cases EAS is not set and perf domains are not built. By
> > > changing the values of sysctl_sched_energy_aware, its not possible to
> > > force build the perf domains. Hence remove this sysctl on such platforms
> > > that dont support it. Some of the settings can be changed later
> > > such as smt_active by offlining the CPU's, In those cases if
> > > build_perf_domains returns true, re-enable the sysctl.
> > > 
> > > Anytime, when sysctl_sched_energy_aware is changed sched_energy_update
> > > is set when building the perf domains. Making use of that to find out if
> > > the change is happening by sysctl or dynamic system change.
> > > 
> > > Taking different cases:
> > > Case1. system while booting has EAS capability, sysctl will be set 1. Hence
> > > perf domains will be built if needed. On changing the sysctl to 0, since
> > > sched_energy_update is true, perf domains would be freed and sysctl will
> > > not be removed. later sysctl is changed to 1, enabling the perf domains
> > > rebuild again. Since sysctl is already there, it will skip register.
> > > 
> > > Case2. System while booting doesn't have EAS Capability. Later after system
> > > change it becomes capable of EAS. sched_energy_update is false. Though
> > > sysctl is 0, will go ahead and try to enable eas. This is the current
> > > behaviour. if has_eas  is true, then sysctl will be registered. After
> > > that any sysctl change is same as Case1.
> > > 
> > 
> > I think this change makes sense. Just one question for case 2,
> > sched_energy_update is not strictly tied with sysctl change, right?
> > sched_energy_update is true in rebuild_sched_domains_energy().
> > rebuild_sched_domains_energy() will not only be invoked by sysctl
> > path via sched_energy_aware_handler(), but also by other path, such
> > as update_scale_freq_invariant(). If the system boots with EAS capability
> > disabled, then it becomes EAS capable due to the frequency invariant
> > readiness(cpufreq policy change?), then
> > cpufreq_notifier(CPUFREQ_CREATE_POLICY) -> init_amu_fie_callback() ->
> > amu_fie_setup() -> opology_set_scale_freq_source() ->
> > update_scale_freq_invariant(true) -> rebuild_sched_domains_energy()
> > Since sched_energy_update is true, the rebuild of perf domain will be skipped(but
> > actually we want to create it) Please correct me if I miss something.
> > 
> 
> I thought 'sched_energy_update' was here to force rebuilding the
> perf_domains instead. If sched_energy_update=1, then it prevents from finding
> a pre-existing perf_domain and skipping the perf_domain rebuild, unless I also
> missed something:
> 
> 
> #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
> 	/* Build perf. domains: */
> 	for (i = 0; i < ndoms_new; i++) {
> 		for (j = 0; j < n && !sched_energy_update; j++) {
> 			if (cpumask_equal(doms_new[i], doms_cur[j]) &&
> 			    cpu_rq(cpumask_first(doms_cur[j]))->rd->pd) {
> 				has_eas = true;
> 				goto match3;
> 			}
> 		}
> 		/* No match - add perf. domains for a new rd */
> 		has_eas |= build_perf_domains(doms_new[i]);
> match3:
> 		;
> 	}
> 	sched_energy_set(has_eas);
> #endif

Yes, it enters build_perf_domains(), in which we have this:

-	if (!sysctl_sched_energy_aware)
+	if (!sysctl_sched_energy_aware && sched_energy_update)
 		goto free;

and domain rebuild will be skipped.

thanks,
Chenyu
