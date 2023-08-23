Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0C3784EE3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 04:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjHWCwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 22:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjHWCwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 22:52:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756631A5;
        Tue, 22 Aug 2023 19:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692759156; x=1724295156;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=BxhTdxd+e8kzFSkcAc1Aj2Tpu6g68mXoJxeEwrExm7o=;
  b=k8F33AmDR8Dpk/Mai7C37U+WopW7GYzrsiFaWGqsGO1Syu9gzYgvPXJr
   L34lrhbQ7AstPs+nH9+v5ZNDnf7JCu3wtnONAoAtqC1bGAW8wEfwiS/Ah
   OBCRtO9AroP3N0NNTSz+Fin0+r/dBMLE26AYM2ACNVRPJyePGa4eKxIRa
   bzY4N5O4HKBJ5doKEruHMLYPKye/D7yFnY3nbCVw87X73iICEVt9INU/K
   VEWtP8CbJDNAaGbrQh1HoRTSKIjWK5l9Uw33Ce5nVOjdyCSm+v9cUC5mU
   POy/kEJu8nG+g3JWoUoNf8iE9+AYhNOiHoz+t2som/yHFBlGDqkjFEBId
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="374021294"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="374021294"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 19:52:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="801921618"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="801921618"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 22 Aug 2023 19:52:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 19:52:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 22 Aug 2023 19:52:34 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 22 Aug 2023 19:52:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjYiyVum820svmuDihdcVWyj52umjPU5exoasqnxvUxXNRxr18UuBZzsqQNkTam5hrd1QK/BY6zrTgnNaiFaogxi48OfGnipn536wTTiyTI6r5AfFmt6Xh8i3S3tjXWI8BaUvRaYD24kktZUferrm2Gb0dU906Q2lGBxH/jFkEr4qARHPTxobS0jVjIIAqaAkCXmItnm7gUn/ST6W4B7/xjU4xL+lyRVWnfE6bwJ5oYzr7JdrTxNrati3/HVpfr0jzjksBg4/nl6on4JYQCZ66tt0UiW/Fm1SpttLIGaMonnZTV6SdW7cLjknSCuhJbbA4v2npawTaelX3mmoxpziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eo3tJgFNeollXkd8mbWHHCXyOobhXgL+EsBb6oAVG1U=;
 b=flouoUKet1tAvtEsNM4zoVybrF3EA+M40gYiZBcjrSofMPCgCRGZJX50nU7G8oXR+/Y87BV7Fgi2BR/K3WTMu365tJCIECDsmAJLKIUsBK/hLVUH6Wz8jr2/Kv7ypPB1uffWu59GzFa+luJ15JBxIX1Q6ep71ovgWtDWiqekYKcSDJKBd48w1CMUlpXXBqM2Hw0B6mS6HZOrN1l3in/pHyxv52wAwCgK0/ObOY5g59iQBmXaURP1AfFoLB26zNIFPxVE6Dbiy0UpsnTwXgu+2eu++C34RfI3SF9+qtAjPtsTslfnRtot9lsXcZHkElo9D/EiIJn/GlWMi9BdfrY7Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CH3PR11MB7674.namprd11.prod.outlook.com (2603:10b6:610:12b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 23 Aug
 2023 02:52:32 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6699.020; Wed, 23 Aug 2023
 02:52:32 +0000
Date:   Wed, 23 Aug 2023 10:52:17 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Ze Gao <zegao2021@gmail.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ze Gao <zegao@tencent.com>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-perf-users@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [RFC PATCH v6 3/5] sched, tracing: reorganize fields of switch
 event struct
Message-ID: <202308231018.8ddf15b7-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230803083352.1585-4-zegao@tencent.com>
X-ClientProxiedBy: KL1PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::33) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CH3PR11MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: 537351b9-ff3f-4c13-a8b4-08dba383ff06
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +jYCMfEeUY3aPDVc0XV672iB8FSZ2TeUMyjlDlw3lrGk1bvnIM6EXEqBl2ot0v+I1XYULxg5eT7zAJsyjvYHjNWEk8INkwocb42nbHVS7c1Aw1eX016KmJvmi+XDw7tcj1eaHkgPn92YXlrHiW4KsyYXOPfN5ZmKFbwmTV+9E+sWr3JnEEBNe89llcj/DbKMFGzx6DwKcSPdNB6J8QSmmTja25WnPtElwJ0MH6zxoA2QQokkiCcE2SPinJ99Wm/OeemEFGlLHWStu0nD1G43qj/gc+fKzWDKZv82DkJAHCR+/YimCDJWvctmv+Ws8q6WrJXX0ZdNuwH12j+DXD4Fg51ta+1FnBXfxfc7lgWXM64x81EoB4y8Mzw33lyaIwwjoNtT64qhfNrqewb6apP0C9DSlSiMKSn+MYpbJjb1WrwiQz1ig2dfiyBl251y4TytnPwBPLIhHtCo3Gpg1PL4pmYcU+3on9+JxXXEwc7hFjRY94mWmBxiAjO4IYrVeP5yF0M4LP+dePclBhyKUj1VAnYG9tmNJaftGTaztNo52rqAcoa8NtupIKS/JNXILmwFlA8penha9kPrj0Th/rlORg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(186009)(451199024)(1800799009)(86362001)(4326008)(5660300002)(8676002)(7416002)(2906002)(36756003)(8936002)(478600001)(966005)(26005)(2616005)(6506007)(6666004)(1076003)(6486002)(6512007)(83380400001)(82960400001)(66946007)(66556008)(66476007)(316002)(6916009)(54906003)(38100700002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i2oKLUU4+6//P3hPxz2E0/LXdfIaA8SUOi5AmySrcvHRudrNtBLSbWHl7HNg?=
 =?us-ascii?Q?wy0LiC1C8LlI85hJDYq9ozQXu46t1iwEqCPvwL8OY0eNl7hs/sGrSW7m0VSo?=
 =?us-ascii?Q?LAnuj59ngn4Mf6ihQhat5Ki+8QUWddubGdQOfo/8gshOJR4srICu83KjwxKN?=
 =?us-ascii?Q?hHtyjsuxvA1dBVmZYpaoxSCbvDy+qTTxjC5BTGEAyX6fsudSyVWeByHjEMFh?=
 =?us-ascii?Q?tiSYWtp9erxR3B9/0AsmeUk5EUswr+ayKDRxj/weuNDXHhy21weMygdcZFLT?=
 =?us-ascii?Q?dQpgPaYujodwn4s1rZmCkk/UUJ59nNHBInEhjSSsVcR9KlogiD8M3zLevylz?=
 =?us-ascii?Q?wYa/YUbW2PQGEQHYGvetsFaqlvuSJMGu/xDnhEXs7MhSEdRVNy1rlc/JkI4y?=
 =?us-ascii?Q?WTNJbo6iM4SmV/4muJEKkV4/04uqNHceuJNRasn8fu+gnitkOcBKkB+5P39h?=
 =?us-ascii?Q?RDR4n/MsPwpkXaxfH/VP0ScP/4TPqHDP1ZJj1EVRT5gRulWUpdVU0YfVWmr2?=
 =?us-ascii?Q?RvQ5MRB034RVbYBfuMhduykpehG6yjgcM1e00glx6Uq4nGP+uIP1BeK9Fj0w?=
 =?us-ascii?Q?Jg56Oly6LkCZYu4gwt4lfJDgC5EVbdaONt2MiqXW1BUNVu8z9XREMD2tt0uH?=
 =?us-ascii?Q?CVFSQZ20A60kgMlq/Z9S/vTx+f4siP9LdP1KsxgPEB+o9mnXH9glDfa9c+aV?=
 =?us-ascii?Q?17owstnhcn5WRPAIRN1Uxja1ics0yNo48WIdbZmpCTxSbZnYVlQzg8+w18BX?=
 =?us-ascii?Q?xT8UkclbMVxFt4D6CAkofitB/QWf3Iccb3nkgjGhQ3eFP3BC7++D3M964aNk?=
 =?us-ascii?Q?H+yLDQOZzvkb9JpUaxEkmu9PFYqP5sg1iCfqsZdV/wdxvVBdA6OOoSOtIlg/?=
 =?us-ascii?Q?eCv9lgrYsT2Bsn18gWQg7WGL/kSGkQyBs3Yr7jE5EqWZ/wpvR1DN56cUyFuL?=
 =?us-ascii?Q?1tWppyYTz8xsRfCewvB43E+MyWrCUpQQwyBXxxHujQIWIY2vWa6U3GFjchsx?=
 =?us-ascii?Q?Xl0FLdrXXmCCc/KoYdweC5KUEIlZRSJkFcawvop8oqd1f+kc5DkhnSs491/2?=
 =?us-ascii?Q?Qj3g9glUVnGxzD1S0b9WxT8wA/hmLjuOBLRg2djxyjcl4fKpgjpRHjKrZY8B?=
 =?us-ascii?Q?VYsr0ef4SGE/1kwDTAGmJ4rnmi1yDyR7sm2L1NH2ikH0P17fIlBn7NguXDUx?=
 =?us-ascii?Q?AZyL1XrgKtxDnoqJRiPC4rHcovgDtf7BYrk2Cv1wyy5eXSuJHf/EPIYnO34r?=
 =?us-ascii?Q?UoS7TQ35V4LGdHuU3BbOhemrYYJE4En/jGx3/Fqo7fTZYCDCjCrQpw7F5FFl?=
 =?us-ascii?Q?Eu+G4qxf97fRtDZVuDaVR2U4x3ifnWQcD5GSQrAlO3Ib5jlWZhSYsj9v7hnU?=
 =?us-ascii?Q?AMTaJgJ4ymMAtZjy4vplsaYAMYMPGI/mXaDiltc5tQPVSuh6GU5fqtCL7XwS?=
 =?us-ascii?Q?5pXo4gm2euTLAXDdfKdkjAMtU4dq2TL4CA+3Ir95sI5ml+0zrOLn46nrSaq4?=
 =?us-ascii?Q?BTReVe1DlkK4yP1H4gTnhJYA0Pe1FG/LOJvHjaHj3cpOOhj9mzxQ1k88N9cn?=
 =?us-ascii?Q?KOv3yyzZ06DB8NFI3ADFlgcrDmc1NAkdyhJ+2JMzlwS1SKBdgorz/BTmbnPF?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 537351b9-ff3f-4c13-a8b4-08dba383ff06
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 02:52:31.9285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkxN5jT8dA/vRgc38SlTiUqQDn7tR/4G6H1RD55hGUzCdHeNGHiBoogeA59ETZ3B+57xj9G+8P7+cgp/AEvq8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7674
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



Hello,

kernel test robot noticed "perf-sanity-tests.Parse_sched_tracepoints_fields.fail" on:

commit: 029aadfe946d99c4b11f1dd52f9ff76a09b21f69 ("[RFC PATCH v6 3/5] sched, tracing: reorganize fields of switch event struct")
url: https://github.com/intel-lab-lkp/linux/commits/Ze-Gao/perf-sched-sync-state-char-array-with-the-kernel/20230803-163946
base: https://git.kernel.org/cgit/linux/kernel/git/acme/linux.git perf/core
patch link: https://lore.kernel.org/all/20230803083352.1585-4-zegao@tencent.com/
patch subject: [RFC PATCH v6 3/5] sched, tracing: reorganize fields of switch event struct

in testcase: perf-sanity-tests
version: perf-x86_64-00c7b5f4ddc5-1_20230402
with following parameters:

	perf_compiler: gcc



compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202308231018.8ddf15b7-oliver.sang@intel.com



 14: Roundtrip evsel->name                                           : Ok
 15: Parse sched tracepoints fields                                  : FAILED!
 16: syscalls:sys_enter_openat event fields                          : Ok



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230823/202308231018.8ddf15b7-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

