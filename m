Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D2078FB73
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbjIAJu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjIAJuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:50:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B0810E0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 02:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693561817; x=1725097817;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sTdOLu9MkdHPwDDoX7ms/ABzaru4lOhdo3ghOcYsrDc=;
  b=nXJzm+zE24F4bCf0pCsg9qxxenwlkW9ivB7Cp9br9WJfOfZUcCMVD4F8
   AKM7oPqa0TmOMgckYp4VhNdUL1T9wgieKXtFrPhq7tq+glug7yWn8lUjd
   xs5whLotOPYJxFBAtl59BNDgb6JrzB91YeCzzGucheWTnUCjm1FCeOKrv
   0iOmcZAhNn+Ae/TV5WuBOrJk7xFW5nyUiHexv4i++Nsrr9cvvJjdJbWBG
   wINc6Pxg0L3EpxJ9G/yevEBLvfEKVwkeVa0yfoect7429xuRQa6vyq5Q4
   hWqNNeDRe5/VA/W5b3GT8tPA0S7IdaZym37wPM2KH+18WrmWRdCebO6rc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="440162578"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="440162578"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 02:50:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="739871304"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="739871304"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2023 02:50:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 02:50:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 1 Sep 2023 02:50:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 1 Sep 2023 02:50:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d26jxiXIzK4sDqxMhmZAGXb5LWsjp2gY1b3wXVT4QkvnXH6abcy7qe9rNivndJLY+pEWD5Xi3Iwn14roK5H4TX248kweKY/L437hCIteQWLLUmo3FO0ar6GoSbirnyXMZeqK9eEJC9+SNofyeIGMJinfzBUFQ1/5vzAivHnTfvAVeTIE5BGfQS65ipZbNIofgGhUHUfWR/mLk+imBSpHDkuRsrAL6+56MBB57hUSy4eQhJPXqhYi66ULvre3YBS3w2m2inL9SsdI28JQl9k2TKeXGuwJBCRjfD1sP6gpXy3JUe7iGrz5dv09Pwtz+5JGUcL0aGtmpdHvzkCdh1IHkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oabdwx5Xn9+QtCxhAOV4ilCn7eeYeBQ3rkdKVQsT/do=;
 b=CSz1TceyWLo6H8VYamBsUo4F2A8z2ziLRUbtrSAePx/D4nN+IW5nhHMcoiRM0UaTZAcMnFZOHOHt2g7V2ONSU4Yl0zoDNe/2FofvpKv1/dYdnQfeZVQvV7AIZEOPoftdf3i6jo/jlps3+L/ymZOP2aArvItstMrhx6fEk21b9xQBQK4NVh72TAwbcSlzU6V1KCqv1Nb3lKFP70EBm2UFcdg7UQwp41UNR8Nk6kZnJGFSG0tMlg0RD732WXT0LgwirKdyKosH8MPDJLaodLxTIrhVwy35PEqA0yq2/jAbOHtXKBLvIHVo2X9AUEB95787k/pP0jLmD39DrAROKBcrhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CH0PR11MB5708.namprd11.prod.outlook.com (2603:10b6:610:111::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.26; Fri, 1 Sep
 2023 09:50:13 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6699.034; Fri, 1 Sep 2023
 09:50:12 +0000
Date:   Fri, 1 Sep 2023 17:49:56 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <ionela.voinescu@arm.com>, <quentin.perret@arm.com>,
        <srikar@linux.vnet.ibm.com>, <mgorman@techsingularity.net>,
        <mingo@kernel.org>
Subject: Re: [PATCH v2] sched/topology: remove sysctl_sched_energy_aware
 depending on the architecture
Message-ID: <ZPGzxEVZhpyZuTvj@chenyu5-mobl2>
References: <20230901065249.137242-1-sshegde@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230901065249.137242-1-sshegde@linux.vnet.ibm.com>
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CH0PR11MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: cae05f1b-ec46-49a4-cb4b-08dbaad0d5fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BFnm3EH1w8u6y/CKTdagIu2BMtyfl2UD6jOZYdkoErXyNdTKgy8O/29RlPUbA27fa3RQ7Le/CExSlII4tMZZlI1OPZO9B3TdBxFw2yDF6m+5P1gI540eIkTtD366NbmODlMcwcl1q+HM/sT667DjXM7u+Ieq1iBGv68z+9b6KUCDDQRYyEmdBI2OrI0gvin9Wy9rPSgenPgEXOHEMAnb3gIRJ0ac1L0yQ2F6VtV2t+tJ8GKtJBqcX6Uie6TPIg6Kevuq/GLqEEBd+CawkabaWpwInKGdB3AQJB1n5g4OYAVD5P/b94D7WcwGmAguDNgiJrHwlsKQgM339XsJmEfrjL4dU4nPTYU+1N9pi15b+RMNEfGThTtKEn9Vtko2D3YfT3Ri2HKDEYWeD97snsnRvnLv5Ek0R5MKw2r9QxcLWPDWTBPWV632HoMKDOyxWJ6cg0oeYNrkVTwgubzFcCiFeSMayMuzFAQmPuArhadtAW4zAPNoJq/wqsbrRrSS7bTUrsGC48QVDgXM2tZW+8s7jmBgjJPW1JzkCs8+11cGektu4Ta7LKssYTI94np9vpEK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(39860400002)(376002)(346002)(136003)(1800799009)(186009)(451199024)(7416002)(33716001)(2906002)(6916009)(316002)(41300700001)(5660300002)(8676002)(8936002)(4326008)(86362001)(6666004)(478600001)(83380400001)(26005)(53546011)(6486002)(6506007)(6512007)(9686003)(66946007)(82960400001)(38100700002)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GxHc3SMepEqpa0by4YGrT3xIF18G/US3tfCOyqwxbhq8s0bPwewpY4QeKuVq?=
 =?us-ascii?Q?hki5BYCj1rbgH8/kvYfaRPqW8hJAez5f6hH+AmQS5V94K4nt1btBd5VDsrtA?=
 =?us-ascii?Q?BmB9EXDJAHp7SbyL6ENUfKv/8O0CjGSAFIJ0ZuMLl1XxCZstWzyW/0WWYxMk?=
 =?us-ascii?Q?P2O+Ocf3cJAySRPICJQtnhYqWeF/TeFSQwxNxsnzJByCm9lokvLK70QH6sSw?=
 =?us-ascii?Q?vsB89x1GB2afz4Hx0peknWWLhzF4qgvucVOPhuleZlER1WIy7wGZT3GF6WeF?=
 =?us-ascii?Q?wp8BlwMOdnO1YUnCLyjsGC5grV67ZKLaKoY3ZmOFxNZ+JwxR+Bxj6qsXOhg0?=
 =?us-ascii?Q?u7/EawNRKTl2iWxYVoPb1uRfH1Ai/Qxd+j4YGzokBCcMXorOhImkQjaXoQz5?=
 =?us-ascii?Q?FXuI3eQe3j3Ebj9WWFP4cg8LHfS+5ClwWjpugPwwrTuFL3cimGMKedY476b6?=
 =?us-ascii?Q?9gNfhmumxcrfrSqjpighn6Udo8q5Pqwqh2WRidqaBbJ0BC0QvqfWLLMCYgHH?=
 =?us-ascii?Q?8SrqOVYj+JAKWj1II1iuXLy4MCgYkWhC4qp/DzN2KKJzyDUyE0OpFrgJwUF7?=
 =?us-ascii?Q?+H2VyHO6cqYYW9v6+dVzVYm5O4bnYTA2zg/Pruz9T9TdoCXTlzNaNCXtRG80?=
 =?us-ascii?Q?wli9VfZ6DzSyEqCyLf6BWWzS/GFl1CFmRTU+hD4ItPfxn6EV3vp1THIVej9M?=
 =?us-ascii?Q?hPhYqMuNv9bWOhRqT1TxD5PerVw/1Uf+bM5PQv1ONDIqqDlLctEorAOQu7e9?=
 =?us-ascii?Q?9IAxN+89YjbVsarm2aIpwkTle28FjJyz7G4bhizAhYsRYKTcMOuoLrbB4eGQ?=
 =?us-ascii?Q?UbvIqU5Lb2XJ/yyGcPVhJzkVpkrm5l/KGWy8mr/UrxGVSMy47mZp5qNojPBm?=
 =?us-ascii?Q?8QX7Ev86aKUcUE8V4yRf1u4smFqwFiMBn7/IzAQAwn+hkHQI32f7zvMHRW1T?=
 =?us-ascii?Q?Uq9JC6ix6OnaXHMiRRLLqTGInlcu0tsYvfv7BzioZWSnEj8Wn6dAtqY4GWDp?=
 =?us-ascii?Q?IOihCpjJ7XZRbddtQHFjC3CimhIYPpCAPKzXN4Dg7V4ZBJUqCQOR5Q+/1FOV?=
 =?us-ascii?Q?x1wM2frvuTIoxBcGTgAvvsgwvbCuW2TU4jE0xjMn8ub1Gi6h+lDN4Yd9kPD3?=
 =?us-ascii?Q?CtZfwxzW859CBXC9yVClZnQH4e74IVi9Y//8WUCima5y7hvANzvbHdp2QRe8?=
 =?us-ascii?Q?BKrNahGNXzH1lt9orSvSdmAPzXwMyt6PquE+mCC50hw7KGIP55sFrdpzf5sT?=
 =?us-ascii?Q?CsneXhOZa5F+toSSbOB81JpE9nymOK/rq5j/KjRV90AdpiZQh/sUATfmfEmU?=
 =?us-ascii?Q?dDNNq4v31Juvixe1E5n2pD/Pmb1bATWLXQUeu443QUY7LNc/6IO3HRmO0ZvF?=
 =?us-ascii?Q?IamI38yZu0hOdG97ZT1lvpgee6J6W3m9rGQwRkDF7GlBkNB++0uKGtnPbkHj?=
 =?us-ascii?Q?vJ27S+9yEdgNT3lSM8snuxPIgeInkoAc85yLuv7p0K0ZVmueMah5ggbfNkEw?=
 =?us-ascii?Q?ddq5RkulGtmyolIdny23X0NaMFyh4wrXL78K2uNPwwwuhms5TsxBRRVM9T0M?=
 =?us-ascii?Q?RO6HLWX0We6z/Cyf80clsyVcgS/8aGdpTBbEBH19?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cae05f1b-ec46-49a4-cb4b-08dbaad0d5fe
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 09:50:12.5324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sj4aUA10dp8M/F66Hh/paRErlgastEDdFj1sP/3pbuAUjp20kwaXhBJ9wKgQ2qSUWcD4pcbqqO1aUripp4Fmqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5708
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shrikanth,

On 2023-09-01 at 12:22:49 +0530, Shrikanth Hegde wrote:
> Currently sysctl_sched_energy_aware doesn't alter the said behaviour on
> some of the architectures. IIUC its meant to either force rebuild the
> perf domains or cleanup the perf domains by echoing 1 or 0 respectively.
> 
> perf domains are not built when there is SMT, or when there is no
> Asymmetric CPU topologies or when there is no frequency invariance.
> Since such cases EAS is not set and perf domains are not built. By
> changing the values of sysctl_sched_energy_aware, its not possible to
> force build the perf domains. Hence remove this sysctl on such platforms
> that dont support it. Some of the settings can be changed later
> such as smt_active by offlining the CPU's, In those cases if
> build_perf_domains returns true, re-enable the sysctl.
> 
> Anytime, when sysctl_sched_energy_aware is changed sched_energy_update
> is set when building the perf domains. Making use of that to find out if
> the change is happening by sysctl or dynamic system change.
> 
> Taking different cases:
> Case1. system while booting has EAS capability, sysctl will be set 1. Hence
> perf domains will be built if needed. On changing the sysctl to 0, since
> sched_energy_update is true, perf domains would be freed and sysctl will
> not be removed. later sysctl is changed to 1, enabling the perf domains
> rebuild again. Since sysctl is already there, it will skip register.
> 
> Case2. System while booting doesn't have EAS Capability. Later after system
> change it becomes capable of EAS. sched_energy_update is false. Though
> sysctl is 0, will go ahead and try to enable eas. This is the current
> behaviour. if has_eas  is true, then sysctl will be registered. After
> that any sysctl change is same as Case1.
>

I think this change makes sense. Just one question for case 2,
sched_energy_update is not strictly tied with sysctl change, right?
sched_energy_update is true in rebuild_sched_domains_energy().
rebuild_sched_domains_energy() will not only be invoked by sysctl
path via sched_energy_aware_handler(), but also by other path, such
as update_scale_freq_invariant(). If the system boots with EAS capability
disabled, then it becomes EAS capable due to the frequency invariant
readiness(cpufreq policy change?), then
cpufreq_notifier(CPUFREQ_CREATE_POLICY) -> init_amu_fie_callback() ->
amu_fie_setup() -> opology_set_scale_freq_source() -> 
update_scale_freq_invariant(true) -> rebuild_sched_domains_energy()
Since sched_energy_update is true, the rebuild of perf domain will be skipped(but
actually we want to create it) Please correct me if I miss something.

thanks,
Chenyu

thanks,
Chenyu
