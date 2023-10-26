Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1DE7D7D37
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344189AbjJZHDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjJZHDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:03:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D7B192
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698303793; x=1729839793;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QTsfqRLgDpzZ1zUsGj+UtuKHxpzkh6VRdAAm+9MrGI8=;
  b=OGwSd+P6dS+fuGMlF/zV6rXsnng2mDuWmzTFwF6tjv+wNY4u898Iptao
   5yHKOmLiX2PW9GdOFYP3JrqjmPjNd9aaMDuphn/JdZol3RaKeFoB0a0Ka
   g3YzmBRAxQZ2YGmcky/O9IEU3IJHWmLLKIuqdg5u2Pn9dDrf31xpbFIHW
   02lbEdcP1r1o4IVbNeBgp2NE1vlWKFUOELw+vvjyi1cGhHX/V645EoRCj
   TgCGyJaVqSFVeZ5GBJ7SrsqanlID4zSAfwDR0ky8fcqmzG3ecoIIGh3WV
   WyMxzrUb/7brMG4Imxs4iq+LIpHcd33MJfhDAtNBBkbK5MqTuG3MA1yZH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="9032894"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="9032894"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 00:03:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="735644816"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="735644816"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 00:03:13 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 00:03:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 00:03:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 00:03:05 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 00:03:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sl6TwKXbyOUc6QgBWXZ2OF+dPuvOkgKasl9im+jCaluJ4hb0vA8flEF+tBnvLdIky42gj1IY7F3Q7ZES0XbS9w0vRKMjwOBlPNiOymGb8360vDLbtI7Za/MDqqSvVPzaFOZz4pmUMu0pDsrlC1tBsCc1YHt+RhmXj6wSo0AZCpuecypM44HBKnnklz/eBJ/c9VSoIXSDj5/ak4tTctcXxTXjbbKrovzaLyIahuqm0vYpEh2aGes8mBmI/C9/xlDubN2hkw4lKquonGrIZgemZGWjhJKMT2Muj84b/+69CrZOYo1jFXq7vHSKcRwJRVr+h6NQ7Fzgh+ySiWr+xZITWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/iO4Av5TIOl5cZTrWRdtmYne6nHq/LpCrIwvnSVY/I=;
 b=CrWnaqCzMVgyWYxOUfEhgk2OCQcqhtyrFohTNHLd7/EGgbrFx66JiKPlkl057sP2RDkHgLe1LXnMms3ASPhyWdFc0E0aRhjo5+EFTLPbSCze+K7M0to57rVmSYgFjBeoeO4rnRWXh18pTsicQC1v6rl19tsjR2OWmStk722oYp2kspF0DQdgjVpWBBA2mka53wtslM3DC4WPDMztZmF3WS9+kvLgS0ZJM44WPthOlqnDGtek4BTIf7SQtk/rPex2tPgocXjTmFHOpXZ+fV87rx0pImH9AYvgmQPFSgnAqDqqecPHxItsvyRahYe1uCbHDWoHQyjdXl1CQGx1nkoZPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DM4PR11MB5344.namprd11.prod.outlook.com (2603:10b6:5:393::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 07:02:57 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%5]) with mapi id 15.20.6907.025; Thu, 26 Oct 2023
 07:02:56 +0000
Date:   Thu, 26 Oct 2023 15:02:42 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Juergen Gross <jgross@suse.com>, Len Brown <len.brown@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-kernel@vger.kernel.org>, Chen Yu <yu.chen.surf@gmail.com>,
        Wendy Wang <wendy.wang@intel.com>
