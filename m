Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5462F78AEB5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 13:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjH1LWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 07:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjH1LWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:22:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54407B6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 04:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693221739; x=1724757739;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Il7SOEY+8AyykpIg+PLczyuvJZpR54zcd+NqFwBWJDk=;
  b=Adk9puHlGD8KqZUoiYZ7x73AMJVNOuQF1JQr24o4LwpQ5guv9GdyfKly
   L+/UJHYIdYkbxT+WhWD2PubgbViaha2wT6EBviDy8YUMHfJIuh6pvMiR5
   s1fmUNiBTtfEbmPYzFPXryen5DV4C3RG2ZPLGh6XL5LGDdVyr98LN9nYX
   K14lE37nw9veCEWx9oU00EUaC2KyQXCkCS4hfF1OWzt6bajaE8bhxY43k
   5OitG2zchEZsxHGpjjOd4sawBHKtaRDxLQ6th9tdaSpR9lP1FkDbOUTvU
   EXCOoErowXobPR7YKUHrW7TOZ/z3yRNVViboiPmP0gzgJHOIJ0wLRjhIV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="375045439"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="375045439"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 04:22:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="912018954"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="912018954"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 28 Aug 2023 04:22:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 04:22:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 28 Aug 2023 04:22:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 28 Aug 2023 04:22:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAjT68kzFb22bRtQxbxq6a2sZC+0qZFMO5cgYIpcPmvPZPHKn5jlDhdDbmkfwO7UlhOqdwGiRi2uWkRJs5VeB0thhAsyiU2U3P3A4ac9KLbcDQ+OAjK8bq/mfLTQ78H4oIDXDS2JEREJhEz4Jn4YCpzKeWE0Q3MYXzpSgJJRUsQDhulYYD9vJf7TRAIM3ysjHtVUQCVKvUedTS0rtqh+eKjhq9dKwv01kzgzWVW02IYxamn8eLqh5PQHBIj/Ppq7jSbMUDMKV5jTgX/rhasOCA9oQTkOOiCtkLwWA5AO1eSJ6QOfIexBrhIkBDK6EaczThuCggO4LJcHl2OTjb5Y2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u30ITxRj9n+yDwug+JwSQ6Jmh0wCMy4Isqsa9DJ/VKE=;
 b=JpWAJ0JzSS6AMAOpGqTK/CX93Vcnv5ObHQiY7MnQMzeoUdlcUP7mEckDhqCGByb75cKezCKur6XeSEqJbjfE3ot9XLb+OkrtyMxhJ4r6Q8MfxhBYcrT5r+PbjXlmz0CqjktIY/YQxW27UDUmBe2BEEKCk4LvzwbbRtwarkeDxtwQbVwyJRB9eStHOVdFXst3OcEXoMeBhw9rJ/VBbc2Zs4xfHkymeYMmrVQpwAqnqmmchqe5tuPwHXDYqx+EaAwufJDEio2QilSEQjY0EBaUVCVpcNUdCdx2kEB8pDx0VsS5tN9XyIjyuIhtcco2E+EQRKmp3NblwrSEgH/OWfuhuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SA3PR11MB7414.namprd11.prod.outlook.com (2603:10b6:806:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 11:22:12 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9a8d:9d34:4af2:f2e5]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9a8d:9d34:4af2:f2e5%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 11:22:12 +0000
Date:   Mon, 28 Aug 2023 19:22:01 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Swapnil Sapkal <Swapnil.Sapkal@amd.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Waiman Long <longman@redhat.com>,
        Deng Pan <pan.deng@intel.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        David Vernet <void@manifault.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/1] Reduce cost of accessing tg->load_avg
Message-ID: <20230828112201.GB504382@ziqianlu-dell>
References: <20230823060832.454842-1-aaron.lu@intel.com>
 <20e21145-4fef-33b5-f41c-5bfd66a0281e@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20e21145-4fef-33b5-f41c-5bfd66a0281e@amd.com>
