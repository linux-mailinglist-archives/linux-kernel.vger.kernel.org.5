Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0457178BCFB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 04:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbjH2CnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 22:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbjH2Cm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:42:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3E51AC;
        Mon, 28 Aug 2023 19:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693276971; x=1724812971;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FoXoadNI3su0bt27LLPndCMCilW/GxdnGLxcMm/Q2EE=;
  b=fOf5TGC3+n/hHSdBedG4to09Np1Asl6//iu07cQkmXd+7z9SBFBf3lTN
   FnpJWiuX5YasUOP9hkvpx8vmupnVgmTDaC/tVH+45rZP2Ay0bleknvWvS
   tdFnl6F69SwnNQUob378OYLmPtqLwvbXsKWbhZYZrs9cZN5ZCukK9bXNI
   Pdwq29huhSmYEOZ4FDBqS5L+9uyTZZQ28sWqXnoIkNqw8TyztAWTs4Aq3
   WQdGXvrm/wg7FRyULCSF0qWz1k6DXWI/ytFIfBD46GUwe/5KOH1DCYqia
   5UzMy1sPSK4AwMgrUN5ee7ipdO+qfFVdTV2wTDvzfDTx/UTnC4uAvHi9n
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="372676128"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="372676128"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 19:42:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="767898823"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="767898823"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 28 Aug 2023 19:42:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 19:42:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 19:42:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 28 Aug 2023 19:42:18 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 28 Aug 2023 19:42:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZcrFFql8ZexcIOhmap9EipoPUhF8jTO+/58tJjhC1upYWNbjBCe8+naPTk9kE9iJGh+qo5zmpKLNmnBc380OYZkGNXoqWB4eHFMRMEyZwKdM6wotkPVvOfLiM159iYFt6R9g4hoPMArjVugfME5qWVrlr5l3jQpXO1DfakhlOWYRCE9Ew2yCYeY/4/Hu3aL3GdwkjmJTrK7E84PFLFAH9gwi05lco6eVx2MQThRW3iVvk4oKaE2MEX7y7/i4JpYEjJdD32VW93RW4cqMINjfrUMItnHF98M3iQ4vNsvUVC+eeHTL8FI/eFBNLZ6IsPrrKafbvE16+3VnBT1cUsl5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+Ai5l+tltZW2ISDbpNRA1ne2DJwE62iESVi/HieTmk=;
 b=FdPJu/TuDKQSJjguO1oifUxG+Crgr5Xvh7vpLJZAwjHMOtMp/Eja1IooSlOi8Lb56y+kNtAKN3DZAb8wNVqNL3Ik7j3Q0kV+gG0XPMKikuiTWFii4a1gB1sE5CmKM2TLgI07bHjPmM0HheHeWizA7niDLt1WUhd+oD3ViUNtwNDAwMs/n9C1qn+gFDvPhAcF0SvLwvbISYhrIERe5G2OHxh7vIYsUDadw/Jd5wyFwCw1/ngB196GMuJcGkmcT9MBNK5/N/qEvuM+jmCo8yP3YTiz5LYk1SJkSuq8Pc0ASyTLNl9PXcO8BT0zM0RBlqsjSDup09uSvx5VhYIPNZz/+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CH3PR11MB8518.namprd11.prod.outlook.com (2603:10b6:610:1b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.13; Tue, 29 Aug
 2023 02:42:13 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 02:42:13 +0000
Date:   Tue, 29 Aug 2023 10:42:04 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <oliver.sang@intel.com>
Subject: Re: [perf-tools-next:tmp.perf-tools-next] [perf dlfilter]
 f178a76b05: perf-sanity-tests.dlfilter_C_API.fail
Message-ID: <ZO1a/GyZmevAXj9Z@xsang-OptiPlex-9020>
References: <202308232146.94d82cb4-oliver.sang@intel.com>
 <78a87ed2-3aa8-95ef-28ae-19961f7c4acb@intel.com>
 <ZOa1LnnwETWCQ6n5@xsang-OptiPlex-9020>
 <8685878c-8de0-88b9-4434-f823620f6abf@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8685878c-8de0-88b9-4434-f823620f6abf@intel.com>
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CH3PR11MB8518:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b5e2453-9186-409c-a901-08dba8398cb2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DHV7V49qomXn+kzfuHmJhFyAefhojhb8lBTa7uxmUtZdxXNneucwCC+qCyigDDQLuc9O1b8MuoVYF35PuptNxtnZmTBSaZoyMsihRbMXerg1jubBXAmFuKbbV0X2plbV9Pm4zbgTmbVtKcavb6ZCKN0APA6fan0+Vp7ack8QI6SqIe7qpIB9mlg1MIjXCO77Oaw2yZy03cgFSJt7cSDqIldZvuin26LdlvV3R7aoU3m91EODArZQyyg4Jmk2a60jiYQZCnaLTt1aX3U2gm29qgYkt6t64aueoa0gICxedXRqimDOn/f/leuWyF38kVznQZnW+Cp1+jsVl6XTzlpE1u6ipwPIZPqszAkJ3A+8cwOGHML3v61Vr5033rDdUcqkUVUymz/Jm5byfXKDoe66MLEPtCpc0CKbaiDzed8hzR9tkWDIP0jcLqje8ZPz4HMLK0ismOa2XuJyBUbIXtBqeGAJ5zbaLo76lW591XaJxBkdkrhQ3nVnPdbW3TI5mFdgV9qkMV8SpS+Xu/WslvdUWesVDJuS5XDvGOUVFVxbSb6S2se4Yb+YZOGiOSnq2BAZfmUvhNYUmEi4LziwzvNeSIMmQLgD8YonQVNpf4X9uQAg5ah+P6HeDZ0nglsKSO+I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199024)(186009)(1800799009)(966005)(33716001)(86362001)(6862004)(5660300002)(53546011)(9686003)(83380400001)(30864003)(44832011)(8676002)(41300700001)(4326008)(66556008)(6512007)(6486002)(6666004)(107886003)(26005)(6506007)(8936002)(54906003)(82960400001)(38100700002)(66946007)(2906002)(66476007)(6636002)(316002)(478600001)(2004002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pjbMA8KcdaHgyLBzt7Lh0aiOopVgF16MYhAF4YbLuO6U1KLd16wrENzNjTPU?=
 =?us-ascii?Q?YrrswXhIdeNP29e1nsRNoTyM0N7eOPKHbjNQoXZFizv0IR89iuJvGx2KgBgt?=
 =?us-ascii?Q?0fQESEiObYlMwqnEivK2kO+AVklw43GtW8D1rHepk8tJ0FXHf1LuAIz7KS8J?=
 =?us-ascii?Q?t+wO0+aMYAhjp7Gs57d6tPh8es+m8jNSH6FELraX1CT2rhM8jKqeqQmYQtTy?=
 =?us-ascii?Q?WjfXUoqx4/Jm2ofHFdW7esn4EtDYR0vbue3L4TMBcKCHqZqPOpBkMt8HydC+?=
 =?us-ascii?Q?vxxH421IJm7MkqCAzy9LcmTl78ivf+OaI3m2CISLZYc75pZEJTfRZFpJLJBa?=
 =?us-ascii?Q?SF5tFGyNNhw8/SbOLdQ/OjtKQk3Doko3yHLxk1nzjdeHlFOoR6lCU6LccJ1q?=
 =?us-ascii?Q?l4cYpqt0PdfnW448yOl5/I9iyYU/5wdbLiBqcdP5HpiOvitUfyubfukCAluu?=
 =?us-ascii?Q?m8+h+Gph/NfJhhKRwnJGJNoz/KQyuph1iucILrcziPIhvwrvKdSvBsSCA9ML?=
 =?us-ascii?Q?OrYaRupIJLk8DVTP2Ehn4ydijQ3bcJnKr6iyBRYsGLIwdEiJOAvnxc4VERh3?=
 =?us-ascii?Q?xR3fpB2eiDE/qOv1HkIrUlm7OPMBzhnfjNRQoVAyygTCQSneiGppVyCi1+DP?=
 =?us-ascii?Q?qxW0rQ2WQS6o3v7V9BW9liHO/EnQwPkPDF9gaSQDx1vZs61Hsy1AFcwjPovV?=
 =?us-ascii?Q?1cK6I/m6snMcW1gfB/hDEHBziJiVkYpZHzSOKK4qwxW1OyuE2vgMeDUUP22l?=
 =?us-ascii?Q?sjZxgENar/eDKPlpmemZMp+v7c3AXnmZyeiHBFAhAC/+8Xim9xEEpEt++BBL?=
 =?us-ascii?Q?PRAjeOdLxjwWIw/loBVsfXccB17fxVq49I8QRbDT3bAEemwFnEcrWUwcr6Kr?=
 =?us-ascii?Q?/3uMGoi0O53Wttok2ri+x+QQ8RGmWgaYL8AYqc0L6KOmcHs6bJh7KTPigpc2?=
 =?us-ascii?Q?RQHDZJ0ThQIHKmFZEjPc2UVBJLNVoS351on1H/cW/xC0MVeeuvwfU+eMTfRM?=
 =?us-ascii?Q?01hm2cPpPf4OJhANGp4BbKx0IjrmBdManxyX5TR3jdmunQvSilsRARDL+O5v?=
 =?us-ascii?Q?8bcMF1HNcF4ez3Wxhiin0tJcRUzE0lWn//XwXuRCNwaqhdTGMaIxZ0luYOYf?=
 =?us-ascii?Q?Ijvy7HMn2FOKde1DHRIsraLNNOgrM86BolItCUcIZ5eklOXJgFbSnw6+aB7W?=
 =?us-ascii?Q?uLMGiff3B323s4EsXodRtF+FFmuhGczSgTMh2zJaHNHSDqENBjHePh/ckWpr?=
 =?us-ascii?Q?Nef6Pfb3ksu7GSxg9kwLhAJP+tJM8OBU9np5t5GSdewMnYJ1caA/oKsyQR3J?=
 =?us-ascii?Q?s8s+cWL98G5lvOlvMaHjvtYnpMoZzlFJUi4C76M/mMPGO4E8D7pYc6Y+bamX?=
 =?us-ascii?Q?AgsUXZukj4Maf3Mpyc/e8BZilDCL1yZBeXh3cfiaDGLSN6Nn3DskW5ag6VB9?=
 =?us-ascii?Q?22HnYpDNshFvo/hdm/Oe71+683w69lq11wzlUJnuOmbVSwPksOuowml+Kwrl?=
 =?us-ascii?Q?7sBEH/04TeH9oL5yO0cFZFX3K3HFl4OL5MZDizqSymPnTusZtxuPjciGzL3g?=
 =?us-ascii?Q?jireGqBWs04txaoME5avOEAUEBrwFFgfZPfGOmp1wedVUghvAHEHncdzRk/u?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b5e2453-9186-409c-a901-08dba8398cb2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 02:42:13.3256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YIVD0nOFNs1ikvzGfLXabbMbcQxDG8+D6tPaMTy177UUq3GlyguD/vnotBi1HvZlUm6xZ5nONRpy7msfrQsaAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8518
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, Adrian Hunter,

On Thu, Aug 24, 2023 at 07:45:25AM +0300, Adrian Hunter wrote:
> On 24/08/23 04:41, Oliver Sang wrote:
> > hi, Adrian Hunter,
> > 
> > On Wed, Aug 23, 2023 at 06:37:49PM +0300, Adrian Hunter wrote:
> >> On 23/08/23 17:57, kernel test robot wrote:
> >>>
> >>>
> >>> Hello,
> >>>
> >>> kernel test robot noticed "perf-sanity-tests.dlfilter_C_API.fail" on:
> >>>
> >>> commit: f178a76b054fd046d212c3c67745146ff191a443 ("perf dlfilter: Add a test for resolve_address()")
> >>> https://git.kernel.org/cgit/linux/kernel/git/perf/perf-tools-next.git tmp.perf-tools-next
> >>>
> >>> [test failed on linux-next/master 28c736b0e92e11bfe2b9997688213dc43cb22182]
> >>
> >> We sometimes make a test for an issue then fix it, so the new test fails,
> >> but is fixed in a subsequent patch.  If you read the commit it says as much:
> >>
> >> commit f178a76b054fd046d212c3c67745146ff191a443
> >> Author: Adrian Hunter <adrian.hunter@intel.com>
> >> Date:   Mon Jul 31 12:18:55 2023 +0300
> >>
> >>     perf dlfilter: Add a test for resolve_address()
> >>     
> >>     Extend the "dlfilter C API" test to test
> >>     perf_dlfilter_fns.resolve_address(). The test currently fails, but passes
> >>     after a subsequent patch.
> >>     
> >>     Reviewed-by: Ian Rogers <irogers@google.com>
> >>     Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >>     Cc: Jiri Olsa <jolsa@kernel.org>
> >>     Cc: Namhyung Kim <namhyung@kernel.org>
> >>     Link: https://lore.kernel.org/r/20230731091857.10681-1-adrian.hunter@intel.com
> >>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >>
> >> The fix is:
> >>
> >> 42c6dd9d23019ff339d0aca80a444eb71087050e perf dlfilter: Initialize addr_location before passing it to thread__find_symbol_fb()
> > 
> > thanks a lot for information!
> > 
> > as above mentioned, when this auto-bisect done, it confirmed the issue still
> > exists linux-next/master:
> > [test failed on linux-next/master 28c736b0e92e11bfe2b9997688213dc43cb22182]
> > which includes 42c6dd9d23019ff339d0aca80a444eb71087050e
> > 
> > we will test again on latest linux-next/master:
> > e3f80d3eae76c (tag: next-20230823, linux-next/master, broonie-ci/next-master) Add linux-next specific files for 20230823
> > and 42c6dd9d23019ff339d0aca80a444eb71087050e
> > 
> > Thanks
> 
> Could you include the output from:
> 
> 	perf test -v dlfilter

sorry for late. by testing again on e3f80d3eae76c (next-20230823) and fix
commit (42c6dd9d23019), we still observed the failure of "dlfilter C API"
test.

below is the output after adding '-v':

 67: dlfilter C API                                                  :
--- start ---
test child forked, pid 10070
Checking for gcc
Command: gcc --version
gcc (Debian 10.2.1-6) 10.2.1 20210110
Copyright (C) 2020 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

dlfilters path: /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/dlfilters
Command: gcc -g -o /tmp/dlfilter-test-10070-prog /tmp/dlfilter-test-10070-prog.c
Creating new host machine structure
Command: /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf script -i /tmp/dlfilter-test-10070-perf-data --dlfilter /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/dlfilters/dlfilter-test-api-v0.so --dlarg first --dlarg 1 --dlarg 4198700 --dlarg 4198693 --dlarg 0 --dlarg last
start API
filter_event_early API
filter_event API
stop API

=================================================================
==10080==ERROR: LeakSanitizer: detected memory leaks

Indirect leak of 1314 byte(s) in 21 object(s) allocated from:
    #0 0x7fb81e5d2037 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
    #1 0x5629993429c2 in symbol__new util/symbol.c:300
    #2 0x5629996dfe6b in dso__load_sym_internal util/symbol-elf.c:1713
    #3 0x5629996e08c8 in dso__load_sym util/symbol-elf.c:1771
    #4 0x56299934f62a in dso__load util/symbol.c:2042
    #5 0x5629993d9f61 in map__load util/map.c:353
    #6 0x5629993da42a in map__find_symbol util/map.c:387
    #7 0x56299928f86c in machine__resolve util/event.c:760
    #8 0x562998fa4ba1 in process_sample_event /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/builtin-script.c:2389
    #9 0x5629993f6a7a in evlist__deliver_sample util/session.c:1518
    #10 0x5629993f6f94 in machines__deliver_event util/session.c:1557
    #11 0x5629993f8902 in perf_session__deliver_event util/session.c:1639
    #12 0x5629993e45dd in ordered_events__deliver_event util/session.c:188
    #13 0x562999413dbc in do_flush util/ordered-events.c:245
    #14 0x562999414bd7 in __ordered_events__flush util/ordered-events.c:324
    #15 0x5629994150b2 in ordered_events__flush util/ordered-events.c:342
    #16 0x5629993fe9ac in __perf_session__process_pipe_events util/session.c:2122
    #17 0x562999405d8a in perf_session__process_events util/session.c:2622
    #18 0x562998faa215 in __cmd_script /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/builtin-script.c:2839
    #19 0x562998fbe081 in cmd_script /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/builtin-script.c:4365
    #20 0x562999224c02 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:322
    #21 0x56299922547f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:375
    #22 0x5629992259b1 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:419
    #23 0x5629992260dd in main /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:535
    #24 0x7fb81d77ad09 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x23d09)

Indirect leak of 478 byte(s) in 1 object(s) allocated from:
    #0 0x7fb81e5d2037 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
    #1 0x562999336ea3 in dso__new_id util/dso.c:1315
    #2 0x56299933d354 in __dsos__addnew_id util/dsos.c:271
    #3 0x56299933d4e1 in __dsos__findnew_id util/dsos.c:294
    #4 0x56299933d58d in dsos__findnew_id util/dsos.c:301
    #5 0x5629993d4c4b in machine__findnew_dso_id util/machine.c:3364
    #6 0x5629993d8a33 in map__new util/map.c:167
    #7 0x5629993c759d in machine__process_mmap_event util/machine.c:2029
    #8 0x56299928acc7 in perf_event__process_mmap util/event.c:395
    #9 0x5629993f7022 in machines__deliver_event util/session.c:1559
    #10 0x5629993f8902 in perf_session__deliver_event util/session.c:1639
    #11 0x5629993fb98d in perf_session__process_event util/session.c:1875
    #12 0x5629993fe31b in __perf_session__process_pipe_events util/session.c:2102
    #13 0x562999405d8a in perf_session__process_events util/session.c:2622
    #14 0x562998faa215 in __cmd_script /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/builtin-script.c:2839
    #15 0x562998fbe081 in cmd_script /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/builtin-script.c:4365
    #16 0x562999224c02 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:322
    #17 0x56299922547f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:375
    #18 0x5629992259b1 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:419
    #19 0x5629992260dd in main /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:535
    #20 0x7fb81d77ad09 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x23d09)

Indirect leak of 256 byte(s) in 1 object(s) allocated from:
    #0 0x7fb81e5d2037 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
    #1 0x56299986b463 in zalloc (/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf+0x1923463)
    #2 0x56299941dcbe in thread__new util/thread.c:44
    #3 0x5629993bb6b7 in ____machine__findnew_thread util/machine.c:654
    #4 0x5629993bbad8 in __machine__findnew_thread util/machine.c:693
    #5 0x5629993bbb8e in machine__findnew_thread util/machine.c:703
    #6 0x5629993bc0a1 in machine__process_comm_event util/machine.c:750
    #7 0x562999289065 in perf_event__process_comm util/event.c:224
    #8 0x5629993f72b9 in machines__deliver_event util/session.c:1565
    #9 0x5629993f8902 in perf_session__deliver_event util/session.c:1639
    #10 0x5629993fb98d in perf_session__process_event util/session.c:1875
    #11 0x5629993fe31b in __perf_session__process_pipe_events util/session.c:2102
    #12 0x562999405d8a in perf_session__process_events util/session.c:2622
    #13 0x562998faa215 in __cmd_script /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/builtin-script.c:2839
    #14 0x562998fbe081 in cmd_script /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/builtin-script.c:4365
    #15 0x562999224c02 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:322
    #16 0x56299922547f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:375
    #17 0x5629992259b1 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:419
    #18 0x5629992260dd in main /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:535
    #19 0x7fb81d77ad09 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x23d09)

Indirect leak of 120 byte(s) in 1 object(s) allocated from:
    #0 0x7fb81e5d2037 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
    #1 0x56299986b463 in zalloc (/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf+0x1923463)
    #2 0x5629993debff in maps__new util/maps.c:166
    #3 0x56299941dbfe in thread__init_maps util/thread.c:27
    #4 0x5629993bb822 in ____machine__findnew_thread util/machine.c:674
    #5 0x5629993bbad8 in __machine__findnew_thread util/machine.c:693
    #6 0x56299941dc26 in thread__init_maps util/thread.c:29
    #7 0x5629993bb822 in ____machine__findnew_thread util/machine.c:674
    #8 0x5629993bbad8 in __machine__findnew_thread util/machine.c:693
    #9 0x5629993bbb8e in machine__findnew_thread util/machine.c:703
    #10 0x5629993bc0a1 in machine__process_comm_event util/machine.c:750
    #11 0x562999289065 in perf_event__process_comm util/event.c:224
    #12 0x5629993f72b9 in machines__deliver_event util/session.c:1565
    #13 0x5629993f8902 in perf_session__deliver_event util/session.c:1639
    #14 0x5629993fb98d in perf_session__process_event util/session.c:1875
    #15 0x5629993fe31b in __perf_session__process_pipe_events util/session.c:2102
    #16 0x562999405d8a in perf_session__process_events util/session.c:2622
    #17 0x562998faa215 in __cmd_script /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/builtin-script.c:2839
    #18 0x562998fbe081 in cmd_script /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/builtin-script.c:4365
    #19 0x562999224c02 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:322
    #20 0x56299922547f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:375
    #21 0x5629992259b1 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:419
    #22 0x5629992260dd in main /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:535
    #23 0x7fb81d77ad09 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x23d09)

Indirect leak of 72 byte(s) in 1 object(s) allocated from:
    #0 0x7fb81e5d1e8f in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:145
    #1 0x5629993d86fc in map__new util/map.c:128
    #2 0x5629993c759d in machine__process_mmap_event util/machine.c:2029
    #3 0x56299928acc7 in perf_event__process_mmap util/event.c:395
    #4 0x5629993f7022 in machines__deliver_event util/session.c:1559
    #5 0x5629993f8902 in perf_session__deliver_event util/session.c:1639
    #6 0x5629993fb98d in perf_session__process_event util/session.c:1875
    #7 0x5629993fe31b in __perf_session__process_pipe_events util/session.c:2102
    #8 0x562999405d8a in perf_session__process_events util/session.c:2622
    #9 0x562998faa215 in __cmd_script /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/builtin-script.c:2839
    #10 0x562998fbe081 in cmd_script /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/builtin-script.c:4365
    #11 0x562999224c02 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:322
    #12 0x56299922547f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:375
    #13 0x5629992259b1 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:419
    #14 0x5629992260dd in main /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:535
    #15 0x7fb81d77ad09 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x23d09)

Indirect leak of 67 byte(s) in 1 object(s) allocated from:
    #0 0x7fb81e5d2037 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
    #1 0x5629993429c2 in symbol__new util/symbol.c:300
    #2 0x5629996d554e in dso__synthesize_plt_got_symbols util/symbol-elf.c:653
    #3 0x5629996d5f7f in dso__synthesize_plt_symbols util/symbol-elf.c:714
    #4 0x56299934f662 in dso__load util/symbol.c:2049
    #5 0x5629993d9f61 in map__load util/map.c:353
    #6 0x5629993da42a in map__find_symbol util/map.c:387
    #7 0x56299928f86c in machine__resolve util/event.c:760
    #8 0x562998fa4ba1 in process_sample_event /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/builtin-script.c:2389
    #9 0x5629993f6a7a in evlist__deliver_sample util/session.c:1518
    #10 0x5629993f6f94 in machines__deliver_event util/session.c:1557
    #11 0x5629993f8902 in perf_session__deliver_event util/session.c:1639
    #12 0x5629993e45dd in ordered_events__deliver_event util/session.c:188
    #13 0x562999413dbc in do_flush util/ordered-events.c:245
    #14 0x562999414bd7 in __ordered_events__flush util/ordered-events.c:324
    #15 0x5629994150b2 in ordered_events__flush util/ordered-events.c:342
    #16 0x5629993fe9ac in __perf_session__process_pipe_events util/session.c:2122
    #17 0x562999405d8a in perf_session__process_events util/session.c:2622
    #18 0x562998faa215 in __cmd_script /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/builtin-script.c:2839
    #19 0x562998fbe081 in cmd_script /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/builtin-script.c:4365
    #20 0x562999224c02 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:322
    #21 0x56299922547f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:375
    #22 0x5629992259b1 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:419
    #23 0x5629992260dd in main /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:535
    #24 0x7fb81d77ad09 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x23d09)

Indirect leak of 53 byte(s) in 1 object(s) allocated from:
    #0 0x7fb81e5d2037 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
    #1 0x5629993429c2 in symbol__new util/symbol.c:300
    #2 0x5629996d5e7e in dso__synthesize_plt_symbols util/symbol-elf.c:707
    #3 0x56299934f662 in dso__load util/symbol.c:2049
    #4 0x5629993d9f61 in map__load util/map.c:353
    #5 0x5629993da42a in map__find_symbol util/map.c:387
    #6 0x56299928f86c in machine__resolve util/event.c:760
    #7 0x562998fa4ba1 in process_sample_event /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/builtin-script.c:2389
    #8 0x5629993f6a7a in evlist__deliver_sample util/session.c:1518
    #9 0x5629993f6f94 in machines__deliver_event util/session.c:1557
    #10 0x5629993f8902 in perf_session__deliver_event util/session.c:1639
    #11 0x5629993e45dd in ordered_events__deliver_event util/session.c:188
    #12 0x562999413dbc in do_flush util/ordered-events.c:245
    #13 0x562999414bd7 in __ordered_events__flush util/ordered-events.c:324
    #14 0x5629994150b2 in ordered_events__flush util/ordered-events.c:342
    #15 0x5629993fe9ac in __perf_session__process_pipe_events util/session.c:2122
    #16 0x562999405d8a in perf_session__process_events util/session.c:2622
    #17 0x562998faa215 in __cmd_script /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/builtin-script.c:2839
    #18 0x562998fbe081 in cmd_script /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/builtin-script.c:4365
    #19 0x562999224c02 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:322
    #20 0x56299922547f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:375
    #21 0x5629992259b1 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:419
    #22 0x5629992260dd in main /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:535
    #23 0x7fb81d77ad09 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x23d09)

Indirect leak of 48 byte(s) in 1 object(s) allocated from:
    #0 0x7fb81e5d2037 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
    #1 0x56299986b463 in zalloc (/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf+0x1923463)
    #2 0x56299941ac12 in comm__new util/comm.c:110
    #3 0x56299941dddc in thread__new util/thread.c:64
    #4 0x5629993bb6b7 in ____machine__findnew_thread util/machine.c:654
    #5 0x5629993bbad8 in __machine__findnew_thread util/machine.c:693
    #6 0x5629993bbb8e in machine__findnew_thread util/machine.c:703
    #7 0x5629993bc0a1 in machine__process_comm_event util/machine.c:750
    #8 0x562999289065 in perf_event__process_comm util/event.c:224
    #9 0x5629993f72b9 in machines__deliver_event util/session.c:1565
    #10 0x5629993f8902 in perf_session__deliver_event util/session.c:1639
    #11 0x5629993fb98d in perf_session__process_event util/session.c:1875
    #12 0x5629993fe31b in __perf_session__process_pipe_events util/session.c:2102
    #13 0x562999405d8a in perf_session__process_events util/session.c:2622
    #14 0x562998faa215 in __cmd_script /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/builtin-script.c:2839
    #15 0x562998fbe081 in cmd_script /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/builtin-script.c:4365
    #16 0x562999224c02 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:322
    #17 0x56299922547f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:375
    #18 0x5629992259b1 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:419
    #19 0x5629992260dd in main /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:535
    #20 0x7fb81d77ad09 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x23d09)

Indirect leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x7fb81e5d1e8f in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:145
    #1 0x5629993ddbfc in __maps__insert util/maps.c:43
    #2 0x5629993de075 in maps__insert util/maps.c:70
    #3 0x56299941f59f in thread__insert_map util/thread.c:349
    #4 0x5629993c75cb in machine__process_mmap_event util/machine.c:2036
    #5 0x56299928acc7 in perf_event__process_mmap util/event.c:395
    #6 0x5629993f7022 in machines__deliver_event util/session.c:1559
    #7 0x5629993f8902 in perf_session__deliver_event util/session.c:1639
    #8 0x5629993fb98d in perf_session__process_event util/session.c:1875
    #9 0x5629993fe31b in __perf_session__process_pipe_events util/session.c:2102
    #10 0x562999405d8a in perf_session__process_events util/session.c:2622
    #11 0x562998faa215 in __cmd_script /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/builtin-script.c:2839
    #12 0x562998fbe081 in cmd_script /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/builtin-script.c:4365
    #13 0x562999224c02 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:322
    #14 0x56299922547f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:375
    #15 0x5629992259b1 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:419
    #16 0x5629992260dd in main /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:535
    #17 0x7fb81d77ad09 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x23d09)

Indirect leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x7fb81e5d2037 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
    #1 0x5629994178b7 in nsinfo__alloc util/namespaces.c:147
    #2 0x56299941796e in nsinfo__new util/namespaces.c:161
    #3 0x56299941de82 in thread__new util/thread.c:72
    #4 0x5629993bb6b7 in ____machine__findnew_thread util/machine.c:654
    #5 0x5629993bbad8 in __machine__findnew_thread util/machine.c:693
    #6 0x5629993bbb8e in machine__findnew_thread util/machine.c:703
    #7 0x5629993bc0a1 in machine__process_comm_event util/machine.c:750
    #8 0x562999289065 in perf_event__process_comm util/event.c:224
    #9 0x5629993f72b9 in machines__deliver_event util/session.c:1565
    #10 0x5629993f8902 in perf_session__deliver_event util/session.c:1639
    #11 0x5629993fb98d in perf_session__process_event util/session.c:1875
    #12 0x5629993fe31b in __perf_session__process_pipe_events util/session.c:2102
    #13 0x562999405d8a in perf_session__process_events util/session.c:2622
    #14 0x562998faa215 in __cmd_script /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/builtin-script.c:2839
    #15 0x562998fbe081 in cmd_script /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/builtin-script.c:4365
    #16 0x562999224c02 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:322
    #17 0x56299922547f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:375
    #18 0x5629992259b1 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:419
    #19 0x5629992260dd in main /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:535
    #20 0x7fb81d77ad09 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x23d09)

Indirect leak of 30 byte(s) in 1 object(s) allocated from:
    #0 0x7fb81e57f817 in __interceptor_strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:452
    #1 0x56299934f456 in dso__load util/symbol.c:2011
    #2 0x5629993d9f61 in map__load util/map.c:353
    #3 0x5629993da42a in map__find_symbol util/map.c:387
    #4 0x56299928f86c in machine__resolve util/event.c:760
    #5 0x562998fa4ba1 in process_sample_event /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/builtin-script.c:2389
    #6 0x5629993f6a7a in evlist__deliver_sample util/session.c:1518
    #7 0x5629993f6f94 in machines__deliver_event util/session.c:1557
    #8 0x5629993f8902 in perf_session__deliver_event util/session.c:1639
    #9 0x5629993e45dd in ordered_events__deliver_event util/session.c:188
    #10 0x562999413dbc in do_flush util/ordered-events.c:245
    #11 0x562999414bd7 in __ordered_events__flush util/ordered-events.c:324
    #12 0x5629994150b2 in ordered_events__flush util/ordered-events.c:342
    #13 0x5629993fe9ac in __perf_session__process_pipe_events util/session.c:2122
    #14 0x562999405d8a in perf_session__process_events util/session.c:2622
    #15 0x562998faa215 in __cmd_script /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/builtin-script.c:2839
    #16 0x562998fbe081 in cmd_script /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/builtin-script.c:4365
    #17 0x562999224c02 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:322
    #18 0x56299922547f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:375
    #19 0x5629992259b1 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:419
    #20 0x5629992260dd in main /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:535
    #21 0x7fb81d77ad09 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x23d09)

Indirect leak of 25 byte(s) in 1 object(s) allocated from:
    #0 0x7fb81e57f817 in __interceptor_strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:452
    #1 0x56299933d208 in dso__set_basename util/dsos.c:259
    #2 0x56299933d37e in __dsos__addnew_id util/dsos.c:275
    #3 0x56299933d4e1 in __dsos__findnew_id util/dsos.c:294
    #4 0x56299933d58d in dsos__findnew_id util/dsos.c:301
    #5 0x5629993d4c4b in machine__findnew_dso_id util/machine.c:3364
    #6 0x5629993d8a33 in map__new util/map.c:167
    #7 0x5629993c759d in machine__process_mmap_event util/machine.c:2029
    #8 0x56299928acc7 in perf_event__process_mmap util/event.c:395
    #9 0x5629993f7022 in machines__deliver_event util/session.c:1559
    #10 0x5629993f8902 in perf_session__deliver_event util/session.c:1639
    #11 0x5629993fb98d in perf_session__process_event util/session.c:1875
    #12 0x5629993fe31b in __perf_session__process_pipe_events util/session.c:2102
    #13 0x562999405d8a in perf_session__process_events util/session.c:2622
    #14 0x562998faa215 in __cmd_script /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/builtin-script.c:2839
    #15 0x562998fbe081 in cmd_script /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/builtin-script.c:4365
    #16 0x562999224c02 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:322
    #17 0x56299922547f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:375
    #18 0x5629992259b1 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:419
    #19 0x5629992260dd in main /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-42c6dd9d23019ff339d0aca80a444eb71087050e/tools/perf/perf.c:535
    #20 0x7fb81d77ad09 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x23d09)

SUMMARY: AddressSanitizer: 2527 byte(s) leaked in 32 allocation(s).
Failed with return value 256
test child finished with -1
---- end ----
dlfilter C API: FAILED!


> 
> > 
> >>>
> >>> in testcase: perf-sanity-tests
> >>> version: perf-x86_64-00c7b5f4ddc5-1_20230402
> >>> with following parameters:
> >>>
> >>> 	perf_compiler: gcc
> >>>
> >>>
> >>>
> >>> compiler: gcc-12
> >>> test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory
> >>>
> >>> (please refer to attached dmesg/kmsg for entire log/backtrace)
> >>>
> >>>
> >>>
> >>>
> >>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> >>> the same patch/commit), kindly add following tags
> >>> | Reported-by: kernel test robot <oliver.sang@intel.com>
> >>> | Closes: https://lore.kernel.org/oe-lkp/202308232146.94d82cb4-oliver.sang@intel.com
> >>>
> >>>
> >>>
> >>>  66: Convert perf time to TSC                                        :
> >>>  66.1: TSC support                                                   : Ok
> >>>  66.2: Perf time to TSC                                              : Ok
> >>>  67: dlfilter C API                                                  : FAILED!  <---
> >>>  68: Sigtrap                                                         : Ok
> >>>
> >>>
> >>>
> >>> The kernel config and materials to reproduce are available at:
> >>> https://download.01.org/0day-ci/archive/20230823/202308232146.94d82cb4-oliver.sang@intel.com
> >>>
> >>>
> >>>
> >>
> 