Subject: Re: [RFC PATCH] genirq: Exclude managed irq during irq migration
Message-ID: <ZToPEihOjvttyh5q@chenyu5-mobl2.ccr.corp.intel.com>
References: <20231020072522.557846-1-yu.c.chen@intel.com>
 <87v8au6a98.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87v8au6a98.ffs@tglx>
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|DM4PR11MB5344:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ce0c203-4a05-48d1-71b4-08dbd5f1946c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jMJZrJ/dX8JWvPaxIqwXWh7Q/YCQ0+UrPR31JdpwaCBONzYSpAX7OPwpesx02uiUnuo0NvLqg2TFuxrSZJSGgOo4PdvOSae0pxymQEfmgsyTg9JbAgWp71UinGhz6YhnasHIJeq6Qx1gCLWVnjKW9ngMygjVVUgtAjLfraQnnR9QJdTkIw455tOEOzNy7oPSreqKHQMEj41HNz9mg+xsfJre9iNQbOW68hM91ZO7Y0L9mCeUbUR2ga391/BnoKR7LoirSmimDf6fnLQCq41/m7IC39Xbx/9Vk0jDhgedmhu1ZTie2e7cvUykNEZyN+mq4JgzZKtqAyTkmZpTLILZndEMtclQ5H8R4nJe5MNwJv+Fbw6e2iELdANlyER+K104/9SW/naeqEIw78u2ueL52Uag5zs7aIEU3U6ALLStYibJ+2KR6iv6Igy4HW2Jts/Sg9EKZJB4izid2HPgK44OiKJtRthb9Assg03YrZ1nD7qbF9ZbN2AuMxqo124oHiA2uvH20uMaFZkbTwDtE0sRdjWDPYL5snbBwY0b/uAhZqSE3D0MIblWFHFRGi/d8MhX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6666004)(66556008)(66476007)(54906003)(316002)(6916009)(66946007)(38100700002)(478600001)(6486002)(41300700001)(86362001)(4326008)(8936002)(8676002)(53546011)(6512007)(6506007)(5660300002)(82960400001)(107886003)(4001150100001)(2906002)(83380400001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E2F7APcObg2LF7GC4MZz0lsgvjg84nQVd4aRNX/WmUIex/StE1bwFgE/DUzq?=
 =?us-ascii?Q?HlX8uLjhsHe+hHZPt2PgEElYvN49uKCJqc/rrLosqyPPmepPCCdaCuw5X6JC?=
 =?us-ascii?Q?g2nRVt5UlHPhfhiOICCisEkKdKVij40UD5kHs8XuaGruBmjffDXzg/XFQnFt?=
 =?us-ascii?Q?6mC/LZMYLpXlzztxw/9xvr8aUYxGwS3zJ75UpdLUb1+CE18OGJCz6fwXW8J+?=
 =?us-ascii?Q?N8pW7oZTUb2OFYb5XPDmYBWpvXi38yyXXB6IFYNXjm4JNKBMKFHrV0osyTBF?=
 =?us-ascii?Q?pxm8U9zIlPCO3wcG1+t5tm3NFLf+16P4xQOYrJonH6Bvnt9C4B8xpD4F6vpy?=
 =?us-ascii?Q?Fa4j7tC29Q+HavNHSLF5nBQGp16korgOiybCOM9Yc+z/E5fML/cSU9HZbpGT?=
 =?us-ascii?Q?nTRu2Pey0i66hQRbJLRL9d1IPAR5mmyJ+eUg5yVYMUrauQGohtfC5YFfna8Y?=
 =?us-ascii?Q?DjhfbPfK+fCNjqh+HK8GPRAuyNascvZmjTMNBt95jnEiUnvtwI2aKEpqLVZo?=
 =?us-ascii?Q?oOItE6SaDW1PhXhhDed5xm6nsT8rCUSgAFRuhE40KD2f9Opz6ZD5zb3zsOEB?=
 =?us-ascii?Q?s8jtFprnhC2YWJ9vGvOT+W7bl+q137DR1grrqN2x9vQQWIe05NwNB7NoV4S4?=
 =?us-ascii?Q?9M8GjdBe99gGcEb0rTnxBHAEbZfRnwxQG8e/Hd5BeI3POG1FK3i/VKfb1oW6?=
 =?us-ascii?Q?f7Auq+23C8aSqdTbSdiNBi3qK7Kky4f4Vk/NmVE/3exJ3tdtsqzqg950adsB?=
 =?us-ascii?Q?pzJbqGsv0RAqirdyow8jSZY+vGNHyeNOCFGTv7P9p5/JUOBiJWyX5Jvt2IqR?=
 =?us-ascii?Q?G7lLMV2VWL1N9yaRopHoY0zeZNXsER/0J/LwDAzLw5Rmm/u0NRltMI1v9b8R?=
 =?us-ascii?Q?JsAZhGKst154klpLIJ4Nm9d+uWIt04a7HNYnBq4cLdwPgAixrZT93BwtjAdC?=
 =?us-ascii?Q?nARVt36F3PE0Ck9CNywKI8fmqGFfH/UD0Lf+EoFXH4+P6ujnRMik2ohqDlGr?=
 =?us-ascii?Q?BoZYHC8KbOtlZ5fyl1bqdaAb5ujeLqqO4tP0iKFrDr0Bc/r0fF9b2Rrxy1IS?=
 =?us-ascii?Q?7h5VdANkKEKUcnranHgOSrltWfMvRJNlMDF+3+wx6k6kXlYJPUXrfTBooH+G?=
 =?us-ascii?Q?C8BVoJqCet06AEWKGGGVrhmaI4sSJnNgvBt9lI6rGEzNPm+K13uSo22FBvLI?=
 =?us-ascii?Q?YffFxPAKA7o4HRNNQwpehMYByLMjDB1OInc9yEUYv9mKpiNRgVmrchDWpLxt?=
 =?us-ascii?Q?QszMuFBbxRLgaR3OmATvpetY0V4UL063FhdDkY3fyDSnoDmMHzvHhuy3Yajz?=
 =?us-ascii?Q?OwupWMb6AIhPIGHJltE15yw/dEJy0jhBFC/N5/m6dQrP1Po9hEFQTf2nk2LD?=
 =?us-ascii?Q?G790aY2ELEZY0nBl9qx0iJFVTspCklKV2CXvmLl5b/nZV1N0+gCS8r4cfQGC?=
 =?us-ascii?Q?Kqzg66Mp/g0uK00UguKNH0zEj7Fem6z3nt3b24JAcRHUjC5EKFG2ThrFDkcM?=
 =?us-ascii?Q?J8oDZ0KHj0CIwSXMN2+slqfkPmabEHoeebdI0OAo2P6a9ZZFFtgIKR8oSueq?=
 =?us-ascii?Q?9wGpsQK83Prj7v2R9Q9nuO8RtFRi2ud5uPmSgYWL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce0c203-4a05-48d1-71b4-08dbd5f1946c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 07:02:56.1181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2tTq5bM5uIfdr8XI7tm8r+c8YvEVClRbhjvGmCLEb9yuy/Yn5VkKO+9L443pS/gZclolv55q9s+cSS3nMicShg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5344
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 2023-10-25 at 16:34:59 +0200, Thomas Gleixner wrote:
> Chen!
> 
> On Fri, Oct 20 2023 at 15:25, Chen Yu wrote:
> > The managed IRQ will be shutdown and not be migrated to
> 
> Please write out interrupts in change logs, this is not twitter.
> 
> > other CPUs during CPU offline. Later when the CPU is online,
> > the managed IRQ will be re-enabled on this CPU. The managed
> > IRQ can be used to reduce the IRQ migration during CPU hotplug.
> >
> > Before putting the CPU offline, the number of the already allocated
> > IRQs on this offlining CPU will be compared to the total number
> 
> The usage of IRQs and vectors is slightly confusing all over the
> place.
> 
> > of available IRQ vectors on the remaining online CPUs. If there is
> > not enough slot for these IRQs to be migrated to, the CPU offline
> > will be terminated. However, currently the code treats the managed
> > IRQ as migratable, which is not true, and brings false negative
> > during CPU hotplug and hibernation stress test.
> 
> Your assumption that managed interrupts cannot be migrated is only
> correct when the managed interrupts affinity mask has exactly one online
> target CPU. Otherwise the interrupt is migrated to one of the other
> online CPUs in the affinity mask.
> 
> Though that does not affect the migrateability calculation because in
> case that a managed interrupt has an affinity mask with more than one
> target CPU set, the vectors on the currently not targeted CPUs are
> already reserved and accounted for in matrix->global_available. IOW,
> migrateability for such managed interrupts is already guaranteed.
>

Got it, the percpu cm->managed has been pre-reserved already and is
excluded from m->global_available. So we still should substract the
number of allocated managed interrupts to avoid duplicated calculation.
 
> I'll amend the changelog to make this clear.
> 

Thanks for helping on this.

thanks,
Chenyu
