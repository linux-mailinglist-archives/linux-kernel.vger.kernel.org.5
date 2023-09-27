Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB0C7AF95D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 06:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjI0E3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 00:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjI0E2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 00:28:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17307AA8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 20:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695784656; x=1727320656;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=01M9VW3LwF13Ew6oqV0eSlSMbCh3iI9+cbdTviiZZn8=;
  b=NxxXle2HcWvE0xq64sioDOdTLGB1D710XiRpH7Dch3dYfy/qzzLO9Ut6
   MriCZwL6Yk7a3wEHzu81lz6zEMRxhVVUlixbs12a6RmJpAGFm5M8H/uLF
   Jh8L3KHBdv84d0pAnlIbMWxJU9S+gI0iX2GrYCIa3ZSAQZdbTi1himpnY
   JVzC56LoWICd7odWpy9/wcsy19hFNsZF19sxGU67SSTUyUkc5W0GHr3Ai
   K/YdTaqbFCDdqqaMoAJ8H1daL18oXloHxDhk24pDvcneRRWfb6BPOmJT6
   vt13z8avYWONyTMXONMJ+MpbCShz3N5i4Y1IZP41bDfvm+XgHtmp4osdd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="381617999"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="381617999"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 20:17:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="872717166"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="872717166"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 20:17:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 20:17:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 20:17:35 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 20:17:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9Zb7u1zYVRdQxd1YM8M2Umn0sSB/T6HkRGm8+/jzn0k6/FMxY2HTyBHQLEIwm51XCckKE24vQr4Hn0Uexbdp5k2nsxtKkROedr5612Ku0W5Ixtm6mT2e0ydKBfB03ZQlREWont98KdgBRqldBOkvh17EWbsW9Q1bMgcgZ7UQDYfLX+xqA9cD6yshSP7CA46eMoBDuSliqkVdEKRICd6Ai5Hg1XiMa8xDRT7PyP26IB+unPAAn9Zt0fAWy1T7Etv/0XT2feXZKaF7gG8V2e2eYVViaGal/vYrWfI6rwLiM/BLoIdM6yh/LGcwBV1iDAKd1Y0QB8+9SxDymuEVYpkPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kMwgXzsl9iQoWFyectxsisqEmoy1E0kG6XFGWQR4vo=;
 b=aAuAqQYBcUuSUf1OsSp/Z7fOEYSU/dwWRk8k/0JKEfcILRt2z/vwXbR5k9R9ZUvvKAemEsHg/kJ/mgy8/Eo3vHKrxN8c0GB5KC1fRDQZxQbPuFNMW3EuXPEpR/EiJGJUdnY2uZesTIIqPkeYvmVzpVF9zWZSnFyCKtK6T5WWU+EIoMwb2NLyGVUZnZkzSmJiG0T7XyCyFoeMo5ZbuISFb+CToAjgtMO9ng8EfEdobO1i2y40eDdoKnfcrUzfNll5zAUqbkiF3nOPIqNEtaTp30vjV8+NHRg+D4y1ICgDDQl7wuUiySTErQYOWU2oTmwssmAZD+8yVqXgbQrKf4w8og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6469.namprd11.prod.outlook.com (2603:10b6:8:c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 27 Sep
 2023 03:17:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6792.026; Wed, 27 Sep 2023
 03:17:33 +0000
Date:   Tue, 26 Sep 2023 20:17:29 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-coco@lists.linux.dev>
CC:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Gonda <pgonda@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4 2/6] configfs-tsm: Introduce a shared ABI for
 attestation reports
Message-ID: <65139ec9e25ef_91c1e294aa@dwillia2-xfh.jf.intel.com.notmuch>
References: <169570181657.596431.6178773442587231200.stgit@dwillia2-xfh.jf.intel.com>
 <169570182987.596431.14062417344858914481.stgit@dwillia2-xfh.jf.intel.com>
 <c3d347a7-58d6-4830-aad4-d354b83f0704@linux.intel.com>
 <651329fed4947_124e929464@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <668e7778-e1f6-48a8-9631-0643c1ce9e4f@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <668e7778-e1f6-48a8-9631-0643c1ce9e4f@linux.intel.com>