X-ClientProxiedBy: SGXP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::33)
 To BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|SA3PR11MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 37777880-33db-4c96-983d-08dba7b9068f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fj/eBUzIWsC7C3SDlZp6dJc38t9wX2U//g9nXzCdWpYx35t9DOTGFbe9SjARdIfqBaRm45Sd/ptHseJ6bv4jLAYhldG0ViaFsxnWfgrRJZVVSZ9SEW5OeWN4gQTzAw8oWtG6mYM12fqK39WZ3QI5Jhq4a5ERj4EWHwx9CPYlobfSwHB0iY+70M5b0ENqn9Roa//TVSM4QMBz+FKInOVHr0fJCoexLteGFNZLhhKaxK1h49huRNEimIZskZx4itaEMORt1C3VWZLy1WFkO6FDbVuJsyjRRO1QlHOECuA71zBXPhepj6uhFFS15jLK6Ac/ykySEGFgyy/n9wCHfMf2PLpQsTOdB0r6zCa+sJdO1BT/EBhIH3n5syIa2BuxHd1FT7I8/E0QlmW5HgF4hqlOuC8RJQYZFBuJDXZ92S9yiWUCC9TO+guG/DWxZKO7JiIz6Edt/DFCao/lLj1v7/jV3+0D9G92jrq9oygD5Nqo2NBB92rv5MXzUTPUOOQfagjxIO7btrtKitdte7AFw+hSXV2x6qAXbQ8sdpoNXuI2NIo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(366004)(396003)(39860400002)(376002)(186009)(1800799009)(451199024)(41300700001)(7416002)(33716001)(38100700002)(6666004)(86362001)(966005)(82960400001)(478600001)(83380400001)(26005)(9686003)(1076003)(6512007)(53546011)(6486002)(6506007)(5660300002)(66946007)(6916009)(54906003)(316002)(2906002)(66476007)(66556008)(33656002)(8676002)(4326008)(8936002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XQ7/cuEaPkjKgBPIY8RssFDtsoGYOk/lfc7FOy+RzR3JUBO4RMOy6hxQnOLf?=
 =?us-ascii?Q?mPL/6vRkNn72M6SeJyEnkC9Wxfus17uTMRhCbEE/hGC/UGEQUZ3a+nFjBUSS?=
 =?us-ascii?Q?JvKQ7lOySaUuC6z4WgJRVcdfL5YXUsglKdpUN+k/BliffHLAqtA66mIWBIRO?=
 =?us-ascii?Q?/QcnmzvWQJIGG7liotJbAAiywA2HZOgWMr9AGPvjyvKTB80zn87ScpQvbgoW?=
 =?us-ascii?Q?AMqNdvv/bo5mXWqAWF4FyNeOZsPXpNaxNWYHeZEadQgh3gcHd2gaf2l7QimK?=
 =?us-ascii?Q?oULfsFAIad/Ln22UbhBq4dZxv1pWkzm75njyx7OovN8LvwXehY4o/vwUYJr/?=
 =?us-ascii?Q?oGyJtxYyta3o8fxWId4/ffCKA+G45IWYCRykC4nesa0pzE3fWYiPgwGgtYII?=
 =?us-ascii?Q?kVLgVIL8ID2H04gIcVQF2gwSanYxS36XrBZ/K+jydier2HrKhJghYJIu6Jv4?=
 =?us-ascii?Q?3A/zIwySg1k59gD/XMC0JBkHwLTQY3bzBbIqJc2WaGAYz3Sd6YxmXfXvKodL?=
 =?us-ascii?Q?nRP5KwY8qWmWahZS96QJ4Y/2yEhB8/wnGS2u/in+9hxpHQ6NZ5JiHHZ/7oLb?=
 =?us-ascii?Q?q5jBICso6/6BcrmMjBN2vaEJmmlrsSZy3yo2NoiKpY+9F7joBJpyvT4nUIZ8?=
 =?us-ascii?Q?Q187I5Q/0clT6z5CTsw1dt52uNsMc61AVgQgKDFdP3kGwIDXkOHulCMtTD3H?=
 =?us-ascii?Q?UM1BuYYMawH1ehMxc9BtMsRx6GnQWPwVq8GY1J3WexXjvegyMESfXwSBFI1n?=
 =?us-ascii?Q?WtL3n0sNCXltk2oyRfip5w7Ti0lIgm8lYRx/dypLI5ayuYFG/pVZo88QNc9y?=
 =?us-ascii?Q?ZxNxJCS39MtZSuzTf56Ew3bD3RQhQzFuJbb5Irs942VKn7zCj3ad/BkGsHBl?=
 =?us-ascii?Q?zSVbtsAiNsc1tkLqnQ5IAtfwjEFmeNEc6umOW+yi8pUW65Epj1jH5x8W8jxu?=
 =?us-ascii?Q?LPlGtAmVoeWsb0pBqXFax1fwJVB2KIVSwCgcBPkwNu4Xm/6wxA2kqEQmBx2J?=
 =?us-ascii?Q?D2pcTKAgLh7hjYr2rVepp0aFnTZaogJvgxu/SecwwZiAVEfiA/Piz8BwBPK8?=
 =?us-ascii?Q?9tputbwyFiTY53DLj3OxShX69HoObIrM0nV/xTi1GxTb54k+S/LeJZZnxtqR?=
 =?us-ascii?Q?Hpul0vBzCJoCmJjGmVXaFCNteF+a0nHaw2a23S6FQuaWERbS/ISoxY8rGis4?=
 =?us-ascii?Q?2BEQ/P8ngi7Dk+OlMcgbRMBNw2Bp+qqc4B9cO36xQwm6A7mqaMZYMdiaIZKo?=
 =?us-ascii?Q?gFxuvThEKItinPu5th3eIj8xCYk+UxjBUt/lWqO6n5Q5XLv/RBcLizUbSEn4?=
 =?us-ascii?Q?OyC8FYRrHumLJBOBnWXPR3ddkrjn6Veb6PHQu9ssqTLzhI8bvrydke2vsjQi?=
 =?us-ascii?Q?Hiz2BL6ACz7nDeqY42kEdbh/d6PZLJSNVHF6RdZgwHEhFac/DAftT3E9j830?=
 =?us-ascii?Q?XVt5vHghAaRJSuJvr/tVTD8N0imf50Hc/2W3JKw70encZ6q8NpQ2McMpvdEE?=
 =?us-ascii?Q?P4coPxO4hTTA2/VJT9aMdEHMV3N3dvagHCAF7eQa8aXD/vwIWk7a/u4EpokT?=
 =?us-ascii?Q?8kWPEZD8NwhgygULhfwB0NTTNFFJUqlks3rexUuw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 37777880-33db-4c96-983d-08dba7b9068f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 11:22:12.5487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPnp4Iyr0WCYG8TyQBPXN6vo8wM7jPUBweBCVkLm3RK0KLKRyJOUwQx4TEj6hqJXRVpR1t1MHdJByl3WWLDN/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7414
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

