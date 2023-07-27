Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5137B76436A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 03:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjG0BdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 21:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjG0Bc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 21:32:59 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74ADE1738
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 18:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690421578; x=1721957578;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=u7rvnskAyZQLr/jiUlhUpSV7nzdX/3cMR6rxrfLJ7fI=;
  b=IJzDZgYeFWAmRxtZujchap37z7D0xawjwX/ojow9HH3UfigqNURQSX94
   nxdQXXVCNQIBtIlxO/TXU7XwcMZhzMHGYhzClnG7rkswOO6ysvt7BMY/I
   GYQO6bXv/NgrWDs7zKDrtVHxmd9GpQViObo/vjTq4ULOBm1F3FI8HN8Bo
   jWPJInmjRyBszwH/4tIEbwRM7bKMia2ren9U7KzoEL1pegOUKn+JG7L7n
   LTOfi1tU5Jd0Vdd3xI2Q7rRNmT+aCaCm+SZRw/u30KtIKuCvRePzcoh1+
   HTp1yatGqyy10IrT4G3OOdZb6+KUUVWcZr3k0uCd9H6fjXVl6WFWTg5KR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="431974999"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="431974999"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 18:32:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="792115064"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="792115064"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jul 2023 18:32:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 18:32:56 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 18:32:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 18:32:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 18:32:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIyZxUfAQGR+R5UaDl9eLO2cwiT6pgXW3MRR5NbxbpmArPW8YB8m12o9Kej91APQ+WI60cNU7rStGxImCEA1RHMD0ogVCNzY/sWQBHitosuOlDUQkylG4rQx403jGZndW7167X7rsWR0yT3Cg7Gx9gX7YBLC1kxByh2FX+hDC0cOXZQzmbEenhTZKvD686Sabxoeniji4+nBj4uBR7tdO1G43sPtQ5OfmEvy3en36RiYsq5F0SiEWneihoz8KUjtv3D18Qw7XA47XGwVOsjR3rINhYXaeKkXk45fluvYfra5JAA6LrTxvyedFb3dXHhDSst9Grrg1PvbW5c1Gv5Txg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFNmCNkQiVqC0fURyah4Hnp9XbReilYzsCF7BVijNYE=;
 b=cCr2VCr0sTLfdZ6c1tFqJmyknJK7s+S6rUbGKVjTWa8l/RfipIpxZQh8oX7xpDDxjEgMYAKQfoKR6LbsKGtH5FEPB43O0wkJq88XiZgE981562WHBFAsiJ9dLywq1iAqMZDA2eaTiB2V5wA+3rCprH9qgzOQUiRgWDUICoG1eXj6ltm8rKfm8AlIqF7XVSXZNWwXRRKDYVvoLfFdKR4Aixglc53ZXcYOFnbdPLe/38cuvxYM3ANNeQKp8Z8VghlJLyNpkH7bNahBWk9fwxIkXqZYymi/q8JdU4gJgAE18SKHsy+JXCXVZLxhzXkBL14LNA9dz9qRAI+hTLsxgLsxww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by PH7PR11MB8570.namprd11.prod.outlook.com (2603:10b6:510:2ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 01:32:52 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::57e7:80ff:c440:c53a]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::57e7:80ff:c440:c53a%5]) with mapi id 15.20.6609.032; Thu, 27 Jul 2023
 01:32:52 +0000
Date:   Thu, 27 Jul 2023 09:24:59 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Paul E . McKenney" <paulmck@kernel.org>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <rui.zhang@intel.com>,
        <tim.c.chen@intel.com>
Subject: Re: [Patch v2 2/2] x86/tsc: use logical_packages as a better
 estimation of socket numbers
