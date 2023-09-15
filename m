Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B076C7A1533
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 07:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjIOFPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 01:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjIOFPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 01:15:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F3E269D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 22:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694754899; x=1726290899;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=psSnDzZdZuC4o9JlVLc9VSwt9rrap0OIKCkDQF5tfJo=;
  b=g1cTDcuBBEuC+RVL5LBuJWJi5ypcR4N6mzK/JxsuZ0B3CqCianwgYIeE
   SI5z2Rv1SUwwd+QlW+ydx1TgCaR2TSt0sjAym3wMCr13kcQgEwXYJKhUW
   0aGE3GxTU/ibRJ82p/ZXO4UVkGpnLtnbCD4m+zlhCzPaCzj3JqWyHAcKo
   1cCrEpBPvE0B2tcwM7rAXq5/hrSVNQ+l25i/k8l6GVd1htdTbRfKvo9C5
   UJa/7nQK840NnZfkT2wDGoz/eFfu4kVSIouTks/C4YUqfh9SliGtroGoK
   m7RQvVRPWDT5Fy5Kah88Jx6l6enTz0m+cMVuwzoxoywer9EKJneRvLxX5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="443223767"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="443223767"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 22:14:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="779945929"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="779945929"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 22:14:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 22:14:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 22:14:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 22:14:58 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 22:14:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEE5edgtRwDUT89U9vOnEreluyW/NvZA3Lpvlikcx+o9wpowX9Z3gCZCmRgAeFq12/PzDtG+5conY7LH1glpTwLJ3czIZtdZAn1JbupDeqagv48rupFcPHUoXQlCrLm5DqYJY0I7m7Q29UwwY2PiKryGLeK8erJmJCOtKkSWRPoRQ+mkbkmcVVcy6HdiQOAZBclpZdSAdHDaCjhLGaIyZmVeuf3ccdcdpLGfuAFpzllqQFQyXcG5/Ff/BAnsBr5yEEh9zepL+v+/ouBooe/VbXfB+u+KL5z8qtixzI3mDSPyfx+f+X5ZL1l01uvUKOceOd3jVIQjVA2xFJPD20hMmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFrOuQQ7Wqzzr0afGC5etIYPCQ+i0DHxiUiv/i2tJrA=;
 b=RIL/xY/1x9xNrg7ntpenCFItzSRKnSyi0kzSgGG+9NRtohQEsUTIu+KVnAcPq4uDVboqgIsrQ3ygAN4XIwU3Z39TTfmy7gwl1uRKDhD18X36wxD3eWVYFqQkOc+v6TdqCzJgR/SzPhwSRltQBhcqCMpiKTPngGiPEMwoCmFKi4E9TRnHnfq611D7a9iQkT31S3mw4JIJoGF3jWmVEs9Ifg3mjhZo+CMMQeFmVusIN38v7S9Cet17RxxD6cU+A7cMZ7hoTnXH9H61AB7+KgWi+bt3DijzYuZAaS41QUpc6V5u8AgXd0lRNxijUbgiud+XQ2dZgnjsae5jNjD3YzJrZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DM4PR11MB5566.namprd11.prod.outlook.com (2603:10b6:5:39c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 05:14:56 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::488d:7cde:d174:b775]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::488d:7cde:d174:b775%7]) with mapi id 15.20.6745.030; Fri, 15 Sep 2023
 05:14:56 +0000
Date:   Fri, 15 Sep 2023 13:05:25 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Lameter, Christopher" <cl@os.amperecomputing.com>
CC:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC Patch 3/3] mm/slub: setup maxim per-node partial according
 to cpu numbers
Message-ID: <ZQPmFcmaRSrbK45H@feng-clx>
References: <20230905141348.32946-1-feng.tang@intel.com>
 <20230905141348.32946-4-feng.tang@intel.com>
 <CAB=+i9RWVvUb5LyoTpzZ0XXWoSNxbKJuA6fynvOd4U+P5q+uaA@mail.gmail.com>
 <ZQKwu3TrorCvgH9b@feng-clx>
 <21a0ba8b-bf05-0799-7c78-2a35f8c8d52a@os.amperecomputing.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <21a0ba8b-bf05-0799-7c78-2a35f8c8d52a@os.amperecomputing.com>
