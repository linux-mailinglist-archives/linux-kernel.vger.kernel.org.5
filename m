Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD8C7B15F6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjI1IXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjI1IXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:23:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14313180
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695889412; x=1727425412;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lBDCshas+4HTWPnYe48wOLnbJ8UckaoAh8vJT/JaUVg=;
  b=iYaQXJAh163bSLGJdGFTjcRoJQuLSwAEPc3FiE27yOBFPz0uWc4d3Txp
   RmqAqi+MxXp4rXWxi0XO4lhhpGSlP+08iwv4TyRAYltL+DcmU7IPjbgVA
   ABQ801PVussXYBR42nzOgTKr4J8Y/spW8mnwxNnbZShP/BTvAnVolLQb3
   1hfLFY5g3EthtyYGfMm7ShvZSZ5Q/swBj+Pz2oM3RPvf310yWoiT1hlnc
   5Oo/zw7YA4kj5+vSuBoCdPBlTkEN0aIMhj9bsYREEMNLqXRo98pKU/iv7
   U+xpQOXo1EpUwkQOVe1aCt18KMdRIk048gwTazZwVJ+iGo3yZLKmKEKez
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="379284941"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="379284941"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 01:23:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="699192239"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="699192239"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Sep 2023 01:23:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 01:23:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 01:23:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 28 Sep 2023 01:23:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 28 Sep 2023 01:23:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaL+5jK8PchQpZAKy1ZrMC3fQf2yq30IlHmWzGHrAuy3RQIGR92y70EheP+xOeBd89cuDFolg/K+yaB88DuBOnX0p9iewPCACHH+eOgd+wLeDhZ6Cg1LzU6qp7OrwG3Q1ibP73/Dm8anQtS1n2G18CpeL6npATVuyb3mw6Px0kw59cch+1IJpbru/Q6a0v7bGXGq+hE0jb9QIomQL89gL+uPDB+GGK5PWGj6HTWr6H4WaPvrAJPyt/Iwgad6fdvMYOGBO3wkpxAfIpKiNmQE+TRnAMVB0AecwvPKu6gQA11T77nnQtrRxxgzwiA/khCMNEaYFq1WqnlWX3aGuefVNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blgD4hGqbtm7T0KhvxsTt2pJxs+Pkhywl/zWOf7DHsY=;
 b=MpFw5kks/huBf3oHwpiDBxCWB5vklraDy5ZgVLPRSx0+d9x0EyKVZ2UkKbbMMiP+FzZvHbY8EtzNVV8YKxF5rw+MW4gbz3mzbXDlkJiE6MpCkMvLg5uOnP0QvvFOZ1elCqiTARASRjvH7K3FWyV+YLvpUEgYwxIjpJ1nFTJNsT6h7LjSJdvBvLWolvUUpxFEyD9KZCi8S01+Nz/zFUzvICyTmK3coRJb4+cM1i6gFoulXUj7eFdv2Eqb4Q0XHFIFa/z9iuQChHoZZ77ah1kBzEjxwdfUE81ZM6u5Nas+TwcptJlRaCNmxbK7LqnkMLFFrbAbrAV9gTrZ7XpQ1KGYSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SN7PR11MB7601.namprd11.prod.outlook.com (2603:10b6:806:34a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 08:23:23 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%4]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 08:23:23 +0000
Date:   Thu, 28 Sep 2023 16:23:06 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        <linux-kernel@vger.kernel.org>, Chen Yu <yu.chen.surf@gmail.com>
Subject: Re: [PATCH 0/2] Introduce SIS_CACHE to choose previous CPU during
 task wakeup
