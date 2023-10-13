Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9367C8EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 23:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjJMVUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 17:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjJMVUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 17:20:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB47B7;
        Fri, 13 Oct 2023 14:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697232027; x=1728768027;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2sJzlbVWnWTTKUd+/fVLZjP+UjwSP/jGeyEpXHgKV7E=;
  b=IHo6nF+7w8Km1cAdBvPsnmHEd+bWFYEM8FgUriYaLCv44/31iPtuDQsH
   xxKorQLgRJjtktGwqXlJ5B0ibDoah55SyzkQAiQvz/S/SdZjLmfdB1Pwu
   XgCHq5cQN4byDvRckVkJMzT5ntIjmi2TgZY6Vzt3dFhtVjfwzhBAO9YYd
   bX7nLa3KM8Ij0W+HUTrJlmw4swPTG6jpO4R4YyujHSeu688o+tftE3L6M
   uKAKT2TFeIrTF1hfYXdc5KGcySKw3PKKc5QtmH77Pj9u6QXfTP2j9qL2j
   nZTslEGXtufw2uWt9VCZLHblXEwb+YBzkKPoL0d7NurQcyqbWDh3rbwpv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="449459074"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="449459074"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 14:20:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="898705085"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="898705085"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 14:18:34 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 14:20:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 14:20:24 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 14:20:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0GiTGESlM8q0NG/6dnf4AS3bS3TxRiOANc24n2ugMb+XPJUemifGaMrt6wDVFkk7TBrbJF3AXDbRxLQYw9PVufs49JQJR0b2Q56XkY00EibeXdDebxFaKQ6IEVOcV7JoLcwAX5lnGsRStNVoW1i/50j8pxaXRNNHW3VgHPyp1lA5uXcTpGEWsKsQxEVI5rph0y4nnaOqBY8YflgjGPoIRbQ9SgInPrsjto3xv/ZubEY8IXsN1eUt2Doa4Y325ZKz2LbPxpyTTFAlP+Tw/Qqb0706t2b2pV/tv7gkMO0OZcDNrXzjVTyEcTPLkAp5gIvHWlOwbgyDh3n1vzNehFkpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4cQTuXZMjx4m72lGSSKUfHm5EoEz/z8evwJZQ9VUtw=;
 b=RRZilSocgQcGSDkkw3puwJg+jru5xqKFBkXs2s6Pm2vOuzO2a/HlgzA1lNIiy8oOC99Yj2iZYJ0zZvJFHakyKJ7onCi0PBtoFH7mFqmhHylfdNvPNfYe8oF3ncSBa3clxNfkwEFnuimpcG9PRkWlmWTqVQrICLhtBsO8cb9NhbOKtNeZ3CyRmy0rTamIFZHRY+klyX+gM7is8UEr118nXMz7+ZHoD8AJuliajrpJn9vrV9imQ/KZDMySe1Vp2iyq7Lqhf/WjTXCgg1SlMrsMP9LaWnfNlxwVWvkin402XjcWMlFJXorH3o16ZaEr+XD6EK5XT/T4KOTGxAycC2Z/PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4900.namprd11.prod.outlook.com (2603:10b6:303:9e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 21:20:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ec95:c199:551f:2d11]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ec95:c199:551f:2d11%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 21:20:22 +0000
Date:   Fri, 13 Oct 2023 14:20:19 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-acpi@vger.kernel.org>
CC:     <rafael@kernel.org>, <vishal.l.verma@intel.com>, <lenb@kernel.org>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] ACPI: NFIT: Fix local use of devm_*()
Message-ID: <6529b493cc785_5c0d2947d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231013085722.3031537-1-michal.wilczynski@intel.com>
 <6529727e18964_f879294ea@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <f7441bb4-c2c9-4eee-9fed-ad8b28de4788@intel.com>
 <652978deafdf8_f8792944c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <1c2117f1-2d22-4d08-bd9f-8c821d4a1757@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1c2117f1-2d22-4d08-bd9f-8c821d4a1757@intel.com>