Hi Swapnil,

On Fri, Aug 25, 2023 at 04:03:20PM +0530, Swapnil Sapkal wrote:
> Hello Aaron,
> 
> On 8/23/2023 11:38 AM, Aaron Lu wrote:
> > RFC v2 -> v1:
> > - drop RFC;
> > - move cfs_rq->last_update_tg_load_avg before cfs_rq->tg_load_avg_contrib;
> > - add Vincent's reviewed-by tag.
> > 
> > RFC v2:
> > Nitin Tekchandani noticed some scheduler functions have high cost
> > according to perf/cycles while running postgres_sysbench workload.
> > I perf/annotated the high cost functions: update_cfs_group() and
> > update_load_avg() and found the costs were ~90% due to accessing to
> > tg->load_avg. This series is an attempt to reduce the overhead of
> > the two functions.
> > Thanks to Vincent's suggestion from v1, this revision used a simpler way
> > to solve the overhead problem by limiting updates to tg->load_avg to at
> > most once per ms. Benchmark shows that it has good results and with the
> > rate limit in place, other optimizations in v1 don't improve performance
> > further so they are dropped from this revision.
> > 
> 
> I have tested this series alongside Mathieu's changes. You can find the
> report here: https://lore.kernel.org/all/f6dc1652-bc39-0b12-4b6b-29a2f9cd8484@amd.com/
> 
> Tested-by: Swapnil Sapkal <Swapnil.Sapkal@amd.com>

Thanks a lot for running these workloads and share the results, will
include your tag when sending the next version.

Regards,
Aaron

> > Aaron Lu (1):
> >    sched/fair: ratelimit update to tg->load_avg
> > 
> >   kernel/sched/fair.c  | 13 ++++++++++++-
> >   kernel/sched/sched.h |  1 +
> >   2 files changed, 13 insertions(+), 1 deletion(-)
> > 
> --
> Thanks and Regards,
> Swapnil
