Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73A37C6516
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347050AbjJLGFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbjJLGFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:05:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813D3BE;
        Wed, 11 Oct 2023 23:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697090736; x=1728626736;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VoDOon62gI4hOZbSKfv38Ulp5fjMaXpw1vIF+02CQ6k=;
  b=MZ2OiTgi7dcK8oQIdYrdr8T4XvYa08J8fZifAojtqpjMpUyDlLfgjKPH
   NiW9Z9h5JG1g28XxcajK4YJAMHRpwL4n8WrWvN/BKTvrNLdj12z4uiI1+
   NI463m3Ana3r0/PbVQXncnP+aDpdZC/4KJ6FhuCXLJ/RVHiulLfJ+uJJp
   NZ18wUvz6W2+6zJo6vFWR1tqqKib1mKAjIyp8WApjLIG2CbVLz5RC08R4
   N3O8FEA3pcyxfu0EKPNBgxk6Gt6d5zseNvIJo/+5QfR0c2iQXrn5AEPIY
   B1E9eR9G+n8cFQAgAsAGOiwMQUTVsTith9h/B8DsWf2tRomXfRXhIgDbT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="364208713"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="364208713"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 23:05:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="704032474"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="704032474"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 23:05:34 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 23:05:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 23:05:34 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 23:05:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hI6w8oPKhonnWP2TLsTGLt/jAOkxBgLS507/txxGnAENKdF4ynxFlNm9PAFHM3AWIpkf53nrBhgBZpC91PLoy/cqmgJxAXsFkXOX4Wvko+XxmB5IsgpjuXzoEDmDFTM+T/qc1kJb+n4q/svMvdiVte3Qy6TLS0/bA4meoK4sONQBt0Y27M5Ni7hOk+CSJC8AURbj/bQmpwaboSk434lWVDQtiToXnYx7e0Kqo7p4Ey3/qQWyfBKAeJ3sN2RbSHGWF1LLd+6ACClhA7ZdRsmIwDRMayihitqJ3bC8EpIVUmEu/A3hI58ybn4yial1hFGrvZhkvNaYa5HSSCh6GbVVJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRZA19wl6L+lz8EkG1F+PcveVqYo1KMr3Dg9vIiQA0k=;
 b=nBbCkETefjbk0+5oLcXGbs6mjBb96F8auX4fE709csaCTMkptiN8ArS6KcP3xO0hTglSppIAlDhoThnEw+aBLySTLYpogtyMDrDBt0rqKiZ1Gp/wpOajhVghMEEN4CfNj2bCnn28ORWIiOfkBs7n7HgHwFjB1eD79/ls6S7b2Z8dpjCdzpi4O+O7i7ZvovYDqYws+G5avAflAohXL7yBqoRNDGqXWqDAVc3CkTAyY9/1ABoDrJxbgA72Oe+TDtuyfV9GOqskpha9VBlxloRqVkI/OqjTibOSAemDcCV1r+MUnehpnT7Id+JoD8ep6o4afJ8ZaI37CsT30kjxAwaeWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CH0PR11MB5265.namprd11.prod.outlook.com (2603:10b6:610:e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 06:05:31 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7edc:de45:7f2d:9ade]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7edc:de45:7f2d:9ade%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 06:05:31 +0000
Date:   Thu, 12 Oct 2023 13:56:06 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     "Sang, Oliver" <oliver.sang@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>,
        "Smita.KoralahalliChannabasappa@amd.com" 
        <Smita.KoralahalliChannabasappa@amd.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v9 2/3] x86/mce: Add per-bank CMCI storm mitigation
Message-ID: <ZSeKduDig1Z7ZuGN@feng-clx>
References: <20231004183623.17067-3-tony.luck@intel.com>
 <202310111637.dee70328-oliver.sang@intel.com>
 <SJ1PR11MB6083D191286779302821A7EAFCCCA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZSbCYt35j20ezT98@feng-clx>
 <SJ1PR11MB6083154D148B42B8B7BC48D9FCCCA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZSeF6T0mkrH5pOgD@feng-clx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZSeF6T0mkrH5pOgD@feng-clx>