X-ClientProxiedBy: SG2PR06CA0244.apcprd06.prod.outlook.com
 (2603:1096:4:ac::28) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DM4PR11MB5566:EE_
X-MS-Office365-Filtering-Correlation-Id: 995f7ec5-c844-421b-a01c-08dbb5aab35c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kWrhxSMo3TAlvZ8Wb+6luQMqtQ3MmvgtjUpGxOkBPUGoE3dr3TGNprzypGU+IEkLHcRAdhgxu6KXqXzmD0SwAKuUHGijJMC75ZNpKNp5TQ9xF8C7+6jNXXKS5nLPQ9Poks3OEfncfeAIPTr7aKbvHc8+AlZX/4JoE/HyFroyIZ+LVRNvhjSj5feV457MEPwRPmcXoVngRic5wvuuaEthaWzTe7QrwU6zP27DuFY0llfPFG23m+4RBRMU2AIg22iqH8p985OlUfnJVgCMi5A4818FB0skXsWUtPpgbvMI7iR/msGZiNIjhayM+uWsMhEQqSH3OZMHt6Yn1YCvwDfH/mKeeAOqOnvoEtFFccuW2FKt+luKvgDI/HjU48s3lUqLqKgixkabWEu3uVBIsBgLKbrbD+xeE9SCq5Qx2np/Sa5/YFvZsj4pQfmXnhmvPp0SVWRU9gma/fGLC7ufhWm1SJPbBazHNuJ18pF4thvu89evt0kMoojx3a+OU1ip0rxzWN+RoAGznJ1j48qDIv8Ss6Ju0T62eatbOydCWUNxVUS5fS/npE3uo6L41txxR90w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(396003)(366004)(39860400002)(376002)(186009)(451199024)(1800799009)(44832011)(4744005)(26005)(7416002)(41300700001)(6916009)(316002)(66476007)(54906003)(66946007)(66556008)(2906002)(478600001)(5660300002)(4326008)(8676002)(8936002)(6486002)(6666004)(6506007)(9686003)(6512007)(83380400001)(33716001)(38100700002)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oNgA1XJBD3Yk4hdUqvJH1CqKJV/1o3xC+/fmdadH8M662yf00E83MvwUQMrV?=
 =?us-ascii?Q?Q0lkSPQp5fbFtTf4chOCnY38twLuLTDu+F0lLj1iSUvE78DXi17LTZkQ+cSC?=
 =?us-ascii?Q?wseZCYfKb+jo4gm+QzNGPDV5A4CcHopZC4Vyhj0bk1mdFUjPDIMJysoHagRi?=
 =?us-ascii?Q?0FVmEK2F1VhY1r/KZSVnuaw2NlvX8gJr/XLivXwQDxUPhC0/jbbhk6IQ4aqe?=
 =?us-ascii?Q?TtpGSmJWnc81+DVBYkq7ZOMkWnuYS5FWzMFvYcgQN+nAdXbrEUXPTBWQlc9q?=
 =?us-ascii?Q?DruT2fQM/CXBaWGJdxhDOaHQvccwMVpkpQRqsuFrUhwXaNqoFpYoEPWXFKuX?=
 =?us-ascii?Q?CcDU2RLx/6Ui9VGVoOguqZr8yoCWT6Uq36D5oXet7TbSAh0z/VXXCSBgPvdW?=
 =?us-ascii?Q?3WxcQ0Z3KDn6q1ZROiKHska6CfnWZY1q8Y1Q1IKmnCypu5YgMhCkoLMr/yau?=
 =?us-ascii?Q?T66CXEZv5fBx3TARMBxE1IUO1x6+wvEAE3OUB9IAZ7bET+lxXaVO+O8DdPwK?=
 =?us-ascii?Q?k4p8sF1kKAPhN166sMqv5sbbU97CFEDQOjhYDAq8ryjsyit0wnIng48RhLng?=
 =?us-ascii?Q?4z2Jtks568UHL3BSiiRByY9yDCgPQg7zOVC5a2bCrXaTpvPyIKrnqVnlk6Ys?=
 =?us-ascii?Q?ZOEPlZvmzjBwjiuQKLP/W6Z+mz1ro/mITMsfM9q5OO9cDSHoKzjrbVYWlXph?=
 =?us-ascii?Q?yyfdQYHXfx857mWRyqfDkqkRhZRLIz+BfTPPAU6st3k3zC9K8FUc+SYLVf5l?=
 =?us-ascii?Q?aJDsbZIpyLPZ8Ifqi1twXmotILoJZ0er/UaD6T+uDF1tWzNiTn3CiV3Yon3E?=
 =?us-ascii?Q?saQ7zt7fSgQSaBXiG5dG+PEE62xRIR6nw3pTH6edasS+69AVl8OYJk6inWKl?=
 =?us-ascii?Q?PnpCAhuGFCGOjR61j+c8pP5or51nFARw6qoMF8prmySXWWKTYUmtXOvnqrm7?=
 =?us-ascii?Q?drGj/0iXmpuX9OJXm774WcxsVS/zR5dIJSXI2w8P5MxY9cbfLdihygE+EHZS?=
 =?us-ascii?Q?X3Ay9TBjxklyV2/Ph3et1hV9SGmUNsyaS+4ttSuUsbahTMvDDs3W1VRRoCwl?=
 =?us-ascii?Q?3n8LO/HkkLk3g8ydQQJTH2+AVaVw+5W0HxHDTNXDDCMbiiidFKIcxsnqgU26?=
 =?us-ascii?Q?guqSPDWWaAmUUpjlZPBYPWKzipchPWtPqXgHKS+SvVca34dBDr8ewENIO/Vu?=
 =?us-ascii?Q?d5/B7pWFOBrDAgK8O7AuqxwBLnb5BGfaM6G8v0pSmX4oFC0tbx+MSctdbnYe?=
 =?us-ascii?Q?ubN8Z01qmpOhUVFMtS/WKJyj5qTEhoz84ApIppYTCxyUI24tCUEG0rMOawLU?=
 =?us-ascii?Q?qGBr0lkygeH/LOh7qR7uG/9WSyhMdfGEfSOjgs7X83kdSfre3hWHDKT1Aqyv?=
 =?us-ascii?Q?NGqellbYmodAznmL9w6Z0PwuDayOjQYulMXbx28NeWvPruvJLhjzX4unYxxD?=
 =?us-ascii?Q?bKcfVTIeUCsbA4BMOeRwvpHwarF8izbCJkH+bQnDEQqmQHfGZbPmdgjRLgUC?=
 =?us-ascii?Q?fSGe9SeFOogliS36TzOpcqfZl/eaC3J7UJ+PlYI93/NyvpMQgFXuW0jSFzZC?=
 =?us-ascii?Q?EHIeAb8iGgnXiT+tER2qlCbfRC30Z+ILvilvEBKD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 995f7ec5-c844-421b-a01c-08dbb5aab35c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 05:14:56.2687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PERWKyJDwpkWM2nIdh5isc6kI1hO6gCFtRKigykZa4EUePxTob03o5PNnEJOTy5+mGYwlXfzhv/Wqj5f7wYQuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5566
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 07:40:22PM -0700, Lameter, Christopher wrote:
> On Thu, 14 Sep 2023, Feng Tang wrote:
> 
> > One reason I wanted to revisit the MIN_PARTIAL is, it was changed from
> > 2 to 5 in 2007 by Christoph, in commit 76be895001f2 ("SLUB: Improve
> > hackbench speed"), the system has been much huger since then.
> > Currently while a per-cpu partial can already have 5 or more slabs,
> > the limit for a node with possible 100+ CPU could be reconsidered.
> 
> Well the trick that I keep using in large systems with lots of memory is to
> use huge page sized page allocation. The applications on those already are
> using the same page size. Doing so usually removes a lot of overhead and
> speeds up things significantly.
> 
> Try booting with "slab_min_order=9"

Thanks for sharing the trick! I tried and it works here. But this is
kind of extreme and fit for some special use case, and these patches
try to be useful for generic usage.

Thanks,
Feng