Message-ID: <ZMHHa0rkAQwm+Sw2@feng-clx>
References: <20230615092021.GE1683497@hirez.programming.kicks-ass.net>
 <ZIwMstkB7CG3pDYu@feng-clx>
 <87h6qz7et0.ffs@tglx>
 <87edm36qqb.ffs@tglx>
 <ZJW0gi5oQQbxf8Df@feng-clx>
 <ZJhUiO+bdBoLU5WF@feng-clx>
 <87r0px40o5.ffs@tglx>
 <ZJ2Grrn7sq9Jdxf6@feng-clx>
 <ZLVEVoZTbYi3LbjK@feng-clx>
 <87pm4esbv6.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87pm4esbv6.ffs@tglx>
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|PH7PR11MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c60e62b-f2ba-44a1-d9e0-08db8e416520
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OkMQ2KqHl4ZqyGWBPcVxHcMUfhThjEBDLXzPW9wyrzxJWFlsyFIpLqhckRv0pl7o1ljfgUaSZ65FyavSSlINmpLADH4jwulzIF0/JkbmrYRnUw9jpkV7mccuJ6BdEvLOJ9an22o0mQjcsxGLBoZEbTkoxOg1oCmTTs6jdhs2L8fatdOTI1zIP5C5VkVxe4nNOMs3wtQUuuDvYJdkTsy0LMceYp4aHuZH5dkBOGkZWXNJKaR+7z5CU73qzW16bI7ydcb6uqfb8GmPHrTkljcBKAx5n2tNRU6rhfgxyXfa+wufXIbixMB4qvZ30TLdwPpKH0RJ+ImEk6dajJ+PQvypEqmvAW57jKYFs9Va1YvmcxmbNSGrzLHv18LnbFsGR4CgK5QTACCvfKxn9oeygiZ5k9i0RJrxqgSqJLsdTB622L6UrlABFkQf/4OP2NSQAOGLkxw/sblL6yrkkCt7MvaLZcMBuNiXK4/mJed5SXb4ZQU8BQhN8pgwfrUE51xiju5H+62F1fnbSW2hTIvNs//0ZmYKWXIgnaabKUgVw41SqLqXh5l9M/k0zNvOY2ZFF/rBAwNWvb/CiwXWUKnJyY19zGbC83Wh9Byt3Zm0ahREe6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(82960400001)(6486002)(478600001)(6506007)(26005)(6512007)(9686003)(6916009)(4326008)(54906003)(66556008)(66476007)(66946007)(186003)(38100700002)(7416002)(44832011)(8676002)(8936002)(33716001)(5660300002)(2906002)(4744005)(316002)(41300700001)(86362001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6J1Ifq928+psZcijVL0Zdg50sJaCXoglZFTRKWkBK7L+U+TgaxlaKJx/ncRS?=
 =?us-ascii?Q?wlAjKdPqBQkitNT8sX0InXfZZxdsk9NRFnteYuY3r4KxAV6cR2DwtseYMU/E?=
 =?us-ascii?Q?6YkjI6qhv3hLfOgFut2lgLBPNk+nNKyPNClKaUJ5VbtiizM1DpntPlnSF2XL?=
 =?us-ascii?Q?j2OuIwLSft5WK+ISZY+iYsqNAL0Lc+SXtiTdyZqkYXINi3O0rrUNW86+xPfX?=
 =?us-ascii?Q?SfwOTJ8ShqA+6IjbUEHSdRTbl6vOL2NDXDLI+OZ98MsmB51GOVAhTPZeJa/p?=
 =?us-ascii?Q?jvORBRwfcT0+/zIFTtMGEiTGh1kZZudEYgtC2C/HhTSlSTUleqW3BCf3l2iS?=
 =?us-ascii?Q?IVc/1Ct2mUTqDjzDp3xhXbrXeuV+JTybi+SQWAWCJ+ZmdWLz0L0pznDJP5IK?=
 =?us-ascii?Q?ESvdhDksszMN16BkF8dT2tnBZQnFXEM4JBglonPWlch/KoBGgDdHjrJgsK5o?=
 =?us-ascii?Q?1KFRaUPkceQUe5F7s+TeGUNgS8dZkWsQ+CXDfG8rz50zWu5Oys/gqDVb9Vi6?=
 =?us-ascii?Q?FBPk83a2dcLOtfw1YpmCpNfy2wcuFHP7XBEwgK/BuT1NtBMCBYoY7uxuBOyl?=
 =?us-ascii?Q?SpEZNRqWSN/1Wjl3s3Z9dJw3++usUuHXk0G7/P3Jqp/JjP5ub9AMjx59geM8?=
 =?us-ascii?Q?/uMA8rJ/9fyrwVjWnWx2Xch74TTUS1gkGdfj945wCBV0/x1Sqj9T/Do1EaXe?=
 =?us-ascii?Q?vrGY+vw6CgYe8XDLENB4YZoqhFf+fGJqfqwS+zMubuEmYBWfhNxtHng/Nzrk?=
 =?us-ascii?Q?N/MqBgUoxx1nMv+suZVdi/+636tHKPpmQSs6YumVl6P7IymHP2e77dHCTqtb?=
 =?us-ascii?Q?+V0vIJwY/cLszZ1YG4psoeHBt3ZngxKZgRi0ezVjwmxwTu/sd9q5ICe6BXwo?=
 =?us-ascii?Q?kYsZQptUazwRZrqv699lXm4UaCA92rny6SI5kk5OftV1nrVFyFiwG8CXEHy2?=
 =?us-ascii?Q?xPgA8dxM46qHjMDDr3AANm3TvCONSVciMOVg19kkMNYCiXFPGVo+8fpgEASg?=
 =?us-ascii?Q?mvg/4DtXzstFfBibC1S73j+gmUdwSVIFt0X3SgRwT99+2MWSMevqIH1ZQIn+?=
 =?us-ascii?Q?dyLJ/J61RDXc6gCC5JE4yOkyQo1Ndhg+LBEJey2kKtOYPcPsbf5dJOHsVhnX?=
 =?us-ascii?Q?CXdkuv7823afooIusPcgHmDDtVIDMFJz/KDwbkrNNTg612xixLz5f9dQJKb+?=
 =?us-ascii?Q?iqtP9xeG+IBDOj4fOBsc1mYiOMTGc3Dik7fXkOuyi4YQH8PNZpIf2WZQqdWB?=
 =?us-ascii?Q?ymc3kEUJfxBmwTKJMLaI5I6t8YhLvds2AlqHBRECidyp6XwELpxKhgDmeKdl?=
 =?us-ascii?Q?V5oiv3xGgg3SkumtLV9uHZwAGNqAcr5qGd6oBVnyekznNYU0UlGuY/iDI/zF?=
 =?us-ascii?Q?98MmSe8RNZjR2CdYSy1XHQt2n784wmHZlFLbqkFKgJ59boQ8XK5vVV5lSIHE?=
 =?us-ascii?Q?YjcVJDYNn+pNENnW++xGux9p8gOLac+Rmd9qmNEf4O5w1xAI3Y7e+1ASXodB?=
 =?us-ascii?Q?D00geePQ3BYYaDhWb7unifj+tC/A04ppgQgheAS78Vbs51zX5aS1KDb4fsdW?=
 =?us-ascii?Q?8kZHSYp7uf8tJXaCNozcZG0TGZJ14ieQKgy+zi4B?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c60e62b-f2ba-44a1-d9e0-08db8e416520
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 01:32:52.5767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mb4XhlgolWwX7wrgYLAJBZaZkSF+guf42g5vOM9cxFCZ7nRqBeVbe1gPNGPxzMzga2ihPhMUYjQfyXaAXW3BsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8570
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 09:37:17PM +0200, Thomas Gleixner wrote:
> On Mon, Jul 17 2023 at 21:38, Feng Tang wrote:
> > On Thu, Jun 29, 2023 at 09:27:10PM +0800, Feng Tang wrote:
> >
> > I plan to put these together and resend. Can I use your Signed-off-by
> > for your code?  
> 
> No. I'm reworking the topology code at large scale and this temporary
> hack is just in the way. Give me a couple of days to polish it up for
> posting. That will just provide the correct information out of the box.
 
Glad to see this happening! and thanks for the heads up.

- Feng

> Thanks,
> 
>         tglx
