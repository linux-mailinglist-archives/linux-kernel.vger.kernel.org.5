Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382927ADCCF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjIYQMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbjIYQMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:12:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD24EE;
        Mon, 25 Sep 2023 09:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695658324; x=1727194324;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/rYLGEboSDAFJ+J5dNCwt0Ui2b72bADJ129wYQvcBNE=;
  b=c2TYYA+T4rbT1UbBUC5lxVFvg3YtC2vehwNR88v5gfKuPq0YswHzbz+f
   tG7qk07CSoZLeYPYoOphyW17Drfz3YmFvr+mDg/b9n2Amzgkgypkf8Gzn
   Z54Eyv8iYrk6kBMiKP4RUpCGoxeoMoQP31i3iIFIfciIx/3mhSuSAGlRJ
   Qdedh/tlcG+A6VQ6R8fzTvFamIL4Qk7PryOH0NDTM5PUyC7/8lXjBkzrY
   Q5hpgRr/WQ3IUcon2gY0zreE6oYJBpBCDQzGLXgP4NJDp+AVqok6SQP5v
   DZ8kcIUdXUpW5nk39TXmW5YCpFJBOwKf/g96I0dG7Kij10J9oQO6CV34Z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="380162970"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="380162970"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 09:11:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="1079265717"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="1079265717"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 09:11:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 09:11:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 09:11:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 09:11:52 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 09:11:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyVPNYUOTlTu0/Afrhs5fm5pjWUrU9ymQ0C4a1qQjxw0W6HoHcS7vdU4UVLLBFgkMOfd7vKbX0/mAJA0qZTQ182QyMy5CUfkL+uo/NErzobeq2w5cnnMiLAvY4TkIjciLFb9+fyVtrHKiIod6lnABaZjZAcoC7yReM4Jg/XI5Qz2vaTn2VyZG42XFBIysvdykmIoK9YBE3rL2VyTkXL/g4WUBVOfr5jis0KV1iOemUAqtR8ZJ+Cz536XsiTWYD9wz/9l5j4/ZQ02EnpPrEg62pM4iyoEsmjwPlvDsacINQbF7JHWDaZKy9FYsjDoMmdy2g/gtiFZd6Bk5gu09zdG1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTnhXh4MZYbJW3OpsMCRA+ZG/lnppif3xn4H2eqgPSI=;
 b=S8A9frC6eVB17coL1Ix4kb5Pq2NpiByImvAiEpzDZptBrTMn0d8T7Norr01fvBFRKGEfPnBBxvDA2P3vvOvS4lSm1VbxPi7pHVfTddcnRunQYSMRp8vIlIzges0yIDjo9pLtt0vwzejkRZK8Cs1ngImHgO0lRFCaDC6F5ll5eW/Q4f8S+EkfazIS3VnCh/0lqXICK4G3w/uZVxWDUiv2BaGDVvst7Q+dAjgJnprx/5lMjimSgWpHKTcZbJu4rdryJOesksRsvfMtuh4yESwt71hb7BNyV3AzGNVhwLk9wOi/ssayj8kKgNegkVWso9mXHpcQK2AIg6ytNWfmmVQ2tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6537.namprd11.prod.outlook.com (2603:10b6:208:3a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Mon, 25 Sep
 2023 16:11:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6792.026; Mon, 25 Sep 2023
 16:11:49 +0000
Date:   Mon, 25 Sep 2023 09:11:44 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Michal Wilczynski <michal.wilczynski@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <rafael.j.wysocki@intel.com>,
        <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <rui.zhang@intel.com>
Subject: Re: [PATCH v1 9/9] ACPI: NFIT: Don't use KBUILD_MODNAME for driver
 name
Message-ID: <6511b140c87aa_acca294d8@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230925144842.586829-1-michal.wilczynski@intel.com>
 <20230925144842.586829-10-michal.wilczynski@intel.com>
 <ZRGrk8/0UMd9FuFH@smile.fi.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZRGrk8/0UMd9FuFH@smile.fi.intel.com>
X-ClientProxiedBy: MW4P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 0edd7a76-301c-456a-3ad9-08dbbde21f35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZOE5jr/wwOyLLRp2xPl28QASJ8g5vLe58flziEjzVvcYd+AgbMI5nKJXNcDtSQny4AfD+a9aiZlHpNSMABkyJxqF9fO4Qen0Oep8ZF4ZjlcwT5UvKBRjOqOU2GP2scvcIw8tQ10BcMHipNSN6/mS058DuUXO4/Q7ajLU8DfDbQXT20Xb/qOKiXNr8YKqUpXbAXkgJ97dEPDXQvkMlzjytlvW6U6u36tZQEskrh4VoWh2mfu2jPxJBG0f1hs0+4oFR/tjLA2GVbxi9Mo3xzigUwbW3R708bCNiosCZsBy3Fq41eJjqoAbSpDCLHHRGglLnk7RmAUHYiwMUIq7VknZK9+Jwg2n27xO4+dKi6e8B9BxNtxgcc+Hqo4/EMjv3z1zHl/8jYLKLtmTkTsuqFn8w6z3pCiE8tYts9cv831b/84vXyAHhEk0ilDj1Lf78u+Pi3ochf+Dq7kA7fu0TN11YfpXA+bPZGLuys8d88fntuiNnzdntg9bIHpZgzatuhcr26w5w1si0RpgyLzjpR/M8Obv/7t1ZykhBhtkEohYUOC2lLNxU7ReipvHKaYeEUrd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(230922051799003)(451199024)(186009)(1800799009)(6506007)(26005)(6666004)(6486002)(82960400001)(4744005)(38100700002)(86362001)(107886003)(2906002)(6512007)(9686003)(4326008)(478600001)(8676002)(83380400001)(6636002)(66946007)(110136005)(41300700001)(66476007)(8936002)(5660300002)(316002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m2eWm4ThU4j99qKLg5L56tos+kHSB08keOf8BkqblRYhrvewnwNHLvPhKqzO?=
 =?us-ascii?Q?Sgmg0hK3ZJY1hc5lLUWn/MW2vZ5lQWlpSsn16Z36BtRe73kZ+S5CPozQerR3?=
 =?us-ascii?Q?3ZpAkNuWW/0aZ3hwKfxFVeO33748+Sg46708bmR6wBUJ3uhABMclIykHLlbu?=
 =?us-ascii?Q?UaC5bxTt6g5g/aRaPFHw7AhEM5AMwHzIGA2aUHkxQfhlYUQsVL32YAdCQonB?=
 =?us-ascii?Q?3PWGYtJ7JHObMe+sjDO+rw582tdf98PC5ZDroXXACNvuX4Enlg2eLbWrlbEi?=
 =?us-ascii?Q?67q/HHXL/vMQKewo0IDu+688Wx6wG/RgQSabL/jaBYxQJHr2ime2EgCXmOof?=
 =?us-ascii?Q?8cNjG5k6Nqk1I3bQChqOYL98bPevcwRReXi+a2os8HEzfq/bPPTrusfwq+VA?=
 =?us-ascii?Q?Pf5c6QXkNyMuhtGE8fDV0VszVIaE6UUiQUHoO0zNNt4WcWLuPvwoOK3D65+8?=
 =?us-ascii?Q?sNywGIeuk465CpJRyZN9oBSOQHva2Vt2ZRzxnNKWnCxuTyRwO+qwV+94o3xz?=
 =?us-ascii?Q?NdaW6EdBS3YP3w3vMR23PulbnEyLnQgNdjV9IUeo60/E9ulnpCMGH/0O3mlp?=
 =?us-ascii?Q?lZ3rAuDHiomnJG7EUzJCUY3XAuWLnbkcXbwLjKPnSwYUSUCEE2hIUpAQrn9U?=
 =?us-ascii?Q?iP4dwbAGPz6FIa5nClZAlhqnxDjlxULniShIzbri2PuFiMBn01C5JnVslhGR?=
 =?us-ascii?Q?g7JqM61FF882LI0s1b+9U2reeCrf3QFkrXd6LLwTpc5GkzbmVppuiK6SXmcz?=
 =?us-ascii?Q?AQwrpXIH9FTedLoNp6tc8UTzjVseMknWlWxxDw9/AlmxGPtWnRkUcr3589TB?=
 =?us-ascii?Q?CW6GM5BmaPwfvp5FPKXecvArbtmScPcEBPorIH9zBT8jBamOgFiiKvHwfIgm?=
 =?us-ascii?Q?eEdEUIBfNTLANs0//9acBnlUJQV6OFvGk0LIA9QN40f1IpzOkXG1sHXNVFUK?=
 =?us-ascii?Q?2eLlYeiPa++LGiyIeX2y3pIHDsln+kQDSCMAhthRZPnADCIMyBSeuWTgQ+H0?=
 =?us-ascii?Q?8msSQbN5OTLvReMqTsPmRlx2WBlJB5EUUa+WFCv6gdHB4NVMFlW20wl2mIb8?=
 =?us-ascii?Q?ZMKuVyZSeyZhGVDG7FT2bIKDDbx9NrSo2cbQS6uswWBu4WHOVgEdxROkmf1S?=
 =?us-ascii?Q?5gMNsjWxMUtQ8Cym0WCnKie8g8a2LORdMqk5YbaZjXmNJmkygLqmr/tHtySX?=
 =?us-ascii?Q?bKfZrsPU1G+ww4dcmHDGOteiLdrCs0wqMGAe+DNJbivN7DlSB4DUrF0XsP/i?=
 =?us-ascii?Q?kbJWMw0SrthTCiaC9eEpXStBH63gNHCK2UVKuvX49owvT6Q/M94rOAd+xUKl?=
 =?us-ascii?Q?fOTiQqdvUO708g20YKat6jd/6okZO6up6vL4WeNBkp6TfpzxsZBUJJaaaRgE?=
 =?us-ascii?Q?NsyQsEVuLkog92+qr6w3SA0w8ikgs+TVTzAybZ6k3kASxq1yptI9Ebuq/s6H?=
 =?us-ascii?Q?6VfLkoEmgVKmYy4V2M5lzeVTYmEq8pJbtzurcGPyMl9MLZTVnCpXvtMGZbPN?=
 =?us-ascii?Q?PE3RQmmMApVDDT4HL/Ak3+VPgA3KXdL40CKo177Vj0fyNoBMBAMQiPs7C7KQ?=
 =?us-ascii?Q?lJzBYdXokJEa5wa40Z/YD03pKUygoujuGAqGJuGpCz0gnPRUCSfbc5TrGwKg?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0edd7a76-301c-456a-3ad9-08dbbde21f35
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 16:11:49.0298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9xXb7I0iEDRgkhxXmtNPPRPIZBKabJjYdWF0vT+XRtaPPevyfpeDwh9IcbD2+X2iNOelvnOG7eHMCLQp9OAbrI2Kr2GbSsIhRDoltJ76R4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6537
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko wrote:
> On Mon, Sep 25, 2023 at 05:48:42PM +0300, Michal Wilczynski wrote:
> > Driver name is part of the ABI, so it should be hard-coded, as ABI
> > should be always kept backward compatible. Prevent ABI from changing
> > accidentally in case KBUILD_MODNAME change.
> 
> This is up to maintainers, probably we won't have any users outside of existing
> model (instantiating via ACPI ID). All the above is "strictly speaking"...

...right, more than 8 years for this "risk" to materialize indicates
it's a non-issue to me.