X-ClientProxiedBy: MW3PR06CA0012.namprd06.prod.outlook.com
 (2603:10b6:303:2a::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: 80181811-366c-4488-c06b-08dbbf084a31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5WrU/fSyHDHOzb0lmNb0/c7Gc2pg1mcCRnyKeSIlj1X12/LmIhigFJYp4ZPECUXuOgaKyseJby6XB+bWrjthvZ7flbu6MzpxRTKIxJMvZvXxaKRX5NUKpUjkcVcqHc4RFwe4HmHjuo7nJ5gxSNFoWYs3sFm6WDppz/xgRuIWcLjV7namPUgXA3MjDRNPqym1vEoOFm+gJVhbTZ7WIMVYBZEcmY17jtlde8+UXL49nTZMxTEMPvZWmqrx0mWI54OQJpl/o30qs52XVIb+/n0ZVAKpQszcW8WW6H1X0nRKyk7G+d7njvM64H6bevpVSyWsDY0RdR6R5SHYx5dXwmqsb6LJKC4A33Xz2w595vDsQZqOjAa8LZiVdjfElr5N2Y+EIeeQn+CgIH8ax7YgYprSKNh1jRYXPFoUGpDYmh6eznvFyj2qUQjYke2XvkUVJEQemKOFZGOxPVvHBH3U0AMtx0YqD5ItALTrs1eVFRZZ5JWOdrRhxjp3omYR77pnGu/mZQUgwqtXI4sx9NBr3Ft1LMteBq/gAw9ySYo8zJ2t9PQapZGLedkz+VM2ebh8HlFF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(136003)(366004)(376002)(230922051799003)(1800799009)(186009)(451199024)(6512007)(82960400001)(2906002)(26005)(38100700002)(478600001)(6506007)(86362001)(6486002)(9686003)(83380400001)(6666004)(316002)(4326008)(8936002)(8676002)(41300700001)(7416002)(5660300002)(66556008)(66476007)(66946007)(110136005)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JHt9ZOPlYjOoP8nK+tNuEi33TmuykqVVT/msjCeDe3Rscgp6aRxDLCaygldO?=
 =?us-ascii?Q?YA2VZDM0Dewc9bvUp5skqV3i6YQvokisSxIfrJpGE/kaWSS62JOa2c20iRy8?=
 =?us-ascii?Q?HDErMFCjD1BQfVGCrzU3pL2EKZLBItd0dygPiNOkEnHuTzXTF8rsQ4xyksly?=
 =?us-ascii?Q?SvFNR5ZbNKum1TyOngi8yIRxihq2mm1pE8oqd9T70CWbF69dsMCLfcl5LNd1?=
 =?us-ascii?Q?YRJkBubHRNmlhTM35IUsyDlJWFFu08QSLEQc6evkcgaQ1CFBscj5qjBZ2GAm?=
 =?us-ascii?Q?ZGe7rWszKX5rFa2arlVFmAcMZ5tCQUlm4ooCIYI4VjFMs+05GZGMD7ZgEuOT?=
 =?us-ascii?Q?ifBK6dR9XEWStGXhzcLN5Ai0FzITNm8TzrTHg8o6dcuVZr7XxEaci7j813hI?=
 =?us-ascii?Q?6u9N1b8rZduX7p/Q0nsPi3augGER1Ccrf6W3wdAgrWA23AwxvG65QuvPbp3U?=
 =?us-ascii?Q?bWOfW+gGa+/BiOidm8p8Z2VeKp35hOtASfI65Y1HZJkKt/iRgVJCrbGGQHNO?=
 =?us-ascii?Q?VHo8T7xWM6PRVt/CnBYsMu6O9m3HrAUC6rZxqxdD0N3xkxC/DcU2gme0Tu3r?=
 =?us-ascii?Q?p4vmc2RSmWvkUZIsdsSqxgxnLxO9X6CCGvRTVX0McewPX3wOVo9ATIcnN2tC?=
 =?us-ascii?Q?9LE6s94gpo2ua1YJTKu4+vVIkBgYFS0v5IFJyLd7mVsRhEOVsTRsIljzQEAr?=
 =?us-ascii?Q?Ndv72cU+cZdg3NzgXcLGAM0vuqCkXOum61EhqMkk2/c5mdP3mboBjA+sYyX1?=
 =?us-ascii?Q?bkmxHBUYHCv1OyoojlIhlqm+M9v4naEqH3B9dPpXugL0np/QDHL0rxcRTaON?=
 =?us-ascii?Q?8mnUMTU0M/+STUHaPjKcPXommEUl0TXMf7FXDNBza5f9OCaWy4N3ropKkfwL?=
 =?us-ascii?Q?0dlXu+KyPoZTKxvF+3fyaA68O56p0FDnvVDN0KF86sfbXwjpqzgtp3BA2lm4?=
 =?us-ascii?Q?bPQWTyMZd/UWHToII2UiDbEdDzBWs2uTR1bdSx1U66dLmF1OBHDAtg5938XA?=
 =?us-ascii?Q?4Y5KbxzomiR36B8IjBtFsLAzNJG80GP5+26IhCScqSRwONbalArmIcN2OfHN?=
 =?us-ascii?Q?8nQzFjEP89dJvNU2zK/3GNd3Xj3ycPRscMtUHWiHbTgeY9PWWMmFPCYPYOPP?=
 =?us-ascii?Q?3vAE91fHVbH1qXbxfU5MyE5bs70YNfnBUz6Dyf64u8AIf1lq/DcLw5mOj8qm?=
 =?us-ascii?Q?XiZkPkwo9bXSMnbLUv8DvaTz+Zs/Aj9JK7OxgNijLUeL9+SC1fRZZxI/Bi9H?=
 =?us-ascii?Q?7IZbHJV3qE5rqezhKVebEvFE8Wv+cdlPASF4FILhw8QvmbX0Isf7M0BjL9yu?=
 =?us-ascii?Q?bct0qBOMNyXclZPBp/3aW927FpfIwC+cVCcWRcBImR0JPFKTa7hQg8oVF7zF?=
 =?us-ascii?Q?t2VzNqlWrC3H8wkztYUOBvs6ZVpZfNv1MnbJIp67XVnYNPq7fK9yqW6H+10t?=
 =?us-ascii?Q?gXpjOM65H3Yuh3vWUr3AnBAnUQVV8+y8WPQMMIuuUJPd8FDgyZxXWcY3kEYE?=
 =?us-ascii?Q?6rpchoYE+5Aak30I3jfKtnycn+UuupN1aJm5cyggoZ/6q9PRisFIT7MRaDCV?=
 =?us-ascii?Q?Dsy5u7saFuHWfkU4wtE0TP1FLwiaogCqgHSnU9aPR0mzMtEoBB3XpNDqRYne?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80181811-366c-4488-c06b-08dbbf084a31
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 03:17:33.0230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CM+BqwD3tJ+UJJ6goFQVcnuSNWXXZGL511o9chYlBMR6udDSj7JGqfCETh90nGG8b+uDt6pYP7GNqViSRCqHplAMcaLIGisA5O2QGtR+WsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6469
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kuppuswamy Sathyanarayanan wrote:
[..]
> >>> +/**
> >>> + * struct tsm_desc - option descriptor for generating tsm report blobs
> >>> + * @privlevel: optional privilege level to associate with @outblob
> >>> + * @inblob_len: sizeof @inblob
> >>> + * @inblob: arbitrary input data
> >>> + */
> >>> +struct tsm_desc {
> >>> +	unsigned int privlevel;
> >>> +	size_t inblob_len;
> >>> +	u8 inblob[TSM_INBLOB_MAX];
> >>> +};
> >>> +
> >>> +/**
> >>> + * struct tsm_report - track state of report generation relative to options
> >>> + * @desc: report generation options / cached report state
> >>> + * @outblob: generated evidence to provider to the attestation agent
> >>> + * @outblob_len: sizeof(outblob)
> >>
> >> I think following is incorrect. You might want to add info about certs_len
> >> and certs.
> > 
> > Yeah, missed updating this with certs addition. The outblob_len
> > definition is correct, or do you mean the kdoc is out of order with
> > respect to the struct?
> 
> No, I am talking about the write_generation, read_generation and cfg options.
> They are part of struct tsm_report_state, so why document it here?

Ah yup, will fix.