X-ClientProxiedBy: SG2PR04CA0154.apcprd04.prod.outlook.com (2603:1096:4::16)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CH0PR11MB5265:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f69ee32-2fb6-4b58-a7f8-08dbcae93cf7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iYTB3W9+WZF8e7zXAry6QrOTqXNp3LoK9Ikaxz5zpKaV2Ey5T1/aNpuZY0RwJHSu6bJXlY1nzO4qEJRGhHr1Rer/YILJHtm7HRXkXrHVsxgSly+uKb+QqR7zcMS/Joun+WXPRD3vlvFkqxN6dpqs+q6UHqC9/dA29CQFA+u9mhK4EZw8PlQnBnr27BQHddfpjLZTHDA5jLe75O+evJBIwWp3/bSAXwjJsE9A5nnsW1yvwrSk0dBbK4GdWuUhs6vswnmU26ZKlSc+sqmsPq5JbUCmAUeCrEhjmSxQDK+1NX/HaLl+I/Oe3jiK4N9ROyvCPIVN2Ul5MJePTw+8BV4+Or5Ae5zLrNpgnpxEJ7UHLm8ptNXuMraZdB2CSjIiyzz0jMnPuq4bRx+9FlkVRab8f+rpNy/1KQX9tun60TF6WHdkcDQN3VyZA1CVNXZ6rho92hF8qhp1iG5zYMTjU7MefEzh4Q5Y4nkZJ2s/x6eFrsj5pjEkMr2WPOCNO9sRR+Z9DNvg/AcokDZBodHqUlgkJzcWHs34mwQkI62K5mkqhrI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(396003)(366004)(136003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38100700002)(9686003)(6512007)(26005)(82960400001)(478600001)(966005)(6486002)(44832011)(5660300002)(8936002)(8676002)(4326008)(6862004)(86362001)(15650500001)(7416002)(2906002)(33716001)(316002)(54906003)(6636002)(41300700001)(66476007)(66556008)(66946007)(6666004)(6506007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K5nQ3Rj/Hgin1/p+Kg5COZoivLC9ANyyeJggcic4FJgm+EYNDaoDBqE7lPhK?=
 =?us-ascii?Q?LsEtVv96f2l4NUHlqWVm0IRhkn+IBBRpzB4p7kTDnXubl9gtzwQ/dIfJqiLE?=
 =?us-ascii?Q?cbhyVTqx9Gvtzv4TdFvz4ZzRTB537gxZUpsm6Aw8UClJBM0jFcfmc6uW/liN?=
 =?us-ascii?Q?G6N1Yh7/3w9O7Xy4wJpV5ObXRpIQjYIcvKt7b8SwfKLqmqxcFl1XjMyQrOIM?=
 =?us-ascii?Q?nbLPJN93S8Cr2AXuLUNluBrXAJbngMs/uZvNq+NJcowqoCAHhl5RIFhgKJXG?=
 =?us-ascii?Q?iASj/D4Fsha6pjYWaAosAD5kPLW9fDG3yABdpLT0najyOOD8bWGT7RrcTA1Z?=
 =?us-ascii?Q?J7H5AwVDzdYdRKmE+0TvDmCuo9Xu6XQKoA6Ta2sF3d6SPoWD50KrgXkjM/9H?=
 =?us-ascii?Q?8Vz801FnTCLLuD36XK0A7emyXt0kHhxsk/eNnyorZJ6mQYv5D0qPJ7WUfZBL?=
 =?us-ascii?Q?E3Fg9Bo89SG4vxWA+7C0HUIGrdYL/g6E8OGq4uu/vQdF8Hpf/ImcSAAS4q2s?=
 =?us-ascii?Q?+bgcekqkag1a9eJuDeSpAFGNZ/4nbGFfODHY7FAb0OOWgvV94AgzPrudaX+V?=
 =?us-ascii?Q?i1cbPJc2s9sovfmLwykM01IzyxsSzUW88lEjimpCFdYHl19R9yLzba7/KYZW?=
 =?us-ascii?Q?QqFqD6/WBfbVfQI7PsT6rJ7NE7ouT8abwA8xcY2vT4/pc/ilwGhwUosbQsX4?=
 =?us-ascii?Q?FgsOUTxpv8PAR8PnN6ug+EGkpPL2CimlsfWt6zgGA2feFPSHr4tNTEgJwL+N?=
 =?us-ascii?Q?9dNCOb0UqYwGpQz5xilhwJBhJ7EKfJmlGboEh9EW/4Oqw6UNyAr7Bl4i+Ntv?=
 =?us-ascii?Q?jmGSyTyyr1VVwdlaI5U3TF5wYLdj8ALQ5V5yh+URhfAKWQORIVgcSSRf0Ane?=
 =?us-ascii?Q?cuBbCkaFKS04eNUBHrvmvptQfWKazAfiVUT/Vett3/cI7nFfozynaIfWxJx0?=
 =?us-ascii?Q?4Ou+heKSZJuqlGBUdYCcWnDJ9pHLkOJjRUW5jfhkvSeZ/rE/HmKHKSXAYud9?=
 =?us-ascii?Q?1AB1cU3R4vu6tLd4o8/p6CZniZhsQnW3Fsss8NJkQJF4WGVjTsA2IyNXVETs?=
 =?us-ascii?Q?AAK15DTJ4s0d2HNdh7g000XsRd9jwRVRtymdDAEpfXBTYBORsX9volV6PXQu?=
 =?us-ascii?Q?6vSUIIAwpSiJj6toJ4AiwFTnWgGrl2okPlcgwvm2h6EaWIHEkTM6ZrjpN8fv?=
 =?us-ascii?Q?GHUzy8XZ9u/QYws1v9e2KM5Le4G5VJQFeAmcaGXb8ZTElj/vS62+LAQGG+ju?=
 =?us-ascii?Q?lhJLwetNEbmTy9I9RAFCqEdidhf7SzgZT7gf+hcuwa4oTjOJXNMRTojaJ7Ju?=
 =?us-ascii?Q?CplrnW9sqzIgjlaVi4aEUifgtRAb3Da0K/oI9NZMKg1fNH5yHiQtmCJ3xVlB?=
 =?us-ascii?Q?QNPmKcqwt0ga3npYb4VOG1AcZSYs1l38/eKBviiLBgwZc/dF9UcuKIfBbWDI?=
 =?us-ascii?Q?ZrWxJYAJMcqfP4asPBxdiMzHxZSzu2CDSRNVRjgWuZoQps7+LCbAOufPF+wE?=
 =?us-ascii?Q?H+qIxey6BcuxCbuKXGdJNGNQTLejfBuIDhuHjbrJ8msCX2/SWyJiwhGamVrd?=
 =?us-ascii?Q?spEFmvRhfCgPKY/Xvi/uH6Av6t9mTAJjcvMZRzE4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f69ee32-2fb6-4b58-a7f8-08dbcae93cf7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 06:05:30.3603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4G+yxsVJ1tuVqUwSu3o61X34lLVFK3SFNnI0wT8aI884IRKCGcA1eotpHibLDI6pXHHT9ydgk2LjT49wV3i5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5265
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 01:36:41PM +0800, Feng Tang wrote:
> On Thu, Oct 12, 2023 at 01:23:54AM +0800, Luck, Tony wrote:
> > > IIRC, CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B was enabled in 0Day's
> > > kernel config for quite a while, to force each funtion's start
> > > address aligned on 64 bytes. Don't know if this has been changed
> > > recently.
> > >
> > > Also I noticed the patch introduce a new per-cpu variable 'storm_desc",
> > > if the function address is 64B aligned, then per-cpu data alignment
> > > may be related.
> > 
> > If adding (removing, changing) per-cpu variables can cause 8% performance
> > changes, then maybe there needs to be some way to insulate the builds
> > from these side effects (as was done with the 64-byte function alignment).
> > I've no ideas on how to achieve that :-(

As for mitigation (how to reduce these kind of strange performance
changes), I have proposed a "selective isolation" in LPC 2021, in
page 15 of https://lpc.events/event/11/contributions/895/attachments/770/1603/Strange_kernel_performance_changes_lpc_2021.pdf

As kernel binary is compactly linked together, the alignment change
of text/data in earlier modules could affect other modules after them.
MCE module is much easier to hit these strange performance changes,
just because it sit in arch/ folder and get linked early in kernel
binary.

The idea of "selective isolation" is simple, by picking some modules
sparsely and enforce some alignment to function/data/per-cpu data,
so that they can act as fences/borders, separate kernel into multiple
capsules, and make the alignment changes only take effect inside
that specific capsule.

Any thoughts? thanks!

- Feng
 
> Philip helped to clarify that 0Day kernel build does enable the 64 bytes
> function address alignment.

[...]