X-ClientProxiedBy: MW4PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:303:dc::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4900:EE_
X-MS-Office365-Filtering-Correlation-Id: 94a4656d-ff97-4dea-66a5-08dbcc323576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EwH9MLAIZqiw1k/t6jYOIY8kMW/5ra7UkIFZbB3ND+RsO+JmcmlP/sAeCzKx+gbYiWnvzu+cVTyeosKH/pTZKf9yYy9/wG3OJCmW6liSXnY40IZAd9GhKR+JvB+zwmHGm8ZJ9WXO52pcSaT2FKi7G06prb1dK60JnlL4z+3sP4vyVqQbg8QGl5b+uRBF8v2KPYeBVi/rj+9TEfBn69SxZmSY5wthCIgsJKo5E95pVUEi8bPpnJOH2VqCAtrN80IjISE/UIpy53BrBghvWbX/7WDJGqTrYDx2q66BaORul1+TFUPLVAg6vZ8l+Ii79oTmH651SgwVZ0JWbpfqQVNou8VTP78ht+hdxUxElbW3q8bNzxpU8M4UwuRWRBb3yb/yyIjf3wlTOgKMAQFabAneWaltYPG63CVqi2Er5lSmDK9IazagTBk4fjMkq76qhvtAyAzrk+YYHttXVkKMGy3+O/yl5NurqFrkS13PCMT3a8/r6fxFM1U6I8xOsoimXs3CmlOf0V4VVKp3qz8WasYe8IYStRPqrf9JqIKSARJDIKazryJqTEYbZMAJrAyx8/hS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(376002)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(53546011)(6506007)(6666004)(9686003)(6486002)(6512007)(478600001)(83380400001)(26005)(2906002)(110136005)(66476007)(41300700001)(4326008)(66946007)(5660300002)(8676002)(66556008)(8936002)(316002)(38100700002)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FzD+xBxn2FpPp5fcm3szeOm+XHvUTUxeT8OV/BUvKzwVhltatItKqlFccsaL?=
 =?us-ascii?Q?2Uk3b8nOVStBtkSdWSDwboElloIAbRFe7LOj23sS3vs1+hnbIuZREbueglcm?=
 =?us-ascii?Q?QJ1enyjY9KmNFWy2wHoaZxQk1+4HYONdMyyn+2z4BMNo6z14euhVVqi5Q0oU?=
 =?us-ascii?Q?6TVWCMptV886B9Gj+bSTxa1KiXBS54YzJ7A3c2jLdum3lycFZlKunI4YLZeM?=
 =?us-ascii?Q?3BafkuD20K4b8YTulT8DV5K+DrVl1goJOVsRPoAuhed5P7tbJk/VK04d8YxR?=
 =?us-ascii?Q?2Qfd6HXKmI7UwdMArEZRNfj/TvAI+IdjSKP3ohrjPsi7Igi0UlYHhkZNsJyq?=
 =?us-ascii?Q?Bbng21MDwaJfy9M89z2dqVVeks6HYIG/D6NDzXNALncDHDNPHfIiJVdpz/yw?=
 =?us-ascii?Q?6RN/bjTcPQuwsDYZnvkEo4WW5C/JPp22x1ZmH11nN5Iyz1Um8NLWbve+1MBW?=
 =?us-ascii?Q?PqcBLUYmpC0pXFTTJ3Z32LeNrc24j2lxOzOenL0sdu0QjCXdnYsN1/cXgT4n?=
 =?us-ascii?Q?Y+PiAMmp+NBOoi3x94Li5I38eKkOJDiOsEjQBLQ9xYZqKzz3eeDFsAmdaRRX?=
 =?us-ascii?Q?akbb3wuYxsi6RswpNXdIqdV1pkiGgzv6wren0f16juI8hZjfhw4zZC7+yGX9?=
 =?us-ascii?Q?zttjFVJl1rSbJdXqunR34gIVKGUXtSNaEoQOwofTmsNhzx6m3aH60JQ7shUg?=
 =?us-ascii?Q?66rcPeeW2wV5snuphTAgtxTUNxuslqK82l6ZW6Ny3ktpiidZHMlKXEaOHq7t?=
 =?us-ascii?Q?nQIxFGeuqoBpI2lQYjTOoNlZTLjj5T2rBAjbEBou6tYZVCmDyu517oWp5O+f?=
 =?us-ascii?Q?qUVLVCqGyQ/Q5bj5G33Jydzj857i1b5EzxMcKhXS2yt0HRsYATKLs6w1GE9J?=
 =?us-ascii?Q?GJIzGwrRx+DGcI6ZtEh1HFO9YkdRC4jl33nfKdckhUJA8tqiIWiSrgk7xpDZ?=
 =?us-ascii?Q?p8jH3OChSuVgsCiMkFynmo2qOe7dOtmVcfQsJZMwjYsDYM9fQCvGvkHSTozN?=
 =?us-ascii?Q?O7dUFWvZqNQQckRS4wosjitB7AOJ2iXfMXTPTmQBC/ZLVN3JHyiQmfr39dOU?=
 =?us-ascii?Q?fBFU8wSNla9UQGDQfwhfXMXMJJkzQgv/nrm1XQDyfHcOmoUUhXEkMlKlhxx1?=
 =?us-ascii?Q?pNGdQbXjMz5rwbdGX2j7tNSxiDwJv5FaLmy+TGR6IPYLYgGCw7lsPywszU1V?=
 =?us-ascii?Q?3Veuvganj0qBHOgVTyaPNk7QyRw9zVAgbFJD3EET0Yvy2xs346TeyFuWGAeG?=
 =?us-ascii?Q?yvfy+J+fX7UySriSLXfZssLWOe3dWVeTt2gfZn+AjJbJYxFeXQ3OTztQbXHd?=
 =?us-ascii?Q?EYRXQg9hqffurXXrXxh5jBYnIWbnTs1oSoYsZBcvwS9Q6awxyxV6bXgj90i+?=
 =?us-ascii?Q?oO/OpklDn/FpSUTtaoSKEzlymeLRu3u+T6XUb4AgLzX0hKyYIHXiBX8wT4Lb?=
 =?us-ascii?Q?qUy2Bq7xi4UXq2Xmr0+j1MU1QSiiHdFypIjnGMOCCrgh9Iur4owOE3Rqrf4U?=
 =?us-ascii?Q?d+XjDvL44/vZLzOoWYf5gNxC2GS/eq8wTMaNJ2JTutcTFOwFw6C5fm1fruDj?=
 =?us-ascii?Q?zlkLlGR7udiUiMwp/nUM7lH6O/ugL0Ny0zIc8Y/pAIMS0oiN95icuYCwTee9?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a4656d-ff97-4dea-66a5-08dbcc323576
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 21:20:22.1880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMnk6iwshG4cgS/iVeKllX7wUQzPIG5byGSfmHblSoFkF4BB3n6qIBws23YMfRh1UL+a++SJMLyDPZKartZJ/3hl9Stwo1gIYMOfr4SLWnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4900
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wilczynski, Michal wrote:
> 
> 
> On 10/13/2023 7:05 PM, Dan Williams wrote:
> > Wilczynski, Michal wrote:
> >> On 10/13/2023 6:38 PM, Dan Williams wrote:
> >>> Michal Wilczynski wrote:
> >>>> devm_*() family of functions purpose is managing memory attached to a
> >>>> device. So in general it should only be used for allocations that should
> >>>> last for the whole lifecycle of the device. 
> >>> No, this assertion is not accurate, if it were strictly true then
> >>> devm_kfree() should be deleted. This patch is only a cleanup to switch
> >>> the automatic cleanup pattern from devm to the new cleanup.h helpers.
> >> The memory in question is only used locally in a function, so there is no reason
> >> to use devm_*() family of functions. I think devm_kfree() is more for special
> >> cases where the memory is meant to be used for the whole lifecycle of device,
> >> but some special case occurs and it's not and it needs to be freed.
> >>
> >> This is an incorrect API usage. Would you propose to change all memory
> >> allocations currently being done to devm_*() family simply because devm_kfree()
> >> exists ?
> > Michal, please work with someone else to get these cleanups upstream, I
> > am done with this thread.
> 
> I'm really sorry if I offended you, I didn't mean to.

Hey, it happens.

I am not offended, just frustrated.

Going forward, my advice for anyone doing advocacy for a patch set is to
be clear about "what happens if upstream does not take this patch?".
When you view it from that angle the patch changelog that would have
received an immediate Reviewed-by with no additional comment from me is
something along the lines of:

"The new cleanup.h facilities that arrived in v6.5-rc1 can replace the
the usage of devm semantics in acpi_nfit_init_interleave_set(). That
routine appears to only be using devm to avoid goto statements. The new
__free() annotation at variable declaration time can achieve the same
effect more efficiently.

There is no end user visible side effects of this patch, I was motivated
to send this cleanup to practice using the new helpers."

As Linus mentions, subtlety is difficult to convey in mailing list
interactions, and you may not have picked up on it, but the frustration
for me began with the claim of a memory leak that turned out to be
false. That was the prompt to consider "what other claims should I be
careful about now that the fundamental justification for touching this
old code has gone away."

So if you want to try again with the justification of the patch limited
to a cleanup, we can move forward.