Message-ID: <ZRU36iTsA7IPzhL+@chenyu5-mobl2.ccr.corp.intel.com>
References: <cover.1695704179.git.yu.c.chen@intel.com>
 <ZRPhC7b6OT1uFtNE@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZRPhC7b6OT1uFtNE@gmail.com>
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SN7PR11MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d7a8194-ce4c-4bed-08d9-08dbbffc2e16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /I3Qqxyoyy+wA7gsI27XhrgESWF6ALTpBom/i2Umf/AxpxS/tKoM4icdo0iMos8n4TCng1baer5YRjkjI3GUrseSJocme7zYPK9VYMVNfZS74Q2HqZxgSwld7k9u4XKIOmyHwjzJ5qCOwRyFqkujcTOioqqhAQTWUrC6Y8HKDYIVL6hsIy5gdWpL1zYPI9Nd+c8m/0rbgE2FDuwV0ux7uB5gddHC53yQzueu5IKjkjV0aseBIJkSafIz8agO5ayXGYPhW3++LNQNH6/RNQgOf8PZdhT3GZ1mkDHcB7L6yCAGevgJH5rLavwct+uksnHs19jHas6xWrO91vZYhx6sS1ZdrwEYOEZqsZS8Ha8HxSm6+c/nk+IWqKJnbHWvCX60dkhnjtr5ZevECqLUlHaIthjX97md9MjjV7K4VOkM+PGhI8+aB6QcI0JFi6UjgpiuxYx5NHfRefXLvUmgcnxfFLUHfgNacKW6Iy3U7qD2IphKAba8wQE25E1TNtz7MvP6uXLKppgDBitMH3njQ3h0OH/amdCI+oWMMejPDg7lUIptQy11tryrz95SJYkgy0tC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(136003)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(8676002)(54906003)(66946007)(316002)(41300700001)(66476007)(6916009)(66556008)(6512007)(4326008)(8936002)(7416002)(2906002)(478600001)(6666004)(26005)(6486002)(5660300002)(38100700002)(6506007)(53546011)(83380400001)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UUwobaGtXDXxu+WHvHg6bt7ask67Z6izenI/aR28+LiKz1E1KbCgoJLwH50a?=
 =?us-ascii?Q?lMnftIWUB9g/K192cNNpVOIGjdmheqk223PVl0THzDpi3ef7DmU/aYiDsq+S?=
 =?us-ascii?Q?afuXR9Oo1iJF8YgfMBU/SOWA5Ts8ZR+QYzUcO8ToRRk0DrMFfdSJ41yzsgYj?=
 =?us-ascii?Q?JPNDxOewW7axt/aaSXlWSiMSMOC7cBxHnpt6GRIVKmQV1e2iqV6CAfiBUWOV?=
 =?us-ascii?Q?UDi6WuWRnBc8CVsQDCpdpe8Ipe2AWLTiu4rpGcA/yVoSHPZvfEihbNrkj/HN?=
 =?us-ascii?Q?DNpeFmiN/Q6O2QPl9qgHFrKF/T+Po534BAT6yGVK7d+QPX30iBGzFvJrGc+E?=
 =?us-ascii?Q?53xot/NJyxdMh6wY2k9IvkuWy5vHWlGk+J2MawG13AO/mSt1r+utUL1fMM+z?=
 =?us-ascii?Q?CYSvZmPlX2ZuJyMcKMOjr+m0tliN6lcHn7CgifTdM0dyRPbprT1ubXJQphqy?=
 =?us-ascii?Q?vkrm2GUUsquZtPFSdsSd5+h6o4X+3y6jLQJgdTs73hObQ93yqmMttikacJZB?=
 =?us-ascii?Q?owOrGr2prsPY1bGa+0scApwqnam/f2UzFkNI7BDUHQ0Hy6zxSABZxks6Sjew?=
 =?us-ascii?Q?OI3kffYYVCZIHS6PDYb3HngYV/8jnnZILNBxqYVnAjTqwM7N+gRKPGZLpAjM?=
 =?us-ascii?Q?l0GYq03SO5bQ14wvog/oY5cU29zIIgKJUUm6k1NjIqrEyKTduQ1MWjoGPZbT?=
 =?us-ascii?Q?d2sH8oL1iiZg6b5BierrXypM2mbf3wTPYgrykn4ocFslfGobfm0KOYkph6Zw?=
 =?us-ascii?Q?J5ffs84y6l+V60AtH/aiOGs4sS7Bt+aZtt47gx5F7pkWCEZcqcpZSeCPFXqf?=
 =?us-ascii?Q?KmrtWS1cm+J+8sJNuX+aGqRLG8mnVvuzHrO+0qxrZBO3U8+r32ytSAcYldiI?=
 =?us-ascii?Q?uTD3RvPbhLsIVHLVaOnFGFvvHSQrQVdM9S0+XzTo91CiX+C57jR3v5K4WCgr?=
 =?us-ascii?Q?nvVDEO3eOacIdUp+OL7v+NV8Nu+zWd3JHJ1yee7Ijc9Q7cblZ6owSNyhdc2w?=
 =?us-ascii?Q?DMoU9+CurHIg25C+FErr1C2E3DIphZTMuBEHWKk+gzYfDETTF+VdZdVzs/Zm?=
 =?us-ascii?Q?Z3Mx4BSguznVsE69XkFfDlupaKCIOAureuh0OJ14lsyYVX7OCOpAcuyBlH/S?=
 =?us-ascii?Q?uxzEqtjaIoKRncgDDrwEHUviCeM2/WJmRNZKqWyQZnsRMyLlB9xIQv4B5Ojq?=
 =?us-ascii?Q?y3fbPygMEAtJJmj8YxNxVMzLQONSNvmvvWEZHVbHsps3JMCM5MCKDZxDJzcC?=
 =?us-ascii?Q?fEuDA1EizH2tv65CYW7XcbBP8YU9JQwr4v18PBxMdRAXt7I8LKUh0fXi1FcZ?=
 =?us-ascii?Q?S7Tw6j7lKv6lAEpFGCixatmBUecqmW6CFORyHNfTiJcnHyBh/OlrAQk47CTU?=
 =?us-ascii?Q?FjNP1n1JmEGAsvtNRAxMdonIJdbMn3UHO7z1urSpIfYI5a9fVjsBVls0vkLv?=
 =?us-ascii?Q?0QbhiXJ+y+5c2XDdu3UWdwViyTnFiNvgCIGHn9m4n+ZMorER1QE6DfWrx8VN?=
 =?us-ascii?Q?MRutTTUUTWyzjxxFegPjvnpCTLnS3aCaXpgOnNbOcYXYPDBwdjKt+1PS0NBv?=
 =?us-ascii?Q?LOyYI0qPWqYE7Kbnpt1bySq29a7E+Y7XldboBYfy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7a8194-ce4c-4bed-08d9-08dbbffc2e16
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 08:23:23.0765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: em+GoWr49tezXuyH8a3J5F79mv9KbLWuwFBWiFrFFOrgT00k9XOHsSf1ebTVnUTQmQKwwWsf4lFXBsKca5z0KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7601
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On 2023-09-27 at 10:00:11 +0200, Ingo Molnar wrote:
> 
> * Chen Yu <yu.c.chen@intel.com> wrote:
> 
> > When task p is woken up, the scheduler leverages select_idle_sibling()
> > to find an idle CPU for it. p's previous CPU is usually a preference
> > because it can improve cache locality. However in many cases, the
> > previous CPU has already been taken by other wakees, thus p has to
> > find another idle CPU.
> > 
> > Inhibit the task migration while keeping the work conservation of
> > scheduler could benefit many workloads. Inspired by Mathieu's
> > proposal to limit the task migration ratio[1], this patch considers
> > the task average sleep duration. If the task is a short sleeping one,
> > then tag its previous CPU as cache hot for a short while. During this
> > reservation period, other wakees are not allowed to pick this idle CPU
> > until a timeout. Later if the task is woken up again, it can find its
> > previous CPU still idle, and choose it in select_idle_sibling().
> 
> Yeah, so I'm not convinced about this at this stage.
> 
> By allowing a task to basically hog a CPU after it has gone idle already,
> however briefly, we reduce resource utilization efficiency for the sake
> of singular benchmark workloads.
>

Currently in the code we do not really reserve the idle CPU or force it
to be idle. We just give other wakee a search sequence suggestion to find
the idle CPU. If all idle CPUs are in reserved state, the first reserved idle
CPU will be picked up rather than left it in idle. This can fully utilize the
idle CPU resource. The main impact is the wakeup latency if I understand
correctly. Let me run the latest schbench and monitor these latency statistics
in detail.
 
> In a mixed environment the cost of leaving CPUs idle longer than necessary
> will show up - and none of these benchmarks show that kind of side effect
> and indirect overhead.
> 
> This feature would be a lot more convincing if it tried to measure overhead
> in the pathological case, not the case it's been written for.
>

Thanks for the suggestion, Ingo. Yes, we should launch more tests to evaluate this
proposal. As Tim mentioned, we have previously tested it using OLTP benchmark
as described in PATCH [2/2]. I'm thinking of running more benchmarks to get
a wider understanding of how this change would impact them, both positive and
negative part.

thanks,
Chenyu
